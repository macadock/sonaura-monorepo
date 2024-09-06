import { Hono } from "hono";
import { getSupabaseClient } from "../../lib/supabase";

export const products = new Hono<{ Bindings: CloudflareBindings }>();

products.get("/", async (c) => {
	const supabase = getSupabaseClient(c);

	const { data, error } = await supabase.from("products").select("*");
	if (error) {
		return c.json({ error: error.message }, { status: 500 });
	}
	return c.json(data);
});
