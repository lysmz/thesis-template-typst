//---------------------------------------------------------------------
= Evaluation und Demonstration <ch:experiments>
//---------------------------------------------------------------------

Dieses Kapitel bewertet den Demonstrator und den daraus abgeleiteten Leitfaden anhand von A1–A9 aus @sec:requirements. Im Mittelpunkt steht, welche Veränderungen und Zielzustände durch die vorliegenden Belege nachvollziehbar sind. Die Beschreibung einer Implementierung, ein erfolgreicher Test und ein beobachteter Ablauf liefern unterschiedliche Aussagen. Die Bewertung verbindet diese Nachweise mit ihrem jeweiligen Prüfstand und weist verbleibende Lücken aus.

== Prüfgegenstand und Belegbasis <sec:evaluation-evidence>

Gegenstand der Quellcodebewertung ist der StudyPlan-Stand `17434b2`, eingesehen am 10. Oktober 2026. Dieser Stand ist im öffentlichen GitHub-Repository `lysmz/studyplan` zugänglich. Für Paket- und Laufzeitaussagen werden die dokumentierten Windows-Prüfungen vom 4. Oktober herangezogen. Sie beziehen sich auf die korrigierte Anwendung nach der Härtung mit Electron 44.5.1 unter Windows x64. Der native Prüfschritt bestätigt SQLite-Schreiben und -Lesen sowie den libSQL-Zugriff in dieser Electron-Laufzeit. Die Paketidentität ist durch EXE- und ASAR-Hashes festgehalten; die betreffenden Sicherheitsquellen sind gegenüber dem zugehörigen Commit `fc25822` unverändert. @StudyPlanSecurityRemediation2026 @StudyPlanEvaluationSource2026

Die Belegbasis umfasst Code- und Architekturinspektionen, automatisierte Prüfungen sowie ausgewählte manuelle Paketabläufe. Für die Synchronisierung liegen zusätzlich Berichte der Integrationsprototypen und der Upload-Nachbesserung vom 26. September vor. Diese dokumentieren damalige lokale und entfernte Prüfszenarien; sie sind keine erneute Prüfung der heutigen Dienstkonfiguration. Ein unabhängiger Migrationsdurchlauf, Frontend-Unit-Tests und automatisierte End-to-End-Tests gehören gemäß Kapitel 3 und 4 nicht zum Evaluationsumfang. @StudyPlanSyncSpikes2026 @StudyPlanUploadChecks2026

Am 10. Oktober wurden ergänzend die fünf vorhandenen lokalen Service-Suites erneut ausgeführt. Das zugehörige Ausführungsprotokoll wird als separates lokales Artefakt außerhalb des öffentlichen Repositorys geführt. Die Suites verwenden Node.js 24.18.1 unter Windows x64 und SQLite-Datenbanken im Arbeitsspeicher. Ihre Testschemata werden innerhalb der Fixtures erzeugt. Der Aufruf des Dispatchers ersetzt native IPC; die Dateiimporte verwenden nachgebildete Dateiauswahlergebnisse. Damit prüfen diese Suites Fachlogik, Datenzuordnung und ausgewählte Schnittstellenfehler, jedoch weder die Oberfläche noch native Dateidialoge, produktive Datenbankmigrationen oder Neustartpersistenz. @tab:local-service-results zeigt die Ergebnisse. @StudyPlanEvaluationTests2026

#figure(
  {
    set par(justify: false)
    set text(size: 9pt)
    table(
      columns: (1.2fr, 0.6fr, 3fr),
      inset: 5pt,
      align: left,
      table.header([*Suite*], [*Bestanden*], [*Geprüfte Ausschnitte*]),
      [`auth:test`], [8/8], [Passwort-Hashing, Anmeldung und Abmeldung, fehlende Sitzungen, Benutzerzuordnung und strukturierte Fehler.],
      [`dashboard:test`], [4/4], [Leere Datenbestände, persönliche Statistik, Fristen und benutzerbezogene Aktivitäten.],
      [`events:test`], [9/9], [Persönliche Terminoperationen, Filter, ICS-Parsing und -Import, Abbruch sowie ungültige Inhalte.],
      [`grades:test`], [8/8], [Numerische Notenwerte, ECTS-gewichtete Statistik, Datenzuordnung, CSV-Parsing, Import und Abbruch.],
      [`timetable:test`], [6/6], [Eigene Einträge, vorbereitete Pläne, Entfernen und Leeren, ungültige Werte und fremde Datensätze.],
      [*Gesamt*], [*35/35*], [Keine fehlgeschlagenen oder übersprungenen Tests in diesen fünf Suites.],
    )
  },
  caption: [Erneute Ausführung vorhandener lokaler Service-Tests am 10. Oktober 2026; Protokoll und Prüfstand nach @StudyPlanEvaluationTests2026.],
) <tab:local-service-results>

