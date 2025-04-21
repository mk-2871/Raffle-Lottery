//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "src/Raffle.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {CreateSubcription} from "script/Interactions.s.sol";

contract DeployRaffle is Script {
    function run() public {}

    function deployContract() public returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        //local -> deploy mocks, get local config
        //seplia -> get sepolia config
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        if (config.subscriptionId == 0) {
            Createsubscription createSubscription = new CreateSubscription();
            (config.subscriptionId, config.vrfCoordinator) =
                createSubscription.createSubscription(config.vrfCoordinator);
        }

        vm.startBroadcast();
        Raffle raffle = new Raffle(
            config.entranceFee,
            config.interval,
            config.vrfCoordinator,
            config.gaslane,
            config.subscriptionId,
            config.callbackGasLimit
        );
        vm.stopBroadcast();

        return (raffle, helperConfig);
    }
}
