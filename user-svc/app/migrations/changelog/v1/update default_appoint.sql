-- changeset camtien:14/10/24/8/57
CREATE OR REPLACE FUNCTION set_default_status()
RETURNS TRIGGER AS $$
BEGIN
    -- Thiết lập giá trị cho status dựa trên truy vấn
    NEW.status := (SELECT id_status FROM status WHERE status_name = 'pending' LIMIT 1);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER appointment_set_default_status
BEFORE INSERT ON appointments
FOR EACH ROW
EXECUTE FUNCTION set_default_status();

ALTER TABLE appointments
ALTER COLUMN status DROP DEFAULT;

--rollback DROP TRIGGER IF EXISTS appointment_set_default_status ON appointments;DROP FUNCTION IF EXISTS set_default_status();ALTER TABLE appointments ALTER COLUMN status SET DEFAULT '39c8f365-5533-4453-a866-ac4da784876d';