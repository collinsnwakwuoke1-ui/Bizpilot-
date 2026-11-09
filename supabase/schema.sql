create extension if not exists pgcrypto;

create table if not exists public.businesses (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  slug text unique,
  description text default '',
  instagram text default '',
  facebook text default '',
  whatsapp text default '',
  created_at timestamptz not null default now()
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  business_id uuid not null references public.businesses(id) on delete cascade,
  name text not null,
  sku text not null,
  category text default '',
  quantity integer not null default 0 check (quantity >= 0),
  price numeric(12,2) not null default 0 check (price >= 0),
  cost numeric(12,2) not null default 0 check (cost >= 0),
  image_url text,
  created_at timestamptz not null default now(),
  unique (business_id, sku)
);

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  business_id uuid not null references public.businesses(id) on delete cascade,
  customer_name text not null,
  customer_email text,
  customer_phone text,
  items jsonb not null default '[]'::jsonb,
  total numeric(12,2) not null default 0 check (total >= 0),
  status text not null default 'pending' check (status in ('pending','confirmed','processing','shipped','completed','cancelled')),
  created_at timestamptz not null default now()
);

alter table public.businesses enable row level security;
alter table public.products enable row level security;
alter table public.orders enable row level security;

create policy "Owners manage their businesses"
on public.businesses for all to authenticated
using (owner_id = auth.uid())
with check (owner_id = auth.uid());

create policy "Owners manage products in their businesses"
on public.products for all to authenticated
using (exists (select 1 from public.businesses b where b.id = business_id and b.owner_id = auth.uid()))
with check (exists (select 1 from public.businesses b where b.id = business_id and b.owner_id = auth.uid()));

create policy "Owners view and manage orders"
on public.orders for all to authenticated
using (exists (select 1 from public.businesses b where b.id = business_id and b.owner_id = auth.uid()))
with check (exists (select 1 from public.businesses b where b.id = business_id and b.owner_id = auth.uid()));

-- Public shop browsing and order submission are intentionally not enabled here.
-- Add a validated Edge Function with rate limiting before exposing anonymous checkout.
