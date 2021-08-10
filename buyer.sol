pragma solidity ^0.7.0;

contract danielEther is ERC20{

    mapping(address =>uint256) public amount;
    uint256 totalAmount;
    string tokenName;
    string tokenSymbol;
    uint256 decimal;

    constructor() public{
      totalAmount = 10000 * 10**18;
      amount[msg.sender]=totalAmount;
      tokenName="danielEther";
      tokenSymbol="DAN";
      decimal=18;
    }
    
    event bought(address sender, uint price, int8 ttype);
    
    function totalSupply() public view returns (unit256){
        return totalAmount;
    }
    
    function balanceOf(address to_who) public view
        returns(uint256){
        return amount[to_who];
    }
    
    function buy(address to_a,uint256 _value) public
        returns(bool){
            require(_value<=amount[msg.sender]);
            amount[msg.sender]=amount[msg.sender]-_value;
            amount[to_a]=amount[to_a]+_value;
            bought(msg.sender,_value)
            return true;
    }
    
}    