const main = async () => {
    const domainContractFactory = await hre.ethers.getContractFactory('Domains');
    const domainContract = await domainContractFactory.deploy("sith");
    await domainContract.deployed();
  
    console.log("Contract deployed to:", domainContract.address);
  
    let txn = await domainContract.register("priyansh",  {value: hre.ethers.utils.parseEther('0.04')});
    await txn.wait();
    console.log("Minted domain priyansh.sith");
  
    txn = await domainContract.setDark("priyansh", "I love the Death Star.");
    await txn.wait();
    console.log("Set plans for priyansh.sith");
  }
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();