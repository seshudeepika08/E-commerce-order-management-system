CREATE TABLE Customer (
    customer_id INTEGER PRIMARY KEY,
    name CHAR(100) NOT NULL,
    email CHAR(100) NOT NULL UNIQUE,
    phone CHAR(15) UNIQUE
);
CREATE TABLE Address (
    address_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    city CHAR(50) NOT NULL,
    state CHAR(50) NOT NULL,
    pincode CHAR(10) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
CREATE TABLE Category (
    category_id INTEGER PRIMARY KEY,
    category_name CHAR(50) NOT NULL UNIQUE
);
CREATE TABLE Product (
    product_id INTEGER PRIMARY KEY,
    category_id INTEGER NOT NULL,
    product_name CHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock_quantity INTEGER DEFAULT 0 CHECK (stock_quantity >= 0),
    description CHAR(200),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);
CREATE TABLE Cart (
    cart_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL UNIQUE,
    cart_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
CREATE TABLE Cart_Item (
    cart_item_id INTEGER PRIMARY KEY,
    cart_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER DEFAULT 1 CHECK (quantity > 0),
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    status CHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
CREATE TABLE Order_Item (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER DEFAULT 1 CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
CREATE TABLE Order_Item (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER DEFAULT 1 CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
CREATE TABLE Delivery (
    delivery_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL UNIQUE,
    delivery_address CHAR(200) NOT NULL,
    delivery_status CHAR(20) DEFAULT 'Pending',
    delivery_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
CREATE TABLE Review (
    review_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment CHAR(200),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
