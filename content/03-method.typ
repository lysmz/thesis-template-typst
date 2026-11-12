//---------------------------------------------------------------------
= Methodisches Vorgehen <ch:method>
//---------------------------------------------------------------------

== Design Science Research und Erkenntnisziel

Die Arbeit orientiert sich an DSR. Dabei wird eine Lösung für ein praktisches Problem entwickelt und anhand festgelegter Anforderungen bewertet.
Im Mittelpunkt stehen die Entwicklung eines Migrationspfads und dessen Anwendung auf den KI-generierten Webprototyp Studienplaner.
Die Forschungsaktivitäten nach Peffers et al. wurden bereits bei der Gliederung der Arbeit eingeplant.
Das Prozessmodell nach Peffers et al. unterscheidet Problemidentifikation und Motivation, Definition der Lösungsziele, Entwurf und Entwicklung, Demonstration, Evaluation sowie Kommunikation @Peffers2007.

Diese Forschungsaktivitäten strukturieren die wissenschaftliche Darstellung des durchgeführten Vorgehens.
Ihre frühzeitige Planung bedeutet nicht, dass sämtliche technischen Schritte bereits zu Beginn festgelegt waren.
Die Migration wurde schrittweise entwickelt; Erkenntnisse aus der Analyse und Umsetzung führten zu Anpassungen der Architektur und des weiteren Vorgehens.
Die nachfolgend beschriebenen Entwicklungsphasen fassen den tatsächlichen Migrationsprozess zusammen.

Das zentrale wissenschaftliche Ergebnis ist der Migrationspfad. Er wird aus den für die Migration notwendigen Veränderungen abgeleitet und beschreibt ein fallbezogenes Vorgehen.
Die Electron-Anwendung dient als technischer Demonstrator, an dem die Umsetzung des Migrationspfads gezeigt und geprüft wird.
Der Migrationspfad dokumentiert die Voraussetzungen, Entscheidungen, Migrationsschritte und Kontrollpunkte der Migration.
Aussagen über seine Übertragbarkeit werden auf den untersuchten Fall begrenzt.

== Untersuchungsgegenstand und Analyseverfahren

Ausgangspunkt war der auf Replit erzeugte Studienplaner.
Wie in @ch:intro erläutert, erfolgte dessen Erstellung anhand funktionaler Beschreibungen ohne verbindliche Vorgaben zur technischen Architektur.
Untersucht wurde damit ein KI-generierter Webprototyp, dessen Komponenten für die Electron-Laufzeit neu eingeordnet werden mussten.

Die Untersuchung erfolgte anhand des Quellcodes, der Projektkonfiguration und der vorhandenen technischen Dokumentation.
Dabei wurden Benutzeroberfläche, Schnittstellen, Geschäftslogik, Datenhaltung und externe Abhängigkeiten erfasst.
Für die Migration war insbesondere zu klären, welche Funktionen unmittelbar von einem Backend oder einer Netzwerkverbindung abhingen, welche Bestandteile lokal weiterverwendet werden konnten und an welchen Stellen eine Anpassung der Verantwortlichkeiten erforderlich war.

Ergänzend wurde die offizielle Plattformdokumentation herangezogen, um die Wahl des Untersuchungsgegenstands einzuordnen.
Replit und Lovable wurden hierzu beispielhaft hinsichtlich ihrer dokumentierten Backend-Ansätze betrachtet.
Diese Betrachtung dient der Begründung des Untersuchungsumfangs.
Die Ergebnisse und der daraus abgeleitete Anforderungskatalog werden in @ch:analysis dargestellt.

== Erster Migrationsversuch und Konsequenzen für das Migrationsvorgehen <sec:migration-preliminary>

Vor der Entwicklung des in dieser Arbeit untersuchten Demonstrators wurde in einem separaten Repository ein erster Migrationsversuch mit LLM-Unterstützung durchgeführt.
Ausgangs- und Zielprojekt wurden dem LLM als Arbeitsgrundlage bereitgestellt.
Die Migration sollte schrittweise erfolgen, beginnend mit der Datenbank und anschließend den Schnittstellen und der Benutzeroberfläche.
Die Datenbankübertragung ließ sich dabei ohne wesentliche Schwierigkeiten durchführen.
Die Schnittstellen wurden zunächst manuell angepasst, ohne den vorhandenen OpenAPI-Vertrag als gemeinsame Grundlage für die Generierung der Schnittstellenbausteine weiterzuführen.

Bei der weiteren Bearbeitung wurden vorhandene Dateien und ihre Geschäftslogik durch das LLM gelesen und in der Zielstruktur neu geschrieben.
Dabei entstanden auch kleinere Änderungen, deren Notwendigkeit für die Migration nicht erkennbar war.
Beobachtet wurden unter anderem Änderungen von Texteingaben zu numerischen Formularfeldern, Anpassungen der Datumsverarbeitung und zusätzliche Platzhalter in Formularen.
Solche Eingriffe erschwerten es, notwendige Anpassungen an die Desktop-Zielumgebung von unbeabsichtigten Veränderungen des Anwendungsverhaltens zu unterscheiden.
Die manuelle Bearbeitung mehrerer Schnittstellenmodule erschwerte außerdem die Nachverfolgung von Datentypen und Konvertierungen über den gesamten Verarbeitungspfad.
Dadurch war weniger übersichtlich, ob der übernommene Funktionsumfang und das Verhalten weiterhin dem Webprototyp entsprachen.

