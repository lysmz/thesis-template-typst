//---------------------------------------------------------------------
= Analyse und Anforderungsdefinition <ch:analysis>
//---------------------------------------------------------------------

== Vom übergeordneten Ziel zur Fallauswahl

Die in @ch:intro formulierte Forschungsfrage nimmt einen frameworkagnostischen Migrationsansatz als Ausgangsziel auf. Für dessen Bearbeitung ist zunächst zu bestimmen, welche Architekturmerkmale des Ausgangsartefakts die Transformation beeinflussen. Entscheidend ist nicht allein das verwendete Frontend-Framework, sondern auch, wo Geschäftslogik, Datenhaltung und Authentifizierung ausgeführt werden und welche dieser Bestandteile im verfügbaren Quellcode enthalten sind.

Zur Einordnung werden Replit und Lovable anhand ihrer offiziellen Dokumentation beispielhaft betrachtet. Replit beschreibt Webanwendungen als standardmäßig erzeugte Full-Stack-Anwendungen mit Frontend und Backend. API-Routen, Datenbank und serverseitige Logik werden nach dem Bedarf der Anwendung eingerichtet. Diese Dokumentation beschreibt das Plattformangebot; den konkreten Aufbau des Studienplaners belegt erst die Analyse des vorliegenden Artefakts @ReplitWebApps2026.

Lovable dokumentiert dagegen einen standardmäßig aktivierten verwalteten Cloud-Backend-Dienst auf Grundlage der Open-Source-Technologie von Supabase. Alternativ kann ein eigenes Supabase-Projekt angebunden werden. Datenbank, Authentifizierung, Dateispeicherung und serverseitige Funktionen werden damit als Backend-Dienste bereitgestellt. Diese dokumentierte Dienststruktur wird hier als Backend-as-a-Service eingeordnet. Daraus folgt jedoch nicht, dass jedes Lovable-Projekt dieselbe Architektur aufweist @LovableSupabase2026.

Für die Migration ergibt sich daraus eine unterschiedliche Ausgangslage. Liegt die serverseitige Anwendungslogik als eigener Quellcode vor, kann ihre Übernahme und Anpassung an die lokale Laufzeit untersucht werden. Bei einer dienstgebundenen Architektur müssen dagegen auch die vom Dienst übernommenen Verantwortlichkeiten identifiziert und gegebenenfalls lokal nachgebildet werden. Eine reine Ersetzung des Frontend-Transports deckt diese zweite Ausgangslage nicht vollständig ab.

Die Entwicklung und Prüfung eines allgemeinen Leitfadens für beide Fälle würde den Umfang dieser Arbeit überschreiten. Die praktische Untersuchung wird daher auf den Replit-Prototyp Studienplaner begrenzt. Lovable dient zur dokumentationsgestützten Begründung dieser Eingrenzung; eine Lovable-Anwendung wird nicht migriert. Der resultierende Leitfaden kann potenziell übertragbare Prinzipien aufzeigen, wird jedoch nicht als validierte Lösung für beliebige Frameworks oder Plattformen ausgegeben.

== Funktionen und Architektur des Ausgangsartefakts <sec:starting-artifact>

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

Der vorliegende Replit-Prototyp enthält eine React-Oberfläche, einen eigenständigen Express-API-Server, einen durch OpenAPI beschriebenen API-Vertrag sowie eine über Drizzle angebundene PostgreSQL-Datenhaltung. Oberfläche, Backend und gemeinsam genutzte Bibliotheken sind im Projekt getrennt abgelegt. Die Datenbankanbindung erwartet eine konfigurierte entfernte Datenbankverbindung. Damit liegt im untersuchten Fall serverseitiger Quellcode vor, der für die Migration analysiert und angepasst werden kann @StudienplanerSource2026.

Die Schnittstellen zwischen Frontend und Backend werden in der Datei `lib/api-spec/openapi.yaml` als gemeinsamer API-Vertrag beschrieben. Dieser legt die Endpunkte sowie die Strukturen der Anfragen und Antworten fest. Auf dieser Grundlage erzeugt Orval API-Aufrufhilfen, React-Query-Hooks und Typdefinitionen für das Frontend sowie Zod-Schemata für die Validierung im Backend. Die generierten Bestandteile werden über gemeinsam genutzte Projektbibliotheken eingebunden. Der OpenAPI-Vertrag bildet damit die gemeinsame Grundlage für die Schnittstellendefinition auf beiden Seiten und wird bei der späteren Anpassung des Kommunikationswegs erneut aufgegriffen @StudienplanerSource2026.

