const HDWalletProvider = require('truffle-hdwallet-provider')
const infuraKey = "your infura key"
const mnemonic = 'your menemonic'

//for secure deployment**** : 

//fs.readFile(".secret").toString().trim()

//or 

//use .dotenv package

//to read process.env.INFURA_API_KEY and process.env.MNEMONIC

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    kovan: {
      provider: () => new HDWalletProvider(process.env.MNEMONIC, `https://kovan.infura.io/v3/${process.env.INFURA_API_KEY}`),
      network_id: "*"
    },
    compilers: {
      solc: {
        version: "^0.8",
        //this optimizer config for reduce gas fee
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
