//---------------------------------------------------------------------
= Entwurf, Migration und Migrationsleitfaden <ch:migration>
//---------------------------------------------------------------------

== Struktur des Migrationsleitfadens

Innerhalb dieser Phasen werden zusammengehörige Änderungen nach den Bereichen Datenhaltung, Schnittstellen, CRUD-Verarbeitung, Dateiimporte und Online-Anbindungen gegliedert.
Die Darstellung bündelt die tatsächlich vorgenommenen Anpassungen und erklärt exemplarisch ihre Entscheidungen und Prinzipien.
Sie beschreibt daher nicht jede migrierte Funktion einzeln.
Die Analyse aus @ch:analysis liefert den architektonischen Ausgangspunkt und die Kriterien zur Bewertung des erreichten Zustands.

Die Phasen unterscheiden Zielzustände der Entwicklung.
Sie behaupten weder eine von Beginn an vollständig festgelegte Projektplanung noch eine vollständige Trennung aller Arbeitsschritte.
Insbesondere beeinflussen die Sicherheitsanforderungen bereits den ersten Architekturentwurf.
Jede Phase beschreibt deshalb neben ihrem funktionalen Ziel auch die relevanten Schnittstellen und einen Kontrollpunkt für den erreichten Stand.

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    inset: 7pt,
    align: left,
    table.header([*Phase*],
    [*Zielzustand*],
    [*Kontrollpunkt*]),
    [1],
    [Lokale Kernfunktionen mit lokaler Datenhaltung [Local-First Bezug] und begrenzter IPC-Kommunikation.],
    [Kernabläufe ohne Netzwerk ausführen; Änderungen nach Neustart erneut lesen.],
    [2],
    [Synchronisierte Aufgaben und Online-Anbindungen.],
    [Lokale Speicherung, spätere Übermittlung und Verhalten bei Netzwerkausfall unterscheiden.],
    [3],
    [Geprüfte Härtung],
    [Anwendbarkeit, Umsetzung und Nachweis jeder Empfehlung dokumentieren.],
  ),
  caption: [Phasen und Kontrollpunkte des fallbezogenen Migrationsleitfadens.],
) <tab:migration-phases>

== Phase 1: Von der Webanwendung zur Offline-Kernanwendung <sec:offline-core-migration>

=== Initialisierung des Electron-Projekts und Übernahme der Datenbankmodule

Electron wurde im Sinne von A3 gewählt, um vorhandene Komponenten weiterzuverwenden.
Das Backend des Ausgangsartefakts verwendete TypeScript und Node.js @StudienplanerSource2026.
Da der Electron-Main-Prozess ebenfalls eine Node.js-Laufzeit bereitstellt, konnten fachliche Logik und Bibliotheken als Grundlage der lokalen Umsetzung dienen @ElectronProcessModel2026.

Als Alternative wurde Tauri erwogen, dessen privilegierter Core-Prozess auf Rust basiert @TauriProcessModel2026.
Eine Portierung des Backends in diesen Core hätte neben der Sprache auch Datentypen, Fehlerbehandlung und Bibliotheksanbindungen betroffen, insbesondere den Drizzle-Datenzugriff.
Tauri erlaubt allerdings auch die Einbindung einer Node.js-Anwendung als Sidecar @TauriNodeSidecar2026.
Dieser Weg hätte einen zusätzlichen auszuliefernden Prozess und dessen Kommunikation erfordert.
Für Electron sprach die unmittelbare Ausführung der übernommenen Backend-Komponenten im Main-Prozess.

Das Zielprojekt wurde mit der `react-ts`-Vorlage von electron-vite initialisiert @ElectronViteGettingStarted2026.
Damit blieb die im Replit-Frontend verwendete Kombination aus React, TypeScript und Vite erhalten @StudienplanerSource2026.
Die betrachtete React-TypeScript-Anleitung von Electron Forge verwendet `webpack-typescript`; 
Forge bietet daneben auch Vite-Vorlagen an [aber nicht out of the box mit react] @ElectronForgeReact2026 @ElectronForgeGettingStarted2026.
Die Wahl von electron-vite beruhte auf der erwarteten Begrenzung der Anpassungen durch kompatible Technologien.
Ein geringerer Migrationsaufwand gegenüber Tauri oder Electron Forge wurde nicht vergleichend evaluiert.

Anschließend wurden die Drizzle-Schemadefinitionen für Benutzer, Stundenpläne, Studiengänge, Gruppen, Noten, Termine und das Aktivitätsprotokoll [alle Tables inklusive drizzle.config.ts] samt Exportmodul nach `src/main/db/schema` übernommen.
Für die erste Entwicklung ersetzte eine lokale SQLite-Datei die PostgreSQL-Verbindung [als Benutzerdatenbank. Mit dem Umgebungswechsel übernahm die Desktop-Anwendung im Main-Prozess das Anlegen, Öffnen und Migrieren der Benutzerdatenbank.
 ]: Der Dialekt wechselte zu `sqlite`, und `DATABASE_URL` entfiel für die lokale Datenhaltung @StudienplanerSource2026 @StudyPlanDatabase2026.

Die Datei wird zur Laufzeit unter dem von Electron bereitgestellten Pfad `userData` angelegt @ElectronAppPaths2026.
Dieser liegt außerhalb des Projekt- und Installationsverzeichnisses, trennt veränderliche Daten von Programmdateien und vermeidet Schreibzugriffe auf das Installationsverzeichnis.
Ein Update kann so Programmdateien ersetzen, ohne die Benutzerdatenbank auszutauschen.
Ausgeliefert werden die Migrationen zur Einrichtung und Aktualisierung ihres Schemas @StudyPlanDatabase2026.

=== Anpassung der Tabellen und Datenbankabhängigkeiten an SQLite

Die Übernahme der bestehenden Schemadefinitionen erforderte Anpassungen, da diese auf PostgreSQL-spezifische Datentypen und Tabellenkonstruktoren aufbauten. Um das in @ch:analysis festgelegte Ziel eines minimalen Refactoring-Aufwands zu erreichen, wurden die Konstrukte durch entsprechende SQLite-Äquivalente ersetzt, während fachliche Tabellen- und Spaltennamen, Pflichtfelder sowie Standardwerte unverändert blieben.

Auf Treiberebene wurde die PostgreSQL-Bibliothek `pg` für die lokale Datenhaltung durch `@libsql/client` abgelöst. Drizzle blieb dabei als einheitliche Abstraktionsschicht für das Schema und den Datenzugriff erhalten.

@tab:postgresql-sqlite-mapping fasst die im Demonstrator verwendeten Abbildungen zusammen. 
Das Stundenplanschema liefert hierbei Beispiele für Kennungen, boolesche Werte und Enums, während das Terminschema die Datumsabbildung ergänzt @StudienplanerSource2026 @StudyPlanDatabase2026.

#figure(
{
set par(justify: false)
table(
columns: (1fr, 1.2fr, 1.5fr),
inset: 6pt,
align: left,
table.header(
[*PostgreSQL / Drizzle*],
[*SQLite / Drizzle*],
[*Bedeutung der Anpassung*],
),
[`pgTable`],
[`sqliteTable`],
[Tabellenkonstruktor für den neuen Dialekt.],
[`serial` als Primärschlüssel],
[`integer` mit `autoIncrement`],
[Numerische, automatisch erzeugte Kennung bleibt erhalten.],
[`boolean`],
[`integer` im Modus `boolean`],
[Integer-Speicherung mit booleschen TypeScript-Werten.],
[`pgEnum`],
[`text` mit `enum`-Werteliste],
[Typableitung bleibt erhalten; keine gleichwertige Datenbankprüfung.],
[`timestamp` mit Zeitzone],
[`integer` im Modus `timestamp`],
[Zeitpunkt wird als Unix-Zeit gespeichert und im Code als `Date` verwendet.],
)
},
caption: [Ausgewählte Abbildungen der PostgreSQL-Schemadefinitionen auf SQLite im Demonstrator.],
) <tab:postgresql-sqlite-mapping>

=== Versionierte Schemamigrationen und Datenbankinitialisierung

Zur Einrichtung des Datenbankschemas standen mit Drizzle zwei Ansätze zur Auswahl: Während `drizzle-kit push` Schemadefinitionen direkt und ohne gesonderte SQL-Dateien mit der Zieldatenbank abgleicht @DrizzlePush2026, erzeugt `drizzle-kit generate` versionierte SQL-Migrationsdateien auf Basis von Schema-Snapshots @DrizzleGenerate2026.

Für den Demonstrator wurde der generatorbasierte Ansatz gewählt. 
Die im Verzeichnis `drizzle` abgelegten Dateien werden gemeinsam mit dem Quellcode versioniert. 
Dies gewährleistet einen nachvollziehbaren Migrationspfad bei künftigen Schemaerweiterungen, ohne bestehende Benutzerdatenbanken bei Updates zurücksetzen zu müssen. 
Die Kompatibilität konkreter Migrationen mit Altdaten bleibt dabei fallweise zu prüfen.

Die zugehörige Konfiguration in @lst:drizzle-config definiert den SQLite-Dialekt, den Schema-Einstiegspunkt sowie das Ausgabeverzeichnis der Migrationen @StudyPlanDatabase2026. 
In der `package.json` wurden hierfür die Skripte `db:generate` (`drizzle-kit generate`) und `db:check` (`drizzle-kit check`) eingerichtet.

#figure(
block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
set text(size: 8.5pt)
raw(read("../code/drizzle-config.ts"), lang: "typescript", block: true)
}),
kind: raw,
supplement: [Quellcode],
caption: [Drizzle-Kit-Konfiguration zur Erzeugung der SQLite-Migrationen.],
) <lst:drizzle-config>

Damit die Migrationen auch im Produktivbetrieb ausgeführt werden können, bindet `electron-builder.yml` den Ordner `drizzle` über `extraResources` in das Installationspaket ein (@lst:migration-resources). 
Die Anwendung greift während der Entwicklung direkt auf das Projektverzeichnis zu, im paketierten Zustand hingegen über `process.resourcesPath` @StudyPlanDatabase2026.

#figure(
block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
set text(size: 8.5pt)
raw(read("../code/migration-resources.yml"), lang: "yaml", block: true)
}),
kind: raw,
supplement: [Quellcode],
caption: [Auslieferung der Migrationsdateien über zusätzliche Paketressourcen (Ausschnitt).],
) <lst:migration-resources>

Der eigentliche Initialisierungsprozess wird beim Anwendungsstart innerhalb von `app.whenReady()` über `initDatabase()` ausgeführt, bevor Dienste initialisiert oder Fenster geöffnet werden @StudyPlanDatabase2026:

1. *Speicherort auflösen:* In `src/main/db/index.ts` wird der Pfad aus `app.getPath('userData')` und dem Unterordner `data` gebildet (unter Windows beispielsweise `%APPDATA%\studyplan\data\studyplan.db`, im Entwicklungsbetrieb `studyplan-dev.db`). Der Zielordner wird vor dem Öffnen automatisch angelegt.
2. *Verbindung und Pragmas:* Der libSQL-Client öffnet die Datei über eine lokale `file:`-URL. Zur Laufzeit werden unmittelbar `PRAGMA foreign_keys = ON` (Aktivierung der referenziellen Integritätsprüfung) und `PRAGMA journal_mode = WAL` (Write-Ahead-Logging) gesetzt @SQLitePragma2026.
3. *Migration und Integritätstest:* Nach Bereitstellung der SQLite-kompatiblen Migrationstabelle `__drizzle_migrations` wendet der Drizzle-Migrator alle noch ausstehenden SQL-Dateien an. Abschließend bestätigt eine einfache Prüfabfrage die Funktionsfähigkeit der Verbindung.

Scheitert dieser Ablauf an einem beliebigen Punkt, bricht die Anwendung mit einer Fehlermeldung ab. Dadurch wird ausgeschlossen, dass die Benutzeroberfläche mit einer unvollständig vorbereiteten oder inkonsistenten Datenbank startet.

Für Funktionen mit Referenzdaten stellen die Datenmigrationen `0001_seed-study-programs.sql` und `0002_seed-timetable-presets.sql` Studiengänge, Lehrveranstaltungen und Stundenplanvorlagen bereit. 
Sie werden während des Migrationsschritts lokal eingefügt und garantieren die Offline-Fähigkeit der Anwendung, da lokale IPC-Handler bereits vor einem externen Datenabruf im Feature Studiengänge auf einen konsistenten Datenbestand zugreifen können @StudyPlanDatabase2026.

=== Übernahme des API-Vertrags und Anpassung der Codegenerierung <sec:api-contract-migration>

Die Schnittstellenmigration ging vom bestehenden OpenAPI-Vertrag unter `lib/api-spec/openapi.yaml` aus, der nach `api/openapi.yaml` in das Desktop-Projekt übernommen wurde. 
Dessen Operationskennungen, Parameter und Datenschemata dienten bereits im Web-Prototyp als zentrale Spezifikation für Validierung und Client-Generierung @StudienplanerSource2026.

Die Entscheidung, an diesem zentralen Vertrag festzuhalten, resultiert wesentlich aus den Erfahrungen des Vorversuchs (@sec:migration-preliminary). 
Die dort beobachteten, schwer nachvollziehbaren Moduländerungen begründeten das Ziel, notwendige Schnittstellenanpassungen strikt von funktionellen Verhaltensänderungen zu trennen.

Als Alternative hätte das bisherige Werkzeug Orval beibehalten und die damit erzeugten Hooks, Typen und Zod-Schemata manuell für Electron-IPC adaptiert werden können. 
Dies hätte jedoch bedeutet, bei künftigen Schemaänderungen mehrere abhängige Module händisch synchronisieren zu müssen. Um diesen Bruch zu vermeiden, wurde die zentrale Vertragsgrundlage beibehalten und deren Übersetzung auf den IPC-Transport über eigene TypeScript-Generatoren unter `scripts/openapi-ipc` automatisiert @StudyPlanApiMigration2026. 
Das Vorgehen unterstützt die Wiederverwendung nach A3 sowie die Entkopplung nach A8 und A9: Der Vertrag wird zentral gepflegt und Anpassungen propagieren automatisiert in alle abgeleiteten Schnittstellenbausteine.

@fig:api-interface-migration stellt den ursprünglichen HTTP-basierten Aufrufweg der Web-Anwendung der lokalen Electron-Architektur gegenüber.

#figure(
image("../figures/api-interface-migration.svg", width: 100%),
placement: top,
caption: [Vertragsbasierte Codegenerierung und Aufrufwege im Web-Prototyp und in der lokalen Electron-Kernanwendung.
Gestrichelte Pfeile zeigen Generierung oder Einbindung, durchgezogene Pfeile Laufzeitkommunikation.
Spätere Synchronisierungs- und Online-Pfade sind nicht dargestellt.],
) <fig:api-interface-migration>

Die wesentliche Verschiebung liegt in der Realisierung des Transports: Anstelle von HTTP-Requests an einen Express-Server tritt eine typisierte Prozesskommunikation über Preload und IPC. 
@tab:api-interface-changes fasst diese strukturellen Unterschiede zusammen.

#figure(
{
set par(justify: false)
table(
columns: (1.1fr, 1.9fr, 2fr),
inset: 6pt,
align: left,
table.header(
[*Aspekt*],
[*Web-Prototyp*],
[*Electron-Kernanwendung*],
),
[Vertragsgrundlage],
[OpenAPI mit Operationskennungen und Datenschemata.],
[Bestehende Definitionen übernommen und gezielt für Desktop-Zwecke ergänzt.],
[Codegenerierung],
[Orval für React Query und Zod.],
[Projektspezifische TypeScript-Generatoren für Client, Hooks und Zod-Verträge.],
[Aufrufweg],
[HTTP-Methode und URL über `customFetch`.],
[`operationId` und Eingabeobjekt über Preload und den Kanal `api:invoke`.],
[Parameter],
[Pfad, Query-String und HTTP-Body.],
[Strukturierte Eingabeobjekte mit `path`, `query` und `body`.],
[Ergebnis],
[HTTP-Antwort bzw. HTTP-Fehlerstatus.],
[Geprüftes `ApiResult`; Fehler werden typisiert als `ApiClientError` weitergegeben.],
[Datumswerte],
[Strings im generierten Client; Datumsprüfung in Zod-Schemata.],
[`Date`-Werte und `z.date()` in den gemeinsamen Modulen.],
[Zugriffsgrenze],
[Serverseitige HTTP-Verarbeitung und Sitzungszuordnung.],
[Begrenzte Bridge, Absender- und Schemaprüfung sowie fachliche Sitzungsprüfung.],
)
},
caption: [Wiederverwendete Vertragsgrundlage und Änderungen an ihrer Umsetzung.],
) <tab:api-interface-changes>

