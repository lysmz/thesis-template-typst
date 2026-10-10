//---------------------------------------------------------------------
= Entwurf, Migration und Migrationsleitfaden <ch:migration>
//---------------------------------------------------------------------

Dieses Kapitel dokumentiert den durchgeführten Migrationsprozess und die dabei getroffenen Entscheidungen. Die Darstellung beginnt mit der Vorbereitung der lokalen Datenhaltung und folgt anschließend den weiteren Transformationsschritten. Auf dieser Grundlage werden die Handlungsempfehlungen des Migrationsleitfadens abgeleitet. Die Beschreibung der konkreten Umsetzung und die daraus gewonnenen Empfehlungen sind dabei zu unterscheiden.

== Struktur des Migrationsleitfadens

Der Leitfaden ordnet die Migration in drei Phasen: die Überführung in eine lokal nutzbare Offline-Anwendung, die Ergänzung um Synchronisierung und weitere Online-Anbindungen sowie die konsolidierte Härtung. Vorausgesetzt wird die Analyse des Ausgangsartefakts aus @ch:analysis. Das dort erstellte Komponentenbild und der Anforderungskatalog legen fest, welche Funktionen übernommen und welche Verantwortlichkeiten verändert werden müssen.

Die Phasen unterscheiden Zielzustände der Entwicklung. Sie behaupten weder eine von Beginn an vollständig festgelegte Projektplanung noch eine vollständige Trennung aller Arbeitsschritte. Insbesondere beeinflussen die Sicherheitsanforderungen bereits den ersten Architekturentwurf. Jede Phase beschreibt deshalb neben ihrem funktionalen Ziel auch die relevanten Schnittstellen und einen Kontrollpunkt für den erreichten Stand.

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    inset: 7pt,
    align: left,
    table.header([*Phase*], [*Zielzustand*], [*Kontrollpunkt*]),
    [1], [Lokale Kernfunktionen mit lokaler Datenhaltung und begrenzter IPC-Kommunikation.], [Kernabläufe ohne Netzwerk ausführen; Änderungen nach Neustart erneut lesen.],
    [2], [Synchronisierte Aufgaben und gesonderte Online-Anbindungen.], [Lokale Speicherung, spätere Übermittlung und Verhalten bei Netzwerkausfall unterscheiden.],
    [3], [Geprüfte Härtung im festgelegten Electron-Sicherheitsrahmen.], [Anwendbarkeit, Umsetzung und Nachweis jeder Empfehlung dokumentieren.],
  ),
  caption: [Phasen und Kontrollpunkte des fallbezogenen Migrationsleitfadens.],
) <tab:migration-phases>

== Phase 1: Von der Webanwendung zur Offline-Kernanwendung

Die erste Phase überführt die persönlichen Kernfunktionen in eine lokale Desktop-Anwendung. Datenhaltung, Identitätsverwaltung, CRUD-Operationen und Dateiimporte werden innerhalb der Electron-Laufzeit ausgeführt. Synchronisierung und externe Katalogaktualisierung folgen in Phase 2. Für katalogabhängige Funktionen wird zunächst ein lokal bereitgestellter Datenbestand verwendet.

=== Initialisierung des Electron-Projekts und Übernahme der Datenbankmodule

Electron wurde im Sinne von A3 gewählt, um vorhandene Komponenten weiterzuverwenden. Das Backend des Ausgangsartefakts verwendete TypeScript und Node.js. @StudienplanerSource2026 Da der Electron-Main-Prozess ebenfalls eine Node.js-Laufzeit bereitstellt, konnten fachliche Logik und Bibliotheken als Grundlage der lokalen Umsetzung dienen. @ElectronProcessModel2026

Als Alternative wurde Tauri erwogen, dessen privilegierter Core-Prozess auf Rust basiert. @TauriProcessModel2026 Eine Portierung des Backends in diesen Core hätte neben der Sprache auch Datentypen, Fehlerbehandlung und Bibliotheksanbindungen betroffen, insbesondere den Drizzle-Datenzugriff. Tauri erlaubt allerdings auch die Einbindung einer Node.js-Anwendung als Sidecar. @TauriNodeSidecar2026 Dieser Weg hätte einen zusätzlichen auszuliefernden Prozess und dessen Kommunikation erfordert. Für Electron sprach die unmittelbare Ausführung der übernommenen Backend-Komponenten im Main-Prozess.

Das Zielprojekt wurde mit der `react-ts`-Vorlage von electron-vite initialisiert. @ElectronViteGettingStarted2026 Damit blieb die im Replit-Frontend verwendete Kombination aus React, TypeScript und Vite erhalten. @StudienplanerSource2026 Die betrachtete React-TypeScript-Anleitung von Electron Forge verwendet `webpack-typescript`; Forge bietet daneben auch Vite-Vorlagen an. @ElectronForgeReact2026 @ElectronForgeGettingStarted2026 Die Wahl von electron-vite beruhte auf der erwarteten Begrenzung der Anpassungen durch kompatible Technologien. Ein geringerer Migrationsaufwand gegenüber Tauri oder Electron Forge wurde nicht vergleichend evaluiert.

Anschließend wurden die Drizzle-Schemadefinitionen für Benutzer, Stundenpläne, Studiengänge, Gruppen, Noten, Termine und das Aktivitätsprotokoll samt Exportmodul nach `src/main/db/schema` übernommen. Die angepasste `drizzle.config.ts` liegt im Projektstamm. Für die erste Entwicklung ersetzte eine lokale SQLite-Datei die PostgreSQL-Verbindung: Der Dialekt wechselte zu `sqlite`, und `DATABASE_URL` entfiel für die lokale Datenhaltung. @StudienplanerSource2026 @StudyPlanDatabase2026

Mit dem Umgebungswechsel übernahm die Desktop-Anwendung im Main-Prozess das Anlegen, Öffnen und Migrieren der Benutzerdatenbank. Die Datei wird zur Laufzeit unter dem von Electron bereitgestellten Pfad `userData` angelegt. @ElectronAppPaths2026 Dieser liegt außerhalb des Projekt- und Installationsverzeichnisses, trennt veränderliche Daten von Programmdateien und vermeidet Schreibzugriffe auf das Installationsverzeichnis. Ein Update kann so Programmdateien ersetzen, ohne die Benutzerdatenbank auszutauschen. Ausgeliefert werden die Migrationen zur Einrichtung und Aktualisierung ihres Schemas. @StudyPlanDatabase2026

=== Anpassung der Tabellen und Datenbankabhängigkeiten an SQLite

Die Übernahme der Dateien genügte noch nicht, da die bestehenden Definitionen PostgreSQL-spezifische Datentypen und Tabellenkonstruktoren verwendeten. Diese wurden durch die entsprechenden SQLite-Konstrukte ersetzt. Die fachlichen Tabellen- und Spaltennamen sowie die vorhandenen Pflichtfelder und Standardwerte wurden dabei möglichst beibehalten. Dieser Ansatz begrenzte die Änderungen am Datenmodell und entsprach dem in @ch:analysis festgelegten Ziel, vorhandene Komponenten mit möglichst geringem Refactoring-Aufwand weiterzuverwenden.

Die Anpassung lässt sich am Stundenplanschema nachvollziehen. @lst:timetable-postgresql zeigt die ursprüngliche Definition der Tabelle `timetable_entries`; @lst:timetable-sqlite zeigt ihre Überführung in das SQLite-Schema des Demonstrators. Beide Ausschnitte lassen die übrigen Tabellen und die abgeleiteten Validierungsschemata weg; die Zeilenumbrüche wurden für die Darstellung angepasst. @StudienplanerSource2026 @StudyPlanDatabase2026

#figure(
  block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
    set text(size: 8.5pt)
    raw(read("../code/timetable-postgresql.ts"), lang: "typescript", block: true)
  }),
  kind: raw,
  supplement: [Quellcode],
  caption: [Stundenplaneinträge im PostgreSQL-Schema des Ausgangsartefakts (Ausschnitt).],
) <lst:timetable-postgresql>

#figure(
  block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
    set text(size: 8.5pt)
    raw(read("../code/timetable-sqlite.ts"), lang: "typescript", block: true)
  }),
  kind: raw,
  supplement: [Quellcode],
  caption: [Stundenplaneinträge im SQLite-Schema des Demonstrators (Ausschnitt).],
) <lst:timetable-sqlite>

An die Stelle von `pgTable` trat `sqliteTable`. Der automatisch erzeugte Primärschlüssel wurde von `serial` auf einen Integer-Primärschlüssel mit `autoIncrement` umgestellt. Das boolesche Feld `isCustom` wird in SQLite als Integer gespeichert; Drizzles Modus `boolean` erhält dabei die Verwendung boolescher Werte im TypeScript-Code. @DrizzleSQLiteTypes2026

Die PostgreSQL-Enums für Wochentage und Zeitblöcke wurden durch konstante Wertelisten und daraus abgeleitete TypeScript-Union-Typen ersetzt. Die Spalten verwenden diese Listen über die `enum`-Option des Text-Konstruktors. Diese Option unterstützt die Typableitung, erzwingt jedoch zur Laufzeit keinen zulässigen Wertebereich in der Datenbank. @DrizzleSQLiteTypes2026 Die erhaltene Typisierung ist daher nicht mit der bisherigen Datenbankprüfung gleichzusetzen; eine Prüfung eingehender Werte bleibt erforderlich. Die aus den Tabellen abgeleiteten Insert- und Select-Typen sowie die Erzeugung der Zod-Schemata konnten weiterhin nach dem vorhandenen Muster verwendet werden.

Für die benötigten Pakete wurde zunächst die Abhängigkeitskonfiguration des Ausgangsartefakts herangezogen. Die angegebenen Versionsbereiche für `drizzle-orm` (`^0.45.2`), `drizzle-kit` (`^0.31.10`) und `drizzle-zod` (`^0.8.3`) wurden übernommen. Der PostgreSQL-Treiber `pg` wurde für die lokale Datenhaltung durch `@libsql/client` ersetzt; im Demonstrator ist hierfür der Versionsbereich `^0.18.0` angegeben. @StudienplanerSource2026 @StudyPlanDatabase2026 Damit blieb Drizzle als Abstraktion für Schema und Datenzugriff erhalten, während der verwendete Treiber wechselte.

Die Verantwortlichkeiten der Pakete sind dabei zu unterscheiden: Der libSQL-Client öffnet die lokale Datenbankdatei, Drizzle ORM führt die Datenbankoperationen aus und Drizzle Kit erzeugt die SQL-Migrationsdateien. Das Anwenden dieser Dateien beim Anwendungsstart übernimmt der Migrator aus `drizzle-orm/libsql/migrator`. Die automatische Anwendung vorbereiteter Migrationen ist somit Bestandteil der eingerichteten Drizzle-Initialisierung und keine alleinige Eigenschaft des Datenbanktreibers. @StudyPlanDatabase2026

