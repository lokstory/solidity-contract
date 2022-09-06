// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceFeed is Ownable {

    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Polygon
     * Aggregator: MATIC/USD
     * Address: 0xAB594600376Ec9fD91F8e885dADF0CE036862dE0 
     */
    constructor(address feed) {
        setPriceAddress(feed);
    }

    function setPriceAddress(address feed) public onlyOwner {
        priceFeed = AggregatorV3Interface(feed);
    }

    function decimals() public view returns (uint8) {
        return priceFeed.decimals();
    }

    function getRoundData(uint80 id) public view returns (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound) {
        return priceFeed.getRoundData(id);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
        /*uint80 roundID*/,
        int price,
        /*uint startedAt*/,
        /*uint timeStamp*/,
        /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}
