--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.addresses (
    customer_id integer,
    address1 character varying(255),
    address2 character varying(255),
    city character varying(50),
    postal_code character varying(50),
    country_code character varying(50)
);


ALTER TABLE public.addresses OWNER TO pyapp;

--
-- Name: category; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    category_name character varying(255)
);


ALTER TABLE public.category OWNER TO pyapp;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: pyapp
--

CREATE SEQUENCE public.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_category_id_seq OWNER TO pyapp;

--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pyapp
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.countries (
    country_code character varying(50) NOT NULL,
    name character varying(255)
);


ALTER TABLE public.countries OWNER TO pyapp;

--
-- Name: courier; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.courier (
    courier_id integer NOT NULL,
    name character varying(255),
    price numeric(13,6),
    logo character varying(255)
);


ALTER TABLE public.courier OWNER TO pyapp;

--
-- Name: courier_courier_id_seq; Type: SEQUENCE; Schema: public; Owner: pyapp
--

CREATE SEQUENCE public.courier_courier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courier_courier_id_seq OWNER TO pyapp;

--
-- Name: courier_courier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pyapp
--

ALTER SEQUENCE public.courier_courier_id_seq OWNED BY public.courier.courier_id;


--
-- Name: currency; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.currency (
    currency_id integer NOT NULL,
    name character varying(50),
    currency_code character varying(50)
);


ALTER TABLE public.currency OWNER TO pyapp;

--
-- Name: currency_currency_id_seq; Type: SEQUENCE; Schema: public; Owner: pyapp
--

CREATE SEQUENCE public.currency_currency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currency_currency_id_seq OWNER TO pyapp;

--
-- Name: currency_currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pyapp
--

ALTER SEQUENCE public.currency_currency_id_seq OWNED BY public.currency.currency_id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    gender smallint,
    birthday date,
    email_address character varying(255),
    username character varying(255),
    password character varying(255),
    contact character varying(50)
);


ALTER TABLE public.customers OWNER TO pyapp;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: pyapp
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_customer_id_seq OWNER TO pyapp;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pyapp
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: ordered_products; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.ordered_products (
    order_id integer,
    product_id integer,
    quantity integer,
    total_price numeric(13,6)
);


ALTER TABLE public.ordered_products OWNER TO pyapp;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    customer_id integer,
    status character varying(10),
    carrier_id integer,
    address_id integer,
    product_id integer,
    invoice_no character varying(50),
    shipping_fee numeric(13,6),
    total_tax numeric(13,6),
    total_price numeric(13,6),
    pyament_id integer,
    delivery_date date
);


ALTER TABLE public.orders OWNER TO pyapp;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: pyapp
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_id_seq OWNER TO pyapp;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pyapp
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: payment_type; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.payment_type (
    payment_id integer NOT NULL,
    payment_method character varying(50),
    credit_card_number character varying(50),
    currency_id integer
);


ALTER TABLE public.payment_type OWNER TO pyapp;

--
-- Name: payment_type_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: pyapp
--

CREATE SEQUENCE public.payment_type_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_type_payment_id_seq OWNER TO pyapp;

--
-- Name: payment_type_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pyapp
--

ALTER SEQUENCE public.payment_type_payment_id_seq OWNED BY public.payment_type.payment_id;


--
-- Name: product_images; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.product_images (
    product_id integer,
    image_name character varying(255),
    image_sorting integer
);


ALTER TABLE public.product_images OWNER TO pyapp;

--
-- Name: products; Type: TABLE; Schema: public; Owner: pyapp
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(255),
    description text,
    price numeric(13,6),
    sku character varying(50),
    stock integer,
    variation character varying(255),
    brand character varying(50),
    category_id integer
);


ALTER TABLE public.products OWNER TO pyapp;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: pyapp
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_id_seq OWNER TO pyapp;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pyapp
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: category category_id; Type: DEFAULT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- Name: courier courier_id; Type: DEFAULT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.courier ALTER COLUMN courier_id SET DEFAULT nextval('public.courier_courier_id_seq'::regclass);


