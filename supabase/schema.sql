-- Schéma de départ pour une future synchronisation multi-appareils via Supabase.
-- À exécuter seulement après création d'un projet Supabase et ajout d'une authentification.
create extension if not exists pgcrypto;

create table if not exists public.events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  event_date date,
  location text,
  notes text not null default '',
  status text not null default 'active' check (status in ('active','archived')),
  created_at timestamptz not null default now(),
  started_at timestamptz not null default now(),
  ended_at timestamptz,
  updated_at timestamptz not null default now()
);

create table if not exists public.contacts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  event_id uuid references public.events(id) on delete set null,
  pseudo text not null,
  cosplay text not null default '',
  instagram_url text not null default '',
  photo_status text not null default 'todo' check (photo_status in ('todo','editing','sent','none')),
  tag_permission boolean not null default false,
  publish_permission boolean not null default false,
  notes text not null default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.events enable row level security;
alter table public.contacts enable row level security;

create policy "Users manage their own events"
  on public.events for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "Users manage their own contacts"
  on public.contacts for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create index if not exists events_user_date_idx on public.events(user_id, event_date desc);
create index if not exists contacts_user_pseudo_idx on public.contacts(user_id, pseudo);
create index if not exists contacts_event_id_idx on public.contacts(event_id);