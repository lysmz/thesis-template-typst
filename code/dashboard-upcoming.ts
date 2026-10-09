router.get("/dashboard/upcoming", requireAuth, async (req, res): Promise<void> => {
  const userId = req.session.userId!;
  const now = new Date();
  const in7Days = new Date(now.getTime() + 7 * 24 * 60 * 60 * 1000);

  const events = await db
    .select()
    .from(eventsTable)
    .where(
      and(
        eq(eventsTable.userId, userId),
        gte(eventsTable.startDate, now),
        lte(eventsTable.startDate, in7Days),
      ),
    )
    .orderBy(eventsTable.startDate);

  res.json(events);
});
