pragma solidity ^0.8.20;

import "forge-std/Test.sol";

contract ForkTest is Test {
    // the identifiers of the fork
    uint256 binanceFork;

    uint256 lastBlock = 29_003_114;
    uint256 recentBlock = 28_003_114;
    uint256 oldBlock = 10_003_114;
    // USDC on Binance
    address constant usdc = 0x8965349fb649A33a30cbFDa057D8eC2C48AbE2A2;

    // Replace BINANCE_RPC_URL with your rpc url inside your .env file e.g:
    // BINANCE_RPC_URL = 'https://eth-mainnet.g.alchemy.com/v2/ALCHEMY_KEY'
    string BINANCE_RPC_URL = vm.envString("BINANCE_RPC_URL");

    // create two _different_ forks during setup
    function setUp() public {
        binanceFork = vm.createFork(BINANCE_RPC_URL);
    }

    function testCanSetForkLastBlockNumber() public {
        vm.selectFork(binanceFork);
        vm.rollFork(lastBlock);

        assertEq(block.number, lastBlock);
    }

    function testCanSetForkRecentBlockNumber() public {
        vm.selectFork(binanceFork);
        vm.rollFork(recentBlock);

        assertEq(block.number, recentBlock);
    }

    function testCanSetForkOldBlockNumber() public {
        vm.selectFork(binanceFork);
        vm.rollFork(oldBlock);

        assertEq(block.number, oldBlock);
    }

    function testContractWithFork() public {
        vm.selectFork(binanceFork);
        vm.rollFork(oldBlock);

        SimpleStorageContract simple = new SimpleStorageContract();
        simple.set(100);
        assertEq(simple.value(), 100);
    }

    function testAccountBalanceWithFork() public {
        vm.selectFork(binanceFork);
        vm.rollFork(oldBlock);
        assertEq(usdc.balance, 0);
    }

    function testStorageSlotWithFork() public {
        vm.selectFork(binanceFork);
        vm.rollFork(oldBlock);

        bytes32 slot = vm.load(usdc, 0);
        assertNotEq(slot, 0);
    }
}

contract SimpleStorageContract {
    uint256 public value;

    function set(uint256 _value) public {
        value = _value;
    }
}
