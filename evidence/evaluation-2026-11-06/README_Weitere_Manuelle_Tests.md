# Weitere manuelle Prüfungen für Kapitel 6

Diese Liste ergänzt README_Testanleitung.md. Die dort bereits eingetragenen Importversuche F1–F8 bleiben bestehen. Hier stehen die noch offenen Benutzerabläufe. Die erwarteten Ergebnisse sind Prüfkriterien; bitte daneben das tatsächlich beobachtete Verhalten festhalten, auch wenn es davon abweicht.

## Vorbereitung und Protokoll

- Dasselbe gebaute Anwendungspaket für alle Fälle verwenden. Eintragen, ob die installierte Anwendung oder die EXE aus win-unpacked verwendet wird. Nicht zwischen beiden wechseln.
- Paketzuordnung: build-info.json im übergeordneten Ordner; dort steht der am 06.11.2026 verifizierte Evaluationsstand. Tatsächliches Testdatum und Windows-Version zusätzlich notieren.
- Persönliche Testdaten mit eindeutigen Namen anlegen, zum Beispiel „L1 Offline-Note“ oder „S1 Offline-Aufgabe“. Vorhandene Daten müssen nicht gelöscht werden.
- Für Offline-Versuche WLAN ausschalten und gegebenenfalls das Netzwerkkabel trennen. Ein Wechsel in eine andere App-Ansicht ist kein Anwendungsneustart: Für Neustartversuche StudyPlan vollständig beenden und erneut starten.
- Rückmeldungen möglichst wörtlich notieren. Je ein Screenshot von wichtigen Vorher-/Nachher-Zuständen hilft. Zugangsdaten nicht protokollieren.
- Falls ein Versuch nicht durchführbar ist, „nicht durchgeführt“ mit Grund eintragen. Eine Abweichung ist ebenfalls ein verwertbares Ergebnis.

| Testdatum | Windows-Version | Paket / Startdatei | Lokales Testkonto |
| --- | --- | --- | --- |
| 6.11.26 | Windows 11 | C:\Users\Joshua\Desktop\Desktop App prototype\studyplan\dist\evaluation-2026-11-05 |test.1 |

## L1: Paketstart und lokale Anmeldung ohne Internet

1. StudyPlan beenden und die Internetverbindung trennen.
2. Das gebaute Paket starten.
3. Mit einem bereits vorhandenen lokalen StudyPlan-Testkonto anmelden.
4. Notenverwaltung, Kalender und Stundenplan öffnen.

Erwartet: Die Anwendung startet ohne Verbindung. Die lokale Anmeldung und die persönlichen Ansichten funktionieren; vorhandene lokale Daten werden angezeigt.

Festhalten: Start gelungen? Anmeldung gelungen? Welche Ansichten und Bestände waren verfügbar? Gab es Fehlermeldungen oder endloses Laden?
Start, Anmeldung gelungen, kein Laden, alle Ansichten können besucht werden
## L2: Persönliche Änderungen offline und nach Neustart

Die Internetverbindung bleibt getrennt.

1. In der Notenverwaltung eine Note „L2 Offline-Note“ mit Note 2,0 und 5 ECTS anlegen.
2. Die Note ändern, zum Beispiel auf 1,7. Eine andere Ansicht öffnen und zurückkehren; den geänderten Wert prüfen.
3. Im Kalender einen persönlichen Termin „L2 Offline-Termin“ mit eindeutigem Datum und Uhrzeit anlegen. Datum und Uhrzeit notieren.
4. Im Stundenplan einen eigenen Eintrag „L2 Offline-Stundenplan“ anlegen. Falls die Oberfläche dazu eine Kursauswahl verlangt, einen vorhandenen Kurs wählen und die Auswahl notieren.
5. StudyPlan vollständig beenden. Ohne Internet erneut starten und lokal anmelden.
6. Alle drei Einträge erneut öffnen. Werte mit den notierten Angaben vergleichen. Auch prüfen, ob die zuvor importierten Termine und Noten noch vorhanden sind.
7. Die drei neu angelegten L2-Testeinträge offline löschen. Anwendung erneut vollständig beenden und starten. Prüfen, ob sie weiterhin gelöscht sind. Die importierten F-Testdaten können bestehen bleiben.

Erwartet: Anlegen, Ändern und Lesen funktionieren offline. Nach dem Neustart bleiben die gespeicherten Werte erhalten. Gelöschte Testeinträge erscheinen nach dem zweiten Neustart nicht erneut.

