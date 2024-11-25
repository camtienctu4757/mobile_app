-- chageset camtien:14/10/24/7/49
ALTER TABLE appointments
DROP COLUMN appointment_date;

-- rollback ALTER TABLE appointments ADD COLUMN service_uuid UUID;

-- changset camtien:14/10/24/7/51
ALTER TABLE appointments
ALTER COLUMN status SET DEFAULT '39c8f365-5533-4453-a866-ac4da784876d';

-- rollback ALTER TABLE appointments ALTER COLUMN status DROP DEFAULT;

