-- changset camtien:58
INSERT INTO status (status_name) VALUES 
    ('pending'),
    ('cancle'),
    ('success');

-- rollback DELETE FROM status WHERE status_name IN ('pending', 'cancle', 'success');

