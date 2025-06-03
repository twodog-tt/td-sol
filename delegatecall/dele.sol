// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract B {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint256 public num;
    address public sender;
    uint256 public value;

    event DelegateCallResult(bool success, bytes data);

    function setVars(address _contract, uint256 _num) public payable {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        emit DelegateCallResult(success, data);
        require(success, "delegatecall failed!");
    }
}
