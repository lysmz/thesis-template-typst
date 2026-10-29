//---------------------------------------------------------------------
= Diskussion <ch:outlook>
//---------------------------------------------------------------------

Die Evaluation in @ch:experiments zeigt, welche Eigenschaften des Demonstrators durch die vorhandenen Belege gestützt sind.
Dieses Kapitel ordnet ihre Bedeutung für die Forschungsfrage und den Migrationsleitfaden ein.
Im Mittelpunkt stehen die Verlagerung von Verantwortlichkeiten, die Abwägung zwischen Wiederverwendung und Anpassung sowie die Grenzen der untersuchten Architektur.

== Beitrag zur Forschungsfrage <sec:discussion-contribution>

Die Forschungsfrage aus @ch:intro zielt auf eine systematische Überführung KI-generierter Webarchitekturen in sichere Local-First-Desktop-Anwendungen.
Der untersuchte Fall liefert dafür ein Vorgehen, das die vorhandenen Komponenten nach ihren Aufgaben einordnet und ihre Zuständigkeiten in der Zielumgebung neu festlegt.
Die Oberfläche bleibt weitgehend erhalten, während Datenhaltung, Schnittstellenverarbeitung und Dienstanbindungen angepasst werden.
Die Migration lässt sich damit als Transformation von Verantwortlichkeiten beschreiben: Aufgaben, die zuvor das entfernte Backend übernahm, werden teilweise in die lokale Anwendung verlagert; gemeinsame Daten benötigen weiterhin einen geregelten entfernten Abgleich.

Die Phasenstruktur macht diese Transformation nachvollziehbar.
Eine lokale Kernarchitektur schafft zunächst die Grundlage für Datenverarbeitung und Persistenz.
Darauf aufbauend werden externe Datenübernahme und Kollaboration ergänzt.
Die konsolidierte Härtung prüft die tatsächlich entstandenen Prozess- und Schnittstellengrenzen.
Die Schritte besitzen somit fachliche Abhängigkeiten, auch wenn Sicherheitsentscheidungen bereits während der gesamten Entwicklung erforderlich sind.
Die Beispiele für CRUD, Dateiimporte und Netzwerkanbindungen zeigen, wie dieses Vorgehen auf unterschiedliche Interaktionsformen angewendet wurde.

Der Beitrag zur Forschungsfrage besteht in einem begründeten, am Demonstrator nachvollziehbaren Migrationsmodell.
Die in @sec:migration-recommendations formulierten Handlungsempfehlungen verbinden Voraussetzungen, Änderungen und Kontrollpunkte.
Im Rahmen des gestaltungsorientierten Vorgehens werden Entwicklung, Demonstration und Evaluation eines solchen Artefakts miteinander verbunden @Peffers2007.
Die Aussagekraft dieses Ergebnisses hängt an den ausgewiesenen Nachweisen; die Fallstudie begründet keine allgemeine Gültigkeit für beliebige Webarchitekturen.

== Wiederverwendung und architektonische Anpassung <sec:discussion-reuse>

Das Ziel eines begrenzten Refactoring-Aufwands erwies sich als sinnvolle Orientierung für die Auswahl und Übernahme der Komponenten.
Die Kombination aus React, TypeScript und Vite sowie die Node.js-Laufzeit des Electron-Main-Prozesses passten zu wesentlichen Bestandteilen des Ausgangsartefakts.
@sec:offline-core-migration und @sec:frontend-migration zeigen die dadurch mögliche Weiterverwendung.
Diese technische Anschlussfähigkeit erklärt die Werkzeugwahl im konkreten Projekt.
Eine Überlegenheit von Electron oder electron-vite gegenüber den betrachteten Alternativen hinsichtlich Aufwand, Wartbarkeit oder Sicherheit wurde jedoch nicht vergleichend untersucht.

