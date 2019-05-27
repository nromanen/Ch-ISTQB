--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2



SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;



CREATE TABLE public.customers (
    user_id integer NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;



CREATE TABLE public.employees (
    user_id integer NOT NULL,
    chief_id integer,
    birth_date date,
    hire_date date,
    address character varying
);


ALTER TABLE public.employees OWNER TO postgres;


CREATE TABLE public.locations (
    id integer NOT NULL,
    city character varying,
    country character varying
);


ALTER TABLE public.locations OWNER TO postgres;



CREATE TABLE public.ordered_products (
    orders_id integer,
    products_id integer,
    historical_price numeric,
    quantity integer
);


ALTER TABLE public.ordered_products OWNER TO postgres;

--
CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_id integer,
    product_name_id integer,
    order_date date,
    responsible_employee integer,
    delivery_location integer
);


ALTER TABLE public.orders OWNER TO postgres;



CREATE TABLE public.products (
    id integer NOT NULL,
    product_name character varying,
    product_category_id integer,
    unit_price numeric,
    location_id integer
);


ALTER TABLE public.products OWNER TO postgres;


--

CREATE TABLE public.products_categories (
    id integer NOT NULL,
    category_name character varying
);


ALTER TABLE public.products_categories OWNER TO postgres;


--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    location_id integer
);


ALTER TABLE public.users OWNER TO postgres;



INSERT INTO public.customers (user_id) VALUES (331);
INSERT INTO public.customers (user_id) VALUES (332);
INSERT INTO public.customers (user_id) VALUES (333);
INSERT INTO public.customers (user_id) VALUES (334);
INSERT INTO public.customers (user_id) VALUES (335);
INSERT INTO public.customers (user_id) VALUES (1001);



INSERT INTO public.customers (user_id) VALUES (1);
INSERT INTO public.customers (user_id) VALUES (2);
INSERT INTO public.customers (user_id) VALUES (3);
INSERT INTO public.customers (user_id) VALUES (4);
INSERT INTO public.customers (user_id) VALUES (5);
INSERT INTO public.customers (user_id) VALUES (6);


INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (302, 301, '1971-02-20', '1994-05-23', '1496  Pooz Street');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (303, 301, '1971-05-27', '1994-09-29', '2134  Woodland Drive');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (304, 301, '1976-01-29', '1994-11-17', '600  Cimmaron Road');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (305, 301, '1981-05-11', '2007-03-10', '411  West Drive');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (307, 306, '1984-03-20', '2004-03-10', '2929  Bassel Street');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (308, 306, '1985-04-09', '2007-04-13', '2111  Meadowcrest Lane');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (309, 306, '1989-01-26', '2010-07-13', '3990  High Meadow Lane');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (310, 306, '1991-07-22', '2010-02-27', '3494  Cinnamon Lane');



INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (7, 8, '1985-06-03', '2010-06-02', '29  Bassel Street');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (8, 309, '1980-05-02', '2010-07-05', '9  Bassel Street');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (9, 8, '1984-06-01', '2011-03-06', '292  Bassel Street');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (10, 310, '1986-04-03', '1012-03-03', '2  Bassel Street');



INSERT INTO public.locations (id, city, country) VALUES (321, 'London', 'Great Britain');
INSERT INTO public.locations (id, city, country) VALUES (322, 'Paris', 'France');
INSERT INTO public.locations (id, city, country) VALUES (323, 'Berlin', 'Germany');
INSERT INTO public.locations (id, city, country) VALUES (324, 'Marseille', 'France');
INSERT INTO public.locations (id, city, country) VALUES (325, 'Strasbourg', 'France');
INSERT INTO public.locations (id, city, country) VALUES (326, 'Bordeaux', 'France');
INSERT INTO public.locations (id, city, country) VALUES (327, 'Barcelona', 'Spain');
INSERT INTO public.locations (id, city, country) VALUES (328, 'Madrid', 'Spain');
INSERT INTO public.locations (id, city, country) VALUES (329, 'Dortmund', 'Germany');
INSERT INTO public.locations (id, city, country) VALUES (330, 'Antwerp', 'Belgium');




INSERT INTO public.locations (id, city, country) VALUES (1, 'Kiev', 'Ukraine');
INSERT INTO public.locations (id, city, country) VALUES (2, 'Athens', 'Greece');
INSERT INTO public.locations (id, city, country) VALUES (3, 'Ottawa', 'Canada');
INSERT INTO public.locations (id, city, country) VALUES (4, 'Rome', 'Italy');
INSERT INTO public.locations (id, city, country) VALUES (5, 'Warsaw', 'Poland');
INSERT INTO public.locations (id, city, country) VALUES (6, 'Bern', 'Switzerland');
INSERT INTO public.locations (id, city, country) VALUES (7, 'Vienna', 'Austria');




INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (381, 361, 0.1, 3);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (382, 362, 0.1, 4);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (383, 363, 0.1, 5);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (384, 364, 1.1, 3);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (385, 365, 3, 5);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (386, 366, 7, 1);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (387, 367, 100, 1);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (388, 368, 200, 1);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (389, 369, 15, 2);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (390, 370, 10, 3);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (1, 1, 23, 3);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (2, 2, 37, 2);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (3, 3, 55, 1);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (4, 4, 28, 4);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (5, 5, 67, 6);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (6, 6, 35, 3);



INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (381, 331, 361, '1998-08-10', 302, 321);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (382, 332, 362, '2000-03-03', 303, 322);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (383, 333, 363, '2000-04-12', 304, 323);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (384, 334, 364, '2001-10-25', 305, 324);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (385, 335, 365, '2003-01-27', 307, 325);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (386, 331, 366, '2004-04-14', 308, 326);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (387, 332, 367, '2006-07-03', 309, 327);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (388, 333, 368, '2007-11-26', 310, 328);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (389, 334, 369, '2008-07-16', 302, 329);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (390, 335, 370, '2015-07-15', 303, 330);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (1001, 1001, 363, '2012-04-12', 303, 324);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (381, 331, 361, '1998-08-10', 302, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (382, 332, 362, '2000-03-03', 303, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (383, 333, 363, '2000-04-12', 304, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (384, 334, 364, '2001-10-25', 305, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (385, 335, 365, '2003-01-27', 307, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (386, 331, 366, '2004-04-14', 308, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (387, 332, 367, '2006-07-03', 309, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (388, 333, 368, '2007-11-26', 310, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (389, 334, 369, '2008-07-16', 302, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (390, 335, 370, '2015-07-15', 303, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (1, 1, 1, '2013-04-03', 7, 1);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (2, 2, 2, '2014-06-05', 7, 2);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (3, 3, 3, '2014-03-03', 8, 3);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (4, 4, 4, '2015-04-04', 8, 4);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (5, 5, 5, '2016-05-05', 9, 5);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (6, 6, 6, '2016-06-04', 10, 6);


INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (366, 'Mustard greens', 352, 9, 326);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (367, 'Mobile Phone', 353, 250, 328);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (368, 'Camera', 353, 400, 330);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (369, 'T-shirt', 354, 25, 329);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (370, 'Sweaters', 354, 35, 329);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (361, 'Nectarine', 351, 0.4, 322);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (362, 'Papaya', 351, 0.3, 323);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (363, 'Clementine', 351, 0.8, 324);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (365, 'Carrots', 352, 4, 325);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (364, 'Radicchio', 352, 2.2, 324);


INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (1, 'Waistcoat', 354, 23, 1);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (2, 'Jeans', 354, 34, 2);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (3, 'Skirt', 354, 24, 3);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (4, 'Trousers', 354, 56, 4);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (5, 'Cap', 354, 36, 5);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (6, 'Swimsuit', 354, 76, 6);



INSERT INTO public.products_categories (id, category_name) VALUES (351, 'Fruits');
INSERT INTO public.products_categories (id, category_name) VALUES (352, 'Vegetables');
INSERT INTO public.products_categories (id, category_name) VALUES (353, 'Electronics');
INSERT INTO public.products_categories (id, category_name) VALUES (354, 'Clothing');



INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (301, 'Anne', 'Lamonica', 321);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (302, 'Shanta', 'Spainhour', 322);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (303, 'Kiersten', 'Plemons', 323);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (304, 'Karan', 'Guynes', 324);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (305, 'Emogene', 'Gowdy', 325);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (306, 'Leoma', 'Almy', 326);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (307, 'Shirlene', 'Mckeever', 327);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (308, 'Juli', 'Curnutte', 328);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (309, 'Kecia', 'Reily', 329);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (310, 'Milton', 'Hewey', 330);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (331, 'Francisco', 'Clarke', 321);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (332, 'Kelvin', 'Ashline', 322);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (333, 'Kareem', 'Tocco', 323);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (334, 'Allen', 'Stockman ', 324);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (335, 'Derick', 'Lonzo', 325);

INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (1000, 'ASASA', 'ASDADASD', 322);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (1001, 'France User', 'France User', 324);


INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (1, 'Carletta', 'Quintanilla', 1);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (2, 'Melvina', 'Crosby', 2);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (3, 'Hoyt ', ' Helfer', 3);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (4, 'Makeda', 'Bolick', 3);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (5, 'Cory', 'Gillam', 4);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (6, 'Deshawn', 'Goodspeed', 4);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (7, 'Charleen', 'Fondren', 5);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (8, 'Kyoko', 'Vitela', 7);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (9, 'Ka', 'Tennant', 3);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (10, 'Margrett', 'Stumpff', 3);


ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (user_id);



ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (user_id);




ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);




ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);




ALTER TABLE ONLY public.products_categories
    ADD CONSTRAINT products_categories_pkey PRIMARY KEY (id);




ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);




ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);



CREATE INDEX fki_category ON public.products USING btree (product_category_id);




CREATE INDEX fki_chief ON public.employees USING btree (chief_id);


CREATE INDEX fki_customer ON public.orders USING btree (customer_id);



CREATE INDEX fki_customers ON public.customers USING btree (user_id);




CREATE INDEX fki_delivery ON public.orders USING btree (delivery_location);



CREATE INDEX fki_employee ON public.orders USING btree (responsible_employee);




CREATE INDEX fki_location_id ON public.products USING btree (location_id);



CREATE INDEX fki_product_name ON public.orders USING btree (product_name_id);



CREATE INDEX fki_products ON public.ordered_products USING btree (orders_id);




CREATE INDEX fki_users_location ON public.users USING btree (location_id);




ALTER TABLE ONLY public.products
    ADD CONSTRAINT category FOREIGN KEY (product_category_id) REFERENCES public.products_categories(id);



ALTER TABLE ONLY public.employees
    ADD CONSTRAINT chief FOREIGN KEY (chief_id) REFERENCES public.users(id);



ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customer FOREIGN KEY (user_id) REFERENCES public.users(id);




ALTER TABLE ONLY public.orders
    ADD CONSTRAINT customer FOREIGN KEY (customer_id) REFERENCES public.customers(user_id);




ALTER TABLE ONLY public.orders
    ADD CONSTRAINT delivery FOREIGN KEY (delivery_location) REFERENCES public.locations(id);



ALTER TABLE ONLY public.orders
    ADD CONSTRAINT employee FOREIGN KEY (responsible_employee) REFERENCES public.employees(user_id);



ALTER TABLE ONLY public.products
    ADD CONSTRAINT location_id FOREIGN KEY (location_id) REFERENCES public.locations(id);



ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT orders FOREIGN KEY (orders_id) REFERENCES public.orders(id);




ALTER TABLE ONLY public.orders
    ADD CONSTRAINT product_name FOREIGN KEY (product_name_id) REFERENCES public.products(id);




ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT products FOREIGN KEY (products_id) REFERENCES public.products(id);



ALTER TABLE ONLY public.employees
    ADD CONSTRAINT users FOREIGN KEY (user_id) REFERENCES public.users(id);




ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_location FOREIGN KEY (location_id) REFERENCES public.locations(id);



--
-- PostgreSQL database dump complete
--

