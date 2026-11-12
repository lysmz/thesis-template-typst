//---------------------------------------------------------------------
= Theoretischer Hintergrund <ch:data>
//---------------------------------------------------------------------

== KI-gestützte Entwicklungsplattformen und Softwarequalität <sec:theory-ai-quality>

KI-gestützte Entwicklungsplattformen (beispielsweise Replit oder Lovable) ermöglichen im Kontext dieser Arbeit die Generierung und iterative Überarbeitung von Anwendungscode auf Basis natürlicher Sprache.
Das resultierende Softwareartefakt umfasst typischerweise den ausführbaren Programmcode, zugehörige Konfigurationen sowie notwendige Abhängigkeiten.
Diese Systeme ordnen sich in ein neuartiges Programmierparadigma ein, das in der Fach- und Praxisdiskussion häufig unter dem Begriff des sogenannten _Vibe Coding_ zusammengefasst wird.

Architektonisch basieren entsprechende Plattformen meist auf einem orchestrierenden KI-Agenten, welcher eingehende Nutzerprompts an spezialisierte Subagenten delegiert.
Diese Subagenten interagieren mit Repositories, nutzen domänenspezifische Logiken und sind an geschlossene virtuelle Laufzeit- sowie Debugging-Umgebungen angebunden.

Für den weiteren Verlauf dieser Arbeit ist dabei wesentlich, dass die Plattformen im Kern auf Large Language Models (LLMs) aufbauen.
Zwar verfügen sie über integrierte Werkzeuge zur automatisierten Fehlerkorrektur und zur grundlegenden Sicherheitsanalyse, diese Validierungen beziehen sich jedoch primär auf die Laufzeitumgebung der jeweiligen Plattform.
Spezifische Anforderungen oder Folgeprobleme, die sich bei einer Migration der Artefakte in externe Produktionsumgebungen ergeben, werden durch diese internen Prüfmechanismen folglich nur unzureichend antizipiert.

Vor diesem Hintergrund müssen die sichtbare Funktionalität und die inhärente Softwarequalität getrennt voneinander bewertet werden: Ein fehlerfreier Durchlauf auf der Benutzeroberfläche belegt lediglich das Funktionieren einer konkreten Interaktion.
Ob darüber hinaus Sicherheitsvorgaben (wie das Prinzip der geringsten Rechte bei Datenzugriffen) eingehalten, Ausnahmefälle robust behandelt und architektonische Standards für eine nachhaltige Wartbarkeit erfüllt werden, bedarf einer gesonderten technischen Prüfung.

== API-Verträge, Typisierung und Codegenerierung <sec:theory-contracts>

Ein API-Vertrag definiert formal die angebotenen Operationen einer Schnittstelle sowie die erwarteten Datenstrukturen für Anfragen und Antworten.
Einen etablierten Standard stellt hierbei die OpenAPI-Spezifikation dar, welche HTTP-basierte Programmierschnittstellen sprachunabhängig – typischerweise im YAML- oder JSON-Format – abbildet.
Ein entsprechendes Dokument beschreibt unter anderem Endpunkte, HTTP-Methoden, Parameter, Statuscodes sowie wiederverwendbare Datenschemata.
Über die reine Dokumentation hinaus dient die formale Schnittstellenbeschreibung als Grundlage für die automatisierte Generierung nachgelagerter Softwareartefakte @OpenApi310 und fungiert somit als einheitliche Integrationsbasis zwischen verteilten Komponenten.

Werkzeuge zur automatisierten Codegenerierung wie Orval übersetzen OpenAPI-Spezifikationen in typsicheren Programmcode für Frontend- und Backend-Architekturen.
Neben der Reduktion von repetitivem Integrationscode (_Boilerplate Code_) minimiert dieses Vorgehen bei konsistenter Anwendung typische Schnittstellendivergenzen (_Schema Mismatches_), indem Änderungen an der Schnittstellendefinition direkt über das Typsystem in den konsumierenden Anwendungen abgebildet und validiert werden.

== Electron-Laufzeit <sec:theory-electron>

Electron ist ein Open-Source-Framework, das Node.js und die Rendering-Engine Chromium kombiniert, um plattformübergreifende Desktop-Anwendungen mit Webtechnologien zu erstellen.
Das Framework erzwingt architektonisch keine strikten Vorgaben bezüglich des Prozessdesigns oder der internen Kommunikationsflüsse, sodass die Verantwortung für eine sichere Konfiguration von Prozesstrennung, Sandboxing und Kontextisolation primär bei den Entwickelnden liegt.

