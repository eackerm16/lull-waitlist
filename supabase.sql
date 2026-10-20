-- lull. Calm Cover waitlist
-- Run once in Supabase: SQL Editor > New query > paste > Run.

create table if not exists public.waitlist (
  id          uuid primary key default gen_random_uuid(),
  email       text not null,
  first_name  text,
  shade       text,
  source      text,
  consent     boolean not null default false,
  created_at  timestamptz not null default now(),
  constraint waitlist_email_format check (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  constraint waitlist_email_length check (char_length(email) <= 254),
  constraint waitlist_name_length  check (first_name is null or char_length(first_name) <= 80),
  constraint waitlist_source_length check (source is null or char_length(source) <= 60),
  constraint waitlist_shade_value  check (shade is null or shade in ('pearl','linen','sand','amber','umber','onyx','unsure'))
);

-- One sign-up per email, ignoring capitals.
create unique index if not exists waitlist_email_unique on public.waitlist (lower(email));

-- Visitors can add themselves (with consent) but can never read, edit or delete the list.
alter table public.waitlist enable row level security;

drop policy if exists "Visitors can join the waitlist" on public.waitlist;
create policy "Visitors can join the waitlist"
  on public.waitlist for insert
  to anon
  with check (consent = true);

grant insert on public.waitlist to anon;

-- Handy views for the team (run in the SQL Editor; not reachable from the website):
-- select count(*) from public.waitlist;
-- select shade, count(*) from public.waitlist group by shade order by count(*) desc;
-- select source, count(*) from public.waitlist group by source order by count(*) desc;
