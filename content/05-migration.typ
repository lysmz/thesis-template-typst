//---------------------------------------------------------------------
= Entwurf, Migration und Migrationsleitfaden <ch:migration>
//---------------------------------------------------------------------

== Struktur des Migrationsleitfadens

Der Migrationsleitfaden gliedert die Umsetzung in drei Zielzustände: eine Offline-Kernanwendung, deren Erweiterung um Online-Funktionen und die anschließende Prüfung und Härtung.
Innerhalb der Phasen werden die Anpassungen an Datenhaltung, Schnittstellen und Anwendungsfunktionen anhand ausgewählter Beispiele erläutert.
Die Analyse aus @ch:analysis liefert den architektonischen Ausgangspunkt und die Bewertungskriterien.
Jede Phase endet mit einem Kontrollpunkt; Sicherheitsanforderungen fließen bereits in die Architekturentscheidungen der ersten Phase ein.

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    inset: 7pt,
    align: left,
    table.header([*Phase*],
    [*Zielzustand*],
    [*Kontrollpunkt*]),
    [1],
    [Offline-Kernfunktionen mit lokaler Datenhaltung und begrenzter IPC-Kommunikation.],
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
Die `react-ts`-Vorlage vereinte die benötigten Technologien unmittelbar; die betrachtete React-TypeScript-Anleitung von Electron Forge verwendet dagegen `webpack-typescript` @ElectronForgeReact2026 @ElectronForgeGettingStarted2026.

Anschließend wurden die Drizzle-Schemadefinitionen für Benutzer, Stundenpläne, Studiengänge, Gruppen, Noten, Termine und das Aktivitätsprotokoll samt Exportmodul nach `src/main/db/schema` übernommen.
Eine lokale SQLite-Datei ersetzte die PostgreSQL-Verbindung; `DATABASE_URL` entfiel für die lokale Datenhaltung.
Der Main-Prozess übernahm das Anlegen, Öffnen und Migrieren der Benutzerdatenbank @StudienplanerSource2026 @StudyPlanDatabase2026.

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
Damit lassen sich Schemaerweiterungen bei Updates schrittweise auf bestehende Benutzerdatenbanken anwenden.

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

Scheitert dieser Ablauf, bricht der Start mit einer Fehlermeldung ab, bevor die Benutzeroberfläche geöffnet wird.

Für Funktionen mit Referenzdaten stellen die Datenmigrationen `0001_seed-study-programs.sql` und `0002_seed-timetable-presets.sql` Studiengänge, Lehrveranstaltungen und Stundenplanvorlagen bereit. 
Sie werden während des Migrationsschritts lokal eingefügt und stehen damit bereits beim ersten Start ohne Netzwerkverbindung zur Verfügung @StudyPlanDatabase2026.

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
YAML-Eingabe (Auszug)
#set text(size: 8.5pt)
```yaml
EventInput:
  type: object
  required: [title]
  properties:
    title:
      type: string
      minLength: 1
    description:
      type: string
```
],
[
TypeScript-Ausgabe (Auszug)
#set text(size: 8.5pt)
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

Zur Laufzeit vermittelt ein typisierter RPC-Aufruf zwischen Renderer und Main-Prozess.
@fig:ipc-dispatcher-flow zeigt den Aufrufweg und die Verarbeitung im zentralen Dispatcher.

#figure(
  image("../figures/ipc-dispatcher-flow.svg", width: 100%),
  caption: [IPC-Aufrufweg und Verarbeitung im API-Dispatcher. Durchgezogene Pfeile zeigen die Anfrage, gestrichelte Pfeile die Rückgabe über dieselben Schnittstellen. Eigene Darstellung nach @StudyPlanApiMigration2026.],
) <fig:ipc-dispatcher-flow>

Die Preload-Bridge stellt über `contextBridge.exposeInMainWorld` ausschließlich `window.apiTransport.invoke` bereit; das vollständige `ipcRenderer`-Modul und frei wählbare Kanalnamen bleiben dem Renderer vorenthalten @ElectronContextBridge2026 @ElectronIpc2026.
Die Deklaration in `src/preload/index.d.ts` ergänzt das globale `Window`-Interface für die statische Typprüfung.

Unbekannte Operationskennungen und ungültige Eingaben werden abgewiesen.
Für eine im Vertrag definierte Operation ohne registrierten Handler liefert der Dispatcher `NOT_IMPLEMENTED`.
Geschäftslogik, Sitzungsprüfungen und Datenbankzugriffe verbleiben in den Handlern und Services des Main-Prozesses @StudyPlanApiMigration2026.

=== Grenzen und kritische Würdigung des Generatoransatzes

Der Generator verwendet OpenAPI als Vertragsformat für IPC, obwohl die Spezifikation HTTP-Schnittstellen beschreibt @OpenApi310.
HTTP-Methoden und URI-Pfade dienen dabei als Metadaten; Fehler werden über `ApiResult` statt über HTTP-Antworten übertragen.

Der Generator deckt bewusst nur den im Demonstrator tatsächlich benötigten Funktionsumfang der Spezifikation ab. 
Komplexere OpenAPI-Konstrukte, wie rekursive Schemadefinitionen oder tief verschachtelte oneOf-Vereinigungen, werden vom Parser nicht aufgelöst, sondern zur Generierungszeit als Fehler abgewiesen @StudyPlanApiMigration2026.

Die gemeinsame Ableitung von Typen, Validierung und Client vermeidet deren manuelle Synchronisierung.
Dafür wurde eine eigene Toolchain entwickelt, die bei Änderungen der unterstützten Spezifikation oder der Zielbibliotheken mitgepflegt werden muss @StudyPlanApiMigration2026.

=== Übernahme der React-Oberfläche in den Renderer <sec:frontend-migration>
Die React-Oberfläche aus artifacts/studienplaner/ wurde zu src/renderer/src/ migriert. 

Mitkopierte Web- und Replit-spezifische Konfigurationsdateien (package.json, vite.config.ts, tsconfig.json, components.json und die redundante index.html) wurden entfernt. 
Da electron-vite den Main-, Preload- und Renderer-Prozess zentral konfiguriert und für den Renderer standardmäßig auf src/renderer/index.html zugreift @ElectronViteConfig2026, entfielen serverspezifische Parameter wie Portvorgaben, BASE_PATH und Replit-Plugins des Ausgangsprojekts ersatzlos @StudienplanerSource2026 @StudyPlanFrontendMigration2026.

Um bestehende Modulpfade wie `@/components/ui/badge` ohne Refaktorisierung beizubehalten, wurde der Pfadalias `@` in electron.vite.config.ts auf src/renderer/src abgebildet und parallel in tsconfig.web.json für `@/*` hinterlegt @StudyPlanFrontendMigration2026. 
Der synchrone Eintrag in beiden Dateien stellt sicher, dass Vite die Pfade beim Bündeln auflöst und TypeScript sie bei der Typprüfung korrekt zuordnet @TypeScriptPaths2026.

Die übernommene index.css definiert Theme-Variablen und bindet Tailwind CSS, tw-animate-css sowie das Typografie-Plugin ein. 
`@tailwindcss/vite` wurde über tailwindcss() neben react() registriert und die Vite-Typreferenz in src/renderer/src/env.d.ts hinterlegt @TailwindVite2026 @StudyPlanFrontendMigration2026.
Die Vorlagenstile assets/main.css und assets/base.css wurden samt Beispielkomponenten gelöscht.

