// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

// Get funds from users（从用户处获得资金）
// Withdraw funds（提取资金）
// Set a minimum funding value in USD（同时设置一个以 usd(美元)计价的最小资助额）
contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 1;
    // 用户地址
    address[] public funders;
    // 用户地址 => (Wei/ETU)
    mapping(address => uint256) public addressToAointFunded;

    // 合约部署人
    address public owner;

    constructor() {
        owner = msg.sender;
    }

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
        // msg.sender = 调用者的地址
        // msg.value = 携带的以太币（Wei\Gwei\Finney\Ether）
        require(
            msg.value.getConversionRate() > minimumUsd,
            "Didn't send enough!"
        );
        funders.push(msg.sender);
        addressToAointFunded[msg.sender] = msg.value;
    }

    // 提取资金
    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAointFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);
        // actually withdraw funds
        // // 1.transger
        // payable(msg.sender).transfer(address(this).balance);
        // // 2.send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // 3.call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner {
        // 合约部署人校验
        require(msg.sender == owner, "Not allowed!");
        // _; 代表函数内的方法，如果_;在后面说明先执行（require(msg.sender == owner, "Not allowed!");）在执行修饰的函数
        // 他就像是一个占位符一样，将我们要执行的函数内容进行占位
        _;
    }
}
