import { Hono } from "hono";
import { getSupabaseClient } from "../../lib/supabase";

export const shops = new Hono<{ Bindings: CloudflareBindings }>();

shops.get("/", async (c) => {
	const supabase = getSupabaseClient(c);

	const { data, error } = await supabase.from("shops").select("*");
	if (error) {
		return c.json({ error: error.message }, { status: 500 });
	}
	return c.json(data);
});