=== Versionierte Schemamigrationen und Datenbankinitialisierung

Nach der Anpassung der Tabellen wurden zwei Wege zur Einrichtung des Datenbankschemas unterschieden. Mit `drizzle-kit push` können die Schemadefinitionen unmittelbar mit einer angebundenen Datenbank abgeglichen und die Änderungen ohne gesondert gespeicherte SQL-Migrationsdateien angewandt werden. @DrizzlePush2026 Alternativ erzeugt `drizzle-kit generate` SQL-Dateien anhand der aktuellen Definitionen und der bisherigen Schema-Snapshots. Diese Dateien können anschließend durch den Drizzle-Migrator angewandt werden. @DrizzleGenerate2026

Für den Demonstrator wurde der zweite Weg gewählt. Die Migrationsdateien liegen im Verzeichnis `drizzle` und können gemeinsam mit dem Anwendungscode versioniert und ausgeliefert werden. Beim Start verarbeitet der Migrator die noch nicht angewandten Migrationen. Damit steht ein nachvollziehbarer Ablauf für spätere Schemaänderungen bereit, ohne die vorhandene Benutzerdatenbank bei jedem Update neu anzulegen. Die Verträglichkeit einer konkreten Schemaänderung mit bestehenden Daten muss dennoch anhand der jeweiligen Migration geprüft werden.

Die resultierende Konfiguration beschreibt deshalb nur den SQLite-Dialekt, den Einstiegspunkt der Schemadefinitionen und das Ausgabeverzeichnis der Migrationen. Ein Verbindungsparameter zur Entwicklungsdatenbank ist für die Generierung nicht mehr erforderlich. @DrizzleGenerate2026 Der Laufzeitpfad der Benutzerdatenbank wird separat im Main-Prozess festgelegt. @lst:drizzle-config zeigt diese Konfiguration des Demonstrators. @StudyPlanDatabase2026

#figure(
  block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
    set text(size: 8.5pt)
    raw(read("../code/drizzle-config.ts"), lang: "typescript", block: true)
  }),
  kind: raw,
  supplement: [Quellcode],
  caption: [Drizzle-Kit-Konfiguration zur Erzeugung der SQLite-Migrationen.],
) <lst:drizzle-config>

In `package.json` wurden `db:generate` für `drizzle-kit generate` und `db:check` für `drizzle-kit check` eingerichtet. Zur Laufzeit verwendet die Anwendung die erzeugten Dateien über den ORM-Migrator. @StudyPlanDatabase2026

Die Initialisierung wurde in den Startablauf des Main-Prozesses eingebunden. Innerhalb des mit `app.whenReady()` begonnenen Ablaufs in `src/main/index.ts` wird `initDatabase()` abgewartet, bevor die lokale Datenbank an Repositories und Dienste übergeben und das Anwendungsfenster geöffnet wird. Scheitert die Vorbereitung, zeigt die Anwendung eine Fehlermeldung an und beendet den Start. Die Oberfläche wird dadurch nicht mit einer unvollständig vorbereiteten Datenbank geöffnet. @StudyPlanDatabase2026

In `src/main/db/index.ts` wird der Speicherort aus `app.getPath('userData')` und dem Unterverzeichnis `data` gebildet. Die paketierte Anwendung verwendet `studyplan.db`, die Entwicklung `studyplan-dev.db`. Unter Windows ergibt sich beispielsweise `%APPDATA%\studyplan\data\studyplan.db` innerhalb von `AppData\Roaming`. Der Unterordner wird vor dem Öffnen der Datei angelegt. @StudyPlanDatabase2026

Danach öffnet der libSQL-Client die Datei über eine lokale `file:`-URL. Die Initialisierung setzt ausdrücklich `PRAGMA foreign_keys = ON` und `PRAGMA journal_mode = WAL`. Die erste Einstellung aktiviert die Prüfung der im Schema tatsächlich definierten Fremdschlüsselbedingungen; sie ergänzt selbst keine solchen Bedingungen. Die zweite wählt den Write-Ahead-Logging-Modus für die Datenbank. @SQLitePragma2026 Anschließend werden die ausstehenden Migrationen angewandt und die Verbindung mit einer einfachen Abfrage geprüft. Die konkrete Implementierung legt außerdem die SQLite-kompatible Migrationstabelle `__drizzle_migrations` vor dem Aufruf des Migrators an. @StudyPlanDatabase2026

Damit die Migrationen auch in der installierten Anwendung verfügbar sind, wurde das Verzeichnis `drizzle` in `electron-builder.yml` unter `extraResources` aufgenommen. @lst:migration-resources zeigt diesen Eintrag. In der Entwicklung liest die Anwendung die Dateien aus dem Projektverzeichnis; im paketierten Zustand verwendet sie `process.resourcesPath` und den dort enthaltenen Unterordner `drizzle`. @StudyPlanDatabase2026

#figure(
  block(width: 100%, inset: 8pt, fill: luma(246), radius: 2pt, {
    set text(size: 8.5pt)
    raw(read("../code/migration-resources.yml"), lang: "yaml", block: true)
  }),
  kind: raw,
  supplement: [Quellcode],
  caption: [Auslieferung der Migrationsdateien über zusätzliche Paketressourcen (Ausschnitt).],
) <lst:migration-resources>

Für Funktionen mit Referenzdaten wurden außerdem Studiengänge, Lehrveranstaltungen und Stundenplanvorlagen über die Datenmigrationen `0001_seed-study-programs.sql` und `0002_seed-timetable-presets.sql` bereitgestellt. Sie werden beim Einrichten der Datenbank lokal eingefügt und stehen damit auch vor dem in Phase 2 ergänzten Katalogabruf zur Verfügung. Dies ist für die Offline-Nutzung entscheidend: Ein lokal ausführbarer Handler kann nur auf den tatsächlich vorhandenen Datenbestand zugreifen. @StudyPlanDatabase2026

=== Übernahme des API-Vertrags und Anpassung der Codegenerierung <sec:api-contract-migration>

Die Schnittstellenmigration ging vom OpenAPI-Vertrag unter `lib/api-spec/openapi.yaml` aus, der nach `api/openapi.yaml` übernommen wurde. Seine Operationskennungen, Parameter und Datenschemata dienten bereits im Web-Prototyp zur Erzeugung von Aufrufhilfen und Zod-Schemata. @StudienplanerSource2026

Im Ausgangsartefakt verwendete Orval dafür `orval.config.ts`. Im Desktop-Projekt übernehmen eigene TypeScript-Skripte unter `scripts/openapi-ipc` die Generierung. Ihre Konfiguration `api/ipc-generator.config.ts` legt den Eingabevertrag und die Ausgabepfade fest. Das Prinzip der gemeinsamen Vertragsgrundlage bleibt damit erhalten, während die Umsetzung auf IPC ausgerichtet wird. @StudyPlanApiMigration2026

Der Generator liest den Vertrag mit `yaml` und erzeugt TypeScript-Typen, Zod-Laufzeitschemata, die Zuordnungstabelle `operationContracts` sowie einen transportunabhängigen API-Client unter `src/shared/api/generated`. React-Query-Hooks liegen unter `src/renderer/src/api/generated`. Der Main-Prozess verwendet die gemeinsamen Schemata zur Validierung. @StudyPlanApiMigration2026

`api:generate` erzeugt die Module; `api:check` prüft ihre Übereinstimmung mit der Generatorausgabe. Der YAML-Vertrag wird während der Entwicklung eingelesen. Zur Laufzeit werden die erzeugten Module verwendet. Die fachliche Implementierung und ihre Handler-Registrierung bleiben gesonderte Aufgaben. @StudyPlanApiMigration2026

Während der Oberflächenintegration wurde `generator-lib.ts` im Commit `f03ab7f` um React-Query-Hooks und das Exportmodul `src/renderer/src/api/index.ts` erweitert. Die Aufrufformen orientieren sich am Web-Client: Queries erhalten Pfad- und Query-Parameter, Mutationen ein Variablenobjekt mit `data` für den bisherigen Request-Body. Auch Hilfsfunktionen für Query Keys werden erzeugt. Diese Orientierung ermöglicht die Weiterverwendung vorhandener Aufrufmuster. @StudyPlanFrontendMigration2026 @StudyPlanApiMigration2026

Zunächst stellte Preload den vollständigen API-Client bereit. Im Authentifizierungscommit `1c1988d` wurde seine Erzeugung in den Renderer verlagert: Die Hooks verwenden dort `createApiClient` mit `window.apiTransport.invoke`. Preload vermittelt den Transport; der Client verarbeitet Ergebnisse und rekonstruiert Fehler als `ApiClientError`. @StudyPlanLocalAuth2026

=== IPC-Transport, Preload-Schnittstelle und Dispatcher

Der API-Client ersetzt HTTP-Methode, URL und `customFetch` durch eine Funktion vom Typ `ApiTransport`. Diese übermittelt `operationId` und typisierte Eingabedaten über Preload. Die übernommenen Gruppen `path`, `query` und `body` bezeichnen nun Felder des IPC-Eingabeobjekts. Die Schnittstelle folgt dem Prinzip eines Remote Procedure Call (RPC): Der Renderer ruft eine benannte Operation im Main-Prozess auf und erhält deren Ergebnis. Electron-IPC bildet dafür den lokalen Transport zwischen den Prozessen. @StudienplanerSource2026 @StudyPlanApiMigration2026

In `src/preload/index.ts` sendet `apiTransport.invoke` die Operationskennung, Eingaben und eine `requestId` über `ipcRenderer.invoke` auf dem festen Kanal `api:invoke`. `contextBridge.exposeInMainWorld` stellt dem Renderer `window.apiTransport` bereit; `ipcMain.handle` nimmt den Aufruf im Main-Prozess entgegen. Dies entspricht dem von Electron dokumentierten Aufrufmuster mit Rückgabewert. @ElectronIpc2026 @StudyPlanApiMigration2026

`src/preload/index.d.ts` erweitert `Window` für die Typprüfung; das Laufzeitobjekt stellt Preload bereit. Der Renderer erhält die begrenzte Transportmethode statt frei wählbarer IPC-Kanäle oder des vollständigen `ipcRenderer`-Objekts. Diese Begrenzung entspricht der Electron-Empfehlung für die Bridge. @ElectronContextBridge2026

Der Dispatcher in `src/main/ipc/api-dispatcher.ts` prüft Absender und Anfrageform und ordnet die `operationId` einem Vertrag sowie einem registrierten Handler zu. Das generierte Zod-Schema validiert die Eingaben. Unbekannte Operationen und ungültige Daten werden abgewiesen. @StudyPlanApiMigration2026

Nach der Handler-Ausführung validiert der Dispatcher auch Rückgabewerte und ausdrücklich deklarierte Fehlerantworten. Ein erfolgreiches `ApiResult` enthält `ok: true`, Daten und Anfragekennung; ein Fehler enthält `ok: false` und ein Fehlerobjekt. Der API-Client entnimmt die Daten beziehungsweise erzeugt `ApiClientError`. @StudyPlanApiMigration2026