Grundsätzlich unterscheidet Electron zwischen dem zentralen Main-Prozess mit vollem Zugriff auf Betriebssystemressourcen und einem oder mehreren Renderer-Prozessen, die typischerweise der Benutzeroberfläche dienen.
Getrennte Prozesse begrenzen für sich genommen noch nicht die verfügbaren Systemzugriffe: Durch Optionen wie `nodeIntegration: true` können Node.js-APIs unmittelbar innerhalb des Renderers ausgeführt werden.

Die daraus resultierenden architektonischen Ansätze lassen sich idealtypisch gegenüberstellen:
#figure(
  image("../figures/electron-architecture-comparison.svg", width: 100%),
  caption: [Idealtypischer Vergleich einer isolierten und einer offenen Electron-Konfiguration. Eigene Darstellung auf Grundlage der Electron-Sicherheitsrichtlinien @ElectronSecurity2026.],
) <fig:electron-architecture-comparison>

Ist die Node.js-Integration im Renderer aktiviert, wird dessen Sandboxing deaktiviert. Gelingt es Angreifenden beispielsweise über Cross-Site Scripting (XSS) oder manipulierte externe Inhalte, Schadcode im Renderer auszuführen, können verfügbare Node.js-APIs eine _Remote Code Execution_ (RCE) auf Ebene des Host-Betriebssystems ermöglichen @ElectronSecurity2026.

Um diesen Angriffsvektoren zu begegnen, beschreiben die _Electron-Sicherheitsrichtlinien (Electron Security Guidelines)_ @ElectronSecurity2026 empfohlene Schutzmaßnahmen für die Electron-Laufzeit.
Zu den zentralen Maßnahmen zählen das Deaktivieren der Node.js-Integration im Renderer, das Aktivieren von Sandboxing und _Kontextisolation (Context Isolation)_, restriktive Navigationsregeln und eine _Content Security Policy_ (CSP) sowie die Validierung sämtlicher IPC-Nachrichten und die IPC-Absenderprüfung. Sandboxing beschränkt die Systemzugriffe des Renderer-Prozesses; Kontextisolation trennt den JavaScript-Kontext der Webseite vom Kontext des Preload-Skripts.
Die Richtlinien heben insbesondere hervor, dass die Exposition nativer Systemfähigkeiten gegenüber potenziell unsicherem Web-Code das kritischste Sicherheitsrisiko der Plattform darstellt.

=== Lokale Ressourcen über eigene Protokolle <sec:theory-electron-protocols>

Eine Electron-Anwendung kann ihre Benutzeroberfläche aus lokal ausgelieferten HTML-, JavaScript- und CSS-Dateien laden.
Neben dem direkten Laden über `file://` unterstützt Electron anwendungseigene URL-Schemata, deren Anfragen ein im Main-Prozess registrierter Protokollhandler beantwortet.
Eine Adresse wie `app://bundle/index.html` kann so auf eine lokale Anwendungsdatei abgebildet werden, ohne einen HTTP-Server zu starten.
`app` ist dabei ein frei gewählter Schemaname, dessen Verhalten die Anwendung festlegt @ElectronProtocol2026.

Der Handler bildet einen kontrollierbaren Zugang zu den lokalen Ressourcen: Die Anwendung kann festlegen, welche Adressen auf welche Dateien zugreifen dürfen.
Dazu müssen angeforderte Pfade gegen das vorgesehene Renderer-Ressourcenverzeichnis geprüft werden.
Eigenschaften wie die Behandlung als sicheres oder standardkonformes Schema werden bei der Registrierung ausdrücklich konfiguriert; sie ergeben sich nicht aus dem Namen @ElectronProtocol2026.

=== Navigation über Hash-Routing <sec:hash-routing>

Single-Page-Anwendungen bilden unterschiedliche Ansichten über clientseitige Routen ab.
Im regulären Browserbetrieb kann ein Webserver beim direkten Aufruf oder Neuladen einer solchen Route die zentrale `index.html` ausliefern.
Eine entsprechende Rewriting-Regel ordnet beispielsweise den Pfad `/settings` dieser Einstiegsdatei zu (_Fallback-Routing_).
Das clientseitige Skript wertet anschließend den angeforderten Pfad aus und stellt die zugehörige Ansicht im DOM dar.

In Electron lassen sich die Frontend-Ressourcen dagegen direkt über `file://` von der Festplatte laden, etwa mit `win.loadFile('dist/index.html')`.
Dabei steht keine serverseitige Fallback-Regel zur Verfügung.
Eine pfadbasierte Route kann beim Neuladen deshalb auf eine nicht vorhandene lokale Datei verweisen und einen Ladefehler verursachen, obwohl der vorherige Seitenwechsel innerhalb der bereits geladenen Anwendung funktioniert hat.

