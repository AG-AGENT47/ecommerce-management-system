DROP DATABASE ECOM;
CREATE DATABASE ecom;
USE ecom;

CREATE TABLE Customers (
  c_id VARCHAR(5) PRIMARY KEY,
  c_name VARCHAR(50) NOT NULL,
  c_email VARCHAR(100) NOT NULL UNIQUE,
  c_phoneno DOUBLE NOT NULL UNIQUE,
  
  CONSTRAINT chk_email CHECK(c_email LIKE '%_@__%.__%'),
  CONSTRAINT chk_cphoneno CHECK (LENGTH(c_phoneno)=10)
);

CREATE TABLE Customer_Location(
	c_id VARCHAR(5) NOT NULL,
    c_address_sno INT NOT NULL DEFAULT 1,
    c_address_house VARCHAR(50) NOT NULL,
    c_address_pincode VARCHAR(10) NOT NULL,
    PRIMARY KEY(c_id, c_address_sno),
    FOREIGN KEY (c_id) REFERENCES Customers(c_id),
    CONSTRAINT ck_pincode CHECK (LENGTH(c_address_pincode)=6)
);

CREATE TABLE Customer_city (
	c_city VARCHAR(50) NOT NULL,
    c_pincode VARCHAR(10) PRIMARY KEY REFERENCES Customer_location(c_address_pincode)
);

CREATE TABLE Customer_state (
	c_state VARCHAR(50) NOT NULL,
    c_city VARCHAR(50) PRIMARY KEY REFERENCES Customer_city(c_city)
);

CREATE TABLE Products (
  p_id VARCHAR(5) PRIMARY KEY,
  p_name VARCHAR(50) NOT NULL,
  p_description VARCHAR(500) NOT NULL,
  p_category VARCHAR(50) NOT NULL,
  p_price DECIMAL(10,2) NOT NULL,
  p_effective_price DECIMAL(10,2) NOT NULL DEFAULT 0,
  p_discount DECIMAL(5,2)  NOT NULL DEFAULT 0 CHECK (p_discount>=0 AND p_discount<=100),
  p_units_on_order INT NOT NULL CHECK (p_units_on_order>=0),
  p_units_in_stock INT NOT NULL CHECK (p_units_in_stock>=0)
);

CREATE TABLE Coupons (
c_coupon_code VARCHAR(20) PRIMARY KEY,
c_discount DECIMAL(5,2) NOT NULL DEFAULT 0 CHECK (c_discount>=0 AND c_discount<=100)
);

CREATE TABLE Orders (
  o_id VARCHAR(5) PRIMARY KEY,
  c_id VARCHAR(5) NOT NULL,
  o_date DATE NOT NULL,
  o_price DECIMAL(10,2) NOT NULL DEFAULT 0,
  o_status VARCHAR(50) NOT NULL,
  o_coupon_code VARCHAR(20) DEFAULT 'ZERO',
  o_house VARCHAR(50) NOT NULL,
  o_pincode VARCHAR(10) NOT NULL REFERENCES Customer_city(c_pincode),
  
  CONSTRAINT fk_o_customers 
	FOREIGN KEY (c_id) 
    REFERENCES Customers(c_id),
  
  CONSTRAINT fk_o_coupons 
	FOREIGN KEY (o_coupon_code) 
    REFERENCES Coupons(c_coupon_code)
);

CREATE TABLE Payment (
  p_id VARCHAR(5) PRIMARY KEY,
  o_id VARCHAR(5) NOT NULL,
  p_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  p_type VARCHAR(20) NOT NULL,
  p_date DATE NOT NULL,
  
  CONSTRAINT fk_payment_order 
		FOREIGN KEY (o_id) REFERENCES Orders(o_id)
		ON DELETE CASCADE
);

CREATE TABLE Shipping (
  s_tracking_id VARCHAR(5) PRIMARY KEY,
  s_date DATE NOT NULL,
  s_phoneno DOUBLE NOT NULL,
  s_status VARCHAR(50) NOT NULL,
  o_id VARCHAR(5) NOT NULL,
  
  CONSTRAINT fk_shipping_order
	FOREIGN KEY (o_id)
    REFERENCES Orders(o_id)
    ON DELETE CASCADE,
    
  CONSTRAINT chk_sphoneno CHECK (LENGTH(s_phoneno)=10)
);

CREATE TABLE Reviews (
  p_id VARCHAR(5) NOT NULL,
  r_title VARCHAR(100) NOT NULL,
  r_rating INT NOT NULL CHECK (r_rating IN (1,2,3,4,5)),
  r_feedback VARCHAR(500) NOT NULL,
  r_date DATE NOT NULL,
  
  CONSTRAINT pk_reviews PRIMARY KEY(p_id, r_title),
  
  CONSTRAINT fk_reviews_products
	FOREIGN KEY (p_id) 
    REFERENCES Products(p_id)
    ON DELETE CASCADE
);

CREATE TABLE Has (
p_id VARCHAR(5) NOT NULL,
o_id VARCHAR(5) NOT NULL,
p_qty INT NOT NULL DEFAULT 0,

CONSTRAINT pk_has PRIMARY KEY(p_id, o_id),

CONSTRAINT fk_hasproduct 
	FOREIGN KEY(p_id)
    REFERENCES Products(p_id),
    
CONSTRAINT fk_order 
	FOREIGN KEY(o_id)
    REFERENCES Orders(o_id)
    ON DELETE CASCADE
);

CREATE TABLE Cart (
c_id VARCHAR(5) NOT NULL,
p_id VARCHAR(5) NOT NULL,
p_qty INT NOT NULL DEFAULT 0,

CONSTRAINT pk_has PRIMARY KEY(p_id, c_id),

CONSTRAINT fk_cartproduct 
	FOREIGN KEY(p_id)
    REFERENCES Products(p_id),
    
CONSTRAINT fk_customer
	FOREIGN KEY(c_id)
    REFERENCES Customers(c_id)
    ON DELETE CASCADE
);