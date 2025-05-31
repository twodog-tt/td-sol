// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 0xddaAd340b0f1Ef65169Ae5E41A8b10776a75482d
contract Callee {
    uint256 public x;

    function setx(uint256 _x) public {
        x = _x;
    }
}

// 0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B
contract Caller {
    address calleeAddress;

    constructor(address _calleeAddress) {
        calleeAddress = _calleeAddress;
    }

    function setCalleeX(uint256 _x) public {
        Callee callee = Callee(calleeAddress);
        callee.setx(_x);
    }
}

