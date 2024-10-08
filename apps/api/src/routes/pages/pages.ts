import { Hono } from "hono";
import { getSupabaseClient } from "../../lib/supabase";

export const pages = new Hono<{ Bindings: CloudflareBindings }>();

pages.get("/", async (c) => {
	const supabase = getSupabaseClient(c);

	const { data, error } = await supabase.from("pages").select("*");
	if (error) {
		return c.json({ error: error.message }, { status: 500 });
	}
	return c.json(data);
});
