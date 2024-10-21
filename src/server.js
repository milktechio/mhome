// server.js
import express from "express";
import cors from "cors";
import votingRoutes from "./routes/votingRoutes.js";

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

app.use("/", votingRoutes);

export default app;
