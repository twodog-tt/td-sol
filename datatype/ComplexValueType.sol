// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract  ComplexValueType {
    function testAddress()public view returns(address){
        // address 可以是外部账号或者合约地址
        address addr = msg.sender;
        // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        // 得到的地址就是链向钱包的地址（账号合约本身）
        return addr;
    }

    function testMyAddress()public view returns(address){
        // address 可以是外部账号或者合约地址
        address addr = address(this);
        // 0x93f8dddd876c7dBE3323723500e83E202A7C96CC
        // 得到的地址是当前正在被调用的合约的地址（已部署的合约）
        return addr;
    }

    // contract type
    function testContract() public view returns (ComplexValueType){
        ComplexValueType mycontract = this;
        // mycontract 局部变量
        // this 当前这个合约
        return mycontract;
    }

    // 定长字节数组
    function testFixedByteArray()public pure returns (bytes3){
        bytes3 data;
        // 0x000000 定义的3个字节的数据块
        return data;
    }

    function testFixedByteArray1()public pure returns (bytes1){
        bytes3 data = 0x111111;
        bytes1 f = data[0]; 
        // 0x11
        return f;
    }

    function testFixedByteArray2()public pure returns (bytes1){
        bytes3 data = 0x111111;
        bytes1 f = data[1]; 
        // 0x11
        return f;
    }
}