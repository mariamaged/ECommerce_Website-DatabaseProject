-- Table 1
CREATE TABLE Users
(
username VARCHAR(20),
password VARCHAR(20),
first_name VARCHAR(20),
last_name VARCHAR(20),
email VARCHAR(50) NOT NULL,

CONSTRAINT Users_primary_key
PRIMARY KEY(username),

CONSTRAINT Users_unique1
UNIQUE(email)
);

---------------------------------------------------------------------------------------------------------------------

-- Table 2
CREATE TABLE User_mobile_numbers
(
mobile_number VARCHAR(20),
username VARCHAR(20),

CONSTRAINT User_mobile_numbers_primary_key
PRIMARY KEY(mobile_number, username),

CONSTRAINT User_mobile_numbers_foreign_key1
FOREIGN KEY(username) REFERENCES Users
);

---------------------------------------------------------------------------------------------------------------------

-- Table 3
CREATE TABLE User_Addresses
(
address VARCHAR(100),
username VARCHAR(20),

CONSTRAINT User_Addresses_primary_key
PRIMARY KEY(address, username),

CONSTRAINT User_Addresses_foreign_key1
FOREIGN KEY(username) REFERENCES Users
);

---------------------------------------------------------------------------------------------------------------------

-- Table 4
CREATE TABLE Customer
(
username VARCHAR(20),
points INT NOT NULL DEFAULT 0,

CONSTRAINT Customer_primary_key
PRIMARY KEY(username),

CONSTRAINT Customer_foreign_key1
FOREIGN KEY(username) REFERENCES Users
);

---------------------------------------------------------------------------------------------------------------------

-- Table 5
CREATE TABLE Admins
(
username VARCHAR(20),

CONSTRAINT Admins_primary_key
PRIMARY KEY(username),

CONSTRAINT Admins_foreign_key1
FOREIGN KEY(username) REFERENCES Users
);

---------------------------------------------------------------------------------------------------------------------

-- Table 6
CREATE TABLE Vendor 
(
username VARCHAR(20),
activated BIT NOT NULL DEFAULT 0, 
company_name VARCHAR(20) NOT NULL, 
bank_acc_no VARCHAR(20) NOT NULL, 
admin_username VARCHAR(20),

CONSTRAINT Vendor_primary_key
PRIMARY KEY(username),

CONSTRAINT Vendor_foreign_key1
FOREIGN KEY(username) REFERENCES Users,

CONSTRAINT Vendor_foreign_key2
FOREIGN KEY(admin_username) REFERENCES Admins

);

---------------------------------------------------------------------------------------------------------------------

-- Table 7
CREATE TABLE Delivery_Person
(
username VARCHAR(20),
is_activated BIT NOT NULL DEFAULT 0,

CONSTRAINT Delivery_Person_primary_key
PRIMARY KEY(username),

CONSTRAINT Delivery_Person_foreign_key1
FOREIGN KEY(username) REFERENCES Users

);

---------------------------------------------------------------------------------------------------------------------

-- Table 8
CREATE TABLE Credit_Card
(
number VARCHAR(20), 
expiry_date DATE NOT NULL,
cvv_code VARCHAR(4) NOT NULL,

CONSTRAINT Credit_Card_primary_key
PRIMARY KEY(number)
);

---------------------------------------------------------------------------------------------------------------------

-- Table 9
CREATE TABLE Delivery
(
id INT IDENTITY,
type VARCHAR(20) NOT NULL,
time_duration INT NOT NULL,
fees DECIMAL(5,3) NOT NULL,
username VARCHAR(20),

CONSTRAINT Delivery_primary_key
PRIMARY KEY(id),

CONSTRAINT Delivery_foreign_key1
FOREIGN KEY(username) REFERENCES Admins
);
---------------------------------------------------------------------------------------------------------------------

-- Table 19
CREATE TABLE Giftcard
(
code VARCHAR(10), 
expiry_date DATETIME, 
amount INT, 
username VARCHAR(20),

CONSTRAINT Giftcard_primary_key
PRIMARY KEY(code),

CONSTRAINT Giftcard_foreign_key1
FOREIGN KEY(username) REFERENCES Admins 
);

---------------------------------------------------------------------------------------------------------------------

-- Table 10
CREATE TABLE Orders
(
order_no INT IDENTITY, 
order_date DATETIME NOT NULL, 
total_amount DECIMAL(10, 2) NOT NULL, 
cash_amount DECIMAL(10, 2), 
credit_amount DECIMAL(10, 2), 
payment_type VARCHAR(20), 
order_status VARCHAR(20) NOT NULL, 
remaining_days INT,
time_limit DATETIME, 
Gift_Card_code_used VARCHAR(10),
customer_name VARCHAR(20) NOT NULL,
delivery_id INT,
creditCard_number VARCHAR(20),

CONSTRAINT Orders_primary_key
PRIMARY KEY(order_no),

CONSTRAINT Orders_foreign_key1
FOREIGN KEY(Gift_Card_code_used) REFERENCES Giftcard,

CONSTRAINT Orders_foreign_key2
FOREIGN KEY(customer_name) REFERENCES Customer,

CONSTRAINT Orders_foreign_key3
FOREIGN KEY(delivery_id) REFERENCES Delivery,

CONSTRAINT Orders_foreign_key4
FOREIGN KEY(creditCard_number) REFERENCES Credit_Card

);
---------------------------------------------------------------------------------------------------------------------

-- Table 11
CREATE TABLE Product
(
serial_no INT IDENTITY,
product_name VARCHAR(20) NOT NULL,
category VARCHAR(20) NOT NULL, 
product_description TEXT, 
price DECIMAL(10, 2),
final_price DECIMAL(10,2),
color VARCHAR(20), 
available BIT NOT NULL DEFAULT 1,
rate INT,
vendor_username VARCHAR(20) NOT NULL, 
customer_username VARCHAR(20), 
customer_order_id INT,

CONSTRAINT Product_primary_key
PRIMARY KEY(serial_no),

CONSTRAINT Product_foreign_key1
FOREIGN KEY(vendor_username) REFERENCES Vendor,

CONSTRAINT Product_foreign_key2
FOREIGN KEY(customer_username) REFERENCES Customer,

CONSTRAINT Product_foreign_key3
FOREIGN KEY(customer_order_id) REFERENCES Orders
);

---------------------------------------------------------------------------------------------------------------------

-- Table 12
CREATE TABLE CustomerAddstoCartProduct
(
serial_no INT,
customer_name VARCHAR(20),

CONSTRAINT CustomerAddstoCartProduct_primary_key
PRIMARY KEY(serial_no, customer_name),

CONSTRAINT CustomerAddstoCartProduct_foreign_key1
FOREIGN KEY(serial_no) REFERENCES Product,

CONSTRAINT CustomerAddstoCartProduct_foreign_key2
FOREIGN KEY(customer_name) REFERENCES Customer 

);

---------------------------------------------------------------------------------------------------------------------

-- Table 13
CREATE TABLE Todays_Deals
(
deal_id INT IDENTITY,
deal_amount INT NOT NULL,
expiry_date DATETIME NOT NULL,
admin_username VARCHAR(20),

CONSTRAINT Todays_Deals_primary_key
PRIMARY KEY(deal_id),

CONSTRAINT Todays_Deals_foreign_key1
FOREIGN KEY(admin_username) REFERENCES Admins
);

---------------------------------------------------------------------------------------------------------------------

-- Table 14
CREATE TABLE Todays_Deals_Product
(
deal_id INT,
serial_no INT,

CONSTRAINT Todays_Deals_Product_primary_key
PRIMARY KEY(deal_id, serial_no),

CONSTRAINT Todays_Deals_Product_foreign_key1
FOREIGN KEY(deal_id) REFERENCES Todays_Deals, 

constraint Todays_Deals_Product_foreign_key2
FOREIGN KEY(serial_no) REFERENCES Product 
);

---------------------------------------------------------------------------------------------------------------------

-- Table 15
CREATE TABLE offer
(
offer_id INT IDENTITY, 
offer_amount INT NOT NULL, 
expiry_date DATETIME NOT NULL,

CONSTRAINT offer_primary_key
PRIMARY KEY(offer_id)
);

---------------------------------------------------------------------------------------------------------------------

-- Table 16
CREATE TABLE offersOnProduct
(
offer_id INT, 
serial_no INT,

CONSTRAINT offersOnProduct_primary_key
PRIMARY KEY(offer_id, serial_no),

CONSTRAINT offersOnProduct_foreign_key1
FOREIGN KEY(offer_id) REFERENCES offer,

CONSTRAINT offersOnProduct_foreign_key2
FOREIGN KEY(serial_no) REFERENCES Product
);

---------------------------------------------------------------------------------------------------------------------

-- Table 17
CREATE TABLE Customer_Question_Product
(
serial_no INT, 
customer_name VARCHAR(20),
question VARCHAR(50) NOT NULL, 
answer TEXT,

CONSTRAINT Customer_Question_Product_primary_key
PRIMARY KEY(serial_no, customer_name),

CONSTRAINT Customer_Question_Product_foreign_key1 
FOREIGN KEY(serial_no) REFERENCES Product, 

CONSTRAINT Customer_Question_Product_foreign_key2
FOREIGN KEY(customer_name) REFERENCES Customer
);

---------------------------------------------------------------------------------------------------------------------

-- Table 18
CREATE TABLE Wishlist
(
username VARCHAR(20), 
name VARCHAR(20),

CONSTRAINT Wishlist_primary_key
PRIMARY KEY(username, name),

CONSTRAINT Wishlist_foreign_key1
FOREIGN KEY(username) REFERENCES Customer
);

---------------------------------------------------------------------------------------------------------------------

-- Table 20
CREATE TABLE Wishlist_Product
(
username VARCHAR(20), 
wish_name VARCHAR(20),
serial_no INT,

CONSTRAINT Wishlist_Product_primary_key
PRIMARY KEY(username, wish_name, serial_no),

CONSTRAINT Wishlist_Product_foreign_key1
FOREIGN KEY(username, wish_name) REFERENCES Wishlist,

CONSTRAINT Wishlist_Product_foreign_key2
FOREIGN KEY(serial_no) REFERENCES Product
);

---------------------------------------------------------------------------------------------------------------------

-- Table 21
CREATE TABLE Admin_Customer_Giftcard
(
code VARCHAR(10), 
customer_name VARCHAR(20), 
admin_username VARCHAR(20),
remaining_points INT,

CONSTRAINT Admin_Customer_Giftcard_primary_key
PRIMARY KEY(code, customer_name, admin_username),

CONSTRAINT Admin_Customer_Giftcard_foreign_key1
FOREIGN KEY(code) REFERENCES Giftcard, 

CONSTRAINT Admin_Customer_Giftcard_foreign_key2
FOREIGN KEY(customer_name) REFERENCES Customer,

CONSTRAINT Admin_Customer_Giftcard_foreign_key3
FOREIGN KEY(admin_username) REFERENCES Admins 
);

---------------------------------------------------------------------------------------------------------------------

-- Table 22
create table Admin_Delivery_Order
(
delivery_username VARCHAR(20),
order_no INT, 
admin_username VARCHAR(20),
delivery_window VARCHAR(50),

CONSTRAINT Admin_Delivery_Order_primary_key
PRIMARY KEY(delivery_username, order_no),

CONSTRAINT Admin_Delivery_Order_foreign_key1
FOREIGN KEY(delivery_username) REFERENCES Delivery_Person, 

CONSTRAINT Admin_Delivery_Order_foreign_key2
FOREIGN KEY(order_no) REFERENCES Orders,  

CONSTRAINT Admin_Delivery_Order_foreign_key3
FOREIGN KEY(admin_username) REFERENCES Admins 
);

---------------------------------------------------------------------------------------------------------------------

-- Table 23
CREATE TABLE Customer_CreditCard
(
customer_name VARCHAR(20),
cc_number VARCHAR(20),

CONSTRAINT Customer_CreditCard_primary_key
PRIMARY KEY(customer_name, cc_number),

CONSTRAINT Customer_CreditCard_foreign_key1
FOREIGN KEY(customer_name) REFERENCES Customer,

CONSTRAINT Customer_CreditCard_foreign_key2
FOREIGN KEY(cc_number) REFERENCES Credit_Card
);

---------------------------------------------------------------------------------------------------------------------
