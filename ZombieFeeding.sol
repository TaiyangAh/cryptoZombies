// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.13 <0.9.0;

import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna) public {
        /* Add a require statement to verify that msg.sender 
        is equal to this zombie's owner */
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        //父合约方法须为internal而不是private修饰,才能被子合约调用到
        _createZombie("NoName", newDna);
    }
}
