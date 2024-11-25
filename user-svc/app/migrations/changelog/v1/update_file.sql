-- changeset camtien:16
ALTER TABLE files
ADD COLUMN created_at UUID,
ADD CONSTRAINT fk_service
FOREIGN KEY (service_id)
REFERENCES services(service_uuid);
  DEFAULT CURRENT_TIMESTAMP
-- rollback ALTER TABLE files DROP CONSTRAINT fk_service;ALTER TABLE files DROP COLUMN service_id;

