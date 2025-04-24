-- to create an index on date rather than date time, which is way too specific
alter table booking add booking_slot_date date generated always as (date(booking_slot)) stored;


-- index reason: when calling procedure is_table_booked (date, table_number), 
-- rather than checking the entire bookings table, we focus on bookings of only the required date, then we check if the required table is occupied on that date
alter table booking add index index_booking_slot_date (booking_slot_date);