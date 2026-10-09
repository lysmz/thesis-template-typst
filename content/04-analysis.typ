//---------------------------------------------------------------------
= Analyse und Anforderungsdefinition <ch:analysis>
//---------------------------------------------------------------------

== Vom übergeordneten Ziel zur Fallauswahl

Die in @ch:intro formulierte Forschungsfrage nimmt einen frameworkagnostischen Migrationsansatz als Ausgangsziel auf. Für dessen Bearbeitung ist zunächst zu bestimmen, welche Architekturmerkmale des Ausgangsartefakts die Transformation beeinflussen. Entscheidend ist nicht allein das verwendete Frontend-Framework, sondern auch, wo Geschäftslogik, Datenhaltung und Authentifizierung ausgeführt werden und welche dieser Bestandteile im verfügbaren Quellcode enthalten sind.

Zur Einordnung werden Replit und Lovable anhand ihrer offiziellen Dokumentation beispielhaft betrachtet. Replit beschreibt Webanwendungen als standardmäßig erzeugte Full-Stack-Anwendungen mit Frontend und Backend. API-Routen, Datenbank und serverseitige Logik werden nach dem Bedarf der Anwendung eingerichtet. Diese Dokumentation beschreibt das Plattformangebot; den konkreten Aufbau des Studienplaners belegt erst die Analyse des vorliegenden Artefakts. @ReplitWebApps2026

Lovable dokumentiert dagegen einen standardmäßig aktivierten verwalteten Cloud-Backend-Dienst auf Grundlage der Open-Source-Technologie von Supabase. Alternativ kann ein eigenes Supabase-Projekt angebunden werden. Datenbank, Authentifizierung, Dateispeicherung und serverseitige Funktionen werden damit als Backend-Dienste bereitgestellt. Diese dokumentierte Dienststruktur wird hier als Backend-as-a-Service eingeordnet. Daraus folgt jedoch nicht, dass jedes Lovable-Projekt dieselbe Architektur aufweist. @LovableSupabase2026

Für die Migration ergibt sich daraus eine unterschiedliche Ausgangslage. Liegt die serverseitige Anwendungslogik als eigener Quellcode vor, kann ihre Übernahme und Anpassung an die lokale Laufzeit untersucht werden. Bei einer dienstgebundenen Architektur müssen dagegen auch die vom Dienst übernommenen Verantwortlichkeiten identifiziert und gegebenenfalls lokal nachgebildet werden. Eine reine Ersetzung des Frontend-Transports deckt diese zweite Ausgangslage nicht vollständig ab.

Die Entwicklung und Prüfung eines allgemeinen Leitfadens für beide Fälle würde den Umfang dieser Arbeit überschreiten. Die praktische Untersuchung wird daher auf den Replit-Prototyp Studienplaner begrenzt. Lovable dient zur dokumentationsgestützten Begründung dieser Eingrenzung; eine Lovable-Anwendung wird nicht migriert. Der resultierende Leitfaden kann potenziell übertragbare Prinzipien aufzeigen, wird jedoch nicht als validierte Lösung für beliebige Frameworks oder Plattformen ausgegeben.

== Funktionen und Architektur des Ausgangsartefakts

=== Funktionaler Untersuchungsumfang <sec:functional-scope>

Der funktionale Ausgangspunkt ergibt sich aus den ursprünglichen Erstellungs-Prompts zur persönlichen Studienorganisation und zur Zusammenarbeit in Studiengruppen. Beide Prompts sind in @app:creation-prompts dokumentiert. Für die Migration werden sämtliche persönlichen Funktionsbereiche sowie Authentifizierung und ausgewählte Gruppenfunktionen betrachtet. @tab:feature-scope konkretisiert diesen Untersuchungsumfang. Die Aufstellung bildet den funktionalen Bezugsrahmen; maßgeblich für den Demonstrator ist der in @sec:target-architecture definierte repräsentative Kernfunktionsumfang.

