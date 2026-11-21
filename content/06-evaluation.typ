//---------------------------------------------------------------------
= Evaluation des Demonstrators und des Migrationspfads <ch:experiments>
//---------------------------------------------------------------------

Die Evaluation prüft die in @sec:requirements festgelegten Kriterien anhand der entstandenen Anwendung.
Im Mittelpunkt stehen die lokale Nutzbarkeit, die Architektur, die Weiterverwendung des Webprototyps, die Online-Anbindungen und die Sicherheitsmaßnahmen.
Die Ergebnisse bilden zugleich die Grundlage für die Bewertung des in @sec:migration-recommendations beschriebenen Migrationspfads.

== Vorgehen der Prüfung <sec:evaluation-evidence>

Die Funktionsprüfung folgt typischen Benutzerabläufen: installierte Electron-Anwendung starten, Daten bearbeiten, die Verbindung unterbrechen und gespeicherte Änderungen nach einem Neustart erneut öffnen.
Für die synchronisierten Studiengruppen werden gemeinsame Gruppenaufgaben zwischen zwei Supabase-Benutzerkonten ausgetauscht sowie Gruppen und direkte Kontoeinladungen geprüft.
Ergänzend werden die Aufteilung der Anwendung und die Wirkung ausgewählter Sicherheitsmaßnahmen betrachtet.

Manuelle Funktionsprüfungen untersuchen die Bedienung der installierten Electron-Anwendung.
Automatisierte Tests ergänzen sie um fachliche Regeln und gezielt erzeugte Fehlerfälle.
Für jeden Prüffall wird das zuletzt vorliegende Ergebnis verwendet.
Die lokale Nutzbarkeit und die Architektur werden in @sec:local-feature-evaluation und @sec:architecture-evaluation geprüft. @sec:collaboration-evaluation und @sec:security-evaluation untersuchen die Online-Anbindungen und die Härtung. @sec:guide-evaluation ordnet die Ergebnisse dem Migrationspfad zu. @sec:requirements-evaluation fasst die Bewertung anhand des Anforderungskatalogs zusammen.

== Nutzbarkeit der Electron-Anwendung <sec:local-feature-evaluation>

Die Offline-Kernanwendung soll ohne Internetverbindung starten und persönliche Daten dauerhaft speichern.
Geprüft wurden die lokale Anmeldung, Notenverwaltung, Kalender und Stundenplan.
Die Abläufe verbinden die Bearbeitung mit einem vollständigen Anwendungsneustart, damit auch der Erhalt der Änderungen geprüft wird.
@tab:local-usage-results fasst die Prüfschritte zur lokalen Nutzung und die beobachteten Ergebnisse zusammen.

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (1fr, 1.6fr, 1.8fr),
        inset: 5pt,
        align: left,
        table.header([*Prüfschritt*], [*Durchführung*], [*Ergebnis*]),
        [Start und Anmeldung],
        [Verbindung trennen, installierte Electron-Anwendung starten und mit einem vorhandenen lokalen Benutzerkonto anmelden.],
        [Start und Anmeldung gelangen. Die persönlichen Ansichten waren ohne anhaltende Ladezustände erreichbar.],
        [Persönliche Daten bearbeiten],
        [Noten, Termine und Stundenplaneinträge ohne Verbindung anlegen beziehungsweise bearbeiten und erneut öffnen.],
        [Die vorgesehenen Bearbeitungen funktionierten; die Änderungen wurden angezeigt.],
        [Daten nach Neustart lesen],
        [Anwendung vollständig beenden und weiterhin ohne Verbindung neu starten.],
        [Die gespeicherten Einträge und Änderungen waren weiterhin vorhanden.],
        [Löschungen erhalten],
        [Testeinträge offline löschen und die Anwendung erneut starten.],
        [Die gelöschten Einträge erschienen nicht erneut.],
        [Lokale Konten wechseln],
        [Zu einem anderen lokalen Benutzerkonto und anschließend zum ursprünglichen Konto wechseln.],
        [Persönliche Einträge waren nur dem zugehörigen Konto zugeordnet und nach dem Rückwechsel wieder verfügbar.],
      )
    },
    caption: [Prüfung der lokalen Nutzung und der Speicherung über einen Anwendungsneustart hinaus.],
  ) <tab:local-usage-results>
]

Damit sind die lokale Anmeldung und die untersuchten persönlichen Funktionen auch ohne Verbindung nutzbar.
Ihre Nutzung setzt keine Anmeldung mit einem Supabase-Benutzerkonto voraus.

