require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
defaultNetwork: "hardhat",
networks: {
  hardhat: {
    chainId: 1337
  },
  sepolia: {
    url: "https://eth-sepolia.g.alchemy.com/v2/WPft7dHoQeX-Lrj26L5m3lu-5c4I8-GO",
    accounts: [process.env.PRIVATE_KEY],
  }
},

  solidity: "0.8.19",
};
