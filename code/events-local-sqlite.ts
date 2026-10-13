export const eventsTable = sqliteTable('events', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  title: text('title').notNull(),
  startDate: integer('start_date', { mode: 'timestamp' })
    .notNull(),
  endDate: integer('end_date', { mode: 'timestamp' })
    .notNull(),
  isMultiDay: integer('is_multi_day', { mode: 'boolean' })
    .notNull().default(false),
  userId: integer('user_id').notNull()
  // Weitere Felder weggelassen.
})
