// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract TwitterContract {
    struct Tweet {
        uint id;
        address author;
        string content;
        uint createdAt;
    }

    struct Message {
        uint id;
        string content;
        address from;
        address to;
        uint createdAt;
    }

    mapping(uint => Tweet) public tweets;

    mapping(address => uint[]) public tweetsOf;

    mapping(address => Message[]) public conversations;

    mapping(address => mapping(address => bool)) public operators;

    mapping(address => address[]) public following;

    uint nextId;

    uint nextMessageId;

    
    function _tweet(address _from, string memory _content) internal { // tweet  access check - owner, authority
     require(_from == msg.sender || operators[_from][msg.sender],"you dont have access");
     tweets[nextId]=Tweet(nextId,_from,_content,block.timestamp);
      tweetsOf[_from].push(nextId);
      nextId = nextId+1;

}

  function _sendMessage(address _from,address _to,string memory _content) internal {
     require(_from==msg.sender|| operators[_from][msg.sender],"you dont have asccess");
    conversations[_from].push(Message(nextMessageId,_content,_from,_to,block.timestamp));