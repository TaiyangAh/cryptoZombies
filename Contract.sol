// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.13 <0.9.0;

/*  random Zombie generator */

contract ZombieFactory {
    //声明事件
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;
    //struct像js中的对象
    struct Zombie {
        string name;
        uint256 dna;
    }
    //声明一个动态(元素可拓展),公开(可从合约外部访问)的Zombie类型的数组
    Zombie[] public zombies;

    //定义一个私有(private)方法
    function _createZombie(string memory _name, uint256 _dna) private {
        /* fire an event to let the app know the function was called.
        Operation push has changed behavior since since solidity 0.6 --
        It no longer returns the length but a reference to the added element. */
        zombies.push(Zombie(_name, _dna));
        uint256 id = zombies.length - 1;
        emit NewZombie(id, _name, _dna);
    }

    /*keccak256-- A built-in hash function basically maps an input 
    into a random 256-bit hexadecimal number. 
    keccak256 expects a single parameter of type bytes */
    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
