use sakila;



create table  Categories (
category_id int primary key not null,
category_name varchar(40)
);
insert into Categories(category_id, category_name) values (1, 'Electronics'),
    (2, 'Clothing'),
    (3, 'Books');
 
create table  Products(
 product_id INT PRIMARY KEY NOT NULL,
    product_name VARCHAR(50),
    category_id INT,
    price INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)


);
INSERT INTO Products (product_id, product_name, category_id, price)
VALUES
    (101, 'Iphone', 1, 900),
    (102, 'Laptop', 1, 800),
    (201, 'Hoddie', 2, 20),
    (202, 'Jeans', 2, 40),
    (301, 'Fairtail', 3, 15);


create table  Customers (
customer_id int primary key not null,
customer_name varchar(20),
email varchar(255)
);
INSERT INTO Customers (customer_id, customer_name, email)
VALUES
    (1, 'Simon Ha', 'simon.ha@gmailcom'),
    (2, 'Will Smith', 'smith@gmailcom'),
    (3, 'Taylor Lun', 'taylor@gmailcom');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, customer_id, order_date)
VALUES
    (1001, 1, '2023-09-20'),
    (1002, 2, '2023-09-21'),
    (1003, 3, '2023-09-22');

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity)
VALUES
    (1, 1001, 101, 2),
    (2, 1001, 201, 3),
    (3, 1002, 102, 1),
    (4, 1003, 301, 5);
    
--     Lấy thông tin tất cả các sản phẩm đã được đặt trong một đơn đặt hàng cụ thể.-- 
SELECT Products.product_name, OrderDetails.quantity, Products.price
FROM OrderDetails
INNER JOIN Products ON OrderDetails.product_id = Products.product_id
WHERE OrderDetails.order_id = 1001;

-- Tính tổng số tiền trong một đơn đặt hàng cụ thể.
SELECT SUM(OrderDetails.quantity * Products.price) AS total_amount
FROM OrderDetails
INNER JOIN Products ON OrderDetails.product_id = Products.product_id
WHERE OrderDetails.order_id = 1001;

-- Lấy danh sách các sản phẩm chưa có trong bất kỳ đơn đặt hàng nào.
select Products.product_name from Products
left join  OrderDetails on Products.product_id = OrderDetails.product_id
where OrderDetails.product_id is null;
-- Đếm số lượng sản phẩm trong mỗi danh mục. (category_name, total_products)

select Categories.category_name, COUNT(Products.product_id) AS total_products
from Categories
left join Products on Categories.category_id = Products.category_id
group by Categories.category_name;
-- Tính tổng số lượng sản phẩm đã đặt bởi mỗi khách hàng (customer_name, total_ordered)
select Customers.customer_name, sum(OrderDetails.quantity) as total_ordered
from Customers
left join Orders on Customers.customer_id = Orders.customer_id
left join OrderDetails on Orders.order_id = OrderDetails.order_id
group by Customers.customer_name;

-- Lấy thông tin danh mục có nhiều sản phẩm nhất (category_name, product_count)
select category_name, COUNT(*) AS product_count
from Categories
inner join Products on Categories.category_id = Products.category_id
group by category_name;

-- Tính tổng số sản phẩm đã được đặt cho mỗi danh mục (category_name,total_ordered)
select category_name, sum(OrderDetails.quantity) as total_ordered
from Categories
left join Products on Categories.category_id = Products.category_id
left join OrderDetails on Products.product_id = OrderDetails.product_id
group by category_name;

-- 8.Lấy thông tin về top 3 khách hàng có số lượng sản phẩm đặt hàng lớn nhất (customer_id, customer_name, total_ordered)
select Customers.customer_id, Customers.customer_name, SUM(OrderDetails.quantity) AS total_ordered
from Customers
inner join Orders on Customers.customer_id = Orders.customer_id
inner join  OrderDetails on Orders.order_id = OrderDetails.order_id
group by Customers.customer_id, Customers.customer_name
order by total_ordered desc;
-- Lấy thông tin về khách hàng đã đặt hàng nhiều hơn một lần trong khoảng thời gian cụ thể từ ngày A -> ngày B (customer_id, customer_name, total_orders):
 select Customers.customer_id, Customers.customer_name,COUNT(DISTINCT Orders.order_id) as total_orders
from Customers
inner join Orders on Customers.customer_id = Orders.customer_id
where Orders.order_date between '2023-09-19' and '2023-09-23'
group by Customers.customer_id, Customers.customer_name
having COUNT(DISTINCT Orders.order_id) > 1;

-- Lấy thông tin về các sản phẩm đã được đặt hàng nhiều lần nhất và số lượng đơn đặt hàng tương ứng (product_id, product_name, total_ordered)
select Products.product_id, Products.product_name, COUNT(DISTINCT OrderDetails.order_id) as total_ordered
from Products
inner join  OrderDetails on Products.product_id = OrderDetails.product_id
group by Products.product_id, Products.product_name
order by total_ordered desc





