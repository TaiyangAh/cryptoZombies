### solidity 笔记

1.In addition to public and private, Solidity has two more types of visibility for functions: internal and external.

internal is the same as private, except that it's also accessible to contracts that inherit from this contract. (Hey, that sounds like what we want here!).

external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract.