Die package.json des Electron-Projekts wurde um die Komponenten- und Hilfsbibliotheken ergänzt. 

=== Anbindung der Seiten und Navigation

Die bisherigen API-Aufrufe über `@workspace/api-client-react` wurden in den Seiten und im Layout durch `@/api` ersetzt, welches die IPC-basierten Hooks und Typen exportiert @StudyPlanFrontendMigration2026. 
Da der Codegenerator die Schnittstellensignaturen beibehielt (siehe @sec:api-contract-migration), blieben etablierte Aufrufmuster wie useListEvents(monthParams) oder Mutationen mit { data: ... } syntaktisch intakt.

Im selben Zuge wurden ungenutzte Imports, Variablen und Zustände entfernt. 

Für die Navigation nutzt die Anwendung weiterhin wouter. 
Anstelle des webbasierten Basispfads (import.meta.env.BASE_URL) wurde der Router über useHashLocation aus wouter/use-hash-location eingebunden (`<WouterRouter hook="{useHashLocation}">`) @StudyPlanFrontendMigration2026.
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
Diese lokale Sitzung liegt im Arbeitsspeicher und endet beim Beenden der Anwendung; die Benutzerdatensätze bleiben dagegen in der SQLite-Datenbank gespeichert @StudienplanerSource2026 @StudyPlanLocalAuth2026.

Bei erfolgreicher Anmeldung oder Registrierung leert der Renderer den bisherigen React-Query-Cache, speichert die Benutzerinformation unter dem Query Key von `getMe` und navigiert zur Anwendung.
`UNAUTHENTICATED` führt zur Anmeldung und wird von der Query-Wiederholungslogik berücksichtigt.
Andere Ladefehler erhalten eine Anzeige mit erneuter Abfragemöglichkeit.
Die Weiterleitung bei bestehender Anmeldung erfolgt über einen React-Effekt @StudyPlanLocalAuth2026.

=== Integration der CRUD-Funktionen am Beispiel der Notenverwaltung <sec:crud-migration>

Nach der Oberflächenintegration und der lokalen Authentifizierung wurden die weiteren fachlichen Funktionen mit dem vorbereiteten Aufrufweg verbunden.
Die Migration der CRUD-Operationen wird exemplarisch an der Notenverwaltung beschrieben.
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
Die resultierenden Handler werden in die gemeinsame Registry aufgenommen, die der IPC-Dispatcher verwendet @StudyPlanGradesMigration2026.

Die Benutzerkennung stammt bei diesen Operationen aus der lokalen Sitzung im Main-Prozess.
Der gemeinsame Wrapper `authenticated` stellt sie dem Handler bereit.
Im Repository werden Änderungen und Löschungen anhand der Datensatzkennung und der Benutzerkennung eingeschränkt.
Findet eine solche Operation keinen passenden Datensatz, meldet der Service einen fachlichen Fehler, den der Handler in `NOT_FOUND` überführt.
Damit bleibt die persönliche Datenzuordnung Bestandteil des vollständigen Verarbeitungspfads @StudyPlanGradesMigration2026.

Die vorhandenen fachlichen Regeln wurden als Ausgangspunkt beibehalten.
Dazu gehören optionale Werte, die Erfassung von Aktivitäten, der ECTS-gewichtete Notendurchschnitt und die Auswertung nach Semester.
Anpassungen ergaben sich aus der lokalen Datenrepräsentation: Note und ECTS werden im SQLite-Schema als numerische Werte verarbeitet, sodass die bisher für PostgreSQL verwendete Umwandlung in Strings beziehungsweise deren Rückkonvertierung entfallen konnte.
Die Migration übernahm somit die fachlichen Berechnungen und gliederte ihre Ausführung neu @StudienplanerSource2026 @StudyPlanGradesMigration2026.

Bei der Notenerfassung übermittelt die vorhandene Seite beispielsweise die Formulardaten über `useCreateGrade` beziehungsweise `useUpdateGrade`.
Die Oberfläche aktualisiert anschließend die Abfragen für Notenliste und Statistik @StudyPlanGradesMigration2026.

@fig:grades-crud-flow stellt diesen Ablauf mit den beteiligten Prozessbereichen und dem Rückweg des Ergebnisses dar.

#figure(
  image("../figures/grades-crud-flow.svg", width: 100%),
  caption: [Lokaler CRUD-Aufrufweg am Beispiel der Notenerfassung. Durchgezogene Pfeile zeigen die Anfrage, gestrichelte Pfeile den Rückweg und die anschließende Aktualisierung der Oberfläche.],
) <fig:grades-crud-flow>

`scripts/grades/grades.test.ts` verbindet den generierten Client mit Dispatcher, Handlern, Service, Repositories und einer SQLite-Datenbank im Arbeitsspeicher.
Geprüft werden Sitzung, persönliche Datenzuordnung, Änderungen, Aktivitäten und Statistik.
Der direkte Dispatcher-Aufruf ersetzt die native IPC-Kommunikation.

=== Lokaler Dateiimport am Beispiel iCal <sec:file-import-migration>

Im Web-Prototyp übermittelte die Kalenderseite die gewählte Datei als `FormData` mit `fetch` an `/api/events/import-ical`.
Der zugehörige Express-Route-Handler verband die HTTP-Dateiannahme mit dem Parsen, der fachlichen Zuordnung und der Speicherung der Termine.
@lst:ical-web-upload zeigt den bisherigen Einstieg in diese Verarbeitung @StudienplanerSource2026.
#figure(
block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
set text(size: 8.5pt)
raw(read("../code/ical-web-upload.ts"), lang: "typescript", block: true)
}),
kind: raw,
supplement: [Quellcode],
caption: [Dateiannahme und Parseraufruf der ursprünglichen Express-Route (gekürzter Ausschnitt) @StudienplanerSource2026.],
) <lst:ical-web-upload>

In der Desktop-Anwendung ersetzt eine native Dateiauswahl den HTTP-Upload.
Die neue Vertragsoperation `importEventsIcal` ist parameterlos: Der Renderer übergibt weder Dateipfad noch Dateiinhalt und erhält damit keinen frei wählbaren Dateisystemzugriff @ElectronContextBridge2026 @StudyPlanIcalMigration2026.
Den lokalen Importablauf zeigt @fig:local-file-import-flow.
#figure(
image("../figures/local-file-import-flow.svg", width: 100%),
caption: [Lokaler iCal-Import mit nativer Dateiauswahl und getrenntem Abbruchpfad.],
) <fig:local-file-import-flow>

Für die Dateiauswahl wurde `NativeIcalFilePicker` ergänzt, der `dialog.showOpenDialog` mit einem ICS-Filter modal an das anfragende Fenster bindet @ElectronDialog2026 @StudyPlanIcalMigration2026.
Da die Dateiannahme über Multer entfällt, übernimmt die lokale Implementierung auch die bisherige Größenobergrenze von 10 MiB.
Sie prüft die Endung `.ics`, den regulären Dateityp und die Größe vor und nach dem Einlesen; anschließend wird der Inhalt als UTF-8-Text verarbeitet @StudienplanerSource2026 @StudyPlanIcalMigration2026.