Davon getrennt dokumentiert der Nachbesserungsbericht vom 4. Oktober 53 erfolgreiche Prüfungen: Security-Suite (13), IPC-/Generator-Suite (10), lokale Gruppenressourcen (5), Katalogsuite (8) und Kollaborations-Service-/Uploadtests (17). Im Windows-Paket bestanden außerdem drei isolierte PowerSync-Prüfungen zu Neustartpersistenz, Client-Schemaerweiterung und Repository-CRUD. Die unterschiedlichen Zahlen beschreiben jeweils ausgewählte Testmengen und keine prozentuale Abdeckung der Anwendung. @StudyPlanSecurityRemediation2026

== Architektur und Wiederverwendung <sec:architecture-evaluation>

Die Zuordnung der Module bestätigt die in A2 geforderte Trennung von Darstellung, fachlicher Verarbeitung und Datenzugriff. Die Oberfläche ruft fachliche Operationen über Preload und IPC auf. Im Main-Prozess vermitteln Handler zwischen Dispatcher und Services; Repositories führen die Datenbankabfragen aus. Das Notenbeispiel aus @sec:crud-migration lässt sich durchgehend von `useCreateGrade` bis `GradesRepository` nachvollziehen. Die erneut ausgeführten Tests verbinden Client, Dispatcher, Handler, Service und Repository mit einer Testdatenbank. Sie prüfen damit einen vollständigen fachlichen Verarbeitungspfad ohne React-Oberfläche. @StudyPlanEvaluationSource2026 @StudyPlanEvaluationTests2026

Electron-Prozesse und fachliche Schichten bleiben unterschiedliche Strukturmerkmale. Fachlogik und Datenzugriff liegen beide im Main-Prozess; ihre Verantwortlichkeiten werden durch die Module und deren Abhängigkeiten getrennt. Testimplementierungen für Dateiauswahl und externe Transporte zeigen, dass diese Abhängigkeiten an den betrachteten Stellen austauschbar sind. Daraus folgt eine strukturelle Grundlage für weitere Tests, jedoch keine bereits vollständige Testabdeckung sämtlicher Services. @StudyPlanEvaluationSource2026

Für A4 ist der lokale Aufrufweg maßgeblich: Die Kernoperationen werden über die beiden begrenzten IPC-Bridges registriert und ausgeführt. Im betrachteten Main-Startablauf wird hierfür kein Express-Server gestartet. Der Vite-Entwicklungsserver dient der Bereitstellung des Renderers im Entwicklungsmodus; er ist kein HTTP-Wrapper der lokalen Fachlogik. Im Paket werden die Renderer-Ressourcen über `app://bundle/index.html` geladen. Externe HTTPS-Anfragen bleiben auf die dafür vorgesehenen Anbindungen beschränkt. @StudyPlanEvaluationSource2026 @StudyPlanHardeningImplementation2026

Die Wiederverwendung gemäß A3 ist qualitativ nachvollziehbar. React-Seiten, Oberflächenkomponenten, Gestaltung und wesentliche fachliche Regeln bilden weiterhin die Grundlage der Anwendung. Der OpenAPI-Vertrag und Drizzle bleiben erhalten, während Transport, Laufzeitschemata, Datenbankdialekt und Treiber angepasst wurden. Die ursprünglichen HTTP-Routen wurden auf Handler, Services und Repositories verteilt. Die Synchronisierung ergänzt einen eigenen Datenhaltungsbereich und neue Dienstanbindungen. Kapitel 5 benennt diese Eingriffe und ihre Gründe. Gemessene Entwicklungszeiten, ein Codeanteil in Prozent oder ein vergleichender Nachweis minimalen Aufwands liegen nicht vor und werden für A3 auch nicht vorausgesetzt.