#figure(
  {
    set par(justify: false)
    table(
    columns: (1fr, 3fr),
    inset: 6pt,
    align: left,
    table.header([*Bereich*], [*Betrachtete Funktionen*]),
    [Dashboard], [Notendurchschnitt, gesammelte ECTS-Punkte, anstehende Fristen, Schnellzugriffe sowie letzte Aktivitäten und nächste Termine.],
    [Kalender], [Monatsansicht mit Tages-Popover, Termindetails und Löschen, farbliche Kennzeichnung der Terminarten, iCal-/ICS-Import, mehrtägige Termine und nach Priorität filterbare Listenansicht.],
    [Noten], [Semesterweise gruppierte Kurs-, Noten- und ECTS-Tabelle; Anlegen, Lesen, Bearbeiten und Löschen; CSV-Import mit Spaltenerkennung; ECTS-gewichteter Notendurchschnitt und Prüfung der Kurszugehörigkeit zum Studiengang.],
    [Stundenplan], [Raster mit fünf Wochentagen und sechs festen Hochschulzeitblöcken, Auswahl vorbereiteter Hochschulpläne, Hinzufügen und Entfernen von Kursen, visuelle Unterscheidung vorgeschlagener und eigener Einträge sowie Leeren des Plans mit Bestätigung.],
    [Authentifizierung], [Registrierung, Anmeldung und Abmeldung sowie die Zuordnung persönlicher Daten zur jeweiligen Identität.],
    [Studiengruppen], [Anlegen benannter Gruppen und Einladen weiterer Mitglieder; gemeinsame Aufgaben mit Fälligkeit, zuständiger Person und Status „offen“ beziehungsweise „erledigt“.],
    )
  },
  caption: [Funktionaler Untersuchungsumfang auf Grundlage der ursprünglichen Erstellungs-Prompts.],
) <tab:feature-scope>

Im Webprototyp wird die angemeldete Sitzung über Session-Cookies vermittelt. Bei der Migration sind die lokale Zuordnung persönlicher Daten und die für die Zusammenarbeit benötigte entfernte Authentifizierung gesondert zu betrachten. Die konkrete Umsetzung der Identitäts- und Sitzungsverwaltung wird in @ch:migration beschrieben.

Der Kollaborationsumfang wird auf Gruppenerstellung, Einladungen und gemeinsame Aufgaben begrenzt. Kommentare, gemeinsame Kalendertermine sowie zusätzliche Gruppeninhalte wie Links und Notizen werden nicht untersucht. Die Sichtbarkeit gemeinsamer Aufgaben bleibt auf die jeweiligen Gruppenmitglieder begrenzt; persönliche Noten und Termine werden durch die Gruppenzugehörigkeit nicht automatisch geteilt.

=== Technische Komponenten und Repository-Struktur

Der vorliegende Replit-Prototyp enthält eine React-Oberfläche, einen eigenständigen Express-API-Server, einen durch OpenAPI beschriebenen API-Vertrag sowie eine über Drizzle angebundene PostgreSQL-Datenhaltung. Oberfläche, Backend und gemeinsam genutzte Bibliotheken sind im Projekt getrennt abgelegt. Die Datenbankanbindung erwartet eine konfigurierte entfernte Datenbankverbindung. Damit liegt im untersuchten Fall serverseitiger Quellcode vor, der für die Migration analysiert und angepasst werden kann. @StudienplanerSource2026

Die Schnittstellen zwischen Frontend und Backend werden in der Datei `lib/api-spec/openapi.yaml` als gemeinsamer API-Vertrag beschrieben. Dieser legt die Endpunkte sowie die Strukturen der Anfragen und Antworten fest. Auf dieser Grundlage erzeugt Orval API-Aufrufhilfen, React-Query-Hooks und Typdefinitionen für das Frontend sowie Zod-Schemata für die Validierung im Backend. Die generierten Bestandteile werden über gemeinsam genutzte Projektbibliotheken eingebunden. Der OpenAPI-Vertrag bildet damit die gemeinsame Grundlage für die Schnittstellendefinition auf beiden Seiten und wird bei der späteren Anpassung des Kommunikationswegs erneut aufgegriffen. @StudienplanerSource2026

