require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

const {
  TESTNET_API_URL,
  TESTNET_GAS,
  TESTNET_GAS_PRICE,
  MAINNET_API_URL,
  PRIVATE_KEY,
  MAINNET_GAS,
  MAINNET_GAS_PRICE,
} = process.env;

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    testnet: {
      url: TESTNET_API_URL,
      accounts: [`0x${PRIVATE_KEY}`],
      gas: TESTNET_GAS,
      gasPrice: TESTNET_GAS_PRICE,
    },
    mainnet: {
      url: MAINNET_API_URL,
      accounts: [`0x${PRIVATE_KEY}`],
      gas: MAINNET_GAS,
      gasPrice: MAINNET_GAS_PRICE,
    },
  },
};
