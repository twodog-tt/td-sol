// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Callee {
    uint public x;
    string public message;
    uint public receivedValue;

    event SetX(uint x);
    event Received(string func, uint value, bytes data);

    function setX(uint _x) public payable {
        x = _x;
        receivedValue = msg.value;
        emit SetX(_x);
    }

    function setMessage(string calldata _msg) public returns (string memory) {
        message = _msg;
        return _msg;
    }

    receive() external payable {
        emit Received("receive", msg.value, "");
    }

    fallback() external payable {
        emit Received("fallback", msg.value, msg.data);
    }
}
