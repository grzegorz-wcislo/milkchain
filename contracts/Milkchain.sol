pragma solidity ^0.6.4;

contract Milkchain {
    struct MilkPortion {
        uint liters;
        address owner;
    }

    mapping (uint => MilkPortion) public milkPortions;

    uint nextId;

    constructor() public {
        nextId = 0;
    }

    function addMilkPortion(uint liters) public {
        milkPortions[nextId++] = MilkPortion(liters, msg.sender);
    }
}