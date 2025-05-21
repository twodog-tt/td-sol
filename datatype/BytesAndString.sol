// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract BytesAndString {
    // 2种 初始化方式
    string name = "BytesAndString"; // new string(5);
    bytes name1 = "BytesAndString"; // new bytes(5);

    // string是不能修改的
    // bytes是可以修改的

    function testStringAndBytes()public view returns(string memory){
        // 初始化方式new 为什么用new? struct初始化为什么不用new?
        string memory data = "xyz"; 
        bytes memory data1 = "abc";

        // 不同location的memory拷贝
        data = name;
        data1 = name1;

        // 强制类型转换
        data1 = bytes(data);
        data = string(data1);

        return  data;
    }

    // 高级话题，bytes与byte[]的区别？
}