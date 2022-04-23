// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.13 <0.9.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
    //Function modifiers with arguments
    modifier aboveLevel(uint256 _level, uint256 _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    function changeName(uint256 _zombieId, string calldata _newName)
        external
        aboveLevel(2, _zombieId)
    {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    function changeDna(uint256 _zombieId, uint256 _newDna)
        external
        aboveLevel(20, _zombieId)
    {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    // make it an external view function, so we can call it from web3.js without needing any gas
    function getZombiesByOwner(address _owner)
        external
        view
        returns (uint256[] memory)
    {
        // Declaring arrays in memory to save gas
        uint256[] memory result = new uint256[](ownerZombieCount[_owner]);
        uint256 counter = 0;
        for (uint256 i = 0; i < zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}
