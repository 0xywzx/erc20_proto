var MyToken = artifacts.require("./MyToken.sol");
var TokenSale = artifacts.require("./TokenSale.sol");

module.exports = function(deployer) {
  deployer.deploy(MyToken, 1000000).then(instance => {
    console.log('ABI:',JSON.stringify(instance.abi))
  }).then(function() {
    var tokenPrice = 1000000000000000; // Token price is 0.001ETH
    return deployer.deploy(TokenSale, MyToken.address, tokenPrice);
  })  
};