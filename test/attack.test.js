const { ethers } = require("hardhat")
const { expect } = require("chai")
const { utils, BigNumber } = require("ethers")
const { Contract } = require("hardhat/internal/hardhat-network/stack-traces/model")

describe("Deploy randomNumber hack", () => {
    it("Should be able to guess the exact number", async () => {
        // Deploy game contract
        const gameContractFactory = await ethers.getContractFactory("Game")
        const gameContract = await gameContractFactory.deploy()
        await gameContract.deployed()
        console.log(`Deployed game contract with ${gameContract.address} address`)

        // Now deploy the attack contract
        const attackContractFactory = await ethers.getContractFactory("Attack")
        const attackContract = await attackContractFactory.deploy(gameContract.address)
        console.log(`Deployed game attack contract with ${attackContract.address} address`)

        // Attack the game
        const attackTransaction = await attackContract.attack()
        await attackTransaction.wait()

        const gameBalance = await gameContract.getBalance()
        // balance game should be 0
        expect(gameBalance).to.equal(BigNumber.from("0"))
    })
})
