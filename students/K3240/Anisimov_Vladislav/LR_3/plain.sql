--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2025-04-21 12:36:52

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

--
-- TOC entry 875 (class 1247 OID 16555)
-- Name: fuel_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.fuel_type AS ENUM (
    'petrol',
    'diesel',
    'electro',
    'АИ-95',
    'АИ-98',
    'ДТ'
);


ALTER TYPE public.fuel_type OWNER TO postgres;

--
-- TOC entry 905 (class 1247 OID 16747)
-- Name: insurance_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.insurance_type AS ENUM (
    'Полная',
    'Частичная'
);


ALTER TYPE public.insurance_type OWNER TO postgres;

--
-- TOC entry 869 (class 1247 OID 16536)
-- Name: transmission_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.transmission_type AS ENUM (
    'auto',
    'manual',
    'variator',
    'electro',
    'robotic'
);


ALTER TYPE public.transmission_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16593)
-- Name: accident; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accident (
    id integer NOT NULL,
    instance_id integer NOT NULL,
    damage real NOT NULL,
    date timestamp with time zone NOT NULL,
    place text NOT NULL
);


ALTER TABLE public.accident OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16492)
-- Name: brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brand (
    id integer NOT NULL,
    name text NOT NULL,
    insurance_type public.insurance_type NOT NULL,
    insurance_cost real NOT NULL,
    collateral_value real NOT NULL
);


ALTER TABLE public.brand OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16528)
-- Name: car; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car (
    id integer NOT NULL,
    engine_id integer NOT NULL,
    transmission public.transmission_type NOT NULL,
    car_body_id integer NOT NULL,
    fuel_consumption real NOT NULL,
    info_id integer
);


ALTER TABLE public.car OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16561)
-- Name: car_body; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car_body (
    id integer NOT NULL,
    clearence integer NOT NULL,
    trunk_volume integer NOT NULL,
    seats_count integer NOT NULL
);


ALTER TABLE public.car_body OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16511)
-- Name: car_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car_info (
    id integer NOT NULL,
    brand_id integer NOT NULL,
    model text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.car_info OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16581)
-- Name: car_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car_instance (
    id integer NOT NULL,
    car_id integer NOT NULL,
    reg_code text NOT NULL,
    vin_code text NOT NULL,
    special_marks text,
    engine_code text NOT NULL,
    last_maintenance date,
    price integer NOT NULL,
    mileage integer NOT NULL,
    year integer NOT NULL
);


ALTER TABLE public.car_instance OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16479)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer NOT NULL,
    full_name text NOT NULL,
    phone text NOT NULL,
    adress text NOT NULL,
    discount real,
    CONSTRAINT discount_check CHECK (((discount > (0)::double precision) AND (discount <= (1)::double precision)))
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16616)
-- Name: contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract (
    id integer NOT NULL,
    instance_id integer NOT NULL,
    passport_id integer NOT NULL,
    price real NOT NULL,
    date_start timestamp with time zone NOT NULL,
    rent_scan_ref text,
    rent_emp_id integer NOT NULL,
    return_scan_ref text,
    return_emp_id integer,
    delay integer
);


ALTER TABLE public.contract OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16664)
-- Name: contract_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract_history (
    id integer NOT NULL,
    contract_id integer NOT NULL,
    emp_id integer NOT NULL,
    date_end time with time zone NOT NULL
);


ALTER TABLE public.contract_history OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16445)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id integer NOT NULL,
    full_name text NOT NULL,
    phone_number text NOT NULL,
    email text NOT NULL
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16547)
-- Name: engine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.engine (
    id integer NOT NULL,
    capacity real NOT NULL,
    power integer NOT NULL,
    fuel_type public.fuel_type NOT NULL
);


ALTER TABLE public.engine OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16603)
-- Name: fine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fine (
    id integer NOT NULL,
    instance_id integer NOT NULL,
    info text NOT NULL,
    cost integer NOT NULL,
    date timestamp with time zone NOT NULL,
    client_pays boolean DEFAULT true NOT NULL
);


ALTER TABLE public.fine OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16470)
-- Name: passport_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passport_history (
    id integer NOT NULL,
    client_id integer NOT NULL,
    date_start date NOT NULL,
    date_end date,
    details text NOT NULL,
    CONSTRAINT date_check CHECK ((date_start < date_end)),
    CONSTRAINT details_check CHECK ((details <> ' '::text))
);


ALTER TABLE public.passport_history OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."position" (
    id integer NOT NULL,
    title text NOT NULL,
    responsibilities text NOT NULL
);


ALTER TABLE public."position" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16415)
-- Name: positions_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.positions_history (
    id integer NOT NULL,
    emp_pos_id integer NOT NULL,
    emp_id integer NOT NULL,
    salary integer NOT NULL,
    date_start date NOT NULL,
    date_end date
);


ALTER TABLE public.positions_history OWNER TO postgres;

--
-- TOC entry 4910 (class 0 OID 16593)
-- Dependencies: 226
-- Data for Name: accident; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accident (id, instance_id, damage, date, place) FROM stdin;
1	14	108967	2024-07-07 20:19:24+03	59.911711, 30.318259
2	12	293932	2018-12-11 06:09:00+03	59.875907, 30.319792
3	15	68618	2020-12-29 05:08:45+03	59.925184, 30.383394
4	5	328944	2020-07-10 14:35:43+03	59.925184, 30.383394
5	16	320469	2021-07-17 07:23:46+03	59.960323, 30.338080
6	6	79982	2018-10-13 01:31:41+03	59.832748, 30.441285
7	11	260342	2024-02-20 01:21:49+03	59.929985, 30.410788
8	2	121309	2024-04-14 15:35:54+03	59.947947, 30.283215
9	7	716988	2019-07-07 04:17:45+03	59.888628, 30.524698
\.


--
-- TOC entry 4904 (class 0 OID 16492)
-- Dependencies: 220
-- Data for Name: brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brand (id, name, insurance_type, insurance_cost, collateral_value) FROM stdin;
1	Toyota	Полная	10000	15000
2	Honda	Частичная	8000	15000
3	BMW	Полная	20000	40000
4	Mercedes-Benz	Частичная	20000	40000
5	Audi	Частичная	20000	40000
6	Volkswagen	Полная	10000	12000
7	Ford	Частичная	8000	12000
8	Chevrolet	Частичная	8000	15000
9	Hyundai	Полная	6000	10000
10	Kia	Частичная	6000	10000
\.


--
-- TOC entry 4906 (class 0 OID 16528)
-- Dependencies: 222
-- Data for Name: car; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.car (id, engine_id, transmission, car_body_id, fuel_consumption, info_id) FROM stdin;
1	1	auto	1	7.8	1
2	2	auto	1	9.2	1
3	3	variator	2	7.1	1
4	4	variator	3	6.2	2
5	5	manual	4	6.8	2
6	6	robotic	3	5.9	2
7	7	auto	5	9.5	3
8	8	auto	6	7.8	3
9	9	auto	7	11.3	3
10	10	auto	8	6.8	4
11	11	auto	9	6.5	4
12	12	auto	10	8.9	4
13	13	auto	11	6.5	5
14	14	manual	12	6.2	5
15	15	robotic	13	7.1	5
16	16	manual	14	5.9	6
17	17	auto	15	6.4	6
18	18	robotic	16	6.7	6
19	19	auto	17	13.5	7
20	20	auto	18	11.8	7
21	21	auto	19	14.2	7
22	22	auto	20	12.3	8
23	23	auto	21	9.8	8
24	24	robotic	22	15	8
25	25	auto	23	7.4	9
26	26	manual	24	6.9	9
27	27	robotic	25	7.8	9
28	28	manual	26	6.1	10
29	29	auto	27	6.5	10
30	30	variator	28	5.8	10
\.


--
-- TOC entry 4908 (class 0 OID 16561)
-- Dependencies: 224
-- Data for Name: car_body; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.car_body (id, clearence, trunk_volume, seats_count) FROM stdin;
1	155	480	5
2	153	493	5
3	135	420	5
4	137	428	5
5	210	650	5
6	212	645	5
7	208	660	5
8	150	540	5
9	152	530	5
10	148	550	5
11	160	460	5
12	158	455	5
13	162	465	5
14	145	380	5
15	143	375	5
16	147	385	5
17	250	1700	5
18	245	1650	5
19	255	1720	5
20	120	320	4
21	122	310	4
22	118	330	4
23	185	550	5
24	183	540	5
25	187	560	5
26	160	500	5
27	158	495	5
28	155	490	5
\.


--
-- TOC entry 4905 (class 0 OID 16511)
-- Dependencies: 221
-- Data for Name: car_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.car_info (id, brand_id, model, description) FROM stdin;
1	1	Camry	Надёжный седан бизнес-класса с комфортным салоном и плавной подвеской
2	2	Civic	Компактный и экономичный автомобиль с современным дизайном
3	3	X5	Роскошный внедорожник с мощными двигателями и премиальным интерьером
4	4	E-Class	Элегантный бизнес-седан с высококачественными материалами отделки
5	5	A4	Динамичный премиальный седан с прогрессивными технологиями
6	6	Golf	Культовый хэтчбек с отличной управляемостью и практичностью
7	7	F-150	Мощный полноразмерный пикап для работы и активного отдыха
8	8	Camaro	Легендарный спортивный автомобиль с агрессивным дизайном
9	9	Tucson	Современный кроссовер с богатым оснащением и просторным салоном
10	10	Rio	Доступный компактный автомобиль с хорошей комплектацией
\.


--
-- TOC entry 4909 (class 0 OID 16581)
-- Dependencies: 225
-- Data for Name: car_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.car_instance (id, car_id, reg_code, vin_code, special_marks, engine_code, last_maintenance, price, mileage, year) FROM stdin;
1	16	А123АВ78	XTA210990Y1234567	\N	VWEA2114TSI12345	2024-10-15	850000	120000	2015
2	7	В234ВС78	Y6TF51234A9876543	\N	BMWB58B30M123456	2024-11-20	4200000	60000	2019
3	22	С345СТ78	Z7VG98765B4567890	\N	CHVLT1V86212345	2024-12-05	3800000	50000	2017
4	3	Е456ЕК78	XWB654321C7890123	\N	TYTA25AFKS123456	2024-10-25	2100000	75000	2018
5	10	К567КМ78	YTC321098D2345678	\N	MBM27420T123456	2024-11-10	3200000	90000	2017
6	16	М678МН78	ZUD210987E3456789	\N	VWEA2114TSI67890	2024-12-15	780000	120000	2015
7	25	Н789НО78	XVF987654F4567890	\N	HYTTHETA2023456	2024-10-30	1850000	55000	2019
8	7	О890ОР78	YWG876543G5678901	\N	BMWB58B30M789012	2024-11-25	4500000	60000	2019
9	13	Р901РУ78	ZXH765432H6789012	\N	AUDEA88820T1234	2024-12-20	2800000	110000	2016
10	22	С012СХ78	XAI654321I7890123	\N	CHVLT1V86267890	2024-11-05	3700000	50000	2017
11	4	Т123ТА78	YBJ543210J8901234	\N	HONL15B15T12345	2024-12-10	2200000	45000	2020
12	10	У234УВ78	ZCK432109K9012345	\N	MBM27420T789012	2024-10-20	3100000	90000	2017
13	16	Х345ХЕ78	XDL321098L0123456	\N	VWEA2114TSI34567	2024-11-15	800000	120000	2015
14	19	А456АК78	YEM210987M1234567	\N	FORDCOYOTE50123	2024-12-25	5200000	30000	2021
15	25	В567ВМ78	ZFN987654N2345678	\N	HYTTHETA2078901	2024-10-10	1950000	55000	2019
16	7	Е678ЕН78	XGO876543O3456789	\N	BMWB58B30M345678	2024-11-30	4300000	60000	2019
17	1	М846ОА178	JN8AZ28R59T103357	\N	TOY2ARFEJPN789012	2025-03-20	3000000	72000	2021
\.


--
-- TOC entry 4903 (class 0 OID 16479)
-- Dependencies: 219
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, full_name, phone, adress, discount) FROM stdin;
1	Tripp Norville	+51 (393) 623-2058	35275 Springview Parkway	\N
2	Koressa Rapin	+62 (861) 730-6013	1128 Crownhardt Circle	\N
3	Tremaine Domotor	+86 (922) 846-6017	7155 6th Trail	\N
4	Eloisa Biaggioni	+964 (613) 667-5163	4937 Anniversary Place	\N
5	Aland Kuhlen	+98 (832) 788-4098	26970 Tennessee Way	\N
7	Parrnell Timlett	+57 (469) 279-7784	78 Oneill Circle	\N
8	Minnaminnie Cornick	+66 (265) 252-9747	4 Menomonie Junction	\N
9	Waldon Pessler	+977 (534) 374-1599	4 Sloan Lane	\N
10	Ardra Leamon	+420 (312) 318-0507	444 Hudson Junction	\N
11	Klarrisa Heggman	+994 (922) 196-0200	5639 Bobwhite Crossing	\N
12	Sarena Smeal	+593 (369) 366-9448	0 Calypso Plaza	\N
14	Nahum Larvin	+420 (443) 589-8990	513 Hazelcrest Hill	\N
15	Forrester Leitch	+27 (755) 227-6784	5 Vahlen Avenue	\N
16	Addie Lucian	+62 (718) 277-1976	64134 Mariners Cove Plaza	\N
17	Ritchie Leadbetter	+504 (647) 617-3794	68 Gateway Drive	\N
18	Savina Knutsen	+48 (367) 814-9637	73 Killdeer Place	\N
19	Mauricio Playfair	+51 (212) 328-2630	63 Sunnyside Hill	\N
20	Megen Dryden	+235 (578) 613-9254	1 Center Park	0.09
21	Gabie Matityahu	+63 (936) 721-1412	65 Mcbride Crossing	\N
22	Ardyth Edlestone	+351 (677) 991-6963	12 Nova Drive	\N
23	Slade Mundell	+221 (290) 965-9337	4670 Stephen Plaza	\N
24	Wilmar Witten	+1 (817) 623-4823	72 Sheridan Pass	\N
25	Ethelyn Vaadeland	+359 (941) 136-1612	5 Butternut Alley	\N
26	Udall Cordet	+86 (683) 765-2678	5 Larry Place	\N
27	Eilis Aubrey	+33 (935) 917-4339	57 Crownhardt Avenue	\N
28	Shela Danielut	+86 (966) 642-6833	79615 Logan Terrace	\N
29	Orville Knoles	+420 (632) 649-5186	4 Clyde Gallagher Park	\N
30	Hyman Hargrave	+351 (208) 243-0639	2432 Mcbride Trail	\N
31	Rafaela Haugh	+48 (266) 750-0122	15 Northview Crossing	\N
32	Myriam McElwee	+86 (977) 144-5897	48303 Forest Run Terrace	\N
33	Mickie Paxforde	+63 (889) 262-8639	1534 Lerdahl Parkway	\N
34	Guy Chenery	+62 (172) 232-8446	6961 Amoth Avenue	\N
35	Thekla Rosenfeld	+55 (940) 484-4482	168 Bunker Hill Terrace	\N
37	Nannette Lamberteschi	+86 (468) 385-9534	94849 Sugar Junction	\N
39	Zuzana Jeannot	+30 (723) 826-3575	668 Carey Court	\N
40	Ava Dumbrell	+385 (514) 219-6430	0 Packers Circle	\N
41	Peter Kupis	+389 (949) 158-4031	3 Green Junction	\N
43	Ivar Beelby	+351 (882) 656-1964	6 Macpherson Parkway	\N
44	Mellisa Mattia	+86 (282) 297-1872	3 Hollow Ridge Trail	\N
45	Lothaire Paladini	+62 (996) 490-7913	16315 Maple Wood Terrace	\N
47	L;urette Dommerque	+55 (640) 102-0875	1 Logan Alley	\N
48	Davis Colum	+86 (800) 578-3258	8 Dunning Court	\N
49	Winthrop Readwood	+1 (661) 243-4212	9649 Jenifer Trail	\N
50	Grenville Emm	+66 (174) 727-7387	9 Lien Drive	\N
51	Derrek Ammer	+86 (648) 188-7053	82822 Susan Way	\N
52	Wyn Bertolaccini	+54 (999) 121-0680	2 Stang Circle	\N
53	Jonas Trickey	+81 (596) 821-4142	5626 Express Place	\N
54	Harrison Skeel	+86 (942) 990-5255	59 Lakeland Court	0.22
55	Kare Ferronet	+420 (156) 613-3898	975 Colorado Trail	\N
56	Malvina Bevington	+46 (212) 436-3936	6 American Ash Lane	\N
57	Cleo Simkins	+86 (465) 653-0025	3125 Sommers Junction	\N
58	Nancee Durrad	+58 (879) 735-2715	47 Golden Leaf Road	\N
59	Cyrille Van Hove	+7 (553) 917-6382	480 Drewry Point	\N
60	Gaynor Burney	+216 (771) 614-0978	384 Luster Center	\N
61	Baryram Ripsher	+57 (638) 571-4313	74811 Monica Plaza	\N
62	Jeana Dossit	+233 (172) 626-0626	730 Independence Place	\N
63	Gonzalo Archer	+66 (670) 717-1032	98 Derek Court	\N
64	Kristian Harbord	+52 (413) 178-5252	1 Claremont Center	\N
65	Killy Conachy	+355 (732) 269-4813	01 Spenser Street	\N
67	Chrissie Tinson	+1 (309) 674-9529	7 Fisk Avenue	\N
68	Engracia MacTavish	+63 (587) 164-6555	78622 Tennessee Street	\N
69	Edyth Giffon	+1 (405) 427-1801	23104 Dakota Lane	\N
70	Agnola Chinge de Hals	+351 (773) 205-0007	17781 Grover Alley	\N
71	Branden Kitchaside	+86 (219) 734-8361	499 Di Loreto Drive	\N
72	Julie Grebert	+7 (967) 549-6432	618 Blue Bill Park Street	\N
73	Josiah Pratley	+57 (946) 754-5508	69093 Doe Crossing Alley	0.08
74	Queenie Withrop	+216 (197) 795-2857	75 Maywood Hill	\N
75	Ivory Senyard	+263 (594) 162-2022	21 Independence Trail	\N
76	Mathias Losano	+33 (415) 340-2898	083 Anhalt Center	\N
77	Emmery Knyvett	+46 (871) 700-3873	73 Arkansas Junction	\N
78	Raleigh Genicke	+86 (396) 200-3650	870 Karstens Crossing	\N
79	Johnathon Epp	+995 (154) 350-7736	61442 Mariners Cove Circle	\N
81	Val Owbridge	+351 (364) 503-1882	8224 Morrow Place	0.18
82	Lyman FitzGilbert	+86 (826) 872-9245	2320 Butternut Court	\N
84	Anabel Luckcuck	+86 (234) 954-5566	12044 Fairview Junction	\N
85	Bess Wanklin	+242 (501) 661-2383	6930 7th Way	\N
86	Bing Brazenor	+86 (260) 724-4185	43 Division Avenue	0.1
87	Wilmette Conrart	+385 (882) 173-7853	55 Onsgard Drive	\N
88	Valma Weathers	+380 (724) 768-1979	69960 Bluestem Avenue	\N
89	Britta Paolacci	+54 (359) 751-0181	1 North Circle	\N
90	Charita McKee	+63 (222) 304-2295	5 Stone Corner Way	\N
91	Codee Keely	+58 (393) 812-6728	963 Sachtjen Terrace	\N
92	Gilligan Kittless	+1 (904) 142-3576	4671 Chinook Lane	\N
93	Harriet Aubert	+66 (232) 824-4836	825 Cottonwood Parkway	\N
95	Cyndi Fenck	+352 (557) 864-1394	74 Kim Avenue	\N
96	Chrissy Jantet	+52 (774) 165-3141	024 Kipling Road	\N
97	Yulma Seabrocke	+86 (242) 335-6544	9 Mockingbird Circle	\N
98	Ynes Lorimer	+86 (340) 676-4313	76313 Susan Parkway	\N
99	Warden Muckart	+62 (481) 346-4857	54566 Butternut Parkway	\N
100	Rubetta Marsham	+598 (580) 340-7423	03 Artisan Parkway	\N
6	Berrie Shawyers	+970 (306) 858-3949	1 Clarendon Point	0.08
13	Sheeree Lepoidevin	+34 (746) 337-6678	833 Sunnyside Center	0.03
36	Henka Whyte	+62 (735) 261-2847	11 Hoard Street	0.01
38	Seth Van der Krui	+380 (392) 971-5053	707 Annamark Circle	0.06
42	Jandy Stonner	+1 (202) 252-5946	625 Portage Junction	0.07
46	Kata Roberti	+86 (265) 741-9532	18502 Eagan Alley	0.23
66	Hugo Monnoyer	+86 (294) 593-8098	16 Merry Point	0.22
80	Devon Iwaszkiewicz	+33 (560) 958-6003	1741 Waywood Alley	0.03
83	Clemmie Betton	+7 (523) 328-4636	93 Dayton Junction	0.06
94	Herta Ewebank	+7 (822) 116-2580	3 Leroy Road	0.05
\.


