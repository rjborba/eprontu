import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  defaultNetwork: "eprontu",
  networks: {
    eprontu: {
      url: `http://100.64.0.113:8545/`,
      accounts: [
        "0decfa4f9642de0fe676d9f36e9ccc13399074357270294be8a818eee5c84b95",
        "0b238ada60ed23bcc8feacaba091a802baddbe2d8419aeae914255df069b92ae",
      ],
    },
  },
};

export default config;
