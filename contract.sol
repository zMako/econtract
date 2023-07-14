// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SendEthereum {
    
    // Specify the fee receiver's address
    address payable private feeReceiver = payable(<address>);
    
    // Specify the fee ratio
    uint256 private feeRatio = 8762376; // for 0.008762376 ETH
    uint256 private oneEth = 1000000000000000000; // 1 ETH in WEI for ratio calculation
    
    function sendEthereum(address payable _recipient, uint256 _amount) public payable {
        
        // Ensure the sender sent enough ETH
        require(msg.value >= _amount, "Not enough ETH sent with the transaction.");
        
        // Calculate the fee
        uint256 fee = (_amount * feeRatio) / oneEth;
        
        // Ensure the _amount is greater than the fee
        require(_amount > fee, "Amount should be greater than the fee.");
        
        // Send the ETH to the recipient
        _recipient.transfer(_amount - fee);
        
        // Send the fee to the feeReceiver
        feeReceiver.transfer(fee);
    }
    
}
