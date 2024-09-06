import { Hono } from "hono";
import { categories, pages } from "./routes";

const app = new Hono<{ Bindings: CloudflareBindings }>().basePath("/api");

app.route("/pages", pages);
app.route("/categories", categories);

export default app;
