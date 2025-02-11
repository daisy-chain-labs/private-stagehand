import { default as DefaultStagehandConfig } from "@/stagehand.config";
import type { ConstructorParams } from "@/dist";
import dotenv from "dotenv";
import path from "path";

// Load environment variables from the root .env file
dotenv.config({ path: path.resolve(__dirname, "../../.env") });

// Set default ANON_ENV to development if not set
if (!process.env.ANON_ENV) {
  process.env.ANON_ENV = "development";
}

const StagehandConfig: ConstructorParams = {
  ...DefaultStagehandConfig,
  env: "LOCAL" /* Environment to run Stagehand in */,
  verbose: 1 /* Logging verbosity level (0=quiet, 1=normal, 2=verbose) */,
  headless: true /* Run browser in headless mode */,
  browserbaseSessionCreateParams: {
    projectId: process.env.BROWSERBASE_PROJECT_ID,
  },
  enableCaching: false /* Enable caching functionality */,
};
export default StagehandConfig;