Gesteuert über die Konfigurationsdatei `api/ipc-generator.config.ts` erzeugt die Toolchain aus der `openapi.yaml` die benötigten Module getrennt nach Zielumgebung @StudyPlanApiMigration2026:

- *Gemeinsame Module (`src/shared/api/generated`):* Typdefinitionen, Zod-Laufzeitschemata, die Zuordnungstabelle `operationContracts` sowie der Basistransport.
- *Renderer-Module (`src/renderer/src/api/generated`):* React-Query-Hooks für die Benutzeroberfläche und standardisierte Query-Key-Hilfsfunktionen.

Wie diese Artefakte im Detail aus den OpenAPI-Definitionen abgeleitet werden, beschreibt der folgende Abschnitt.

=== Funktionsweise der OpenAPI-IPC-Codegenerierung <sec:api-generator-concept>

Die Codeerzeugung übersetzt die Vertragsbeschreibung während der Entwicklung schrittweise in TypeScript-Module. 
Der Ablauf gliedert sich in drei aufeinander aufbauende Phasen: das Einlesen und Strukturieren des Dokuments, das programmatische Zusammensetzen der Quelltext-Zeichenketten sowie die Formatierung und Ausgabe der Dateien @StudyPlanApiMigration2026.

Die Orchestrierung übernimmt buildGeneratedFiles. 
Die Funktion liest die Spezifikation mit readFile ein und wandelt sie über den YAML-Parser in einen internen Objektbaum um. Anschließend durchläuft collectOperations alle Pfade und HTTP-Methoden:

Für jede Operation entsteht ein Datensatz mit Operationskennung, primärem Tag, Parametern, Antwortschemata sowie der Klassifikation als Query (get) oder Mutation (post, put, delete).

Fehlende oder mehrfach vergebene Operationskennungen werden strikt zurückgewiesen.

operationInputSchema konsolidiert Pfad- und Query-Parameter sowie den Request-Body in die festen Eingabegruppen path, query und body.

Die eigentliche Transformation in Laufzeitschemata erfolgt über die rekursive Funktion zodSchema. 
Sie übersetzt einzelne Schemadefinitionen in Zod-Ausdrücke. Für zusammengesetzte Objekte fügt zodSchema die Feldzeilen zusammen und ergänzt für nicht in required geführte Eigenschaften .optional().

Die Generatorfunktion contractSource bettet diesen Ausdruck schließlich in eine exportierte Schemadeklaration ein und leitet über z.infer den passenden TypeScript-Typ ab. 
@lst:generator-event-example stellt diese Transformation am Beispiel von Termindaten gegenüber.

#figure(
{
set par(justify: false)
grid(
columns: (1fr, 1fr),
column-gutter: 12pt,
align: left,
[
YAML-Eingabe (Auszug)yaml EventInput: type: object required: [title] properties: title: type: string minLength: 1 description: type: string 
],
[
TypeScript-Ausgabe (Auszug)
```ts
export const EventInputSchema = z
.object({
title: z.string().min(1),
description: z.string().optional()
})
.passthrough()

    export type EventInput = 
      z.infer<typeof EventInputSchema>
    ```
  ],
)
},
kind: raw,
caption: [Übersetzung ausgewählter Terminfelder in ein Zod-Laufzeitschema und einen abgeleiteten Typ @StudyPlanApiMigration2026.],
) <lst:generator-event-example>
Für komplexere Schemastrukturen löst orderSchemas Abhängigkeiten zwischen lokalen `$ref`-Verweisen auf und bringt die Deklarationen in eine gültige Reihenfolge. 
contractSource erzeugt darüber hinaus die Ein-, Ausgabe- und Fehlerschemata der einzelnen Operationen und fasst diese im zentralen Objekt operationContracts zusammen @StudyPlanApiMigration2026.

Die Abbildung der Vertragsbestandteile auf die generierten Zielbausteine fasst @tab:api-generator-mapping zusammen.

#figure(
{
set par(justify: false)
set text(size: 9pt)
table(
columns: (1.2fr, 1.2fr, 1.5fr),
inset: 5pt,
align: left,
table.header(
[OpenAPI-Eingabe],
[Generatorfunktion],
[Erzeugtes Element],
),
[Array mit `$ref` auf Event],
[zodSchema],
[z.array(EventSchema)],
[Optionaler Query-Parameter month],
[operationInputSchema],
[Eingabefeld query.month mit z.number().int()],
[Request-Body mit Verweis auf EventInput],
[operationInputSchema / contractSource],
[Eingabefeld body: EventInputSchema],
[operationId: listEvents, tags: [events]],
[collectOperations / clientSource],
[Client-Methode api.events.listEvents(...)],
[Methode get bzw. post],
[collectOperations / rendererReactQuerySource],
[Hook useListEvents (Query) bzw. useCreateEvent (Mutation)],
[2xx-Antwort und Fehlerdefinitionen],
[collectOperations / contractSource],
[Rückgabeschema und typisierte Fehlervereinigung],
)
},
caption: [Ausgewählte Übersetzungen vom OpenAPI-Vertrag in die generierten IPC-Module @StudyPlanApiMigration2026.],
) <tab:api-generator-mapping>
Aufbauend auf diesen Schemata erzeugt clientSource die typisierten Methoden des Basis-Clients, gegliedert nach dem ersten OpenAPI-Tag. Die Methoden nehmen die Eingaben entgegen und leiten sie zusammen mit der jeweiligen operationId an den Transport weiter. rendererReactQuerySource generiert darauf aufsetzend die React-Query-Hooks samt Hilfsfunktionen für standardisierte Query Keys.

Im letzten Schritt formatiert der Generator die resultierenden Quelltexte programmatisch über Prettier mit dem TypeScript-Parser. 
Das Skript scripts/openapi-ipc/generate.ts legt die Zielverzeichnisse an und speichert contract.generated.ts, client.generated.ts, react-query.generated.ts sowie die Exportmodule als UTF-8-Dateien ab. 
Über das package.json-Skript api:generate wird dieser Ablauf manuell oder im Build angestoßen; api:check (--check) validiert im Rahmen der CI, ob die im Repository liegenden Dateien exakt dem aktuellen Stand der openapi.yaml entsprechen @StudyPlanApiMigration2026.
=== IPC-Transport, Preload-Schnittstelle und Dispatcher

ur Laufzeit lösen prozessübergreifende IPC-Aufrufe die herkömmliche HTTP-Kommunikation ab. 
Die Kommunikation folgt dabei dem Prinzip eines typisierten Remote Procedure Call (RPC): Der Renderer-Prozess stößt eine benannte Operation im Main-Prozess an und erhält asynchron das validierte Ergebnis zurück @StudienplanerSource2026 @StudyPlanApiMigration2026.

Die Vermittlung übernimmt ein Transportadapter vom Typ ApiTransport. 
Anstelle von HTTP-Methode und URL erwartet dieser die generierte operationId sowie ein strukturiertes Eingabeobjekt mit den Feldern path, query und body.

Die Anbindung des Renderers an den Electron-IPC-Kanal erfolgt streng nach dem Prinzip der geringsten Rechte (Principle of Least Privilege) @ElectronContextBridge2026:

Preload-Bridge (src/preload/index.ts): Über contextBridge.exposeInMainWorld wird dem Renderer ausschließlich die Methode window.apiTransport.invoke bereitgestellt. 
Das vollständige ipcRenderer-Modul sowie frei wählbare Kanalnamen bleiben der Renderer-Umgebung vorenthalten. 
Die Typdeklaration in src/preload/index.d.ts erweitert das globale Window-Interface für die statische Typprüfung.

Kanalabstraktion: Aufrufe werden im Preload-Skript mit einer eindeutigen requestId versehen und über den festen Kanal api:invoke via ipcRenderer.invoke an den Main-Prozess gesendet @ElectronIpc2026.

Client-Instanziierung: Der im Renderer laufende API-Client nutzt diese exponierte Bridge-Funktion, verarbeitet die Rückgabewerte und wandelt Fehlermeldungen in typisierte ApiClientError-Instanzen um @StudyPlanLocalAuth2026.

Im Main-Prozess nimmt ipcMain.handle die Nachrichten entgegen und übergibt sie dem zentralen Dispatcher in src/main/ipc/api-dispatcher.ts @StudyPlanApiMigration2026:

[Renderer / React Query] 
       │  api.events.listEvents(...)
       ▼
[API-Client & Transport] 
       │  window.apiTransport.invoke('listEvents', input)
       ▼
[Preload (Bridge)] ── ipcRenderer.invoke('api:invoke', ...) ──┐
                                                              │ IPC-Grenze
[Main: ipcMain.handle] ◄──────────────────────────────────────┘
       │
       ▼
[API-Dispatcher]
       ├─ 1. Absender & Format prüfen
       ├─ 2. Operation auflösen (operationContracts)
       ├─ 3. Eingabe mit Zod validieren
       ├─ 4. Registrierten Handler aufrufen
       └─ 5. Rückgabe / Fehler validieren (ApiResult)
Der Dispatcher prüft zunächst den anfragenden Frame sowie die Struktur der Nachricht. 
Anhand der übergebenen operationId schlägt er die zugehörigen Schemadefinitionen in operationContracts nach und validiert die Eingabedaten mit dem generierten Zod-Eingabeschema. 
Ungültige Datenstrukturen oder unbekannte Operationskennungen werden unmittelbar abgewiesen.

Ist die Operation zwar im Schema definiert, aber kein passender Handler registriert, antwortet der Dispatcher mit dem Fehlercode NOT_IMPLEMENTED. 
Die Codegenerierung stellt somit lediglich das typisierte Gerüst bereit; die eigentliche Geschäftslogik, Sitzungsprüfungen und Datenbankzugriffe verbleiben in den Handlern und Services des Main-Prozesses @StudyPlanApiMigration2026.

Nach der Ausführung des Handlers validiert der Dispatcher das Ergebnis gegen das deklarierte Antwort- bzw. Fehlerschema. 
Die Antwort wird in ein einheitliches ApiResult gekapselt:

Erfolg: { ok: true, data: ..., requestId }

Fehler: { ok: false, error: ..., requestId }

Dieses standardisierte Antwortformat erlaubt es dem Client im Renderer, erfolgreiche Nutzdaten transparent auszupacken und kontrollierte Anwendungsfehler konsistent an die aufrufenden React-Query-Hooks weiterzureichen.

=== Grenzen und kritische Würdigung des Generatoransatzes

Die automatisierte Generierung der IPC-Schnittstellen aus einer zentralen Spezifikation gewährleistet zwar eine konsistente Brücke zwischen Renderer- und Main-Prozess, bringt jedoch methodische und architektonische Einschränkungen mit sich.

Eine fundamentale Grenze liegt in der Natur des Ausgangsformats: OpenAPI ist primär auf zustandslose HTTP-Kommunikation ausgelegt @OpenApi310. 
Bei der Übertragung auf Electron-IPC verlieren klassische REST-Konzepte ihre ursprüngliche Funktion:

HTTP-Methoden (GET, POST etc.) und URI-Pfade fungieren im Generator lediglich als Klassifikations- und Routing-Metadaten zur Unterscheidung zwischen Queries und Mutationen; sie repräsentieren keine Netzwerkendpunkte.

Statuscodes wie 404 oder 500 entfallen auf Transportebene und werden stattdessen in das anwendungsspezifische Fehlerformat von ApiResult überführt.

Der Generator deckt bewusst nur den im Demonstrator tatsächlich benötigten Funktionsumfang der Spezifikation ab. 
Komplexere OpenAPI-Konstrukte, wie rekursive Schemadefinitionen oder tief verschachtelte oneOf-Vereinigungen, werden vom Parser nicht aufgelöst, sondern zur Generierungszeit als Fehler abgewiesen @StudyPlanApiMigration2026.

Zudem muss der gewählte Ansatz im Hinblick auf den Entwicklungs- und Wartungsaufwand kritisch betrachtet werden:

Aspekt	Nutzen des Generatoransatzes	Verbleibende Einschränkungen / Kosten
Typsicherheit	Durchgängige End-to-End-Typisierung vom Main-Handler bis zum React-Hook.	Bei Spezifikationsfehlern bricht der gesamte Generierungs- und Buildprozess ab.
Änderungsaufwand	Schemaänderungen propagieren automatisch in Typen, Validierung und Client.	Hoher initialer Entwicklungsaufwand für Parser, AST-Mapping und Prettier-Pipeline.
Wartbarkeit	Vermeidung manueller Synchronisationsfehler zwischen den Prozessen (A3, A8).	Laufender Pflegeaufwand der Toolchain bei künftigen Spezifikations- oder Framework-Updates.
Eine quantitative Aufwandsersparnis gegenüber einer manuellen Anpassung vorhandener Orval-Artefakte konnte im Rahmen der Arbeit nicht empirisch nachgewiesen werden @StudyPlanApiMigration2026. 
Der Hauptgewinn des gewählten Ansatzes liegt somit nicht zwingend in kürzeren Entwicklungszeiten, sondern primär in der strukturellen Verlässlichkeit: Fehlerhafte Schnittstellenaufrufe und Datenformate werden bereits zur Übersetzungs- bzw. Generierungszeit erkannt, wodurch die strikte Trennung von Schnittstellenvertrag und Fachlogik (A2) architektonisch erzwungen wird.

=== Übernahme der React-Oberfläche in den Renderer <sec:frontend-migration>
Die React-Oberfläche aus artifacts/studienplaner/ wurde zu src/renderer/src/ migriert. 

Mitkopierte Web- und Replit-spezifische Konfigurationsdateien (package.json, vite.config.ts, tsconfig.json, components.json und die redundante index.html) wurden entfernt. 
Da electron-vite den Main-, Preload- und Renderer-Prozess zentral konfiguriert und für den Renderer standardmäßig auf src/renderer/index.html zugreift @ElectronViteConfig2026, entfielen serverspezifische Parameter wie Portvorgaben, BASE_PATH und Replit-Plugins des Ausgangsprojekts ersatzlos @StudienplanerSource2026 @StudyPlanFrontendMigration2026.

Um bestehende Modulpfade wie `@/components/ui/badge` ohne Refaktorisierung beizubehalten, wurde der Pfadalias `@` in electron.vite.config.ts auf src/renderer/src abgebildet und parallel in tsconfig.web.json für `@/*` hinterlegt @StudyPlanFrontendMigration2026. 
Der synchrone Eintrag in beiden Dateien stellt sicher, dass Vite die Pfade beim Bündeln auflöst und TypeScript sie bei der Typprüfung korrekt zuordnet @TypeScriptPaths2026.

Die übernommene index.css definiert Theme-Variablen und bindet Tailwind CSS, tw-animate-css sowie das Typografie-Plugin ein. 
`@tailwindcss/vite` über tailwindcss() neben react() registriert und die Vite-Typreferenz in src/renderer/src/env.d.ts hinterlegt @TailwindVite2026 @StudyPlanFrontendMigration2026. 
Die Vorlagenstile assets/main.css und assets/base.css wurden samt Beispielkomponenten gelöscht.

Die package.json des Electron-Projekts wurde um die Komponenten- und Hilfsbibliotheken ergänzt. 

=== Anbindung der Seiten und Navigation

Die bisherigen API-Aufrufe über `@workspace/api-client-react` wurden in den Seiten und im Layout durch `@/api` ersetzt, welches die IPC-basierten Hooks und Typen exportiert @StudyPlanFrontendMigration2026. 
Da der Codegenerator die Schnittstellensignaturen beibehielt (siehe @sec:api-contract-migration), blieben etablierte Aufrufmuster wie useListEvents(monthParams) oder Mutationen mit { data: ... } syntaktisch intakt.

Im selben Zuge wurden ungenutzte Imports, Variablen und Zustände entfernt. 

