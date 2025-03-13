echo "Read the environment variables"
. ./.env # load the environment variables from the .env file for deployment

echo "Deploying the contract on Ethereum Sepolia testnet"
forge script contracts/scripts/Deploy.s.sol --rpc-url ${RPC_URL:?} --broadcast -vv