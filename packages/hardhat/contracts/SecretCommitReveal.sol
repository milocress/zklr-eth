pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract SecretCommitReveal {

  address payable public bountyIssuer;

  mapping (address=>uint256) public accuracies;
  address payable public bestModelAddress;
  string public trainingDataUri;
  string public metaParams;
  string public publicKey;
  bool public canClaim = false;

  mapping (address=>uint256) public hashes;

  function initialize(string memory _metaParams, string memory _trainingDataUri, string memory _publicKey) public payable {
    bountyIssuer = payable(msg.sender);

    metaParams = _metaParams;
    trainingDataUri = _trainingDataUri;
    publicKey = _publicKey;
  }

  function submitModel(uint256 accuracy, uint256 _hash, string memory proof) public {
    // TODO: verify proof

    accuracies[msg.sender] = accuracy;
    uint256 bestAccuracy = accuracies[bestModelAddress];
    if (accuracy > bestAccuracy) {
      bestModelAddress = payable(msg.sender);
    }

    hashes[msg.sender] = _hash;
  }

  function endCompetition() public {
    require(msg.sender == bountyIssuer);

    canClaim = true;
  }

  function claim(string memory encryptedParams) public {
    // TODO: check params against hash

    payable(msg.sender).transfer(address(this).balance);
  }

}