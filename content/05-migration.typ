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

=== Einordnung der weiteren Offline-Migration

Für den vollständigen Zielzustand der ersten Phase müssen die fachlichen Funktionen mit den vorbereiteten Schnittstellen verbunden und die Oberfläche in den Renderer übernommen werden. Die bisherigen Serverfunktionen werden dabei nach ihren Verantwortlichkeiten in Controller beziehungsweise Handler, Services und Repositories gegliedert. Die vorbereitete Datenhaltung und der vertragsbasierte IPC-Aufrufweg bilden die Grundlage für diese weitere Transformation. Die resultierende Struktur des Demonstrators ist in seiner technischen Architekturdokumentation beschrieben. @StudyPlanArchitecture2026

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

// Arbeitsstand: Datenhaltung und Überführung der API-Schnittstelle sind
// als Bericht mit konkreten Belegen und Architekturvergleich ausgearbeitet.
// Die weiteren Transformationsschritte sind bislang als Phasenübersicht beschrieben.
// Noch ergänzen: deren Prozessbericht und die daraus abgeleiteten Empfehlungen.