Wiederverwendung betrifft dabei unterschiedliche Ebenen.
Oberflächenkomponenten und fachliche Regeln konnten als Grundlage erhalten bleiben.
PostgreSQL-spezifische Schemadefinitionen, HTTP-Sitzungen und Route-Handler mussten dagegen an die lokale Laufzeit und ihre Verantwortlichkeiten angepasst werden.
@sec:architecture-evaluation stützt deshalb eine qualitative Aussage über erhaltene Bestandteile und nachvollziehbare Eingriffe.
Für A3 ist diese Unterscheidung entscheidend: Die Begrenzung des Änderungsumfangs bleibt den Architektur- und Sicherheitsanforderungen untergeordnet.
Die Eignung einer übernommenen Komponente richtet sich weiterhin nach den Anforderungen der Zielumgebung.

Der Vorversuch aus @sec:migration-preliminary verdeutlicht eine weitere Bedeutung der Wiederverwendung: Werden während der Übertragung zugleich Formulare, Datendarstellungen und Schnittstellen verändert, wird die Zuordnung einzelner Eingriffe schwieriger.
A3 dient deshalb auch der Kontrolle des Änderungsumfangs.
Vorhandenes Verhalten bildet einen Bezugspunkt, gegenüber dem notwendige Veränderungen begründet werden können.
Für den Leitfaden folgt daraus, Anpassungen an Transport und Persistenz nachvollziehbar zuzuordnen und zusätzliche Änderungen der Fachlogik oder Oberfläche ausdrücklich auszuweisen.

Der OpenAPI-IPC-Generator veranschaulicht diese Abwägung besonders deutlich.
Ein gemeinsamer Vertrag ermöglicht die abgestimmte Ableitung von Client, Hooks, Typen und Laufzeitschemata.
Dafür wurde ein eigener Generator entwickelt, der selbst verstanden, geprüft und gepflegt werden muss.
Die Entscheidung verlagert wiederkehrende Anpassungen in eine zentrale Übersetzung und ist im erweiterbaren Demonstrator nachvollziehbar.
Wie @sec:api-contract-migration zeigt, bleiben fachliche Implementierung, Berechtigungsentscheidungen und Fehlerbehandlung eigenständige Aufgaben.
Der Vertrag beschreibt die Schnittstelle; ihre korrekte und sichere Verwendung muss in den beteiligten Verarbeitungspfaden gewährleistet werden.

Die Übernahme dieses Vertrags setzt außerdem eine fachliche Prüfung des Ausgangsartefakts voraus.
Ein Generator kann Typen und Validierungsschemata konsistent aus einer Beschreibung ableiten, aber nicht feststellen, ob diese Beschreibung die beabsichtigte Domäne richtig modelliert.
Ein falscher Zusammenhang zwischen Entitäten oder eine unzutreffende Pflichtfeldregel kann dadurch ebenso konsequent in Schnittstellen und Zod-Schemata übernommen werden.
In der Fallstudie wurden ausgewählte Regeln der Studienplanung nachvollzogen; daraus folgt kein Nachweis einer allgemeinen fachlichen Zuverlässigkeit des erzeugenden Sprachmodells.
Bei anderen Domänen kann zusätzliches Fachwissen zur Prüfung erforderlich sein.
Die gemeinsame Vertragsgrundlage verringert somit widersprüchliche Schnittstellendefinitionen, ersetzt aber keine fachliche Validierung.

Der OpenAPI-Vertrag blieb zudem nicht die einzige Quelle für alle IPC-Schnittstellen der gesamten Migration.
Der Kollaborationsbereich erhielt separat definierte TypeScript-Verträge und Zod-Eingabeschemata, während die Kernanwendung den Generator weiterverwendet @StudyPlanContractReview2026.
Die in @sec:sync-implementation beschriebene Aufteilung begrenzt den Geltungsbereich der zentralen Vertragsquelle auf den generierten Bereich.
Dass fachliche Implementierungen zusätzlich geschrieben werden mussten, widerspricht diesem Prinzip für sich genommen nicht: Ein Schnittstellenvertrag beschreibt Aufrufe und Daten, nicht die vollständige Geschäftslogik.
Auch die Einführung einer zweiten Datenbank erzwingt keine zweite Vertragsquelle.
Die Aufteilung entstand aus der konkreten Integration und müsste für einen durchgehend gemeinsamen Vertrag gesondert bereinigt werden.

