// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract MappingType {
    // 改成public
    mapping(string => uint8) ages;
    // public读操作array
    mapping(string => mapping(string => uint8))public ages1;
    function getAge(string memory name) public view returns(uint8){
        // mapping(string => uint8) storage _ages = ages;
        return ages[name];
    }

    function setAge(string memory name,uint8 age)public {
        ages[name] = age;
    }
    // 一般规则：public memory calldata internal private可以是storage
    // mapping：只能是storage
    // 推论：public函数中，参数或者返回值不可能出现mapping类型
    
    
    
    // 写一个internal或private函数，传递storage的mapping
    
}