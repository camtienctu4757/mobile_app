-- changeset camtien:10/10/24/10/44
ALTER TABLE user_files 
RENAME COLUMN name TO file_name;

ALTER TABLE user_files 
ADD COLUMN user_uuid UUID;

ALTER TABLE user_files 
ADD CONSTRAINT fk_user_uuid FOREIGN KEY (user_uuid) REFERENCES users(user_uuid);

-- rollback: ALTER TABLE user_files DROP CONSTRAINT IF EXISTS fk_user_uuid; ALTER TABLE user_files DROP COLUMN user_uuid;ALTER TABLE user_files RENAME COLUMN file_name TO name;
