// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanConverter {
    mapping(bytes1 => uint256) public symbolValues;

    constructor() {
        symbolValues["I"] = 1;
        symbolValues["V"] = 5;
        symbolValues["X"] = 10;
        symbolValues["L"] = 50;
        symbolValues["C"] = 100;
        symbolValues["D"] = 500;
        symbolValues["M"] = 1000;
    }

    function romanToInt(string memory s) public view returns (uint256) {
        bytes memory str = bytes(s);
        uint256 n = str.length;
        uint256 ans = 0;

        for (uint256 i = 0; i < n; i++) {
            uint256 value = symbolValues[str[i]];
            if (i < n - 1 && value < symbolValues[str[i + 1]]) {
                ans -= value;
            } else {
                ans += value;
            }
        }

        return ans;
    }
}
