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

=== Initialisierung des Electron-Projekts und Übernahme der Datenbankmodule

Die Entscheidung für Electron orientierte sich an Anforderung A3, vorhandene Komponenten soweit möglich weiterzuverwenden. Das Backend des Ausgangsartefakts war in TypeScript für Node.js implementiert. @StudienplanerSource2026 Im Main-Prozess von Electron steht ebenfalls eine Node.js-Laufzeit zur Verfügung. @ElectronProcessModel2026 Damit konnten die vorhandene fachliche Logik und ihre JavaScript- beziehungsweise TypeScript-Bibliotheken als Ausgangsbasis für die lokale Umsetzung dienen.

Tauri wurde als alternative Desktop-Laufzeit erwogen. Sein privilegierter Core-Prozess basiert auf Rust, während die Oberfläche weiterhin Webtechnologien verwenden kann. @TauriProcessModel2026 Eine Übernahme der Backend-Funktionen in diesen Rust-Core hätte eine Portierung der TypeScript-Implementierung erfordert. Dabei wären neben der Syntax auch Sprachkonzepte, Datentypen, Fehlerbehandlung und Bibliotheksanbindungen anzupassen gewesen. Insbesondere hätte der mit Drizzle implementierte Datenzugriff durch eine entsprechende Rust-Implementierung ersetzt werden müssen. Der erwartete zusätzliche Aufwand sprach aus Sicht des Projekts gegen diesen Weg und für die Beibehaltung der bestehenden Implementierungssprache mit Electron.

Ein vollständiger Sprachwechsel ist bei Tauri allerdings keine zwingende Voraussetzung: Die offizielle Dokumentation beschreibt auch die Einbindung einer Node.js-Anwendung als separaten Sidecar-Prozess. @TauriNodeSidecar2026 Dieser Ansatz ermöglicht die Weiterverwendung vorhandener Backend-Logik, erfordert jedoch die Einbindung und Auslieferung eines zusätzlichen Prozesses sowie dessen Kommunikation mit der übrigen Anwendung. Electron wurde gewählt, um die übernommenen Backend-Komponenten unmittelbar im Main-Prozess auszuführen. Die Entscheidung beruht auf der erwarteten Begrenzung der Eingriffe in das Ausgangsartefakt; ein vergleichender Nachweis des Migrationsaufwands gegenüber Tauri wurde nicht erbracht.

Zu Beginn wurde ein neues Electron-Projekt mit dem auf electron-vite beruhenden Projektgenerator angelegt. Gewählt wurde die Vorlage für React und TypeScript, da das Frontend des Replit-Prototyps bereits React, TypeScript und Vite verwendete. @StudienplanerSource2026 Der Projektgenerator stellt hierfür die Vorlage `react-ts` bereit. @ElectronViteGettingStarted2026

Als Alternative wurde Electron Forge anhand seiner Dokumentation betrachtet. Die dort beschriebene Einrichtung von React mit TypeScript geht von der Vorlage `webpack-typescript` aus. @ElectronForgeReact2026 Forge bietet außerdem die Vorlagen `vite` und `vite-typescript` an. @ElectronForgeGettingStarted2026 Für electron-vite sprach im vorliegenden Projekt die unmittelbar verfügbare Kombination aus Vite, React und TypeScript. Der Entscheidung lag die Annahme zugrunde, dass die Beibehaltung dieser Technologien weniger Anpassungen an der Oberfläche und ihrer Build-Konfiguration erfordert als ein gleichzeitiger Wechsel des Build-Werkzeugs. Diese Annahme wurde nicht durch eine vergleichende Migration mit Electron Forge und Webpack evaluiert. Die Wahl von electron-vite wird daher als projektbezogene Entscheidung dokumentiert; ein geringerer Migrationsaufwand gegenüber den Alternativen ist damit nicht nachgewiesen.

Anschließend wurden die Drizzle-Schemadefinitionen aus der gemeinsamen Datenbankbibliothek des Ausgangsartefakts in den Main-Prozess übernommen. Im Zielprojekt liegen sie unter `src/main/db/schema`. Dies betrifft die Definitionen für Benutzer, Stundenpläne, Studiengänge, Gruppen, Noten, Termine und das Aktivitätsprotokoll sowie deren gemeinsames Exportmodul. Auch die bestehende Drizzle-Kit-Konfiguration wurde als Ausgangspunkt übernommen; im Zielprojekt befindet sich `drizzle.config.ts` im Projektstamm. Der Datenbankzugriff wurde damit dem Main-Prozess zugeordnet. @StudienplanerSource2026 @StudyPlanDatabase2026

Für die ersten lokalen Entwicklungsschritte wurde die bisherige Verbindung zu PostgreSQL durch den Zugriff auf eine SQLite-Datei im Projektverzeichnis ersetzt. In der Drizzle-Konfiguration wurde der Dialekt von `postgresql` auf `sqlite` umgestellt. Die bisher für die entfernte Datenbank verwendete Umgebungsvariable `DATABASE_URL` entfiel für diesen lokalen Datenbankzugriff.

Mit dem Wechsel der Ausführungsumgebung verschob sich auch die Verantwortung für die Datenbankverwaltung: Die Desktop-Anwendung übernimmt im Main-Prozess das Anlegen, Öffnen und Migrieren der lokalen Benutzerdatenbank. Die Datenbankdatei wird zur Laufzeit im anwendungsspezifischen Benutzerdatenverzeichnis außerhalb des Projekt- und Installationsverzeichnisses angelegt. @StudyPlanDatabase2026 Hierfür wird der von Electron bereitgestellte Pfad `userData` verwendet. @ElectronAppPaths2026 Dieser Speicherort trennt veränderliche Benutzerdaten von den ausgelieferten Programmdateien. Die Datenhaltung benötigt dadurch keine Schreibrechte im Installationsverzeichnis und bleibt vom Austausch der Programmdateien bei einem Update getrennt. Ausgeliefert werden die Migrationsdateien, mit denen die Anwendung eine neue Datenbank einrichtet oder eine vorhandene aktualisiert. @StudyPlanDatabase2026

=== Anpassung der Tabellendefinitionen an SQLite

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

=== Anpassung der Datenbankabhängigkeiten

Für die benötigten Pakete wurde zunächst die Abhängigkeitskonfiguration des Ausgangsartefakts herangezogen. Die angegebenen Versionsbereiche für `drizzle-orm` (`^0.45.2`), `drizzle-kit` (`^0.31.10`) und `drizzle-zod` (`^0.8.3`) wurden übernommen. Der PostgreSQL-Treiber `pg` wurde für die lokale Datenhaltung durch `@libsql/client` ersetzt; im Demonstrator ist hierfür der Versionsbereich `^0.18.0` angegeben. @StudienplanerSource2026 @StudyPlanDatabase2026 Damit blieb Drizzle als Abstraktion für Schema und Datenzugriff erhalten, während der verwendete Treiber wechselte.

