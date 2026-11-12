# Beschlossene Terminologie

## Weiteres Vorgehen

- Die übrigen Vorschläge zur Terminologie sind vom Nutzer grundsätzlich angenommen.
- Alle P-Einträge wurden einzeln besprochen. Die vorgemerkten Vorschläge wurden am 12. November 2026 umgesetzt. Die gemeinsame fachliche Nachschärfung von T69 bleibt ausdrücklich offen; die Stellen stehen gesondert in sicherheitsbegriffe-nachschaerfen.md.

## T07: Desktop-Zielumgebung und Electron-Laufzeit – geklärt und terminologisch umgesetzt

- **Desktop-Zielumgebung** bezeichnet die gesamte Betriebsumgebung einschließlich Betriebssystem, Dateisystem und Zugriffsrechten.
- **Electron-Laufzeit** bezeichnet die konkrete technische Ausführungsumgebung.
- Diese Begriffe bezeichnen unterschiedliche Ebenen und werden entsprechend ihrem Kontext verwendet.
- Die Bedeutung wurde vom Nutzer ausdrücklich bestätigt; der Thesis-Text wurde für diesen Eintrag noch nicht geändert.

## T14: Design Science Research und Modell nach Peffers – geklärt und terminologisch umgesetzt

- Der Nutzer hat die Forschungsaktivitäten bereits in der ursprünglichen Gliederung eingeplant und DSR bewusst verwendet. Die methodische Orientierung wurde nicht erst nachträglich beim Schreiben ergänzt.
- Die zuvor vorgeschlagene Dreiteilung in „Forschungsansatz“, „Forschungsrahmen“ und „Prozessmodell“ war vom Nutzer nicht als begriffliche Abstufung beabsichtigt.
- **Design Science Research (DSR)** wird als zentrale Bezeichnung verwendet. Das **Modell nach Peffers et al.** beschreibt die zur Strukturierung eingeplanten Forschungsaktivitäten; deren konkrete Bedeutung für die Arbeit soll verständlich erklärt werden.
- Die bewusste Planung der Forschungsaktivitäten ist von den schrittweise entstandenen technischen Entscheidungen und Anpassungen während der Migration zu unterscheiden. Sie bedeutet nicht, dass alle technischen Schritte von Anfang an feststanden.
- Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T15: Webprototyp, Electron-Anwendung und Migrationspfad – geklärt und terminologisch umgesetzt

- **Webprototyp** bezeichnet die ursprüngliche Replit-Anwendung; Einführung als „Webprototyp des Studienplaners“.
- **Electron-Anwendung** bezeichnet die migrierte Software. Der Nutzer bestätigt ihre Rolle als **technischer Demonstrator**.
- **Migrationspfad** bezeichnet das abgeleitete Vorgehen mit Empfehlungen und Kontrollpunkten. Der Nutzer bestätigt ihn als **zentrales wissenschaftliches Ergebnis**.
- „Artefakt“ soll bei konkreten Bezügen durch die eindeutige Bezeichnung des jeweiligen Gegenstands präzisiert werden. Allgemeine methodische Aussagen können den Oberbegriff weiterhin verwenden.
- Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T16: Erster Migrationsversuch und Spike-Tests – geklärt und terminologisch umgesetzt

- **Erster Migrationsversuch** bezeichnet den frühen Versuch der Migration mit LLM-Unterstützung aus Kapitel 3.
- **Spike-Tests** bezeichnet die späteren technischen Erprobungen der Synchronisationsintegration aus Kapitel 5. Der Nutzer erläutert, dass diese innerhalb eines Worktrees durchgeführt wurden.
- Die beiden Untersuchungen werden begrifflich getrennt. Die vorgeschlagenen deutschen Bezeichnungen „Migrationsvorversuch“ und „technische Vorprüfung der Synchronisationsintegration“ werden nicht als Leitbegriffe übernommen.
- Bei der Einführung der Spike-Tests kurz den konkret erprobten Zweck erklären; vertraute technische Begriffe beibehalten.
- Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T23: Module und Kurse sind getrennte Fachobjekte – geklärt und terminologisch umgesetzt