Bei einer bekannten, aber nicht registrierten Operation liefert der Dispatcher `NOT_IMPLEMENTED`. Generierte Hooks allein stellen somit keine ausführbare Funktion bereit. Fachlogik, Sitzungszuordnung und Berechtigungen werden in Handlern und Services umgesetzt; die konsolidierte Härtungsprüfung folgt in Phase 3. @StudyPlanApiMigration2026

=== Begründung und Grenzen der vertragsbasierten Generierung

Alternativ hätten die von Orval erzeugten Hooks, Typen und Zod-Schemata manuell angepasst werden können. Der eigene Generator wäre entfallen, Änderungen hätten jedoch in mehreren abhängigen Modulen abgestimmt werden müssen. Für den erweiterbaren Demonstrator wurde deshalb die zentrale Vertragsgrundlage beibehalten und ihre Übersetzung nach IPC automatisiert.

Für Erweiterungen wird der Vertrag an einer Stelle ergänzt und die Änderung durch erneute Generierung in Typen, Client, Hooks und Laufzeitschemata übertragen. Anschließend werden Handler, Fachlogik und Oberflächenabläufe implementiert. Dieses Vorgehen unterstützt die Wiederverwendung nach A3 und das Erweiterungsmuster nach A8 und A9. Der anfängliche Entwicklungs- und spätere Pflegeaufwand des Generators bleibt zu berücksichtigen; eine quantitative Aufwandsersparnis wurde nicht nachgewiesen. @StudyPlanApiMigration2026

Die gemeinsame Vertragsbindung definiert die Schnittstelle zwischen Renderer und Main-Prozess. Die fachliche Implementierung bleibt hinter dieser Grenze im Main-Prozess. Damit können Schnittstellenverarbeitung, Fachlogik und Datenzugriff getrennt geprüft werden, wie A2 verlangt.

@fig:api-interface-migration stellt den ursprünglichen Aufrufweg demjenigen der lokalen Electron-Kernanwendung gegenüber. In beiden Fällen bildet ein gemeinsamer Vertrag die Grundlage für Client und Validierung. Die wesentliche Änderung liegt in der Umsetzung dieses Vertrags zur Laufzeit: HTTP-Aufrufe an einen Express-Server werden durch begrenzte Aufrufe über Preload und IPC ersetzt. Die eingezeichnete Trennung in Handler, Services und Repositories zeigt die resultierende Desktop-Architektur; ihre fachliche Ausarbeitung ist ein weiterer Migrationsschritt. @StudienplanerSource2026 @StudyPlanApiMigration2026

#figure(
  image("../figures/api-interface-migration.svg", width: 100%),
  placement: top,
  caption: [Vertragsbasierte Codegenerierung und Aufrufwege im Web-Prototyp und in der lokalen Electron-Kernanwendung. Gestrichelte Pfeile zeigen Generierung oder Einbindung, durchgezogene Pfeile Laufzeitkommunikation. Spätere Synchronisierungs- und Online-Pfade sind nicht dargestellt.],
) <fig:api-interface-migration>

Die Umsetzung der gemeinsamen Vertragsgrundlage im Web-Prototyp und in der Electron-Kernanwendung wird in @tab:api-interface-changes gegenübergestellt.

#figure(
  {
    set par(justify: false)
    table(
      columns: (1fr, 2fr, 2fr),
      inset: 6pt,
      align: left,
      table.header([*Aspekt*], [*Web-Prototyp*], [*Electron-Kernanwendung*]),
      [Vertragsgrundlage], [OpenAPI mit Operationskennungen und Datenschemata.], [Bestehende Definitionen übernommen und gezielt ergänzt.],
      [Generierung], [Orval für React Query und Zod.], [Projektspezifische TypeScript-Generatoren für Client, Hooks und gemeinsame Zod-Verträge.],
      [Aufrufweg], [HTTP-Methode und URL über `customFetch`.], [`operationId` und Eingabeobjekt über Preload und den Kanal `api:invoke`.],
      [Parameter], [Pfad, Query-String und HTTP-Body.], [Strukturierte Eingabe mit `path`, `query` und `body`.],
      [Ergebnis], [HTTP-Antwort beziehungsweise HTTP-Fehler.], [Geprüftes `ApiResult`; Fehler werden als `ApiClientError` weitergegeben.],
      [Datumswerte], [Strings im generierten Client; Datumsprüfung in Zod-Schemata.], [`Date`-Werte und `z.date()` in den gemeinsamen Modulen.],
      [Zugriffsgrenze], [Serverseitige HTTP-Verarbeitung und Sitzungszuordnung.], [Begrenzte Bridge, Absender- und Schemaprüfung sowie fachliche Sitzungsprüfung.],
    )
  },
  caption: [Wiederverwendete Vertragsgrundlage und Änderungen an ihrer Umsetzung.],
) <tab:api-interface-changes>

OpenAPI beschreibt standardmäßig HTTP-APIs. @OpenApi310 Die IPC-Nutzung übersetzt ausgewählte Vertragsbestandteile projektspezifisch: Methoden und Pfade bleiben Metadaten, die Weiterleitung verwendet die Operationskennung. Der Generator unterstützt die benötigten Schemakonstrukte und lokale Referenzen, weist jedoch beispielsweise rekursive Komponentenschemata zurück. Er bildet damit den verwendeten Vertragsumfang ab, ohne vollständige OpenAPI-Kompatibilität zu beanspruchen. @StudyPlanApiMigration2026

=== Übernahme der React-Oberfläche in den Renderer <sec:frontend-migration>

Die React-Oberfläche aus `artifacts/studienplaner/` wurde im Commit `f4ea658` nach `src/renderer/src/` übernommen. Dazu gehören Layout, UI-Komponenten, Hilfsmodule unter `hooks/` und `lib/` sowie die Seiten für Dashboard, Kalender, Noten und Stundenplan. @StudyPlanFrontendMigration2026

`App.tsx` und `main.tsx` behielten die Einbindung von React Query über `QueryClientProvider` sowie die Anbieter für Tooltips und Benachrichtigungen bei. Die Darstellungsstruktur konnte weitgehend weiterverwendet werden; anzupassen waren insbesondere Modulauflösung, Datenzugriffe und Navigation. @StudienplanerSource2026 @StudyPlanFrontendMigration2026

Die übernommene `index.css` enthält Theme-Variablen und die Einbindung von Tailwind CSS, `tw-animate-css` und dem Typografie-Plugin. Die Vorlagendateien `assets/main.css` und `assets/base.css` wurden samt Beispielkomponenten und Grafiken entfernt. Der zunächst ebenfalls kopierte Google-Fonts-Import wurde im Commit `36ff5f9` entfernt; die vorhandenen Schriftstapel enthalten lokale Systemschrift-Fallbacks. Damit wird für die Darstellung kein externer Schriftabruf vorausgesetzt. @StudyPlanFrontendMigration2026

Mitkopierte Paket- und Konfigurationsdateien wurden nach dem Abgleich mit der Electron-Struktur im Commit `8b9bd66` entfernt: `package.json`, `vite.config.ts`, `tsconfig.json`, `components.json` und die zusätzliche `index.html`. Der Renderer verwendet `src/renderer/index.html` und die Paket- und Build-Konfiguration des Zielprojekts. @StudyPlanFrontendMigration2026

Die Replit-Plugins, `PORT`, `BASE_PATH` sowie Webserver- und Ausgabeeinstellungen der ursprünglichen Vite-Konfiguration wurden nicht übernommen. @StudienplanerSource2026 electron-vite verwaltet Main, Preload und Renderer in einer gemeinsamen Konfiguration; für den Renderer verwendet es standardmäßig `src/renderer` und die dortige `index.html`. @ElectronViteConfig2026

Im Commit `ceccf8f` wurde der Alias `@` in `electron.vite.config.ts` unter `renderer.resolve.alias` auf `src/renderer/src` gesetzt. `tsconfig.web.json` erhielt die entsprechende Zuordnung für `@/*`; `@renderer` blieb erhalten. So konnten Imports wie `@/components/ui/badge` weiterverwendet werden. @StudyPlanFrontendMigration2026 Vite benötigt die Zuordnung für den Build, TypeScript für die Modul- und Typprüfung. TypeScript-`paths` allein schreibt die ausgegebenen Importpfade nicht um. @TypeScriptPaths2026

Für die Styles wurde `@tailwindcss/vite` mit `tailwindcss()` neben `react()` registriert, entsprechend dem dokumentierten Tailwind-Integrationsweg. @TailwindVite2026 Diese Anpassung und die Vite-Typreferenz in `src/renderer/src/env.d.ts` gehören zur Oberflächenintegration im Commit `f03ab7f`; dessen Generatoränderungen wurden bereits in @sec:api-contract-migration behandelt. @StudyPlanFrontendMigration2026

Die Paketdefinition wurde anhand des Ausgangsartefakts um Radix UI, `clsx`, `class-variance-authority`, `tailwind-merge`, React Hook Form samt Resolver, React Query, `date-fns`, Lucide und Wouter ergänzt. Die shadcn/ui-Komponenten wurden als Quelldateien übernommen. Die Abhängigkeitsauflösung entstand im Zielprojekt neu: Das Ausgangsartefakt verwendet `pnpm-lock.yaml`, das Electron-Projekt `package-lock.json`. @StudienplanerSource2026 @StudyPlanFrontendMigration2026

=== Anbindung der Seiten, Datumswerte und Navigation

Die bisherigen Imports aus `@workspace/api-client-react` wurden in den Seiten und im Layout durch Imports aus `@/api` ersetzt. Dieses Modul exportiert die für IPC erzeugten Hooks und zugehörigen Typen. Die Generatoranpassungen aus @sec:api-contract-migration ermöglichten, vorhandene Hook-Namen und typische Aufrufmuster beizubehalten. Beispielsweise blieb die Verwendung von `useListEvents(monthParams)` beziehungsweise einer Mutation mit `{ data: ... }` erhalten. Die Änderung des Imports allein genügte allerdings dort nicht, wo sich die Datendarstellung an der Schnittstelle änderte. @StudyPlanFrontendMigration2026

Im Commit `ce275e4` wurde beispielsweise in `pages/kalender.tsx` die Verarbeitung von Datumsstrings an die generierten `Date`-Typen angepasst. `eventsForDay` verwendet `new Date(e.startDate)` anstelle von `parseISO`; für das Enddatum gilt dieselbe Anpassung. Formulareingaben werden in `Date`-Werte umgewandelt und Abfragegrenzen als solche übergeben. Vorhandene Werte können direkt formatiert oder über `getTime()` sortiert werden. Das Dashboard wurde entsprechend angepasst. @StudyPlanFrontendMigration2026