Die Verantwortlichkeiten der Pakete sind dabei zu unterscheiden: Der libSQL-Client öffnet die lokale Datenbankdatei, Drizzle ORM führt die Datenbankoperationen aus und Drizzle Kit erzeugt die SQL-Migrationsdateien. Das Anwenden dieser Dateien beim Anwendungsstart übernimmt der Migrator aus `drizzle-orm/libsql/migrator`. Die automatische Anwendung vorbereiteter Migrationen ist somit Bestandteil der eingerichteten Drizzle-Initialisierung und keine alleinige Eigenschaft des Datenbanktreibers. @StudyPlanDatabase2026

=== Erzeugung versionierter Schemamigrationen

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

In `package.json` wurden hierfür die Skripte `db:generate` mit dem Befehl `drizzle-kit generate` und `db:check` mit `drizzle-kit check` eingerichtet. Die Anwendung selbst benötigt zur Laufzeit keine Ausführung von Drizzle Kit: Sie verwendet die bereits erzeugten Dateien über den ORM-Migrator. Ein zusätzliches Skript für `push` wäre eine Möglichkeit für die Entwicklung, ist jedoch im aktuellen Zielprojekt nicht eingerichtet. @StudyPlanDatabase2026

=== Datenbankinitialisierung beim Anwendungsstart

Die Initialisierung wurde in den Startablauf des Main-Prozesses eingebunden. Innerhalb des mit `app.whenReady()` begonnenen Ablaufs in `src/main/index.ts` wird `initDatabase()` abgewartet, bevor die lokale Datenbank an Repositories und Dienste übergeben und das Anwendungsfenster geöffnet wird. Scheitert die Vorbereitung, zeigt die Anwendung eine Fehlermeldung an und beendet den Start. Die Oberfläche wird dadurch nicht mit einer unvollständig vorbereiteten Datenbank geöffnet. @StudyPlanDatabase2026

Der Speicherort wird in `src/main/db/index.ts` aus `app.getPath('userData')` und dem Unterverzeichnis `data` gebildet. Electron stellt damit einen plattformabhängigen Pfad für die Daten der jeweiligen Anwendung bereit. @ElectronAppPaths2026 In der paketierten Anwendung lautet der Dateiname `studyplan.db`, während die Entwicklung `studyplan-dev.db` verwendet. Unter Windows ergibt sich bei der verwendeten Anwendungskonfiguration beispielsweise `%APPDATA%\studyplan\data\studyplan.db`, üblicherweise innerhalb von `AppData\Roaming`. @StudyPlanDatabase2026 Der Unterordner wird vor dem Öffnen der Datei angelegt; die Datenbank bleibt so von den ausgelieferten Programmdateien getrennt.

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

Mit diesen Schritten war die lokale Datenhaltung vorbereitet. Dies umfasst die SQLite-Schemadefinitionen, den lokalen Datenbankzugriff sowie die Generierung, Auslieferung und Anwendung der Migrationen. Eine offline nutzbare Kernanwendung folgt daraus erst durch die anschließende Übernahme der fachlichen Operationen und der Oberfläche.

=== Übernahme des API-Vertrags und Anpassung der Codegenerierung <sec:api-contract-migration>

Nach der Vorbereitung der Datenhaltung wurde die Schnittstelle zwischen Oberfläche und fachlichen Operationen überführt. Als Ausgangspunkt diente der OpenAPI-Vertrag aus `lib/api-spec/openapi.yaml` des Web-Prototyps. Er wurde in das Zielprojekt unter `api/openapi.yaml` übernommen. Die Schreibweise der vorliegenden Dateien lautet somit `.yaml`. Der Vertrag enthält die Operationskennungen, Parameter und Datenschemata, aus denen bereits im Ausgangsartefakt Aufrufhilfen für die Oberfläche und Zod-Schemata erzeugt wurden. @StudienplanerSource2026

Im Web-Prototyp steuerte `orval.config.ts` die Erzeugung eines React-Query-Clients und der Zod-Schemata durch Orval. Dieses Prinzip der gemeinsamen Vertragsgrundlage wurde übernommen. Im Desktop-Projekt erfolgt die Generierung jedoch durch eigene TypeScript-Skripte unter `scripts/openapi-ipc`. Die Datei `api/ipc-generator.config.ts` wird von diesen Skripten eingelesen; sie ist keine Orval-Konfiguration. Sie legt den Eingabevertrag sowie die Ausgabepfade für gemeinsame API-Module und Renderer-Aufrufhilfen fest. @StudyPlanApiMigration2026

Für das Einlesen des Vertrags wird das Paket `yaml` verwendet. Zod dient weiterhin zur Beschreibung und Prüfung der Eingabe- und Ausgabedaten. Der Projektgenerator liest die Operationen und Schema-Komponenten aus dem Vertrag und erzeugt daraus TypeScript-Typen, Laufzeitschemata sowie eine Zuordnungstabelle `operationContracts`. Zusätzlich erzeugt er einen transportunabhängigen API-Client und React-Query-Hooks für den Renderer. Die Typen und Zod-Schemata liegen gemeinsam unter `src/shared/api/generated`; die Hooks liegen unter `src/renderer/src/api/generated`. Die Validierung verwendet der Main-Prozess, auch wenn die generierten Module nicht ausschließlich in seinem Quellcodeverzeichnis abgelegt sind. @StudyPlanApiMigration2026

Die Generierung wird über `api:generate` in `package.json` aufgerufen. Mit `api:check` kann geprüft werden, ob die vorhandenen Dateien der aktuellen Generatorausgabe entsprechen. OpenAPI und YAML werden dabei während der Entwicklung eingelesen. Zur Laufzeit verwendet die Anwendung die daraus erzeugten Module; sie interpretiert den YAML-Vertrag nicht bei jedem API-Aufruf erneut. Die Generatoren erzeugen außerdem keine fachlichen Implementierungen. Eine im Vertrag definierte Operation muss gesondert mit einem Handler verbunden werden. @StudyPlanApiMigration2026