Der iCal-Import und der CSV-Notenimport wurden gemeinsam als Dateiimporte geprüft.
Die fachliche Funktion der Web-Anwendung blieb dabei erhalten: Ausgewählte Dateien werden geprüft und geeignete Einträge in den jeweiligen Bestand übernommen.
Die Desktop-Anpassung betrifft insbesondere die native Dateiauswahl.
@tab:file-import-results zeigt, wie beide Importe mit gültigen und ungeeigneten Dateien sowie beim Abbruch der Dateiauswahl umgehen.

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (1.1fr, 3.3fr),
        inset: 5pt,
        align: left,
        table.header([*Prüffall*], [*Ergebnis beim iCal-Import und CSV-Notenimport*]),
        [Gültige Daten],
        [Die Einträge wurden übernommen und in der jeweiligen Ansicht korrekt angezeigt.],
        [Ungeeignete Inhalte],
        [Ungeeignete Dateien wurden mit einer Fehlermeldung zurückgewiesen; der Bestand blieb unverändert. Bei der gemischten Notendatei wurden gültige Einträge übernommen und ungültige mit entsprechender Rückmeldung übersprungen.],
        [Dateiauswahl abbrechen],
        [Der Dialog schloss sich ohne Änderung des Datenbestands.],
      )
    },
    caption: [Ergebnisse des iCal-Imports und des CSV-Notenimports.],
  ) <tab:file-import-results>
]

== Architektur und Weiterverwendung des Webprototyps <sec:architecture-evaluation>

Für die Architekturprüfung wurde die Zuordnung der vorhandenen Module mit der Zielarchitektur verglichen.
Als durchgehendes Beispiel dient die Notenverwaltung.
Hier lässt sich der Aufruf von der Benutzeroberfläche über die Schnittstelle und die fachliche Verarbeitung bis zum Datenzugriff verfolgen.
@tab:architecture-results stellt die Ergebnisse zur Aufteilung der Verantwortlichkeiten, zum lokalen Aufrufweg und zur Weiterverwendung dar.

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (1.2fr, 1.6fr, 1.8fr),
        inset: 5pt,
        align: left,
        table.header([*Kriterium*], [*Prüfung*], [*Ergebnis*]),
        [Getrennte Verantwortlichkeiten],
        [Benutzeroberfläche, Geschäftslogik und Datenzugriff am Verarbeitungspfad der Notenverwaltung zuordnen.],
        [Die Aufgaben sind auf Oberflächenkomponenten, Services und Repositories verteilt.],
        [Unabhängig prüfbare Geschäftslogik],
        [Geschäftslogik der Notenverwaltung ohne Bedienung der Benutzeroberfläche testen.],
        [Alle acht Tests bestanden, unter anderem zu Notenwerten, gewichteter Statistik, Benutzerzuordnung und Import.],
        [Lokaler Aufrufweg],
        [Kommunikation zwischen Benutzeroberfläche und lokaler Verarbeitung nachvollziehen.],
        [Die Aufrufe erfolgen über begrenzte Preload-Schnittstellen und IPC. Ein lokaler HTTP-Server ist dafür nicht erforderlich.],
        [Weiterverwendung],
        [Erhaltene Bestandteile und notwendige Änderungen mit dem Webprototyp vergleichen.],
        [Oberflächenkomponenten, fachliche Berechnungen und der OpenAPI-Vertrag blieben als Grundlage erhalten. Laufzeit, Routing, Aufruftransport und Datenbankanbindung wurden angepasst.],
      )
    },
    caption: [Abgleich der Architektur und der Weiterverwendung am Beispiel der Notenverwaltung.],
  ) <tab:architecture-results>
]

Die Ergebnisse bestätigen die geforderte Trennung der Verantwortlichkeiten und die Prüfbarkeit der Geschäftslogik.
Die in @ch:migration beschriebenen Eingriffe machen außerdem nachvollziehbar, welche Bestandteile weiterverwendet wurden und weshalb andere angepasst werden mussten.
Die Bewertung der Weiterverwendung bezieht sich auf diese begründete Zuordnung.

== Online-Anbindungen und Fehlerverhalten <sec:collaboration-evaluation>

Zunächst wird die einseitige Übernahme externer Katalogdaten in @sec:catalog-evaluation untersucht. @sec:collaborative-task-evaluation behandelt anschließend den Abgleich zwischen zwei Konten und die netzwerkabhängigen Gruppenfunktionen.

=== Einseitige Datenübernahme aus dem Studiengangskatalog <sec:catalog-evaluation>