Im Hinblick auf den Vorversuch aus @sec:migration-preliminary sind die Konsistenz der Schnittstellenbausteine und der Erhalt des fachlichen Verhaltens getrennt zu bewerten. Die gemeinsame Vertragsableitung macht Typen, Aufrufhilfen und Laufzeitschemata auf dieselbe Definition zurückführbar. Die fachlichen Tests prüfen demgegenüber die Ergebnisse ausgewählter Verarbeitungspfade. Weder die Vertragsbindung noch ein erfolgreicher Build belegen für sich die Übereinstimmung aller Anwendungsabläufe mit dem Ausgangsartefakt. Eine geringere Häufigkeit unbeabsichtigter Verhaltensänderungen gegenüber dem Vorversuch wurde nicht vergleichend gemessen.

== Kernfunktionen und lokale Nutzbarkeit <sec:local-feature-evaluation>

Die Paketprotokolle belegen den Start der gebauten Windows-Anwendung, die Darstellung der Anmeldung und der lokalen Assets sowie die Nutzung der Gruppenroute mit Aufgaben. Nach der Aktualisierung auf Electron 44.5.1 funktionieren die geprüften nativen Datenbank- und Workerpfade. Damit ist A1 für diesen Paketstand und die dokumentierten Abläufe gestützt. Eine entsprechende Aussage über macOS, Linux oder eine signierte Installation lässt sich daraus nicht ableiten. @StudyPlanSecurityRemediation2026

Die persönlichen Funktionen wurden mit ihrem fachlichen Kontext übernommen. @tab:functional-evaluation ordnet die Ausgangsfunktionen den Veränderungen und Nachweisen zu. Die Gegenüberstellung bewertet insbesondere die in A8 geforderten Interaktionsformen. Sie behauptet keine separat geprüfte Übereinstimmung jedes visuellen Details der ursprünglichen Oberfläche.

#block[
  #show figure.where(kind: table): set block(breakable: false)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (0.9fr, 1.7fr, 2.7fr),
        inset: 3.5pt,
        align: left,
        table.header([*Bereich*], [*Ausgangsfunktion*], [*Migrationsergebnis und Beleg*]),
        [Dashboard], [Persönliche Kennzahlen, Fristen und Aktivitäten über Webrouten.], [Lokale Services und benutzerbezogene SQLite-Abfragen; vier erfolgreiche Tests für ausgewählte Kennzahlen und Auswahlbedingungen.],
        [Kalender], [Persönliche Termine, Ansichten und ICS-Webupload.], [Lokale Terminoperationen und nativer Importaufruf; neun erfolgreiche Tests für CRUD, Filter und ausgewählte ICS-Fälle. Kalenderdarstellung und Farbcodierung wurden nicht als vollständige GUI-Testmatrix geprüft.],
        [Noten], [Semesterbezogene Noten, Statistik und CSV-Webupload.], [Service-/Repository-Pfad mit numerischen Werten sowie lokaler CSV-Verarbeitung; acht erfolgreiche Tests. Die fachliche Statistik bleibt erhalten.],
        [Stundenplan], [Persönliche Einträge und vorbereitete Hochschulpläne.], [Lokale Auswahl und Verwaltung mit Sitzungszuordnung; sechs erfolgreiche Tests. Rasterdarstellung und visuelle Unterscheidungen sind übernommene Oberflächenbestandteile.],
        [Identität], [Webanmeldung mit Session-Cookies.], [Lokale Sitzung im Main und getrennte Anmeldung für bestehende entfernte Konten; acht lokale Auth-Tests und dokumentierte Paket-Anmeldung. Keine Registrierung entfernter Konten in der App.],
        [Studiengruppen], [Gruppenerstellung, Einladungslink und gemeinsame Aufgaben.], [Neue personenbezogene Einladung und lokaler Aufgabenbestand mit Synchronisierung. Gruppenverwaltung benötigt eine Verbindung; Kommentare und weitere gemeinsame Inhalte sind nicht Untersuchungsgegenstand.],
        [Katalog], [Bereitgestellter Referenzdatenbestand.], [Ergänzender Download mit Schemaprüfung und transaktionaler lokaler Übernahme. Acht Katalogtests im Nachbesserungsbericht; keine Rückübertragung lokaler Änderungen.],
      )
    },
    caption: [Funktionale Gegenüberstellung für den Kernumfang nach @StudienplanerSource2026, @StudyPlanEvaluationSource2026 und den Prüfprotokollen @StudyPlanEvaluationTests2026, @StudyPlanSecurityRemediation2026 und @StudyPlanUploadChecks2026.],
  ) <tab:functional-evaluation>
]