Die Bibliothek `node-ical` und die vorhandenen fachlichen Feldzuordnungen wurden beibehalten und in `events-ical.parser.ts` ausgelagert.
Ergänzt wurden Prüfungen der grundlegenden Kalenderstruktur und gültiger Zeitangaben sowie der Ausschluss von Zeitspannen, deren Ende vor dem Beginn liegt.
Übersprungene Einträge werden separat gezählt.
Die übernommenen Termine erhalten die Benutzerkennung, werden gesammelt gespeichert und durch einen Aktivitätseintrag protokolliert @StudyPlanIcalMigration2026.

Das neue Ergebnisschema `EventIcalImportResult` unterscheidet den Abbruch (`status: cancelled`, beide Zählwerte 0) vom erfolgreichen Import (`status: imported` mit `importedCount` und `skippedCount`).
Ein Abbruch verändert den Datenbestand nicht; fehlerhafte Kalenderstrukturen werden als `VALIDATION_ERROR` gemeldet.
Während der Verarbeitung sind die Importbedienelemente deaktiviert @StudyPlanIcalMigration2026.

Der CSV-Notenimport (`importGradesCsv`) verwendet dasselbe Importmuster mit einem eigenen Parser in `grades-csv.parser.ts` @StudyPlanCsvMigration2026.

Damit ist die lokale Kernanwendung einschließlich der Dateiimporte umgesetzt @StudyPlanLocalCore2026.
Als Kontrollpunkt sind die Kernabläufe ohne Netzwerk auszuführen und gespeicherte Änderungen nach einem Neustart erneut zu lesen (A1, A5).

== Phase 2: Netzwerkanbindungen und Local-First-Synchronisierung

Die zweite Phase ergänzt die Synchronisierung gemeinsamer Aufgaben im Feature Studiengruppen sowie den Online-Abruf von Studiengangsdaten.

=== Auswahlkriterien und betrachtete Synchronisierungslösungen <sec:sync-tool-selection>

Für die Synchronisierung sollte eine bestehende Lösung eingesetzt werden, die Aufgabenänderungen lokal speichert und bei verfügbarer Verbindung abgleicht (A6).
Um den vorhandenen Datenzugriff möglichst weiterzuverwenden (A3), waren die Ausführbarkeit im Electron-Main-Prozess, die SQLite- und Drizzle-Anbindung sowie die unterstützte entfernte Datenhaltung maßgeblich.
Betrachtet wurden PowerSync und Turso; @tab:sync-tool-options stellt ihre Integrationsansätze gegenüber.

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

Für den Demonstrator wurde die Kombination aus Supabase und PowerSync gewählt.
Supabase stellt die PostgreSQL-Datenbank für den gemeinsamen Gruppenbestand sowie die Authentifizierung der beteiligten Benutzer bereit @SupabaseDatabase2026 @SupabaseAuth2026.
PowerSync übernimmt den Abgleich mit den lokalen SQLite-Datenbanken.
Ausschlaggebend war die dokumentierte Integration beider Dienste, die Authentifizierung, Backend-Datenhaltung und gezielte Datenverteilung miteinander verbindet @PowerSyncSupabase2026.

Auch Turso unterstützt Synchronisierung und Offline-Schreibzugriffe @TursoSync2026.
Für die gewählte Kombination sprach die vorhandene Anbindung an Supabase, durch die diese Infrastrukturaufgaben mit bestehenden Diensten umgesetzt werden konnten.

=== Vorprüfung der Integration und Drizzle-Anbindung

Vor der Integration in die Anwendung wurde die gewählte Kombination anhand zweier Prototypen erprobt.
Zunächst wurde das PowerSync-Node-SDK im Electron-Main-Prozess eingebunden.
Dabei wurden die lokale Speicherung einschließlich ausstehender Uploads, Schemaerweiterungen, der Abgleich zwischen Geräten und die Paketierung geprüft @StudyPlanSyncSpikes2026.

Anschließend wurde die Drizzle-Anbindung ergänzt, um typisierte CRUD-Abfragen und die Abbildung der verwendeten Datentypen zu erproben.
Dabei ließen sich die vorhandenen Abfragemuster auf den synchronisierten Datenzugriff übertragen.
Die lokale Speicherung und der geräteübergreifende Abgleich funktionierten auch mit dieser Anbindung @StudyPlanSyncSpikes2026.

Die Weiterverwendung von Drizzle erforderte jedoch Anpassungen des Schemas an PowerSync.
Clientseitig setzt PowerSync eine Primärschlüsselspalte `id` vom Typ Text voraus; für lokal erzeugte Datensätze wurden im Demonstrator UUIDs verwendet @PowerSyncClientId2026 @StudyPlanSyncSpikes2026.
Damit änderten sich gegenüber den automatisch erzeugten Integer-Kennungen der Kernanwendung auch die zugehörigen Referenzen.

Für die weitere Migration standen deshalb zwei Vorgehensweisen zur Auswahl: die vollständige Umstellung der bestehenden Schemata und Datenzugriffe auf den PowerSync-Bestand oder die schrittweise Überführung einzelner Funktionsbereiche.
Gewählt wurde die zweite Variante, um die Offline-Kernanwendung weiterzuverwenden und zunächst nur den Kollaborationsbereich anzupassen.
Dieses Vorgehen folgt dem Grundgedanken des Strangler-Fig-Patterns: Bestehende Funktionen bleiben nutzbar, während ihre neuen Implementierungen schrittweise hinzukommen @FowlerStranglerFig2024.

=== Architektur mit zwei lokalen Datenhaltungsbereichen <sec:sync-architecture>

Während der schrittweisen Migration bleibt die SQLite-Datenbank aus Phase 1 für persönliche Funktionen und bestehende lokale Gruppen erhalten.
Der synchronisierte Kollaborationsbereich erhält einen eigenen lokalen Datenbestand.
Beide Bereiche werden vom Main-Prozess angesprochen; die Oberfläche verwendet weiterhin die begrenzten Preload-/IPC-Schnittstellen.
@fig:local-first-architecture zeigt die Aufteilung und die Anbindung der entfernten Dienste @StudyPlanSyncArchitecture2026.

Die Oberfläche führt die bestehenden lokalen Gruppen unter `/gruppen` als „Gruppen“ und den ergänzten Kollaborationsbereich unter `/gruppen-sync` als „Gruppen (Sync)“.
Beide Implementierungen bestehen während der Überführung nebeneinander; vorhandene lokale Gruppendaten werden nicht automatisch in den synchronisierten Bereich übertragen @StudyPlanGroupTransition2026.

#figure(
  image("../figures/local-first-architecture.svg", width: 100%),
  caption: [Architektur nach Ergänzung der Synchronisierung im Feature Studiengruppen.
    Dargestellt sind die beiden lokalen Datenhaltungsbereiche sowie direkte Online-Aufrufe, Upload und Download.
    Der separate Datenabruf im Feature Studiengänge ist hier nicht dargestellt.
    Eigene Darstellung nach @StudyPlanSyncArchitecture2026 und @PowerSyncSupabase2026.],
) <fig:local-first-architecture>

