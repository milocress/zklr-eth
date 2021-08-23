pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract SingleEntryComp {

  address payable public bountyIssuer;

  string public trainingDataUri;
  string public metaParams;
  uint256 public accuracyTarget;
  string public publicKey;


  function initialize(string memory _metaParams, string memory _trainingDataUri, uint256 _accuracyTarget, string memory _publicKey) public payable {
    bountyIssuer = payable(msg.sender);

    metaParams = _metaParams;
    trainingDataUri = _trainingDataUri;
    accuracyTarget = _accuracyTarget;
    publicKey = _publicKey;
  }

  function submitModel(uint256 accuracy, string memory modelParamsEncrypted, string memory proof) public {
    // TODO: verify proof
    require (accuracy >= accuracyTarget);

    payable(msg.sender).transfer(address(this).balance);
  }

}