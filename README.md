Repro for https://github.com/foundry-rs/foundry/issues/4962

Create a .env file with the following content with the RPC url pointing to a non-archive node (for example, free ChainStack node).

```shell
BINANCE_RPC_URL=your_rpc_url
```

Run with `forge test --no-storage-caching`
