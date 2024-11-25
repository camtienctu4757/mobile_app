-- changeset camtien:57
ALTER TABLE users
ADD COLUMN is_enabled BOOLEAN DEFAULT True;