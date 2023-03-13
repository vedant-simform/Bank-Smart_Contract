//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract SimformBank{
    mapping(address=>uint) customerAccountBalance;
    
    // Events
    event depositETH(address _to, uint _amount);
    event viewAccountBalance(address _accountName);
    event withdrawETH(address _from, uint _amount);
    
    function deposit() payable public {
        customerAccountBalance[msg.sender] += msg.value;
        emit depositETH(msg.sender,msg.value);
        emit viewAccountBalance(msg.sender);
    }

    function checkBalance() public view returns(uint){
        return customerAccountBalance[msg.sender];
    }

    function withdraw(uint withdrawAmount) payable public {
        withdrawAmount = withdrawAmount * 1e18;  // Changing input wei => ETH
        require(withdrawAmount<=customerAccountBalance[msg.sender],"Insufficient Balance");
        customerAccountBalance[msg.sender] -= withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);       
        emit depositETH(address(this), msg.value);
        emit viewAccountBalance(msg.sender);  
    }
    
}