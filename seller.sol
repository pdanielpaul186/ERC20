pragma solidity ^0.7.0;

contract Deal {
    
  address public owner;
  address public buyerAddr;
  
  struct Buyer {
    address addr;
    string name;
    bool init;
  }
  
  struct Order {
    string goods;
    uint quantity;
    uint number;
    uint price;
    uint safepay;
    Shipment shipment;
    bool init;
  }
  
  event OrderSent(address buyer, string goods, uint quantity, uint orderno);
  event PriceSent(address buyer, uint orderno, uint price, int8 ttype);
  event SafepaySent(address buyer, uint orderno, uint value, uint now);
  
  function Deal(address _buyerAddr) public payable {
    owner = msg.sender;
    buyerAddr = _buyerAddr;
  }

  function sendOrder(string goods, uint quantity) payable public {
    require(msg.sender == buyerAddr);
    orderseq++;
    orders[orderseq] = Order(goods, quantity, orderseq, 0, 0, Shipment(0, 0, 0, 0, 0, 0, false), true);
    OrderSent(msg.sender, goods, quantity, orderseq);

  }

  function sendPrice(uint orderno, uint price, int8 ttype) payable public {
    require(msg.sender == owner);
    require(orders[orderno].init);
    require(ttype == 1 || ttype == 2);
    if(ttype == 1){
      orders[orderno].price = price;
    } else {
      orders[orderno].shipment.price = price;
      orders[orderno].shipment.init  = true;
    }
    PriceSent(buyerAddr, orderno, price, ttype);

  }

  function sendSafepay(uint orderno) payable public {
    require(orders[orderno].init);
    require(buyerAddr == msg.sender);
    require((orders[orderno].price + orders[orderno].shipment.price) == msg.value);
    orders[orderno].safepay = msg.value;
    SafepaySent(msg.sender, orderno, msg.value, now);
  }

}