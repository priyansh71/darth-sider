const { expect } = require("chai");

describe("Domain contract", () => {
  let domainContractFactory;
  let domainContract;
  let txn;

  beforeEach(async () => {
      domainContractFactory = await hre.ethers.getContractFactory('Domains');
      domainContract = await domainContractFactory.deploy("sith");
      await domainContract.deployed();


  });

    it("Should ensure that msg.sender and mapping output are the same.", async () => {
      txn = await domainContract.register("vader",  {
        value: hre.ethers.utils.parseEther('0.55')
      });
      await txn.wait();
        let [owner] = await hre.ethers.getSigners();
        const domainOwner = await domainContract.getAddress("vader");
        expect(domainOwner).to.equal(owner.address);

    });

    it("Should not help change someone else's vow.", async () => {
      txn = await domainContract.register("vader",  {
        value: hre.ethers.utils.parseEther('0.55')
      });
      await txn.wait();
        let [_, randomPerson] = await hre.ethers.getSigners();
        try {
            txn = await domainContract.connect(randomPerson).setDark("vader", "malicious");
        }
        catch(error){
            expect(error.message).to.equal(
              "VM Exception while processing transaction: reverted with custom error 'Unauthorized()'"
            )
        }
    });

    it("Should remember caller's vows to become a sith.", async () => {
      txn = await domainContract.register("vader",  {
        value: hre.ethers.utils.parseEther('0.55')
      });
      await txn.wait();
      const why = "I love the death star.";
      txn = await domainContract.setDark("vader", why);
      await txn.wait();
      const darkSocials = await domainContract.getDark("vader");

      expect(darkSocials).to.equal(why);
    });

    it("Should not mint jedis as .sith.",async () => {
      try {
          txn = await domainContract.register("jedi",  {
            value: hre.ethers.utils.parseEther('0.3')
          });
        }
      catch(error){
        expect(error.message).to.equal(
          `VM Exception while processing transaction: reverted with custom error 'InvalidName("jedi")'`
        )
      }

    })
      
});