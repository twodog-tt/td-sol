// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageLayout {
    uint256 public num; // slot 0 
    address public sender;// slot 1
    Person person;  // slot 2 3 4
    bool[12] success; // slot 5
    mapping(address=>uint) balance; // slot n ,映射到很远的位置。
    uint256 public value; // slot 6

    struct Person {
        uint256 num ; // slot 0 
        address sender;// slot 1
        bool[12] success;
        uint256 value; // slot 2
    }

    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}
