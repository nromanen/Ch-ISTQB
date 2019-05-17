--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

-- Started on 2019-05-17 11:16:24

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
-- TOC entry 196 (class 1259 OID 66554)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    user_id integer NOT NULL,
    location_id integer
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 66557)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    user_id integer NOT NULL,
    chief_id integer,
    birth_date date,
    hire_date date,
    address character varying,
    location_id integer
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 66563)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    city character varying,
    country character varying
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 66569)
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
-- TOC entry 200 (class 1259 OID 66575)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_id integer,
    product_name_id integer,
    order_date date,
    responsible_employee integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 66578)
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
-- TOC entry 202 (class 1259 OID 66584)
-- Name: products_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_categories (
    id integer NOT NULL,
    category_name character varying
);


ALTER TABLE public.products_categories OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 66590)
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
-- TOC entry 2873 (class 0 OID 66554)
-- Dependencies: 196
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (user_id, location_id) FROM stdin;
331	321
332	322
333	323
334	324
335	325
403	320
404	321
405	322
406	323
407	324
408	325
409	326
410	327
411	328
412	329
490	330
491	320
500	321
\.


--
-- TOC entry 2874 (class 0 OID 66557)
-- Dependencies: 197
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (user_id, chief_id, birth_date, hire_date, address, location_id) FROM stdin;
302	301	1971-02-20	1994-05-23	1496  Pooz Street	322
303	301	1971-05-27	1994-09-29	2134  Woodland Drive	323
304	301	1976-01-29	1994-11-17	600  Cimmaron Road	324
305	301	1981-05-11	2007-03-10	411  West Drive	325
307	306	1984-03-20	2004-03-10	2929  Bassel Street	327
308	306	1985-04-09	2007-04-13	2111  Meadowcrest Lane	328
309	306	1989-01-26	2010-07-13	3990  High Meadow Lane	329
310	306	1991-07-22	2010-02-27	3494  Cinnamon Lane	330
\.


--
-- TOC entry 2875 (class 0 OID 66563)
-- Dependencies: 198
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id, city, country) FROM stdin;
321	London	Great Britain
322	Paris	France
323	Berlin	Germany
324	Marseille	France
325	Strasbourg	France
326	Bordeaux	France
327	Barcelona	Spain
328	Madrid	Spain
329	Dortmund	Germany
330	Antwerp	Belgium
\.


--
-- TOC entry 2876 (class 0 OID 66569)
-- Dependencies: 199
-- Data for Name: ordered_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordered_products (orders_id, products_id, historical_price, quantity) FROM stdin;
381	361	0.1	3
382	362	0.1	4
383	363	0.1	5
384	364	1.1	3
385	365	3	5
386	366	7	1
387	367	100	1
388	368	200	1
389	369	15	2
390	370	10	3
\.


--
-- TOC entry 2877 (class 0 OID 66575)
-- Dependencies: 200
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, customer_id, product_name_id, order_date, responsible_employee) FROM stdin;
381	331	361	1998-08-10	302
382	332	362	2000-03-03	303
383	333	363	2000-04-12	304
384	334	364	2001-10-25	305
385	335	365	2003-01-27	307
386	331	366	2004-04-14	308
387	332	367	2006-07-03	309
388	333	368	2007-11-26	310
389	334	369	2008-07-16	302
390	335	370	2015-07-15	303
\.


--
-- TOC entry 2878 (class 0 OID 66578)
-- Dependencies: 201
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, product_name, product_category_id, unit_price, location_id) FROM stdin;
366	Mustard greens	352	9	326
367	Mobile Phone	353	250	328
368	Camera	353	400	330
369	T-shirt	354	25	329
370	Sweaters	354	35	329
361	Nectarine	351	0.4	322
362	Papaya	351	0.3	323
363	Clementine	351	0.8	324
365	Carrots	352	4	325
364	Radicchio	352	2.2	324
\.


--
-- TOC entry 2879 (class 0 OID 66584)
-- Dependencies: 202
-- Data for Name: products_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_categories (id, category_name) FROM stdin;
351	Fruits
352	Vegetables
353	Electronics
354	Clothing
\.