Die Erzeugung der Renderer-Hooks wurde während der anschließenden Oberflächenintegration weiter ausgearbeitet. Im Commit `f03ab7f` wurde `scripts/openapi-ipc/generator-lib.ts` um die Generierung der React-Query-Aufrufhilfen und eines gemeinsamen Exportmoduls unter `src/renderer/src/api/index.ts` erweitert. Der Generator orientiert sich an den bereits verwendeten Aufrufformen: Query-Hooks erhalten die benötigten Pfad- und Query-Parameter, Mutation-Hooks verwenden ein Variablenobjekt mit `data` für den bisherigen Request-Body. Auch Hilfsfunktionen zur Bildung der Query Keys werden erzeugt. Damit können vorhandene Aufrufmuster der Oberfläche weiterverwendet werden, während der Generator ihre Eingaben auf die interne IPC-Struktur abbildet. @StudyPlanFrontendMigration2026 @StudyPlanApiMigration2026

Im Zuge der ersten Authentifizierungsimplementierung wurde auch die Anbindung des generierten Clients angepasst. Zunächst stellte Preload den vollständigen API-Client bereit. Im Commit `1c1988d` wurde seine Erzeugung in den Renderer verlagert: Die generierten Hooks verwenden dort `createApiClient` mit der über `window.apiTransport.invoke` bereitgestellten Transportfunktion. Preload vermittelt die IPC-Aufrufe, während der Client im Renderer erfolgreiche Ergebnisse entnimmt und Fehler als `ApiClientError` rekonstruiert. Diese Änderung ist Teil der Schnittstellenintegration und wird deshalb hier zusammen mit der Generatorentwicklung dokumentiert. @StudyPlanLocalAuth2026

=== Einrichtung des IPC-Transports und der Preload-Schnittstelle

Der generierte API-Client ruft fachliche Operationen über einen abstrahierten Transport auf. Im Web-Prototyp verwendete der erzeugte Client HTTP-Methode, URL und `customFetch`. Im Desktop-Projekt erhält der Client stattdessen eine Funktion vom Typ `ApiTransport`. Diese übermittelt eine `operationId` und deren typisierte Eingabedaten über die Preload-Schnittstelle. Parameter werden dabei in den Gruppen `path`, `query` und `body` zusammengefasst. Die Bezeichnungen bleiben aus dem Web-Vertrag erhalten, bezeichnen im IPC-Aufruf jedoch Felder eines Objekts statt Bestandteile einer HTTP-Anfrage. @StudienplanerSource2026 @StudyPlanApiMigration2026

In `src/preload/index.ts` wurde hierfür ein Objekt `apiTransport` eingerichtet. Dessen Methode `invoke` sendet die Anfrage über `ipcRenderer.invoke` auf den festgelegten Kanal `api:invoke` an den Main-Prozess. Die Anfrage enthält die Operationskennung, das Eingabeobjekt und eine `requestId` zur Zuordnung des Ergebnisses. Der Renderer erhält über `contextBridge.exposeInMainWorld` Zugriff auf `window.apiTransport`. Dieses Zusammenspiel von Preload-Bridge, `ipcRenderer.invoke` und `ipcMain.handle` entspricht dem von Electron dokumentierten Muster für einen Aufruf mit Rückgabewert. @ElectronIpc2026 @StudyPlanApiMigration2026

Ergänzend wurde in `src/preload/index.d.ts` das globale TypeScript-Interface `Window` um die typisierte Transportmethode erweitert. Diese Deklaration beschreibt die Schnittstelle für die Typprüfung; das tatsächlich verfügbare Objekt wird durch den Preload-Code bereitgestellt. Der Renderer verwendet dadurch die vorgesehenen API-Aufrufe, ohne einen frei wählbaren IPC-Kanal oder das gesamte `ipcRenderer`-Objekt zu erhalten. Die Electron-Dokumentation empfiehlt eine begrenzte Bridge anstelle der Weitergabe des vollständigen IPC-Zugriffs. @ElectronContextBridge2026

Ein IPC-Handler für diesen Aufrufweg wird im Main-Prozess registriert. Im Renderer befinden sich die Aufrufhilfen und Hooks; dort wird kein `ipcMain.handle` eingerichtet und kein Main-IPC-Ereignis verarbeitet. Die Übernahme der React-Komponenten und die dafür erforderlichen Anpassungen ihrer API-Nutzung werden im anschließenden Entwicklungsschritt behandelt. Die hier beschriebene Schnittstelle schafft zunächst die technische Grundlage dafür. @StudyPlanApiMigration2026

=== Validierung und Zuordnung der Operationen im Main-Prozess

Für die zentrale Verarbeitung wurde `src/main/ipc/api-dispatcher.ts` angelegt. Der Dispatcher nimmt die über `api:invoke` übermittelte Anfrage entgegen und ordnet sie anhand der `operationId` einem Vertrag und einem registrierten Handler zu. Im vorliegenden Implementierungsstand prüft er zunächst den zulässigen Absender sowie die grundlegende Form der Anfrage. Anschließend prüft er die Eingabedaten mit dem zur Operation erzeugten Zod-Schema. Unbekannte Operationskennungen und ungültige Eingaben werden abgewiesen. @StudyPlanApiMigration2026

Nach der Ausführung des Handlers validiert der Dispatcher auch dessen Rückgabewert. Für ausdrücklich deklarierte Fehlerantworten verwendet er ebenfalls die erzeugten Fehlerschemata. Das Ergebnis wird in einem gemeinsamen Format zurückgegeben: Ein erfolgreicher Aufruf enthält `ok: true`, die Daten und eine Anfragekennung; ein fehlgeschlagener Aufruf enthält `ok: false` und ein Fehlerobjekt. Der API-Client entnimmt einem erfolgreichen Ergebnis die Daten und überführt einen Fehler in `ApiClientError`. Damit wird die bisherige HTTP-Antwortbehandlung durch eine ausdrückliche IPC-Ergebnisbehandlung ersetzt. @StudyPlanApiMigration2026

Die Handler-Zuordnung wird unabhängig von der Generierung eingerichtet. Der Dispatcher implementiert selbst weder die fachliche Auswahl noch den Datenbankzugriff. Bei einer bekannten, aber nicht registrierten Operation liefert er `NOT_IMPLEMENTED`. Die Generierung eines Vertrags oder Hooks belegt daher noch nicht die Ausführbarkeit der zugehörigen Funktion. Fachliche Berechtigungen und die Zuordnung einer lokalen Sitzung werden zusätzlich in den jeweiligen Handlern beziehungsweise Diensten behandelt. Die detaillierte Härtungsprüfung dieser Schnittstellen folgt in Phase 3. @StudyPlanApiMigration2026

=== Begründung und Grenzen der vertragsbasierten Generierung