Festhalten: Ergebnis getrennt für Noten, Kalender und Stundenplan; insbesondere Werte vor/nach Neustart und Löschverhalten. Falls eine genannte Bedienmöglichkeit fehlt, genau das notieren.
offline CRUD funktioniert für alle Fälle.
## L3: Trennung lokaler Konten

1. Mit dem ersten lokalen Konto prüfen, welche F6-/F7-Importnoten und persönlichen Termine vorhanden sind.
2. Lokal abmelden und mit einem zweiten lokalen Testkonto anmelden. Falls noch keines besteht, dieses vor dem Versuch anlegen.
3. Notenverwaltung und persönliche Kalenderdaten öffnen.
4. Zum ersten Konto zurückwechseln und dort den Bestand erneut prüfen.

Erwartet: Persönliche Einträge des ersten Kontos werden dem zweiten Konto nicht angezeigt. Beim Rückwechsel sind sie weiterhin vorhanden. Der gemeinsame Studiengangskatalog ist kein persönlicher Bestand und darf in beiden Konten sichtbar sein.
Erwartungen werden vollkommen erfüllt, keine Auffäligkeiten
## K1: Katalog online übernehmen und erneut abrufen

1. Internetverbindung herstellen und die Ansicht „Studie“ öffnen.
2. Den Abschluss des Katalogabrufs abwarten. Sichtbare Rückmeldung und Studiengänge notieren; bei mindestens einem Studiengang auch die Kursliste festhalten.
3. Die Ansicht verlassen und erneut öffnen, damit ein weiterer Abruf erfolgt. Falls die Oberfläche eine Aktualisierungsaktion anbietet, kann diese verwendet werden; die verwendete Aktion notieren.
4. Die zuvor festgehaltenen Studiengänge und Kurse vergleichen.

Erwartet: Der Online-Abruf gelingt und die übernommenen Inhalte sind sichtbar. Der wiederholte Abruf erzeugt keine zusätzlichen identischen Einträge. Falls beim Öffnen keine Rückmeldung zum Abruf erscheint, „keine sichtbare Abrufbestätigung“ notieren; vorhandene Einträge allein zeigen noch nicht, wann sie übernommen wurden.
Erwartungen werden vollkommen erfüllt, keine Auffäligkeiten

## K2: Katalog bei Verbindungsfehler und nach Offline-Neustart

Direkt nach K1 durchführen.

1. Einen in K1 festgehaltenen Studiengang samt Kursen notieren oder fotografieren.
2. Internetverbindung trennen. „Studie“ verlassen und erneut öffnen, um einen Abruf ohne Verbindung auszulösen.
3. Fehlermeldung und gegebenenfalls angebotene Wiederholung notieren. Prüfen, ob die zuvor sichtbaren Daten weiterhin verwendbar sind.
4. Anwendung vollständig beenden und ohne Internet neu starten. Lokal anmelden und denselben Studiengang samt Kursen erneut öffnen.
5. Internet wiederherstellen und den Abruf erneut versuchen. Rückmeldung festhalten.

Erwartet: Der fehlgeschlagene Abruf entfernt den vorhandenen Katalog nicht. Die festgehaltenen Daten sind auch nach dem Offline-Neustart verfügbar. Nach Wiederherstellung der Verbindung ist ein erneuter Abruf möglich.

Ungültige Serverantworten müssen hierfür nicht künstlich erzeugt werden; dafür liegen bereits automatisierte Prüfungen vor.
Erwartungen werden vollkommen erfüllt, keine Auffäligkeiten

## Vorbereitung für G1–G3 und S1–S3: Zwei Kollaborationskonten

- Den synchronisierten Gruppenbereich verwenden, nicht die ursprüngliche lokale Gruppenfunktion.
- Zwei bereits eingerichtete entfernte Testkonten A und B verwenden. Die entfernte Anmeldung erfolgt zusätzlich zur lokalen StudyPlan-Anmeldung.
- Für den Abgleich zwei unabhängig laufende Clients benutzen, möglichst auf zwei Rechnern mit demselben Paket. A und B dürfen nicht dieselbe lokale Datenablage teilen. Falls nur ein Client verfügbar ist, G-Fälle nacheinander mit Kontowechsel durchführen und diese Einschränkung notieren; den Zwei-Client-Nachweis S1–S3 offenlassen.
- Für die folgenden Versuche nur eine eigens angelegte Testgruppe verwenden. Konten mit Alias A/B dokumentieren; keine Passwörter eintragen.