--
-- TOC entry 4912 (class 0 OID 16616)
-- Dependencies: 228
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract (id, instance_id, passport_id, price, date_start, rent_scan_ref, rent_emp_id, return_scan_ref, return_emp_id, delay) FROM stdin;
1	1	35	2400	2020-01-25 20:50:00+03	\N	1	\N	3	0
2	1	70	2400	2020-02-11 12:25:00+03	\N	3	\N	1	0
3	1	51	2400	2020-04-30 12:10:00+03	\N	2	\N	3	0
4	1	11	2400	2020-06-09 19:50:00+03	\N	2	\N	2	0
5	1	65	2400	2020-07-24 14:25:00+03	\N	2	\N	2	0
6	1	75	2400	2020-08-14 17:18:00+03	\N	2	\N	3	0
7	1	17	2400	2020-09-29 19:57:00+03	\N	1	\N	3	0
8	1	36	2400	2020-10-27 11:49:00+03	\N	1	\N	3	0
9	1	13	2400	2020-12-10 19:56:00+03	\N	2	\N	1	0
10	1	59	2400	2021-01-10 17:45:00+03	\N	1	\N	1	0
11	1	49	2400	2021-01-26 19:27:00+03	\N	2	\N	1	0
12	1	45	2400	2021-04-03 09:26:00+03	\N	2	\N	2	12
13	1	68	2400	2021-05-11 21:33:00+03	\N	1	\N	1	15
14	1	11	2400	2021-06-05 17:21:00+03	\N	1	\N	2	0
15	1	94	2400	2021-08-03 16:40:00+03	\N	1	\N	2	0
16	1	18	2400	2021-09-16 13:26:00+03	\N	3	\N	3	20
17	1	14	2400	2021-12-15 18:26:00+03	\N	3	\N	3	0
18	1	40	2400	2022-01-27 18:50:00+03	\N	1	\N	2	0
19	1	33	2400	2022-03-07 19:20:00+03	\N	3	\N	2	0
20	1	52	2400	2022-04-15 17:25:00+03	\N	2	\N	2	0
21	1	100	2400	2022-05-20 14:08:00+03	\N	3	\N	2	0
22	1	9	2400	2022-06-11 12:27:00+03	\N	1	\N	2	0
23	1	95	2400	2022-08-12 19:08:00+03	\N	3	\N	1	0
24	1	35	2400	2022-10-09 17:48:00+03	\N	2	\N	2	6
25	1	83	2400	2022-11-09 13:54:00+03	\N	1	\N	2	0
26	1	16	2400	2022-12-02 10:12:00+03	\N	3	\N	2	0
27	1	46	2400	2023-01-10 18:09:00+03	\N	2	\N	2	0
28	1	86	2400	2023-02-07 17:02:00+03	\N	1	\N	1	0
29	1	10	2400	2023-03-23 21:58:00+03	\N	2	\N	2	0
30	1	70	2400	2023-05-01 16:29:00+03	\N	2	\N	3	0
31	1	82	2400	2023-05-25 21:16:00+03	\N	1	\N	1	0
32	1	5	2400	2023-06-22 21:11:00+03	\N	1	\N	3	3
33	1	35	2400	2023-07-13 15:05:00+03	\N	3	\N	2	0
34	1	41	2400	2023-07-30 11:34:00+03	\N	2	\N	3	0
35	1	96	2400	2023-08-20 12:15:00+03	\N	1	\N	1	0
36	1	27	2400	2023-09-04 18:47:00+03	\N	3	\N	2	19
37	1	63	2400	2023-10-07 09:56:00+03	\N	2	\N	2	8
38	1	89	2400	2023-11-20 13:43:00+03	\N	2	\N	3	0
39	1	72	2400	2024-02-01 18:39:00+03	\N	3	\N	2	0
40	1	67	2400	2024-02-26 12:54:00+03	\N	1	\N	2	0
41	1	53	2400	2024-04-05 09:37:00+03	\N	2	\N	2	0
42	1	60	2400	2024-04-16 19:14:00+03	\N	1	\N	3	0
43	1	62	2400	2024-04-28 16:57:00+03	\N	3	\N	3	0
44	1	76	2400	2024-05-15 20:21:00+03	\N	3	\N	2	0
45	1	13	2400	2024-06-10 09:44:00+03	\N	2	\N	3	0
46	1	31	2400	2024-06-27 20:32:00+03	\N	3	\N	2	0
47	1	48	2400	2024-07-15 12:00:00+03	\N	3	\N	2	0
48	1	60	2400	2024-07-31 21:05:00+03	\N	3	\N	3	9
49	1	2	2400	2024-09-21 15:51:00+03	\N	1	\N	1	0
50	1	37	2400	2024-10-28 09:10:00+03	\N	1	\N	1	0
51	1	32	2400	2024-12-22 21:08:00+03	\N	2	\N	1	0
52	1	35	2400	2025-01-11 17:02:00+03	\N	1	\N	2	0
53	1	76	2400	2025-02-03 10:34:00+03	\N	3	\N	3	0
54	2	72	12600	2021-08-20 22:17:00+03	\N	2	\N	1	0
55	2	47	12600	2021-10-02 11:21:00+03	\N	2	\N	1	0
56	2	87	12600	2021-11-18 15:48:00+03	\N	3	\N	2	0
57	2	71	12600	2022-02-13 18:39:00+03	\N	1	\N	2	0
58	2	48	12600	2022-04-13 20:13:00+03	\N	3	\N	1	0
59	2	2	12600	2022-06-24 16:04:00+03	\N	3	\N	3	0
60	2	83	12600	2022-08-29 11:23:00+03	\N	2	\N	2	0
61	2	54	12600	2022-10-04 17:13:00+03	\N	1	\N	1	0
62	2	84	12600	2022-11-11 09:53:00+03	\N	2	\N	2	0
63	2	18	12600	2022-12-26 13:34:00+03	\N	3	\N	2	16
64	2	94	12600	2023-02-05 16:31:00+03	\N	3	\N	2	0
65	2	13	12600	2023-03-03 13:33:00+03	\N	2	\N	3	0
66	2	67	12600	2023-05-11 19:26:00+03	\N	2	\N	1	15
67	2	33	12600	2023-06-08 14:14:00+03	\N	2	\N	1	0
68	2	52	12600	2023-07-09 09:31:00+03	\N	2	\N	1	0
69	2	38	12600	2023-10-02 14:10:00+03	\N	1	\N	2	0
70	2	69	12600	2023-11-24 13:22:00+03	\N	3	\N	3	0
71	2	26	12600	2023-12-24 14:24:00+03	\N	3	\N	2	0
72	2	35	12600	2024-01-15 15:52:00+03	\N	3	\N	2	0
73	2	73	12600	2024-02-29 10:43:00+03	\N	2	\N	1	0
74	2	24	12600	2024-03-15 18:24:00+03	\N	2	\N	2	0
75	2	52	12600	2024-04-11 09:15:00+03	\N	3	\N	3	0
76	2	99	12600	2024-05-09 20:46:00+03	\N	3	\N	3	0
77	2	18	12600	2024-06-11 14:42:00+03	\N	2	\N	2	0
78	2	12	12600	2024-06-13 15:43:00+03	\N	1	\N	2	0
79	2	42	12600	2024-07-16 12:16:00+03	\N	1	\N	3	0
80	2	22	12600	2024-09-12 12:26:00+03	\N	1	\N	1	0
81	2	45	12600	2024-10-07 14:38:00+03	\N	3	\N	2	0
82	2	4	12600	2024-12-06 18:02:00+03	\N	1	\N	2	0
83	2	66	12600	2025-01-10 16:36:00+03	\N	1	\N	3	0
84	2	79	12600	2025-02-03 21:24:00+03	\N	3	\N	1	0
85	3	80	11100	2022-11-30 19:31:00+03	\N	3	\N	2	0
86	3	40	11100	2023-01-25 11:11:00+03	\N	3	\N	3	0
87	3	98	11100	2023-02-26 16:09:00+03	\N	2	\N	2	0
88	3	28	11100	2023-03-26 16:00:00+03	\N	2	\N	3	0
89	3	40	11100	2023-04-06 18:48:00+03	\N	3	\N	2	0
90	3	38	11100	2023-07-07 20:05:00+03	\N	1	\N	2	0
91	3	52	11100	2023-07-27 18:50:00+03	\N	3	\N	1	0
92	3	82	11100	2023-08-16 09:41:00+03	\N	2	\N	2	0
93	3	43	11100	2023-10-16 20:54:00+03	\N	1	\N	2	0
94	3	95	11100	2023-11-27 19:07:00+03	\N	3	\N	1	23
95	3	72	11100	2024-02-08 19:11:00+03	\N	2	\N	3	0
96	3	60	11100	2024-04-15 09:52:00+03	\N	1	\N	1	0
97	3	87	11100	2024-05-12 13:06:00+03	\N	3	\N	3	0
98	3	31	11100	2024-06-04 16:34:00+03	\N	3	\N	2	0
99	3	46	11100	2024-07-10 10:55:00+03	\N	1	\N	2	0
100	3	18	11100	2024-09-30 11:13:00+03	\N	1	\N	1	0
101	3	25	11100	2024-12-27 18:14:00+03	\N	3	\N	1	15
102	3	40	11100	2025-01-01 15:30:00+03	\N	1	\N	3	0
103	3	36	11100	2025-01-24 17:37:00+03	\N	3	\N	1	0
104	3	74	11100	2025-02-02 17:22:00+03	\N	1	\N	3	0
105	3	85	11100	2025-02-21 20:46:00+03	\N	1	\N	1	0
106	4	37	6300	2024-04-23 17:05:00+03	\N	3	\N	2	10
107	4	19	6300	2024-06-22 12:47:00+03	\N	2	\N	1	0
108	4	16	6300	2024-09-09 10:50:00+03	\N	2	\N	1	0
109	4	29	6300	2024-09-25 11:23:00+03	\N	1	\N	1	0
110	4	96	6300	2024-11-13 11:53:00+03	\N	1	\N	2	0
111	4	28	6300	2024-12-21 12:21:00+03	\N	2	\N	2	0
112	4	59	6300	2025-01-07 15:18:00+03	\N	1	\N	2	0
113	4	74	6300	2025-02-04 18:10:00+03	\N	3	\N	2	0
114	5	97	9600	2021-11-08 17:09:00+03	\N	2	\N	2	0
115	5	6	9600	2021-12-13 12:20:00+03	\N	1	\N	1	0
116	5	32	9600	2021-12-27 13:35:00+03	\N	3	\N	1	0
117	5	29	9600	2022-03-02 10:41:00+03	\N	3	\N	1	0
118	5	48	9600	2022-04-22 15:08:00+03	\N	2	\N	3	0
119	5	76	9600	2022-05-15 10:41:00+03	\N	3	\N	3	0
120	5	42	9600	2022-07-01 13:25:00+03	\N	1	\N	2	0
121	5	64	9600	2022-07-27 10:25:00+03	\N	1	\N	1	13
122	5	80	9600	2022-11-09 13:00:00+03	\N	1	\N	1	0
123	5	22	9600	2022-12-14 11:03:00+03	\N	3	\N	2	0
124	5	74	9600	2023-02-13 11:15:00+03	\N	2	\N	1	20
125	5	2	9600	2023-03-12 19:04:00+03	\N	2	\N	1	0
126	5	53	9600	2023-04-12 13:51:00+03	\N	2	\N	3	0
127	5	66	9600	2023-04-29 21:54:00+03	\N	3	\N	2	21
128	5	29	9600	2023-06-10 11:16:00+03	\N	1	\N	3	0
129	5	35	9600	2023-07-25 10:42:00+03	\N	2	\N	1	0
130	5	55	9600	2023-10-09 10:51:00+03	\N	3	\N	1	11
131	5	5	9600	2023-12-18 15:45:00+03	\N	1	\N	3	0
132	5	46	9600	2024-01-12 17:35:00+03	\N	3	\N	3	0
133	5	77	9600	2024-02-05 17:08:00+03	\N	1	\N	2	0
134	5	27	9600	2024-03-24 18:05:00+03	\N	2	\N	1	0
135	5	69	9600	2024-05-14 12:42:00+03	\N	3	\N	1	0
136	5	25	9600	2024-06-28 11:03:00+03	\N	1	\N	3	0
137	5	69	9600	2024-08-18 18:20:00+03	\N	3	\N	2	0
138	5	43	9600	2024-10-18 14:46:00+03	\N	1	\N	2	21
139	5	50	9600	2025-01-05 13:38:00+03	\N	1	\N	2	0
140	5	49	9600	2025-01-29 14:36:00+03	\N	1	\N	3	0
141	6	74	2400	2020-05-19 10:04:00+03	\N	3	\N	1	0
142	6	24	2400	2020-06-11 11:09:00+03	\N	3	\N	2	0
143	6	46	2400	2020-07-17 11:07:00+03	\N	2	\N	3	0
144	6	16	2400	2020-09-17 12:28:00+03	\N	3	\N	1	0
145	6	18	2400	2020-09-28 21:32:00+03	\N	1	\N	3	0
146	6	88	2400	2020-11-16 13:23:00+03	\N	1	\N	2	0
147	6	15	2400	2020-12-24 10:49:00+03	\N	2	\N	1	0
148	6	45	2400	2021-01-17 19:39:00+03	\N	2	\N	3	0
149	6	78	2400	2021-02-12 18:05:00+03	\N	1	\N	2	0
150	6	14	2400	2021-03-14 13:23:00+03	\N	2	\N	3	0
151	6	57	2400	2021-04-22 14:29:00+03	\N	1	\N	2	0
152	6	79	2400	2021-05-22 10:05:00+03	\N	3	\N	3	0
153	6	20	2400	2021-06-24 19:40:00+03	\N	1	\N	2	0
154	6	84	2400	2021-08-03 12:42:00+03	\N	1	\N	1	2
155	6	68	2400	2021-08-18 19:06:00+03	\N	1	\N	2	0
156	6	7	2400	2021-09-30 15:02:00+03	\N	3	\N	3	0
157	6	16	2400	2021-12-11 13:35:00+03	\N	3	\N	1	0
158	6	39	2400	2022-01-22 12:14:00+03	\N	1	\N	3	0
159	6	10	2400	2022-03-16 21:24:00+03	\N	3	\N	2	0
160	6	54	2400	2022-04-12 10:22:00+03	\N	3	\N	2	0
161	6	26	2400	2022-06-20 17:29:00+03	\N	1	\N	1	0
162	6	78	2400	2022-08-17 15:40:00+03	\N	2	\N	2	0
163	6	70	2400	2022-08-19 16:30:00+03	\N	1	\N	2	0
164	6	72	2400	2022-11-13 13:33:00+03	\N	1	\N	2	0
165	6	73	2400	2023-02-03 11:33:00+03	\N	2	\N	1	0
166	6	99	2400	2023-02-24 16:35:00+03	\N	1	\N	3	0
167	6	32	2400	2023-03-18 18:50:00+03	\N	2	\N	3	0
168	6	82	2400	2023-05-15 10:46:00+03	\N	2	\N	1	0
169	6	30	2400	2023-06-10 17:30:00+03	\N	2	\N	3	0
170	6	63	2400	2023-07-30 14:13:00+03	\N	2	\N	1	0
171	6	25	2400	2023-09-17 10:52:00+03	\N	3	\N	2	0
172	6	37	2400	2023-10-26 15:32:00+03	\N	1	\N	2	0
173	6	18	2400	2023-12-17 16:31:00+03	\N	3	\N	2	0
174	6	36	2400	2024-01-05 16:38:00+03	\N	1	\N	2	0
175	6	1	2400	2024-03-23 09:59:00+03	\N	2	\N	1	0
176	6	93	2400	2024-05-11 19:01:00+03	\N	2	\N	1	0
177	6	53	2400	2024-07-31 14:35:00+03	\N	3	\N	1	0
178	6	20	2400	2024-09-05 12:13:00+03	\N	2	\N	3	0
179	6	36	2400	2024-10-03 20:38:00+03	\N	3	\N	1	0
180	6	83	2400	2024-11-18 18:07:00+03	\N	1	\N	3	0
181	6	5	2400	2024-12-02 19:46:00+03	\N	2	\N	3	0
182	6	97	2400	2025-02-21 12:55:00+03	\N	3	\N	2	0
183	7	27	6000	2024-03-21 09:02:00+03	\N	1	\N	3	0
184	7	55	6000	2024-04-11 11:04:00+03	\N	3	\N	2	0
185	7	84	6000	2024-05-22 18:52:00+03	\N	2	\N	3	13
186	7	53	6000	2024-07-21 20:44:00+03	\N	2	\N	1	0
187	7	17	6000	2024-09-26 12:20:00+03	\N	3	\N	3	0
188	7	87	6000	2024-11-01 09:51:00+03	\N	2	\N	3	0
189	7	31	6000	2024-12-30 20:27:00+03	\N	2	\N	2	0
190	7	80	6000	2025-02-14 11:53:00+03	\N	3	\N	2	0
191	8	38	12600	2024-01-22 19:28:00+03	\N	3	\N	2	0
192	8	17	12600	2024-03-13 18:19:00+03	\N	2	\N	1	0
193	8	55	12600	2024-04-13 14:03:00+03	\N	3	\N	3	0
194	8	40	12600	2024-04-25 11:59:00+03	\N	2	\N	3	0
195	8	16	12600	2024-06-13 12:25:00+03	\N	3	\N	3	0
196	8	99	12600	2024-08-29 09:41:00+03	\N	2	\N	1	0
197	8	17	12600	2024-09-10 12:00:00+03	\N	2	\N	3	0
198	8	17	12600	2024-09-30 13:43:00+03	\N	2	\N	3	0
199	8	35	12600	2025-01-23 09:12:00+03	\N	2	\N	1	0
200	9	9	8400	2023-03-15 12:29:00+03	\N	2	\N	1	0
201	9	58	8400	2023-04-09 15:20:00+03	\N	1	\N	2	0
202	9	100	8400	2023-05-15 15:33:00+03	\N	1	\N	2	0
203	9	60	8400	2023-07-20 18:56:00+03	\N	2	\N	1	0
204	9	5	8400	2023-09-18 16:15:00+03	\N	2	\N	2	0
205	9	3	8400	2023-12-17 16:23:00+03	\N	3	\N	1	0
206	9	60	8400	2024-01-15 12:52:00+03	\N	1	\N	3	0
207	9	74	8400	2024-02-06 12:00:00+03	\N	3	\N	2	10
208	9	10	8400	2024-03-05 12:44:00+03	\N	3	\N	2	0
209	9	35	8400	2024-04-12 19:33:00+03	\N	3	\N	1	0
210	9	87	8400	2024-05-10 10:18:00+03	\N	3	\N	2	0
211	9	48	8400	2024-07-09 12:29:00+03	\N	1	\N	1	0
212	9	4	8400	2024-09-09 12:46:00+03	\N	2	\N	1	0
213	9	56	8400	2024-10-17 09:38:00+03	\N	1	\N	1	0
214	9	38	8400	2025-01-08 21:06:00+03	\N	3	\N	2	0
215	9	90	8400	2025-02-25 20:47:00+03	\N	1	\N	2	0
216	10	35	11100	2022-04-24 18:51:00+03	\N	2	\N	3	0
217	10	69	11100	2022-05-28 10:02:00+03	\N	1	\N	1	0
218	10	1	11100	2022-06-24 21:57:00+03	\N	2	\N	2	0
219	10	93	11100	2022-08-05 21:01:00+03	\N	1	\N	3	0
220	10	32	11100	2022-09-09 14:18:00+03	\N	2	\N	2	0
221	10	61	11100	2022-10-15 11:37:00+03	\N	3	\N	2	0
222	10	43	11100	2022-10-29 13:03:00+03	\N	2	\N	3	0
223	10	99	11100	2023-02-05 12:31:00+03	\N	3	\N	3	0
224	10	9	11100	2023-03-30 15:21:00+03	\N	1	\N	3	0
225	10	83	11100	2023-05-15 11:48:00+03	\N	1	\N	1	21
226	10	9	11100	2023-06-15 21:06:00+03	\N	2	\N	3	0
227	10	38	11100	2023-07-18 13:17:00+03	\N	3	\N	3	0
228	10	20	11100	2023-09-06 11:00:00+03	\N	3	\N	3	0
229	10	23	11100	2023-09-30 13:50:00+03	\N	3	\N	2	0
230	10	69	11100	2023-11-02 12:47:00+03	\N	1	\N	3	0
231	10	93	11100	2023-11-23 19:47:00+03	\N	2	\N	1	19
232	10	31	11100	2023-12-09 16:43:00+03	\N	1	\N	3	19
233	10	58	11100	2024-01-19 14:24:00+03	\N	1	\N	3	10
234	10	42	11100	2024-04-15 18:15:00+03	\N	1	\N	1	0
235	10	33	11100	2024-06-06 09:01:00+03	\N	3	\N	1	0
236	10	36	11100	2024-07-14 14:03:00+03	\N	3	\N	3	0
237	10	97	11100	2024-08-18 19:04:00+03	\N	2	\N	1	0
238	10	15	11100	2024-09-13 09:55:00+03	\N	1	\N	3	0
239	10	19	11100	2024-09-30 15:07:00+03	\N	1	\N	3	0
240	10	82	11100	2024-11-21 16:07:00+03	\N	2	\N	1	0
241	10	14	11100	2024-12-16 14:56:00+03	\N	2	\N	2	0
242	11	94	6000	2021-08-16 12:08:00+03	\N	1	\N	3	19
243	11	10	6000	2021-09-05 20:42:00+03	\N	3	\N	1	0
244	11	14	6000	2021-09-18 15:07:00+03	\N	1	\N	1	0
245	11	78	6000	2021-11-03 19:47:00+03	\N	1	\N	2	0
246	11	85	6000	2021-11-29 12:05:00+03	\N	2	\N	3	0
247	11	42	6000	2022-01-06 20:10:00+03	\N	3	\N	2	0
248	11	8	6000	2022-03-17 11:39:00+03	\N	1	\N	3	0
249	11	97	6000	2022-05-15 11:23:00+03	\N	1	\N	1	0
250	11	35	6000	2022-07-17 12:00:00+03	\N	2	\N	2	0
251	11	15	6000	2022-09-06 14:32:00+03	\N	1	\N	3	0
252	11	55	6000	2022-10-10 14:17:00+03	\N	1	\N	3	0
253	11	13	6000	2022-12-06 16:10:00+03	\N	2	\N	3	0
254	11	56	6000	2023-01-09 14:34:00+03	\N	3	\N	1	0
255	11	22	6000	2023-03-02 11:50:00+03	\N	1	\N	3	0
256	11	59	6000	2023-04-18 19:19:00+03	\N	1	\N	3	3
257	11	60	6000	2023-07-01 11:40:00+03	\N	2	\N	3	0
258	11	5	6000	2023-09-11 10:06:00+03	\N	3	\N	2	0
259	11	38	6000	2023-10-29 19:13:00+03	\N	3	\N	1	0
260	11	76	6000	2023-11-21 15:29:00+03	\N	3	\N	2	0
261	11	64	6000	2024-01-14 18:55:00+03	\N	3	\N	2	0
262	11	73	6000	2024-02-12 12:46:00+03	\N	2	\N	3	0
263	11	66	6000	2024-04-27 09:13:00+03	\N	2	\N	3	19
264	11	14	6000	2024-06-06 15:34:00+03	\N	2	\N	2	0
265	11	63	6000	2024-07-29 09:30:00+03	\N	3	\N	2	0
266	11	21	6000	2024-09-13 14:41:00+03	\N	3	\N	3	0
267	11	50	6000	2024-10-14 10:45:00+03	\N	3	\N	3	0
268	11	71	6000	2024-11-15 17:29:00+03	\N	1	\N	1	0
269	11	17	6000	2024-12-17 21:50:00+03	\N	3	\N	2	17
270	12	84	9600	2021-02-01 12:19:00+03	\N	1	\N	1	0
271	12	21	9600	2021-03-11 12:42:00+03	\N	1	\N	3	0
272	12	50	9600	2021-04-29 18:27:00+03	\N	1	\N	2	0
273	12	39	9600	2021-07-17 20:09:00+03	\N	1	\N	1	0
274	12	79	9600	2021-11-09 10:06:00+03	\N	2	\N	2	0
275	12	33	9600	2021-12-09 18:20:00+03	\N	3	\N	1	0
276	12	29	9600	2021-12-14 10:03:00+03	\N	2	\N	3	0
277	12	47	9600	2022-01-14 13:19:00+03	\N	2	\N	3	21
278	12	99	9600	2022-02-05 10:47:00+03	\N	3	\N	3	0
279	12	78	9600	2022-02-25 15:46:00+03	\N	2	\N	2	0
280	12	65	9600	2022-04-10 19:46:00+03	\N	2	\N	2	0
281	12	87	9600	2022-05-15 20:29:00+03	\N	2	\N	3	0
282	12	82	9600	2022-05-22 10:48:00+03	\N	2	\N	3	0
283	12	5	9600	2022-06-10 20:33:00+03	\N	3	\N	3	0
284	12	61	9600	2022-07-11 12:12:00+03	\N	3	\N	3	0
285	12	48	9600	2022-10-08 09:27:00+03	\N	1	\N	1	0
286	12	6	9600	2022-12-01 19:12:00+03	\N	1	\N	1	0
287	12	32	9600	2022-12-15 13:20:00+03	\N	2	\N	3	0
288	12	42	9600	2023-01-10 15:23:00+03	\N	3	\N	3	0
289	12	44	9600	2023-01-29 17:18:00+03	\N	3	\N	3	0
290	12	19	9600	2023-03-05 20:11:00+03	\N	3	\N	1	0
291	12	62	9600	2023-04-18 12:21:00+03	\N	1	\N	2	0
292	12	26	9600	2023-06-08 21:48:00+03	\N	2	\N	3	0
293	12	19	9600	2023-06-16 15:12:00+03	\N	2	\N	2	0
294	12	55	9600	2023-07-31 09:48:00+03	\N	2	\N	2	3
295	12	92	9600	2023-08-31 11:21:00+03	\N	2	\N	2	0
296	12	19	9600	2023-09-17 16:35:00+03	\N	2	\N	2	0
297	12	60	9600	2023-10-21 14:18:00+03	\N	2	\N	2	0
298	12	18	9600	2023-12-06 09:21:00+03	\N	1	\N	1	0
299	12	45	9600	2024-01-12 14:44:00+03	\N	2	\N	2	3
300	12	75	9600	2024-02-03 15:33:00+03	\N	3	\N	1	0
301	12	67	9600	2024-02-29 13:35:00+03	\N	3	\N	3	0
302	12	16	9600	2024-03-26 18:25:00+03	\N	1	\N	3	0
303	12	80	9600	2024-05-19 12:34:00+03	\N	1	\N	3	0
304	12	21	9600	2024-06-27 17:04:00+03	\N	1	\N	1	0
305	12	20	9600	2024-09-14 17:41:00+03	\N	3	\N	1	0
306	12	59	9600	2024-10-18 11:44:00+03	\N	2	\N	2	0
307	12	70	9600	2024-11-09 18:19:00+03	\N	3	\N	2	0
308	12	33	9600	2024-12-02 13:41:00+03	\N	2	\N	3	0
309	12	44	9600	2025-01-03 14:52:00+03	\N	3	\N	3	0
310	13	65	2400	2022-10-26 16:56:00+03	\N	3	\N	3	10
311	13	68	2400	2022-11-17 19:25:00+03	\N	1	\N	1	0
312	13	16	2400	2022-12-08 12:27:00+03	\N	3	\N	3	0
313	13	20	2400	2022-12-28 11:32:00+03	\N	1	\N	2	23
314	13	86	2400	2023-02-07 20:37:00+03	\N	1	\N	3	0
315	13	9	2400	2023-03-21 13:36:00+03	\N	2	\N	3	0
316	13	46	2400	2023-04-25 21:37:00+03	\N	2	\N	1	0
317	13	14	2400	2023-06-01 21:03:00+03	\N	1	\N	3	0
318	13	58	2400	2023-07-16 09:55:00+03	\N	2	\N	1	0
319	13	68	2400	2023-08-01 14:35:00+03	\N	2	\N	3	0
320	13	59	2400	2023-10-08 18:21:00+03	\N	1	\N	2	0
321	13	86	2400	2023-11-15 09:33:00+03	\N	3	\N	3	0
322	13	5	2400	2023-12-29 19:59:00+03	\N	3	\N	1	19
323	13	69	2400	2024-02-26 09:57:00+03	\N	1	\N	2	0
324	13	19	2400	2024-03-08 11:07:00+03	\N	3	\N	1	0
325	13	13	2400	2024-03-27 19:17:00+03	\N	1	\N	3	0
326	13	44	2400	2024-04-18 11:49:00+03	\N	2	\N	2	0
327	13	87	2400	2024-05-28 13:22:00+03	\N	2	\N	2	0
328	13	25	2400	2024-06-19 11:09:00+03	\N	3	\N	3	0
329	13	11	2400	2024-09-02 09:29:00+03	\N	3	\N	1	0
330	13	7	2400	2024-12-13 13:39:00+03	\N	2	\N	1	0
331	13	46	2400	2025-01-13 21:37:00+03	\N	2	\N	1	0
332	14	5	15600	2023-09-14 22:29:00+03	\N	1	\N	3	0
333	14	68	15600	2023-11-11 18:39:00+03	\N	1	\N	1	0
334	14	83	15600	2024-02-15 14:10:00+03	\N	1	\N	3	0
335	14	53	15600	2024-04-01 13:45:00+03	\N	3	\N	1	0
336	14	41	15600	2024-04-13 12:50:00+03	\N	1	\N	3	0
337	14	8	15600	2024-06-27 19:04:00+03	\N	3	\N	1	0
338	14	63	15600	2024-10-06 21:31:00+03	\N	2	\N	1	0
339	14	89	15600	2024-11-13 19:25:00+03	\N	2	\N	3	0
340	14	50	15600	2025-01-02 19:34:00+03	\N	2	\N	1	0
341	14	100	15600	2025-02-08 12:13:00+03	\N	2	\N	1	0
342	15	94	6000	2022-11-19 13:40:00+03	\N	1	\N	3	0
343	15	18	6000	2022-12-20 11:38:00+03	\N	3	\N	2	0
344	15	37	6000	2023-01-27 09:18:00+03	\N	3	\N	2	0
345	15	5	6000	2023-03-14 19:30:00+03	\N	1	\N	1	0
346	15	95	6000	2023-05-24 16:15:00+03	\N	3	\N	3	0
347	15	36	6000	2023-07-02 09:23:00+03	\N	1	\N	1	0
348	15	93	6000	2023-08-23 13:16:00+03	\N	3	\N	2	0
349	15	47	6000	2023-10-19 21:28:00+03	\N	3	\N	2	0
350	15	28	6000	2023-12-05 14:59:00+03	\N	1	\N	3	0
351	15	10	6000	2023-12-15 21:14:00+03	\N	2	\N	3	0
352	15	87	6000	2024-02-17 19:52:00+03	\N	2	\N	2	0
353	15	35	6000	2024-04-09 11:14:00+03	\N	1	\N	3	0
354	15	70	6000	2024-05-26 19:37:00+03	\N	2	\N	1	3
355	15	71	6000	2024-08-04 10:44:00+03	\N	1	\N	1	0
356	15	7	6000	2024-09-03 10:36:00+03	\N	3	\N	1	0
357	15	63	6000	2024-10-29 12:03:00+03	\N	2	\N	3	0
358	15	93	6000	2024-11-06 17:40:00+03	\N	2	\N	2	0
359	15	51	6000	2025-01-01 10:08:00+03	\N	2	\N	3	0
360	15	56	6000	2025-01-24 17:29:00+03	\N	1	\N	3	0
361	15	86	6000	2025-02-08 19:46:00+03	\N	1	\N	3	0
362	16	35	12600	2020-07-11 14:11:00+03	\N	2	\N	2	0
363	16	7	12600	2020-09-30 11:13:00+03	\N	1	\N	1	0
364	16	71	12600	2020-11-08 14:21:00+03	\N	3	\N	2	0
365	16	30	12600	2020-12-02 15:26:00+03	\N	3	\N	1	0
366	16	15	12600	2020-12-29 10:57:00+03	\N	1	\N	3	0
367	16	59	12600	2021-01-22 09:20:00+03	\N	1	\N	2	0
368	16	72	12600	2021-05-07 14:51:00+03	\N	1	\N	2	0
369	16	94	12600	2021-05-28 21:27:00+03	\N	3	\N	2	0
370	16	36	12600	2021-07-20 19:05:00+03	\N	1	\N	3	0
371	16	85	12600	2021-08-09 15:39:00+03	\N	3	\N	2	0
372	16	32	12600	2021-09-27 10:06:00+03	\N	1	\N	3	0
373	16	100	12600	2021-11-29 18:09:00+03	\N	2	\N	1	0
374	16	37	12600	2022-01-18 17:00:00+03	\N	1	\N	1	0
375	16	81	12600	2022-02-08 17:07:00+03	\N	1	\N	3	0
376	16	24	12600	2022-03-18 20:24:00+03	\N	2	\N	2	0
377	16	54	12600	2022-04-18 10:09:00+03	\N	1	\N	3	0
378	16	28	12600	2022-06-05 11:14:00+03	\N	3	\N	1	0
379	16	32	12600	2022-06-17 12:32:00+03	\N	1	\N	2	18
380	16	95	12600	2022-08-14 21:54:00+03	\N	1	\N	1	0
381	16	33	12600	2022-09-13 17:20:00+03	\N	1	\N	2	0
382	16	10	12600	2022-09-29 11:09:00+03	\N	3	\N	1	14
383	16	71	12600	2022-11-13 09:09:00+03	\N	3	\N	1	0
384	16	42	12600	2023-01-07 12:44:00+03	\N	3	\N	2	0
385	16	4	12600	2023-03-16 14:31:00+03	\N	2	\N	2	0
386	16	81	12600	2023-05-27 20:25:00+03	\N	1	\N	2	0
387	16	29	12600	2023-06-30 16:06:00+03	\N	1	\N	1	0
388	16	61	12600	2023-07-07 20:59:00+03	\N	3	\N	1	0
389	16	69	12600	2023-08-10 20:03:00+03	\N	1	\N	3	0
390	16	8	12600	2023-09-24 14:23:00+03	\N	3	\N	2	0
391	16	89	12600	2023-11-11 14:54:00+03	\N	2	\N	2	0
392	16	35	12600	2024-01-23 12:58:00+03	\N	2	\N	1	0
393	16	5	12600	2024-03-11 13:41:00+03	\N	2	\N	3	0
394	16	19	12600	2024-03-25 11:51:00+03	\N	1	\N	2	0
395	16	89	12600	2024-05-11 12:38:00+03	\N	1	\N	3	0
396	16	61	12600	2024-07-19 10:15:00+03	\N	1	\N	2	0
397	16	11	12600	2024-09-14 17:05:00+03	\N	3	\N	3	0
398	16	4	12600	2024-09-29 09:15:00+03	\N	1	\N	2	18
399	16	80	12600	2024-11-25 18:23:00+03	\N	1	\N	2	0
400	16	50	12600	2025-01-10 12:03:00+03	\N	2	\N	2	0
401	16	76	12600	2025-02-18 15:53:00+03	\N	2	\N	3	0
\.


