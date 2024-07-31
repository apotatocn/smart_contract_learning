// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

contract SimpleFactory {
    SimpleStorage[] public simpleStorages;

    function createSimpleStorageContract() public {
        simpleStorages.push(new SimpleStorage());
    }

    // 调用store 设置值
    function sfStore(uint256 _index, uint256 _favoriteNumber) public {
        SimpleStorage simpleStorage = simpleStorages[_index];
        simpleStorage.store(_favoriteNumber);
    }

    // 获取值
    function sfGet(uint256 _index) public view returns (uint256) {
        SimpleStorage simpleStorage = simpleStorages[_index];
        uint256 number = simpleStorage.retrieve();
        return number;
    }
}
