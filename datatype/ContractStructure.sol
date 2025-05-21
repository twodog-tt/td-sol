// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// 0xf8e81D47203A594245E36C48e151709F0C19fBe8
// 0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B
contract ContractStructure {
    uint256 public balance; // 当声明为public时，会自动生成一个同名的public view函数

    // 与Java中的log日志有点像 定义事件的名称即结构
    event BalanceAdded(uint256 oldValue,uint256 incre);

    // 合约在区块链上被部署的时候执行构造函数
    constructor(uint256 _bal){
        balance = _bal;
    }

    // 合约函数的修饰器，可以自定义的对合约函数进行修饰
    modifier IncrementRange(uint256 _incre){
        // 修饰器是对函数的输入输出条件进行约束的
        // 与面向对象语言中的面相切面类似
        // 要求 _incre > 100，否则提示“too small!”
        require(_incre > 100,"too small!");
        // 执行被修饰函数的逻辑
        _; 
    }

    function balance1() internal view returns(uint256){
        return balance;
    }

    function addBalance(uint256 _incre)external IncrementRange(_incre) {
        uint256 old = balance;
        balance += _incre;
        // 触发事件
        // 编译部署后在控制台输出日志 
        /**
                                [
                    {
                        "from": "0xDA0bab807633f07f013f94DD0E6A4F96F8742B53",
                        "topic": "0x2f59d1a3b7b985da630a67df5848afd649a7ac56a4f65c399458a7b1219d2556",
                        "event": "BalanceAdded",
                        "args": {
                            "0": "0",
                            "1": "123",
                            "oldValue": "0",
                            "incre": "123"
                        }
                    }
                ]
        */
        emit BalanceAdded(old, _incre);
    }
}