Aufgabenänderungen werden zunächst lokal gespeichert und anschließend an Supabase übermittelt.
Der Empfang entfernter Änderungen erfolgt über den PowerSync-Dienst.
Davon getrennt bleiben administrative Gruppenfunktionen, die Supabase unmittelbar aufrufen und deshalb eine Netzwerkverbindung benötigen @PowerSyncSupabase2026 @StudyPlanSyncArchitecture2026.

=== Konten und Einladungsablauf im Kollaborationsbereich <sec:collaboration-invitations>

Für den Kollaborationsbereich werden entfernte Benutzerkonten verwendet, die von der lokalen Kontoverwaltung aus Phase 1 getrennt sind.
Supabase Auth verwaltet diese Konten; anwendungsbezogene Namen und Kennungen liegen in einer zugeordneten `profiles`-Tabelle @SupabaseUserManagement2026.
Für die Fallstudie wurden die benötigten Testkonten vorab über das Supabase-Dashboard angelegt.
Die Desktop-Anwendung bietet die Anmeldung mit den vorhandenen E-Mail-Adressen und Passwörtern; Registrierung, E-Mail-Bestätigung und Passwortzurücksetzung sind in ihrer Oberfläche nicht enthalten @StudyPlanSyncArchitecture2026.

Der Ausgangsprompt benannte Gruppeneinladungen über Link oder E-Mail.
Im Web-Prototyp erzeugte die Gruppenroute einen Einladungstoken.
Die Oberfläche bildete daraus eine URL und kopierte sie in die Zwischenablage; die Weitergabe erfolgte außerhalb der Anwendung.
Die Seite `/einladung/:token` ermöglichte das Anzeigen und Annehmen der Einladung @StudienplanerInviteReview2026.

Für den synchronisierten Bereich wurde die Auswahl der einzuladenden Personen in die Anwendung verlagert.
Zur Vereinfachung der Auswahl können Gruppeneigentümer nach Benutzer- oder Anzeigenamen der als auffindbar markierten Profile suchen.
Die Suche liefert bis zu 20 Treffer mit Kennung, Benutzername und Anzeigename; die eigene Identität, vorhandene Mitglieder und bereits eingeladene Personen werden ausgeschlossen @StudyPlanSyncArchitecture2026.

Die Auswahl eines Profils erzeugt eine personenbezogene Einladung.
Die eingeladene Person erhält diese durch PowerSync und kann sie annehmen oder ablehnen.
Nach der Annahme entsteht die Mitgliedschaft, anhand derer die Gruppendaten übertragen werden @StudyPlanSyncArchitecture2026.

=== Technische Integration der Kollaborationsmodule <sec:sync-implementation>

==== Datenmodell und Typabbildung

Die technische Umsetzung begann mit der Anpassung des Datenmodells für PostgreSQL und den lokalen PowerSync-Bestand:
- *Identifikatoren:* Die fünf Tabellen des Features Studiengruppen wurden in Supabase über versionierte SQL-Migrationen mit UUID-Primärschlüsseln angelegt. Das lokale Drizzle-Schema bildet diese als Zeichenketten (`text`) ab @StudyPlanSyncIntegration2026.
- *Datentypen:* Datums- und Zeitwerte werden lokal als ISO-8601-Zeichenketten abgebildet; boolesche Attribute werden über den nativen SQLite-Ganzzahltyp (`0` bzw. `1`) repräsentiert.
- *Schemaableitung:* Die zentrale Datei `schema.ts` definiert diesen lokalen Tabellenbestand und generiert mittels `DrizzleAppSchema` die für das PowerSync-SDK erforderliche Konfigurationsstruktur.

==== Backend-Anbindung und Replikationsregeln

Für die zuvor beschriebene Benutzerführung wurden die Backend-Funktionen `search_invitable_profiles`, `send_group_invitation` und `respond_group_invitation` angebunden.
Sie setzen Profilsuche, Einladungsversand und Annahme beziehungsweise Ablehnung um @StudyPlanSyncArchitecture2026.

Für die Replikation aus dem Backend wurden die Tabellen der PostgreSQL-Publication `powersync` zugewiesen und für die Replikationsrolle freigegeben @PowerSyncSupabase2026.

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

Der PowerSync-Dienst überwacht das PostgreSQL-Write-Ahead-Log (WAL).
Durch `auto_subscribe: true` wird der Stream beim Verbindungsaufbau automatisch abonniert @PowerSyncStreams2026.

==== Kollaborationslaufzeit und IPC-Verträge

Die Steuerung des synchronisierten Bereichs übernimmt das Modul `CollaborationRuntime`.
Es kapselt den Sitzungszustand, verwaltet die Verbindungslebenszyklen und steuert den Datenzugriff.
Für die Anmeldung ruft der Connector im Main-Prozess `signInWithPassword` mit den eingegebenen Zugangsdaten auf und authentifiziert damit die zuvor eingerichteten Konten @StudyPlanSyncArchitecture2026 @SupabasePasswordSignIn2026.
Nach erfolgreicher Anmeldung öffnet die Laufzeit eine benutzerbezogene SQLite-Datenbank und verbindet sie mit PowerSync (@lst:collaboration-connect).

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

Der Connector stellt über `fetchCredentials` die Anmeldedaten für die PowerSync-Verbindung bereit und übermittelt über `uploadData` die ausstehenden lokalen Änderungen an die Backend-API.
Das Modul `online-gateway.ts` bündelt dagegen die unmittelbaren Supabase-RPC-Aufrufe für Gruppenerstellung, Profilsuche und Einladungsversand @StudyPlanSyncIntegration2026.

Der Vertrag für die Kollaborationsschnittstelle ist in `src/shared/collaboration/ipc.ts` hinterlegt.
Er wird manuell typisiert; Zod-Schemata prüfen die Eingaben im Main-Prozess @StudyPlanSyncIntegration2026.
Der eigene Kollaborationskanal bildet den getrennten Sitzungs- und Verbindungslebenszyklus dieses Bereichs ab.

@fig:collaboration-modules stellt die resultierende Modulverteilung und die jeweiligen Kommunikationspfade zusammenfassend dar.

#figure(
  image("../figures/collaboration-modules.svg", width: 100%),
  caption: [Modulaufteilung der Kollaborationsintegration neben der lokalen Kernanwendung.
    Blaue Pfeile: Lokale Aufrufe und Datenzugriffe; violette Pfeile: Externe Dienstkommunikation; gestrichelter Pfeil: Deklarative Schemaeinbindung.
    Eigene Darstellung nach @StudyPlanSyncIntegration2026.],
) <fig:collaboration-modules>

==== Native Abhängigkeiten und Paketierung

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

=== Schemaänderungen und Erweiterung weiterer Funktionen <sec:sync-schema-updates>

Auf die Integration eines Funktionsbereichs folgen zwei Aufgaben für die Weiterentwicklung: Änderungen seines Schemas müssen mit Backend und Datenverteilung abgestimmt werden; weitere Bereiche benötigen eine Überführung ihrer Datenmodelle und Zugriffe.

==== Verantwortung für Schemaänderungen und Updates