Die Oberfläche in `artifacts/studienplaner/` verwendet React und Vite sowie Tailwind CSS und shadcn/ui für die Darstellung. Der Express-Server liegt in `artifacts/api-server/` und wird mit esbuild als ESM-Anwendung gebündelt. Die gemeinsam genutzten Bibliotheken sind unter `lib/` zusammengefasst: `db/` enthält das Drizzle-Schema und den PostgreSQL-Client, `api-spec/` den OpenAPI-Vertrag, `api-zod/` die daraus erzeugten Validierungsschemata und `api-client-react/` die mit Orval generierten React-Query-Aufrufhilfen. `artifacts/mockup-sandbox/` dient der Gestaltung und Erprobung von Oberflächen und wird nicht als fachlicher Bestandteil der Migration betrachtet. @StudienplanerSource2026

@fig:original-web-architecture stellt die Komponenten und ihre Beziehungen dar. Die durchgezogenen Pfeile zeigen den Kommunikationsweg zur Laufzeit: Die React-Oberfläche ruft den Express-API-Server über HTTP auf; dessen Route-Handler greifen über Drizzle und den PostgreSQL-Client auf die Datenbank zu. Die gestrichelten Pfeile zeigen die Codegenerierung und Einbindung der aus dem OpenAPI-Vertrag erzeugten Bestandteile. Der Vertrag selbst ist damit eine Grundlage der Entwicklung und kein zusätzlicher Vermittler im Laufzeitpfad.

#figure(
  image("../figures/original-web-architecture.svg", width: 100%),
  caption: [Ursprüngliche Webarchitektur des Studienplaners mit Laufzeitkommunikation und OpenAPI-basierter Codegenerierung; eigene Darstellung auf Grundlage des Ausgangsartefakts.],
) <fig:original-web-architecture>

Diese Projektaufteilung ist noch kein Nachweis einer durchgängig getrennten Dreischichtenarchitektur. Für die Transformation sind die tatsächlichen Verantwortlichkeiten der Module und ihre Abhängigkeiten maßgeblich. Das in @lst:dashboard-upcoming gezeigte Beispiel veranschaulicht das im API-Server verwendete Verarbeitungsmuster innerhalb eines Route-Handlers.

#figure(
  block(
    width: 100%,
    inset: 8pt,
    fill: luma(246),
    radius: 2pt,
    {
      set text(size: 8.5pt)
      raw(read("../code/dashboard-upcoming.ts"), lang: "typescript", block: true)
    },
  ),
  kind: raw,
  supplement: [Quellcode],
  caption: [Exemplarischer Express-Route-Handler für die Abfrage anstehender Termine im Ausgangsartefakt.],
) <lst:dashboard-upcoming>

Der Handler liest nach der Authentifizierungsprüfung die Benutzerkennung aus der Sitzung, selektiert Termine für die kommenden sieben Tage und liefert das Abfrageergebnis als JSON zurück. Damit verbindet er HTTP-Verarbeitung, Fachlogik und Datenzugriff. Die Migration erfordert neben der Entkopplung vom HTTP-Transport eine architektonische Trennung in Controller (Schnittstellenverarbeitung), Service (Fachlogik) und Repository (Datenzugriff). Diese Aufteilung ermöglicht eine isolierte Prüfung der Geschäftslogik mit austauschbaren Datenzugriffen und erleichtert die Wartung sowie Anpassungen an Transport und Persistenz.

Das zentrale Migrationsproblem besteht somit in der Verlagerung der bisher servergebundenen Funktionen in die lokale Desktop-Laufzeit bei gleichzeitigem Erhalt der eingeschlossenen Kernfunktionen. Die Oberfläche soll möglichst weitgehend weiterverwendet werden. Technisch notwendige Anpassungen betreffen insbesondere den Aufrufweg zur Geschäftslogik, das Datenbankschema, die Sitzungsverwaltung und die Behandlung externer Dienste.

=== Lokale Funktionen und exemplarische Online-Anbindungen

