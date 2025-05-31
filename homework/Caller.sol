// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Callee {
    uint256 public x;
    address public caller;

    function setX(uint _x) public {
        caller = msg.sender; // msg.sender 是当前交易或调用的发起者地址。
        x = _x;
    }
}

// 0x5e17b14ADd6c386305A32928F985b29bbA34Eff5
contract Caller {
    address public caller;
    address calleeAddress;

    constructor(address _calleeAddress) {
        calleeAddress = _calleeAddress;
    }

    function setCalleeX(uint _x) public {
        caller = msg.sender;
        Callee callee = Callee(calleeAddress);
        callee.setX(_x);
    }
}
