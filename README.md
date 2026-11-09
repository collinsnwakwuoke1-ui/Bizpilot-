# BizPilot

AI-powered inventory, online shop and marketing workspace.

## Core modules
- Inventory and stock alerts
- Public storefront and customer orders
- Marketing campaign copy and e-flyer preparation

## Setup
1. Install dependencies with `npm install`.
2. Copy `.env.example` to `.env` and add your Supabase project URL and anon key.
3. Run `npm run dev`.
4. Apply `supabase/schema.sql` in the Supabase SQL Editor.

AI copy generation is currently a guided template workflow; connect a secure server-side AI provider before describing it as live AI. Public checkout/payment processing also requires a secure backend and payment integration.