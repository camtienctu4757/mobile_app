-- liquibase formatted sql

-- changeset ltbao:1
<<<<<<< HEAD
CREATE TABLE product_test (product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name VARCHAR(255));
=======
<<<<<<< HEAD
CREATE TABLE products (product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name VARCHAR(255));
=======
CREATE TABLE product_test (product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name VARCHAR(255));
>>>>>>> camtienv6
>>>>>>> camtienv7
-- rollback DROP TABLE products;
-- changeset ltbao:2
INSERT INTO products (name) VALUES ('join');
-- rollback delete from products where product_id='1';
-- changeset ltbao:3
INSERT INTO products (name) VALUES ('join1');
-- rollback delete from products where product_id='2';