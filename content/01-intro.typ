//---------------------------------------------------------------------
= Einleitung <ch:intro>
//---------------------------------------------------------------------

== Motivation und Relevanz

Viele Menschen möchten Anwendungen für den persönlichen Gebrauch erstellen, verfügen jedoch über keine Programmiererfahrung.
Durch KI-gestützte Werkzeuge wie Replit oder Lovable ist es ihnen heute möglich, innerhalb kurzer Zeit funktionsfähige Anwendungen zu erzeugen, ohne eine einzige Zeile Code selbst zu schreiben oder zu verstehen.
Diese Anwendungen nutzen die Erstellenden im Vertrauen darauf, sie seien sicher und produktionsreif.
Tatsächlich betrachten sie den erzeugten Code jedoch nie; sie beurteilen die Anwendung ausschließlich anhand ihrer sichtbaren Funktionen.
Der Quellcode bleibt für sie eine Blackbox, deren Qualität und Sicherheit sie nicht einschätzen können.

Die Relevanz dieser Entwicklung reicht über die Erstellung kleiner Hobby-Werkzeuge hinaus: KI-gestützte Entwicklungsplattformen richten sich auch an Unternehmen und werben mit Anwendungen für den produktiven Einsatz, wie etwa die Unternehmensbeispiele auf der Website von Lovable zeigen @Lovable2026.
Damit gewinnen Anforderungen an Sicherheit, Zuverlässigkeit und Wartbarkeit an Bedeutung.
Werden solche Anwendungen zudem als lokale Desktop-Anwendungen mit direktem Zugriff auf Dateisystem und Systemressourcen betrieben, müssen zusätzliche Sicherheitsanforderungen berücksichtigt werden.
Eine Anwendung, die oberflächlich funktioniert, aber unbemerkt unsicher oder architektonisch mangelhaft ist, kann in einer solchen lokalen Laufzeitumgebung Schäden verursachen, die über die Zugriffsmöglichkeiten einer im Browser isolierten Anwendung hinausgehen.
Genau an dieser Stelle setzt die vorliegende Arbeit an.

== Problemstellung

Von technischen Laien instruierte generative KI-Modelle fokussieren sich nahezu ausschließlich auf die Umsetzung der gewünschten Funktionen.
Fundamentale Qualitätsmerkmale des Software Engineerings nach ISO/IEC 25010 — Wartbarkeit, Trennung der Belange, Interoperabilität und Sicherheit — bleiben dabei regelmäßig unberücksichtigt.
Auch die Produktdarstellung von Lovable betont die schnelle Umsetzung beschriebener Ideen und deren unmittelbare Bereitstellung.
Zwar bewirbt die Plattform zugleich Sicherheitsfunktionen; aus der sichtbaren Funktionalität und den Produktversprechen allein lässt sich jedoch nicht ableiten, ob der erzeugte Code die Qualitätsanforderungen eines konkreten Einsatzszenarios erfüllt @Lovable2026.
Der entstehende Code ist häufig unstrukturiert und stark gekoppelt, was spätere Wartung und Erweiterung erschwert.
Da die Erstellenden nur die Funktionen, nicht aber den Code beurteilen, bleibt diese Diskrepanz für sie unsichtbar: Die Anwendung wirkt einsatzbereit, obwohl sie es nicht ist.

Besonders kritisch wird diese Diskrepanz, sobald eine solche Webanwendung in eine lokale Desktop-Umgebung überführt werden soll.
Die Zielumgebung stellt völlig andere Anforderungen als die isolierte Sandbox des KI-Werkzeugs, und die vom Werkzeug getroffenen Architekturentscheidungen lassen sich nicht unverändert übernehmen.
Technisch wäre es mit vergleichsweise geringem Aufwand möglich, eine Webanwendung nur oberflächlich zu verpacken, etwa indem im Main-Prozess einer Electron-Anwendung eine lokale Web-API betrieben und das Frontend unverändert im Renderer ausgeliefert wird.
Ein solcher Ansatz ermöglicht zwar die Ausführung auf dem Desktop, berücksichtigt für sich genommen jedoch nicht die zusätzlichen Sicherheitsanforderungen, die durch den Zugriff auf lokale Dateien und Systemressourcen entstehen.
Ohne eine gezielte Anpassung der Vertrauensgrenzen und Zugriffsmöglichkeiten können Schwachstellen der ursprünglichen Webanwendung dadurch Auswirkungen auf das lokale System erhalten.
Ziel der Arbeit ist deshalb nicht die bloße Ausführbarkeit auf dem Desktop, sondern eine sichere, architektonisch saubere Transformation.
Für genau diese Klasse von Anwendungen fehlt bislang ein systematisches Vorgehen, um eine von Laien in Auftrag gegebene, KI-generierte Webanwendung sicher in eine lokale Desktop-Anwendung zu transformieren.