--
-- TOC entry 4913 (class 0 OID 16664)
-- Dependencies: 229
-- Data for Name: contract_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract_history (id, contract_id, emp_id, date_end) FROM stdin;
1	1	3	12:25:00+03
2	2	2	15:22:00+03
3	2	3	19:08:00+03
4	2	2	11:57:00+03
5	2	3	12:10:00+03
6	3	3	19:50:00+03
7	4	1	14:25:00+03
8	5	1	17:18:00+03
9	6	3	19:57:00+03
10	7	2	11:49:00+03
11	8	1	15:52:00+03
12	8	2	19:56:00+03
13	9	1	17:45:00+03
14	10	3	19:27:00+03
15	11	1	15:54:00+03
16	11	2	18:36:00+03
17	11	2	10:29:00+03
18	11	2	09:26:00+03
19	12	1	21:33:00+03
20	13	1	15:33:00+03
21	13	3	17:21:00+03
22	14	1	21:16:00+03
23	14	3	12:16:00+03
24	14	1	19:28:00+03
25	14	2	16:40:00+03
26	15	2	15:17:00+03
27	15	1	10:20:00+03
28	15	3	12:26:00+03
29	15	2	13:26:00+03
30	16	1	14:17:00+03
31	16	1	20:13:00+03
32	16	2	18:46:00+03
33	16	1	18:26:00+03
34	17	2	18:50:00+03
35	18	2	17:39:00+03
36	18	1	19:20:00+03
37	19	3	17:25:00+03
38	20	3	18:41:00+03
39	20	2	14:08:00+03
40	21	1	12:27:00+03
41	22	1	16:32:00+03
42	22	1	19:08:00+03
43	23	3	15:00:00+03
44	23	3	17:48:00+03
45	24	2	13:54:00+03
46	25	1	10:12:00+03
47	26	3	11:21:00+03
48	26	1	10:50:00+03
49	26	1	15:12:00+03
50	26	3	18:09:00+03
51	27	3	17:02:00+03
52	28	2	21:58:00+03
53	29	3	19:43:00+03
54	29	1	18:53:00+03
55	29	1	19:07:00+03
56	29	2	16:29:00+03
57	30	2	21:16:00+03
58	31	1	21:11:00+03
59	32	2	15:05:00+03
60	33	3	11:34:00+03
61	34	2	12:15:00+03
62	35	1	18:47:00+03
63	36	3	09:56:00+03
64	37	2	13:43:00+03
65	38	1	16:48:00+03
66	38	2	18:39:00+03
67	39	1	12:54:00+03
68	40	2	09:37:00+03
69	41	3	19:14:00+03
70	42	3	16:57:00+03
71	43	1	20:21:00+03
72	44	2	09:44:00+03
73	45	2	20:32:00+03
74	46	3	12:00:00+03
75	47	2	21:05:00+03
76	48	1	21:36:00+03
77	48	3	18:35:00+03
78	48	3	13:17:00+03
79	48	2	15:51:00+03
80	49	1	15:34:00+03
81	49	1	09:10:00+03
82	50	3	18:39:00+03
83	50	1	21:08:00+03
84	51	2	17:02:00+03
85	52	2	10:34:00+03
86	53	1	11:26:00+03
87	53	2	19:05:00+03
88	54	1	11:21:00+03
89	55	1	11:19:00+03
90	55	2	15:48:00+03
91	56	2	14:49:00+03
92	56	1	15:38:00+03
93	56	1	18:39:00+03
94	57	3	11:30:00+03
95	57	1	20:13:00+03
96	58	2	21:28:00+03
97	58	3	20:52:00+03
98	58	1	15:57:00+03
99	58	2	16:04:00+03
100	59	1	13:17:00+03
101	59	1	15:14:00+03
102	59	3	11:23:00+03
103	60	2	20:24:00+03
104	60	1	17:13:00+03
105	61	3	09:53:00+03
106	62	3	18:03:00+03
107	62	1	20:52:00+03
108	62	2	10:02:00+03
109	62	2	13:34:00+03
110	63	1	16:31:00+03
111	64	3	13:33:00+03
112	65	1	20:42:00+03
113	65	2	16:06:00+03
114	65	2	11:45:00+03
115	65	1	19:26:00+03
116	66	2	14:14:00+03
117	67	2	09:31:00+03
118	68	2	17:32:00+03
119	68	2	14:52:00+03
120	68	2	10:55:00+03
121	68	1	14:10:00+03
122	69	1	13:22:00+03
123	70	3	14:24:00+03
124	71	2	15:52:00+03
125	72	3	10:43:00+03
126	73	3	18:24:00+03
127	74	3	18:53:00+03
128	74	1	09:15:00+03
129	75	2	20:46:00+03
130	76	2	14:42:00+03
131	77	2	15:43:00+03
132	78	2	12:16:00+03
133	79	1	17:33:00+03
134	79	1	19:55:00+03
135	79	3	17:58:00+03
136	79	3	12:26:00+03
137	80	3	14:38:00+03
138	81	3	16:00:00+03
139	81	1	09:12:00+03
140	81	2	09:39:00+03
141	81	3	18:02:00+03
142	82	1	11:46:00+03
143	82	2	16:36:00+03
144	83	2	21:24:00+03
145	84	2	21:10:00+03
146	85	2	14:08:00+03
147	85	1	16:08:00+03
148	85	2	17:03:00+03
149	85	1	11:11:00+03
150	86	3	16:09:00+03
151	87	3	16:00:00+03
152	88	2	18:48:00+03
153	89	2	13:23:00+03
154	89	3	13:14:00+03
155	89	1	10:17:00+03
156	89	3	20:05:00+03
157	90	1	18:50:00+03
158	91	1	09:41:00+03
159	92	2	12:15:00+03
160	92	3	21:25:00+03
161	92	3	20:54:00+03
162	93	2	19:07:00+03
163	94	3	17:15:00+03
164	94	2	19:47:00+03
165	94	3	17:59:00+03
166	94	3	19:11:00+03
167	95	2	19:14:00+03
168	95	3	09:52:00+03
169	96	3	14:20:00+03
170	96	2	13:06:00+03
171	97	1	10:23:00+03
172	97	3	16:34:00+03
173	98	1	21:25:00+03
174	98	3	10:55:00+03
175	99	2	15:06:00+03
176	99	3	20:16:00+03
177	99	2	11:13:00+03
178	100	1	10:58:00+03
179	100	3	15:07:00+03
180	100	3	11:43:00+03
181	100	2	18:14:00+03
182	101	3	15:30:00+03
183	102	1	17:37:00+03
184	103	3	17:22:00+03
185	104	1	20:46:00+03
186	105	1	17:16:00+03
187	105	1	11:39:00+03
188	106	3	14:32:00+03
189	106	3	18:37:00+03
190	106	1	12:47:00+03
191	107	2	18:03:00+03
192	107	3	09:41:00+03
193	107	2	11:41:00+03
194	107	1	10:50:00+03
195	108	3	11:23:00+03
196	109	2	11:01:00+03
197	109	1	19:32:00+03
198	109	2	11:07:00+03
199	109	1	11:53:00+03
200	110	3	16:04:00+03
201	110	3	12:21:00+03
202	111	1	15:18:00+03
203	112	3	18:10:00+03
204	113	2	14:54:00+03
205	114	2	12:20:00+03
206	115	2	13:35:00+03
207	116	3	17:44:00+03
208	116	1	13:21:00+03
209	116	3	21:03:00+03
210	116	2	10:41:00+03
211	117	2	15:08:00+03
212	118	1	10:41:00+03
213	119	3	09:13:00+03
214	119	1	13:25:00+03
215	120	2	10:25:00+03
216	121	2	21:26:00+03
217	121	1	19:00:00+03
218	121	3	13:00:00+03
219	122	1	11:03:00+03
220	123	1	19:08:00+03
221	123	1	15:44:00+03
222	123	3	18:04:00+03
223	123	3	11:15:00+03
224	124	2	19:04:00+03
225	125	2	13:51:00+03
226	126	3	21:54:00+03
227	127	2	17:18:00+03
228	127	2	16:39:00+03
229	127	1	11:16:00+03
230	128	3	10:42:00+03
231	129	2	19:33:00+03
232	129	3	17:19:00+03
233	129	1	10:51:00+03
234	130	3	15:13:00+03
235	130	3	19:01:00+03
236	130	3	20:12:00+03
237	130	1	15:45:00+03
238	131	2	17:35:00+03
239	132	3	17:08:00+03
240	133	2	15:29:00+03
241	133	2	19:38:00+03
242	133	3	18:05:00+03
243	134	1	12:42:00+03
244	135	1	11:03:00+03
245	136	2	17:23:00+03
246	136	3	18:20:00+03
247	137	2	12:24:00+03
248	137	1	14:46:00+03
249	138	3	15:29:00+03
250	138	1	13:38:00+03
251	139	2	14:36:00+03
252	140	2	21:14:00+03
253	140	1	12:20:00+03
254	141	1	11:56:00+03
255	141	3	11:09:00+03
256	142	3	11:07:00+03
257	143	2	17:15:00+03
258	143	1	12:28:00+03
259	144	3	21:32:00+03
260	145	2	13:23:00+03
261	146	2	18:52:00+03
262	146	2	10:49:00+03
263	147	2	19:39:00+03
264	148	1	18:05:00+03
265	149	2	13:23:00+03
266	150	3	14:29:00+03
267	151	3	21:11:00+03
268	151	2	10:05:00+03
269	152	1	19:40:00+03
270	153	1	12:42:00+03
271	154	2	19:06:00+03
272	155	2	17:34:00+03
273	155	1	15:02:00+03
274	156	2	21:22:00+03
275	156	3	13:35:00+03
276	157	3	12:14:00+03
277	158	3	17:56:00+03
278	158	3	16:32:00+03
279	158	2	21:24:00+03
280	159	2	10:22:00+03
281	160	2	20:16:00+03
282	160	2	14:17:00+03
283	160	1	10:58:00+03
284	160	3	17:29:00+03
285	161	1	15:40:00+03
286	162	3	16:30:00+03
287	163	3	17:44:00+03
288	163	2	17:31:00+03
289	163	1	11:46:00+03
290	163	2	13:33:00+03
291	164	1	13:10:00+03
292	164	3	13:18:00+03
293	164	2	19:40:00+03
294	164	2	11:33:00+03
295	165	2	09:50:00+03
296	165	2	18:15:00+03
297	165	3	16:35:00+03
298	166	2	18:50:00+03
299	167	3	14:03:00+03
300	167	2	11:38:00+03
301	167	2	10:46:00+03
302	168	3	19:05:00+03
303	168	3	17:30:00+03
304	169	2	14:13:00+03
305	170	1	19:52:00+03
306	170	1	10:52:00+03
307	171	2	14:49:00+03
308	171	3	15:32:00+03
309	172	2	16:31:00+03
310	173	1	16:38:00+03
311	174	1	16:32:00+03
312	174	2	18:32:00+03
313	174	3	09:59:00+03
314	175	2	19:01:00+03
315	176	2	17:05:00+03
316	176	1	17:06:00+03
317	176	1	16:53:00+03
318	176	3	14:35:00+03
319	177	1	12:13:00+03
320	178	2	20:38:00+03
321	179	2	21:58:00+03
322	179	1	18:07:00+03
323	180	1	19:46:00+03
324	181	1	21:59:00+03
325	181	2	15:01:00+03
326	181	2	21:11:00+03
327	181	2	12:55:00+03
328	182	3	19:42:00+03
329	183	2	11:04:00+03
330	184	2	18:52:00+03
331	185	3	12:49:00+03
332	185	2	16:42:00+03
333	185	3	09:17:00+03
334	185	3	20:44:00+03
335	186	2	13:22:00+03
336	186	1	09:09:00+03
337	186	1	10:54:00+03
338	186	1	12:20:00+03
339	187	1	19:05:00+03
340	187	3	21:01:00+03
341	187	3	09:51:00+03
342	188	1	18:13:00+03
343	188	3	20:27:00+03
344	189	3	19:08:00+03
345	189	1	19:33:00+03
346	189	2	11:53:00+03
347	190	1	20:11:00+03
348	190	3	16:59:00+03
349	190	1	15:08:00+03
350	190	3	09:04:00+03
351	191	2	09:38:00+03
352	191	3	18:19:00+03
353	192	3	14:03:00+03
354	193	2	11:59:00+03
355	194	3	12:25:00+03
356	195	2	17:43:00+03
357	195	2	09:41:00+03
358	196	2	12:00:00+03
359	197	3	13:43:00+03
360	198	3	10:54:00+03
361	198	1	11:50:00+03
362	198	2	12:17:00+03
363	198	1	09:12:00+03
364	199	1	19:28:00+03
365	200	2	15:20:00+03
366	201	3	15:33:00+03
367	202	1	18:29:00+03
368	202	1	15:35:00+03
369	202	3	18:56:00+03
370	203	1	17:51:00+03
371	203	3	14:06:00+03
372	203	2	09:05:00+03
373	203	2	16:15:00+03
374	204	3	16:49:00+03
375	204	1	15:02:00+03
376	204	2	17:53:00+03
377	204	1	16:23:00+03
378	205	2	12:52:00+03
379	206	2	12:00:00+03
380	207	1	12:44:00+03
381	208	2	19:33:00+03
382	209	3	10:18:00+03
383	210	1	20:31:00+03
384	210	1	13:26:00+03
385	210	3	10:32:00+03
386	210	1	12:29:00+03
387	211	1	12:47:00+03
388	211	3	15:41:00+03
389	211	3	12:46:00+03
390	212	1	13:12:00+03
391	212	3	09:38:00+03
392	213	2	21:00:00+03
393	213	3	09:23:00+03
394	213	3	15:58:00+03
395	213	2	21:06:00+03
396	214	1	13:59:00+03
397	214	1	21:08:00+03
398	214	1	20:47:00+03
399	215	1	14:08:00+03
400	215	1	15:55:00+03
401	216	1	10:02:00+03
402	217	1	21:57:00+03
403	218	2	13:35:00+03
404	218	3	21:01:00+03
405	219	3	14:21:00+03
406	219	3	14:18:00+03
407	220	3	11:37:00+03
408	221	1	13:03:00+03
409	222	3	13:58:00+03
410	222	3	09:09:00+03
411	222	1	16:57:00+03
412	222	3	12:31:00+03
413	223	1	17:27:00+03
414	223	3	15:21:00+03
415	224	1	11:48:00+03
416	225	3	21:06:00+03
417	226	1	13:15:00+03
418	226	2	13:17:00+03
419	227	3	11:00:00+03
420	228	1	13:50:00+03
421	229	3	12:47:00+03
422	230	2	19:47:00+03
423	231	1	16:43:00+03
424	232	3	14:24:00+03
425	233	2	13:59:00+03
426	233	1	13:59:00+03
427	233	1	18:15:00+03
428	234	3	09:01:00+03
429	235	1	14:03:00+03
430	236	3	09:51:00+03
431	236	3	19:04:00+03
432	237	2	09:55:00+03
433	238	2	15:07:00+03
434	239	3	16:07:00+03
435	240	2	14:56:00+03
436	241	2	09:18:00+03
437	241	1	19:14:00+03
438	241	1	18:36:00+03
439	242	1	20:22:00+03
440	242	2	20:42:00+03
441	243	2	15:07:00+03
442	244	2	19:47:00+03
443	245	2	12:05:00+03
444	246	2	20:10:00+03
445	247	1	10:18:00+03
446	247	2	11:39:00+03
447	248	3	20:44:00+03
448	248	3	10:27:00+03
449	248	3	11:23:00+03
450	249	3	09:34:00+03
451	249	1	16:18:00+03
452	249	3	13:54:00+03
453	249	2	12:00:00+03
454	250	1	14:32:00+03
455	251	1	14:17:00+03
456	252	3	11:23:00+03
457	252	3	16:10:00+03
458	253	3	19:31:00+03
459	253	2	14:34:00+03
460	254	2	09:09:00+03
461	254	3	11:50:00+03
462	255	2	19:19:00+03
463	256	2	14:22:00+03
464	256	1	16:46:00+03
465	256	2	11:40:00+03
466	257	2	21:32:00+03
467	257	1	17:00:00+03
468	257	3	10:06:00+03
469	258	3	19:13:00+03
470	259	2	15:29:00+03
471	260	1	09:47:00+03
472	260	3	15:32:00+03
473	260	2	15:26:00+03
474	260	3	18:55:00+03
475	261	2	12:46:00+03
476	262	1	20:29:00+03
477	262	1	21:22:00+03
478	262	3	11:11:00+03
479	262	3	09:13:00+03
480	263	2	15:34:00+03
481	264	3	13:54:00+03
482	264	3	17:42:00+03
483	264	1	13:37:00+03
484	264	2	09:30:00+03
485	265	1	14:41:00+03
486	266	1	10:45:00+03
487	267	3	17:29:00+03
488	268	2	21:20:00+03
489	268	3	21:50:00+03
490	269	3	14:53:00+03
491	269	3	21:23:00+03
492	269	2	18:01:00+03
493	269	2	20:33:00+03
494	270	1	12:42:00+03
495	271	2	18:27:00+03
496	272	2	15:57:00+03
497	272	1	21:41:00+03
498	272	1	18:59:00+03
499	272	2	20:09:00+03
500	273	3	20:37:00+03
501	273	1	12:09:00+03
502	273	1	18:39:00+03
503	273	2	10:06:00+03
504	274	3	18:20:00+03
505	275	3	10:03:00+03
506	276	2	12:45:00+03
507	276	1	13:19:00+03
508	277	2	10:47:00+03
509	278	3	15:46:00+03
510	279	3	14:20:00+03
511	279	2	14:05:00+03
512	279	3	19:46:00+03
513	280	2	20:29:00+03
514	281	2	10:48:00+03
515	282	3	20:33:00+03
516	283	3	18:11:00+03
517	283	2	12:12:00+03
518	284	3	13:46:00+03
519	284	1	19:31:00+03
520	284	1	14:35:00+03
521	284	2	09:27:00+03
522	285	3	19:12:00+03
523	286	1	10:58:00+03
524	286	1	13:20:00+03
525	287	1	15:23:00+03
526	288	2	17:18:00+03
527	289	3	20:11:00+03
528	290	3	14:31:00+03
529	290	2	12:21:00+03
530	291	3	20:13:00+03
531	291	1	18:11:00+03
532	291	2	16:09:00+03
533	291	1	21:48:00+03
534	292	3	15:12:00+03
535	293	3	09:48:00+03
536	294	1	11:21:00+03
537	295	3	16:35:00+03
538	296	3	14:18:00+03
539	297	2	17:18:00+03
540	297	3	09:21:00+03
541	298	2	21:32:00+03
542	298	3	14:44:00+03
543	299	2	15:33:00+03
544	300	2	13:35:00+03
545	301	3	18:25:00+03
546	302	3	09:30:00+03
547	302	1	12:34:00+03
548	303	3	17:04:00+03
549	304	3	19:11:00+03
550	304	2	17:41:00+03
551	305	3	11:44:00+03
552	306	3	18:19:00+03
553	307	2	13:41:00+03
554	308	1	11:52:00+03
555	308	3	14:52:00+03
556	309	3	09:56:00+03
557	309	3	10:59:00+03
558	310	3	19:25:00+03
559	311	3	12:27:00+03
560	312	1	11:32:00+03
561	313	1	20:37:00+03
562	314	3	13:36:00+03
563	315	3	21:37:00+03
564	316	2	21:03:00+03
565	317	1	09:55:00+03
566	318	2	14:35:00+03
567	319	3	19:32:00+03
568	319	3	21:49:00+03
569	319	2	18:21:00+03
570	320	1	16:12:00+03
571	320	1	15:28:00+03
572	320	2	09:33:00+03
573	321	2	18:28:00+03
574	321	3	19:59:00+03
575	322	2	16:22:00+03
576	322	1	09:57:00+03
577	323	1	11:07:00+03
578	324	3	19:17:00+03
579	325	2	11:49:00+03
580	326	1	13:22:00+03
581	327	2	11:09:00+03
582	328	1	12:37:00+03
583	328	1	09:29:00+03
584	329	1	19:30:00+03
585	329	3	15:47:00+03
586	329	3	12:39:00+03
587	329	3	13:39:00+03
588	330	2	21:37:00+03
589	331	1	21:13:00+03
590	331	1	13:14:00+03
591	331	1	19:45:00+03
592	331	3	16:40:00+03
593	332	1	09:25:00+03
594	332	1	19:18:00+03
595	332	1	18:39:00+03
596	333	2	19:05:00+03
597	333	3	17:01:00+03
598	333	1	14:10:00+03
599	334	2	14:23:00+03
600	334	2	17:31:00+03
601	334	3	13:45:00+03
602	335	2	12:50:00+03
603	336	3	13:01:00+03
604	336	2	19:04:00+03
605	337	3	15:08:00+03
606	337	3	12:02:00+03
607	337	1	09:09:00+03
608	337	2	21:31:00+03
609	338	1	19:25:00+03
610	339	3	14:02:00+03
611	339	1	14:03:00+03
612	339	3	12:49:00+03
613	339	2	19:34:00+03
614	340	2	18:51:00+03
615	340	1	12:13:00+03
616	341	1	11:01:00+03
617	342	3	11:38:00+03
618	343	3	09:18:00+03
619	344	1	19:30:00+03
620	345	2	11:17:00+03
621	345	2	14:39:00+03
622	345	3	16:15:00+03
623	346	2	09:23:00+03
624	347	3	13:16:00+03
625	347	2	13:16:00+03
626	348	2	15:06:00+03
627	348	1	21:28:00+03
628	349	1	19:08:00+03
629	349	3	16:37:00+03
630	349	3	14:59:00+03
631	350	3	21:14:00+03
632	351	1	12:10:00+03
633	351	2	10:29:00+03
634	351	2	19:52:00+03
635	352	1	11:14:00+03
636	353	3	19:37:00+03
637	354	2	13:13:00+03
638	354	3	13:40:00+03
639	354	3	19:03:00+03
640	354	2	10:44:00+03
641	355	2	10:36:00+03
642	356	1	12:03:00+03
643	357	2	17:40:00+03
644	358	3	10:08:00+03
645	359	3	17:29:00+03
646	360	2	19:46:00+03
647	361	3	18:58:00+03
648	362	2	20:57:00+03
649	362	1	17:29:00+03
650	362	1	09:27:00+03
651	362	3	11:13:00+03
652	363	2	11:23:00+03
653	363	2	14:21:00+03
654	364	3	11:25:00+03
655	364	3	15:26:00+03
656	365	3	10:57:00+03
657	366	1	09:20:00+03
658	367	1	09:01:00+03
659	367	2	12:05:00+03
660	367	3	15:54:00+03
661	367	3	14:51:00+03
662	368	3	21:27:00+03
663	369	3	14:45:00+03
664	369	2	19:05:00+03
665	370	3	15:39:00+03
666	371	1	14:48:00+03
667	371	3	10:06:00+03
668	372	2	12:29:00+03
669	372	2	18:09:00+03
670	373	1	11:05:00+03
671	373	1	17:00:00+03
672	374	2	17:07:00+03
673	375	3	17:42:00+03
674	375	2	20:24:00+03
675	376	1	10:09:00+03
676	377	1	11:14:00+03
677	378	3	12:32:00+03
678	379	1	21:54:00+03
679	380	3	17:20:00+03
680	381	1	11:09:00+03
681	382	2	16:19:00+03
682	382	3	09:09:00+03
683	383	1	15:25:00+03
684	383	1	12:44:00+03
685	384	2	21:22:00+03
686	384	1	09:03:00+03
687	384	3	10:06:00+03
688	384	2	14:31:00+03
689	385	1	18:19:00+03
690	385	2	20:25:00+03
691	386	3	11:26:00+03
692	386	1	16:47:00+03
693	386	3	21:14:00+03
694	386	3	16:06:00+03
695	387	1	20:59:00+03
696	388	1	20:03:00+03
697	389	1	14:23:00+03
698	390	3	14:54:00+03
699	391	1	16:55:00+03
700	391	2	12:58:00+03
701	392	2	20:00:00+03
702	392	1	13:41:00+03
703	393	3	11:51:00+03
704	394	3	12:38:00+03
705	395	2	10:14:00+03
706	395	3	14:42:00+03
707	395	1	10:15:00+03
708	396	2	19:57:00+03
709	396	2	14:45:00+03
710	396	3	18:27:00+03
711	396	1	17:05:00+03
712	397	1	09:15:00+03
713	398	3	18:23:00+03
714	399	3	12:03:00+03
715	400	3	15:53:00+03
716	401	2	12:37:00+03
\.


