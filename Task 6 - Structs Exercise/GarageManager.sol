// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GarageManager {
    struct Car {
        string make;
        string model;
        string color;
        uint256 numberOfDoors; 
    }

    mapping(address => Car[]) public garage;

    error BadCarIndex(uint256 index);

    function addCar(string memory _make, string memory _model, string memory _color, uint256 _numberOfDoors) public {
        garage[msg.sender].push(Car(_make, _model, _color, _numberOfDoors));
    }

    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    function updateCar(uint256 _index, string memory _make, string memory _model, string memory _color, uint256 _numberOfDoors) public {
        if (_index >= garage[msg.sender].length) {
            revert BadCarIndex(_index);
        }
        
        garage[msg.sender][_index] = Car(_make, _model, _color, _numberOfDoors);
    }

    function resetMyGarage() public {
        delete garage[msg.sender];
    }
}