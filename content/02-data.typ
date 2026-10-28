//---------------------------------------------------------------------
= Theoretischer Hintergrund <ch:data>
//---------------------------------------------------------------------

Dieses Kapitel erläutert die Begriffe und technischen Prinzipien, auf denen die Analyse und Migration aufbauen.
Es verbindet Softwarequalität und Schichtentrennung mit vertragsbasierten Schnittstellen, dem Electron-Prozessmodell sowie lokaler Datenhaltung und Synchronisierung.
Die konkrete Ausgangsarchitektur, Werkzeugwahl und Umsetzung werden in den nachfolgenden Kapiteln untersucht.

== KI-gestützte Anwendungsentwicklung und Softwarequalität <sec:theory-ai-quality>

Unter KI-gestützter Anwendungsentwicklung wird hier die Erzeugung und Überarbeitung von Anwendungscode anhand sprachlicher Anforderungen verstanden.
Das resultierende Ausgangsartefakt umfasst ausführbaren Code, Konfigurationen und Abhängigkeiten.
Seine sichtbare Funktionalität und seine technischen Eigenschaften sind getrennt zu betrachten: Ein erfolgreicher Oberflächenablauf zeigt zunächst, dass eine bestimmte Interaktion funktioniert.
Ob Datenzugriffe angemessen begrenzt sind, Fehler behandelt werden und die Struktur spätere Änderungen ermöglicht, erfordert weitere Prüfungen.

Perry et al. untersuchten in einer Studie mit 47 Teilnehmenden fünf sicherheitsbezogene Programmieraufgaben.
Teilnehmende mit Zugang zu einem auf `codex-davinci-002` basierenden KI-Assistenten erstellten in vier der fünf Aufgaben häufiger unsichere Lösungen als die Vergleichsgruppe.
Zugleich schätzten sie ihre Lösungen häufiger als sicher ein @Perry2023.
Die Ergebnisse betreffen das untersuchte Modell, die Aufgaben und die damaligen Versuchsbedingungen.
Sie begründen die Relevanz einer eigenständigen Sicherheitsprüfung, erlauben aber keine unmittelbare Qualitätsbewertung heutiger Replit- oder Lovable-Anwendungen.

Zur Beschreibung der benötigten Eigenschaften unterscheidet Requirements Engineering funktionale Anforderungen, Qualitätsanforderungen und Randbedingungen.
Funktionale Anforderungen betreffen das verlangte Verhalten, etwa das Speichern eines Termins.
Qualitätsanforderungen beziehen sich auf Eigenschaften wie Zuverlässigkeit oder Änderbarkeit.
Randbedingungen begrenzen den Lösungsraum, beispielsweise durch eine vorgegebene Zieltechnologie @IREBGlossary2026.
Diese Unterscheidung hilft, gewünschte Funktionen von den Bedingungen ihrer Umsetzung und Nutzung zu trennen.

ISO/IEC 25010:2023 stellt ein Produktqualitätsmodell bereit, dessen Merkmale und Untermerkmale zur Spezifikation, Messung und Bewertung von Qualität verwendet werden können @ISOIEC250102023.
Für die vorliegende Arbeit stehen insbesondere Wartbarkeit, Testbarkeit und Sicherheit im Mittelpunkt.
Die Trennung von Verantwortlichkeiten ist ein Entwurfsprinzip, das solche Qualitätsziele unterstützen soll.
Die Wahl einer Schichtenarchitektur ersetzt deshalb nicht die Bewertung der tatsächlich entstandenen Anwendung.

== Webarchitekturen und Trennung der Verantwortlichkeiten <sec:theory-layers>

In einer Client-Server-Webarchitektur fordert der Browser Ressourcen und Anwendungsdaten über HTTP an.
Der Server verarbeitet die Anfrage und liefert eine Antwort zurück; bei dynamischen Anwendungen können dabei Fachlogik und Datenbankzugriffe ausgeführt werden @MDNClientServer2026.
Bei einer getrennten Weboberfläche übernimmt das Frontend insbesondere Darstellung und Benutzerinteraktion, während ein Backend fachliche Operationen und Datenzugriffe bereitstellt.
Entscheidend für die Migration ist, welche Aufgaben tatsächlich an diese entfernte Laufzeit gebunden sind.

