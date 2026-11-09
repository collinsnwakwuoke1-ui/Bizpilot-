import { createClient } from "@supabase/supabase-js";

// Publishable key is designed for browser use. Row Level Security protects all data.
// Never put a Supabase secret/service-role key or an OpenAI key in this file.
export const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL || "https://jjnrxlapobknpihoxwnn.supabase.co";
const SUPABASE_KEY = import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY || import.meta.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_RIV_uyxvF3b1UFeLaSZJgw_dD_o65WV";
export const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