--
-- TOC entry 4901 (class 0 OID 16445)
-- Dependencies: 217
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (id, full_name, phone_number, email) FROM stdin;
1	Иванов Алексей	+79215612943	alex22@mail.ru
2	Петрова Мария	+79317844155	mary.pet@gmail.com
3	Сидоров Дмитрий	+79216548111	dim.sidor@gmail.com
\.


--
-- TOC entry 4907 (class 0 OID 16547)
-- Dependencies: 223
-- Data for Name: engine; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.engine (id, capacity, power, fuel_type) FROM stdin;
1	2.5	249	АИ-95
2	3.5	301	АИ-98
3	2	178	АИ-95
4	1.5	174	АИ-95
5	1.8	125	АИ-95
6	1.5	158	АИ-95
7	3	340	АИ-98
8	2	249	ДТ
9	4.4	450	АИ-98
10	2	245	ДТ
11	2.2	184	ДТ
12	3	367	АИ-98
13	2	190	АИ-95
14	1.8	150	АИ-95
15	2	249	АИ-95
16	1.4	150	АИ-95
17	1.6	115	АИ-95
18	1.8	180	АИ-95
19	5	400	АИ-98
20	3.5	325	АИ-98
21	3.5	450	АИ-98
22	6.2	455	АИ-98
23	2	275	АИ-95
24	6.2	650	АИ-98
25	2	177	АИ-95
26	1.6	150	АИ-95
27	2	185	АИ-95
28	1.6	123	АИ-95
29	1.4	100	АИ-95
30	1.2	90	АИ-95
\.


