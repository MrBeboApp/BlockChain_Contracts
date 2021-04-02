pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract MultiWallet{
    
    uint minApprovers;
    
    address payable beneficiary;
    address owner;
    
    //accounts these have permission to send
    mapping (address=>bool) approvedBy;
    
    //accounts that have apprmssions to approve to any one
     mapping (address=>bool) isApprover;
     
     
     uint approvalsNumber;
     
     constructor(address  [] memory _approvers,uint _minApprovers,address payable  _beneficiary) payable{
         require(_minApprovers <= _approvers.length,"The number of approvers should less than the number of approvers");
         minApprovers =_minApprovers;
         beneficiary =_beneficiary;
         owner=msg.sender;
         
         for(uint i =0;i <= _approvers.length;i++){
             address approv = _approvers[i];
             isApprover[approv]=true;
         }
     }
     
     
     
     
     function approvedTransction() public{
         require(isApprover[msg.sender],"Not an Approver");
         if(!approvedBy[msg.sender]){
             approvalsNumber++;
             approvedBy[msg.sender] = true;
         }
         
         if(approvalsNumber == minApprovers){
             
             
             beneficiary.send(address(this).balance);
             selfdestruct(owner);
         }
         
     }


function reject() public{
      require(isApprover[msg.sender],"Not an Approver");
      selfdestruct(owner);

}

}