Mit dem synchronisierten Datenbestand verteilt sich die Schemaverwaltung auf Backend, PowerSync-Dienst und Desktop-Anwendung.
Die persönliche Datenbank wird weiterhin über die mitgelieferten Drizzle-Migrationen aktualisiert.
Für den synchronisierten Bereich werden dagegen das PostgreSQL-Schema und die Datenverteilung serverseitig gepflegt; das lokale Schema wird dem PowerSync-SDK deklarativ vorgegeben @SupabaseSchemaMigrations2026 @PowerSyncSchemaChanges2026.
@fig:sync-schema-deployment zeigt die Bereitstellungsreihenfolge für eine kompatible, additive Schemaerweiterung.

#figure(
  image("../figures/sync-schema-deployment.svg", width: 100%),
  caption: [Bereitstellung einer kompatiblen, additiven Schemaerweiterung über Backend, Synchronisierungsdienst und Client. Eigene Darstellung nach @PowerSyncSchemaDeployment2026.],
) <fig:sync-schema-deployment>

Bei Umbenennungen, Typänderungen oder dem Entfernen von Feldern sind zusätzliche Übergangsschritte erforderlich: Ältere Clients können weiterhin aktiv sein oder nach einer Offline-Phase ausstehende Änderungen im bisherigen Format übertragen @PowerSyncSchemaChanges2026.

==== Schemaübertragung am Terminbeispiel

Das Terminbeispiel aus der Vorprüfung zeigt die Schemaanpassungen für einen weiteren Datenbereich.
Als Ausgangspunkt diente das lokale SQLite-Terminschema aus Phase 1; für PowerSync wurde die separate Prototyptabelle `spike_events` mit Testdaten angelegt @StudyPlanSyncSpikes2026.

@lst:events-local-sqlite und @lst:events-powersync zeigen ausgewählte Felder vor und nach dieser Anpassung.
Im Prototyp ersetzt eine Textkennung den automatisch erzeugten Integer; `ownerId` verweist auf die entfernte Supabase-Identität.
Datumswerte werden als Text gespeichert: Das Repository erzeugt beim Schreiben ISO-Strings und wandelt sie beim Lesen wieder in `Date`-Werte um.
Aus den Drizzle-Tabellen wird zusätzlich das Schema für PowerSync abgeleitet @StudyPlanSchemaReview2026.

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

=== Online-Datenabruf im Feature Studiengänge <sec:study-catalog-download>

Das Feature Studiengänge verwendet einen einseitigen Datenabruf: Fachliche Referenzdaten werden online bereitgestellt, in die lokale Datenbank übernommen und anschließend offline gelesen.
Der Demonstrator ergänzt hierzu den in Phase 1 ausgelieferten Seed-Bestand um online abrufbare Beispieldaten; der vorhandene Grundbestand bleibt erhalten @StudyPlanCatalog2026.

Dafür wurde eine Supabase Edge Function ergänzt, die Studiengänge und zugehörige Lehrveranstaltungen aus einer JSON-Datei über einen öffentlichen HTTP-Endpunkt bereitstellt.
Dieser Endpunkt benötigt weder ein Benutzerkonto noch einen Zugriff auf die entfernte Datenbank.
Änderungen am angebotenen Katalog erfordern eine erneute Bereitstellung dieser Datei mit der Funktion, jedoch keine neue Version der Desktop-Anwendung.
Der bestehende OpenAPI-Vertrag wurde um `refreshStudyCatalog` und dessen Ergebnis mit den Anzahlen übernommener Studiengänge und Lehrveranstaltungen erweitert @StudyPlanCatalog2026.

Beim Öffnen des Features Studiengänge liest die Oberfläche zunächst den lokalen Bestand und löst zusätzlich die Aktualisierung aus.
Der Main-Prozess lädt die JSON-Daten, validiert sie anhand der vorhandenen Feldschemata und übernimmt beide Datenbereiche gemeinsam in einer Transaktion.
Anhand stabiler Kennungen werden neue Einträge eingefügt und vorhandene aktualisiert, sodass wiederholte Abrufe keine Duplikate erzeugen.
In der Antwort fehlende Einträge werden nicht gelöscht.
Nach erfolgreicher Übernahme werden die betroffenen Abfragen der Oberfläche erneut ausgeführt @StudyPlanCatalog2026.

Scheitern Abruf, Validierung oder Datenbankübernahme, bleibt der bisherige lokale Bestand nutzbar.
Die Oberfläche zeigt den Fehler an und bietet einen erneuten Versuch an.
Bereits übernommene Katalogdaten bleiben auch nach einem Neustart lokal verfügbar.
Der untersuchte Stand ruft den Katalog bei jedem Seitenaufruf erneut ab; eine Versionsprüfung zur Erkennung neuer Katalogstände wurde nicht implementiert @StudyPlanCatalog2026.

=== Funktionsumfang, Grenzen und Abschluss der Phase

Die zweite Phase ergänzt die lokale Kernanwendung um synchronisierte Gruppenaufgaben und aktualisierbare Studiengangsdaten.
Aufgaben können während einer bestehenden Kollaborationssitzung ohne Verbindung bearbeitet werden; nach einem Anwendungsneustart ist jedoch eine erneute entfernte Anmeldung erforderlich @StudyPlanSyncArchitecture2026.
Eine eigene fachliche Zusammenführung konkurrierender Bearbeitungen oder Löschkonflikte wurde nicht ergänzt.

Als Kontrollpunkt sind die lokale Speicherung einer Aufgabenänderung, ihre anschließende Übermittlung und die Übernahme entfernter Änderungen getrennt zu prüfen (A6).
Beim Katalogabruf muss der vorhandene lokale Bestand auch nach einem Verbindungsfehler nutzbar bleiben; unmittelbar netzwerkabhängige Gruppenaktionen müssen den Fehler verständlich anzeigen (A8).

== Phase 3: Prüfung und Härtung der vervollständigten Anwendung <sec:app-hardening>

=== Prüfrahmen und Sicherheitsmatrix

Nach der funktionalen Umsetzung wurden die Sicherheitsgrenzen der Desktop-Anwendung zusammenhängend geprüft und daraus notwendige Nachbesserungen abgeleitet.
Grundlage war die Electron-Sicherheitscheckliste, deren Empfehlungen gemäß A7 auf die Anwendung zu übertragen sind @ElectronSecurity2026.
Ergänzend wurden die in @sec:requirements festgelegte Eingabevalidierung, die anwendungsinterne Zugriffskontrolle und die Verarbeitung externer Daten einbezogen.

Für jede Empfehlung wurde in einer Sicherheitsmatrix festgehalten, ob sie anwendbar ist, welche Anwendungsstellen sie betrifft, wie sie umgesetzt ist und worauf ihre Bewertung beruht.
Bei nicht genutzten Mechanismen wurde die fehlende Anwendbarkeit begründet; offene Umsetzungen und ausstehende Prüfungen wurden gesondert erfasst.
Die Matrix wurde während der Prüfung und Nachbesserung fortgeschrieben und mit den zugehörigen Prüfprotokollen verknüpft @StudyPlanSecurityChecks2026 @StudyPlanSecurity2026.

=== Zuordnung der Anforderungen zu den Prüforten

Die Prüforte wurden entlang der Zugriffswege ausgewählt: zwischen Renderer und Main-Prozess, bei der Übernahme von Dateien und Netzwerkdaten sowie beim Laden lokaler Anwendungsressourcen.
Hinzu kamen Fenster- und Sessioneinstellungen, die Electron-Version und die Konfiguration des ausgelieferten Pakets.

