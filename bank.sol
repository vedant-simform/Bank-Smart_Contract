//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract SimformBank{
    mapping(address=>uint) public customer;
   
    function deposit() payable public {
        customer[msg.sender] += msg.value;
    }

    function checkBalance() public view returns(uint){
        return customer[msg.sender];
    }

    function withdraw(uint withdrawAmount) payable public {
        require(withdrawAmount<=customer[msg.sender],"Insufficient Balance");
        payable(msg.sender).transfer(withdrawAmount); 
        customer[msg.sender] -= withdrawAmount;
    }
}