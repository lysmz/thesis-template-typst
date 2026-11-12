# Terminologieprüfung der Thesis

Stand: 11. November 2026. Geprüft wurden die aktuellen Quelltexte der Kapitel 1–7 in der Reihenfolge des Dokuments sowie die Textbeschriftungen ihrer zehn eingebundenen SVG-Abbildungen. Die Thesis selbst wurde nicht geändert.

## So liest du die Liste

**Zeilen beziehen sich auf die jeweilige Typst-Kapiteldatei, nicht auf PDF-Zeilen.** K5 Z.52 bedeutet beispielsweise content/05-migration.typ, Zeile 52. Die Fundstellen sind anklickbar. Leerzeilen und Typst-Formatierungszeilen werden mitgezählt. PDF und Quelltext können unterschiedliche Bearbeitungsstände haben; maßgeblich ist hier der aktuelle Quelltext.

Jeder Eintrag beginnt mit einem vorgeschlagenen Leitbegriff. Darunter stehen die tatsächlich gefundenen Bezeichnungen mit ihren Fundstellen. Es handelt sich um eine kontextuell erstellte Arbeitsliste, nicht um eine Liste automatisch austauschbarer Wörter.

- **V – Bezeichnungswechsel:** derselbe Bezug oder eine auffällige Wechselbenennung; die Erläuterung nennt nötige Einschränkungen.
- **E – eingeführte Entsprechung:** etwa englischer Name, deutsche Übersetzung, Abkürzung oder technischer Feldname. Meist genügt eine saubere Einführung.
- **P – Kontext prüfen:** verwandte Begriffe, verschiedene Ebenen oder mehrere Gegenstände. Hier wäre eine globale Ersetzung fachlich problematisch.

Die Klassifikation gilt für die Begriffsfamilie; die Erläuterung unterscheidet innerhalb einer Familie Synonyme, Teilbegriffe und andere Gegenstände. Groß-/Kleinschreibung am Wortanfang wird zusammengeführt, Beugungsformen werden möglichst wortgetreu gezeigt. Wiederholungen derselben Bezeichnung sind für die erfassten Suchformen ebenfalls aufgeführt. Bei drei ausdrücklich mehrdeutigen Familien (Lehrveranstaltungen, Kerndatenbank und Kollaborationsdatenbank) sind die Fundstellen auf die erläuterten Kontexte begrenzt.

Umfang: Fließtext, Überschriften, Tabellen, Bildunterschriften und SVG-Text. Bibliografie, ursprüngliche Prompts im Anhang, Dateibaum, externe Code-Listings und Codeblöcke sind keine sprachlichen Überarbeitungsziele dieser Liste. Technische Bezeichner im Fließtext werden zur Zuordnung mit erfasst. Die Liste kann Bezeichnungswechsel sichtbar machen; sie kann nicht belegen, wer eine Formulierung geschrieben hat.

## Besonders auffällige Stellen

1. **Migrationspfad / Migrationsweg / Migrationsleitfaden:** wechselnde Bezeichnung des zentralen Ergebnisses, bereits in Kapitel 1 und erneut in Kapitel 7 (T01).
2. **Geschäftslogik / Fachlogik / fachliche Verarbeitung:** derselbe Schichtbezug mit wechselnden Namen (T17).
3. **Module / Lehrveranstaltungen / Kurse:** auffälliger Wechsel zwischen Analyse, Umsetzung und Evaluation; fachliche Identität erst klären (T23).
4. **Benutzerdatenbank / persönliche Datenbank / lokale SQLite-Datei:** in Phase 1 dieselbe Datenbank; von der zusätzlichen Kollaborationsdatenbank trennen (T49–T50).
5. **Controller / Handler:** Architekturvorgabe und Implementierungsbeschreibung verwenden verschiedene Rollennamen (T35).
6. **Synchronisation / Synchronisierung:** durchgehender sprachlicher Wechsel, auch in Überschriften und Ergebnistabellen (T12).
7. **Sync Rules / Sync Streams:** abweichende Bezeichnungen in Grundlagenabbildung und Implementierung; mögliches unterschiedliches Konfigurationsmodell prüfen (T60).

## Kapitelweise Orientierung

Die nachfolgenden Kapitelregister führen zu den unten zusammengefassten Begriffsfamilien. Eine Familie wird nur einmal ausführlich erklärt; ihre Fundstellen decken alle betroffenen Kapitel ab. So lassen sich die Kapitel nacheinander durcharbeiten und zugleich kapitelübergreifende Wechsel erkennen.

### Kapitel 1: Einleitung

