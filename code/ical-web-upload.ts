const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 10 * 1024 * 1024 }
});

router.post("/events/import-ical", requireAuth, upload.single("file"),
  async (req, res): Promise<void> => {
    if (!req.file) {
      res.status(400).json({ error: "Keine Datei hochgeladen" });
      return;
    }

    const userId = req.session.userId!;
    const icsText = req.file.buffer.toString("utf-8");

    let parsed: ReturnType<typeof parseICS>;
    try {
      parsed = parseICS(icsText);
    } catch {
      res.status(400).json({ error: "Ungültige ICS-Datei" });
      return;
    }

    // Weitere Verarbeitung im selben Route-Handler ausgelassen:
    // VEVENT-Einträge abbilden, Termine und Aktivität speichern,
    // angelegte Termine als JSON zurückgeben.
  }
);
