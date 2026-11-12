//---------------------------------------------------------------------
= Einleitung <ch:intro>
//---------------------------------------------------------------------

== Motivation und Relevanz

Viele Menschen möchten Anwendungen für den persönlichen Gebrauch erstellen, verfügen jedoch über keine Programmiererfahrung.
Durch KI-gestützte Entwicklungsplattformen wie Replit oder Lovable ist es ihnen heute möglich, innerhalb kurzer Zeit funktionsfähige Anwendungen zu erzeugen, ohne eine einzige Zeile Code selbst zu schreiben oder zu verstehen.
Diese Anwendungen nutzen die Erstellenden im Vertrauen darauf, sie seien sicher und produktionsreif.
Tatsächlich betrachten sie den erzeugten Code jedoch nie; sie beurteilen die Anwendung ausschließlich anhand ihrer sichtbaren Funktionen.
Der Quellcode bleibt für sie eine Blackbox, deren Qualität und Sicherheit sie nicht einschätzen können.

Die Relevanz dieser Entwicklung reicht über die Erstellung kleiner Hobby-Werkzeuge hinaus: KI-gestützte Entwicklungsplattformen richten sich auch an Unternehmen und werben mit Anwendungen für den produktiven Einsatz, wie etwa die Unternehmensbeispiele auf der Website von Lovable zeigen @Lovable2026.
Damit gewinnen Anforderungen an Sicherheit, Zuverlässigkeit und Wartbarkeit an Bedeutung.
Werden solche Anwendungen zudem als lokale Desktop-Anwendungen mit direktem Zugriff auf Dateisystem und Systemressourcen betrieben, müssen zusätzliche Sicherheitsanforderungen berücksichtigt werden.
Eine Anwendung, die oberflächlich funktioniert, aber unbemerkt unsicher oder architektonisch mangelhaft ist, kann in einer solchen Desktop-Zielumgebung Schäden verursachen, die über die Zugriffsmöglichkeiten einer im Browser isolierten Anwendung hinausgehen.
Genau an dieser Stelle setzt die vorliegende Arbeit an.

== Problemstellung

Besonders kritisch wird diese Diskrepanz, sobald eine solche Webanwendung in eine Desktop-Zielumgebung migriert werden soll.
Die Desktop-Zielumgebung einschließlich Betriebssystem, Dateisystem und Zugriffsrechten stellt andere Anforderungen als die Sandbox der KI-gestützten Entwicklungsplattform; die von der Plattform getroffenen Architekturentscheidungen lassen sich deshalb nicht unverändert übernehmen.
Technisch wäre es mit vergleichsweise geringem Aufwand möglich, eine Webanwendung nur oberflächlich zu verpacken, etwa indem im Main-Prozess einer Electron-Anwendung eine lokale Web-API betrieben und das Frontend unverändert im Renderer ausgeliefert wird.
Ein solcher Ansatz ermöglicht zwar die Ausführung auf dem Desktop, berücksichtigt für sich genommen jedoch nicht die zusätzlichen Sicherheitsanforderungen, die durch den Zugriff auf lokale Dateien und Systemressourcen entstehen.
Ohne eine gezielte Anpassung der Vertrauensgrenzen und Zugriffsmöglichkeiten können Schwachstellen der ursprünglichen Webanwendung dadurch Auswirkungen auf das lokale System erhalten.
Ziel der Arbeit ist deshalb nicht die bloße Ausführbarkeit auf dem Desktop, sondern eine sichere, architektonisch saubere Migration.
Für genau diese Klasse von Anwendungen fehlt bislang ein systematisches Vorgehen, um eine von Laien in Auftrag gegebene, KI-generierte Webanwendung sicher in eine lokale Desktop-Anwendung zu migrieren.

== Fallstudie und Zielsetzung

Um diese Lücke zu schließen, entwickelt die vorliegende Arbeit einen methodischen Migrationspfad für die Migration KI-generierter Webanwendungen in sichere Local-First-Desktop-Anwendungen.
Die Fallstudie ist der Studienplaner, eine deutschsprachige Studienverwaltungsanwendung. Der Webprototyp des Studienplaners wurde auf Replit erzeugt und wird in eine Electron-Anwendung migriert.
Entscheidend ist dabei, wie dieser Prototyp entstanden ist: Er wurde bewusst so in Auftrag gegeben, wie es eine Person ohne technischen Hintergrund tun würde.
Die beiden ursprünglichen Prompts beschreiben in überwiegend alltagssprachlicher Form gewünschte Funktionen und Nutzungsszenarien, etwa einen persönlichen Stundenplan und die Zusammenarbeit in Studiengruppen.
Sie enthalten auch Anforderungen an Anmeldung und Zugriffsschutz, machen jedoch keine Vorgaben zur Wahl eines UI-Frameworks oder einer konkreten Backend- oder Datenbanktechnologie.
Der Studienplaner ist damit keine von einem erfahrenen Entwickler gestaltete Anwendung, sondern eine authentisch laienhaft erzeugte, und repräsentiert so genau die Klasse von Artefakten, auf die der Migrationspfad abzielt.

Die Wahl des Local-First-Paradigmas als Zielarchitektur ist dabei nicht beliebig.
Damit soll veranschaulicht werden, dass die Migration in eine Desktop-Zielumgebung nicht auf den Umbau zu einer ausschließlich offline nutzbaren Anwendung beschränkt ist.
Local-First bündelt mehrere für die Migration KI-generierter Software zentrale Eigenschaften: autonome Offline-Verfügbarkeit, Datensouveränität und eine vom Netzwerk entkoppelte, dauerhaft verfügbare Nutzung.
Die Arbeit untersucht jedoch nicht sämtliche Aspekte dieses Paradigmas, sondern setzt einen besonderen Schwerpunkt auf die Synchronisation lokal gespeicherter Daten.
Online-Funktionen können erhalten bleiben und mit lokaler Datenhaltung sowie einer auch ohne Netzwerk verfügbaren Kernfunktionalität verbunden werden.

== Aufbau der Arbeit

Der weitere Aufbau der Arbeit orientiert sich an Design Science Research (DSR) und den Forschungsaktivitäten nach Peffers et al. und gliedert sich in sechs aufeinander aufbauende Kapitel:

- *Kapitel 2* legt das theoretische Fundament der Arbeit: Es führt in KI-gestützte Entwicklungsplattformen sowie API-Verträge ein, analysiert die Electron-Laufzeit unter Sicherheitsgesichtspunkten und behandelt lokale Datenhaltung sowie Local-First-Architekturen.
- *Kapitel 3* erläutert die Orientierung an DSR und den Forschungsaktivitäten nach Peffers et al. sowie das konkrete Vorgehen der Untersuchung.
- *Kapitel 4* widmet sich der Problem- und Kontextanalyse: Es analysiert bestehende KI-gestützte Entwicklungsplattformen (u. a. Replit, Lovable) und leitet die Anforderungen an die Electron-Anwendung und den Migrationspfad ab.
- *Kapitel 5* dokumentiert die Migration des Webprototyps zur Electron-Anwendung und leitet daraus die Empfehlungen des Migrationspfads ab.
- *Kapitel 6* evaluiert und demonstriert den entwickelten Migrationspfad anhand einer empirischen Fallstudie.
- *Kapitel 7* bündelt die zentralen Ergebnisse, diskutiert Entscheidungen, Beitrag und Grenzen des Migrationspfads und schließt mit einem Ausblick auf weiterführende Untersuchungen und die Weiterentwicklung der Anwendung.