Für die Navigation nutzt die Anwendung weiterhin wouter. 
Anstelle des webbasierten Basispfads (import.meta.env.BASE_URL) bindet den Router über useHashLocation aus wouter/use-hash-location ein (`<WouterRouter hook="{useHashLocation}">`) @StudyPlanFrontendMigration2026. 
Wie in @sec:hash-routing ausgeführt, steuert das Adressfragment (z. B. `#/kalender`) den internen Seitenwechsel, ohne den Dateipfad der geladenen Renderer-Ressource im Electron-Kontext zu verändern.

=== Lokale Authentifizierung als erster vollständiger Verarbeitungspfad

Nach der Übernahme der Oberfläche begrenzte der vorhandene Anmeldeablauf zunächst den Zugang zu den fachlichen Seiten.
Das Layout ruft `useGetMe` auf und setzt einen zugeordneten Benutzer voraus.
Erwogen wurden das Entfernen der Anmeldung oder eine automatische Zuordnung zu einem Standardbenutzer im Hintergrund.
Diese Varianten hätten Änderungen an der bestehenden Benutzerführung und Kontozuordnung erfordert.
Die Anmeldung wurde beibehalten, weil sie zum ursprünglichen Funktionsumfang gehörte und ihre Entfernung für die lokale Ausführung technisch nicht erforderlich war.
Sie wurde als erste Handlergruppe implementiert, sodass der vorbereitete Aufrufweg zwischen Oberfläche, Preload, Dispatcher und lokaler Datenhaltung an einem zusammenhängenden Ablauf genutzt werden konnte.

`auth.handlers.ts` ordnet `register`, `login`, `logout` und `getMe` den Service-Aufrufen zu und übersetzt deklarierte Fehler.
`AuthService` übernimmt Registrierung, Passwortprüfung und Benutzerzuordnung; `UsersRepository` führt die Drizzle-Abfragen aus.
Nach der Datenbankinitialisierung werden die Module erzeugt und die Handler registriert.
Damit ist die in A2 geforderte Trennung erstmals für eine vollständige Operationsgruppe umgesetzt @StudyPlanLocalAuth2026.

Für das Hashen und Vergleichen der Passwörter wurde das bereits im Web-Backend verwendete Paket `bcryptjs` übernommen.
Passwort-Hashes bleiben im Main-Prozess und in der lokalen Benutzertabelle; die Oberfläche erhält nur die vorgesehenen Benutzerdaten.
An die Stelle der HTTP-Sitzung tritt `SessionService`, der die aktuelle Benutzerkennung im Main-Prozess hält.
Diese lokale Sitzung liegt im Arbeitsspeicher und endet beim Beenden der Anwendung; die Benutzerdatensätze bleiben dagegen in der SQLite-Datenbank gespeichert.
Die lokale Anmeldung ist von der später ergänzten Authentifizierung gegenüber entfernten Kollaborationsdiensten zu unterscheiden @StudienplanerSource2026 @StudyPlanLocalAuth2026.

Bei erfolgreicher Anmeldung oder Registrierung leert der Renderer den bisherigen React-Query-Cache, speichert die Benutzerinformation unter dem Query Key von `getMe` und navigiert zur Anwendung.
`UNAUTHENTICATED` führt zur Anmeldung und wird von der Query-Wiederholungslogik berücksichtigt.
Andere Ladefehler erhalten eine Anzeige mit erneuter Abfragemöglichkeit.
Die Weiterleitung bei bestehender Anmeldung erfolgt über einen React-Effekt @StudyPlanLocalAuth2026.

=== Integration der CRUD-Funktionen am Beispiel der Notenverwaltung <sec:crud-migration>

Nach der Oberflächenintegration und der lokalen Authentifizierung wurden die weiteren fachlichen Funktionen mit dem vorbereiteten Aufrufweg verbunden.
Die Migration der CRUD-Operationen wird exemplarisch an der Notenverwaltung beschrieben.
Anlegen, Lesen, Bearbeiten und Löschen folgen in den persönlichen Anwendungsbereichen einer wiederkehrenden Grundstruktur; eine separate Beschreibung jeder Variante würde überwiegend dieselben Transformationsschritte wiederholen.
Die Notenverwaltung wurde integriert, zunächst ohne CSV-Import.
Als fachliche Vorlage dienten die ursprünglichen Routen aus `artifacts/api-server/src/routes/grades.ts` @StudienplanerSource2026 @StudyPlanGradesMigration2026.

Die Übertragung bestand darin, die innerhalb der Route verbundenen Aufgaben nach ihren Verantwortlichkeiten aufzuteilen.
HTTP-spezifische Zugriffe auf `req` und `res` entfielen.
Die Eingabeprüfung wurde durch die bereits eingerichtete Vertragsvalidierung des Dispatchers übernommen.
Die Verarbeitung der Operationen und ihrer Fehler wurde den Handlern zugeordnet, die fachlichen Regeln dem Service und die Drizzle-Abfragen dem Repository.
@tab:grade-responsibilities zeigt diese Zuordnung am untersuchten Beispiel @StudyPlanGradesMigration2026.

#figure(
  {
    set par(justify: false)
    table(
      columns: (1fr, 1.3fr, 2.2fr),
      inset: 6pt,
      align: left,
      table.header([*Schicht*],
      [*Zielmodul*],
      [*Aufgabe im Notenbeispiel*]),
      [Schnittstelle],
      [`grades.handlers.ts`],
      [Operationszuordnung, Übernahme der Sitzungskennung und Übersetzung fachlicher Fehler.],
      [Fachlogik],
      [`GradesService`],
      [Anlegen und Ändern fachlicher Werte, Notenstatistik und Veranlassung von Aktivitätseinträgen.],
      [Datenzugriff],
      [`GradesRepository`],
      [Lesen und Schreiben der Notendatensätze über Drizzle mit benutzerbezogenen Auswahlbedingungen.],
    )
  },
  caption: [Aufteilung der ursprünglichen Notenrouten auf Handler, Service und Repository.],
) <tab:grade-responsibilities>

Die Module wurden in `src/main/index.ts` in den Startablauf eingebunden.
Nach der Datenbankinitialisierung werden `GradesRepository` und `ActivityLogRepository` mit der Datenbankverbindung erzeugt.
Beide werden an `GradesService` übergeben.
`createGradesHandlers` verbindet anschließend die Service-Aufrufe mit den vorgesehenen Operationskennungen und der bereits vorhandenen `SessionService`-Instanz.
Die resultierenden Handler werden in die gemeinsame Registry aufgenommen, die der IPC-Dispatcher verwendet.
Die fachliche Implementierung wird damit an die zuvor erzeugten Schnittstellen angeschlossen @StudyPlanGradesMigration2026.

Die Benutzerkennung stammt bei diesen Operationen aus der lokalen Sitzung im Main-Prozess.
Der gemeinsame Wrapper `authenticated` stellt sie dem Handler bereit.
Im Repository werden Änderungen und Löschungen anhand der Datensatzkennung und der Benutzerkennung eingeschränkt.
Findet eine solche Operation keinen passenden Datensatz, meldet der Service einen fachlichen Fehler, den der Handler in `NOT_FOUND` überführt.
Damit bleibt die persönliche Datenzuordnung Bestandteil des vollständigen Verarbeitungspfads @StudyPlanGradesMigration2026.

Die vorhandenen fachlichen Regeln wurden als Ausgangspunkt beibehalten.
Dazu gehören optionale Werte, die Erfassung von Aktivitäten, der ECTS-gewichtete Notendurchschnitt und die Auswertung nach Semester.
Anpassungen ergaben sich aus der lokalen Datenrepräsentation: Note und ECTS werden im SQLite-Schema als numerische Werte verarbeitet, sodass die bisher für PostgreSQL verwendete Umwandlung in Strings beziehungsweise deren Rückkonvertierung entfallen konnte.
Die Migration übernahm somit die fachlichen Berechnungen und gliederte ihre Ausführung neu @StudienplanerSource2026 @StudyPlanGradesMigration2026.

Für die integrierten CRUD-Funktionen ergibt sich der Aufrufweg *Formular → Hook → Preload/IPC → Dispatcher → Handler → Service → Repository → SQLite*.
Bei der Notenerfassung übermittelt die vorhandene Seite beispielsweise die Formulardaten über `useCreateGrade` beziehungsweise `useUpdateGrade`.
Der generierte Hook bildet die Eingabe auf den IPC-Vertrag ab.
Nach Prüfung und Ausführung gelangt das Ergebnis über den Dispatcher und den API-Client zurück zum Hook.
Die Oberfläche aktualisiert anschließend die Abfragen für Notenliste und Statistik @StudyPlanGradesMigration2026.

@fig:grades-crud-flow stellt diesen Ablauf mit den beteiligten Prozessbereichen und dem Rückweg des Ergebnisses dar.

#figure(
  image("../figures/grades-crud-flow.svg", width: 100%),
  caption: [Lokaler CRUD-Aufrufweg am Beispiel der Notenerfassung. Durchgezogene Pfeile zeigen die Anfrage, gestrichelte Pfeile den Rückweg und die anschließende Aktualisierung der Oberfläche.],
) <fig:grades-crud-flow>

Diese Grundstruktur kann für weitere CRUD-Bereiche erneut angewandt werden.
Dabei sind jeweils die zugehörigen Vertragsdefinitionen, fachlichen Regeln, Datenzugriffe und Berechtigungen zu berücksichtigen.
Die Wiederholung betrifft die Verteilung der Verantwortlichkeiten und den Kommunikationsweg; die Berechtigungsregeln gemeinsamer Gruppenressourcen sind gesondert von der persönlichen Datenzuordnung zu prüfen.
Die Struktur konkretisiert damit A2 und das in A8 geforderte Erweiterungsmuster.

`scripts/grades/grades.test.ts` verbindet den generierten Client mit Dispatcher, Handlern, Service, Repositories und einer SQLite-Datenbank im Arbeitsspeicher.
Geprüft werden Sitzung, persönliche Datenzuordnung, Änderungen, Aktivitäten und Statistik.
Der direkte Dispatcher-Aufruf ersetzt die native IPC-Kommunikation.
Der Test prüft damit die Fachlogik samt Datenzugriff.

=== Lokaler Dateiimport am Beispiel iCal <sec:file-import-migration>
Das Importmuster wird am iCal-Import beschrieben.
Im Web-Prototyp übermittelte die Kalenderseite die gewählte Datei als FormData mit fetch an /api/events/import-ical.@lst:ical-web-upload zeigt die Dateiannahme und den Parseraufruf aus artifacts/api-server/src/routes/events.ts des Web-Prototyps.
Der Ausschnitt verdeutlicht die Bindung an HTTP: Die Datei stammt aus req.file, die Benutzerkennung aus der Sitzung und Fehler werden unmittelbar als HTTP-Antwort ausgegeben.
Die anschließende fachliche Abbildung und Speicherung lagen im selben Route-Handler und sind hier ausgelassen.
#figure(
block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
set text(size: 8.5pt)
raw(read("../code/ical-web-upload.ts"), lang: "typescript", block: true)
}),
kind: raw,
supplement: [Quellcode],
caption: [Dateiannahme und iCal-Parseraufruf im Web-Prototyp; gekürzter und für die Darstellung umgebrochener Ausschnitt aus der ursprünglichen Express-Route @StudienplanerSource2026.],
) <lst:ical-web-upload>
Die fachliche Grundlage des Imports stammt somit aus dem Ausgangsartefakt @StudienplanerSource2026 @StudyPlanIcalMigration2026.
In der Desktop-Anwendung wurde dieser HTTP-Upload in eine lokale Importoperation überführt.
Aus Sicherheitsgründen – insbesondere zur Wahrung des Prinzips der geringsten Rechte und zur Vermeidung von Path-Traversal-Schwachstellen – darf der Renderer keine absoluten Dateipfade anfordern oder übergeben.
Stattdessen löst die Oberfläche die Operation lediglich aus, während die Dateiauswahl und das Einlesen vollständig im privilegierten Main-Prozess verbleiben @ElectronContextBridge2026.
Hierfür wurde der OpenAPI-Vertrag um die parameterlose Operation importEventsIcal sowie das Ergebnisschema EventIcalImportResult erweitert.
Die bereits etablierte Generierungs- und Validierungspipeline greift dadurch unmittelbar @StudyPlanIcalMigration2026.
@fig:local-file-import-flow
fasst den daraus resultierenden Ablauf zusammen.
Der Renderer reagiert auf den Klick in der Oberfläche und sendet ausschließlich die Importanfrage; Dateiauswahl, Einlesen und Verarbeitung werden vom Main-Prozess veranlasst.
Der native Dateidialog liefert dabei zunächst den ausgewählten Pfad oder einen Abbruch zurück, nicht den Dateiinhalt.
#figure(
image("../figures/local-file-import-flow.svg", width: 100%),
caption: [Lokaler Dateiimport am Beispiel iCal. Der Renderer löst den Import über IPC aus; der Main-Prozess öffnet den nativen Dateidialog und verarbeitet die ausgewählte Datei. Ein Abbruch überspringt die Verarbeitung und Speicherung.],
) <fig:local-file-import-flow>

Die Dateiauswahl steuert NativeIcalFilePicker im Main-Prozess.
Er ruft dialog.showOpenDialog mit einem Filter für ICS-Dateien auf und bindet den Dialog modal an das anfragende Anwendungsfenster @ElectronDialog2026 @StudyPlanIcalMigration2026.
Bricht der Benutzer den Vorgang ab, endet die Verarbeitung unmittelbar mit status: cancelled und beiden Zählwerten auf 0, ohne den Datenbestand zu verändern.
Wird eine Datei gewählt, verbleibt der absolute Pfad innerhalb des Main-Prozesses.
Die Implementierung prüft die Endung .ics, den regulären Dateityp sowie die aus der ursprünglichen Multer-Konfiguration übernommene Größenobergrenze von 10 MiB vor und nach dem Einlesen, bevor der Inhalt als UTF-8-Text bereitgestellt wird @StudienplanerSource2026 @StudyPlanIcalMigration2026.
Die semantische Interpretation der Kalenderdaten kapselt src/main/services/events-ical.parser.ts.
Das Modul nutzt weiterhin die Bibliothek node-ical und übernimmt die bestehenden fachlichen Abbildungen, trennt die Formatprüfung jedoch strikt von Sitzungskontext und Datenbankzugriff.
Gegenüber dem Prototyp wurden Prüfungen der grundlegenden Kalenderstruktur, der Validität von Zeitangaben sowie der Ausschluss invertierter Zeitspannen (Enddatum vor Startdatum) ergänzt.
Übersprungene Einträge werden nun separat erfasst @StudyPlanIcalMigration2026.

EventsService.importEventsIcal verarbeitet die validierte Parserausgabe fachlich.
Der Dienst reichert die Termine mit der Benutzerkennung an, übergibt sie gesammelt an EventsRepository.createManyEvents und legt den zugehörigen Aktivitätseintrag an.
Über die Schnittstelle IcalFilePicker wird der konkrete Picker als Abhängigkeit an createEventsHandlers übergeben.
Dateiauswahl, Parsing, fachliche Koordination und Datenpersistenz sind dadurch in klar voneinander getrennte Schichten unterteilt @StudyPlanIcalMigration2026.

Das Ergebnis der Operation wird über den Dispatcher typisiert an das Frontend zurückgegeben:
Bei erfolgreicher Verarbeitung liefert der Handler status: imported zusammen mit importedCount und skippedCount; fehlerhafte Kalenderstrukturen werden in VALIDATION_ERROR überführt.
In der Kalenderseite stößt der generierte Mutation-Hook useImportEventsIcal den Ablauf an, deaktiviert während der Laufzeit die Bedienelemente (isPending) und invalidiert bei Erfolg die Termin-Caches zur Aktualisierung der Ansicht @StudyPlanIcalMigration2026. 
Dasselbe Architekturmuster (nativer Picker → Format-Parser → Service → Repository) wurde analog für den CSV-Notenimport (importGradesCsv) adaptiert.
Anstelle einer externen Bibliothek kommt dort ein maßgeschneiderter Parser (grades-csv.parser.ts) zum Einsatz.
Dies zeigt, dass das vorgestellte Entwurfsmuster für lokale Dateiimporte sowohl Standardbibliotheken als auch spezialisierte Eigenimplementierungen gleichermaßen aufnehmen kann @StudyPlanCsvMigration2026.

