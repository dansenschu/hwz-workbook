create extension if not exists pgcrypto;

create table if not exists public.workbook_submissions (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  course_id text not null default 'hwz-ai-operating-model',
  participant_name text,
  company text,
  role text,
  maturity_scores jsonb not null default '{}'::jsonb,
  tensions jsonb not null default '{}'::jsonb,
  answers jsonb not null default '{}'::jsonb,
  page_url text,
  user_agent text,
  app_version text
);

alter table public.workbook_submissions enable row level security;

drop policy if exists "Allow anonymous workbook submissions" on public.workbook_submissions;
create policy "Allow anonymous workbook submissions"
on public.workbook_submissions
for insert
to anon
with check (true);

grant usage on schema public to anon;
grant insert on table public.workbook_submissions to anon;
