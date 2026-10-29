//---------------------------------------------------------------------
= Theoretischer Hintergrund <ch:data>
//---------------------------------------------------------------------

== KI-gestützte Anwendungsentwicklungplatformen und Softwarequalität <sec:theory-ai-quality>

Unter KI-gestützter Anwendungsentwicklungsplatformen [wie Replit und Lovable verstehen wir Platformen die sich darauf spezialisiert haben aus Natürlicher Sprache der Nutzer vollwertige Softwareartefakte (Apps) zu entwickeln] 
wird hier die Erzeugung und Überarbeitung von Anwendungscode anhand sprachlicher Anforderungen verstanden.
Das resultierende Ausgangsartefakt umfasst ausführbaren Code, Konfigurationen und Abhängigkeiten.
Diese Platformen sind Teil eines neuen Programmierparadigma das allgemein teil des Vibe-Coding ist.
Technisch gesehen funktionieren diese Platformen mit einem KI-Agenten Orchestrator der die Anfragen der Nutzer an Subagenten weiterleitet, die mithilfe von Domain Specific Languages Code schreiben; Repositories anlegen und anbindungen an virtuelle Umgebung samt Debugger haben.
Für die Arbeit relevant sind dabei die Fakten das die Platformen im Kern mit LLM arbeiten und auch wenn diese mit Hilfe von Speziellen Tools fehler Selbstständig beheben können und sicherheitsvorgaben überprüfen können, so sind diese fundermental nur für die dortige Umgebung ausgelegt.
Daraus lässt sich auch herausarbeiten das die Platformen die neuen Probleme die bei einer Migration auf eine andere Umgebung erscheinen nicht schon vollumfänglich absehen und dahin gehend lenken können.
Seine sichtbare Funktionalität und seine technischen Eigenschaften sind getrennt zu betrachten: Ein erfolgreicher Oberflächenablauf zeigt zunächst, dass eine bestimmte Interaktion funktioniert.
Ob Datenzugriffe angemessen begrenzt sind, Fehler behandelt werden und die Struktur spätere Änderungen ermöglicht, erfordert weitere Prüfungen.
== API-Verträge, Typisierung und Codegenerierung <sec:theory-contracts>

 ist Ein API-Vertragbeschreibt die angebotenen Operationen und die erwarteten Strukturen ihrer Eingaben und Ergebnisse.
OpenAPI definiert hierfür eine programmiersprachenunabhängige Beschreibung von HTTP-APIs in form einer yml Datei.
Ein OpenAPI-Dokument kann unter anderem Pfade, Operationen, Parameter, Antwortformen und wiederverwendbare Schemata festlegen.
Es kann als Grundlage für Dokumentation und die Erzeugung abhängiger Programmteile dienen @OpenApi310.
Die Definition schafft eine gemeinsame Schnittstellengrundlage für die beteiligten Komponenten.

Orval ist ein Programm das aus einer OpenAPI Specifikation code für Frontend und Backend applicationen in mehreren Frameworks und Programmiersprachen erstellen kann.
Dadurch reduziert sich der Aufwand von Standardcode (Boilerplate) und verhindert bei konsequentem nutzen das riskiko von schnittstellenmissmatchen

== Electron als Desktop-Laufzeit <sec:theory-electron>

Electron ist ein Framework basierent auf Nodejs und Chromium. 
Electron schreibt keine feste Architektur seines Frameworks vor. 
Es ist möglich durch Optionen verschiedene Einstellungen den Internen Flow und Kommunikation von den Prozessen zu beeinflussen.
Eine Strikte Trennung muss vom Entckler selbst eingehalten werden um die sicherheit zu gewährleisten.
Es ist z.B. möglich mit NodeJS integration true NodeJS Schnittstellen direkt im Chromium Browser zu aktivieren. 
Die Electron Security Guidelines sind Guidelines die sich damit beschäftigen welche eigenschaften und settings eine app aktiviert und deaktiviert haben sollten um die Sicherheit zu erhöhen.
<exemplarische Architektur von zwei möglich Aufbauen von Electron apps. 1. mit strikter Trennung Renderer-IPC-Main 2. "all in one der Renderer kann node js ausführen und nimmt daten und links entgegen">
durch eine mangelhafte Trennung kann es dazu führen das Remote-Code Execution direkt auf das Betriebssystem zugreifen könnten und nicht mehr in der Browser Sandbox gefangen sind.