Eine mögliche Alternative bestand darin, die von Orval erzeugten Hooks, Typen und Zod-Schemata manuell zu übernehmen und an IPC anzupassen. Damit wäre die Entwicklung eines eigenen Generators entfallen. Die Schnittstellendefinitionen hätten jedoch weiterhin in den Aufrufhilfen und Validierungsschemata gepflegt und bei Änderungen miteinander abgestimmt werden müssen. Für den angestrebten erweiterbaren Demonstrator wurde deshalb die gemeinsame Vertragsgrundlage beibehalten und ihre Übersetzung in den IPC-Aufrufweg automatisiert.

Der Vertrag legt fest, welche Operationen verfügbar sind und welche Eingaben, Rückgabewerte und deklarierten Fehler sie besitzen. Aus dieser gemeinsamen Beschreibung werden die Typdefinitionen, Client-Aufrufe, Hooks und Zod-Schemata abgeleitet. Eine Änderung der Schnittstellenbeschreibung wird dadurch an einer zentralen Stelle vorgenommen und anschließend durch erneute Generierung in die abhängigen Module übertragen. Für zusätzliche Operationen ergibt sich ein wiederholbares Vorgehen: den Vertrag ergänzen, die Schnittstellenmodule erzeugen und die zugehörigen Handler sowie ihre fachliche Verarbeitung implementieren. Oberflächenabläufe, Geschäftslogik und Berechtigungsprüfungen bleiben dabei gesonderte Entwicklungsaufgaben. @StudyPlanApiMigration2026

Die eigenen Generator-Skripte bündeln die Regeln zur Abbildung des übernommenen Vertrags auf Operationskennungen, strukturierte IPC-Eingaben und die gemeinsame Ergebnisbehandlung. Diese Regeln werden damit für alle eingeschlossenen Operationen nach demselben Verfahren angewendet. Die Entscheidung verbindet die Wiederverwendung des Ausgangsvertrags nach A3 mit der Erweiterbarkeit nach A8 und einem nachvollziehbaren Vorgehen nach A9. Sie begründet sich durch die konsistente Pflege und wiederholbare Transformation der Schnittstellen; ein geringerer Gesamtaufwand gegenüber einer manuellen Übernahme wurde nicht quantitativ nachgewiesen.

Das Architekturziel ist eine verbindliche, gemeinsam definierte und typisierte Schnittstelle zwischen Renderer und Main-Prozess. Beide Seiten hängen von diesem Vertrag ab. Die fachliche Implementierung bleibt im Main-Prozess und wird vom Renderer über die festgelegten Aufrufe angesprochen. Diese Bindung an einen gemeinsamen Vertrag unterstützt die Trennung der Verantwortlichkeiten und ihre unabhängige Prüfung im Sinne von A2.

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

OpenAPI ist als Standard zur Beschreibung von HTTP-APIs definiert. @OpenApi310 Die hier entwickelte Nutzung für IPC ist eine projektspezifische Übersetzung ausgewählter Vertragsbestandteile. Methoden und Pfade bleiben als Metadaten erhalten; die tatsächliche Weiterleitung verwendet die Operationskennung. Der Generator unterstützt die im Projekt benötigten Schemakonstrukte und lokale Referenzen, beansprucht aber keine vollständige Umsetzung sämtlicher OpenAPI-Funktionen. Beispielsweise weist er rekursive Komponentenschemata zurück. Die Wiederverwendung des Vertrags ist deshalb ein belegtes Prinzip dieses Falls und kein Nachweis allgemeiner HTTP- oder OpenAPI-Kompatibilität des IPC-Transports. @StudyPlanApiMigration2026

=== Übernahme der React-Oberfläche in den Renderer <sec:frontend-migration>

Nach der Vorbereitung der Datenhaltung und der Schnittstelle wurde die Oberfläche des Ausgangsartefakts in den Electron-Renderer übernommen. Damit wurde die bei der Projektinitialisierung gewählte Kombination aus React, TypeScript und Vite praktisch aufgegriffen. Als Ausgangspunkt diente `artifacts/studienplaner/`. Die vorhandenen Seiten, das Anwendungslayout, die UI-Komponenten sowie die Hilfsmodule unter `hooks/` und `lib/` wurden in `src/renderer/src/` überführt. Hierzu gehören beispielsweise die Badge-, Formular- und Dialogkomponenten sowie die Seiten für Dashboard, Kalender, Noten und Stundenplan. Die Übernahme ist im Commit `f4ea658` dokumentiert. @StudyPlanFrontendMigration2026

Auch `App.tsx` und der React-Einstiegspunkt `main.tsx` wurden übernommen. Die vorhandene Einbindung von React Query über `QueryClientProvider` sowie die Anbieter für Tooltips und Benachrichtigungen blieben als Grundlage der Oberfläche erhalten. Die Darstellungsstruktur konnte dadurch weitgehend als vorhandener React-Code weiterverwendet werden; die folgende Integration betraf insbesondere Modulauflösung, Datenzugriffe und Navigation. @StudienplanerSource2026 @StudyPlanFrontendMigration2026

Für die Gestaltung wurde die Web-Stylesheet-Datei `index.css` übernommen und weiterhin in `main.tsx` importiert. Sie enthält die Theme-Variablen sowie die Einbindung von Tailwind CSS, `tw-animate-css` und dem Typografie-Plugin. Die Dateien `assets/main.css` und `assets/base.css` gehörten dagegen zur Electron-Vorlage und wurden zusammen mit deren Beispielkomponenten und Grafiken entfernt. Sie sind somit kein zusätzlich übernommener Bestandteil der Web-Oberfläche. @StudyPlanFrontendMigration2026

Beim anfänglichen Kopieren gelangten außerdem die eigenständige `package.json`, `vite.config.ts`, `tsconfig.json`, `components.json` und eine zusätzliche `index.html` in den Renderer-Quellcodeordner. Nach dem Abgleich mit der Electron-Projektstruktur wurden diese Dateien im Commit `8b9bd66` entfernt. Der HTML-Einstiegspunkt liegt in der Zielanwendung unter `src/renderer/index.html`; Paketdefinitionen und Build-Konfiguration werden durch die vorhandenen Dateien des Electron-Projekts verwaltet. Die kopierten Konfigurationen dienten damit als Grundlage für den Abgleich, wurden aber nicht als zweites Frontend-Projekt weiterbetrieben. @StudyPlanFrontendMigration2026

=== Abgleich von Build-Konfiguration und Frontend-Abhängigkeiten

