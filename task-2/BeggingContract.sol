// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BeggingContract is Ownable {
    mapping(address => uint256) public donations;
    address[] public donors;

    // 记录捐赠事件
    event Donation(address indexed donor, uint256 amount);
    event Withdrawal(address indexed to, uint256 amount);

    // 允许任何人捐赠ETH
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than 0");

        if (donations[msg.sender] == 0) {
            donors.push(msg.sender); // 新捐赠人记录
        }

        donations[msg.sender] += msg.value;
        emit Donation(msg.sender, msg.value);
    }

    // 合约拥有者提取所有捐赠
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        payable(owner()).transfer(balance);
        emit Withdrawal(owner(), balance);
    }

    // 查询某地址的捐赠总额
    function getDonation(address donor) public view returns (uint256) {
        return donations[donor];
    }

    // 可选功能：捐赠排行榜（前3名）
    function top3Donors() public view returns (address[3] memory topDonors, uint256[3] memory amounts) {
        address[3] memory tempAddrs;
        uint256[3] memory tempAmounts;

        for (uint256 i = 0; i < donors.length; i++) {
            address addr = donors[i];
            uint256 amount = donations[addr];

            for (uint256 j = 0; j < 3; j++) {
                if (amount > tempAmounts[j]) {
                    // 后移已有的
                    for (uint256 k = 2; k > j; k--) {
                        tempAmounts[k] = tempAmounts[k - 1];
                        tempAddrs[k] = tempAddrs[k - 1];
                    }
                    tempAmounts[j] = amount;
                    tempAddrs[j] = addr;
                    break;
                }
            }
        }

        return (tempAddrs, tempAmounts);
    }

    // 限时捐赠：只能在指定时间范围捐赠（可选）
    uint256 public startTime;
    uint256 public endTime;

    constructor(uint256 _startTime, uint256 _endTime, address initialOwner) Ownable(initialOwner) {
        require(_startTime < _endTime, "Start time must be before end time");
        startTime = _startTime;
        endTime = _endTime;
    }

    // 限时捐赠逻辑改写（可选）
    function limitedTimeDonate() public payable {
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Donations are closed");
        donate(); // 调用主 donate 函数
    }
}

// 合约部署地址：0xfe24a652851792679b6ec2e50b9d0ac4f80550a9

