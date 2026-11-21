//---------------------------------------------------------------------
= Manuelle Laufzeitversuche mit den DevTools <app:devtools-pruefungen>
//---------------------------------------------------------------------

Dieser Anhang dokumentiert die drei DevTools-Prüffälle zur Eingabevalidierung, Textdarstellung und CSP aus @sec:security-evaluation.
Die verwendeten Befehle sind für die Darstellung gekürzt und formatiert.

#show raw.where(block: true): it => block(
  width: 100%,
  breakable: false,
  inset: 8pt,
  fill: luma(246),
  radius: 2pt,
  text(size: 8.5pt, it),
)

== P1 – Eingabevalidierung

Der erste Aufruf übergibt eine ungültige Terminkennung an die API-Preload-Schnittstelle.
Der zweite übergibt eine ungültige Gruppenkennung an die Kollaborations-Preload-Schnittstelle.

```javascript
const api = await window.apiTransport.invoke('getEvent', {
  path: { id: 'not-a-number' }
});
console.log('BA-P1-API', api.ok, api.error?.code);
// false, VALIDATION_ERROR

const collab = await window.collaborationTransport.invoke('createTask', {
  groupId: 'not-a-uuid',
  title: 'BA-Sicherheitsprüfung P1'
});
console.log('BA-P1-COLLAB', collab.ok, collab.error?.code);
// false, INVALID
```

#pagebreak(weak: true)

== P2 – Textdarstellung

Der HTML-artige Aufgabentitel wurde manuell gespeichert.
Im Ausschnitt steht `title` für den exakten Aufgabentitel aus dem Prüffall.

```javascript
function baP2Inspect(title) {
  const matches = [...document.querySelectorAll('[role="tabpanel"] p')]
    .filter(node => node.textContent === title);
  const node = matches[0];

  return {
    matches: matches.length,
    childNodeTypes: node ? [...node.childNodes].map(n => n.nodeType) : [],
    svgInTitle: node?.querySelectorAll('svg').length,
    markerIsUndefined:
      document.documentElement.dataset.baSecurityMarker === undefined
  };
}

console.log('BA-P2-INITIAL', baP2Inspect(title));
// Aufgabe schließen und erneut öffnen.
console.log('BA-P2-REOPENED', baP2Inspect(title));
```

Bei beiden Prüfungen wurde genau ein Treffer mit einem Textknoten (`childNodeTypes: [3]`) gefunden.
Es gab kein SVG-Element im Titel und der Marker blieb undefiniert.

== P3 – CSP

Der Renderer meldete beim Versuch, ein Skript aus einer fremden Quelle zu laden, ein `securitypolicyviolation`-Ereignis.

```javascript
const baCspListener = event => {
  console.log('BA-P3-CSP', event.effectiveDirective, event.blockedURI);
};
document.addEventListener('securitypolicyviolation', baCspListener);

const baCspScript = document.createElement('script');
baCspScript.src = 'https://ba-security.invalid/marker.js';
document.head.appendChild(baCspScript);

// BA-P3-CSP script-src-elem https://ba-security.invalid/marker.js
```

Die Konsole meldete, dass `script-src 'self'` den Ladeversuch blockierte.
Die Ausgabe `script-src-elem` bezeichnet die für das Skriptelement gemeldete Direktive.
