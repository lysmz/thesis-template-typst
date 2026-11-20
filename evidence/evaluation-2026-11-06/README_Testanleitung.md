# Importtestdateien für Kapitel 6

Alle Inhalte sind synthetische Testdaten. Die erwarteten Ergebnisse sind Prüfkriterien, keine bereits beobachteten GUI-Ergebnisse.

## Vorbereitung

Mit einem lokalen Testkonto anmelden. Vor jedem Versuch Termin-/Notenbestand festhalten und die Rückmeldung fotografieren oder abschreiben. Jede gültige Datei zunächst nur einmal importieren: Ein erneuter Import kann zusätzliche Einträge erzeugen.

## F1 und F5: Abbrechen

Hierfür ist keine Datei nötig. Import öffnen und im Dateidialog auf Abbrechen klicken. Erwartet: unveränderter Bestand. Vorher-/Nachher-Bestand vergleichen.

## F2 und F3: Gültiger Kalender

Datei: F2-F3_termine_gueltig.ics

Erwartet: 3 importierte Termine, 0 übersprungene Einträge. Im Kalender zum November 2026 navigieren.

| Titel | Datum | Beginn Europe/Berlin | Ende Europe/Berlin | Ort |
| --- | --- | --- | --- | --- |
| F2 Vorlesung Datenbanken | 09.11.2026 | 10:00 | 11:30 | Raum A101 |
| F2 Klausur Softwaretechnik | 10.11.2026 | 14:30 | 16:00 | Raum B202 |
| F2 Abgabe Projektbericht | 11.11.2026 | 17:00 | 17:30 | Online |

Die Datei speichert UTC-Zeitpunkte mit Z am Ende. Beispiel für F3: DTSTART:20261109T090000Z entspricht am 09.11.2026 um 10:00 Uhr in Europe/Berlin. Bei anderer Systemzeitzone kann die lokale Anzeige abweichen.

## F4: Ungeeigneter Kalender

Datei: F4_termine_ungeeignet.ics

Die Endung erlaubt die Auswahl im ICS-Dialog; der Inhalt ist absichtlich ungültig. Erwartet: verständliche Fehlermeldung, keine neuen Termine, App weiterhin bedienbar. Anschließend beispielsweise eine andere Ansicht öffnen.

## F6: Gültige Noten

Datei: F6_noten_gueltig.csv

Erwartet: 3 importierte Noten, 0 übersprungene Zeilen.

| Kursname | Note | ECTS | Semester |
| --- | --- | --- | --- |
| F6 Datenbanken | 1,7 | 5 | WS 2026/27 |
| F6 Softwaretechnik | 2,3 | 6 | WS 2026/27 |
| F6 Mathematik, Grundlagen | 1,3 | 4 | WS 2026/27 |

Alle Einträge gehören zum aktuell angemeldeten lokalen Konto. Die CSV ordnet keine Katalog-Kurs-ID zu. Für einen Kontentrennungstest nach dem Import zu einem anderen lokalen Konto wechseln und prüfen, dass dort diese Einträge fehlen.

## F7: Gemischte Noten

Datei: F7_noten_gemischt.csv

Erwartet: 2 importierte Noten und 2 übersprungene ungültige Zeilen.

| Datenzeile ohne Kopfzeile | Inhalt | Erwartet |
| --- | --- | --- |
| 1 | F7 Rechnernetze, Note 2,0, 5 ECTS, WS 2026/27 | übernommen |
| 2 | fehlender Modulname | übersprungen |
| 3 | F7 Betriebssysteme, Note 1,7, 6 ECTS, WS 2026/27 | übernommen |
| 4 | nur eine Spalte | übersprungen |

Die Rückmeldung sollte die zwei importierten und zwei übersprungenen Einträge nennen. Die Fehler sind bewusst strukturell: Nichtnumerische Noten allein werden vom aktuellen Import als fehlende Note behandelt und eignen sich deshalb nicht als verlässlicher Überspring-Fall.

## F8: Vollständig ungeeignete Noten

Datei: F8_noten_ungeeignet.csv

Die CSV ist lesbar, enthält aber ausschließlich Datensätze ohne Modulnamen. Erwartet: Fehlermeldung, dass keine gültigen Noten enthalten sind; Bestand bleibt unverändert.

## Beobachtungen

Für jeden Fall tatsächliche Rückmeldung, Bestandsänderung und  festhalten. Die Dateien belegen allein noch nicht die erfolgreiche Bedienung des nativen Dateidialogs.

| Fall | Datum / Konto | Tatsächliche Rückmeldung | Bestand vorher / nachher | Ergebnis  |
| --- | --- | --- | --- | --- |
| F1 |test.1 | erwartetes Verhalten | datenbestand unverändert | modal schließt sich, keine side-effekts |
| F2 |test.1 | erwartetes Verhalten | datenbestand um 3 Termine erweitert | keine Termine / 3 Termine | erfolgreiche Übernahme der Daten aus Datei
| F3 |test.1 | erwartetes Verhalten | datenbestand um 3 Termine erweitert | keine Termine / 3 Termine | erfolgreiche Übernahme der Daten aus Datei
| F4 |test.1 | erwartetes Verhalten | datenbestand nicht verändert, erwartete Fehlermeldung | 3 Termine / 3 Termine | erfolgreiches Error-Management
| F5 |test.1 | erwartetes Verhalten | datenbestand unverändert | modal schließt sich, keine side-effekts |
| F6 |test.1 | erwartetes Verhalten | datenbestand um 3 Termine erweitert | keine Termine / 3 Termine | erfolgreiche Übernahme der Daten aus Datei
| F7 |test.1 | erwartetes Verhalten | datenbestand um 2 Einträge erweitert 2 Ungültige wurden Übersprungen | 0 Einträge / +2 Einträge | test erfolgreich
| F8 |test.1 | erwartetes Verhalten | Die CSV enthält keine gültigen Noten | 2 Einträge / 2 Einträge | kein Eintrag wurde übernommen