Die Electron Security Guidelines konkretisieren solche Schutzaufgaben für die Laufzeit.
Sie behandeln unter anderem die Begrenzung von Node.js-Zugriffen im Renderer, Context Isolation, Sandboxing, Berechtigungen, Inhalts- und Navigationsbeschränkungen sowie die Validierung von IPC-Absendern.
Die Dokumentation weist ausdrücklich auf die erhöhten Folgen hin, wenn fremder JavaScript-Code Zugriff auf lokale Systemfähigkeiten erhält @ElectronSecurity2026.
=== Navigation über Hashrouting <sec:hash-routing>

Bei einer Single-Page-Anwendung bestimmt ein clientseitiger Router, welche Ansicht gezeigt wird. 
Was der normale Webbrowser macht (https://)
Wenn du im Browser eine SPA (wie z. B. deine Vite-React-App) aufrufst:

Du surfst auf [https://meine-app.de/settings](https://meine-app.de/settings).

Dein Browser schickt eine HTTP-Anfrage an den Webserver: "Gib mir bitte /settings".

Auf dem Webserver (z. B. Nginx, Apache oder Vercel) ist eine Fallback-Regel hinterlegt (Rewriting). Der Server weiß: „Die Datei /settings existiert gar nicht als HTML-Datei, aber das ist eine SPA – ich schicke stattdessen die index.html zurück.“

Dein Browser lädt die index.html, führt React aus, und React Router liest den Pfad /settings aus und zeigt die richtige Ansicht.

Was Electron macht (file://)
In einem Standard-Electron-Build gibt es keinen zwischengeschalteten Webserver:

Electron lädt deine UI mit win.loadFile('dist/index.html'). Die Adresse im Chromium-Fenster lautet jetzt intern z. B. file:///Users/deinName/app/dist/index.html.

Du klickst in der App auf einen Link zu /settings. React Router manipuliert die Anzeigezeile zu file:///Users/deinName/app/dist/settings.

Bis hierhin klappt alles, weil React die Seite einfach im Speicher neu zeichnet.

Jetzt drückst du F5 (Reload):

Chromium fragt nun nicht mehr einen Server mit cleveren Fallback-Regeln, sondern fragt das Betriebssystem-Dateisystem:

„Gibt es auf der Festplatte eine Datei unter /Users/deinName/app/dist/settings?“

Das Dateisystem antwortet: „Nein, hier liegt nur index.html, sonst nichts.“

Ergebnis: 404 / ERR_FILE_NOT_FOUND und ein weißer Bildschirm.

Warum das Hash (#) das Problem löst
Das Dateisystem interpretiert URLs strikt nach Standards: Alles, was hinter einer Raute # steht, ist ein Client-seitiger Anker und wird niemals als Dateipfad gewertet.

URL: file:///Users/deinName/app/dist/index.html#/settings

Wenn du F5 drückst, fragt Chromium das Dateisystem: „Gib mir /Users/deinName/app/dist/index.html“ (alles ab # ignoriert Chromium beim Dateizugriff).

Die Datei index.html existiert -> sie wird geladen.

Sobald dein JavaScript anspringt, sieht der HashRouter das #/settings und rendert die Settings-Seite.
== Lokale Persistenz, Schema und Identität <sec:theory-persistence>

Drizzle (meist als Drizzle ORM bezeichnet) ist ein modernes, leichtgewichtiges und typsicheres Object-Relational Mapping (ORM).
Drizzle ist nicht nur eine einzelne Bibliothek, sondern eine modulare Suite von Werkzeugen:
Drizzle ORM (Der Core)
Der Kern von Drizzle kümmert sich um die Definition von Schemata und das Ausführen von Abfragen:

TypeScript-first & maximale Typsicherheit: Schema-Definitionen in TypeScript dienen direkt als Single Source of Truth. Typen für Insert, Select und Relationen werden automatisch ohne Codegenerierung abgeleitet (inferSelect, inferInsert).

Zwei Abfrage-Paradigmen (nur eine relevant):

SQL-like API: Sieht fast exakt wie normales SQL aus (db.select().from(users).where(...)). Maximale Kontrolle über Joins, Aggregationen etc.

Zero Overhead / Serverless-ready: Drizzle ist extrem schlank, hat keine schwere Engine/Rust-Binaries im Hintergrund, startet in wenigen Millisekunden und eignet sich daher hervorragend für Serverless- und Edge-Umgebungen (wie Cloudflare Workers, Vercel Functions, AWS Lambda).


2. Drizzle Kit (Migrations- & CLI-Tool)
Ein Begleit-CLI-Werkzeug für das Schema-Management:

Automatische Migrationen: Vergleicht dein TypeScript-Schema mit dem aktuellen Zustand und generiert SQL-Migrationsdateien (drizzle-kit generate).

Direktes Anwenden (drizzle-kit push): Überträgt Änderungen am Schema direkt in eine Entwicklungs-Datenbank, ohne vorher Migrationsdateien schreiben zu müssen (ideal fürs Prototyping).

Introspektion (drizzle-kit introspect): Liest eine bestehende Datenbank aus und generiert automatisch das passende Drizzle-TypeScript-Schema (Pull).

Unterstützte Datenbanken und Umgebungen
Drizzle setzt auf bestehende Datenbanktreiber auf und unterstützt:

PostgreSQL: z. B. über node-postgres (pg), postgres.js, Neon Serverless, Vercel Postgres, Supabase.

MySQL: z. B. über mysql2, PlanetScale.

SQLite: z. B. über better-sqlite3, Bun SQLite, Turso (libSQL), Cloudflare D1.

Laufzeitumgebungen: Node.js, Bun, Deno, Cloudflare Workers, Edge-Runtimes.
== Local-First <sec:theory-local-first>

Local-First ist ein Software-Architekturparadigma für datenintensive Anwendungen.
Der Grundsatz lautet: Die primäre Quelle der Wahrheit (Single Source of Truth) liegt auf dem lokalen Gerät des Nutzers.

Im traditionellen Cloud-Modell (Cloud-First) besitzt der Server die Daten; der Client ist nur ein Anzeigeinstrument, das bei jedem Klick übers Netzwerk nach Erlaubnis fragt. 
Bei Local-First liest und schreibt die Anwendung direkt in eine lokale Datenbank auf dem Gerät. 
Die Cloud bzw. der Server fungiert lediglich als sekundäre Schicht für Synchronisation, Backup und Zusammenarbeit.

Das Konzept wurde maßgeblich 2019 durch das Manifest „Local-first software: You own your data, in spite of the cloud“ der Forschungsinitiative Ink & Switch formuliert.

Für uns sind die zwei Aspekte relevant : 
Das Netzwerk ist optional (Offline-by-default)

Eine Local-First-App ist nicht bloß „offline-fähig“ über nachträgliche Caches – sie ist von Grund auf offline lauffähig. 
Alle Kernfunktionen stehen im Flugzeug, im Funkloch oder bei Serverausfällen uneingeschränkt zur Verfügung.

Nahtlose Zusammenarbeit (Collaboration)

Mehrere Personen können gleichzeitig an denselben Dokumenten arbeiten (wie in Google Docs oder Figma). 
Konflikte bei parallelen Änderungen werden automatisch aufgelöst.

Technische Säulen: Wie wird Local-First umgesetzt?
Um diese Aspekte in der Praxis zu realisieren, stützt sich Local-First auf moderne mathematische und architektonische Werkzeuge:

CRDTs (Conflict-free Replicated Data Types):

Spezielle Datenstrukturen (z. B. implementiert in Yjs oder Automerge), die es erlauben, dass mehrere Geräte gleichzeitig offline Änderungen vornehmen. Sobald sie sich verbinden, führen sich die Datenstände mathematisch garantiert ohne manuelle Konflikt-Dialoge konsistent zusammen.

Lokale Datenbanken im Client:

Technologien wie SQLite (z. B. via OPFS im Browser oder direkt nativ in Electron/Tauri), IndexedDB oder RxDB.

Synchronisations-Engines:

Frameworks wie ElectricSQL, Replicache, PowerSync, Zero oder Dexie Cloud, die den Abgleich zwischen lokaler SQLite/IndexedDB und einer Server-Datenbank (z. B. Postgres) übernehmen.

Kleppmann et al. beschreiben Local-First als Zielbild, das Zusammenarbeit mit lokaler Nutzbarkeit und Kontrolle über die eigenen Daten verbindet.
Zu seinen Idealen gehören unter anderem Offline-Nutzung, geräteübergreifender Zugriff, langfristige Verfügbarkeit und Sicherheit beziehungsweise Privatheit.
Die lokale Kopie nimmt dabei eine zentrale Rolle ein; Server können die Verteilung unterstützen @Kleppmann2019.
Local-First umfasst damit weitergehende Ziele als die Verwendung einer lokalen Datenbank.
Welche Eigenschaften eine konkrete Anwendung umsetzt, ist jeweils auszuweisen.

Für externe Datenflüsse ist zwischen Übernahme und Synchronisierung zu unterscheiden.
Bei einer Übernahme in einer Richtung werden Referenzdaten heruntergeladen, geprüft und lokal gespeichert.
Eine Zusammenarbeit mit gemeinsamen Daten benötigt zusätzlich die Übermittlung lokaler Änderungen und die Verarbeitung entfernter Ergebnisse.
Lokaler Schreibabschluss und entfernter Abgleich finden dabei zu unterschiedlichen Zeitpunkten statt.

PowerSync ist eine Sync-Engine für Local-First- und Offline-First-Anwendungen.

Sie ermöglicht es Entwicklern, eine lokale SQLite-Datenbank auf dem Endgerät des Nutzers (Web, Mobile oder Desktop) nahtlos, bidirektional und in Echtzeit mit einer zentralen Backend-Datenbank (wie PostgreSQL, MySQL oder MongoDB) zu synchronisieren.

Das Problem, das PowerSync löst
Klassische Cloud-Anwendungen leiden oft unter Ladezeiten, Netzwerkunterbrechungen und Offline-Problemen:

Bei schlechter Internetverbindung stockt die UI.

Offline funktioniert die App meist gar nicht.

Das nachträgliche Bauen einer eigenen Synchronisationslogik (Konfliktlösung, Cache-Invalidierung, Offline-Warteschlangen) ist extrem komplex und fehleranfällig.

PowerSync löst dies, indem alle Lese- und Schreibzugriffe der App sofort lokal auf einer echten SQLite-Datenbank ausgeführt werden (0 ms Latenz, volle Offline-Fähigkeit). PowerSync kümmert sich im Hintergrund transparent um den Abgleich mit der Cloud.

Wie PowerSync funktioniert (Architektur)
Das System besteht im Wesentlichen aus drei Komponenten:

Client-seitige SQLite-Datenbank:
Auf dem Gerät (z. B. via WebAssembly/OPFS im Browser, native SQLite in Flutter/React Native oder Electron) liegt eine lokale SQLite-Datenbank. Die UI fragt Daten direkt per SQL oder ORM (wie Drizzle) von dort ab.

PowerSync Service (Sync-Schicht):
Ein eigener Dienst (entweder als Managed Cloud-Service oder Open-Source selbst gehostet), der zwischen deiner Hauptdatenbank und den Clients sitzt.

Er lauscht auf Änderungen deiner Backend-Datenbank über Logical Replication (z. B. PostgreSQL WAL / pgoutput).

Über sogenannte Sync Rules (deklarative SQL-Filterregeln) steuerst du serverseitig, welcher Nutzer welche Datenzeilen auf sein Gerät synchronisiert bekommen darf (Partial Replication / Partitionierung).

Dein bestehendes Backend:
Du musst deine bestehende Backend-Infrastruktur nicht wegwerfen:

Downloads / Updates: Werden von PowerSync als Daten-Stream (WebSocket/HTTP-Streaming) effizient an den Client gesendet.

Uploads / Mutations: Wenn der Client Daten ändert, schickt er diese in eine lokale Upload-Queue, die an deine regulären REST-/GraphQL-/RPC-Endpunkte gesendet wird. Dein Server validiert die Daten und schreibt sie in die Hauptdatenbank, woraufhin PowerSync den neuen Zustand streamt.


Wichtigste Merkmale und Vorteile
Echtes SQLite auf dem Client: Du kannst relationale Datenstrukturen, komplexe JOINs, Indizes und Volltextsuche direkt auf dem Gerät ausführen.

Partial Replication (Dynamische Synchronisation): Ein Nutzer lädt nicht die gesamte Unternehmensdatenbank herunter, sondern nur die Tabellen und Zeilen, für die er berechtigt ist (z. B. nur Projekte, denen er zugewiesen ist).

Framework- & Plattform-agnostisch:

Frontend: Flutter, React Native, Web (React, Vue etc.), Kotlin Multiplatform, Swift, Node.js / Electron.

Backend-Datenbanken: PostgreSQL, Supabase, Neon, MySQL, MongoDB u. a.



Supabase ist eine Open-Source-Plattform für Backend-as-a-Service (BaaS) und gilt als die führende Open-Source-Alternative zu Google Firebase.
Die Kernkomponenten von Supabase
Supabase bündelt mehrere Open-Source-Tools zu einer integrierten Plattform:

PostgreSQL-Datenbank: Jedes Projekt erhält eine dedizierte Postgres-Instanz. Du kannst Standard-SQL, gespeicherte Prozeduren, Trigger, Indizes und Erweiterungen (wie pgvector für KI/Embeddings oder PostGIS für Geodaten) ohne Einschränkungen nutzen.

Auto-generierte APIs: Supabase erstellt automatisch typsichere REST- und GraphQL-Schnittstellen direkt aus deinem Datenbankschema (über PostgREST).

Zusammenspiel mit dem Local-First- und Drizzle-Stack
Mit PowerSync: Supabase bietet native Logical Replication (WAL). PowerSync klinkt sich dort ein, um Datenzeilen aus Supabase direkt in lokale SQLite-Datenbanken auf Endgeräten (Mobile, Desktop/Electron, Web) zu replizieren.

== Bestehende Ansätze und Einordnung der Arbeit <sec:theory-positioning>

Es gibt schon arbeiten, aus denen ein Verdacht für sicherheitslücken für KI generierte Apps ableitbar ist. 
Zum Beispiel : Perry et al. untersuchten in einer Studie mit 47 Teilnehmenden fünf sicherheitsbezogene Programmieraufgaben.
Teilnehmende mit Zugang zu einem auf `codex-davinci-002` basierenden KI-Assistenten erstellten in vier der fünf Aufgaben häufiger unsichere Lösungen als die Vergleichsgruppe.
Zugleich schätzten sie ihre Lösungen häufiger als sicher ein @Perry2023.
Die Ergebnisse betreffen das untersuchte Modell, die Aufgaben und die damaligen Versuchsbedingungen.
Sie begründen die Relevanz einer eigenständigen Sicherheitsprüfung, erlauben aber keine unmittelbare Qualitätsbewertung heutiger Replit- oder Lovable-Anwendungen.

Es gibt auch arbeiten die sich mit Softwaremigrationen ausernandersetzen, bzw Softwaremigrationen von Web-zu-Desktop oder Desktop-zu-Web oder Offline-zu-Cloud.
Cloud-zu-Local-First ist noch relativ neu, und durch die besondere Kombi von KI Generierung und Local-First als zu neu herraustellt.