Bei IPC wurden drei Fragen unterschieden: Darf das aufrufende Fenster die Schnittstelle verwenden, entspricht die Anfrage dem Vertrag und ist die angemeldete Person zum Datenzugriff berechtigt?
Damit werden Senderprüfung, Eingabevalidierung und fachliche Zugriffskontrolle jeweils einer eigenen Verantwortung zugeordnet @StudyPlanHardeningImplementation2026.

@tab:hardening-checkpoints fasst die Prüforte und Leitfragen zusammen.
Die Nummern ordnen alle 20 Electron-Empfehlungen zu; verwandte Punkte sind gebündelt.
A7 gilt für die gesamte Checkliste, weitere Anforderungsbezüge sind ergänzend angegeben @StudyPlanSecurity2026.

#pagebreak(weak: true)

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (0.8fr, 1.4fr, 3.5fr),
        inset: 5pt,
        align: left,
        table.header([*Bezug*],
        [*Prüfort*],
        [*Leitfrage*]),
        [Nr. 1; A6, A8],
        [Netzwerkanbindung im Main],
        [Sind die Verbindungen für Studiengangsdaten, Supabase und PowerSync auf sichere Protokolle begrenzt, und wie werden Zugangsdaten in Adressen sowie Weiterleitungen behandelt?],
        [Nr. 2–4],
        [Fenster und Preload],
        [Sind Renderer und privilegierte Laufzeit durch die Einstellungen für Node-Integration, Kontextisolation und Sandbox getrennt?],
        [Nr. 5],
        [Session-Berechtigungen],
        [Werden nur benötigte Berechtigungen und nur für das vorgesehene Fenster und Dokument freigegeben?],
        [Nr. 6, 8–10],
        [Fenster- und Startoptionen],
        [Bleibt die Web-Sicherheit aktiv, und werden unsichere Inhalte oder unbenötigte experimentelle Funktionen durch Einstellungen oder Startoptionen freigegeben?],
        [Nr. 7],
        [Renderer-HTML],
        [Begrenzt die Content Security Policy (CSP), aus welchen Quellen Skripte und weitere Inhalte geladen werden dürfen?],
        [Nr. 11–12],
        [Webviews],
        [Wird `webviewTag` verwendet oder aktiviert, und welche Empfehlungen zu dessen Konfiguration sind dadurch anwendbar?],
        [Nr. 13–15],
        [Navigation, Fenster und Shell],
        [Wie werden Navigation und zusätzliche Fenster begrenzt, und welche externen Aufrufe sind über `shell.openExternal` zulässig?],
        [Nr. 17, 20; A2, A4],
        [Beide IPC-Eingänge],
        [Sind die Preload-Schnittstellen begrenzt, und werden Absender, Operationskennung und Eingaben geprüft, bevor die fachliche Verarbeitung beginnt?],
        [Nr. 18],
        [Lokale Ressourcen],
        [Wie werden lokale Inhalte ausgeliefert, und bleibt der Dateizugriff auch bei abweichenden Pfaden oder Verknüpfungen auf die vorgesehene Rendererwurzel begrenzt?],
        [Nr. 16; A1],
        [Electron-Version],
        [Entspricht die verwendete Version dem Aktualisierungsstand zum Prüfzeitpunkt, und bleiben die nativen Datenbankmodule nach einer Aktualisierung funktionsfähig?],
        [Nr. 19; A1],
        [Ausgeliefertes Paket],
        [Sind unbenötigte Electron-Startfunktionen über Fuses deaktiviert und die vorgesehenen Schutzmaßnahmen für das ASAR-Anwendungsarchiv im Paket wirksam?],
        [Ergänzend; A5, A8],
        [Datei- und Datenübernahme],
        [Sind Dateizugriffe, Typ und Größe begrenzt, werden externe Daten vor der Übernahme validiert und fremde Textinhalte als Text dargestellt?],
      )
    },
    caption: [Prüforte und Leitfragen des Sicherheitsabgleichs; Zuordnung nach @StudyPlanSecurity2026, ergänzt um die lokalen Importpfade nach @StudyPlanHardeningImplementation2026.],
  ) <tab:hardening-checkpoints>
]

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
Dadurch lässt sich die tatsächlich verwendete Policy unabhängig vom Dispatcher prüfen @StudyPlanSecurityRemediation2026 @StudyPlanHardeningImplementation2026.

Für externe Anbindungen wurde ein gemeinsamer HTTPS-Prüfer eingeführt.
Er weist ungeeignete Protokolle und eingebettete Zugangsdaten zurück, ohne den Konfigurationswert in Fehlermeldungen auszugeben.
Der Datenabruf im Feature Studiengänge und die Supabase-Anbindung verwenden zusätzlich `redirect: 'error'`.
Der Prüfer erhält die Schreibweise einer gültigen Adresse: Eine zwischenzeitliche Normalisierung ergänzte am PowerSync-Endpunkt einen Slash und verhinderte die Verbindung.
Die Korrektur und ein Regressionstest sichern dieses Detail ab @StudyPlanSecurityRemediation2026.

Electron wurde auf 44.5.1 aktualisiert.
Damit mussten auch die nativen Datenbankabhängigkeiten und ihr Paketbetrieb geprüft werden; die erforderlichen Anpassungen betrafen `better-sqlite3`, das PowerSync-Node-SDK und den nativen Prüfschritt.
Die Paketauswahl wurde auf gebaute Anwendungsteile und Produktionsabhängigkeiten begrenzt, während Drizzle-Migrationen weiterhin über `extraResources` ausgeliefert werden.
Prüfdokumente und Umgebungsdateien gehören nicht zum Anwendungspaket @StudyPlanSecurityRemediation2026.

Die Fuse-Konfiguration deaktiviert `RunAsNode`, die Auswertung von `NODE_OPTIONS`, Node-Inspektionsargumente und zusätzliche Dateiprotokollprivilegien.
Aktiviert wurden `OnlyLoadAppFromAsar` und `EnableEmbeddedAsarIntegrityValidation`; Cookie- und Snapshot-Fuses blieben nach Bedarfsprüfung unverändert.
Die Werte wurden am gebauten Windows-Paket ausgelesen und die eingebetteten Integritätsmetadaten mit dem tatsächlichen ASAR-Header verglichen @StudyPlanSecurityRemediation2026.

=== Nachweisverfahren

Die Nachweise wurden auf vier Ebenen erhoben.
*Codeinspektion* ordnet Einstellungen und Kontrollen den tatsächlichen Einstiegspunkten zu.
*Automatisierte Tests* prüfen ausgewählte Entscheidungen und Fehlerpfade; hierfür wurden vorhandene Dispatcher-, Service-, Upload- und Katalogtests sowie eine kleine Security-Suite verwendet.
*Paketprüfungen* kontrollieren Buildabhängigkeiten, Fuses und Integritätsmetadaten an der erzeugten Anwendung.
*Laufzeitbeobachtungen* zeigen die Wirkung ausgewählter Maßnahmen im gestarteten Paket.
Die Prüfprotokolle halten den jeweiligen Anwendungs- und Paketstand fest @StudyPlanSecurityRemediation2026.

