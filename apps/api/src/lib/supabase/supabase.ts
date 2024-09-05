import type { Context } from "hono";
import { SupabaseClient } from "@supabase/supabase-js";
import type { Database } from "@repo/supabase";

type ContextWithBindings = Context<{ Bindings: CloudflareBindings }>

export const getSupabaseClient = (context: ContextWithBindings) => {
  const supabaseUrl = context.env.SUPABASE_URL
  const supabaseAnonKey = context.env.SUPABASE_ANON_KEY
  return new SupabaseClient<Database>(supabaseUrl, supabaseAnonKey)
}