Für A5 ergibt sich aus der Codeinspektion ein lokaler Verarbeitungspfad der persönlichen Funktionen. Die Datenbank liegt im Benutzerdatenverzeichnis; Schema und anfängliche Referenzdaten werden vor der Nutzung eingerichtet. Die lokalen Service-Tests bestätigen die betrachteten Operationen ohne entfernten Transport. Weil sie im Arbeitsspeicher ausgeführt werden, belegen sie deren Ergebnisse jedoch nicht nach einem Anwendungsneustart. Die paketierten PowerSync-Persistenztests betreffen einen separaten Prototyp und dürfen nicht als Neustartnachweis aller persönlichen Tabellen gewertet werden. @StudyPlanEvaluationSource2026 @StudyPlanEvaluationTests2026 @StudyPlanSecurityRemediation2026

Die Offline-Kernarchitektur ist damit nachvollziehbar und ausgewählte lokale Abläufe sind geprüft. Ein vollständiger Paketdurchlauf sämtlicher persönlicher Kernfunktionen bei unterbrochener Verbindung einschließlich Neustart und erneutem Lesen liegt in der ausgewerteten Belegbasis nicht vor. A5 wird deshalb nur teilweise als belegt bewertet. Dies bezeichnet eine Nachweislücke; aus ihr folgt weder eine nachgewiesene Fehlfunktion noch die pauschale Erfüllung der Anforderung.

Auch die Dateiimporte besitzen unterschiedliche Nachweisebenen. ICS- und CSV-Parser sowie ihre fachliche Übernahme werden in den lokalen Tests ausgeführt. Die native Dialoganbindung, Dateityp- und Größenbegrenzung sind durch Codeinspektion nachvollziehbar. Die Test-Dateiauswahl ersetzt den echten Dialog. Es wird daher kein vollständig beobachteter nativer Importablauf für jede Variante behauptet. Der Katalogtest ergänzt die Datenübernahme um einen injizierten Transport mit Import-, Aktualisierungs-, Fehler- und Rollbackfällen; er ist kein neuer Live-Abruf des entfernten Dienstes. @StudyPlanEvaluationTests2026 @StudyPlanSecurityRemediation2026

== Synchronisierung und Fehlerverhalten <sec:collaboration-evaluation>

Die Integrationsprototypen belegen die technische Verbindung von PowerSync, lokalem SQLite und Drizzle. Im Terminprototyp blieben ein Datensatz und vier ausstehende Änderungen nach dem Schließen und erneuten Öffnen der Datenbank erhalten. Der dokumentierte Replikatabgleich übertrug denselben Datensatz an eine weitere lokale Replik. Die geprüfte Schemaerweiterung ergänzt eine Client-View; sie ist kein vollständiger koordinierter Versionsrollout von Backend, Datenverteilung und Anwendung. Die Übernahme bestehender persönlicher Termine einschließlich ihrer Referenzen wurde ebenfalls nicht demonstriert. @StudyPlanSyncSpikes2026

Für den Gruppenbereich dokumentiert die Upload-Nachprüfung vom 26. September neun erfolgreiche Prüfungen mit Electron, PowerSync und SQLite sowie zwölf erfolgreiche Cloud-Prüfpunkte. Zu den Cloud-Fällen gehören Benutzersuche und Einladungszustellung, Annahme mit synchronisierter Mitgliedschaft, Offline-Aufgabenänderung und anschließender Abgleich zwischen Mitgliedern. Die zwölf Prüfpunkte umfassen auch die Bereinigung der erzeugten Testdaten. Diese Ergebnisse beziehen sich auf getrennte Testreplikate und den damaligen Dienststand, nicht auf einen vollständig geprüften Kontolebenszyklus oder eine produktive Mehrgeräteanwendung. @StudyPlanUploadChecks2026

