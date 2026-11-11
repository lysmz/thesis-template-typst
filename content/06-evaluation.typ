//---------------------------------------------------------------------
= Evaluation des Demonstrators und des Migrationsleitfadens <ch:experiments>
//---------------------------------------------------------------------

Die Evaluation prüft die in @sec:requirements festgelegten Kriterien anhand der entstandenen Anwendung.
Im Mittelpunkt stehen die lokale Nutzbarkeit, die Architektur, die Weiterverwendung des Ausgangsartefakts, die Online-Anbindungen und die Sicherheitsmaßnahmen.
Die Ergebnisse bilden zugleich die Grundlage für die Bewertung des in @sec:migration-recommendations beschriebenen Leitfadens.

== Vorgehen der Prüfung <sec:evaluation-evidence>

Die Funktionsprüfung folgt typischen Benutzerabläufen: Anwendung starten, Daten bearbeiten, die Verbindung unterbrechen und gespeicherte Änderungen nach einem Neustart erneut öffnen.
Für die Kollaboration werden Aufgaben zwischen zwei Konten ausgetauscht sowie Gruppen und Einladungen geprüft.
Ergänzend werden die Aufteilung der Anwendung und die Wirkung ausgewählter Sicherheitsmaßnahmen betrachtet.

Manuelle Versuche prüfen die Bedienung der gebauten Anwendung.
Automatisierte Tests ergänzen sie um fachliche Regeln und gezielt erzeugte Fehlerfälle.
Die folgenden Übersichten zeigen jeweils die durchgeführte Prüfung und das beobachtete Ergebnis.
Für jeden Prüffall wird das zuletzt vorliegende Ergebnis verwendet.

== Nutzbarkeit der lokalen Desktop-Anwendung <sec:local-feature-evaluation>

Die lokale Kernanwendung soll ohne Internetverbindung starten und persönliche Daten dauerhaft speichern.
Geprüft wurden die lokale Anmeldung, Notenverwaltung, Kalender und Stundenplan.
Die Abläufe verbinden die Bearbeitung mit einem vollständigen Anwendungsneustart, damit auch der Erhalt der Änderungen geprüft wird.

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
        [Verbindung trennen, Anwendung starten und mit einem vorhandenen lokalen Konto anmelden.],
        [Start und Anmeldung gelangen. Die persönlichen Ansichten waren ohne anhaltende Ladezustände erreichbar.],
        [Persönliche Daten bearbeiten],
        [Noten, Kalendereinträge und Stundenplaneinträge ohne Verbindung anlegen beziehungsweise bearbeiten und erneut öffnen.],
        [Die vorgesehenen Bearbeitungen funktionierten; die Änderungen wurden angezeigt.],
        [Daten nach Neustart lesen],
        [Anwendung vollständig beenden und weiterhin ohne Verbindung neu starten.],
        [Die gespeicherten Einträge und Änderungen waren weiterhin vorhanden.],
        [Löschungen erhalten],
        [Testeinträge offline löschen und die Anwendung erneut starten.],
        [Die gelöschten Einträge erschienen nicht erneut.],
        [Lokale Konten wechseln],
        [Zu einem anderen lokalen Konto und anschließend zum ursprünglichen Konto wechseln.],
        [Persönliche Einträge waren nur dem zugehörigen Konto zugeordnet und nach dem Rückwechsel wieder verfügbar.],
      )
    },
    caption: [Prüfung der lokalen Nutzung und der Speicherung über einen Anwendungsneustart hinaus.],
  )
]

Damit sind die lokale Anmeldung und die untersuchten persönlichen Funktionen auch ohne Verbindung nutzbar.
Ihre Nutzung setzt keine Anmeldung am entfernten Kollaborationsdienst voraus.

Kalender- und Notenimport wurden gemeinsam als Dateiimport geprüft.
Die fachliche Funktion der Web-Anwendung blieb dabei erhalten: Ausgewählte Dateien werden geprüft und geeignete Einträge in den jeweiligen Bestand übernommen.
Die Desktop-Anpassung betrifft insbesondere die lokale Dateiauswahl.

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
        table.header([*Prüffall*], [*Ergebnis bei Kalender- und Notenimport*]),
        [Gültige Daten],
        [Die Einträge wurden übernommen und in der jeweiligen Ansicht korrekt angezeigt.],
        [Ungeeignete Inhalte],
        [Ungeeignete Dateien wurden mit einer Fehlermeldung zurückgewiesen; der Bestand blieb unverändert. Bei der gemischten Notendatei wurden gültige Einträge übernommen und ungültige mit entsprechender Rückmeldung übersprungen.],
        [Dateiauswahl abbrechen],
        [Der Dialog schloss sich ohne Änderung des Datenbestands.],
      )
    },
    caption: [Ergebnisse der Kalender- und Notenimporte.],
  )
]

== Architektur und Weiterverwendung des Ausgangsartefakts <sec:architecture-evaluation>

Für die Architekturprüfung wurde die Zuordnung der vorhandenen Module mit der Zielarchitektur verglichen.
Als durchgehendes Beispiel dient die Notenverwaltung.
Hier lässt sich der Aufruf von der Oberfläche über die Schnittstelle und die fachliche Verarbeitung bis zum Datenzugriff verfolgen.

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
        [Darstellung, fachliche Verarbeitung und Datenzugriff am Notenpfad zuordnen.],
        [Die Aufgaben sind auf Oberflächenkomponenten, Services und Repositories verteilt.],
        [Unabhängig prüfbare Fachlogik],
        [Notenverarbeitung ohne Bedienung der Oberfläche testen.],
        [Alle acht Tests bestanden, unter anderem zu Notenwerten, gewichteter Statistik, Benutzerzuordnung und Import.],
        [Lokaler Aufrufweg],
        [Kommunikation zwischen Oberfläche und lokaler Verarbeitung nachvollziehen.],
        [Die Aufrufe erfolgen über begrenzte Preload-Schnittstellen und IPC. Ein lokaler HTTP-Server ist dafür nicht erforderlich.],
        [Weiterverwendung],
        [Erhaltene Bestandteile und notwendige Änderungen mit dem Ausgangsartefakt vergleichen.],
        [Oberflächenkomponenten, fachliche Berechnungen und der API-Vertrag blieben als Grundlage erhalten. Laufzeit, Routing, Aufruftransport und Datenbankanbindung wurden angepasst.],
      )
    },
    caption: [Abgleich der Architektur und der Weiterverwendung am Beispiel der Notenverwaltung.],
  )
]

Die Ergebnisse bestätigen die geforderte Trennung der Verantwortlichkeiten und die Prüfbarkeit der fachlichen Verarbeitung.
Die in Kapitel 5 beschriebenen Eingriffe machen außerdem nachvollziehbar, welche Bestandteile weiterverwendet wurden und weshalb andere angepasst werden mussten.
Die Bewertung der Weiterverwendung bezieht sich auf diese begründete Zuordnung.

== Online-Anbindungen und Fehlerverhalten <sec:collaboration-evaluation>

=== Einseitige Übernahme von Studiengangsdaten

Beim Studiengangskatalog wurde geprüft, ob externe Daten übernommen werden und anschließend lokal verfügbar bleiben.
Neben dem erfolgreichen Abruf wurden wiederholte Aktualisierungen, Verbindungsfehler und ungeeignete Antworten betrachtet.

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
        [Der Abruffehler wurde gemeldet; vorhandene Studiengänge und Kurse blieben verfügbar.],
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
  )
]

Der externe Dienst wird damit für die Aktualisierung benötigt.
Ein bereits vorhandener Katalogbestand kann unabhängig von seiner Erreichbarkeit verwendet werden.

=== Kollaborative Aufgabenänderungen

Die Aufgabenprüfung unterscheidet lokale Speicherung, spätere Übermittlung und die Anzeige der Änderung beim anderen beteiligten Konto.
Ergänzend wurden die Online-Abläufe für Gruppen und Einladungen durchgespielt.

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
        [Während einer bestehenden Sitzung die Verbindung trennen, eine Aufgabe anlegen und die Ansicht erneut öffnen.],
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
  )
]

Aufgaben können während einer bestehenden Kollaborationssitzung ohne Verbindung bearbeitet werden.
Nach einem Anwendungsneustart ist eine erneute entfernte Anmeldung erforderlich; anschließend stehen die gespeicherten Änderungen wieder zur Verfügung und werden übertragen.

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
  )
]

Die geprüften Verwaltungsaktionen benötigen eine Verbindung, während Aufgabenänderungen zunächst lokal verarbeitet werden.
Diese Unterscheidung wird durch die beobachteten Abläufe und Rückmeldungen nachvollziehbar.

== Wirkung der Sicherheitsmaßnahmen <sec:security-evaluation>

Die Sicherheitsprüfung folgt der in Kapitel 4 festgelegten Anforderung und der in @sec:app-hardening beschriebenen Checkliste.
Alle 20 Empfehlungen wurden auf ihre Anwendbarkeit geprüft.
Die Betrachtung der Einstellungen und Schnittstellen wurde durch automatisierte Tests, Kontrollen der gebauten Anwendung und ausgewählte Laufzeitversuche ergänzt.

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
        [Inhaltsrichtlinie],
        [Das Laden eines Skripts aus einer unerlaubten Quelle versuchen.],
        [Die Inhaltsrichtlinie blockierte das Skript; es wurde nicht ausgeführt.],
        [Navigation und Fenster],
        [Ein fremdes Navigationsziel und ein zusätzliches Fenster öffnen lassen.],
        [Die Anwendung blieb im vorgesehenen Dokument. Es öffnete sich weder ein zusätzliches App-Fenster noch der Systembrowser.],
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

