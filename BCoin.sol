// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract BCoin{
    address public minter;
    mapping(address=>uint) public balance;
    event sent(address _from, address _to, uint _amount);

    constructor(){
        minter = msg.sender;
    }

    function mint(address _reciver, uint _amount) public{
        require(msg.sender == minter,"You can't mint cause u aren't the owner");
        balance[_reciver] += _amount;
    }

    error insufficientBalance(uint requested, uint available);
    function send(address _reciever, uint _amount) public{
        if(_amount > balance[msg.sender]){
         revert insufficientBalance({
             requested:_amount,
             available:balance[msg.sender]
         });
        }
        balance[msg.sender] -= _amount;
        balance[_reciever] += _amount;
        emit sent(msg.sender, _reciever,_amount);
    }
}