Eine Schichtenarchitektur ordnet Verantwortlichkeiten und Abhängigkeiten innerhalb der Anwendung.
Eine verbreitete Aufteilung unterscheidet Darstellung, fachliche Verarbeitung und Datenzugriff.
Logische Schichten sind dabei von physisch getrennten Ausführungseinheiten zu unterscheiden: Mehrere Schichten können innerhalb derselben Laufzeit liegen @MicrosoftLayers2026.
Ebenso belegt die Ablage in unterschiedlichen Projektordnern für sich genommen keine fachliche Schichtentrennung.
Maßgeblich ist, welche Aufgaben die Module ausführen und welche anderen Module sie dafür aufrufen.

Für die Verarbeitung fachlicher Aufrufe werden in dieser Arbeit die Rollen Controller, Service und Repository verwendet.
Ein Controller beziehungsweise Handler nimmt den Aufruf entgegen, ordnet Eingaben zu und übersetzt Ergebnis oder Fehler in die jeweilige Schnittstellenform.
Ein Service stellt fachliche Operationen bereit und koordiniert ihre Verarbeitung.
Das Service-Layer-Muster beschreibt hierfür eine Anwendungsgrenze, hinter der Geschäftslogik und zusammengehörige Aktionen organisiert werden @StaffordServiceLayer2003.
Ein Repository kapselt den Zugriff auf gespeicherte Daten gegenüber der Fachlogik.
Das Repository-Muster vermittelt zwischen fachlichen Objekten und ihrer Speicherung und konzentriert die zugehörigen Zugriffsoperationen @HieattMeeRepository2003.

Diese Rollen bilden keine zusätzliche Aufteilung in drei Betriebssystemprozesse.
Der Controller gehört zur Verarbeitung einer Schnittstelle; Services und Repositories können gemeinsam in einer privilegierten Laufzeit ausgeführt werden.
Ihre Trennung soll ermöglichen, den Transport oder die konkrete Datenbankanbindung gezielt anzupassen, ohne sämtliche fachlichen Regeln an diesen Stellen erneut zu implementieren.
Werden Datenzugriffe und externe Dienste über austauschbare Abhängigkeiten eingebunden, lässt sich die Fachlogik mit Testimplementierungen prüfen.
Ob diese Austauschbarkeit im konkreten Projekt erreicht wird, ist an seinen Modulen und Aufrufwegen zu untersuchen.

== API-Verträge, Typisierung und Codegenerierung <sec:theory-contracts>

Ein API-Vertrag beschreibt die angebotenen Operationen und die erwarteten Strukturen ihrer Eingaben und Ergebnisse.
OpenAPI definiert hierfür eine programmiersprachenunabhängige Beschreibung von HTTP-APIs.
Ein OpenAPI-Dokument kann unter anderem Pfade, Operationen, Parameter, Antwortformen und wiederverwendbare Schemata festlegen.
Es kann als Grundlage für Dokumentation und die Erzeugung abhängiger Programmteile dienen @OpenApi310.
Die Definition schafft eine gemeinsame Schnittstellengrundlage für die beteiligten Komponenten.

Codegenerierung leitet aus dieser Grundlage beispielsweise Typdefinitionen, Aufrufhilfen oder Validierungsschemata ab.
Die Übersetzung besitzt dabei eigene Regeln: Der Generator muss bestimmen, wie Operationen benannt, Eingaben zugeordnet und Datentypen in der Zielsprache dargestellt werden.
Änderungen am Vertrag können dadurch abgestimmt in mehreren abhängigen Dateien erscheinen.
Fachliche Verarbeitung und Zugriffskontrollen bleiben weiterhin zu implementieren; der Generator erzeugt zunächst die durch seine Übersetzungsregeln festgelegten Bestandteile.

