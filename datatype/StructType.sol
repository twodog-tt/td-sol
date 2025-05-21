// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

 contract StructType {
    struct Person{
        string name;
        uint8 age;
        // Person friend; // 此时出现递归问题，使自带的初始化过程无限裂变占用无限内存空间
    }

    struct Home{
        string add;
        string city;
        uint num;
    }

    Person master;

    // 测试读操作
    function readPerson()public view returns (Person memory){
        return master;
    }
    // 测试写操作
    function writePerson(Person memory p)public {
        master = p;
    }
    function writePerson(string memory name)public {
      master.name = name;
    }

    // 测试内存struct，对struct来说，memory与storage并没有多大影响
    function testMemoryStruct()public pure returns(Person memory){
        // 声明自带初始化，这是递归结构需要考虑的问题。。。
        Person memory p; // 不需要使用new,因为struct大小是确定的，不需要一个尺寸参数
        // 这一点跟new动态数组,bytes,string不同
        p.name = "ergou";
        p.age = 12;
        return p;
    }


    //  测试内存location为storage的局部变量
    function testStorageLocalStruct()public view returns(Person memory){
        Person storage p = master; // 此处不可以不赋值
        return p;
    }

 }