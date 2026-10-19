create extension if not exists pgcrypto;

create table if not exists public.prizes (
  id bigint generated always as identity primary key,
  label text not null unique,
  discount_percent integer not null check (discount_percent between 10 and 100),
  weight integer not null check (weight > 0),
  active boolean not null default true
);

insert into public.prizes (label, discount_percent, weight) values
 ('10% DE DESCUENTO',10,40),
 ('15% DE DESCUENTO',15,25),
 ('20% DE DESCUENTO',20,18),
 ('30% DE DESCUENTO',30,10),
 ('50% DE DESCUENTO',50,5),
 ('100% DE DESCUENTO',100,2)
on conflict (label) do update set discount_percent=excluded.discount_percent, weight=excluded.weight;

create table if not exists public.coupons (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references auth.users(id) on delete cascade,
  prize_id bigint not null references public.prizes(id),
  code text not null unique,
  created_at timestamptz not null default now(),
  expires_at timestamptz not null default (now() + interval '7 days'),
  redeemed_at timestamptz,
  redeemed_by text
);

alter table public.prizes enable row level security;
alter table public.coupons enable row level security;

-- No public table access: all prize issuance/redemption is done by server-side functions.
revoke all on public.prizes from anon, authenticated;
revoke all on public.coupons from anon, authenticated;

create index if not exists coupons_code_idx on public.coupons(code);
create index if not exists coupons_expires_at_idx on public.coupons(expires_at);