Statische Typisierung und Laufzeitvalidierung erfüllen unterschiedliche Aufgaben.
TypeScript prüft Typbeziehungen während der Entwicklung und Übersetzung; seine Typannotationen werden bei der Erzeugung von JavaScript entfernt und verändern das Laufzeitverhalten nicht @TypeScriptBasics2026.
Eine Typdefinition gewährleistet daher nicht, dass eine tatsächlich empfangene Eingabe ihr entspricht.
Bibliotheken wie Zod prüfen Werte anhand ausführbarer Schemata und liefern bei ungültigen Eingaben strukturierte Validierungsfehler @ZodBasics2026.
Auch eine strukturell gültige Eingabe muss anschließend fachlich zulässig sein, etwa hinsichtlich Wertebereich, Benutzerzuordnung und Berechtigung.

Für einen Transportwechsel ist deshalb zwischen der Bedeutung einer Operation und ihrer bisherigen HTTP-Abbildung zu unterscheiden.
Ein vorhandener OpenAPI-Vertrag kann als Ausgangspunkt einer angepassten Generierung dienen.
Seine Übertragung auf IPC ist jedoch eine projektspezifische Interpretation und keine von OpenAPI standardisierte IPC-Schnittstelle.
Zu klären sind dabei insbesondere Datendarstellung, Fehlerformen und die Zuordnung der Operationen zum neuen Aufrufweg.

== Electron als Desktop-Laufzeit <sec:theory-electron>

Electron übernimmt ein Mehrprozessmodell aus Chromium und verbindet die Darstellung von Webinhalten mit einer Node.js-Laufzeit.
Der Main-Prozess bildet den Einstiegspunkt der Anwendung, verwaltet ihren Lebenszyklus und erzeugt Fenster.
Er kann Node.js- sowie native Electron-APIs verwenden.
Renderer-Prozesse stellen die Webinhalte der Fenster dar und verarbeiten die zugehörige Oberfläche @ElectronProcessModel2026.
Dadurch kann eine vorhandene Weboberfläche die Grundlage einer Desktop-Anwendung bilden, während privilegierte Aufgaben gesondert zugeordnet werden.

Ein Preload-Skript wird im Renderer-Prozess vor den eigentlichen Webinhalten ausgeführt.
Es ist kein eigenständiger dritter Prozess.
Bei aktivierter Context Isolation besitzen Preload und geladene Oberfläche getrennte JavaScript-Kontexte.
Über `contextBridge` können ausgewählte Funktionen für die Oberfläche bereitgestellt werden.
Die Electron-Dokumentation empfiehlt begrenzte Methoden statt einer ungefilterten Weitergabe mächtiger Schnittstellen wie `ipcRenderer.send` @ElectronContextIsolation2026.
Die Bridge bestimmt damit, welche Fähigkeiten die Oberfläche aufrufen kann.

Interprozesskommunikation (IPC) vermittelt Nachrichten zwischen den beteiligten Prozessen.
Electron unterstützt unter anderem einen Anfrage-Antwort-Aufruf, bei dem der Renderer eine Operation anstößt und ein Ergebnis aus dem Main-Prozess erhält @ElectronIpc2026.
Für fachliche Schnittstellen können solche Aufrufe mit Operationskennungen, Eingaben und definierten Ergebnissen versehen werden.
Der Main-Prozess muss die erlaubten Absender, Operationen und Daten prüfen, bevor privilegierte Verarbeitung erfolgt.

Die technische Prozessstruktur und die fachlichen Schichten sind somit unabhängig voneinander zu beschreiben.
Der Renderer kann die Darstellung übernehmen, während Controller, Services und Repositories im Main-Prozess liegen.
Preload und IPC bilden den Kommunikationsweg zwischen diesen Zuständigkeiten.
Eine solche Zuordnung macht die privilegierten Eingangsstellen sichtbar; ihre Begrenzung und Absicherung sind eigene Entwurfs- und Prüfaufgaben.

=== Navigation über Hashrouting <sec:hash-routing>

