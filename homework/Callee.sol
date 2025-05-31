// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "homework/ICallee.sol";

// 0x93f8dddd876c7dBE3323723500e83E202A7C96CC
contract Callee is ICallee {
    uint256 public x;

    function setx(uint256 _x) public {
        x = _x;
    }
}
