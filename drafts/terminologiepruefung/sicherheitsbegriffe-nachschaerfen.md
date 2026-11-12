# Gesonderte Nachschärfung: Prozesstrennung, Sandboxing und Kontextisolation

Stand: 12. November 2026. **Wie ausdrücklich vereinbart, sind die folgenden Stellen zur gemeinsamen fachlichen Durchsicht vorgemerkt.** Die aufgeführten Formulierungsvorschläge stehen bereits im Quelltext und in der separaten Prüf-PDF; die gemeinsame Nachschärfung ist noch offen. Alle Zeilen beziehen sich auf den aktuellen Quelltext.

Die wichtigste Stelle ist K2 Z.45. Prozesstrennung beschreibt die Aufteilung auf Prozesse; Sandboxing begrenzt Systemzugriffe; Kontextisolation trennt JavaScript-Kontexte. Diese Mechanismen dürfen nicht als austauschbare Bezeichnungen behandelt werden.

## Sandbox der Erstellungsplattform

[K1 Z.22](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/01-intro.typ:22>)

Der Betriebskontext der KI-Plattform wird von der Desktop-Zielumgebung abgegrenzt.

**Vorher:**

> Die Zielumgebung stellt völlig andere Anforderungen als die isolierte Sandbox der KI-gestützten Entwicklungsplattform, und die von der Plattform getroffenen Architekturentscheidungen lassen sich nicht unverändert übernehmen.

**Aktueller Vorschlag:**

> Die Desktop-Zielumgebung einschließlich Betriebssystem, Dateisystem und Zugriffsrechten stellt andere Anforderungen als die Sandbox der KI-gestützten Entwicklungsplattform; die von der Plattform getroffenen Architekturentscheidungen lassen sich deshalb nicht unverändert übernehmen.

## Drei unterschiedliche Schutzmechanismen

[K2 Z.34](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:34>)

Prozesstrennung, Sandboxing und Kontextisolation werden einzeln benannt.

**Vorher:**

> Das Framework erzwingt architektonisch keine strikten Vorgaben bezüglich des Prozessdesigns oder der internen Kommunikationsflüsse, sodass die Verantwortung für eine sichere Konfiguration und Prozessisolierung primär bei den Entwickelnden liegt.

**Aktueller Vorschlag:**

> Das Framework erzwingt architektonisch keine strikten Vorgaben bezüglich des Prozessdesigns oder der internen Kommunikationsflüsse, sodass die Verantwortung für eine sichere Konfiguration von Prozesstrennung, Sandboxing und Kontextisolation primär bei den Entwickelnden liegt.

## Prozesstrennung und verfügbare APIs

[K2 Z.37](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:37>)

Der Text beschreibt nun ausdrücklich die Verfügbarkeit von Node.js-APIs im Renderer.

**Vorher:**

> Konfigurationsabhängig lässt sich diese Trennung jedoch aufweichen: Durch Optionen wie `nodeIntegration: true` können native Node.js-APIs unmittelbar innerhalb des Renderers ausgeführt werden.

**Aktueller Vorschlag:**

> Getrennte Prozesse begrenzen für sich genommen noch nicht die verfügbaren Systemzugriffe: Durch Optionen wie `nodeIntegration: true` können Node.js-APIs unmittelbar innerhalb des Renderers ausgeführt werden.

## Sandboxing und mögliche Codeausführung

[K2 Z.45](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:45>)

Wichtigster Punkt: Der alte Satz setzte fehlende Prozesstrennung mit dem Wegfall der Sandbox gleich. Der neue Vorschlag benennt die aktivierte Node.js-Integration und die dadurch deaktivierte Renderer-Sandbox.

**Vorher:**

> Besteht keine strikte Prozesstrennung, entfällt die Schutzwirkung der Chromium-Sandbox: Gelingt es Angreifenden, beispielsweise über Cross-Site Scripting (XSS) oder manipulierte externe Inhalte, Schadcode in den Darstellungsprozess einzuschleusen, kann dies unmittelbar zu _Remote Code Execution_ (RCE) auf Ebene des Host-Betriebssystems führen.

**Aktueller Vorschlag:**

> Ist die Node.js-Integration im Renderer aktiviert, wird dessen Sandboxing deaktiviert. Gelingt es Angreifenden beispielsweise über Cross-Site Scripting (XSS) oder manipulierte externe Inhalte, Schadcode im Renderer auszuführen, können verfügbare Node.js-APIs eine _Remote Code Execution_ (RCE) auf Ebene des Host-Betriebssystems ermöglichen @ElectronSecurity2026.

## Sandboxing und Kontextisolation erklären

[K2 Z.48](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/02-basics.typ:48>)

