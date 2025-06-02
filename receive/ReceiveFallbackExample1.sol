// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReceiveFallbackExample1 {
    event ReceivedETH(string func, uint amount);
    event FallbackETH(string func, uint amount, bytes data);

    // 当调用方发送 ETH 且没有 calldata（data 为空）时被调用
    receive() external payable {
        emit ReceivedETH("receive", msg.value);
    }

    // 当调用方发送 ETH 且带有无效 calldata 或没有 receive() 时被调用
    fallback() external payable {
        emit FallbackETH("fallback", msg.value, msg.data);
    }

    // 查询合约余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
