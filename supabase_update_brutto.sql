-- ============================================================
--  AYLI BUCHHALTUNG – Update für Brutto-Eingabe & "Gemischt"
--  In Supabase unter SQL Editor ausführen (nur einmal nötig).
-- ============================================================

-- 1) Neue Spalte für den tatsächlich bezahlten Betrag (Brutto)
alter table public.transactions
  add column if not exists brutto numeric(12,2);

-- 2) MwSt-Satz darf jetzt auch -1 (= "Gemischt: 7% + 19%") sein.
--    Alte Regel entfernen, neue Regel setzen.
alter table public.transactions
  drop constraint if exists transactions_vat_check;

alter table public.transactions
  add constraint transactions_vat_check
  check (vat in (-1, 0, 7, 19));

-- ============================================================
--  FERTIG. "Success. No rows returned" = alles korrekt.
--  Hinweis: vat = -1 bedeutet "Gemischt" – die Aufteilung in
--  7% und 19% erfolgt später automatisch anhand des Kassenbons.
-- ============================================================
