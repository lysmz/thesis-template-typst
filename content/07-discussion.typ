//---------------------------------------------------------------------
= Diskussion und Ausblick <ch:outlook>
//---------------------------------------------------------------------

Die Migration des KI-generierten Studienplaners von Replit zu einer lokal nutzbaren Electron-Anwendung gelang im festgelegten Umfang.
Die geprüften persönlichen Funktionsbereiche funktionieren offline, und gespeicherte Daten bleiben nach einem Neustart verfügbar.
Gemeinsame Gruppenaufgaben lassen sich während einer bestehenden Supabase-Kollaborationssitzung offline bearbeiten und später synchronisieren.

Die Sicherheitsprüfung in @sec:security-evaluation zeigt, dass die Electron-Sicherheitsrichtlinien im festgelegten Prüfumfang eingehalten wurden.
Zwei Empfehlungen zu Webviews waren nicht anwendbar.
Bei der Prüfung sicherer externer Verbindungen blieb die interne Behandlung von Weiterleitungen durch PowerSync offen.

== Übertragbarkeit des erprobten Migrationspfads

Das Ziel eines frameworkunabhängigen Migrationspfads wurde teilweise erreicht.
Teile des TypeScript-Backends konnten übernommen werden, weil sowohl der Webprototyp als auch Electron eine Node.js-Laufzeit bereitstellen.
Bei einem Lovable-Prototyp, dessen Backend überwiegend aus Supabase-Diensten besteht und für den kein vergleichbarer eigener Backend-Code vorliegt, müssten Teile der Verarbeitung für den Offline-Betrieb gegebenenfalls neu entwickelt werden.
Für andere Projekte lässt sich daraus der erste Schritt des Migrationspfads ableiten.
Pro Funktionsbereich ist zu klären, wo seine Verarbeitung bisher stattfindet und welche Schritte künftig auf dem Gerät laufen müssen.

Im ersten Migrationsversuch änderte die KI bei der Migration unbeabsichtigt das Verhalten einzelner Funktionsbereiche.
Aus den Erfahrungen des ersten Migrationsversuchs entstand das Ziel, vorhandene Funktionsbereiche möglichst unverändert zu übernehmen und notwendige Anpassungen ausdrücklich zu begründen.
Die schrittweise Migration sollte helfen, die Auswirkungen einzelner Änderungen nachvollziehbar zu halten.

== Entscheidungen und Abwägungen während der Migration

Der Wechsel zur Electron-Anwendung eröffnete Entscheidungen, die im ursprünglichen Webprototyp noch nicht anstanden.
Bei Gruppeneinladungen wurde die linkbasierte Gruppeneinladung durch die direkte Kontoeinladung eines vorhandenen Supabase-Benutzerkontos ersetzt. 
@sec:collaboration-invitations dokumentiert beide Abläufe.
Der ursprüngliche Link führte zur gemeinsam erreichbaren Web-Anwendung, deren Backend die Einladung prüfte und die Mitgliedschaft anlegte.
Die lokale Desktop-Oberfläche bietet diese gemeinsame Webadresse nicht mehr.
Die direkte Kontoeinladung wurde gewählt, um den Ablauf innerhalb der Electron-Anwendung abzuwickeln; die gemeinsame Verwaltung von Einladungen und Mitgliedschaften bleibt beim entfernten Backend.
Der Funktionsbereich blieb erhalten, während sich der Bedienungsablauf bewusst änderte.
Auch die erneute Anmeldung mit dem Supabase-Benutzerkonto nach dem Schließen der Electron-Anwendung folgt einer Entscheidung.
Die Supabase-Kollaborationssitzung bleibt nur für die Laufzeit der Electron-Anwendung bestehen.
Sie über einen Neustart hinweg zu speichern, wäre eine andere Ausgestaltung gewesen.

Die Synchronisation wurde zunächst für gemeinsame Gruppenaufgaben eingeführt.
So konnten Noten, Kalender und Stundenplan ihre bisherige lokale Kerndatenbank weiterverwenden.
Die zusätzliche lokale Kollaborationsdatenbank begrenzte den Umfang der Umstellung, brachte aber zusätzlichen Pflegeaufwand mit sich.
Eine ähnliche Abwägung entstand bei den Schnittstellen.
Der IPC-Codegenerator hält Typen, Eingabevalidierungen und Aufrufe auf demselben Stand, muss dafür aber selbst gepflegt werden.
Für die synchronisierten Studiengruppen kam neben dem OpenAPI-Vertrag ein manuell typisierter Kollaborationsvertrag hinzu.

