// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "./EProntuTypes.sol";
import "./EProntuPatient.sol";

contract EProntu {
    mapping(string => EProntuPatient) private _patients;
    address[] private authorizedAddresses;

    constructor() {}

    function getAuthorizedAddresses() public view returns (address[] memory) {
        return authorizedAddresses;
    }

    function getPatient(string memory id) public view returns (EProntuPatient) {
        return _patients[id];
    }

    function addPatient(
        string memory id,
        string memory name,
        string memory bdate,
        SharedStructs.BloodType memory bloodType,
        address ownerAddress
    ) public {
        EProntuPatient patient = new EProntuPatient(
            id,
            name,
            bdate,
            bloodType,
            ownerAddress
        );
        _patients[id] = patient;
    }
}
