const Milkchain = artifacts.require("Milkchain");

module.exports = function(deployer) {
  deployer.deploy(Milkchain);
};