== Wissenschaftlicher und praktischer Beitrag des Migrationspfads <sec:discussion-contribution>

Der wissenschaftliche Beitrag liegt darin, die Empfehlungen aus den Entscheidungen der Fallstudie herzuleiten.
Der Migrationspfad hält fest, welche Eigenschaften des Prototyps die Entscheidungen beeinflussten und welche Folgen sich daraus ergaben.
Dadurch lässt sich bei einem weiteren Projekt prüfen, ob die Voraussetzungen für eine Empfehlung auch dort gelten.

Für Entwickler macht der Migrationspfad die Migration einer Webanwendung aus ihrer ursprünglichen Plattform in eine Desktop-Zielumgebung planbar.
Sie können mit einem Funktionsbereich beginnen, seine Abhängigkeiten untersuchen und festlegen, welches Verhalten nach der Migration erhalten bleiben soll.
Die Kontrollpunkte helfen ihnen zu beurteilen, wann dieser Schritt abgeschlossen ist.
Bei einem KI-generierten Prototyp kann diese Bestandsaufnahme besonders hilfreich sein, wenn die Benutzeroberfläche bereits funktioniert und der Aufbau des Codes noch wenig vertraut ist.

== Grenzen der Untersuchung <sec:discussion-validity>

Die Arbeit untersucht einen Webprototyp und einen Technologiestack.
Eine unabhängige Anwendung des Migrationspfads auf ein anderes Projekt steht aus.
Auch wurde nicht verglichen, ob das Vorgehen gegenüber anderen Ansätzen Aufwand spart oder ob die im ersten Migrationsversuch beobachteten Probleme typisch für KI-gestützte Migrationen sind.

Von den Local-First-Aspekten wurden die autonome Offline-Verfügbarkeit und die Zusammenarbeit mehrerer Nutzer durch Synchronisation untersucht.
Die übrigen Aspekte des Paradigmas waren nicht Gegenstand der Untersuchung.
Die Ergebnisse beziehen sich damit auf diese beiden Schwerpunkte und erlauben keine abschließende Bewertung der Electron-Anwendung anhand des gesamten Local-First-Paradigmas.
Die Wahl von PowerSync bezog sich auf gemeinsame Gruppenaufgaben mehrerer Personen.
Ob Turso für den Abgleich persönlicher Daten zwischen den Geräten einer Person besser geeignet wäre, wurde praktisch nicht verglichen.

== Ausblick <sec:future-work>

Eine andere Person könnte den Migrationspfad auf einen Lovable-Prototyp mit Frontend und Backend-Diensten anwenden.
Dabei ließe sich festhalten, welche Schritte übertragbar sind, welche angepasst werden müssen und wo Angaben oder Kontrollpunkte fehlen.
Ergänzend könnten einzelne Migrationsschritte automatisiert werden.
Ein Vergleich ausgewählter Funktionsbereiche vor und nach der Migration würde zeigen, ob die Automatisierung Aufwand spart und das vorgesehene Verhalten erhält.

Für die Weiterentwicklung der Electron-Anwendung bietet sich ein Test über zwei Versionen hinweg an.
Dazu würde eine neue Version an eine bestehende Installation ausgeliefert.
Geprüft würde, ob sie das Datenbankschema aktualisiert, vorhandene Daten erhält und mit Änderungen umgehen kann, die vor dem Update offline gespeichert wurden.
Bei synchronisierten Daten wäre zusätzlich das Verhalten älterer Clients zu prüfen.
Über mehrere Updates hinweg ließe sich außerdem untersuchen, welche Änderungen an Electron, Abhängigkeiten oder Schnittstellen neue Sicherheitsprüfungen erfordern.

Die lokale Kerndatenbank und die lokale Kollaborationsdatenbank könnten in einer weiteren Entwicklungsphase zusammengeführt werden.
Dabei wäre zu prüfen, wie bestehende persönliche Daten und lokale Gruppenbestände mit ihren Beziehungen in die gemeinsame Datenbank übernommen werden können.
Für die Zusammenarbeit könnte die Electron-Anwendung außerdem eine Registrierung für Supabase-Benutzerkonten erhalten, einschließlich Kontobestätigung und einer ausdrücklichen Verknüpfung mit dem lokalen Benutzerkonto.

Ein gemeinsamer API-Vertrag könnte schließlich die Aufrufe für persönliche Funktionsbereiche und die Zusammenarbeit aus derselben Quelle beschreiben und generieren.
Dabei müssten die jeweiligen Prüfungen für lokale Anwendungssitzungen und Supabase-Kollaborationssitzungen erhalten bleiben.
