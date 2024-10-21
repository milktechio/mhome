import { Router } from "express";
import { VotingController } from "../controllers/votingController.js";

const router = Router();

router.post("/say", VotingController.say);
router.post("/register", VotingController.register);
router.delete("/delete", VotingController.deleteUser);
router.get("/getUser", VotingController.getUser);

export default router;
