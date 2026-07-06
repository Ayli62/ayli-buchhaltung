-- ============================================================
--  AYLI BUCHHALTUNG – Update: Zahlungsart (Bar / Karte)
--  In Supabase unter SQL Editor ausführen (nur einmal nötig).
-- ============================================================

-- Neue Spalte für die Zahlungsart. Standardwert: 'Bar'.
alter table public.transactions
  add column if not exists payment text not null default 'Bar'
  check (payment in ('Bar','Karte'));

-- ============================================================
--  FERTIG. "Success. No rows returned" = alles korrekt.
--  Bestehende Buchungen erhalten automatisch 'Bar' als Wert.
-- ============================================================