--
-- TOC entry 4911 (class 0 OID 16603)
-- Dependencies: 227
-- Data for Name: fine; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fine (id, instance_id, info, cost, date, client_pays) FROM stdin;
2	13	12.16	1500	2018-01-21 05:58:57+03	t
4	6	12.6	1500	2017-05-21 18:46:25+03	t
5	10	12.16	1500	2021-06-28 13:17:21+03	t
6	2	12.6	500	2020-12-13 06:40:40+03	t
7	4	12.9	500	2020-07-28 14:10:34+03	t
9	12	12.16	1500	2024-04-11 13:37:42+03	t
10	6	12.19	3000	2020-10-01 17:50:28+03	t
11	8	12.19	3000	2020-03-08 11:13:02+03	t
12	10	12.6	1500	2018-08-28 03:13:04+03	t
13	15	12.9	500	2022-08-04 04:20:43+03	t
14	5	12.9	500	2022-11-17 11:31:26+03	t
15	12	12.16	1500	2023-11-29 17:06:14+03	t
16	9	12.19	3000	2023-11-20 20:31:08+03	t
18	1	12.19	3000	2024-01-18 03:21:19+03	t
19	6	12.9	500	2018-08-12 18:41:38+03	t
20	12	12.6	500	2020-10-29 23:13:30+03	t
22	13	12.16	1500	2023-12-29 20:21:56+03	t
23	15	12.19	3000	2022-07-25 03:11:41+03	t
24	7	12.9	500	2023-01-26 03:56:31+03	t
25	13	12.9	500	2024-01-18 06:26:58+03	t
26	9	12.9	500	2022-10-27 00:19:37+03	t
27	6	12.16	1500	2024-03-12 18:29:19+03	t
30	11	12.16	1500	2022-08-29 10:21:21+03	t
32	1	12.19	3000	2018-11-23 05:58:12+03	t
33	10	12.9	500	2021-05-20 15:53:05+03	t
35	8	12.19	3000	2020-09-05 14:32:32+03	t
36	13	12.9	500	2018-08-18 02:21:40+03	t
37	10	12.9	500	2019-06-29 17:26:58+03	t
38	16	12.6	500	2023-03-25 09:32:29+03	t
39	4	12.19	3000	2019-07-08 21:55:09+03	t
40	6	12.16	1500	2019-10-23 10:34:49+03	t
42	3	12.19	3000	2019-01-20 00:31:33+03	t
43	15	12.19	3000	2024-09-20 11:39:15+03	t
45	6	12.19	3000	2024-11-24 13:06:27+03	t
46	14	12.16	1500	2023-01-13 22:42:56+03	t
47	1	12.6	500	2018-03-17 16:42:11+03	t
48	15	12.6	500	2024-11-15 17:45:59+03	t
49	6	12.16	1500	2019-12-06 18:12:54+03	t
50	2	12.6	1500	2022-02-12 12:16:39+03	t
51	10	12.9	500	2024-06-09 21:23:14+03	t
52	1	12.19	3000	2022-08-18 04:10:32+03	t
53	15	12.9	500	2023-05-19 19:30:38+03	t
54	6	12.9	500	2016-06-27 20:50:07+03	t
55	1	12.16	1500	2017-02-01 13:24:29+03	t
56	3	12.9	500	2018-09-24 02:12:44+03	t
57	4	12.6	500	2022-01-02 08:57:06+03	t
58	1	12.9	500	2019-03-11 00:50:21+03	t
59	9	12.16	1500	2020-08-07 06:01:24+03	t
60	9	12.19	3000	2018-07-24 21:31:17+03	t
61	14	12.9	500	2022-06-12 17:31:31+03	t
62	15	12.9	500	2023-12-14 23:07:57+03	t
64	2	12.19	3000	2021-08-06 09:50:03+03	t
65	1	12.9	500	2022-09-24 17:44:18+03	t
66	9	12.19	3000	2021-06-22 09:12:19+03	t
67	1	12.9	500	2020-06-05 05:16:52+03	t
68	13	12.19	3000	2023-03-15 16:41:00+03	t
69	4	12.6	1500	2021-07-15 22:31:30+03	t
70	12	12.19	3000	2017-11-21 08:13:34+03	t
71	10	12.6	1500	2022-03-19 16:21:59+03	t
73	7	12.9	500	2022-07-22 15:56:44+03	t
74	14	12.6	500	2023-07-30 09:51:45+03	t
75	12	12.9	500	2020-09-15 06:21:01+03	t
76	8	12.9	500	2025-01-21 04:48:38+03	t
77	12	12.9	500	2023-12-05 06:03:29+03	t
78	2	12.16	1500	2019-09-16 05:29:23+03	t
80	12	12.6	1500	2021-04-13 17:33:21+03	t
81	13	12.16	1500	2018-11-12 03:06:41+03	t
83	13	12.9	500	2023-06-16 01:24:55+03	t
84	14	12.16	1500	2022-12-27 16:38:19+03	t
85	7	12.6	500	2023-01-31 13:30:27+03	t
87	15	12.19	3000	2020-05-07 16:45:14+03	t
88	8	12.9	500	2021-08-27 03:33:08+03	t
90	3	12.16	1500	2024-01-17 18:31:31+03	t
92	14	12.6	500	2022-07-20 01:27:29+03	t
93	13	12.19	3000	2016-03-28 06:50:32+03	t
94	5	12.19	3000	2021-02-25 18:57:55+03	t
95	10	12.9	500	2023-09-25 04:41:39+03	t
97	12	12.16	1500	2023-06-18 23:39:55+03	t
98	10	12.6	1500	2021-06-24 17:49:43+03	t
99	3	12.16	1500	2021-07-29 01:18:00+03	t
101	16	12.9	500	2020-11-15 01:44:16+03	t
102	5	12.9	500	2023-10-15 10:51:04+03	t
103	1	12.6	1500	2020-07-24 21:23:17+03	t
104	3	12.9	500	2022-04-29 15:56:54+03	t
106	12	12.6	500	2024-09-10 22:36:00+03	t
107	13	12.19	3000	2024-08-21 03:24:00+03	t
108	8	12.9	500	2024-02-20 02:04:48+03	t
109	10	12.6	500	2018-04-07 12:44:58+03	t
110	10	12.19	3000	2024-09-21 13:20:13+03	t
112	15	12.16	1500	2019-09-07 22:32:36+03	t
113	3	12.6	1500	2023-06-16 04:17:12+03	t
114	11	12.9	500	2021-04-03 13:16:06+03	t
115	11	12.19	3000	2021-05-26 12:55:17+03	t
116	13	12.9	500	2021-12-27 15:07:10+03	t
117	9	12.19	3000	2018-09-04 00:43:03+03	t
118	14	12.9	500	2024-09-15 21:39:28+03	t
119	7	12.16	1500	2021-01-08 09:20:06+03	t
121	6	12.16	1500	2022-02-17 15:34:35+03	t
122	3	12.19	3000	2017-07-11 21:35:48+03	t
125	14	12.19	3000	2023-02-17 03:08:23+03	t
126	10	12.6	500	2020-02-12 17:29:47+03	t
127	6	12.16	1500	2016-08-26 00:45:20+03	t
128	2	12.6	1500	2019-07-11 01:46:11+03	t
130	3	12.9	500	2023-04-07 06:11:43+03	t
133	4	12.9	500	2023-03-30 09:14:31+03	t
134	11	12.19	3000	2021-08-26 23:35:25+03	t
135	14	12.6	1500	2025-01-06 03:51:25+03	t
136	9	12.9	500	2024-07-09 11:45:47+03	t
137	6	12.9	500	2017-08-14 07:38:34+03	t
138	6	12.6	1500	2017-03-22 09:44:25+03	t
139	5	12.9	500	2022-12-28 01:50:04+03	t
140	11	12.19	3000	2024-07-10 14:19:26+03	t
141	6	12.16	1500	2018-04-18 07:24:02+03	t
142	12	12.9	500	2022-12-09 20:10:26+03	t
143	5	12.6	500	2017-09-17 06:44:05+03	t
144	6	12.6	1500	2024-09-08 03:56:29+03	t
145	9	12.9	500	2024-03-13 03:33:36+03	t
146	9	12.19	3000	2020-03-03 20:27:19+03	t
147	13	12.16	1500	2021-11-27 16:16:01+03	t
148	15	12.19	3000	2022-05-03 11:50:57+03	t
149	10	12.19	3000	2024-06-22 11:20:05+03	t
150	13	12.16	1500	2018-10-11 11:58:26+03	t
152	3	12.6	500	2023-12-26 23:27:51+03	t
153	14	12.9	500	2022-10-12 17:10:39+03	t
154	11	12.19	3000	2021-01-08 22:15:35+03	t
155	9	12.6	1500	2019-07-30 01:21:37+03	t
156	13	12.9	500	2024-03-26 00:58:54+03	t
157	7	12.16	1500	2019-12-15 19:08:53+03	t
158	6	12.16	1500	2021-07-28 11:07:57+03	t
159	10	12.16	1500	2020-10-21 22:47:06+03	t
160	10	12.9	500	2021-01-15 09:21:29+03	t
162	3	12.9	500	2018-10-15 21:16:07+03	t
165	5	12.16	1500	2024-12-17 10:08:53+03	t
166	2	12.19	3000	2020-12-04 09:50:32+03	t
167	10	12.19	3000	2022-12-18 10:15:16+03	t
168	2	12.19	3000	2023-05-31 23:08:03+03	t
169	9	12.19	3000	2024-04-02 05:01:47+03	t
170	7	12.19	3000	2021-09-18 02:41:50+03	t
173	15	12.9	500	2023-04-12 04:51:53+03	t
174	10	12.19	3000	2023-09-10 06:50:41+03	t
175	3	12.19	3000	2019-03-04 19:05:08+03	t
177	10	12.9	500	2018-02-17 16:26:01+03	t
178	6	12.19	3000	2022-04-30 17:19:09+03	t
183	7	12.19	3000	2021-02-02 03:04:11+03	t
184	7	12.6	500	2020-12-10 05:25:56+03	t
187	1	12.6	500	2022-03-30 22:49:02+03	t
188	9	12.16	1500	2020-04-04 15:46:09+03	t
190	16	12.19	3000	2022-11-08 11:36:35+03	t
191	12	12.19	3000	2022-10-12 12:11:19+03	t
194	10	12.19	3000	2018-11-07 22:06:29+03	t
197	6	12.9	500	2023-10-02 21:35:39+03	t
199	16	12.6	1500	2023-10-03 15:18:03+03	t
201	10	12.19	3000	2021-07-17 07:24:29+03	t
202	13	12.6	500	2024-11-08 22:17:10+03	t
203	5	12.19	3000	2019-12-15 19:48:06+03	t
204	4	12.19	3000	2018-07-27 12:48:34+03	t
205	4	12.19	3000	2019-10-01 04:38:35+03	t
206	16	12.9	500	2019-08-31 14:15:37+03	t
207	13	12.19	3000	2022-07-01 00:47:30+03	t
208	2	12.16	1500	2021-02-04 21:31:27+03	t
209	3	12.16	1500	2024-02-16 18:42:11+03	t
210	5	12.9	500	2020-11-26 13:10:27+03	t
211	11	12.9	500	2020-11-30 13:05:57+03	t
212	16	12.19	3000	2023-11-02 22:54:56+03	t
213	8	12.19	3000	2023-10-24 09:19:10+03	t
218	9	12.9	500	2024-06-07 22:49:45+03	t
219	4	12.9	500	2019-09-06 22:16:12+03	t
220	12	12.19	3000	2018-03-04 19:29:34+03	t
221	6	12.9	500	2020-07-11 10:12:30+03	t
222	8	12.6	500	2020-12-10 03:40:16+03	t
223	7	12.19	3000	2024-09-28 22:02:37+03	t
224	9	12.9	500	2022-07-26 14:18:01+03	t
225	5	12.16	1500	2020-10-11 00:20:56+03	t
226	8	12.19	3000	2021-02-22 03:05:55+03	t
227	6	12.19	3000	2020-05-14 19:30:16+03	t
228	7	12.19	3000	2020-08-29 05:03:07+03	t
229	5	12.6	500	2017-09-22 23:54:26+03	t
230	12	12.19	3000	2018-11-26 11:09:17+03	t
231	5	12.9	500	2018-05-06 19:45:48+03	t
233	16	12.16	1500	2023-04-20 03:33:09+03	t
234	3	12.9	500	2022-06-03 01:44:50+03	t
236	6	12.16	1500	2020-12-12 05:22:55+03	t
237	5	12.16	1500	2018-09-02 20:16:40+03	t
238	7	12.19	3000	2023-10-09 01:28:57+03	t
239	2	12.19	3000	2024-09-01 07:57:22+03	t
240	5	12.16	1500	2024-10-13 13:37:27+03	t
242	1	12.9	500	2021-05-04 19:55:47+03	t
243	13	12.19	3000	2024-09-18 20:10:47+03	t
244	13	12.19	3000	2025-01-03 05:56:17+03	t
245	12	12.6	1500	2018-11-26 22:56:12+03	t
246	12	12.16	1500	2023-02-15 10:05:18+03	t
247	3	12.6	1500	2018-06-22 20:39:35+03	t
248	16	12.9	500	2020-12-08 22:13:48+03	t
249	12	12.9	500	2023-11-19 07:21:11+03	t
250	2	12.9	500	2024-10-02 08:59:24+03	t
251	6	12.9	500	2018-06-11 13:56:27+03	t
252	13	12.6	500	2018-04-22 11:07:16+03	t
253	3	12.9	500	2018-08-31 09:35:03+03	t
256	2	12.9	500	2020-01-04 23:05:12+03	t
257	10	12.19	3000	2023-09-11 09:45:13+03	t
258	10	12.9	500	2024-01-27 16:32:49+03	t
259	15	12.9	500	2021-11-12 11:49:22+03	t
261	7	12.19	3000	2021-07-12 19:38:25+03	t
263	13	12.16	1500	2020-06-29 04:38:50+03	t
264	6	12.19	3000	2024-12-18 10:59:31+03	t
265	6	12.9	500	2018-05-13 19:44:10+03	t
266	10	12.9	500	2021-08-23 17:04:48+03	t
267	9	12.9	500	2016-11-13 23:17:46+03	t
268	6	12.16	1500	2022-02-20 13:36:34+03	t
269	12	12.19	3000	2024-01-05 17:22:03+03	t
270	3	12.16	1500	2020-09-17 09:35:52+03	t
271	1	12.9	500	2020-10-11 05:42:37+03	t
272	5	12.16	1500	2020-01-23 16:48:21+03	t
273	11	12.16	1500	2022-07-29 11:05:27+03	t
274	8	12.19	3000	2024-04-05 06:02:53+03	t
275	1	12.6	1500	2021-05-10 03:23:17+03	t
276	7	12.9	500	2020-05-14 23:14:52+03	t
277	2	12.19	3000	2019-07-29 01:21:21+03	t
278	1	12.19	3000	2021-11-11 15:25:05+03	t
279	12	12.6	1500	2024-11-27 13:20:15+03	t
280	3	12.9	500	2024-05-19 22:47:13+03	t
281	13	12.9	500	2022-06-14 14:35:48+03	t
282	7	12.16	1500	2019-11-28 16:40:44+03	t
283	16	12.9	500	2020-11-01 17:35:42+03	t
286	16	12.9	500	2022-01-16 03:14:18+03	t
287	13	12.9	500	2019-01-24 10:30:58+03	t
288	8	12.16	1500	2025-03-02 06:31:51+03	t
289	9	12.6	1500	2018-08-29 14:34:05+03	t
290	15	12.9	500	2024-10-24 00:54:19+03	t
292	16	12.6	1500	2023-10-07 11:32:58+03	t
293	13	12.19	3000	2021-02-27 11:35:30+03	t
294	1	12.9	500	2016-02-17 08:35:41+03	t
295	2	12.19	3000	2021-05-30 09:07:26+03	t
296	2	12.9	500	2020-08-08 06:59:49+03	t
297	8	12.19	3000	2019-12-16 06:51:06+03	t
298	10	12.9	500	2019-03-30 10:00:19+03	t
299	14	12.6	500	2021-09-23 16:05:09+03	t
300	3	12.19	3000	2022-12-01 21:01:45+03	t
304	1	12.19	3000	2017-04-20 01:14:00+03	t
305	16	12.19	3000	2022-05-06 08:38:40+03	t
306	1	12.9	500	2018-12-05 21:27:17+03	t
309	5	12.9	500	2025-03-12 13:10:38+03	t
310	3	12.9	500	2019-03-05 09:38:42+03	t
312	15	12.16	1500	2022-09-05 03:58:42+03	t
313	9	12.6	1500	2021-08-09 22:58:03+03	t
315	12	12.19	3000	2022-05-21 17:58:11+03	t
316	2	12.6	1500	2021-03-30 03:34:36+03	t
317	14	12.9	500	2022-05-12 11:51:07+03	t
318	2	12.19	3000	2020-02-03 23:43:40+03	t
319	10	12.19	3000	2020-10-03 02:48:05+03	t
320	8	12.6	500	2023-11-08 01:44:24+03	t
322	13	12.19	3000	2019-09-13 19:59:19+03	t
323	4	12.9	500	2024-10-03 10:37:50+03	t
324	8	12.9	500	2023-07-06 17:43:23+03	t
325	16	12.19	3000	2021-06-05 06:47:25+03	t
326	4	12.19	3000	2019-07-11 02:16:24+03	t
327	11	12.9	500	2022-01-28 13:44:34+03	t
328	8	12.9	500	2020-02-02 19:05:37+03	t
329	3	12.6	1500	2017-11-24 10:28:57+03	t
330	14	12.6	500	2022-07-15 12:27:19+03	t
331	2	12.6	1500	2020-10-10 05:52:23+03	t
332	5	12.16	1500	2020-01-18 08:20:00+03	t
333	9	12.16	1500	2019-10-08 10:59:51+03	t
334	12	12.9	500	2024-04-21 10:03:44+03	t
336	8	12.19	3000	2021-11-28 07:27:00+03	t
337	15	12.16	1500	2023-11-07 21:47:36+03	t
338	9	12.19	3000	2021-08-07 01:13:10+03	t
339	6	12.16	1500	2019-08-04 01:03:00+03	t
340	2	12.16	1500	2022-04-26 12:46:59+03	t
342	15	12.6	1500	2021-05-02 06:29:30+03	t
344	15	12.6	1500	2021-04-27 05:07:57+03	t
346	5	12.19	3000	2023-12-20 21:32:24+03	t
347	9	12.16	1500	2017-09-10 10:47:15+03	t
350	1	12.16	1500	2022-07-04 07:57:50+03	t
351	13	12.6	1500	2018-01-07 09:41:09+03	t
352	12	12.6	500	2020-03-12 13:44:05+03	t
355	11	12.9	500	2020-11-27 05:57:26+03	t
356	8	12.6	1500	2020-05-05 06:05:54+03	t
358	13	12.16	1500	2020-02-19 21:53:11+03	t
360	13	12.9	500	2019-01-26 23:37:22+03	t
361	9	12.9	500	2019-10-19 20:57:43+03	t
362	4	12.16	1500	2022-04-19 04:23:43+03	t
363	7	12.6	500	2023-05-11 04:46:32+03	t
364	7	12.9	500	2019-07-11 18:25:35+03	t
365	5	12.19	3000	2019-11-01 17:47:22+03	t
366	13	12.6	1500	2023-08-24 15:28:14+03	t
367	2	12.9	500	2023-08-25 00:35:51+03	t
368	8	12.9	500	2023-02-21 19:54:09+03	t
369	12	12.9	500	2020-10-30 11:29:04+03	t
370	8	12.19	3000	2020-08-28 08:46:46+03	t
371	13	12.9	500	2016-08-30 10:01:19+03	t
372	1	12.9	500	2018-04-20 01:54:46+03	t
373	15	12.9	500	2021-11-27 21:15:04+03	t
374	9	12.6	500	2021-08-28 04:05:27+03	t
376	2	12.16	1500	2023-04-06 00:53:25+03	t
377	9	12.19	3000	2016-12-21 08:25:13+03	t
378	10	12.19	3000	2019-07-03 15:33:13+03	t
379	6	12.9	500	2022-07-07 05:30:46+03	t
380	1	12.6	1500	2023-10-18 11:06:06+03	t
381	6	12.6	500	2020-05-24 04:24:32+03	t
382	11	12.9	500	2021-09-29 08:45:09+03	t
384	5	12.16	1500	2023-10-05 06:56:12+03	t
385	15	12.16	1500	2019-10-31 15:48:49+03	t
386	16	12.19	3000	2023-01-07 20:19:55+03	t
390	5	12.9	500	2022-08-06 22:16:10+03	t
391	6	12.9	500	2017-12-30 22:20:27+03	t
392	14	12.9	500	2024-02-05 17:02:58+03	t
394	5	12.6	500	2020-04-10 16:34:19+03	t
395	12	12.19	3000	2018-04-16 06:57:45+03	t
396	10	12.19	3000	2018-05-12 00:45:31+03	t
397	2	12.9	500	2022-03-18 14:14:22+03	t
398	6	12.6	1500	2023-09-11 18:47:56+03	t
400	5	12.9	500	2023-11-23 12:42:33+03	t
401	1	12.9	500	2025-03-03 14:41:16+03	t
403	13	12.9	500	2020-07-17 19:10:16+03	t
404	10	12.9	500	2024-08-01 18:16:27+03	t
409	9	12.19	3000	2020-02-15 05:59:35+03	t
410	12	12.9	500	2022-03-29 08:48:20+03	t
411	11	12.19	3000	2021-02-06 02:45:56+03	t
412	6	12.19	3000	2020-01-03 06:38:09+03	t
413	13	12.6	1500	2025-01-07 14:56:53+03	t
415	16	12.9	500	2023-10-24 10:54:25+03	t
417	5	12.6	1500	2024-09-23 06:49:49+03	t
419	11	12.6	1500	2021-04-22 12:23:10+03	t
421	10	12.9	500	2017-08-10 11:56:43+03	t
422	12	12.6	1500	2024-08-11 07:38:34+03	t
423	15	12.6	500	2025-03-08 12:20:59+03	t
424	16	12.9	500	2020-02-27 07:05:29+03	t
425	8	12.9	500	2020-06-18 12:14:25+03	t
427	6	12.9	500	2025-03-16 14:38:31+03	t
428	4	12.19	3000	2022-04-06 16:31:35+03	t
429	3	12.9	500	2017-10-21 14:23:38+03	t
430	12	12.16	1500	2021-05-25 19:53:58+03	t
431	9	12.9	500	2024-05-01 06:31:07+03	t
432	3	12.9	500	2019-09-24 08:53:32+03	t
433	12	12.6	500	2021-11-29 20:20:10+03	t
434	11	12.19	3000	2021-05-20 19:08:48+03	t
435	6	12.19	3000	2023-08-03 08:59:04+03	t
437	2	12.9	500	2020-08-25 21:23:39+03	t
438	1	12.9	500	2020-08-12 08:37:36+03	t
439	6	12.9	500	2018-06-02 00:10:22+03	t
440	3	12.9	500	2022-06-25 22:15:30+03	t
441	13	12.9	500	2017-12-20 03:07:45+03	t
443	2	12.9	500	2024-12-22 19:00:05+03	t
446	4	12.9	500	2024-12-28 08:49:09+03	t
447	11	12.19	3000	2024-04-25 18:41:08+03	t
448	16	12.19	3000	2020-08-29 07:36:38+03	t
449	10	12.6	1500	2021-06-13 09:37:38+03	t
451	10	12.9	500	2023-05-03 02:05:23+03	t
452	6	12.9	500	2019-07-21 14:31:06+03	t
453	1	12.9	500	2017-05-23 08:31:48+03	t
454	7	12.6	500	2020-05-04 05:24:14+03	t
455	6	12.16	1500	2024-12-30 15:23:55+03	t
456	1	12.6	500	2023-12-07 08:34:20+03	t
457	12	12.9	500	2018-11-27 09:07:13+03	t
458	4	12.6	1500	2019-01-27 17:47:46+03	t
459	1	12.19	3000	2024-02-26 07:27:37+03	t
461	1	12.19	3000	2024-01-24 19:23:40+03	t
462	1	12.19	3000	2018-10-16 16:03:04+03	t
464	14	12.16	1500	2021-07-07 16:26:57+03	t
465	9	12.6	500	2024-09-01 07:55:23+03	t
467	8	12.9	500	2022-10-15 02:01:39+03	t
468	6	12.9	500	2024-11-14 10:55:45+03	t
470	2	12.19	3000	2024-08-25 13:31:58+03	t
471	9	12.6	1500	2023-05-18 05:13:59+03	t
472	8	12.6	500	2020-05-30 12:12:21+03	t
473	6	12.9	500	2023-03-28 11:14:03+03	t
474	2	12.19	3000	2024-01-22 00:54:37+03	t
475	11	12.9	500	2022-02-01 04:03:50+03	t
476	11	12.9	500	2025-03-29 10:00:05+03	t
477	8	12.19	3000	2020-11-12 21:43:03+03	t
478	9	12.9	500	2022-10-20 16:20:15+03	t
479	6	12.9	500	2024-03-17 06:13:39+03	t
480	1	12.9	500	2022-05-20 16:38:53+03	t
481	1	12.9	500	2017-03-23 18:44:50+03	t
482	12	12.9	500	2019-11-08 02:56:47+03	t
483	11	12.19	3000	2020-09-27 21:42:50+03	t
484	5	12.6	500	2023-03-04 19:25:06+03	t
485	13	12.16	1500	2021-09-18 14:30:40+03	t
486	12	12.9	500	2019-06-25 00:46:00+03	t
487	14	12.16	1500	2024-07-26 00:42:56+03	t
488	5	12.6	500	2018-10-15 02:13:39+03	t
489	6	12.19	3000	2024-08-28 02:40:09+03	t
490	3	12.16	1500	2023-07-10 13:51:48+03	t
491	1	12.19	3000	2020-09-16 03:39:07+03	t
493	12	12.19	3000	2022-12-28 06:24:44+03	t
494	15	12.9	500	2020-10-26 15:21:54+03	t
496	6	12.19	3000	2021-09-01 03:01:10+03	t
497	10	12.16	1500	2023-02-05 22:09:09+03	t
498	9	12.19	3000	2018-09-12 23:13:38+03	t
499	8	12.16	1500	2020-11-13 13:51:43+03	t
500	15	12.9	500	2024-12-01 17:59:38+03	t
501	15	12.16	1500	2020-04-19 12:08:04+03	t
502	16	12.6	500	2021-04-21 18:21:31+03	t
504	12	12.6	1500	2024-08-26 13:23:10+03	t
505	1	12.6	1500	2023-12-10 15:19:56+03	t
506	9	12.9	500	2023-07-31 12:24:10+03	t
508	10	12.9	500	2021-09-01 12:15:36+03	t
510	15	12.6	1500	2022-08-02 09:12:18+03	t
511	7	12.6	500	2020-11-05 15:22:33+03	t
513	2	12.19	3000	2021-12-09 22:02:54+03	t
514	3	12.9	500	2020-11-23 11:30:39+03	t
515	16	12.19	3000	2023-12-14 17:07:56+03	t
516	14	12.19	3000	2022-09-17 22:10:56+03	t
518	16	12.9	500	2024-10-24 04:30:41+03	t
519	1	12.9	500	2022-01-11 12:14:53+03	t
521	2	12.16	1500	2020-06-14 13:09:04+03	t
522	9	12.16	1500	2017-02-10 03:36:24+03	t
523	13	12.19	3000	2022-07-27 10:51:40+03	t
525	2	12.9	500	2022-04-30 20:41:40+03	t
526	12	12.9	500	2022-01-17 02:54:58+03	t
527	10	12.6	1500	2021-10-04 20:51:40+03	t
528	12	12.9	500	2019-02-01 11:03:25+03	t
529	12	12.19	3000	2023-06-05 10:11:33+03	t
530	1	12.9	500	2025-01-05 14:07:28+03	t
531	1	12.16	1500	2019-10-27 10:06:17+03	t
532	9	12.6	1500	2017-08-18 22:42:06+03	t
533	6	12.9	500	2019-07-20 04:44:32+03	t
534	2	12.9	500	2023-03-05 15:00:57+03	t
535	4	12.19	3000	2024-08-13 20:25:00+03	t
536	3	12.9	500	2024-01-12 01:28:39+03	t
537	5	12.19	3000	2023-05-28 03:08:30+03	t
539	9	12.6	1500	2017-06-27 02:58:41+03	t
540	6	12.9	500	2016-03-11 04:47:51+03	t
541	8	12.16	1500	2019-08-26 01:25:27+03	t
542	15	12.19	3000	2021-05-13 17:44:54+03	t
543	5	12.19	3000	2023-12-13 07:23:47+03	t
544	8	12.19	3000	2023-06-05 04:49:30+03	t
545	5	12.16	1500	2021-08-11 23:59:08+03	t
546	9	12.19	3000	2020-11-18 04:35:11+03	t
548	6	12.9	500	2020-02-02 19:57:09+03	t
550	11	12.6	500	2023-03-05 17:55:45+03	t
551	13	12.9	500	2024-01-31 13:55:28+03	t
552	3	12.9	500	2017-10-28 05:36:40+03	t
553	2	12.16	1500	2024-11-12 14:27:02+03	t
555	9	12.6	500	2023-08-11 20:30:45+03	t
556	10	12.9	500	2021-08-18 16:58:03+03	t
557	12	12.16	1500	2023-03-29 10:26:44+03	t
558	3	12.6	1500	2017-11-28 17:43:01+03	t
559	13	12.16	1500	2023-08-09 15:03:09+03	t
561	12	12.19	3000	2024-03-22 06:39:33+03	t
562	16	12.16	1500	2019-07-15 22:38:53+03	t
563	10	12.9	500	2019-05-15 01:26:20+03	t
564	12	12.6	500	2019-04-27 07:30:41+03	t
566	1	12.6	500	2017-10-19 05:58:20+03	t
568	6	12.9	500	2024-07-09 14:19:33+03	t
569	13	12.19	3000	2023-10-19 10:38:06+03	t
570	12	12.9	500	2017-09-07 11:22:50+03	t
571	16	12.6	1500	2021-03-07 23:07:33+03	t
572	9	12.6	500	2023-10-23 10:11:07+03	t
573	3	12.16	1500	2023-10-25 17:04:44+03	t
575	12	12.19	3000	2018-09-20 07:21:06+03	t
576	10	12.16	1500	2018-12-06 14:34:35+03	t
577	10	12.9	500	2022-01-05 06:38:07+03	t
579	4	12.19	3000	2019-06-28 23:51:47+03	t
580	16	12.9	500	2020-12-29 09:38:26+03	t
582	10	12.19	3000	2018-07-05 18:11:02+03	t
583	9	12.6	500	2017-01-10 20:38:33+03	t
584	9	12.19	3000	2024-03-03 09:30:44+03	t
585	9	12.19	3000	2024-02-06 23:16:07+03	t
586	6	12.19	3000	2018-06-29 03:05:43+03	t
587	16	12.19	3000	2019-12-30 17:01:09+03	t
588	15	12.9	500	2024-12-06 00:57:13+03	t
589	14	12.6	1500	2023-02-13 21:36:56+03	t
590	6	12.9	500	2016-12-11 03:31:51+03	t
592	9	12.19	3000	2023-10-18 09:33:01+03	t
593	7	12.9	500	2022-04-13 21:28:49+03	t
594	11	12.9	500	2020-12-02 00:24:20+03	t
595	13	12.19	3000	2021-02-27 08:13:55+03	t
597	6	12.9	500	2018-02-16 19:29:04+03	t
599	8	12.19	3000	2020-05-14 07:37:26+03	t
605	5	12.19	3000	2018-11-10 01:23:46+03	t
606	14	12.9	500	2024-05-21 16:55:56+03	t
607	16	12.16	1500	2020-07-21 00:45:10+03	t
608	1	12.6	1500	2025-02-08 11:54:53+03	t
610	12	12.19	3000	2024-12-14 20:02:14+03	t
611	15	12.16	1500	2021-02-02 22:59:00+03	t
612	12	12.19	3000	2024-02-01 14:08:10+03	t
613	1	12.6	1500	2019-01-24 23:41:18+03	t
614	2	12.16	1500	2021-03-28 13:17:29+03	t
616	10	12.6	500	2022-08-07 23:00:46+03	t
617	12	12.9	500	2024-08-08 01:04:03+03	t
618	8	12.9	500	2021-01-19 04:28:12+03	t
619	1	12.6	1500	2021-06-26 11:10:08+03	t
620	8	12.16	1500	2021-11-12 21:42:22+03	t
622	3	12.19	3000	2017-10-21 13:31:17+03	t
623	13	12.6	500	2020-02-16 02:10:00+03	t
624	1	12.19	3000	2017-02-28 03:49:52+03	t
625	5	12.9	500	2019-04-22 00:27:44+03	t
626	10	12.19	3000	2017-11-18 17:31:29+03	t
627	12	12.9	500	2017-12-09 22:09:09+03	t
629	10	12.19	3000	2021-07-08 07:18:47+03	t
633	6	12.9	500	2022-03-04 04:23:29+03	t
634	7	12.19	3000	2022-06-29 12:32:16+03	t
635	3	12.9	500	2018-07-13 06:06:38+03	t
637	6	12.9	500	2017-10-18 11:07:57+03	t
638	1	12.9	500	2017-04-21 15:35:51+03	t
640	4	12.6	500	2021-03-26 03:22:53+03	t
641	3	12.16	1500	2023-05-03 23:34:07+03	t
642	8	12.19	3000	2020-03-12 08:32:08+03	t
644	10	12.16	1500	2020-01-07 07:37:02+03	t
645	11	12.19	3000	2024-07-25 12:03:35+03	t
646	12	12.19	3000	2018-12-07 00:02:40+03	t
647	14	12.19	3000	2023-04-06 15:16:38+03	t
648	5	12.16	1500	2021-12-10 04:57:34+03	t
649	2	12.16	1500	2021-03-07 17:03:15+03	t
650	5	12.19	3000	2022-02-09 14:42:01+03	t
651	5	12.6	1500	2024-04-09 22:55:09+03	t
652	8	12.19	3000	2025-03-04 12:20:39+03	t
655	15	12.19	3000	2021-07-08 00:25:25+03	t
656	16	12.9	500	2022-06-07 18:21:31+03	t
657	16	12.16	1500	2022-09-21 12:26:37+03	t
659	8	12.9	500	2019-10-15 18:34:30+03	t
660	16	12.19	3000	2021-05-18 07:31:32+03	t
662	7	12.19	3000	2022-12-30 17:16:12+03	t
663	5	12.6	500	2020-07-02 03:27:35+03	t
664	10	12.9	500	2017-12-18 10:43:56+03	t
665	8	12.19	3000	2025-03-17 12:36:41+03	t
666	2	12.9	500	2024-10-06 12:14:12+03	t
667	4	12.9	500	2020-12-18 04:10:32+03	t
668	11	12.6	1500	2020-12-03 00:43:28+03	t
669	9	12.19	3000	2017-12-22 03:39:08+03	t
672	8	12.9	500	2020-01-23 17:27:49+03	t
673	9	12.6	500	2020-10-04 03:14:51+03	t
674	14	12.9	500	2021-10-29 21:42:15+03	t
675	16	12.16	1500	2019-12-25 03:04:43+03	t
676	10	12.19	3000	2019-01-02 09:39:59+03	t
677	13	12.19	3000	2024-06-10 10:44:16+03	t
678	13	12.16	1500	2018-09-23 01:50:28+03	t
679	13	12.16	1500	2016-02-20 00:04:17+03	t
681	10	12.6	1500	2020-12-09 16:57:29+03	t
682	7	12.19	3000	2024-11-30 10:54:46+03	t
683	10	12.16	1500	2017-08-29 11:32:03+03	t
685	14	12.9	500	2023-05-25 23:55:22+03	t
686	3	12.19	3000	2018-12-03 14:58:57+03	t
687	2	12.16	1500	2021-09-24 23:32:49+03	t
688	4	12.19	3000	2021-05-17 09:34:34+03	t
689	13	12.9	500	2016-05-11 21:55:52+03	t
690	7	12.16	1500	2020-01-10 06:03:15+03	t
691	3	12.9	500	2023-10-25 09:41:40+03	t
692	14	12.19	3000	2024-11-18 13:37:09+03	t
693	1	12.19	3000	2024-07-15 12:47:48+03	t
694	10	12.19	3000	2017-08-10 01:11:52+03	t
695	3	12.19	3000	2022-08-17 11:54:16+03	t
696	13	12.19	3000	2020-08-12 03:37:43+03	t
698	1	12.9	500	2023-10-17 11:41:16+03	t
699	10	12.9	500	2020-09-19 15:27:07+03	t
700	6	12.6	500	2019-09-13 18:25:35+03	t
701	13	12.6	1500	2020-04-06 02:16:34+03	t
703	13	12.9	500	2016-04-18 23:14:19+03	t
704	4	12.6	500	2018-08-23 15:20:37+03	t
706	1	12.16	1500	2018-09-24 16:03:53+03	t
707	4	12.6	500	2020-05-13 23:50:34+03	t
708	9	12.9	500	2022-06-30 13:51:11+03	t
709	4	12.19	3000	2020-07-26 00:52:20+03	t
710	1	12.9	500	2024-02-03 12:15:01+03	t
711	2	12.9	500	2020-10-16 18:05:01+03	t
712	9	12.9	500	2020-08-20 17:54:32+03	t
713	16	12.9	500	2023-05-30 17:20:55+03	t
714	16	12.9	500	2020-03-23 15:59:00+03	t
715	7	12.19	3000	2022-02-01 09:33:07+03	t
718	9	12.9	500	2020-11-02 12:24:48+03	t
720	4	12.9	500	2020-03-19 12:34:21+03	t
721	15	12.9	500	2021-10-27 04:39:58+03	t
722	5	12.19	3000	2022-06-10 05:48:56+03	t
723	16	12.6	1500	2019-12-08 22:09:58+03	t
724	3	12.9	500	2020-04-30 15:38:25+03	t
726	2	12.6	500	2024-12-04 09:02:07+03	t
727	14	12.9	500	2023-10-08 00:04:07+03	t
729	15	12.9	500	2022-03-14 07:51:23+03	t
730	8	12.6	500	2020-04-20 14:57:58+03	t
732	1	12.6	500	2023-09-16 15:15:45+03	t
733	16	12.19	3000	2020-08-12 12:40:54+03	t
734	1	12.19	3000	2017-08-15 09:13:34+03	t
735	13	12.19	3000	2020-08-05 18:25:07+03	t
736	16	12.16	1500	2021-12-30 21:03:21+03	t
737	6	12.16	1500	2017-09-30 09:55:43+03	t
738	13	12.19	3000	2017-10-03 05:49:42+03	t
739	16	12.6	500	2022-09-21 04:42:55+03	t
740	15	12.6	500	2023-01-13 18:51:37+03	t
741	2	12.19	3000	2022-05-09 10:04:13+03	t
742	11	12.19	3000	2022-07-16 19:08:05+03	t
743	1	12.9	500	2019-06-15 17:30:43+03	t
744	9	12.19	3000	2018-02-24 23:29:49+03	t
745	12	12.19	3000	2018-02-15 22:43:22+03	t
746	5	12.9	500	2019-09-04 12:29:53+03	t
747	16	12.16	1500	2022-09-06 20:50:52+03	t
751	6	12.16	1500	2025-02-28 20:36:34+03	t
752	15	12.19	3000	2024-06-08 22:00:58+03	t
753	10	12.9	500	2021-04-12 19:56:45+03	t
754	13	12.6	1500	2016-08-18 06:34:04+03	t
755	14	12.16	1500	2025-03-31 19:48:44+03	t
756	10	12.9	500	2019-02-02 03:24:05+03	t
757	1	12.9	500	2022-09-09 00:57:15+03	t
758	12	12.16	1500	2024-04-14 12:57:57+03	t
759	14	12.6	1500	2024-10-19 00:38:49+03	t
760	2	12.19	3000	2019-12-11 06:30:39+03	t
761	14	12.16	1500	2021-08-01 17:24:56+03	t
762	5	12.9	500	2017-10-05 00:51:27+03	t
763	15	12.16	1500	2023-09-21 20:03:04+03	t
764	1	12.19	3000	2020-09-08 20:58:58+03	t
766	9	12.9	500	2023-05-14 09:50:55+03	t
767	5	12.16	1500	2024-10-22 07:15:34+03	t
768	9	12.9	500	2023-09-24 14:01:38+03	t
769	4	12.9	500	2022-02-01 19:09:21+03	t
773	13	12.19	3000	2017-06-30 11:14:35+03	t
774	5	12.6	500	2017-08-16 14:39:38+03	t
775	8	12.9	500	2023-03-11 13:14:08+03	t
777	13	12.19	3000	2019-05-04 19:51:38+03	t
778	15	12.16	1500	2021-02-05 21:18:01+03	t
780	11	12.6	500	2023-05-23 20:23:28+03	t
782	1	12.6	500	2023-12-22 15:20:57+03	t
784	1	12.19	3000	2022-04-28 02:33:40+03	t
786	6	12.16	1500	2018-10-29 21:48:50+03	t
787	9	12.9	500	2024-06-18 10:42:19+03	t
788	1	12.16	1500	2021-07-03 12:42:06+03	t
789	13	12.9	500	2019-02-14 10:43:53+03	t
790	9	12.16	1500	2020-03-12 21:06:20+03	t
791	12	12.19	3000	2020-05-10 12:32:23+03	t
792	13	12.16	1500	2016-07-28 20:38:24+03	t
794	16	12.6	1500	2019-07-13 10:00:25+03	t
795	13	12.9	500	2018-04-19 05:28:07+03	t
796	1	12.6	500	2024-03-22 21:16:41+03	t
797	10	12.6	500	2023-03-22 04:18:11+03	t
799	10	12.6	500	2022-09-17 09:55:12+03	t
800	12	12.9	500	2018-09-08 00:29:42+03	t
801	16	12.19	3000	2020-11-20 23:37:44+03	t
802	2	12.19	3000	2020-09-01 05:25:42+03	t
803	13	12.19	3000	2022-11-03 01:35:32+03	t
805	15	12.6	500	2021-03-16 14:09:38+03	t
806	11	12.9	500	2021-10-14 06:38:11+03	t
807	13	12.9	500	2018-10-17 14:21:43+03	t
808	10	12.9	500	2024-12-02 09:24:37+03	t
809	8	12.9	500	2023-09-07 01:43:18+03	t
810	8	12.19	3000	2024-10-30 02:25:10+03	t
812	5	12.16	1500	2022-08-28 18:33:32+03	t
813	3	12.16	1500	2021-09-18 16:50:13+03	t
814	8	12.6	500	2023-02-02 16:20:23+03	t
820	4	12.6	500	2023-05-07 13:55:46+03	t
821	8	12.19	3000	2022-07-12 16:45:47+03	t
822	1	12.16	1500	2017-06-08 11:32:55+03	t
823	15	12.6	1500	2020-03-24 03:09:47+03	t
825	5	12.19	3000	2018-03-24 03:01:12+03	t
826	16	12.19	3000	2023-11-22 09:55:52+03	t
827	5	12.9	500	2025-01-14 23:56:12+03	t
830	12	12.6	500	2018-06-02 06:38:09+03	t
832	4	12.16	1500	2021-04-26 05:23:39+03	t
835	13	12.16	1500	2019-03-13 17:52:19+03	t
836	1	12.9	500	2024-07-10 22:41:35+03	t
837	13	12.6	1500	2018-02-13 12:16:39+03	t
838	1	12.9	500	2022-07-19 01:58:23+03	t
839	5	12.6	500	2018-08-19 20:13:32+03	t
840	1	12.6	500	2019-10-10 02:54:09+03	t
842	15	12.19	3000	2023-10-16 12:25:26+03	t
843	8	12.19	3000	2022-02-23 04:07:46+03	t
845	12	12.9	500	2022-03-15 15:59:41+03	t
846	8	12.9	500	2020-09-19 03:30:28+03	t
848	5	12.9	500	2018-07-28 02:35:39+03	t
849	5	12.6	1500	2024-01-24 19:21:58+03	t
850	6	12.19	3000	2019-02-01 20:30:16+03	t
851	5	12.6	1500	2019-05-20 00:48:13+03	t
853	11	12.19	3000	2022-04-08 08:00:19+03	t
854	15	12.9	500	2025-01-14 04:53:38+03	t
855	7	12.19	3000	2023-06-28 21:19:32+03	t
856	11	12.6	1500	2024-05-16 09:30:51+03	t
857	14	12.19	3000	2023-12-22 04:54:30+03	t
858	10	12.19	3000	2020-05-13 03:07:59+03	t
859	10	12.19	3000	2018-11-06 21:46:05+03	t
860	5	12.9	500	2021-10-12 08:32:06+03	t
861	16	12.6	1500	2020-11-14 03:39:17+03	t
862	8	12.19	3000	2022-05-08 09:17:16+03	t
863	13	12.19	3000	2021-06-02 11:52:30+03	t
864	7	12.9	500	2022-02-06 18:49:10+03	t
865	6	12.6	500	2023-04-26 15:36:42+03	t
866	8	12.9	500	2020-07-04 17:13:35+03	t
867	9	12.6	1500	2022-04-19 04:15:10+03	t
869	6	12.6	500	2021-07-22 10:27:40+03	t
870	12	12.6	500	2024-06-12 10:48:40+03	t
871	2	12.9	500	2020-09-17 01:26:43+03	t
872	13	12.9	500	2020-01-12 02:43:39+03	t
874	1	12.6	1500	2017-07-06 21:12:01+03	t
877	4	12.9	500	2021-05-14 05:52:43+03	t
878	1	12.6	500	2020-09-28 20:51:57+03	t
879	14	12.6	500	2022-09-13 15:19:12+03	t
880	2	12.6	1500	2023-12-13 19:16:04+03	t
881	16	12.16	1500	2023-10-21 00:38:14+03	t
882	13	12.19	3000	2023-06-28 13:57:32+03	t
884	10	12.16	1500	2019-03-02 22:16:01+03	t
886	4	12.19	3000	2019-04-07 22:04:53+03	t
887	4	12.9	500	2022-03-17 04:55:48+03	t
888	13	12.6	1500	2024-10-10 23:32:17+03	t
890	1	12.9	500	2018-06-28 17:04:26+03	t
891	4	12.19	3000	2021-11-29 23:01:28+03	t
892	2	12.16	1500	2024-12-19 10:51:43+03	t
893	7	12.9	500	2023-02-14 13:20:10+03	t
894	14	12.6	1500	2024-02-26 11:18:03+03	t
897	12	12.9	500	2022-08-07 17:04:37+03	t
899	6	12.9	500	2018-10-26 10:48:43+03	t
900	2	12.16	1500	2021-07-22 06:15:52+03	t
902	6	12.19	3000	2017-06-29 06:34:41+03	t
903	13	12.6	1500	2024-10-31 14:25:40+03	t
904	10	12.19	3000	2019-04-14 21:19:34+03	t
905	15	12.9	500	2020-12-09 17:24:23+03	t
906	13	12.9	500	2016-08-16 03:43:22+03	t
907	12	12.9	500	2024-03-29 17:40:19+03	t
908	12	12.9	500	2021-01-01 23:53:13+03	t
909	1	12.9	500	2021-05-16 10:43:57+03	t
912	3	12.9	500	2019-08-28 10:32:44+03	t
913	1	12.19	3000	2017-01-28 05:14:17+03	t
915	9	12.19	3000	2024-07-27 01:33:31+03	t
916	13	12.19	3000	2017-09-01 08:55:52+03	t
918	16	12.6	500	2023-02-14 20:29:42+03	t
919	15	12.19	3000	2020-11-06 08:56:01+03	t
920	1	12.19	3000	2024-04-03 10:04:39+03	t
922	4	12.19	3000	2022-07-27 22:19:57+03	t
924	8	12.19	3000	2020-06-27 13:49:25+03	t
925	5	12.9	500	2020-11-21 05:23:56+03	t
927	3	12.6	500	2022-01-06 12:56:09+03	t
928	1	12.19	3000	2023-01-07 07:12:41+03	t
929	11	12.19	3000	2024-12-04 16:16:22+03	t
931	1	12.9	500	2016-04-10 01:01:03+03	t
933	16	12.6	1500	2021-08-26 12:21:04+03	t
934	10	12.16	1500	2021-06-08 08:41:04+03	t
936	15	12.16	1500	2025-03-09 10:30:19+03	t
937	2	12.9	500	2021-10-16 13:02:36+03	t
938	16	12.19	3000	2019-07-09 14:48:34+03	t
939	10	12.6	500	2022-06-10 07:02:00+03	t
940	1	12.16	1500	2017-07-27 17:08:07+03	t
941	15	12.19	3000	2021-08-16 09:06:20+03	t
943	1	12.19	3000	2022-05-29 10:24:02+03	t
944	13	12.19	3000	2024-06-17 23:46:33+03	t
945	8	12.9	500	2021-08-21 08:02:05+03	t
946	14	12.9	500	2023-10-23 16:36:24+03	t
947	3	12.6	1500	2018-08-13 22:59:19+03	t
950	1	12.9	500	2022-09-24 23:06:32+03	t
951	15	12.16	1500	2023-09-29 01:50:10+03	t
954	5	12.19	3000	2019-05-26 11:26:11+03	t
955	15	12.16	1500	2022-01-04 20:15:04+03	t
957	3	12.9	500	2021-10-28 01:36:54+03	t
959	10	12.9	500	2023-04-21 08:42:18+03	t
961	5	12.19	3000	2018-03-08 05:45:05+03	t
962	9	12.9	500	2018-03-08 22:26:51+03	t
964	11	12.6	1500	2024-11-21 22:31:36+03	t
967	7	12.6	1500	2021-07-08 18:47:17+03	t
968	5	12.19	3000	2019-04-02 10:15:14+03	t
970	11	12.19	3000	2022-06-28 05:54:43+03	t
971	6	12.19	3000	2017-12-19 04:17:36+03	t
973	9	12.19	3000	2022-09-21 18:42:11+03	t
974	12	12.9	500	2018-12-17 14:55:37+03	t
975	6	12.9	500	2019-07-27 06:31:29+03	t
976	4	12.16	1500	2021-10-20 16:32:52+03	t
977	7	12.9	500	2020-08-16 06:38:54+03	t
980	3	12.16	1500	2019-06-30 23:35:07+03	t
981	5	12.19	3000	2019-11-06 13:58:27+03	t
983	12	12.6	500	2017-09-14 15:38:48+03	t
984	13	12.16	1500	2016-03-23 00:51:04+03	t
985	13	12.19	3000	2024-08-19 02:19:53+03	t
986	7	12.9	500	2023-12-13 19:33:43+03	t
987	3	12.6	500	2021-04-08 07:42:18+03	t
988	13	12.19	3000	2016-12-16 18:47:21+03	t
989	13	12.16	1500	2022-05-09 20:01:36+03	t
990	11	12.19	3000	2023-11-12 01:37:33+03	t
992	10	12.6	1500	2021-06-28 18:47:29+03	t
994	15	12.9	500	2020-08-28 04:34:35+03	t
996	14	12.6	500	2021-07-23 23:45:16+03	t
997	12	12.19	3000	2019-05-27 19:32:57+03	t
998	9	12.9	500	2021-10-13 09:30:08+03	t
999	11	12.6	500	2023-08-15 06:31:49+03	t
1000	11	12.9	500	2024-06-06 03:35:54+03	t
\.


