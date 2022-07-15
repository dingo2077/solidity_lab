pragma solidity ^0.8.0;

import "./Ownable.sol";
contract Main {

    address owner;

    


    constructor() {
        owner = msg.sender;
    }

    mapping (address=>uint) public mapUserLimits;

    function toSetLimit2(address _userAddress, uint _userLimit) public {
        require(msg.sender==_msgSender(),"error_1"); //require не выполняется.
        mapUserLimits[_userAddress]=_userLimit;
    }

    function toCheckBalance() public view returns(uint) {
        return address(this).balance;
    }


    function toWithdraw(uint _toAmount) public {
        
        if (msg.sender==owner) {
            payable(owner).transfer(_toAmount); } 
            else if (_toAmount>mapUserLimits[msg.sender]) {
                revert("error1"); }
                 else { payable(msg.sender).transfer(_toAmount);
                 mapUserLimits[msg.sender]-=_toAmount; }
                     
                }


    function toReceiveMoney() public payable {

    }
        receive() payable external {} //Нельзя задеплоить сразу с балансом по дефолту в VM, почему?
        fallback() external {} //Добавить payable? поработать.



}
