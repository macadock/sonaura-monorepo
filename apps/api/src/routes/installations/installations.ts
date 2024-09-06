import { Hono } from "hono";
import { getSupabaseClient } from "../../lib/supabase";

export const installations = new Hono<{ Bindings: CloudflareBindings }>();

installations.get("/", async (c) => {
	const supabase = getSupabaseClient(c);

	const { data, error } = await supabase.from("installations").select("*");
	if (error) {
		return c.json({ error: error.message }, { status: 500 });
	}
	return c.json(data);
});
