SET SQL_SAFE_UPDATES = 0;
USE ECOM;

INSERT INTO Customers (c_id, c_name, c_email, c_phoneno)
VALUES
  ('CS01', 'Sandeep Kumar', 'sandeep@gmail.com', '9876543210'),
  ('CS02', 'Priya Singh', 'priya@gmail.com', '9823450789'),
  ('CS03', 'Rajesh Patel', 'rajesh@gmail.com', '8877665544'),
  ('CS04', 'Amit Sharma', 'amit@gmail.com', '9922118899'),
  ('CS05', 'Neha Gupta', 'neha@gmail.com', '9988776655'),
  ('CS06', 'Anil Yadav', 'anil@gmail.com', '9876543219'),
  ('CS07', 'Divya Verma', 'divya@gmail.com', '9823456489'),
  ('CS08', 'Sanjay Mishra', 'sanjay@gmail.com', '8877065544'),
  ('CS09', 'Kavita Gupta', 'kavita@gmail.com', '9931198899'),
  ('CS10', 'Vikas Singh', 'vikas@gmail.com', '9988775655');
  
INSERT INTO Customer_Location (c_id, c_address_sno, c_address_house, c_address_pincode)
VALUES
  ('CS01', 1, 'Flat no. 101, Royal Residency', '110001'),
  ('CS01', 2, 'House no. 23, Gali no. 5', '110002'),
  ('CS02', 1, 'B-45, Shanti Vihar', '201301'),
  ('CS03', 1, 'Plot no. 78, Sector 16', '380016'),
  ('CS03', 2, 'Flat no. 203, Om Residency', '380015'),
  ('CS04', 1, 'H-10, Surya Vihar', '302018'),
  ('CS05', 1, 'House no. 45, Block C', '500001'),
  ('CS06', 1, 'Flat no. 302, Lotus Tower', '560001'),
  ('CS07', 1, 'B-23, Ashok Nagar', '400072'),
  ('CS08', 1, 'Plot no. 12, Sector 3', '110022'),
  ('CS09', 1, 'Flat no. 501, Ocean View', '700016'),
  ('CS09', 2, 'House no. 12, Park Street', '700017'),
  ('CS10', 1, 'House no. 34, Sector 10', '122001');

  
INSERT INTO Customer_city (c_city, c_pincode)
VALUES
  ('New Delhi', '110001'),
  ('New Delhi', '110002'),
  ('Noida', '201301'),
  ('Ahmedabad', '380016'),
  ('Ahmedabad', '380015'),
  ('Jaipur', '302018'),
  ('Hyderabad', '500001'),
  ('Bengaluru', '560001'),
  ('Mumbai', '400072'),
  ('New Delhi', '110022'),
  ('Kolkata', '700016'),
  ('Kolkata', '700017'),
  ('Gurugram', '122001');

INSERT INTO Customer_state (c_state, c_city)
VALUES
  ('Delhi', 'New Delhi'),
  ('Delhi', 'Noida'),
  ('Gujarat', 'Ahmedabad'),
  ('Rajasthan', 'Jaipur'),
  ('Telangana', 'Hyderabad'),
  ('Karnataka', 'Bengaluru'),
  ('Maharashtra', 'Mumbai'),
  ('West Bengal', 'Kolkata'),
  ('Haryana', 'Gurugram');

