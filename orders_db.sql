--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7
-- Dumped by pg_dump version 10.7

-- Started on 2019-05-17 20:09:29

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2874 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 16911)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    user_id integer NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16914)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    user_id integer NOT NULL,
    chief_id integer,
    birth_date date,
    hire_date date,
    address character varying,
    notes character varying
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16920)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    city character varying,
    country character varying
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16926)
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
-- TOC entry 200 (class 1259 OID 16932)
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
-- TOC entry 201 (class 1259 OID 16935)
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
-- TOC entry 202 (class 1259 OID 16941)
-- Name: products_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_categories (
    id integer NOT NULL,
    category_name character varying
);


ALTER TABLE public.products_categories OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16947)
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
-- TOC entry 2859 (class 0 OID 16911)
-- Dependencies: 196
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.customers (user_id) VALUES (331);
INSERT INTO public.customers (user_id) VALUES (332);
INSERT INTO public.customers (user_id) VALUES (333);
INSERT INTO public.customers (user_id) VALUES (334);
INSERT INTO public.customers (user_id) VALUES (335);
INSERT INTO public.customers (user_id) VALUES (514);
INSERT INTO public.customers (user_id) VALUES (515);
INSERT INTO public.customers (user_id) VALUES (516);
INSERT INTO public.customers (user_id) VALUES (517);


