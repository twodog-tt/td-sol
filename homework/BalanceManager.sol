// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalanceManager {
    mapping(address=>uint256) public balanceOf;

    string public name = "mydoller";
    string public symbol = "$";
    uint8 public decimals = 4; // 一万个数字单位等于1个mydoller(1$)

    constructor(uint totalBalance){
        // msg.sender;
        balanceOf[msg.sender] = totalBalance;
    }

    function transfer(address to, uint256 amount)public {
        address from = msg.sender;
        uint256 fb = balanceOf[from];
        uint256 tb = balanceOf[to];

        require(amount <= fb,"error");
        
        fb -= amount;
        tb += amount;
        balanceOf[from] = fb;
        balanceOf[to] = tb;
    } 
    
}

// 0x3340f5d42160702c3dBd14833Fa55Ca5b28bBF2F

// 0xa1c5518FB60260B859A9564c4b3Dfc9238d3120C

// 0x0F7ab322Ddd9Afd1EebAd59f608b341B02864883