Die persönlichen Funktionen ermöglichen die Untersuchung unterschiedlicher lokaler Interaktionsformen. Die CRUD-Funktionen der Noten-, Termin- und Stundenplanverwaltung stehen für die Verarbeitung von Benutzereingaben und den Zugriff auf persistente Anwendungsdaten. Die CSV- und iCal-/ICS-Importe ergänzen diesen Umfang um die Übernahme dateibasierter Daten. Dabei müssen externe Daten eingelesen, interpretiert, validiert und auf das interne Datenmodell abgebildet werden. Der Untersuchungsumfang umfasst somit sowohl die unmittelbare Bearbeitung von Daten über die Oberfläche als auch deren Übernahme aus Dateien. Diese Interaktionsformen bilden die Grundlage für die lokale Migration, bevor zusätzliche Netzwerkzugriffe und Synchronisierung betrachtet werden.

Für die Zielanwendung werden zwei Online-Anbindungen betrachtet: der Abruf des Studiengangkatalogs und die Zusammenarbeit im ausgewählten Gruppenbereich. Die übrigen eingeschlossenen Funktionen werden so eingeordnet, dass ihre Datenhaltung und Verarbeitung lokal erfolgen können. Dazu zählen auch die persönliche Datenzuordnung und die lokalen Dateiimporte. Nach einem Katalogabruf stehen die übernommenen Daten der lokalen Verarbeitung zur Verfügung; der Abruf selbst benötigt eine Verbindung.

Der Katalog dient als Beispiel für das Herunterladen, Prüfen und lokale Übernehmen externer Daten. Der Gruppenbereich ergänzt dieses Muster um entfernte Authentifizierung, Mitgliedschaft und Einladungen sowie die Synchronisierung lokal verarbeiteter Aufgabenänderungen. Innerhalb dieses Bereichs ist zwischen synchronisierbaren Aufgabenoperationen und unmittelbar netzwerkabhängigen Verwaltungsoperationen zu unterscheiden.

Diese Auswahl deckt zwei für den Leitfaden relevante Integrationsmuster ab: externe Datenübernahme und Local-First-Kollaboration. Weitere Funktionen mit vergleichbaren Anforderungen können auf denselben architektonischen Prinzipien aufbauen. Daraus ergibt sich die Annahme, dass solche Erweiterungen überwiegend eine erneute Anwendung der beschriebenen Muster erfordern. Eine Übertragbarkeit auf Funktionen mit zusätzlichen Anforderungen wird dadurch nicht nachgewiesen; diese wäre im jeweiligen Fall gesondert zu prüfen.

== Zielarchitektur und Sicherheitsbegriff <sec:target-architecture>

Ziel der Migration ist eine architektonisch nachvollziehbare Desktop-Anwendung, deren Struktur zugleich die Grundlage des Migrationsleitfadens bildet. Architektonische Qualität wird dabei durch klar zugeordnete Verantwortlichkeiten, definierte Schnittstellen und kontrollierte Abhängigkeiten konkretisiert. Wiederkehrende Aufgaben sollen nach einheitlichen Mustern umgesetzt werden. Dadurch können die Transformationsschritte verständlich beschrieben und auf weitere Funktionen mit vergleichbaren Anforderungen bezogen werden.

Die Zielarchitektur soll Darstellung, Geschäftslogik und Datenzugriff trennen. Die Verarbeitung fachlicher Aufrufe soll in Controller, Services und Repositories gegliedert werden. Der Renderer soll die Oberfläche bereitstellen; privilegierte Operationen sollen über begrenzte Preload-Schnittstellen an den Main-Prozess vermittelt werden. Die Kommunikation soll über Interprozesskommunikation erfolgen, ohne hierfür einen lokalen HTTP-Server zu betreiben. Die Prozessaufteilung und die fachliche Schichtentrennung ergänzen sich, sind jedoch nicht gleichzusetzen.

