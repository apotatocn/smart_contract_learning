// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import {AggregatorV3Interface} from "@chainlink/contracts@1.2.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// Get funds from users（从用户处获得资金）
// Withdraw funds（提取资金）
// Set a minimum funding value in USD（同时设置一个以 usd(美元)计价的最小资助额）
contract FundMe {
    uint256 public minimumUsd = 50;

    // 从用户处获得资金
    // 20000000000000000
    // payable修饰符表示改函数是一个合约账户的函数，就像账户钱包地址一样拥有余额value
    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 设置一个最小USD金额的限制的校验
        // require: 相当于断言,并且可以回滚，退回花费的gas
        // msg：每个合约都有基础参数
        // msg.data = 合约数据
        // msg.gas = gas费用
        // msg.sender = ？
        // msg.value = 参数
        require(getConversionRate(msg.value) > minimumUsd, "Didn't send enough!");
        // 如何能向这个合约转入ETH
    }

    function getPrice() public view returns (uint256) {
        // ABI
        // Address
        // ETH/USD: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // BTC/USD: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // 3000.00000000
        return uint256(price * 1e10); // 1**10 == 10000000000
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPic = getPrice();
        // Wei转为ETH
        uint256 ethAmountInUsd = (ethPic * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    // 提取资金
    // function withdraw() public {}
}
