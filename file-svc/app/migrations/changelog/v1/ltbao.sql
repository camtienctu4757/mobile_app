-- liquibase formatted sql

-- changeset ltbao:1
CREATE TABLE service_files (
  file_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  file_name VARCHAR(255) NOT NULL,
  service_id UUID DEFAULT gen_random_uuid(),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   FOREIGN KEY (service_id) REFERENCES services(service_id)
);
-- rollback DROP TABLE service_files;