Funktional soll ein zusammenhängender, sinnvoll nutzbarer Kernumfang der ursprünglichen Anwendung erhalten bleiben. Entscheidend ist die Abdeckung der unterschiedlichen Interaktionsformen: Oberflächeninteraktionen mit lokaler Datenverarbeitung, das Einlesen und Validieren von Dateien sowie Netzwerkanfragen und die Synchronisierung gemeinsamer Aufgaben. Dashboard, Kalender, Noten und Studiengruppen bilden den fachlichen Kontext dieser allgemeineren Anwendungsaufgaben. Die vollständige Übernahme jeder CRUD-Variante ist demgegenüber kein eigenständiges Ziel. Der Kernumfang muss für die betrachteten Interaktionsformen vollständige Verarbeitungspfade einschließlich Datenzuordnung, Validierung und Fehlerbehandlung bereitstellen.

Lokale Datenhaltung bildet die Grundlage der Offline-Kernfunktionen. Local-First verbindet lokale Nutzbarkeit mit weitergehenden Eigenschaften wie Kollaboration und Kontrolle über die eigenen Daten. @Kleppmann2019 Die Arbeit greift daraus gezielt die lokale Verarbeitung und die ergänzende Synchronisierung im ausgewählten Gruppenfeature auf. Der Katalogabruf ergänzt diesen Umfang als Beispiel einer externen Datenübernahme.

Erweiterbarkeit bedeutet in diesem Zusammenhang, dass eine Person nach Einarbeitung in die dokumentierten Muster zusätzliche Funktionen mit vergleichbaren Anforderungen entsprechend umsetzen kann. Die vorhandenen Beispiele müssen deshalb sowohl den fachlichen Ablauf als auch die erforderlichen Validierungen, Berechtigungsprüfungen und Sicherheitsgrenzen nachvollziehbar zeigen. Das Fortführen dieser Muster soll zu einer konsistenten Anwendung führen, ohne für jede weitere Funktion einen neuen Architekturansatz entwickeln zu müssen.

Die Anwendung soll außerdem strukturell auf spätere Tests vorbereitet sein. Fachliche Services müssen unabhängig von Oberfläche und Transport prüfbar sein; Datenzugriffe und externe Dienste sollen für diese Tests durch geeignete Testimplementierungen ersetzt werden können. Zusätzliche Testfälle und Funktionen innerhalb der betrachteten Interaktionsformen sollen sich ergänzen lassen, ohne zuvor die Schichtentrennung oder die grundlegenden Abhängigkeiten neu ordnen zu müssen. Damit wird die Vermeidung solcher nachgelagerten Strukturkorrekturen als Ziel formuliert; die tatsächliche Testabdeckung wird gesondert bewertet.

Unter einer sicheren beziehungsweise gehärteten Electron-Anwendung versteht diese Arbeit die Umsetzung der anwendbaren Electron Security Guidelines im festgelegten Prüfumfang. Dazu gehören insbesondere die Isolation des Renderers, begrenzte privilegierte Schnittstellen, die Prüfung von IPC-Absendern und Eingaben sowie Beschränkungen für nachgeladene Inhalte, Navigation und zusätzliche Fenster. @ElectronSecurity2026 Der Begriff bezeichnet damit einen konkret prüfbaren Richtlinienrahmen und keinen Nachweis der Abwesenheit sämtlicher Schwachstellen.

== Anforderungskatalog <sec:requirements>

Die Anforderungen verbinden die Fallauswahl, das Architekturziel und den festgelegten funktionalen sowie sicherheitsbezogenen Umfang. Die Kennungen A1–A9 werden für die Zuordnung der Migrationsschritte und die spätere Evaluation verwendet. Die nachfolgend genannten Bewertungsansätze legen fest, worauf ein Nachweis Bezug nehmen muss; konkrete Szenarien und Ergebnisse werden in @ch:experiments dokumentiert.

=== A1: Lauffähige Desktop-Anwendung

Das Replit-Artefakt muss in eine lauffähige Electron-Anwendung überführt werden. Bewertet werden der Start einer gebauten Anwendung und die Ausführbarkeit der eingeschlossenen Kernfunktionen. Die untersuchte Version und die Laufzeitumgebung sind im Nachweis festzuhalten.

=== A2: Dreischichtenarchitektur