Hash-Routing hält die Route im Adressfragment, also hinter dem Zeichen `#`, und vermeidet damit eine Änderung des Ressourcenpfads.
Das Adressfragment wird vor dem Zugriff auf die adressierte Ressource abgetrennt und anschließend clientseitig ausgewertet @RFC3986.
So bleibt die geladene Ressource beim Seitenwechsel gleich; der Router bestimmt anhand des Adressfragments die darzustellende Ansicht @WouterHashRouting2026.

Dieses Verfahren lässt sich sowohl mit `file://` als auch mit einem anwendungseigenen URL-Schema verwenden.
Bei `app://bundle/index.html#/settings` liefert der Protokollhandler die `index.html`, während der Router die Ansicht für `#/settings` auswählt.

=== Paketierung und Electron Fuses <sec:theory-electron-fuses>

Electron-Anwendungen bündeln ihren Programmcode und ihre Ressourcen häufig in einem ASAR-Archiv (`app.asar`).
Electron behandelt dessen Inhalt für viele Dateizugriffe wie ein virtuelles Verzeichnis.
Bestimmte native Module benötigen dagegen reale Dateipfade und werden deshalb außerhalb des Archivs mitgeliefert @ElectronAsar2026.

Electron Fuses sind Schalter in der Electron-Binary, mit denen beim Paketieren Funktionen aktiviert oder deaktiviert werden können.
Dadurch lassen sich unbenötigte Fähigkeiten der ausgelieferten Laufzeit begrenzen.
Beispielsweise steuert `RunAsNode`, ob die Anwendung über die Umgebungsvariable `ELECTRON_RUN_AS_NODE` als Node.js-Prozess gestartet werden kann @ElectronFuses2026.

Weitere Fuses betreffen das Laden des Anwendungscodes und dessen Integrität.
`OnlyLoadAppFromAsar` beschränkt die Suche nach dem Anwendungscode auf `app.asar`.
In Verbindung mit `EnableEmbeddedAsarIntegrityValidation` kann das Archiv beim Laden anhand der im Paket hinterlegten Integritätsinformationen geprüft werden @ElectronFuses2026 @ElectronAsarIntegrity2026.

== Drizzle ORM als Datenzugriffsschicht <sec:theory-persistence>

Drizzle ORM ist ein leichtgewichtiges, typsicheres Object-Relational-Mapping-Werkzeug (ORM) für das TypeScript-Ökosystem.
Die Drizzle-Werkzeugsuite verzichtet im Gegensatz zu traditionellen, monolithischen ORM-Systemen auf umfangreiche Laufzeit-Engines oder externe Binärabhängigkeiten und ist modular aufgebaut.
Diese besteht im Wesentlichen aus der Kernbibliothek für den Datenzugriff sowie einem CLI-Werkzeug für das Schema- und Migrationsmanagement:

- *Drizzle ORM (Kernbibliothek):* Die Datenbankschemata werden deklarativ in TypeScript beschrieben. 
Diese zentrale Schemadefinition bildet die Grundlage für den typisierten Datenzugriff.
  Typdefinitionen für Lese- und Schreiboperationen (`inferSelect`, `inferInsert`) leitet das System automatisch über statische Typinferenz ab, ohne dass ein vorgeschalteter Codegenerierungsschritt erforderlich ist.
  Für Abfragen bietet Drizzle eine SQL-nahe Syntax (z. B. `db.select().from(...).where(...)`), die standardkonforme SQL-Ausdrücke abbildet und eine feingranulare Kontrolle über Joins und Aggregationen ermöglicht.
- *Drizzle Kit (CLI & Migrationsmanagement):* Ergänzend zur Kernbibliothek dient Drizzle Kit der Synchronisation zwischen Code und Datenbanksystem.
  Das Werkzeug erlaubt das automatisierte Generieren von SQL-Migrationsdateien auf Basis von Schema-Differenzen (`generate`) sowie das direkte Synchronisieren des Schemas mit Entwicklungsdatenbanken (`push`), was insbesondere iterative Entwicklungszyklen beschleunigt.

Architektonisch fungiert Drizzle ORM nicht als eigenständiger Datenbanktreiber, sondern setzt als Abstraktionsschicht auf bestehenden Treiber-Ökosystemen auf.
Für den Kontext dieser Arbeit sind insbesondere zwei Datenbankparadigmen relevant:

+ *Dateibasierte und eingebettete Systeme (SQLite):* Über Treiber wie `better-sqlite3` oder libSQL-basierte Lösungen (wie Turso) ermöglicht Drizzle ORM einen performanten, lokalen Datenzugriff innerhalb der Node.js-Laufzeitumgebung des Main-Prozesses.
+ *Client-Server-Datenbanksysteme (PostgreSQL):* Über native Treiber (wie `pg` oder `postgres.js`) bindet Drizzle ORM relationale PostgreSQL-Instanzen an, wobei die identische TypeScript-Schemadefinition beibehalten wird.

Durch diesen modularen Aufbau und den Verzicht auf schwergewichtige Abstraktionen eignet sich Drizzle ORM besonders für hybride Anwendungsszenarien, bei denen datenbanknahe Performanz und statische Typsicherheit bei minimalem Laufzeit-Overhead gefordert sind.

== Local-First-Architekturen und Datensynchronisation <sec:theory-local-first>

Das Architekturparadigma _Local-First_ beschreibt datenintensive Anwendungen, bei denen ein primärer lokaler Datenbestand auf dem Endgerät des Nutzers die lokale Verarbeitung ermöglicht.
Im Gegensatz zu traditionellen _Cloud-First_-Architekturen, bei denen der Client als darstellende Schicht fungiert und Zustandsänderungen synchron über das Netzwerk autorisiert werden müssen, operieren Lese- und Schreibzugriffe bei Local-First primär auf einer lokalen Datenbankinstanz.
Externe Cloud-Dienste dienen hierbei als sekundäre Infrastrukturschicht für Hintergrundsynchronisation, Persistenzsicherung und kollaborative Datenabgleiche.

Grundlegend formalisiert wurde das Konzept von Kleppmann et al. @Kleppmann2019.
Die Autoren beschreiben Local-First als architektonisches Zielbild, das kollaboratives Arbeiten mit lokaler Nutzbarkeit, geringen Latenzen und vollständiger Datenkontrolle vereint.
Zu den zentralen Eigenschaften zählen:
- *Autonome Offline-Verfügbarkeit (_Offline-by-Default_):* Die Kernfunktionalität der Software ist unabhängig vom Vorhandensein einer aktiven Netzwerkverbindung stets uneingeschränkt gegeben.
- *Gleichzeitige Zusammenarbeit (_Multi-User Collaboration_):* Mehrere Clients können parallel Modifikationen an denselben Datenbeständen vornehmen, wobei auftretende Konflikte deterministisch aufgelöst werden.

Bei externen Datenflüssen ist zwischen einer einseitigen Datenübernahme und einer kollaborativen Synchronisation zu unterscheiden: Bei einer einseitigen Datenübernahme werden Referenzdaten bezogen, validiert und lokal gespeichert.
Eine kollaborative Synchronisation erfordert hingegen das kontinuierliche Erfassen lokaler Mutationen, deren asynchrone Übertragung an den Server sowie die Integration entfernter Transaktionen.
Lokaler Schreibabschluss (_Local Commit_) und die Bestätigung der Übernahme durch das Backend finden dabei zeitlich entkoppelt statt @Kleppmann2019.

=== Replikation über PowerSync

Um den komplexen Anforderungen an Konsistenz, Offline-Warteschlangen und Cache-Invalidierung zu begegnen, kommen spezialisierte Synchronisations-Engines zum Einsatz.
PowerSync stellt eine solche Middleware dar, welche eine lokale SQLite-Datenbank auf dem Endgerät (etwa innerhalb einer Electron-Laufzeit) mit einer relationalen Backend-Datenbank abgleicht.
@fig:powersync-replication-flow veranschaulicht das Zusammenspiel der beteiligten Komponenten und die Wege lokaler Änderungen zum Backend und zurück zum Client.

#figure(
  image("../figures/powersync-replication-flow.svg", width: 100%),
  caption: [Zusammenspiel von lokaler Datenhaltung, Backend und PowerSync-Dienst. Eigene Darstellung nach @PowerSyncWritingChanges2026 und @PowerSyncSupabase2026.],
) <fig:powersync-replication-flow>

=== Backend-Infrastruktur mit Supabase

Supabase ist eine quelloffene _Backend-as-a-Service_-Plattform (BaaS).
Ihre PostgreSQL-Datenbank dient als zentrale Backend-Datenbank und Replikationsquelle.
Den Kern bildet eine vollwertige PostgreSQL-Instanz.
Durch die native Unterstützung des PostgreSQL-WAL und des `pgoutput`-Plugins ermöglicht Supabase die direkte Anbindung von Synchronisationsdiensten wie PowerSync.
Gleichzeitig stellt die Plattform automatisierte Schnittstellen und Authentifizierungsmechanismen bereit, womit sie als standardisiertes Backend für die persistente Datenhaltung und Mandantentrennung dient.