Ungenutzte Imports, Variablen und Zustandseinträge wurden ebenfalls entfernt. Die geerbte Electron-Toolkit-Konfiguration aktiviert `noUnusedLocals` und `noUnusedParameters`; das Ausgangsartefakt setzte `noUnusedLocals` auf `false`. @StudienplanerSource2026 @StudyPlanFrontendMigration2026 Die Bereinigung war daher auch für die Typprüfung erforderlich, da TypeScript ungenutzte lokale Deklarationen bei aktivierter Prüfung als Fehler meldet. @TypeScriptUnused2026

Die direkten HTTP-Dateiimporte der kopierten Kalender- und Notenseiten wurden im nachfolgend beschriebenen Importschritt durch lokale Operationen ersetzt. @StudienplanerSource2026 @StudyPlanFrontendMigration2026

Für die Navigation wurde das bereits verwendete Paket `wouter` beibehalten. Im Web-Prototyp erhielt dessen Router den aus `import.meta.env.BASE_URL` abgeleiteten Basispfad. Im Authentifizierungscommit `1c1988d` wurde stattdessen `useHashLocation` aus `wouter/use-hash-location` eingebunden und mit `<WouterRouter hook={useHashLocation}>` aktiviert. @StudyPlanFrontendMigration2026 Der Hook verwendet den Teil der Adresse hinter `#` als Anwendungsroute. @WouterHashRouting2026 Eine Seite wie `/kalender` kann dadurch innerhalb der geladenen Renderer-Ressource als `#/kalender` adressiert werden. Der Pfad der lokalen HTML-Datei bleibt bestehen, während Wouter die Seitenauswahl übernimmt. Die vorhandenen React-Routen und Navigationskomponenten konnten auf dieser Grundlage weiterverwendet werden. @StudyPlanFrontendMigration2026

=== Lokale Authentifizierung als erster vollständiger Verarbeitungspfad

Nach der Übernahme der Oberfläche begrenzte der vorhandene Anmeldeablauf zunächst den Zugang zu den fachlichen Seiten. Das Layout ruft `useGetMe` auf und setzt einen zugeordneten Benutzer voraus. Für die weitere Entwicklung wurde die Anmeldung deshalb beibehalten und als erste Handlergruppe implementiert. Damit konnte der bereits vorbereitete Aufrufweg zwischen Oberfläche, Preload, Dispatcher und lokaler Datenhaltung an einem zusammenhängenden Ablauf genutzt werden. Dieser Schritt ist im Commit `1c1988d` dokumentiert. @StudyPlanLocalAuth2026

`auth.handlers.ts` ordnet `register`, `login`, `logout` und `getMe` den Service-Aufrufen zu und übersetzt deklarierte Fehler. `AuthService` übernimmt Registrierung, Passwortprüfung und Benutzerzuordnung; `UsersRepository` führt die Drizzle-Abfragen aus. Nach der Datenbankinitialisierung werden die Module erzeugt und die Handler registriert. Damit ist die in A2 geforderte Trennung erstmals für eine vollständige Operationsgruppe umgesetzt. @StudyPlanLocalAuth2026

Für das Hashen und Vergleichen der Passwörter wurde das bereits im Web-Backend verwendete Paket `bcryptjs` mit dem dort angegebenen Versionsbereich `^3.0.3` übernommen. Passwort-Hashes bleiben im Main-Prozess und in der lokalen Benutzertabelle; die Oberfläche erhält nur die vorgesehenen Benutzerdaten. An die Stelle der HTTP-Sitzung tritt `SessionService`, der die aktuelle Benutzerkennung im Main-Prozess hält. Diese lokale Sitzung liegt im Arbeitsspeicher und endet beim Beenden der Anwendung; die Benutzerdatensätze bleiben dagegen in der SQLite-Datenbank gespeichert. Die lokale Anmeldung ist von der später ergänzten Authentifizierung gegenüber entfernten Kollaborationsdiensten zu unterscheiden. @StudienplanerSource2026 @StudyPlanLocalAuth2026

Bei erfolgreicher Anmeldung oder Registrierung leert der Renderer den bisherigen React-Query-Cache, speichert die Benutzerinformation unter dem Query Key von `getMe` und navigiert zur Anwendung. `UNAUTHENTICATED` führt zur Anmeldung und wird von der Query-Wiederholungslogik berücksichtigt. Andere Ladefehler erhalten eine Anzeige mit erneuter Abfragemöglichkeit. Die Weiterleitung bei bestehender Anmeldung erfolgt über einen React-Effekt. @StudyPlanLocalAuth2026

=== Integration der CRUD-Funktionen am Beispiel der Notenverwaltung <sec:crud-migration>

Nach der Oberflächenintegration und der lokalen Authentifizierung wurden die weiteren fachlichen Funktionen mit dem vorbereiteten Aufrufweg verbunden. Die Migration der CRUD-Operationen wird exemplarisch an der Notenverwaltung beschrieben. Anlegen, Lesen, Bearbeiten und Löschen folgen in den persönlichen Anwendungsbereichen einer wiederkehrenden Grundstruktur; eine separate Beschreibung jeder Variante würde überwiegend dieselben Transformationsschritte wiederholen. Die Notenverwaltung wurde im Commit `f97642b` integriert, zunächst ohne CSV-Import. Als fachliche Vorlage dienten die ursprünglichen Routen aus `artifacts/api-server/src/routes/grades.ts`. @StudienplanerSource2026 @StudyPlanGradesMigration2026

Die Übertragung bestand darin, die innerhalb der Route verbundenen Aufgaben nach ihren Verantwortlichkeiten aufzuteilen. HTTP-spezifische Zugriffe auf `req` und `res` entfielen. Die Eingabeprüfung wurde durch die bereits eingerichtete Vertragsvalidierung des Dispatchers übernommen. Die Verarbeitung der Operationen und ihrer Fehler wurde den Handlern zugeordnet, die fachlichen Regeln dem Service und die Drizzle-Abfragen dem Repository. @tab:grade-responsibilities zeigt diese Zuordnung am untersuchten Beispiel. @StudyPlanGradesMigration2026

#figure(
  {
    set par(justify: false)
    table(
      columns: (1fr, 1.3fr, 2.2fr),
      inset: 6pt,
      align: left,
      table.header([*Schicht*], [*Zielmodul*], [*Aufgabe im Notenbeispiel*]),
      [Schnittstelle], [`grades.handlers.ts`], [Operationszuordnung, Übernahme der Sitzungskennung und Übersetzung fachlicher Fehler.],
      [Fachlogik], [`GradesService`], [Anlegen und Ändern fachlicher Werte, Notenstatistik und Veranlassung von Aktivitätseinträgen.],
      [Datenzugriff], [`GradesRepository`], [Lesen und Schreiben der Notendatensätze über Drizzle mit benutzerbezogenen Auswahlbedingungen.],
    )
  },
  caption: [Aufteilung der ursprünglichen Notenrouten auf Handler, Service und Repository.],
) <tab:grade-responsibilities>

Die Module wurden in `src/main/index.ts` in den Startablauf eingebunden. Nach der Datenbankinitialisierung werden `GradesRepository` und `ActivityLogRepository` mit der Datenbankverbindung erzeugt. Beide werden an `GradesService` übergeben. `createGradesHandlers` verbindet anschließend die Service-Aufrufe mit den vorgesehenen Operationskennungen und der bereits vorhandenen `SessionService`-Instanz. Die resultierenden Handler werden in die gemeinsame Registry aufgenommen, die der IPC-Dispatcher verwendet. Die fachliche Implementierung wird damit an die zuvor erzeugten Schnittstellen angeschlossen. @StudyPlanGradesMigration2026

Die Benutzerkennung stammt bei diesen Operationen aus der lokalen Sitzung im Main-Prozess. Der gemeinsame Wrapper `authenticated` stellt sie dem Handler bereit. Im Repository werden Änderungen und Löschungen anhand der Datensatzkennung und der Benutzerkennung eingeschränkt. Findet eine solche Operation keinen passenden Datensatz, meldet der Service einen fachlichen Fehler, den der Handler in `NOT_FOUND` überführt. Damit bleibt die persönliche Datenzuordnung Bestandteil des vollständigen Verarbeitungspfads. @StudyPlanGradesMigration2026

Die vorhandenen fachlichen Regeln wurden als Ausgangspunkt beibehalten. Dazu gehören optionale Werte, die Erfassung von Aktivitäten, der ECTS-gewichtete Notendurchschnitt und die Auswertung nach Semester. Anpassungen ergaben sich aus der lokalen Datenrepräsentation: Note und ECTS werden im SQLite-Schema als numerische Werte verarbeitet, sodass die bisher für PostgreSQL verwendete Umwandlung in Strings beziehungsweise deren Rückkonvertierung entfallen konnte. Die Migration übernahm somit die fachlichen Berechnungen und gliederte ihre Ausführung neu. @StudienplanerSource2026 @StudyPlanGradesMigration2026

Für die integrierten CRUD-Funktionen ergibt sich der Aufrufweg *Formular → Hook → Preload/IPC → Dispatcher → Handler → Service → Repository → SQLite*. Bei der Notenerfassung übermittelt die vorhandene Seite beispielsweise die Formulardaten über `useCreateGrade` beziehungsweise `useUpdateGrade`. Der generierte Hook bildet die Eingabe auf den IPC-Vertrag ab. Nach Prüfung und Ausführung gelangt das Ergebnis über den Dispatcher und den API-Client zurück zum Hook. Die Oberfläche aktualisiert anschließend die Abfragen für Notenliste und Statistik. @StudyPlanGradesMigration2026

Diese Grundstruktur kann für weitere CRUD-Bereiche erneut angewandt werden. Dabei sind jeweils die zugehörigen Vertragsdefinitionen, fachlichen Regeln, Datenzugriffe und Berechtigungen zu berücksichtigen. Die Wiederholung betrifft die Verteilung der Verantwortlichkeiten und den Kommunikationsweg; die Berechtigungsregeln gemeinsamer Gruppenressourcen sind gesondert von der persönlichen Datenzuordnung zu prüfen. Die Struktur konkretisiert damit A2 und das in A8 geforderte Erweiterungsmuster.

`scripts/grades/grades.test.ts` verbindet den generierten Client mit Dispatcher, Handlern, Service, Repositories und einer SQLite-Datenbank im Arbeitsspeicher. Geprüft werden Sitzung, persönliche Datenzuordnung, Änderungen, Aktivitäten und Statistik. Der direkte Dispatcher-Aufruf ersetzt die native IPC-Kommunikation. Der Test prüft damit die Fachlogik samt Datenzugriff; Oberfläche und Electron-Laufzeit werden gesondert bewertet. @StudyPlanGradesMigration2026

=== Lokaler Dateiimport am Beispiel iCal <sec:file-import-migration>

Das Importmuster wird am iCal-Import aus Commit `fe08220` beschrieben. Im Web-Prototyp übermittelte die Kalenderseite die gewählte Datei als `FormData` mit `fetch` an `/api/events/import-ical`. Multer nahm den Upload entgegen; der Route-Handler interpretierte die Kalenderdaten und schrieb die Termine in die Datenbank. @StudienplanerSource2026 @StudyPlanIcalMigration2026

