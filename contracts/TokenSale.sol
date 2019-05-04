pragma solidity >=0.4.21 <0.6.0;
import "./MyToken.sol";

contract TokenSale {

  address admin;
  MyToken public tokenContract;
  uint256 public tokenPrice;
  uint256 public tokensSold;

  event Sell (address _buyer, uint256 _value);

  constructor(MyToken _tokenContract, uint256 _tokenPrice) public {
    admin = msg.sender;
    tokenContract = _tokenContract;
    tokenPrice = _tokenPrice;
    //Assign an admin
    //Token contract
    //Token admin
  } 

  //_numberOfTokens * tokenPriceでは安全ではないのでDS Mathを使う
  function multiply (uint x, uint y) internal pure returns (uint z) {
    require(y == 0 || (z = x * y) / y == x);
  }

  function buyTokens(uint256 _numberOfTokens) public payable {
    //Require thet tokens is equal to tokens
    //Require that contract has enough token
    //Require that a transfer is successful
    //Keep track of TokenSold
    //Sell Event
    require(msg.value == multiply(_numberOfTokens, tokenPrice));
    //Contractのバランスはthisで表せる
    require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
    require(tokenContract.transfer(msg.sender, _numberOfTokens));
    tokensSold += _numberOfTokens;
    emit Sell(msg.sender, _numberOfTokens);
  }

  function endSale() public {
    //Require admin
    //Transfer remaining tokens to admin
    //Destroy contract
    require(msg.sender == admin);
    require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
    selfdestruct(msg.sender);  
  }
}