=== Abschluss der Offline-Kernanwendung und Übergang zu Phase 2

Mit der Realisierung der lokalen Datenhaltung, der Portierung der Oberfläche sowie der IPC-gestützten Schnittstellen- und Importarchitektur ist die erste Migrationsphase abgeschlossen. 
Die zentralen Domänen – Authentifizierung, Dashboard, Kalender, Notenverwaltung und Stundenplan – operieren nun vollständig autark innerhalb der Desktop-Anwendung. 
Durch die Bereitstellung von Referenzdaten über initiale Migrationen und die lokale Ausführung von Dateiimporten im Main-Prozess agiert das System ohne Rückgriff auf ein entferntes Web-Backend @StudyPlanLocalCore2026.

Dieser Zwischenstand markiert einen wesentlichen Meilenstein für die Erfüllung der Architekturziele:

Autarkie und Persistenz (A1, A5): Der fehlerfreie Start ohne Netzwerkverbindung und die Beständigkeit des Datenbestands über Anwendungsneustarts hinweg belegen die Funktionsfähigkeit der Offline-Kernanwendung.

Architektur und Kommunikation (A2, A4): Die strikte Trennung in Handler, Services und Repositories sowie der typisierte IPC-Dispatcher gewährleisten eine saubere Kapselung der Prozesswelten.

Wiederverwendung und Erweiterbarkeit (A3, A8): Die Beibehaltung der vertragsbasierten Schemata und das einheitliche Entwurfsmuster für Importe bilden das Fundament für künftige Funktionserweiterungen.

Während die tiefergehende messtechnische Validierung von Laufzeiten und Persistenzverhalten Gegenstand der Evaluation in @ch:experiments ist, bildet die lokale Kernanwendung die geschlossene Basis für Phase 2. 
Diese erweitert das System gezielt um synchrone Kommunikationspfade: Neben dem selektiven Abruf externer Katalogdaten wird eine Synchronisierung für gemeinsame Aufgaben ergänzt, wobei die Hoheit über persönliche Daten und deren lokale Verarbeitung uneingeschränkt erhalten bleibt.

== Phase 2: Netzwerkanbindungen und Local-First-Synchronisierung

Die zweite Phase ergänzt gezielt Funktionen, die eine Verbindung zu entfernten Diensten voraussetzen, während die lokale Offline-Fähigkeit als architektonische Basis erhalten bleibt.

=== Auswahlkriterien und betrachtete Synchronisierungslösungen <sec:sync-tool-selection>

Die Auswahl einer Synchronisierungskomponente orientiert sich primär an zwei zentralen Vorgaben:
Einerseits verlangt Anforderung A3 die Beibehaltung der in Phase 1 etablierten Schichtentrennung auf Basis von TypeScript und dem ORM Drizzle.
Andererseits fordert Anforderung A6 den automatischen Datenabgleich nach lokaler Verarbeitung.
Um den Entwicklungsaufwand zu begrenzen und den Fokus auf Migrationsmuster zu legen, wurde eine bestehende Lösung statt einer fehleranfälligen Eigenentwicklung für Konfliktbehandlung, Offline-Queues und Verbindungsunterbrechungen evaluiert.

Als Kernkriterien für die Vorauswahl galten die Ausführbarkeit im Electron-Main-Prozess, eine direkte SQLite- und Drizzle-Kompatibilität sowie die Anbindungsmöglichkeit an externe Datenbank-Backends.
In die engere Betrachtung kamen zwei grundsätzlich verschiedene Architekturansätze:
PowerSync als dedizierte Synchronisationsschicht (@PowerSyncNode2026) und Turso als verteilte Datenbankinfrastruktur auf libSQL-Basis (@TursoEmbeddedReplicas2026).
@tab:sync-tool-options stellt die architektonischen Profile beider Optionen gegenüber.

#figure(
  {
    set par(justify: false)
    table(
      columns: (1.2fr, 2fr, 2fr),
      inset: 6pt,
      align: left,
      table.header(
        [*Kriterium*],
        [*PowerSync*],
        [*Turso (libSQL)*]
      ),
      [Architekturrolle],
      [Synchronisations-Middleware vor relationaler Backend-Datenbank],
      [Verwaltete Cloud-Datenbank mit integrierten lokalen Replikaten (Embedded Replicas)],

      [Drizzle-Integration],
      [Schema-Ableitung und Abfrage-Wrapper via `@powersync/drizzle-driver` @PowerSyncDrizzleDriver2026],
      [Nativer Datenzugriff via `drizzle-orm/libsql` über den libSQL-Client @DrizzleTurso2026],

      [Entfernte Datenhaltung],
      [Flexibel anbindbare PostgreSQL-Instanzen (z. B. Supabase) @PowerSyncSupabase2026],
      [Zentral verwaltete Datenbankinstanz in der Turso Cloud @TursoEmbeddedReplicas2026],
    )
  },
  caption: [Vergleich der Integrationsansätze für die Local-First-Synchronisation.],
) <tab:sync-tool-options>
=== Entscheidung für PowerSync und Supabase

Für den Demonstrator wurde eine Architektur mit entferntem Backend gewählt, das den gemeinsamen Datenbestand der Gruppen hält.
Ein Peer-to-Peer-Ansatz wäre grundsätzlich eine andere Entwurfsrichtung; er wurde in dieser Arbeit nicht weiterverfolgt.
Auch für das Backend sollten vorhandene Dienste verwendet werden, um die Infrastrukturentwicklung innerhalb des festgelegten Untersuchungsumfangs zu halten.

Die Wahl fiel auf Supabase weil es eine PostgreSQL-Datenbank sowie Authentifizierung mit SDKs und API-Endpunkten bereitstellt @SupabaseDatabase2026 @SupabaseAuth2026.
Ausschlaggebend war seine dokumentierte Integration mit PowerSync: Ausgewählte PostgreSQL-Daten werden in lokale SQLite-Datenbanken übertragen; lokale Änderungen werden gespeichert, in eine Upload-Warteschlange aufgenommen und bei verfügbarer Verbindung über einen Connector an das Backend übermittelt.
Sync Streams legen fest, welche Daten an die jeweiligen Clients übertragen werden @PowerSyncSupabase2026.

Diese Kombination passte zum Feature Studiengruppen: Unterschiedliche Benutzer sollen auf gemeinsame Aufgaben zugreifen und Änderungen zunächst lokal ausführen können.
PowerSync verband dafür die lokale SQLite-Verarbeitung und die Drizzle-Anbindung mit Supabase als entferntem Backend.
Die Anwendung musste weiterhin ihre Datenschemata, den Upload-Connector und die fachlichen Zugriffsregeln implementieren.
Der Einsatz der Dienste begrenzte damit die zusätzlich zu entwickelnde Synchronisierungsinfrastruktur.

Die Entscheidung gegen Turso beruht auf dieser projektbezogenen Passung.
Auch Turso ermöglicht Synchronisierung und Offline-Schreibzugriffe; die Turso-Sync-Dokumentation beschreibt hierfür lokale Änderungen mit späterem `push()` und den Empfang entfernter Änderungen über `pull()` @TursoSync2026.
Für den gewählten Supabase-Entwurf bot PowerSync eine unmittelbar dokumentierte Verbindung von Authentifizierung, Backend-Datenbank und gezielter Datenverteilung @PowerSyncSupabase2026.
Die Auswahl begründet daher die verwendete Kombination, ohne eine allgemeine Überlegenheit gegenüber Turso zu behaupten.

=== Vorprüfung der Integration und Grenzen der Wiederverwendung

Die praktische Integrationsfähigkeit von PowerSync wurde im Vorfeld anhand zweier fokussierter Prototypen evaluiert @StudyPlanSyncSpikes2026:
- *Erster Prototyp:* Prüfung der Ausführung des Node-SDKs innerhalb des Electron-Main-Prozesses, der lokalen Datenpersistenz samt Upload-Warteschlange (_Upload Queue_), der Schemaerweiterung, des geräteübergreifenden Abgleichs sowie der Paketierung.
- *Zweiter Prototyp:* Ergänzung des Drizzle-Wrappers zur Evaluierung typisierter CRUD-Abfragen und der korrekten Abbildung relationaler Datentypen.

Die daraus resultierenden Berichte bestätigten sowohl die lokale Funktionsfähigkeit als auch den erfolgreichen Abgleich über Supabase und PowerSync. Diese Ergebnisse stützten die Entscheidung, die Synchronisierung schrittweise und zunächst beschränkt auf einen isolierten Kollaborationsbereich einzuführen. Zu beachten ist, dass sich diese Vorprüfung ausschließlich auf die Machbarkeit des gewählten Technologiestacks konzentrierte; ein empirischer Vergleich mit alternativen Synchronisierungslösungen fand im Rahmen dieses Prototypings nicht statt @StudyPlanSyncSpikes2026.

Hinsichtlich der Wiederverwendbarkeit bestehender Softwarekomponenten ermöglichte die Anbindung von Drizzle eine weitgehende Übernahme von Typdefinitionen, Abfragelogiken und Repository-Mustern:
- Über das Konstrukt `DrizzleAppSchema` wird das lokale Schema für PowerSync direkt aus den bestehenden Drizzle-Tabellendefinitionen abgeleitet.
- Die Hilfsfunktion `wrapPowerSyncWithDrizzle` stellt den gewohnten typisierten Datenzugriff auf den synchronisierten Datenbestand bereit @StudyPlanSyncSpikes2026.

Die Datenhaltung erfordert jedoch eine organisatorische Trennung der Schemaverantwortung:
- *Synchronisierter Datenbestand:* PowerSync übernimmt die autonome Verwaltung und Migration der lokalen Tabellenstruktur.
- *Persönlicher Datenbestand:* Für die rein lokale Datenbank aus Phase 1 verbleibt die Migrationsverwaltung bei Drizzle Kit.
- *Backend & Synchronisationsregeln:* Serverseitige PostgreSQL-Migrationen sowie die Konfiguration der _Sync Streams_ werden separat gepflegt @StudyPlanSyncSpikes2026.

Durch diesen Aufbau bleibt Drizzle als Abstraktionsschicht für den typisierten Datenzugriff erhalten, während die strukturelle Verwaltung synchronisierter Daten und Identitäten strikt an die Vorgaben des Synchronisationsdienstes delegiert wird.

=== Architektur mit zwei lokalen Datenhaltungsbereichen <sec:sync-architecture>

Durch die Einbindung von PowerSync und Supabase erweitert sich das vormals rein lokale System um externe Cloud-Dienste. 
Die Prozessgrenzen innerhalb der Desktop-Anwendung bleiben dabei gewahrt: Der Electron-Renderer kommuniziert weiterhin ausschließlich über die restriktive Preload-/IPC-Schnittstelle, während der Main-Prozess den Datenzugriff und die Netzwerkanbindung zentral koordiniert.

Auf Persistenzebene führt diese Erweiterung zu einem *Dual-Database-Ansatz* auf dem Client @StudyPlanSyncArchitecture2026:
1. *Persönlicher Bereich:* Die SQLite-Datenbank aus Phase 1 verwaltet weiterhin persönliche Daten sowie lokale, nicht synchronisierte Gruppen.
2. *Kollaborationsbereich:* Für das synchronisierte Feature Studiengruppen wird eine separate SQLite-Datenbank instanziiert.
PowerSync übernimmt hierbei sowohl die Strukturverwaltung als auch den Datentransport. 
Zur strikten Datentrennung wird pro entfernter Benutzeridentität eine eigenständige Datenbankdatei angelegt.

Serverseitig fungiert eine PostgreSQL-Instanz bei Supabase als gemeinsame Datengrundlage.

#figure(
  image("../figures/local-first-architecture.svg", width: 100%),
  caption: [Architektur nach Ergänzung der Synchronisierung im Feature Studiengruppen.
    Dargestellt sind die beiden lokalen Datenhaltungsbereiche sowie direkte Online-Aufrufe, Upload und Download.
    Der separate Datenabruf im Feature Studiengänge ist hier nicht dargestellt.
    Eigene Darstellung nach @StudyPlanSyncArchitecture2026 und @PowerSyncSupabase2026.],
) <fig:local-first-architecture>

Wie in @fig:local-first-architecture dargestellt, erfolgt die Kommunikation über getrennte Pfade:
- *Upload-Pfad (Schreibzugriffe):* Lokale Änderungen (z. B. an kollaborativen Aufgaben) werden zunächst in der lokalen Kollaborationsdatenbank persistiert und über eine Upload-Warteschlange (_Upload Connector_) an die Supabase-REST-API übertragen.
- *Download-Pfad (Replikation):* Der PowerSync-Dienst transformiert serverseitige PostgreSQL-Änderungen anhand definierter _Sync Streams_ und repliziert diese automatisch in den lokalen Datenbestand des Clients @PowerSyncSupabase2026 @StudyPlanSyncArchitecture2026.

*Grenzen der Offline-Fähigkeit:*
Nicht alle Gruppenoperationen folgen diesem asynchronen Replikationsmuster. 
Administrative Funktionen wie das Anlegen neuer Gruppen, die Profilsuche sowie der Einladungsversand setzen eine aktive Netzwerkverbindung voraus und werden über synchrone Online-Aufrufe abgewickelt. 
Zudem verbleibt das Authentifizierungs-Token im aktuellen Demonstrator rein flüchtig im Arbeitsspeicher, womit ein Anwendungsneustart stets eine erneute Authentifizierung erfordert. 
Die lokale Speicherung synchronisierter Aufgaben bedeutet daher keine uneingeschränkte Offline-Verfügbarkeit aller Gruppenfunktionen @StudyPlanSyncArchitecture2026.
=== Verantwortung für Schemaänderungen und Updates <sec:sync-schema-updates>

Die Einführung der Synchronisierung verändert das Vorgehen bei Schemaänderungen grundlegend: Verwaltete die Desktop-Anwendung in Phase 1 ihre lokale Datenbank noch autonom über mitgelieferte Drizzle-Migrationen, erfordern synchronisierte Funktionen nun eine koordinierte Bereitstellung über drei Entitäten hinweg:
+ das relationale PostgreSQL-Schema im Supabase-Backend,
+ die Verteilungs- und Filterregeln im PowerSync-Replikationsdienst sowie
+ das lokale Anwendungsschema auf dem Client.

Während das Backend über versionierte SQL-Migrationen aktualisiert wird @SupabaseSchemaMigrations2026, erfolgt die Schemaverwaltung auf dem Client deklarativ: Das mittels `DrizzleAppSchema` abgeleitete Schema wird beim Initialisieren an das PowerSync-SDK übergeben @StudyPlanSyncIntegration2026. Das Standardmodell von PowerSync speichert replizierte Datensätze lokal als Rohdaten (JSON) und projiziert diese dynamisch über SQLite-Views in das Zielformat. Schemaanpassungen werden somit beim Start einer neuen Anwendungsversion unmittelbar durch die Neudefinition dieser Views wirksam, ohne dass separate clientseitige Migrationsskripte erforderlich sind @PowerSyncSchemaChanges2026. Die Drizzle-Migrationen verbleiben daher exklusiv bei der lokalen Datenbank der Kernanwendung.

Für additive Anpassungen – beispielsweise das Einfügen einer synchronisierten Tabelle – ergibt sich hieraus ein deterministischer Bereitstellungsablauf @PowerSyncSchemaDeployment2026:

+ *Backend-Erweiterung:* Zunächst wird das Schema in Supabase aktualisiert. Dies umfasst Tabellenstrukturen, Zugriffsregeln (Row-Level Security) sowie etwaige Anpassungen backendseitiger RPC-Funktionen.
+ *Synchronisationskonfiguration:* Die neue Tabelle wird in die PostgreSQL-Publication aufgenommen und in die Dienstkonfiguration von PowerSync (`sync-streams.yaml`) eingebunden. Die Bereitstellung der aktualisierten Konfiguration muss serverseitig abgeschlossen sein, bevor abhängige Client-Funktionen freigegeben werden.
+ *Client-Rollout:* Abschließend wird die neue Desktop-Version verteilt, die das erweiterte Drizzle-/PowerSync-Schema enthält und die neuen Datenstrukturen konsumiert.

