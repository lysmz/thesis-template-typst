const fs=require('node:fs');const path=require('node:path');
const root=path.resolve(__dirname,'../..');const edits=new Map();const missing=[];
function replace(file,a,b){let text=edits.has(file)?edits.get(file):fs.readFileSync(path.join(root,file),'utf8');if(!text.includes(a)){missing.push(file+': '+a);return;}edits.set(file,text.replaceAll(a,b));}
function chapter(n){return 'content/'+['01-intro.typ','02-basics.typ','03-method.typ','04-analysis.typ','05-migration.typ','06-evaluation.typ','07-discussion.typ'][n-1];}
replace(chapter(4),'an die lokale Laufzeit anpassen','an die Electron-Laufzeit anpassen');
replace(chapter(4),'kann ihre Übernahme und Anpassung an die lokale Laufzeit untersucht werden','kann ihre Übernahme und Anpassung an die Electron-Laufzeit untersucht werden');
replace(chapter(5),'Auslieferung der Migrationsdateien','Auslieferung der SQL-Migrationsdateien');
replace(chapter(5),'die damit erzeugten Hooks, Typen','die damit erzeugten React-Query-Hooks, Typen');
replace(chapter(5),'für Client, Hooks und Zod-Laufzeitschemata','für Client, React-Query-Hooks und Zod-Laufzeitschemata');
replace(chapter(5),'Im letzten Schritt formatiert der Generator','Im letzten Schritt formatiert der IPC-Codegenerator');
replace(chapter(5),'Der Generator verwendet OpenAPI','Der IPC-Codegenerator verwendet OpenAPI');
replace(chapter(5),'Der Generator deckt bewusst','Der IPC-Codegenerator deckt bewusst');
replace(chapter(5),'Da der Codegenerator die Schnittstellensignaturen','Da der IPC-Codegenerator die Schnittstellensignaturen');
replace(chapter(7),'Der eigene Generator hält','Der IPC-Codegenerator hält');
replace(chapter(5),'Supabase stellt die PostgreSQL-Datenbank für den gemeinsamen Gruppenbestand','Die Supabase-PostgreSQL-Datenbank speichert den gemeinsamen Gruppenbestand; Supabase stellt außerdem');
// Die vorherige Ersetzung bewahrt das Satzende und wird grammatisch vervollständigt.
replace(chapter(5),'Supabase stellt außerdem sowie die Authentifizierung','Supabase stellt außerdem die Authentifizierung');
replace(chapter(5),'die Content Security Policy (CSP)','die CSP');
replace(chapter(5),'Durchführung und Prüfkriterien der Laufzeitversuche','Durchführung und Prüfkriterien der manuellen Laufzeitversuche');
replace(chapter(6),'und ausgewählte Laufzeitversuche ergänzt','und ausgewählte manuelle Laufzeitversuche ergänzt');
replace(chapter(6),'Die ausgewählten Sicherheitsversuche verliefen erfolgreich','Die ausgewählten manuellen Laufzeitversuche verliefen erfolgreich');
replace(chapter(5),'eine eigene Toolchain entwickelt','eine eigene Toolchain für den IPC-Codegenerator entwickelt');
replace(chapter(5),'die zentrale Vertragsgrundlage beibehalten','der zentrale OpenAPI-Vertrag beibehalten');
replace(chapter(5),'übersetzt die Vertragsbeschreibung während der Entwicklung','übersetzt den OpenAPI-Vertrag während der Entwicklung');
// Feste Fachbegriffe nur an den konkreten Beschriftungen präzisieren.
replace('figures/api-interface-migration.svg','API-Vertrag als gemeinsame Ausgangsbasis','OpenAPI-Vertrag als gemeinsame Ausgangsbasis');
replace('figures/api-interface-migration.svg','<text x="1135" y="350" class="note">und Zod-Laufzeitschemata</text>','<text x="1135" y="350" class="note" style="font-size: 22px">Zod-Laufzeitschemata</text>');
replace('figures/api-interface-migration.svg','<text x="475" y="350" class="note">Zod-Laufzeitschemata</text>','<text x="475" y="350" class="note" style="font-size: 22px">Zod-Laufzeitschemata</text>');
replace('figures/api-interface-migration.svg','Fachliche Logik und Datenzugriff','Geschäftslogik und Datenzugriff');
replace('figures/grades-crud-flow.svg','<text x="240" y="667" class="heading">Benutzeroberfläche aktualisieren</text>','<text x="240" y="667" class="heading" style="font-size: 24px">Benutzeroberfläche aktualisieren</text>');
replace('figures/collaboration-modules.svg','<text x="890" y="970" class="note">Upload-Warteschlange</text>','<text x="890" y="955" class="note" style="font-size: 12px"><tspan x="890">Upload-</tspan><tspan x="890" dy="15">Warteschlange</tspan></text>');
replace('figures/collaboration-modules.svg','<text x="240" y="811">Repositories / Drizzle ORM</text>','<text x="240" y="811" style="font-size: 25px">Repositories / Drizzle ORM</text>');
replace('figures/collaboration-modules.svg','<text x="675" y="997">Kollaborationsdatenbank</text>','<text x="675" y="997" style="font-size: 25px">Lokale Kollaborationsdatenbank</text>');
replace('figures/collaboration-modules.svg','Generierter API-Vertrag','Generierter OpenAPI-Vertrag');
replace('figures/collaboration-modules.svg','Eigener Modulvertrag, Zod-Prüfung und lokale Sitzung','Kollaborationsvertrag und Supabase-Kollaborationssitzung');
replace('figures/collaboration-modules.svg','Drizzle-Kit-Migrationen','SQL-Migrationsdateien');
replace('figures/local-first-architecture.svg','<text x="970" y="686" class="heading">Kollaborationsdatenbank</text>','<text x="970" y="680" class="heading" style="font-size: 24px"><tspan x="970">Lokale</tspan><tspan x="970" dy="28">Kollaborationsdatenbank</tspan></text>');
replace('figures/local-first-architecture.svg','<text x="970" y="722">Kollaborationsdatenbestand</text>','<text x="970" y="735" style="font-size: 20px">Lokaler Kollaborationsdatenbestand</text>');
replace('figures/local-first-architecture.svg','<text x="970" y="754" class="note">Datei je entfernter Identität</text>','<text x="970" y="756" class="note" style="font-size: 20px">Datei je Supabase-Benutzerkonto</text>');
replace('figures/local-first-architecture.svg','<text x="230" y="686" class="heading">Lokale Kerndatenbank</text>','<text x="230" y="686" class="heading" style="font-size: 25px">Lokale Kerndatenbank</text>');
replace('figures/local-first-architecture.svg','Drizzle-Kit-Migrationen','SQL-Migrationsdateien');
replace('figures/local-first-architecture.svg','React-Oberfläche','React-Benutzeroberfläche');
replace('figures/original-web-architecture.svg','React-Oberfläche','React-Benutzeroberfläche');
replace('figures/original-web-architecture.svg','API-Vertrag und Codegenerierung','OpenAPI-Vertrag und Codegenerierung');
replace('figures/original-web-architecture.svg','Authentifizierung · Session · Zod','Authentifizierung · HTTP-Sitzung · Zod');
replace('figures/electron-architecture-comparison.svg','Isolierte Architektur','Isolierte Konfiguration');
replace('figures/electron-architecture-comparison.svg','Monolithische Architektur','Offene Konfiguration');
replace('figures/electron-architecture-comparison.svg','Context Isolation / contextBridge','Kontextisolation');
// Nur am tatsächlich bearbeiteten Text anhängende Leerzeichen entfernen.
for(const [file,text]of edits)edits.set(file,text.replace(/[ \t]+(?=\r?$)/gmu,''));
const baseline=JSON.parse(fs.readFileSync(path.join(__dirname,'vor-umsetzung-2026-11-12.json'),'utf8'));
for(const file of fs.readdirSync(path.join(root,'content')).filter(n=>/^0[1-7]-/.test(n))){const p='content/'+file;const text=edits.get(p)||fs.readFileSync(path.join(root,p),'utf8');const old=baseline.find(d=>d.file===p).text.split(/\r?\n/);const eol=text.includes('\r\n')?'\r\n':'\n';edits.set(p,text.split(/\r?\n/).map((line,i)=>line===old[i]?line:line.replace(/[ \t]+$/u,'')).join(eol));}
if(missing.length)throw Error('Fehlende Kontexte: '+missing.join('\n'));
for(const [file,text]of edits)fs.writeFileSync(path.join(root,file),text,'utf8');
console.log(edits.size+' Dateien nachgeprüft.');