== Fallstudie und Zielsetzung

Um diese Lücke zu schließen, entwickelt die vorliegende Arbeit einen methodischen Migrationspfad für die Überführung KI-generierter Webanwendungen in sichere Local-First-Desktop-Anwendungen.
Validierungsobjekt ist eine konkrete Fallstudie: der Studienplaner, eine deutschsprachige Studienverwaltungsanwendung, die als Replit-Webprototyp vorliegt und in eine Electron-Anwendung überführt wird.
Entscheidend ist dabei, wie dieser Prototyp entstanden ist: Er wurde bewusst so in Auftrag gegeben, wie es eine Person ohne technischen Hintergrund tun würde.
Die beiden ursprünglichen Prompts beschreiben in überwiegend alltagssprachlicher Form gewünschte Funktionen und Nutzungsszenarien, etwa einen persönlichen Stundenplan und die Zusammenarbeit in Studiengruppen (@app:prompt-initial und @app:prompt-groups).
Sie enthalten auch Anforderungen an Anmeldung und Zugriffsschutz, machen jedoch keine Vorgaben zur Wahl eines UI-Frameworks oder einer konkreten Backend- oder Datenbanktechnologie.
Der Studienplaner ist damit keine von einem erfahrenen Entwickler gestaltete Anwendung, sondern eine authentisch laienhaft erzeugte, und repräsentiert so genau die Klasse von Artefakten, auf die der Migrationspfad abzielt.

Die Wahl des Local-First-Paradigmas als Zielarchitektur ist dabei nicht beliebig.
Local-First bündelt mehrere für die Migration KI-generierter Software zentrale Eigenschaften: Offline-Fähigkeit, Datensouveränität und eine vom Netzwerk entkoppelte, dauerhaft verfügbare Nutzung.
Die Arbeit untersucht jedoch nicht sämtliche Aspekte dieses Paradigmas, sondern setzt einen besonderen Schwerpunkt auf die Synchronisierung lokal gespeicherter Daten.
Damit soll veranschaulicht werden, dass die Migration in eine Desktop-Umgebung nicht auf den Umbau zu einer ausschließlich offline nutzbaren Anwendung beschränkt ist.
Online-Funktionen können erhalten bleiben und mit lokaler Datenhaltung sowie einer auch ohne Netzwerk verfügbaren Kernfunktionalität verbunden werden.

== Forschungsfrage

*FF1:* Wie können KI-generierte Webarchitekturen mithilfe eines framework-agnostischen Ansatzes systematisch in sichere Local-First-Desktop-Anwendungen überführt werden?

== Aufbau der Arbeit

Der weitere Aufbau der Arbeit orientiert sich am Design-Science-Research-Prozess und gliedert sich in sieben weitere Kapitel.
Kapitel 2 legt den theoretischen Hintergrund, indem es KI-gestützte Entwicklungswerkzeuge, die Besonderheiten von Web-zu-Desktop-Architekturen, das Local-First-Paradigma sowie sicherheitsrelevante Grundlagen einordnet und die bestehende Forschungslücke herausarbeitet.
Kapitel 3 stellt den methodischen Rahmen der Arbeit vor, begründet die Wahl des Design-Science-Research-Ansatzes und skizziert den eigenen Forschungsprozess.
Kapitel 4 widmet sich der Problemanalyse: Zunächst wird die Softwarelandschaft KI-gestützter Entwicklungswerkzeuge, etwa Ansätze wie Replit oder Lovable, betrachtet, bevor in die Tiefe des gewählten Ansatzes, der Replit-Umgebung und des daraus resultierenden Artefakts, eingestiegen wird.
Kapitel 5 behandelt Entwurf und Entwicklung des Artefakts, also die konzeptionelle Architektur und die praktische Umsetzung der Electron-Anwendung.
Kapitel 6 stellt die Evaluation und Demonstration des entwickelten Migrationspfads anhand der Fallstudie in den Mittelpunkt.
Kapitel 7 diskutiert die gewonnenen Erkenntnisse, reflektiert die verfolgten Lösungswege und ordnet die Ergebnisse im Vergleich zu bestehenden Ansätzen ein.
Kapitel 8 fasst die zentralen Erkenntnisse zusammen und gibt einen Ausblick auf offene Fragestellungen und zukünftigen Forschungsbedarf.