Die Trennung in Handler, Services und Repositories unterstützt diese weitere Bearbeitung.
Fachliche Tests können ohne React-Oberfläche ausgeführt und externe Abhängigkeiten an den betrachteten Stellen ersetzt werden.
Die Struktur schafft damit eine Erweiterungsgrundlage.
Ihre vollständige Nutzung durch zusätzliche Tests und weitere Funktionen bleibt eine Entwicklungsaufgabe.
Der in @sec:requirements-evaluation festgehaltene frühere Lint-Befund zeigt zudem, dass strukturelle Verbesserungen und erfolgreiche fachliche Tests nicht sämtliche bestehenden Qualitätsprobleme beseitigen.

== Einordnung der Local-First-Architektur <sec:discussion-local-first>

Kleppmann et al. verbinden Local-First mit lokaler Nutzbarkeit, Zusammenarbeit, langfristiger Verfügbarkeit sowie Kontrolle über die eigenen Daten.
Lokale Kopien besitzen in diesem Zielbild eine zentrale Rolle; Server unterstützen die Verteilung @Kleppmann2019.
Der Demonstrator greift daraus gezielt lokale Datenverarbeitung und ergänzende Synchronisierung auf.
Seine Einordnung muss deshalb zwischen diesen umgesetzten Eigenschaften und dem weitergehenden Anspruch auf Unabhängigkeit und Datenkontrolle unterscheiden.

Für die gemeinsamen Aufgaben bleibt das Backend maßgeblich für die Annahme von Änderungen und den anschließend verteilten Datenbestand.
PowerSync beschreibt dieses Vorgehen als serverautoritative Architektur @PowerSyncWritingChanges2026.
Die Anwendung ermöglicht zunächst einen lokalen Abschluss, während die entfernte Verarbeitung später erfolgen kann.
Die Zusammenarbeit bleibt an Konten, Berechtigungen und die gewählten Dienste gebunden.
Damit werden ausgewählte Local-First-Eigenschaften demonstriert; die vollständige Umsetzung des von Kleppmann et al. beschriebenen Zielbilds wird nicht beansprucht.

Die zwei lokalen Datenhaltungsbereiche erlaubten, Kollaboration neben den persönlichen Funktionen einzuführen.
Diese schrittweise Überführung lässt sich mit dem von Fowler beschriebenen Strangler-Fig-Vorgehen einordnen, bei dem abgegrenzte Teile einer bestehenden Anwendung nach und nach ersetzt werden.
Auch Übergangsstrukturen gehören zu diesem Ansatz @FowlerStranglerFig2024.
Im Demonstrator entstehen dadurch zusätzliche Zuständigkeiten für Datenbanktreiber, Identitäten und Schemaverwaltung.

Eine vollständige Fortführung müsste zwei unabhängige Entwurfsaufgaben behandeln.
Für eine gemeinsame Vertragsquelle könnten die Kollaborationsoperationen in den zentralen Vertrag aufgenommen und ihre Typen, Aufrufhilfen und Validierungsschemata daraus erzeugt werden.
Die Repositories könnten dabei zunächst weiterhin auf verschiedene Datenbanken zugreifen.
Eine zusätzliche Vereinheitlichung der Datenhaltung müsste dagegen bestehende Datensätze und Referenzen, Kennungen sowie lokale und entfernte Benutzerzuordnungen überführen.
Persönliche Tabellen wären ausdrücklich lokal zu konfigurieren; ihr Zugriff müsste auch ohne entfernte Anmeldung möglich bleiben.
Erst nach Ablösung aller bisherigen Datenzugriffe und ihrer Initialisierung könnte der libSQL-Treiber entfallen.
Die Schema-Vorprüfung aus Phase 2 zeigt einzelne Anpassungen, weist jedoch weder eine solche vollständige Datenmigration noch einen vereinheitlichten Gesamtvertrag nach.
Diese Schritte sind mögliche Weiterentwicklungen des Entwurfs.

