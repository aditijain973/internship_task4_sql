 create database task4db;
use task4db;

create table Customer (
customer_id int primary key,
name varchar(50),
city varchar(50),
email varchar(50),
phone varchar(15),
join_date date
);

insert into Customer values 
(1, 'Aditi Jain', 'Delhi', 'aditijain3974@gmail.com', '8906543456', '2024-12-12'),
(2, 'Anya Sharma', 'Noida', 'anyasharma74@gmail.com', '9089543456', '2024-03-9'),
(3, 'Rahul Mishra', 'Mumbai', 'rahul21sharma@gmail.com', '89089064236', '2025-02-12'),
(4, 'Varun Saniyan', 'Pune', 'varunsa74@gmail.com', '9064428696', '2023-02-12');

create table Product (
product_id int primary key, 
name varchar(50), 
category varchar(50), 
price decimal(10,2),
stock_quantity int, 
supplier varchar(50),
rating decimal(2,1)
);
INSERT INTO product VALUES
(1, 'Laptop', 'Electronics', 60000, 15, 'TechWorld', 4.5),
(2, 'Mobile', 'Electronics', 25000, 30, 'SmartHub', 4.2),
(3, 'Headphones', 'Accessories', 2000, 100, 'SoundMax', 4.7);

CREATE TABLE Purchase (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    payment_method VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO Purchase VALUES
(1, 1, '2025-08-01', 62000, 'Delivered', 'UPI'),
(2, 2, '2025-08-02', 27000, 'Delivered', 'Card'),
(3, 3, '2025-08-03', 2000, 'Pending', 'Cash');

CREATE TABLE Sales (
    order_Detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    discount DECIMAL(5,2),
    final_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

Select * from customer;
Select * from product;
Select * from Purchase;


-- customer table queries--

Select name, city, email FROM customer;
-- whereclause --
Select * from customer WHERE city = 'Delhi';

Select * from customer where join_date > '2024-01-01';

-- order by function --
Select * from customer Order BY name asc;

Select * from customer ORDER BY join_date desc;

-- group by and aggregate function  --
SELECT city, COUNT(*) as total_customers From customer group by city;

Select city, MIN(join_date) as first_customer_joined from customers group by city;

-- joins --
Select c.customer_id, c.name, o.order_id, o.total_amount from customers c Inner join orders o on c.customer_id = o.customer_id;

Select c.customer_id, c.name, o.order_id, o.total_amount from customers c left join orders o on c.customer_id = o.customer_id;

Select c.customer_id, c.name, o.order_id, o.total_amount from customer c right join orders o on c.customer_id = o.customer_id;

-- subqueries --
Select name, city from customer where customer_id in (select customer_id from orders where total_amount > 5000);

Select * from customer where join_date = (select MAX(join_date) from customer);

-- aggregate function --
Select COUNT(*) as total_customer from customer;

Select avg(LENGTH(name)) as avg_name_length from customer;

-- creating a view for analysis --
Create view customer_spending as
Select c.customer_id, c.name, SUM(o.total_amount) AS total_spent FROM customer c
Join orders o on c.customer_id = o.customer_id
Group by c.customer_id, c.name;

Select * from customer_spending where total_spent > 10000;

-- optimize with indexes --

create index idx_customers_city on customer(city);

create index idx_customers_join_date on customers(join_date);