Die Oberfläche in `artifacts/studienplaner/` verwendet React und Vite sowie Tailwind CSS und shadcn/ui für die Darstellung. Der Express-Server liegt in `artifacts/api-server/` und wird mit esbuild als ESM-Anwendung gebündelt. Die gemeinsam genutzten Bibliotheken sind unter `lib/` zusammengefasst: `db/` enthält das Drizzle-Schema und den PostgreSQL-Client, `api-spec/` den OpenAPI-Vertrag, `api-zod/` die daraus erzeugten Validierungsschemata und `api-client-react/` die mit Orval generierten React-Query-Aufrufhilfen. `artifacts/mockup-sandbox/` dient der Gestaltung und Erprobung von Oberflächen und wird nicht als fachlicher Bestandteil der Migration betrachtet @StudienplanerSource2026.

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

Der exemplarische Route-Handler verbindet HTTP-Verarbeitung, fachliche Auswahl und Datenzugriff innerhalb einer Funktion. Die Projektaufteilung in Frontend, API-Server und gemeinsame Bibliotheken entspricht daher noch keiner durchgängigen Trennung fachlicher Verantwortlichkeiten.

Das zentrale Migrationsproblem besteht darin, die bisher servergebundenen Funktionen in die lokale Desktop-Laufzeit zu überführen. Dabei sind insbesondere der Kommunikationsweg, die Datenhaltung, die Sitzungsverwaltung und die Zuständigkeiten der beteiligten Komponenten neu einzuordnen.

=== Lokale Funktionen und exemplarische Online-Anbindungen

Die ausgewählten Funktionen decken unterschiedliche Verarbeitungspfade ab. Noten-, Termin- und Stundenplanverwaltung stehen für die Verarbeitung von Benutzereingaben und persistenten Anwendungsdaten. CSV- und iCal-/ICS-Importe ergänzen diesen Umfang um das Einlesen, Parsen und Validieren externer Dateien.

Für die persönlichen Funktionen wird eine lokale Verarbeitung vorgesehen. Die benötigten Katalogdaten müssen dafür bereits lokal verfügbar sein. Der Studienkatalog und die Studiengruppen bilden die betrachteten Online-Anbindungen: Beim Katalog werden externe Referenzdaten heruntergeladen und lokal übernommen; im Gruppenbereich werden gemeinsame Daten zwischen Beteiligten abgeglichen. Gruppenerstellung und Einladungen werden dabei als unmittelbar netzwerkabhängige Verwaltungsoperationen eingeordnet.

Diese Auswahl bildet den funktionalen Bezugsrahmen für die Zielarchitektur und den Anforderungskatalog.

== Zielarchitektur und Sicherheitsbegriff <sec:target-architecture>

Ziel der Migration ist eine lauffähige Desktop-Anwendung, die einen sinnvoll nutzbaren Kernumfang des Ausgangsartefakts erhält. Vorhandene Oberflächenbestandteile und fachliche Regeln sollen soweit möglich weiterverwendet werden. Dadurch bleibt der Prototyp die Grundlage der Transformation, und die Änderungen können auf die Anforderungen der neuen Umgebung konzentriert werden. Architektur- und Sicherheitsanforderungen haben dabei Vorrang vor der unveränderten Übernahme bestehender Komponenten.

Für die fachliche Struktur wird eine Dreischichtenarchitektur gewählt. Darstellung, Geschäftslogik und Datenzugriff sollen getrennte Verantwortlichkeiten besitzen; fachliche Aufrufe werden entsprechend in Controller, Services und Repositories gegliedert. Damit lassen sich Änderungen am Transport und an der Persistenz gezielt zuordnen. Fachliche Services sollen unabhängig von Oberfläche und Transport geprüft werden können, wobei Datenzugriffe und externe Dienste durch Testimplementierungen ersetzbar sind.

Die Electron-Prozesse setzen diese fachlichen Schichten nicht unmittelbar abbildend um. Der Renderer stellt die Oberfläche bereit; Geschäftslogik und Datenzugriff können beide im Main-Prozess liegen. Privilegierte Operationen werden über begrenzte Preload-Schnittstellen und IPC aufgerufen. Dieser Kommunikationsweg organisiert lokale Fachoperationen innerhalb der Electron-Prozessstruktur, ohne das HTTP-Routing des ursprünglichen Backends als zusätzliche Vermittlungsschicht weiterzuführen.

Die lokale Datenhaltung bildet die Grundlage der Offline-Nutzung. Persönliche Änderungen sollen ohne Verbindung verarbeitet werden können und nach einem Neustart erhalten bleiben. Ergänzende Online-Anbindungen übernehmen zwei unterschiedliche Aufgaben: Der Katalogabruf aktualisiert lokal verfügbare Referenzdaten; die Gruppensynchronisierung übermittelt lokal verarbeitete Aufgabenänderungen bei vorhandener Verbindung. Damit wird die Offline-Kernanwendung um den ausgewählten Kollaborationsumfang erweitert @Kleppmann2019.

Der Demonstrator soll vollständige Beispiele für die betrachteten Interaktionsformen bereitstellen. Dazu gehören Datenzuordnung, Validierung, Berechtigungsprüfung und Fehlerbehandlung. Die vollständige Übernahme jeder CRUD-Variante ist kein eigenständiges Ziel. Entscheidend ist, dass die vorhandenen Verarbeitungspfade einheitliche Muster zeigen, auf denen weitere Funktionen und Tests mit vergleichbaren Anforderungen aufbauen können.

Der Wechsel zur lokalen Laufzeit erweitert die Zugriffsmöglichkeiten auf Dateien und Systemressourcen. Unter einer gehärteten Electron-Anwendung versteht diese Arbeit deshalb die Umsetzung der anwendbaren Electron Security Guidelines im festgelegten Prüfumfang. Dazu zählen insbesondere Renderer-Isolation, begrenzte privilegierte Schnittstellen, die Prüfung von IPC-Absendern und Eingaben sowie Beschränkungen für nachgeladene Inhalte, Navigation und zusätzliche Fenster @ElectronSecurity2026.

Aus der Umsetzung wird ein Migrationsleitfaden abgeleitet. Dieser soll die Voraussetzungen, Entscheidungen, Änderungen und Kontrollpunkte so dokumentieren, dass das Vorgehen am Demonstrator nachvollzogen werden kann. Projektspezifische Anpassungen und möglicherweise übertragbare Prinzipien werden dabei unterschieden.

== Anforderungskatalog <sec:requirements>

Die Anforderungen konkretisieren die beschriebenen Ziele und Entwurfsentscheidungen. Ihre Kennungen dienen der Zuordnung zu den Migrationsschritten und der späteren Evaluation. Die folgenden Bewertungsansätze bestimmen die erforderlichen Nachweise; die Ergebnisse werden in @ch:experiments dargestellt.

=== A1: Lauffähige Desktop-Anwendung

Das Ausgangsartefakt muss in eine lauffähige Electron-Anwendung überführt werden. Bewertet werden der Start eines gebauten Pakets und die Ausführbarkeit der eingeschlossenen Kernfunktionen. Version und Laufzeitumgebung sind im Nachweis festzuhalten.

=== A2: Dreischichtenarchitektur

Darstellung, Geschäftslogik und Datenzugriff müssen getrennte Verantwortlichkeiten besitzen. Die Fachlogik muss unabhängig von Oberfläche und Transport prüfbar sein. Der Nachweis erfolgt durch den Abgleich der tatsächlichen Module mit der Zielarchitektur und einen beispielhaften fachlichen Verarbeitungspfad.

=== A3: Begrenzung des Refactoring-Aufwands

Bestandteile des Ausgangsartefakts sollen soweit möglich weiterverwendet werden. Notwendige Anpassungen und Ersetzungen sind nach Komponenten beziehungsweise Schichten zu dokumentieren und zu begründen. Bewertet wird die Nachvollziehbarkeit der Eingriffe; ein global minimaler Entwicklungsaufwand oder eine gemessene Zeitersparnis wird nicht verlangt.

=== A4: Lokale Kommunikation im Electron-Prozessmodell

Lokale Fachoperationen müssen über begrenzte Preload-Schnittstellen und IPC ausgeführt werden. Dies nutzt den in @sec:theory-electron beschriebenen Kommunikationsweg des Electron-Prozessmodells. Die zusätzliche Entwurfsentscheidung dieser Arbeit besteht darin, das ursprüngliche HTTP-Routing nicht als lokalen Server weiterzuführen. Der Nachweis beschreibt den tatsächlichen Aufrufweg und zeigt, dass hierfür kein lokaler HTTP-Server erforderlich ist. Externe HTTPS-Anbindungen werden gesondert betrachtet.

=== A5: Lokale Datenhaltung und Offline-Kernfunktionen

Die ausgewählten persönlichen Kernfunktionen und die lokale Identitätsverwaltung müssen ohne Netzwerkverbindung nutzbar sein. Änderungen müssen einen Anwendungsneustart überdauern. Damit wird die lokale Nutzbarkeit als Grundlage des in @sec:theory-local-first beschriebenen Local-First-Anspruchs konkretisiert; A6 ergänzt die Zusammenarbeit. Für katalogabhängige Funktionen wird ein bereits lokal verfügbarer Datenbestand vorausgesetzt. Der Nachweis umfasst lokale Verarbeitung und anschließendes erneutes Lesen der gespeicherten Daten.

=== A6: Local-First-Kollaboration am Gruppenfeature „Aufgaben“

Aufgabenänderungen müssen lokal verarbeitet und bei vorhandener Verbindung synchronisiert werden können. Lokale Speicherung und anschließende Übermittlung sind getrennt nachzuweisen. Gruppenerstellung und Einladungen gehören zum Kernumfang; ihre Online-Voraussetzungen sind auszuweisen.

=== A7: Härtung gemäß Electron Security Guidelines

Die Sicherheitscheckliste muss vollständig auf Anwendbarkeit geprüft werden. Für anwendbare Empfehlungen sind Umsetzung, Beleg und Nachweisebene zu dokumentieren. Vorhandene Tests und ausgewählte negative Laufzeitfälle ergänzen die Prüfung. Fehlende oder begrenzte Nachweise müssen ausdrücklich erkennbar bleiben.

=== A8: Repräsentativer Kernfunktionsumfang und Erweiterbarkeit

Der Demonstrator muss zusammenhängende Verarbeitungspfade für CRUD-Oberflächeninteraktionen, Dateiimporte und Netzwerkanbindungen bereitstellen. Der Nachweis benennt die übernommenen Funktionen, vergleicht ihr Verhalten mit dem Ausgangsartefakt und ordnet ihnen Architektur- und Sicherheitsmuster zu. Er muss zeigen, wie weitere Funktionen mit vergleichbaren Anforderungen auf diesen Mustern aufbauen können.

=== A9: Nachvollziehbarer Migrationsleitfaden

Der Leitfaden muss Voraussetzungen, Reihenfolge, Änderungen, Entscheidungen und Kontrollpunkte beschreiben. Seine Schritte müssen dem Demonstrator zugeordnet werden können. Bewertet werden die Nachvollziehbarkeit dieser Zuordnung und die Kennzeichnung des Geltungsbereichs der Empfehlungen.

== Abgrenzung des Untersuchungsumfangs

Die interne Sicherheit und der Betrieb entfernter Dienste für Synchronisierung oder Datenbereitstellung liegen außerhalb des Umfangs. Ebenso ausgeschlossen sind die Verschlüsselung der lokalen Datenbankdatei und ihr Schutz gegenüber anderen Betriebssystemprozessen oder Benutzern.

Kommentare, weitere gemeinsame Gruppeninhalte, die Synchronisierung persönlicher Daten über mehrere Endgeräte und gemeinsame Echtzeitbearbeitung von Dokumenten werden nicht untersucht. Auch die Entwicklung eines vollständigen entfernten Kontolebenszyklus mit Registrierung und Passwortzurücksetzung sowie die Übertragung von Dateien über entfernte Speicherbereiche gehören nicht zum Umfang.

Frontend-Unit-Tests, automatisierte End-to-End-Tests, ein umfassender Sicherheitsvergleich zwischen Web- und Desktop-Laufzeit sowie ein unabhängiger Reproduktionsdurchlauf des Leitfadens sind ausgeschlossen. Aussagen zur Sicherheit und Übertragbarkeit bleiben auf die ausgewiesenen Verfahren und Nachweise begrenzt.