Die Nachprüfung enthält auch negative Ergebnisse des vorherigen Verhaltens. Fünf Regressionen zeigten, dass eine ohne Wirkung gebliebene Änderung aus der Warteschlange verschwinden konnte, ein abgewiesener Auftrag unabhängige Änderungen blockierte und wiederholte Uploads neuere Bearbeitungen überschrieben. Der erfolgreiche lokale Standardablauf hatte diese Fehler nicht erkannt. Nach der Änderung werden bekannte Ablehnungen vor dem Bestätigen der Warteschlangentransaktion lokal gesichert. Wiederholte Operationen erhalten anhand ihrer Identität den bereits erfassten Ausgang. Die Protokolle belegen die ausgewählten Fälle einschließlich verlorener Antworten, Prozessabbruch und konkurrierender doppelter Anfragen. @StudyPlanUploadChecks2026

Der aktuelle Connector verwendet hierfür `upload_group_task` und ein lokales Ablehnungsjournal. Die erneute Anwendung derselben Operation ist von einer neuen konkurrierenden Bearbeitung zu unterscheiden: Die protokollierten Fälle belegen Schutz vor den untersuchten Wiederholungsfehlern, aber keine allgemeine Zusammenführung konkurrierender Änderungen. Auch eine lokale Transaktion mit mehreren Aufgabenoperationen wird dadurch nicht zu einer einzigen atomaren entfernten Transaktion. Diese Grenzen konkretisieren das in Kapitel 5 beschriebene Fehlerverhalten der Synchronisierung. @StudyPlanUploadChecks2026 @StudyPlanEvaluationSource2026

Im korrigierten Windows-Paket wurde ergänzend eine synthetische Aufgabe über die Oberfläche gespeichert, erneut geöffnet und aus dem lokalen Bestand gelesen. Zum dokumentierten Zeitpunkt meldete die Synchronisierung `connected: true` und `pendingUploads: 0`. Der spätere Weiterbetrieb erzeugte jedoch Streamabbrüche im Startprotokoll. Der erfolgreiche Einzelablauf ist deshalb kein Beleg eines dauerhaft störungsfreien Onlinebetriebs. Zusammen mit den Prototypen stützt er A6 für die ausgewählten Aufgaben-, Gruppen- und Einladungsabläufe. Unmittelbare Online-Voraussetzungen und der lokale Abschluss bleiben dabei getrennt. @StudyPlanSecurityRemediation2026

== Ergebnis der Sicherheitsprüfung <sec:security-evaluation>

Die konsolidierte Matrix bewertet alle 20 Electron-Empfehlungen. Sie weist 17 auf der jeweils dokumentierten Nachweisebene als erfüllt aus. Zwei Empfehlungen zu Webviews sind wegen deren fehlender Nutzung begründet nicht anwendbar. Punkt 1 wird innerhalb des ausdrücklich begrenzten Prüfumfangs als erfüllt bewertet: HTTPS-Konfiguration und Redirect-Abweisung sind für Katalog und Supabase belegt, die SDK-interne PowerSync-Redirectbehandlung ist dagegen nicht praktisch nachgewiesen. Diese Grenze bleibt Teil der Bewertung von A7. @StudyPlanSecurity2026

Für Renderer-Isolation, Sandbox, Berechtigungen und bestimmte Standardwerte stützt sich die Bewertung überwiegend auf Code- und versionsbezogene Konfigurationsprüfung. Die Senderpolicy wird dagegen zusätzlich durch sechs Unit-Fälle geprüft. Fuses und ASAR-Integrität wurden an der tatsächlichen EXE und am Archiv kontrolliert. Keine dieser Nachweisebenen darf als umfassender Laufzeitangriff gegen sämtliche Empfehlungen ausgegeben werden. @sec:app-hardening dokumentiert die Zuordnung und Umsetzung; @tab:security-runtime-results fasst die tatsächlich beobachteten Fälle zusammen. @StudyPlanSecurityRemediation2026