Bei einer Single-Page-Anwendung bestimmt ein clientseitiger Router, welche Ansicht innerhalb des geladenen Dokuments dargestellt wird.
Hashrouting legt die Anwendungsroute im Fragment der Adresse hinter `#` ab, beispielsweise als `#/kalender`.
Das Fragment wird clientseitig verarbeitet und bei einer HTTP-Anfrage nicht an den Server übermittelt @MDNFragment2026.
Der Ressourcenpfad des Dokuments bleibt dadurch unverändert, während sich die ausgewählte Ansicht ändern kann.

Dies ist für eine lokal geladene Electron-Oberfläche eine mögliche Navigationsstrategie: Eine fachliche Route muss nicht als eigener Dateipfad aufgelöst werden.
Wouter stellt dafür den Hook `useHashLocation` bereit @WouterHashRouting2026.
Hashrouting ist keine zwingende Vorgabe von Electron; seine Eignung hängt vom Laden der Renderer-Ressourcen und der gewählten Navigation ab.

== Lokale Persistenz, Schema und Identität <sec:theory-persistence>

Persistenz bezeichnet den Erhalt von Daten über die aktuelle Programmausführung hinaus.
Eine lokal ausgeführte Funktion ist daher erst dann dauerhaft nutzbar, wenn ihre Ergebnisse gespeichert und nach einem Neustart wieder gelesen werden können.
SQLite stellt hierfür eine eingebettete SQL-Datenbank bereit.
Die Bibliothek benötigt keinen eigenen Datenbankserver und liest beziehungsweise schreibt Datenbankdateien direkt @SQLiteAbout2026.
Das Öffnen, Initialisieren und Aktualisieren dieses Datenbestands wird damit Teil der Anwendungszuständigkeit.

Eine Datenzugriffsbibliothek beziehungsweise ein Object-Relational Mapper (ORM) vermittelt zwischen Programmstrukturen und Datenbankoperationen.
Seine Beibehaltung kann die Weiterverwendung von Abfragen und Schemadefinitionen unterstützen.
Ein Wechsel des Datenbanksystems erfordert trotzdem einen Abgleich von Datentypen, Schlüsseln, Beziehungen und Prüfbedingungen.
Gleiche Tabellen- oder Typnamen gewährleisten keine unveränderte Bedeutung ihrer Speicherung.

Versionierte Schemamigrationen beschreiben die aufeinanderfolgenden Änderungen am Datenbankschema.
Drizzle Kit kann dazu aus Schemadefinitionen SQL-Migrationsdateien erzeugen @DrizzleGenerate2026.
Die Aktualisierung einer Anwendung muss unterscheiden, ob ein neuer Datenbestand eingerichtet oder ein bereits vorhandener Bestand weiterentwickelt wird.
Programmdateien und veränderliche Benutzerdaten besitzen entsprechend unterschiedliche Lebenszyklen.

Mit lokaler Datenhaltung muss außerdem die Zuordnung der Datensätze zu einer Identität festgelegt werden.
Eine lokale Benutzerkennung, eine aktive Sitzung und ein entferntes Konto erfüllen unterschiedliche Aufgaben.
Die lokale Zuordnung hält persönliche Datensätze konsistent; eine entfernte Authentifizierung ermöglicht den Zugriff auf einen gemeinsamen Dienst.
Für synchronisierte Daten müssen Kennungen auch bei zunächst getrennten lokalen Änderungen eindeutig erzeugt und erhalten werden können.
Diese Identitätsentscheidungen betreffen Beziehungen und Zugriffskontrollen und sind deshalb Bestandteil der Architektur.

== Offline-Nutzung und Local-First-Synchronisierung <sec:theory-local-first>

Offline-Fähigkeit beschreibt hier die Ausführbarkeit der ausgewählten Funktionen ohne aktuelle Netzwerkverbindung.
Dafür müssen benötigter Anwendungscode und Daten lokal verfügbar sein.
Ein System kann solche Funktionen anbieten und zugleich andere Operationen besitzen, die unmittelbar eine Verbindung benötigen.
Der Begriff legt für sich genommen noch keine Strategie für gemeinsame Daten oder konkurrierende Änderungen fest.