In der Desktop-Anwendung wurde diese Upload-Verarbeitung in eine lokale Importoperation überführt. Hierfür wurde der OpenAPI-Vertrag um `importEventsIcal` und das Ergebnisschema `EventIcalImportResult` ergänzt. Anschließend wurden Client, Hook und Validierungsschemata neu erzeugt. Die Operation besitzt keine Dateipfad- oder Inhaltsparameter: Der Renderer löst über `useImportEventsIcal` die Auswahl aus, während der Main-Prozess die Datei ermittelt und verarbeitet. Damit wird die in @sec:api-contract-migration beschriebene zentrale Vertragspflege an einer zusätzlichen Schnittstelle angewandt. @StudyPlanIcalMigration2026

Die Dateiauswahl übernimmt `NativeIcalFilePicker` im Main-Prozess. Er verwendet `dialog.showOpenDialog` mit einem Filter für ICS-Dateien und bindet den Dialog, sofern verfügbar, an das aus dem IPC-Absender ermittelte Anwendungsfenster. @StudyPlanIcalMigration2026 Electron liefert aus diesem Dialog die ausgewählten Pfade beziehungsweise einen Abbruchzustand zurück. @ElectronDialog2026 Der Pfad bleibt innerhalb der nativen Auswahl und wird nicht vom Renderer als frei wählbares Argument übergeben. Die Implementierung prüft die Endung `.ics`, den regulären Dateityp und eine Größenobergrenze von 10 MiB vor sowie nach dem Einlesen. Anschließend stellt sie den Inhalt als UTF-8-Text für die Verarbeitung bereit. @StudyPlanIcalMigration2026

Die Interpretation der Kalenderdaten wurde in `src/main/services/events-ical.parser.ts` ausgelagert. Das Modul verwendet weiterhin `node-ical`, prüft die grundlegende Kalenderstruktur und bildet verwertbare `VEVENT`-Einträge auf interne Termindaten ab. Fehlende Titel oder ungültige Datumswerte führen zum Überspringen der betreffenden Einträge; diese werden gezählt. Aus der ursprünglichen Verarbeitung wurden unter anderem die Ableitung des Termintyps aus dem Titel und eine Standarddauer bei fehlendem Enddatum übernommen. Der Parser erzeugt die Termindaten ohne Benutzerkennung und ohne Datenbankzugriff. @StudienplanerSource2026 @StudyPlanIcalMigration2026

`EventsService.importEventsIcal` übernimmt die fachliche Verarbeitung der Parserausgabe. Der Service ergänzt die aus der Sitzung stammende Benutzerkennung, übergibt die Datensätze an `EventsRepository.createManyEvents` und veranlasst den Aktivitätseintrag zum Import. Dateiauswahl, Formatinterpretation, fachliche Zuordnung und Datenzugriff erhalten dadurch getrennte Zuständigkeiten. Beim Start wird der native Picker als Abhängigkeit an `createEventsHandlers` übergeben. Die Schnittstelle `IcalFilePicker` ermöglicht zugleich, die Dateiauswahl in Tests durch eine geeignete Implementierung zu ersetzen. @StudyPlanIcalMigration2026

Für den Import wurde eine ausdrückliche Ergebnisbehandlung eingerichtet. Ein erfolgreicher Import liefert `status: imported` sowie `importedCount` und `skippedCount`. Ein abgebrochener Dateidialog liefert `status: cancelled` mit beiden Zählwerten `0` und verändert den Datenbestand nicht. Ungültige Dateiauswahl oder Kalenderinhalte werden im Handler über die vorgesehenen Fehlerklassen in `VALIDATION_ERROR` und die deklarierte Fehlerantwort überführt. Diese Ergebnisse durchlaufen denselben Dispatcher und API-Client wie die CRUD-Operationen. @StudyPlanIcalMigration2026

In der Kalenderseite ersetzt der generierte Mutation-Hook den direkten HTTP-Aufruf und das HTML-Dateifeld. Während der Operation wird der Importknopf über `isPending` deaktiviert. Nach einem erfolgreichen Import wird die Terminanfrage invalidiert; die Oberfläche zeigt die Anzahl importierter und gegebenenfalls übersprungener Einträge an. Ein Abbruch beendet den Ablauf ohne Erfolgsmeldung, während ein Fehler gesondert angezeigt wird. Die ursprüngliche Upload-Oberfläche wird damit zu einem Auslöser für die im Main-Prozess ausgeführte lokale Importfunktion. @StudyPlanIcalMigration2026

Die Termintests prüfen Parserfälle, Benutzerzuordnung, Aktivitätseintrag, Abbruch und ungültige Kalenderinhalte. Ein ersetzter `IcalFilePicker` liefert vorgegebene Inhalte oder einen Abbruchzustand. So werden Handler, Parser, Service und Repository unabhängig vom Dateidialog geprüft. Native Dialoginteraktion und die Prüfungen beim Lesen realer Dateien benötigen einen gesonderten Nachweis. @StudyPlanIcalMigration2026

Der CSV-Notenimport aus Commit `d37f1b5` verwendet dieselbe Aufteilung in nativen Dateipicker, Import-Handler, Service und Repository. Die Formatverarbeitung übernimmt hier der eigene Parser `grades-csv.parser.ts`, der Spalten erkennt und unter anderem Trennzeichen, zitierte Felder und Dezimalkommas verarbeitet. Die Vertragsoperation `importGradesCsv` und der erzeugte Hook liefern entsprechend den Import- oder Abbruchstatus sowie Zählwerte. CSV zeigt damit, dass das beschriebene Importmuster sowohl eine eingebundene Parserbibliothek als auch einen eigenen Parser aufnehmen kann. @StudyPlanCsvMigration2026

=== Abschluss der Offline-Kernanwendung und Übergang zu Phase 2

Mit der lokalen Datenhaltung, der übernommenen Oberfläche, den generierten Aufrufhilfen und den implementierten Verarbeitungspfaden ist die erste Migrationsphase abgeschlossen. Die persönlichen Kernfunktionen werden innerhalb der Desktop-Anwendung ausgeführt: Lokale Anmeldung, Dashboard, Kalender, Noten und Stundenplan greifen über registrierte Handler, Services und Repositories auf SQLite zu; Dateiimporte werden im Main-Prozess verarbeitet. Die für Studiengänge und Stundenplanvorlagen benötigten Ausgangsdaten werden mit den Migrationen bereitgestellt. Für diese Abläufe wird kein Web-Backend benötigt. @StudyPlanLocalCore2026

Der Kontrollpunkt umfasst den Start der gebauten Anwendung ohne Netzwerk, die Kernabläufe und die Persistenz nach einem Neustart (A1 und A5). Schichtentrennung (A2) und lokale Kommunikation (A4) werden anhand ihrer Umsetzung geprüft. Die Fachlogiktests ergänzen diesen Nachweis; Laufzeit und Persistenz sind in @ch:experiments gesondert zu bewerten. Wiederverwendung und Erweiterungsmuster unterstützen die Bewertung von A3 und A8.

Phase 2 baut auf dieser lokalen Kernanwendung auf. Sie ergänzt die Synchronisierung gemeinsamer Aufgaben sowie den Abruf externer Katalogdaten. Damit werden zusätzliche Kommunikationspfade eingeführt, während die persönlichen Daten und ihre Verarbeitung lokal bleiben.

== Phase 2: Netzwerkanbindungen und Local-First-Synchronisierung

Die zweite Phase ergänzt gezielt Funktionen, die eine Verbindung zu entfernten Diensten benötigen. Die lokale Kernanwendung bleibt dabei die Grundlage. Local-First bedeutet für den hier untersuchten Aufgabenbereich, dass eine Änderung zunächst lokal verarbeitet werden kann und ihre Übermittlung als nachgelagerter Vorgang erfolgt. Die Phase verfolgt keinen Anspruch auf vollständige Umsetzung sämtlicher Local-First-Eigenschaften.

=== Auswahlkriterien und betrachtete Synchronisierungslösungen <sec:sync-tool-selection>

Die Toolauswahl knüpfte an A3 an: Die in Phase 1 eingerichtete Schichtentrennung, TypeScript und Drizzle sollten möglichst weitgehend weiterverwendet werden. Zugleich verlangte A6 die Synchronisierung gemeinsamer Aufgaben nach lokaler Verarbeitung. Eine Eigenentwicklung hätte zusätzlich Verfahren für ausstehende Änderungen, Wiederholungen nach Verbindungsunterbrechungen, den Abgleich der Datenbestände und Konfliktbehandlung erfordert. Um den Umfang der Arbeit auf die Migration und ihre Muster zu begrenzen, wurde deshalb nach einer vorhandenen Synchronisierungslösung gesucht.

Für die Vorauswahl waren insbesondere lokale SQLite-Verarbeitung, eine Drizzle-Anbindung, die Ausführung im Electron-Main-Prozess und die Anbindung eines entfernten Backends relevant. In die engere Auswahl kamen PowerSync und Turso. PowerSync stellt mit `@powersync/drizzle-driver` eine Anbindung für typisierte Drizzle-Abfragen bereit. @PowerSyncDrizzleDriver2026 Für Turso besteht eine Drizzle-Anbindung über den bereits verwendeten libSQL-Treiber. @DrizzleTurso2026 Beide Ansätze boten damit Anknüpfungspunkte an die lokale Datenhaltung aus Phase 1.

Die Kandidaten übernehmen unterschiedliche Aufgaben. PowerSync bildet eine Synchronisierungsschicht zwischen einer Backend-Datenbank und lokalem SQLite; für die Node.js-Laufzeit steht ein eigenes SDK bereit. @PowerSyncNode2026 Turso verbindet eine SQLite-kompatible Datenbank mit einem Cloud-Dienst und Replikationsmöglichkeiten. Die dokumentierten Embedded Replicas unterstützen lokale Datenhaltung und einen Abgleich mit Turso Cloud. @TursoEmbeddedReplicas2026 @tab:sync-tool-options fasst die für die Vorauswahl relevanten Anknüpfungspunkte zusammen.

#figure(
  {
    set par(justify: false)
    table(
      columns: (1fr, 2fr, 2fr),
      inset: 6pt,
      align: left,
      table.header([*Aspekt*], [*PowerSync*], [*Turso/libSQL*]),
      [Rolle], [Synchronisierungsschicht vor einer Backend-Datenbank.], [Datenbank und Cloud-Dienst mit lokalen Replikaten.],
      [Drizzle-Anbindung], [Wrapper und Ableitung des lokalen Schemas über `@powersync/drizzle-driver`.], [Datenzugriff über `drizzle-orm/libsql` und den libSQL-Client.],
      [Entfernte Datenhaltung], [Anbindung von Supabase/PostgreSQL im gewählten Entwurf.], [Abgleich mit der Datenbank in Turso Cloud.],
    )
  },
  caption: [Dokumentationsbasierte Gegenüberstellung der für die Vorauswahl betrachteten Integrationsansätze. @PowerSyncDrizzleDriver2026 @PowerSyncSupabase2026 @DrizzleTurso2026 @TursoEmbeddedReplicas2026],
) <tab:sync-tool-options>

