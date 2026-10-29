/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "styles/ohm.typ" : thesis, appendix

#show: thesis.with(
  type: "bachelor",
  title: [Systematische Transformation KI-generierter Web-Architekturen in sichere, lokale Desktop-Anwendungen unter Anwendung des Local-First-Paradigmas],
  author: "Joshua Ohans",
  student-id: none,
  lang: "de",
  examiners: (
    [Prof. Dr. Matthias Teßmann],
    [Prof. Dr. Ronald Petrlic],
  ),
  supervisors: none,
  acknowledgements: none,
  abstract: none,
  glossary: yaml("glossary.yaml"),      // Glossary entries and acronyms (from external file)
  bibliography-file: "refs.bib",    // Bibliography file for referencing
  bibliography-style: "ieee",           // Citation style (see Typst docs), 'alphanumeric' supported
  header: "chapter",
)

#include "content/01-intro.typ"
#include "content/02-basics.typ"
#include "content/03-method.typ"
#include "content/04-analysis.typ"
#include "content/05-migration.typ"
#include "content/06-evaluation.typ"
#include "content/07-discussion.typ"
#include "content/08-summary.typ"

#show: appendix                         // Switch from main content to appendix

#include "content/A1-supplemental.typ"  // Same as with main content

#include "content/A2-project-structure.typ"
