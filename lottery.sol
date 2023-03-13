// SPDX-License-Identifier: GPL-3.0
pragma solidity  >=0.7.0 <0.9.0;
contract Lottery{
    address public manager;
    address payable[] public participants;
    constructor(){
        manager=msg.sender;
    }

  

    receive() external payable
    { 
        require(msg.value==1 ether);
        // return address(this).balance;
        participants.push(payable(msg.sender));

    }

    function balance() public view returns(uint)  {
        require(msg.sender==manager);
        return address(this).balance;

    }

    function randMod() public view returns(uint)
    {
        // increase nonce
      
        return uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,participants.length)));
    }


    function winner() public  {
        require(msg.sender==manager);
        require(participants.length>=3);
        uint  i=randMod();
        address payable king;
        uint index= i%participants.length;

        king=participants[index];

        king.transfer(balance());
       
    }









   
}