#block[
  #show figure.where(kind: table): set block(breakable: true)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (0.7fr, 2.5fr, 2.2fr),
        inset: 5pt,
        align: left,
        table.header([*Fall*], [*Beobachtetes Ergebnis*], [*Reichweite*]),
        [P1], [Ungültige Eingabe an beiden realen Bridges zurückgewiesen: API mit `VALIDATION_ERROR`, Kollaboration mit `INVALID`.], [Zwei ausgewählte Eingaben aus dem erlaubten Renderer; keine vollständige Operations- oder Rollenmatrix und kein Angriff aus einem fremden Fenster.],
        [P2], [Gespeicherter HTML-artiger Aufgabentitel bleibt auch nach Wiederöffnung Text: ein passender Absatz, Textknoten, kein SVG-Element und kein Ausführungsmarker.], [Darstellung und erneutes Lesen dieser Aufgabe im Paket; keine allgemeine XSS-Freiheit oder Mehrgeräteprüfung.],
        [P3], [Fremde Skriptquelle durch die CSP blockiert; beobachtetes Ereignis mit `script-src-elem`, kein gesetzter Ausführungsmarker.], [Konkreter Ressourcenladefall; die DevTools-Ausführung des Prüfaufbaus ist selbst kein XSS-Nachweis.],
        [Navigation / Fenster], [Fremde Navigation ändert die App-Adresse nicht; `window.open` liefert `null`, kein zusätzliches App-Fenster oder beobachtetes Browseröffnen.], [Ausgewählte Paketversuche ergänzen die Codeprüfung der Dokument- und Fensterpolicy.],
      )
    },
    caption: [Beobachtete negative Laufzeitfälle am korrigierten Windows-Paket vom 4. Oktober 2026 nach @StudyPlanSecurityRemediation2026.],
  ) <tab:security-runtime-results>
]

Der Nachbesserungsverlauf zeigt außerdem die Bedeutung der Prüfung am erzeugten Artefakt. Die erste URL-Normalisierung verhinderte die PowerSync-Verbindung; ein Resolverproblem beeinträchtigte die Formularvalidierung. Beide Befunde wurden korrigiert und die finalen Paketnachweise separat gebunden. Frühere erfolgreiche Teilprüfungen des fehlerhaften Zwischenstands wurden nicht als Funktionsnachweise der korrigierten Binary übernommen. Die Sicherheitsbewertung bezieht sich daher auf den ausgewiesenen finalen Stand. @StudyPlanSecurityRemediation2026

A7 ist damit im festgelegten Richtlinien- und Nachweisrahmen erfüllt. Die Bewertung umfasst weder die Härtung der entfernten Infrastruktur noch Datenbankverschlüsselung gegenüber anderen Betriebssystemprozessen oder eine Distributionsfreigabe. Sie enthält insbesondere keinen zusätzlichen PowerSync-Redirectnachweis. Aus dem dokumentierten Ergebnis folgt keine Aussage über die Abwesenheit sämtlicher Schwachstellen. @StudyPlanSecurity2026

== Bewertung der Anforderungen und des Leitfadens <sec:requirements-evaluation>

Die Ergebnisse werden in @tab:requirements-evaluation auf den Anforderungskatalog zurückgeführt. *Belegt* bezeichnet dort einen durch die genannten Verfahren gestützten Befund innerhalb des ausgewiesenen Umfangs. *Teilweise belegt* weist aus, dass für einen erforderlichen Zielzustand nur Teilnachweise vorliegen. Die Anforderungsbewertung wird somit von einer pauschalen Aussage über die gesamte Anwendung getrennt.

