// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanConverterV2 {
    string[4] thousands = ["", "M", "MM", "MMM"];
    string[10] hundreds = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
    string[10] tens = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
    string[10] ones = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];

    function intToRoman(uint256 num) public view returns (string memory) {
        require(num > 0 && num <= 3999, "Number out of range");
        // abi.encodePacked(a, b, c)
        // 这是 Solidity 中常见的字符串拼接方式，返回的是 bytes，通过 string(...) 转换为字符串。
        return string(abi.encodePacked(
            thousands[num / 1000],
            hundreds[(num % 1000) / 100],
            tens[(num % 100) / 10],
            ones[num % 10]
        ));
    }
}