--
-- TOC entry 4902 (class 0 OID 16470)
-- Dependencies: 218
-- Data for Name: passport_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passport_history (id, client_id, date_start, date_end, details) FROM stdin;
1	1	2020-09-06	\N	4683991498
2	2	2024-12-08	\N	8444083692
3	3	2022-06-29	\N	5520613602
4	4	2020-11-28	\N	1643244910
5	5	2022-07-29	\N	4920831073
6	6	2020-10-16	\N	6861054432
7	7	2020-10-01	\N	3645123992
8	8	2022-05-12	\N	4264320594
9	9	2024-07-19	\N	1919281282
10	10	2024-01-15	\N	4009750305
11	11	2022-03-31	\N	7141524629
12	12	2024-08-05	\N	4023984107
13	13	2020-12-26	\N	5626061311
14	14	2022-12-27	\N	5296683328
15	15	2024-01-10	\N	7376372592
16	16	2021-03-25	\N	8042867914
17	17	2024-12-23	\N	7860952389
18	18	2021-10-26	\N	6798887939
19	19	2022-09-01	\N	5008540639
20	20	2023-12-29	\N	4484562009
21	21	2020-05-23	\N	6104201139
22	22	2023-02-26	\N	6534581541
23	23	2023-06-11	\N	4896332603
24	24	2021-09-24	\N	2684863326
25	25	2022-06-29	\N	4314539477
26	26	2024-05-27	\N	5253318203
27	27	2023-04-02	\N	8289559290
28	28	2024-07-11	\N	9431886424
29	29	2023-07-24	\N	6288402867
30	30	2020-10-16	\N	3928925857
31	31	2022-03-21	\N	1439897774
32	32	2021-09-10	\N	5343756735
33	33	2022-03-29	\N	9588164864
34	34	2022-08-05	\N	5611800876
35	35	2020-08-01	\N	7316353099
36	36	2020-12-07	\N	1540846648
37	37	2023-05-18	\N	3352399010
38	38	2023-05-09	\N	7640207759
39	39	2024-09-04	\N	2127927010
40	40	2023-06-11	\N	8896242440
41	41	2023-02-12	\N	1955622912
42	42	2022-05-30	\N	5820321271
43	43	2024-06-21	\N	5979193339
44	44	2020-12-18	\N	9922296823
45	45	2021-10-04	\N	6501039549
46	46	2025-04-26	\N	9233136811
47	47	2023-05-09	\N	5145354431
48	48	2023-07-06	\N	3153936801
49	49	2024-07-25	\N	6893832869
50	50	2024-05-30	\N	6024130040
51	51	2024-12-21	\N	5743068785
52	52	2021-06-21	\N	1592629618
53	53	2024-09-30	\N	1960685532
54	54	2023-08-21	\N	7887013676
55	55	2024-10-23	\N	8898072719
56	56	2021-11-24	\N	9085262810
57	57	2022-05-28	\N	2721344285
58	58	2024-04-13	\N	4910391668
59	59	2024-02-15	\N	3551183260
60	60	2023-08-16	\N	6866604769
61	61	2021-12-11	\N	8432377478
62	62	2021-08-17	\N	6806627511
63	63	2021-01-17	\N	2074761226
64	64	2024-03-20	\N	3729269204
65	65	2022-02-22	\N	4497135100
66	66	2022-08-23	\N	8067943457
67	67	2022-09-25	\N	5524081958
68	68	2024-11-05	\N	3015629892
69	69	2023-07-10	\N	7730742168
70	70	2021-11-16	\N	1768306456
71	71	2024-02-17	\N	8461768237
72	72	2024-05-16	\N	3592364982
73	73	2022-02-23	\N	4095591008
74	74	2021-03-10	\N	2180470319
75	75	2025-04-15	\N	8342686606
76	76	2020-12-22	\N	1567190994
77	77	2024-12-06	\N	1743245706
78	78	2024-02-17	\N	3023866605
79	79	2024-02-15	\N	7139809993
80	80	2022-07-25	\N	2733127681
81	81	2023-12-05	\N	4732651751
82	82	2022-12-18	\N	6627714962
83	83	2021-01-20	\N	5569455974
84	84	2023-05-07	\N	3990371520
85	85	2021-08-19	\N	9672003765
86	86	2024-05-14	\N	8299411898
87	87	2021-02-13	\N	6089283715
88	88	2023-04-20	\N	7539175067
89	89	2021-01-14	\N	3980069585
90	90	2022-07-12	\N	5167397426
91	91	2023-10-10	\N	1253170282
92	92	2020-08-21	\N	9361147247
93	93	2024-06-13	\N	8178646635
94	94	2020-07-23	\N	6946499358
95	95	2021-10-05	\N	1368309482
96	96	2023-05-25	\N	8087413371
97	97	2024-11-18	\N	8048744188
98	98	2024-10-21	\N	8897436621
99	99	2023-12-05	\N	6526997237
100	100	2024-06-08	\N	8031438906
\.