--
-- TOC entry 2880 (class 0 OID 66590)
-- Dependencies: 203
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, location_id) FROM stdin;
301	Anne	Lamonica	321
302	Shanta	Spainhour	322
303	Kiersten	Plemons	323
304	Karan	Guynes	324
305	Emogene	Gowdy	325
306	Leoma	Almy	326
307	Shirlene	Mckeever	327
308	Juli	Curnutte	328
309	Kecia	Reily	329
310	Milton	Hewey	330
331	Francisco	Clarke	321
332	Kelvin	Ashline	322
333	Kareem	Tocco	323
334	Allen	Stockman 	324
335	Derick	Lonzo	325
401	Tennille	Madill  	330
402	Jeffry	Majeed	322
403	Sharice	Grisson	321
404	Rosenda	Mancia	323
405	Novella	Pilkenton	325
406	Tiara	Bloyd	321
407	Lashawn	Villani	322
408	Lamar	Nicks	323
409	Ward	Henline	324
410	Yuri	Sansom	325
411	Lourdes	Bargo	326
412	Berniece	Leader	327
490	Carrol	Masse	328
491	Xiomara	Strassburg	329
500	Bella	Lambson	330
\.


--
-- TOC entry 2718 (class 2606 OID 66597)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2721 (class 2606 OID 66599)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2725 (class 2606 OID 66601)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 2730 (class 2606 OID 66603)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 2736 (class 2606 OID 66605)
-- Name: products_categories products_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_categories
    ADD CONSTRAINT products_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2734 (class 2606 OID 66607)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 2739 (class 2606 OID 66609)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2731 (class 1259 OID 66610)
-- Name: fki_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_category ON public.products USING btree (product_category_id);


--
-- TOC entry 2722 (class 1259 OID 66611)
-- Name: fki_chief; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_chief ON public.employees USING btree (chief_id);


--
-- TOC entry 2727 (class 1259 OID 66612)
-- Name: fki_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_customer ON public.orders USING btree (customer_id);


--
-- TOC entry 2719 (class 1259 OID 66613)
-- Name: fki_customers; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_customers ON public.customers USING btree (user_id);


--
-- TOC entry 2723 (class 1259 OID 66614)
-- Name: fki_location; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_location ON public.employees USING btree (location_id);


--
-- TOC entry 2732 (class 1259 OID 66615)
-- Name: fki_location_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_location_id ON public.products USING btree (location_id);


--
-- TOC entry 2728 (class 1259 OID 66616)
-- Name: fki_product_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_product_name ON public.orders USING btree (product_name_id);


--
-- TOC entry 2726 (class 1259 OID 66617)
-- Name: fki_products; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_products ON public.ordered_products USING btree (orders_id);


--
-- TOC entry 2737 (class 1259 OID 66618)
-- Name: fki_users_location; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_users_location ON public.users USING btree (location_id);


--
-- TOC entry 2748 (class 2606 OID 66619)
-- Name: products category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT category FOREIGN KEY (product_category_id) REFERENCES public.products_categories(id);


--
-- TOC entry 2741 (class 2606 OID 66624)
-- Name: employees chief; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT chief FOREIGN KEY (chief_id) REFERENCES public.users(id);


--
-- TOC entry 2740 (class 2606 OID 66629)
-- Name: customers customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customer FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2746 (class 2606 OID 66634)
-- Name: orders customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT customer FOREIGN KEY (customer_id) REFERENCES public.customers(user_id);


--
-- TOC entry 2742 (class 2606 OID 66639)
-- Name: employees location; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT location FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 2749 (class 2606 OID 66644)
-- Name: products location; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT location FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 2750 (class 2606 OID 66649)
-- Name: products location_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT location_id FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 2744 (class 2606 OID 66654)
-- Name: ordered_products orders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT orders FOREIGN KEY (orders_id) REFERENCES public.orders(id);


--
-- TOC entry 2747 (class 2606 OID 66659)
-- Name: orders product_name; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT product_name FOREIGN KEY (product_name_id) REFERENCES public.products(id);


--
-- TOC entry 2745 (class 2606 OID 66664)
-- Name: ordered_products products; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT products FOREIGN KEY (products_id) REFERENCES public.products(id);


--
-- TOC entry 2743 (class 2606 OID 66669)
-- Name: employees users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2751 (class 2606 OID 66674)
-- Name: users users_location; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_location FOREIGN KEY (location_id) REFERENCES public.locations(id);


-- Completed on 2019-05-17 11:16:25

--
-- PostgreSQL database dump complete
--