Darstellung, Geschäftslogik und Datenzugriff müssen getrennte Verantwortlichkeiten besitzen; fachliche Aufrufe sind entsprechend in Controller, Services und Repositories zu gliedern. Abhängigkeiten sind so zu gestalten, dass die Geschäftslogik unabhängig von Oberfläche und Transport mit austauschbaren Datenzugriffen geprüft werden kann. Der Nachweis erfolgt durch den Abgleich des Architekturmodells mit den tatsächlichen Modulen und einem beispielhaften fachlichen Ablauf. Die Electron-Prozesse sind dabei nicht mit den fachlichen Schichten gleichzusetzen; Geschäftslogik und Datenzugriff können beide im Main-Prozess liegen.

=== A3: Begrenzung des Refactoring-Aufwands

Bestandteile des Ausgangsartefakts sollen soweit möglich weiterverwendet werden. Notwendige Anpassungen und Ersetzungen sind nach Komponenten beziehungsweise Schichten zu dokumentieren und zu begründen. Diese Anforderung verlangt nachvollziehbare Eingriffe, jedoch keinen Nachweis eines global minimalen Entwicklungsaufwands.

=== A4: Lokale Kommunikation ohne HTTP-Wrapper

Die lokale Anwendungslogik darf nicht lediglich durch den Weiterbetrieb des ursprünglichen HTTP-Backends eingebettet werden. Der Nachweis beschreibt den tatsächlichen Aufrufweg über Preload und IPC und zeigt, dass für lokale fachliche Operationen kein HTTP-Server erforderlich ist. Externe HTTPS-Anbindungen bleiben davon unberührt.

=== A5: Lokale Datenhaltung und Offline-Kernfunktionen

Die für den Kernumfang ausgewählten lokalen Funktionen aus @sec:functional-scope und die lokale Identitätsverwaltung müssen ohne Netzwerkverbindung nutzbar sein. Änderungen müssen lokal gespeichert werden und einen Neustart der Anwendung überdauern. Für Funktionen mit Katalogdaten wird dabei ein bereits lokal verfügbarer Datenbestand vorausgesetzt. Der Nachweis muss zwischen diesen Funktionen und ausdrücklich netzwerkabhängigen Operationen unterscheiden.

=== A6: Local-First-Kollaboration am Gruppenfeature „Aufgaben“

Aufgabenänderungen müssen im festgelegten Kollaborationsumfang lokal verarbeitet und bei verfügbarer Verbindung übermittelt werden können. Der Nachweis beschreibt lokale Speicherung und anschließende Synchronisierung als getrennte Vorgänge. Gruppenerstellung und Einladungsfunktionen gehören zum Untersuchungsumfang; ihre unmittelbar netzwerkabhängigen Operationen sind gesondert auszuweisen. Kommentare sind ausgeschlossen. Eine Mehrgeräte-Synchronisierung oder gemeinsame Echtzeitbearbeitung von Dokumenten wird nicht verlangt.

=== A7: Härtung gemäß Electron Security Guidelines

Die offizielle Sicherheitscheckliste muss vollständig auf Anwendbarkeit geprüft werden. Für anwendbare Empfehlungen sind Umsetzung, Beleg und Nachweisebene zu dokumentieren. Eingabevalidierung und Maßnahmen gegen fremden Code werden durch geeignete vorhandene Tests und ausgewählte negative Laufzeitfälle ergänzt. Eine fehlende Prüfung darf nicht als Erfüllung gewertet werden; begrenzt belegte Aussagen müssen ihre Nachweisgrenze nennen.

=== A8: Repräsentativer Kernfunktionsumfang und Erweiterbarkeit

Der Demonstrator muss einen zusammenhängenden Kernfunktionsumfang mit repräsentativen Abläufen für Oberflächeninteraktionen, lokale Persistenz, Dateiimporte und Netzwerkanbindungen bereitstellen. Gruppenerstellung, Einladungen und synchronisierte Aufgaben bleiben Bestandteil dieses Umfangs. Die vollständige Übernahme jeder CRUD-Variante wird nicht verlangt. Der Nachweis benennt die tatsächlich übernommenen Funktionen, vergleicht deren Verhalten mit dem Ausgangsartefakt und ordnet ihnen die verwendeten Architektur- und Sicherheitsmuster zu. Er muss nachvollziehbar machen, wie weitere Funktionen mit vergleichbaren Anforderungen auf diesen Mustern aufbauen können. Änderungen der Identitäts- und Sitzungsverwaltung sind zu begründen. Vorhandene Service-Unit-Tests ergänzen den Nachweis für die tatsächlich geprüfte Logik.

