-- changeset camtien:9
INSERT INTO roles (role_name) VALUES 
  ('ShopOwner'),
  ('Normal');
-- rollback DELETE FROM roles WHERE role_name IN ('ShopOwner', 'Normal');