== Abdeckung der Verarbeitungsmuster und Bewertung des Leitfadens <sec:guide-evaluation>

Die geprüften Funktionen decken die in Kapitel 4 ausgewählten Verarbeitungsmuster ab.
Aus ihrer Umsetzung lassen sich zugleich die Ansatzpunkte für weitere Funktionen ableiten.

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
        [Lokale Datenbearbeitung], [Noten, Kalender und Stundenplan],
        [Oberfläche, fachliche Verarbeitung und Datenzugriff übernehmen getrennte Aufgaben.],
        [Dateiimport], [Kalender- und Notenimport],
        [Dateiauswahl, Prüfung und Übernahme können auf weitere Eingabeformate übertragen werden.],
        [Einseitige Datenübernahme], [Studiengangskatalog],
        [Externe Aktualisierung und lokale Verwendung werden getrennt; Fehler erhalten den bisherigen Bestand.],
        [Kollaborative Synchronisierung], [Gemeinsame Aufgaben],
        [Lokale Änderungen werden gespeichert und anschließend übertragen; Speicherung und Abgleich werden getrennt geprüft.],
        [Unmittelbare Online-Aktion], [Gruppen und Einladungen],
        [Netzwerkabhängige Aktionen werden ausdrücklich ausgewiesen und geben Verbindungsfehler zurück.],
      )
    },
    caption: [Abdeckung der Verarbeitungsmuster und Ansatzpunkte für Erweiterungen.],
  ) <tab:functional-evaluation>
]

Die Empfehlungen des Leitfadens lassen sich diesen Umsetzungsschritten zuordnen.
Die Auswahl der Zielumgebung und die lokale Datenhaltung schaffen die Grundlage; begrenzte Schnittstellen und vollständige Bearbeitungsabläufe strukturieren die Migration einzelner Funktionen.
Dateiimporte, externe Datenübernahme und Kollaboration ergänzen die jeweiligen Verarbeitungsmuster.
Die Härtung führt die Sicherheitsmaßnahmen und ihre Kontrolle zusammen.

Voraussetzungen, Entscheidungen und Kontrollpunkte sind damit am Demonstrator nachvollziehbar.
Der Leitfaden beschreibt ein aus dieser Fallstudie abgeleitetes Vorgehen für vergleichbare Ausgangsartefakte.

== Gesamtbewertung <sec:requirements-evaluation>

Die folgende Übersicht führt die Ergebnisse auf die Kriterien aus Kapitel 4 zurück.

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
        [Lauffähige Desktop-Anwendung],
        [Die gebaute Anwendung startet; die ausgewählten Benutzerabläufe funktionieren.],
        [Dreischichtenarchitektur],
        [Darstellung, Fachlogik und Datenzugriff sind getrennt. Die Notenverarbeitung ist ohne Oberfläche prüfbar.],
        [Weiterverwendung des Ausgangsartefakts],
        [Erhaltene Bestandteile und notwendige Anpassungen sind zugeordnet und begründet.],
        [Lokale Kommunikation],
        [Lokale Aufrufe verwenden begrenzte Preload-Schnittstellen und IPC. Ein lokaler HTTP-Server wird nicht benötigt.],
        [Offline-Verfügbarkeit],
        [Lokale Anmeldung und persönliche Datenbearbeitung funktionieren ohne Verbindung. Gespeicherte Daten bleiben nach einem Neustart erhalten; ein vorhandener Katalog ist offline nutzbar.],
        [Kollaborative Synchronisierung],
        [Lokale Aufgabenänderungen bleiben erhalten und werden nach Wiederverbindung für das andere Konto verfügbar. Gruppen und Einladungen setzen eine Verbindung voraus.],
        [Härtung der Anwendung],
        [Alle Empfehlungen sind auf Anwendbarkeit, Umsetzung und Prüfung eingeordnet. Die ausgewählten Sicherheitsversuche verliefen erfolgreich; die genannte Prüfgrenze bleibt bestehen.],
        [Verarbeitungsmuster und Erweiterbarkeit],
        [Die ausgewählten Muster sind durch geprüfte Funktionen abgedeckt und bieten Ansatzpunkte für vergleichbare Erweiterungen.],
        [Nachvollziehbarer Migrationsleitfaden],
        [Voraussetzungen, Reihenfolge, Änderungen und Kontrollpunkte sind der Umsetzung im Demonstrator zugeordnet.],
      )
    },
    caption: [Zusammenfassende Bewertung anhand des Anforderungskatalogs.],
  ) <tab:requirements-evaluation>
]