INSERT INTO Products (p_id, p_name, p_description, p_category, p_price, p_discount, p_units_on_order, p_units_in_stock)
VALUES
  ('PD01', 'T-shirt', 'Men\'s Black T-shirt', 'Fashion', 25.99, 10.00, 50, 100),
  ('PD02', 'Jeans', 'Women\'s Skinny Fit Jeans', 'Fashion', 35.99, 5.00, 70, 150),
  ('PD03', 'Running Shoes', 'Men\'s Running Shoes', 'Sports', 49.99, 15.00, 40, 80),
  ('PD04', 'Yoga Mat', 'Eco-Friendly Yoga Mat', 'Health & Care', 19.99, 0.00, 20, 50),
  ('PD05', 'Shampoo', 'Organic Shampoo for Oily Hair', 'Health & Care', 12.99, 20.00, 100, 200),
  ('PD06', 'Milk', 'Organic Milk', 'Groceries', 4.99, 0.00, 200, 500),
  ('PD07', 'Cheese', 'Cheddar Cheese', 'Groceries', 8.99, 0.00, 50, 100),
  ('PD08', 'Sofa', '3-Seater Fabric Sofa', 'Furniture', 399.99, 0.00, 10, 20),
  ('PD09', 'Dining Table', 'Wooden Dining Table with 4 Chairs', 'Furniture', 299.99, 10.00, 5, 10),
  ('PD10', 'Bed', 'Queen-sized Bed with Headboard', 'Furniture', 599.99, 5.00, 2, 5),
  ('PD11', 'Laptop', '13-inch Laptop with i7 Processor', 'Electronics', 1299.99, 12.00, 15, 30),
  ('PD12', 'Smartphone', 'Android Smartphone with 64GB Storage', 'Electronics', 599.99, 8.00, 25, 50),
  ('PD13', 'Camera', 'Mirrorless Camera with 18-55mm Lens', 'Electronics', 899.99, 0.00, 5, 10),
  ('PD14', 'Tennis Racket', 'Carbon Fiber Tennis Racket', 'Sports', 89.99, 0.00, 20, 40),
  ('PD15', 'Basketball', 'Indoor/Outdoor Basketball', 'Sports', 24.99, 15.00, 50, 100),
  ('PD16', 'Board Game', 'Monopoly Board Game', 'Toys', 29.99, 0.00, 30, 60),
  ('PD17', 'Lego Set', 'Harry Potter Lego Set', 'Toys', 49.99, 10.00, 25, 50),
  ('PD18', 'Treadmill', 'Folding Treadmill for Home', 'Sports', 699.99, 20.00, 5, 10),
  ('PD19', 'Suitcase', 'Hard-shell Suitcase with Spinner Wheels', 'Travel', 99.99, 5.00, 40, 80),
  ('PD20', 'Backpack', 'Waterproof Backpack with Laptop Compartment', 'Travel', 49.99, 0.00, 30,10),
  ('PD21', 'Maggi', 'A delicious and quick snack that can be prepared in minutes.', 'Groceries', 15.00, 5.00, 500, 1000),
  ('PD22', 'Toothpaste', 'A refreshing toothpaste that provides long-lasting freshness.', 'Health & Care', 75.00, 0.00, 200, 500),
  ('PD23', 'Snakes and Ladders', 'Fun to play and keeps you engaged.', 'Toys', 1499.00, 0.00, 50, 100),
  ('PD24', 'Cricket Bat', 'A high-quality cricket bat made from premium materials.', 'Sports', 5999.00, 20.00, 10, 20),
  ('PD25', 'Water Purifier', 'A smart water purifier that removes impurities and provides safe drinking water.', 'Electronics', 12999.00, 5.00, 30, 50),
  ('PD26', 'Sunglasses', 'A classic pair of sunglasses that never go out of style.', 'Fashion', 7999.00, 10.00, 50, 100),
  ('PD27', 'Backpack', 'A multipurpose durable and stylish backpack.', 'Travel', 19999.00, 0.00, 20, 30);

INSERT INTO Coupons (c_coupon_code, c_discount) VALUES
  ('DIWALI2023', 20.00),
  ('HOLI2023', 15.00),
  ('GANESHCHATURTHI2023', 25.00),
  ('NAVRATRI2023', 10.00),
  ('DURGAPUJA2023', 30.00),
  ('CHRISTMAS2023', 25.00),
  ('SHIVRATRI2023', 15.00),
  ('INDEPENDENCEDAY2023', 20.00),
  ('REPUBLICDAY2023', 20.00),
  ('VALENTINESDAY2023', 10.00),
  ('ZERO', 0.00);  

