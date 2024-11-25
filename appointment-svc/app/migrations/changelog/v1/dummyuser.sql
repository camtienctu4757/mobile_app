-- changeset camtien:10
ALTER TABLE users
DROP COLUMN user_type;
-- rollback ALTER TABLE users ADD COLUMN user_type UUID NOT NULL;
-- changeset camtien:11
INSERT INTO users (username, password, email, phone_number, created_at, updated_at) VALUES
('user1', 'password1', 'user1@example.com', '1234567890', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user2', 'password2', 'user2@example.com', '2345678901', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user3', 'password3', 'user3@example.com', '3456789012', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user4', 'password4', 'user4@example.com', '4567890123', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user5', 'password5', 'user5@example.com', '5678901234', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user6', 'password6', 'user6@example.com', '6789012345', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user7', 'password7', 'user7@example.com', '7890123456', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user8', 'password8', 'user8@example.com', '8901234567', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user9', 'password9', 'user9@example.com', '9012345678', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user10', 'password10', 'user10@example.com', '0123456789', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--rollback DELETE FROM users WHERE username IN ('user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7', 'user8', 'user9', 'user10');
