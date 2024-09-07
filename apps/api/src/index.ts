import { Hono } from "hono";
import { categories, installations, pages, products, shops } from "./routes";

const app = new Hono<{ Bindings: CloudflareBindings }>().basePath("/api");

app.route("/pages", pages);
app.route("/categories", categories);
app.route("/products", products);
app.route("/installations", installations);
app.route("/shops", shops);

export default app;