--
-- TOC entry 4899 (class 0 OID 16399)
-- Dependencies: 215
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."position" (id, title, responsibilities) FROM stdin;
1	Менеджер по аренде	Прием заявок, оформление договоров, консультация клиентов
2	Старший менеджер	Контроль работы менеджеров, работа с ключевыми клиентами, отчетность
3	Администратор	Встреча клиентов, прием платежей, контроль состояния авто
\.


--
-- TOC entry 4900 (class 0 OID 16415)
-- Dependencies: 216
-- Data for Name: positions_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.positions_history (id, emp_pos_id, emp_id, salary, date_start, date_end) FROM stdin;
\.


--
-- TOC entry 4707 (class 2606 OID 16777)
-- Name: accident accident_damage_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.accident
    ADD CONSTRAINT accident_damage_check CHECK ((damage >= (0)::double precision)) NOT VALID;


--
-- TOC entry 4733 (class 2606 OID 16597)
-- Name: accident accident_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accident
    ADD CONSTRAINT accident_pkey PRIMARY KEY (id);


--
-- TOC entry 4721 (class 2606 OID 16498)
-- Name: brand brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (id);


--
-- TOC entry 4729 (class 2606 OID 16565)
-- Name: car_body car_body_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_body
    ADD CONSTRAINT car_body_pkey PRIMARY KEY (id);


