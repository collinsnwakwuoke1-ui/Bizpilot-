# BizPilot

BizPilot is a web app starter focused on three modules:

- **AI inventory workspace:** product catalogue, stock quantities, low-stock warnings and stock-cost overview.
- **Online shop:** storefront profile and product preview, including social contact details.
- **Marketing:** campaign-copy builder and downloadable promotional text.

## Run locally

1. Install Node.js.
2. Run `npm install`.
3. Run `npm run dev`.
4. Open the local URL printed by Vite.

## Supabase foundation

The initial database schema is in `supabase/schema.sql`. Apply it in the Supabase SQL Editor when setting up the backend. The frontend currently uses sample in-browser data; database persistence and authentication still need to be connected and tested.

## Important launch checklist

- Connect authentication and all inventory/shop screens to Supabase.
- Create a secure public storefront and order-submission Edge Function. Do not make the orders table publicly writable.
- Connect an AI provider through a server-side Edge Function; never expose an AI secret key in browser code.
- Add image generation/storage for e-flyers and test image rights and file limits.
- Add checkout/payment integration only after the order workflow is secured.
- Configure environment variables in the hosting provider and test a production build.

**Status:** UI starter scaffold, not yet production-ready. The marketing copy generator currently uses a local template and is not live AI.
