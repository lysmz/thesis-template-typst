export const spikeEventsTable = sqliteTable('spike_events', {
  id: text('id').primaryKey().notNull(),
  ownerId: text('owner_id').notNull(),
  title: text('title').notNull(),
  startDate: text('start_date').notNull(),
  endDate: text('end_date').notNull(),
  isMultiDay: integer('is_multi_day', { mode: 'boolean' })
    .notNull()
  // Weitere Felder und Indizes weggelassen.
})

export const powerSyncDrizzleSchemaDefinition = {
  spikeEventsTable
}
export const powerSyncDrizzleSchema =
  new DrizzleAppSchema(powerSyncDrizzleSchemaDefinition)
