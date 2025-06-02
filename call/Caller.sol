// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICallee {
    function setX(uint _x) external payable;
    function setMessage(string calldata _msg) external returns (string memory);
}

contract Caller {
    event CallResult(bool success, bytes data);

    function callSetX(address _callee, uint _x) public payable {
        bytes memory data = abi.encodeWithSignature("setX(uint256)", _x);
        (bool success, bytes memory returnData) = _callee.call{value: msg.value}(data);
        emit CallResult(success, returnData);
    }

    function callSetMessage(address _callee, string memory _msg) public {
        bytes memory data = abi.encodeWithSignature("setMessage(string)", _msg);
        (bool success, bytes memory returnData) = _callee.call(data);
        emit CallResult(success, returnData);
    }

    function callNonExistentFunction(address _callee) public {
        bytes memory data = abi.encodeWithSignature("noSuchFunction()");
        (bool success, bytes memory returnData) = _callee.call(data);
        emit CallResult(success, returnData);
    }

    function sendEtherOnly(address payable _callee) public payable {
        (bool success, bytes memory data) = _callee.call{value: msg.value}("");
        emit CallResult(success, data);
    }
}