Nicht-additive Änderungen wie Umbenennungen, Typumwandlungen oder das Löschen von Attributen bedürfen zusätzlicher Übergangsphasen @PowerSyncSchemaChanges2026. Da Clients nach längeren Offline-Phasen noch ungesendete Schreiboperationen im alten Format übertragen können oder Anwendungsupdates verzögert installiert werden, müssen Lese- und Schreibformate rückwärtskompatibel gehalten werden (beispielsweise über versionierte Streams oder serverseitige Transformationen).

Ein vollständiger Migrationszyklus über mehrere divergierende Anwendungs- und Backend-Versionen hinweg wurde im Rahmen des Demonstrators nicht praktisch durchlaufen; die beschriebenen Anforderungen definieren den architektonischen Rahmen für den späteren Produktivbetrieb.

=== Technische Integration der Kollaborationsmodule <sec:sync-implementation>

==== Datenmodell und Typabbildung

Die technische Umsetzung begann mit der Synchronisation des Datenmodells zwischen PostgreSQL und dem lokalen PowerSync-Bestand:
- *Identifikatoren:* Die fünf Tabellen des Features Studiengruppen wurden in Supabase über versionierte SQL-Migrationen auf Basis von UUID-Primärschlüsseln angelegt. Das lokale Drizzle-Schema bildet diese als Zeichenketten (`text`) ab. Neue Datensätze generieren ihre UUIDs bereits vorab auf dem Client, um optimistische lokale Schreibvorgänge zu ermöglichen. Damit weicht das Kollaborationsmodell gezielt von den inkrementellen numerischen Schlüsseln der Kernanwendung ab @StudyPlanSyncIntegration2026.
- *Datentypen:* Datums- und Zeitwerte werden lokal als ISO-8601-Zeichenketten abgebildet; boolesche Attribute werden über den nativen SQLite-Ganzzahltyp (`0` bzw. `1`) repräsentiert.
- *Schemaableitung:* Die zentrale Datei `schema.ts` definiert diesen lokalen Tabellenbestand und generiert mittels `DrizzleAppSchema` die für das PowerSync-SDK erforderliche Konfigurationsstruktur.

==== Backend-Publikation und Replikationsregeln

Um Änderungen an verbundene Clients zu verteilen, wurden die Tabellen der PostgreSQL-Publication `powersync` zugewiesen und für die Replikationsrolle freigegeben. Die Autorisierung des Replikationsdienstes gegenüber Supabase stützt sich auf die Validierung der ausgestellten Anmeldetoken @PowerSyncSupabase2026.

Die deklarative Datenverteilung erfolgt über die Dienstkonfiguration `sync-streams-v4.yaml`. Diese definiert auf Basis von SQL-Abfragen, welche Teilmengen an die jeweiligen Clients repliziert werden. Schreib- und Lesepfade sind hierbei asymmetrisch getrennt: Die Streams regeln ausschließlich den nachgelagerten Download, während Autorisierungsprüfungen für Schreibzugriffe im Backend greifen @StudyPlanSyncIntegration2026.

@lst:collaboration-stream illustriert die Definition des Aufgaben-Streams: Die Pseudofunktion `auth.user_id()` liefert die Identität des authentifizierten Clients. Über eine Unterabfrage (`user_groups`) werden dessen aktive Gruppenmitgliedschaften ermittelt, woraufhin die Replikation auf Aufgaben dieser Gruppen beschränkt wird. Ähnliche Selektionsregeln steuern die Verteilung von Gruppenmetadaten, Profilen und Einladungen.

#figure(
  block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
    set text(size: 8.5pt)
    raw(read("../code/collaboration-stream.yaml"), lang: "yaml", block: true)
  }),
  kind: raw,
  supplement: [Quellcode],
  caption: [Auswahl gemeinsamer Aufgaben in `sync-streams-v4.yaml` (Auszug) @StudyPlanSyncIntegration2026.],
) <lst:collaboration-stream>

Der PowerSync-Dienst überwacht das PostgreSQL-Write-Ahead-Log (WAL) und repliziert passende Änderungen kontinuierlich. Durch `auto_subscribe: true` wird der Stream beim Verbindungsaufbau automatisch abonniert. Das Client-SDK übernimmt die Datenübertragung und persistiert die Datensätze lokal, wo sie durch Anwendungs-Repositories via Drizzle abgefragt werden @PowerSyncStreams2026. 

==== Laufzeitabhängigkeiten und native Bindungen

Die Integration des Replikationsmoduls erforderte Anpassungen des Node- und Electron-Laufzeitumfelds. @tab:sync-integration-packages fasst die ergänzten Pakete zusammen.

#figure(
  {
    set par(justify: false)
    table(
      columns: (1fr, 1.4fr),
      inset: 6pt,
      align: left,
      table.header([*Ergänztes Paket*],
      [*Aufgabe im Demonstrator*]),
      [`@powersync/node`],
      [Lokale PowerSync-Datenbank, Replikationsverbindung und Upload-Warteschlange.],
      [`@powersync/drizzle-driver`],
      [Ableitung des Client-Schemas und Bereitstellung der typisierten Drizzle-Abstraktion.],
      [`@supabase/supabase-js`],
      [Authentifizierung, synchrone RPC-Aufrufe und Upload lokaler Daten an die Backend-API.],
      [`better-sqlite3`],
      [Nativer SQLite-Treiber für die PowerSync-Verbindung.],
    )
  },
  caption: [Für den Kollaborationsbereich ergänzte Laufzeitabhängigkeiten @StudyPlanSyncIntegration2026.],
) <tab:sync-integration-packages>

Im Gegensatz zur Kernanwendung, die libSQL verwendet, nutzt das PowerSync-Node-SDK den Treiber `better-sqlite3` @PowerSyncNode2026. Zur Vermeidung von Blockaden des Haupt-Threads wird die Datenbankinstanz über einen dedizierten Node-Worker (`powersync.worker?nodeWorker`) ausgeführt @StudyPlanSyncIntegration2026. 

Da Electron native Binärmodule standardmäßig in einem virtuellen ASAR-Archiv bündelt, native C-Erweiterungen für den Dateizugriff unter Betriebssystemen wie Windows jedoch reale Pfade im Dateisystem voraussetzen, wurde die Paketierungskonfiguration (`electron-builder.yml`) angepasst @ElectronAsar2026:
- Die Pakete `@powersync/node` und `better-sqlite3` werden über die Direktive `asarUnpack` explizit unkomprimiert im Verzeichnis `app.asar.unpacked` abgelegt.
- Das Skript `electron-builder install-app-deps` kompiliert die nativen Bindungen im `postinstall`-Schritt gegen die ABI der Ziel-Electron-Version @StudyPlanSyncIntegration2026 @StudyPlanSyncSpikes2026.

==== Anwendungsarchitektur und IPC-Verträge

Die Steuerung des synchronisierten Bereichs obliegt dem Modul `CollaborationRuntime`. Es kapselt den Sitzungszustand, verwaltet die Verbindungslebenszyklen und steuert den Datenzugriff:
1. *Verbindungsaufbau:* Nach erfolgreicher Authentifizierung öffnet die Laufzeitumgebung eine benutzerbezogene SQLite-Datenbank (`collaboration-${userId}.db`) und initialisiert den PowerSync-Connector (@lst:collaboration-connect).
2. *Connector-Aufgaben:* Der Connector delegiert Authentifizierungsanfragen über `fetchCredentials` an Supabase und wickelt über `uploadData` das Leeren der lokalen Upload-Warteschlange via API ab.
3. *Netzwerkgateway:* Funktionen, die eine zwingende Online-Verbindung voraussetzen (Gruppenerstellung, Nutzersuche, Einladungsversand), werden außerhalb des asynchronen Replikationspfads direkt über `online-gateway.ts` via Supabase-RPC abgewickelt @StudyPlanSyncIntegration2026.

#figure(
  ```ts
  const userId = await connection.connector.getUserId()
  const directory = join(this.userDataDirectory, 'collaboration')
  database = await openCollaborationDatabase(
    directory,
    `collaboration-${userId}.db`
  )
  await database.powerSync.connect(connection.connector)
  ```,
  caption: [Initialisierung und Verbindung der benutzerspezifischen Kollaborationsdatenbank; Auszug aus `CollaborationRuntime.signIn` @StudyPlanSyncIntegration2026.],
) <lst:collaboration-connect>

Die IPC-Schicht zwischen Renderer- und Main-Prozess spiegelt diese Trennung wider:
- *Kernanwendung:* Verwendet weiterhin den etablierten Kanal `api:invoke` über `window.apiTransport`.
- *Kollaboration:* Verwendet den dedizierten Kanal `collaboration:invoke` über `window.collaborationTransport`.

Der Vertrag für die Kollaborationsschnittstelle ist in `src/shared/collaboration/ipc.ts` hinterlegt. Im Gegensatz zu den generierten OpenAPI-Verträgen der Kernanwendung wird dieser Vertrag projektintern manuell typisiert und im Main-Prozess über Zod-Validierungsschemata gegen fehlerhafte oder unberechtigte Aufrufe abgesichert @StudyPlanSyncIntegration2026. Diese Separierung auf Transportebene resultiert primär aus den unterschiedlichen Lebenszyklen und Modulverträgen der beiden Funktionsbereiche; eine spätere Vereinheitlichung der Datenhaltung würde diese fachliche Schnittstellentrennung daher nicht zwangsläufig aufheben.

@fig:collaboration-modules stellt die resultierende Modulverteilung und die jeweiligen Kommunikationspfade zusammenfassend dar.

#figure(
  image("../figures/collaboration-modules.svg", width: 100%),
  caption: [Modulaufteilung der Kollaborationsintegration neben der lokalen Kernanwendung.
    Blaue Pfeile: Lokale Aufrufe und Datenzugriffe; violette Pfeile: Externe Dienstkommunikation; gestrichelter Pfeil: Deklarative Schemaeinbindung.
    Eigene Darstellung nach @StudyPlanSyncIntegration2026.],
) <fig:collaboration-modules>

=== Anpassung des Einladungsablaufs und vorausgesetzte Konten <sec:collaboration-invitations>

Der Ausgangsprompt benannte Gruppeneinladungen über Link oder E-Mail.
Im Web-Prototyp erzeugte die Gruppenroute einen Einladungstoken.
Die Oberfläche bildete daraus eine URL und kopierte sie in die Zwischenablage; die Weitergabe erfolgte außerhalb der Anwendung.
Bereits vorhanden waren außerdem die Seite `/einladung/:token` zum Anzeigen und Annehmen der Einladung sowie Backend-Routen zum Lesen des Tokens und zum Gruppenbeitritt @StudienplanerInviteReview2026.
Der alternative Ablauf lässt sich daher nicht mit vollständig fehlender Beitrittslogik begründen.

Die statische Prüfung zeigt allerdings eine Lücke im Übergang zur Anmeldung: Die Einladungsseite übergibt mit `redirect` eine Rücksprungadresse, die Login-Seite navigiert nach erfolgreicher Anmeldung jedoch zu `/`, ohne diesen Parameter auszuwerten.
Damit ist keine automatische Rückkehr zur Einladung umgesetzt @StudienplanerInviteReview2026.
Eine Laufzeitprüfung der ursprünglichen Replit-Bereitstellung wurde nicht durchgeführt; aus diesem Befund folgt kein Nachweis, dass der gesamte Einladungsablauf dort grundsätzlich unbrauchbar war.

Für das synchronisierte Feature Studiengruppen wurde ein anderer Einladungsablauf implementiert.
Supabase Auth verwaltet die entfernten Benutzerkonten; die anwendungsbezogenen Namen und Kennungen liegen in einer zugeordneten `profiles`-Tabelle.
Die Trennung zwischen Auth-Daten und über die Anwendungs-API zugänglichen Profilen entspricht dem von Supabase dokumentierten Ansatz @SupabaseUserManagement2026.
Neu entwickelt wurde eine Suche nach Benutzer- oder Anzeigenamen.
Die Funktion `search_invitable_profiles` steht dem angemeldeten Gruppeneigentümer zur Verfügung und liefert bis zu 20 passende, als auffindbar markierte Profile.
Eigene Identität, vorhandene Mitglieder und Personen mit bereits ausstehender Einladung werden ausgeschlossen.
Als Ergebnis werden Kennung, Benutzername und Anzeigename übermittelt @StudyPlanSyncArchitecture2026.

Dieser Entwurf setzt für den Demonstrator voraus, dass Gruppeneigentümer die Existenz und die angegebenen Namen auffindbarer Profile kennen dürfen.
Die Annahme vereinfacht die Auswahl innerhalb der Anwendung und ist eine fachliche Entscheidung der Fallstudie.
Sie bedeutet keine Freigabe sämtlicher Auth-Daten und ersetzt keine Festlegung der gewünschten Auffindbarkeit in einer produktiven Anwendung.

Die Auswahl eines Profils führt zu einer personenbezogenen Einladung über `send_group_invitation`.
Die eingeladene Person erhält den Eintrag durch PowerSync und kann ihn mit `respond_group_invitation` annehmen oder ablehnen.
Nach der Annahme entsteht die Mitgliedschaft, anhand derer die Gruppendaten übertragen werden @StudyPlanSyncArchitecture2026.
Die Benutzersuche und der zugehörige Einladungsablauf verändern die ursprüngliche Benutzerführung.
Damit konnte die Interaktion mit dem entfernten Backend innerhalb der Anwendung demonstriert werden, ohne zusätzlich die externe Linkweitergabe und den Wiedereinstieg in die Desktop-Anwendung auszuarbeiten.
Der Ablauf ist eine fachliche Anpassung des Untersuchungsumfangs und keine technisch zwingende Folge des Transportwechsels.

Für die Fallstudie wurden die benötigten entfernten Testkonten vorab über das Supabase-Dashboard angelegt.
Ihre E-Mail-Adressen und Passwörter mussten somit bereits vorliegen.
Die Desktop-Anwendung enthält eine Anmeldung für diese Konten: Im Main-Prozess ruft der Connector `signInWithPassword` mit den eingegebenen Zugangsdaten auf @StudyPlanSyncArchitecture2026.
Die Methode authentifiziert bestehende Konten und übernimmt keine Registrierung @SupabasePasswordSignIn2026.
Die lokale Kontoverwaltung aus Phase 1 bleibt davon getrennt.

Eine Registrierung für das entfernte Backend, E-Mail-Bestätigung und Passwortzurücksetzung wurden in der Anwendungsoberfläche nicht implementiert.
Der Untersuchungsaufbau setzt eingerichtete Konten voraus, um authentifizierte Gruppenzugriffe und die Synchronisierung gemeinsamer Aufgaben zu demonstrieren.
Die Ausarbeitung eines vollständigen Kontolebenszyklus würde zusätzliche Produktfunktionen und Anforderungen einführen.
Für diesen begrenzten Nachweis wurden sie daher nicht entwickelt; bei einer produktiven Anwendung wären sie anhand des vorgesehenen Benutzerzugangs gesondert festzulegen.
Die Fallstudie bewertet damit die Migration unter dieser Voraussetzung und weist keine vollständige entfernte Benutzerverwaltung nach.

=== Schrittweise Überführung weiterer Funktionen

Die parallele Datenhaltung ermöglicht eine Migration nach Funktionsbereichen: Ein vorhandener Bereich bleibt zunächst bestehen, während ein ausgewählter Bereich mit dem neuen Datenzugriff umgesetzt wird.
Dieses Vorgehen folgt dem Grundgedanken des Strangler-Fig-Patterns, bestehende Funktionen schrittweise durch neue Implementierungen abzulösen @FowlerStranglerFig2024.
Im Demonstrator bleibt das in Phase 1 lokal übernommene Feature Studiengruppen unter `/gruppen` bestehen.
Der in Phase 2 ergänzte Bereich unter `/gruppen-sync` verwendet die neue Kollaborationsdatenbank.
Die Oberfläche unterscheidet beide als „Gruppen“ und „Gruppen (Sync)“.
Die Koexistenz ist ein Übergangsstand der Umsetzung; bestehende lokale Gruppendaten werden nicht automatisch in den synchronisierten Bereich übertragen @StudyPlanGroupTransition2026.