Die beiden Mechanismen werden getrennt erklärt; CSP und IPC-Prüfungen bleiben eigenständige Maßnahmen.

**Vorher:**

> Zu den zentralen Maßnahmen zählen das Deaktivieren der Node.js-Integration im Renderer, das Erzwingen von _Context Isolation_ und Sandboxing, restriktive Navigations- und Inhaltsrichtlinien (_Content Security Policy_) sowie eine rigorose Validierung sämtlicher IPC-Nachrichten und deren Absender.

**Aktueller Vorschlag:**

> Zu den zentralen Maßnahmen zählen das Deaktivieren der Node.js-Integration im Renderer, das Aktivieren von Sandboxing und _Kontextisolation (Context Isolation)_, restriktive Navigationsregeln und eine _Content Security Policy_ (CSP) sowie die Validierung sämtlicher IPC-Nachrichten und die IPC-Absenderprüfung. Sandboxing beschränkt die Systemzugriffe des Renderer-Prozesses; Kontextisolation trennt den JavaScript-Kontext der Webseite vom Kontext des Preload-Skripts.

## Konkrete Maßnahmen statt Renderer-Isolation

[K4 Z.140](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/04-analysis.typ:140>)

Der Sammelbegriff wird durch Sandboxing, Kontextisolation und deaktivierte Node.js-Integration präzisiert.

**Vorher:**

> Dazu zählen insbesondere Renderer-Isolation, begrenzte privilegierte Schnittstellen, die Prüfung von IPC-Absendern und Eingaben sowie Beschränkungen für nachgeladene Inhalte, Navigation und zusätzliche Fenster @ElectronSecurity2026.

**Aktueller Vorschlag:**

> Dazu zählen insbesondere Sandboxing und Kontextisolation des Renderers bei deaktivierter Node.js-Integration, begrenzte privilegierte Schnittstellen, die IPC-Absenderprüfung und Eingabevalidierung sowie Beschränkungen für nachgeladene Inhalte, Navigation und zusätzliche Fenster @ElectronSecurity2026.

## Prüffrage zu den Einstellungen

[K5 Z.845](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/content/05-migration.typ:845>)

Die Leitfrage nennt die konkret zu prüfenden Einstellungen.

**Vorher:**

> [Sind Renderer und privilegierte Laufzeit durch die Einstellungen für Node-Integration, Kontextisolation und Sandbox getrennt?],

**Aktueller Vorschlag:**

> [Sind die Node.js-Integration im Renderer deaktiviert sowie Sandboxing und Kontextisolation aktiviert?],

## Isolierte Konfiguration

[electron-architecture-comparison.svg Z.19](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:19>)

Die Beschriftung beschreibt eine Konfiguration und vermeidet eine zusätzliche Architekturklasse.

**Vorher:**

> <text x="270" y="35" class="heading">Isolierte Architektur</text>

**Aktueller Vorschlag:**

> <text x="270" y="35" class="heading">Isolierte Konfiguration</text>

## Offene Konfiguration

[electron-architecture-comparison.svg Z.20](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:20>)

„Monolithisch“ wird vermieden: Der Main-Prozess bleibt auch in der offenen Konfiguration vorhanden.

**Vorher:**

> <text x="830" y="35" class="heading">Monolithische Architektur</text>

**Aktueller Vorschlag:**

> <text x="830" y="35" class="heading">Offene Konfiguration</text>

## Kontextisolation in der Abbildung

[electron-architecture-comparison.svg Z.40](<C:/Users/Joshua/Desktop/Desktop App prototype/thesis-template-typst/figures/electron-architecture-comparison.svg:40>)

Die Beschriftung benennt den Mechanismus. Das API-Mittel contextBridge wird dadurch nicht als Synonym eingeführt.

**Vorher:**

> <text x="270" y="353" class="note">Context Isolation / contextBridge</text>

**Aktueller Vorschlag:**

> <text x="270" y="353" class="note">Kontextisolation</text>

## Quellen zur fachlichen Durchsicht

Die Electron-Dokumentation erläutert, dass aktivierte Node.js-Integration die Renderer-Sandbox deaktiviert: [Process Sandboxing](https://www.electronjs.org/docs/latest/tutorial/sandbox). Die Trennung der JavaScript-Kontexte von Webseite und Preload-Skript wird separat erklärt: [Context Isolation](https://www.electronjs.org/docs/latest/tutorial/context-isolation).

Bei der gemeinsamen Durchsicht prüfen wir jeweils die technische Aussage, ihre Verständlichkeit und die Übereinstimmung mit der beschriebenen Konfiguration des Demonstrators. Die Darstellung ist kein zusätzlicher Sicherheitsnachweis der Anwendung.
