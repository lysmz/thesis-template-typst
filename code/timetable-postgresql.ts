import {
  pgTable, serial, text, integer, boolean, pgEnum
} from "drizzle-orm/pg-core";

export const weekDayEnum = pgEnum("week_day", [
  "monday", "tuesday", "wednesday", "thursday", "friday"
]);
export const timeSlotEnum = pgEnum("time_slot", [
  "slot1", "slot2", "slot3", "slot4", "slot5", "slot6"
]);

export const timetableEntriesTable = pgTable("timetable_entries", {
  id: serial("id").primaryKey(),
  courseName: text("course_name").notNull(),
  weekDay: weekDayEnum("week_day").notNull(),
  timeSlot: timeSlotEnum("time_slot").notNull(),
  room: text("room"),
  professor: text("professor"),
  isCustom: boolean("is_custom").notNull().default(true),
  color: text("color"),
  userId: integer("user_id").notNull(),
});