--
-- TOC entry 2860 (class 0 OID 16914)
-- Dependencies: 197
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (302, 301, '1971-02-20', '1994-05-23', '1496  Pooz Street', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (303, 301, '1971-05-27', '1994-09-29', '2134  Woodland Drive', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (304, 301, '1976-01-29', '1994-11-17', '600  Cimmaron Road', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (305, 301, '1981-05-11', '2007-03-10', '411  West Drive', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (307, 306, '1984-03-20', '2004-03-10', '2929  Bassel Street', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (308, 306, '1985-04-09', '2007-04-13', '2111  Meadowcrest Lane', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (309, 306, '1989-01-26', '2010-07-13', '3990  High Meadow Lane', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (310, 306, '1991-07-22', '2010-02-27', '3494  Cinnamon Lane', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (518, 301, '1986-08-21', '2014-10-08', '2154  Harley Vincent Drive', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (519, 301, '1989-05-03', '2015-11-16', '3115  Brownton Road', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (520, 301, '1991-02-18', '2016-01-28', '3467  Emily Renzelli Boulevard', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (521, 306, '1991-05-01', '2016-12-16', '4604  Mulberry Lane', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (522, 306, '1992-11-17', '2017-01-12', '4925  Perine Street', NULL);
INSERT INTO public.employees (user_id, chief_id, birth_date, hire_date, address, notes) VALUES (523, 306, '1993-02-12', '2017-10-27', '4146  Powder House Road', NULL);


--
-- TOC entry 2861 (class 0 OID 16920)
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


--
-- TOC entry 2862 (class 0 OID 16926)
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
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (527, 504, 1, 2);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (528, 505, 0.5, 1);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (529, 506, 50, 3);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (530, 507, 190, 4);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (531, 508, 35, 1);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (532, 509, 2, 5);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (533, 510, 90, 2);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (524, 501, 2, 3);
INSERT INTO public.ordered_products (orders_id, products_id, historical_price, quantity) VALUES (525, 502, 0.5, 2);


--
-- TOC entry 2863 (class 0 OID 16932)
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
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (527, 517, 504, '2015-01-28', 521, 330);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (528, 514, 505, '2015-05-01', 522, 329);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (529, 515, 506, '2016-08-11', 523, 328);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (530, 516, 507, '2016-12-12', 518, 327);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (531, 517, 508, '2017-05-08', 519, 326);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (532, 514, 509, '2017-08-03', 520, 325);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (533, 515, 510, '2019-02-27', 521, 324);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (524, 514, 501, '2014-05-29', 518, 323);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (525, 515, 502, '2014-02-24', 519, 322);
INSERT INTO public.orders (id, customer_id, product_name_id, order_date, responsible_employee, delivery_location) VALUES (526, 516, 503, '2014-07-01', 520, 321);


--
-- TOC entry 2864 (class 0 OID 16935)
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
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (501, 'Butter', 511, 3, 330);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (502, 'Bread', 511, 1, 324);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (503, 'Rice', 511, 2, 328);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (504, 'Flour
', 511, 1.5, 325);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (505, 'Milk', 511, 1, 330);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (506, 'Chair
', 512, 65, 323);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (507, 'Sofa', 512, 230, 323);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (508, 'Carpet', 513, 45, 327);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (509, 'Juice', 511, 3, 328);
INSERT INTO public.products (id, product_name, product_category_id, unit_price, location_id) VALUES (510, 'Chanderlier', 353, 120, 329);


--
-- TOC entry 2865 (class 0 OID 16941)
-- Dependencies: 202
-- Data for Name: products_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products_categories (id, category_name) VALUES (351, 'Fruits');
INSERT INTO public.products_categories (id, category_name) VALUES (352, 'Vegetables');
INSERT INTO public.products_categories (id, category_name) VALUES (353, 'Electronics');
INSERT INTO public.products_categories (id, category_name) VALUES (354, 'Clothing');
INSERT INTO public.products_categories (id, category_name) VALUES (511, 'Food');
INSERT INTO public.products_categories (id, category_name) VALUES (512, 'Furniture');
INSERT INTO public.products_categories (id, category_name) VALUES (513, 'Household products');


--
-- TOC entry 2866 (class 0 OID 16947)
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
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (514, 'Kimber
', 'Thorn', 321);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (515, 'Ardis
', 'Emert', 323);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (516, 'Bambi
', 'Gebo', 324);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (517, 'Louvenia
', 'Kervin', 330);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (518, 'Diamond', 'Sargent', 329);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (519, 'Sage
', 'Lindholm', 328);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (520, 'Roslyn
', 'Fairbank', 325);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (521, 'Lynda', 'Mouton', 327);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (522, 'Natasha', 'Serrato', 330);
INSERT INTO public.users (id, first_name, last_name, location_id) VALUES (523, 'Johnson', 'Youssef', 322);


--
-- TOC entry 2703 (class 2606 OID 16954)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2706 (class 2606 OID 16956)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2709 (class 2606 OID 16958)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 2716 (class 2606 OID 16960)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 2722 (class 2606 OID 16962)
-- Name: products_categories products_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_categories
    ADD CONSTRAINT products_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2720 (class 2606 OID 16964)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 2725 (class 2606 OID 16966)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2717 (class 1259 OID 16967)
-- Name: fki_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_category ON public.products USING btree (product_category_id);


--
-- TOC entry 2707 (class 1259 OID 16968)
-- Name: fki_chief; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_chief ON public.employees USING btree (chief_id);


--
-- TOC entry 2711 (class 1259 OID 16969)
-- Name: fki_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_customer ON public.orders USING btree (customer_id);


--
-- TOC entry 2704 (class 1259 OID 16970)
-- Name: fki_customers; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_customers ON public.customers USING btree (user_id);


--
-- TOC entry 2712 (class 1259 OID 17035)
-- Name: fki_delivery; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_delivery ON public.orders USING btree (delivery_location);


--
-- TOC entry 2713 (class 1259 OID 17041)
-- Name: fki_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_employee ON public.orders USING btree (responsible_employee);


--
-- TOC entry 2718 (class 1259 OID 16971)
-- Name: fki_location_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_location_id ON public.products USING btree (location_id);


--
-- TOC entry 2714 (class 1259 OID 16972)
-- Name: fki_product_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_product_name ON public.orders USING btree (product_name_id);


--
-- TOC entry 2710 (class 1259 OID 16973)
-- Name: fki_products; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_products ON public.ordered_products USING btree (orders_id);


--
-- TOC entry 2723 (class 1259 OID 16974)
-- Name: fki_users_location; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_users_location ON public.users USING btree (location_id);


--
-- TOC entry 2735 (class 2606 OID 16975)
-- Name: products category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT category FOREIGN KEY (product_category_id) REFERENCES public.products_categories(id);


--
-- TOC entry 2727 (class 2606 OID 16980)
-- Name: employees chief; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT chief FOREIGN KEY (chief_id) REFERENCES public.users(id);


--
-- TOC entry 2726 (class 2606 OID 16985)
-- Name: customers customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customer FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2731 (class 2606 OID 16990)
-- Name: orders customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT customer FOREIGN KEY (customer_id) REFERENCES public.customers(user_id);


--
-- TOC entry 2733 (class 2606 OID 17030)
-- Name: orders delivery; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT delivery FOREIGN KEY (delivery_location) REFERENCES public.locations(id);


--
-- TOC entry 2734 (class 2606 OID 17036)
-- Name: orders employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT employee FOREIGN KEY (responsible_employee) REFERENCES public.employees(user_id);


--
-- TOC entry 2736 (class 2606 OID 17000)
-- Name: products location_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT location_id FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 2729 (class 2606 OID 17005)
-- Name: ordered_products orders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT orders FOREIGN KEY (orders_id) REFERENCES public.orders(id);


--
-- TOC entry 2732 (class 2606 OID 17010)
-- Name: orders product_name; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT product_name FOREIGN KEY (product_name_id) REFERENCES public.products(id);


--
-- TOC entry 2730 (class 2606 OID 17015)
-- Name: ordered_products products; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT products FOREIGN KEY (products_id) REFERENCES public.products(id);


--
-- TOC entry 2728 (class 2606 OID 17020)
-- Name: employees users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2737 (class 2606 OID 17025)
-- Name: users users_location; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_location FOREIGN KEY (location_id) REFERENCES public.locations(id);


-- Completed on 2019-05-17 20:09:29

--
-- PostgreSQL database dump complete
--