Das Terminbeispiel aus der Vorprüfung konkretisiert die erforderlichen Anpassungen.
Die ursprüngliche `events`-Tabelle besitzt numerische, automatisch erzeugte Kennungen und lokale Benutzerkennungen.
Für die separate Prototyptabelle `spike_events` wurden clientseitige UUIDs, eine Supabase-Benutzerzuordnung und geeignete Datentypabbildungen verwendet.
Geprüft wurden typisierte CRUD-Zugriffe, Persistenz ausstehender Änderungen und der Abgleich zwischen Replikaten.
Damit liegt ein Beispiel für die technische Überführung eines weiteren Datenbereichs vor; die Übernahme vorhandener Termine einschließlich ihrer Referenzen wurde damit noch nicht durchgeführt @StudyPlanSyncSpikes2026.
Weitere Bereiche würden dieselben Grundschritte durchlaufen: Schema und Identitäten anpassen, Daten und Referenzen zuordnen, Repositories anbinden und das Verhalten prüfen.
Die Umsetzung jedes weiteren CRUD-Pfads würde das bereits gezeigte Muster wiederholen und wird daher nicht vollständig ausgearbeitet.

@lst:events-local-sqlite und @lst:events-powersync zeigen ausgewählte Felder vor und nach dieser Anpassung.
Der Vergleich beginnt beim bereits auf SQLite übertragenen Schema aus Phase 1.
Im Prototyp ersetzt eine Textkennung den automatisch erzeugten Integer; `ownerId` verweist auf die entfernte Supabase-Identität.
Datumswerte werden als Text gespeichert: Das Repository erzeugt beim Schreiben ISO-Strings und wandelt sie beim Lesen wieder in `Date`-Werte um.
Aus den Drizzle-Tabellen wird zusätzlich das Schema für PowerSync abgeleitet.
Die Ausschnitte zeigen somit eine Schema- und Repository-Anpassung, keine Migration vorhandener Benutzerdaten @StudyPlanSchemaReview2026.

#figure(
  block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
    set text(size: 8.5pt)
    raw(read("../code/events-local-sqlite.ts"), lang: "typescript", block: true)
  }),
  kind: raw,
  supplement: [Quellcode],
  caption: [Ausgewählte Felder des lokalen Terminschemas aus Phase 1; weitere Felder weggelassen.],
) <lst:events-local-sqlite>

#figure(
  block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
    set text(size: 8.5pt)
    raw(read("../code/events-powersync.ts"), lang: "typescript", block: true)
  }),
  kind: raw,
  supplement: [Quellcode],
  caption: [Entsprechende Felder der separaten PowerSync-Prototyptabelle und Schemaableitung; weitere Felder und Indizes weggelassen.],
) <lst:events-powersync>

Eine spätere Zusammenführung in einer PowerSync-verwalteten lokalen Datenbank wäre grundsätzlich möglich, ohne sämtliche Inhalte zu teilen.
Persönliche Tabellen müssten dafür ausdrücklich als lokale Tabellen konfiguriert werden, etwa mit `localOnly: true`; ihre Änderungen gelangen dann nicht in die Upload-Warteschlange @PowerSyncLocalOnly2026 @PowerSyncDrizzleDriver2026.
Das bloße Weglassen eines Sync Streams reicht hierfür nicht aus, da Streams den Download steuern.
Benutzerzuordnung und Zugriff ohne entfernte Anmeldung wären bei einer solchen Zusammenführung weiterhin zu erhalten.
Erst nach Ablösung aller bisherigen libSQL-Zugriffe könnte `@libsql/client` entfallen.
Dazu wären die betroffenen Repositories, Datenbankinitialisierung und Schemaverwaltung zu überführen.
Im gewählten Entwurf bliebe `better-sqlite3` als lokaler Treiber erhalten.
Eine solche vollständige Ablösung wurde nicht geprüft; sie beschreibt eine mögliche Weiterentwicklung, nicht den erreichten Projektstand.

=== Grenzen der untersuchten Synchronisierung

Die Untersuchung umfasst die lokale Verarbeitung gemeinsamer Aufgaben und deren späteren Abgleich.
Eine vollständige Übernahme persönlicher Kontodaten auf andere Geräte oder gemeinsame Echtzeitbearbeitung von Dokumenten gehört gemäß Kapitel 4 nicht dazu.
Der Replikatabgleich der Vorprüfung prüft die technische Datenübertragung, ersetzt jedoch keine vollständige Kontomigration @StudyPlanSyncSpikes2026.

Der Web-Prototyp verarbeitete Änderungen unmittelbar über sein autoritatives Backend.
Eine fachliche Zusammenführung konkurrierender Offline-Änderungen war dort nicht implementiert @StudienplanerSource2026.
Local-First ergänzt diese Entwurfsfrage: Regeln für konkurrierende Bearbeitungen, Löschkonflikte oder manuelle Konfliktentscheidungen müssen aus den Anforderungen der jeweiligen Anwendung abgeleitet werden.
Ihre umfassende Entwicklung würde neue Fachfunktionalität schaffen und geht über die hier demonstrierte Migration hinaus.

Auch der Demonstrator besitzt deshalb keine eigens entwickelte Konfliktzusammenführung.
Der Connector des ursprünglichen Integrationsstands übermittelte Aufgabenänderungen mit `upsert`, `update` und `delete` an Supabase, ohne eine eigene Versionsprüfung @StudyPlanSyncArchitecture2026.
Die spätere Upload-Nachbesserung ergänzt eine Backend-Operation mit Wiederholungsschutz und ein lokales Ablehnungsjournal; ihre Ergebnisse werden in @sec:collaboration-evaluation bewertet @StudyPlanUploadChecks2026.
Eine als Last Write Wins bezeichnete Regel müsste ausdrücklich festlegen, welche Reihenfolge maßgeblich ist; ihre fachliche Eignung ist hier nicht evaluiert.
Die Begrenzung betrifft erweiterte Konfliktstrategien.
Warteschlange, Wiederholungen und der Umgang mit abgelehnten Änderungen bleiben für die Migration relevant.
PowerSync verwendet ein serverautoritatives Modell; aus einem lokalen Schreibabschluss folgt noch keine Bestätigung durch das Backend @PowerSyncWritingChanges2026.

=== Online-Datenabruf im Feature Studiengänge <sec:study-catalog-download>

Das Feature Studiengänge ergänzt die Synchronisierung um einen einfacheren Netzwerkablauf: Fachliche Referenzdaten werden online bereitgestellt, in die lokale Datenbank übernommen und anschließend offline gelesen.
Damit können Kataloginhalte unabhängig von einer neuen Anwendungsversion aktualisiert werden.
Der Demonstrator ergänzt hierzu den in Phase 1 ausgelieferten Seed-Bestand um online abrufbare Beispieldaten; der vorhandene Grundbestand bleibt erhalten @StudyPlanCatalog2026.

Im Commit `9320911` wurde dafür eine Supabase Edge Function ergänzt, die Studiengänge und zugehörige Lehrveranstaltungen aus einer JSON-Datei über einen öffentlichen HTTP-Endpunkt bereitstellt.
Dieser Endpunkt benötigt weder ein Benutzerkonto noch einen Zugriff auf die entfernte Datenbank.
Änderungen am angebotenen Katalog erfordern eine erneute Bereitstellung dieser Datei mit der Funktion, jedoch keine neue Version der Desktop-Anwendung.
Der bestehende OpenAPI-Vertrag wurde um `refreshStudyCatalog` und dessen Ergebnis mit den Anzahlen übernommener Studiengänge und Lehrveranstaltungen erweitert.
Daraus wurden die IPC-Vertragsbestandteile und der React-Query-Hook erneut generiert @StudyPlanCatalog2026.

Beim Öffnen des Features Studiengänge liest die Oberfläche zunächst den lokalen Bestand und löst zusätzlich die Aktualisierung aus.
Der Main-Prozess lädt die JSON-Daten, validiert sie anhand der vorhandenen Feldschemata und übernimmt beide Datenbereiche gemeinsam in einer Transaktion.
Anhand stabiler Kennungen werden neue Einträge eingefügt und vorhandene aktualisiert, sodass wiederholte Abrufe keine Duplikate erzeugen.
In der Antwort fehlende Einträge werden nicht gelöscht.
Nach erfolgreicher Übernahme werden die betroffenen Abfragen der Oberfläche erneut ausgeführt @StudyPlanCatalog2026.

Scheitern Abruf, Validierung oder Datenbankübernahme, bleibt der bisherige lokale Bestand nutzbar.
Die Oberfläche zeigt den Fehler an und bietet einen erneuten Versuch an.
Bereits übernommene Katalogdaten bleiben auch nach einem Neustart lokal verfügbar.
Der untersuchte Stand ruft den Katalog bei jedem Seitenaufruf erneut ab; eine Versionsprüfung zur Erkennung neuer Katalogstände wurde nicht implementiert.
Er zeigt damit das Muster eines Downloads mit dauerhafter lokaler Datenhaltung.
Die Desktop-Anwendung lädt dabei keine Katalogänderungen zum entfernten Dienst hoch @StudyPlanCatalog2026.

Der Kontrollpunkt dieser Phase betrifft insbesondere A6 und A8.
Für Aufgaben sind der lokale Abschluss einer Änderung und ihre spätere Übernahme im Kollaborationsablauf getrennt zu beobachten.
Bei unmittelbar netzwerkabhängigen Operationen sind Fehlermeldung und Verhalten ohne Verbindung auszuweisen.
Bereits lokal verfügbare Funktionen dürfen durch den Ausfall einer zusätzlichen Online-Anbindung nicht unnötig blockiert werden.

== Phase 3: Prüfung und Härtung der vervollständigten Anwendung <sec:app-hardening>

=== Prüfrahmen und Sicherheitsmatrix

Nach der funktionalen Umsetzung werden die Sicherheitsgrenzen der entstandenen Anwendung zusammenhängend geprüft.
*Prüfung* bezeichnet hier den Abgleich einer Anforderung mit der tatsächlichen Implementierung und den verfügbaren Belegen.
*Härtung* bezeichnet die daraus abgeleiteten Änderungen, mit denen unnötige Befugnisse eingeschränkt oder festgestellte Abweichungen behoben werden.
Die bereits in den ersten beiden Phasen eingerichtete Prozess- und Schichtentrennung bleibt dabei die Grundlage; Sicherheitsmaßnahmen entstehen somit auch während der Migration und werden in dieser Phase konsolidiert.

Den Bezugsrahmen bildet A7: Sämtliche Empfehlungen der Electron-Sicherheitscheckliste sind auf Anwendbarkeit, Umsetzung und Nachweistiefe zu prüfen @ElectronSecurity2026.
Hinzu kommen die in @sec:requirements und der Abgrenzung festgelegte Eingabevalidierung, anwendungsinterne Zugriffskontrolle und Verarbeitung externer Daten.
A2 und A4 bestimmen die Verantwortlichkeiten entlang des Aufrufwegs; A5, A6 und A8 legen die betrachteten lokalen Funktionen, Kollaborationsabläufe und Interaktionsformen fest.
Diese Anforderungen bestimmen die Prüforte, ohne selbst bereits einen Sicherheitsnachweis zu liefern.

Für den Abgleich wurden ein Prüfplan, eine Ergebnismatrix sowie Protokolle der gezielten Prüfungen erstellt.
Jede Empfehlung erhält eine begründete Anwendbarkeitsentscheidung, einen Verweis auf die betroffenen Dateien, eine Bewertung und die verwendete Nachweisebene.
*Nicht anwendbar* ist ein Punkt nur, wenn der betreffende Mechanismus im Demonstrator fehlt.
Eine fehlende Prüfung oder eine noch ausstehende Umsetzung wird gesondert ausgewiesen.
Die konsolidierte Matrix verbindet die Einzelbewertungen mit den Quellcode-, Test-, Paket- und Laufzeitbelegen @StudyPlanSecurityChecks2026 @StudyPlanSecurity2026.

=== Zuordnung der Anforderungen zu den Prüforten

Die Prüfung folgt den Grenzen, an denen Daten oder Befugnisse übergeben werden: vom Renderer an den Preload und Main-Prozess, von ausgewählten Dateien an die Parser sowie von entfernten Diensten an die lokale Anwendung.
Hinzu kommen Fenster- und Sessionkonfiguration sowie Einstellungen, die erst beim Paketieren wirksam werden.
@tab:hardening-checkpoints ordnet diesen Stellen die konkrete Umsetzung und das jeweilige Prüfverfahren zu.
Die Nummern beziehen sich auf alle 20 Electron-Empfehlungen; verwandte Punkte sind für die Darstellung zusammengefasst.
A7 gilt für den gesamten Richtlinienabgleich.
Die Einzelbewertungen verbleiben in der Projektmatrix @StudyPlanSecurity2026.

#pagebreak(weak: true)

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (0.8fr, 2.4fr, 2.5fr),
        inset: 5pt,
        align: left,
        table.header([*Bezug*],
        [*Prüfstelle und Umsetzung*],
        [*Prüfverfahren und Nachweisgrenze*]),
        [Nr. 1; A6, A8],
        [*Netzwerkanbindung im Main:* HTTPS-Adressen ohne eingebettete Zugangsdaten für das Feature Studiengänge, Supabase und PowerSync prüfen.
          Abrufe im Feature Studiengänge und Supabase-Abrufe lehnen Weiterleitungen ab.],
        [Code- und Konfigurationstests; Redirectversuch mit tatsächlichem Node-Fetch.
          Die SDK-interne PowerSync-Redirectbehandlung ist nicht praktisch nachgewiesen.],
        [Nr. 2–4],
        [*Fenster und Preload:* `nodeIntegration: false`, `contextIsolation: true`, `sandbox: true`; privilegierte Zugriffe bleiben im Main.],
        [Codeinspektion von Fensterkonfiguration und Startpfaden.
          Keine zusätzliche Laufzeitabfrage der Einstellungen oder eigenständige Betriebssystem-Sandbox-Analyse.],
        [Nr. 5],
        [*Session-Berechtigungen:* Check- und Request-Handler erlauben ausschließlich `clipboard-sanitized-write` für das zugelassene Fenster und Dokument.],
        [Codeinspektion der gemeinsamen Fenster- und Dokumentprüfung; keine gesonderte Berechtigungsdialog-Testreihe.],
        [Nr. 6, 8–10],
        [*Fenster- und Startoptionen:* Web-Sicherheit bleibt aktiv; unsichere Inhalte, experimentelle Funktionen und zusätzliche Blink-Funktionen werden nicht freigegeben.],
        [Code- und Startpfadprüfung mit den Standardwerten der dokumentierten Electron-Version.
          Die Abwesenheit eines Overrides wird von einer expliziten Einstellung unterschieden.],
        [Nr. 7],
        [*Renderer-HTML:* CSP mit `default-src 'none'`, `script-src 'self'`, gesperrten Objekten und Frames.],
        [Codeabgleich und P3: beobachtete Blockierung einer fremden Skriptquelle.
          Inline-Styles bleiben erlaubt; der Einzelversuch belegt keine allgemeine XSS-Freiheit.],
        [Nr. 11–12],
        [*Webviews:* Keine Nutzung und keine Aktivierung von `webviewTag`.],
        [Quellcodesuche und versionsbezogener Standardwert.
          Beide Empfehlungen sind wegen des fehlenden Mechanismus begründet nicht anwendbar.],
        [Nr. 13–15],
        [*Navigation, Fenster und Shell:* Dokumentpolicy begrenzt Navigation; neue Fenster werden abgelehnt; `shell.openExternal` wurde entfernt.],
        [Codeinspektion, Policy-Tests und ausgewählte Paketversuche: fremde Navigation und `window.open`.
          Die Beobachtung gilt für diese Versuche.],
        [Nr. 17, 20; A2, A4],
        [*Beide IPC-Eingänge:* Feste Preload-Kanäle ohne Electron-Rohobjekte.
          Gemeinsame Policy prüft registriertes Fenster, Hauptframe und Dokumentadresse; Operationskennung und Eingabe werden im Main validiert.],
        [Codeabgleich, sechs Sender-Unit-Tests und P1 an beiden realen Bridges.
          Kein zusätzlicher Fenster-/Frame-Harness; ein kompromittierter erlaubter Hauptframe bleibt erlaubter Sender.],
        [Nr. 18],
        [*Lokale Ressourcen:* `app://bundle/index.html` mit fester Rendererwurzel, GET/HEAD, Pfad- und Realpathprüfung sowie passenden Inhaltstypen; keine CSP-Umgehung.],
        [Resolver- und Handler-Tests einschließlich eines Junction-Ausbruchs; Assets und betrachtete Abläufe im gebauten Paket.
          Kein allgemeiner Dateisystemaudit.],
        [Nr. 16; A1],
        [*Laufzeitversion:* Electron 44.5.1 exakt in Paketdefinition und Lockfile festgelegt.
          Native Datenbankmodule müssen weiterhin funktionieren.],
        [Buildprotokoll, nativer Datenbankcheck und Paket-User-Agent.
          Versionsaktualität ist eine zeitpunktbezogene Aussage des dokumentierten Prüfstands.],
        [Nr. 19; A1],
        [*Paketkonfiguration:* Vier unbenötigte Fuse-Optionen deaktiviert; Laden aus ASAR und eingebettete ASAR-Integritätsprüfung aktiviert.],
        [Fuse-Werte aus der tatsächlichen EXE lesen, eingebetteten mit tatsächlichem ASAR-Headerhash vergleichen; Paket-, Datenbank- und Workerfunktion prüfen.
          Keine Signierungs- oder Distributionsbewertung.],
        [Ergänzend; A5, A8],
        [*Datei- und Datenübernahme:* CSV-/ICS-Auswahl im Main; Dateityp und Größe begrenzen.
          Eingaben und externe Katalogdaten vor fachlicher Übernahme validieren; fremde Textinhalte als Text darstellen.],
        [Codeabgleich der Importpfade aus Phase 1, vorhandene Validierungs- und Katalogtests sowie P2 am Aufgabentitel.
          Keine zusätzliche umfassende Parser- oder XSS-Testfamilie.],
      )
    },
    caption: [Prüforte, Härtungsmaßnahmen und Nachweise im Demonstrator; Zuordnung nach @StudyPlanSecurity2026 und @StudyPlanSecurityRemediation2026, ergänzt um die lokalen Importpfade nach @StudyPlanHardeningImplementation2026.],
  ) <tab:hardening-checkpoints>
]

