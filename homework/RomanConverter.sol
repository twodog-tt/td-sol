// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanConverter {
    mapping(bytes1 => uint256) public symbolValues; // 映射：存储罗马字符的对应数值

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
        bytes memory str = bytes(s); // 转换成bytes
        uint256 n = str.length; // 获取长度
        uint256 ans = 0; // 初始化返回值

        for (uint256 i = 0; i < n; i++) {
            // 遍历字符数组bytes
            uint256 value = symbolValues[str[i]];
            // 如果当前字符比后一个字符小，说明是减法结构（如 IV = 5 - 1 = 4），减去当前值。
            if (i < n - 1 && value < symbolValues[str[i + 1]]) {
                ans -= value;
            } else {
                // 否则是加法结构，加上当前值。
                ans += value;
            }
        }

        return ans;
    }
}
