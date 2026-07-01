# Ayli Buchhaltung

Eine mobile-first Buchhaltungs-App für Einnahmen & Ausgaben – Geschäft und Privat getrennt,
mit Belegen, Monats- und Jahresübersicht, Synchronisation über mehrere Geräte (Supabase)
und Installation als Web-App (PWA) über GitHub Pages.

---

## Dateien in diesem Projekt

- **index.html** – die komplette App (Hauptdatei, die GitHub Pages öffnet)
- **manifest.json** – macht die App installierbar (PWA)
- **service-worker.js** – ermöglicht Offline-Nutzung der App-Hülle
- **icon-192.png / icon-512.png** – App-Symbole für den Home-Bildschirm
- **supabase_setup.sql** – der Datenbank-Aufbau (einmalig in Supabase ausführen)

---

## Einrichtung in 3 Schritten

### 1. Supabase (Datenbank) – bereits erledigt
Die Tabelle `transactions` wurde mit `supabase_setup.sql` erstellt.
In der App sind die Zugangsdaten (Project URL + Publishable Key) bereits eingetragen.

Wichtig in Supabase unter **Authentication → Providers → Email**:
- "Email" muss aktiviert sein.
- "Confirm email" am Anfang ausschalten, damit der Login sofort funktioniert.

### 2. Auf GitHub hochladen
Lade **alle Dateien** dieses Ordners in dein Repository `ayli-buchhaltung` hoch
(nicht den Ordner selbst, sondern die Dateien direkt).

### 3. GitHub Pages aktivieren
Repository → **Settings → Pages** → Branch `main` (Root) → Save.
Nach ein bis zwei Minuten ist die App unter der angezeigten Adresse erreichbar.

---

## Als App auf dem iPhone installieren

1. Öffne die GitHub-Pages-Adresse in **Safari**.
2. Tippe auf **Teilen** (das Quadrat mit Pfeil nach oben).
3. Wähle **"Zum Home-Bildschirm"**.

Danach startet die App wie eine echte App im Vollbild.

---

## Erste Nutzung

1. App öffnen → **"Neues Konto erstellen"** (E-Mail + Passwort, mind. 6 Zeichen).
2. Danach mit denselben Daten **anmelden**.
3. Buchungen erfassen – sie werden automatisch in Supabase gespeichert
   und erscheinen auf allen Geräten, auf denen du angemeldet bist.

---

## Funktionen

- Geschäft und Privat getrennt
- Einnahmen und Ausgaben mit Kategorien, Notizen und automatischer MwSt.-Berechnung
- Belege fotografieren / hochladen
- Monatsübersicht, Umsatz pro Tag
- Gewinnberechnung (netto)
- CSV-Export und Monatsabschluss (ZIP mit Belegen) für die Buchhalterin
- Synchronisation über Supabase, lokale Sicherung als Fallback
- Installierbar als PWA

---

## Hinweis

Diese App ist eine Vorbereitungshilfe für die Buchhaltung und ersetzt keine
Steuerberatung. Für die offizielle Steuererklärung bitte eine Steuerberaterin
oder einen Steuerberater hinzuziehen.