Die Synchronisierung verändert außerdem die Verantwortung für Updates.
Das ausgelieferte Desktop-Paket verwaltet nur einen Teil der beteiligten Strukturen.
Änderungen an synchronisierten Daten betreffen auch das entfernte Schema und die Datenverteilung.
Die in @sec:sync-schema-updates hergeleitete Abstimmung ist deshalb eine betriebliche Konsequenz der gewählten Architektur.
Bei einer praktischen Anwendung müssten unterschiedliche Client-Versionen und noch ausstehende Änderungen berücksichtigt werden.

Die Upload-Nachprüfung aus @sec:collaboration-evaluation verdeutlicht schließlich, welche zusätzlichen Anforderungen aus der zeitlich getrennten Verarbeitung entstehen.
Fehler bei Ablehnung und Wiederholung wurden durch erfolgreiche Standardabläufe zunächst nicht erkannt.
Daraus folgt für den Leitfaden, dass der lokale Schreibabschluss, die Annahme durch das Backend und das Verhalten bei Wiederholung eigene Kontrollpunkte benötigen.
Fachliche Regeln für neue konkurrierende Bearbeitungen bleiben anwendungsspezifisch.
Der untersuchte Wiederholungsschutz und das Ablehnungsjournal behandeln dagegen konkrete Zuverlässigkeitsprobleme des übertragenen Verarbeitungspfads.
Diese Aufgaben müssen bei der Migration ausdrücklich eingeordnet werden, auch wenn eine umfassende Konfliktzusammenführung außerhalb des Untersuchungsumfangs liegt.

== Bedeutung der Härtung und des Paketbetriebs <sec:discussion-hardening>

Die Härtung betrifft das Zusammenwirken von Prozessisolation, begrenzten Fähigkeiten und Prüfungen an den Eingangsstellen.
Die Architektur begrenzt die Funktionen des Renderers; die Schnittstellenvalidierung prüft übertragene Daten, während fachliche Zugriffskontrollen deren zulässige Verwendung bestimmen.
Die Nachweise aus @sec:security-evaluation sind deshalb als Ergänzung dieser Struktur zu verstehen.
Eine einzelne Maßnahme oder ein bestandener negativer Fall trägt jeweils nur die zugehörige begrenzte Aussage.

Die dokumentierten Nachbesserungen zeigen die Bedeutung des erzeugten Pakets als Prüfgegenstand.
Native Datenbankmodule, Renderer-Ressourcen und buildabhängige Sicherheitskonfigurationen müssen in ihrer tatsächlichen Auslieferungsform funktionieren.
Änderungen am Ressourcenprotokoll und an der URL-Verarbeitung beeinflussten im untersuchten Verlauf auch Formulare und Synchronisierung @StudyPlanSecurityRemediation2026.
Funktionale und sicherheitsbezogene Prüfungen sind damit praktisch miteinander verbunden: Nach einer Härtungsänderung müssen die betroffenen Abläufe am neuen Paket erneut nachvollzogen werden.

Die Sicherheitsmatrix schafft hierfür einen nachvollziehbaren Bewertungsrahmen.
Sie macht sichtbar, welche Empfehlungen anwendbar sind und welche Aussage durch Codeinspektion, Unit-Test oder Laufzeitversuch gestützt wird.
Die dokumentierte Grenze bei der SDK-internen PowerSync-Redirectbehandlung bleibt dabei erhalten.
Ebenso sind die ausgeschlossenen Schutzaufgaben für entfernte Dienste und die lokale Datenbank innerhalb des Betriebssystems bei einer späteren Nutzung gesondert zu bestimmen.
Die Härtungsbewertung dieser Arbeit dient der begrenzten Prüfung des Demonstrators; sie ist keine allgemeine Freigabe für den produktiven Betrieb.

== Übertragbarkeit und Grenzen der Ergebnisse <sec:discussion-validity>

