// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReceiveFallbackExample {
    constructor() payable {}

    event ReceivedEther(address sender, uint256 amount, string functionType);

    // 当仅发送以太币而不附加任何数据时，会调用 receive 函数
    receive() external payable {
        emit ReceivedEther(msg.sender, msg.value, "receive");
    }

    // 当调用合约不存在的函数，或发送交易附加数据但无匹配函数时，会调用 fallback
    fallback() external payable {
        emit ReceivedEther(msg.sender, msg.value, "fallback");
    }

    // 查看合约当前余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