- Der Nutzer bestätigt zwei vollständig getrennte Features: **Module** sind Modulhandbuchinformationen in der Ansicht `/studiengänge`; **Kurse** sind die Einträge, die in der Ansicht `/stundenplan` in den Stundenplan eingefügt werden können.
- In `/stundenplan` lassen sich zusätzlich **Presets** auswählen. Diese gehören zum Stundenplan-Feature.
- `0001_seed-study-programs.sql` hinterlegt die **Module** des Studiengänge-Features.
- `0002_seed-timetable-presets.sql` hinterlegt die **Kurse** für das Stundenplan-Feature.
- „Module“, „Kurse“ und „Lehrveranstaltungen“ dürfen nicht global als Synonyme behandelt werden. Bei konkreten Fachobjekten sind „Module“ bzw. „Kurse“ entsprechend dem Feature zu verwenden; technische Softwaremodule bleiben davon getrennt.
- Kapitel 5, Zeile 143, soll die beiden Seed-Dateien und ihre jeweils unterschiedlichen Fachobjekte ausdrücklich zuordnen. Die übrigen Bezüge auf „Lehrveranstaltungen“ und „Kurse“ beim Studiengangskatalog sind anhand ihres tatsächlichen Features zu präzisieren.
- Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T24: Studiengruppen in zwei Migrationsständen – geklärt und terminologisch umgesetzt

- Im Webprototyp existierte das Feature `/gruppen`, in dem Gruppen erstellt werden konnten.
- Dieses Studiengruppen-Feature wurde zunächst mit seinen grundlegenden CRUD-Interaktionen zusammen mit den übrigen Features in die lokale Anwendung übernommen.
- Dasselbe Feature war anschließend der ausgewählte Anwendungsfall, um den Local-First-Aspekt der Zusammenarbeit aus Kapitel 2 im Migrationspfad und im technischen Demonstrator zu berücksichtigen. Dafür wurde es um Synchronisation erweitert.
- **Lokale Studiengruppen** bzw. **lokales Studiengruppen-Feature** bezeichnet die zunächst lokal übernommene Implementierung unter `/gruppen`.
- **Synchronisierte Studiengruppen** bzw. **synchronisiertes Studiengruppen-Feature** bezeichnet die um Synchronisation erweiterte Implementierung unter `/gruppen-sync`.
- „Studiengruppen“ bleibt der Oberbegriff. „Kollaborationsbereich“ soll bei konkretem Feature-Bezug entsprechend präzisiert werden; Bezüge auf technische Komponenten und Datenhaltungsbereiche sind im Kontext zu prüfen.
- Die Darstellung soll den schrittweisen Ausbau desselben ursprünglichen Features und das vorübergehende Nebeneinander der Implementierungen deutlich machen.
- Der Nutzer stimmt diesen Bezeichnungen zu. Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T56: Lokales Benutzerkonto und Supabase-Benutzerkonto – geklärt und terminologisch umgesetzt

- Der Nutzer bestätigt, dass die lokale Anmeldung und die Anmeldung für die synchronisierten Studiengruppen zwei getrennte Benutzerkonten betreffen.
- **Lokales Benutzerkonto** bezeichnet das Konto der lokalen Kernanwendung.
- **Supabase-Benutzerkonto** bezeichnet das separate Konto für die synchronisierten Studiengruppen.
- Eine automatische Verknüpfung oder gemeinsame Identität darf im Text nicht vorausgesetzt werden.
- „Profil“ bezeichnet weiterhin den zusätzlichen anwendungsbezogenen Datensatz und wird nicht als Synonym für das Benutzerkonto verwendet.
- Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T58: Gruppeneinladungen – geklärt und terminologisch umgesetzt

- Der Nutzer bestätigt den linkbasierten Ablauf im Webprototyp: Ein Einladungslink wird kopiert und außerhalb der Anwendung weitergegeben.
- Der Nutzer bestätigt den direkten Ablauf in den synchronisierten Studiengruppen: Ein vorhandenes Supabase-Benutzerkonto wird in der Anwendung ausgewählt und erhält dort eine Einladung zum Annehmen oder Ablehnen.
- **Linkbasierte Gruppeneinladung** bezeichnet den ursprünglichen Ablauf.
- **Direkte Kontoeinladung** bezeichnet den Ablauf der synchronisierten Studiengruppen.
- „Einladungslink“, „Einladungstoken“ und „Einladungsseite“ sind technische Bestandteile und keine Synonyme des gesamten Einladungsablaufs.
- Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T60: Sync Streams – geklärt und terminologisch umgesetzt

