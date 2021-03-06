// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.13 <0.9.0;

import "./Ownable.sol";
import "./safeMath.sol";

/*  random Zombie generator */

contract ZombieFactory is Ownable {
    //  Declare using safemath
    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;
    //声明事件
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    uint256 cooldownTime = 1 days;

    /* struct像js中的对象.
    优化技巧--32 bits is more than enough 
    to hold the zombie's level and timestamp, so this will 
    save us some gas costs by packing the data more tightly 
    than using a regular uint (256-bits). */
    struct Zombie {
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }
    //声明一个动态(元素可拓展),公开(可从合约外部访问)的Zombie类型的数组
    Zombie[] public zombies;

    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna) internal {
        /* fire an event to let the app know the function was called.
        Operation push has changed behavior since since solidity 0.6 --
        It no longer returns the length but a reference to the added element. */
        zombies.push(
            Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0)
        );
        uint256 id = zombies.length - 1;
        /*  msg.sender -- a certain global variable that is available to all functions 
         which refers to the address of the person (or smart contract) 
         who called the current function.
         The syntax for storing data in a mapping is just like with arrays*/
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
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
        //use require to make sure this function only gets executed one time per user
        require(ownerZombieCount[msg.sender] == 0);
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
