const fs=require('node:fs');
const path=require('node:path');
const crypto=require('node:crypto');
const root=path.resolve(__dirname,'../..');
const stamp='2026-11-12';
const names=['01-intro.typ','02-basics.typ','03-method.typ','04-analysis.typ','05-migration.typ','06-evaluation.typ','07-discussion.typ'];
const docs=names.map((n,i)=>{const file='content/'+n;const before=fs.readFileSync(path.join(root,file),'utf8');return {file,ch:i+1,before,lines:before.split(/\r?\n/),eol:before.includes('\r\n')?'\r\n':'\n'};});
function set(ch,line,text){const d=docs[ch-1];if(d.lines[line-1]===undefined)throw Error('Zeile fehlt '+ch+':'+line);d.lines[line-1]=text;}
// Kontextentscheidungen; die Zeilenzahl wird für die Nachprüfung erhalten.
set(1,16,'Eine Anwendung, die oberflächlich funktioniert, aber unbemerkt unsicher oder architektonisch mangelhaft ist, kann in einer solchen Desktop-Zielumgebung Schäden verursachen, die über die Zugriffsmöglichkeiten einer im Browser isolierten Anwendung hinausgehen.');
set(1,21,'Besonders kritisch wird diese Diskrepanz, sobald eine solche Webanwendung in eine Desktop-Zielumgebung migriert werden soll.');
set(1,22,'Die Desktop-Zielumgebung einschließlich Betriebssystem, Dateisystem und Zugriffsrechten stellt andere Anforderungen als die Sandbox der KI-gestützten Entwicklungsplattform; die von der Plattform getroffenen Architekturentscheidungen lassen sich deshalb nicht unverändert übernehmen.');
set(1,32,'Die Fallstudie ist der Studienplaner, eine deutschsprachige Studienverwaltungsanwendung. Der Webprototyp des Studienplaners wurde auf Replit erzeugt und wird in eine Electron-Anwendung migriert.');
set(1,39,'Damit soll veranschaulicht werden, dass die Migration in eine Desktop-Zielumgebung nicht auf den Umbau zu einer ausschließlich offline nutzbaren Anwendung beschränkt ist.');
set(1,40,'Local-First bündelt mehrere für die Migration KI-generierter Software zentrale Eigenschaften: autonome Offline-Verfügbarkeit, Datensouveränität und eine vom Netzwerk entkoppelte, dauerhaft verfügbare Nutzung.');
set(1,46,'Der weitere Aufbau der Arbeit orientiert sich an Design Science Research (DSR) und den Forschungsaktivitäten nach Peffers et al. und gliedert sich in sechs aufeinander aufbauende Kapitel:');
set(1,48,'- *Kapitel 2* legt das theoretische Fundament der Arbeit: Es führt in KI-gestützte Entwicklungsplattformen sowie API-Verträge ein, analysiert die Electron-Laufzeit unter Sicherheitsgesichtspunkten und behandelt lokale Datenhaltung sowie Local-First-Architekturen.');
set(1,49,'- *Kapitel 3* erläutert die Orientierung an DSR und den Forschungsaktivitäten nach Peffers et al. sowie das konkrete Vorgehen der Untersuchung.');
set(1,50,'- *Kapitel 4* widmet sich der Problem- und Kontextanalyse: Es analysiert bestehende KI-gestützte Entwicklungsplattformen (u. a. Replit, Lovable) und leitet die Anforderungen an die Electron-Anwendung und den Migrationspfad ab.');
set(1,51,'- *Kapitel 5* dokumentiert die Migration des Webprototyps zur Electron-Anwendung und leitet daraus die Empfehlungen des Migrationspfads ab.');
set(2,7,'KI-gestützte Entwicklungsplattformen (beispielsweise Replit oder Lovable) ermöglichen im Kontext dieser Arbeit die Generierung und iterative Überarbeitung von Anwendungscode auf Basis natürlicher Sprache.');
set(2,15,'Zwar verfügen sie über integrierte Werkzeuge zur automatisierten Fehlerkorrektur und zur grundlegenden Sicherheitsanalyse, diese Validierungen beziehen sich jedoch primär auf die Laufzeitumgebung der jeweiligen Plattform.');
set(2,31,'== Electron-Laufzeit <sec:theory-electron>');
set(2,34,'Das Framework erzwingt architektonisch keine strikten Vorgaben bezüglich des Prozessdesigns oder der internen Kommunikationsflüsse, sodass die Verantwortung für eine sichere Konfiguration von Prozesstrennung, Sandboxing und Kontextisolation primär bei den Entwickelnden liegt.');
set(2,36,'Grundsätzlich unterscheidet Electron zwischen dem zentralen Main-Prozess mit vollem Zugriff auf Betriebssystemressourcen und einem oder mehreren Renderer-Prozessen, die typischerweise der Benutzeroberfläche dienen.');
set(2,37,'Getrennte Prozesse begrenzen für sich genommen noch nicht die verfügbaren Systemzugriffe: Durch Optionen wie `nodeIntegration: true` können Node.js-APIs unmittelbar innerhalb des Renderers ausgeführt werden.');
set(2,45,'Ist die Node.js-Integration im Renderer aktiviert, wird dessen Sandboxing deaktiviert. Gelingt es Angreifenden beispielsweise über Cross-Site Scripting (XSS) oder manipulierte externe Inhalte, Schadcode im Renderer auszuführen, können verfügbare Node.js-APIs eine _Remote Code Execution_ (RCE) auf Ebene des Host-Betriebssystems ermöglichen @ElectronSecurity2026.');
set(2,47,'Um diesen Angriffsvektoren zu begegnen, beschreiben die _Electron-Sicherheitsrichtlinien (Electron Security Guidelines)_ @ElectronSecurity2026 empfohlene Schutzmaßnahmen für die Electron-Laufzeit.');
set(2,48,'Zu den zentralen Maßnahmen zählen das Deaktivieren der Node.js-Integration im Renderer, das Aktivieren von Sandboxing und _Kontextisolation (Context Isolation)_, restriktive Navigationsregeln und eine _Content Security Policy_ (CSP) sowie die Validierung sämtlicher IPC-Nachrichten und die IPC-Absenderprüfung. Sandboxing beschränkt die Systemzugriffe des Renderer-Prozesses; Kontextisolation trennt den JavaScript-Kontext der Webseite vom Kontext des Preload-Skripts.');
set(2,54,'Neben dem direkten Laden über `file://` unterstützt Electron anwendungseigene URL-Schemata, deren Anfragen ein im Main-Prozess registrierter Protokollhandler beantwortet.');
set(2,59,'Dazu müssen angeforderte Pfade gegen das vorgesehene Renderer-Ressourcenverzeichnis geprüft werden.');
set(2,73,'Hash-Routing hält die Route im Adressfragment, also hinter dem Zeichen `#`, und vermeidet damit eine Änderung des Ressourcenpfads.');
set(2,74,'Das Adressfragment wird vor dem Zugriff auf die adressierte Ressource abgetrennt und anschließend clientseitig ausgewertet @RFC3986.');
set(2,75,'So bleibt die geladene Ressource beim Seitenwechsel gleich; der Router bestimmt anhand des Adressfragments die darzustellende Ansicht @WouterHashRouting2026.');
set(2,77,'Dieses Verfahren lässt sich sowohl mit `file://` als auch mit einem anwendungseigenen URL-Schema verwenden.');
set(2,94,'== Drizzle ORM als Datenzugriffsschicht <sec:theory-persistence>');
set(2,96,'Drizzle ORM ist ein leichtgewichtiges, typsicheres Object-Relational-Mapping-Werkzeug (ORM) für das TypeScript-Ökosystem.');
set(2,97,'Die Drizzle-Werkzeugsuite verzichtet im Gegensatz zu traditionellen, monolithischen ORM-Systemen auf umfangreiche Laufzeit-Engines oder externe Binärabhängigkeiten und ist modular aufgebaut.');
set(2,100,'- *Drizzle ORM (Kernbibliothek):* Die Datenbankschemata werden deklarativ in TypeScript beschrieben. Diese zentrale Schemadefinition bildet die Grundlage für den typisierten Datenzugriff.');
set(2,116,'Das Architekturparadigma _Local-First_ beschreibt datenintensive Anwendungen, bei denen ein primärer lokaler Datenbestand auf dem Endgerät des Nutzers die lokale Verarbeitung ermöglicht.');
set(2,126,'Bei externen Datenflüssen ist zwischen einer einseitigen Datenübernahme und einer kollaborativen Synchronisation zu unterscheiden: Bei einer einseitigen Datenübernahme werden Referenzdaten bezogen, validiert und lokal gespeichert.');
set(2,128,'Lokaler Schreibabschluss (_Local Commit_) und die Bestätigung der Übernahme durch das Backend finden dabei zeitlich entkoppelt statt @Kleppmann2019.');
set(2,138,'  caption: [Zusammenspiel von lokaler Datenhaltung, Backend und PowerSync-Dienst. Eigene Darstellung nach @PowerSyncWritingChanges2026 und @PowerSyncSupabase2026.],');
set(2,143,'Supabase ist eine quelloffene _Backend-as-a-Service_-Plattform (BaaS). Ihre PostgreSQL-Datenbank dient als zentrale Backend-Datenbank und Replikationsquelle.');
set(3,5,'== Design Science Research und Erkenntnisziel');
set(3,7,'Die Arbeit orientiert sich an DSR. Dabei wird eine Lösung für ein praktisches Problem entwickelt und anhand festgelegter Anforderungen bewertet.');
set(3,9,'Die Forschungsaktivitäten nach Peffers et al. wurden bereits bei der Gliederung der Arbeit eingeplant.');
set(3,12,'Diese Forschungsaktivitäten strukturieren die wissenschaftliche Darstellung des durchgeführten Vorgehens.');
set(3,13,'Ihre frühzeitige Planung bedeutet nicht, dass sämtliche technischen Schritte bereits zu Beginn festgelegt waren.');
set(3,15,'Die nachfolgend beschriebenen Entwicklungsphasen fassen den tatsächlichen Migrationsprozess zusammen.');
set(3,17,'Das zentrale wissenschaftliche Ergebnis ist der Migrationspfad. Er wird aus den für die Migration notwendigen Veränderungen abgeleitet und beschreibt ein fallbezogenes Vorgehen.');
set(3,18,'Die Electron-Anwendung dient als technischer Demonstrator, an dem die Umsetzung des Migrationspfads gezeigt und geprüft wird.');
set(3,26,'Untersucht wurde damit ein KI-generierter Webprototyp, dessen Komponenten für die Electron-Laufzeit neu eingeordnet werden mussten.');
set(3,37,'== Erster Migrationsversuch und Konsequenzen für das Migrationsvorgehen <sec:migration-preliminary>');
set(3,62,'Diese sind Arbeitsschritte innerhalb der DSR-Aktivität Entwurf und Entwicklung und bilden kein eigenständiges Forschungsmodell.');
set(3,71,'Ziel dieser Phase war eine Electron-Anwendung, deren lokale Kernfunktionen die autonome Offline-Verfügbarkeit des Local-First-Paradigmas unterstützen und deren Architektur zugleich die Grundlage für die nachfolgenden Erweiterungen bildet.');
set(3,77,'Aufbauend auf der Offline-Kernanwendung wurden in der zweiten Phase die netzwerkabhängigen Funktionen betrachtet.');
set(3,82,'Die einseitige Datenübernahme aus einem Studiengangskatalog dient als Beispiel für das Herunterladen externer Daten und deren Speicherung in der lokalen Anwendung.');
set(3,84,'Darauf aufbauend wurde mit der Verwaltung gemeinsamer Gruppenaufgaben ein Beispiel für die Zusammenarbeit in synchronisierten Studiengruppen betrachtet.');
set(4,112,'Die Funktionsbereiche Noten, Kalender und Stundenplan beruhen im Kern auf dem Anlegen, Lesen, Ändern und Löschen persistenter Anwendungsdaten und werden deshalb als lokale CRUD-Verarbeitung zusammengefasst.');
set(4,116,'Bei den Online-Anbindungen werden zwei unterschiedliche Verarbeitungsmuster untersucht.');
set(4,133,'Benutzeroberfläche, Geschäftslogik und Datenzugriff sollen getrennte Verantwortlichkeiten besitzen; fachliche Aufrufe werden entsprechend in Handler, Services und Repositories gegliedert. Die Handler übernehmen dabei die Rolle der Controller an der Schnittstelle.');
set(4,140,'Dazu zählen insbesondere Sandboxing und Kontextisolation des Renderers bei deaktivierter Node.js-Integration, begrenzte privilegierte Schnittstellen, die IPC-Absenderprüfung und Eingabevalidierung sowie Beschränkungen für nachgeladene Inhalte, Navigation und zusätzliche Fenster @ElectronSecurity2026.');
set(4,153,'Bewertet werden der Start der installierten Electron-Anwendung und die Ausführbarkeit der Funktionen, die den zuvor beschriebenen Verarbeitungsmustern zugeordnet sind.');
set(4,157,'Benutzeroberfläche, Geschäftslogik und Datenzugriff müssen getrennte Verantwortlichkeiten besitzen.');
set(4,176,'Die zur lokalen Verarbeitung vorgesehenen persönlichen Funktionen sowie die lokale Kontoverwaltung müssen die autonome Offline-Verfügbarkeit gewährleisten.');
set(4,196,'Die Electron-Anwendung muss die beschriebenen Verarbeitungsmuster für lokale CRUD-Verarbeitung, Dateiimporte, einseitige Datenübernahme und kollaborative Synchronisation abdecken.');
set(4,198,'Der Nachweis ordnet den Verarbeitungsmustern konkrete Funktionen sowie die angewendeten Architektur- und Sicherheitsmuster zu.');
set(4,199,'Er muss zeigen, wie weitere Funktionen mit vergleichbaren Verarbeitungsmustern auf diesen Mustern aufbauen können.');
set(5,52,'Eine lokale SQLite-Datei bildet die lokale Kerndatenbank und ersetzt die PostgreSQL-Verbindung des Webprototyps; `DATABASE_URL` entfiel für die lokale Datenhaltung.');
set(5,53,'Der Main-Prozess übernahm das Anlegen, Öffnen und Migrieren der lokalen Kerndatenbank @StudienplanerSource2026 @StudyPlanDatabase2026.');
set(5,57,'Ein Update kann so Programmdateien ersetzen, ohne die lokale Kerndatenbank auszutauschen.');
set(5,103,'Zur Einrichtung des Datenbankschemas standen mit Drizzle Kit zwei Ansätze zur Auswahl: Während `drizzle-kit push` Schemadefinitionen direkt und ohne gesonderte SQL-Dateien mit der Zieldatenbank abgleicht @DrizzlePush2026, erzeugt `drizzle-kit generate` versionierte SQL-Migrationsdateien auf Basis von Schema-Snapshots @DrizzleGenerate2026.');
set(5,107,'Damit lassen sich Schemaerweiterungen bei Updates schrittweise auf bestehende lokale Kerndatenbanken anwenden.');
set(5,143,'Die Datenmigration `0001_seed-study-programs.sql` stellt Studiengänge und ihre Module für den Funktionsbereich Studiengänge bereit. Die Datenmigration `0002_seed-timetable-presets.sql` stellt dagegen Presets mit Kursen für den davon getrennten Funktionsbereich Stundenplan bereit.');
set(5,203,'[Begrenzte Preload-Schnittstelle, IPC-Absenderprüfung und Eingabevalidierung sowie fachliche Sitzungsprüfung.],');
set(5,209,'Gesteuert über die Konfigurationsdatei `api/ipc-generator.config.ts` erzeugt der IPC-Codegenerator aus der `openapi.yaml` gemeinsame Module und Renderer-Module @StudyPlanApiMigration2026:');
set(5,211,'- *Gemeinsame Module (`src/shared/api/generated`):* Typdefinitionen, Zod-Laufzeitschemata, die Zuordnungstabelle `operationContracts` sowie der Basistransport.');
set(5,338,'=== Grenzen und kritische Würdigung des IPC-Codegenerators');
set(5,375,'=== Lokale Anmeldung als erster vollständiger Verarbeitungspfad');
set(5,392,'Diese lokale Anwendungssitzung liegt im Arbeitsspeicher und endet beim Beenden der Anwendung; die Benutzerdatensätze bleiben dagegen in der lokalen Kerndatenbank gespeichert @StudienplanerSource2026 @StudyPlanLocalAuth2026.');
set(5,394,'Bei erfolgreicher lokaler Anmeldung oder Registrierung leert der Renderer den bisherigen React-Query-Cache, speichert die Benutzerinformation unter dem Abfrageschlüssel von `getMe` und navigiert zur Anwendung.');
set(5,401,'Nach der Integration der Benutzeroberfläche und der lokalen Anmeldung wurden die weiteren fachlichen Funktionen mit dem vorbereiteten Aufrufweg verbunden.');
set(5,408,'Die Eingabevalidierung wurde durch die bereits eingerichtete Eingabevalidierung des API-Dispatchers übernommen.');
set(5,425,'      [Geschäftslogik],');
set(5,555,'=== Spike-Tests zur Synchronisationsintegration und Drizzle-Anbindung');
set(5,557,'Vor der Integration in die Anwendung wurden in einem Worktree Spike-Tests mit zwei Prototypen durchgeführt, um die Synchronisationsintegration und anschließend die Drizzle-Anbindung zu erproben.');
set(5,569,'Für die weitere Migration standen deshalb zwei Vorgehensweisen zur Auswahl: die vollständige Umstellung der bestehenden Schemata und Datenzugriffe auf den lokalen Kollaborationsdatenbestand oder die schrittweise Migration einzelner Funktionsbereiche.');
set(5,570,'Gewählt wurde die zweite Variante, um die Offline-Kernanwendung weiterzuverwenden und zunächst nur das Studiengruppen-Feature um Synchronisation zu erweitern.');
set(5,573,'=== Architektur mit lokaler Kerndatenbank und lokaler Kollaborationsdatenbank <sec:sync-architecture>');
set(5,575,'Während der schrittweisen Migration bleibt die lokale Kerndatenbank aus Phase 1 für persönliche Funktionen und lokale Studiengruppen erhalten.');
set(5,576,'Für die synchronisierten Studiengruppen wird eine zusätzliche lokale Kollaborationsdatenbank verwendet.');
set(5,580,'Die Benutzeroberfläche führt das zunächst mit seinen grundlegenden CRUD-Interaktionen übernommene lokale Studiengruppen-Feature unter `/gruppen` als „Gruppen“ und die um Synchronisation erweiterte Implementierung unter `/gruppen-sync` als „Gruppen (Sync)“.');
set(5,581,'Beide Implementierungen desselben ursprünglichen Studiengruppen-Features bestehen während der Migration nebeneinander; vorhandene lokale Gruppendaten werden nicht automatisch in den lokalen Kollaborationsdatenbestand übertragen @StudyPlanGroupTransition2026.');
set(5,593,'Davon getrennt bleibt die netzwerkabhängige Gruppenverwaltung: Ihre Operationen rufen Supabase unmittelbar auf und benötigen deshalb eine Netzwerkverbindung @PowerSyncSupabase2026 @StudyPlanSyncArchitecture2026.');
set(5,595,'=== Benutzerkonten und Einladungsablauf im synchronisierten Studiengruppen-Feature <sec:collaboration-invitations>');
set(5,597,'Für die synchronisierten Studiengruppen werden Supabase-Benutzerkonten verwendet. Diese sind von den lokalen Benutzerkonten der Offline-Kernanwendung getrennt und nicht automatisch mit ihnen verknüpft.');
set(5,600,'Die Electron-Anwendung bietet die Anmeldung mit vorhandenen Supabase-Benutzerkonten über E-Mail-Adresse und Passwort; Registrierung, E-Mail-Bestätigung und Passwortzurücksetzung für diese Konten sind in ihrer Benutzeroberfläche nicht enthalten @StudyPlanSyncArchitecture2026.');
set(5,603,'Für die linkbasierte Gruppeneinladung im Webprototyp erzeugte die Gruppenroute einen Einladungstoken.');
set(5,613,'Für die synchronisierten Studiengruppen wurde stattdessen die direkte Kontoeinladung vorhandener Supabase-Benutzerkonten gewählt.');
set(5,618,'Die Auswahl eines Profils erzeugt eine direkte Kontoeinladung.');
set(5,622,'=== Technische Integration der synchronisierten Studiengruppen <sec:sync-implementation>');
set(5,626,'Die technische Umsetzung begann mit der Anpassung des Datenmodells für die Supabase-PostgreSQL-Datenbank und den lokalen Kollaborationsdatenbestand:');
set(5,629,'- *Schemaableitung:* Die zentrale Drizzle-Schemadefinition in `schema.ts` beschreibt den lokalen Kollaborationsdatenbestand und generiert mittels `DrizzleAppSchema` das PowerSync-Client-Schema.');
set(5,631,'==== Backend-Anbindung und Sync Streams');
set(5,638,'Die Datenverteilung durch den PowerSync-Dienst wird über Sync Streams in `sync-streams-v4.yaml` konfiguriert. SQL-Abfragen legen fest, welche Teilmengen an die jeweiligen Clients repliziert werden. Die Sync Streams steuern ausschließlich den Download; die Autorisierung von Schreibzugriffen erfolgt im Backend @StudyPlanSyncIntegration2026.');
set(5,657,'Die Steuerung des synchronisierten Studiengruppen-Features übernimmt das Modul `CollaborationRuntime`.');
set(5,658,'Es kapselt den Zustand der Supabase-Kollaborationssitzung, verwaltet die Verbindungslebenszyklen und steuert den Datenzugriff.');
set(5,659,'Für die Anmeldung mit dem Supabase-Benutzerkonto ruft der Connector im Main-Prozess `signInWithPassword` mit den eingegebenen Zugangsdaten auf und authentifiziert damit das Konto @StudyPlanSyncArchitecture2026 @SupabasePasswordSignIn2026.');
set(5,660,'Nach erfolgreicher Anmeldung mit dem Supabase-Benutzerkonto öffnet die Laufzeit eine nach diesem Konto getrennte lokale Kollaborationsdatenbank und verbindet sie mit PowerSync (@lst:collaboration-connect).');
set(5,672,'  caption: [Initialisierung und Verbindung der lokalen Kollaborationsdatenbank je Supabase-Benutzerkonto; Auszug aus `CollaborationRuntime.signIn` @StudyPlanSyncIntegration2026.],');
set(5,678,'Der manuell typisierte Kollaborationsvertrag ist in `src/shared/collaboration/ipc.ts` hinterlegt.');
set(5,705,'      [Lokale Kollaborationsdatenbank, Replikationsverbindung und Upload-Warteschlange.],');
set(5,730,'Die lokale Kerndatenbank wird weiterhin über die mitgelieferten SQL-Migrationsdateien von Drizzle Kit aktualisiert.');
set(5,731,'Für die synchronisierten Studiengruppen werden dagegen das PostgreSQL-Datenbankschema und die Sync Streams serverseitig gepflegt; das PowerSync-Client-Schema wird dem PowerSync-SDK deklarativ vorgegeben @SupabaseSchemaMigrations2026 @PowerSyncSchemaChanges2026.');
set(5,743,'Das Terminbeispiel aus den Spike-Tests zeigt die Schemaanpassungen für einen weiteren Datenbereich.');
set(5,747,'Im Prototyp ersetzt eine Textkennung den automatisch erzeugten Integer; `ownerId` verweist auf das Supabase-Benutzerkonto.');
set(5,771,'=== Einseitige Datenübernahme im Funktionsbereich Studiengänge <sec:study-catalog-download>');
set(5,773,'Der Funktionsbereich Studiengänge verwendet eine einseitige Datenübernahme: Katalogdaten werden online bereitgestellt, in die lokale Kerndatenbank übernommen und anschließend offline gelesen.');
set(5,774,'Die Electron-Anwendung ergänzt hierzu den in Phase 1 mitgelieferten Katalog-Grundbestand um online abrufbare Beispieldaten; der vorhandene Katalog-Grundbestand bleibt erhalten @StudyPlanCatalog2026.');
set(5,776,'Dafür wurde eine Supabase Edge Function ergänzt, die Studiengänge und zugehörige Module aus einer JSON-Datei über einen öffentlichen HTTP-Endpunkt bereitstellt.');
set(5,779,'Der bestehende OpenAPI-Vertrag wurde um `refreshStudyCatalog` und dessen Ergebnis mit den Anzahlen übernommener Studiengänge und Module erweitert @StudyPlanCatalog2026.');
set(5,795,'Gemeinsame Gruppenaufgaben können während einer bestehenden Supabase-Kollaborationssitzung ohne Verbindung bearbeitet werden; nach einem Anwendungsneustart ist jedoch eine erneute Anmeldung mit dem Supabase-Benutzerkonto erforderlich @StudyPlanSyncArchitecture2026.');
set(5,816,'Hinzu kamen Fenster- und Electron-Session-Einstellungen, die Electron-Version und die Konfiguration des ausgelieferten Anwendungspakets.');
set(5,845,'        [Sind die Node.js-Integration im Renderer deaktiviert sowie Sandboxing und Kontextisolation aktiviert?],');
set(5,847,'        [Berechtigungen der Electron-Session],');
set(5,887,'Die bisherige Auslieferung über `file://` wurde durch das anwendungseigene URL-Schema `app:` ersetzt, dessen Grundlagen in @sec:theory-electron-protocols erläutert sind.');
set(5,889,'Neben der syntaktischen Pfadprüfung wird der tatsächlich aufgelöste Dateipfad geprüft, damit auch Verknüpfungen keinen Zugriff außerhalb des Renderer-Ressourcenverzeichnisses eröffnen.');
set(5,919,'Die Quellcodeinspektion erfasste Einstellungen und Kontrollen an den jeweiligen Einstiegspunkten; automatisierte Tests prüften Entscheidungen und Fehlerpfade.');
set(5,920,'Paketprüfungen untersuchten das erzeugte Anwendungspaket, während manuelle Laufzeitversuche ausgewählte Kontrollen in der installierten Electron-Anwendung auslösten @StudyPlanSecurityRemediation2026.');
set(5,933,'Die manuellen Laufzeitversuche wurden in der installierten Electron-Anwendung auf Windows mithilfe der DevTools ausgelöst und im bestehenden Renderer beobachtet. Dabei wurde der korrigierte Paketstand verwendet.');
set(5,948,'        [Je eine ungültige Eingabe über die API-Preload-Schnittstelle und die Kollaborations-Preload-Schnittstelle senden.],');
set(5,949,'        [Fehlerantworten `VALIDATION_ERROR` beziehungsweise `INVALID`; die vorgelagerte Eingabevalidierung wird ergänzend im Code nachvollzogen.],');
set(5,953,'        [P3 – CSP],');
set(5,980,'Zunächst sollte je ein repräsentativer Ablauf der benötigten Verarbeitungsmuster ausgewählt werden.');
set(5,985,'Die Spike-Tests der Fallstudie zeigen den Nutzen einer solchen technischen Erprobung: Die verwendete TypeScript-Laufzeit ermöglichte die Weiterverwendung von Backend-Komponenten, während die PowerSync-Anbindung zusätzliche Anpassungen nativer Abhängigkeiten und ihrer Paketierung erforderte @StudyPlanSyncSpikes2026 @StudyPlanSyncIntegration2026.');
set(5,1048,'Die Spike-Tests sollen Schemaabbildung, ORM-Zugriff, lokale Benutzerkonten und Supabase-Benutzerkonten, lokale Speicherung, ausstehende Änderungen und den Betrieb der installierten Anwendung umfassen.');
set(5,1055,'Vorausgesetzte Supabase-Benutzerkonten und fachliche Änderungen der Benutzerführung sind ausdrücklich festzuhalten @StudyPlanSyncIntegration2026 @StudyPlanSyncArchitecture2026.');
set(5,1098,'        [Verarbeitungsmuster und externe Abhängigkeiten benennen; einen frühen Desktop-Paketstand einschließlich vorgesehener nativer Module installieren und die installierte Anwendung starten.],');
set(6,11,'Die Funktionsprüfung folgt typischen Benutzerabläufen: installierte Electron-Anwendung starten, Daten bearbeiten, die Verbindung unterbrechen und gespeicherte Änderungen nach einem Neustart erneut öffnen.');
set(6,15,'Manuelle Funktionsprüfungen untersuchen die Bedienung der installierten Electron-Anwendung.');
set(6,38,'        [Verbindung trennen, installierte Electron-Anwendung starten und mit einem vorhandenen lokalen Benutzerkonto anmelden.],');
set(6,61,'Der iCal-Import und der CSV-Notenimport wurden gemeinsam als Dateiimporte geprüft.');
set(6,63,'Die Desktop-Anpassung betrifft insbesondere die native Dateiauswahl.');
set(6,75,'        table.header([*Prüffall*], [*Ergebnis beim iCal-Import und CSV-Notenimport*]),');
set(6,84,'    caption: [Ergebnisse des iCal-Imports und des CSV-Notenimports.],');
set(6,106,'        [Benutzeroberfläche, Geschäftslogik und Datenzugriff am Verarbeitungspfad der Notenverwaltung zuordnen.],');
set(6,109,'        [Geschäftslogik der Notenverwaltung ohne Bedienung der Benutzeroberfläche testen.],');
set(6,153,'        [Der Abruffehler wurde gemeldet; vorhandene Studiengänge und Module blieben verfügbar.],');
set(6,189,'        [Während einer bestehenden Supabase-Kollaborationssitzung die Verbindung trennen, eine gemeinsame Gruppenaufgabe anlegen und die Ansicht erneut öffnen.],');
set(6,207,'Nach einem Anwendungsneustart ist eine erneute Anmeldung mit dem Supabase-Benutzerkonto erforderlich; anschließend stehen die gespeicherten Änderungen wieder zur Verfügung und werden übertragen.');
set(6,264,'        [CSP],');
set(6,266,'        [Die CSP blockierte das Skript; es wurde nicht ausgeführt.],');
set(6,300,'        [Lokale CRUD-Verarbeitung], [Noten, Kalender und Stundenplan],');
set(6,302,'        [Dateiimport], [iCal-Import und CSV-Notenimport],');
set(6,308,'        [Netzwerkabhängige Gruppenverwaltung], [Studiengruppen und direkte Kontoeinladungen],');
set(6,340,'        [Die installierte Electron-Anwendung startet; die ausgewählten Benutzerabläufe funktionieren.],');
set(6,342,'        [Benutzeroberfläche, Geschäftslogik und Datenzugriff sind getrennt. Die Geschäftslogik der Notenverwaltung ist ohne Benutzeroberfläche prüfbar.],');
set(7,5,'Die Migration des KI-generierten Studienplaners von Replit zu einer lokal nutzbaren Electron-Anwendung gelang im festgelegten Umfang.');
set(7,7,'Gemeinsame Gruppenaufgaben lassen sich während einer bestehenden Supabase-Kollaborationssitzung offline bearbeiten und später synchronisieren.');
set(7,28,'Bei Gruppeneinladungen wurde die linkbasierte Gruppeneinladung durch die direkte Kontoeinladung eines vorhandenen Supabase-Benutzerkontos ersetzt.');
set(7,31,'Die direkte Kontoeinladung wurde gewählt, um den Ablauf innerhalb der Electron-Anwendung abzuwickeln; die gemeinsame Verwaltung von Einladungen und Mitgliedschaften bleibt beim entfernten Backend.');
set(7,33,'Auch die erneute Anmeldung mit dem Supabase-Benutzerkonto nach dem Schließen der Electron-Anwendung folgt einer Entscheidung.');
set(7,34,'Die Supabase-Kollaborationssitzung bleibt nur für die Laufzeit der Electron-Anwendung bestehen.');
set(7,38,'So konnten Noten, Kalender und Stundenplan ihre bisherige lokale Kerndatenbank weiterverwenden.');
set(7,39,'Die zusätzliche lokale Kollaborationsdatenbank begrenzte den Umfang der Umstellung, brachte aber zusätzlichen Pflegeaufwand mit sich.');
set(7,42,'Für die synchronisierten Studiengruppen kam neben dem OpenAPI-Vertrag ein manuell typisierter Kollaborationsvertrag hinzu.');
set(7,80,'Die lokale Kerndatenbank und die lokale Kollaborationsdatenbank könnten in einer weiteren Entwicklungsphase zusammengeführt werden.');
set(7,82,'Für die Zusammenarbeit könnte die Electron-Anwendung außerdem eine Registrierung für Supabase-Benutzerkonten erhalten, einschließlich Kontobestätigung und einer ausdrücklichen Verknüpfung mit dem lokalen Benutzerkonto.');
set(7,85,'Dabei müssten die jeweiligen Prüfungen für lokale Anwendungssitzungen und Supabase-Kollaborationssitzungen erhalten bleiben.');
set(7,50,'Für Entwickler macht der Migrationspfad die Migration einer Webanwendung aus ihrer ursprünglichen Plattform in eine Desktop-Zielumgebung planbar.');
set(3,54,'Für die Kernschnittstellen wurde der vorhandene OpenAPI-Vertrag beibehalten; Typen, React-Query-Hooks und Zod-Laufzeitschemata wurden daraus mit einer auf IPC angepassten Codegenerierung abgeleitet.');
set(4,117,'Der Funktionsbereich Studiengänge dient als Beispiel für die einseitige Datenübernahme von Katalogdaten in die lokale Datenhaltung.');
set(4,119,'Gruppenerstellung und direkte Kontoeinladungen werden dabei als Operationen der netzwerkabhängigen Gruppenverwaltung eingeordnet.');
set(4,121,'Die Migration wird anhand dieser wiederkehrenden Verarbeitungsmuster beschrieben, sodass gleichartige Abläufe nicht für jeden Funktionsbereich erneut erläutert werden müssen.');
set(4,152,'Der Webprototyp muss in eine lauffähige Electron-Anwendung migriert werden.');
set(4,177,'Für den Funktionsbereich Studiengänge wird ein bereits lokal verfügbarer Katalogbestand vorausgesetzt.');
set(4,197,'Die netzwerkabhängige Gruppenverwaltung wird gesondert ausgewiesen.');
set(5,149,'Dessen Operationskennungen (`operationId`), Parameter und Datenschemata dienten bereits im Webprototyp als zentrale Spezifikation für Validierung und Client-Generierung @StudienplanerSource2026.');
set(5,212,'- *Renderer-Module (`src/renderer/src/api/generated`):* React-Query-Hooks für die Benutzeroberfläche und standardisierte Hilfsfunktionen für Abfrageschlüssel.');
set(5,395,'`UNAUTHENTICATED` führt zur lokalen Anmeldung und wird von der Query-Wiederholungslogik berücksichtigt.');
set(5,397,'Die Weiterleitung bei bestehender lokaler Anmeldung erfolgt über einen React-Effekt @StudyPlanLocalAuth2026.');
set(5,399,'=== Integration der lokalen CRUD-Verarbeitung am Beispiel der Notenverwaltung <sec:crud-migration>');
set(5,442,'Die Benutzerkennung stammt bei diesen Operationen aus der lokalen Anwendungssitzung im Main-Prozess.');
set(5,627,'- *Kennungen:* Die fünf Tabellen des Studiengruppen-Features wurden in Supabase über versionierte SQL-Migrationsdateien mit UUID-Primärschlüsseln angelegt. Das lokale Drizzle-Schema bildet diese als Zeichenketten (`text`) ab @StudyPlanSyncIntegration2026.');
set(5,679,'Zod-Laufzeitschemata prüfen die Eingaben dieses Kollaborationsvertrags im Main-Prozess @StudyPlanSyncIntegration2026.');
set(5,781,'Beim Öffnen des Funktionsbereichs Studiengänge liest die Benutzeroberfläche zunächst den lokalen Katalogbestand und löst zusätzlich die Aktualisierung aus.');
set(5,799,'Beim Katalogabruf muss der vorhandene lokale Bestand auch nach einem Verbindungsfehler nutzbar bleiben; Operationen der netzwerkabhängigen Gruppenverwaltung müssen Verbindungsfehler verständlich anzeigen (A8).');
set(5,866,'        [Wie werden lokale Inhalte ausgeliefert, und bleibt der Dateizugriff auch bei abweichenden Pfaden oder Verknüpfungen auf das vorgesehene Renderer-Ressourcenverzeichnis begrenzt?],');
set(5,928,'Ein Test von HTTP-Weiterleitungen verwendete Node-Fetch mit einem lokalen Testserver @StudyPlanSecurityRemediation2026 @StudyPlanHardeningImplementation2026.');
set(5,966,'Die technischen Paket- und Laufzeitbelege stammen vom 4. Oktober 2026 und wurden in der Sicherheitsmatrix vom 6. Oktober zusammengeführt @StudyPlanSecurityRemediation2026 @StudyPlanSecurity2026.');
set(5,1036,'*M6: Einseitige Datenübernahme mit dauerhafter lokaler Speicherung verbinden.*');
set(6,12,'Für die synchronisierten Studiengruppen werden gemeinsame Gruppenaufgaben zwischen zwei Supabase-Benutzerkonten ausgetauscht sowie Gruppen und direkte Kontoeinladungen geprüft.');
set(6,59,'Ihre Nutzung setzt keine Anmeldung mit einem Supabase-Benutzerkonto voraus.');
set(6,123,'Die Ergebnisse bestätigen die geforderte Trennung der Verantwortlichkeiten und die Prüfbarkeit der Geschäftslogik.');
set(6,129,'=== Einseitige Datenübernahme aus dem Studiengangskatalog');
set(6,238,'Die geprüften Operationen der netzwerkabhängigen Gruppenverwaltung benötigen eine Verbindung, während Aufgabenänderungen zunächst lokal verarbeitet werden.');
set(6,269,'        [Die Anwendung blieb im vorgesehenen Dokument. Es öffnete sich weder ein zusätzliches Anwendungsfenster noch der Systembrowser.],');


