// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract BasicType{
    function testInt() public pure returns(uint){
        // uint256 i8 = 259887;
        uint256 max = type(uint256).max;
        // SafeMath
        uint8 x = 8;
        uint16 y = 9;
        x = uint8(y);
        return  max;
    }

    // 定义一个枚举类型
    enum OrderState{layorder,payment,x,y} // 最多有256个成员
    function enumTest()public pure returns(OrderState){
        OrderState state = OrderState.layorder; // 输出为0
        // OrderState state = OrderState.payment; // 输出为1
        return state;
    }
}