- Der Nutzer bestätigt, dass die Grundlagenabbildung denselben Mechanismus wie der Demonstrator zeigen soll.
- **Sync Streams** ist die einheitliche Bezeichnung in Grundlagen, Umsetzungstext und Abbildungen.
- Die Beschriftung „Sync Rules: Datenpartitionen filtern“ in `figures/powersync-replication-flow.svg` ist entsprechend anzupassen.
- „Replikationsregeln“ kann als allgemeine Erklärung der Auswahl zu übertragender Daten verwendet werden, soll aber kein zweites technisches Konfigurationsmodell nahelegen.
- Thesis-Text und Abbildung wurden am 12. November 2026 entsprechend angepasst.

## T69: Prozesstrennung, Sandboxing und Kontextisolation – Klärung mit gesonderter Nachschärfung

- Prozesstrennung, Sandboxing und Kontextisolation werden als unterschiedliche Mechanismen gezielt benannt; die Sandbox der KI-Entwicklungsplattform ist davon getrennt zu kennzeichnen.
- Der unscharfe Sammelbegriff „Renderer-Isolation“ ist anhand der konkret gemeinten Schutzmaßnahmen zu präzisieren.
- **Ausdrücklicher Nutzerwunsch:** Bei der späteren Umsetzung jede betroffene bzw. geänderte Stelle mit Kapitel und Zeile gesondert vorlegen und den Nutzer ausdrücklich an die gemeinsame fachliche Nachschärfung erinnern. Diesen Punkt nicht allein mit einer pauschalen Abschlussmeldung als erledigt behandeln.
- Besonders zu prüfen: K2 Z.34 (Prozessisolierung), K2 Z.45 (behaupteter Zusammenhang zwischen Prozesstrennung und Schutzwirkung der Chromium-Sandbox), K2 Z.48 (Kontextisolation und Sandboxing), K4 Z.140 (Renderer-Isolation), K5 Z.845 (Abgrenzung der Sicherheitseinstellungen), K1 Z.22 (Sandbox der KI-Entwicklungsplattform). Zeilennummern beziehen sich auf den bisherigen Quelltextstand und sind bei Umsetzung erneut zu kontrollieren.
- Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T70: Paketierung und getestete Anwendung – geklärt und terminologisch umgesetzt

- Der Nutzer bestätigt: Die Anwendung wurde über den Installer installiert; anschließend wurde die installierte Anwendung getestet.
- **Paketierung** bezeichnet den Erstellungsprozess; **Anwendungspaket** die gebaute Anwendung; **Installationspaket** den Installer; **ASAR-Archiv** die Datei `app.asar` innerhalb der Anwendung.
- Die Beschreibung der betreffenden Laufzeitprüfungen soll ausdrücklich die **installierte Anwendung** benennen, statt offen zwischen Installer, Anwendungspaket und direkt aus dem Ausgabeordner gestarteter Anwendung zu wechseln.
- Diese Bestätigung betrifft den Start und Test der installierten Anwendung. Für separate automatisierte Paketprüfungen weiterhin die jeweils dokumentierten Artefakte und Prüforte beachten.
- Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T76: Schemadefinition und lokaler Datenbestand – geklärt und terminologisch umgesetzt

- Der Nutzer stimmt zu, die beiden unterschiedlichen Bezüge von „Single Source of Truth“ in Kapitel 2 ausdrücklich zu benennen.
- **Zentrale Schemadefinition** bezeichnet beim Drizzle-Schema die zentrale Definition der Tabellen und Datentypen.
- **Primärer lokaler Datenbestand** bezeichnet im Local-First-Kontext den Datenbestand, auf dem die Anwendung lokal arbeitet.
- Der englische Ausdruck soll an diesen Stellen durch die jeweils konkrete Bezeichnung ersetzt werden. „Datensouveränität“ bleibt als gesonderte Eigenschaft benannt und ist kein Synonym für einen Datenbestand.
- Die Terminologie wurde am 12. November 2026 im Quelltext angepasst. Für T69 bleibt die gemeinsame fachliche Durchsicht der gesondert dokumentierten Vorschläge offen.