Der Konfigurationsabgleich unterschied die für die Darstellung erforderlichen Einstellungen von der ursprünglichen Web-Bereitstellung. Die Web-Vite-Konfiguration enthielt neben React und Tailwind auch Replit-spezifische Entwicklungsplugins, die Umgebungsvariablen `PORT` und `BASE_PATH` sowie Einstellungen für den Webserver und dessen Ausgabeverzeichnis. Diese Bereitstellungsvorgaben wurden für den Electron-Renderer nicht übernommen. @StudienplanerSource2026 electron-vite verwaltet die Konfigurationen für Main, Preload und Renderer in einer gemeinsamen Datei; seine Renderer-Konfiguration verwendet standardmäßig `src/renderer` als Projektwurzel und die dortige `index.html` als Einstiegspunkt. @ElectronViteConfig2026

Für die übernommenen lokalen Imports war der Alias `@` anzupassen. Im Commit `ceccf8f` wurde in `electron.vite.config.ts` unter `renderer.resolve.alias` der Eintrag `'@': resolve('src/renderer/src')` ergänzt. Parallel wurde in `tsconfig.web.json` die Zuordnung `@/*` zu `src/renderer/src/*` eingerichtet. Der bereits vorhandene Alias `@renderer` blieb erhalten. Damit konnten Imports wie `@/components/ui/badge` nach dem Verschieben der Dateien unverändert verwendet werden. @StudyPlanFrontendMigration2026 Beide Zuordnungen erfüllen unterschiedliche Aufgaben: Vite löst die Module für den Build auf; TypeScript verwendet `paths` für seine Modul- und Typprüfung. Die TypeScript-Einstellung allein schreibt die ausgegebenen Importpfade nicht um. @TypeScriptPaths2026

Für die Verarbeitung der übernommenen Styles wurde im Renderer-Bereich von `electron.vite.config.ts` das Plugin `@tailwindcss/vite` importiert und mit `tailwindcss()` neben `react()` registriert. Diese Anpassung befindet sich ebenfalls im Commit `f03ab7f`, dient jedoch der CSS-Verarbeitung und ist von den dort vorgenommenen Generatoränderungen zu unterscheiden. @StudyPlanFrontendMigration2026 Die Kombination aus Vite-Plugin und Tailwind-Import in der CSS-Datei entspricht dem dokumentierten Integrationsweg für Tailwind CSS. @TailwindVite2026 Zusätzlich wurde die Vite-Typreferenz in `src/renderer/src/env.d.ts` wieder eingerichtet. @StudyPlanFrontendMigration2026

Die benötigten Frontend-Pakete wurden anhand der Paketdefinition des Ausgangsartefakts und seiner Abhängigkeitsauflösung in das Electron-Projekt aufgenommen. Dazu zählen die Radix-UI-Pakete der übernommenen shadcn/ui-Komponenten, `clsx`, `class-variance-authority` und `tailwind-merge` für die Gestaltung sowie React Hook Form, dessen Resolver, React Query, `date-fns`, Lucide und Wouter. Die shadcn/ui-Komponenten liegen dabei als übernommene Quelldateien im Projekt vor. Die Paketdefinition des Electron-Projekts wurde ergänzt; die kopierte Frontend-`package.json` konnte anschließend entfallen. Das Ausgangsartefakt verwendet `pnpm-lock.yaml`, während das Zielprojekt seine installierten Abhängigkeiten in `package-lock.json` festhält. Die Abhängigkeitsauflösung wurde daher im Zielprojekt neu erstellt. @StudienplanerSource2026 @StudyPlanFrontendMigration2026

=== Anbindung der übernommenen Seiten und Anpassung der Datumswerte

Die bisherigen Imports aus `@workspace/api-client-react` wurden in den Seiten und im Layout durch Imports aus `@/api` ersetzt. Dieses Modul exportiert die für IPC erzeugten Hooks und zugehörigen Typen. Die Generatoranpassungen aus @sec:api-contract-migration ermöglichten, vorhandene Hook-Namen und typische Aufrufmuster beizubehalten. Beispielsweise blieb die Verwendung von `useListEvents(monthParams)` beziehungsweise einer Mutation mit `{ data: ... }` erhalten. Die Änderung des Imports allein genügte allerdings dort nicht, wo sich die Datendarstellung an der Schnittstelle änderte. @StudyPlanFrontendMigration2026

Dies zeigt der Commit `ce275e4` an `src/renderer/src/pages/kalender.tsx`. Während der Web-Client Datumswerte als Strings bereitstellte, verwenden die generierten Desktop-Typen und Zod-Schemata `Date`-Werte. In `eventsForDay` wurde deshalb `parseISO(e.startDate)` durch `new Date(e.startDate)` ersetzt; dieselbe Anpassung erfolgte für das Enddatum. Bei der Formularübermittlung werden die eingegebenen Datumsstrings mit `new Date(...)` in die erwarteten Werte umgewandelt. Abfragegrenzen werden als `Date` übergeben, und bereits vorhandene Datumswerte können unmittelbar formatiert oder über `getTime()` sortiert werden. Das Dashboard wurde entsprechend angepasst. Die Änderungen betreffen damit die Schnittstellenwerte und deren Verarbeitung, während die bestehende Darstellungsstruktur erhalten bleibt. @StudyPlanFrontendMigration2026

Im selben Arbeitsschritt wurden ungenutzte Imports, Variablen und Zustandseinträge entfernt. Diese Bereinigung änderte den fachlichen Ablauf der betreffenden Seiten nicht. Sie war jedoch auch für die Typprüfung relevant: Die ursprüngliche TypeScript-Basiskonfiguration setzte `noUnusedLocals` auf `false`, während die vom Electron-Projekt geerbte Toolkit-Konfiguration `noUnusedLocals` und `noUnusedParameters` aktiviert. @StudienplanerSource2026 @StudyPlanFrontendMigration2026 TypeScript meldet bei aktiviertem `noUnusedLocals` ungenutzte lokale Deklarationen als Fehler. @TypeScriptUnused2026 Die Bereinigung ist daher im untersuchten Projekt nicht ausschließlich eine Frage des Programmierstils.

Noch nicht überführt waren damit alle Datenzugriffe der Oberfläche. Insbesondere enthielten die kopierten Kalender- und Notenseiten direkte HTTP-Aufrufe für Dateiimporte, die nicht über die generierten Hooks liefen. Ihre Anpassung wird bei der Umsetzung der entsprechenden fachlichen Operationen behandelt. Aus der Übernahme der Seiten und ihrer Hook-Anbindung folgt somit noch keine vollständig offline nutzbare Kernanwendung. @StudienplanerSource2026 @StudyPlanFrontendMigration2026

=== Anpassung der Navigation an lokale Renderer-Ressourcen

