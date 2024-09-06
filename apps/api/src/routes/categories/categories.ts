import { Hono } from "hono";
import { getSupabaseClient } from "../../lib/supabase";

export const categories = new Hono<{ Bindings: CloudflareBindings }>();

categories.get("/", async (c) => {
	const supabase = getSupabaseClient(c);

	const { data, error } = await supabase.from("categories").select("*");
	if (error) {
		return c.json({ error: error.message }, { status: 500 });
	}
	return c.json(data);
});
