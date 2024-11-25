-- changeset camtien:55

ALTER TABLE files
DROP CONSTRAINT files_service_uuid_fkey;

ALTER TABLE files
ADD CONSTRAINT files_service_uuid_fkey
FOREIGN KEY (service_uuid) REFERENCES services(service_uuid)
ON DELETE CASCADE;


ALTER TABLE services
DROP CONSTRAINT services_shop_uuid_fkey;

ALTER TABLE services
ADD CONSTRAINT services_shop_uuid_fkey
FOREIGN KEY (shop_uuid) REFERENCES shops(shop_uuid)
ON DELETE CASCADE;

ALTER TABLE shops
DROP CONSTRAINT shops_owner_id_fkey;

ALTER TABLE shops
ADD CONSTRAINT shops_owner_id_fkey
FOREIGN KEY (owner_id) REFERENCES users(user_uuid)
ON DELETE CASCADE;


DELETE FROM users
WHERE username IN ('user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7', 'user8', 'user9', 'user10');


UPDATE users
SET firstname = 'Tien';

UPDATE users
SET lastname = 'Nguyen';

UPDATE users
SET phone_number = 'Nguyen';

