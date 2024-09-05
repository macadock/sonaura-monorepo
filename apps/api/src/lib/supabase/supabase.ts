import type { Database } from "@repo/supabase";
import { SupabaseClient } from "@supabase/supabase-js";
import type { Context } from "hono";

type ContextWithBindings = Context<{ Bindings: CloudflareBindings }>;

export const getSupabaseClient = (context: ContextWithBindings) => {
	const supabaseUrl = context.env.SUPABASE_URL;
	const supabaseAnonKey = context.env.SUPABASE_ANON_KEY;
	return new SupabaseClient<Database>(supabaseUrl, supabaseAnonKey);
};