INSERT INTO Cart (c_id, p_id, p_qty)
VALUES 
	('CS01', 'PD01', 2),
	('CS01', 'PD08', 3),
    ('CS02', 'PD04', 1),
    ('CS02', 'PD07', 4),
    ('CS03', 'PD09', 2),
    ('CS03', 'PD20', 1),
    ('CS04', 'PD19', 2),
    ('CS04', 'PD15', 2),
    ('CS04', 'PD17', 3),
    ('CS05', 'PD25', 1),
    ('CS05', 'PD03', 2),
    ('CS06', 'PD01', 1),
    ('CS06', 'PD02', 1),
	('CS07', 'PD27', 2),
	('CS07', 'PD03', 1),
	('CS08', 'PD11', 3),
	('CS08', 'PD24', 2),
	('CS09', 'PD13', 1),
	('CS09', 'PD04', 2),
	('CS10', 'PD22', 2);   


INSERT INTO Orders (o_id, c_id, o_date, o_house, o_status, o_coupon_code, o_pincode)
VALUES 
	('OD01', 'CS01', '2023-01-01', 'Flat no. 101, Royal Residency', 'Delivered', 'DIWALI2023', '110011'),
	('OD02', 'CS01', '2023-02-01', 'House no. 23, Gali no. 5', 'Shipped', 'HOLI2023', '110002'),
	('OD03', 'CS02', '2023-03-01', 'B-45, Shanti Vihar', 'Processing', DEFAULT,'201301'),
	('OD04', 'CS03', '2023-04-01', 'Plot no. 78, Sector 16', 'Cancelled', DEFAULT, '380016'),
	('OD05', 'CS04', '2023-05-01', 'H-10, Surya Vihar', 'Delivered', 'NAVRATRI2023', '302018'),
	('OD06', 'CS05', '2023-06-01', 'House no. 45, Block C', 'Shipped', DEFAULT, '500001'),
	('OD07', 'CS06', '2023-07-01', 'Flat no. 302, Lotus Tower', 'Processing', DEFAULT, '560001'),
	('OD08', 'CS07', '2023-08-01', 'B-23, Ashok Nagar', 'Delivered', 'CHRISTMAS2023', '400072'),
	('OD09', 'CS09', '2023-09-01', 'Flat no. 501, Ocean View', 'Shipped', DEFAULT, '700016'),
	('OD10', 'CS09', '2023-10-01', 'House no. 12, Park Street', 'Processing', 'SHIVRATRI2023', '700017');
  

INSERT INTO Has (o_id, p_id, p_qty)
VALUES
	('OD01', 'PD01', 1),
	('OD01', 'PD02', 2),
	('OD01', 'PD05', 1),
	('OD01', 'PD07', 1),
	('OD01', 'PD03', 1),
	('OD01', 'PD04', 2),
	('OD02', 'PD05', 3),
	('OD03', 'PD09', 4),
	('OD04', 'PD21', 2),
	('OD04', 'PD22', 1),
	('OD05', 'PD24', 1),
	('OD05', 'PD27', 1),
	('OD06', 'PD01', 1),
	('OD06', 'PD02', 1),
	('OD07', 'PD22', 2),
	('OD08', 'PD18', 1),
	('OD08', 'PD15', 1),
	('OD08', 'PD13', 2),
	('OD08', 'PD20', 1),
	('OD09', 'PD10', 1),
	('OD09', 'PD02', 3),
	('OD10', 'PD01', 1),
	('OD10', 'PD02', 5),
	('OD10', 'PD16', 1),
	('OD10', 'PD09', 1),
	('OD10', 'PD07', 1);


INSERT INTO Payment (p_id, o_id, p_amount, p_type, p_date)
VALUES 
	('PY01', 'OD01', 193.62, 'Cash', '2023-01-08'),
	('PY02', 'OD02', 31.17, 'Paypal', '2023-02-01'),
	('PY03', 'OD03', 1079.96, 'Debit Card', '2023-03-01'),
	('PY04', 'OD04', 103.50, 'Debit Card', '2023-04-01'),
    ('PY05', 'OD04', -103.50, 'Paypal', '2023-04-02'),
	('PY06', 'OD05', 24798.20, 'Credit Card', '2023-05-01'),
	('PY07', 'OD06', 57.58, 'Paypal', '2023-06-01'),
	('PY08', 'OD07', 150.00, 'Debit Card', '2023-07-01'),
	('PY09', 'OD08', 2431.20, 'Cash', '2023-08-06'),
	('PY10', 'OD09', 672.56, 'Credit Card', '2023-09-01'),
	('PY11', 'OD10', 503.31, 'Paypal', '2023-10-01');

INSERT INTO Shipping (s_tracking_id, s_date, s_phoneno, s_status, o_id)
VALUES 
	('TRK01', '2023-01-08', 1234567890, 'Shipped', 'OD01'),
	('TRK02', '2023-02-04', 2345678901, 'In Transit', 'OD02'),
	('TRK03', '2023-03-10', 3456789012, 'Delivered', 'OD03'),
	('TRK05', '2023-05-05', 5678901234, 'In Transit', 'OD05'),
	('TRK06', '2023-06-04', 6789012345, 'Delivered', 'OD06'),
	('TRK07', '2023-07-06', 7890123456, 'Shipped', 'OD07'),
	('TRK08', '2023-08-06', 8901234567, 'In Transit', 'OD08'),
	('TRK09', '2023-09-03', 9012345678, 'Delivered', 'OD09'),
	('TRK10', '2023-10-07', 1234567890, 'Shipped', 'OD10');
    

INSERT INTO Reviews (p_id, r_title, r_rating, r_feedback, r_date) 
VALUES 
	('PD01', 'Great product!', 5, 'Too good, exceeds my expectations!', '2023-01-08'),
	('PD01', 'Lovely quality', 1, 'Really love the quality, must buy!', '2023-06-04'),
	('PD01', 'Not worth the price', 2, 'Too costly even if the quality is good.', '2023-10-07'),
	('PD05', 'Not the best of its kind', 4, 'Satisfied with the purchase but better alternatives available.', '2023-02-04'),
	('PD07', 'Terrible product', 1, 'Really bad experience with the product, would not recommended at all!', '2023-01-08'),
	('PD03', 'Excellent experience', 5, 'Exceptional quality for the price, really happy with the purchase.', '2023-01-08'),
	('PD04', 'Average product', 3, 'The product is a mid, nothing special.', '2023-01-08'),
	('PD09', 'Great value for the price', 4, 'A value for money purchase, would suggest that you give it a try.', '2023-02-04'),
	('PD09', 'Highly recommend!', 5, 'Really good experience, highly recommended to anyone looking for a quality item.', '2023-10-07'),
	('PD07', 'Disappointing', 2, 'Poor quality.', '2023-10-07'),
	('PD22', 'Do not purchase!', 1, 'The product quality is too bad for its price.', '2023-07-06'),
	('PD24', 'Superb product!', 5, 'Too good, exceeds my expectations!', '2023-05-05'),
	('PD27', 'Expceptional quality', 1, 'Really love the quality, must buy!', '2023-05-05'),
	('PD22', 'Poor value for money', 2, 'Too costly even if the quality is good.', '2023-07-06'),
	('PD18', 'Better alternatives available', 4, 'Satisfied with the purchase but better alternatives available.', '2023-08-06'),
	('PD15', 'Happy with purchase', 5, 'Exceptional quality for the price, really happy with the purchase.', '2023-08-06'),
	('PD13', 'Mid buy', 3, 'The product is a mid, nothing special.', '2023-08-06'),
	('PD20', 'Money efficient!', 4, 'A value for money purchase, would suggest that you give it a try.', '2023-08-06'),
	('PD10', 'Unsatisfactory', 2, 'Poor quality.', '2023-09-03'),
	('PD16', 'Poor quality', 1, 'The product quality is too bad for its price.', '2023-10-07'),
	('PD02', 'Needs improvement', 3, 'Scope for improvement.', '2023-06-04');

UPDATE Products 
SET p_effective_price = cast(p_price - (p_price * p_discount / 100) AS DECIMAL(10,2));

UPDATE Orders
SET o_price = (
    SELECT cast((100-(SELECT c.c_discount FROM Coupons c WHERE c.c_coupon_code = o_coupon_code))*SUM(p_qty * p_effective_price)*0.01 AS DECIMAL(10,2))
    FROM Has
    INNER JOIN Products ON Has.p_id = Products.p_id
    WHERE Has.o_id = Orders.o_id
);
  
