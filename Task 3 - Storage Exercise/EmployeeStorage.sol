// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeStorage {
    uint16 private shares;
    uint32 private salary;
    uint8 private paddingForFutureUse;

    string public name;
    uint256 public idNumber;

    error TooManyShares(uint256 totalShares);

    constructor(
        uint16 _shares,
        string memory _name,
        uint32 _salary,
        uint256 _idNumber
    ) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }

    function viewSalary() public view returns (uint32) {
        return salary;
    }

    function viewShares() public view returns (uint16) {
        return shares;
    }

    function grantShares(uint16 _newShares) public {
        if (_newShares > 5000) {
            revert("Too many shares");
        }

        uint16 totalShares = shares + _newShares;
        if (totalShares > 5000) {
            revert TooManyShares(totalShares);
        }

        shares = totalShares;
    }

    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }
}

// input EmployeeStorage employee = new EmployeeStorage(1000, "Pat", 50000, 112358132134);
