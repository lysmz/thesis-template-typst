//---------------------------------------------------------------------
= Ursprüngliche Erstellungs-Prompts <app:creation-prompts>
//---------------------------------------------------------------------

Dieser Anhang dokumentiert die beiden ursprünglichen Prompts, mit denen der Replit-Webprototyp Studienplaner erstellt und um Studiengruppen erweitert wurde.
Die Prompts werden im ursprünglichen Wortlaut wiedergegeben.
Überschriften und Absatzdarstellung wurden für den Anhang angepasst.

Die Prompts belegen die Beschreibung von Funktionen und Nutzungsszenarien ohne Festlegung eines UI-Frameworks oder einer konkreten technischen Architektur.
Sie enthalten zugleich Anforderungen an Anmeldung, Zugriffsschutz und die Trennung persönlicher und gemeinsamer Inhalte.
Der ursprünglich gewünschte Funktionsumfang ist von dem in @ch:analysis festgelegten Untersuchungsumfang zu unterscheiden; insbesondere begründet der im zweiten Prompt genannte Gerätewechsel keine Erweiterung des Migrations- oder Evaluationsumfangs dieser Arbeit.

#let prompt-source = read("sources/original-creation-prompts.txt").replace("\r\n", "\n")
#let prompts = prompt-source.split("[Prompt 2]")

#let display-prompt(value) = block(
  inset: (left: 10pt, right: 5pt),
  stroke: (left: 0.6pt + luma(160)),
  breakable: true,
  {
    set par(justify: false)
    for paragraph in value.trim().split("\n\n") {
      par({
        for (index, line) in paragraph.split("\n").enumerate() {
          if index > 0 { linebreak() }
          text(line)
        }
      })
    }
  },
)

== Prompt 1: Persönliche Studienorganisation <app:prompt-initial>

#display-prompt(prompts.at(0))

#pagebreak()

== Prompt 2: Studiengruppen und Zusammenarbeit <app:prompt-groups>

#display-prompt(prompts.at(1))