Beim Studiengangskatalog wurde geprüft, ob externe Daten übernommen werden und anschließend lokal verfügbar bleiben.
Neben dem erfolgreichen Abruf wurden wiederholte Aktualisierungen, Verbindungsfehler und ungeeignete Antworten betrachtet.
@tab:catalog-results zeigt die Ergebnisse des Abrufs, der Fehlerbehandlung und der anschließenden Offline-Nutzung.

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (1fr, 1.6fr, 1.8fr),
        inset: 5pt,
        align: left,
        table.header([*Prüfschritt*], [*Durchführung*], [*Ergebnis*]),
        [Katalog abrufen],
        [Studiengangsansicht mit bestehender Verbindung öffnen.],
        [Die Katalogdaten wurden übernommen und angezeigt.],
        [Abruf wiederholen],
        [Die Aktualisierung erneut auslösen und den Bestand vergleichen.],
        [Es entstanden keine zusätzlichen identischen Einträge.],
        [Verbindung unterbrechen],
        [Ohne Verbindung einen Abruf versuchen.],
        [Der Abruffehler wurde gemeldet; vorhandene Studiengänge und Module blieben verfügbar.],
        [Offline neu starten],
        [Anwendung ohne Verbindung neu starten und zuvor übernommene Daten öffnen.],
        [Die Daten waren weiterhin nutzbar.],
        [Abruf erneut versuchen],
        [Verbindung wiederherstellen und erneut aktualisieren.],
        [Der Abruf war wieder möglich.],
        [Fehlerhafte Antworten verarbeiten],
        [Ungeeignete Antworten und einen fehlschlagenden Import automatisiert prüfen.],
        [Die Fehler wurden erkannt. Der bisherige Bestand blieb erhalten; ein fehlgeschlagener Import wurde vollständig zurückgenommen.],
      )
    },
    caption: [Prüfung des Katalogabrufs und der anschließenden lokalen Nutzung.],
  ) <tab:catalog-results>
]

Der externe Dienst wird damit für die Aktualisierung benötigt.
Ein bereits vorhandener Katalogbestand kann unabhängig von seiner Erreichbarkeit verwendet werden.

=== Kollaborative Aufgabenänderungen <sec:collaborative-task-evaluation>

Die Aufgabenprüfung unterscheidet lokale Speicherung, spätere Übermittlung und die Anzeige der Änderung beim anderen beteiligten Konto.
@tab:collaborative-task-results zeigt, welche Aufgabenänderungen lokal erhalten blieben und nach Wiederverbindung beim anderen Konto ankamen.

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (1fr, 1.6fr, 1.8fr),
        inset: 5pt,
        align: left,
        table.header([*Prüfschritt*], [*Durchführung*], [*Ergebnis*]),
        [Aufgabe offline speichern],
        [Während einer bestehenden Supabase-Kollaborationssitzung die Verbindung trennen, eine gemeinsame Gruppenaufgabe anlegen und die Ansicht erneut öffnen.],
        [Die Aufgabe wurde lokal gespeichert und erneut angezeigt.],
        [Änderung übertragen],
        [Verbindung wiederherstellen und die Aufgaben beim anderen Konto prüfen.],
        [Die zuvor offline angelegte Aufgabe wurde dort übernommen und angezeigt.],
        [Ausstehende Änderung erhalten],
        [Eine weitere Aufgabe offline anlegen, Anwendung beenden und nach Wiederverbindung erneut anmelden.],
        [Die Aufgabe blieb erhalten und wurde anschließend auch für das andere Konto verfügbar.],
        [Status ändern und löschen],
        [Aufgabe erledigen, wieder öffnen und löschen; den jeweiligen Zustand beim anderen Konto prüfen.],
        [Die Statusänderungen und die Löschung wurden übernommen.],
      )
    },
    caption: [Ablauf der lokalen Aufgabenbearbeitung und des anschließenden Abgleichs.],
  ) <tab:collaborative-task-results>
]

Aufgaben können während einer bestehenden Supabase-Kollaborationssitzung ohne Verbindung bearbeitet werden.
Nach einem Anwendungsneustart ist eine erneute Anmeldung mit dem Supabase-Benutzerkonto erforderlich; anschließend stehen die gespeicherten Änderungen wieder zur Verfügung und werden übertragen.

