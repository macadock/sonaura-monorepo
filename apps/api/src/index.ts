import { Hono } from "hono";
import { pages, categories } from "./routes";

const app = new Hono<{ Bindings: CloudflareBindings }>().basePath("/api");

app.route("/pages", pages);
app.route("/categories", categories);

// eslint-disable-next-line import/no-default-export
export default app;
