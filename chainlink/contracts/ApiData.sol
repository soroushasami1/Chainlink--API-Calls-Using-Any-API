// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract APIConsumer is ChainlinkClient {
    using Chainlink for Chainlink.Request;
  
    uint256 public volume;
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    constructor() {
        setPublicChainlinkToken();
        oracle = 0xc57B33452b4F7BB189bB5AfaE9cc4aBa1f7a4FD8;
        jobId = "d5270d1c311941d0b08bead21fea7747";
        fee = 0.1 * 10 ** 18;
    }
    
    function requestVolumeData() public returns (bytes32 requestId) 
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        request.add("get", "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETH&tsyms=USD");
        
        request.add("path", "RAW.ETH.USD.VOLUME24HOUR");
        
        int timesAmount = 10**18;
        request.addInt("times", timesAmount);
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function fulfill(bytes32 _requestId, uint256 _volume) public recordChainlinkFulfillment(_requestId)
    {
        volume = _volume;
    }


    // function withdrawLink() external {} - Implement a withdraw function to avoid locking your LINK in the contract

    //for better learning watch chainlink tutorials :
    //https://docs.chain.link/docs/advanced-tutorial/

    // Deploy your contract on kovan testnet
    
    // Then send some link to the contract address for job cost

    /**
    Job Details
    Chainlink DevRel@chainlinkdevrel
    Node Job Id: d5270d1c311941d0b08bead21fea7747
    Oracle Address: 0xc57B33...4FD8
    Cost: 0.1 LINK
     */
}
