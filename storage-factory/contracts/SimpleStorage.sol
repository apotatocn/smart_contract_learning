// I'm a comment!
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

// pragma solidity ^0.8.0;
// pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage {
    uint256 public favoriteNumber;
    People[] public peoples;
    mapping(string => People) public peopleNameToPeople;
    mapping(string => uint256) public nameToFavoriteNumber;

    struct People {
        string name;
        uint256 favoriteNumber;
    }

    // uint256[] public anArray;

    // virtual：子类可以被重写
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    // view、pure只能查看不能修改变量，则不需要花费gas
    // 不发生交易只是在链下读取数值，则不需要花费gas
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    // function add() public pure returns (uint256) {
    //     return 1 + 1;
    // }

    // calldata, memory, storage
    // calldata: 临时变量，并且不可变
    // memory：临时变量，可变
    // storage：永久变量
    // peoples数组添加人
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPepole = People({
            name: _name,
            favoriteNumber: _favoriteNumber
        });
        peoples.push(newPepole);
        peopleNameToPeople[_name] = newPepole;
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