=== Entscheidung für PowerSync und Supabase

Für den Demonstrator wurde eine Architektur mit entferntem Backend gewählt, das den gemeinsamen Datenbestand der Gruppen hält. Ein Peer-to-Peer-Ansatz wäre grundsätzlich eine andere Entwurfsrichtung; er wurde in dieser Arbeit nicht weiterverfolgt. Auch für das Backend sollten vorhandene Dienste verwendet werden, um die Infrastrukturentwicklung innerhalb des festgelegten Untersuchungsumfangs zu halten.

Die Wahl fiel auf Supabase, das eine PostgreSQL-Datenbank sowie Authentifizierung mit SDKs und API-Endpunkten bereitstellt. @SupabaseDatabase2026 @SupabaseAuth2026 Ausschlaggebend war seine dokumentierte Integration mit PowerSync: Ausgewählte PostgreSQL-Daten werden in lokale SQLite-Datenbanken übertragen; lokale Änderungen werden gespeichert, in eine Upload-Warteschlange aufgenommen und bei verfügbarer Verbindung über einen Connector an das Backend übermittelt. Sync Streams legen fest, welche Daten an die jeweiligen Clients übertragen werden. @PowerSyncSupabase2026

Diese Kombination passte zum ausgewählten Gruppenfeature: Unterschiedliche Benutzer sollen auf gemeinsame Aufgaben zugreifen und Änderungen zunächst lokal ausführen können. PowerSync verband dafür die lokale SQLite-Verarbeitung und die Drizzle-Anbindung mit Supabase als entferntem Backend. Die Anwendung musste weiterhin ihre Datenschemata, den Upload-Connector und die fachlichen Zugriffsregeln implementieren. Der Einsatz der Dienste begrenzte damit die zusätzlich zu entwickelnde Synchronisierungsinfrastruktur.

Die Entscheidung gegen Turso beruht auf dieser projektbezogenen Passung. Auch Turso ermöglicht Synchronisierung und Offline-Schreibzugriffe; die Turso-Sync-Dokumentation beschreibt hierfür lokale Änderungen mit späterem `push()` und den Empfang entfernter Änderungen über `pull()`. @TursoSync2026 Für den gewählten Supabase-Entwurf bot PowerSync eine unmittelbar dokumentierte Verbindung von Authentifizierung, Backend-Datenbank und gezielter Datenverteilung. @PowerSyncSupabase2026 Die Auswahl begründet daher die verwendete Kombination, ohne eine allgemeine Überlegenheit gegenüber Turso zu behaupten.

=== Vorprüfung der Integration und Grenzen der Wiederverwendung

Die praktische Integrationsprüfung ist für PowerSync in zwei begrenzten Prototypen dokumentiert. Der erste prüfte die Node-SDK-Ausführung im Electron-Main-Prozess, lokale Persistenz samt Upload-Warteschlange, Schemaerweiterung, Geräteabgleich und Paketierung. Der zweite ergänzte den Drizzle-Wrapper und prüfte typisierte CRUD-Abfragen sowie die Abbildung von Datentypen. Die Projektberichte dokumentieren erfolgreiche lokale Prüfungen und einen Abgleich über Supabase und PowerSync. Sie stützten die Entscheidung, zunächst einen ausgewählten Kollaborationsbereich zu integrieren. Diese Vorprüfung untersucht die gewählte Kombination; sie ist kein praktisch durchgeführter Vergleich beider Kandidaten. @StudyPlanSyncSpikes2026

Die Drizzle-Anbindung ermöglicht Wiederverwendung auf der Ebene der Typdefinitionen, Abfragen und Repository-Muster. Im Prototyp wird das lokale PowerSync-Schema mit `DrizzleAppSchema` aus geeigneten Drizzle-Definitionen abgeleitet; `wrapPowerSyncWithDrizzle` stellt den typisierten Datenzugriff bereit. @StudyPlanSyncSpikes2026

Für synchronisierte Tabellen übernimmt PowerSync die Verwaltung der lokalen Datenbankstruktur. Drizzle Kit bleibt für die persönliche Datenbank aus Phase 1 zuständig; serverseitige PostgreSQL-Migrationen und die Sync-Stream-Konfiguration werden gesondert gepflegt. @StudyPlanSyncSpikes2026 Damit konnte Drizzle als typisierte Datenzugriffsschicht erhalten bleiben, während die Verwaltung des synchronisierten Datenbestands und seiner Identitäten gezielt angepasst wurde. Dieser Unterschied bestimmt die nachfolgende Umsetzung der Gruppenfunktionen.

=== Architektur mit zwei lokalen Datenhaltungsbereichen <sec:sync-architecture>

Mit PowerSync und Supabase erweitert sich die lokale Architektur um entfernte Dienste. Der Renderer verwendet weiterhin die begrenzte Preload-/IPC-Schnittstelle; Datenzugriff und Dienstanbindung werden im Main-Prozess koordiniert. Persönliche Funktionen und ursprüngliche lokale Gruppen verbleiben in der SQLite-Datenbank aus Phase 1. Der neue Kollaborationsbereich verwendet eine weitere lokale SQLite-Datenbank, deren Struktur und Synchronisierung PowerSync verwaltet. Für jede entfernte Benutzeridentität wird eine eigene Datei geöffnet. Es bestehen damit zwei lokale Datenhaltungsbereiche; hinzu kommt der gemeinsame PostgreSQL-Datenbestand bei Supabase. @StudyPlanSyncArchitecture2026

@fig:local-first-architecture zeigt die getrennten Kommunikationswege. Aufgabenänderungen werden zunächst lokal gespeichert und über den Upload-Connector an die Supabase-API übermittelt. PowerSync überträgt die anhand der Sync Streams ausgewählten Backend-Daten zurück in den lokalen Kollaborationsbestand. Der Upload führt somit über die Anwendungs-API, während der Download durch den PowerSync-Dienst erfolgt. @PowerSyncSupabase2026 @StudyPlanSyncArchitecture2026

#figure(
  image("../figures/local-first-architecture.svg", width: 100%),
  caption: [Architektur nach Ergänzung des synchronisierten Gruppenbereichs. Dargestellt sind die beiden lokalen Datenhaltungsbereiche sowie direkte Online-Aufrufe, Upload und Download. Der separate Katalogabruf ist hier nicht dargestellt. Eigene Darstellung nach @StudyPlanSyncArchitecture2026 und @PowerSyncSupabase2026.],
) <fig:local-first-architecture>

Gruppenanlage, Profilsuche und Einladungen verwenden unmittelbare Online-Aufrufe. Die entfernte Sitzung wird im Demonstrator nur im Arbeitsspeicher gehalten; nach einem Neustart ist eine erneute Anmeldung erforderlich. Die lokale Speicherung von Aufgaben bedeutet deshalb keine uneingeschränkte Offline-Verfügbarkeit aller Gruppenoperationen. @StudyPlanSyncArchitecture2026

=== Technische Integration der Kollaborationsmodule <sec:sync-implementation>

Die Integration begann mit der Abstimmung des Datenmodells zwischen Supabase und lokalem PowerSync. In Supabase wurden die fünf Tabellen des Gruppenbereichs durch versionierte SQL-Migrationen angelegt. Datensatz- und Benutzerkennungen werden dort als UUIDs geführt; das lokale Drizzle-Schema bildet sie als Textfelder ab. Neue Aufgaben erhalten ihre UUID bereits beim lokalen Einfügen. Zeitangaben werden lokal als ISO-Strings und boolesche Werte als SQLite-Integer repräsentiert. `schema.ts` definiert diesen lokalen Tabellenbestand und leitet daraus mit `DrizzleAppSchema` das PowerSync-Schema ab. Die neuen Kennungen unterscheiden sich damit von den numerischen Kennungen des Ausgangsmodells. @StudyPlanSyncIntegration2026

Anschließend wurden die Tabellen in die PostgreSQL-Publication `powersync` aufgenommen und für deren Replikationsrolle lesbar gemacht. Die Verbindung des PowerSync-Dienstes zu Supabase umfasst die Datenbankanbindung und die Anerkennung der Supabase-Anmeldetoken. @PowerSyncSupabase2026 Die Datenverteilung wurde in `sync-streams-v4.yaml` beschrieben und als Dienstkonfiguration bereitgestellt. Die Abfragen berücksichtigen Gruppenmitgliedschaften sowie Absender und Empfänger von Einladungen. Diese Datei steuert den Download; die für Schreibzugriffe geltenden Berechtigungen sind zusätzlich im Backend definiert. @StudyPlanSyncIntegration2026 Die entfernten SQL-Migrationen und Sync Streams ergänzen damit das lokale Anwendungsschema und werden getrennt von der Desktop-Paketierung gepflegt.

#figure(
  {
    set par(justify: false)
    table(
      columns: (1fr, 1.4fr),
      inset: 6pt,
      align: left,
      table.header([*Ergänztes Paket*], [*Aufgabe im Demonstrator*]),
      [`@powersync/node`], [Lokale PowerSync-Datenbank, Warteschlange und Synchronisierungsverbindung.],
      [`@powersync/drizzle-driver`], [Ableitung des Client-Schemas und typisierter Drizzle-Zugriff.],
      [`@supabase/supabase-js`], [Anmeldung, direkte RPC-Aufrufe und Upload an die Supabase-API.],
      [`better-sqlite3`], [Nativer SQLite-Treiber für die gewählte PowerSync-Implementierung.],
    )
  },
  caption: [Für den Kollaborationsbereich ergänzte Laufzeitabhängigkeiten und ihre Aufgaben. @StudyPlanSyncIntegration2026],
) <tab:sync-integration-packages>

Für die neue Datenbank wurde `better-sqlite3` gewählt, während die Datenbank aus Phase 1 weiterhin über libSQL angebunden bleibt. Das PowerSync-Node-SDK unterstützt verschiedene SQLite-Treiber; der Wechsel beschreibt somit die konkrete Implementierung des Demonstrators. @PowerSyncNode2026 `database.ts` öffnet die PowerSync-Datenbank und stellt mit `wrapPowerSyncWithDrizzle` den Zugriff für die Repositories bereit. Die Ausführung verwendet einen eigenen Worker, der über `powersync.worker?nodeWorker` in den Electron-Build eingebunden wird. @StudyPlanSyncIntegration2026

