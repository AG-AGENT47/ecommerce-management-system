USE ECOM;

#QUERY 1 CREATING NEW USER 
#The user will provide their details, and a random ID will be generated for them.
	SET @TestVariable = FLOOR(RAND() * POWER(10, 4));
	INSERT INTO customers (c_id,c_name,c_email,c_phoneno) VALUES (@TestVariable , "Ramdeep","Ram@gmail.com",8643907782);
	INSERT IGNORE INTO Customer_Location (c_id, c_address_house, c_address_pincode) VALUES ( @TestVariable, "C 389, SFS Flats", 780087);
	INSERT IGNORE INTO Customer_City (c_city, c_pincode) VALUES ("Raipur", 780087);
	INSERT IGNORE INTO Customer_State (c_state, c_city) VALUES ("Chattisgarh", "Raipur");
	#SELECT * FROM CUSTOMERS;

#QUERY 2 BROWSING PRODUCTS IN SPECIFIC CATEGORY
# User inputs the category they wish to browse.
	SELECT * FROM Products WHERE p_category = 'Fashion';


#QUERY 3 RECOMMENDING SIMILAR PRODUCTS
#User provides productID
	SELECT * FROM Products WHERE p_category = (SELECT p_category FROM Products WHERE p_id = 'PD01') AND p_id != 'PD01' LIMIT 5;


#QUERY 4 SHIPPING STATUS VIA TRACKING NUMBER
#the user will provide the tracking number and his customer id and he mould be given the details
	SELECT * FROM Shipping WHERE s_tracking_id = "TRK01" AND o_id IN (SELECT o_id FROM Orders WHERE c_id = "CS01" );


#QUERY 5 CHANGE SHIPPING ADDRESS
#User provides which address they want to update
	UPDATE Customer_Location
		SET c_address_house = '123 Abracadabra', c_address_pincode = 339903
		WHERE c_address_sno = 1 and c_id = "CS01" ;
	INSERT IGNORE INTO Customer_City (c_city, c_pincode) VALUES ("Jadunagar",339903 );
	INSERT IGNORE INTO Customer_State (c_state, c_city) VALUES ("Rajasthan", "Jadunagar");


#QUERY 6 PRODUCT INFORMATION
#User provides ProductID
	SELECT p_id, p_name, p_description, p_category, p_price, p_discount, p_effective_price, p_units_in_stock 
    FROM Products 
    WHERE p_id = 'PD01';


#QUERY 7 PRODUCTS ON SALE
	SELECT p_id, p_name, p_description, p_category, p_price, p_discount, p_effective_price 
    FROM Products WHERE p_discount>0  
    ORDER BY  p_category, p_discount DESC; 


#QUERY 8 ADD PRODUCT TO CART
#User inputs ProductID and desired quantity
#Implicitly checks that the product exists and enough quantity is available.
	INSERT INTO Cart (c_id, p_id, p_qty)
	SELECT "CS01", "PD15", 4
	FROM Products
	WHERE p_id = "PD15" AND p_units_in_stock >= 4;
    
    
#QUERY 9 PLACING ORDER USING COUPON CODE
#User inputs the coupon code

	-- Generate random OrderID
	SET @order_id = FLOOR(RAND() + POWER(10,4));

	-- Generate random PaymentID
	SET @payment_id = FLOOR(RAND() + POWER(10,4));

	-- 'Pending' order record created in Orders table
	INSERT INTO Orders(o_id, c_id, o_date, o_status, o_house, o_pincode) 
	VALUES (@order_id, 'CS10', CURRENT_DATE, 'Pending', 'A-112 Ashok Vihar', '110056');

	-- Display Customer's Cart
	SELECT * FROM Cart WHERE c_id = 'CS10';

	-- Insert the items from the Cart into the Orders table
	INSERT INTO Has (o_id, p_id, p_qty)
	SELECT @order_id, p_id, p_qty
	FROM Cart 
	WHERE c_id  = 'CS10';

	-- Place order using coupon code Eg. DIWALI2023
	UPDATE Orders SET o_coupon_code = 'DIWALI2023' WHERE c_id = 'CS10' AND o_id = @order_id;
    
	-- Calculate total amount to be paid for the order
	UPDATE Orders
	SET o_price = (
			SELECT cast((100-(SELECT c.c_discount 
			FROM Coupons c 
			WHERE c.c_coupon_code = o_coupon_code))*SUM(p_qty * p_effective_price)*0.01 AS DECIMAL(10,2))
		FROM Has
		INNER JOIN Products ON Has.p_id = Products.p_id
		WHERE Has.o_id = Orders.o_id
	);

	-- Initiate payment for the order 
	INSERT INTO Payment (p_id, o_id, p_amount, p_type, p_date)
		SELECT @payment_id, @order_id, (SELECT o_price FROM orders WHERE o_id = cast(@order_id AS CHAR(5))), "MyCard", CURRENT_DATE;

	-- Update Stocked quantity and Ordered quantity in Products table
	UPDATE Products 
	SET p_units_in_stock = p_units_in_stock - (SELECT p_qty FROM Cart WHERE c_id = 'CS10' AND p_id = Products.p_id) 
	WHERE p_id IN (SELECT p_id FROM Cart WHERE c_id = 'CS10');

	UPDATE Products 
	SET p_units_on_order = p_units_on_order + (SELECT p_qty FROM Cart WHERE c_id = 'CS10' AND p_id = Products.p_id) 
	WHERE p_id IN (SELECT p_id FROM Cart WHERE c_id = 'CS10');

	-- Change order status to 'Ordered'
	UPDATE Orders SET o_status = 'Ordered' WHERE c_id = 'CS10';

	-- Clear the items from Cart table
	DELETE FROM Cart WHERE c_id = 'CS10';
    

#QUERY 10 CANCELLING AN ORDER
#Requires OrderID as well as CustomerID and cancels order if corresponding entry exists. Also issues a refund. 
	SET @pid = FLOOR(RAND() * POWER(10, 4));
	UPDATE orders SET o_status = 'Cancelled' WHERE o_id = "OD01" AND c_id="CS01" AND o_status!='Cancelled';
	INSERT INTO payment (p_id, o_id, p_amount, p_type, p_date)
		SELECT @pid, "OD01", -(SELECT o_price FROM Orders WHERE o_id = "OD01"), "Paypal", CURRENT_DATE
		WHERE (SELECT COUNT(p_id) FROM payment WHERE o_id = "OD01")= 1;
    

#QUERY 11 - WRITING A REVIEW
	INSERT INTO Reviews (p_id, r_title, r_rating, r_feedback, r_date) 
    VALUES ("PD15", "WHAT A PRODUCT!", 4, "A well built product helpful for the youth", CURRENT_DATE);


#QUERY XX - VIEWING A REVIEW
#User provides Product Name.
	SELECT * FROM Reviews WHERE p_id IN (SELECT p_id FROM Products WHERE p_name="T-shirt");


#QUERY 12 - SUGGESTING PRODUCTS FREQUENTLY PURCHASED TOGETHER 
#User provides ProductID and recieves suggestions for Top-5 products frequenctly brought with it.
	#DROP VIEW suggested_ID;
	CREATE VIEW suggested_ID AS 
		SELECT p_id
			FROM (SELECT p_id FROM has WHERE o_id IN (SELECT o_id FROM Has WHERE p_id = "PD01")) AS sub
			WHERE p_id != 'PD01'
			GROUP BY p_id
			ORDER BY COUNT(*) DESC
			LIMIT 5;
	SELECT p_name FROM Products WHERE Products.p_id in (SELECT * FROM suggested_ID);


#QUERY 13 ORDER HISTORY
	SELECT o_id, o_date, o_price, o_status, o_house FROM Orders WHERE c_id = "CS01";


#QUERY 14 PROCESSING A REFUND
#As soon as the order is cancelled, a refund is issued!
#User can check whether a refund has been granted.
	#DROP VIEW process_refund;
	CREATE VIEW process_refund AS
		SELECT o_id FROM Orders WHERE c_id = "CS01";
	SELECT * FROM Payment WHERE o_id IN (SELECT * FROM process_refund) AND p_amount <= 0;


#QUERY 15 UPDATING PAYMENT INFORMATION
#Payment information can be changed during placing the order 
#User can choose their desired mode of payment. For example, in our case, the user chose 'MyCard'.



#QUERY 16 TRENDING PRODUCTS
	#DROP VIEW trending_products;
	CREATE VIEW trending_products AS
		SELECT p_id
		FROM Has
		GROUP BY p_id
		ORDER BY SUM(p_qty) DESC
		LIMIT 5;
	SELECT * FROM Products WHERE p_id IN (SELECT * FROM trending_products);



#QUERY 17 CHANGE DESIRED PRODUCT QUANTITY IN CART
#User inputs their CustomerID and the ProductID they wish to update quantity for
	UPDATE Cart 
	SET p_qty = 2
	WHERE p_id = 'PD01' AND c_id = 'CS01';