Kleppmann et al. beschreiben Local-First als Zielbild, das Zusammenarbeit mit lokaler Nutzbarkeit und Kontrolle über die eigenen Daten verbindet.
Zu seinen Idealen gehören unter anderem Offline-Nutzung, geräteübergreifender Zugriff, langfristige Verfügbarkeit und Sicherheit beziehungsweise Privatheit.
Die lokale Kopie nimmt dabei eine zentrale Rolle ein; Server können die Verteilung unterstützen @Kleppmann2019.
Local-First umfasst damit weitergehende Ziele als die Verwendung einer lokalen Datenbank.
Welche Eigenschaften eine konkrete Anwendung umsetzt, ist jeweils auszuweisen.

Für externe Datenflüsse ist zwischen Übernahme und Synchronisierung zu unterscheiden.
Bei einer Übernahme in einer Richtung werden Referenzdaten heruntergeladen, geprüft und lokal gespeichert.
Eine Zusammenarbeit mit gemeinsamen Daten benötigt zusätzlich die Übermittlung lokaler Änderungen und die Verarbeitung entfernter Ergebnisse.
Lokaler Schreibabschluss und entfernter Abgleich finden dabei zu unterschiedlichen Zeitpunkten statt.

PowerSync stellt für eine solche Anbindung einen lokalen Datenbestand und eine Upload-Warteschlange bereit.
Die Anwendung übermittelt aufgezeichnete Änderungen über einen Connector an ihr Backend.
PowerSync verwendet ein serverautoritäres Modell: Die entfernte Verarbeitung bestimmt den anschließend bestätigten Datenbestand @PowerSyncWritingChanges2026.
Eine lokal abgeschlossene Änderung ist deshalb von ihrer Annahme durch das Backend zu unterscheiden.
Der Einsatz dieser Lösung kann lokale Verarbeitung mit ergänzendem Abgleich verbinden, ohne automatisch sämtliche Ideale des weitergehenden Local-First-Zielbilds zu erfüllen.

Die zeitliche Trennung erfordert ein geregeltes Fehlerverhalten.
Vorübergehende Verbindungsprobleme, endgültige Ablehnungen und unklare Ergebnisse nach einer verlorenen Antwort benötigen unterschiedliche Behandlung.
Für wiederholbare Aufrufe ist Idempotenz relevant: RFC 9110 beschreibt sie für HTTP-Methoden als gleiche beabsichtigte Wirkung mehrerer identischer Anfragen und einer einzelnen Anfrage @RFC9110.
Dieses Prinzip ist bei der Gestaltung wiederholbarer Upload-Operationen zu berücksichtigen.
Davon zu unterscheiden sind fachliche Konflikte zwischen neuen konkurrierenden Bearbeitungen, für die die Anwendung eigene Regeln benötigt.
Die Wahl einer Synchronisierungslösung beantwortet diese Fragen nur im Umfang ihres jeweiligen Verarbeitungsmodells.

== Sicherheitsgrenzen, Härtung und Nachweise <sec:theory-security>

Ein Sicherheitsentwurf muss festlegen, welche Komponenten welchen Eingaben vertrauen dürfen und welche Fähigkeiten ihnen zur Verfügung stehen.
Saltzer und Schroeder formulieren dafür unter anderem das Prinzip geringster Privilegien: Programme und Benutzer sollen nur die für ihre Aufgaben benötigten Rechte besitzen.
Hinzu kommen sichere Vorgaben und die vollständige Prüfung von Zugriffen @SaltzerSchroeder1975.
Für eine Desktop-Anwendung betrifft dies insbesondere die Stellen, an denen Oberflächenaktionen privilegierte Datei-, Datenbank- oder Dienstoperationen auslösen.

