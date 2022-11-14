// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./EProntuTypes.sol";

contract EProntuPatient {
    address private _owner;

    mapping(address => bool) public _isAuthorized;

    string private _id;
    string private _name;
    string private _bdate;
    SharedStructs.BloodType private _bloodType;
    SharedStructs.ApointmentHistory[] private _apointmentHistory;
    SharedStructs.Allergies[] private _allergies;

    struct UserData {
        string id;
        string name;
        string bdate;
        string bloodType;
    }

    modifier onlyAuthorized() {
        require(_isAuthorized[msg.sender], "Unauthorized");
        _;
    }

    constructor(
        string memory id,
        string memory name,
        string memory bdate,
        SharedStructs.BloodType memory bloodType,
        address owner
    ) {
        _id = id;
        _name = name;
        _bdate = bdate;
        _bloodType = bloodType;
        _owner = owner;

        _isAuthorized[_owner] = true;
    }

    function authorizeAccess(address toBeAuthorized) public {
        require(
            _isAuthorized[toBeAuthorized] == false,
            "Address already authorized"
        );
        _isAuthorized[toBeAuthorized] = true;
    }

    function unauthorizeAccess(address toBeUnauthorized) public {
        require(
            _isAuthorized[toBeUnauthorized] == true,
            "Address already unauthorized"
        );
        _isAuthorized[toBeUnauthorized] = false;
    }

    function isAuthorized() public view returns (bool) {
        return _isAuthorized[msg.sender];
    }

    function addApointment(SharedStructs.ApointmentHistory memory apointment)
        public
    {
        _apointmentHistory.push(apointment);
    }

    function getApointments()
        public
        view
        onlyAuthorized
        returns (SharedStructs.ApointmentHistory[] memory)
    {
        return _apointmentHistory;
    }

    function getSensitiveData()
        public
        view
        onlyAuthorized
        returns (
            string memory,
            string memory,
            string memory,
            SharedStructs.BloodType memory
        )
    {
        return (_id, _name, _bdate, _bloodType);
    }
}
