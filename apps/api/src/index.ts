import { Hono } from "hono";
import { categories, pages, products } from "./routes";

const app = new Hono<{ Bindings: CloudflareBindings }>().basePath("/api");

app.route("/pages", pages);
app.route("/categories", categories);
app.route("/products", products);

export default app;