## T77: Kontoverwaltung, Anmeldung und Zugriffskontrolle – geklärt und umgesetzt

- Der Nutzer stimmt der Trennung zu: **Anmeldung** ist der Benutzerablauf, **Authentifizierung** die technische Identitätsprüfung und **Zugriffskontrolle / Autorisierung** die Prüfung der Berechtigungen.
- **Lokale Anmeldung** und **Anmeldung mit dem Supabase-Benutzerkonto** werden entsprechend ihrem Kontext verwendet.
- **Kontoverwaltung** bezeichnet den gesamten Funktionsbereich mit Registrierung, Anmeldung und Abmeldung.

## T01: Migrationspfad

- Gewählter Leitbegriff: **Migrationspfad**.
- Ersetzt für das abgeleitete Vorgehen mit Empfehlungen und Kontrollpunkten: „Migrationsleitfaden“, „Leitfaden“ und „Migrationsweg“, einschließlich Genitivformen.
- „Migrationsprozess“ bezeichnet weiterhin die tatsächlich durchgeführten Tätigkeiten.
- In den Kapitelquelltexten umgesetzt: 30 Ersetzungen in den Kapiteln 1 und 3–7. Kapitel 2 enthielt keine entsprechende Stelle.
- Die ursprüngliche Terminologieprüfung bleibt als Bestandsaufnahme erhalten; diese Entscheidung ersetzt deren Vorschlag für T01.
- Prüfung: Änderungen auf die vereinbarten Wortersetzungen begrenzt; Typst-Kompilierung durch fehlenden Download von `glossarium:0.5.10` wegen DNS-Fehler verhindert. Die bestehende `thesis.pdf` wurde nicht überschrieben.

## T02: Migration

- Gewählter Leitbegriff für den Gesamtumbau und die schrittweise Migration der Funktionsbereiche: **Migration**; Verb: **migrieren**.
- „Transformation“, „Überführung“ und „Übertragung“ wurden bei diesem Bezug vereinheitlicht. „Transformationsschritte“ heißt nun „Migrationsschritte“.
- Die Vereinheitlichung umfasst auch den Titel der Arbeit in `document.typ`.
- Spezifische andere Vorgänge bleiben unterscheidbar: Datenübertragung, Schemaübertragung, Generierung von Laufzeitschemata, Abbildung fachlicher Fehler sowie die erwogene Portierung des Backends nach Rust.
- Prüfung: Änderungen und verbleibende Wortvorkommen im Kontext kontrolliert; `git diff --check -- content document.typ` ohne Befund. Kein erneuter PDF-Build, da der bereits festgestellte Paketdownloadfehler durch diese Textänderung nicht behoben wird.
- Die ursprüngliche Terminologieprüfung bleibt als Bestandsaufnahme erhalten; diese Entscheidung ersetzt deren Vorschlag für T02.

## T03: KI-gestützte Entwicklungsplattformen

- Gewählter Oberbegriff für Replit und Lovable: **KI-gestützte Entwicklungsplattformen**.
- Ersetzt: „KI-gestützte Werkzeuge“, „KI-Werkzeug“, „cloudbasierte Entwicklungswerkzeuge“ und „KI-gestützte Anwendungsentwicklungsplattformen“ einschließlich gebeugter Formen.
- Umsetzung: fünf Textstellen in Kapitel 1 und 2, einschließlich der Überschrift und der Begriffseinführung in Kapitel 2. Der Rückverweis „vom Werkzeug“ wurde im selben Satz zu „von der Plattform“ angepasst.
- Prüfung: Vorkommen im Kontext und Diff auf unerwünschte Änderungen kontrolliert; keine PDF-Neuerstellung wegen des bereits dokumentierten Typst-Paketdownloadfehlers.
- Die ursprüngliche Terminologieprüfung bleibt als Bestandsaufnahme erhalten; diese Entscheidung ersetzt deren Vorschlag für T03.

## Umsetzung am 12. November 2026

Details und Prüfungen stehen in umsetzungsbericht.md. Die separate Prüf-PDF wurde erfolgreich erstellt und visuell kontrolliert; der Paketdownloadfehler aus den früheren Arbeitsschritten konnte behoben werden. Die bestehende thesis.pdf bleibt unverändert. T69 ist ausdrücklich zur gemeinsamen Nachschärfung vorgemerkt.
