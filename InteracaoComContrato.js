const Web3 = require('web3');
const web3 = new Web3('https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID'); // Use your Infura project ID

const governanceAbi = [/* ABI of Governance contract */];
const governanceAddress = '0xYourGovernanceContractAddress';
const governanceContract = new web3.eth.Contract(governanceAbi, governanceAddress);

const tokenAbi = [/* ABI of GovernanceToken contract */];
const tokenAddress = '0xYourTokenContractAddress';
const tokenContract = new web3.eth.Contract(tokenAbi, tokenAddress);

const account = '0xYourEthereumAddress';
const privateKey = 'YourPrivateKey';

async function createProposal(description) {
    const data = governanceContract.methods.createProposal(description).encodeABI();
    const tx = {
        to: governanceAddress,
        data,
        gas: 2000000
    };

    const signedTx = await web3.eth.accounts.signTransaction(tx, privateKey);
    const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
    console.log('Proposal created:', receipt);
}

async function vote(proposalId) {
    const data = governanceContract.methods.vote(proposalId).encodeABI();
    const tx = {
        to: governanceAddress,
        data,
        gas: 2000000
    };

    const signedTx = await web3.eth.accounts.signTransaction(tx, privateKey);
    const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
    console.log('Voted:', receipt);
}

async function executeProposal(proposalId) {
    const data = governanceContract.methods.executeProposal(proposalId).encodeABI();
    const tx = {
        to: governanceAddress,
        data,
        gas: 2000000
    };

    const signedTx = await web3.eth.accounts.signTransaction(tx, privateKey);
    const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
    console.log('Proposal executed:', receipt);
}

// Example usage
createProposal('Plant 1000 trees');
vote(1);
executeProposal(1);
