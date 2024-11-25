-- changeset camtien:17
ALTER TABLE files
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

-- rollback ALTER TABLE files DROP COLUMN created_at;