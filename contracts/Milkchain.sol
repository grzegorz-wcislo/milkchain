pragma solidity ^0.6.4;

contract Milkchain {
    struct MilkPortion {
        uint liters;
        address owner;
        uint[] eventIds;
    }

    struct Event {
        EventType eventType;
        uint timestamp;
    }

    enum EventType {
        CREATED
    }

    mapping (uint => MilkPortion) public milkPortions;
    mapping (uint => Event) public events;

    uint nextMilkId;
    uint nextEventId;

    constructor() public {
        nextMilkId = 1;
        nextEventId = 1;
    }

    function addMilkPortion(uint liters) public returns (uint) {
        milkPortions[nextMilkId] = MilkPortion(liters, msg.sender, new uint[](1));
        registerEvent(nextMilkId, EventType.CREATED);
        return nextMilkId++;
    }

    function registerEvent(uint milkId, EventType et) public returns (uint) {
        require(milkPortions[milkId].owner == msg.sender, "Milk not owned");

        events[nextEventId] = Event(et, now);
        milkPortions[milkId].eventIds.push(nextEventId);
        return nextEventId++;
    }
}