Auch die Paketierung wurde angepasst: In `electron-builder.yml` werden `node_modules/@powersync/node/**` und `node_modules/better-sqlite3/**` unter `asarUnpack` aufgeführt. Der Worker ermittelt die native PowerSync-Erweiterung im Verzeichnis `app.asar.unpacked`. Diese Anpassung adressiert das im Prototyp beobachtete Laden der SQLite-Erweiterung unter Windows. Das vorhandene `postinstall`-Skript mit `electron-builder install-app-deps` dient dem Aufbau nativer Abhängigkeiten für die Electron-Laufzeit. @StudyPlanSyncIntegration2026 @StudyPlanSyncSpikes2026 Die Electron-Dokumentation beschreibt die erforderliche Entpackung bei APIs, die reale Dateipfade für native Module benötigen. @ElectronAsar2026

Die Anwendungsmodule erhielten getrennte Zuständigkeiten. `CollaborationRuntime` koordiniert Sitzung, Lebenszyklus und fachliche Operationen. Bei der Anmeldung öffnet sie eine zur entfernten Benutzerkennung gehörende Datenbank und verbindet diese mit dem Connector. Der gekürzte Auszug in @lst:collaboration-connect zeigt diesen Schritt. Die Repositories lesen den lokalen Gruppenbestand und schreiben Aufgabenänderungen. `online-gateway.ts` führt die unmittelbar netzwerkabhängigen Gruppen- und Einladungsoperationen aus. Der Connector liefert über `fetchCredentials` das Anmeldetoken für PowerSync und übermittelt mit `uploadData` die ausstehenden Aufgabenänderungen an Supabase. @StudyPlanSyncIntegration2026

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
  caption: [Öffnen und Verbinden der benutzerbezogenen PowerSync-Datenbank; gekürzter Auszug aus `CollaborationRuntime.signIn`. @StudyPlanSyncIntegration2026],
) <lst:collaboration-connect>

Die Preload-Ebene stellt nun zwei begrenzte Aufrufwege bereit. Über `window.apiTransport.invoke` verwendet die Kernanwendung weiterhin den Kanal `api:invoke`. Für die Kollaboration wurde `window.collaborationTransport.invoke` mit dem Kanal `collaboration:invoke` ergänzt. Der neue Modulvertrag liegt in `src/shared/collaboration/ipc.ts` und wird im betrachteten Stand eigenständig typisiert, statt durch den OpenAPI-Generator erzeugt zu werden. Der zugehörige Main-Handler prüft Absender, Operation und Eingaben mit Zod und berücksichtigt die lokale Sitzung. @StudyPlanSyncIntegration2026 Die beiden IPC-Pfade bilden die getrennte Integration der Funktionsbereiche ab. Zwei Datenbanktreiber erzwingen diese Aufteilung nicht: Die Schnittstellen bieten fachliche Operationen an, deren Datenzugriff hinter den Repositories liegt. Eine Zusammenführung der Datenbanken würde daher nicht automatisch die IPC-Verträge vereinheitlichen.

@fig:collaboration-modules zeigt die Module und ihre Verbindungen. Sie ergänzt das Architekturbild aus @fig:local-first-architecture um die konkrete Aufteilung der Verarbeitung und die beiden IPC-Pfade.

#figure(
  image("../figures/collaboration-modules.svg", width: 100%),
  caption: [Modulaufteilung der Kollaborationsintegration neben der lokalen Kernanwendung. Blaue Pfeile zeigen lokale Aufruf- und Datenzugriffswege, violette Pfeile Dienstkommunikation; der gestrichelte Pfeil zeigt die Schemaeinbindung. Eigene Darstellung nach @StudyPlanSyncIntegration2026.],
) <fig:collaboration-modules>

=== Anpassung des Einladungsablaufs und vorausgesetzte Konten <sec:collaboration-invitations>

Der Ausgangsprompt benannte Gruppeneinladungen über Link oder E-Mail, ohne den Ablauf einer gezielten Benutzerauswahl innerhalb der Anwendung festzulegen. Im Web-Prototyp erzeugte die Gruppenroute einen Einladungstoken. Die Oberfläche bildete daraus eine URL und kopierte sie in die Zwischenablage; die Weitergabe an andere Personen erfolgte außerhalb der Anwendung. @StudienplanerSource2026 Dieser Code beschreibt einen vorgesehenen Ablauf. Ein Nachweis seiner tatsächlichen Nutzbarkeit für die untersuchte Zusammenarbeit wurde in dieser Arbeit nicht geführt. Die Migration konnte deshalb nicht von einem bereits vollständig geprüften Kollaborationsprozess ausgehen.

Für den synchronisierten Gruppenbereich wurde ein anderer Einladungsablauf implementiert. Supabase Auth verwaltet die entfernten Benutzerkonten; die anwendungsbezogenen Namen und Kennungen liegen in einer zugeordneten `profiles`-Tabelle. Die Trennung zwischen Auth-Daten und über die Anwendungs-API zugänglichen Profilen entspricht dem von Supabase dokumentierten Ansatz. @SupabaseUserManagement2026 Neu entwickelt wurde eine Suche nach Benutzer- oder Anzeigenamen. Die Funktion `search_invitable_profiles` steht dem angemeldeten Gruppeneigentümer zur Verfügung und liefert bis zu 20 passende, als auffindbar markierte Profile. Eigene Identität, vorhandene Mitglieder und Personen mit bereits ausstehender Einladung werden ausgeschlossen. Als Ergebnis werden Kennung, Benutzername und Anzeigename übermittelt. @StudyPlanSyncArchitecture2026

Die Auswahl eines Profils führt zu einer personenbezogenen Einladung über `send_group_invitation`. Die eingeladene Person erhält den Eintrag durch PowerSync und kann ihn mit `respond_group_invitation` annehmen oder ablehnen. Nach der Annahme entsteht die Mitgliedschaft, anhand derer die Gruppendaten übertragen werden. @StudyPlanSyncArchitecture2026 Diese Benutzersuche und der zugehörige Einladungsablauf sind fachliche Anpassungen des Demonstrators. Sie gehen über den Austausch des Transports hinaus und konkretisieren die im Ausgangsartefakt nur teilweise festgelegte Zusammenarbeit.

Für die Fallstudie wurden die benötigten entfernten Testkonten vorab über das Supabase-Dashboard angelegt. Ihre E-Mail-Adressen und Passwörter mussten somit bereits vorliegen. Die Desktop-Anwendung enthält eine Anmeldung für diese Konten: Im Main-Prozess ruft der Connector `signInWithPassword` mit den eingegebenen Zugangsdaten auf. @StudyPlanSyncArchitecture2026 Die Methode authentifiziert bestehende Konten und übernimmt keine Registrierung. @SupabasePasswordSignIn2026 Die lokale Kontoverwaltung aus Phase 1 bleibt davon getrennt.

Eine Registrierung für das entfernte Backend, E-Mail-Bestätigung und Passwortzurücksetzung wurden in der Anwendungsoberfläche nicht implementiert. Der Untersuchungsaufbau setzt eingerichtete Konten voraus, um authentifizierte Gruppenzugriffe und die Synchronisierung gemeinsamer Aufgaben zu demonstrieren. Die Ausarbeitung eines vollständigen Kontolebenszyklus würde zusätzliche Produktfunktionen und Anforderungen einführen. Für diesen begrenzten Nachweis wurden sie daher nicht entwickelt; bei einer produktiven Anwendung wären sie anhand des vorgesehenen Benutzerzugangs gesondert festzulegen. Die Fallstudie bewertet damit die Migration unter dieser Voraussetzung und weist keine vollständige entfernte Benutzerverwaltung nach.

=== Schrittweise Überführung weiterer Funktionen

Die parallele Datenhaltung ermöglicht eine Migration nach Funktionsbereichen: Ein vorhandener Bereich bleibt zunächst bestehen, während ein ausgewählter Bereich mit dem neuen Datenzugriff umgesetzt wird. Dieses Vorgehen folgt dem Grundgedanken des Strangler-Fig-Patterns, bestehende Funktionen schrittweise durch neue Implementierungen abzulösen. @FowlerStranglerFig2024 Im Demonstrator sind die beiden Gruppenbereiche jedoch noch getrennt; vorhandene Gruppendaten werden nicht automatisch übernommen. @StudyPlanSyncArchitecture2026

Das Terminbeispiel aus der Vorprüfung konkretisiert die erforderlichen Anpassungen. Die ursprüngliche `events`-Tabelle besitzt numerische, automatisch erzeugte Kennungen und lokale Benutzerkennungen. Für die separate Prototyptabelle `spike_events` wurden clientseitige UUIDs, eine Supabase-Benutzerzuordnung und geeignete Datentypabbildungen verwendet. Geprüft wurden typisierte CRUD-Zugriffe, Persistenz ausstehender Änderungen und der Abgleich zwischen Replikaten. Damit liegt ein Beispiel für die technische Überführung eines weiteren Datenbereichs vor; die Übernahme vorhandener Termine einschließlich ihrer Referenzen wurde damit noch nicht durchgeführt. @StudyPlanSyncSpikes2026 Weitere Bereiche würden dieselben Grundschritte durchlaufen: Schema und Identitäten anpassen, Daten und Referenzen zuordnen, Repositories anbinden und das Verhalten prüfen. Die Umsetzung jedes weiteren CRUD-Pfads würde das bereits gezeigte Muster wiederholen und wird daher nicht vollständig ausgearbeitet.

Eine spätere Zusammenführung in einer PowerSync-verwalteten lokalen Datenbank wäre grundsätzlich möglich, ohne sämtliche Inhalte zu teilen. Persönliche Tabellen müssten dafür ausdrücklich als lokale Tabellen konfiguriert werden, etwa mit `localOnly: true`; ihre Änderungen gelangen dann nicht in die Upload-Warteschlange. @PowerSyncLocalOnly2026 @PowerSyncDrizzleDriver2026 Das bloße Weglassen eines Sync Streams reicht hierfür nicht aus, da Streams den Download steuern. Benutzerzuordnung und Zugriff ohne entfernte Anmeldung wären bei einer solchen Zusammenführung weiterhin zu erhalten. Erst nach Ablösung aller bisherigen libSQL-Zugriffe könnte `@libsql/client` entfallen. Dazu wären die betroffenen Repositories, Datenbankinitialisierung und Schemaverwaltung zu überführen. Im gewählten Entwurf bliebe `better-sqlite3` als lokaler Treiber erhalten. Eine solche vollständige Ablösung wurde nicht geprüft; sie beschreibt eine mögliche Weiterentwicklung, nicht den erreichten Projektstand.

=== Verantwortung für Schemaänderungen und Updates <sec:sync-schema-updates>

Die Einführung der Synchronisierung verändert auch die Verantwortung für spätere Schemaänderungen. In Phase 1 verwaltet die Desktop-Anwendung ihre Datenbank durch mitgelieferte Drizzle-Migrationen. Für synchronisierte Funktionen sind nun das entfernte PostgreSQL-Schema, die PowerSync-Datenverteilung und das lokale Anwendungsschema aufeinander abzustimmen. Die Supabase-Datenbank erhält eigene versionierte SQL-Migrationen. @SupabaseSchemaMigrations2026 Das Desktop-Update ist damit Bestandteil einer koordinierten Bereitstellung über mehrere Komponenten.