Senderprüfung, Eingabevalidierung und fachliche Berechtigung bilden unterschiedliche Kontrollen.
Die Senderpolicy begrenzt, welches Fenster und welcher Frame die Schnittstelle verwenden dürfen.
Die Schemaprüfung begrenzt die zulässige Form der Anfrage.
Ob die betreffende Person auf die angeforderten Daten zugreifen darf, muss weiterhin durch die Sitzungs- und fachliche Zugriffslogik entschieden werden.
Auch ein formal gültiger Aufruf eines erlaubten Renderers benötigt diese Kontrolle.
Die Schichtentrennung macht die Verantwortlichkeiten und ihre Prüfung nachvollziehbar @StudyPlanHardeningImplementation2026.

=== Umgesetzte Nachbesserungen

Der erste dokumentierte Richtlinienabgleich vom 3. Oktober 2026 identifizierte neben bereits vorhandenen Schutzmaßnahmen konkrete Abweichungen.
Die Anwendung verwendete noch das `file://`-Protokoll und Electron 39.8.10.
Das externe Öffnen war lediglich auf HTTPS begrenzt, und mehrere unbenötigte Fuse-Optionen waren in der untersuchten Binary aktiviert.
Diese Befunde wurden in einen Nachbesserungsplan überführt und am 4. Oktober durch Änderungen sowie eine gezielte Nachprüfung bearbeitet.
Die Matrix vom 6. Oktober konsolidiert diesen Verlauf @StudyPlanSecurityChecks2026 @StudyPlanSecurityRemediation2026 @StudyPlanSecurity2026.

Für lokale Ressourcen wurde das Protokoll `app:` eingerichtet.
Sein Handler liefert ausschließlich Dateien innerhalb der gebauten Rendererwurzel aus.
Neben der syntaktischen Pfadprüfung wird der tatsächlich aufgelöste Dateipfad geprüft, damit auch Verknüpfungen keinen Zugriff außerhalb dieser Wurzel eröffnen.
Die Dokumentpolicy erlaubt im Paket ausschließlich das vorgesehene Dokument unter `app://bundle/index.html`; dessen Hash-Routen bleiben nutzbar.
Navigation, Berechtigungsprüfung und IPC-Senderprüfung beziehen sich auf diese Dokumentpolicy.
Assetadressen erhalten dadurch keine Freigabe als IPC-Dokument.
Die bisherige Möglichkeit zum externen Öffnen wurde entfernt @StudyPlanHardeningImplementation2026.

Beide IPC-Eingänge behielten ihre gemeinsame Senderprüfung.
Diese wurde in `sender-policy.ts` ausgelagert und um die ausdrückliche Ablehnung eines fehlenden `senderFrame` ergänzt.
Dadurch lässt sich die tatsächlich verwendete Policy unabhängig vom Dispatcher prüfen.
Die Preload-Bridges exponieren weiterhin lediglich die beiden festen Invoke-Kanäle.
Im Main werden bekannte Operationen und ihre Zod-Eingabeschemata vor der fachlichen Verarbeitung geprüft @StudyPlanSecurityRemediation2026 @StudyPlanHardeningImplementation2026.

Für externe Anbindungen wurde ein gemeinsamer HTTPS-Prüfer eingeführt.
Er weist ungeeignete Protokolle und eingebettete Zugangsdaten zurück, ohne den Konfigurationswert in Fehlermeldungen auszugeben.
Der Datenabruf im Feature Studiengänge und die Supabase-Anbindung verwenden zusätzlich `redirect: 'error'`.
Der Prüfer erhält die Schreibweise einer gültigen Adresse: Eine zwischenzeitliche Normalisierung ergänzte am PowerSync-Endpunkt einen Slash und verhinderte die Verbindung.
Die Korrektur und ein Regressionstest sichern dieses Detail ab.
PowerSync verwendet weiterhin seinen eigenen Transport; dessen interne Weiterleitungen sind von dieser Absicherung nicht vollständig erfasst @StudyPlanSecurityRemediation2026.

Electron wurde auf 44.5.1 aktualisiert.
Damit mussten auch die nativen Datenbankabhängigkeiten und ihr Paketbetrieb geprüft werden; die erforderlichen Anpassungen betrafen `better-sqlite3`, das PowerSync-Node-SDK und den nativen Prüfschritt.
Die Paketauswahl wurde auf gebaute Anwendungsteile und Produktionsabhängigkeiten begrenzt, während Drizzle-Migrationen weiterhin über `extraResources` ausgeliefert werden.
Prüfdokumente und Umgebungsdateien gehören nicht zum Anwendungspaket @StudyPlanSecurityRemediation2026.

Die Fuse-Konfiguration deaktiviert `RunAsNode`, die Auswertung von `NODE_OPTIONS`, Node-Inspektionsargumente und zusätzliche Dateiprotokollprivilegien.
Aktiviert wurden `OnlyLoadAppFromAsar` und `EnableEmbeddedAsarIntegrityValidation`; Cookie- und Snapshot-Fuses blieben nach Bedarfsprüfung unverändert.
Da diese Einstellungen die ausgelieferte Binary betreffen, genügt der Eintrag in `electron-builder.yml` nicht als Beleg.
Die Werte wurden deshalb am gebauten Windows-Paket ausgelesen und die eingebetteten Integritätsmetadaten mit dem tatsächlichen ASAR-Header verglichen @StudyPlanSecurityRemediation2026.

=== Nachweisverfahren und dokumentierte Grenzen

Die Nachweise wurden auf vier Ebenen erhoben.
*Codeinspektion* ordnet Einstellungen und Kontrollen den tatsächlichen Einstiegspunkten zu.
*Automatisierte Tests* prüfen ausgewählte Entscheidungen und Fehlerpfade; hierfür wurden vorhandene Dispatcher-, Service-, Upload- und Katalogtests sowie eine kleine Security-Suite verwendet.
*Paketprüfungen* kontrollieren Buildabhängigkeiten, Fuses und Integritätsmetadaten an der erzeugten Anwendung.
*Laufzeitbeobachtungen* zeigen die Wirkung ausgewählter Maßnahmen im gestarteten Paket.
Diese Ebenen ergänzen sich, ersetzen einander jedoch nicht @StudyPlanSecurityRemediation2026.

Die Security-Suite prüft unter anderem sechs Senderfälle: einen erlaubten Hauptframe, ein fremdes Fenster, einen Unterframe, einen fehlenden Frame, eine falsche Dokumentadresse und ein zerstörtes Fenster.
Hinzu kommen Pfad- und Handlerfälle sowie negative HTTPS-Konfigurationen.
Ein Redirecttest verwendet das tatsächliche Node-Fetch-Verhalten; der dafür injizierte lokale HTTP-Transport ist ausschließlich Testaufbau und begründet keine HTTP-Ausnahme im Anwendungsbetrieb.
Die Tests der Senderpolicy verwenden nachgebildete Electron-Objekte und belegen die Policy-Entscheidungen, nicht einen Angriff aus einem zusätzlich gestarteten Fenster @StudyPlanSecurityRemediation2026 @StudyPlanHardeningImplementation2026.

Die drei praktischen Fälle P1–P3 wurden am korrigierten Windows-Paket über dessen bestehenden Renderer ausgeführt.
*P1* übergibt je eine ungültige Eingabe an die API- und Kollaborationsbridge und prüft die Fehlerantworten `VALIDATION_ERROR` beziehungsweise `INVALID`.
Die Reihenfolge der Schemaprüfung vor der fachlichen Verarbeitung wird ergänzend im Code nachvollzogen.
Dieser Fall prüft die beiden ausgewählten Eingaben; er ist keine vollständige Operations- oder Berechtigungsmatrix @StudyPlanSecurityChecks2026 @StudyPlanSecurityRemediation2026.

*P2* speichert über die reguläre Aufgabenoberfläche einen synthetischen HTML-artigen Titel mit einem SVG-Element und einem harmlosen Ausführungsmarker.
Die Darstellung wird unmittelbar und nach erneutem Öffnen der Aufgabenansicht untersucht.
Erwartet werden ausschließlich Textknoten, kein aus dem Titel erzeugtes SVG-Element und kein gesetzter Marker.
Das Protokoll ergänzt die DOM-Beobachtung um das Lesen der gespeicherten Aufgabe und den zu diesem Zeitpunkt verbundenen Sync-Zustand ohne ausstehende Uploads.
Dieser Ablauf belegt weder Mehrgeräte-Synchronisierung noch allgemeine XSS-Freiheit oder einen dauerhaft störungsfreien Onlinebetrieb @StudyPlanSecurityRemediation2026.

*P3* versucht, eine von der CSP nicht zugelassene fremde Skriptquelle zu laden.
Bewertet wird das konkrete `securitypolicyviolation`-Ereignis einschließlich der verletzten Skriptrichtlinie; ein DNS-Fehler allein wäre kein ausreichender Nachweis.
Ergänzend wurden fremde Navigation und das Öffnen eines zusätzlichen Fensters versucht.
Die Ausführung von Prüfcode in den DevTools ist dabei keine nachgewiesene Schwachstelle: Sie dient zur gezielten Auslösung und Beobachtung der vorhandenen Kontrolle @StudyPlanSecurityChecks2026 @StudyPlanSecurityRemediation2026.

Dateihashes binden die finalen Paket- und Laufzeitprotokolle an dieselbe EXE und dasselbe ASAR-Archiv.
Frühere, während der Nachbesserung fehlgeschlagene Builds oder Prüfungen werden dadurch nicht nachträglich als erfolgreiche Nachweise des korrigierten Pakets ausgegeben.
Die technischen Paket- und Laufzeitbelege stammen vom 4. Oktober 2026; der für diese Darstellung eingesehene HEAD `17434b2` enthält den zugehörigen Sicherheitscode unverändert.
Die spätere Konsolidierung der Dokumentation ist kein neuer Testdurchlauf @StudyPlanSecurityRemediation2026 @StudyPlanSecurity2026.

Die wesentliche verbleibende Transportgrenze betrifft die SDK-interne Redirectbehandlung von PowerSync.
Dort wurde die HTTPS-Startkonfiguration geprüft, aber kein praktischer Redirect- oder Downgradeversuch am Sync-Stream durchgeführt.
Aus der begrenzten Bewertung der Matrix folgt daher kein umfassender Transportnachweis.
Ebenso verbleiben die in Kapitel 4 ausgeschlossene Härtung entfernter Dienste und der Schutz der lokalen Datenbank gegenüber anderen Betriebssystemprozessen außerhalb der Untersuchung.
Die Bewertungen und ihre Bedeutung für A7 werden in @ch:experiments ausgewiesen; dieses Kapitel dokumentiert die Maßnahmen und den Weg zu den Belegen @StudyPlanSecurity2026.

== Handlungsempfehlungen des Migrationsleitfadens <sec:migration-recommendations>

Aus dem dokumentierten Prozess werden acht Handlungsempfehlungen M1–M8 abgeleitet.
Sie beschreiben die erforderlichen Veränderungen zwischen Ausgangsartefakt und Zielarchitektur sowie Kontrollpunkte für deren Umsetzung.
Die Reihenfolge folgt den technischen Abhängigkeiten: Lokale Datenhaltung und begrenzte Schnittstellen bilden die Grundlage vollständiger Offline-Abläufe; darauf bauen externe Datenübernahme und Synchronisierung auf.
Die Sicherheitsanforderungen begleiten alle Schritte und werden am Ende zusammenhängend geprüft.

Die Empfehlungen beziehen sich auf Verantwortlichkeiten und Interaktionsformen.
React, Vite, Drizzle, PowerSync und Supabase sind die konkreten Ausprägungen der Fallstudie.
Ihre Auswahl ist bei einer anderen Anwendung anhand der vorhandenen Komponenten zu prüfen.
Framework-agnostisch bedeutet hier, dass die Transformation über fachliche Operationen, Datenhaltung und Vertrauensgrenzen beschrieben wird und kein bestimmtes Web-Framework voraussetzt.
Die beschriebenen Prozessgrenzen und Härtungsmaßnahmen beziehen sich auf die gewählte Electron-Zielumgebung.

=== Voraussetzungen und Herstellung der lokalen Datenhaltung

*M1: Ausgangsartefakt und Zielumgebung abgleichen.*
Vor der Übernahme sind Oberfläche, Schnittstellen, Fachlogik, Datenhaltung und externe Abhängigkeiten zu erfassen.
Für jede Kernfunktion ist festzulegen, ob sie vollständig lokal ausgeführt werden kann, externe Daten herunterlädt oder gemeinsame Änderungen synchronisiert.
Vorhandener Code dokumentiert dabei zunächst eine Implementierung; seine tatsächliche Nutzbarkeit muss anhand eines vollständigen Ablaufs geprüft werden.
Der Untersuchungsumfang sollte mindestens je ein Beispiel der benötigten Interaktionsformen enthalten.
So entsteht eine begründete Auswahl, ohne jede CRUD-Variante separat migrieren zu müssen.

Auf dieser Grundlage ist eine kompatible Desktop-Laufzeit einzurichten.
Vorhandene Sprachen, Bibliotheken und Buildverfahren sollen weiterverwendet werden, soweit sie mit der Zielarchitektur vereinbar sind.
Die Wahl von Electron und electron-vite in @sec:offline-core-migration veranschaulicht dieses Vorgehen, belegt jedoch keinen allgemein geringsten Aufwand.
Ein kleiner lauffähiger Paketstand sollte früh prüfen, ob die vorgesehenen Datenbanktreiber und nativen Abhängigkeiten auch außerhalb des Entwicklungsmodus funktionieren.
Die Verantwortung für Dateisystem, Datenbank und Dienstzugriffe ist dem Main-Prozess zuzuordnen; der Renderer erhält dafür begrenzte fachliche Schnittstellen.