Für die Navigation wurde das bereits verwendete Paket `wouter` beibehalten. Im Web-Prototyp erhielt dessen Router den aus `import.meta.env.BASE_URL` abgeleiteten Basispfad. Im Authentifizierungscommit `1c1988d` wurde stattdessen `useHashLocation` aus `wouter/use-hash-location` eingebunden und mit `<WouterRouter hook={useHashLocation}>` aktiviert. @StudyPlanFrontendMigration2026 Der Hook verwendet den Teil der Adresse hinter `#` als Anwendungsroute. @WouterHashRouting2026 Eine Seite wie `/kalender` kann dadurch innerhalb der geladenen Renderer-Ressource als `#/kalender` adressiert werden. Der Pfad der lokalen HTML-Datei bleibt bestehen, während Wouter die Seitenauswahl übernimmt. Die vorhandenen React-Routen und Navigationskomponenten konnten auf dieser Grundlage weiterverwendet werden. @StudyPlanFrontendMigration2026

=== Lokale Authentifizierung als erster vollständiger Verarbeitungspfad

Nach der Übernahme der Oberfläche begrenzte der vorhandene Anmeldeablauf zunächst den Zugang zu den fachlichen Seiten. Das Layout ruft `useGetMe` auf und setzt einen zugeordneten Benutzer voraus. Für die weitere Entwicklung wurde die Anmeldung deshalb beibehalten und als erste Handlergruppe implementiert. Damit konnte der bereits vorbereitete Aufrufweg zwischen Oberfläche, Preload, Dispatcher und lokaler Datenhaltung an einem zusammenhängenden Ablauf genutzt werden. Dieser Schritt ist im Commit `1c1988d` dokumentiert. @StudyPlanLocalAuth2026

Die Umsetzung gliedert die Verantwortlichkeiten in drei Teile. `src/main/ipc/handlers/auth.handlers.ts` ordnet die Operationen `register`, `login`, `logout` und `getMe` den fachlichen Aufrufen zu und übersetzt deklarierte Fehler in das gemeinsame API-Fehlerformat. `src/main/services/auth.service.ts` implementiert Registrierung, Passwortprüfung und Benutzerzuordnung. `src/main/repositories/users.repository.ts` übernimmt die Benutzerabfragen und das Anlegen der Datensätze über Drizzle. Beim Anwendungsstart werden Repository und Dienste nach der Datenbankinitialisierung erzeugt und ihre Handler beim Dispatcher registriert. Damit wird die in A2 verlangte Trennung von Schnittstellenverarbeitung, Fachlogik und Datenzugriff erstmals für eine vollständige Operationsgruppe umgesetzt. @StudyPlanLocalAuth2026

Für das Hashen und Vergleichen der Passwörter wurde das bereits im Web-Backend verwendete Paket `bcryptjs` mit dem dort angegebenen Versionsbereich `^3.0.3` übernommen. Passwort-Hashes bleiben im Main-Prozess und in der lokalen Benutzertabelle; die Oberfläche erhält nur die vorgesehenen Benutzerdaten. An die Stelle der HTTP-Sitzung tritt `SessionService`, der die aktuelle Benutzerkennung im Main-Prozess hält. Diese lokale Sitzung liegt im Arbeitsspeicher und endet beim Beenden der Anwendung; die Benutzerdatensätze bleiben dagegen in der SQLite-Datenbank gespeichert. Die lokale Anmeldung ist von der später ergänzten Authentifizierung gegenüber entfernten Kollaborationsdiensten zu unterscheiden. @StudienplanerSource2026 @StudyPlanLocalAuth2026

Im Renderer wurden erfolgreiche Anmeldungen und Registrierungen mit dem React-Query-Cache verbunden: Der bisherige Cache wird geleert und die zurückgegebene Benutzerinformation unter dem Query Key von `getMe` gespeichert. Anschließend erfolgt die Navigation zur Anwendung. Der Fehlercode `UNAUTHENTICATED` führt im Layout zur Anmeldung und wird von der Wiederholungslogik der Queries ausdrücklich berücksichtigt; andere Ladefehler erhalten eine gesonderte Anzeige mit erneuter Abfragemöglichkeit. Auch die Weiterleitung nach einer bereits bestehenden Anmeldung wurde in einen React-Effekt verlagert. Diese Änderungen ergänzen die Übernahme der Oberfläche um die Behandlung des lokalen Sitzungs- und Fehlerzustands. @StudyPlanLocalAuth2026

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

=== Wiederkehrender Verarbeitungspfad und fachliche Prüfung

Für die integrierten CRUD-Funktionen ergibt sich der Aufrufweg *Formular → Hook → Preload/IPC → Dispatcher → Handler → Service → Repository → SQLite*. Bei der Notenerfassung übermittelt die vorhandene Seite beispielsweise die Formulardaten über `useCreateGrade` beziehungsweise `useUpdateGrade`. Der generierte Hook bildet die Eingabe auf den IPC-Vertrag ab. Nach Prüfung und Ausführung gelangt das Ergebnis über den Dispatcher und den API-Client zurück zum Hook. Die Oberfläche aktualisiert anschließend die Abfragen für Notenliste und Statistik. @StudyPlanGradesMigration2026

Diese Grundstruktur kann für weitere CRUD-Bereiche erneut angewandt werden. Dabei sind jeweils die zugehörigen Vertragsdefinitionen, fachlichen Regeln, Datenzugriffe und Berechtigungen zu berücksichtigen. Die Wiederholung betrifft die Verteilung der Verantwortlichkeiten und den Kommunikationsweg; die Berechtigungsregeln gemeinsamer Gruppenressourcen sind gesondert von der persönlichen Datenzuordnung zu prüfen. Die Struktur konkretisiert damit A2 und das in A8 geforderte Erweiterungsmuster.

Mit der Notenimplementierung wurde `scripts/grades/grades.test.ts` ergänzt. Der Testaufbau verbindet den generierten API-Client mit Dispatcher, Handlern, Service und Repositories sowie einer SQLite-Datenbank im Arbeitsspeicher. Geprüft werden unter anderem Sitzungsanforderungen, benutzerbezogene Auswahl, Änderungen und Aktivitätseinträge, Statistikberechnung sowie der Umgang mit fremden Datensätzen. Der Transport ruft den Dispatcher im Test direkt auf und ersetzt damit die native IPC-Kommunikation. Die Tests prüfen folglich den fachlichen Verarbeitungspfad und seine Datenzugriffe; sie sind keine automatisierten Oberflächen- oder Electron-Laufzeittests. @StudyPlanGradesMigration2026

=== Migration des iCal-Dateiimports <sec:file-import-migration>