Die Security-Suite prüft unter anderem sechs Senderfälle: einen erlaubten Hauptframe, ein fremdes Fenster, einen Unterframe, einen fehlenden Frame, eine falsche Dokumentadresse und ein zerstörtes Fenster.
Hinzu kommen Pfad- und Handlerfälle sowie negative HTTPS-Konfigurationen.
Die Senderfälle verwenden nachgebildete Electron-Objekte; der Redirecttest verwendet Node-Fetch mit einem lokalen Testserver @StudyPlanSecurityRemediation2026 @StudyPlanHardeningImplementation2026.

Die drei praktischen Fälle P1–P3 wurden am korrigierten Windows-Paket über dessen bestehenden Renderer ausgeführt.
*P1* übergibt je eine ungültige Eingabe an die API- und Kollaborationsbridge und prüft die Fehlerantworten `VALIDATION_ERROR` beziehungsweise `INVALID`.
Die Reihenfolge der Schemaprüfung vor der fachlichen Verarbeitung wird ergänzend im Code nachvollzogen @StudyPlanSecurityChecks2026 @StudyPlanSecurityRemediation2026.

*P2* speichert über die reguläre Aufgabenoberfläche einen synthetischen HTML-artigen Titel mit einem SVG-Element und einem harmlosen Ausführungsmarker.
Die Darstellung wird unmittelbar und nach erneutem Öffnen der Aufgabenansicht untersucht.
Erwartet werden ausschließlich Textknoten, kein aus dem Titel erzeugtes SVG-Element und kein gesetzter Marker.
Das Protokoll ergänzt die DOM-Beobachtung um das Lesen der gespeicherten Aufgabe und den zu diesem Zeitpunkt verbundenen Sync-Zustand ohne ausstehende Uploads @StudyPlanSecurityRemediation2026.

*P3* versucht, eine von der CSP nicht zugelassene fremde Skriptquelle zu laden.
Bewertet wird das konkrete `securitypolicyviolation`-Ereignis einschließlich der verletzten Skriptrichtlinie; ein DNS-Fehler allein wäre kein ausreichender Nachweis.
Ergänzend wurden fremde Navigation und das Öffnen eines zusätzlichen Fensters versucht.
Die Versuche werden über die DevTools ausgelöst und beobachtet @StudyPlanSecurityChecks2026 @StudyPlanSecurityRemediation2026.

Dateihashes binden die finalen Paket- und Laufzeitprotokolle an dieselbe EXE und dasselbe ASAR-Archiv.
Die technischen Paket- und Laufzeitbelege stammen vom 4. Oktober 2026 und wurden in der Matrix vom 6. Oktober zusammengeführt @StudyPlanSecurityRemediation2026 @StudyPlanSecurity2026.

Die wesentliche verbleibende Transportgrenze betrifft die SDK-interne Redirectbehandlung von PowerSync.
Dort wurde die HTTPS-Startkonfiguration geprüft, aber kein praktischer Redirect- oder Downgradeversuch am Sync-Stream durchgeführt.
Die Ergebnisse der Prüfungen und ihre Bewertung für A7 werden in @ch:experiments ausgewiesen @StudyPlanSecurity2026.

== Handlungsempfehlungen des Migrationsleitfadens <sec:migration-recommendations>

Aus dem dokumentierten Prozess werden acht Handlungsempfehlungen M1–M8 abgeleitet.
Sie übertragen die Erfahrungen der Fallstudie auf die Migration weiterer Webanwendungen nach Electron.
Maßgeblich sind fachliche Operationen, Datenhaltung und Vertrauensgrenzen; die verwendeten Web-Frameworks und Dienstanbieter können dabei variieren.

=== Voraussetzungen und Herstellung der lokalen Datenhaltung

*M1: Ausgangsartefakt und Zielumgebung abgleichen.*
Vor der Übernahme sind Oberfläche, Schnittstellen, Fachlogik, Datenhaltung und externe Abhängigkeiten zu erfassen.
Für jede Kernfunktion ist festzulegen, ob sie vollständig lokal ausgeführt werden kann, externe Daten herunterlädt oder gemeinsame Änderungen synchronisiert.
Der Untersuchungsumfang sollte mindestens je ein Beispiel der benötigten Interaktionsformen enthalten.

Auf dieser Grundlage ist eine kompatible Desktop-Laufzeit einzurichten.
Vorhandene Sprachen, Bibliotheken und Buildverfahren sollen weiterverwendet werden, soweit sie mit der Zielarchitektur vereinbar sind.
Ein kleiner lauffähiger Paketstand sollte früh prüfen, ob die vorgesehenen Datenbanktreiber und nativen Abhängigkeiten auch außerhalb des Entwicklungsmodus funktionieren.

*M2: Lokale Datenhaltung und Identitätszuordnung herstellen.*
Ein entferntes Datenbankschema ist anhand seiner Bedeutung zu überführen.
Datentypen, Schlüssel, Beziehungen, Standardwerte und Prüfbedingungen müssen einzeln abgeglichen werden.
Bei einem Dialektwechsel sind insbesondere entfallende Datenbankprüfungen ausdrücklich im Zielsystem abzubilden @StudyPlanDatabase2026.

Programmdateien und veränderliche Benutzerdaten sind getrennt zu verwalten.
Die Anwendung soll ihre Datenbank an einem geeigneten Benutzerdatenpfad öffnen und das Schema vor der Nutzung vorbereiten.
Schemaänderungen sind versioniert auszuliefern, soweit die Anwendung das Schema selbst verwaltet.
Erforderliche Referenzdaten müssen auch beim ersten Offline-Start verfügbar sein.
Die lokale Identität ist gesondert festzulegen: Anmeldung, Sitzungsdauer und Zuordnung persönlicher Datensätze müssen zusammenpassen.

=== Schnittstellen und Offline-Kernfunktionen überführen

*M3: Fachlichen Vertrag und Transport trennen.*
Ausgangspunkt sollen die benötigten Operationen mit Eingaben, Ergebnissen und Fehlerfällen sein.
Ein vorhandener API-Vertrag kann hierfür weiterverwendet werden, sofern seine Bedeutungen erhalten bleiben.
HTTP-Pfade und Serverobjekte sind dagegen durch einen begrenzten lokalen Transport zu ersetzen.
Der Renderer soll fachliche Operationen aufrufen und keine frei wählbaren IPC-Kanäle oder privilegierten Rohschnittstellen erhalten.

Die Vertragsdefinitionen sollen gemeinsam gepflegt werden.
Wo bereits generierte Clients und Laufzeitschemata vorliegen, ist ihre Ableitung an den neuen Transport anzupassen.
Änderungen am Vertrag müssen in den erzeugten Modulen nachvollziehbar ankommen; Darstellung und Fachlogik sind nur bei tatsächlich veränderter Semantik anzupassen.
Statische Typen sind durch Laufzeitvalidierung an den Prozesseingängen zu ergänzen @StudyPlanApiMigration2026.

*M4: Einen vollständigen Kernablauf herstellen und dessen Muster fortführen.*
Nach der Einrichtung von Datenhaltung und Transport ist zunächst ein zusammenhängender Verarbeitungspfad zu integrieren.
Dabei sind Oberflächenkomponenten und ihre Abhängigkeiten mit den Build-, Import- und Routingbedingungen der Desktop-Umgebung abzugleichen.