| Client | Rechner / Paket | Lokales Konto | Entferntes Konto (Alias) |
| --- | --- | --- | --- |
| A | | | A |
| B | | | B |

Zwei Clients sind nicht verfügbar. Beide Clients werden auf dem selbem System ausgeführt. Begründung : aus dem Code wird das verhalten notwenig. Es besteht keine Forderung das das System auf zwei Systemen getestet werden muss. 
## G1: Gruppe erstellen, Person suchen und einladen

Beide Clients sind online.

1. A im synchronisierten Gruppenbereich anmelden und eine Gruppe „G1 Evaluation“ erstellen.
2. Prüfen, ob die Gruppe erscheint und A als Mitglied beziehungsweise Eigentümer angezeigt wird. Eventuelle Wartezeit bis zur Anzeige notieren.
3. Als A das entfernte Testkonto B über die Profilsuche suchen und einladen.
4. Als B prüfen, ob die Einladung erscheint. Noch nicht annehmen; sie wird für G2 benötigt.

Erwartet: Gruppe, Suchergebnis und Einladung werden sichtbar. Die Einladung erreicht das richtige Konto.
Erwartungen werden vollkommen erfüllt, keine Auffäligkeiten. 

## G2: Online-Aktionen ohne Verbindung

Für jeden Teilversuch zuerst online anmelden und die erforderliche Ansicht öffnen; danach am betreffenden Client die Verbindung trennen. Währenddessen die Anwendung nicht neu starten.

1. **Gruppenerstellung:** Als A offline eine weitere Testgruppe „G2 Offline-Gruppe“ anzulegen versuchen. Rückmeldung notieren.
2. **Profilsuche / Einladung:** Als A offline eine Profilsuche versuchen. Falls ein bereits angezeigtes Suchergebnis verfügbar ist, auch den Einladungsversand versuchen. Ist der Versand wegen fehlender Suchergebnisse nicht erreichbar, „nicht durchführbar“ notieren; nicht als geprüften Fehlerfall werten.
3. **Annahme:** Als B die bereits angezeigte Einladung aus G1 offline anzunehmen versuchen. Rückmeldung und Einladungszustand notieren.
4. Verbindungen wiederherstellen. Prüfen, ob dennoch eine Gruppe, Einladung oder Mitgliedschaft entstanden ist. Den tatsächlichen Zustand notieren, bevor eine Aktion wiederholt wird.

Erwartet: Die Online-Aktionen melden den Verbindungsfehler verständlich und zeigen keinen unbelegten Erfolg. Die Anwendung bleibt bedienbar. Falls eine Aktion später doch ausgeführt wurde oder ihr Ausgang unklar ist, das ausdrücklich festhalten.
Erwartungen werden vollkommen erfüllt, keine Auffäligkeiten. 

## G3: Einladung online annehmen und Mitgliedschaft anzeigen

1. Beide Clients wieder online verwenden.
2. Als B die Einladung aus G1 annehmen, sofern G2 sie nicht bereits angenommen hat. Falls doch, den bereits vorhandenen Zustand notieren.
3. Prüfen, ob B die Gruppe und ihre Mitglieder sieht.
4. Als A prüfen, ob B in der Mitgliederliste erscheint.

Erwartet: B wird Mitglied der richtigen Gruppe. Beide Clients zeigen die Mitgliedschaft nach dem Abgleich an.
Erwartungen werden vollkommen erfüllt, keine Auffäligkeiten. 

## S1: Aufgabe offline speichern und später am zweiten Client sehen

Voraussetzung: Beide Clients sind Mitglieder der Testgruppe. Zunächst beide online anmelden und den Gruppenbestand laden.

1. Nur Client A vom Internet trennen. Anwendung und Kollaborationssitzung geöffnet lassen; B bleibt online.
2. Als A eine Aufgabe „S1 Offline-Aufgabe“ anlegen. Rückmeldung und lokale Anzeige festhalten.
3. Eine andere Ansicht öffnen und zur Aufgabe zurückkehren. Prüfen, ob sie lokal weiterhin sichtbar ist.
4. Als B prüfen, ob die Aufgabe vor der Wiederverbindung von A bereits erscheint. Beobachtungsdauer notieren.
5. A wieder verbinden. Auf beiden Clients die Aufgabe prüfen. Ungefähre Zeit bis zur Anzeige bei B notieren; falls nach etwa einer Minute keine Übernahme sichtbar ist, diesen Zustand festhalten.