Dateiimporte ergänzen die CRUD-Operationen um eine weitere Interaktionsform. Ihr Migrationsmuster wird anhand des iCal-Imports im Commit `fe08220` beschrieben. Im Web-Prototyp wählte die Kalenderseite eine Datei über ein HTML-Dateifeld aus und übermittelte sie als `FormData` mit `fetch` an `/api/events/import-ical`. Im Express-Backend nahm Multer den Upload entgegen. Der Route-Handler las den Inhalt, interpretierte die Kalenderdaten und schrieb die daraus abgeleiteten Termine unmittelbar in die Datenbank. @StudienplanerSource2026 @StudyPlanIcalMigration2026

In der Desktop-Anwendung wurde diese Upload-Verarbeitung in eine lokale Importoperation überführt. Hierfür wurde der OpenAPI-Vertrag um `importEventsIcal` und das Ergebnisschema `EventIcalImportResult` ergänzt. Anschließend wurden Client, Hook und Validierungsschemata neu erzeugt. Die Operation besitzt keine Dateipfad- oder Inhaltsparameter: Der Renderer löst über `useImportEventsIcal` die Auswahl aus, während der Main-Prozess die Datei ermittelt und verarbeitet. Damit wird die in @sec:api-contract-migration beschriebene zentrale Vertragspflege an einer zusätzlichen Schnittstelle angewandt. @StudyPlanIcalMigration2026

Die Dateiauswahl übernimmt `NativeIcalFilePicker` im Main-Prozess. Er verwendet `dialog.showOpenDialog` mit einem Filter für ICS-Dateien und bindet den Dialog, sofern verfügbar, an das aus dem IPC-Absender ermittelte Anwendungsfenster. @StudyPlanIcalMigration2026 Electron liefert aus diesem Dialog die ausgewählten Pfade beziehungsweise einen Abbruchzustand zurück. @ElectronDialog2026 Der Pfad bleibt innerhalb der nativen Auswahl und wird nicht vom Renderer als frei wählbares Argument übergeben. Die Implementierung prüft die Endung `.ics`, den regulären Dateityp und eine Größenobergrenze von 10 MiB vor sowie nach dem Einlesen. Anschließend stellt sie den Inhalt als UTF-8-Text für die Verarbeitung bereit. @StudyPlanIcalMigration2026

Die Interpretation der Kalenderdaten wurde in `src/main/services/events-ical.parser.ts` ausgelagert. Das Modul verwendet weiterhin `node-ical`, prüft die grundlegende Kalenderstruktur und bildet verwertbare `VEVENT`-Einträge auf interne Termindaten ab. Fehlende Titel oder ungültige Datumswerte führen zum Überspringen der betreffenden Einträge; diese werden gezählt. Aus der ursprünglichen Verarbeitung wurden unter anderem die Ableitung des Termintyps aus dem Titel und eine Standarddauer bei fehlendem Enddatum übernommen. Der Parser erzeugt die Termindaten ohne Benutzerkennung und ohne Datenbankzugriff. @StudienplanerSource2026 @StudyPlanIcalMigration2026

`EventsService.importEventsIcal` übernimmt die fachliche Verarbeitung der Parserausgabe. Der Service ergänzt die aus der Sitzung stammende Benutzerkennung, übergibt die Datensätze an `EventsRepository.createManyEvents` und veranlasst den Aktivitätseintrag zum Import. Dateiauswahl, Formatinterpretation, fachliche Zuordnung und Datenzugriff erhalten dadurch getrennte Zuständigkeiten. Beim Start wird der native Picker als Abhängigkeit an `createEventsHandlers` übergeben. Die Schnittstelle `IcalFilePicker` ermöglicht zugleich, die Dateiauswahl in Tests durch eine geeignete Implementierung zu ersetzen. @StudyPlanIcalMigration2026

=== Ergebnisbehandlung und Prüfung des Dateiimports

Für den Import wurde eine ausdrückliche Ergebnisbehandlung eingerichtet. Ein erfolgreicher Import liefert `status: imported` sowie `importedCount` und `skippedCount`. Ein abgebrochener Dateidialog liefert `status: cancelled` mit beiden Zählwerten `0` und verändert den Datenbestand nicht. Ungültige Dateiauswahl oder Kalenderinhalte werden im Handler über die vorgesehenen Fehlerklassen in `VALIDATION_ERROR` und die deklarierte Fehlerantwort überführt. Diese Ergebnisse durchlaufen denselben Dispatcher und API-Client wie die CRUD-Operationen. @StudyPlanIcalMigration2026

In der Kalenderseite ersetzt der generierte Mutation-Hook den direkten HTTP-Aufruf und das HTML-Dateifeld. Während der Operation wird der Importknopf über `isPending` deaktiviert. Nach einem erfolgreichen Import wird die Terminanfrage invalidiert; die Oberfläche zeigt die Anzahl importierter und gegebenenfalls übersprungener Einträge an. Ein Abbruch beendet den Ablauf ohne Erfolgsmeldung, während ein Fehler gesondert angezeigt wird. Die ursprüngliche Upload-Oberfläche wird damit zu einem Auslöser für die im Main-Prozess ausgeführte lokale Importfunktion. @StudyPlanIcalMigration2026

Die vorhandenen Termintests wurden um Parserfälle, den Import für den angemeldeten Benutzer, den Aktivitätseintrag, den Dialogabbruch und ungültige Kalenderinhalte ergänzt. Eine Testimplementierung von `IcalFilePicker` liefert dabei vorgegebene Inhalte oder einen Abbruchzustand. Dadurch lassen sich Parser, Handler, Service und Repository unabhängig von der nativen Dialogoberfläche prüfen. Die tatsächliche Dialoginteraktion und die Prüfungen beim Lesen einer realen Datei werden durch diesen Testaufbau nicht ausgeführt; ihre Bewertung ist vom fachlichen Importtest zu unterscheiden. @StudyPlanIcalMigration2026

=== CSV als ergänzende Anwendung des Importmusters

Der CSV-Notenimport aus Commit `d37f1b5` verwendet dieselbe Aufteilung in nativen Dateipicker, Import-Handler, Service und Repository. Die Formatverarbeitung übernimmt hier der eigene Parser `grades-csv.parser.ts`, der Spalten erkennt und unter anderem Trennzeichen, zitierte Felder und Dezimalkommas verarbeitet. Die Vertragsoperation `importGradesCsv` und der erzeugte Hook liefern entsprechend den Import- oder Abbruchstatus sowie Zählwerte. CSV zeigt damit, dass das beschriebene Importmuster sowohl eine eingebundene Parserbibliothek als auch einen eigenen Parser aufnehmen kann. @StudyPlanCsvMigration2026

=== Einordnung der lokalen Funktionsmigration

