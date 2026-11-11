//---------------------------------------------------------------------
= Diskussion und Ausblick <ch:outlook>
//---------------------------------------------------------------------

Die Migration des KI-generierten Studienplaners von Replit zu einer lokal nutzbaren Electron-App gelang im festgelegten Umfang.
Die geprüften persönlichen Features funktionieren offline, und gespeicherte Daten bleiben nach einem Neustart verfügbar.
Gemeinsame Aufgaben lassen sich während einer bestehenden Sitzung offline bearbeiten und später abgleichen.

Die Sicherheitsprüfung in @sec:security-evaluation zeigt, dass die Electron Security Guidelines im festgelegten Prüfumfang eingehalten wurden.
Zwei Empfehlungen zu Webviews waren nicht anwendbar.
Bei der Prüfung sicherer externer Verbindungen blieb die interne Behandlung von Weiterleitungen durch PowerSync offen.

== Übertragbarkeit des erprobten Migrationswegs

Das Ziel eines frameworkunabhängigen Migrationswegs wurde teilweise erreicht.
Teile des TypeScript-Backends konnten übernommen werden, weil sowohl der Web-Prototyp als auch Electron eine Node.js-Laufzeit bereitstellen.
Bei einem Lovable-Prototyp, dessen Backend überwiegend aus Supabase-Diensten besteht und für den kein vergleichbarer eigener Backend-Code vorliegt, müssten Teile der Verarbeitung für den Offline-Betrieb gegebenenfalls neu entwickelt werden.
Für andere Projekte lässt sich daraus der erste Schritt des Leitfadens ableiten.
Pro Feature ist zu klären, wo seine Verarbeitung bisher stattfindet und welche Schritte künftig auf dem Gerät laufen müssen.

Im Vorversuch änderte die KI bei der Migration unbeabsichtigt das Verhalten einzelner Features.
Aus den Erfahrungen des Vorversuchs entstand das Ziel, vorhandene Features möglichst unverändert zu übernehmen und notwendige Anpassungen ausdrücklich zu begründen.
Die schrittweise Migration sollte helfen, die Auswirkungen einzelner Änderungen nachvollziehbar zu halten.

== Entscheidungen und Abwägungen während der Migration

Der Wechsel zur Desktop-App eröffnete Entscheidungen, die im ursprünglichen Web-Prototyp noch nicht anstanden.
Bei Gruppeneinladungen wurde der Einladungslink durch die Auswahl eines Kontos in der App ersetzt.
Der ursprüngliche Link führte zur gemeinsam erreichbaren Web-Anwendung, deren Backend die Einladung prüfte und die Mitgliedschaft anlegte.
Die lokale Desktop-Oberfläche bietet diese gemeinsame Webadresse nicht mehr.
Die direkte Einladung eines vorhandenen Kontos wurde gewählt, um den Ablauf innerhalb der App abzuwickeln; die gemeinsame Verwaltung von Einladungen und Mitgliedschaften bleibt beim entfernten Backend.
Das Feature blieb erhalten, während sich der Bedienungsablauf bewusst änderte.
Auch die erneute Online-Anmeldung nach dem Schließen der App folgt einer Entscheidung.
Die entfernte Sitzung bleibt nur für die Laufzeit der App bestehen.
Sie über einen Neustart hinweg zu speichern, wäre eine andere Ausgestaltung gewesen.

Die Synchronisierung wurde zunächst für gemeinsame Gruppenaufgaben eingeführt.
So konnten Noten, Kalender und Stundenplan ihre bisherige lokale Datenbank weiterverwenden.
Die zweite lokale Datenbank begrenzte den Umfang der Umstellung, brachte aber zusätzlichen Pflegeaufwand mit sich.
Eine ähnliche Abwägung entstand bei den Schnittstellen.
Der eigene Generator hält Typen, Eingabeprüfungen und Aufrufe auf demselben Stand, muss dafür aber selbst gepflegt werden.
Für den synchronisierten Gruppenbereich kam ein zweiter API-Vertrag hinzu.

== Wissenschaftlicher und praktischer Beitrag des Leitfadens <sec:discussion-contribution>

