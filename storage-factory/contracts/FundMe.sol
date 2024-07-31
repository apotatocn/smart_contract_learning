// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// Get funds from users（从用户处获得资金）
// Withdraw funds（提取资金）
// Set a minimum funding value in USD（同时设置一个以 usd(美元)计价的最小资助额）

contract FundMe {

    uint256 public number;

    // 从用户处获得资金
    // payable修饰符表示改函数是一个合约账户的函数，就像账户钱包地址一样拥有余额value
    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 设置一个最小ETH金额的限制的校验
        // require: 相当于断言,并且可以回滚，退回花费的gas
        // msg：每个合约都有基础参数
        // msg.data = 合约数据
        // msg.gas = gas费用
        // msg.sender = ？
        // msg.value = 参数
        // 回滚测试
        number = 5;
        require(msg.value > 1e18, "Didn't send enough!");
        // 如何能向这个合约转入ETH


    }

    // 提取资金
    // function withdraw() public {}
}
