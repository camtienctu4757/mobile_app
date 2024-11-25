-- changeset camtien:17
ALTER TABLE files
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- rollback ALTER TABLE files DROP COLUMN created_at;

-- changeset camtien:18
ALTER TABLE users
ADD COLUMN image VarChar(255) DEFAULT NULL;

-- rollback ALTER TABLE users DROP COLUMN image;

-- changeset camtien:19
ALTER TABLE files 
DROP COLUMN file_name;
ALTER TABLE files 
ADD COLUMN url VARCHAR(255) NOT NULL;

-- rollback ALTER TABLE files ADD COLUMN file_name VARCHAR(255); ALTER TABLE files DROP COLUMN url;

-- changeset camtien:20
INSERT INTO files (service_uuid, url) VALUES 
((SELECT service_uuid FROM services WHERE service_name = 'Haircut'), 'assets/images/sp1.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Manicure'), 'assets/images/sp2.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Facial Treatment'), 'assets/images/sp3.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Body Massage'), 'assets/images/sp4.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Makeup Application'), 'assets/images/sp5.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Lip Fillers'), 'assets/images/sp6.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Pedicure'), 'assets/images/sp7.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Hair Coloring'), 'assets/images/sp8.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Bridal Makeup'), 'assets/images/sp9.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'mới update name nè'), 'assets/images/sp10.jpg');

-- rollback DELETE FROM files WHERE service_uuid IN (SELECT service_uuid FROM services WHERE service_name IN ('Haircut','Manicure','Facial Treatment','Body Massage','Makeup Application','Lip Fillers','Pedicure','Hair Coloring','Bridal Makeup','mới update name nè'))AND url IN ('assets/images/sp1.jpg','assets/images/sp2.jpg','assets/images/sp3.jpg','assets/images/sp4.jpg','assets/images/sp5.jpg','assets/images/sp6.jpg','assets/images/sp7.jpg','assets/images/sp8.jpg','assets/images/sp9.jpg','assets/images/sp10.jpg');

-- changeset camtien:22
INSERT INTO files (service_uuid, url) VALUES 
((SELECT service_uuid FROM services WHERE service_name = 'Haircut'), 'assets/images/sp1.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Manicure'), 'assets/images/sp2.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Facial Treatment'), 'assets/images/sp3.jpg'),
((SELECT service_uuid FROM services WHERE service_name = 'Body Massage'), 'assets/images/sp4.jpg');
-- rollback DELETE FROM files WHERE service_uuid IN (SELECT service_uuid FROM services WHERE service_name IN ('Haircut','Manicure','Facial Treatment','Body Massage');