Gemischte Webrouten sind nach Verantwortlichkeiten aufzuteilen: Handler übernehmen Operationszuordnung und Fehlerübersetzung, Services die fachlichen Regeln und Repositories den Datenzugriff.
Der Dispatcher prüft Absender und Eingaben vor dem Handler.
Persönliche Datenzuordnung und Berechtigungen bleiben Teil des Ablaufs und dürfen beim Entfernen des HTTP-Transports nicht entfallen.
Der erste vollständige Ablauf dient als Vorlage für weitere Funktionen.
Datenzugriffe und externe Dienste sollen in Servicetests durch Testimplementierungen ersetzbar sein.
Lokaler Schreibabschluss, erneutes Lesen und Fehlerbehandlung bilden den Kontrollpunkt eines übernommenen Kernablaufs @StudyPlanGradesMigration2026.

*M5: Dateiimporte als begrenzte native Operationen gestalten.*
Ein Webupload ist in Dateiauswahl, Lesen, Parsen, Validieren und Übernehmen aufzuteilen.
Die Oberfläche soll den Import auslösen; der Main-Prozess übernimmt die native Auswahl und den Zugriff auf die ausgewählte Datei.
Dateityp und Größe sind zu begrenzen, der Abbruch ist als eigener Zustand zu behandeln und Parserergebnisse sind vor der fachlichen Speicherung zu prüfen.

Das Ergebnis muss angeben, welche Daten übernommen, übersprungen oder abgewiesen wurden.
Die Oberfläche aktualisiert danach die betroffenen Abfragen.
Weitere Dateitypen ergänzen dieses Muster um geeignete Parser und fachliche Prüfungen @StudyPlanIcalMigration2026 @StudyPlanCsvMigration2026.

=== Externe Daten und Kollaboration schrittweise ergänzen

*M6: Downloads mit dauerhafter lokaler Übernahme verbinden.*
Für externe Referenzdaten ist zunächst zu klären, ob eine Aktualisierung in einer Richtung ausreicht.
Der Abruf soll hinter einer im Main-Prozess verwalteten Dienstanbindung liegen.
Empfangene Daten sind vor der Speicherung zu validieren und zusammengehörige Änderungen konsistent zu übernehmen.
Stabile Kennungen und ein festgelegtes Aktualisierungsverhalten müssen verhindern, dass wiederholte Abrufe unkontrolliert Duplikate oder Datenverluste erzeugen.

Die Oberfläche soll den vorhandenen lokalen Bestand weiterhin lesen können, auch wenn die zusätzliche Aktualisierung scheitert.
Für den ersten Offline-Start ist ein mitgelieferter Grundbestand vorzusehen, wenn die Funktion Referenzdaten benötigt @StudyPlanCatalog2026.

*M7: Synchronisierung an einem ausgewählten Funktionsbereich integrieren.*
Vor der breiten Überführung ist die vorgesehene Kombination aus lokaler Datenbank, Synchronisierung und entferntem Backend in einem begrenzten Ablauf zu prüfen.
Die Vorprüfung soll Schemaabbildung, Identitäten, lokale Persistenz, ausstehende Änderungen und Paketbetrieb umfassen.
Datentypen und das Verhalten des ORM-Zugriffs sind dabei gezielt zu prüfen @StudyPlanSyncSpikes2026.

Anschließend sind die Verantwortung für lokale Änderungen, Upload und Download sowie unmittelbar netzwerkabhängige Operationen festzulegen.
Clientseitig erzeugbare Kennungen und eine nachvollziehbare Zuordnung lokaler und entfernter Identitäten müssen Datensätze und Beziehungen konsistent halten.
Der lokale Schreibabschluss ist von der Annahme durch das Backend zu unterscheiden; ausstehende, fehlgeschlagene und abgewiesene Änderungen benötigen ein festgelegtes Verhalten.
Vorausgesetzte entfernte Konten und fachliche Änderungen der Benutzerführung sind ausdrücklich festzuhalten @StudyPlanSyncIntegration2026 @StudyPlanSyncArchitecture2026.

Eine zeitweise parallele Datenhaltung kann die Überführung nach Funktionsbereichen begrenzen.
Für jeden Bereich ist eindeutig festzulegen, welcher lokale Bestand und welche Repository-Implementierung verwendet werden.
Die Übernahme bestehender Daten erfordert eine Zuordnung ihrer Kennungen und Referenzen zum neuen Bestand.
Downloadfilter, Schreibberechtigungen und die Kennzeichnung rein lokaler Tabellen sind getrennt festzulegen.
Bei einer späteren Zusammenführung der lokalen Datenbanken können persönliche Tabellen etwa über `localOnly: true` von der Upload-Warteschlange ausgenommen werden @PowerSyncLocalOnly2026 @PowerSyncDrizzleDriver2026.
Die Ablösung des bisherigen Treibers setzt die Überführung aller betroffenen Repositories sowie der Datenbankinitialisierung und Schemaverwaltung voraus.

Mit der Synchronisierung ist außerdem die Verantwortung für Schemaänderungen neu zu ordnen.
Entferntes Schema, Datenverteilung und Client-Schema müssen kompatibel bereitgestellt werden.
Welche Änderungen weiterhin lokale SQL-Migrationen benötigen und welche das SDK verwaltet, hängt vom gewählten Datenhaltungsmodell ab.
Der Bereitstellungsablauf muss ältere Clients und noch ausstehende Änderungen berücksichtigen; @sec:sync-schema-updates beschreibt die dafür erforderliche Reihenfolge.

=== Härtung und Kontrollpunkte

*M8: Härtung konsolidieren und den Paketstand prüfen.*
Abschließend sind die tatsächlich entstandenen Fenster, Preload-Bridges, IPC-Eingänge, Ressourcen- und Netzwerkpfade gemeinsam zu prüfen.
Jede Electron-Empfehlung erhält eine begründete Anwendbarkeitsentscheidung, Umsetzung und Beleg.
Fehlende Mechanismen, fehlende Implementierungen und fehlende Prüfungen sind getrennt zu bewerten.
Als Dokumentationsmuster dient die Sicherheitsmatrix aus @sec:app-hardening @StudyPlanSecurity2026.

Das Prüfverfahren ist an den Gegenstand anzupassen: Codeinspektion belegt die vorhandene Konfiguration, Unit-Tests prüfen ausgewählte Entscheidungen, und Laufzeitfälle beobachten die Wirkung konkreter Kontrollen.
Buildabhängige Aussagen wie Fuse-Werte, ASAR-Integrität und native Modulkompatibilität sind am erzeugten Paket zu prüfen.
Nach Änderungen an Version, Treibern, Protokoll oder Paketkonfiguration sind die betroffenen Nachweise zu erneuern und an den geprüften Stand zu binden @StudyPlanSecurityRemediation2026.

@tab:migration-recommendation-checkpoints fasst die zu prüfenden Zustände zusammen.
Ihre Zuordnung zu A1–A8 macht den Zweck der einzelnen Schritte sichtbar; die dokumentierte Verbindung von Voraussetzung, Transformation und Kontrollpunkt konkretisiert A9.
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

// Arbeitsstand: Prozessberichte in 5.2–5.4 und abgeleitete Empfehlungen in 5.5.
// Ergebnisse und Nachweisgrenzen der Kontrollpunkte werden in Kapitel 6 bewertet.
