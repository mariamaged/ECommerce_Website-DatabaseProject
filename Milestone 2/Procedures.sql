-- USER STORIES
-- FIRST, unregistered User

-- (1)(a1)
CREATE PROC customerRegister

@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50),
@return bit output


AS
BEGIN


IF(@first_name IS NOT NULL AND @last_name IS NOT NULL AND @password IS NOT NULL and @email is not null and @username is not null)
	BEGIN
	IF(EXISTS(
    SELECT * FROM Customer WHERE username=@username))
	BEGIN
	SET @return=1
	END 

	ELSE
	BEGIN

	SET @return=0
	INSERT INTO Users(username, password, first_name, last_name, email)
	VALUES(@username, @password, @first_name, @last_name, @email);

	INSERT INTO Customer(username)
	VALUES(@username);

	PRINT('Registeration successful!');
	END
	END


END 
GO

-- (2)(a2)
CREATE PROC vendorRegister

@username VARCHAR(20),
@first_name VARCHAR(20), 
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50), 
@company_name VARCHAR(20), 
@bank_acc_no VARCHAR(20),
@return bit output


AS
BEGIN


IF(@first_name IS NOT NULL AND @last_name IS NOT NULL AND @password IS NOT NULL and @username IS NOT NULL AND @email IS NOT NULL AND
@company_name IS NOT NULL AND @bank_acc_no IS NOT NULL)
	BEGIN
	IF(EXISTS(
	SELECT * FROM Vendor WHERE username=@username))
	BEGIN
	SET @return=1;
	END
	ELSE
	BEGIN
	SET @return=0

	INSERT INTO Users(username, password, first_name, last_name, email)
	VALUES(@username, @password, @first_name, @last_name, @email);

	INSERT INTO Vendor(username, company_name, bank_acc_no)
	VALUES(@username, @company_name, @bank_acc_no);
	
	PRINT('Registeration successful!');
	END
	END


END
GO
---------------------------------------------------------------------------------------------------------------------------------------
-- SECOND, registered User

-- (3)(a)
CREATE PROC userLogin

@username VARCHAR(20), 
@password VARCHAR(20),
@success BIT OUTPUT,
@type INT OUTPUT

AS
BEGIN


IF(EXISTS(
SELECT U.*
FROM Users U
WHERE U.username  = @username)) -- Checks existence of user.
	BEGIN
	IF(EXISTS(
	SELECT U.*
	FROM Users U
	WHERE U.username = @username AND U.password = @password)) -- Checks that the password is correct.
		BEGIN
		SELECT @success  = 1;
		PRINT('Login successful!');
		PRINT('Success: 1');
		END

	ELSE
		BEGIN
		SELECT @success  = 0;
		PRINT('Success: 0');
		IF(EXISTS(
		   SELECT U.*
		   FROM Users U
		   WHERE U.password = @password))
			BEGIN
			SELECT @type = NULL;
			PRINT('Wrong password!');
			END
		
		ELSE
			BEGIN
			SELECT @type = -1;
			PRINT('Type: -1');
			PRINT('Password does not exist!');
			END
		END

	END
ELSE
	BEGIN
	SELECT @success = 0;
	PRINT('Success: 0');
	PRINT('User not found!');
	SELECT @type = NULL;
	END

IF(@success = 1) -- Checks type of user.
	BEGIN
	IF(EXISTS(
	SELECT U.*
	FROM Users U
	INNER JOIN Customer C
	ON U.username = C.username
	WHERE U.username = @username))
		BEGIN
		SELECT @type = 0;
		PRINT('Type: 0');
		END 

    ELSE IF(EXISTS(
	SELECT U.*
	FROM Users U
	INNER JOIN Vendor V
	ON U.username = V.username
	WHERE U.username = @username))
		BEGIN
		SELECT @type = 1;
		PRINT('Type: 1');
		END

    ELSE IF(EXISTS(
	SELECT U.*
	FROM Users U
	INNER JOIN Admins A
	ON U.username = A.username
	WHERE U.username = @username))
		BEGIN
		SELECT @type = 2;
		PRINT('Type: 2');
		END

    ELSE IF(EXISTS(
	SELECT U.*
	FROM Users U
	INNER JOIN Delivery_Person DP
	ON U.username = DP.username
	WHERE U.username = @username))
		BEGIN
		SELECT @type = 3;
		PRINT('Type: 3');
		END
	END


END
GO

-- (4)(b)
CREATE PROC addMobile

@username VARCHAR(20), 
@mobile_number VARCHAR(20)

AS 
BEGIN


IF(EXISTS(
SELECT U.*
FROM Users U
WHERE U.username = @username AND U.first_name IS NOT NULL AND U.last_name IS NOT NULL AND U.password IS NOT NULL))
	BEGIN
	INSERT INTO User_mobile_numbers(mobile_number, username)
	VALUES(@mobile_number, @username);
	END


END 
GO

-- (5)(c)
CREATE PROC addAddress

@username VARCHAR(20),
@address VARCHAR(100)

AS 
BEGIN


IF(EXISTS(
SELECT U.*
FROM Users U
WHERE U.username = @username AND U.first_name IS NOT NULL AND U.last_name IS NOT NULL AND U.password IS NOT NULL))
	BEGIN
	INSERT INTO User_Addresses(address, username)
	VALUES(@address, @username);
	END


END 
GO
---------------------------------------------------------------------------------------------------------------------------------------
-- Customer

-- (6)(a)
CREATE PROC showProducts

AS
BEGIN
 

SELECT P.serial_no, P.available, P.product_name, CAST(P.product_description AS VARCHAR(MAX)) AS product_description, P.price, P.final_price, P.color
FROM Product P;


END
GO

-- (7)(b)
CREATE PROC ShowProductsbyPrice

AS
BEGIN


SELECT P.serial_no, P.available, P.product_name, CAST(P.product_description AS VARCHAR(MAX)) AS product_description, P.price, P.final_price, P.color
FROM Product P
ORDER BY P.price ASC;


END
GO

-- (8)(c)
CREATE PROC searchbyname

@text VARCHAR(20)

AS
BEGIN


SELECT P.product_name, CAST(P.product_description AS VARCHAR(MAX)) AS product_description, P.price, P.final_price, P.color
FROM Product P
WHERE P.product_name LIKE '%' + @text + '%';


END
GO

-- (9)(d)
CREATE PROC AddQuestion

@serial INT, 
@customer VARCHAR(20), 
@Question VARCHAR(50)

AS
BEGIN


ALTER TABLE Customer_Question_Product
DROP CONSTRAINT Customer_Question_Product_foreign_key1;

ALTER TABLE Customer_Question_Product
ADD CONSTRAINT Customer_Question_Product_foreign_key1
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO Customer_Question_Product(serial_no, customer_name, question)
VALUES(@serial, @customer, @Question);


END
GO

-- (10)(e1)
CREATE PROC addToCart

@customername VARCHAR(20),
@serial INT

AS
BEGIN


ALTER TABLE CustomerAddstoCartProduct
DROP CONSTRAINT CustomerAddstoCartProduct_foreign_key1;

ALTER TABLE CustomerAddstoCartProduct
ADD CONSTRAINT CustomerAddstoCartProduct_foreign_key1
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE;


INSERT INTO CustomerAddstoCartProduct(serial_no, customer_name)
VALUES(@serial, @customername);


END
GO

-- (11)(e2)
CREATE PROC removefromCart

@customername VARCHAR(20),
@serial INT

AS
BEGIN


DELETE FROM CustomerAddstoCartProduct
WHERE serial_no = @serial AND customer_name = @customername;


END
GO

-- (12)(f)
CREATE PROC createWishlist

@customername VARCHAR(20),
@name VARCHAR(20)


AS
BEGIN


INSERT INTO Wishlist(username, name)
VALUES(@customername, @name);


END
GO

-- (13)(g1)
CREATE PROC AddtoWishlist

@customername VARCHAR(20), 
@wishlistname VARCHAR(20), 
@serial INT

AS
BEGIN


ALTER TABLE Wishlist_Product
DROP CONSTRAINT Wishlist_Product_foreign_key1;

ALTER TABLE Wishlist_Product
ADD CONSTRAINT Wishlist_Product_foreign_key1
FOREIGN KEY(username, wish_name) REFERENCES Wishlist ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Wishlist_Product
DROP CONSTRAINT Wishlist_Product_foreign_key2;

ALTER TABLE Wishlist_Product
ADD CONSTRAINT Wishlist_Product_foreign_key2
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE;

IF(NOT EXISTS(
SELECT W.*
FROM Wishlist W
WHERE W.username = @customername AND W.name = @wishlistname))
	BEGIN
	INSERT INTO Wishlist(username, name)
	VALUES(@customername, @wishlistname);

	INSERT INTO Wishlist_Product(username, wish_name, serial_no)
	VALUES(@customername, @wishlistname, @serial);
	END

ELSE
	BEGIN
	INSERT INTO Wishlist_Product(username, wish_name, serial_no)
	VALUES(@customername, @wishlistname, @serial);
	END


END 
GO

-- (14)(g2)
CREATE PROC removefromWishlist

@customername VARCHAR(20), 
@wishlistname VARCHAR(20), 
@serial INT

AS
BEGIN


DELETE FROM Wishlist_Product
WHERE username = @customername AND wish_name = @wishlistname AND serial_no = @serial;


END
GO

-- (15)(h)
CREATE PROC showWishlistProduct

@customername VARCHAR(20), 
@name VARCHAR(20)

AS
BEGIN


SELECT P.serial_no, P.product_name, CAST(P.product_description AS VARCHAR(MAX)) AS product_description, P.price, P.final_price, P.color
FROM Wishlist_Product WP
INNER JOIN Product P
ON P.serial_no = WP.serial_no
WHERE WP.username = @customername AND WP.wish_name = @name;


END
GO

-- (16)(i)
CREATE PROC viewMyCart

@customer VARCHAR(20)

AS
BEGIN


SELECT P.serial_no, P.product_name, CAST(P.product_description AS VARCHAR(MAX)) AS product_description , P.price, P.final_price, P.color
FROM Product P
INNER JOIN CustomerAddstoCartProduct CAtCP 
ON P.serial_no = CAtCP.serial_no
WHERE CAtCP.customer_name = @customer;


END
GO

-- (17)(j1)
CREATE PROC calculatepriceOrder

@customername VARCHAR(20),
@sum DECIMAL(10, 2) OUTPUT

AS
BEGIN


SELECT @sum =  SUM(P.final_price) 
			   FROM Product P
			   INNER JOIN CustomerAddstoCartProduct CAtCP
			   ON P.serial_no = CAtCP.serial_no
			   WHERE CAtCP.customer_name = @customername;

PRINT(@sum);
END
GO

-- (18)(j2)
CREATE PROC productsinorder

@customername VARCHAR(20), 
@orderID INT

AS
BEGIN


-- Changes the customer_username and customer_order_id fields in the Product table.
UPDATE Product
SET available = 0, customer_username = @customername, customer_order_id = @orderID
WHERE serial_no IN
(
SELECT CAtCP.serial_no
FROM CustomerAddstoCartProduct CAtCP
WHERE CAtCP.customer_name = @customername
);

-- Deletes customers that have the same stuff in their cart.
DELETE FROM CustomerAddstoCartProduct
WHERE serial_no IN 
(
SELECT CAtCP.serial_no
FROM CustomerAddstoCartProduct CAtCP
WHERE CAtCP.customer_name = @customername
) 
AND customer_name <> @customername;


END
GO

-- (19)(j3)
CREATE PROC emptyCart

@customername VARCHAR(20)

AS
BEGIN


DELETE FROM CustomerAddstoCartProduct
WHERE customer_name = @customername;


END
GO

-- (20)(j4)
CREATE PROC makeOrder

@customername VARCHAR(20)

AS
BEGIN


-- Declare variables to hold total price for order and order number.
DECLARE @total_price DECIMAL(10, 2);
DECLARE @orderNumber INT;

-- Calculate total price for order.
EXEC calculatepriceOrder @customername = @customername, @sum  = @total_price OUTPUT;

-- Create a new order with the customer's name and the total price.
ALTER TABLE Orders
DROP CONSTRAINT Orders_foreign_key3;

ALTER TABLE Orders
ADD CONSTRAINT Orders_foreign_key3
FOREIGN KEY(delivery_id) REFERENCES Delivery ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Orders
DROP CONSTRAINT Orders_foreign_key4;

ALTER TABLE Orders
ADD CONSTRAINT Orders_foreign_key4
FOREIGN KEY(creditCard_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO Orders(order_date, total_amount, order_status, customer_name)
VALUES(CURRENT_TIMESTAMP, @total_price, 'not processed', @customername);

-- Retrive the customer's order order number.
SELECT @orderNumber = MAX(O.order_no)
					  FROM Orders O;

-- Update the product table and delete the other customers tuples with the same current customer's cart.                    
EXEC productsinorder @customername = @customername, @orderID = @orderNumber;

-- Empty the customer's cart.
EXEC emptyCart @customername = @customername;


END
GO

-- (21)(k)
CREATE PROC cancelOrder

@orderid INT

AS
BEGIN


DECLARE @total DECIMAL(10,2), @returnedPoints INT, @points INT, @remainingpoints INT, @customer VARCHAR(20), @gift VARCHAR(10), @time DATETIME, @payment VARCHAR(20);
DECLARE @credit DECIMAL(10, 2);
DECLARE @cash DECIMAL(10, 2);

IF(EXISTS(
SELECT O.*
FROM Orders O
WHERE O.order_no = @orderid AND (O.order_status = 'not processed' OR O.order_status = 'in process'))) -- Checks if the order_status is in process or not processed.
	BEGIN
	SELECT @total = O.total_amount FROM Orders O WHERE O.order_no = @orderid;

	SELECT @customer = O.customer_name FROM Orders O WHERE O.order_no = @orderid;

	SELECT @gift = O.Gift_Card_code_used -- Will be null if he paid totally using credit or cash.
				   FROM Orders O
				   WHERE O.order_no = @orderid;

	SELECT @time = Gf.expiry_date FROM Giftcard Gf WHERE Gf.code = @gift;

	SELECT @payment = O.payment_type FROM Orders O WHERE O.order_no = @orderid;

	SELECT @credit = O.credit_amount FROM Orders O WHERE O.order_no = @orderid;

	SELECT @cash = O.cash_amount FROM Orders O WHERE O.order_no = @orderid;

	SELECT @points = C.points FROM Customer C WHERE C.username = @customer;

	SELECT @remainingpoints = ACG.remaining_points FROM Admin_Customer_Giftcard ACG WHERE ACG.code = @gift AND ACG.customer_name = @customer;

	IF(@time > CURRENT_TIMESTAMP)	-- Checks that the gift card used was not expired.
			BEGIN
			IF(@payment = 'credit')
				BEGIN
				SELECT @returnedPoints = @total - @credit;
				END
			IF(@payment = 'cash')
				BEGIN
				SELECT @returnedPoints = @total - @cash;
				END
			UPDATE Customer
			SET points = @points + @returnedPoints
			WHERE username = @customer;

			UPDATE Admin_Customer_Giftcard
			SET remaining_points = @remainingpoints + @returnedPoints
			WHERE customer_name = @customer AND code = @gift;
			END

	-- Updates the products that were in the order.
	UPDATE Product
	SET available = 1, customer_username = NULL, customer_order_id = NULL
	WHERE customer_order_id = @orderid;

	-- Deletes the order from the order table.
	DELETE FROM Orders 
	WHERE order_no = @orderid;
	END


END
GO

-- (22)(l)
CREATE PROC returnProduct

@serialno INT, 
@orderid INT

AS
BEGIN


DECLARE @total DECIMAL(10,2), @returnedPoints INT, @points INT, @remainingpoints INT, @customer VARCHAR(20), @gift VARCHAR(10), @time DATETIME;
DECLARE @payment VARCHAR(20);
DECLARE @credit DECIMAL(10, 2);
DECLARE @cash DECIMAL(10, 2);
DECLARE @productprice DECIMAL(10, 2);

IF(EXISTS(
SELECT O.*
FROM Orders O
WHERE O.order_no = @orderid AND O.order_status = 'delivered'))
	BEGIN
	SELECT @total = O.total_amount FROM Orders O WHERE O.order_no = @orderid;

	SELECT @customer = O.customer_name FROM Orders O WHERE O.order_no = @orderid;

	SELECT @gift = O.Gift_Card_code_used FROM Orders O WHERE O.order_no = @orderid;

	SELECT @payment = O.payment_type FROM Orders O WHERE O.order_no = @orderid;

	SELECT @credit = O.credit_amount FROM Orders O WHERE O.order_no = @orderid;

	SELECT @cash =	O.cash_amount FROM Orders O WHERE O.order_no = @orderid;

	SELECT @time = Gf.expiry_date FROM Giftcard Gf WHERE Gf.code = @gift;

	SELECT @points = C.points FROM Customer C WHERE C.username = @customer;

	SELECT @remainingpoints = ACG.remaining_points FROM Admin_Customer_Giftcard ACG WHERE ACG.code = @gift AND ACG.customer_name = @customer;

	SELECT @productprice = P.final_price FROM Product P WHERE P.serial_no = @serialno;

	IF(@time > CURRENT_TIMESTAMP)	-- Checks that the gift card used was not expired.
			BEGIN
			SELECT @returnedPoints = @total - @productprice;
			UPDATE Customer
			SET points = @points + @returnedPoints
			WHERE username = @customer;

			UPDATE Admin_Customer_Giftcard
			SET remaining_points = @remainingpoints + @returnedPoints
			WHERE customer_name = @customer AND code = @gift;
			END

			-- Updates the product returned.
			UPDATE Product
			SET available = 1, customer_username = NULL, customer_order_id = NULL
			WHERE serial_no = @serialno;

			UPDATE Orders
			SET total_amount = @total - @productprice
			WHERE order_no = @orderid;
	END


END
GO

-- (23)(m)
CREATE PROC ShowproductsIbought

@customername VARCHAR(20)

AS
BEGIN


SELECT P.serial_no, P.product_name, P.category, CAST(P.product_description AS VARCHAR(MAX)) AS product_description, P.price, P.final_price, P.color
FROM Product P
WHERE P.customer_username = @customername;


END
GO

-- (24)(n)
CREATE PROC rate

@serialno INT,
@rate INT,
@customername VARCHAR(20)

AS
BEGIN


UPDATE Product
SET rate = @rate
WHERE serial_no = @serialno AND customer_username = @customername;


END
GO

-- (25)(o)
CREATE PROC SpecifyAmount

@customername VARCHAR(20),
@orderID INT,
@cash DECIMAL(10,2),
@credit DECIMAL(10,2)

AS
BEGIN


DECLARE @takenPoints INT;
DECLARE @totalPrice DECIMAL(10, 2);
DECLARE @gift VARCHAR(10);

-- Get the total price.
SELECT @totalPrice = O.total_amount
					 FROM Orders O
					 WHERE O.order_no = @orderID;

-- Get the user's giftcard (if there is one active giftcard applied to him, this will return one value. If there no giftcard, this will return null).
SELECT @gift =  ACG.code
				FROM Admin_Customer_Giftcard ACG
				INNER JOIN Giftcard Gf
				ON Gf.code = ACG.code
				WHERE ACG.customer_name = @customername AND Gf.expiry_date > CURRENT_TIMESTAMP;

IF(@cash IS NULL OR @cash = 0) -- Payment type will be credit.
	BEGIN
	SELECT @takenPoints = @totalPrice - @credit;
	
	UPDATE Orders 
	SET payment_type = 'credit', cash_amount = 0, credit_amount = @credit
	WHERE order_no = @orderID;

	IF(@takenPoints <> 0)
		BEGIN
		UPDATE Orders
		SET Gift_Card_code_used = @gift
		WHERE order_no = @orderID;

		UPDATE Customer 
		SET points = points - @takenPoints
		WHERE username = @customername;

		UPDATE Admin_Customer_Giftcard
		SET remaining_points = remaining_points - @takenPoints
		WHERE code = @gift AND customer_name = @customername;
		END
	END

IF(@credit IS NULL OR @credit = 0) -- Payment type will be cash.
	BEGIN
	SELECT @takenPoints = @totalPrice - @cash;

	UPDATE Orders 
	SET payment_type = 'cash', cash_amount = @cash, credit_amount = 0
	WHERE order_no = @orderID;

	IF(@takenPoints <> 0)
		BEGIN
		UPDATE Orders
		SET Gift_Card_code_used = @gift
		WHERE order_no = @orderID;

		UPDATE Customer 
		SET points = points - @takenPoints
		WHERE username = @customername;

		UPDATE Admin_Customer_Giftcard
		SET remaining_points = remaining_points - @takenPoints
		WHERE code = @gift AND customer_name = @customername;
		END
	END


END
GO

-- (26)(p)
CREATE PROC AddCreditCard

@creditcardnumber VARCHAR(20),
@expirydate DATE,
@cvv VARCHAR(4),
@customername VARCHAR(20)

AS
BEGIN


ALTER TABLE Customer_CreditCard
DROP CONSTRAINT Customer_CreditCard_foreign_key2;

ALTER TABLE Customer_CreditCard
ADD CONSTRAINT Customer_CreditCard_foreign_key2
FOREIGN KEY(cc_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE;

IF(NOT EXISTS(
SELECT CC.*
FROM Credit_Card CC
WHERE CC.number = @creditcardnumber))
	BEGIN
	INSERT INTO Credit_Card(number, expiry_date, cvv_code)
	VALUES(@creditcardnumber, @expirydate, @cvv);

	IF(@customername IS NOT NULL)
		BEGIN
		INSERT INTO Customer_CreditCard(customer_name, cc_number)
		VALUES(@customername, @creditcardnumber);
		END
	END


ELSE
	BEGIN
	IF(@customername IS NOT NULL)
		BEGIN
		INSERT INTO Customer_CreditCard(customer_name, cc_number)
		VALUES(@customername, @creditcardnumber);
		END
	END


END
GO

-- (27)(q)
CREATE PROC ChooseCreditCard 

@creditcard VARCHAR(20),
@orderid INT

AS
BEGIN

DECLARE @customer VARCHAR(20);

SELECT @customer = O.customer_name
				   FROM Orders O
				   WHERE O.order_no = @orderid;
IF(EXISTS(
SELECT CC.*
FROM Customer_CreditCard CC
WHERE CC.cc_number = @creditcard AND CC.customer_name = @customer))
	BEGIN
	UPDATE Orders
	SET creditCard_number = @creditcard
	WHERE order_no = @orderid AND payment_type = 'credit';
	END


END
GO

-- (28)(r)
CREATE PROC vewDeliveryTypes

AS
BEGIN


SELECT D.type, D.time_duration AS Duration_in_days, D.fees
FROM Delivery D;


END
GO

-- (29)(s)
CREATE PROC specifydeliverytype

@orderID INT,
@deliveryID INT

AS
BEGIN


DECLARE @time INT, @order DATETIME, @limit DATETIME;

UPDATE Orders
SET delivery_id = @deliveryID
WHERE order_no = @orderID;

SELECT @time = D.time_duration
			   FROM Delivery D
			   WHERE D.id = @deliveryID;

SELECT @order = O.order_date
				FROM Orders O
				WHERE O.order_no = @orderID;

SELECT @limit = DATEADD(DAY, @time, @order);

UPDATE Orders
SET remaining_days = DATEDIFF(DAY, CURRENT_TIMESTAMP, @LIMIT)
WHERE order_no = @orderID;


END
GO

-- (30)(t)
CREATE PROC trackRemainingDays

@orderid INT,
@customername VARCHAR(20),
@days INT OUTPUT

AS
BEGIN


DECLARE @time INT, @order DATETIME, @limit DATETIME;

SELECT @time = D.time_duration
			   FROM Delivery D
			   INNER JOIN Orders O
			   ON O.delivery_id = D.id
			   WHERE O.order_no = @orderid;

SELECT @order = O.order_date
				FROM Orders O
				WHERE O.order_no = @orderID;

SELECT @limit = DATEADD(DAY, @time, @order);
SELECT @days = DATEDIFF(DAY, CURRENT_TIMESTAMP, @LIMIT)

UPDATE Orders
SET remaining_days = @days
WHERE order_no = @orderID;


END
GO

---------------------------------------------------------------------------------------------------------------------------------------
-- Vendor

--(32)(a)
CREATE PROC postProduct

@vendorUsername VARCHAR(20), 
@product_name VARCHAR(20),
@category VARCHAR(20), 
@product_description TEXT,
@price DECIMAL(10,2), 
@color VARCHAR(20)

AS
BEGIN


ALTER TABLE Product
DROP CONSTRAINT Product_foreign_key1;

ALTER TABLE Product
ADD CONSTRAINT Product_foreign_key1
FOREIGN KEY(vendor_username) REFERENCES Vendor ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE Product
DROP CONSTRAINT Product_foreign_key3;

ALTER TABLE Product
ADD CONSTRAINT Product_foreign_key3
FOREIGN KEY(customer_order_id) REFERENCES Orders ON DELETE SET NULL ON UPDATE CASCADE;

	INSERT INTO Product(product_name, category, product_description, price, final_price, color, vendor_username)
	VALUES(@product_name, @category, @product_description, @price, @price, @color, @vendorUsername);
	


END
GO

--(33)(b)
CREATE PROC vendorviewProducts

@vendorname VARCHAR(20)

AS
BEGIN


	SELECT P.*
	FROM Product P
	WHERE P.vendor_username = @vendorname;


END
GO

--(34)(c)
CREATE PROC EditProduct

@vendorname VARCHAR(20), 
@serialnumber INT,
@product_name VARCHAR(20),
@category VARCHAR(20),
@product_description TEXT, 
@price DECIMAL(10, 2), 
@color VARCHAR(20)

AS
BEGIN


	-- Change product name
	IF(@product_name IS NOT NULL)
		BEGIN
		UPDATE Product
		SET product_name = @product_name
		WHERE vendor_username  = @vendorname AND serial_no = @serialnumber;
		END

	-- Change category
	IF(@category IS NOT NULL)
		BEGIN
		UPDATE Product
		SET category = @category
		WHERE vendor_username  = @vendorname AND serial_no = @serialnumber;
		END

	-- Change product_description
	IF(@product_description IS NOT NULL)
		BEGIN
		UPDATE Product
		SET product_description  = @product_description 
		WHERE vendor_username  = @vendorname AND serial_no = @serialnumber;
		END

	-- Change price
	IF(@price IS NOT NULL)
		BEGIN
		UPDATE Product
		SET price  = @price
		WHERE vendor_username  = @vendorname AND serial_no = @serialnumber;
		END

	-- Change color
	IF(@color IS NOT NULL)
		BEGIN
		UPDATE Product
		SET color  = @color
		WHERE vendor_username  = @vendorname AND serial_no = @serialnumber;
		END


END
GO

-- (35)(d)
CREATE PROC deleteProduct

@vendorname VARCHAR(20),
@serialnumber INT

AS
BEGIN


	DELETE FROM Product
	WHERE vendor_username  = @vendorname AND serial_no = @serialnumber;


END
GO

-- (36)(e)
CREATE PROC viewQuestions

@vendorname VARCHAR(20)

AS
BEGIN


	SELECT CQP.serial_no, CQP.customer_name, CQP.question
	FROM Customer_Question_Product CQP
	WHERE CQP.serial_no IN (
	SELECT P.serial_no
	FROM Product P
	WHERE P.vendor_username = @vendorname 
                           );


END
GO

-- (37)(f)
CREATE PROC answerQuestions

@vendorname VARCHAR(20), 
@serialno INT, 
@customername VARCHAR(20), 
@answer TEXT

AS
BEGIN


	UPDATE Customer_Question_Product
	SET answer = @answer
	WHERE serial_no = @serialno AND customer_name = @customername AND serial_no IN (
	SELECT P.serial_no
	FROM Product P
	WHERE P.vendor_username = @vendorname										   );


END
GO

-- (38)(g1)
CREATE PROC addOffer

@offeramount INT,
@expiry_date DATETIME

AS
BEGIN


INSERT INTO offer(offer_amount, expiry_date)
VALUES(@offeramount, @expiry_date);


END
GO

-- (39)(g2)
CREATE PROC checkOfferonProduct

@serial INT,
@activeoffer BIT OUTPUT

AS
BEGIN


IF(EXISTS(
SELECT ooP.*
FROM offersOnProduct ooP
INNER JOIN offer o
ON o.offer_id = ooP.offer_id
WHERE ooP.serial_no = @serial AND o.expiry_date > CURRENT_TIMESTAMP))
	BEGIN
	SELECT @activeoffer = 1;
	END

ELSE
	BEGIN
	SELECT @activeoffer = 0;
	END


END
GO

-- (40)(g3)
CREATE PROC checkandremoveExpiredoffer

@offerid INT

AS
BEGIN


DECLARE @expiry DATETIME;

SELECT @expiry = o.expiry_date
				 FROM offer o
				 WHERE o.offer_id = @offerid;

IF(@expiry <= CURRENT_TIMESTAMP) -- Checks that it has expired.
	BEGIN
	UPDATE Product
	SET final_price = price
	WHERE serial_no IN
	(
	SELECT ooP.serial_no
	FROM offersOnProduct ooP
	WHERE ooP.offer_id = @offerid
	);

	DELETE FROM offersOnProduct
	WHERE offer_id = @offerid;

	DELETE FROM offer
	WHERE offer_id = @offerid;
	END


END
GO

-- (41)(g4)
CREATE PROC applyOffer

@vendorname VARCHAR(20),
@offerid INT,
@serial INT

AS
BEGIN


DECLARE @active BIT;
DECLARE @expiry DATETIME;
DECLARE @newprice DECIMAL(10, 2), @oldprice DECIMAL(10, 2), @amount INT;
-- Checks that the offer exists in the offer table.
IF(EXISTS(
SELECT o.*
FROM offer o
WHERE o.offer_id = @offerid))
	BEGIN
	SELECT @expiry  = o.expiry_date
					  FROM offer o
					  WHERE o.offer_id = @offerid;

	-- Checks if it has an active offer.
	EXEC checkOfferonProduct @serial = @serial, @activeoffer = @active OUTPUT;

	
	-- Checks that the offer was not expired.
	IF(@active = 0 AND @expiry > CURRENT_TIMESTAMP)
			BEGIN
			ALTER TABLE offersOnProduct
			DROP CONSTRAINT offersOnProduct_foreign_key1;

			ALTER TABLE offersOnProduct
			ADD CONSTRAINT offersOnProduct_foreign_key1
			FOREIGN KEY(offer_id) REFERENCES offer ON DELETE CASCADE ON UPDATE CASCADE;

			ALTER TABLE offersOnProduct
			DROP CONSTRAINT offersOnProduct_foreign_key2;

			ALTER TABLE offersOnProduct 
			ADD CONSTRAINT offersOnProduct_foreign_key2
			FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE;

			INSERT INTO offersOnProduct(offer_id, serial_no)
			VALUES(@offerid, @serial);

			SELECT @amount = o.offer_amount
							 FROM offer o
							 WHERE o.offer_id = @offerid;

			SELECT @oldprice = P.final_price
							   FROM Product P
							   WHERE P.serial_no = @serial;

			SET @newprice = @oldprice - ((@amount*@oldprice)/100);

			UPDATE Product
			SET final_price = @newprice
			WHERE serial_no = @serial AND vendor_username = @vendorname;
			END

		ELSE IF(@expiry > CURRENT_TIMESTAMP)
			BEGIN
			PRINT('There is an active offer on that product!');
			END
		END


END
GO

---------------------------------------------------------------------------------------------------------------------------------------
-- Admins

-- (42)(a)
CREATE PROC activateVendors

@admin_username VARCHAR(20),
@vendor_username VARCHAR(20)

AS 
BEGIN


UPDATE Vendor
SET admin_username = @admin_username,
	activated = 1
WHERE username = @vendor_username;


END 
GO

-- (43)(b)
CREATE PROC inviteDeliveryPerson

@delivery_username VARCHAR(20),
@delivery_email VARCHAR(50)

AS 
BEGIN


INSERT INTO Users(username, email)
VALUES(@delivery_username, @delivery_email);

INSERT INTO Delivery_Person(username)
VALUES(@delivery_username);


END 
GO

-- (44)(c)
CREATE PROC reviewOrders

AS 
BEGIN


SELECT O.*, P.serial_no, P.product_name, P.category, CAST(P.product_description AS VARCHAR(MAX)) AS product_description, P.price, P.final_price, P.color, P.available, P.rate, P.vendor_username, P.customer_username
FROM Orders O
INNER JOIN Product P
ON O.order_no = P.customer_order_id
ORDER BY O.order_no;


END 
GO

-- (45)(d)
CREATE PROC updateOrderStatusInProcess

@order_no INT

AS 
BEGIN


UPDATE Orders
SET order_status = 'in process'
WHERE order_no = @order_no;


END 
GO

-- (46)(e)
CREATE PROC addDelivery

@delivery_type VARCHAR(20),
@time_duration INT,
@fees DECIMAL(5,3),
@admin_username VARCHAR(20)

AS 
BEGIN


INSERT INTO Delivery(type, time_duration, fees, username)
VALUES(@delivery_type, @time_duration, @fees, @admin_username);


END 
GO

-- (47)(f)
CREATE PROC assignOrdertoDelivery

@delivery_username VARCHAR(20),
@order_no INT,
@admin_username VARCHAR(20)

AS 
BEGIN


ALTER TABLE Admin_Delivery_Order
DROP CONSTRAINT Admin_Delivery_Order_foreign_key1;

ALTER TABLE Admin_Delivery_Order
ADD CONSTRAINT Admin_Delivery_Order_foreign_key1
FOREIGN KEY(delivery_username) REFERENCES Delivery_Person ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Admin_Delivery_Order
DROP CONSTRAINT Admin_Delivery_Order_foreign_key2;

ALTER TABLE Admin_Delivery_Order
ADD CONSTRAINT Admin_Delivery_Order_foreign_key2
FOREIGN KEY(order_no) REFERENCES Orders ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO Admin_Delivery_Order(delivery_username, order_no, admin_username)
VALUES(@delivery_username, @order_no, @admin_username);


END 
GO

-- (48)(g1)
CREATE PROC createTodaysDeal

@deal_amount INT,
@admin_username VARCHAR(20),
@expiry_date DATETIME

AS 
BEGIN


INSERT INTO Todays_Deals(deal_amount, expiry_date, admin_username)
VALUES(@deal_amount, @expiry_date, @admin_username);


END 
GO

-- (49)(g2)
CREATE PROC checkTodaysDealOnProduct

@serial_no INT,
@activeDeal BIT OUTPUT

AS 
BEGIN


IF(EXISTS(
SELECT TDP.*
FROM Todays_Deals_Product TDP
INNER JOIN Todays_Deals TD
ON TDP.deal_id = TD.deal_id
WHERE TDP.serial_no = @serial_no AND TD.expiry_date > CURRENT_TIMESTAMP))
	BEGIN
	SELECT @activeDeal = 1;
	END

ELSE
	BEGIN
	SELECT @activeDeal = 0;
	END


END 
GO

-- (50)(g3)
CREATE PROC addTodaysDealOnProduct

@deal_id INT,
@serial_no INT

AS 
BEGIN


DECLARE @active BIT;
DECLARE @expiry DATETIME;
DECLARE @newprice DECIMAL(10, 2), @oldprice DECIMAL(10, 2), @amount INT;
-- Checks that the deal exists in the deal table.
IF(EXISTS(
SELECT TD.*
FROM Todays_Deals TD
WHERE TD.deal_id = @deal_id))
	BEGIN
	SELECT @expiry  = TD.expiry_date
					  FROM Todays_Deals TD
					  WHERE TD.deal_id = @deal_id;

	-- Checks if it has an active deal.
	EXEC checkTodaysDealOnProduct @serial_no = @serial_no, @activeDeal = @active OUTPUT;

	
	-- Checks that the deal was not expired.
	IF(@active = 0 AND @expiry > CURRENT_TIMESTAMP)
			BEGIN
			ALTER TABLE Todays_Deals_Product
			DROP CONSTRAINT Todays_Deals_Product_foreign_key1;

			ALTER TABLE Todays_Deals_Product
			ADD CONSTRAINT Todays_Deals_Product_foreign_key1
			FOREIGN KEY(deal_id) REFERENCES Todays_Deals ON DELETE CASCADE ON UPDATE CASCADE;

			ALTER TABLE Todays_Deals_Product
			DROP CONSTRAINT Todays_Deals_Product_foreign_key2;

			ALTER TABLE Todays_Deals_Product
			ADD CONSTRAINT Todays_Deals_Product_foreign_key2
			FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE;

			INSERT INTO Todays_Deals_Product(deal_id, serial_no)
			VALUES(@deal_id, @serial_no);

			SELECT @amount = TD.deal_amount
							 FROM Todays_Deals TD
							 WHERE TD.deal_id = @deal_id;

			SELECT @oldprice = P.final_price
							   FROM Product P
							   WHERE P.serial_no = @serial_no;

			SET @newprice = @oldprice - ((@amount*@oldprice)/100);

			UPDATE Product
			SET final_price = @newprice
			WHERE serial_no = @serial_no;
			END

		ELSE IF(@expiry > CURRENT_TIMESTAMP)
			BEGIN
			PRINT('There is an active deal on that product!');
			END
		END


END 
GO

-- (51)(g4)
CREATE PROC removeExpiredDeal

@deal_iD INT

AS 
BEGIN


DECLARE @expiry DATETIME;

SELECT @expiry = TD.expiry_date
				 FROM Todays_Deals TD
				 WHERE TD.deal_id = @deal_iD;

IF(@expiry <= CURRENT_TIMESTAMP) -- Checks that it has expired.
	BEGIN
	UPDATE Product
	SET final_price = price
	WHERE serial_no IN
	(
	SELECT TDP.serial_no
	FROM Todays_Deals_Product TDP
	WHERE TDP.deal_id = @deal_iD
	);
	DELETE FROM Todays_Deals_Product
	WHERE deal_id = @deal_iD;

	DELETE FROM Todays_Deal
	WHERE deal_id = @deal_iD;
	END


END 
GO

-- (52)(h)
CREATE PROC createGiftCard

@code VARCHAR(10),
@expiry_date DATETIME,
@amount INT,
@admin_username VARCHAR(20)

AS 
BEGIN

INSERT INTO Giftcard(code, expiry_date, amount, username)
VALUES(@code, @expiry_date, @amount, @admin_username);

END 
GO

-- (53)(i1)
CREATE PROC removeExpiredGiftCard

@code VARCHAR(10)

AS 
BEGIN


DECLARE @expiry DATETIME, @amount INT;

SELECT @expiry = Gf.expiry_date
				 FROM Giftcard Gf
				 WHERE Gf.code = @code;

SELECT @amount = Gf.amount
				FROM Giftcard Gf
				WHERE Gf.code = @code;

IF(@expiry <= CURRENT_TIMESTAMP) -- Checks that it has expired.
	BEGIN
	UPDATE Customer
	SET points = points - ADG.remaining_points
	FROM Customer C
	INNER JOIN Admin_Customer_Giftcard ADG
	ON C.username = ADG.customer_name 
	WHERE ADG.code = @code;

	DELETE FROM Admin_Customer_Giftcard
	WHERE code = @code;

	DELETE FROM Giftcard
	WHERE code = @code;
	END


END 
GO

-- (54)(i2)
CREATE PROC checkGiftCardOnCustomer

@code VARCHAR(10),
@activeGiftCard BIT OUTPUT

AS 
BEGIN


IF(EXISTS(
SELECT ADG.*
FROM Admin_Customer_Giftcard ADG
WHERE ADG.code = @code))
	BEGIN
	SELECT @activeGiftCard = 1;
	PRINT(1);
	END

ELSE
	BEGIN
	SELECT @activeGiftCard = 0;
	PRINT(0);
	END


END 
GO

-- (55)(i3)
CREATE PROC giveGiftCardtoCustomer

@code VARCHAR(10),
@customer_name VARCHAR(20), 
@admin_username VARCHAR(20)

AS 
BEGIN

DECLARE @amount INT

IF(EXISTS(
SELECT Gf.*
FROM Giftcard Gf
WHERE Gf.code = @code))
	BEGIN
	SELECT @amount = Gf.amount
				     FROM Giftcard Gf
					 WHERE Gf.code = @code;

	ALTER TABLE Admin_Customer_Giftcard
	DROP CONSTRAINT Admin_Customer_Giftcard_foreign_key1;

	ALTER TABLE Admin_Customer_Giftcard
	ADD CONSTRAINT Admin_Customer_Giftcard_foreign_key1
	FOREIGN KEY(code) REFERENCES Giftcard ON UPDATE CASCADE ON DELETE CASCADE;

	INSERT INTO Admin_Customer_Giftcard(code, customer_name, admin_username,remaining_points)
	VALUES(@code, @customer_name, @admin_username, @amount);


	UPDATE Customer
	SET points = points + @amount
	WHERE username = @customer_name;
	END


END 
GO

---------------------------------------------------------------------------------------------------------------------------------------
-- Delivery Person
-- (56)(a)
CREATE PROC acceptAdminInvitation

@delivery_username VARCHAR(20)

AS
BEGIN


UPDATE Delivery_Person
SET is_activated = 1
WHERE username = @delivery_username;


END
GO

-- (57)(b)
CREATE PROC deliveryPersonUpdateInfo

@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)

AS
BEGIN


IF(@email IS NOT NULL)
	BEGIN
	UPDATE Users
	SET email = @email
	WHERE username = @username;
	END

UPDATE Users
SET first_name = @first_name,
	last_name = @last_name,
	password = @password
WHERE username = @username;


END
GO

-- (58)(c)
CREATE PROC viewmyorders

@deliveryperson VARCHAR(20)

AS
BEGIN


SELECT O.*
FROM Orders O
INNER JOIN Admin_Delivery_Order ADO
ON O.order_no = ADO.order_no
WHERE ADO.delivery_username = @deliveryperson;


END
GO

-- (59)(d)
CREATE PROC specifyDeliveryWindow

@delivery_username VARCHAR(20),
@order_no INT,
@delivery_window VARCHAR(50)

AS
BEGIN


UPDATE Admin_Delivery_Order
SET delivery_window = @delivery_window
WHERE delivery_username = @delivery_username AND order_no = @order_no;


END
GO

-- (60)(e)
CREATE PROC updateOrderStatusOutforDelivery

@order_no INT

AS
BEGIN


UPDATE Orders
SET order_status = 'out for delivery'
WHERE order_no = @order_no;


END
GO

-- (61)(f)
CREATE PROC updateOrderStatusDelivered

@order_no INT

AS
BEGIN


UPDATE Orders
SET order_status = 'delivered'
WHERE order_no = @order_no;


END
GO

