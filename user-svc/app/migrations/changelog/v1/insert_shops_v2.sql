-- changeset camtien:62
INSERT INTO shops (shop_name, owner_id, address, phone, email, latitude, longitude, created_at, updated_at, image) 
VALUES('Tóc Xinh Salon', 
    (SELECT user_uuid FROM users WHERE email = 'camtien000@gmail.com'), 
    '123 Đường A, Quận 1', 
    '0123456789', 
    'contact@tocxinh.com', 
    10.028511, 
   105.804817, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    'toc_xinh.jpg'),
    ('Beauty House', 
    (SELECT user_uuid FROM users WHERE email = 'camtien00000@gmail.com'), 
    '789 Nguyen Thi Minh Khai, Da Nang', 
    '0123456789', 
    'info@beautyhouse.com', 
    10.028511, 
   105.804817, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    'beauty_house.jpg'), ('Salon Nắng Vàng',(SELECT user_uuid FROM users WHERE email = 'camtien00000@gmail.com'), '321 Le Duan, Nha Trang', '0909876543', 'support@nangvangsalon.com', 12.239496, 109.196293, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'nang_vang.jpg');

-- rollback DELETE FROM shops WHERE shop_name IN ('Salon Glamour','Tóc Xinh Salon','Beauty House','Salon Nắng Vàng');
