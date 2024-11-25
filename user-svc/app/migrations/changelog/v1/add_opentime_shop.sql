-- changeset camtien:10/10/24/11/05

ALTER TABLE shops 
ADD COLUMN open_time TIME NOT NULL DEFAULT '08:00:00',
ADD COLUMN close_time TIME NOT NULL DEFAULT '17:00:00';
UPDATE shops SET open_time = '08:00:00', close_time = '17:00:00';

-- rollback ALTER TABLE shops DROP COLUMN open_time,DROP COLUMN close_time;