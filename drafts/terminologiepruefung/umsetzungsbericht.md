# Umsetzung der vereinbarten Terminologie

Stand: 12. November 2026. Die nach T01–T03 vorgemerkten Begriffe wurden unter Berücksichtigung aller P-Klärungen in den sieben Kapiteldateien umgesetzt. 8 SVG-Abbildungen wurden sprachlich angepasst; bei längeren Beschriftungen wurden Schriftgrößen bzw. Zeilenaufteilung korrigiert.

**T69 wurde nach gesonderter Vorlage vom Nutzer zur Übernahme freigegeben.** Auf seinen Wunsch wurde vor der Aktualisierung des Freigabestatus der Sicherungscommit a86bcc7 erstellt. Die Vorher-/Nachher-Texte bleiben in sicherheitsbegriffe-nachschaerfen.md dokumentiert.

## Wesentliche Entscheidungen

- Migrationspfad: zentrales wissenschaftliches Ergebnis; Electron-Anwendung: technischer Demonstrator; Webprototyp: ursprüngliche Replit-Anwendung.
- DSR und die Forschungsaktivitäten nach Peffers wurden bewusst bereits bei der Gliederung eingeplant; technische Entscheidungen entwickelten sich schrittweise.
- Desktop-Zielumgebung: gesamter Betriebskontext. Electron-Laufzeit: konkrete technische Ausführungsumgebung.
- Erster Migrationsversuch und spätere Spike-Tests im Worktree bleiben getrennt benannt.
- Module gehören zum Studiengänge-Feature; Kurse und Presets zum Stundenplan-Feature. Die beiden Seed-Dateien sind in K5 Z.143 ausdrücklich zugeordnet.
- Lokale und synchronisierte Studiengruppen sind zwei Migrationsstände desselben ursprünglichen Features.
- Lokales Benutzerkonto und Supabase-Benutzerkonto bleiben getrennt. Profile sind zusätzliche Anwendungsdatensätze.
- Linkbasierte Gruppeneinladung im Webprototyp; direkte Kontoeinladung im synchronisierten Studiengruppen-Feature.
- Sync Streams gelten für Grundlagen und Demonstrator.
- Lokale Kerndatenbank, lokale Kollaborationsdatenbank und Supabase-PostgreSQL-Datenbank bleiben unterscheidbar.
- Zentrale Schemadefinition und primärer lokaler Datenbestand ersetzen die beiden unterschiedlichen Bezüge von Single Source of Truth.
- Kontoverwaltung ist der Funktionsbereich; Anmeldung, Authentifizierung und Zugriffskontrolle sind unterschiedliche Vorgänge.
- Laufzeitprüfungen beziehen sich auf die über den Installer installierte Anwendung; automatisierte Paketprüfungen behalten ihren jeweiligen Artefaktbezug.

## Prüfung

- Typst-Kompilierung erfolgreich. Der zuvor blockierte Paketdownload konnte durchgeführt werden.
- Separate Prüf-PDF: output/pdf/thesis-terminologie-pruefung.pdf; 74 Seiten. Die vorhandene thesis.pdf wurde nicht überschrieben.
- Alle 74 Seiten als Seitenübersichten visuell geprüft; geänderte Abbildungen zusätzlich einzeln und zentrale Seiten in höherer Auflösung kontrolliert.
- SVG-Dateien auf gültiges XML geprüft.
- git diff --check für Kapitel, document.typ und Abbildungen ohne Befund.
- Eingebettete Codeblöcke, vorhandene Typst-Referenzanker und Pfade eingebundener Ressourcen unverändert. Externe Code-Listings, Originalprompts, Bibliografie und Anhangdateien wurden nicht bearbeitet.
- Zeilenzahl der Kapiteldateien erhalten; aktuelle Fundstellen bleiben direkt adressierbar.

## Begriffsfamilien im Überblick

Die Tabelle dokumentiert die Durchsicht aller 84 Familien der ursprünglichen Arbeitsliste. Eine Familie mit bereits korrekt eingeführten Abkürzungen oder fachlich unterschiedlichen Teilbegriffen benötigt keine pauschale Wortersetzung. Ein geänderter Kontext kann mehrere Familien zugleich betreffen. Maßgeblich sind die bestätigten Entscheidungen und der Kontext.