#block[
  #show figure.where(kind: table): set block(breakable: false)
  #figure(
    {
      set par(justify: false)
      set text(size: 9pt)
      table(
        columns: (0.55fr, 1.3fr, 3.4fr),
        inset: 3.5pt,
        align: left,
        table.header([*Anf.*], [*Bewertung*], [*Beleg und Einordnung*]),
        [A1], [Für den geprüften Windows-Paketstand belegt.], [Start, Assets, Anmeldung, Gruppenroute und Aufgabenablauf dokumentiert; native Datenbank- und Workerchecks erfolgreich. Keine entsprechende Plattform- oder Installerbewertung.],
        [A2], [Architektonisch und exemplarisch belegt.], [Verantwortlichkeiten der Module und vollständiger Notenpfad nachvollzogen; lokale fachliche Tests ohne Oberfläche. Erweiterte Testabdeckung ist davon zu unterscheiden.],
        [A3], [Qualitativ belegt.], [Wiederverwendete Komponenten und erforderliche Änderungen dokumentiert. Kein Vergleich des Entwicklungsaufwands mit alternativen Werkzeugen.],
        [A4], [Belegt.], [Lokale Fachoperationen über Preload und IPC statt eines lokalen HTTP-Backends; externe HTTPS-Anbindungen bleiben gesondert.],
        [A5], [Teilweise belegt.], [Lokale Datenhaltung und geprüfte persönliche Operationen vorhanden. Vollständiger Offline-Paketdurchlauf mit Neustartnachweis aller persönlichen Kernfunktionen nicht dokumentiert.],
        [A6], [Für die untersuchten Kollaborationsfälle belegt.], [Lokale Persistenz, Warteschlange, Einladung, Mitgliedschaft und Abgleich in ausgewählten Prototypfällen; Aufgabenablauf im finalen Paket. Kein dauerhaft störungsfreier Betrieb nachgewiesen.],
        [A7], [Im festgelegten Prüfumfang erfüllt.], [Alle 20 Empfehlungen eingeordnet; Code-, Unit-, Paket- und Laufzeitbelege ausgewiesen. PowerSync-Redirectbehandlung bleibt dokumentierte Nachweisgrenze.],
        [A8], [Für die repräsentativen Verarbeitungspfade belegt.], [CRUD, Dateiimporte, Download und Kollaboration mit wiederkehrenden Architekturmustern abgedeckt. Oberflächeneinzelheiten nicht vollständig systematisch geprüft.],
        [A9], [Durch Prozess- und Strukturabgleich belegt.], [Voraussetzungen, Phasen, Änderungen und Kontrollpunkte in Kapitel 5 dokumentiert; M1–M8 zugeordnet. Keine unabhängige Anwendung des Leitfadens auf ein weiteres Artefakt.],
      )
    },
    caption: [Anforderungsbezogene Bewertung auf Grundlage der in diesem Kapitel ausgewiesenen Belege und Nachweisgrenzen.],
  ) <tab:requirements-evaluation>
]

Der Leitfaden aus @sec:migration-recommendations lässt sich dem Demonstrator zuordnen: M1–M2 betreffen Laufzeit, Datenhaltung und Identität; M3–M5 die Vertrags-, CRUD- und Importpfade; M6–M7 die externe Datenübernahme und Kollaboration; M8 die konsolidierte Härtung. Die Beispiele zeigen wiederkehrende Verantwortlichkeiten bei unterschiedlichen Interaktionsformen. Dadurch ist die Ableitung der Handlungsempfehlungen aus dem Fall nachvollziehbar. Dass eine weitere Person damit ein anderes Artefakt ohne wesentliche Lücken migriert, wurde nicht unabhängig geprüft.

Die nachgewiesene Wiederverwendung und die geprüften Verarbeitungspfade stützen den fallbezogenen Ansatz. Die wichtigste offene funktionale Nachweisaufgabe ist der vollständige Offline- und Neustartdurchlauf für A5. Darüber hinaus bleiben die genannten Transport- und Laufzeitgrenzen bestehen. Ein früheres Upload-Prüfprotokoll enthält auch einen fehlgeschlagenen Gesamtlint mit überwiegend bestehenden Formatierungsbefunden; diese Prüfung wurde hier nicht erneut ausgeführt. Erfolgreiche fachliche Tests und Paketabläufe sind daher kein pauschaler Nachweis technischer Schuldenfreiheit. Die Bedeutung dieser Ergebnisse für Übertragbarkeit und weitere Anwendung wird in Kapitel 7 diskutiert. @StudyPlanUploadChecks2026