--
-- Name: currency currency_id; Type: DEFAULT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.currency ALTER COLUMN currency_id SET DEFAULT nextval('public.currency_currency_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: payment_type payment_id; Type: DEFAULT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.payment_type ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_type_payment_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.addresses (customer_id, address1, address2, city, postal_code, country_code) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.category (category_id, category_name) FROM stdin;
1	mensWear
2	womensWear
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.countries (country_code, name) FROM stdin;
AF	Afghanistan
AM	Armenia
AZ	Azerbaijan
BH	Bahrain
BD	Bangladesh
BT	Bhutan
BN	Brunei
KH	Cambodia
CN	China
GE	Georgia
HK	Hong Kong
IN	India
ID	Indonesia
IR	Iran
IQ	Iraq
IL	Israel
JP	Japan
JO	Jordan
KZ	Kazakhstan
KW	Kuwait
KG	Kyrgyzstan
LA	Laos
LB	Lebanon
MO	Macau
MY	Malaysia
MV	Maldives
MN	Mongolia
MM	Myanmar
NP	Nepal
KP	North Korea
OM	Oman
PK	Pakistan
PH	Philippines
QA	Qatar
SA	Saudi Arabia
SG	Singapore
KR	South Korea
LK	Sri Lanka
SY	Syria
TW	Taiwan
TJ	Tajikistan
TH	Thailand
TR	Turkey
TM	Turkmenistan
AE	United Arab Emirates
UZ	Uzbekistan
VN	Vietnam
YE	Yemen
\.


--
-- Data for Name: courier; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.courier (courier_id, name, price, logo) FROM stdin;
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.currency (currency_id, name, currency_code) FROM stdin;
1	Afghanistan	AFN
2	Armenia	AMD
3	Azerbaijan	AZN
4	Bahrain	BHD
5	Bangladesh	BDT
6	Bhutan	BTN
7	Brunei	BND
8	Cambodia	KHR
9	China	CNY
10	Georgia	GEL
11	Hong Kong	HK
12	India	INR
13	Indonesia	IDR
14	Iran	IRR
15	Iraq	IQD
16	Israel	ILS
17	Japan	JPY
18	Jordan	JOD
19	Kazakhstan	KZT
20	Kuwait	KWD
21	Kyrgyzstan	KGS
22	Laos	LAK
23	Lebanon	LBP
24	Macau	MOP
25	Malaysia	MYR
26	Maldives	MVR
27	Mongolia	MNT
28	Myanmar	MMK
29	Nepal	NPR
30	North Korea	KPW
31	Oman	OMR
32	Pakistan	PKR
33	Philippines	PHP
34	Qatar	QAR
35	Saudi Arabia	SAR
36	Singapore	SGD
37	South Korea	KRW
38	Sri Lanka	LKR
39	Syria	SYP
40	Taiwan	TWT
41	Tajikistan	TJS
42	Thailand	THB
43	Turkey	TRY
44	Turkmenistan	TMT
45	United Arab Emirates	AED
46	Uzbekistan	UZS
47	Vietnam	VND
48	Yemen	YER
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.customers (customer_id, first_name, last_name, gender, birthday, email_address, username, password, contact) FROM stdin;
1	test1	test1	0	2020-03-25	test1@gmaill.com	test1	123	12312312321
\.


--
-- Data for Name: ordered_products; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.ordered_products (order_id, product_id, quantity, total_price) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.orders (order_id, customer_id, status, carrier_id, address_id, product_id, invoice_no, shipping_fee, total_tax, total_price, pyament_id, delivery_date) FROM stdin;
\.


--
-- Data for Name: payment_type; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.payment_type (payment_id, payment_method, credit_card_number, currency_id) FROM stdin;
\.


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.product_images (product_id, image_name, image_sorting) FROM stdin;
3	img/profile.png	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: pyapp
--

COPY public.products (product_id, name, description, price, sku, stock, variation, brand, category_id) FROM stdin;
3	test1	test1	123.000000	1234567	123	test1,test1,test1	test1	1
\.


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pyapp
--

SELECT pg_catalog.setval('public.category_category_id_seq', 2, true);


--
-- Name: courier_courier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pyapp
--

SELECT pg_catalog.setval('public.courier_courier_id_seq', 1, false);


--
-- Name: currency_currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pyapp
--

SELECT pg_catalog.setval('public.currency_currency_id_seq', 48, true);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pyapp
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 1, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pyapp
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- Name: payment_type_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pyapp
--

SELECT pg_catalog.setval('public.payment_type_payment_id_seq', 1, false);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pyapp
--

SELECT pg_catalog.setval('public.products_product_id_seq', 3, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_code);


--
-- Name: courier courier_pkey; Type: CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.courier
    ADD CONSTRAINT courier_pkey PRIMARY KEY (courier_id);


--
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (currency_id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: payment_type payment_type_pkey; Type: CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.payment_type
    ADD CONSTRAINT payment_type_pkey PRIMARY KEY (payment_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: addresses addresses_country_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_country_code_fkey FOREIGN KEY (country_code) REFERENCES public.countries(country_code);


--
-- Name: addresses addresses_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pyapp
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id);


--
-- PostgreSQL database dump complete
--