const rules=[
 ['Web-Prototyp','Webprototyp'],['Replit-Webprototyp','Webprototyp'],['Replit-Prototyp','Webprototyp'],
 ['Electron-App','Electron-Anwendung'],['Desktop-App','Electron-Anwendung'],
 ['Synchronisierungs','Synchronisations'],['Synchronisierung','Synchronisation'],
 ['Fachlogik','Geschäftslogik'],['fachliche Logik','Geschäftslogik'],['fachlichen Logik','Geschäftslogik'],
 ['Preload-Bridge','Preload-Schnittstelle'],['Preload-Bridges','Preload-Schnittstellen'],
 ['IPC-Dispatcher','API-Dispatcher'],['IPC-Senderprüfung','IPC-Absenderprüfung'],
 ['Eingabeprüfung','Eingabevalidierung'],['IPC-Schemaprüfung','IPC-Eingabevalidierung'],
 ['Zod-Validierungsschemata','Zod-Laufzeitschemata'],['Zod-Schemata','Zod-Laufzeitschemata'],['Zod-Verträge','Zod-Laufzeitschemata'],
 ['Codeerzeugung','Codegenerierung'],['React-Query-Aufrufhilfen','React-Query-Hooks'],
 ['Rendererwurzel','Renderer-Ressourcenverzeichnis'],['PowerSync Service','PowerSync-Dienst'],
 ['Upload Queue','Upload-Warteschlange'],['Node-Integration','Node.js-Integration'],
 ['ASAR-Anwendungsarchiv','ASAR-Archiv'],['Anwendungsarchiv','ASAR-Archiv'],
 ['Quellcodeinspektionen','Quellcodeinspektionen'],['Codeinspektion','Quellcodeinspektion'],
 ['ISO-Strings','ISO-8601-Zeichenketten'],['Identifikatoren','Kennungen'],
 ['Studiengangkatalog','Studiengangskatalog'],['Studiengangsdaten','Katalogdaten'],
 ['unidirektionalen Übernahme','einseitigen Datenübernahme'],['unidirektionale Übernahme','einseitige Datenübernahme'],
 ['Kalendereinträgen','Terminen'],['Kalendereinträge','Termine'],['Kalendertermine','Termine'],
 ['iCal-/ICS-Importe','iCal-Importe'],['iCal-/ICS-Import','iCal-Import (ICS-Dateien)'],
 ['lokalen Dateiauswahl','nativen Dateiauswahl'],['lokale Dateiauswahl','native Dateiauswahl'],
 ['synchronisierten Gruppenbereich','synchronisierten Studiengruppen'],
 ['Drizzle-Migrationen','SQL-Migrationsdateien von Drizzle Kit'],
 ['SQLite-Migrationen','SQL-Migrationsdateien für SQLite'],
 ['Electron Security Guidelines','Electron-Sicherheitsrichtlinien'],
 ['Electron-Sicherheitscheckliste','Checkliste der Electron-Sicherheitsrichtlinien'],
 ['Vorversuchs','ersten Migrationsversuchs'],['Vorversuch','erster Migrationsversuch'],
 ['Kollaborationssitzung','Supabase-Kollaborationssitzung'],
 ['lokalen Konten','lokalen Benutzerkonten'],['lokales Konto','lokales Benutzerkonto'],['lokalen Konto','lokalen Benutzerkonto'],
];
function lexical(s,ch){
 s=s.replace(/des Features/gu,'des Funktionsbereichs').replace(/Das Feature/gu,'Der Funktionsbereich').replace(/das Feature/gu,'den Funktionsbereich');
 for(const [a,b] of rules) {if(a===b)continue;s=s.replaceAll(a,b);}
 // Wortgrenzen erhalten zusammengesetzte technische Namen.
 s=s.replace(/(?<![\p{L}-])Oberfläche(?!\p{L})/gu,'Benutzeroberfläche');
 s=s.replace(/(?<![\p{L}-])App(?!\p{L})/gu,'Electron-Anwendung');
 s=s.replace(/(?<![\p{L}-])Dispatcher(s)?(?!\p{L})/gu,(_,gen)=>'API-Dispatcher'+(gen||''));
 s=s.replace(/(?<![\p{L}-])Senderprüfung(?!\p{L})/gu,'IPC-Absenderprüfung');
 s=s.replace(/(?<![\p{L}-])Absenderprüfung(?!\p{L})/gu,'IPC-Absenderprüfung');
 s=s.replace(/(?<![\p{L}-])Features(?!\p{L})/gu,'Funktionsbereiche');
 s=s.replace(/(?<![\p{L}-])Feature(?!\p{L})/gu,'Funktionsbereich');
 s=s.replace(/(?<![\p{L}-])Lehrveranstaltungen(?!\p{L})/gu,'Module');
 if(ch>=3){
  s=s.replace(/Ausgangsartefakts/gu,'Webprototyps').replace(/Ausgangsartefakt(?![\p{L}])/gu,'Webprototyp');
  s=s.replace(/(?<![\p{L}-])API-Vertrag(s)?(?!\p{L})/gu,(_,gen)=>'OpenAPI-Vertrag'+(gen||''));
 }
 s=s.replace(/lokalen Kernanwendung/gu,'Offline-Kernanwendung').replace(/lokale Kernanwendung/gu,'Offline-Kernanwendung').replace(/Electron-Kernanwendung/gu,'Offline-Kernanwendung');
 s=s.replace(/Desktop-Umgebung/gu,'Desktop-Zielumgebung').replace(/(?<![\p{L}-])Zielumgebung/gu,'Desktop-Zielumgebung');
 s=s.replace(/gemeinsamen Aufgaben/gu,'gemeinsamen Gruppenaufgaben').replace(/gemeinsame Aufgaben/gu,'gemeinsame Gruppenaufgaben').replace(/Gemeinsame Aufgaben/gu,'Gemeinsame Gruppenaufgaben');
 s=s.replace(/(?<![\p{L}-])CRUD-Verarbeitung/gu,'lokale CRUD-Verarbeitung');
 s=s.replace(/des Kollaborationsbereichs/gu,'des synchronisierten Studiengruppen-Features').replace(/im Kollaborationsbereich/gu,'im synchronisierten Studiengruppen-Feature').replace(/den Kollaborationsbereich/gu,'das synchronisierte Studiengruppen-Feature');
 s=s.replace(/(?<![\p{L}-])Kollaborationsbereich(?!\p{L})/gu,'synchronisiertes Studiengruppen-Feature');
 if(ch!==2)s=s.replace(/(?<![\p{L}-])Drizzle(?![\p{L}-]| (?:ORM|Kit|\())/gu,'Drizzle ORM');
 return s;
}
function proseLine(line,ch){
 // Nicht in Dateipfade, Codebezeichner, Referenzanker oder inline Code eingreifen.
 return line.split(/(`[^`]*`|@[-\w:]+|<[^>]+>|"[^"\r\n]*")/gu).map((s,i)=>i%2?s:lexical(s,ch)).join('');
}
const changes=[];
for(const d of docs){
 let fence=false;
 d.lines=d.lines.map(line=>{
  if(/^\s*```/.test(line)){fence=!fence;return line;}
  if(fence||/^\s*(?:\/\/|image\(|raw\(read\()/.test(line))return line;
  return proseLine(line,d.ch);
 });
 // Grammatik und konkrete Bezüge nach der gemeinsamen Wortvereinheitlichung.
 const fix=(a,b)=>{d.lines=d.lines.map(s=>s.replaceAll(a,b));};
 fix('Supabase-Supabase-Kollaborationssitzung','Supabase-Kollaborationssitzung');
 fix('Preload-Schnittstelles','Preload-Schnittstellen');
 fix('der lokale CRUD-Verarbeitung','der lokalen CRUD-Verarbeitung');
 fix('gemeinsamer Aufgaben','gemeinsamer Gruppenaufgaben');
 fix('synchronisierte Gruppenaufgaben','gemeinsame Gruppenaufgaben');
 fix('synchronisierten Gruppenaufgaben','gemeinsamen Gruppenaufgaben');
 fix('Die Matrix wurde','Die Sicherheitsmatrix wurde');
 fix('Electron-Hauptprozesses','Main-Prozesses');
 fix('lokale lokale CRUD-Verarbeitung','lokale CRUD-Verarbeitung');
 fix('Lokale lokale CRUD-Verarbeitung','Lokale CRUD-Verarbeitung');
 fix('Electron-Sicherheitsrichtlinien (Electron-Sicherheitsrichtlinien)','Electron-Sicherheitsrichtlinien (Electron Security Guidelines)');
 fix('des Funktionsbereiche','der Funktionsbereiche');
 fix('des Funktionsbereich ','des Funktionsbereichs ');
 fix('Benutzeroberfläche, fachliche Verarbeitung und Datenzugriff','Benutzeroberfläche, Geschäftslogik und Datenzugriff');
 fix('Darstellung, Geschäftslogik und Datenzugriff','Benutzeroberfläche, Geschäftslogik und Datenzugriff');
 fix('Die Eingabevalidierung wurde durch die bereits eingerichtete Eingabevalidierung des API-Dispatchers übernommen.','Der API-Dispatcher übernahm die Eingabevalidierung anhand des OpenAPI-Vertrags.');
 fix('der ersten Migrationsversuch','der erste Migrationsversuch');
 fix('Der erster Migrationsversuch','Der erste Migrationsversuch');
 fix('Im erster Migrationsversuch','Im ersten Migrationsversuch');
 fix('im erster Migrationsversuch','im ersten Migrationsversuch');
 fix('aus dem erster Migrationsversuch','aus dem ersten Migrationsversuch');
 // Offene generische Vertragsbezüge bei zukünftiger Vereinheitlichung bleiben generisch.
 if(d.ch===7){fix('Ein gemeinsamer OpenAPI-Vertrag könnte','Ein gemeinsamer API-Vertrag könnte');}
 // Konkrete Einzelstellen, für die globales Ersetzen semantisch falsch wäre.
 if(d.ch===4){d.lines[64]='    [Kontoverwaltung],';}
 if(d.ch===5){
  d.lines[315]=d.lines[315].replace('standardisierte Query Keys','standardisierte Abfrageschlüssel (Query Keys)');
  d.lines[585]='    Dargestellt sind die lokale Kerndatenbank und die lokale Kollaborationsdatenbank sowie direkte Online-Aufrufe, Upload und Download.';
  d.lines[628]=d.lines[628].replace('Drizzle ORM-Schemadefinition','Drizzle-Schemadefinition');
  d.lines[639]=d.lines[639].replace('Aufgaben-Streams','Aufgaben-Sync-Streams').replace('Ähnliche Selektionsregeln','Weitere Sync Streams');
  d.lines[652]=d.lines[652].replace('der Stream','der Sync Stream');
  d.lines[811]=d.lines[811]; // Leerzeile bleibt erhalten.
  d.lines[887]='Sein Protokollhandler liefert ausschließlich Dateien innerhalb des gebauten Renderer-Ressourcenverzeichnisses aus.';
 }
 if(d.ch===2){
  for(const i of [106,109,110,112])d.lines[i-1]=d.lines[i-1].replace(/Drizzle(?![\p{L}-]| ORM| Kit)/gu,'Drizzle ORM');
 }
 const after=d.lines.join(d.eol);
 const old=d.before.split(/\r?\n/);
 if(old.length!==d.lines.length)throw Error('Zeilenzahl verändert '+d.file);
 d.lines.forEach((text,i)=>{if(text!==old[i])changes.push({file:d.file,chapter:d.ch,line:i+1,before:old[i],after:text});});
 d.after=after;
}
// SVG-Beschriftungen und barrierefreie Beschreibungen bearbeiten; Geometrie bleibt erhalten.
const svgDocs=[];
for(const name of fs.readdirSync(path.join(root,'figures')).filter(n=>n.endsWith('.svg'))){
 const file='figures/'+name;const before=fs.readFileSync(path.join(root,file),'utf8');
 let after=before.replace(/<(text|desc)\b[^>]*>[\s\S]*?<\/\1>/gu,whole=>whole.replace(/>[^<]+</gu,s=>'>'+lexical(s.slice(1,-1),0)+'<'));
 const replacements=[['Sync Rules: Datenpartitionen filtern','Sync Streams: Datenpartitionen filtern'],['Handler / Controller','Handler'],['Persönliches SQLite','Lokale Kerndatenbank'],['SQLite aus Phase 1','Lokale Kerndatenbank'],['Lokale SQLite-Datei','Lokale Kerndatenbank'],['Lokaler Gruppenbestand','Kollaborationsdatenbestand'],['Lokale Persistenzschicht (Client)','Lokale Datenhaltung (Client)'],['Lokale Persistierung','Lokale Speicherung'],['PowerSync / SQLite','Kollaborationsdatenbank'],['API- und Kollaborationsbridge','API- und Kollaborations-Preload-Schnittstellen'],['Node.js · Express-API-Server','Node.js · Express-API-Server']];
 for(const [a,b]of replacements)after=after.replaceAll(a,b);
 if(name==='collaboration-modules.svg')after=after.replace('>Queue<','>Upload-Warteschlange<');
 if(name==='api-interface-migration.svg')after=after.replace('>Begrenzte Bridge<','>Preload-Schnittstelle<');
 if(name==='grades-crud-flow.svg')after=after.replace('>Begrenzte Bridge<','>Preload-Schnittstelle<');
 if(name==='ipc-dispatcher-flow.svg')after=after.replace('>Preload-Schnittstelle<','>API-Preload-Schnittstelle<');
 const old=before.split(/\r?\n/),next=after.split(/\r?\n/);
 if(old.length!==next.length)throw Error('SVG-Zeilenzahl verändert');
 next.forEach((text,i)=>{if(text!==old[i])changes.push({file,line:i+1,before:old[i],after:text});});
 svgDocs.push({file,before,after});
}
const bundle=[...docs,...svgDocs];
if(process.argv.includes('--apply')){
 const backup=path.join(__dirname,'vor-umsetzung-'+stamp+'.json');
 if(fs.existsSync(backup))throw Error('Sicherung existiert bereits; nicht erneut anwenden.');
 fs.writeFileSync(backup,JSON.stringify(bundle.map(d=>({file:d.file,sha256:crypto.createHash('sha256').update(d.before).digest('hex'),text:d.before})),null,2)+'\n');
 for(const d of bundle)if(d.before!==d.after)fs.writeFileSync(path.join(root,d.file),d.after,'utf8');
}
fs.writeFileSync(path.join(__dirname,'aenderungen-'+stamp+'.json'),JSON.stringify(changes,null,2)+'\n');
console.log(JSON.stringify({applied:process.argv.includes('--apply'),changedFiles:bundle.filter(d=>d.before!==d.after).map(d=>d.file),changedLines:changes.length},null,2));
