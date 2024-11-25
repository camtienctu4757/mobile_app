-- changeset camtien:64
ALTER TABLE employee_absences
RENAME COLUMN employee_uuid TO absences_uuid;

ALTER TABLE employee_absences
ADD COLUMN service_uuid UUID NOT NULL,
ADD COLUMN start_time TIMESTAMP NOT NULL,
ADD COLUMN end_time TIMESTAMP NOT NULL;

ALTER TABLE employee_absences
ADD CONSTRAINT fk_service_uuid
FOREIGN KEY (service_uuid) REFERENCES services(service_uuid);