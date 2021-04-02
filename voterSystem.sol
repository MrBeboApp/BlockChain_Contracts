pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract Voter{
    
    struct optionPosition{
        uint position;
        bool exixit;
    }
    uint [] public votes;
    string []  public options;
    mapping(address=>bool) hasVoted;
    mapping(string=> optionPosition) positionOfOption;
    
 //Intial the voter options 
     constructor (string[] memory _options) {
         options = _options;
        //  delete votes;
        //  delete options;
        
        
        for(uint i = 0; i < options.length;i++){
            optionPosition memory optionPos = optionPosition(i,true);
            string memory optionName = options[i];
            positionOfOption[optionName]= optionPos;
            
        }
         
     }
    
    //Add your vote with number
    
    function vote(uint option)public{
        require(0<= option && option < options.length,"Your Entry is Invalid");
        require(!hasVoted[msg.sender],"Your Account have Already Voted");
        votes[option] = votes[option]+1;
        hasVoted[msg.sender] = true;
    }
    
    //Other vote function with the name not with the number
    
    
       function vote(string memory optionName)public{
        require(!hasVoted[msg.sender],"Your Account have Already Voted");
        optionPosition memory optionPos = positionOfOption[optionName];
        require(optionPos.exixit,"Open dosnot exixit");
        votes[optionPos.position] = votes[optionPos.position]+1;
        hasVoted[msg.sender] = true;
    }
    
    //Get The options
    function getOptions()public view returns(string[] memory){
        
        return options;
        
    }
    
  
  //Get all votes
    function getVotes()public view returns(uint[] memory){
        
        return votes;
        
    }
}