| Eintrag | Thema der ursprünglichen Liste | Bearbeitungsstand |
|---|---|---|
| T01 | Migrationsleitfaden | Bereits zuvor umgesetzt; beibehalten |
| T02 | Migration / Transformation | Bereits zuvor umgesetzt; beibehalten |
| T03 | KI-gestützte Entwicklungsplattformen | Bereits zuvor umgesetzt; beibehalten |
| T04 | Webprototyp des Studienplaners | Im Kontext geprüft und präzisiert |
| T05 | Studienplaner als Produktname | Im Kontext geprüft und präzisiert |
| T06 | Electron-Anwendung / Desktop-Anwendung | Im Kontext geprüft und präzisiert |
| T07 | Lokale Desktop-Laufzeit / Zielumgebung | Im Kontext geprüft und präzisiert |
| T08 | Benutzeroberfläche | Im Kontext geprüft und präzisiert |
| T09 | Funktionen / Features | Im Kontext geprüft und präzisiert |
| T10 | Offline-Kernanwendung | Im Kontext geprüft und präzisiert |
| T11 | Autonome Offline-Verfügbarkeit | Im Kontext geprüft und präzisiert |
| T12 | Datensynchronisation | Im Kontext geprüft und präzisiert |
| T13 | Design Science Research | Im Kontext geprüft und präzisiert |
| T14 | Forschungsrahmen / Forschungsansatz | Im Kontext geprüft und präzisiert |
| T15 | Demonstrator und Artefakt | Im Kontext geprüft und präzisiert |
| T16 | Vorversuch | Im Kontext geprüft und präzisiert |
| T17 | Geschäftslogik | Im Kontext geprüft und präzisiert |
| T18 | Verarbeitungspfad | Im Kontext geprüft und präzisiert |
| T19 | CRUD-Verarbeitung | Im Kontext geprüft und präzisiert |
| T20 | Notenverwaltung | Im Kontext geprüft und präzisiert |
| T21 | Kalendereinträge / Termine | Im Kontext geprüft und präzisiert |
| T22 | Studiengangskatalog | Im Kontext geprüft und präzisiert |
| T23 | Lehrveranstaltungen / Kurse / Module | Im Kontext geprüft und präzisiert |
| T24 | Studiengruppen und synchronisierter Gruppenbereich | Im Kontext geprüft und präzisiert |
| T25 | Gemeinsame Aufgaben / Gruppenaufgaben | Im Kontext geprüft und präzisiert |
| T26 | Unmittelbar netzwerkabhängige Verwaltungsoperationen | Im Kontext geprüft und präzisiert |
| T27 | Einseitige Datenübernahme | Im Kontext geprüft und präzisiert |
| T28 | Dateiimport | Im Kontext geprüft und präzisiert |
| T29 | iCal-Import / ICS-Import | Im Kontext geprüft und präzisiert |
| T30 | Native Dateiauswahl | Im Kontext geprüft und präzisiert |
| T31 | Main-Prozess | Im Kontext geprüft und präzisiert |
| T32 | Renderer-Prozess | Im Kontext geprüft und präzisiert |
| T33 | Preload-Schnittstelle | Im Kontext geprüft und präzisiert |
| T34 | IPC-Dispatcher | Im Kontext geprüft und präzisiert |
| T35 | Handler / Controller | Im Kontext geprüft und präzisiert |
| T36 | API-Vertrag | Im Kontext geprüft und präzisiert |
| T37 | Operationskennung | Im Kontext geprüft und präzisiert |
| T38 | Eingabevalidierung | Im Kontext geprüft und präzisiert |
| T39 | IPC-Absenderprüfung | Im Kontext geprüft und präzisiert |
| T40 | Zod-Laufzeitschemata | Im Kontext geprüft und präzisiert |
| T41 | Codegenerierung | Im Kontext geprüft und präzisiert |
| T42 | React-Query-Hooks | Im Kontext geprüft und präzisiert |
| T43 | Query Keys | Im Kontext geprüft und präzisiert |
| T44 | Hash-Routing und Adressfragment | Im Kontext geprüft und präzisiert |
| T45 | Eigenes URL-Schema / Anwendungsprotokoll | Im Kontext geprüft und präzisiert |
| T46 | Rendererwurzel / Ressourcenverzeichnis | Im Kontext geprüft und präzisiert |
| T47 | Drizzle ORM | Im Kontext geprüft und präzisiert |
| T48 | Lokale Datenhaltung / Persistenz | Im Kontext geprüft und präzisiert |
| T49 | Lokale Datenbank aus Phase 1 | Im Kontext geprüft und präzisiert |
| T50 | Lokaler PowerSync-Datenbestand / Kollaborationsdatenbank | Im Kontext geprüft und präzisiert |
| T51 | Backend-Datenbank | Im Kontext geprüft und präzisiert |
| T52 | SQL-Migrationsdateien / Schemamigrationen | Im Kontext geprüft und präzisiert |
| T53 | Schemadefinition / Datenbankschema | Im Kontext geprüft und präzisiert |
| T54 | Kennung / Identifikator / ID | Im Kontext geprüft und präzisiert |
| T55 | Lokale Identitätsverwaltung | Im Kontext geprüft und präzisiert |
| T56 | Lokale und entfernte Konten | Im Kontext geprüft und präzisiert |
| T57 | Sitzung / Session | Im Kontext geprüft und präzisiert |
| T58 | Einladungslink / Token / Einladung | Im Kontext geprüft und präzisiert |
| T59 | PowerSync-Dienst | Im Kontext geprüft und präzisiert |
| T60 | Replikationsregeln / Sync Streams | Im Kontext geprüft und präzisiert |
| T61 | Upload-Warteschlange | Im Kontext geprüft und präzisiert |
| T62 | Lokaler Schreibabschluss | Im Kontext geprüft und präzisiert |
| T63 | Electron-Sicherheitsrichtlinien | Im Kontext geprüft und präzisiert |
| T64 | Sicherheitsmatrix | Im Kontext geprüft und präzisiert |
| T65 | Härtung | Im Kontext geprüft und präzisiert |
| T66 | Content Security Policy | Im Kontext geprüft und präzisiert |
| T67 | Kontextisolation | Im Kontext geprüft und präzisiert |
| T68 | Node.js-Integration | Im Kontext geprüft und präzisiert |
| T69 | Sandbox / Prozessisolierung | Formulierungen umgesetzt, gesondert vorgelegt und vom Nutzer freigegeben |
| T70 | Paketierung / Paket / Archiv | Im Kontext geprüft und präzisiert |
| T71 | ASAR-Archiv | Im Kontext geprüft und präzisiert |
| T72 | Electron Fuses | Im Kontext geprüft und präzisiert |
| T73 | Codeinspektion | Im Kontext geprüft und präzisiert |
| T74 | Laufzeitversuche | Im Kontext geprüft und präzisiert |
| T75 | Weiterleitung / Redirect | Im Kontext geprüft und präzisiert |
| T76 | Single Source of Truth | Im Kontext geprüft und präzisiert |
| T77 | Authentifizierung / Anmeldung | Im Kontext geprüft und präzisiert |
| T78 | Large Language Model (LLM) | Im Kontext geprüft und präzisiert |
| T79 | Object-Relational Mapping (ORM) | Im Kontext geprüft und präzisiert |
| T80 | Cross-Site Scripting (XSS) | Im Kontext geprüft und präzisiert |
| T81 | Remote Code Execution (RCE) | Im Kontext geprüft und präzisiert |
| T82 | Backend as a Service (BaaS) | Im Kontext geprüft und präzisiert |
| T83 | Write-Ahead Log / Write-Ahead Logging (WAL) | Geprüft; eindeutige Bezeichnungen bzw. fachliche Unterschiede beibehalten |
| T84 | ISO-8601-Zeichenketten / ISO-Strings | Im Kontext geprüft und präzisiert |

## Änderungsnachweis

Seit dem Stand vor dieser Umsetzung wurden 452 Quelltextzeilen in 15 Dateien geändert. Die Sicherung vor-umsetzung-2026-11-12.json enthält den unveränderten Ausgangsstand dieses Arbeitsschritts. aenderungen-2026-11-12.json dokumentiert jede geänderte Zeile mit Vorher-/Nachher-Text; pruefung-2026-11-12.json enthält den geprüften Dateistand. Die ursprüngliche Terminologieprüfung und ihre Suchergebnisse bleiben als historische Bestandsaufnahme erhalten.
