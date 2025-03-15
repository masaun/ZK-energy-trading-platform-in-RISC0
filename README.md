# ZK Energy Trading Platform ⚡️

## Tech stack

- `ZK circuit`: Written in [`zkVM / Boundless`]() powered by [RISC Zero]()) 
- Smart Contract: Written in Solidity (Framework: Foundry)
- Blockchain: [`Ethereum Sepolia`]() (Testnet)

<br>

## Actors


<br>

## Overview

- This is the ZK (Zero-Knowledge) based Energy Trading Platform in `zkVM / Boundless` powered by `RISC Zero`, which is the Zero-Knowledge based Energy Trading Platform that consists of the ZK programs (ZK circuits) and the smart contracts.

- Through trading energy on this platform, each actor would get the following merits: 
  - an energy producer ('s Smart Meter) can list a sell order of a specified amount of energy **without revealing** a **`whole` amount of energy available** in the producer's energy charger.

  - an energy buyer ('s Smart Meter) can buy their desired-amount of energy, which is validated and a `proof` is attested via a ZK circuit.



<br>

## Deployed-addresses on Ethereum Sepolia testnet

<br>

## Installations

### Install the cargo packages

- 1/ Install the Cargo packages
```bash
cargo build
```

- 2/ Within the `contracts/test/Elf.sol`, the **path** (`SMART_METER_PATH`) should be fixed like this:
```solidity
library Elf {
    string public constant SMART_METER_PATH =
        "../../target/riscv-guest/guests/smart-meter/riscv32im-risc0-zkvm-elf/release/smart-meter";
}
```

<br>

### Compile the smart contracts

- Compile the smart contracts
```bash
forge build
```

<br>

### Running the test of the guest program

- Run the test of the "smart-meter" guest program
```bash
sh guests/tests/runningGuestProgram_smart-meter.sh
```

<br>

### Deploy the SCs
- Deploy SCs
```bash
sh ./contracts/scripts/runningScript_Deploy.sh
```

<br>

### Running the Test of SCs on Ethereum Sepolia testnet
- Run the `./contracts/test/EnergyAggregator.t.sol`
```bash
sh ./contracts/test/runningTest_EnergyAggregator.sh
```

<br>

### Running the Apps
- Run the `./apps/src/main.rs`
```bash
sh ./apps/runningApp_main.sh
```



<br>

<hr>

# Boundless Foundry Template

This template serves as a starting point for developing an application with verifiable compute provided by [Boundless][boundless-homepage].
It is built around a simple smart contract, `EvenNumber`, and its associated RISC Zero guest, `is-even`.

## Build

To build the example run:

```bash
# Populate the `./lib` submodule dependencies
git submodule update --init --recursive
cargo build
forge build
```

## Test

Test the Solidity smart contracts with:

```bash
forge test -vvv
```

Test the Rust code including the guest with:

```bash
cargo test
```

## Deploy to Testnet

### Set up your environment

Export your Sepolia testnet wallet private key as an environment variable:

```bash
export WALLET_PRIVATE_KEY="YOUR_WALLET_PRIVATE_KEY"
```

To allow provers to access your zkVM guest binary, it must be uploaded to a public URL. For this example we will upload to IPFS using Pinata. Pinata has a free tier with plenty of quota to get started. Sign up at [[Pinata](https://pinata.cloud/)](https://pinata.cloud/), generate an API key, and set the JWT as an environment variable:

```bash
export PINATA_JWT="YOUR_PINATA_JWT"
```

A [`.env`](./.env) file is provided with the Boundless contract deployment information for Sepolia.
The example app reads from this `.env` file automatically.

### Deploy the contract

To deploy the `EvenNumber` contract run:

```bash
. ./.env # load the environment variables from the .env file for deployment
forge script contracts/scripts/Deploy.s.sol --rpc-url ${RPC_URL:?} --broadcast -vv
```

Save the `EvenNumber` contract address to an env variable:

<!-- TODO: Update me -->

```bash
# First contract deployed and top of logs is EvenNumber
export EVEN_NUMBER_ADDRESS=#COPY EVEN NUMBER ADDRESS FROM DEPLOY LOGS
```

> You can also use the following command to set the contract address if you have [`jq`][jq] installed:
>
> ```bash
> export EVEN_NUMBER_ADDRESS=$(jq -re '.transactions[] | select(.contractName == "EvenNumber") | .contractAddress' ./broadcast/Deploy.s.sol/11155111/run-latest.json)
> ```

### Run the example

The [example app](apps/src/main.rs) will upload your zkVM guest to IPFS, submit a request to the market for a proof that "4" is an even number, wait for the request to be fulfilled, and then submit that proof to the EvenNumber contract, setting the value to "4".


To run the example:

```bash
RUST_LOG=info cargo run --bin app -- --even-number-address ${EVEN_NUMBER_ADDRESS:?} --number 4
```

[jq]: https://jqlang.github.io/jq/
[boundless-homepage]: https://beboundless.xyz
[sepolia]: https://ethereum.org/en/developers/docs/networks/#sepolia
