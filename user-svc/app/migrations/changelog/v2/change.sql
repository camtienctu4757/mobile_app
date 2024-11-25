-- liquibase formatted sql
-- changeset camtien:10/15/24/7/21
CREATE TABLE roles (
    role_uuid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_name VARCHAR(255) NOT NULL
);

CREATE TABLE users (
  user_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone_number VARCHAR(15),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  firstname VARCHAR(100),
  lastname VARCHAR(100)
  is_enabled = Boolean DEFAULT True NOT NULL
);


CREATE TABLE user_roles(
role_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
user_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
FOREIGN KEY (role_uuid) REFERENCES roles(id_role),
FOREIGN KEY (user_uuid) REFERENCES users(user_uuid)
);

-- rollback DROP TABLE user_roles; DROP TABLE users; DROP TABLE roles;

-- changeset camtien:10/15/24/7/28
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
  FOREIGN KEY (owner_id) REFERENCES users(user_uuid)
);

CREATE TABLE catalog (
    catalog_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    catalog_name VARCHAR(255)
);

CREATE TABLE services (
    service_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    service_name VARCHAR(255) NOT NULL,
    shop_uuid UUID,
    catalog_uuid UUID,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    duration INT,
    employees INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (shop_uuid) REFERENCES shops(shop_uuid),
    FOREIGN KEY (catalog_uuid) REFERENCES catalog(catalog_uuid)
);
-- rollback DROP TABLE services; DROP TABLE catalog;DROP TABLE shops;

-- changeset camtien:10/15/24/7/31
CREATE TABLE service_files(
    file_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    service_uuid UUID,
    file_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (service_uuid) REFERENCES services(service_uuid)
);
CREATE TABLE shop_files(
    file_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    shop_uuid UUID,
    file_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (shop_uuid) REFERENCES shops(shop_uuid)
);
CREATE TABLE user_files(
    file_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_uuid UUID,
    file_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_uuid) REFERENCES users(user_uuid)
);

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

-- rollback  DROP TABLE appointments;DROP TABLE status; DROP TABLE user_files;DROP TABLE shop_files;DROP TABLE service_files;

-- changeset camtien:10/15/27/7/40

    CREATE TABLE employee_absences(
    absences_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    absence_date DATE NOT NULL,
    reason VARCHAR(255),
    service_uuid UUID,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (service_uuid) REFERENCES services(service_uuid)
    );
    CREATE TABLE time_slots (
        slot_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
        service_uuid UUID,
        start_time TIME NOT NULL,
        end_time TIME NOT NULL,
        available_employees INT NOT NULL,
        slot_date Date NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (service_uuid) REFERENCES services(service_uuid)
    )
    
    CREATE TABLE appointments(
    appointment_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_uuid UUID,
    appointment_date DateTime
    status UUID,
    timeslot_uuid UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_uuid) REFERENCES users(user_uuid),
    FOREIGN KEY (timeslot_uuid) REFERENCES time_slots(slot_uuid)
    );
    
-- rollback DROP TABLE appointments; DROP TABLE time_slots; DROP TABLE employee_absences;


