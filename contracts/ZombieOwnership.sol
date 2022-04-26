// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.13 <0.9.0;

import "./ZombieAttack.sol";
import "./ERC721.sol";
import "./safeMath.sol";

/// @title A contract that manages transfering zombie ownership
/// @author Lian Wu
/// @dev  Compliant with OpenZeppelin's implementation of the ERC721 spec draft
contract ZombieOwnership is ZombieAttack, ERC721 {
    /* 不能认为在ZombieFactory中使用过就可以继承而直接使用,
    safeMath lib需要重新引入与声明, */
    //declare using safemath
    using SafeMath for uint256;

    mapping(uint256 => address) zombieApprovals;

    function balanceOf(address _owner)
        external
        view
        override
        returns (uint256)
    {
        // Return the number of zombies `_owner` has
        return ownerZombieCount[_owner];
    }

    function ownerOf(uint256 _tokenId)
        external
        view
        override
        returns (address)
    {
        // Return the owner of `_tokenId`
        return zombieToOwner[_tokenId];
    }

    function _transfer(
        address _from,
        address _to,
        uint256 _tokenId
    ) private {
        ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].sub(1);
        zombieToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable override {
        require(
            zombieToOwner[_tokenId] == msg.sender ||
                zombieApprovals[_tokenId] == msg.sender
        );
        //Call _transfer
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId)
        external
        payable
        override
        onlyOwnerOf(_tokenId)
    {
        zombieApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }
}