Ergänzend wurden die Online-Abläufe für Gruppen und Einladungen geprüft.
@tab:group-invitation-results zeigt die Ergebnisse der Gruppenerstellung und der Kontoeinladungen sowie das Verhalten bei unterbrochener Verbindung.

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (1.1fr, 1.5fr, 1.8fr),
        inset: 5pt,
        align: left,
        table.header([*Prüffall*], [*Durchführung*], [*Ergebnis*]),
        [Gruppe erstellen],
        [Mit bestehender Verbindung eine Testgruppe anlegen.],
        [Die Gruppe und die zugehörige Mitgliedschaft wurden angezeigt.],
        [Person suchen und einladen],
        [Ein vorhandenes Konto suchen und eine Einladung versenden.],
        [Das vorgesehene Konto erhielt die Einladung.],
        [Einladung annehmen],
        [Einladung mit dem eingeladenen Konto annehmen und die Mitgliedschaft prüfen.],
        [Gruppe und Mitgliedschaft waren anschließend für beide Konten sichtbar.],
        [Online-Aktionen ohne Verbindung],
        [Gruppenerstellung, Suche beziehungsweise Einladung und Einladungsannahme ohne Verbindung versuchen.],
        [Die Verbindungsfehler wurden verständlich gemeldet. Die Anwendung blieb bedienbar und zeigte keinen erfolgreichen Abschluss an.],
      )
    },
    caption: [Ergebnisse der Gruppen- und Einladungsabläufe.],
  ) <tab:group-invitation-results>
]

Die geprüften Operationen der netzwerkabhängigen Gruppenverwaltung benötigen eine Verbindung, während Aufgabenänderungen zunächst lokal verarbeitet werden.
Diese Unterscheidung wird durch die beobachteten Abläufe und Rückmeldungen nachvollziehbar.

== Wirkung der Sicherheitsmaßnahmen <sec:security-evaluation>

Die Sicherheitsprüfung folgt der im @sec:requirements festgelegten Anforderung A7 und der in @sec:app-hardening beschriebenen Checkliste.
Alle 20 Empfehlungen wurden auf ihre Anwendbarkeit geprüft.
Die Betrachtung der Einstellungen und Schnittstellen wurde durch automatisierte Tests, Kontrollen der gebauten Anwendung und ausgewählte manuelle Laufzeitversuche ergänzt.
@tab:security-runtime-results fasst ausgewählte Prüfungen vom Umgang mit Eingaben bis zur Kontrolle des installierten Anwendungspakets zusammen.

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (1fr, 1.6fr, 1.8fr),
        inset: 5pt,
        align: left,
        table.header([*Prüfbereich*], [*Durchführung*], [*Ergebnis*]),
        [Eingabevalidierung],
        [Ungültige Eingaben über beide Anwendungsschnittstellen übergeben.],
        [Die Eingaben wurden mit den vorgesehenen Validierungsfehlern zurückgewiesen.],
        [Textdarstellung],
        [Einen Aufgabentitel mit HTML-artigem Inhalt speichern und erneut öffnen.],
        [Der Inhalt wurde weiterhin als Text dargestellt; der enthaltene Code wurde nicht ausgeführt.],
        [CSP],
        [Das Laden eines Skripts aus einer unerlaubten Quelle versuchen.],
        [Die CSP blockierte das Skript; es wurde nicht ausgeführt.],
        [Navigation und Fenster],
        [Ein fremdes Navigationsziel und ein zusätzliches Fenster öffnen lassen.],
        [Die Anwendung blieb im vorgesehenen Dokument. Es öffnete sich weder ein zusätzliches Anwendungsfenster noch der Systembrowser.],
        [Gebautes Anwendungspaket],
        [Ausgewählte Startoptionen und den Integritätsschutz des Anwendungspakets kontrollieren.],
        [Die vorgesehenen Optionen waren gesetzt; die Integritätsprüfung war erfolgreich.],
      )
    },
    caption: [Ausgewählte Prüfungen zur Wirkung der Sicherheitsmaßnahmen.],
  ) <tab:security-runtime-results>
]

17 Empfehlungen sind mit den jeweils vorgesehenen Prüfungen erfüllt.
Zwei Empfehlungen zu Webviews sind wegen deren fehlender Nutzung nicht anwendbar.
Die Empfehlung zu sicheren externen Verbindungen ist im festgelegten Umfang erfüllt; die interne Redirectbehandlung des PowerSync-SDK wurde nicht praktisch geprüft.
Damit sind Umsetzung und Prüfgrenze für alle Empfehlungen eingeordnet.

== Abdeckung der Verarbeitungsmuster und Bewertung des Migrationspfads <sec:guide-evaluation>

