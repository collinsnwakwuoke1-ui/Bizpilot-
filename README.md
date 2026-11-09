# BizPilot

BizPilot is a web app for small businesses, focused on AI inventory management, an online shop, marketing and an AI business assistant.

## Included workflows

1. Create an account and set up a business workspace with a business type and description.
2. Add products with SKU, category, purchase cost, selling price, quantity and low-stock threshold.
3. Track inventory levels and review low-stock alerts.
4. Publish selected products to a public shop and add social media contact details.
5. Receive customer orders through the public storefront; order submission validates the current product prices and stock on the server and deducts stock atomically.
6. Manage online order status from pending through fulfilment.
7. Generate channel-specific marketing content using the Supabase `generate-marketing` Edge Function.
8. Ask the BizPilot AI assistant for data-grounded inventory and business recommendations.

## Supabase project

This frontend is connected to the BizPilot Supabase project. Browser code uses the public publishable key only. Row Level Security protects workspace data.

Database additions were applied to the connected Supabase project:
- Business type, business description, public shop slug/status and social handles.
- Product shop visibility and image URL fields.
- Secure `store_orders` table.
- `create_business_workspace` onboarding RPC.
- `submit_store_order` server-side order RPC, callable only by service_role.

Deployed Edge Functions:
- `generate-marketing` (existing AI marketing integration)
- `bizpilot-assistant` (authenticated business assistant)
- `public-store` (public shop read and customer order submission)

## Local development

1. Install Node.js.
2. Run `npm install`.
3. Copy `.env.example` to `.env` if you want to override the built-in Supabase URL/key.
4. Run `npm run dev`.

## Required Supabase Edge Function secrets

Check Supabase Dashboard → Edge Functions → Secrets:
- `OPENAI_API_KEY` — required for live AI marketing and the assistant.
- `SUPABASE_SERVICE_ROLE_KEY` — needed by the public-store function (server-side only; never put it in browser code).
- `APP_ORIGIN` — set to the exact deployed app origin for the AI functions' CORS response.

Supabase automatically provides project URL and API key environment variables to deployed functions. Do not place any server-side secret in a frontend `.env` file or GitHub.

## Cloudflare Pages

Build command: `npm run build`

Build output directory: `dist`

Set the following Cloudflare Pages environment variables if overriding the built-in public values:
- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_PUBLISHABLE_KEY`

## Important production checks

- Verify that OpenAI secrets are configured before using AI features.
- Configure `APP_ORIGIN` to the exact production domain and tighten the public-store CORS allowlist to that domain before public launch.
- Add rate limiting / bot protection to public order intake before promoting the shop widely.
- Payment checkout is not yet connected to online store orders. Orders are submitted as pending and require manual confirmation.
- Image generation and automatic social publishing are not yet implemented; marketing currently generates text.
- Run end-to-end tests with a real user, product, storefront and order before launch.
