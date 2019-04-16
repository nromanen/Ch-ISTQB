--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7
-- Dumped by pg_dump version 10.7

-- Started on 2019-04-16 17:58:17

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
-- TOC entry 1 (class 3079 OID 12278)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 16937)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    name character varying
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16929)
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company (
    company_id integer NOT NULL,
    name character varying
);


ALTER TABLE public.company OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16921)
-- Name: flight; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flight (
    id integer NOT NULL,
    flight character varying,
    departure_id integer,
    arrival_id integer,
    company_id integer,
    plain character varying,
    "time" character varying,
    price character varying
);


ALTER TABLE public.flight OWNER TO postgres;

--
-- TOC entry 2168 (class 0 OID 16937)
-- Dependencies: 198
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (city_id, name) FROM stdin;
1	Kyiv
2	Istanbul
3	Paris
4	London
\.


--
-- TOC entry 2167 (class 0 OID 16929)
-- Dependencies: 197
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company (company_id, name) FROM stdin;
1	Wizz Air
2	Turkish Airlines
3	British Airlines
4	Biplan2
\.


--
-- TOC entry 2166 (class 0 OID 16921)
-- Dependencies: 196
-- Data for Name: flight; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flight (id, flight, departure_id, arrival_id, company_id, plain, "time", price) FROM stdin;
1	735	1	2	1	Boeing	7:00	100
2	835	2	3	2	IL-20	8:00	150
3	935	3	1	3	Aerobus	9:00	200
4	1035	4	1	4	Biplan	10:00	120
\.


--
-- TOC entry 2041 (class 2606 OID 16944)
-- Name: city pk_city_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT pk_city_id PRIMARY KEY (city_id);


--
-- TOC entry 2039 (class 2606 OID 16936)
-- Name: company pk_company_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT pk_company_id PRIMARY KEY (company_id);


--
-- TOC entry 2037 (class 2606 OID 16928)
-- Name: flight pk_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT pk_id PRIMARY KEY (id);


--
-- TOC entry 2033 (class 1259 OID 16956)
-- Name: fki_arrival_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_arrival_id ON public.flight USING btree (arrival_id);


--
-- TOC entry 2034 (class 1259 OID 16962)
-- Name: fki_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_company_id ON public.flight USING btree (company_id);


--
-- TOC entry 2035 (class 1259 OID 16950)
-- Name: fki_departure_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_departure_id ON public.flight USING btree (departure_id);


--
-- TOC entry 2044 (class 2606 OID 16978)
-- Name: flight fk_arrival_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT fk_arrival_id FOREIGN KEY (arrival_id) REFERENCES public.city(city_id);


--
-- TOC entry 2043 (class 2606 OID 16973)
-- Name: flight fk_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES public.company(company_id);


--
-- TOC entry 2042 (class 2606 OID 16968)
-- Name: flight fk_departure_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT fk_departure_id FOREIGN KEY (departure_id) REFERENCES public.city(city_id);


-- Completed on 2019-04-16 17:58:17

--
-- PostgreSQL database dump complete
--

