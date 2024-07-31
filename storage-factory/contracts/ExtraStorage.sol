// I'm a comment!
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

// 继承关键字 is
contract ExtraStorage is SimpleStorage {

    //重写父类的方法必须保证：
    //1、父类方法上添加 virtual 关键字修饰
    //2、子类重写的方法必须加override关键字
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}
