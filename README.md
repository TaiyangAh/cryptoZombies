### solidity 笔记

1.In addition to _public_ and _private_, Solidity has two more types of visibility for functions: _internal_ and _external_.

internal is the same as private, except that it's also accessible to contracts that inherit from this contract. (Hey, that sounds like what we want here!).

external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract.

2.For our contract to talk to another contract on the blockchain that we don't own, first we need to define an **interface**. its syntax like a contract skeleton. This is how the compiler knows it's an interface

3.solidity 编程语言与众不同的特征:
(1).**永固性[Immutability]** -- after you deploy a contract to Ethereum, it’s immutable, which means that it can never be modified or updated again
(2).**gas** 机制 -- In Solidity, your users have to pay every time they execute a function on your DApp using a currency called gas. Users buy gas with Ether (the currency on Ethereum), so your users have to spend ETH in order to execute functions on your DApp.
