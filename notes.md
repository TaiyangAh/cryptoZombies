### 一、solidity 笔记

1.In addition to _public_ and _private_, Solidity has two more types of visibility for functions: _internal_ and _external_.

internal is the same as private, except that it's also accessible to contracts that inherit from this contract. (Hey, that sounds like what we want here!).

external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract.

2.For our contract to talk to another contract on the blockchain that we don't own, first we need to define an **interface**. its syntax like a contract skeleton. This is how the compiler knows it's an interface

3.solidity 编程语言与众不同的特征:
(1).**永固性[Immutability]** -- after you deploy a contract to Ethereum, it’s immutable, which means that it can never be modified or updated again
(2).**gas** 机制 -- In Solidity, your users have to pay every time they execute a function on your DApp using a currency called gas. Users buy gas with Ether (the currency on Ethereum), so your users have to spend ETH in order to execute functions on your DApp.
(3).**payable functions** -- a special type of function that can receive Ether

4.gas optimization
(1)**view** functions don't cost any gas when they're called **externally** by a user,you can optimize your DApp's gas usage for your users by using read-only **external view functions** wherever possible
(2)One of the more expensive operations in Solidity is using **storage** — particularly **writes**.In order to keep costs down, you want to avoid writing data to storage except when absolutely necessary

5.function modifiers
(1).**visibility modifiers**：control when and where the function can be called from

-- **private** means it's only callable from other functions inside the contract; **internal** is like private but can also be called by contracts that inherit from this one; **external** can only be called outside the contract; and finally **public** can be called anywhere, both internally and externally.

(2).**state modifiers**：tell us how the function interacts with the BlockChain

-- **view** tells us that by running the function, no data will be saved/changed. **pure** tells us that not only does the function not save any data to the blockchain, but it also doesn't read any data from the blockchain. Both of these don't cost any gas to call if they're called externally from outside the contract (but they do cost gas if called internally by another function).

(3).the **payable** modifier：payable functions are part of what makes Solidity and Ethereum so cool — they are a special type of function that can receive Ether

(4).**custom modifiers**：define custom logic affect a function

6.address and address payable：see the [differences between 'address' and 'address payable'](https://ethereum.stackexchange.com/questions/64108/whats-the-difference-between-address-and-address-payable/64109#64109)

7.第三方**lib**的用法,不同于第三方 contract,没有继承机制

### 二、webjs 笔记

1.Web3.js will need 2 things to talk to a contract: its **address** and its **ABI**.