Die Notenverwaltung und die Dateiimporte zeigen zwei vollständige lokale Verarbeitungspfade auf Grundlage der übernommenen Oberfläche. Weitere persönliche CRUD-Funktionen verwenden dieselbe Verteilung auf Handler, Services und Repositories; die Dateiimporte ergänzen sie um begrenzte native Dateiauswahl und gesonderte Formatverarbeitung. Die Beispiele erläutern damit wiederkehrende Transformationsschritte, ohne jede Funktion einzeln zu beschreiben. Für den Zielzustand der ersten Phase bleibt der Kontrollpunkt auf den gesamten eingeschlossenen Kernumfang zu beziehen. Die resultierende Struktur des Demonstrators ist in seiner technischen Architekturdokumentation beschrieben. @StudyPlanArchitecture2026

Der Kontrollpunkt dieser Phase betrifft A1, A2, A4 und A5: Die Anwendung muss lokal starten, die vorgesehenen Kernabläufe müssen ohne Netzwerkverbindung funktionieren und Änderungen müssen persistent sein. Für A3 und A8 wird zugleich festgehalten, welche Komponenten weiterverwendet wurden und welche Verhaltensänderungen durch die Transformation entstanden sind.

== Phase 2: Von der Offline-Kernanwendung zur Local-First-Kollaboration

Die zweite Phase ergänzt gezielt Funktionen, die eine Verbindung zu entfernten Diensten benötigen. Die lokale Kernanwendung bleibt dabei die Grundlage. Local-First bedeutet für den hier untersuchten Aufgabenbereich, dass eine Änderung zunächst lokal verarbeitet werden kann und ihre Übermittlung als nachgelagerter Vorgang erfolgt. Die Phase verfolgt keinen Anspruch auf vollständige Umsetzung sämtlicher Local-First-Eigenschaften.

Im Demonstrator besitzt der synchronisierte Gruppenbereich eine eigene lokale PowerSync-Datenbank. Diese ist von der Datenbank für persönliche Daten und ursprüngliche lokale Gruppen getrennt. Aufgabenänderungen werden in dieser lokalen Datenbank gespeichert und anschließend über den Connector an den entfernten Dienst übermittelt. Für die Zusammenarbeit werden Supabase und PowerSync eingesetzt. Die vorhandenen lokalen Gruppen werden nicht automatisch in den synchronisierten Bereich überführt.

Nicht jede Operation dieses Bereichs ist offline ausführbar. Gruppenanlage, Profilsuche und Einladungsoperationen benötigen im vorhandenen Entwurf eine Online-Anfrage. Auch die Voraussetzungen der Anmeldung sind zu berücksichtigen: Die entfernte Sitzung wird im Demonstrator im Arbeitsspeicher gehalten, sodass nach einem Neustart eine erneute Anmeldung erforderlich ist. @StudyPlanArchitecture2026 Aus der lokalen Speicherung von Aufgaben folgt daher keine uneingeschränkte Offline-Verfügbarkeit des gesamten Kollaborationsbereichs.

Zusätzlich zur Synchronisierung werden weitere Online-Anbindungen separat behandelt. Beim Studiengangkatalog ruft der Main-Prozess externe Daten ab, validiert deren Felder und übernimmt sie in die lokale Datenbank. Scheitert die Aktualisierung, bleiben bereits lokal vorhandene Katalogdaten verfügbar. @StudyPlanCatalog2026 Dieser Ablauf ist ein Download mit lokalem Datenbestand und keine Synchronisierung gemeinsam bearbeiteter Aufgaben.

Der Kontrollpunkt dieser Phase betrifft insbesondere A6 und A8. Für Aufgaben sind der lokale Abschluss einer Änderung und ihre spätere Übernahme im Kollaborationsablauf getrennt zu beobachten. Bei unmittelbar netzwerkabhängigen Operationen sind Fehlermeldung und Verhalten ohne Verbindung auszuweisen. Bereits lokal verfügbare Funktionen dürfen durch den Ausfall einer zusätzlichen Online-Anbindung nicht unnötig blockiert werden.

== Phase 3: Prüfung und Härtung der vervollständigten Anwendung

Nach der funktionalen Umsetzung wird die Gesamtheit der entstandenen Schnittstellen geprüft. Dazu gehören IPC-Eingänge, lokale Ressourcen, Navigationsmöglichkeiten und externe Kommunikationspfade. Die Electron-Sicherheitscheckliste bildet den festgelegten Bezugsrahmen. @ElectronSecurity2026 Für jede Empfehlung werden Anwendbarkeit, erforderliche Maßnahme, konkreter Beleg und verbleibende Nachweisgrenze dokumentiert.

Die im Demonstrator vorgesehenen Maßnahmen betreffen unter anderem deaktivierte Node-Integration im Renderer, Context Isolation, Renderer-Sandboxing, eine restriktive Content Security Policy und die Begrenzung von Navigation sowie zusätzlichen Fenstern. IPC-Absender und fachliche Eingaben werden im Main-Prozess geprüft. Für externe Dienste sind die zugelassenen Verbindungsziele und ihre Transportkonfiguration zu kontrollieren. Paketbezogene Einstellungen sind am gebauten Artefakt zu prüfen, sofern sie Bestandteil der jeweiligen Empfehlung sind.

Der Kontrollpunkt ist A7. Ein Konfigurationseintrag, ein Unit-Test und eine beobachtete Laufzeitwirkung liefern unterschiedliche Nachweise und werden entsprechend ausgewiesen. Für SDK-interne Netzwerkpfade wird keine Prüfung behauptet, die tatsächlich nicht durchgeführt wurde. Die konsolidierte Projektmatrix dokumentiert insbesondere die begrenzte Bewertung der PowerSync-Redirectbehandlung; diese Nachweisgrenze ist bei der Ergebnisdarstellung zu übernehmen. @StudyPlanSecurity2026

== Ausarbeitung der einzelnen Migrationsschritte

Die Phasenübersicht legt die Struktur des Leitfadens fest. Für die abschließende Ausarbeitung ist jeder Transformationsschritt mit seinem konkreten Ausgangszustand, der vorgenommenen Änderung und dem zugehörigen Beleg zu verbinden. Architekturentscheidungen und Kontrollpunkte müssen auf die Anforderungen A1–A9 zurückgeführt werden können. Eine Phasenbeschreibung allein ersetzt diese Dokumentation noch nicht.

// Arbeitsstand: Phase 1 ist mit Datenhaltung, API-Schnittstelle, Renderer,
// Authentifizierung sowie exemplarischen CRUD- und Importpfaden ausgearbeitet.
// Phase 2 und Phase 3 sind bislang als Phasenübersicht beschrieben.
// Noch ergänzen: deren Prozessbericht und die daraus abgeleiteten Empfehlungen.
