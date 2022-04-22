### solidity 笔记

1.In addition to _public_ and _private_, Solidity has two more types of visibility for functions: _internal_ and _external_.

internal is the same as private, except that it's also accessible to contracts that inherit from this contract. (Hey, that sounds like what we want here!).

external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract.

2.For our contract to talk to another contract on the blockchain that we don't own, first we need to define an **interface**. its syntax like a contract skeleton. This is how the compiler knows it's an interface
