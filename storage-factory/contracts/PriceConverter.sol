// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@chainlink/contracts@1.2.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256) {
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

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount)
        internal
        view
        returns (uint256)
    {
        uint256 ethPic = getPrice();
        // Wei转为ETH
        uint256 ethAmountInUsd = (ethPic * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}
