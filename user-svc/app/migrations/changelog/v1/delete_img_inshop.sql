-- changeset camtien:10/10/24/11/10
ALTER TABLE users 
DROP COLUMN image;

ALTER TABLE shops 
DROP COLUMN image;

-- rollback ALTER TABLE users ADD COLUMN image VARCHAR(255); ALTER TABLE shops ADD COLUMN image VARCHAR(255);  