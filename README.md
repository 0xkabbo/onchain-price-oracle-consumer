# On-Chain Price Oracle Consumer

This repository demonstrates how to securely fetch real-time asset prices (e.g., ETH/USD) directly on-chain using Chainlink Price Feeds. This is a critical component for any DeFi application that requires reliable price data to determine collateralization ratios, liquidation thresholds, or swap rates.

### Features
* **Decentralized Data:** Pulls prices from a network of independent oracle nodes to prevent single points of failure.
* **Security Checks:** Includes validation for stale data and negative price values.
* **Multi-Asset Ready:** Easily extendable to support BTC, LINK, Gold, or any other supported Chainlink pair.

### Implementation Details
The contract interacts with the `AggregatorV3Interface`. When requesting a price, the contract ensures the `updatedAt` timestamp is recent to avoid using outdated market information.
