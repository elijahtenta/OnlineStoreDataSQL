
select 'drop table '||table_name||' cascade constraints;' from user_tables;
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

DROP TABLE person;
CREATE TABLE person (
    person_id INT,
    person_name VARCHAR(30),
    PRIMARY KEY(person_id)
);

DROP TABLE address;
CREATE TABLE address (
    address_street VARCHAR(30),
    address_city VARCHAR(20),
    address_state VARCHAR(2),
    PRIMARY KEY(address_street, address_city, address_state)
);

DROP TABLE employee;
CREATE TABLE employee (
    employee_id INT REFERENCES person(person_id),
    PRIMARY KEY(employee_id)
);

DROP TABLE customer;
CREATE TABLE customer (
    customer_id INT REFERENCES person(person_id),
    PRIMARY KEY(customer_id)
);

DROP TABLE located;
CREATE TABLE located (
    entity_id INT,
    address_street VARCHAR(30),
    address_city VARCHAR(20),
    address_state VARCHAR(2),
    FOREIGN KEY(address_street, address_city, address_state) REFERENCES address(address_street, address_city, address_state)
);

DROP TABLE item;
CREATE TABLE item (
    item_id INT,
    item_name VARCHAR(20),
    item_description VARCHAR(100),
    PRIMARY KEY(item_id)
);

DROP TABLE services;
CREATE TABLE services (
    services_id INT REFERENCES item(item_id),
    PRIMARY KEY(services_id)
);

DROP TABLE hardware;
CREATE TABLE hardware (
    hardware_id INT REFERENCES item(item_id),
    PRIMARY KEY(hardware_id)
);

DROP TABLE performed;
CREATE TABLE performed (
    employee_id INT REFERENCES employee(employee_id) NOT NULL,
    services_id INT REFERENCES services(services_id) NOT NULL,
    customer_id INT REFERENCES customer(customer_id) NOT NULL,
    performed_date DATE NOT NULL,
    performed_hours DECIMAL(2,1) NOT NULL
);

DROP TABLE uses;
CREATE TABLE uses (
    service_id INT REFERENCES services(services_id),
    hardware_id INT REFERENCES hardware(hardware_id)
);

DROP TABLE suplier;
CREATE TABLE suplier (
    suplier_id INT NOT NULL,
    suplier_name VARCHAR(20),
    PRIMARY KEY(suplier_id)
);

DROP TABLE shipment;
CREATE TABLE shipment (
    hardware_id INT REFERENCES hardware(hardware_id),
    suplier_id INT REFERENCES suplier(suplier_id),
    shipment_quantity INT NOT NULL,
    shipment_price DECIMAL(6,2)
);

DROP TABLE sale;
CREATE TABLE sale (
    customer_id INT REFERENCES customer(customer_id),
    item_id INT REFERENCES item(item_id),
    sale_quantity INT NOT NULL,
    sale_price DECIMAL(5,2)
);

DROP TABLE delivery;
CREATE TABLE delivery (
	customer_id INT REFERENCES customer(customer_id),
    item_id INT REFERENCES item(item_id),
    delivery_date DATE,
    address_street VARCHAR(30),
    address_city VARCHAR(20),
    address_state VARCHAR(2),
	employee_id INT REFERENCES employee(employee_id),
    FOREIGN KEY(address_street, address_city, address_state) REFERENCES address(address_street, address_city, address_state)
);

INSERT ALL
    INTO person(person_id, person_name) VALUES(17645, 'Bill')

    INTO person(person_id, person_name) VALUES(10234, 'Able')
    INTO employee(employee_id) VALUES(10234)
    INTO person(person_id, person_name) VALUES(11567, 'Baker')
    INTO employee(employee_id) VALUES(11567)
    INTO person(person_id, person_name) VALUES(3289, 'George')
    INTO employee(employee_id) VALUES(3289)
    INTO person(person_id, person_name) VALUES(88331, 'Alice')
    INTO employee(employee_id) VALUES(88331)

    INTO customer(customer_id) VALUES(3289)
    INTO customer(customer_id) VALUES(88331)
    INTO person(person_id, person_name) VALUES(74591, 'Jane')
    INTO customer(customer_id) VALUES(74591)
    INTO customer(customer_id) VALUES(10234)
SELECT * FROM dual;

SELECT * FROM person;
SELECT * FROM customer;
SELECT * FROM employee;

INSERT ALL
    INTO address(address_street, address_city, address_state) VALUES('342 streetA', 'Monticello', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('65 streetS', 'St. Cloud', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('892 streetM', 'Minneapolis', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('342 streetB', 'Monticello', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('342 streetC', 'Monticello', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('999 StreetG', 'Duluth', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('60 streetG', 'St. Paul', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('75 streetT', 'Duluth', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('6 streetA', 'St. Paul', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('798 StreetE', 'Duluth', 'MN')
    INTO address(address_street, address_city, address_state) VALUES('344 streetA', 'Monticello', 'MN')
SELECT * FROM dual;

SELECT * FROM address;

INSERT ALL
    INTO suplier(suplier_id, suplier_name) VALUES(7760, 'ABC-Supply')
    INTO suplier(suplier_id, suplier_name) VALUES(7761, 'MyHWCo')
    INTO suplier(suplier_id, suplier_name) VALUES(98760, 'LightCo')
SELECT * FROM dual;

SELECT * FROM suplier;

INSERT ALL
    INTO located(entity_id, address_street, address_city, address_state) VALUES(7760, '60 streetG', 'St. Paul', 'MN')
    INTO located(entity_id, address_street, address_city, address_state) VALUES(7760, '75 streetT', 'Duluth', 'MN')
    INTO located(entity_id, address_street, address_city, address_state) VALUES(7761, '6 streetA', 'St. Paul', 'MN')
    INTO located(entity_id, address_street, address_city, address_state) VALUES(98760, '798 StreetE', 'Duluth', 'MN')
    INTO located(entity_id, address_street, address_city, address_state) VALUES(10234, '342 streetA', 'Monticello', 'MN')
    INTO located(entity_id, address_street, address_city, address_state) VALUES(11567, '65 streetS', 'St. Cloud', 'MN')
    INTO located(entity_id, address_street, address_city, address_state) VALUES(3289, '892 streetM', 'Minneapolis', 'MN')
    INTO located(entity_id, address_street, address_city, address_state) VALUES(17645, '342 streetB', 'Monticello', 'MN')
    INTO located(entity_id, address_street, address_city, address_state) VALUES(88331, '342 streetC', 'Monticello', 'MN')
    INTO located(entity_id, address_street, address_city, address_state) VALUES(74591, '999 StreetG', 'Duluth', 'MN')
SELECT * FROM dual;

SELECT * FROM located;

INSERT ALL
    INTO item(item_id, item_name, item_description) VALUES(2, 'cement', '60 lb. bag of cement')
    INTO hardware(hardware_id) VALUES(2)
    INTO item(item_id, item_name, item_description) VALUES(4, 'paint', 'gallon of white paint')
    INTO hardware(hardware_id) VALUES(4)
    INTO item(item_id, item_name, item_description) VALUES(10, 'nail', '2 inch nail')
    INTO hardware(hardware_id) VALUES(10)
    INTO item(item_id, item_name, item_description) VALUES(12, 'nail', '3 inch nail')
    INTO hardware(hardware_id) VALUES(12)
    INTO item(item_id, item_name, item_description) VALUES(14, 'nail', '4 inch nail')
    INTO hardware(hardware_id) VALUES(14)
    INTO item(item_id, item_name, item_description) VALUES(16, 'bolt', '2 inch bolt')
    INTO hardware(hardware_id) VALUES(16)
    INTO item(item_id, item_name, item_description) VALUES(20, 'light bulb', '40 watt')
    INTO hardware(hardware_id) VALUES(20)
    INTO item(item_id, item_name, item_description) VALUES(22, 'light bulb', '60 watt')
    INTO hardware(hardware_id) VALUES(22)
    INTO item(item_id, item_name, item_description) VALUES(24, 'light bulb', '10 watt LED')
    INTO hardware(hardware_id) VALUES(24)
    INTO item(item_id, item_name, item_description) VALUES(26, 'light bulb', '14 watt LED')
    INTO hardware(hardware_id) VALUES(26)
    INTO item(item_id, item_name, item_description) VALUES(28, 'glaze', '16 ounces')
    INTO hardware(hardware_id) VALUES(28)
    INTO item(item_id, item_name, item_description) VALUES(29, 'grill', '40 lb. barbeque')
    INTO hardware(hardware_id) VALUES(29)
    INTO item(item_id, item_name, item_description) VALUES(30, 'key', 'key blank – type 1')
    INTO hardware(hardware_id) VALUES(30)
    INTO item(item_id, item_name, item_description) VALUES(32, 'key', 'key blank – type 2')
    INTO hardware(hardware_id) VALUES(32)
    INTO item(item_id, item_name, item_description) VALUES(34, 'grass seed', '1 pound')
    INTO hardware(hardware_id) VALUES(34)
    
    INTO item(item_id, item_name, item_description) VALUES(100, 'duplicate', 'type 1 key')
    INTO services(services_id) VALUES(100)
    INTO item(item_id, item_name, item_description) VALUES(101, 'duplicate', 'type 2 key')
    INTO services(services_id) VALUES(101)
    INTO item(item_id, item_name, item_description) VALUES(102, 'repair', 're-glaze window')
    INTO services(services_id) VALUES(102)
    INTO item(item_id, item_name, item_description) VALUES(103, 'rent', 'seed spreader')
    INTO services(services_id) VALUES(103)
SELECT * FROM dual;

SELECT * FROM item;
SELECT * FROM hardware;
SELECT * FROM services;

INSERT ALL
    INTO uses(service_id, hardware_id) VALUES(100, 30)
    INTO uses(service_id, hardware_id) VALUES(101, 32)
    INTO uses(service_id, hardware_id) VALUES(102, 28)
    INTO uses(service_id, hardware_id) VALUES(103, 34)
SELECT * FROM dual;

SELECT * FROM uses;

INSERT ALL
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(3289, 100, 2, 2)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(3289, 101, 1, 1)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(3289, 29, 1, 300)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(88331, 26, 32, 160)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(88331, 24, 2, 20)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(88331, 20, 5, 25)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(88331, 4, 7, 70)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(74591, 4, 3, 90)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(74591, 28, 1, 5)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(74591, 20, 4, 12)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(74591, 103, 1, 10)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(10234, 2, 25, 125)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(10234, 14, 100, 5)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(10234, 16, 150, 15)
    INTO sale(customer_id, item_id, sale_quantity, sale_price) VALUES(10234, 100, 1, 1)
SELECT * FROM dual;

SELECT * FROM sale;

INSERT ALL
    INTO delivery(customer_id, item_id, address_street, address_city, address_state, delivery_date, employee_id) VALUES(3289, 29, '65 streetS', 'St. Cloud', 'MN', TO_DATE ('01/01/2021', 'DD/MM/YYYY'), 3289)
    INTO delivery(customer_id, item_id, address_street, address_city, address_state, delivery_date, employee_id) VALUES(74591, 4, '344 streetA', 'Monticello', 'MN', TO_DATE ('01/09/2021', 'DD/MM/YYYY'), 3289)
SELECT * FROM dual;

SELECT * FROM delivery;

INSERT ALL
    INTO shipment(hardware_id, suplier_id, shipment_quantity, shipment_price) VALUES(2, 7760, 50, 3)
    INTO shipment(hardware_id, suplier_id, shipment_quantity, shipment_price) VALUES(16, 7760, 1440, 0.05)
    INTO shipment(hardware_id, suplier_id, shipment_quantity, shipment_price) VALUES(29, 7761, 10, 200)
    INTO shipment(hardware_id, suplier_id, shipment_quantity, shipment_price) VALUES(24, 98760, 100, 5)
    INTO shipment(hardware_id, suplier_id, shipment_quantity, shipment_price) VALUES(26, 98760, 250, 6)
    INTO shipment(hardware_id, suplier_id, shipment_quantity, shipment_price) VALUES(14, 7761, 20000, 0.02)
    INTO shipment(hardware_id, suplier_id, shipment_quantity, shipment_price) VALUES(28, 7760, 288, 2)
SELECT * FROM dual;

SELECT * FROM shipment;

INSERT ALL
    INTO performed(employee_id, customer_id, services_id, performed_date, performed_hours) VALUES(11567, 3289, 100, TO_DATE('09/09/21', 'MM/DD/YY'), 0.1)
    INTO performed(employee_id, customer_id, services_id, performed_date, performed_hours) VALUES(11567, 3289, 101, TO_DATE('09/08/21', 'MM/DD/YY'), 0.1)
    INTO performed(employee_id, customer_id, services_id, performed_date, performed_hours) VALUES(10234, 10234, 100, TO_DATE('09/12/21', 'MM/DD/YY'), 0.1)
SELECT * FROM dual;

SELECT * FROM performed;
