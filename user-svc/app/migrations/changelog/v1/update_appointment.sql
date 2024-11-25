-- chageset camtien:12/10/24/08/46
ALTER TABLE appointments
DROP COLUMN service_uuid;

-- rollback ALTER TABLE appointments ADD COLUMN service_uuid UUID;


