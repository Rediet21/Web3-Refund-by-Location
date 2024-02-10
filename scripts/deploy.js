const { ethers } = require("hardhat");

const rewardsTokenAddress = "0x6db049243Cd27d3b46b76adB38eD42c3b84CB83e"; // Replace with the ERC20 token contract address
const employerAddress = "0xBD6d01fa990348Fd962870fbf7DeD4C0725f85D7"; // Replace with the employer's address


async function main() {
  // Deploying the DriverCompliance contract
  const DriverCompliance = await ethers.getContractFactory("DriverCompliance");
  const driverCompliance = await DriverCompliance.deploy(
    /* Pass the addresses of rewardsToken and employer here */
    rewardsTokenAddress,
    employerAddress
  );
  //await driverCompliance.deployed();
  console.log("DriverCompliance contract deployed to:", driverCompliance.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });