//---------------------------------------------------------------------
= Analyse und Anforderungsdefinition <ch:analysis>
//---------------------------------------------------------------------

== Vom übergeordneten Ziel zur Fallauswahl <sec:method-case-selection>

Die in Kapitel 1 formulierte Forschungsfrage nimmt einen frameworkagnostischen Migrationsansatz als Ausgangsziel auf.
Für dessen Bearbeitung ist zunächst zu bestimmen, welche Architekturmerkmale des Ausgangsartefakts die Transformation beeinflussen.
Entscheidend ist nicht allein das verwendete Frontend-Framework, sondern die Beschaffenheit der gesamten Anwendung samt ihrer Abhängigkeiten – insbesondere wo Geschäftslogik, Datenhaltung und Authentifizierung ausgeführt werden und welche dieser Bestandteile im verfügbaren Quellcode enthalten sind.
@tab:platform-comparison stellt die dokumentierten Backend-Strukturen von Replit und Lovable und die daraus abgeleiteten Ausgangslagen für die Migration gegenüber.

#figure(
  {
    set par(justify: false)
    set text(size: 9pt)
    table(
      columns: (1.1fr, 2fr, 2fr),
      inset: 7pt,
      align: left,
      stroke: 0.5pt + luma(180),
      fill: (x, y) => if y == 0 { luma(235) } else if x == 0 { luma(247) } else { white },
      table.header([*Vergleichsaspekt*], [*Replit*], [*Lovable*]),
      [Backend-Struktur],
      [Full-Stack-Anwendung mit Frontend und Backend; Einrichtung nach dem Bedarf der Anwendung.],
      [Verwaltetes Cloud-Backend; alternativ Anbindung eines eigenen Supabase-Projekts.],
      [Bereitgestellte Funktionen],
      [API-Routen, Datenbank und serverseitige Anwendungslogik.],
      [Datenbank, Authentifizierung, Dateispeicherung und serverseitige Funktionen als Backend-Dienste.],
      [Ansatzpunkt der Migration],
      [Soweit serverseitige Logik als eigener Quellcode vorliegt, kann ihre Übernahme und Anpassung an die lokale Laufzeit untersucht werden.],
      [Vom Dienst übernommene Verantwortlichkeiten müssen identifiziert und für eine lokale Nutzung gegebenenfalls nachgebildet werden.],
    )
  },
  caption: [Gegenüberstellung der dokumentierten Backend-Strukturen nach @ReplitWebApps2026, @LovableCloud2026 und @LovableSupabase2026; Ansatzpunkte der Migration als eigene Einordnung.],
) <tab:platform-comparison>

Die Entwicklung und Prüfung eines allgemeinen Leitfadens für beide Fälle würde den Umfang dieser Arbeit überschreiten.
Die praktische Untersuchung wird daher auf den Replit-Prototyp Studienplaner begrenzt.
Der resultierende Leitfaden kann potenziell übertragbare Prinzipien aufzeigen, wird jedoch nicht als validierte Lösung für beliebige Frameworks oder Plattformen ausgegeben.

== Funktionen und Architektur des Ausgangsartefakts <sec:starting-artifact>

=== Funktionsumfang des Ausgangsartefakts <sec:functional-scope>

Der Funktionsumfang der Webanwendung ergibt sich aus den ursprünglichen Erstellungs-Prompts zur persönlichen Studienorganisation und zur Zusammenarbeit in Studiengruppen.
@tab:feature-scope gibt einen Überblick über die Features des Ausgangsartefakts und ihre Funktionen.

#figure(
  {
    set par(justify: false)
    table(
    columns: (1fr, 3fr),
    inset: 6pt,
    align: left,
    table.header([*Bereich*],
    [*Funktionen der Webanwendung*]),
    [Dashboard],
    [Notendurchschnitt, gesammelte ECTS-Punkte, anstehende Fristen, Schnellzugriffe sowie letzte Aktivitäten und nächste Termine.],
    [Kalender],
    [Monatsansicht mit Tages-Popover, Termindetails und Löschen, farbliche Kennzeichnung der Terminarten, iCal-/ICS-Import, mehrtägige Termine und nach Priorität filterbare Listenansicht.],
    [Noten],
    [Semesterweise gruppierte Kurs-, Noten- und ECTS-Tabelle; Anlegen, Lesen, Bearbeiten und Löschen; CSV-Import mit Spaltenerkennung; ECTS-gewichteter Notendurchschnitt und Prüfung der Kurszugehörigkeit zum Studiengang.],
    [Stundenplan],
    [Raster mit fünf Wochentagen und sechs festen Hochschulzeitblöcken, Auswahl vorbereiteter Hochschulpläne, Hinzufügen und Entfernen von Kursen, visuelle Unterscheidung vorgeschlagener und eigener Einträge sowie Leeren des Plans mit Bestätigung.],
    [Authentifizierung],
    [Registrierung, Anmeldung und Abmeldung sowie die Zuordnung persönlicher Daten zur jeweiligen Identität.],
    [Studiengänge],
    [Abruf und Anzeige der angebotenen Studiengänge und der ihnen zugeordneten Module über das Backend.],
    [Studiengruppen],
    [Anlegen benannter Gruppen und Einladen weiterer Mitglieder; gemeinsame Aufgaben mit Fälligkeit, zuständiger Person und Status „offen“ beziehungsweise „erledigt“. Kommentare, gemeinsame Kalendertermine sowie zusätzliche Gruppeninhalte wie Links und Notizen],
    )
  },
  caption: [Funktionsumfang des Ausgangsartefakts auf Grundlage der ursprünglichen Erstellungs-Prompts.],
) <tab:feature-scope>

Zu den Online-Anbindungen der Webanwendung gehören die Bereitstellung der Studiengänge und zugehörigen Module über das Backend sowie die gemeinsame Nutzung von Aufgaben und weiteren Inhalten im Feature Studiengruppen.

=== Technische Komponenten und Repository-Struktur

Eine Übersicht der Verzeichnisse und zentralen Dateien des Ausgangsartefakts zeigt der Dateibaum in @app:web-prototype-filetree.

@fig:original-web-architecture stellt die Komponenten und ihre Beziehungen dar.

#figure(
  image("../figures/original-web-architecture.svg", width: 100%),
  caption: [Ursprüngliche Webarchitektur des Studienplaners mit Laufzeitkommunikation und OpenAPI-basierter Codegenerierung; eigene Darstellung auf Grundlage des Ausgangsartefakts.],
) <fig:original-web-architecture>

Das in @lst:dashboard-upcoming gezeigte Beispiel veranschaulicht das im API-Server verwendete Verarbeitungsmuster innerhalb eines Route-Handlers.

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

Der exemplarische Route-Handler verbindet HTTP-Verarbeitung, fachliche Auswahl und Datenzugriff innerhalb einer Funktion.

=== Lokale Funktionen und exemplarische Online-Anbindungen

Für die Untersuchung werden Funktionen mit vergleichbaren Verarbeitungspfaden gemeinsam betrachtet.
Die Features Noten, Kalender und Stundenplan beruhen im Kern auf dem Anlegen, Lesen, Ändern und Löschen persistenter Anwendungsdaten und werden deshalb als CRUD-Verarbeitung zusammengefasst.
Für diese Funktionen wird bei der Migration eine lokale Verarbeitung vorgesehen.
CSV- und iCal-/ICS-Importe bilden eine weitere Gruppe, da sie jeweils das Einlesen, Parsen, Validieren und Speichern externer Dateien erfordern.

Bei den Online-Anbindungen werden zwei unterschiedliche Verarbeitungspfade untersucht.
Das Feature Studiengänge dient als Beispiel für die einseitige Übernahme externer Referenzdaten in die lokale Datenhaltung.
Im Feature Studiengruppen wird anhand gemeinsamer Aufgaben die kollaborative Synchronisation betrachtet, bei der lokale Änderungen übertragen und entfernte Änderungen übernommen werden.
Gruppenerstellung und Einladungen werden dabei als unmittelbar netzwerkabhängige Verwaltungsoperationen eingeordnet.

Die Migration wird anhand dieser wiederkehrenden Verarbeitungsmuster beschrieben, sodass gleichartige Abläufe nicht für jedes Feature erneut erläutert werden müssen.

== Zielarchitektur und Sicherheitsbegriff <sec:target-architecture>

Die in @ch:intro beschriebene Problemstellung liegt darin, dass die sichtbare Funktionsfähigkeit einer KI-generierten Webanwendung ihre Eignung für eine lokale Desktop-Laufzeit nicht gewährleistet.
Insbesondere können bestehende Schwachstellen durch den erweiterten Zugriff auf Dateien und Systemressourcen zusätzliche Auswirkungen erhalten.
Die Zielarchitektur muss deshalb die Vertrauensgrenzen und Zugriffsmöglichkeiten an die lokale Laufzeit anpassen und zugleich einen sinnvoll nutzbaren Kernumfang des Ausgangsartefakts erhalten.
Vorhandene Oberflächenbestandteile und fachliche Regeln sollen soweit möglich weiterverwendet werden.
Dadurch bleibt der Prototyp die Grundlage der Transformation, und die Änderungen können auf die Anforderungen der neuen Umgebung konzentriert werden.
Architektur- und Sicherheitsanforderungen haben dabei Vorrang vor der unveränderten Übernahme bestehender Komponenten.

Die Dreischichtenarchitektur wird gewählt, um migrationsbedingte Änderungen an Kommunikation und Datenhaltung von der Darstellung und den fachlichen Regeln zu trennen.
Darstellung, Geschäftslogik und Datenzugriff sollen getrennte Verantwortlichkeiten besitzen; fachliche Aufrufe werden entsprechend in Controller, Services und Repositories gegliedert.

Die lokale Datenhaltung bildet die Grundlage für die autonome Offline-Verfügbarkeit des Local-First-Paradigmas.
Persönliche Änderungen sollen ohne Verbindung verarbeitet werden können und nach einem Neustart erhalten bleiben.
Die kollaborative Synchronisation im Feature Studiengruppen soll die gleichzeitige Zusammenarbeit unterstützen @Kleppmann2019.

Unter einer gehärteten Electron-Anwendung versteht diese Arbeit die Umsetzung der anwendbaren Electron Security Guidelines im festgelegten Prüfumfang.
Dazu zählen insbesondere Renderer-Isolation, begrenzte privilegierte Schnittstellen, die Prüfung von IPC-Absendern und Eingaben sowie Beschränkungen für nachgeladene Inhalte, Navigation und zusätzliche Fenster @ElectronSecurity2026.

Aus der Umsetzung wird ein Migrationsleitfaden abgeleitet.

== Anforderungskatalog <sec:requirements>

Die Anforderungen konkretisieren die beschriebenen Ziele und Entwurfsentscheidungen.
Ihre Kennungen dienen der Zuordnung zu den Migrationsschritten und der späteren Evaluation.
Die folgenden Bewertungsansätze bestimmen die erforderlichen Nachweise.

=== A1: Lauffähige Desktop-Anwendung

Das Ausgangsartefakt muss in eine lauffähige Electron-Anwendung überführt werden.
Bewertet werden der Start eines gebauten Pakets und die Ausführbarkeit der Funktionen, die den zuvor beschriebenen Verarbeitungspfaden zugeordnet sind.

=== A2: Dreischichtenarchitektur

Darstellung, Geschäftslogik und Datenzugriff müssen getrennte Verantwortlichkeiten besitzen.
Die Geschäftslogik muss unabhängig von Darstellung und Kommunikation prüfbar sein.
Der Nachweis erfolgt durch den Abgleich der tatsächlichen Module mit der Zielarchitektur und einen beispielhaften fachlichen Verarbeitungspfad.

=== A3: Weiterverwendung des Ausgangsartefakts

Bestandteile des Ausgangsartefakts sollen soweit möglich weiterverwendet werden.
Notwendige Anpassungen und Ersetzungen sind nach Komponenten beziehungsweise Schichten zu dokumentieren und zu begründen.
Bewertet wird die Nachvollziehbarkeit der Eingriffe; ein global minimaler Entwicklungsaufwand oder eine gemessene Zeitersparnis wird nicht verlangt.

=== A4: Lokale Kommunikation im Electron-Prozessmodell

Die lokale Kommunikation soll der in @sec:theory-electron dargestellten isolierten Architektur folgen.
Der Renderer soll lokale Fachoperationen über begrenzte Preload-Schnittstellen und IPC im Main-Prozess aufrufen.
Das ursprüngliche HTTP-Routing soll dabei nicht als lokaler Server weitergeführt werden.
Der Nachweis beschreibt den tatsächlichen Aufrufweg und zeigt, dass hierfür kein lokaler HTTP-Server erforderlich ist.

=== A5: Lokale Datenhaltung und autonome Offline-Verfügbarkeit

Die zur lokalen Verarbeitung vorgesehenen persönlichen Funktionen sowie die lokale Identitätsverwaltung im Feature Authentifizierung müssen die autonome Offline-Verfügbarkeit gewährleisten.
Für das Feature Studiengänge wird ein bereits lokal verfügbarer Datenbestand vorausgesetzt.
Der Nachweis umfasst die lokale Verarbeitung ohne Netzwerkverbindung und das erneute Lesen der gespeicherten Daten nach einem Anwendungsneustart.

=== A6: Kollaborative Synchronisation im Feature Studiengruppen

Gemeinsame Aufgaben werden als exemplarischer Synchronisationsfall gewählt, da mehrere Beteiligte denselben Datenbestand bearbeiten und Änderungen auch ohne unmittelbare Netzwerkverbindung lokal erfassen können sollen.
Aufgabenänderungen müssen lokal verarbeitet und bei vorhandener Verbindung synchronisiert werden können.
Lokale Speicherung, anschließende Übermittlung und die Übernahme entfernter Änderungen sind getrennt nachzuweisen.
Gruppenerstellung und Einladungen gehören zum Kernumfang; ihre Online-Voraussetzungen sind auszuweisen.

=== A7: Härtung gemäß Electron Security Guidelines

Die Sicherheitscheckliste muss vollständig auf Anwendbarkeit geprüft werden.
Für anwendbare Empfehlungen sind Umsetzung, Beleg und Nachweisebene zu dokumentieren.
Vorhandene Tests und ausgewählte negative Laufzeitfälle ergänzen die Prüfung.
Fehlende oder begrenzte Nachweise müssen ausdrücklich erkennbar bleiben.

=== A8: Abdeckung wiederkehrender Verarbeitungsmuster und Erweiterbarkeit

Der Demonstrator muss die beschriebenen Verarbeitungspfade für CRUD-Verarbeitung, Dateiimporte, einseitige Datenübernahme und kollaborative Synchronisation abdecken.
Unmittelbar netzwerkabhängige Verwaltungsoperationen werden gesondert ausgewiesen.
Der Nachweis ordnet den Verarbeitungspfaden konkrete Funktionen sowie die angewendeten Architektur- und Sicherheitsmuster zu.
Er muss zeigen, wie weitere Funktionen mit vergleichbaren Verarbeitungspfaden auf diesen Mustern aufbauen können.

=== A9: Dokumentation und Zuordnung der Migrationsschritte

Der Leitfaden muss Voraussetzungen, Reihenfolge, Änderungen, Entscheidungen und Kontrollpunkte beschreiben.
Seine Schritte müssen den beschriebenen Verarbeitungsmustern und ihrer Umsetzung im Demonstrator zugeordnet werden können.
Bewertet werden die Nachvollziehbarkeit dieser Zuordnung und die Kennzeichnung des Geltungsbereichs der Empfehlungen.

== Abgrenzung des Untersuchungsumfangs

Die Sicherheitsprüfung konzentriert sich auf die Architektur und Implementierung des Demonstrators sowie seine Schnittstellen zu verwendeten Bibliotheken und entfernten Diensten.
Eine eigenständige Sicherheitsprüfung des internen Codes dieser Bibliotheken und Dienste sowie ihres Betriebs würde den Umfang der Arbeit überschreiten.
Ihre Einbindung in den Demonstrator bleibt dagegen Bestandteil der Untersuchung, insbesondere die Begrenzung von Zugriffsrechten und die Prüfung eingehender Daten.

Der Schutz lokal gespeicherter Daten wird hinsichtlich der Zugriffspfade innerhalb der Anwendung betrachtet.
Die Verschlüsselung der Datenbankdatei und ihr Schutz vor anderen Betriebssystemprozessen oder Benutzern bleiben außerhalb des Untersuchungsumfangs, da hierfür ein weitergehendes Schutzkonzept für die lokale Systemumgebung erforderlich wäre.

Die Verifikation konzentriert sich auf die festgelegten Architektur- und Sicherheitsanforderungen.
Frontend-Unit-Tests und automatisierte End-to-End-Tests werden im verfügbaren Arbeitsumfang nicht durchgeführt.
Ein umfassender Sicherheitsvergleich zwischen Web- und Desktop-Laufzeit sowie ein unabhängiger Reproduktionsdurchlauf des Migrationsleitfadens würden zusätzliche Untersuchungen erfordern.
Aussagen zur Sicherheit und Übertragbarkeit bleiben daher auf die durchgeführten Prüfungen und dokumentierten Nachweise begrenzt.
