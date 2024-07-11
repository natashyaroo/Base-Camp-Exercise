// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArraysExercise {
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    address[] public senders;
    uint[] public timestamps;

    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    function resetNumbers() public {
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }

    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint[] memory filteredTimestamps = new uint[](timestamps.length);
        address[] memory filteredSenders = new address[](senders.length);
        uint count = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                filteredTimestamps[count] = timestamps[i];
                filteredSenders[count] = senders[i];
                count++;
            }
        }

        assembly {
            mstore(filteredTimestamps, count)
            mstore(filteredSenders, count)
        }

        return (filteredTimestamps, filteredSenders);
    }

    function resetSenders() public {
        delete senders;
    }

    function resetTimestamps() public {
        delete timestamps;
    }
}
