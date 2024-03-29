// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//importing ERC20.sol file from the openZeppelin library
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 

contract DriverCompliance {
    struct Location {
        string latitude;
        string longitude;
        uint256 timestamp;
        //uint256 tokenBalance;
        //bool isRegistered;
    }
    //enum is user-defined data & representing diffrent level of compliance here
    enum ComplianceLevel {Bad, Good, Excellent}
    
    //creating state variables t
    ERC20 public rewardsToken;
    address public employer;
    uint256 public lock_amount = 5 ether;
    uint256 public salary = 3 ether;
    uint256 public bonus = 2 ether;
    uint256 public rewardPer_Compliance = 1 ether;
    uint256 public Location_stated;

    //mapping the drivers address to location and complianceLevel 
    mapping(address => Location) public driverLocations;
    mapping(address => ComplianceLevel) public driverCompliance;

    
    //events are a way to emit and log information about specific occurrences or 
    //actions within a contract. They are useful for notifying external systems or 
    //front-end applications about important events that occurred during contract execution.

    event StartWorking (address indexed driver);
    event ComplianceChecked(address indexed driver, ComplianceLevel level);
    event SalaryPaid(address indexed driver, uint256 amount);
    event RewardPaid(address indexed driver, uint256 amount);
    
    // take adress of the initator and the ERC20 token
    constructor(address _rewardsToken, address _employer) {
        rewardsToken = ERC20(_rewardsToken);
        employer = _employer;
    }
    // This function is used by the employer to intiate the work by setting longtude, lattitude and the time stamp
    function startWork(string memory longitude_set, string memory latitude_set, uint256 timestamp_set) external payable {
        require(msg.sender == employer, "only the employer can initiate the process");
        require(msg.value == lock_amount, "Please lock the specified amount of ETH.");
        driverLocations[msg.sender] = Location(longitude_set, latitude_set, timestamp_set);

        driverCompliance[msg.sender] = ComplianceLevel.Bad;
        //put the location and time stamp in to variable inorder to compare them with the one sent from the driver & he should set the time stamp to zero
        emit StartWorking(msg.sender);
        }
    //this function depends on function below
    function GetLocation(string memory latitude, string memory longitude, uint256 timestamp) external {
        require(driverLocations[msg.sender].timestamp == 0, "Driver already completed work");
        driverLocations[msg.sender] = Location(latitude, longitude, timestamp);
        ComplianceLevel compliance = checkCompliance(msg.sender);
        driverCompliance[msg.sender] = compliance;
        emit ComplianceChecked(msg.sender, compliance);

    }
    // what does the variable driver stands for
    function checkCompliance(address driver) internal view returns (ComplianceLevel) {
         Location memory employerLocation = driverLocations[employer];
         Location memory driverLocation = driverLocations[driver];

        if (compareStrings(employerLocation.latitude, driverLocation.latitude) &&
        compareStrings(employerLocation.longitude, driverLocation.longitude)) {
            if (employerLocation.timestamp == driverLocation.timestamp ) {
                return ComplianceLevel.Excellent;
            } else {
                return ComplianceLevel.Good;
            }
        }
        else {
            return ComplianceLevel.Bad;
            }
    }
    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
    // function that should be cinnected with the ehtereum payment fot the transaction
    function paySalary() external {
        ComplianceLevel compliance = driverCompliance[msg.sender];
        require(compliance != ComplianceLevel.Bad, "Driver has not fulfilled any compliance criteria.");

        if (compliance == ComplianceLevel.Excellent) {
            rewardsToken.transferFrom(employer, msg.sender, rewardPer_Compliance * 5);
        } else if (compliance == ComplianceLevel.Good) {
            rewardsToken.transferFrom(employer, msg.sender, rewardPer_Compliance * 3);
        } 

        payable(msg.sender).transfer(salary);
        emit RewardPaid(msg.sender, rewardPer_Compliance * uint256(compliance));
        emit SalaryPaid(msg.sender, salary);
}

}
