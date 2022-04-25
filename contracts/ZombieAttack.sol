// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.13 <0.9.0;

import "./ZombieHelper.sol";

contract ZombieAttack is ZombieHelper {
    uint256 randNonce = 0;

    function randMod(uint256 _modulus) internal returns (uint256) {
        randNonce++;
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.timestamp, msg.sender, randNonce)
                )
            ) % _modulus;
    }
}