Der wissenschaftliche Beitrag liegt darin, die Empfehlungen aus den Entscheidungen der Fallstudie herzuleiten.
Der Leitfaden hält fest, welche Eigenschaften des Prototyps die Entscheidungen beeinflussten und welche Folgen sich daraus ergaben.
Dadurch lässt sich bei einem weiteren Projekt prüfen, ob die Voraussetzungen für eine Empfehlung auch dort gelten.

Für Entwickler macht der Leitfaden das Vorhaben, eine App außerhalb ihrer ursprünglichen Plattform zu betreiben, planbar.
Sie können mit einem Feature beginnen, seine Abhängigkeiten untersuchen und festlegen, welches Verhalten nach der Übertragung erhalten bleiben soll.
Die Kontrollpunkte helfen ihnen zu beurteilen, wann dieser Schritt abgeschlossen ist.
Bei einem KI-generierten Prototyp kann diese Bestandsaufnahme besonders hilfreich sein, wenn die Oberfläche bereits funktioniert und der Aufbau des Codes noch wenig vertraut ist.

== Grenzen der Untersuchung <sec:discussion-validity>

Die Arbeit untersucht einen Replit-Prototyp und einen Technologiestack.
Eine unabhängige Anwendung des Leitfadens auf ein anderes Projekt steht aus.
Auch wurde nicht verglichen, ob das Vorgehen gegenüber anderen Ansätzen Aufwand spart oder ob die im Vorversuch beobachteten Probleme typisch für KI-gestützte Migrationen sind.

Von den Local-First-Aspekten wurden die autonome Offline-Verfügbarkeit und die Zusammenarbeit mehrerer Nutzer durch Synchronisierung untersucht.
Die übrigen Aspekte des Paradigmas waren nicht Gegenstand der Untersuchung.
Die Ergebnisse beziehen sich damit auf diese beiden Schwerpunkte und erlauben keine abschließende Bewertung der App anhand des gesamten Local-First-Paradigmas.
Die Wahl von PowerSync bezog sich auf gemeinsame Aufgaben mehrerer Personen.
Ob Turso für den Abgleich persönlicher Daten zwischen den Geräten einer Person besser geeignet wäre, wurde praktisch nicht verglichen.

== Ausblick <sec:future-work>

Eine andere Person könnte den Leitfaden auf einen Lovable-Prototyp mit Frontend und Backend-Diensten anwenden.
Dabei ließe sich festhalten, welche Schritte übertragbar sind, welche angepasst werden müssen und wo Angaben oder Kontrollpunkte fehlen.
Ergänzend könnten einzelne Migrationsschritte automatisiert werden.
Ein Vergleich ausgewählter Features vor und nach der Übertragung würde zeigen, ob die Automatisierung Aufwand spart und das vorgesehene Verhalten erhält.

Für die Weiterentwicklung der App bietet sich ein Test über zwei Versionen hinweg an.
Dazu würde eine neue Version an eine bestehende Installation ausgeliefert.
Geprüft würde, ob sie das Datenbankschema aktualisiert, vorhandene Daten erhält und mit Änderungen umgehen kann, die vor dem Update offline gespeichert wurden.
Bei synchronisierten Daten wäre zusätzlich das Verhalten älterer Clients zu prüfen.
Über mehrere Updates hinweg ließe sich außerdem untersuchen, welche Änderungen an Electron, Abhängigkeiten oder Schnittstellen neue Sicherheitsprüfungen erfordern.

Die beiden lokalen Datenbanken könnten in einer weiteren Entwicklungsphase zusammengeführt werden.
Dabei wäre zu prüfen, wie bestehende persönliche Daten und lokale Gruppenbestände mit ihren Beziehungen in die gemeinsame Datenbank übernommen werden können.
Für die Zusammenarbeit könnte die App außerdem eine Registrierung für entfernte Konten erhalten, einschließlich Kontobestätigung und Zuordnung zur lokalen Anmeldung.

Ein gemeinsamer API-Vertrag könnte schließlich die Aufrufe für persönliche Features und die Zusammenarbeit aus derselben Quelle beschreiben und generieren.
Dabei müssten die jeweiligen Prüfungen für lokale und entfernte Sitzungen erhalten bleiben.