--
-- TOC entry 4723 (class 2606 OID 16517)
-- Name: car_info car_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_info
    ADD CONSTRAINT car_info_pkey PRIMARY KEY (id);


--
-- TOC entry 4705 (class 2606 OID 16701)
-- Name: car_instance car_instance_mileage_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.car_instance
    ADD CONSTRAINT car_instance_mileage_check CHECK ((mileage >= 0)) NOT VALID;


--
-- TOC entry 4731 (class 2606 OID 16587)
-- Name: car_instance car_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_instance
    ADD CONSTRAINT car_instance_pkey PRIMARY KEY (id);


--
-- TOC entry 4706 (class 2606 OID 16700)
-- Name: car_instance car_instance_price_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.car_instance
    ADD CONSTRAINT car_instance_price_check CHECK ((price > 0)) NOT VALID;


--
-- TOC entry 4699 (class 2606 OID 16426)
-- Name: positions_history check_date; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.positions_history
    ADD CONSTRAINT check_date CHECK ((date_start <= date_end)) NOT VALID;


--
-- TOC entry 4700 (class 2606 OID 16425)
-- Name: positions_history check_salary; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.positions_history
    ADD CONSTRAINT check_salary CHECK ((salary >= 0)) NOT VALID;


--
-- TOC entry 4719 (class 2606 OID 16486)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 4739 (class 2606 OID 16759)
-- Name: contract_history contract_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_history
    ADD CONSTRAINT contract_history_pkey PRIMARY KEY (id);


--
-- TOC entry 4737 (class 2606 OID 16620)
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id);


--
-- TOC entry 4711 (class 2606 OID 16403)
-- Name: position emp_position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT emp_position_pkey PRIMARY KEY (id);


--
-- TOC entry 4713 (class 2606 OID 16419)
-- Name: positions_history emp_positions_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions_history
    ADD CONSTRAINT emp_positions_history_pkey PRIMARY KEY (id);


--
-- TOC entry 4715 (class 2606 OID 16451)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- TOC entry 4727 (class 2606 OID 16553)
-- Name: engine engine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.engine
    ADD CONSTRAINT engine_pkey PRIMARY KEY (id);


--
-- TOC entry 4708 (class 2606 OID 16702)
-- Name: fine fine_cost_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.fine
    ADD CONSTRAINT fine_cost_check CHECK ((cost > 0)) NOT VALID;


--
-- TOC entry 4735 (class 2606 OID 16609)
-- Name: fine fine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fine
    ADD CONSTRAINT fine_pkey PRIMARY KEY (id);


--
-- TOC entry 4717 (class 2606 OID 16705)
-- Name: passport_history passport_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_history
    ADD CONSTRAINT passport_history_pkey PRIMARY KEY (id);


--
-- TOC entry 4704 (class 2606 OID 16694)
-- Name: engine power_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.engine
    ADD CONSTRAINT power_check CHECK ((power > 0)) NOT VALID;


--
-- TOC entry 4709 (class 2606 OID 16770)
-- Name: contract price_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.contract
    ADD CONSTRAINT price_check CHECK ((price > (0)::double precision)) NOT VALID;


--
-- TOC entry 4725 (class 2606 OID 16534)
-- Name: car specs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT specs_pkey PRIMARY KEY (id);


--
-- TOC entry 4748 (class 2606 OID 16598)
-- Name: accident accident_instance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accident
    ADD CONSTRAINT accident_instance_id_fkey FOREIGN KEY (instance_id) REFERENCES public.car_instance(id);


--
-- TOC entry 4743 (class 2606 OID 16518)
-- Name: car_info car_info_brand_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_info
    ADD CONSTRAINT car_info_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brand(id);


--
-- TOC entry 4747 (class 2606 OID 16654)
-- Name: car_instance car_instance_car_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_instance
    ADD CONSTRAINT car_instance_car_id_fkey FOREIGN KEY (car_id) REFERENCES public.car(id) NOT VALID;


--
-- TOC entry 4754 (class 2606 OID 16760)
-- Name: contract_history contract_history_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_history
    ADD CONSTRAINT contract_history_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.contract(id) NOT VALID;


--
-- TOC entry 4755 (class 2606 OID 16765)
-- Name: contract_history contract_history_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_history
    ADD CONSTRAINT contract_history_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES public.employee(id) NOT VALID;


--
-- TOC entry 4750 (class 2606 OID 16684)
-- Name: contract contract_instance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_instance_id_fkey FOREIGN KEY (instance_id) REFERENCES public.car_instance(id) NOT VALID;


--
-- TOC entry 4751 (class 2606 OID 16753)
-- Name: contract contract_passport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_passport_id_fkey FOREIGN KEY (passport_id) REFERENCES public.passport_history(id) NOT VALID;


--
-- TOC entry 4752 (class 2606 OID 16785)
-- Name: contract contract_rent_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_rent_emp_id_fkey FOREIGN KEY (rent_emp_id) REFERENCES public.employee(id) NOT VALID;


--
-- TOC entry 4753 (class 2606 OID 16790)
-- Name: contract contract_return_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_return_emp_id_fkey FOREIGN KEY (return_emp_id) REFERENCES public.employee(id) NOT VALID;


--
-- TOC entry 4740 (class 2606 OID 16420)
-- Name: positions_history emp_pos_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions_history
    ADD CONSTRAINT emp_pos_id FOREIGN KEY (emp_pos_id) REFERENCES public."position"(id);


--
-- TOC entry 4749 (class 2606 OID 16610)
-- Name: fine fine_instance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fine
    ADD CONSTRAINT fine_instance_id_fkey FOREIGN KEY (instance_id) REFERENCES public.car_instance(id);


--
-- TOC entry 4742 (class 2606 OID 16487)
-- Name: passport_history passport_history_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_history
    ADD CONSTRAINT passport_history_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id) NOT VALID;


--
-- TOC entry 4741 (class 2606 OID 16689)
-- Name: positions_history positions_history_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions_history
    ADD CONSTRAINT positions_history_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES public.employee(id) NOT VALID;


--
-- TOC entry 4744 (class 2606 OID 16571)
-- Name: car specs_car_body_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT specs_car_body_id_fkey FOREIGN KEY (car_body_id) REFERENCES public.car_body(id) NOT VALID;


--
-- TOC entry 4745 (class 2606 OID 16576)
-- Name: car specs_engine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT specs_engine_id_fkey FOREIGN KEY (engine_id) REFERENCES public.engine(id) NOT VALID;


--
-- TOC entry 4746 (class 2606 OID 16649)
-- Name: car specs_info_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT specs_info_id_fkey FOREIGN KEY (info_id) REFERENCES public.car_info(id) NOT VALID;


-- Completed on 2025-04-21 12:36:52

--
-- PostgreSQL database dump complete
--

