-- ============================================================
--  AYLI BUCHHALTUNG – Datenbank-Schema für Supabase
--  Passt zur bestehenden App-Struktur und ist vorbereitet für:
--  Mehrbenutzer, Notizen, Belege/OCR, Synchronisation
-- ============================================================

-- 1) Alte Tabelle entfernen (falls leer angelegt), sauber neu aufbauen
drop table if exists public.transactions cascade;

-- 2) Haupttabelle: Buchungen
create table public.transactions (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null default auth.uid() references auth.users(id) on delete cascade,

  -- Kernfelder (entsprechen deiner App)
  scope         text not null default 'betrieb'   check (scope in ('betrieb','privat')),
  type          text not null default 'expense'   check (type in ('income','expense')),
  description   text not null,
  date          date not null,
  category      text not null,
  net           numeric(12,2) not null default 0,   -- Netto-Betrag
  vat           integer not null default 19         check (vat in (0,7,19)),

  -- Erweiterungen
  note          text,                 -- Notizen
  merchant      text,                 -- Händler (für OCR später)
  photo_path    text,                 -- Verweis auf Beleg in Supabase Storage

  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

-- 3) Indizes für schnelle Suche und Filter
create index idx_tx_user   on public.transactions(user_id);
create index idx_tx_date   on public.transactions(date);
create index idx_tx_scope  on public.transactions(scope);
create index idx_tx_type   on public.transactions(type);

-- 4) updated_at automatisch aktualisieren
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end $$;

create trigger trg_tx_updated
  before update on public.transactions
  for each row execute function public.set_updated_at();

-- ============================================================
--  5) SICHERHEIT: Row Level Security (RLS)
--     Jeder Benutzer sieht und ändert nur seine eigenen Daten.
--     (Vorbereitung für Mehrbenutzer – Freigaben kommen später.)
-- ============================================================
alter table public.transactions enable row level security;

create policy "eigene Buchungen lesen"
  on public.transactions for select
  using ( auth.uid() = user_id );

create policy "eigene Buchungen einfügen"
  on public.transactions for insert
  with check ( auth.uid() = user_id );

create policy "eigene Buchungen ändern"
  on public.transactions for update
  using ( auth.uid() = user_id )
  with check ( auth.uid() = user_id );

create policy "eigene Buchungen löschen"
  on public.transactions for delete
  using ( auth.uid() = user_id );

-- ============================================================
--  FERTIG.
--  Nach dem Ausführen: "Success. No rows returned" = alles korrekt.
-- ============================================================
