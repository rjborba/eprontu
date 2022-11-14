import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";
import { EProntu } from "../typechain-types";

const MOCK_ID = "123";
const MOCK_NAME = "Rodrigo José Borba Fernande";

describe("EProntu", function () {
  const addRodrigoPatient = async (
    eProntu: EProntu,
    patientAddress: string
  ) => {
    const recip = await eProntu.addPatient(
      MOCK_ID,
      MOCK_NAME,
      "02/02/1994",
      { bloodType: "O", factore: 1 },
      patientAddress
    );

    await recip.wait(1);
  };

  async function deploy() {
    const [owner, otherAccount] = await ethers.getSigners();

    const EProntu = await ethers.getContractFactory("EProntu");
    const eProntu = await EProntu.deploy();

    return { eProntu, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Deployment sanity", async function () {
      const { eProntu } = await loadFixture(deploy);

      expect(eProntu).not.to.be.null;
    });

    it("Add Patient", async function () {
      const { eProntu, otherAccount } = await loadFixture(deploy);
      await addRodrigoPatient(eProntu, otherAccount.address);
    });

    it("Should NOT allow access to a not authorized address", async () => {
      const { eProntu, owner, otherAccount } = await loadFixture(deploy);
      await addRodrigoPatient(eProntu, otherAccount.address);

      const EProntuPatientAddress = await eProntu.getPatient(MOCK_ID);
      const eProntuPatient = await ethers.getContractAt(
        "EProntuPatient",
        EProntuPatientAddress,
        owner
      );

      await expect(eProntuPatient.getSensitiveData()).to.be.rejectedWith(
        "Unauthorized"
      );
    });

    it("Authorize access", async () => {
      const { eProntu, owner, otherAccount } = await loadFixture(deploy);
      await addRodrigoPatient(eProntu, otherAccount.address);

      const EProntuPatientAddress = await eProntu.getPatient(MOCK_ID);
      const eProntuPatient = await ethers.getContractAt(
        "EProntuPatient",
        EProntuPatientAddress,
        owner
      );

      await expect(eProntuPatient.getSensitiveData()).to.be.rejectedWith(
        "Unauthorized"
      );

      const eProntuPatientOwner = await ethers.getContractAt(
        "EProntuPatient",
        EProntuPatientAddress,
        otherAccount
      );

      await eProntuPatientOwner.authorizeAccess(owner.address);

      await eProntuPatient.getSensitiveData();
    });

    it("Unauthorize access", async () => {
      const { eProntu, owner, otherAccount } = await loadFixture(deploy);
      await addRodrigoPatient(eProntu, otherAccount.address);

      const EProntuPatientAddress = await eProntu.getPatient(MOCK_ID);
      const eProntuPatient = await ethers.getContractAt(
        "EProntuPatient",
        EProntuPatientAddress,
        owner
      );

      await expect(eProntuPatient.getSensitiveData()).to.be.rejectedWith(
        "Unauthorized"
      );

      const eProntuPatientOwner = await ethers.getContractAt(
        "EProntuPatient",
        EProntuPatientAddress,
        otherAccount
      );

      await eProntuPatientOwner.authorizeAccess(owner.address);

      await eProntuPatient.getSensitiveData();

      await eProntuPatientOwner.unauthorizeAccess(owner.address);

      await expect(eProntuPatient.getSensitiveData()).to.be.rejectedWith(
        "Unauthorized"
      );
    });
  });
});
