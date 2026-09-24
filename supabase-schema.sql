-- CONECTA SERVIÇOS - SUPABASE
-- Execute este arquivo no SQL Editor do Supabase.
-- Depois crie seu primeiro usuário e altere a role dele para admin.

create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  email text,
  phone text,
  city text,
  role text not null default 'client' check (role in ('client','professional','admin')),
  status text not null default 'active' check (status in ('active','pending','suspended')),
  service_category text,
  subscription_until timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.service_requests (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references public.profiles(id) on delete cascade,
  professional_id uuid not null references public.profiles(id) on delete cascade,
  service text not null,
  description text not null,
  status text not null default 'pending' check (status in ('pending','accepted','rejected','completed','cancelled')),
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.service_requests enable row level security;

-- Função auxiliar para verificar administrador
create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

-- Profiles
drop policy if exists "profiles_select_authenticated" on public.profiles;
create policy "profiles_select_authenticated" on public.profiles
for select to authenticated using (true);

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own" on public.profiles
for insert to authenticated with check (id = auth.uid() or public.is_admin());

drop policy if exists "profiles_update_own_or_admin" on public.profiles;
create policy "profiles_update_own_or_admin" on public.profiles
for update to authenticated using (id = auth.uid() or public.is_admin())
with check (id = auth.uid() or public.is_admin());

-- Requests
drop policy if exists "requests_select_related" on public.service_requests;
create policy "requests_select_related" on public.service_requests
for select to authenticated using (client_id = auth.uid() or professional_id = auth.uid() or public.is_admin());

drop policy if exists "requests_insert_client" on public.service_requests;
create policy "requests_insert_client" on public.service_requests
for insert to authenticated with check (client_id = auth.uid());

drop policy if exists "requests_update_related" on public.service_requests;
create policy "requests_update_related" on public.service_requests
for update to authenticated using (professional_id = auth.uid() or client_id = auth.uid() or public.is_admin())
with check (professional_id = auth.uid() or client_id = auth.uid() or public.is_admin());

-- Crie um usuário pelo painel Authentication > Users.
-- Depois execute, substituindo o e-mail:
-- update public.profiles set role='admin' where email='SEU_EMAIL_ADMIN@EMAIL.COM';

-- IMPORTANTE:
-- A confirmação do pagamento é manual. O ADM deve conferir o Pix fora do sistema
-- e clicar em "Confirmar pagamento e liberar 30 dias" no painel administrativo.
