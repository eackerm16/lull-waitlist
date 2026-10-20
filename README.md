# lull. Calm Cover waitlist

A static page (no build step). Sign-ups go straight into a Supabase table.

## 1. Supabase (5 minutes)
1. Create a project at supabase.com.
2. SQL Editor → New query → paste `supabase.sql` → Run.
3. Project Settings → API: copy the **Project URL** and the **anon public** key into `config.js`.

The anon key is safe to publish. The table's security rules only let visitors add themselves; nobody can read the list from the website.

## 2. Vercel
Drag this `waitlist` folder into vercel.com/new (or `npx vercel` inside it). No framework, no build command.

## 3. Share with tracking
Add `?ref=` to the link so you can see who drove sign-ups:
`https://your-site.vercel.app/?ref=campus` or `?ref=creatorname`

## 4. Read the results (Supabase SQL Editor)
```sql
select count(*) from public.waitlist;
select shade, count(*) from public.waitlist group by shade order by 2 desc;   -- which 2–3 shades to launch
select source, count(*) from public.waitlist group by source order by 2 desc; -- which creator or group works
```