Diese Erfahrungen flossen in das überarbeitete Vorgehen ein.
Vorhandene Oberflächenkomponenten und fachliche Regeln sollten gezielt weiterverwendet und Änderungen auf die Anforderungen der Desktop-Zielumgebung zurückgeführt werden.
Für die Kernschnittstellen wurde der vorhandene OpenAPI-Vertrag beibehalten; Typen, React-Query-Hooks und Zod-Laufzeitschemata wurden daraus mit einer auf IPC angepassten Codegenerierung abgeleitet.
Die architektonische Trennung sollte zugleich die Zuordnung und Prüfung der erforderlichen Änderungen erleichtern.
Der erste Migrationsversuch erklärt damit die Entwicklung dieser Entscheidungen.
Seine Darstellung beruht auf rückblickend eingeordneten Beobachtungen des Entwicklungsverlaufs und stellt keine kontrollierte Vergleichsevaluation der beiden Vorgehensweisen dar.

== Ablauf der Entwicklung

Die technische Entwicklung gliederte sich in drei aufeinander aufbauende Phasen.
Diese sind Arbeitsschritte innerhalb der DSR-Aktivität Entwurf und Entwicklung und bilden kein eigenständiges Forschungsmodell.

=== Phase 1: Migration zur Offline-Kernanwendung

Zunächst wurden die eingeschlossenen Kernfunktionen von der ursprünglichen Server-Laufzeit entkoppelt.
Hierzu wurden die Komponenten auf eine Desktop-Architektur mit getrennten Verantwortlichkeiten für Benutzeroberfläche, Geschäftslogik und Datenzugriff abgebildet.
Die Datenhaltung wurde lokal bereitgestellt.
Aufrufe der bisherigen Webschnittstellen wurden in einen begrenzten Kommunikationsweg zwischen Renderer, Preload und Main-Prozess überführt.

Ziel dieser Phase war eine Electron-Anwendung, deren lokale Kernfunktionen die autonome Offline-Verfügbarkeit des Local-First-Paradigmas unterstützen und deren Architektur zugleich die Grundlage für die nachfolgenden Erweiterungen bildet.
Die Verantwortlichkeiten und Schnittstellen wurden so gestaltet, dass Synchronisation und weitere externe Dienste später integriert werden können, ohne die lokale Kernarchitektur erneut grundlegend umzustrukturieren.
Damit verbindet diese Phase die Herstellung lokaler Nutzbarkeit mit der Vorbereitung einer schrittweise erweiterbaren Anwendung.

=== Phase 2: Ergänzung um Synchronisation und weitere Online-Anbindungen

Aufbauend auf der Offline-Kernanwendung wurden in der zweiten Phase die netzwerkabhängigen Funktionen betrachtet.
Diese waren bei der Herstellung der Offline-Kernanwendung zunächst ausgeklammert worden.
Ziel war es, externe Datenquellen und Dienste schrittweise in die vorbereitete Desktop-Architektur einzubinden und dadurch den angestrebten Funktionsumfang zu vervollständigen.

Die Wiederanbindung wurde anhand zweier unterschiedlich komplexer Fälle untersucht.
Die einseitige Datenübernahme aus einem Studiengangskatalog dient als Beispiel für das Herunterladen externer Daten und deren Speicherung in der lokalen Anwendung.
Dieser Vorgang umfasst keine Synchronisation und veranschaulicht zunächst einen einfachen Netzwerkzugriff.
Darauf aufbauend wurde mit der Verwaltung gemeinsamer Gruppenaufgaben ein Beispiel für die Zusammenarbeit in synchronisierten Studiengruppen betrachtet.
Hier werden lokal verarbeitete Änderungen über eine zusätzliche Synchronisationsinfrastruktur zwischen den Beteiligten ausgetauscht.
Dieser zweite Fall greift gezielt Eigenschaften des Local-First-Paradigmas auf.

=== Phase 3: Konsolidierte Prüfung und Härtung

Nach der funktionalen Umsetzung wurden die entstandenen lokalen und netzwerkbezogenen Schnittstellen systematisch hinsichtlich der Electron-Sicherheitsrichtlinien geprüft und erforderliche Anpassungen vorgenommen. 
Die Darstellung einer abschließenden Härtung bedeutet daher nicht, dass Sicherheit erst nach Abschluss der Entwicklung berücksichtigt wird.
Der Sicherheitsbegriff wird für diese Arbeit über die Umsetzung der anwendbaren Electron-Sicherheitsrichtlinien einschließlich Eingabevalidierung und Maßnahmen gegen die Ausführung fremden Codes operationalisiert @ElectronSecurity2026.

Diese abschließende Phase bündelt die Prüfung der fertigen Anwendung.
Sicherheitsrelevante Architekturentscheidungen, insbesondere die Trennung privilegierter Funktionen vom Renderer und die Begrenzung der Preload-Schnittstellen, betreffen bereits die vorausgehenden Phasen.

== Ableitung des Migrationspfads und Bewertung

Aus dem dokumentierten Migrationsprozess werden die Schritte des Migrationspfads abgeleitet.

Die Bewertung orientiert sich am Anforderungskatalog aus @ch:analysis.
Architektur- und Quellcodeinspektionen, vorhandene Service-Unit-Tests sowie begrenzte manuelle Demonstrationen bilden die vorgesehenen Nachweisformen.
Für den Sicherheitsnachweis werden Anwendbarkeit, Umsetzung und Beleg jeder Electron-Empfehlung getrennt erfasst.
Die Ergebnisdarstellung erfolgt in @ch:experiments.
