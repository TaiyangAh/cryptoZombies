// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.13 <0.9.0;

import "./ZombieAttack.sol";
import "./ERC721.sol";

abstract contract ZombieOwnership is ZombieAttack, ERC721 {}
