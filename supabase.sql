-- Conecta Serviços: banco online compartilhado para o PWA.
-- No Supabase: SQL Editor > New query > cole tudo e execute.

create table if not exists public.app_state (
  id bigint primary key,
  state jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

drop policy if exists "app_state_select" on public.app_state;
drop policy if exists "app_state_insert" on public.app_state;
drop policy if exists "app_state_update" on public.app_state;

-- ATENÇÃO: estas políticas deixam o estado do aplicativo acessível pela chave anon.
-- Elas são adequadas apenas para a versão inicial/demonstração. Para produção,
-- migre a autenticação para Supabase Auth e restrinja o painel ADM.
create policy "app_state_select" on public.app_state for select to anon using (true);
create policy "app_state_insert" on public.app_state for insert to anon with check (true);
create policy "app_state_update" on public.app_state for update to anon using (true) with check (true);

insert into public.app_state (id,state)
values (1, '{"session":null,"users":[],"requests":[],"payments":[],"settings":{"planPrice":4.99}}'::jsonb)
on conflict (id) do nothing;
