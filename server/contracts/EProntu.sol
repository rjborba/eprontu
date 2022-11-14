// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract EProntu {
    struct BloodType {
        string bloodType;
        uint256 factore;
        uint256 authLevel;
    }

    struct Allergies {
        string allergyType;
        string name;
        uint256 severity;
        uint256 authLevel;
    }

    struct Patient {
        string id;
        string name;
        string bdate;
        BloodType bloodType;
        Allergies allergies;
    }

    mapping(string => Patient) private _patients;
    address[] private authorizedAddresses;

    constructor() {}

    function getAuthorizedAddresses() public view returns (address[] memory) {
        return authorizedAddresses;
    }

    function getPatient(string memory id) public view returns (Patient memory) {
        bool authorized = false;
        for (uint i; i < authorizedAddresses.length; i++) {
            address _authorizedAddress = authorizedAddresses[i];

            if (_authorizedAddress == msg.sender) {
                authorized = true;
                break;
            }
        }

        require(
            authorized,
            "Sender does not have permission to accesss patient data"
        );

        // require(_patients[id], "Patient not found");

        return _patients[id];
    }

    // uint public unlockTime;
    // address payable public owner;

    // event Withdrawal(uint amount, uint when);

    // constructor(uint _unlockTime) payable {
    //     require(
    //         block.timestamp < _unlockTime,
    //         "Unlock time should be in the future"
    //     );

    //     unlockTime = _unlockTime;
    //     owner = payable(msg.sender);
    // }

    // function withdraw() public {
    //     require(block.timestamp >= unlockTime, "You can't withdraw yet");
    //     require(msg.sender == owner, "You aren't the owner");

    //     emit Withdrawal(address(this).balance, block.timestamp);

    //     owner.transfer(address(this).balance);
    // }
}
