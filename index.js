const Caver = require('caver-js');
const caver = new Caver('https://cypress.fautor.app/archive');
const artifacts = require('./contracts/abi.json');

const Contract = '0x252A59642C494Db5D3645BCa65a36E70e50bf85e';

async function main() {
    try {
        const myContract = new caver.contract.create(artifacts.abi, Contract);
        const totalSupply = await myContract.call('totalSupply');
        for(let i=0; i<totalSupply; i++){
            const data = await myContract.call('dogeSounds', i);
            console.log(data);
        }
    } catch (e){
        console.log(e);
    }

}
main();