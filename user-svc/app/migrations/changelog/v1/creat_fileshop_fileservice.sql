-- changeset camtien:10/10/24/10/32
ALTER TABLE files
DROP COLUMN service_uuid;

ALTER TABLE files RENAME TO user_files;
ALTER TABLE user_files RENAME COLUMN url TO name;

CREATE TABLE shop_files (
    file_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    shop_uuid UUID,
    file_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (shop_uuid) REFERENCES shops(shop_uuid)
);
CREATE TABLE service_files (
    file_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    service_uuid UUID,
    file_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (service_uuid) REFERENCES services(service_uuid)
);
-- rollback DROP TABLE IF EXISTS service_files; DROP TABLE IF EXISTS shop_files;ALTER TABLE user_files RENAME TO files;ALTER TABLE files RENAME COLUMN name TO url;ALTER TABLE files ADD COLUMN service_uuid UUID; 