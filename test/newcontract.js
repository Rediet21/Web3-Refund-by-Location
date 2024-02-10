const { ethers } = require("hardhat");

async function main() {
  // Deploying the DriverCompliance contract
  const DriverCompliance = await ethers.getContractFactory("DriverCompliance");
  const driverCompliance = await DriverCompliance.deploy(
    /* Pass the addresses of rewardsToken and employer here */
    rewardsTokenAddress,
    //employer adress as registered in ethereum
    employerAddress
  );
  await driverCompliance.deployed();
  console.log("DriverCompliance contract deployed to:", driverCompliance.address);

  // Testing the contract functionality
  const [deployer, driver] = await ethers.getSigners();

  // Start work by the employer
  const lockAmount = ethers.utils.parseEther("5");
  await driverCompliance.connect(deployer).startWork("longitude", "latitude", Math.floor(Date.now() / 1000), { value: lockAmount });

  // Set driver's location
  await driverCompliance.connect(driver).GetLocation("latitude", "longitude", Math.floor(Date.now() / 1000));

  // Pay salary
  await driverCompliance.connect(driver).paySalary();

  console.log("Test script executed successfully.");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });