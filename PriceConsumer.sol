// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @dev Interface for Chainlink Aggregator V3
 */
interface AggregatorV3Interface {
  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

/**
 * @title PriceConsumer
 * @dev Safely consumes price data from Chainlink Oracles.
 */
contract PriceConsumer {
    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Sepolia
     * Aggregator: ETH/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    /**
     * @dev Returns the latest price with safety checks.
     */
    function getLatestPrice() public view returns (int256) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        require(price > 0, "Negative price not allowed");
        require(timeStamp != 0, "Round not complete");
        require(answeredInRound >= roundID, "Stale price data");
        
        // Ensure price is not older than 24 hours (86400 seconds)
        require(block.timestamp - timeStamp <= 86400, "Price data is too old");

        return price;
    }
}
