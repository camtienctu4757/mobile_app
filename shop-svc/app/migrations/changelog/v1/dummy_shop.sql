-- changeset camtien:12
INSERT INTO shops (shop_name, owner_id, address, phone, email, latitude, longitude, created_at, updated_at, image) 
SELECT 'Salon Glamour', 
    user_uuid, 
    '123 Đường A, Quận 1', 
    '0123456789', 
    'salon.glamour@example.com', 
    10.123456, 
    106.695477, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    'salon_glamour.jpg' FROM 
    users WHERE username = 'user1';

INSERT INTO shops (shop_name, owner_id, address, phone, email, latitude, longitude, created_at, updated_at, image) 
SELECT 'Tóc Xinh Salon', 
    user_uuid, 
    '123 Đường A, Quận 1', 
    '0123456789', 
    'contact@tocxinh.com', 
    10.028511, 
   105.804817, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    'toc_xinh.jpg' FROM 
    users WHERE username = 'user2';

INSERT INTO shops (shop_name, owner_id, address, phone, email, latitude, longitude, created_at, updated_at, image) 
SELECT 'Beauty House', 
    user_uuid, 
    '789 Nguyen Thi Minh Khai, Da Nang', 
    '0123456789', 
    'info@beautyhouse.com', 
    10.028511, 
   105.804817, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    'beauty_house.jpg' FROM 
    users WHERE username = 'user3';



INSERT INTO shops (shop_name, owner_id, address, phone, email, latitude, longitude, created_at, updated_at, image) 
SELECT 'Salon Nắng Vàng',user_uuid, '321 Le Duan, Nha Trang', '0909876543', 'support@nangvangsalon.com', 12.239496, 109.196293, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'nang_vang.jpg' FROM 
    users WHERE username = 'user3';

-- rollback DELETE FROM shops WHERE shop_name IN ('Salon Glamour','Tóc Xinh Salon','Beauty House','Salon Nắng Vàng');
