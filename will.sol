// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Will{
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable public{
        owner= msg.sender;
        fortune = msg.value;
        deceased = false;
    }

    modifier mustBeDeceased{
        require(deceased==true);
        _;
    }
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    address payable [] familyWallets;
    mapping(address => uint) inheritance;

    function setInheritance(address payable _addr, uint _amount) public onlyOwner{
        familyWallets.push(_addr);
        inheritance[_addr] = _amount;
    }
    function _payout() private mustBeDeceased{
        for(uint i = 0; i<familyWallets.length; i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }
    function setDeceasedStatus() public onlyOwner{
        deceased = true;
        _payout();
    }
}
