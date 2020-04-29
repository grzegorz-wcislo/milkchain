pragma solidity ^0.6.4;

contract Milkchain {
    struct MilkPortion {
        uint liters;
        address owner;
        uint[] eventIds;
        uint[] transactionIds;
    }

    struct Event {
        EventType eventType;
        uint timestamp;
    }

    enum EventType {
        CREATED,
        UHTED,
        PASTEURIZED
    }

    struct Transaction {
        address seller;
        uint price;
        uint timestamp;
    }

    mapping (uint => MilkPortion) public milkPortions;
    mapping (uint => Event) public events;
    mapping (uint => Transaction) public transactions;

    uint nextMilkId;
    uint nextEventId;
    uint nextTransactionId;

    constructor() public {
        nextMilkId = 0;
        nextEventId = 0;
        nextTransactionId = 0;
    }

    function addMilkPortion(uint liters) public returns (uint) {
        milkPortions[nextMilkId] = MilkPortion(liters, msg.sender, new uint[](0), new uint[](0));
        registerEvent(nextMilkId, EventType.CREATED);
        return nextMilkId++;
    }

    function registerEvent(uint milkId, EventType et) public returns (uint) {
        require(milkPortions[milkId].owner == msg.sender, "Milk not owned");
        require(milkPortions[milkId].eventIds.length == 0 || et != EventType.CREATED, "Cannot create twice");

        events[nextEventId] = Event(et, now);
        milkPortions[milkId].eventIds.push(nextEventId);
        return nextEventId++;
    }

    function sellMilk(uint milkId, address buyer, uint price) public returns (uint) {
        require(milkPortions[milkId].owner == msg.sender, "Milk not owned");

        milkPortions[milkId].owner = buyer;

        transactions[nextTransactionId] = Transaction(msg.sender, price, now);
        milkPortions[milkId].transactionIds.push(nextTransactionId);

        return nextTransactionId++;
    }
}