Auf Clientseite wird das mit `DrizzleAppSchema` abgeleitete Schema beim Öffnen der PowerSync-Datenbank an das SDK übergeben. @StudyPlanSyncIntegration2026 Im verwendeten Standardmodell speichert PowerSync Daten als JSON und stellt sie über SQLite-Views entsprechend dem lokalen Schema bereit. Eine aktualisierte Schemadefinition wird beim Start der neuen Anwendungsversion angewandt; für diese Views werden keine zusätzlichen Drizzle-SQL-Migrationsdateien benötigt. @PowerSyncSchemaChanges2026 Die Drizzle-Migrationen aus Phase 1 bleiben für die separate persönliche Datenbank zuständig.

Für eine additive Erweiterung, etwa eine neue synchronisierte Tabelle, ergibt sich folgender Bereitstellungsablauf:

+ Zunächst wird das Supabase-Schema erweitert. Dazu gehören die erforderlichen Zugriffsregeln und gegebenenfalls Anpassungen der Backend-Operationen.
+ Anschließend wird die Tabelle in die PostgreSQL-Publication aufgenommen und die Sync-Stream-Konfiguration angepasst. Die Verarbeitung der aktualisierten Konfiguration muss abgeschlossen sein, bevor die neue Funktion freigegeben wird.
+ Danach wird die Desktop-Version mit dem erweiterten Client-Schema und den zugehörigen Anwendungsfunktionen veröffentlicht.

Diese Reihenfolge entspricht dem von PowerSync beschriebenen Vorgehen für additive Änderungen. Umbenennungen, Löschungen oder Typänderungen können andere Übergangsschritte erfordern. @PowerSyncSchemaDeployment2026

Die Abstimmung muss auch ältere Clients berücksichtigen, die ein Update noch nicht installiert haben oder nach einer Offline-Phase ausstehende Änderungen übertragen. Bestehende Lese- und Schreibformate sind während des Übergangs kompatibel zu halten. PowerSync beschreibt dafür unter anderem versionierte Streams und Datentransformationen; deren konkrete Verwendung hängt von der Schemaänderung ab. @PowerSyncSchemaChanges2026 Ein vollständiger Ablauf mit unterschiedlichen Anwendungsversionen, Backend-Änderung und anschließender Desktop-Aktualisierung wurde im Demonstrator nicht geprüft. Dieser Abschnitt benennt die daraus abgeleitete Anforderung an spätere Updates und erweitert den bisherigen Implementierungsnachweis nicht.

=== Grenzen der untersuchten Synchronisierung

Die Untersuchung umfasst die lokale Verarbeitung gemeinsamer Aufgaben und deren späteren Abgleich. Eine vollständige Übernahme persönlicher Kontodaten auf andere Geräte oder gemeinsame Echtzeitbearbeitung von Dokumenten gehört gemäß Kapitel 4 nicht dazu. Der Replikatabgleich der Vorprüfung prüft die technische Datenübertragung, ersetzt jedoch keine vollständige Kontomigration. @StudyPlanSyncSpikes2026

Der Web-Prototyp verarbeitete Änderungen unmittelbar über sein autoritatives Backend. Eine fachliche Zusammenführung konkurrierender Offline-Änderungen war dort nicht implementiert. @StudienplanerSource2026 Local-First ergänzt diese Entwurfsfrage: Regeln für konkurrierende Bearbeitungen, Löschkonflikte oder manuelle Konfliktentscheidungen müssen aus den Anforderungen der jeweiligen Anwendung abgeleitet werden. Ihre umfassende Entwicklung würde neue Fachfunktionalität schaffen und geht über die hier demonstrierte Migration hinaus.

Auch der Demonstrator besitzt deshalb keine eigens entwickelte Konfliktzusammenführung. Sein Connector übermittelt Aufgabenänderungen mit `upsert`, `update` und `delete` an Supabase, ohne eine eigene Versionsprüfung. @StudyPlanSyncArchitecture2026 Eine als Last Write Wins bezeichnete Regel müsste ausdrücklich festlegen, welche Reihenfolge maßgeblich ist; ihre fachliche Eignung ist hier nicht evaluiert. Die Begrenzung betrifft erweiterte Konfliktstrategien. Warteschlange, Wiederholungen und der Umgang mit abgelehnten Änderungen bleiben für die Migration relevant. PowerSync verwendet ein serverautoritatives Modell; aus einem lokalen Schreibabschluss folgt noch keine Bestätigung durch das Backend. @PowerSyncWritingChanges2026

=== Online-Abruf des Studienkatalogs <sec:study-catalog-download>

Der Studienkatalog ergänzt die Synchronisierung um einen einfacheren Netzwerkablauf: Fachliche Referenzdaten werden online bereitgestellt, in die lokale Datenbank übernommen und anschließend offline gelesen. Damit können Kataloginhalte unabhängig von einer neuen Anwendungsversion aktualisiert werden. Der Demonstrator ergänzt hierzu den in Phase 1 ausgelieferten Seed-Bestand um online abrufbare Beispieldaten; der vorhandene Grundbestand bleibt erhalten. @StudyPlanCatalog2026

Im Commit `9320911` wurde dafür eine Supabase Edge Function ergänzt, die Studiengänge und zugehörige Lehrveranstaltungen aus einer JSON-Datei über einen öffentlichen HTTP-Endpunkt bereitstellt. Dieser Endpunkt benötigt weder ein Benutzerkonto noch einen Zugriff auf die entfernte Datenbank. Änderungen am angebotenen Katalog erfordern eine erneute Bereitstellung dieser Datei mit der Funktion, jedoch keine neue Version der Desktop-Anwendung. Der bestehende OpenAPI-Vertrag wurde um `refreshStudyCatalog` und dessen Ergebnis mit den Anzahlen übernommener Studiengänge und Lehrveranstaltungen erweitert. Daraus wurden die IPC-Vertragsbestandteile und der React-Query-Hook erneut generiert. @StudyPlanCatalog2026

Beim Öffnen der Studienseite liest die Oberfläche zunächst den lokalen Bestand und löst zusätzlich die Aktualisierung aus. Der Main-Prozess lädt die JSON-Daten, validiert sie anhand der vorhandenen Feldschemata und übernimmt beide Datenbereiche gemeinsam in einer Transaktion. Anhand stabiler Kennungen werden neue Einträge eingefügt und vorhandene aktualisiert, sodass wiederholte Abrufe keine Duplikate erzeugen. In der Antwort fehlende Einträge werden nicht gelöscht. Nach erfolgreicher Übernahme werden die betroffenen Abfragen der Oberfläche erneut ausgeführt. @StudyPlanCatalog2026

Scheitern Abruf, Validierung oder Datenbankübernahme, bleibt der bisherige lokale Bestand nutzbar. Die Oberfläche zeigt den Fehler an und bietet einen erneuten Versuch an. Bereits übernommene Katalogdaten bleiben auch nach einem Neustart lokal verfügbar. Der untersuchte Stand ruft den Katalog bei jedem Seitenaufruf erneut ab; eine Versionsprüfung zur Erkennung neuer Katalogstände wurde nicht implementiert. Er zeigt damit das Muster eines Downloads mit dauerhafter lokaler Datenhaltung. Die Desktop-Anwendung lädt dabei keine Katalogänderungen zum entfernten Dienst hoch. @StudyPlanCatalog2026

Der Kontrollpunkt dieser Phase betrifft insbesondere A6 und A8. Für Aufgaben sind der lokale Abschluss einer Änderung und ihre spätere Übernahme im Kollaborationsablauf getrennt zu beobachten. Bei unmittelbar netzwerkabhängigen Operationen sind Fehlermeldung und Verhalten ohne Verbindung auszuweisen. Bereits lokal verfügbare Funktionen dürfen durch den Ausfall einer zusätzlichen Online-Anbindung nicht unnötig blockiert werden.

== Phase 3: Prüfung und Härtung der vervollständigten Anwendung

Nach der funktionalen Umsetzung wird die Gesamtheit der entstandenen Schnittstellen geprüft. Dazu gehören IPC-Eingänge, lokale Ressourcen, Navigationsmöglichkeiten und externe Kommunikationspfade. Die Electron-Sicherheitscheckliste bildet den festgelegten Bezugsrahmen. @ElectronSecurity2026 Für jede Empfehlung werden Anwendbarkeit, erforderliche Maßnahme, konkreter Beleg und verbleibende Nachweisgrenze dokumentiert.

Die im Demonstrator vorgesehenen Maßnahmen betreffen unter anderem deaktivierte Node-Integration im Renderer, Context Isolation, Renderer-Sandboxing, eine restriktive Content Security Policy und die Begrenzung von Navigation sowie zusätzlichen Fenstern. IPC-Absender und fachliche Eingaben werden im Main-Prozess geprüft. Für externe Dienste sind die zugelassenen Verbindungsziele und ihre Transportkonfiguration zu kontrollieren. Paketbezogene Einstellungen sind am gebauten Artefakt zu prüfen, sofern sie Bestandteil der jeweiligen Empfehlung sind.

Der Kontrollpunkt ist A7. Ein Konfigurationseintrag, ein Unit-Test und eine beobachtete Laufzeitwirkung liefern unterschiedliche Nachweise und werden entsprechend ausgewiesen. Für SDK-interne Netzwerkpfade wird keine Prüfung behauptet, die tatsächlich nicht durchgeführt wurde. Die konsolidierte Projektmatrix dokumentiert insbesondere die begrenzte Bewertung der PowerSync-Redirectbehandlung; diese Nachweisgrenze ist bei der Ergebnisdarstellung zu übernehmen. @StudyPlanSecurity2026

== Ausarbeitung der einzelnen Migrationsschritte

Aus dem dokumentierten Migrationsverlauf werden die Handlungsempfehlungen des Leitfadens abgeleitet. Jede Empfehlung verbindet einen konkreten Ausgangszustand mit der erforderlichen Transformation, den betroffenen Verantwortlichkeiten und einem Kontrollpunkt. Die Zuordnung zu A1–A9 macht nachvollziehbar, welches Ziel der jeweilige Schritt unterstützt.

// Arbeitsstand: Phase 1 ist mit Datenhaltung, API-Schnittstelle, Renderer,
// Authentifizierung sowie exemplarischen CRUD- und Importpfaden ausgearbeitet.
// Phase 2 enthält Toolauswahl, Integrationsvorprüfung, Architektur, technische Integration,
// Einladungsablauf, Schema- und Updateverantwortung, Umfang und Katalogabruf; der konkrete Aufgabenablauf
// ist noch auszuarbeiten.
// Phase 3 ist bislang als Phasenübersicht beschrieben.
// Noch ergänzen: die weiteren Prozessberichte und abgeleiteten Empfehlungen.