=== A9: Nachvollziehbarer Migrationsleitfaden

Der Leitfaden muss Voraussetzungen, Reihenfolge, Änderungen, Entscheidungen und Kontrollpunkte der durchgeführten Migration beschreiben. Seine Schritte müssen dem Demonstrator zugeordnet werden können. Projektspezifische Anpassungen und mögliche übertragbare Prinzipien sind kenntlich zu machen. Ein zusätzlicher unabhängiger Reproduktionsdurchlauf ist kein Bestandteil dieser Anforderung.

== Abgrenzung des Untersuchungsumfangs

Untersucht werden die Migration und Härtung der Desktop-Anwendung anhand eines repräsentativen Kernumfangs. Dieser umfasst drei Interaktionsformen:

- *CRUD-Oberflächeninteraktionen:* Anlegen, Lesen, Bearbeiten und Löschen von Anwendungsdaten über die Oberfläche, einschließlich Eingabevalidierung, fachlicher Verarbeitung und lokaler Persistenz. Die Noten-, Termin- und Stundenplanverwaltung liefern hierfür die betrachteten Beispiele.
- *Dateiverarbeitung:* Einlesen, Parsen und Validieren lokaler CSV- und iCal-/ICS-Dateien sowie die Übernahme ihrer Inhalte in das interne Datenmodell. Betrachtet wird damit der vollständige Verarbeitungspfad eines Dateiimports.
- *Netzwerkinteraktionen:* Abruf und Verarbeitung externer Katalogdaten sowie die Anbindung der Gruppenfunktionen mit Authentifizierung, Gruppenerstellung, Einladungen und Synchronisierung gemeinsamer Aufgaben. Unmittelbare Online-Anfragen und nachgelagerte Synchronisierung werden unterschieden.

Der Sicherheitsumfang bezieht sich auf die Desktop-Anwendung und ihre Schnittstellen. Eingabevalidierung, anwendungsinterne Zugriffskontrollen und die sichere Anbindung sowie Verarbeitung externer Daten bleiben Bestandteil der Untersuchung.

Nicht untersucht werden die interne Sicherheit und der sichere Betrieb der entfernten Dienste, die Synchronisierung oder die Bereitstellung von Nutzdaten übernehmen. Die Härtung ihrer Server, Datenbanken und sonstigen Infrastruktur liegt außerhalb des Umfangs. Die Nutzung solcher Dienste begründet somit keine Aussage über deren eigene Sicherheit.

Ebenfalls ausgeschlossen ist der Schutz der lokalen Datenbank innerhalb des Betriebssystems, insbesondere die Verschlüsselung der Datenbankdatei und ihre Absicherung gegen Zugriffe anderer lokaler Prozesse oder Betriebssystembenutzer. Die Datenzuordnung und Zugriffskontrolle innerhalb der Anwendung sowie die Validierung vor Datenbankoperationen bleiben davon unberührt.

Die Local-First-Demonstration bleibt auf gemeinsame Aufgaben und die zugehörige Gruppen- und Einladungsverwaltung begrenzt. Kommentare, weitere gemeinsame Gruppeninhalte, die Synchronisierung persönlicher Daten über mehrere Endgeräte, gemeinsame Echtzeitbearbeitung von Dokumenten und Bucket-Dateifunktionen sind ausgeschlossen.

Frontend-Unit-Tests, automatisierte End-to-End-Tests und ein umfassender Sicherheitsvergleich zwischen Web- und Desktop-Laufzeit sind ausgeschlossen. Diese Abgrenzungen beschränken den Geltungsbereich der Ergebnisse und gelten nicht als unerfüllte Anforderungen.