- [T01 · Migrationsleitfaden](#t01) (V)
- [T02 · Migration / Transformation](#t02) (V)
- [T03 · KI-gestützte Entwicklungsplattformen](#t03) (V)
- [T04 · Webprototyp des Studienplaners](#t04) (V)
- [T05 · Studienplaner als Produktname](#t05) (E)
- [T06 · Electron-Anwendung / Desktop-Anwendung](#t06) (V)
- [T07 · Lokale Desktop-Laufzeit / Zielumgebung](#t07) (P)
- [T08 · Benutzeroberfläche](#t08) (V)
- [T11 · Autonome Offline-Verfügbarkeit](#t11) (V)
- [T12 · Datensynchronisation](#t12) (V)
- [T13 · Design Science Research](#t13) (E)
- [T14 · Forschungsrahmen / Forschungsansatz](#t14) (P)
- [T15 · Demonstrator und Artefakt](#t15) (P)
- [T24 · Studiengruppen und synchronisierter Gruppenbereich](#t24) (P)
- [T31 · Main-Prozess](#t31) (E)
- [T32 · Renderer-Prozess](#t32) (E)
- [T36 · API-Vertrag](#t36) (V)
- [T48 · Lokale Datenhaltung / Persistenz](#t48) (V)
- [T69 · Sandbox / Prozessisolierung](#t69) (P)
- [T76 · Single Source of Truth](#t76) (P)
- [T77 · Authentifizierung / Anmeldung](#t77) (P)

### Kapitel 2: Theoretischer Hintergrund

- [T02 · Migration / Transformation](#t02) (V)
- [T03 · KI-gestützte Entwicklungsplattformen](#t03) (V)
- [T06 · Electron-Anwendung / Desktop-Anwendung](#t06) (V)
- [T07 · Lokale Desktop-Laufzeit / Zielumgebung](#t07) (P)
- [T08 · Benutzeroberfläche](#t08) (V)
- [T11 · Autonome Offline-Verfügbarkeit](#t11) (V)
- [T12 · Datensynchronisation](#t12) (V)
- [T15 · Demonstrator und Artefakt](#t15) (P)
- [T22 · Studiengangskatalog](#t22) (V)
- [T27 · Einseitige Datenübernahme](#t27) (V)
- [T31 · Main-Prozess](#t31) (E)
- [T32 · Renderer-Prozess](#t32) (E)
- [T35 · Handler / Controller](#t35) (V)
- [T36 · API-Vertrag](#t36) (V)
- [T38 · Eingabevalidierung](#t38) (V)
- [T41 · Codegenerierung](#t41) (V)
- [T44 · Hash-Routing und Adressfragment](#t44) (E)
- [T45 · Eigenes URL-Schema / Anwendungsprotokoll](#t45) (V)
- [T46 · Rendererwurzel / Ressourcenverzeichnis](#t46) (V)
- [T47 · Drizzle ORM](#t47) (E)
- [T48 · Lokale Datenhaltung / Persistenz](#t48) (V)
- [T51 · Backend-Datenbank](#t51) (V)
- [T52 · SQL-Migrationsdateien / Schemamigrationen](#t52) (V)
- [T53 · Schemadefinition / Datenbankschema](#t53) (V)
- [T59 · PowerSync-Dienst](#t59) (V)
- [T61 · Upload-Warteschlange](#t61) (V)
- [T62 · Lokaler Schreibabschluss](#t62) (E)
- [T63 · Electron-Sicherheitsrichtlinien](#t63) (V)
- [T66 · Content Security Policy](#t66) (E)
- [T67 · Kontextisolation](#t67) (E)
- [T68 · Node.js-Integration](#t68) (E)
- [T69 · Sandbox / Prozessisolierung](#t69) (P)
- [T70 · Paketierung / Paket / Archiv](#t70) (P)
- [T71 · ASAR-Archiv](#t71) (V)
- [T72 · Electron Fuses](#t72) (E)
- [T76 · Single Source of Truth](#t76) (P)
- [T78 · Large Language Model (LLM)](#t78) (E)
- [T79 · Object-Relational Mapping (ORM)](#t79) (E)
- [T80 · Cross-Site Scripting (XSS)](#t80) (E)
- [T81 · Remote Code Execution (RCE)](#t81) (E)
- [T82 · Backend as a Service (BaaS)](#t82) (E)
- [T83 · Write-Ahead Log / Write-Ahead Logging (WAL)](#t83) (E)

### Kapitel 3: Methodisches Vorgehen

- [T01 · Migrationsleitfaden](#t01) (V)
- [T02 · Migration / Transformation](#t02) (V)
- [T04 · Webprototyp des Studienplaners](#t04) (V)
- [T05 · Studienplaner als Produktname](#t05) (E)
- [T06 · Electron-Anwendung / Desktop-Anwendung](#t06) (V)
- [T07 · Lokale Desktop-Laufzeit / Zielumgebung](#t07) (P)
- [T08 · Benutzeroberfläche](#t08) (V)
- [T09 · Funktionen / Features](#t09) (V)
- [T10 · Offline-Kernanwendung](#t10) (V)
- [T11 · Autonome Offline-Verfügbarkeit](#t11) (V)
- [T12 · Datensynchronisation](#t12) (V)
- [T13 · Design Science Research](#t13) (E)
- [T14 · Forschungsrahmen / Forschungsansatz](#t14) (P)
- [T15 · Demonstrator und Artefakt](#t15) (P)
- [T16 · Vorversuch](#t16) (P)
- [T17 · Geschäftslogik](#t17) (V)
- [T18 · Verarbeitungspfad](#t18) (V)
- [T22 · Studiengangskatalog](#t22) (V)
- [T24 · Studiengruppen und synchronisierter Gruppenbereich](#t24) (P)
- [T27 · Einseitige Datenübernahme](#t27) (V)
- [T31 · Main-Prozess](#t31) (E)
- [T32 · Renderer-Prozess](#t32) (E)
- [T33 · Preload-Schnittstelle](#t33) (V)
- [T36 · API-Vertrag](#t36) (V)
- [T38 · Eingabevalidierung](#t38) (V)
- [T40 · Zod-Laufzeitschemata](#t40) (V)
- [T42 · React-Query-Hooks](#t42) (V)
- [T63 · Electron-Sicherheitsrichtlinien](#t63) (V)
- [T65 · Härtung](#t65) (V)
- [T73 · Codeinspektion](#t73) (V)
- [T74 · Laufzeitversuche](#t74) (V)
- [T78 · Large Language Model (LLM)](#t78) (E)
- [T81 · Remote Code Execution (RCE)](#t81) (E)

### Kapitel 4: Analyse und Anforderungsdefinition

- [T01 · Migrationsleitfaden](#t01) (V)
- [T02 · Migration / Transformation](#t02) (V)
- [T04 · Webprototyp des Studienplaners](#t04) (V)
- [T05 · Studienplaner als Produktname](#t05) (E)
- [T06 · Electron-Anwendung / Desktop-Anwendung](#t06) (V)
- [T07 · Lokale Desktop-Laufzeit / Zielumgebung](#t07) (P)
- [T08 · Benutzeroberfläche](#t08) (V)
- [T09 · Funktionen / Features](#t09) (V)
- [T11 · Autonome Offline-Verfügbarkeit](#t11) (V)
- [T12 · Datensynchronisation](#t12) (V)
- [T15 · Demonstrator und Artefakt](#t15) (P)
- [T17 · Geschäftslogik](#t17) (V)
- [T18 · Verarbeitungspfad](#t18) (V)
- [T19 · CRUD-Verarbeitung](#t19) (V)
- [T21 · Kalendereinträge / Termine](#t21) (V)
- [T22 · Studiengangskatalog](#t22) (V)
- [T23 · Lehrveranstaltungen / Kurse / Module](#t23) (P)
- [T24 · Studiengruppen und synchronisierter Gruppenbereich](#t24) (P)
- [T25 · Gemeinsame Aufgaben / Gruppenaufgaben](#t25) (V)
- [T26 · Unmittelbar netzwerkabhängige Verwaltungsoperationen](#t26) (V)
- [T27 · Einseitige Datenübernahme](#t27) (V)
- [T28 · Dateiimport](#t28) (V)
- [T29 · iCal-Import / ICS-Import](#t29) (V)
- [T31 · Main-Prozess](#t31) (E)
- [T32 · Renderer-Prozess](#t32) (E)
- [T33 · Preload-Schnittstelle](#t33) (V)
- [T35 · Handler / Controller](#t35) (V)
- [T39 · IPC-Absenderprüfung](#t39) (V)
- [T41 · Codegenerierung](#t41) (V)
- [T48 · Lokale Datenhaltung / Persistenz](#t48) (V)
- [T54 · Kennung / Identifikator / ID](#t54) (E)
- [T55 · Lokale Identitätsverwaltung](#t55) (V)
- [T56 · Lokale und entfernte Konten](#t56) (P)
- [T63 · Electron-Sicherheitsrichtlinien](#t63) (V)
- [T65 · Härtung](#t65) (V)
- [T69 · Sandbox / Prozessisolierung](#t69) (P)
- [T74 · Laufzeitversuche](#t74) (V)
- [T77 · Authentifizierung / Anmeldung](#t77) (P)

### Kapitel 5: Entwurf, Migration und Migrationsleitfaden

- [T01 · Migrationsleitfaden](#t01) (V)
- [T02 · Migration / Transformation](#t02) (V)
- [T04 · Webprototyp des Studienplaners](#t04) (V)
- [T05 · Studienplaner als Produktname](#t05) (E)
- [T06 · Electron-Anwendung / Desktop-Anwendung](#t06) (V)
- [T07 · Lokale Desktop-Laufzeit / Zielumgebung](#t07) (P)
- [T08 · Benutzeroberfläche](#t08) (V)
- [T09 · Funktionen / Features](#t09) (V)
- [T10 · Offline-Kernanwendung](#t10) (V)
- [T11 · Autonome Offline-Verfügbarkeit](#t11) (V)
- [T12 · Datensynchronisation](#t12) (V)
- [T15 · Demonstrator und Artefakt](#t15) (P)
- [T16 · Vorversuch](#t16) (P)
- [T17 · Geschäftslogik](#t17) (V)
- [T18 · Verarbeitungspfad](#t18) (V)
- [T19 · CRUD-Verarbeitung](#t19) (V)
- [T20 · Notenverwaltung](#t20) (V)
- [T21 · Kalendereinträge / Termine](#t21) (V)
- [T22 · Studiengangskatalog](#t22) (V)
- [T23 · Lehrveranstaltungen / Kurse / Module](#t23) (P)
- [T24 · Studiengruppen und synchronisierter Gruppenbereich](#t24) (P)
- [T25 · Gemeinsame Aufgaben / Gruppenaufgaben](#t25) (V)
- [T26 · Unmittelbar netzwerkabhängige Verwaltungsoperationen](#t26) (V)
- [T27 · Einseitige Datenübernahme](#t27) (V)
- [T28 · Dateiimport](#t28) (V)
- [T29 · iCal-Import / ICS-Import](#t29) (V)
- [T30 · Native Dateiauswahl](#t30) (V)
- [T31 · Main-Prozess](#t31) (E)
- [T32 · Renderer-Prozess](#t32) (E)
- [T33 · Preload-Schnittstelle](#t33) (V)
- [T34 · IPC-Dispatcher](#t34) (V)
- [T35 · Handler / Controller](#t35) (V)
- [T36 · API-Vertrag](#t36) (V)
- [T37 · Operationskennung](#t37) (E)
- [T38 · Eingabevalidierung](#t38) (V)
- [T39 · IPC-Absenderprüfung](#t39) (V)
- [T40 · Zod-Laufzeitschemata](#t40) (V)
- [T41 · Codegenerierung](#t41) (V)
- [T42 · React-Query-Hooks](#t42) (V)
- [T43 · Query Keys](#t43) (E)
- [T44 · Hash-Routing und Adressfragment](#t44) (E)
- [T45 · Eigenes URL-Schema / Anwendungsprotokoll](#t45) (V)
- [T46 · Rendererwurzel / Ressourcenverzeichnis](#t46) (V)
- [T47 · Drizzle ORM](#t47) (E)
- [T48 · Lokale Datenhaltung / Persistenz](#t48) (V)
- [T49 · Lokale Datenbank aus Phase 1](#t49) (V)
- [T50 · Lokaler PowerSync-Datenbestand / Kollaborationsdatenbank](#t50) (V)
- [T51 · Backend-Datenbank](#t51) (V)
- [T52 · SQL-Migrationsdateien / Schemamigrationen](#t52) (V)
- [T53 · Schemadefinition / Datenbankschema](#t53) (V)
- [T54 · Kennung / Identifikator / ID](#t54) (E)
- [T55 · Lokale Identitätsverwaltung](#t55) (V)
- [T56 · Lokale und entfernte Konten](#t56) (P)
- [T57 · Sitzung / Session](#t57) (E)
- [T58 · Einladungslink / Token / Einladung](#t58) (P)
- [T59 · PowerSync-Dienst](#t59) (V)
- [T60 · Replikationsregeln / Sync Streams](#t60) (P)
- [T61 · Upload-Warteschlange](#t61) (V)
- [T62 · Lokaler Schreibabschluss](#t62) (E)
- [T63 · Electron-Sicherheitsrichtlinien](#t63) (V)
- [T64 · Sicherheitsmatrix](#t64) (V)
- [T65 · Härtung](#t65) (V)
- [T66 · Content Security Policy](#t66) (E)
- [T67 · Kontextisolation](#t67) (E)
- [T68 · Node.js-Integration](#t68) (E)
- [T69 · Sandbox / Prozessisolierung](#t69) (P)
- [T70 · Paketierung / Paket / Archiv](#t70) (P)
- [T71 · ASAR-Archiv](#t71) (V)
- [T72 · Electron Fuses](#t72) (E)
- [T73 · Codeinspektion](#t73) (V)
- [T74 · Laufzeitversuche](#t74) (V)
- [T75 · Weiterleitung / Redirect](#t75) (E)
- [T77 · Authentifizierung / Anmeldung](#t77) (P)
- [T79 · Object-Relational Mapping (ORM)](#t79) (E)
- [T83 · Write-Ahead Log / Write-Ahead Logging (WAL)](#t83) (E)
- [T84 · ISO-8601-Zeichenketten / ISO-Strings](#t84) (E)

### Kapitel 6: Evaluation des Demonstrators und des Migrationsleitfadens

- [T01 · Migrationsleitfaden](#t01) (V)
- [T02 · Migration / Transformation](#t02) (V)
- [T04 · Webprototyp des Studienplaners](#t04) (V)
- [T06 · Electron-Anwendung / Desktop-Anwendung](#t06) (V)
- [T07 · Lokale Desktop-Laufzeit / Zielumgebung](#t07) (P)
- [T08 · Benutzeroberfläche](#t08) (V)
- [T09 · Funktionen / Features](#t09) (V)
- [T10 · Offline-Kernanwendung](#t10) (V)
- [T11 · Autonome Offline-Verfügbarkeit](#t11) (V)
- [T12 · Datensynchronisation](#t12) (V)
- [T15 · Demonstrator und Artefakt](#t15) (P)
- [T17 · Geschäftslogik](#t17) (V)
- [T18 · Verarbeitungspfad](#t18) (V)
- [T19 · CRUD-Verarbeitung](#t19) (V)
- [T20 · Notenverwaltung](#t20) (V)
- [T21 · Kalendereinträge / Termine](#t21) (V)
- [T22 · Studiengangskatalog](#t22) (V)
- [T23 · Lehrveranstaltungen / Kurse / Module](#t23) (P)
- [T25 · Gemeinsame Aufgaben / Gruppenaufgaben](#t25) (V)
- [T26 · Unmittelbar netzwerkabhängige Verwaltungsoperationen](#t26) (V)
- [T27 · Einseitige Datenübernahme](#t27) (V)
- [T28 · Dateiimport](#t28) (V)
- [T29 · iCal-Import / ICS-Import](#t29) (V)
- [T30 · Native Dateiauswahl](#t30) (V)
- [T33 · Preload-Schnittstelle](#t33) (V)
- [T36 · API-Vertrag](#t36) (V)
- [T38 · Eingabevalidierung](#t38) (V)
- [T48 · Lokale Datenhaltung / Persistenz](#t48) (V)
- [T55 · Lokale Identitätsverwaltung](#t55) (V)
- [T56 · Lokale und entfernte Konten](#t56) (P)
- [T57 · Sitzung / Session](#t57) (E)
- [T65 · Härtung](#t65) (V)
- [T66 · Content Security Policy](#t66) (E)
- [T70 · Paketierung / Paket / Archiv](#t70) (P)
- [T73 · Codeinspektion](#t73) (V)
- [T74 · Laufzeitversuche](#t74) (V)
- [T75 · Weiterleitung / Redirect](#t75) (E)
- [T77 · Authentifizierung / Anmeldung](#t77) (P)

### Kapitel 7: Diskussion und Ausblick

- [T01 · Migrationsleitfaden](#t01) (V)
- [T02 · Migration / Transformation](#t02) (V)
- [T04 · Webprototyp des Studienplaners](#t04) (V)
- [T05 · Studienplaner als Produktname](#t05) (E)
- [T06 · Electron-Anwendung / Desktop-Anwendung](#t06) (V)
- [T08 · Benutzeroberfläche](#t08) (V)
- [T09 · Funktionen / Features](#t09) (V)
- [T11 · Autonome Offline-Verfügbarkeit](#t11) (V)
- [T12 · Datensynchronisation](#t12) (V)
- [T16 · Vorversuch](#t16) (P)
- [T24 · Studiengruppen und synchronisierter Gruppenbereich](#t24) (P)
- [T25 · Gemeinsame Aufgaben / Gruppenaufgaben](#t25) (V)
- [T36 · API-Vertrag](#t36) (V)
- [T49 · Lokale Datenbank aus Phase 1](#t49) (V)
- [T53 · Schemadefinition / Datenbankschema](#t53) (V)
- [T56 · Lokale und entfernte Konten](#t56) (P)
- [T57 · Sitzung / Session](#t57) (E)
- [T58 · Einladungslink / Token / Einladung](#t58) (P)
- [T63 · Electron-Sicherheitsrichtlinien](#t63) (V)
- [T65 · Härtung](#t65) (V)
- [T75 · Weiterleitung / Redirect](#t75) (E)
- [T77 · Authentifizierung / Anmeldung](#t77) (P)

## Zusammengeführte Begriffsliste

<a id="t01"></a>

### T01 · Migrationsleitfaden [V]

Die Arbeit bezeichnet ihr Vorgehen bzw. Ergebnis wechselnd als Pfad, Weg und Leitfaden. Vorschlag: „Migrationsleitfaden“ für das schriftliche Ergebnis; „Migrationsprozess“ für die tatsächlich ausgeführten Tätigkeiten. Falls „Migrationspfad“ bewusst einen anderen Gegenstand meint, diesen Unterschied ausdrücklich definieren.

- **Migrationspfad** – [K1 Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:31>), [K1 Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:36>), [K1 Z.52](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:52>).
- **Migrationswegs** – [K1 Z.53](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:53>), [K7 Z.13](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:13>), [K7 Z.15](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:15>).
- **Migrationsleitfadens** – [K3 Z.8](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:8>), [K4 Z.218](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:218>), [K5 Z.5](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:5>), [K5 Z.30](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:30>), [K5 Z.968](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:968>), [K6 Z.2](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:2>).
- **Leitfaden** – [K3 Z.17](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:17>), [K3 Z.19](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:19>), [K4 Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:39>), [K4 Z.203](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:203>), [K6 Z.322](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:322>), [K7 Z.47](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:47>), [K7 Z.50](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:50>), [K7 Z.69](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:69>).
- **Leitfadens** – [K3 Z.97](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:97>), [K3 Z.99](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:99>), [K4 Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:37>), [K6 Z.7](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:7>), [K6 Z.284](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:284>), [K6 Z.316](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:316>), [K7 Z.18](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:18>), [K7 Z.44](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:44>), [K7 Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:58>).
- **Migrationsleitfaden** – [K4 Z.142](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:142>), [K5 Z.2](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:2>), [K5 Z.7](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:7>), [K6 Z.355](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:355>).

<a id="t02"></a>

### T02 · Migration / Transformation [V]

Im Bezug auf den Gesamtumbau sind dies alternative Benennungen. „Migration“ als Leitbegriff verwenden. Übertragung einzelner Daten oder Felder und die erwogene Portierung nach Rust sind enger gefasste Vorgänge; dort ist eine andere Bezeichnung sachlich sinnvoll. Keine pauschale Ersetzung.

- **Transformation** – [K1 Z.26](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:26>), [K4 Z.8](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:8>), [K4 Z.129](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:129>), [K5 Z.228](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:228>), [K5 Z.232](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:232>).
- **Überführung** – [K1 Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:31>), [K3 Z.41](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:41>), [K3 Z.64](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:64>), [K5 Z.569](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:569>), [K5 Z.581](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:581>), [K5 Z.725](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:725>), [K5 Z.1047](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1047>), [K5 Z.1050](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1050>), [K5 Z.1057](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1057>).
- **Migration** – [K1 Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:39>), [K1 Z.40](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:40>), [K2 Z.16](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:16>), [K3 Z.14](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:14>), [K3 Z.17](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:17>), [K3 Z.19](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:19>), [K3 Z.30](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:30>), [K3 Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:46>), [K4 Z.10](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:10>), [K4 Z.29](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:29>), [K4 Z.34](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:34>), [K4 Z.113](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:113>), [K4 Z.121](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:121>), [K5 Z.2](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:2>), [K5 Z.139](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:139>), [K5 Z.402](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:402>), [K5 Z.451](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:451>), [K5 Z.569](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:569>), [K5 Z.575](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:575>), [K5 Z.609](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:609>), [K5 Z.971](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:971>), [K6 Z.317](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:317>), [K7 Z.5](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:5>), [K7 Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:21>), [K7 Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:23>), [K7 Z.25](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:25>).
- **Übertragung** – [K2 Z.127](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:127>), [K5 Z.406](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:406>), [K5 Z.990](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:990>), [K7 Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:51>), [K7 Z.72](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:72>).
- **Portierung** – [K5 Z.42](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:42>).
- **Migrationen** – [K5 Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:58>), [K5 Z.109](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:109>), [K5 Z.119](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:119>), [K5 Z.122](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:122>), [K5 Z.627](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:627>), [K5 Z.730](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:730>), [K5 Z.907](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:907>), [K5 Z.1065](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1065>), [K7 Z.59](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:59>).

Zusätzlich in Abbildungen:

- **Migrationen** – K5, [local-first-architecture.svg Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:58>); Beschriftung: „Drizzle-Kit-Migrationen“.
- **Migrationen** – K5, [collaboration-modules.svg Z.55](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:55>); Beschriftung: „Drizzle-Kit-Migrationen“.

<a id="t03"></a>

### T03 · KI-gestützte Entwicklungsplattformen [V]

Replit und Lovable werden als Werkzeuge und als Plattformen bezeichnet. Als Oberbegriff durchgängig „KI-gestützte Entwicklungsplattformen“ verwenden; „KI-Werkzeug“ nur, wenn ausdrücklich ein einzelnes Werkzeug gemeint ist.

- **KI-gestützte Werkzeuge** – [K1 Z.8](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:8>).
- **KI-gestützte Entwicklungsplattformen** – [K1 Z.13](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:13>), [K1 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:48>).
- **KI-Werkzeugs** – [K1 Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:22>).
- **cloudbasierte Entwicklungswerkzeuge** – [K1 Z.50](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:50>).
- **KI-gestützte Anwendungsentwicklungsplattformen** – [K2 Z.5](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:5>).
- **KI-gestützten Anwendungsentwicklungsplattformen** – [K2 Z.7](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:7>).

<a id="t04"></a>

### T04 · Webprototyp des Studienplaners [V]

Für die konkrete Ausgangsanwendung wechseln Produktzustand, Herkunft und methodische Rolle. Vorschlag: „Webprototyp des Studienplaners“, danach „Webprototyp“. „Ausgangsartefakt“ ist in methodischen Aussagen zulässig, sollte aber einmal ausdrücklich zugeordnet werden. Allgemeine Aussagen über beliebige Ausgangsartefakte bleiben allgemein.

- **Replit-Webprototyp** – [K1 Z.32](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:32>).
- **KI-generierten Webprototyp** – [K3 Z.8](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:8>).
- **KI-generiertes Ausgangsartefakt** – [K3 Z.26](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:26>).
- **Ausgangsartefakt** – [K3 Z.50](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:50>), [K4 Z.104](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:104>), [K4 Z.152](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:152>), [K5 Z.977](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:977>), [K6 Z.115](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:115>).
- **Ausgangsartefakts** – [K4 Z.8](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:8>), [K4 Z.41](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:41>), [K4 Z.43](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:43>), [K4 Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:46>), [K4 Z.73](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:73>), [K4 Z.80](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:80>), [K4 Z.86](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:86>), [K4 Z.127](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:127>), [K4 Z.161](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:161>), [K4 Z.163](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:163>), [K5 Z.38](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:38>), [K6 Z.6](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:6>), [K6 Z.88](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:88>), [K6 Z.343](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:343>).
- **Replit-Prototyp** – [K4 Z.38](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:38>), [K7 Z.57](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:57>).
- **Web-Prototyp** – [K5 Z.149](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:149>), [K5 Z.163](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:163>), [K5 Z.180](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:180>), [K5 Z.469](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:469>), [K5 Z.603](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:603>), [K7 Z.16](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:16>), [K7 Z.27](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:27>).
- **Ausgangsprojekts** – [K5 Z.353](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:353>).
- **Ausgangsartefakte** – [K6 Z.322](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:322>).

Zusätzlich in Abbildungen:

- **Web-Prototyp** – K5, [api-interface-migration.svg Z.26](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:26>); Beschriftung: „Web-Prototyp“.

<a id="t05"></a>

### T05 · Studienplaner als Produktname [E]

„Studienverwaltungsanwendung“ beschreibt den Studienplaner in K1 Z.32. Kein zweites Produkt. Den Namen einmal mit dieser Beschreibung einführen; bei späteren Rückverweisen den Produktnamen verwenden.

- **Studienplaner** – [K1 Z.32](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:32>), [K1 Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:36>), [K3 Z.8](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:8>), [K3 Z.24](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:24>), [K4 Z.38](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:38>), [K5 Z.350](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:350>).
- **Studienverwaltungsanwendung** – [K1 Z.32](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:32>).
- **Studienplaners** – [K4 Z.86](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:86>), [K7 Z.5](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:5>).

Zusätzlich in Abbildungen:

- **studienplaner** – K4, [original-web-architecture.svg Z.44](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:44>); Beschriftung: „artifacts/studienplaner“.

<a id="t06"></a>

### T06 · Electron-Anwendung / Desktop-Anwendung [V]

Für die umgesetzte Anwendung wechseln „Electron-Anwendung“, „Desktop-Anwendung“ und „App“. Vorschlag: „Electron-Anwendung“ für den konkreten Demonstrator. Generische Desktop-Anwendungen, die Local-First-Zielklasse und das Projektverzeichnis sind nicht automatisch derselbe Gegenstand.

- **Desktop-Anwendungen** – [K1 Z.15](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:15>), [K2 Z.33](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:33>).
- **Electron-Anwendung** – [K1 Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:23>), [K1 Z.32](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:32>), [K1 Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:51>), [K2 Z.53](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:53>), [K3 Z.18](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:18>), [K3 Z.71](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:71>), [K4 Z.139](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:139>), [K4 Z.152](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:152>).
- **Desktop-Anwendung** – [K1 Z.27](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:27>), [K4 Z.150](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:150>), [K5 Z.482](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:482>), [K5 Z.600](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:600>), [K5 Z.729](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:729>), [K5 Z.778](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:778>), [K5 Z.805](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:805>), [K6 Z.20](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:20>), [K6 Z.339](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:339>).
- **Local-First-Desktop-Anwendungen** – [K1 Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:31>).
- **Electron-Anwendungen** – [K2 Z.82](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:82>).
- **Zielprojekt** – [K3 Z.40](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:40>), [K5 Z.47](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:47>).
- **Desktop-Projekt** – [K5 Z.148](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:148>).
- **Electron-App** – [K7 Z.5](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:5>).
- **Desktop-App** – [K7 Z.27](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:27>).

Zusätzlich in Abbildungen:

- **Desktop-Anwendung** – K5, [sync-schema-deployment.svg Z.30](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/sync-schema-deployment.svg:30>); Beschriftung: „Desktop-Anwendung“.

<a id="t07"></a>

### T07 · Lokale Desktop-Laufzeit / Zielumgebung [P]

Die Zielumgebung wird teilweise als Desktop-Umgebung und teilweise als Laufzeit bezeichnet. „Electron-Laufzeit“ für die konkrete technische Laufzeit, „Desktop-Zielumgebung“ für den weiteren Betriebskontext. Die Sandbox der Erstellungsplattform ist eine andere Umgebung.

- **lokalen Laufzeitumgebung** – [K1 Z.16](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:16>).
- **Desktop-Umgebung** – [K1 Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:21>), [K1 Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:39>), [K3 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:48>), [K5 Z.1015](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1015>).
- **Zielumgebung** – [K1 Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:22>), [K2 Z.15](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:15>), [K3 Z.53](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:53>), [K5 Z.209](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:209>), [K5 Z.977](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:977>), [K6 Z.317](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:317>).
- **Web-zu-Desktop-Laufzeitumgebung** – [K1 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:48>).
- **Produktionsumgebungen** – [K2 Z.16](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:16>).
- **Desktop-Laufzeit** – [K2 Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:31>), [K3 Z.26](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:26>), [K4 Z.125](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:125>), [K4 Z.218](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:218>), [K5 Z.982](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:982>).
- **lokale Laufzeit** – [K4 Z.30](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:30>), [K4 Z.127](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:127>).

<a id="t08"></a>

### T08 · Benutzeroberfläche [V]

Bei sichtbaren Komponenten ist regelmäßig dieselbe Benutzeroberfläche gemeint. Vorschlag: „Benutzeroberfläche“, bei technischem Komponentenbezug „Frontend“. Renderer ist der ausführende Prozess, nicht synonym mit der Oberfläche. „Darstellung“ kann zusätzlich einen einzelnen Ausgabevorgang meinen.

- **Frontend** – [K1 Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:23>), [K2 Z.28](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:28>), [K2 Z.69](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:69>), [K4 Z.9](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:9>), [K4 Z.24](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:24>), [K4 Z.217](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:217>), [K7 Z.69](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:69>).
- **Benutzeroberfläche** – [K2 Z.18](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:18>), [K2 Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:36>), [K5 Z.141](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:141>), [K5 Z.212](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:212>).
- **Oberfläche** – [K2 Z.53](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:53>), [K3 Z.29](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:29>), [K3 Z.41](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:41>), [K5 Z.377](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:377>), [K5 Z.382](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:382>), [K5 Z.390](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:390>), [K5 Z.454](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:454>), [K5 Z.460](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:460>), [K5 Z.577](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:577>), [K5 Z.580](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:580>), [K5 Z.600](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:600>), [K5 Z.604](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:604>), [K5 Z.609](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:609>), [K5 Z.781](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:781>), [K5 Z.785](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:785>), [K5 Z.788](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:788>), [K5 Z.978](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:978>), [K5 Z.1025](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1025>), [K5 Z.1042](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1042>), [K5 Z.1106](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1106>), [K5 Z.1109](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1109>), [K6 Z.92](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:92>), [K6 Z.109](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:109>), [K6 Z.112](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:112>), [K6 Z.301](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:301>), [K6 Z.342](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:342>), [K7 Z.53](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:53>).
- **darstellende Schicht** – [K2 Z.117](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:117>).
- **Replit-Frontend** – [K5 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:48>).
- **React-Oberfläche** – [K5 Z.349](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:349>), [K5 Z.350](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:350>).
- **Desktop-Oberfläche** – [K7 Z.30](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:30>).

Zusätzlich in Abbildungen:

- **Benutzeroberfläche** – K2, [electron-architecture-comparison.svg Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:36>); Beschriftung: „Benutzeroberfläche in der Sandbox“.
- **Benutzeroberfläche** – K2, [electron-architecture-comparison.svg Z.47](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:47>); Beschriftung: „Benutzeroberfläche und externe Inhalte“.
- **Benutzeroberfläche** – K2, [powersync-replication-flow.svg Z.25](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:25>); Beschriftung: „Benutzeroberfläche“.
- **Frontend** – K4, [original-web-architecture.svg Z.43](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:43>); Beschriftung: „Browser · Frontend“.
- **React-Oberfläche** – K4, [original-web-architecture.svg Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:46>); Beschriftung: „React-Oberfläche“.
- **Oberfläche** – K5, [grades-crud-flow.svg Z.71](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:71>); Beschriftung: „Oberfläche aktualisieren“.
- **React-Oberfläche** – K5, [local-first-architecture.svg Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:22>); Beschriftung: „React-Oberfläche und generierte Hooks“.

<a id="t09"></a>

### T09 · Funktionen / Features [V]

„Feature“ und „Funktion“ werden für dieselben Funktionsbereiche benutzt, besonders in K4 und K7. Vorschlag: „Funktion“ bzw. „Funktionsbereich“; konkrete UI-Namen wie „Studiengruppen“ beibehalten. Kernfunktionen sind eine Teilmenge, keine zusätzliche Variante jedes Features.

- **Kernfunktionen** – [K3 Z.66](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:66>), [K3 Z.71](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:71>).
- **Features** – [K4 Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:46>), [K4 Z.112](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:112>), [K5 Z.627](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:627>), [K5 Z.781](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:781>), [K7 Z.6](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:6>), [K7 Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:21>), [K7 Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:22>), [K7 Z.72](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:72>), [K7 Z.84](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:84>).
- **Feature** – [K4 Z.76](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:76>), [K4 Z.117](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:117>), [K4 Z.118](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:118>), [K4 Z.121](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:121>), [K4 Z.137](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:137>), [K4 Z.176](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:176>), [K4 Z.177](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:177>), [K4 Z.180](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:180>), [K5 Z.510](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:510>), [K5 Z.585](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:585>), [K5 Z.587](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:587>), [K5 Z.771](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:771>), [K5 Z.773](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:773>), [K5 Z.901](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:901>), [K7 Z.19](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:19>), [K7 Z.32](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:32>), [K7 Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:51>).
- **persönlichen Funktionen** – [K4 Z.176](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:176>), [K6 Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:58>).
- **Anwendungsfunktionen** – [K5 Z.8](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:8>).
- **Offline-Kernfunktionen** – [K5 Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:21>), [K5 Z.999](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:999>).
- **fachlichen Funktionen** – [K5 Z.401](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:401>).
- **persönliche Funktionen** – [K5 Z.575](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:575>).

Zusätzlich in Abbildungen:

- **Kernfunktionen** – K5, [collaboration-modules.svg Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:46>); Beschriftung: „Lokale Kernfunktionen“.

<a id="t10"></a>

### T10 · Offline-Kernanwendung [V]

Bezeichnet die in Phase 1 hergestellte Anwendungsbasis. Vorschlag: „Offline-Kernanwendung“. Die vollständige Electron-Anwendung schließt spätere Erweiterungen ein und ist deshalb nicht stets deckungsgleich.

- **lokal ausführbaren Kernanwendung** – [K3 Z.77](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:77>).
- **Offline-Kernanwendung** – [K3 Z.78](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:78>), [K5 Z.7](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:7>), [K5 Z.33](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:33>), [K5 Z.570](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:570>).
- **Electron-Kernanwendung** – [K5 Z.163](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:163>), [K5 Z.181](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:181>).
- **lokale Kernanwendung** – [K5 Z.505](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:505>), [K5 Z.794](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:794>), [K6 Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:22>).
- **lokalen Kernanwendung** – [K5 Z.686](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:686>).

Zusätzlich in Abbildungen:

- **Electron-Kernanwendung** – K5, [api-interface-migration.svg Z.27](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:27>); Beschriftung: „Electron-Kernanwendung“.

<a id="t11"></a>

### T11 · Autonome Offline-Verfügbarkeit [V]

Mehrere Bezeichnungen beziehen sich auf die Nutzbarkeit ohne Netzwerk. Den in K2 eingeführten Begriff „autonome Offline-Verfügbarkeit“ für die Anforderung verwenden. „Lokale Nutzbarkeit“ ist weiter und beweist allein keine Netzunabhängigkeit; für die Kollaborationssitzung gilt zudem die in K5/K6 beschriebene Einschränkung.

- **Offline-Fähigkeit** – [K1 Z.40](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:40>).
- **Autonome Offline-Verfügbarkeit** – [K2 Z.123](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:123>), [K4 Z.135](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:135>), [K4 Z.174](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:174>), [K4 Z.176](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:176>), [K7 Z.61](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:61>).
- **Offline-by-Default** – [K2 Z.123](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:123>).
- **Offline by Default** – [K3 Z.71](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:71>).
- **lokale Nutzung** – [K4 Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:31>), [K5 Z.1044](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1044>).
- **lokale Nutzbarkeit** – [K6 Z.6](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:6>).
- **lokalen Nutzung** – [K6 Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:54>), [K6 Z.165](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:165>).
- **Offline-Verfügbarkeit** – [K6 Z.347](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:347>).
- **Offline-Betrieb** – [K7 Z.17](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:17>).

<a id="t12"></a>

### T12 · Datensynchronisation [V]

Schreibweisen und Wortbildung wechseln durchgehend. Vorschlag: „Synchronisation“, insbesondere „kollaborative Synchronisation“. Den fachlichen Gesamtabgleich von der technischen Replikation unterscheiden. „Synchronisation“ zwischen Schema und Code in K2 Z.103 ist ein anderer Bezug.

- **Synchronisierung** – [K1 Z.41](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:41>), [K3 Z.72](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:72>), [K3 Z.75](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:75>), [K3 Z.83](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:83>), [K5 Z.346](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:346>), [K5 Z.510](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:510>), [K5 Z.514](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:514>), [K5 Z.552](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:552>), [K5 Z.585](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:585>), [K5 Z.1033](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1033>), [K5 Z.1046](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1046>), [K5 Z.1047](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1047>), [K5 Z.1063](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1063>), [K7 Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:37>), [K7 Z.61](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:61>).
- **Synchronisation** – [K2 Z.103](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:103>), [K2 Z.126](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:126>).
- **Datensynchronisation** – [K2 Z.114](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:114>).
- **Hintergrundsynchronisation** – [K2 Z.118](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:118>).
- **kollaborative Datenabgleiche** – [K2 Z.118](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:118>).
- **kollaborative Synchronisation** – [K2 Z.127](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:127>), [K4 Z.118](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:118>), [K4 Z.137](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:137>), [K4 Z.180](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:180>), [K4 Z.196](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:196>).
- **Synchronisations-Engines** – [K2 Z.132](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:132>).
- **Synchronisierungsinfrastruktur** – [K3 Z.85](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:85>).
- **Local-First-Synchronisierung** – [K5 Z.508](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:508>).
- **Local-First-Synchronisation** – [K5 Z.543](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:543>).
- **Abgleich zwischen Geräten** – [K5 Z.559](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:559>).
- **geräteübergreifende Abgleich** – [K5 Z.563](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:563>).
- **Kollaborative Synchronisierung** – [K6 Z.306](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:306>), [K6 Z.349](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:349>).

<a id="t13"></a>

### T13 · Design Science Research [E]

In K1 eingeführte Langform und Abkürzung desselben Forschungsansatzes. Nach Einführung „DSR“ oder konsequent die Langform verwenden. Das Prozessmodell nach Peffers ist ein Modell innerhalb dieses Forschungsrahmens.

- **Design Science Research** – [K1 Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:46>), [K3 Z.9](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:9>).
- **DSR** – [K1 Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:46>).
- **DSR-Ansatzes** – [K1 Z.49](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:49>).

<a id="t14"></a>

### T14 · Forschungsrahmen / Forschungsansatz [P]

Meist Bezug auf DSR, aber „gestaltungsorientierter Forschungsansatz“ ist die übergeordnete Einordnung. Forschungsansatz, Forschungsrahmen und konkretes Prozessmodell nicht ohne Definition gleichsetzen.

- **methodischen Rahmen** – [K1 Z.49](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:49>).
- **DSR-Ansatzes** – [K1 Z.49](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:49>).
- **Forschungsansatz** – [K3 Z.5](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:5>), [K3 Z.7](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:7>).
- **Forschungsrahmen** – [K3 Z.9](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:9>).
- **Forschungsrahmens** – [K3 Z.62](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:62>).

<a id="t15"></a>

### T15 · Demonstrator und Artefakt [P]

„Artefakt“ ist mehrdeutig: In K2 das generierte Softwareprodukt, in K1/K4 teilweise das Arbeitsergebnis, während K3 Leitfaden und technischen Demonstrator unterscheidet. „Technischer Demonstrator“ für die Electron-Anwendung, „Migrationsleitfaden“ für das abgeleitete Ergebnis, „Webprototyp“ für die Ausgangssoftware verwenden. Nicht global vereinheitlichen.

- **Validierungsobjekt** – [K1 Z.32](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:32>).
- **Artefakten** – [K1 Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:36>).
- **Artefakt** – [K1 Z.50](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:50>).
- **Artefakts** – [K1 Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:51>).
- **Softwareartefakt** – [K2 Z.8](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:8>).
- **Artefakte** – [K2 Z.16](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:16>).
- **Softwareartefakte** – [K2 Z.26](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:26>).
- **technischer Demonstrator** – [K3 Z.18](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:18>).
- **Demonstrators** – [K3 Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:39>), [K4 Z.209](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:209>), [K6 Z.2](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:2>).
- **Demonstrator** – [K4 Z.196](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:196>), [K4 Z.204](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:204>), [K4 Z.211](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:211>), [K5 Z.66](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:66>), [K5 Z.98](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:98>), [K5 Z.105](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:105>), [K5 Z.343](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:343>), [K5 Z.547](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:547>), [K5 Z.566](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:566>), [K5 Z.703](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:703>), [K5 Z.774](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:774>), [K5 Z.1011](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1011>), [K5 Z.1021](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1021>), [K5 Z.1083](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1083>), [K6 Z.321](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:321>), [K6 Z.356](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:356>).

<a id="t16"></a>

### T16 · Vorversuch [P]

„Vorversuch“ in K3/K7 meint den frühen LLM-Migrationsversuch. „Vorprüfung“ und „zwei Prototypen“ in K5 meinen spätere technische PowerSync-Erprobungen. Beide Arten vorläufiger Untersuchungen ausdrücklich auseinanderhalten.

- **Vorversuch** – [K3 Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:37>), [K3 Z.56](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:56>), [K7 Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:21>), [K7 Z.59](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:59>).
- **erster Migrationsversuch** – [K3 Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:39>).
- **Vorversuchs** – [K5 Z.151](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:151>), [K7 Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:22>).
- **Vorprüfung** – [K5 Z.555](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:555>), [K5 Z.743](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:743>), [K5 Z.985](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:985>), [K5 Z.1048](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1048>).
- **Prototypen** – [K5 Z.557](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:557>).
- **Prototyptabelle** – [K5 Z.744](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:744>), [K5 Z.768](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:768>).

<a id="t17"></a>

### T17 · Geschäftslogik [V]

Die Service-Verantwortung heißt Geschäftslogik, Fachlogik oder fachliche Verarbeitung. Vorschlag: „Geschäftslogik“. Fachliche Regeln sind ihr Inhalt; fachliche Verarbeitung kann einen gesamten Ablauf bezeichnen. Nur bei gleichem Schichtbezug vereinheitlichen.

- **Geschäftslogik** – [K3 Z.29](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:29>), [K3 Z.67](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:67>), [K4 Z.9](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:9>), [K4 Z.133](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:133>), [K4 Z.157](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:157>), [K4 Z.158](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:158>), [K5 Z.336](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:336>).
- **Fachlogik** – [K3 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:45>), [K5 Z.425](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:425>), [K5 Z.978](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:978>), [K5 Z.1009](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1009>), [K5 Z.1017](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1017>), [K6 Z.108](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:108>), [K6 Z.342](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:342>).
- **fachliche Regeln** – [K3 Z.53](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:53>), [K4 Z.128](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:128>), [K6 Z.16](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:16>).
- **serverseitige Anwendungslogik** – [K4 Z.27](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:27>).
- **fachlichen Regeln** – [K4 Z.132](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:132>), [K5 Z.409](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:409>), [K5 Z.448](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:448>).
- **fachliche Logik** – [K5 Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:39>).
- **fachliche Verarbeitung** – [K5 Z.863](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:863>), [K6 Z.92](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:92>), [K6 Z.106](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:106>), [K6 Z.301](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:301>).
- **fachlichen Verarbeitung** – [K5 Z.922](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:922>), [K6 Z.123](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:123>).

Zusätzlich in Abbildungen:

- **Fachliche Verarbeitung** – K4, [original-web-architecture.svg Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:58>); Beschriftung: „Fachliche Verarbeitung“.
- **Fachliche Logik** – K5, [api-interface-migration.svg Z.77](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:77>); Beschriftung: „Fachliche Logik und Datenzugriff“.
- **Fachlogik** – K5, [api-interface-migration.svg Z.91](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:91>); Beschriftung: „Fachlogik und Drizzle-Datenzugriff“.
- **Fachliche Verarbeitung** – K5, [ipc-dispatcher-flow.svg Z.57](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:57>); Beschriftung: „Fachliche Verarbeitung“.
- **Fachliche Regeln** – K5, [grades-crud-flow.svg Z.52](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:52>); Beschriftung: „Fachliche Regeln und Aktivitäten“.
- **Fachlogik** – K5, [collaboration-modules.svg Z.63](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:63>); Beschriftung: „Sitzung, Lebenszyklus und Fachlogik“.

<a id="t18"></a>

### T18 · Verarbeitungspfad [V]

Die wiederkehrenden Kategorien werden Muster, Pfade und Interaktionsformen genannt. Vorschlag: „Verarbeitungsmuster“ für die fünf Kategorien, „Verarbeitungspfad“ für einen konkreten Ablauf und „Aufrufweg“ nur für die technische Aufrufkette. Das sind eng verwandte, aber nicht immer identische Begriffe.

- **Verarbeitungspfad** – [K3 Z.49](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:49>), [K4 Z.159](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:159>), [K5 Z.375](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:375>), [K5 Z.1014](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1014>).
- **Verarbeitungsmuster** – [K4 Z.89](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:89>), [K4 Z.121](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:121>), [K4 Z.194](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:194>), [K6 Z.284](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:284>), [K6 Z.286](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:286>), [K6 Z.299](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:299>), [K6 Z.312](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:312>), [K6 Z.318](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:318>), [K6 Z.353](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:353>).
- **Verarbeitungspfaden** – [K4 Z.111](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:111>), [K4 Z.153](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:153>), [K4 Z.198](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:198>), [K4 Z.199](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:199>).
- **Verarbeitungspfade** – [K4 Z.116](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:116>), [K4 Z.196](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:196>).
- **Aufrufweg** – [K4 Z.172](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:172>), [K5 Z.158](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:158>), [K5 Z.189](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:189>), [K5 Z.324](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:324>), [K5 Z.328](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:328>), [K5 Z.382](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:382>), [K5 Z.401](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:401>), [K6 Z.111](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:111>).
- **Verarbeitungsmustern** – [K4 Z.204](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:204>).
- **Kernabläufe** – [K5 Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:22>), [K5 Z.506](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:506>).
- **Aufrufwege** – [K5 Z.163](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:163>).
- **Verarbeitungspfads** – [K5 Z.446](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:446>).
- **CRUD-Aufrufweg** – [K5 Z.460](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:460>).
- **Interaktionsformen** – [K5 Z.980](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:980>), [K5 Z.1098](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1098>).
- **Kernablauf** – [K5 Z.1013](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1013>).
- **Bearbeitungsabläufe** – [K6 Z.317](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:317>).

<a id="t19"></a>

### T19 · CRUD-Verarbeitung [V]

K4 bündelt die persönliche Datenbearbeitung als CRUD-Verarbeitung; K6 nennt dieselbe Kategorie „Lokale Datenbearbeitung“. Vorschlag: „Lokale CRUD-Verarbeitung“. CRUD-Abfragen sind einzelne technische Zugriffe innerhalb dieser Kategorie.

- **CRUD-Verarbeitung** – [K4 Z.112](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:112>), [K4 Z.196](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:196>), [K5 Z.1021](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1021>).
- **CRUD-Funktionen** – [K5 Z.399](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:399>).
- **CRUD-Operationen** – [K5 Z.402](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:402>).
- **CRUD-Abfragen** – [K5 Z.561](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:561>).
- **CRUD-Verhalten** – [K5 Z.1106](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1106>).
- **Lokale Datenbearbeitung** – [K6 Z.300](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:300>).

<a id="t20"></a>

### T20 · Notenverwaltung [V]

Dasselbe durchgehende Beispiel erscheint unter mehreren Namen. Für den Funktionsbereich „Notenverwaltung“ verwenden; Erfassung ist nur ein Teilablauf. „Notenrouten“ bezeichnet ausdrücklich die ursprüngliche Implementierung.

- **Notenverwaltung** – [K5 Z.399](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:399>), [K5 Z.402](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:402>), [K5 Z.403](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:403>), [K5 Z.1021](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1021>), [K6 Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:23>), [K6 Z.91](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:91>), [K6 Z.119](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:119>).
- **Notenbeispiel** – [K5 Z.421](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:421>).
- **Notenrouten** – [K5 Z.433](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:433>).
- **Notenerfassung** – [K5 Z.453](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:453>), [K5 Z.460](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:460>).
- **Notenpfad** – [K6 Z.106](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:106>).
- **Notenverarbeitung** – [K6 Z.109](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:109>), [K6 Z.342](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:342>).

<a id="t21"></a>

### T21 · Kalendereinträge / Termine [V]

Im persönlichen Kalender sind Kalendertermine, Termine und Kalendereinträge meist dieselben Datensätze. Vorschlag: „Kalendereinträge“ oder „Termine“. Fristen, nächste Termine im Dashboard und das Terminschema sind je nach Kontext Anzeige/Teilmenge/Struktur, keine eigenen Synonyme.

- **Termine** – [K4 Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:58>), [K4 Z.60](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:60>), [K4 Z.104](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:104>), [K5 Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:51>), [K5 Z.470](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:470>), [K5 Z.497](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:497>).
- **Kalendertermine** – [K4 Z.70](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:70>).
- **Termindaten** – [K5 Z.232](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:232>).
- **Kalendereinträge** – [K6 Z.41](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:41>).

Zusätzlich in Abbildungen:

- **Termine** – K5, [local-file-import-flow.svg Z.43](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-file-import-flow.svg:43>); Beschriftung: „Inhalt parsen, Termine zuordnen“.

<a id="t22"></a>

### T22 · Studiengangskatalog [V]

„Studiengangkatalog“ in K3 und „Studiengangskatalog“ in K5/K6 benennen denselben Katalog. Katalogdaten/Studiengangsdaten verweisen auf seinen Inhalt. Seed-/Grundbestand sind nur die mitgelieferte Teilmenge; „Referenzdaten“ umfasst zusätzlich Stundenplanvorlagen. Vorschlag: „Studiengangskatalog“ und „Katalogdaten“, Teilmengen ausdrücklich benennen.

- **Referenzdaten** – [K2 Z.126](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:126>), [K4 Z.117](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:117>), [K5 Z.143](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:143>), [K5 Z.773](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:773>), [K5 Z.996](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:996>), [K5 Z.1037](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1037>), [K5 Z.1043](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1043>).
- **Studiengangkatalogs** – [K3 Z.82](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:82>).
- **Studiengangsdaten** – [K5 Z.510](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:510>), [K5 Z.794](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:794>), [K5 Z.842](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:842>), [K6 Z.129](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:129>).
- **Seed-Bestand** – [K5 Z.774](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:774>).
- **Grundbestand** – [K5 Z.774](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:774>), [K5 Z.1043](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1043>), [K5 Z.1044](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1044>).
- **Katalogdaten** – [K5 Z.789](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:789>), [K6 Z.147](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:147>).
- **Katalogabruf** – [K5 Z.799](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:799>).
- **Studiengangskatalog** – [K5 Z.1044](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1044>), [K6 Z.131](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:131>), [K6 Z.304](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:304>).
- **Katalogbestand** – [K6 Z.170](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:170>).

<a id="t23"></a>

### T23 · Lehrveranstaltungen / Kurse / Module [P]

K4 Z.68/76 spricht bei Studiengängen von Modulen, K5 Z.143/776/779 von Lehrveranstaltungen und K6 Z.153 von Kursen. Hier besteht ein auffälliger fachlicher Begriffswechsel. Prüfen, ob jeweils dieselben Katalogeinträge gemeint sind; Module können fachlich mehrere Lehrveranstaltungen umfassen. Technische TypeScript-Module gehören nicht hierher.

- **Kurs-** – [K4 Z.62](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:62>).
- **Kurszugehörigkeit** – [K4 Z.62](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:62>).
- **Kursen** – [K4 Z.64](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:64>).
- **Module** – [K4 Z.68](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:68>), [K4 Z.76](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:76>).
- **Lehrveranstaltungen** – [K5 Z.143](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:143>), [K5 Z.776](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:776>), [K5 Z.779](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:779>).
- **Kurse** – [K6 Z.153](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:153>).

<a id="t24"></a>

### T24 · Studiengruppen und synchronisierter Gruppenbereich [P]

Der neue synchronisierte Bereich heißt Kollaborationsbereich, synchronisierter Bereich oder „Gruppen (Sync)“. Vorschlag: „synchronisierter Studiengruppenbereich“. Bestehende lokale Gruppen unter /gruppen sind eine getrennte Implementierung und dürfen nicht automatisch denselben Namen erhalten.

- **Studiengruppen** – [K1 Z.34](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:34>), [K3 Z.84](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:84>), [K4 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:45>), [K4 Z.69](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:69>), [K4 Z.76](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:76>), [K4 Z.118](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:118>), [K4 Z.137](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:137>), [K4 Z.180](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:180>), [K5 Z.510](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:510>), [K5 Z.585](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:585>), [K5 Z.627](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:627>).
- **Kollaborationsfall** – [K3 Z.84](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:84>).
- **Kollaborationsbereich** – [K5 Z.570](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:570>), [K5 Z.576](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:576>), [K5 Z.580](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:580>), [K5 Z.595](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:595>), [K5 Z.597](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:597>), [K5 Z.714](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:714>).
- **synchronisierten Bereich** – [K5 Z.581](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:581>), [K5 Z.613](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:613>), [K5 Z.731](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:731>).
- **Kollaborationsmodule** – [K5 Z.622](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:622>).
- **synchronisierten Bereichs** – [K5 Z.657](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:657>).
- **Kollaborationsintegration** – [K5 Z.686](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:686>).
- **Kollaborationsbereichs** – [K5 Z.1050](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1050>).
- **synchronisierten Gruppenbereich** – [K7 Z.42](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:42>).

<a id="t25"></a>

### T25 · Gemeinsame Aufgaben / Gruppenaufgaben [V]

Für dieselben kollaborativen Aufgabendatensätze wechseln gemeinsame Aufgaben, Gruppenaufgaben und synchronisierte Aufgaben. Vorschlag: „gemeinsame Gruppenaufgaben“. Aufgabenänderung und Aufgabenbearbeitung bezeichnen die Vorgänge daran.

- **gemeinsame Aufgaben** – [K4 Z.70](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:70>), [K4 Z.182](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:182>), [K6 Z.306](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:306>), [K7 Z.7](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:7>), [K7 Z.64](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:64>).
- **gemeinsamer Aufgaben** – [K4 Z.118](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:118>), [K5 Z.510](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:510>), [K5 Z.649](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:649>).
- **Aufgabenänderungen** – [K4 Z.183](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:183>), [K5 Z.514](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:514>), [K5 Z.591](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:591>), [K6 Z.172](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:172>), [K6 Z.238](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:238>), [K6 Z.350](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:350>).
- **Synchronisierte Aufgaben** – [K5 Z.24](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:24>).
- **synchronisierte Gruppenaufgaben** – [K5 Z.794](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:794>).
- **Aufgabenbearbeitung** – [K6 Z.202](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:202>).
- **gemeinsame Gruppenaufgaben** – [K7 Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:37>).

Zusätzlich in Abbildungen:

- **Gruppenaufgaben** – K5, [local-first-architecture.svg Z.85](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:85>); Beschriftung: „Gezeigter Stand: persönliche Daten lokal; Gruppenaufgaben synchronisiert.“.

<a id="t26"></a>

### T26 · Unmittelbar netzwerkabhängige Verwaltungsoperationen [V]

Gruppenerstellung, Profilsuche und Einladungen werden wechselnd so gebündelt. Vorschlag: „netzwerkabhängige Gruppenverwaltung“ als Kategorie. Direkte Online-RPCs sind deren technische Umsetzung. Ein allgemeiner Online-Aufruf kann auch den Katalog betreffen.

- **unmittelbar netzwerkabhängige Verwaltungsoperationen** – [K4 Z.119](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:119>), [K4 Z.197](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:197>).
- **administrative Gruppenfunktionen** – [K5 Z.593](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:593>).
- **unmittelbar netzwerkabhängige Gruppenaktionen** – [K5 Z.799](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:799>).
- **Online-Abläufe** – [K6 Z.175](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:175>).
- **Online-Aktionen** – [K6 Z.229](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:229>).
- **Verwaltungsaktionen** – [K6 Z.238](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:238>).
- **Online-Aktion** – [K6 Z.308](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:308>).

Zusätzlich in Abbildungen:

- **Online-RPCs** – K5, [local-first-architecture.svg Z.67](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:67>); Beschriftung: „Online-RPCs“.

<a id="t27"></a>

### T27 · Einseitige Datenübernahme [V]

Der Katalog-Verarbeitungstyp heißt u. a. unidirektionale Übernahme, Datenübernahme und Online-Datenabruf. Vorschlag: „einseitige Datenübernahme“ für das Muster. Ein Download ist nur der Empfangsschritt; lokale Validierung und Speicherung gehören ebenfalls dazu.

- **unidirektionalen Übernahme** – [K2 Z.126](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:126>).
- **einfachen Datenübernahme** – [K2 Z.126](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:126>).
- **Herunterladen externer Daten** – [K3 Z.82](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:82>).
- **einseitige Übernahme** – [K4 Z.117](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:117>).
- **einseitige Datenübernahme** – [K4 Z.196](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:196>), [K6 Z.304](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:304>).
- **Online-Datenabruf** – [K5 Z.771](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:771>).
- **einseitigen Datenabruf** – [K5 Z.773](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:773>).
- **Einseitige Übernahme von Studiengangsdaten** – [K6 Z.129](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:129>).
- **externe Datenübernahme** – [K6 Z.318](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:318>).

<a id="t28"></a>

### T28 · Dateiimport [V]

Dieselbe Musterfamilie wird als Dateiimport und über die betroffenen UI-Bereiche benannt. Vorschlag: „Dateiimport“ als Oberbegriff, „iCal-Import“ und „CSV-Notenimport“ als konkrete Fälle. Beide Formate bleiben getrennt.

- **Dateiimporte** – [K4 Z.196](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:196>), [K5 Z.505](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:505>), [K5 Z.1023](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1023>), [K6 Z.318](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:318>).
- **Lokaler Dateiimport** – [K5 Z.467](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:467>).
- **Importablauf** – [K5 Z.484](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:484>).
- **Notenimport** – [K5 Z.503](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:503>).
- **Importmuster** – [K5 Z.503](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:503>).
- **Kalender- und Notenimport** – [K6 Z.61](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:61>), [K6 Z.75](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:75>), [K6 Z.302](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:302>).
- **Dateiimport** – [K6 Z.61](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:61>), [K6 Z.302](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:302>).
- **Kalender- und Notenimporte** – [K6 Z.84](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:84>).

<a id="t29"></a>

### T29 · iCal-Import / ICS-Import [V]

Für den Kalenderdateiimport wechseln iCal und ICS. Vorschlag: einmal „iCal-Import (ICS-Dateien)“ definieren, danach „iCal-Import“. CSV-Notenimport ist der andere Anwendungsfall desselben Musters und kein Synonym.

- **iCal-/ICS-Import** – [K4 Z.60](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:60>).
- **iCal-/ICS-Importe** – [K4 Z.114](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:114>).
- **iCal-Import** – [K5 Z.487](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:487>).
- **CSV-Notenimport** – [K5 Z.503](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:503>).
- **Kalender- und Notenimport** – [K6 Z.61](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:61>), [K6 Z.75](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:75>), [K6 Z.302](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:302>).
- **Kalender- und Notenimporte** – [K6 Z.84](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:84>).

<a id="t30"></a>

### T30 · Native Dateiauswahl [V]

Dateiauswahl bezeichnet den Schritt, Dateidialog das UI-Mittel. Vorschlag: „native Dateiauswahl“ im Prozess und „nativer Dateidialog“ für das Fenster. Dieser Unterschied ist sinnvoll, wechselnde lokal/native-Attribute sind meist unnötig.

- **native Dateiauswahl** – [K5 Z.482](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:482>).
- **nativer Dateiauswahl** – [K5 Z.487](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:487>).
- **Dateiauswahl** – [K5 Z.490](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:490>), [K5 Z.1024](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1024>), [K5 Z.1029](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1029>), [K6 Z.80](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:80>), [K6 Z.303](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:303>).
- **lokale Dateiauswahl** – [K6 Z.63](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:63>).

Zusätzlich in Abbildungen:

- **Nativer Dateidialog** – K5, [local-file-import-flow.svg Z.25](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-file-import-flow.svg:25>); Beschriftung: „Nativer Dateidialog“.
- **Dateidialog** – K5, [local-file-import-flow.svg Z.33](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-file-import-flow.svg:33>); Beschriftung: „2. Dateidialog öffnen“.
- **Dateiauswahl** – K5, [local-file-import-flow.svg Z.41](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-file-import-flow.svg:41>); Beschriftung: „4. Nur bei Dateiauswahl“.

<a id="t31"></a>

### T31 · Main-Prozess [E]

Hauptprozess und Main-Prozess benennen denselben Electron-Prozesstyp. Vorschlag: „Main-Prozess“. Haupt-Thread in K5 Z.717 ist dagegen ein Thread innerhalb der Laufzeit und kein Synonym.

- **Main-Prozess** – [K1 Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:23>), [K2 Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:54>), [K3 Z.69](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:69>), [K4 Z.170](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:170>), [K5 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:45>), [K5 Z.53](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:53>), [K5 Z.323](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:323>), [K5 Z.390](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:390>), [K5 Z.391](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:391>), [K5 Z.442](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:442>), [K5 Z.577](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:577>), [K5 Z.659](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:659>), [K5 Z.679](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:679>), [K5 Z.782](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:782>), [K5 Z.815](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:815>), [K5 Z.1025](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1025>), [K5 Z.1038](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1038>).
- **Hauptprozess** – [K2 Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:36>).
- **Main Process** – [K2 Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:36>).
- **Electron-Hauptprozesses** – [K2 Z.109](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:109>).
- **Electron-Main-Prozess** – [K5 Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:39>), [K5 Z.515](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:515>), [K5 Z.558](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:558>).
- **Main-Prozesses** – [K5 Z.336](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:336>).
- **Haupt-Threads** – [K5 Z.717](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:717>).

Zusätzlich in Abbildungen:

- **Main-Prozess** – K2, [electron-architecture-comparison.svg Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:58>); Beschriftung: „Main-Prozess“.
- **Main-Prozess** – K2, [electron-architecture-comparison.svg Z.67](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:67>); Beschriftung: „ohne Vermittlung über den Main-Prozess“.
- **Main-Prozess** – K2, [electron-architecture-comparison.svg Z.73](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:73>); Beschriftung: „Der Main-Prozess bleibt in beiden Konfigurationen vorhanden; dargestellt sind die Zugriffspfade.“.
- **Main-Prozess** – K5, [api-interface-migration.svg Z.81](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:81>); Beschriftung: „Main-Prozess“.
- **Main-Prozess** – K5, [ipc-dispatcher-flow.svg Z.35](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:35>); Beschriftung: „Fester Kanal zum Main-Prozess“.
- **Main-Prozess** – K5, [ipc-dispatcher-flow.svg Z.38](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:38>); Beschriftung: „Main-Prozess“.
- **Main-Prozess** – K5, [grades-crud-flow.svg Z.32](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:32>); Beschriftung: „Aufruf an den Main-Prozess“.
- **Main-Prozess** – K5, [grades-crud-flow.svg Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:37>); Beschriftung: „Main-Prozess“.
- **Main-Prozess** – K5, [local-file-import-flow.svg Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-file-import-flow.svg:21>); Beschriftung: „Main-Prozess“.
- **Main-Prozess** – K5, [local-file-import-flow.svg Z.50](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-file-import-flow.svg:50>); Beschriftung: „Dateipfad und Dateiinhalt bleiben im Main-Prozess.“.
- **Main-Prozess** – K5, [local-first-architecture.svg Z.28](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:28>); Beschriftung: „Main-Prozess“.
- **Main-Prozess** – K5, [collaboration-modules.svg Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:37>); Beschriftung: „Main-Prozess“.

<a id="t32"></a>

### T32 · Renderer-Prozess [E]

Darstellungsprozess, Renderer-Prozess und die Kurzform Renderer sind dieselbe Electron-Rolle. Vorschlag: einmal „Renderer-Prozess“, danach „Renderer“. Benutzeroberfläche und Browser sind nicht automatisch Synonyme dafür.

- **Renderer** – [K1 Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:23>), [K2 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:48>), [K3 Z.69](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:69>), [K3 Z.95](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:95>), [K4 Z.140](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:140>), [K4 Z.170](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:170>), [K5 Z.212](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:212>), [K5 Z.323](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:323>), [K5 Z.331](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:331>), [K5 Z.349](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:349>), [K5 Z.350](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:350>), [K5 Z.353](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:353>), [K5 Z.355](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:355>), [K5 Z.359](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:359>), [K5 Z.373](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:373>), [K5 Z.394](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:394>), [K5 Z.483](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:483>), [K5 Z.815](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:815>), [K5 Z.845](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:845>), [K5 Z.853](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:853>), [K5 Z.933](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:933>), [K5 Z.1005](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1005>).
- **Darstellungsprozessen** – [K2 Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:36>).
- **Renderer Processes** – [K2 Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:36>).
- **Darstellungsprozess** – [K2 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:45>).
- **Renderer-Prozess** – [K5 Z.353](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:353>).

Zusätzlich in Abbildungen:

- **Renderer-Prozess** – K2, [electron-architecture-comparison.svg Z.34](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:34>); Beschriftung: „Renderer-Prozess“.
- **Renderer-Prozess** – K2, [electron-architecture-comparison.svg Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:46>); Beschriftung: „Renderer-Prozess“.
- **Renderer** – K2, [electron-architecture-comparison.svg Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:51>); Beschriftung: „Node.js-APIs im Renderer“.
- **Renderer** – K5, [api-interface-migration.svg Z.56](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:56>); Beschriftung: „Renderer / React“.
- **Renderer** – K5, [ipc-dispatcher-flow.svg Z.18](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:18>); Beschriftung: „Renderer“.
- **Renderer** – K5, [grades-crud-flow.svg Z.18](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:18>); Beschriftung: „Renderer / React“.
- **Renderer** – K5, [local-file-import-flow.svg Z.18](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-file-import-flow.svg:18>); Beschriftung: „Renderer“.
- **Renderer** – K5, [local-first-architecture.svg Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:21>); Beschriftung: „Renderer“.
- **Renderer** – K5, [collaboration-modules.svg Z.24](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:24>); Beschriftung: „Renderer: vorhandene Seiten und synchronisierte Gruppenansicht“.

<a id="t33"></a>

### T33 · Preload-Schnittstelle [V]

Schnittstelle und Bridge werden für den freigegebenen Prozesszugang verwendet. Vorschlag: „Preload-Schnittstelle“, bei den zwei Zugängen „API-Preload-Schnittstelle“ und „Kollaborations-Preload-Schnittstelle“. Preload-Skript und IPC-Transport sind verschiedene Bestandteile dieses Zugangs.

- **Preload-Schnittstellen** – [K3 Z.95](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:95>), [K4 Z.170](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:170>), [K5 Z.863](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:863>), [K6 Z.113](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:113>), [K6 Z.346](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:346>).
- **Begrenzte Bridge** – [K5 Z.203](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:203>).
- **Preload-Schnittstelle** – [K5 Z.321](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:321>).
- **Preload-Bridge** – [K5 Z.331](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:331>).
- **Preload-/IPC-Schnittstellen** – [K5 Z.577](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:577>).
- **API- und Kollaborationsbridge** – [K5 Z.948](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:948>).
- **Preload-Bridges** – [K5 Z.1071](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1071>).

Zusätzlich in Abbildungen:

- **Preload-Bridge** – K5, [api-interface-migration.svg Z.66](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:66>); Beschriftung: „Preload-Bridge“.
- **Preload-Bridge** – K5, [ipc-dispatcher-flow.svg Z.32](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:32>); Beschriftung: „Preload-Bridge“.
- **Begrenzte Bridge** – K5, [grades-crud-flow.svg Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:31>); Beschriftung: „Begrenzte Bridge“.
- **Preload-/IPC-Schnittstelle** – K5, [local-first-architecture.svg Z.25](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:25>); Beschriftung: „Begrenzte Preload-/IPC-Schnittstelle“.

<a id="t34"></a>

### T34 · IPC-Dispatcher [V]

Im lokalen API-Aufrufweg ist jeweils der zentrale Dispatcher gemeint. Vorschlag: „API-Dispatcher“. IPC bezeichnet den Transport; es gibt außerdem einen separaten Kollaborationseingang. Dispatcher und Handler nicht gleichsetzen.

- **Dispatcher** – [K5 Z.321](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:321>), [K5 Z.335](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:335>), [K5 Z.382](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:382>), [K5 Z.463](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:463>), [K5 Z.465](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:465>), [K5 Z.897](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:897>), [K5 Z.923](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:923>).
- **zentralen Dispatcher** – [K5 Z.324](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:324>).
- **API-Dispatcher** – [K5 Z.328](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:328>).
- **Dispatchers** – [K5 Z.408](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:408>).
- **IPC-Dispatcher** – [K5 Z.440](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:440>).

Zusätzlich in Abbildungen:

- **API-Dispatcher** – K5, [api-interface-migration.svg Z.83](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:83>); Beschriftung: „API-Dispatcher“.
- **API-Dispatcher** – K5, [ipc-dispatcher-flow.svg Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:46>); Beschriftung: „API-Dispatcher“.
- **Dispatcher** – K5, [grades-crud-flow.svg Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:39>); Beschriftung: „Dispatcher“.
- **IPC-Dispatcher** – K5, [local-first-architecture.svg Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:31>); Beschriftung: „IPC-Dispatcher / Handler“.
- **api-dispatcher** – K5, [collaboration-modules.svg Z.41](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:41>); Beschriftung: „api-dispatcher.ts“.

<a id="t35"></a>

### T35 · Handler / Controller [V]

K4 Z.133 fordert Controller, K5 implementiert Handler; die Abbildung api-interface-migration.svg beschriftet „Handler / Controller“. Für die Zielarchitektur daher einmal die Rolle als Controller erklären und anschließend „Handler“ konsistent verwenden. Express-Route-Handler gehört zur ursprünglichen HTTP-Implementierung und ist nicht derselbe Baustein.

- **Handler** – [K2 Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:58>), [K5 Z.335](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:335>), [K5 Z.386](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:386>), [K5 Z.433](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:433>), [K5 Z.440](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:440>), [K5 Z.443](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:443>), [K5 Z.445](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:445>), [K5 Z.888](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:888>).
- **Route-Handlers** – [K4 Z.89](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:89>).
- **Express-Route-Handler** – [K4 Z.104](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:104>), [K5 Z.470](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:470>).
- **Route-Handler** – [K4 Z.107](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:107>).
- **Controller** – [K4 Z.133](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:133>).
- **Handlern** – [K5 Z.336](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:336>), [K5 Z.409](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:409>), [K5 Z.463](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:463>).
- **Handlergruppe** – [K5 Z.382](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:382>).
- **Operationsgruppe** – [K5 Z.387](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:387>).

Zusätzlich in Abbildungen:

- **Route-Handler** – K4, [original-web-architecture.svg Z.56](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:56>); Beschriftung: „Route-Handler“.
- **Route-Handler** – K5, [api-interface-migration.svg Z.75](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:75>); Beschriftung: „Zod-Prüfung und Route-Handler“.
- **Route-Handler** – K5, [api-interface-migration.svg Z.78](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:78>); Beschriftung: „im Route-Handler verbunden“.
- **Handler** – K5, [api-interface-migration.svg Z.87](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:87>); Beschriftung: „Handler / Controller“.
- **Controller** – K5, [api-interface-migration.svg Z.87](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:87>); Beschriftung: „Handler / Controller“.
- **Handler** – K5, [ipc-dispatcher-flow.svg Z.56](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:56>); Beschriftung: „4. Registrierten Handler aufrufen“.
- **Handler** – K5, [grades-crud-flow.svg Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:45>); Beschriftung: „Handler“.
- **Handler** – K5, [local-first-architecture.svg Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:31>); Beschriftung: „IPC-Dispatcher / Handler“.
- **Handler** – K5, [collaboration-modules.svg Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:45>); Beschriftung: „Handler und Services“.

<a id="t36"></a>

### T36 · API-Vertrag [V]

Für die gemeinsame Ausgangsdefinition wechseln API-Vertrag, OpenAPI-Vertrag und Spezifikation. Vorschlag: „OpenAPI-Vertrag“ für api/openapi.yaml. Der manuelle Kollaborationsvertrag in src/shared/collaboration/ipc.ts ist ein zweiter Vertrag; „API-Vertrag“ allein kann ab K5 mehrdeutig werden. OpenAPI als Standard bleibt vom konkreten Dokument zu unterscheiden.

- **API-Verträge** – [K1 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:48>), [K2 Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:21>).
- **API-Vertrag** – [K2 Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:23>), [K3 Z.43](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:43>), [K5 Z.1003](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1003>), [K6 Z.116](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:116>), [K7 Z.42](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:42>), [K7 Z.84](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:84>).
- **OpenAPI-Spezifikation** – [K2 Z.24](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:24>).
- **Schnittstellenbeschreibung** – [K2 Z.26](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:26>).
- **OpenAPI-Spezifikationen** – [K2 Z.28](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:28>).
- **Schnittstellendefinition** – [K2 Z.29](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:29>).
- **OpenAPI-Vertrag** – [K3 Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:54>), [K5 Z.148](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:148>), [K5 Z.314](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:314>), [K5 Z.779](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:779>).
- **API-Vertrags** – [K5 Z.146](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:146>).
- **Vertragsgrundlage** – [K5 Z.155](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:155>), [K5 Z.183](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:183>), [K5 Z.206](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:206>).
- **Vertragsbeschreibung** – [K5 Z.216](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:216>).
- **Vertragsformat** – [K5 Z.340](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:340>).
- **Vertragsdefinitionen** – [K5 Z.1007](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1007>).

Zusätzlich in Abbildungen:

- **API-Vertrag** – K4, [original-web-architecture.svg Z.20](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:20>); Beschriftung: „API-Vertrag und Codegenerierung · Entwicklungszeit“.
- **OpenAPI-Vertrag** – K4, [original-web-architecture.svg Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:22>); Beschriftung: „OpenAPI-Vertrag“.
- **API-Vertrag** – K5, [api-interface-migration.svg Z.19](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:19>); Beschriftung: „API-Vertrag als gemeinsame Ausgangsbasis“.
- **IPC-Vertrag** – K5, [grades-crud-flow.svg Z.27](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:27>); Beschriftung: „API-Client: Eingabe → IPC-Vertrag“.
- **API-Vertrag** – K5, [collaboration-modules.svg Z.42](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:42>); Beschriftung: „Generierter API-Vertrag“.
- **Modulvertrag** – K5, [collaboration-modules.svg Z.59](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:59>); Beschriftung: „Eigener Modulvertrag, Zod-Prüfung und lokale Sitzung“.

<a id="t37"></a>

### T37 · Operationskennung [E]

Deutscher Fachbegriff und technischer Bezeichner für dieselbe Kennung. Vorschlag: einmal „Operationskennung (operationId)“, danach im Fließtext „Operationskennung“. Code und API-Feldnamen unverändert lassen.

- **Operationskennungen** – [K5 Z.149](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:149>), [K5 Z.184](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:184>), [K5 Z.224](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:224>), [K5 Z.334](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:334>), [K5 Z.439](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:439>).
- **operationId** – [K5 Z.191](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:191>), [K5 Z.303](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:303>), [K5 Z.316](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:316>).
- **Operationskennung** – [K5 Z.222](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:222>), [K5 Z.863](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:863>).

Zusätzlich in Abbildungen:

- **Operationskennungen** – K5, [api-interface-migration.svg Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:22>); Beschriftung: „Operationskennungen, Parameter und Datenschemata“.
- **operationId** – K5, [ipc-dispatcher-flow.svg Z.26](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:26>); Beschriftung: „operationId + { path, query, body }“.
- **operationId** – K5, [ipc-dispatcher-flow.svg Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:51>); Beschriftung: „operationId → operationContracts“.

<a id="t38"></a>

### T38 · Eingabevalidierung [V]

Im Dispatcher werden diese Ausdrücke für die Vertragsprüfung der Eingaben verwendet. Vorschlag: „Eingabevalidierung“. Schemaprüfung kann auch Antworten betreffen, Validierung externer Dateien ist ein anderer Prüfort; diese Bezüge erhalten.

- **Validierung sämtlicher IPC-Nachrichten** – [K2 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:48>).
- **Eingabevalidierung** – [K3 Z.92](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:92>), [K5 Z.807](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:807>), [K5 Z.819](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:819>), [K5 Z.947](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:947>), [K6 Z.258](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:258>).
- **Schemaprüfung** – [K5 Z.203](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:203>), [K5 Z.922](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:922>), [K5 Z.949](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:949>).
- **Eingabeprüfung** – [K5 Z.408](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:408>).
- **Vertragsvalidierung** – [K5 Z.408](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:408>).

<a id="t39"></a>

### T39 · IPC-Absenderprüfung [V]

Absender und Sender benennen hier dieselbe Herkunftsprüfung. Vorschlag: „IPC-Absenderprüfung“. Die Dokumentpolicy bestimmt zulässige Dokumente und wird dabei verwendet, ist aber nicht selbst die gesamte Absenderprüfung.

- **Prüfung von IPC-Absendern** – [K4 Z.140](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:140>).
- **Absender- und Schemaprüfung** – [K5 Z.203](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:203>).
- **Senderprüfung** – [K5 Z.819](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:819>), [K5 Z.895](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:895>).
- **IPC-Senderprüfung** – [K5 Z.885](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:885>), [K5 Z.891](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:891>).

Zusätzlich in Abbildungen:

- **Absender-, Eingabe- und Ausgabeprüfung** – K5, [api-interface-migration.svg Z.84](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:84>); Beschriftung: „Absender-, Eingabe- und Ausgabeprüfung“.

<a id="t40"></a>

### T40 · Zod-Laufzeitschemata [V]

Für erzeugte Laufzeitprüfungen wechseln Schemata, Verträge und Validierungsschemata. Vorschlag: „Zod-Laufzeitschemata“. Der gesamte API-Vertrag, Eingabeschema und Ergebnisschema sind nicht deckungsgleich.

- **Laufzeitschemata** – [K3 Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:54>), [K5 Z.228](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:228>), [K5 Z.1008](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1008>), [K5 Z.1011](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1011>).
- **Zod-Schemata** – [K5 Z.154](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:154>), [K5 Z.199](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:199>), [K5 Z.679](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:679>).
- **Zod-Verträge** – [K5 Z.188](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:188>).
- **Zod-Laufzeitschemata** – [K5 Z.211](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:211>).
- **Zod-Laufzeitschema** – [K5 Z.274](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:274>).

Zusätzlich in Abbildungen:

- **Zod-Validierungsschemata** – K4, [original-web-architecture.svg Z.35](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:35>); Beschriftung: „Zod-Validierungsschemata“.
- **Zod-Schemata** – K5, [api-interface-migration.svg Z.40](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:40>); Beschriftung: „Zod-Schemata“.
- **Zod-Verträge** – K5, [api-interface-migration.svg Z.42](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:42>); Beschriftung: „und Zod-Verträge“.
- **Zod-Eingabeschema** – K5, [ipc-dispatcher-flow.svg Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:54>); Beschriftung: „Generiertes Zod-Eingabeschema“.

<a id="t41"></a>

### T41 · Codegenerierung [V]

Für das Verfahren wechseln Codegenerierung und Codeerzeugung. Vorschlag: „Codegenerierung“; „IPC-Codegenerator“ für das eigene Werkzeug. Toolchain umfasst mehrere Schritte, eine Generatorfunktion ist nur ein Bestandteil. Orval und eigener Generator sind verschiedene Werkzeuge.

- **Codegenerierung** – [K2 Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:21>), [K2 Z.28](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:28>), [K4 Z.86](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:86>), [K5 Z.146](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:146>), [K5 Z.163](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:163>), [K5 Z.186](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:186>).
- **TypeScript-Generatoren** – [K5 Z.155](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:155>), [K5 Z.188](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:188>).
- **Toolchain** – [K5 Z.209](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:209>), [K5 Z.347](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:347>).
- **OpenAPI-IPC-Codegenerierung** – [K5 Z.214](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:214>).
- **Codeerzeugung** – [K5 Z.216](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:216>).
- **Generatorfunktion** – [K5 Z.231](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:231>), [K5 Z.291](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:291>).
- **Generatoransatzes** – [K5 Z.338](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:338>).
- **Codegenerator** – [K5 Z.367](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:367>).

Zusätzlich in Abbildungen:

- **Codegenerierung** – K4, [original-web-architecture.svg Z.20](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:20>); Beschriftung: „API-Vertrag und Codegenerierung · Entwicklungszeit“.
- **Codegenerierung** – K4, [original-web-architecture.svg Z.77](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:77>); Beschriftung: „Codegenerierung / Einbindung“.
- **TypeScript-Generatoren** – K5, [api-interface-migration.svg Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:31>); Beschriftung: „TypeScript-Generatoren“.
- **Codegenerierung** – K5, [api-interface-migration.svg Z.107](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:107>); Beschriftung: „Codegenerierung / Einbindung“.

<a id="t42"></a>

### T42 · React-Query-Hooks [V]

„Aufrufhilfen“ in K3 Z.54 und „React-Query-Aufrufhilfen“ in der Webarchitektur beziehen sich auf die erzeugten Hooks. Vorschlag: „React-Query-Hooks“. React Query ist die Bibliothek, Query-Key-Hilfsfunktionen sind separate erzeugte Hilfsfunktionen.

- **Aufrufhilfen** – [K3 Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:54>).
- **Hooks** – [K5 Z.154](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:154>), [K5 Z.188](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:188>), [K5 Z.366](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:366>).
- **React Query** – [K5 Z.187](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:187>).
- **React-Query-Hooks** – [K5 Z.212](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:212>), [K5 Z.316](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:316>).
- **Query-Key-Hilfsfunktionen** – [K5 Z.212](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:212>).

Zusätzlich in Abbildungen:

- **React-Query-Aufrufhilfen** – K4, [original-web-architecture.svg Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:48>); Beschriftung: „React-Query-Aufrufhilfen“.
- **React-Query-Hooks** – K5, [api-interface-migration.svg Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:39>); Beschriftung: „React-Query-Hooks“.
- **React-Query-Hooks** – K5, [api-interface-migration.svg Z.41](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:41>); Beschriftung: „React-Query-Hooks“.
- **React-Query-Hooks** – K5, [api-interface-migration.svg Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:54>); Beschriftung: „Generierter Client und React-Query-Hooks“.
- **React-Query-Hooks** – K5, [api-interface-migration.svg Z.57](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:57>); Beschriftung: „Generierter Client und React-Query-Hooks“.
- **React Query** – K5, [ipc-dispatcher-flow.svg Z.20](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/ipc-dispatcher-flow.svg:20>); Beschriftung: „React Query“.
- **Hooks** – K5, [local-first-architecture.svg Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:22>); Beschriftung: „React-Oberfläche und generierte Hooks“.

<a id="t43"></a>

### T43 · Query Keys [E]

Englische Bezeichnung und zusammengesetzte Hilfsfunktionsnamen. Vorschlag im Fließtext: „Abfrageschlüssel (Query Key)“ einmal einführen, danach eine Schreibweise verwenden. Schlüssel und Funktion zur Erzeugung des Schlüssels bleiben verschieden.

- **Query-Key-Hilfsfunktionen** – [K5 Z.212](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:212>).
- **Query Keys** – [K5 Z.316](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:316>).
- **Query Key** – [K5 Z.394](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:394>).

<a id="t44"></a>

### T44 · Hash-Routing und Adressfragment [E]

K2 erläutert Hash-Routing über das Fragment; K5 nennt denselben Adressteil Adressfragment. Vorschlag: „Adressfragment“. Hash-Routing ist das Verfahren, Hash-Route eine konkrete Route und Fragment der verwendete URL-Bestandteil. Keine vollständigen Synonyme.

- **Hash-Routing** – [K2 Z.62](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:62>), [K2 Z.73](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:73>).
- **Fragment** – [K2 Z.73](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:73>), [K2 Z.74](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:74>).
- **Fragments** – [K2 Z.75](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:75>).
- **Adressfragment** – [K5 Z.373](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:373>).
- **Hash-Routen** – [K5 Z.890](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:890>).

<a id="t45"></a>

### T45 · Eigenes URL-Schema / Anwendungsprotokoll [V]

In der Beschreibung lokaler Ressourcen wechseln URL-Schema, Anwendungsschema und Protokoll. Vorschlag: „anwendungseigenes URL-Schema app:“; „Protokollhandler“ für die zuständige Funktion. Dieses Schema ist kein Datenbank- oder Zod-Schema.

- **eigene URL-Schemata** – [K2 Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:54>).
- **Schemaname** – [K2 Z.56](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:56>).
- **standardkonformes Schema** – [K2 Z.60](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:60>).
- **eigenen Anwendungsschema** – [K2 Z.77](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:77>).
- **eigene Protokoll** – [K5 Z.887](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:887>).

<a id="t46"></a>

### T46 · Rendererwurzel / Ressourcenverzeichnis [V]

Gemeint ist bei der Pfadbegrenzung das Verzeichnis der auszuliefernden Renderer-Ressourcen. Vorschlag: „Renderer-Ressourcenverzeichnis“. Der Benutzerdatenpfad ist ein anderer Speicherort.

- **Ressourcenverzeichnis** – [K2 Z.59](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:59>).
- **Rendererwurzel** – [K5 Z.866](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:866>), [K5 Z.888](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:888>).
- **dieser Wurzel** – [K5 Z.889](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:889>).

<a id="t47"></a>

### T47 · Drizzle ORM [E]

Die Kurzform Drizzle kann die ORM-Kernbibliothek oder die Werkzeugsuite meinen. „Drizzle ORM“ für Datenzugriff, „Drizzle Kit“ für CLI und Erzeugung von SQL-Migrationen verwenden. Drizzle Kit ist kein Synonym von Drizzle ORM.

- **Drizzle** – [K2 Z.94](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:94>), [K2 Z.96](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:96>), [K2 Z.97](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:97>), [K2 Z.102](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:102>), [K2 Z.106](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:106>), [K2 Z.109](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:109>), [K2 Z.110](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:110>), [K2 Z.112](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:112>), [K5 Z.42](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:42>), [K5 Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:51>), [K5 Z.64](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:64>), [K5 Z.77](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:77>), [K5 Z.78](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:78>), [K5 Z.103](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:103>), [K5 Z.106](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:106>), [K5 Z.122](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:122>), [K5 Z.139](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:139>), [K5 Z.385](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:385>), [K5 Z.409](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:409>), [K5 Z.430](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:430>), [K5 Z.515](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:515>), [K5 Z.534](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:534>), [K5 Z.555](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:555>), [K5 Z.561](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:561>), [K5 Z.565](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:565>), [K5 Z.627](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:627>), [K5 Z.707](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:707>), [K5 Z.730](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:730>), [K5 Z.749](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:749>), [K5 Z.907](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:907>), [K5 Z.1049](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1049>).
- **Drizzle ORM** – [K2 Z.96](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:96>), [K2 Z.100](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:100>).
- **Drizzle Kit** – [K2 Z.103](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:103>).
- **drizzle-kit** – [K5 Z.103](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:103>), [K5 Z.110](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:110>), [K5 Z.119](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:119>).

Zusätzlich in Abbildungen:

- **Drizzle** – K4, [original-web-architecture.svg Z.59](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:59>); Beschriftung: „Direkte Drizzle-Abfragen“.
- **Drizzle** – K5, [api-interface-migration.svg Z.91](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:91>); Beschriftung: „Fachlogik und Drizzle-Datenzugriff“.
- **Drizzle** – K5, [api-interface-migration.svg Z.94](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:94>); Beschriftung: „Drizzle / pg“.
- **Drizzle** – K5, [api-interface-migration.svg Z.96](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:96>); Beschriftung: „Drizzle / libSQL“.
- **Drizzle** – K5, [grades-crud-flow.svg Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:58>); Beschriftung: „Drizzle-Abfragen mit Benutzerbezug“.
- **Drizzle** – K5, [local-first-architecture.svg Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:39>); Beschriftung: „Drizzle / libSQL“.
- **Drizzle** – K5, [local-first-architecture.svg Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:45>); Beschriftung: „Drizzle / PowerSync“.
- **Drizzle-Kit** – K5, [local-first-architecture.svg Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:58>); Beschriftung: „Drizzle-Kit-Migrationen“.
- **Drizzle** – K5, [collaboration-modules.svg Z.49](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:49>); Beschriftung: „Repositories / Drizzle“.
- **Drizzle-Kit** – K5, [collaboration-modules.svg Z.55](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:55>); Beschriftung: „Drizzle-Kit-Migrationen“.
- **Drizzle** – K5, [collaboration-modules.svg Z.76](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:76>); Beschriftung: „Drizzle-Wrapper“.

<a id="t48"></a>

### T48 · Lokale Datenhaltung / Persistenz [V]

Datenhaltung, Persistenz und Speicherung überlappen als Funktionsbezeichnungen. Vorschlag: „lokale Datenhaltung“ für die Architekturverantwortung und „lokale Speicherung“ für den Vorgang. Ein Datenhaltungsbereich ist eine architektonische Abgrenzung, eine Datenbank die konkrete Struktur und eine SQLite-Datei deren Träger. Nicht alles durch „Datenbank“ ersetzen.

- **lokaler Datenhaltung** – [K1 Z.42](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:42>), [K5 Z.21](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:21>), [K5 Z.382](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:382>).
- **lokaler Persistenz** – [K2 Z.138](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:138>).
- **persistente Datenhaltung** – [K2 Z.146](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:146>).
- **lokale Datenhaltung** – [K4 Z.117](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:117>), [K4 Z.135](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:135>), [K4 Z.174](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:174>), [K5 Z.52](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:52>), [K5 Z.64](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:64>), [K5 Z.987](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:987>), [K6 Z.317](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:317>).
- **Lokale Speicherung** – [K4 Z.184](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:184>), [K5 Z.25](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:25>), [K5 Z.559](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:559>), [K5 Z.563](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:563>), [K5 Z.798](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:798>), [K6 Z.174](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:174>).
- **Datenhaltungsbereichen** – [K5 Z.573](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:573>).
- **Datenhaltungsbereiche** – [K5 Z.586](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:586>).
- **lokalen Datenhaltung** – [K5 Z.975](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:975>).
- **lokale Persistenz** – [K5 Z.1048](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1048>).

Zusätzlich in Abbildungen:

- **Lokale Persistenzschicht** – K2, [powersync-replication-flow.svg Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:23>); Beschriftung: „Lokale Persistenzschicht (Client)“.
- **Lokale Persistierung** – K2, [powersync-replication-flow.svg Z.29](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:29>); Beschriftung: „Lokale Persistierung“.

<a id="t49"></a>

### T49 · Lokale Datenbank aus Phase 1 [V]

Für dieselbe erste Datenbank wechseln insbesondere „lokale SQLite-Datei“ (K5 Z.52), „Benutzerdatenbank“ (Z.53/57/107) und „persönliche Datenbank“ (Z.730). Vorschlag: „lokale Kerndatenbank“. Sie enthält auch bestehende lokale Gruppen; „persönlich“ beschreibt ihren Inhalt daher nicht vollständig. Allgemeine SQLite-Beispiele und die Kollaborationsdatenbank in Z.660 gehören nicht zu dieser Instanz.

- **SQLite-Datei** – [K5 Z.52](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:52>).
- **Benutzerdatenbank** – [K5 Z.53](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:53>), [K5 Z.57](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:57>).
- **Benutzerdatenbanken** – [K5 Z.107](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:107>).
- **SQLite-Datenbank** – [K5 Z.392](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:392>), [K5 Z.575](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:575>).
- **persönliche Datenbank** – [K5 Z.730](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:730>).
- **lokale Datenbank** – [K5 Z.773](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:773>), [K7 Z.38](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:38>).

<a id="t50"></a>

### T50 · Lokaler PowerSync-Datenbestand / Kollaborationsdatenbank [V]

Der synchronisierte lokale Datenbereich wird als PowerSync-Bestand, Tabellenbestand oder Kollaborationsdatenbank bezeichnet. Vorschlag für die Instanz: „lokale Kollaborationsdatenbank“, für die enthaltenen Daten: „lokaler Kollaborationsdatenbestand“. Kollaborationsbereich umfasst zusätzlich Konten, Module und UI und ist weiter gefasst.

- **PowerSync-Bestand** – [K5 Z.569](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:569>), [K5 Z.626](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:626>).
- **Kollaborationsbereich** – [K5 Z.576](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:576>).
- **lokalen Datenbestand** – [K5 Z.576](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:576>).
- **synchronisierten Bereich** – [K5 Z.581](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:581>), [K5 Z.731](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:731>).
- **lokalen Tabellenbestand** – [K5 Z.629](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:629>).
- **synchronisierten Bereichs** – [K5 Z.657](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:657>).
- **benutzerbezogene SQLite-Datenbank** – [K5 Z.660](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:660>).
- **Kollaborationsdatenbank** – [K5 Z.672](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:672>).
- **PowerSync-Datenbank** – [K5 Z.705](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:705>).
- **synchronisierten Datenbestand** – [K5 Z.729](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:729>).

<a id="t51"></a>

### T51 · Backend-Datenbank [V]

Für die entfernte Datenbasis der Kollaboration „Supabase-PostgreSQL-Datenbank“ verwenden. Supabase ist die gesamte Plattform mit Auth/API, nicht nur eine Datenbank. PostgreSQL im Ausgangsprototyp und alternative Turso-Instanzen sind andere Datenbanken.

- **PostgreSQL-Instanzen** – [K2 Z.110](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:110>), [K5 Z.539](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:539>).
- **Backend-Datenbank** – [K2 Z.133](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:133>), [K5 Z.531](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:531>).
- **zentrale Datenbasis** – [K2 Z.143](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:143>).
- **Replikationsquelle** – [K2 Z.143](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:143>).
- **PostgreSQL-Instanz** – [K2 Z.144](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:144>).
- **entfernte Datenhaltung** – [K5 Z.515](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:515>), [K5 Z.538](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:538>).
- **PostgreSQL-Datenbank** – [K5 Z.548](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:548>).
- **Backend-Datenhaltung** – [K5 Z.550](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:550>).
- **entfernte Datenbank** – [K5 Z.777](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:777>).

<a id="t52"></a>

### T52 · SQL-Migrationsdateien / Schemamigrationen [V]

„Migrationsdateien“ und „SQL-Migrationsdateien“ benennen dieselben ausgelieferten Dateien. Vorschlag: „SQL-Migrationsdateien“ für Dateien, „Schemamigration“ für Strukturänderungen und „Datenmigration“ für Seed-/Bestandsänderungen. Diese Migrationen vom Gesamtumbau Web → Desktop abgrenzen. Die Migrationstabelle ist nur das Verwaltungsobjekt für bereits ausgeführte Schritte, kein Synonym der Migrationsdateien.

- **SQL-Migrationsdateien** – [K2 Z.104](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:104>), [K5 Z.103](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:103>).
- **Schemamigrationen** – [K5 Z.101](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:101>).
- **SQLite-Migrationen** – [K5 Z.119](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:119>).
- **Migrationsdateien** – [K5 Z.132](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:132>).
- **Migrationstabelle** – [K5 Z.139](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:139>).
- **Datenmigrationen** – [K5 Z.143](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:143>).
- **SQL-Migrationen** – [K5 Z.627](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:627>), [K5 Z.1065](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1065>).
- **Drizzle-Migrationen** – [K5 Z.730](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:730>), [K5 Z.907](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:907>).

<a id="t53"></a>

### T53 · Schemadefinition / Datenbankschema [V]

Häufig wechselnde Bezeichnungen der Strukturdefinition. Eine Drizzle-TypeScript-Definition, das tatsächliche Datenbankschema und das daraus abgeleitete PowerSync-Client-Schema sind jedoch unterschiedliche Repräsentationen. Durch das jeweilige Systemattribut kenntlich machen.

- **Datenbankschemata** – [K2 Z.100](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:100>).
- **TypeScript-Schemadefinition** – [K2 Z.110](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:110>).
- **Schemadefinitionen** – [K5 Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:51>), [K5 Z.62](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:62>), [K5 Z.98](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:98>), [K5 Z.103](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:103>), [K5 Z.229](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:229>), [K5 Z.344](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:344>).
- **Datenbankschemas** – [K5 Z.103](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:103>).
- **Drizzle-Schema** – [K5 Z.627](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:627>).
- **Tabellenbestand** – [K5 Z.629](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:629>).
- **PostgreSQL-Schema** – [K5 Z.731](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:731>).
- **lokale Schema** – [K5 Z.731](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:731>).
- **Datenbankschema** – [K5 Z.988](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:988>), [K7 Z.76](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:76>).
- **Client-Schema** – [K5 Z.1064](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1064>).

Zusätzlich in Abbildungen:

- **lokales Schema** – K5, [sync-schema-deployment.svg Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/sync-schema-deployment.svg:31>); Beschriftung: „Erweitertes lokales Schema“.

<a id="t54"></a>

### T54 · Kennung / Identifikator / ID [E]

Kennung, ID und Identifikator sind sprachliche Entsprechungen. Vorschlag: „Kennung“ im Fließtext. Primärschlüssel ist eine Datenbankrolle; UUID ein Format; Operations-, Benutzer- und Datensatzkennungen betreffen verschiedene Objekte. Diese Unterschiede erhalten.

- **Kennungen** – [K4 Z.147](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:147>), [K5 Z.67](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:67>), [K5 Z.598](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:598>), [K5 Z.783](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:783>), [K5 Z.1040](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1040>), [K5 Z.1049](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1049>), [K5 Z.1053](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1053>), [K5 Z.1059](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1059>).
- **Primärschlüssel** – [K5 Z.84](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:84>).
- **Kennung** – [K5 Z.86](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:86>), [K5 Z.616](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:616>).
- **Operationskennungen** – [K5 Z.149](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:149>), [K5 Z.184](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:184>), [K5 Z.224](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:224>), [K5 Z.334](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:334>), [K5 Z.439](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:439>).
- **Benutzerkennung** – [K5 Z.391](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:391>), [K5 Z.442](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:442>), [K5 Z.444](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:444>), [K5 Z.497](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:497>).
- **Datensatzkennung** – [K5 Z.444](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:444>).
- **Primärschlüsselspalte** – [K5 Z.566](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:566>).
- **Integer-Kennungen** – [K5 Z.567](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:567>).
- **Identifikatoren** – [K5 Z.627](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:627>).
- **UUID-Primärschlüsseln** – [K5 Z.627](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:627>).
- **Textkennung** – [K5 Z.747](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:747>).

Zusätzlich in Abbildungen:

- **Operationskennungen** – K5, [api-interface-migration.svg Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/api-interface-migration.svg:22>); Beschriftung: „Operationskennungen, Parameter und Datenschemata“.
- **Benutzerkennung** – K5, [grades-crud-flow.svg Z.46](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/grades-crud-flow.svg:46>); Beschriftung: „Sitzung → Benutzerkennung“.

<a id="t55"></a>

### T55 · Lokale Identitätsverwaltung [V]

Lokale Kontoverwaltung und lokale Identitätsverwaltung bezeichnen denselben Funktionsbereich. Vorschlag: „lokale Kontoverwaltung“. Benutzer-/Datenzuordnung ist eine Verantwortung darin und nicht mit Anmeldung oder Authentifizierung insgesamt gleichzusetzen.

- **lokale Identitätsverwaltung** – [K4 Z.176](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:176>).
- **Kontozuordnung** – [K5 Z.380](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:380>).
- **Benutzerzuordnung** – [K5 Z.385](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:385>), [K6 Z.110](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:110>).
- **persönliche Datenzuordnung** – [K5 Z.446](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:446>), [K5 Z.464](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:464>), [K5 Z.1018](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1018>), [K5 Z.1106](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1106>).
- **lokalen Kontoverwaltung** – [K5 Z.597](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:597>).
- **Identitätszuordnung** – [K5 Z.987](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:987>).

<a id="t56"></a>

### T56 · Lokale und entfernte Konten [P]

Ab Phase 2 bestehen zwei Kontensysteme. „Lokales Benutzerkonto“ für die Kernanwendung und „Supabase-Benutzerkonto“ für Kollaboration verwenden. „Identität“ ist das zugeordnete Identitätskonzept und „Profil“ der zusätzliche Anwendungsdatensatz. Nicht pauschal zu „Benutzer“ vereinheitlichen.

- **Identität** – [K4 Z.66](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:66>), [K5 Z.616](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:616>), [K5 Z.640](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:640>), [K5 Z.997](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:997>).
- **entfernte Benutzerkonten** – [K5 Z.597](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:597>).
- **Supabase-Identität** – [K5 Z.747](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:747>).
- **Benutzerkonto** – [K5 Z.777](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:777>).
- **Identitäten** – [K5 Z.1048](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1048>), [K5 Z.1053](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1053>).
- **entfernte Konten** – [K5 Z.1055](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1055>), [K7 Z.82](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:82>).
- **lokalen Konto** – [K6 Z.38](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:38>), [K6 Z.50](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:50>).
- **Lokale Konten** – [K6 Z.49](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:49>).

Zusätzlich in Abbildungen:

- **entfernter Identität** – K5, [local-first-architecture.svg Z.56](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:56>); Beschriftung: „Datei je entfernter Identität“.

<a id="t57"></a>

### T57 · Sitzung / Session [E]

„Session“ und „Sitzung“ sind sprachlich äquivalent, die Instanzen sind es nicht: HTTP-Sitzung im Webprototyp, lokale Anwendungssitzung, Supabase-Kollaborationssitzung und Electron-Session für Berechtigungen trennen. Vorschlag: jeweils qualifizierte deutsche Bezeichnung.

- **HTTP-Sitzung** – [K5 Z.391](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:391>).
- **lokale Sitzung** – [K5 Z.392](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:392>).
- **Sitzungskennung** – [K5 Z.424](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:424>).
- **lokalen Sitzung** – [K5 Z.442](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:442>).
- **Sitzungszustand** – [K5 Z.658](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:658>).
- **Kollaborationssitzung** – [K5 Z.795](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:795>), [K6 Z.206](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:206>).
- **Sessioneinstellungen** – [K5 Z.816](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:816>).
- **Session-Berechtigungen** – [K5 Z.847](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:847>).
- **Sitzungsdauer** – [K5 Z.997](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:997>).
- **entfernte Sitzung** – [K7 Z.34](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:34>).

Zusätzlich in Abbildungen:

- **Session** – K4, [original-web-architecture.svg Z.49](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:49>); Beschriftung: „HTTP-Fetch · Session-Cookie“.
- **Session** – K4, [original-web-architecture.svg Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:54>); Beschriftung: „Authentifizierung · Session · Zod“.
- **lokale Sitzung** – K5, [collaboration-modules.svg Z.59](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:59>); Beschriftung: „Eigener Modulvertrag, Zod-Prüfung und lokale Sitzung“.

<a id="t58"></a>

### T58 · Einladungslink / Token / Einladung [P]

K3/K4 behandeln Einladungen allgemein; K5/K7 unterscheiden den ursprünglichen Linkablauf und die neue direkte Kontoeinladung. Link, Token, Einladung und Einladungsseite sind keine Synonyme. Im neuen Ablauf „direkte Kontoeinladung“, im alten „linkbasierte Gruppeneinladung“ schreiben.

- **Gruppeneinladungen** – [K5 Z.602](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:602>), [K7 Z.28](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:28>).
- **Einladungstoken** – [K5 Z.603](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:603>).
- **Einladungslink** – [K5 Z.609](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:609>), [K7 Z.28](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:28>).
- **Einladungsseite** – [K5 Z.610](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:610>), [K5 Z.614](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:614>).
- **direkte Einladung** – [K5 Z.613](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:613>), [K7 Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:31>).
- **personenbezogene Einladung** – [K5 Z.618](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:618>).
- **Einladungsversand** – [K5 Z.634](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:634>), [K5 Z.676](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:676>).

<a id="t59"></a>

### T59 · PowerSync-Dienst [V]

Die serverseitige Komponente heißt PowerSync-Dienst bzw. PowerSync Service. Vorschlag: „PowerSync-Dienst“. PowerSync-SDK, Node-Paket und Replikationsmodul sind clientseitige Komponenten und nicht derselbe Gegenstand; allgemeine Synchronisationsdienste sind die Oberklasse.

- **Synchronisations-Engines** – [K2 Z.132](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:132>).
- **Middleware** – [K2 Z.133](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:133>).
- **PowerSync Service** – [K2 Z.138](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:138>).
- **Synchronisationsdiensten** – [K2 Z.145](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:145>).
- **Synchronisations-Middleware** – [K5 Z.531](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:531>).
- **PowerSync-Dienst** – [K5 Z.592](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:592>), [K5 Z.652](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:652>), [K5 Z.729](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:729>).
- **Synchronisierungsdienst** – [K5 Z.736](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:736>).

Zusätzlich in Abbildungen:

- **Synchronisationsdienst** – K2, [powersync-replication-flow.svg Z.55](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:55>); Beschriftung: „Synchronisationsdienst“.
- **PowerSync Service** – K2, [powersync-replication-flow.svg Z.57](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:57>); Beschriftung: „PowerSync Service“.
- **PowerSync Service** – K2, [powersync-replication-flow.svg Z.71](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:71>); Beschriftung: „Uploads laufen über die Backend-API; Downloads über den PowerSync Service.“.
- **PowerSync-Dienst** – K5, [local-first-architecture.svg Z.80](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:80>); Beschriftung: „PowerSync-Dienst“.
- **PowerSync-Dienst** – K5, [collaboration-modules.svg Z.98](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:98>); Beschriftung: „PowerSync-Dienst“.
- **PowerSync-Dienst** – K5, [sync-schema-deployment.svg Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/sync-schema-deployment.svg:23>); Beschriftung: „PowerSync-Dienst“.

<a id="t60"></a>

### T60 · Replikationsregeln / Sync Streams [P]

In K5 regeln Streams die Auswahl heruntergeladener Daten; die Grundlagenabbildung spricht von „Sync Rules“. Prüfen, ob bewusst verschiedene PowerSync-Konfigurationsmodelle dargestellt werden. Falls überall die konkrete Implementierung gemeint ist: „Sync Streams“ verwenden und generisch „Replikationsregeln“ erklären. Keine technischen Schlüssel oder YAML-Namen blind ersetzen.

- **Datenverteilung** – [K5 Z.550](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:550>), [K5 Z.638](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:638>), [K5 Z.725](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:725>), [K5 Z.731](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:731>), [K5 Z.1064](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1064>).
- **Replikationsregeln** – [K5 Z.631](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:631>).
- **Streams** – [K5 Z.638](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:638>), [K5 Z.640](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:640>).
- **Selektionsregeln** – [K5 Z.640](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:640>).
- **Stream** – [K5 Z.653](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:653>).
- **Downloadfilter** – [K5 Z.1060](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1060>).

Zusätzlich in Abbildungen:

- **Sync Rules** – K2, [powersync-replication-flow.svg Z.59](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:59>); Beschriftung: „Sync Rules: Datenpartitionen filtern“.
- **Datenverteilung** – K5, [local-first-architecture.svg Z.81](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:81>); Beschriftung: „Datenverteilung anhand“.
- **Sync Streams** – K5, [local-first-architecture.svg Z.82](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:82>); Beschriftung: „der Sync Streams“.
- **Sync Streams** – K5, [collaboration-modules.svg Z.99](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:99>); Beschriftung: „Sync Streams“.

<a id="t61"></a>

### T61 · Upload-Warteschlange [V]

Upload-Warteschlange und Upload Queue/Queue benennen den Puffer ausstehender Änderungen. Vorschlag: „Upload-Warteschlange“. Ausstehende Änderungen sind der Inhalt, nicht die Warteschlange selbst; „Offline-Warteschlangen“ ist die allgemeinere Klasse.

- **Offline-Warteschlangen** – [K2 Z.132](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:132>).
- **ausstehender Uploads** – [K5 Z.559](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:559>).
- **ausstehenden lokalen Änderungen** – [K5 Z.675](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:675>).
- **Upload-Warteschlange** – [K5 Z.705](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:705>).
- **ausstehende Änderungen** – [K5 Z.739](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:739>), [K5 Z.1048](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1048>), [K5 Z.1066](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1066>).
- **ausstehender Änderungen** – [K5 Z.1113](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1113>).

Zusätzlich in Abbildungen:

- **Upload Queue** – K2, [powersync-replication-flow.svg Z.31](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:31>); Beschriftung: „Upload Queue“.
- **Ausstehende Änderungen** – K2, [powersync-replication-flow.svg Z.32](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:32>); Beschriftung: „Ausstehende Änderungen“.
- **Upload-Warteschlange** – K5, [local-first-architecture.svg Z.64](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:64>); Beschriftung: „mit Upload-Warteschlange“.
- **Queue** – K5, [collaboration-modules.svg Z.85](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:85>); Beschriftung: „Queue“.

<a id="t62"></a>

### T62 · Lokaler Schreibabschluss [E]

„Lokaler Schreibabschluss“ und „Local Commit“ sind eingeführte Entsprechungen. Serverbestätigung/Annahme durch das Backend sind der spätere entfernte Abschluss, nicht derselbe Erfolg. „Entfernter Konsensabgleich“ in K2 könnte einen weitergehenden Mechanismus nahelegen; für den Demonstrator präzise vom Backend bestätigte Übernahme benennen.

- **Lokaler Schreibabschluss** – [K2 Z.128](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:128>).
- **Local Commit** – [K2 Z.128](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:128>).
- **entfernter Konsensabgleich** – [K2 Z.128](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:128>).
- **lokale Schreibabschluss** – [K5 Z.1054](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1054>).
- **Annahme durch das Backend** – [K5 Z.1054](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1054>).
- **Lokalen Schreibabschluss** – [K5 Z.1113](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1113>).

Zusätzlich in Abbildungen:

- **Lokaler Schreibabschluss** – K2, [powersync-replication-flow.svg Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:37>); Beschriftung: „Lokaler Schreibabschluss ist unabhängig von der Serverbestätigung.“.
- **Serverbestätigung** – K2, [powersync-replication-flow.svg Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:37>); Beschriftung: „Lokaler Schreibabschluss ist unabhängig von der Serverbestätigung.“.

<a id="t63"></a>

### T63 · Electron-Sicherheitsrichtlinien [V]

Dieselbe Referenz wird als Guidelines, Richtlinien, Checkliste und Empfehlungen angesprochen. Vorschlag: einmal „Electron-Sicherheitsrichtlinien (Electron Security Guidelines)“, danach deutsche Bezeichnung. „Checkliste“ für die daraus geprüften Punkte und „Sicherheitsmatrix“ für die eigene Dokumentation getrennt verwenden.

- **Electron-Sicherheitsrichtlinien** – [K2 Z.42](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:42>), [K3 Z.90](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:90>).
- **Electron Security Guidelines** – [K2 Z.47](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:47>), [K3 Z.92](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:92>), [K4 Z.139](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:139>), [K4 Z.187](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:187>), [K7 Z.9](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:9>).
- **Electron-Empfehlung** – [K3 Z.103](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:103>), [K5 Z.1072](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1072>).
- **Sicherheitscheckliste** – [K4 Z.189](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:189>).
- **Electron-Sicherheitscheckliste** – [K5 Z.806](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:806>).
- **Electron-Empfehlungen** – [K5 Z.822](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:822>), [K5 Z.1115](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1115>).

<a id="t64"></a>

### T64 · Sicherheitsmatrix [V]

Die eigene Nachweistabelle heißt Sicherheitsmatrix und verkürzt Matrix. Vorschlag: „Sicherheitsmatrix“. Der Sicherheitsabgleich ist der Vorgang, nicht die Tabelle.

- **Sicherheitsmatrix** – [K5 Z.803](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:803>), [K5 Z.809](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:809>), [K5 Z.1074](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1074>).
- **Matrix** – [K5 Z.811](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:811>), [K5 Z.966](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:966>).
- **Sicherheitsabgleichs** – [K5 Z.878](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:878>).

<a id="t65"></a>

### T65 · Härtung [V]

Härtung ist die Herstellung der Schutzmaßnahmen, Sicherheitsprüfung deren Prüfung und Sicherheitsnachweis die Begründung des Ergebnisses. Inhaltlich eng verbunden, aber keine Synonyme. Insbesondere „sichere Anwendung“ nicht kommentarlos als Ersatz für den begrenzten Prüfumfang benutzen.

- **Härtung** – [K3 Z.88](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:88>), [K3 Z.91](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:91>), [K4 Z.187](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:187>), [K5 Z.7](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:7>), [K5 Z.27](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:27>), [K5 Z.801](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:801>), [K5 Z.1068](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1068>), [K5 Z.1070](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1070>), [K6 Z.319](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:319>), [K6 Z.351](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:351>).
- **Sicherheitsnachweis** – [K3 Z.103](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:103>).
- **gehärteten Electron-Anwendung** – [K4 Z.139](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:139>).
- **Sicherheitsprüfung** – [K4 Z.209](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:209>), [K4 Z.210](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:210>), [K6 Z.243](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:243>), [K7 Z.9](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:9>).
- **Schutzmaßnahmen** – [K5 Z.872](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:872>), [K5 Z.884](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:884>).
- **Sicherheitsmaßnahmen** – [K6 Z.6](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:6>), [K6 Z.13](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:13>), [K6 Z.241](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:241>), [K6 Z.275](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:275>), [K6 Z.319](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:319>).

<a id="t66"></a>

### T66 · Content Security Policy [E]

Im konkreten Fremdskripttest bezeichnen CSP und Inhaltsrichtlinie dieselbe Richtlinie. Vorschlag: einmal „Content Security Policy (CSP)“, danach „CSP“. Eine Skriptrichtlinie ist eine einzelne Vorgabe darin; „Navigations- und Inhaltsrichtlinien“ ist weiter.

- **Inhaltsrichtlinien** – [K2 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:48>).
- **Content Security Policy** – [K2 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:48>), [K5 Z.854](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:854>).
- **CSP** – [K5 Z.854](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:854>), [K5 Z.954](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:954>).
- **Inhaltsrichtlinie** – [K5 Z.953](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:953>), [K6 Z.264](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:264>), [K6 Z.266](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:266>).
- **Skriptrichtlinie** – [K5 Z.955](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:955>).

<a id="t67"></a>

### T67 · Kontextisolation [E]

Deutsche und englische Bezeichnung derselben Schutzoption. Vorschlag: „Kontextisolation (Context Isolation)“ bei Einführung, danach „Kontextisolation“. contextBridge ist das zugehörige API-Mittel, nicht die Option selbst.

- **Context Isolation** – [K2 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:48>).
- **Kontextisolation** – [K5 Z.845](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:845>).

Zusätzlich in Abbildungen:

- **Context Isolation** – K2, [electron-architecture-comparison.svg Z.40](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:40>); Beschriftung: „Context Isolation / contextBridge“.

<a id="t68"></a>

### T68 · Node.js-Integration [E]

Node.js-Integration und Node-Integration benennen dieselbe Electron-Option. Vorschlag: „Node.js-Integration“. Node.js-APIs sind die erreichbaren Funktionen, kein Synonym der Option.

- **nodeIntegration** – [K2 Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:37>).
- **Node.js-APIs** – [K2 Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:37>).
- **Node.js-Integration** – [K2 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:48>).
- **Node-Integration** – [K5 Z.845](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:845>).

Zusätzlich in Abbildungen:

- **nodeIntegration** – K2, [electron-architecture-comparison.svg Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:37>); Beschriftung: „nodeIntegration: false · sandbox: true“.
- **nodeIntegration** – K2, [electron-architecture-comparison.svg Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:48>); Beschriftung: „nodeIntegration: true“.
- **Node.js-APIs** – K2, [electron-architecture-comparison.svg Z.51](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:51>); Beschriftung: „Node.js-APIs im Renderer“.

<a id="t69"></a>

### T69 · Sandbox / Prozessisolierung [P]

Die isolierte Umgebung der KI-Plattform, Chromium-Sandbox, Prozessaufteilung und Kontextisolation sind verschiedene Schutzgrenzen. „Renderer-Isolation“ ist ein Sammelbegriff. Nur bei eindeutigem Bezug vereinheitlichen; insbesondere Sandbox und getrennte Prozesse nicht pauschal gleichsetzen.

- **Sandbox** – [K1 Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:22>), [K5 Z.845](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:845>).
- **Prozessisolierung** – [K2 Z.34](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:34>).
- **Prozesstrennung** – [K2 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:45>).
- **Chromium-Sandbox** – [K2 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:45>).
- **Sandboxing** – [K2 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:48>).
- **Renderer-Isolation** – [K4 Z.140](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:140>).

Zusätzlich in Abbildungen:

- **Sandbox** – K2, [electron-architecture-comparison.svg Z.36](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:36>); Beschriftung: „Benutzeroberfläche in der Sandbox“.
- **sandbox** – K2, [electron-architecture-comparison.svg Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:37>); Beschriftung: „nodeIntegration: false · sandbox: true“.

<a id="t70"></a>

### T70 · Paketierung / Paket / Archiv [P]

Paketierung bezeichnet den Prozess, Anwendungspaket das Ergebnis, Paketstand eine Version und Paketbetrieb deren Ausführung. Für das Ergebnis „Anwendungspaket“ und bei konkretem Windows-Test „Windows-Anwendungspaket“ verwenden. Das ASAR-Archiv ist nur ein Bestandteil des Pakets.

- **Paketierung** – [K2 Z.80](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:80>), [K5 Z.559](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:559>), [K5 Z.691](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:691>), [K5 Z.985](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:985>).
- **bündeln** – [K2 Z.82](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:82>), [K5 Z.356](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:356>).
- **Paketieren** – [K2 Z.86](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:86>).
- **Installationspaket** – [K5 Z.122](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:122>).
- **Anwendungspakets** – [K5 Z.885](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:885>), [K6 Z.271](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:271>).
- **Paketbetrieb** – [K5 Z.906](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:906>), [K5 Z.1048](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1048>).
- **Anwendungspaket** – [K5 Z.908](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:908>), [K6 Z.270](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:270>).
- **Windows-Paket** – [K5 Z.930](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:930>).
- **Windows-Pakets** – [K5 Z.933](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:933>).
- **Paketstand** – [K5 Z.984](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:984>), [K5 Z.1070](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1070>).
- **Desktop-Paketstand** – [K5 Z.1098](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1098>).

<a id="t71"></a>

### T71 · ASAR-Archiv [V]

Für die gebündelten Anwendungsdateien wechseln ASAR-Archiv und Anwendungsarchiv. Vorschlag: „ASAR-Archiv (app.asar)“, danach „ASAR-Archiv“. app.asar.unpacked ist ein separates Verzeichnis außerhalb des Archivs, nicht dasselbe Archiv.

- **ASAR-Archiv** – [K2 Z.82](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:82>), [K5 Z.965](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:965>).
- **app.asar** – [K2 Z.82](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:82>), [K2 Z.91](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:91>).
- **virtuelles Verzeichnis** – [K2 Z.83](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:83>).
- **virtuellen ASAR-Archiv** – [K5 Z.719](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:719>).
- **ASAR-Anwendungsarchiv** – [K5 Z.872](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:872>).
- **Anwendungsarchiv** – [K5 Z.913](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:913>).

<a id="t72"></a>

### T72 · Electron Fuses [E]

„Electron Fuses“ und die erklärende Bezeichnung Schalter betreffen denselben Mechanismus. Konfiguration und ausgelesene Werte sind unterschiedliche Sichten. Vorschlag: einmal „Electron Fuses“, danach „Fuses“. Einzelne Fuses unverändert beim technischen Namen nennen.

- **Electron Fuses** – [K2 Z.80](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:80>), [K2 Z.86](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:86>).
- **Schalter in der Electron-Binary** – [K2 Z.86](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:86>).
- **Fuses** – [K2 Z.90](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:90>), [K5 Z.872](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:872>), [K5 Z.914](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:914>).
- **Fuse-Konfiguration** – [K5 Z.911](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:911>).
- **Fuse-Werte** – [K5 Z.930](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:930>), [K5 Z.1077](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1077>).

<a id="t73"></a>

### T73 · Codeinspektion [V]

Code- und Quellcodeinspektion sind dasselbe Prüfverfahren. Vorschlag: „Quellcodeinspektion“. Architekturprüfung kann zusätzlich Modulzuordnung und Entwurfsabgleich einschließen und ist dann weiter gefasst.

- **Architektur- und Quellcodeinspektionen** – [K3 Z.102](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:102>).
- **Codeinspektion** – [K5 Z.919](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:919>).
- **Architekturprüfung** – [K6 Z.90](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:90>).
- **Betrachtung der Einstellungen und Schnittstellen** – [K6 Z.245](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:245>).

<a id="t74"></a>

### T74 · Laufzeitversuche [V]

Manuelle Sicherheitsversuche am gestarteten Paket werden unterschiedlich benannt. Vorschlag: „manuelle Laufzeitversuche“ für diese Sicherheitsprüfungen. Manuelle Funktionsprüfungen der Benutzerabläufe und Protokolle als Nachweisdokumente getrennt halten.

- **manuelle Demonstrationen** – [K3 Z.102](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:102>).
- **Laufzeitfälle** – [K4 Z.191](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:191>).
- **Laufzeitversuche** – [K5 Z.920](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:920>), [K5 Z.933](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:933>), [K5 Z.961](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:961>), [K6 Z.245](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:245>).
- **Laufzeitbelege** – [K5 Z.966](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:966>).
- **Manuelle Versuche** – [K6 Z.15](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:15>).
- **Sicherheitsversuche** – [K6 Z.352](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:352>).

<a id="t75"></a>

### T75 · Weiterleitung / Redirect [E]

Im Netzwerkprüfkontext sind Redirect und Weiterleitung dieselbe HTTP-Funktion. Vorschlag: „HTTP-Weiterleitung“. Die UI-Weiterleitung zur Anmeldung in K5 Z.397 ist clientseitige Navigation und ein anderer Vorgang.

- **Weiterleitung** – [K5 Z.397](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:397>).
- **Weiterleitungen** – [K5 Z.842](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:842>), [K7 Z.11](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:11>).
- **redirect** – [K5 Z.901](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:901>).
- **Redirecttest** – [K5 Z.928](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:928>).
- **Redirectbehandlung** – [K6 Z.281](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:281>).

<a id="t76"></a>

### T76 · Single Source of Truth [P]

„Single Source of Truth“ bezieht sich in K2 Z.100 auf das Drizzle-Schema und in Z.116 auf lokale Anwendungsdaten. Jeweils den Gegenstand nennen: maßgebliche Schemadefinition vs. maßgeblicher lokaler Datenbestand. Datensouveränität und Datenkontrolle sind Ziele, keine Synonyme einer bestimmten Datenquelle.

- **Datensouveränität** – [K1 Z.40](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:40>).
- **zentrale Referenz** – [K2 Z.100](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:100>).
- **Single Source of Truth** – [K2 Z.100](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:100>), [K2 Z.116](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:116>).
- **primäre Datenhoheit** – [K2 Z.116](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:116>).
- **Datenkontrolle** – [K2 Z.121](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:121>).

<a id="t77"></a>

### T77 · Authentifizierung / Anmeldung [P]

Anmeldung ist der Benutzerablauf, Authentifizierung die Identitätsprüfung. Zugriffskontrolle/Autorisierung entscheidet danach über Rechte. Die Begriffe sind verwandt, aber nicht austauschbar. „Lokale Anmeldung“ und „Supabase-Anmeldung“ durchgängig qualifizieren.

- **Anmeldung** – [K1 Z.35](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:35>), [K4 Z.66](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:66>), [K5 Z.379](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:379>), [K5 Z.381](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:381>), [K5 Z.394](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:394>), [K5 Z.395](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:395>), [K5 Z.397](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:397>), [K5 Z.600](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:600>), [K5 Z.606](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:606>), [K5 Z.659](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:659>), [K5 Z.660](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:660>), [K5 Z.795](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:795>), [K5 Z.997](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:997>), [K5 Z.1021](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1021>), [K6 Z.23](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:23>), [K6 Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:37>), [K6 Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:39>), [K6 Z.58](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:58>), [K6 Z.59](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:59>), [K6 Z.207](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:207>), [K6 Z.348](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/06-evaluation.typ:348>), [K7 Z.33](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:33>), [K7 Z.82](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/07-discussion.typ:82>).
- **Zugriffsschutz** – [K1 Z.35](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:35>).
- **Authentifizierung** – [K4 Z.9](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:9>), [K4 Z.28](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:28>), [K4 Z.65](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:65>), [K4 Z.176](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:176>), [K5 Z.375](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:375>), [K5 Z.401](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:401>), [K5 Z.548](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:548>), [K5 Z.550](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:550>), [K5 Z.709](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:709>).
- **Passwortprüfung** – [K5 Z.385](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:385>).
- **Autorisierungsprüfungen** – [K5 Z.638](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:638>).
- **Zugriffskontrolle** – [K5 Z.807](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:807>), [K5 Z.819](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:819>).
- **Berechtigungen** – [K5 Z.847](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:847>), [K5 Z.848](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:848>), [K5 Z.1018](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1018>).

Zusätzlich in Abbildungen:

- **Authentifizierung** – K4, [original-web-architecture.svg Z.54](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/original-web-architecture.svg:54>); Beschriftung: „Authentifizierung · Session · Zod“.
- **Anmeldung** – K5, [local-first-architecture.svg Z.68](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/local-first-architecture.svg:68>); Beschriftung: „und Anmeldung“.

<a id="t78"></a>

### T78 · Large Language Model (LLM) [E]

Langform und Abkürzung desselben Modelltyps. Nach der Einführung „LLM“ verwenden. „KI“ ist der weitere Oberbegriff; KI-Plattform, Agent und LLM sind unterschiedliche Ebenen.

- **Large Language Models** – [K2 Z.14](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:14>).
- **LLMs** – [K2 Z.14](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:14>).
- **LLM** – [K3 Z.39](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:39>), [K3 Z.40](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:40>), [K3 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:45>).

<a id="t79"></a>

### T79 · Object-Relational Mapping (ORM) [E]

Ausgeschriebener Fachbegriff und Abkürzung. Einmal einführen; „ORM“ bezeichnet das Verfahren bzw. Werkzeugklasse, „Drizzle ORM“ die konkrete Bibliothek.

- **ORM** – [K2 Z.96](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:96>), [K2 Z.97](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:97>), [K2 Z.100](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:100>), [K5 Z.1048](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:1048>).
- **Object-Relational-Mapping-Werkzeug** – [K2 Z.96](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:96>).

Zusätzlich in Abbildungen:

- **ORM** – K2, [powersync-replication-flow.svg Z.34](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:34>); Beschriftung: „1. SQL / ORM“.

<a id="t80"></a>

### T80 · Cross-Site Scripting (XSS) [E]

K2 führt Langform und Abkürzung als dieselbe Angriffsklasse ein. Das ist eine sachgerechte Einführung und kein problematischer Bezeichnungswechsel.

- **Cross-Site Scripting** – [K2 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:45>).
- **XSS** – [K2 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:45>).

<a id="t81"></a>

### T81 · Remote Code Execution (RCE) [E]

Langform und Abkürzung sind äquivalent. „Ausführung fremden Codes“ in K3 ist eine weiter gefasste Beschreibung des Schutzziels und nicht automatisch die genaue Angriffsklasse RCE.

- **Remote Code Execution** – [K2 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:45>).
- **RCE** – [K2 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:45>).
- **Ausführung fremden Codes** – [K3 Z.92](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/03-method.typ:92>).

<a id="t82"></a>

### T82 · Backend as a Service (BaaS) [E]

Langform und Abkürzung bezeichnen dieselbe Plattformklasse. Supabase ist ein konkreter Vertreter; „Backend“ allein ist nicht gleichbedeutend mit BaaS.

- **Backend-as-a-Service** – [K2 Z.143](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:143>).
- **BaaS** – [K2 Z.143](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:143>).

<a id="t83"></a>

### T83 · Write-Ahead Log / Write-Ahead Logging (WAL) [E]

WAL wird sowohl für SQLite in der Kerndatenbank als auch für das PostgreSQL-Änderungsprotokoll der Replikation verwendet. Den Systembezug ausdrücklich nennen. Das Protokoll und das Logging-Verfahren sind verwandt; die beiden Datenbanksysteme teilen nicht dieselbe Logdatei.

- **PostgreSQL-WAL** – [K2 Z.145](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:145>).
- **WAL** – [K5 Z.138](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:138>), [K5 Z.652](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:652>).
- **Write-Ahead-Logging** – [K5 Z.138](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:138>).
- **PostgreSQL-Write-Ahead-Log** – [K5 Z.652](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:652>).

Zusätzlich in Abbildungen:

- **WAL** – K2, [powersync-replication-flow.svg Z.65](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/powersync-replication-flow.svg:65>); Beschriftung: „(WAL)“.
- **WAL** – K5, [collaboration-modules.svg Z.104](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/collaboration-modules.svg:104>); Beschriftung: „WAL“.

<a id="t84"></a>

### T84 · ISO-8601-Zeichenketten / ISO-Strings [E]

K5 Z.628 und Z.748 beschreiben dasselbe textbasierte Datumsformat. Vorschlag: „ISO-8601-Zeichenketten“. Date-Werte im Code und Unix-Zeit im Schema aus Phase 1 sind andere Repräsentationen.

- **ISO-8601-Zeichenketten** – [K5 Z.628](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:628>).
- **ISO-Strings** – [K5 Z.748](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:748>).

## Fachlich wichtige Abgrenzungen beim Überarbeiten

- **Datenhaltung ≠ Datenbank ≠ Datenbankdatei:** Verantwortung, logische Instanz und physischer Träger. Für den konkreten Gegenstand trotzdem einen eindeutigen Namen wählen.
- **Kerndatenbank ≠ Kollaborationsdatenbank ≠ Supabase-Datenbank:** mindestens drei Rollen; die Kollaborationsdatei wird zusätzlich je entfernter Identität angelegt.
- **Benutzeroberfläche ≠ Renderer ≠ Preload ≠ Main-Prozess:** Komponenten und Prozesse nicht durcheinander ersetzen.
- **API-Vertrag ≠ Zod-Schema ≠ TypeScript-Typ:** Quelle, Laufzeitprüfung und statische Typbeschreibung.
- **OpenAPI-Vertrag der Kernfunktionen ≠ manuell typisierter Kollaborationsvertrag.**
- **Synchronisation ≠ Replikation ≠ einseitige Datenübernahme:** Gesamtverhalten, technischer Verteilmechanismus und eigener Verarbeitungstyp.
- **Lokale Speicherung ≠ erfolgreicher Upload ≠ Übernahme beim anderen Konto.**
- **Lokale Anmeldung ≠ Supabase-Anmeldung; Anwendungssitzung ≠ Electron-Session.**
- **Sicherheitsrichtlinien ≠ eigene Sicherheitsmatrix ≠ Sicherheitsprüfung ≠ Härtung.**
- **Anwendungsmigration ≠ Schemamigration ≠ Seed-Datenmigration.**
- **Anwendungspaket ≠ ASAR-Archiv ≠ app.asar.unpacked.**
- **Beispiel aus der Vorprüfung ≠ endgültiger Demonstrator.**

## Nachweis und Grenzen

Alle hier aufgeführten Fundstellen wurden aus den zum Prüfzeitpunkt gelesenen Dateien ermittelt. Die ergänzende Datei terminologie-fundstellen.json enthält für jeden Treffer die Originalzeile bzw. SVG-Beschriftung und den SHA-256-Stand der Kapiteldateien. Sie erleichtert die Kontrolle, wenn du später Text umstellst. Zeilennummern gelten nur für diesen Stand.

Die fachliche Gruppierung beruht auf der Lektüre aller sieben Kapitel. Die anschließende Suchauswertung sammelt die Vorkommen der aufgenommenen Bezeichnungen; sie ist kein Beweis, dass jede denkbare Umschreibung erfasst wurde. Ein einzelner, durchgehend gleich benannter Fachbegriff ohne alternative Bezeichnung ist kein Befund dieser Prüfung. Normale Pronomen und allgemeine Rückverweise („die Anwendung“, „das System“, „der Bestand“) sind ohne eindeutigen Bezug nicht als eigene Synonyme aufgenommen.
