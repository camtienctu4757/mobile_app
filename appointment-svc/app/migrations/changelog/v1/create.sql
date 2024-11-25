-- liquibase formatted sql
-- changeset camtien:1
CREATE TABLE roles (
    id_role UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_name VARCHAR(255) NOT NULL
);
-- rollback DROP TABLE roles;

-- changeset camtien:2
CREATE TABLE users (
  user_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone_number VARCHAR(15),
  user_type UUID NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_type) REFERENCES roles(id_role)
);

-- rollback DROP TABLE users; 

-- changeset camtien:3
CREATE TABLE shops (
  shop_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  shop_name VARCHAR(255) NOT NULL,
  owner_id UUID,
  address VARCHAR(255),
  phone VARCHAR(11),
  email VARCHAR(255),
  latitude DECIMAL(9,6),
  longitude DECIMAL(9,6),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  image VARCHAR(255) DEFAULT NULL,
  FOREIGN KEY (owner_id) REFERENCES users(user_uuid)
);
-- rollback DROP TABLE shops;


-- changeset camtien:4
CREATE TABLE catalog (
    catalog_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    catalog_name VARCHAR(255)
);

-- rollback DROP TABLE catalog;


-- changeset camtien:5
CREATE TABLE services (
    service_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    service_name VARCHAR(255) NOT NULL,
    shop_uuid UUID,
    catalog_uuid UUID,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    duration INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (shop_uuid) REFERENCES shops(shop_uuid),
    FOREIGN KEY (catalog_uuid) REFERENCES catalog(catalog_uuid)
);

-- rollback DROP TABLE services;

-- changeset camtien:6
CREATE TABLE files (
    file_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    service_uuid UUID,
    file_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (service_uuid) REFERENCES services(service_uuid)
);

-- rollback DROP TABLE files;


-- changeset camtien:7
CREATE TABLE status(
    id_status UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    status_name VARCHAR(255) NOT NULL
);

CREATE TABLE appointments (
    appointment_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_uuid UUID,
    service_uuid UUID,
    appointment_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_uuid) REFERENCES users(user_uuid),
    FOREIGN KEY (status) REFERENCES status(id_status),
    FOREIGN KEY (service_uuid) REFERENCES services(service_uuid)
    
);

-- rollback DROP TABLE appointments;DROP TABLE status;


-- changeset camtien:8
CREATE TABLE appointment_histories (
    history_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    appointment_uuid UUID,
    status UUID NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_uuid) REFERENCES appointments(appointment_uuid),
    FOREIGN KEY (status) REFERENCES status(id_status)
);
--rollback DROP Table appointment_histories;

