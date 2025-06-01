// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Ether 单位演示合约（修正版）
/// @author ChatGPT
/// @notice 展示 ether/gwei/wei 单位以及转换方法
contract EtherUnits {

    /// @notice 返回 wei、gwei、ether 对应的值（均为 uint256）
    function getUnits() public pure returns (
        uint256 oneWei,
        uint256 oneGwei,
        uint256 oneEther
    ) {
        return (1 wei, 1 gwei, 1 ether);
    }

    /// @notice 将以太数量转为 wei（例如输入 2，将返回 2 ether 的 wei 值）
    function etherToWei(uint256 ethAmount) public pure returns (uint256) {
        return ethAmount * 1 ether;
    }

    /// @notice 将 gwei 数量转换为 wei
    function gweiToWei(uint256 gweiAmount) public pure returns (uint256) {
        return gweiAmount * 1 gwei;
    }

    /// @notice 将 wei 转为 ether（返回整数部分和余数）
    /// @dev Solidity 不支持小数，因此只能手动分开整数和余数
    function weiToEther(uint256 weiAmount) public pure returns (uint256 etherInteger, uint256 remainderInWei) {
        etherInteger = weiAmount / 1 ether;
        remainderInWei = weiAmount % 1 ether;
    }

    /// @notice 如果用户发送了 >= 1 ether，就返还 1 ether 给他
    function sendBackOneEther() public payable {
        require(msg.value >= 1 ether, "You need to send at least 1 ether");
        payable(msg.sender).transfer(1 ether);
    }

    /// @notice 记录收到的 ETH
    event ReceivedEther(address indexed sender, uint256 amount);

    /// @dev 当合约接收 ETH 时触发 receive
    receive() external payable {
        emit ReceivedEther(msg.sender, msg.value);
    }
}
