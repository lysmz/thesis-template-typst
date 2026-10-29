//---------------------------------------------------------------------
= Projektstruktur des Webprototyps <app:web-prototype-filetree>
//---------------------------------------------------------------------

Der folgende Dateibaum zeigt eine gekürzte Übersicht des Repositories `Student-Study-Hub`.
Auslassungen sind durch `...` gekennzeichnet.

#block(
  width: 100%,
  inset: 8pt,
  fill: luma(246),
  radius: 2pt,
)[
  #show raw: set text(font: "Consolas", size: 7.5pt)
  ```text
  Student-Study-Hub/
  ├── artifacts/
  │   ├── studienplaner/              # React-Weboberfläche
  │   │   └── src/
  │   │       ├── pages/              # Dashboard, Kalender, Noten, Gruppen …
  │   │       ├── components/         # Layout und UI-Komponenten
  │   │       ├── App.tsx             # Routing und Anwendungsaufbau
  │   │       ├── main.tsx            # Frontend-Einstiegspunkt
  │   │       ├── ...
  │   ├── api-server/                 # Express-Backend
  │   │   └── src/
  │   │       ├── routes/             # HTTP-Endpunkte und Verarbeitung
  │   │       ├── middlewares/        # Unter anderem Authentifizierung
  │   │       ├── app.ts              # Express-Konfiguration
  │   │       └── index.ts            # Serverstart
  │   └── ...
  ├── lib/
  │   ├── db/
  │   │   ├── src/schema/             # Drizzle-Datenbankschema
  │   │   └── drizzle.config.ts
  │   ├── api-spec/
  │   │   ├── openapi.yaml            # Gemeinsamer API-Vertrag
  │   │   └── orval.config.ts         # Codegenerierung
  │   ├── api-client-react/           # Generierter Client und Query-Hooks
  │   └── api-zod/                    # Generierte Validierungsschemata
  ├── package.json
  └── pnpm-workspace.yaml
  ```
]