Erwartet: Die Aufgabe ist bei A sofort lokal verfügbar. B erhält sie nach Wiederherstellung der Verbindung. Bei B Titel und Gruppe vergleichen; eine Verbindungsanzeige bei A allein genügt nicht als Nachweis der Übernahme.
Erwartungen werden vollkommen erfüllt, keine Auffäligkeiten. 

## S2: Ausstehende Offline-Aufgabe über Anwendungsneustart erhalten

1. A zunächst online anmelden und die Testgruppe laden. B bleibt online.
2. A vom Internet trennen und eine neue Aufgabe „S2 Neustart-Aufgabe“ anlegen.
3. A weiterhin offline vollständig beenden und erneut starten. Lokal anmelden und den synchronisierten Gruppenbereich öffnen. Festhalten, ob eine erneute entfernte Anmeldung verlangt wird und ob diese ohne Verbindung möglich ist.
4. A wieder verbinden und mit demselben entfernten Konto anmelden. Die Aufgabe nicht erneut anlegen.
5. Prüfen, ob die Aufgabe bei A wieder erscheint und anschließend bei B ankommt. 

Erwartet: Nach einem Neustart ist die erneute entfernte Anmeldung erforderlich. Nach Wiederverbindung und Anmeldung bleibt die zuvor offline gespeicherte Aufgabe erhalten und wird an B übertragen. Die fehlende Offline-Anmeldung am entfernten Konto ist eine zu dokumentierende Nutzungsvoraussetzung. Ob die Aufgabe unmittelbar vor oder nach der Anmeldung übertragen wird, lässt sich aus der Oberfläche allein möglicherweise nicht unterscheiden.
Erwartungen werden vollkommen erfüllt, keine Auffäligkeiten. 

## S3: Aufgabenänderung und Löschung zwischen zwei Clients

Beide Clients sind online; eine der neu angelegten S-Testaufgaben verwenden.

1. Als B die Aufgabe als erledigt markieren. Als A prüfen, ob derselbe Status erscheint.
2. Als A die Aufgabe wieder öffnen, sofern die Oberfläche dies anbietet. Als B den Status prüfen.
3. Als A diese Testaufgabe löschen. Als B prüfen, ob sie verschwindet.
4. Bei B die Ansicht wechseln und zurückkehren; prüfen, ob der letzte Zustand bestehen bleibt.

Erwartet: Statusänderungen und Löschung werden auf den anderen Client übernommen. Nur die eigenen Testaufgaben löschen.
Erwartungen werden vollkommen erfüllt, keine Auffäligkeiten. 

## Beobachtungen

Bei mehrteiligen Fällen gern mehrere Zeilen ergänzen. „Erwartetes Verhalten“ bitte durch die konkrete Anzeige ergänzen, insbesondere bei Verbindungsfehlern. Screenshots können neben dieser Anleitung gespeichert und hier mit Dateinamen genannt werden.

| Fall / Teilschritt | Datum / Konto / Client | Tatsächliche Rückmeldung und Anzeige | Bestand / Werte vorher → nachher | Neustart / Verbindung / Wartezeit | Ergebnis / Screenshot |
| --- | --- | --- | --- | --- | --- |
| L1 | | | | | |
| L2 Noten | | | | | |
| L2 Kalender | | | | | |
| L2 Stundenplan | | | | | |
| L2 Löschen / zweiter Neustart | | | | | |
| L3 | | | | | |
| K1 | | | | | |
| K2 | | | | | |
| G1 | | | | | |
| G2 Gruppenerstellung | | | | | |
| G2 Profilsuche / Einladung | | | | | |
| G2 Annahme | | | | | |
| G3 | | | | | |
| S1 | | | | | |
| S2 | | | | | |
| S3 | | | | | |

## Reihenfolge und Umfang

Zuerst L1–L3, danach K1–K2. Für G1–G3 und S1–S3 die beiden entfernten Konten und möglichst zwei Rechner bereithalten. Innerhalb dieser Fälle die Reihenfolge beibehalten, weil Einladung, Mitgliedschaft und Aufgaben aufeinander aufbauen.

Architekturprüfung, automatisierte Fehlerantworten, Fuse-Werte und ASAR-Integrität müssen für diese Liste nicht manuell nachgeprüft werden. Dafür gibt es bereits technische Belege. Die neuen Beobachtungen ergänzen gezielt die bisher fehlenden Benutzerabläufe für Kapitel 6. Kapitel 6 selbst wird erst anhand der eingetragenen Ergebnisse ergänzt.
