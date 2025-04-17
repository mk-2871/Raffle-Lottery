// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

import {VRFConsumerBaseV2Plus} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

/**
 *  @title Raffle Contract
 *  @author Mohanakumar S
 *  @notice Contract for creating a sample raffle contract
 *  @dev Implements Chainlink VRFv2.5
 */
contract Raffle is VRFConsumerBaseV2Plus {
    // --- Errors ---
    error Raffle__SendMoreToEnterRaffle();

    // --- State Variables ---
    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval; // Duration of lottery in seconds
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    bytes32 private keyHash;
    uint64 private s_subscriptionId;
    uint16 private requestConfirmations;
    uint32 private callbackGasLimit;
    uint32 private numWords;
    bool private enableNativePayment;

    // --- Events ---
    event WinnerPicked(address indexed winner);

    // --- Constructor ---
    constructor(uint256 entranceFee,uint256 interval,address vrfCoordinator) 
    VRFConsumerBaseV2Plus(vrfCoordinator) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    // --- External Functions ---
    function pickWinner() view external {
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert(); // Optional: make this a custom error
        }

        //Request randomness
        // uint256 requestId = s_vrfCoordinator.requestRandomWords(
        //     VRFV2PlusClient.RandomWordsRequest({
        //         keyHash: keyHash,
        //         subId: s_subscriptionId,
        //         requestConfirmations: requestConfirmations,
        //         callbackGasLimit: callbackGasLimit,
        //         numWords: numWords,
        //         extraArgs: VRFV2PlusClient._argsToBytes(
        //             VRFV2PlusClient.ExtraArgsV1({
        //                 nativePayment: enableNativePayment
        //             })
        //         )
        //     })
        // );
    }

    // --- Internal Functions ---
    function fulfillRandomWords(
        uint256 , 
        uint256[] calldata randomWords
    ) internal override {}

    // --- View / Pure Functions ---
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
