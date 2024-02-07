// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "./IERC721.sol";

contract GeologixContract {
    //structure for saving the drivers information
    struct Driver {
        uint256 complianceRating;
        uint256 tokenBalance;
        bool isRegistered;
    }

    // Mapping to store driver information using their ethereum adresses
    //mapping(uint256 => ListedToken) private idToListedToken;
    mapping(address => Driver) private drivers;

    //ERC721 token contract adress
    address public tokenAddress;

    //Event Triggered when a driver registers
    event DriverRegistered(address indexed driverAddress);

    //Event trigered when a driver's compliance rating is uodated
    event complianceRatingUpdated(address indexed driverAddress, unit256 newRating);

    //Event triggered when a driver recives tokens as a reward
    event TokensRewarded(address indexed driverAddress, unit256 amount);

    //constrctor to set the ERC721 token contract adress
    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }
    //function to be executed for the events
    //msg.sender contains the ethereum adress of the sender
    //the adress is sent for the listener
    function registerDriver() external {
        require(!drivers[msg.sender].isRegistered, "Driver already registered");

        drivers[msg.sender].isRegistered = true;
        drivers[msg.sender].complianceRating = 100;

        emit DriverRegisteres(msg.sender);
    }

    // Function to update a driver's compliance rating
    function updateComplianceRating(address driverAddress, uint256 newRating) external {
        require(drivers[driverAddress].isRegistered, "Driver not registered.");
        
        drivers[driverAddress].complianceRating = newRating;
        
        emit ComplianceRatingUpdated(driverAddress, newRating);
    }
    
    // Function to reward drivers with tokens based on compliance rating
    function rewardTokens(address driverAddress, uint256 amount) external {
        require(drivers[driverAddress].isRegistered, "Driver not registered.");
        
        // Transfer tokens from the smart contract to the driver
        IERC20 token = IERC20(tokenAddress);
        token.transfer(driverAddress, amount);
        
        // Update the driver's token balance
        drivers[driverAddress].tokenBalance += amount;
        
        emit TokensRewarded(driverAddress, amount);
    }

   
    

}
