import { HttpAgent, Actor } from "@dfinity/agent";
import { idlFactory } from "../../contracts/.dfx/local/canisters/main/service.did.js";

export class VotingController {
  constructor() {}

  static say = async (req, res) => {
    const { message } = req.body;

    const agent = new HttpAgent({ host: "http://127.0.0.1:4943" });
    agent.fetchRootKey();

    const servicesCanister = Actor.createActor(idlFactory, {
      agent,
      canisterId: "bkyz2-fmaaa-aaaaa-qaaaq-cai", // Reemplaza con tu Canister ID
    });

    try {
      // Llama al método saySomething
      const result = await servicesCanister.say(message);

      res.status(200).json({ result });
    } catch (error) {
      console.error("Error al llamar a say:", error);
      res.status(500).json({ error: "Error al llamar al canister" });
    }
  };

  static register = async (req, res) => {
    const agent = new HttpAgent({ host: "http://127.0.0.1:4943" });
    agent.fetchRootKey();

    const servicesCanister = Actor.createActor(idlFactory, {
      agent,
      canisterId: "bkyz2-fmaaa-aaaaa-qaaaq-cai", // Reemplaza con tu Canister ID
    });

    try {
      const result = await servicesCanister.register();

      res.status(200).json({ result });
    } catch (error) {
      res.status(500).json({ error: "Error al registrar al usuario" });
    }
  };

  static deleteUser = async (req, res) => {
    const agent = new HttpAgent({ host: "http://127.0.0.1:4943" });
    agent.fetchRootKey();

    const servicesCanister = Actor.createActor(idlFactory, {
      agent,
      canisterId: "bkyz2-fmaaa-aaaaa-qaaaq-cai", // Reemplaza con tu Canister ID
    });

    try {
      const result = await servicesCanister.removeUser();
      res.status(200).json({ result });
    } catch (error) {
      res.status(500).json({ error: "Error eliminando usuario" });
    }
  };

  static getUser = async (req, res) => {
    const agent = new HttpAgent({ host: "http://127.0.0.1:4943" });
    agent.fetchRootKey();

    const servicesCanister = Actor.createActor(idlFactory, {
      agent,
      canisterId: "bkyz2-fmaaa-aaaaa-qaaaq-cai", // Reemplaza con tu Canister ID
    });

    try {
      const result = await servicesCanister.getUser();
      res.status(200).json({ result });
    } catch (error) {
      res.status(500).json({ error: "Error viendo usuarios" });
    }
  };
}
