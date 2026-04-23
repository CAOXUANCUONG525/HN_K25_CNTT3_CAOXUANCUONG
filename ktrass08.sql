create database BookStoreDB;
use BookStoreDB;
create table Category (
category_id int auto_increment primary key not null,
category_name varchar(100) not null,
description varchar(255)
);
create table Book (
book_id int auto_increment primary key not null,
title varchar(150) not null ,
status int default 1,
publish_date date,
price decimal(10,2),
category_id int ,
foreign key (category_id) references Category (category_id)
);
create table BookOrder(
order_id int auto_increment primary key not null,
customer_name varchar(100) not null ,
book_id int ,
foreign key (book_id) references Book (book_id) ON DELETE CASCADE,
order_date date DEFAULT(CURRENT_DATE),
delivery_date date
);
-- ●Thêmcột:Thêm cột author_name(VARCHAR(100),NOTNULL)vào bảng Book.
alter table Book 
add author_name varchar(100) not null;
-- ●Sửa kiểu dữ liệu:Thay đổi cột customer_name trong bảng BookOrder thành VARCHAR(200)
alter table BookOrder 
modify customer_name varchar(200) ;
-- Thêm ràng buộc:Thêm ràng buộc CHECK cho bảng BookOrder để đảm bảo delivery_date luôn lớn hơn hoặc bằng order_date.
alter table BookOrder
add constraint CHK_DeliveryDate
check (delivery_date >= order_date );

INSERT INTO Category (category_id, category_name, description) VALUES
(1, 'IT & Tech', 'Sách lập trình'),
(2, 'Business', 'Sách kinh doanh'),
(3, 'Novel', 'Tiểu thuyết');

INSERT INTO Book (book_id, title, status, publish_date, price, category_id, author_name) VALUES
(1, 'Clean Code', 1, '2020-05-10', 500000, 1, 'Robert C. Martin'),
(2, 'Đắc Nhân Tâm', 0, '2018-08-20', 150000, 2, 'Dale Carnegie'),
(3, 'JavaScript Nâng cao', 1, '2023-01-15', 350000, 1, 'Kyle Simpson'),
(4, 'Nhà Giả Kim', 0, '2015-11-25', 120000, 3, 'Paulo Coelho');

INSERT INTO BookOrder (order_id, customer_name, book_id, order_date, delivery_date) VALUES
(101, 'Nguyen Hai Nam ', 1, '2025-01-10', '2025-01-15'),
(102, 'Tran Bao Ngoc  ', 3, '2025-02-05', '2025-02-10'),
(103, 'Le Hoang Yen', 4, '2025-03-12', NULL);

update book 
set price =+5000
where category_id =(
	select category_id
    from category 
    where category_id =1
);
UPDATE BookOrder SET delivery_date = '2025-12-31' WHERE delivery_date IS NULL;
-- xoa du lieu 
delete from BookOrder
where delivery_date < '2025-02-01';
-- Truy van du lieu 
-- 1. CASE & AS: Trạng thái hàng hóa
SELECT title, author_name, 
       CASE WHEN status = 1 THEN 'Còn hàng' ELSE 'Hết hàng' END AS status_name
FROM Book;
-- 2. Hàm hệ thống: Viết hoa và tính số năm xuất bản
SELECT UPPER(title) AS title_uppercase, 
       (YEAR(CURDATE()) - YEAR(publish_date)) AS years_since_published
FROM Book;

-- 3. INNER JOIN: Thông tin sách và thể loại
SELECT b.title, b.price, c.category_name
FROM Book b
JOIN Category c ON b.category_id = c.category_id;

-- 4. ORDER BY & LIMIT: Top 2 sách giá cao nhất
SELECT * FROM Book 
ORDER BY price DESC 
LIMIT 2;
 -- 6. Scalar Subquery: Sách giá cao hơn mức trung bình
SELECT * FROM Book 
WHERE price > (SELECT AVG(price) FROM Book);






