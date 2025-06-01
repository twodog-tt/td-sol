// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Caller {
    address calleeAddress;
    uint public xx;

    constructor(address _calleeAddress) {
        calleeAddress = _calleeAddress;
    }

    function setCalleeX(uint _x) public {
        bytes memory cd = abi.encodeWithSignature("setx(uint256)", _x);
        (bool suc,bytes memory rst) = calleeAddress.call(cd);
        if(!suc){
            revert("call failed!");
        }
        (uint x) = abi.decode(rst, (uint));   
        xx = x;
    }
}