const { ethers } = require("hardhat");

async function main() {
  // Deploying the DriverCompliance contract
  const DriverCompliance = await ethers.getContractFactory("DriverCompliance");
  const driverCompliance = await DriverCompliance.deploy(
    /* Pass the addresses of rewardsToken and employer here */
    "<rewardsTokenAddress>",
    "<employerAddress>"
  );
  await driverCompliance.deployed();
  console.log("DriverCompliance contract deployed to:", driverCompliance.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });