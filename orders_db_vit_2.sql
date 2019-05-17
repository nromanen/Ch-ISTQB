--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7
-- Dumped by pg_dump version 11.2

-- Started on 2019-05-17 18:28:09

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

--
-- TOC entry 196 (class 1259 OID 25308)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    user_id integer NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 25311)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    user_id integer NOT NULL,
    chief_id integer,
    birth_date date,
    hire_date date,
    address character varying
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 25317)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    city character varying,
    country character varying
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 25323)
-- Name: ordered_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordered_products (
    orders_id integer,
    products_id integer,
    historical_price numeric,
    quantity integer
);


ALTER TABLE public.ordered_products OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 25329)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
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

--
-- TOC entry 201 (class 1259 OID 25332)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    product_name character varying,
    product_category_id integer,
    unit_price numeric,
    location_id integer
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 25338)
-- Name: products_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_categories (
    id integer NOT NULL,
    category_name character varying
);


ALTER TABLE public.products_categories OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 25344)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    location_id integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 2213 (class 0 OID 25308)
-- Dependencies: 196
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.customers (user_id) VALUES (331);
INSERT INTO public.customers (user_id) VALUES (332);
INSERT INTO public.customers (user_id) VALUES (333);
INSERT INTO public.customers (user_id) VALUES (334);
INSERT INTO public.customers (user_id) VALUES (335);
INSERT INTO public.customers (user_id) VALUES (123);
INSERT INTO public.customers (user_id) VALUES (124);
INSERT INTO public.customers (user_id) VALUES (125);
INSERT INTO public.customers (user_id) VALUES (121);
INSERT INTO public.customers (user_id) VALUES (122);


--
-- TOC entry 2214 (class 0 OID 25311)
-- Dependencies: 197
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (302, 301, '1971-02-20', '1994-05-23', '1496  Pooz Street');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (303, 301, '1971-05-27', '1994-09-29', '2134  Woodland Drive');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (304, 301, '1976-01-29', '1994-11-17', '600  Cimmaron Road');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (305, 301, '1981-05-11', '2007-03-10', '411  West Drive');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (307, 306, '1984-03-20', '2004-03-10', '2929  Bassel Street');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (308, 306, '1985-04-09', '2007-04-13', '2111  Meadowcrest Lane');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (309, 306, '1989-01-26', '2010-07-13', '3990  High Meadow Lane');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (310, 306, '1991-07-22', '2010-02-27', '3494  Cinnamon Lane');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (112, 111, '1972-05-23', '1983-06-15', '4943  John Daniel Drive');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (113, 111, '1973-06-23', '1984-06-20', '4846  Haul Road');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (114, 111, '1973-08-22', '1985-06-06', '1976  Gambler Lane');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (115, 111, '1980-10-12', '1981-07-06', '1744  Drainer Avenue');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (117, 111, '1975-10-11', '1990-09-10', '120  Camel Back Road');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (118, 116, '1945-10-10', '1990-09-09', '3266  Monroe Street');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (119, 116, '1950-10-10', '1990-11-11', '2553  Maryland Avenue');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (120, 116, '1960-12-12', '1990-11-12', '3008  Ferry Street');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (121, 116, '1970-08-13', '1986-11-11', '2214  Private Lane');
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address) VALUES (122, 116, '1972-03-04', '1992-05-05', '2838  Ashton Lane');


--
-- TOC entry 2215 (class 0 OID 25317)
-- Dependencies: 198
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

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
INSERT INTO public.locations (id, city, country) VALUES (101, 'Wien', 'Austria');
INSERT INTO public.locations (id, city, country) VALUES (102, 'Graz', 'Austria');
INSERT INTO public.locations (id, city, country) VALUES (103, 'Gliwice', 'Poland');
INSERT INTO public.locations (id, city, country) VALUES (104, 'Budapest', 'Ungarn');
INSERT INTO public.locations (id, city, country) VALUES (105, 'Klagenfurt', 'Austria');
INSERT INTO public.locations (id, city, country) VALUES (106, 'Melburn', 'Australia');
INSERT INTO public.locations (id, city, country) VALUES (107, 'Phoenix', 'USA');
INSERT INTO public.locations (id, city, country) VALUES (108, 'LA', 'USA');
INSERT INTO public.locations (id, city, country) VALUES (109, 'Lviv', 'Ukraine');
INSERT INTO public.locations (id, city, country) VALUES (110, 'Oslo', 'Denmark');


--
-- TOC entry 2216 (class 0 OID 25323)
-- Dependencies: 199
-- Data for Name: ordered_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

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
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (181, 140, 0.2, 3);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (182, 141, 0.3, 4);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (183, 142, 0.4, 1);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (184, 143, 2, 2);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (185, 144, 1.1, 3);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (186, 145, 1, 2);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (187, 146, 1.1, 3);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (188, 147, 2, 2);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (189, 148, 3, 2);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (190, 149, 4, 2);


--
-- TOC entry 2217 (class 0 OID 25329)
-- Dependencies: 200
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

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
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (181, 121, 140, '1998-08-10', 112, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (182, 122, 141, '1997-07-09', 113, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (183, 123, 142, '2018-02-03', 114, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (184, 124, 143, '2017-03-12', 115, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (185, 125, 144, '2011-09-09', 117, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (186, 121, 145, '2010-10-10', 118, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (187, 122, 146, '2017-10-10', 119, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (188, 123, 147, '2016-11-11', 120, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (189, 124, 148, '2015-11-12', 112, NULL);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (190, 125, 149, '2014-10-10', 113, NULL);


--
-- TOC entry 2218 (class 0 OID 25332)
-- Dependencies: 201
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

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
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (140, 'tomato', 352, 3, 101);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (141, 'apple', 351, 2, 102);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (142, 'TV', 353, 300, 103);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (143, 'Socks', 354, 5, 105);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (144, 'Cherry', 351, 1, 106);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (145, 'Carrot', 352, 2, 107);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (146, 'Laptop', 353, 700, 108);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (147, 'Dress', 354, 60, 109);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (148, 'Strawberry', 351, 4, 110);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (149, 'Cucumber', 352, 3, 101);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (150, 'Ipad', 353, 800, 102);


--
-- TOC entry 2219 (class 0 OID 25338)
-- Dependencies: 202
-- Data for Name: products_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products_categories (id, category_name) VALUES (351, 'Fruits');
INSERT INTO public.products_categories (id, category_name) VALUES (352, 'Vegetables');
INSERT INTO public.products_categories (id, category_name) VALUES (353, 'Electronics');
INSERT INTO public.products_categories (id, category_name) VALUES (354, 'Clothing');


--
-- TOC entry 2220 (class 0 OID 25344)
-- Dependencies: 203
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

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
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (111, 'Liz', 'Lafollette', 101);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (112, 'Sierra', 'Tresher', 102);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (113, 'Mike', 'Nielsen', 103);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (114, 'Rick', 'Grimes', 104);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (115, 'Artur', 'King', 105);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (116, 'Konan', 'Doile', 106);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (117, 'Kirk', 'Hammet', 107);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (118, 'Dirk', 'Parkinson', 108);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (119, 'Mike', 'Bill', 109);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (120, 'Shakil', 'Neil', 110);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (121, 'Duck', 'Olafson', 101);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (122, 'Gunther', 'Osaka', 102);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (123, 'Danie', 'Ogren', 103);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (124, 'Troy', 'Florey', 104);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (125, 'Foster', 'Mickey', 105);


--
-- TOC entry 2057 (class 2606 OID 25351)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2060 (class 2606 OID 25353)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2063 (class 2606 OID 25355)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 2070 (class 2606 OID 25357)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 2076 (class 2606 OID 25359)
-- Name: products_categories products_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_categories
    ADD CONSTRAINT products_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2074 (class 2606 OID 25361)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 2079 (class 2606 OID 25363)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2071 (class 1259 OID 25364)
-- Name: fki_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_category ON public.products USING btree (product_category_id);


--
-- TOC entry 2061 (class 1259 OID 25365)
-- Name: fki_chief; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_chief ON public.employees USING btree (chief_id);


--
-- TOC entry 2065 (class 1259 OID 25366)
-- Name: fki_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_customer ON public.orders USING btree (customer_id);


--
-- TOC entry 2058 (class 1259 OID 25367)
-- Name: fki_customers; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_customers ON public.customers USING btree (user_id);


--
-- TOC entry 2066 (class 1259 OID 25432)
-- Name: fki_delivery; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_delivery ON public.orders USING btree (delivery_location);


--
-- TOC entry 2067 (class 1259 OID 25438)
-- Name: fki_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_employee ON public.orders USING btree (responsible_employee);


--
-- TOC entry 2072 (class 1259 OID 25368)
-- Name: fki_location_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_location_id ON public.products USING btree (location_id);


--
-- TOC entry 2068 (class 1259 OID 25369)
-- Name: fki_product_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_product_name ON public.orders USING btree (product_name_id);


--
-- TOC entry 2064 (class 1259 OID 25370)
-- Name: fki_products; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_products ON public.ordered_products USING btree (orders_id);


--
-- TOC entry 2077 (class 1259 OID 25371)
-- Name: fki_users_location; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_users_location ON public.users USING btree (location_id);


--
-- TOC entry 2089 (class 2606 OID 25372)
-- Name: products category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT category FOREIGN KEY (product_category_id) REFERENCES public.products_categories(id);


--
-- TOC entry 2081 (class 2606 OID 25377)
-- Name: employees chief; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT chief FOREIGN KEY (chief_id) REFERENCES public.users(id);


--
-- TOC entry 2080 (class 2606 OID 25382)
-- Name: customers customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customer FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2085 (class 2606 OID 25387)
-- Name: orders customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT customer FOREIGN KEY (customer_id) REFERENCES public.customers(user_id);


--
-- TOC entry 2087 (class 2606 OID 25427)
-- Name: orders delivery; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT delivery FOREIGN KEY (delivery_location) REFERENCES public.locations(id);


--
-- TOC entry 2088 (class 2606 OID 25433)
-- Name: orders employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT employee FOREIGN KEY (responsible_employee) REFERENCES public.employees(user_id);


--
-- TOC entry 2090 (class 2606 OID 25397)
-- Name: products location_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT location_id FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 2083 (class 2606 OID 25402)
-- Name: ordered_products orders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT orders FOREIGN KEY (orders_id) REFERENCES public.orders(id);


--
-- TOC entry 2086 (class 2606 OID 25407)
-- Name: orders product_name; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT product_name FOREIGN KEY (product_name_id) REFERENCES public.products(id);


--
-- TOC entry 2084 (class 2606 OID 25412)
-- Name: ordered_products products; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT products FOREIGN KEY (products_id) REFERENCES public.products(id);


--
-- TOC entry 2082 (class 2606 OID 25417)
-- Name: employees users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2091 (class 2606 OID 25422)
-- Name: users users_location; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_location FOREIGN KEY (location_id) REFERENCES public.locations(id);


-- Completed on 2019-05-17 18:28:10

--
-- PostgreSQL database dump complete
--

