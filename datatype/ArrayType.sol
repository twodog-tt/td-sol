// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ArrayType{
    // 静态数组
    uint8[3] data; // 存储在storage
    // 动态数组 不定义尺寸
    uint8[] arr; // 
    function testStaticArray()public view returns (uint8[3] memory){
        // 静态数组是引用类型 引用类型一定有存储地址
        return data;// 返回 0,0,0 （实际上进行了一次内存拷贝，storage中的data拷贝到的memory，然后返回了）
    }

    function testStaticArray1()internal view returns (uint8[3] storage){
        // 静态数组是引用类型 引用类型一定有存储地址
        return data;// 返回 0,0,0
    }
    // 注意以上两个function使用public与internal的区别

    function testDynamicStorageArray()public view returns(uint8[] memory){
        return arr; // 返回空
    }

    function testWriteDynamicStorageArray()public{
        arr.push(12); // 押入元素
        arr.pop();// 弹出元素
        arr.push(1);
    }

    function testMemoryDynamicArr(uint8 size)public pure returns (uint8[] memory){
        // 初始化内存中的动态数组，指的是在程序运行时数组才能做初始化，而不是在声明时的初始化
        uint8[] memory mdata = new uint8[](size);
        return mdata;
    }
}