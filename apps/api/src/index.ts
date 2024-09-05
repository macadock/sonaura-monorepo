import { Hono } from "hono";
import { pages } from "./routes";

const app = new Hono<{ Bindings: CloudflareBindings }>().basePath("/api");

app.route("/pages", pages);

// eslint-disable-next-line import/no-default-export
export default app;