Die Electron Security Guidelines konkretisieren solche Schutzaufgaben für die Laufzeit.
Sie behandeln unter anderem die Begrenzung von Node.js-Zugriffen im Renderer, Context Isolation, Sandboxing, Berechtigungen, Inhalts- und Navigationsbeschränkungen sowie die Validierung von IPC-Absendern.
Die Dokumentation weist ausdrücklich auf die erhöhten Folgen hin, wenn fremder JavaScript-Code Zugriff auf lokale Systemfähigkeiten erhält @ElectronSecurity2026.
Die Übernahme einer Weboberfläche erfordert daher eine Prüfung der verfügbaren Fähigkeiten und ihrer Schnittstellen.

Härtung bezeichnet in dieser Arbeit die gezielte Begrenzung dieser Zugriffsmöglichkeiten und die Umsetzung der anwendbaren Schutzmaßnahmen.
Eingaben sind an den jeweiligen Grenzen zu prüfen: Eine IPC-Nachricht, eine importierte Datei und eine Netzwerkantwort besitzen unterschiedliche Herkunft und Verarbeitungspfade.
Formatprüfung, fachliche Validierung und Berechtigungsentscheidung ergänzen sich.
Die zu prüfenden Eigenschaften müssen auf die tatsächliche Anwendung und ihren festgelegten Sicherheitsumfang bezogen werden.

Auch die Art des Nachweises ist zu unterscheiden.
Codeinspektion zeigt eine vorhandene Implementierung oder Konfiguration.
Ein Unit-Test prüft ausgewählte Entscheidungen unter festgelegten Bedingungen.
Ein Laufzeitversuch beobachtet einen konkreten Ablauf; ein Paketnachweis bezieht zusätzlich die ausgelieferten Ressourcen und Abhängigkeiten ein.
Für eine nachvollziehbare Bewertung müssen Gegenstand, Prüfstand und Reichweite dieser Belege angegeben werden.
Aus einem erfolgreichen Einzeltest folgt keine allgemeine Aussage über die Abwesenheit von Schwachstellen.

== Bestehende Ansätze und Einordnung der Arbeit <sec:theory-positioning>

Die beschriebenen Ansätze liefern unterschiedliche Grundlagen für die Migration.
Schichtenarchitekturen und die Muster Service Layer und Repository ordnen fachliche Verantwortlichkeiten.
OpenAPI unterstützt die Beschreibung und abgestimmte Ableitung von Schnittstellenbestandteilen.
Die Electron-Dokumentation behandelt Prozesskommunikation und laufzeitspezifische Schutzmaßnahmen; die Local-First-Literatur beschreibt Ziele für lokale Nutzung und Zusammenarbeit.

Für die Veränderung bestehender Systeme beschreibt Fowler mit Strangler Fig eine schrittweise Modernisierung, bei der abgegrenzte Funktionen nach und nach in eine neue Struktur überführt werden.
Übergangsarchitekturen können die parallele Nutzung alter und neuer Komponenten ermöglichen @FowlerStranglerFig2024.
Refactoring ist davon begrifflich zu unterscheiden: Es verbessert die interne Struktur von Code bei unverändertem beobachtbarem Verhalten @IREBGlossary2026.
Eine Migration kann solche Strukturänderungen mit Portierungen, Datenüberführungen und zusätzlichen Funktionsanpassungen verbinden.

Für die vorliegende Fragestellung werden diese Grundlagen zu einem fallbezogenen Vorgehen zusammengeführt.
Zu untersuchen ist, welche Bestandteile eines KI-generierten Webartefakts erhalten bleiben können, welche Zuständigkeiten die lokale Anwendung übernimmt und wie zusätzliche Netzwerkanbindungen begrenzt integriert werden.
Der frameworkagnostische Anspruch betrifft dabei die Einordnung der Aufgaben und ihrer Schnittstellen.
Die konkrete Umsetzung und die Grenzen ihrer Übertragbarkeit werden anhand der Fallstudie untersucht.
@ch:method erläutert das methodische Vorgehen; @ch:analysis konkretisiert Ausgangsartefakt, Ziele und Anforderungen.
