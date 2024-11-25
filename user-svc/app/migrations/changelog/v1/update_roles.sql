-- changeset camtien:50
ALTER TABLE services
ADD COLUMN employees Int DEFAULT 5;

-- rollback ALTER TABLE services DROP COLUMN employees;

-- changeset camtien:51
CREATE TABLE time_slots (
    slot_uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    service_uuid UUID,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    available_employees INT NOT NULL,
    slot_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (service_uuid) REFERENCES services(service_uuid)
);
-- rollback DROP TABLE IF EXISTS time_slots;

-- changeset camtien:52
CREATE TABLE employee_absences (
    employee_uuid UUID DEFAULT gen_random_uuid(),
    absence_date DATE,
    reason VARCHAR(255),
    PRIMARY KEY (employee_uuid, absence_date)
);
-- rollback DROP TABLE IF EXISTS employee_absences;

-- changeset camtien:53
ALTER TABLE roles 
RENAME COLUMN id_role TO role_uuid;

CREATE TABLE user_roles (
    user_uuid UUID DEFAULT gen_random_uuid(),
    role_uuid UUID DEFAULT gen_random_uuid(),
    PRIMARY KEY (user_uuid, role_uuid),
    FOREIGN KEY (user_uuid) REFERENCES users(user_uuid) ON DELETE CASCADE,
    FOREIGN KEY (role_uuid) REFERENCES roles(role_uuid) ON DELETE CASCADE
);
DELETE FROM roles
WHERE role_name IN ('Normal', 'ShopOwner');

INSERT INTO roles (role_name)
VALUES ('admin'),
       ('public');

-- rollback DROP TABLE IF EXISTS user_roles;DELETE FROM roles WHERE role_name IN ('admin', 'public');INSERT INTO roles (role_name)VALUES ('Normal'),('ShopOwner');ALTER TABLE roles RENAME COLUMN role_uuid TO id_role;


-- changeset camtien:54
ALTER TABLE users
ADD COLUMN firstname VARCHAR(255),
ADD COLUMN lastname VARCHAR(255);

UPDATE users
SET firstname = 'Tien', lastname = 'Nguyen'
WHERE user_uuid = '76cd955e-b301-4cb8-81e8-0fc4f14a69cd';

UPDATE users
SET firstname = 'Tien', lastname = 'Nguyen'
WHERE user_uuid = '3eb768ba-0c53-4f4c-8d94-598db230b090';

-- rollback UPDATE users SET firstname = NULL, lastname = NULL WHERE user_id IN ('3eb768ba-0c53-4f4c-8d94-598db230b090', '76cd955e-b301-4cb8-81e8-0fc4f14a69cd');ALTER TABLE usersDROP COLUMN firstname,DROP COLUMN lastname;