Die geprüften Funktionen decken die in @ch:analysis ausgewählten Verarbeitungsmuster ab.
@tab:functional-evaluation ordnet jedem Muster ein geprüftes Beispiel zu und zeigt, welche Teile der Umsetzung sich für weitere Funktionen verwenden lassen.

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (1fr, 1.2fr, 2fr),
        inset: 5pt,
        align: left,
        table.header([*Verarbeitungsmuster*], [*Geprüftes Beispiel*], [*Ansatz für weitere Funktionen*]),
        [Lokale CRUD-Verarbeitung], [Noten, Kalender und Stundenplan],
        [Benutzeroberfläche, Geschäftslogik und Datenzugriff übernehmen getrennte Aufgaben.],
        [Dateiimport], [iCal-Import und CSV-Notenimport],
        [Dateiauswahl, Prüfung und Übernahme können auf weitere Eingabeformate übertragen werden.],
        [Einseitige Datenübernahme], [Studiengangskatalog],
        [Externe Aktualisierung und lokale Verwendung werden getrennt; Fehler erhalten den bisherigen Bestand.],
        [Kollaborative Synchronisation], [Gemeinsame Gruppenaufgaben],
        [Lokale Änderungen werden gespeichert und anschließend übertragen; Speicherung und Abgleich werden getrennt geprüft.],
        [Netzwerkabhängige Gruppenverwaltung], [Studiengruppen und direkte Kontoeinladungen],
        [Netzwerkabhängige Aktionen werden ausdrücklich ausgewiesen und geben Verbindungsfehler zurück.],
      )
    },
    caption: [Abdeckung der Verarbeitungsmuster und Ansatzpunkte für Erweiterungen.],
  ) <tab:functional-evaluation>
]

Die Empfehlungen des Migrationspfads lassen sich diesen Umsetzungsschritten zuordnen.
Die Auswahl der Desktop-Zielumgebung und die lokale Datenhaltung schaffen die Grundlage; begrenzte Schnittstellen und vollständige Bearbeitungsabläufe strukturieren die Migration einzelner Funktionen.
Dateiimporte, externe Datenübernahme und Kollaboration ergänzen die jeweiligen Verarbeitungsmuster.
Die Härtung führt die Sicherheitsmaßnahmen und ihre Kontrolle zusammen.

Voraussetzungen, Entscheidungen und Kontrollpunkte sind damit am Demonstrator nachvollziehbar.
Der Migrationspfad beschreibt ein aus dieser Fallstudie abgeleitetes Vorgehen für vergleichbare Ausgangsartefakte.

== Gesamtbewertung <sec:requirements-evaluation>

@tab:requirements-evaluation ordnet die Ergebnisse den in @sec:requirements definierten Anforderungen A1 bis A9 zu.

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (1.2fr, 2.3fr),
        inset: 5pt,
        align: left,
        table.header([*Kriterium*], [*Ergebnis der Bewertung*]),
        [Lauffähige Electron-Anwendung],
        [Die installierte Electron-Anwendung startet; die ausgewählten Benutzerabläufe funktionieren.],
        [Dreischichtenarchitektur],
        [Benutzeroberfläche, Geschäftslogik und Datenzugriff sind getrennt. Die Geschäftslogik der Notenverwaltung ist ohne Benutzeroberfläche prüfbar.],
        [Weiterverwendung des Webprototyps],
        [Erhaltene Bestandteile und notwendige Anpassungen sind zugeordnet und begründet.],
        [Lokale Kommunikation],
        [Lokale Aufrufe verwenden begrenzte Preload-Schnittstellen und IPC. Ein lokaler HTTP-Server wird nicht benötigt.],
        [Offline-Verfügbarkeit],
        [Lokale Anmeldung und persönliche Datenbearbeitung funktionieren ohne Verbindung. Gespeicherte Daten bleiben nach einem Neustart erhalten; ein vorhandener Katalog ist offline nutzbar.],
        [Kollaborative Synchronisation],
        [Lokale Aufgabenänderungen bleiben erhalten und werden nach Wiederverbindung für das andere Konto verfügbar. Gruppen und Einladungen setzen eine Verbindung voraus.],
        [Härtung der Anwendung],
        [Alle Empfehlungen sind auf Anwendbarkeit, Umsetzung und Prüfung eingeordnet. Die ausgewählten manuellen Laufzeitversuche verliefen erfolgreich; die genannte Prüfgrenze bleibt bestehen.],
        [Verarbeitungsmuster und Erweiterbarkeit],
        [Die ausgewählten Muster sind durch geprüfte Funktionen abgedeckt und bieten Ansatzpunkte für vergleichbare Erweiterungen.],
        [Nachvollziehbarer Migrationspfad],
        [Voraussetzungen, Reihenfolge, Änderungen und Kontrollpunkte sind der Umsetzung im Demonstrator zugeordnet.],
      )
    },
    caption: [Zusammenfassende Bewertung anhand des Anforderungskatalogs.],
  ) <tab:requirements-evaluation>
]
