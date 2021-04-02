pragma solidity >=0.7.0 <0.9.0;

//Contarct that is take message and back it to show it
contract ShowMessage{
    
    string public message;
    
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }
}
