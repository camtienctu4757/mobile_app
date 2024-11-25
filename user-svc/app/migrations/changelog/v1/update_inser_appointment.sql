-- changset camtien:58
ALTER TABLE appointments
DROP COLUMN start_time,
DROP COLUMN end_time;

ALTER TABLE appointments
ADD COLUMN timeslot_uuid UUID;

ALTER TABLE appointments
ADD CONSTRAINT fk_timeslot
FOREIGN KEY (timeslot_uuid) REFERENCES time_slots(slot_uuid);

-- rollback ALTER TABLE appointments DROP FOREIGN KEY fk_timeslot;ALTER TABLE appointments ADD COLUMN start_time DATETIME,ADD COLUMN end_time DATETIME;

