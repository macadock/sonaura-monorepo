import { Hono } from "hono";
import { getSupabaseClient } from "../../lib/supabase";

export const pages = new Hono<{ Bindings: CloudflareBindings }>();

pages.get("/", async (c) => {
	const supabase = getSupabaseClient(c);

	const { data, error } = await supabase.from("pages").select("*");
	if (error) return c.text(error.message);
	return c.json(data);
});
