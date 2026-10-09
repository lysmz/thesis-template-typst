import { sqliteTable, integer, text } from 'drizzle-orm/sqlite-core'

export const weekDays = [
  'monday', 'tuesday', 'wednesday', 'thursday', 'friday'
] as const
export type WeekDay = (typeof weekDays)[number]

export const timeSlots = [
  'slot1', 'slot2', 'slot3', 'slot4', 'slot5', 'slot6'
] as const
export type TimeSlot = (typeof timeSlots)[number]

export const timetableEntriesTable = sqliteTable('timetable_entries', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  courseName: text('course_name').notNull(),
  weekDay: text('week_day', { enum: weekDays }).notNull(),
  timeSlot: text('time_slot', { enum: timeSlots }).notNull(),
  room: text('room'),
  professor: text('professor'),
  isCustom: integer('is_custom', { mode: 'boolean' })
    .notNull().default(true),
  color: text('color'),
  userId: integer('user_id').notNull()
})
