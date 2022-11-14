// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

library SharedStructs {
    struct BloodType {
        string bloodType;
        uint256 factore;
    }

    struct Allergies {
        string allergyType;
        string name;
        uint256 severity;
    }

    struct ApointmentHistory {
        string doctorId;
        string notes;
    }
}
