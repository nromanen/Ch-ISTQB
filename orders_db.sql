--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7
-- Dumped by pg_dump version 11.2

-- Started on 2019-05-15 21:30:30

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
-- TOC entry 201 (class 1259 OID 41520)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer,
    user_id integer,
    location_id integer
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 41505)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id integer,
    user_id integer,
    chief_id integer,
    birth_date character varying,
    hire_date character varying,
    adress character varying,
    location_id integer
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 41508)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer,
    city character varying,
    country character varying
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 41523)
-- Name: ordered_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordered_products (
    id integer,
    orders_id integer,
    products_id integer,
    historical_price character varying,
    quantity integer
);


ALTER TABLE public.ordered_products OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 41514)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer,
    customer_id integer,
    product_name_id integer,
    order_date character varying,
    responsible_employee integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 41517)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer,
    product_name character varying,
    product_category_id integer,
    unit_price character varying,
    location_id integer
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 41526)
-- Name: products_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_categories (
    id integer,
    category_name character varying
);


ALTER TABLE public.products_categories OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 41511)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer,
    first_name character varying,
    last_name character varying,
    location_id character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 2877 (class 0 OID 41520)
-- Dependencies: 201
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2872 (class 0 OID 41505)
-- Dependencies: 196
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2873 (class 0 OID 41508)
-- Dependencies: 197
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2878 (class 0 OID 41523)
-- Dependencies: 202
-- Data for Name: ordered_products; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2875 (class 0 OID 41514)
-- Dependencies: 199
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2876 (class 0 OID 41517)
-- Dependencies: 200
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2879 (class 0 OID 41526)
-- Dependencies: 203
-- Data for Name: products_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2874 (class 0 OID 41511)
-- Dependencies: 198
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--



-- Completed on 2019-05-15 21:30:30

--
-- PostgreSQL database dump complete
--

