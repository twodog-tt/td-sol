// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {
    uint[] public numbers; // 存储在storage中国呢

    function setNumbers(uint[] memory _nums) public {
        numbers = _nums; // 直接赋值，Solidity 会自动拷贝元素
    }
}
