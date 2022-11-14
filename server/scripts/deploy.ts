import { ethers } from "hardhat";

async function main() {
  const EProntu = await ethers.getContractFactory("EProntu");
  const eProntu = await EProntu.deploy();

  await eProntu.deployed();

  console.log(`Contract deployed to: ${eProntu.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