*M2: Lokale Datenhaltung und Identitätszuordnung herstellen.*
Ein entferntes Datenbankschema ist anhand seiner Bedeutung zu überführen.
Datentypen, Schlüssel, Beziehungen, Standardwerte und Prüfbedingungen müssen einzeln abgeglichen werden.
Die SQLite-Übertragung in Phase 1 zeigt, dass eine erhaltene TypeScript-Typisierung keine entfallene Datenbankprüfung ersetzt.
Erforderliche Regeln sind deshalb im Zielsystem ausdrücklich abzubilden und an den Eingangsstellen zu validieren @StudyPlanDatabase2026.

Programmdateien und veränderliche Benutzerdaten sind getrennt zu verwalten.
Die Anwendung soll ihre Datenbank an einem geeigneten Benutzerdatenpfad öffnen und das Schema vor der Nutzung vorbereiten.
Schemaänderungen sind versioniert auszuliefern, soweit die Anwendung das Schema selbst verwaltet.
Erforderliche Referenzdaten müssen auch beim ersten Offline-Start verfügbar sein.
Die lokale Identität ist gesondert festzulegen: Anmeldung, Sitzungsdauer und Zuordnung persönlicher Datensätze müssen zusammenpassen.
Eine frühere HTTP-Sitzung lässt sich nicht unverändert als lokale Sitzung behandeln.
Im Demonstrator übernehmen hierfür die Datenbankinitialisierung und die getrennte lokale Sitzungsverwaltung die Verantwortung @StudyPlanDatabase2026 @StudyPlanLocalAuth2026.

=== Schnittstellen und Offline-Kernfunktionen überführen

*M3: Fachlichen Vertrag und Transport trennen.*
Ausgangspunkt sollen die benötigten Operationen mit Eingaben, Ergebnissen und Fehlerfällen sein.
Ein vorhandener API-Vertrag kann hierfür weiterverwendet werden, sofern seine Bedeutungen erhalten bleiben.
HTTP-Pfade und Serverobjekte sind dagegen durch einen begrenzten lokalen Transport zu ersetzen.
Der Renderer soll fachliche Operationen aufrufen und keine frei wählbaren IPC-Kanäle oder privilegierten Rohschnittstellen erhalten.

Die Vertragsdefinitionen sollen gemeinsam gepflegt werden.
Wo bereits generierte Clients und Laufzeitschemata vorliegen, ist ihre Ableitung an den neuen Transport anzupassen.
@sec:api-generator-concept zeigt hierfür den projektspezifischen OpenAPI-IPC-Generator.
Änderungen am Vertrag müssen in den erzeugten Modulen nachvollziehbar ankommen; Darstellung und Fachlogik sind nur bei tatsächlich veränderter Semantik anzupassen.
Statische Typen und Laufzeitvalidierung bleiben unterschiedliche Aufgaben.
Bei mehreren Modulverträgen gelten dieselben Regeln für jeden Eingang; die Zahl der Datenbanken bestimmt nicht die Zahl der IPC-Schnittstellen @StudyPlanApiMigration2026 @StudyPlanSyncIntegration2026.

*M4: Einen vollständigen Kernablauf herstellen und dessen Muster fortführen.*
Nach der Einrichtung von Datenhaltung und Transport ist zunächst ein zusammenhängender Verarbeitungspfad zu integrieren.
Dabei sind Oberflächenkomponenten und ihre Abhängigkeiten mit den Build-, Import- und Routingbedingungen der Desktop-Umgebung abzugleichen.
Der erfolgreiche Build allein zeigt noch nicht, dass eine Seite ihre fachlichen Operationen ausführen kann.
Im Demonstrator erschließt die lokale Authentifizierung den ersten vollständigen Ablauf; die Notenverwaltung konkretisiert anschließend das CRUD-Muster aus @sec:crud-migration @StudyPlanFrontendMigration2026 @StudyPlanLocalAuth2026.

Gemischte Webrouten sind nach Verantwortlichkeiten aufzuteilen: Handler übernehmen Operationszuordnung und Fehlerübersetzung, Services die fachlichen Regeln und Repositories den Datenzugriff.
Der Dispatcher prüft Absender und Eingaben vor dem Handler.
Persönliche Datenzuordnung und Berechtigungen bleiben Teil des Ablaufs und dürfen beim Entfernen des HTTP-Transports nicht entfallen.
Für weitere Funktionen ist dieses Muster mit den jeweils passenden Vertragsdefinitionen und fachlichen Regeln fortzuführen.
Datenzugriffe und externe Dienste sollen in Servicetests durch Testimplementierungen ersetzbar sein.
Lokaler Schreibabschluss, erneutes Lesen und Fehlerbehandlung bilden den Kontrollpunkt eines übernommenen Kernablaufs @StudyPlanGradesMigration2026.

*M5: Dateiimporte als begrenzte native Operationen gestalten.*
Ein Webupload ist in Dateiauswahl, Lesen, Parsen, Validieren und Übernehmen aufzuteilen.
Die Oberfläche soll den Import auslösen; der Main-Prozess übernimmt die native Auswahl und den Zugriff auf die ausgewählte Datei.
Eine frei verwendbare Schnittstelle zum Lesen beliebiger Renderer-Pfade ist dafür nicht erforderlich.
Dateityp und Größe sind zu begrenzen, der Abbruch ist als eigener Zustand zu behandeln und Parserergebnisse sind vor der fachlichen Speicherung zu prüfen.

Das Ergebnis muss angeben, welche Daten übernommen, übersprungen oder abgewiesen wurden.
Die Oberfläche aktualisiert danach die betroffenen Abfragen.
Die Beispiele iCal und CSV in @sec:file-import-migration zeigen, dass dieses Verantwortungsmuster unabhängig von der eingesetzten Parserbibliothek ist.
Ein zusätzlicher Dateityp benötigt einen geeigneten Parser und fachliche Prüfungen; die grundlegende Trennung von Oberfläche, Dateizugriff und Verarbeitung bleibt erhalten @StudyPlanIcalMigration2026 @StudyPlanCsvMigration2026.

=== Externe Daten und Kollaboration schrittweise ergänzen

*M6: Downloads mit dauerhafter lokaler Übernahme verbinden.*
Für externe Referenzdaten ist zunächst zu klären, ob eine Aktualisierung in einer Richtung ausreicht.
Der Abruf soll hinter einer im Main-Prozess verwalteten Dienstanbindung liegen.
Empfangene Daten sind vor der Speicherung zu validieren und zusammengehörige Änderungen konsistent zu übernehmen.
Stabile Kennungen und ein festgelegtes Aktualisierungsverhalten müssen verhindern, dass wiederholte Abrufe unkontrolliert Duplikate oder Datenverluste erzeugen.

Die Oberfläche soll den vorhandenen lokalen Bestand weiterhin lesen können, auch wenn die zusätzliche Aktualisierung scheitert.
Erst ein erfolgreich übernommener Bestand steht für spätere Offline-Aufrufe zur Verfügung; ein leerer lokaler Datenbestand lässt sich durch Fehlerbehandlung allein nicht ersetzen.
Der Datenabruf im Feature Studiengänge aus @sec:study-catalog-download veranschaulicht dieses Muster mit Schemaprüfung, Transaktion und erneutem Ladeversuch.
Eine solche Datenübernahme ist von der Synchronisierung lokaler Änderungen zu unterscheiden @StudyPlanCatalog2026.

*M7: Synchronisierung an einem ausgewählten Funktionsbereich integrieren.*
Vor der breiten Überführung ist die vorgesehene Kombination aus lokaler Datenbank, Synchronisierung und entferntem Backend in einem begrenzten Ablauf zu prüfen.
Die Vorprüfung soll Schemaabbildung, Identitäten, lokale Persistenz, ausstehende Änderungen und Paketbetrieb umfassen.
Eine vorhandene ORM-Anbindung unterstützt Wiederverwendung, ersetzt jedoch nicht die Prüfung von Datentypen und dem Verhalten des neuen Datenzugriffs.
Die Integrationsprototypen des Demonstrators bilden hierfür die Grundlage @StudyPlanSyncSpikes2026.

Anschließend sind die Verantwortung für lokale Änderungen, Upload und Download sowie unmittelbar netzwerkabhängige Operationen festzulegen.
Clientseitig erzeugbare Kennungen und eine nachvollziehbare Zuordnung lokaler und entfernter Identitäten müssen Datensätze und Beziehungen konsistent halten.
Der lokale Schreibabschluss ist von der Annahme durch das Backend zu unterscheiden; ausstehende, fehlgeschlagene und abgewiesene Änderungen benötigen ein festgelegtes Verhalten.
Im Feature Studiengruppen bleiben Aufgabenänderungen lokal ausführbar, während Gruppenerstellung und Einladungen unmittelbare Online-Operationen sind.
Vorausgesetzte entfernte Konten und Änderungen des ursprünglichen Einladungsablaufs sind als Voraussetzungen beziehungsweise fachliche Anpassungen auszuweisen @StudyPlanSyncIntegration2026 @StudyPlanSyncArchitecture2026.

Eine zeitweise parallele Datenhaltung kann die Überführung nach Funktionsbereichen begrenzen.
Für jeden Bereich ist eindeutig festzulegen, welcher lokale Bestand und welche Repository-Implementierung verwendet werden.
Die Übernahme bestehender Daten einschließlich ihrer Referenzen ist eine zusätzliche Aufgabe; das Einrichten einer neuen synchronisierten Tabelle führt sie nicht automatisch aus.
Auch Downloadfilter ersetzen keine Schreibberechtigungen oder die ausdrückliche Festlegung rein lokaler Tabellen.
@sec:sync-architecture erläutert diese Trennung im Demonstrator.

Mit der Synchronisierung ist außerdem die Verantwortung für Schemaänderungen neu zu ordnen.
Entferntes Schema, Datenverteilung und Client-Schema müssen kompatibel bereitgestellt werden.
Welche Änderungen weiterhin lokale SQL-Migrationen benötigen und welche das SDK verwaltet, hängt vom gewählten Datenhaltungsmodell ab.
@sec:sync-schema-updates beschreibt den daraus abgeleiteten Bereitstellungsablauf.
Dieser ist bei einer Erweiterung mit bestehenden Clients und noch ausstehenden Änderungen abzugleichen; er wurde in der Fallstudie nicht als vollständiger Versionsrollout erprobt.

=== Kontrollpunkte, Härtung und Fortführung des Leitfadens

*M8: Härtung konsolidieren und den Paketstand prüfen.*
Abschließend sind die tatsächlich entstandenen Fenster, Preload-Bridges, IPC-Eingänge, Ressourcen- und Netzwerkpfade gemeinsam zu prüfen.
Jede Electron-Empfehlung erhält eine begründete Anwendbarkeitsentscheidung, Umsetzung und Beleg.
Fehlende Mechanismen, fehlende Implementierungen und fehlende Prüfungen sind getrennt zu bewerten.
Die Sicherheitsmatrix aus @sec:app-hardening zeigt das dazu verwendete Dokumentationsmuster @StudyPlanSecurity2026.

Das Prüfverfahren ist an den Gegenstand anzupassen: Codeinspektion belegt die vorhandene Konfiguration, Unit-Tests prüfen ausgewählte Entscheidungen, und Laufzeitfälle beobachten die Wirkung konkreter Kontrollen.
Buildabhängige Aussagen wie Fuse-Werte, ASAR-Integrität und native Modulkompatibilität sind am erzeugten Paket zu prüfen.
Nach Änderungen an Version, Treibern, Protokoll oder Paketkonfiguration sind die betroffenen Nachweise zu erneuern und an den geprüften Stand zu binden.
Die Nachbesserungen in Phase 3 begründen diese Empfehlung; insbesondere dürfen Ergebnisse einer früheren Binary nicht einem veränderten Paket zugeschrieben werden @StudyPlanSecurityRemediation2026.

@tab:migration-recommendation-checkpoints fasst die zu prüfenden Zustände zusammen.
Ihre Zuordnung zu A1–A8 macht den Zweck der einzelnen Schritte sichtbar; die dokumentierte Verbindung von Voraussetzung, Transformation und Kontrollpunkt konkretisiert A9.
Die Tabelle formuliert Prüfaufgaben für die Anwendung des Leitfadens.
Welche Ergebnisse der Demonstrator hierfür tatsächlich liefert, wird in @ch:experiments bewertet.

#block[
  #show figure.where(kind: table): set block(breakable: false)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (0.8fr, 1.8fr, 2.6fr),
        inset: 5pt,
        align: left,
        table.header([*Schritt / Bezug*],
        [*Ergebnis des Schritts*],
        [*Kontrollpunkt*]),
        [M1; A1, A3, A8],
        [Erfasster Kernumfang und begründete, kompatible Zielumgebung.],
        [Interaktionsformen und externe Abhängigkeiten benennen; kleinen Desktop-Paketstand einschließlich vorgesehener nativer Module starten.],
        [M2; A5],
        [Lokal verwalteter Datenbestand mit Schema, Referenzdaten und Identitätszuordnung.],
        [Lokale Initialisierung und Zuordnung prüfen; Daten ohne Netzwerk schreiben und nach Neustart lesen.
          Erforderliche Änderungen an bestehenden Daten gesondert prüfen.],
        [M3; A4, A7],
        [Fachlicher Vertrag mit begrenztem Preload-/IPC-Transport.],
        [Vertrag und erzeugte Module abgleichen; unbekannte Operationen und ungültige Eingaben abweisen.
          Prüfen, dass lokale Aufrufe keinen HTTP-Server benötigen.],
        [M4; A2, A5, A8],
        [Vollständiger Kernablauf mit getrennten Verantwortlichkeiten.],
        [Aufruf von Oberfläche bis Repository nachvollziehen; persönliche Datenzuordnung, CRUD-Verhalten und Fehler prüfen.
          Fachliche Tests von nativer IPC- und Oberflächenprüfung unterscheiden.],
        [M5; A7, A8],
        [Native Dateiauswahl mit begrenztem Zugriff und validierter Verarbeitung.],
        [Abbruch, ungeeignete Eingaben und gültigen Import prüfen; fachliches Ergebnis und Aktualisierung der Oberfläche nachvollziehen.],
        [M6; A5, A8],
        [Validierte Aktualisierung mit dauerhaft lokalem Bestand.],
        [Wiederholten Abruf und fehlerhafte Übernahme prüfen; verfügbaren Bestand bei Netzausfall und nach Neustart weiterverwenden.],
        [M7; A6, A8],
        [Abgegrenzter synchronisierter Bereich mit geregelter Identität und Dienstanbindung.],
        [Lokalen Schreibabschluss, Persistenz ausstehender Änderungen und Übermittlung getrennt prüfen; Online-Voraussetzungen und Verhalten bei Fehlern ausweisen.],
        [M8; A1, A7],
        [Konsolidierte Sicherheitsmatrix mit versionsbezogenen Belegen.],
        [Alle Electron-Empfehlungen zuordnen; ausgewählte Eingabe- und Fremdinhaltfälle prüfen; Paketwerte und Funktion belegen.
          Verbleibende Nachweisgrenzen dokumentieren.],
      )
    },
    caption: [Handlungsempfehlungen und Kontrollpunkte, abgeleitet aus dem dokumentierten Migrationsprozess; die Zuordnung konkretisiert A9.],
  ) <tab:migration-recommendation-checkpoints>
]

Für eine weitere Funktion ist zunächst ihre Interaktionsform zu bestimmen.
Ein zusätzlicher CRUD-Bereich kann das Vertrags-, Handler-, Service- und Repository-Muster fortführen; ein weiterer Import ergänzt Dateiformat und fachliche Validierung; eine weitere Online-Anbindung benötigt einen geregelten Datenübernahme- oder Synchronisierungsablauf.
Neue privilegierte Fähigkeiten, Identitätswechsel oder Datenflüsse erfordern einen erneuten Architektur- und Sicherheitsabgleich.
Der Leitfaden bietet damit ein begründetes Vorgehensmodell für die untersuchten Aufgaben.
Seine Übertragung auf andere Ausgangsartefakte bleibt anhand dieser Voraussetzungen zu prüfen; eine unabhängige Anwendung auf weitere Projekte wurde nicht durchgeführt.

// Arbeitsstand: Prozessberichte in 5.2–5.4 und abgeleitete Empfehlungen in 5.5.
// Ergebnisse und Nachweisgrenzen der Kontrollpunkte werden in Kapitel 6 bewertet.