Potenzial für eine Übertragung besitzen vor allem die beschriebenen Verantwortlichkeiten: die Trennung von fachlichem Vertrag und Transport, die Aufteilung von Schnittstellenverarbeitung und Fachlogik, die lokale Persistenz sowie die Einordnung externer Datenflüsse.
Die konkreten Skripte, Bibliotheken und Konfigurationen sind dagegen an den untersuchten Technologiestack gebunden.
Der frameworkagnostische Anspruch liegt somit auf der Ebene dieser Prinzipien und Prüffragen.
Eine praktische Übertragbarkeit auf weitere Frameworks wurde nicht unabhängig nachgewiesen.

Die Voraussetzungen des Ausgangsartefakts begrenzen diesen Anspruch zusätzlich.
Im Replit-Prototyp lagen Frontend, serverseitige Fachlogik und Datenbankschema als analysierbarer Quellcode vor.
Bei der in @ch:analysis eingeordneten dienstgebundenen Ausgangslage wären auch die vom entfernten Dienst übernommenen Aufgaben zu erfassen und gegebenenfalls lokal nachzubilden.
Der Leitfaden bietet hierfür Fragen zur Zuständigkeit und Datenverarbeitung, aber keinen erprobten vollständigen Migrationsablauf.

Auch die Herkunft des Prototyps ist entsprechend einzuordnen.
Die Fallstudie untersucht ein anhand alltagssprachlicher Prompts erzeugtes Artefakt.
Die beobachtete Kopplung und die erforderlichen Anpassungen werden an dessen konkreter Architektur nachvollzogen.
Daraus lässt sich kein allgemeiner Vergleich zwischen KI-generiertem und menschlich entwickeltem Code ableiten.
Für die Anwendung des Leitfadens ist daher die Prüfung des tatsächlich vorliegenden Artefakts maßgeblich.
Ebenso begründet die rückblickende Einordnung des Vorversuchs die Verfahrensänderung, ohne eine allgemeine Aussage über die Zuverlässigkeit LLM-gestützter Migrationen zu tragen.
Ob das überarbeitete Vorgehen systematisch weniger unbeabsichtigte Änderungen erzeugt, wurde nicht unter vergleichbaren Bedingungen untersucht.

Die Evaluation verbindet Nachweise unterschiedlicher Ebenen und Prüfstände.
Lokale Service-Tests, Integrationsprototypen und ausgewählte Windows-Paketabläufe ergänzen sich, ersetzen aber keinen vollständigen gemeinsamen Durchlauf.
Die wichtigste funktionale Nachweislücke bleibt A5: Die lokalen Verarbeitungspfade sind nachvollziehbar, der vollständige Offline- und Neustartablauf aller persönlichen Kernfunktionen ist jedoch nicht dokumentiert.
Dieser offene Nachweis beschränkt die Aussage über den erreichten Gesamtzustand der Anwendung.
Der Leitfaden formuliert den entsprechenden Kontrollpunkt bereits und macht damit auch sichtbar, welche Prüfung noch erforderlich ist.

Entwicklung und Bewertung erfolgten innerhalb derselben Fallstudie.
Die Zuordnung der Schritte zum Demonstrator stützt die Herleitung des Leitfadens; seine Verständlichkeit und Anwendbarkeit durch eine weitere Person wurden nicht gesondert erprobt.
Die Erweiterbarkeit ist folglich durch die vorhandenen Muster begründet.
Sie ist keine empirische Aussage darüber, dass eine unerfahrene Person zusätzliche Funktionen ohne wesentliche Fehler umsetzen kann.
Ebenso bleiben technische Kenntnisse zur Durchführung und Bewertung der Migration erforderlich.

Für die weitere Verwendung sind daraus zwei vorrangige Aufgaben abzuleiten: den fehlenden Offline- und Persistenznachweis am festgelegten Paketstand zu vervollständigen und den Leitfaden an einem weiteren Ausgangsartefakt unabhängig anzuwenden.
Die erste Aufgabe stärkt die Aussage über den Demonstrator; die zweite prüft den Geltungsbereich der Handlungsempfehlungen.
Auf dieser Grundlage können die in der Fallstudie begründeten Prinzipien schrittweise zu einem breiter erprobten Migrationsverfahren weiterentwickelt werden.
