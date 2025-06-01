// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Callee2 {
    uint256 public x;

    function setx(uint256 _x) public returns (uint256) {
        x = _x;
        return x;
    }
    // 当setx没有被调用的时候，调用fallback函数
    fallback() external {
        x = 10000;
    }
}
