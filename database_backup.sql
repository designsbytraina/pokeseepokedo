--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: encounters; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE encounters (
    encounter_id integer NOT NULL,
    latitude double precision,
    pokemon_id integer,
    longitude double precision
);


ALTER TABLE public.encounters OWNER TO vagrant;

--
-- Name: encounters_encounter_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE encounters_encounter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.encounters_encounter_id_seq OWNER TO vagrant;

--
-- Name: encounters_encounter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE encounters_encounter_id_seq OWNED BY encounters.encounter_id;


--
-- Name: gyms; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE gyms (
    location_id integer NOT NULL,
    latitude double precision,
    longitude double precision,
    name character varying(100) NOT NULL
);


ALTER TABLE public.gyms OWNER TO vagrant;

--
-- Name: gyms_location_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE gyms_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gyms_location_id_seq OWNER TO vagrant;

--
-- Name: gyms_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE gyms_location_id_seq OWNED BY gyms.location_id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE locations (
    location_id integer NOT NULL,
    latitude double precision,
    longitude double precision,
    rating integer,
    name character varying(100) NOT NULL,
    url character varying(200),
    category character varying(50)
);


ALTER TABLE public.locations OWNER TO vagrant;

--
-- Name: locations_location_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE locations_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_location_id_seq OWNER TO vagrant;

--
-- Name: locations_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE locations_location_id_seq OWNED BY locations.location_id;


--
-- Name: poke_base; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE poke_base (
    id integer NOT NULL,
    identifier character varying(50),
    species_id integer,
    height integer,
    weight integer,
    base_experience integer,
    "order" integer,
    is_default integer
);


ALTER TABLE public.poke_base OWNER TO vagrant;

--
-- Name: poke_types; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE poke_types (
    pokemon_id integer,
    type_id integer,
    slot integer
);


ALTER TABLE public.poke_types OWNER TO vagrant;

--
-- Name: types_base; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE types_base (
    id integer NOT NULL,
    identifier character varying(50),
    generation_id integer,
    damage_class_id integer
);


ALTER TABLE public.types_base OWNER TO vagrant;

--
-- Name: types; Type: VIEW; Schema: public; Owner: vagrant
--

CREATE VIEW types AS
 SELECT DISTINCT poke_types.pokemon_id,
    poke_types.type_id,
    types_base.identifier
   FROM (poke_types
     JOIN types_base ON ((poke_types.type_id = types_base.id)))
  ORDER BY poke_types.pokemon_id;


ALTER TABLE public.types OWNER TO vagrant;

--
-- Name: pokemons; Type: VIEW; Schema: public; Owner: vagrant
--

CREATE VIEW pokemons AS
 SELECT poke_base.id,
    poke_base.identifier AS name,
    types.identifier AS type,
    poke_base.height,
    poke_base.weight
   FROM (poke_base
     JOIN types ON ((poke_base.id = types.pokemon_id)))
  ORDER BY poke_base.id;


ALTER TABLE public.pokemons OWNER TO vagrant;

--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE users (
    user_id integer NOT NULL,
    email character varying(64),
    password character varying(64),
    first_name character varying(64),
    last_name character varying(64)
);


ALTER TABLE public.users OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: encounter_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY encounters ALTER COLUMN encounter_id SET DEFAULT nextval('encounters_encounter_id_seq'::regclass);


--
-- Name: location_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY gyms ALTER COLUMN location_id SET DEFAULT nextval('gyms_location_id_seq'::regclass);


--
-- Name: location_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY locations ALTER COLUMN location_id SET DEFAULT nextval('locations_location_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: encounters; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY encounters (encounter_id, latitude, pokemon_id, longitude) FROM stdin;
1	37.7849879999999985	13	-122.400979000000007
2	37.7841149999999999	19	-122.400426999999993
3	37.78416	41	-122.398883999999995
4	37.7828599999999994	133	-122.397441999999998
5	37.7816910000000021	41	-122.395854999999997
6	37.7809230000000014	54	-122.396632999999994
7	37.7791179999999969	135	-122.393389999999997
8	37.7781939999999992	35	-122.393469999999994
9	37.7774500000000018	118	-122.391695999999996
10	37.7788520000000005	54	-122.389962999999995
\.


--
-- Name: encounters_encounter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('encounters_encounter_id_seq', 1, false);


--
-- Data for Name: gyms; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY gyms (location_id, latitude, longitude, name) FROM stdin;
1	37.7848382000000029	-122.402670000000001	Yerba Buena Gardens Gym
\.


--
-- Name: gyms_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('gyms_location_id_seq', 1, true);


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY locations (location_id, latitude, longitude, rating, name, url, category) FROM stdin;
1	37.7844180000000023	-122.401628000000002	4	B Restaurant & Bar	https://www.yelp.com/biz/b-restaurant-and-bar-san-francisco	American (New)
2	37.7796554565429972	-122.395233154297003	4	Brickhouse Cafe	https://www.yelp.com/biz/brickhouse-cafe-san-francisco-2	American (Traditional)
3	37.7805747985839986	-122.396392822265994	4	Lava Lounge	https://www.yelp.com/biz/lava-lounge-san-francisco	Lounges
4	37.7798249454072987	-122.394355908036005	5	Local Tap	https://www.yelp.com/biz/local-tap-san-francisco	Sports Bars
5	37.7781856000000005	-122.392186899999999	3	Lucky Strike	https://www.yelp.com/biz/lucky-strike-san-francisco	Bowling
6	37.7798420000000021	-122.390213000000003	3	MoMo's	https://www.yelp.com/biz/momos-san-francisco	American (New)
7	37.7875149999999991	-122.398723000000004	4	Osha Thai	https://www.yelp.com/biz/osha-thai-san-francisco	Thai
8	37.7788279999999972	-122.394065999999995	4	Victory Hall & Parlor	https://www.yelp.com/biz/victory-hall-and-parlor-san-francisco	Comfort Food
9	37.7840836132872013	-122.398313338009999	5	Wine Down SF	https://www.yelp.com/biz/wine-down-sf-san-francisco	Wine Bars
\.


--
-- Name: locations_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('locations_location_id_seq', 9, true);


--
-- Data for Name: poke_base; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY poke_base (id, identifier, species_id, height, weight, base_experience, "order", is_default) FROM stdin;
1	bulbasaur	1	7	69	64	1	1
2	ivysaur	2	10	130	142	2	1
3	venusaur	3	20	1000	236	3	1
4	charmander	4	6	85	62	5	1
5	charmeleon	5	11	190	142	6	1
6	charizard	6	17	905	240	7	1
7	squirtle	7	5	90	63	10	1
8	wartortle	8	10	225	142	11	1
9	blastoise	9	16	855	239	12	1
10	caterpie	10	3	29	39	14	1
11	metapod	11	7	99	72	15	1
12	butterfree	12	11	320	178	16	1
13	weedle	13	3	32	39	17	1
14	kakuna	14	6	100	72	18	1
15	beedrill	15	10	295	178	19	1
16	pidgey	16	3	18	50	21	1
17	pidgeotto	17	11	300	122	22	1
18	pidgeot	18	15	395	216	23	1
19	rattata	19	3	35	51	25	1
20	raticate	20	7	185	145	26	1
21	spearow	21	3	20	52	27	1
22	fearow	22	12	380	155	28	1
23	ekans	23	20	69	58	29	1
24	arbok	24	35	650	153	30	1
25	pikachu	25	4	60	112	32	1
26	raichu	26	8	300	218	39	1
27	sandshrew	27	6	120	60	40	1
28	sandslash	28	10	295	158	41	1
29	nidoran-f	29	4	70	55	42	1
30	nidorina	30	8	200	128	43	1
31	nidoqueen	31	13	600	227	44	1
32	nidoran-m	32	5	90	55	45	1
33	nidorino	33	9	195	128	46	1
34	nidoking	34	14	620	227	47	1
35	clefairy	35	6	75	113	49	1
36	clefable	36	13	400	217	50	1
37	vulpix	37	6	99	60	51	1
38	ninetales	38	11	199	177	52	1
39	jigglypuff	39	5	55	95	54	1
40	wigglytuff	40	10	120	196	55	1
41	zubat	41	8	75	49	56	1
42	golbat	42	16	550	159	57	1
43	oddish	43	5	54	64	59	1
44	gloom	44	8	86	138	60	1
45	vileplume	45	12	186	221	61	1
46	paras	46	3	54	57	63	1
47	parasect	47	10	295	142	64	1
48	venonat	48	10	300	61	65	1
49	venomoth	49	15	125	158	66	1
50	diglett	50	2	8	53	67	1
51	dugtrio	51	7	333	142	68	1
52	meowth	52	4	42	58	69	1
53	persian	53	10	320	154	70	1
54	psyduck	54	8	196	64	71	1
55	golduck	55	17	766	175	72	1
56	mankey	56	5	280	61	73	1
57	primeape	57	10	320	159	74	1
58	growlithe	58	7	190	70	75	1
59	arcanine	59	19	1550	194	76	1
60	poliwag	60	6	124	60	77	1
61	poliwhirl	61	10	200	135	78	1
62	poliwrath	62	13	540	230	79	1
63	abra	63	9	195	62	81	1
64	kadabra	64	13	565	140	82	1
65	alakazam	65	15	480	225	83	1
66	machop	66	8	195	61	85	1
67	machoke	67	15	705	142	86	1
68	machamp	68	16	1300	227	87	1
69	bellsprout	69	7	40	60	88	1
70	weepinbell	70	10	64	137	89	1
71	victreebel	71	17	155	221	90	1
72	tentacool	72	9	455	67	91	1
73	tentacruel	73	16	550	180	92	1
74	geodude	74	4	200	60	93	1
75	graveler	75	10	1050	137	94	1
76	golem	76	14	3000	223	95	1
77	ponyta	77	10	300	82	96	1
78	rapidash	78	17	950	175	97	1
79	slowpoke	79	12	360	63	98	1
80	slowbro	80	16	785	172	99	1
81	magnemite	81	3	60	65	102	1
82	magneton	82	10	600	163	103	1
83	farfetchd	83	8	150	123	105	1
84	doduo	84	14	392	62	106	1
85	dodrio	85	18	852	161	107	1
86	seel	86	11	900	65	108	1
87	dewgong	87	17	1200	166	109	1
88	grimer	88	9	300	65	110	1
89	muk	89	12	300	175	111	1
90	shellder	90	3	40	61	112	1
91	cloyster	91	15	1325	184	113	1
92	gastly	92	13	1	62	114	1
93	haunter	93	16	1	142	115	1
94	gengar	94	15	405	225	116	1
95	onix	95	88	2100	77	118	1
96	drowzee	96	10	324	66	121	1
97	hypno	97	16	756	169	122	1
98	krabby	98	4	65	65	123	1
99	kingler	99	13	600	166	124	1
100	voltorb	100	5	104	66	125	1
101	electrode	101	12	666	168	126	1
102	exeggcute	102	4	25	65	127	1
103	exeggutor	103	20	1200	182	128	1
104	cubone	104	4	65	64	129	1
105	marowak	105	10	450	149	130	1
106	hitmonlee	106	15	498	159	132	1
107	hitmonchan	107	14	502	159	133	1
108	lickitung	108	12	655	77	135	1
109	koffing	109	6	10	68	137	1
110	weezing	110	12	95	172	138	1
111	rhyhorn	111	10	1150	69	139	1
112	rhydon	112	19	1200	170	140	1
113	chansey	113	11	346	395	143	1
114	tangela	114	10	350	87	145	1
115	kangaskhan	115	22	800	172	147	1
116	horsea	116	4	80	59	149	1
117	seadra	117	12	250	154	150	1
118	goldeen	118	6	150	64	152	1
119	seaking	119	13	390	158	153	1
120	staryu	120	8	345	68	154	1
121	starmie	121	11	800	182	155	1
122	mr-mime	122	13	545	161	157	1
123	scyther	123	15	560	100	158	1
124	jynx	124	14	406	159	162	1
125	electabuzz	125	11	300	172	164	1
126	magmar	126	13	445	173	167	1
127	pinsir	127	15	550	175	169	1
128	tauros	128	14	884	172	171	1
129	magikarp	129	9	100	40	172	1
130	gyarados	130	65	2350	189	173	1
131	lapras	131	25	2200	187	175	1
132	ditto	132	3	40	101	176	1
133	eevee	133	3	65	65	177	1
134	vaporeon	134	10	290	184	178	1
135	jolteon	135	8	245	184	179	1
136	flareon	136	9	250	184	180	1
137	porygon	137	8	365	79	186	1
138	omanyte	138	4	75	71	189	1
139	omastar	139	10	350	173	190	1
140	kabuto	140	5	115	71	191	1
141	kabutops	141	13	405	173	192	1
142	aerodactyl	142	18	590	180	193	1
143	snorlax	143	21	4600	189	196	1
144	articuno	144	17	554	261	197	1
145	zapdos	145	16	526	261	198	1
146	moltres	146	20	600	261	199	1
147	dratini	147	18	33	60	200	1
148	dragonair	148	40	165	147	201	1
149	dragonite	149	22	2100	270	202	1
150	mewtwo	150	20	1220	306	203	1
151	mew	151	4	40	270	206	1
152	chikorita	152	9	64	64	207	1
153	bayleef	153	12	158	142	208	1
154	meganium	154	18	1005	236	209	1
155	cyndaquil	155	5	79	62	210	1
156	quilava	156	9	190	142	211	1
157	typhlosion	157	17	795	240	212	1
158	totodile	158	6	95	63	213	1
159	croconaw	159	11	250	142	214	1
160	feraligatr	160	23	888	239	215	1
161	sentret	161	8	60	43	216	1
162	furret	162	18	325	145	217	1
163	hoothoot	163	7	212	52	218	1
164	noctowl	164	16	408	155	219	1
165	ledyba	165	10	108	53	220	1
166	ledian	166	14	356	137	221	1
167	spinarak	167	5	85	50	222	1
168	ariados	168	11	335	137	223	1
169	crobat	169	18	750	241	58	1
170	chinchou	170	5	120	66	224	1
171	lanturn	171	12	225	161	225	1
172	pichu	172	3	20	41	31	1
173	cleffa	173	3	30	44	48	1
174	igglybuff	174	3	10	42	53	1
175	togepi	175	3	15	49	226	1
176	togetic	176	6	32	142	227	1
177	natu	177	2	20	64	229	1
178	xatu	178	15	150	165	230	1
179	mareep	179	6	78	56	231	1
180	flaaffy	180	8	133	128	232	1
181	ampharos	181	14	615	230	233	1
182	bellossom	182	4	58	221	62	1
183	marill	183	4	85	88	236	1
184	azumarill	184	8	285	189	237	1
185	sudowoodo	185	12	380	144	239	1
186	politoed	186	11	339	225	80	1
187	hoppip	187	4	5	50	240	1
188	skiploom	188	6	10	119	241	1
189	jumpluff	189	8	30	207	242	1
190	aipom	190	8	115	72	243	1
191	sunkern	191	3	18	36	245	1
192	sunflora	192	8	85	149	246	1
193	yanma	193	12	380	78	247	1
194	wooper	194	4	85	42	249	1
195	quagsire	195	14	750	151	250	1
196	espeon	196	9	265	184	181	1
197	umbreon	197	10	270	184	182	1
198	murkrow	198	5	21	81	251	1
199	slowking	199	20	795	172	101	1
200	misdreavus	200	7	10	87	253	1
201	unown	201	5	50	118	255	1
202	wobbuffet	202	13	285	142	257	1
203	girafarig	203	15	415	159	258	1
204	pineco	204	6	72	58	259	1
205	forretress	205	12	1258	163	260	1
206	dunsparce	206	15	140	145	261	1
207	gligar	207	11	648	86	262	1
208	steelix	208	92	4000	179	119	1
209	snubbull	209	6	78	60	264	1
210	granbull	210	14	487	158	265	1
211	qwilfish	211	5	39	86	266	1
212	scizor	212	18	1180	175	159	1
213	shuckle	213	6	205	177	267	1
214	heracross	214	15	540	175	268	1
215	sneasel	215	9	280	86	270	1
216	teddiursa	216	6	88	66	272	1
217	ursaring	217	18	1258	175	273	1
218	slugma	218	7	350	50	274	1
219	magcargo	219	8	550	144	275	1
220	swinub	220	4	65	50	276	1
221	piloswine	221	11	558	158	277	1
222	corsola	222	6	50	133	279	1
223	remoraid	223	6	120	60	280	1
224	octillery	224	9	285	168	281	1
225	delibird	225	9	160	116	282	1
226	mantine	226	21	2200	163	284	1
227	skarmory	227	17	505	163	285	1
228	houndour	228	6	108	66	286	1
229	houndoom	229	14	350	175	287	1
230	kingdra	230	18	1520	243	151	1
231	phanpy	231	5	335	66	289	1
232	donphan	232	11	1200	175	290	1
233	porygon2	233	6	325	180	187	1
234	stantler	234	14	712	163	291	1
235	smeargle	235	12	580	88	292	1
236	tyrogue	236	7	210	42	131	1
237	hitmontop	237	14	480	159	134	1
238	smoochum	238	4	60	61	161	1
239	elekid	239	6	235	72	163	1
240	magby	240	7	214	73	166	1
241	miltank	241	12	755	172	293	1
242	blissey	242	15	468	608	144	1
243	raikou	243	19	1780	261	294	1
244	entei	244	21	1980	261	295	1
245	suicune	245	20	1870	261	296	1
246	larvitar	246	6	720	60	297	1
247	pupitar	247	12	1520	144	298	1
248	tyranitar	248	20	2020	270	299	1
249	lugia	249	52	2160	306	301	1
250	ho-oh	250	38	1990	306	302	1
251	celebi	251	6	50	270	303	1
252	treecko	252	5	50	62	304	1
253	grovyle	253	9	216	142	305	1
254	sceptile	254	17	522	239	306	1
255	torchic	255	4	25	62	308	1
256	combusken	256	9	195	142	309	1
257	blaziken	257	19	520	239	310	1
258	mudkip	258	4	76	62	312	1
259	marshtomp	259	7	280	142	313	1
260	swampert	260	15	819	241	314	1
261	poochyena	261	5	136	44	316	1
262	mightyena	262	10	370	147	317	1
263	zigzagoon	263	4	175	48	318	1
264	linoone	264	5	325	147	319	1
265	wurmple	265	3	36	39	320	1
266	silcoon	266	6	100	72	321	1
267	beautifly	267	10	284	178	322	1
268	cascoon	268	7	115	41	323	1
269	dustox	269	12	316	135	324	1
270	lotad	270	5	26	44	325	1
271	lombre	271	12	325	119	326	1
272	ludicolo	272	15	550	216	327	1
273	seedot	273	5	40	44	328	1
274	nuzleaf	274	10	280	119	329	1
275	shiftry	275	13	596	216	330	1
276	taillow	276	3	23	54	331	1
277	swellow	277	7	198	151	332	1
278	wingull	278	6	95	54	333	1
279	pelipper	279	12	280	151	334	1
280	ralts	280	4	66	40	335	1
281	kirlia	281	8	202	97	336	1
282	gardevoir	282	16	484	233	337	1
283	surskit	283	5	17	54	341	1
284	masquerain	284	8	36	145	342	1
285	shroomish	285	4	45	59	343	1
286	breloom	286	12	392	161	344	1
287	slakoth	287	8	240	56	345	1
288	vigoroth	288	14	465	154	346	1
289	slaking	289	20	1305	252	347	1
290	nincada	290	5	55	53	348	1
291	ninjask	291	8	120	160	349	1
292	shedinja	292	8	12	83	350	1
293	whismur	293	6	163	48	351	1
294	loudred	294	10	405	126	352	1
295	exploud	295	15	840	221	353	1
296	makuhita	296	10	864	47	354	1
297	hariyama	297	23	2538	166	355	1
298	azurill	298	2	20	38	235	1
299	nosepass	299	10	970	75	356	1
300	skitty	300	6	110	52	358	1
301	delcatty	301	11	326	133	359	1
302	sableye	302	5	110	133	360	1
303	mawile	303	6	115	133	362	1
304	aron	304	4	600	66	364	1
305	lairon	305	9	1200	151	365	1
306	aggron	306	21	3600	239	366	1
307	meditite	307	6	112	56	368	1
308	medicham	308	13	315	144	369	1
309	electrike	309	6	152	59	371	1
310	manectric	310	15	402	166	372	1
311	plusle	311	4	42	142	374	1
312	minun	312	4	42	142	375	1
313	volbeat	313	7	177	140	376	1
314	illumise	314	6	177	140	377	1
315	roselia	315	3	20	140	379	1
316	gulpin	316	4	103	60	381	1
317	swalot	317	17	800	163	382	1
318	carvanha	318	8	208	61	383	1
319	sharpedo	319	18	888	161	384	1
320	wailmer	320	20	1300	80	386	1
321	wailord	321	145	3980	175	387	1
322	numel	322	7	240	61	388	1
323	camerupt	323	19	2200	161	389	1
324	torkoal	324	5	804	165	391	1
325	spoink	325	7	306	66	392	1
326	grumpig	326	9	715	165	393	1
327	spinda	327	11	50	126	394	1
328	trapinch	328	7	150	58	395	1
329	vibrava	329	11	153	119	396	1
330	flygon	330	20	820	234	397	1
331	cacnea	331	4	513	67	398	1
332	cacturne	332	13	774	166	399	1
333	swablu	333	4	12	62	400	1
334	altaria	334	11	206	172	401	1
335	zangoose	335	13	403	160	403	1
336	seviper	336	27	525	160	404	1
337	lunatone	337	10	1680	154	405	1
338	solrock	338	12	1540	154	406	1
339	barboach	339	4	19	58	407	1
340	whiscash	340	9	236	164	408	1
341	corphish	341	6	115	62	409	1
342	crawdaunt	342	11	328	164	410	1
343	baltoy	343	5	215	60	411	1
344	claydol	344	15	1080	175	412	1
345	lileep	345	10	238	71	413	1
346	cradily	346	15	604	173	414	1
347	anorith	347	7	125	71	415	1
348	armaldo	348	15	682	173	416	1
349	feebas	349	6	74	40	417	1
350	milotic	350	62	1620	189	418	1
351	castform	351	3	8	147	419	1
352	kecleon	352	10	220	154	423	1
353	shuppet	353	6	23	59	424	1
354	banette	354	11	125	159	425	1
355	duskull	355	8	150	59	427	1
356	dusclops	356	16	306	159	428	1
357	tropius	357	20	1000	161	430	1
358	chimecho	358	6	10	149	432	1
359	absol	359	12	470	163	433	1
360	wynaut	360	6	140	52	256	1
361	snorunt	361	7	168	60	435	1
362	glalie	362	15	2565	168	436	1
363	spheal	363	8	395	58	439	1
364	sealeo	364	11	876	144	440	1
365	walrein	365	14	1506	239	441	1
366	clamperl	366	4	525	69	442	1
367	huntail	367	17	270	170	443	1
368	gorebyss	368	18	226	170	444	1
369	relicanth	369	10	234	170	445	1
370	luvdisc	370	6	87	116	446	1
371	bagon	371	6	421	60	447	1
372	shelgon	372	11	1105	147	448	1
373	salamence	373	15	1026	270	449	1
374	beldum	374	6	952	60	451	1
375	metang	375	12	2025	147	452	1
376	metagross	376	16	5500	270	453	1
377	regirock	377	17	2300	261	455	1
378	regice	378	18	1750	261	456	1
379	registeel	379	19	2050	261	457	1
380	latias	380	14	400	270	458	1
381	latios	381	20	600	270	460	1
382	kyogre	382	45	3520	302	462	1
383	groudon	383	35	9500	302	464	1
384	rayquaza	384	70	2065	306	466	1
385	jirachi	385	3	11	270	468	1
386	deoxys-normal	386	17	608	270	469	1
387	turtwig	387	4	102	64	473	1
388	grotle	388	11	970	142	474	1
389	torterra	389	22	3100	236	475	1
390	chimchar	390	5	62	62	476	1
391	monferno	391	9	220	142	477	1
392	infernape	392	12	550	240	478	1
393	piplup	393	4	52	63	479	1
394	prinplup	394	8	230	142	480	1
395	empoleon	395	17	845	239	481	1
396	starly	396	3	20	49	482	1
397	staravia	397	6	155	119	483	1
398	staraptor	398	12	249	218	484	1
399	bidoof	399	5	200	50	485	1
400	bibarel	400	10	315	144	486	1
401	kricketot	401	3	22	39	487	1
402	kricketune	402	10	255	134	488	1
403	shinx	403	5	95	53	489	1
404	luxio	404	9	305	127	490	1
405	luxray	405	14	420	235	491	1
406	budew	406	2	12	56	378	1
407	roserade	407	9	145	232	380	1
408	cranidos	408	9	315	70	492	1
409	rampardos	409	16	1025	173	493	1
410	shieldon	410	5	570	70	494	1
411	bastiodon	411	13	1495	173	495	1
412	burmy	412	2	34	45	496	1
413	wormadam-plant	413	5	65	148	497	1
414	mothim	414	9	233	148	500	1
415	combee	415	3	55	49	501	1
416	vespiquen	416	12	385	166	502	1
417	pachirisu	417	4	39	142	503	1
418	buizel	418	7	295	66	504	1
419	floatzel	419	11	335	173	505	1
420	cherubi	420	4	33	55	506	1
421	cherrim	421	5	93	158	507	1
422	shellos	422	3	63	65	508	1
423	gastrodon	423	9	299	166	509	1
424	ambipom	424	12	203	169	244	1
425	drifloon	425	4	12	70	510	1
426	drifblim	426	12	150	174	511	1
427	buneary	427	4	55	70	512	1
428	lopunny	428	12	333	168	513	1
429	mismagius	429	9	44	173	254	1
430	honchkrow	430	9	273	177	252	1
431	glameow	431	5	39	62	515	1
432	purugly	432	10	438	158	516	1
433	chingling	433	2	6	57	431	1
434	stunky	434	4	192	66	517	1
435	skuntank	435	10	380	168	518	1
436	bronzor	436	5	605	60	519	1
437	bronzong	437	13	1870	175	520	1
438	bonsly	438	5	150	58	238	1
439	mime-jr	439	6	130	62	156	1
440	happiny	440	6	244	110	142	1
441	chatot	441	5	19	144	521	1
442	spiritomb	442	10	1080	170	522	1
443	gible	443	7	205	60	523	1
444	gabite	444	14	560	144	524	1
445	garchomp	445	19	950	270	525	1
446	munchlax	446	6	1050	78	195	1
447	riolu	447	7	202	57	527	1
448	lucario	448	12	540	184	528	1
449	hippopotas	449	8	495	66	530	1
450	hippowdon	450	20	3000	184	531	1
451	skorupi	451	8	120	66	532	1
452	drapion	452	13	615	175	533	1
453	croagunk	453	7	230	60	534	1
454	toxicroak	454	13	444	172	535	1
455	carnivine	455	14	270	159	536	1
456	finneon	456	4	70	66	537	1
457	lumineon	457	12	240	161	538	1
458	mantyke	458	10	650	69	283	1
459	snover	459	10	505	67	539	1
460	abomasnow	460	22	1355	173	540	1
461	weavile	461	11	340	179	271	1
462	magnezone	462	12	1800	241	104	1
463	lickilicky	463	17	1400	180	136	1
464	rhyperior	464	24	2828	241	141	1
465	tangrowth	465	20	1286	187	146	1
466	electivire	466	18	1386	243	165	1
467	magmortar	467	16	680	243	168	1
468	togekiss	468	15	380	245	228	1
469	yanmega	469	19	515	180	248	1
470	leafeon	470	10	255	184	183	1
471	glaceon	471	8	259	184	184	1
472	gliscor	472	20	425	179	263	1
473	mamoswine	473	25	2910	239	278	1
474	porygon-z	474	9	340	241	188	1
475	gallade	475	16	520	233	339	1
476	probopass	476	14	3400	184	357	1
477	dusknoir	477	22	1066	236	429	1
478	froslass	478	13	266	168	438	1
479	rotom	479	3	3	154	542	1
480	uxie	480	3	3	261	548	1
481	mesprit	481	3	3	261	549	1
482	azelf	482	3	3	261	550	1
483	dialga	483	54	6830	306	551	1
484	palkia	484	42	3360	306	552	1
485	heatran	485	17	4300	270	553	1
486	regigigas	486	37	4200	302	554	1
487	giratina-altered	487	45	7500	306	555	1
488	cresselia	488	15	856	270	557	1
489	phione	489	4	31	216	558	1
490	manaphy	490	3	14	270	559	1
491	darkrai	491	15	505	270	560	1
492	shaymin-land	492	2	21	270	561	1
493	arceus	493	32	3200	324	563	1
494	victini	494	4	40	270	564	1
495	snivy	495	6	81	62	565	1
496	servine	496	8	160	145	566	1
497	serperior	497	33	630	238	567	1
498	tepig	498	5	99	62	568	1
499	pignite	499	10	555	146	569	1
500	emboar	500	16	1500	238	570	1
501	oshawott	501	5	59	62	571	1
502	dewott	502	8	245	145	572	1
503	samurott	503	15	946	238	573	1
504	patrat	504	5	116	51	574	1
505	watchog	505	11	270	147	575	1
506	lillipup	506	4	41	55	576	1
507	herdier	507	9	147	130	577	1
508	stoutland	508	12	610	225	578	1
509	purrloin	509	4	101	56	579	1
510	liepard	510	11	375	156	580	1
511	pansage	511	6	105	63	581	1
512	simisage	512	11	305	174	582	1
513	pansear	513	6	110	63	583	1
514	simisear	514	10	280	174	584	1
515	panpour	515	6	135	63	585	1
516	simipour	516	10	290	174	586	1
517	munna	517	6	233	58	587	1
518	musharna	518	11	605	170	588	1
519	pidove	519	3	21	53	589	1
520	tranquill	520	6	150	125	590	1
521	unfezant	521	12	290	220	591	1
522	blitzle	522	8	298	59	592	1
523	zebstrika	523	16	795	174	593	1
524	roggenrola	524	4	180	56	594	1
525	boldore	525	9	1020	137	595	1
526	gigalith	526	17	2600	232	596	1
527	woobat	527	4	21	63	597	1
528	swoobat	528	9	105	149	598	1
529	drilbur	529	3	85	66	599	1
530	excadrill	530	7	404	178	600	1
531	audino	531	11	310	390	601	1
532	timburr	532	6	125	61	603	1
533	gurdurr	533	12	400	142	604	1
534	conkeldurr	534	14	870	227	605	1
535	tympole	535	5	45	59	606	1
536	palpitoad	536	8	170	134	607	1
537	seismitoad	537	15	620	229	608	1
538	throh	538	13	555	163	609	1
539	sawk	539	14	510	163	610	1
540	sewaddle	540	3	25	62	611	1
541	swadloon	541	5	73	133	612	1
542	leavanny	542	12	205	225	613	1
543	venipede	543	4	53	52	614	1
544	whirlipede	544	12	585	126	615	1
545	scolipede	545	25	2005	218	616	1
546	cottonee	546	3	6	56	617	1
547	whimsicott	547	7	66	168	618	1
548	petilil	548	5	66	56	619	1
549	lilligant	549	11	163	168	620	1
550	basculin-red-striped	550	10	180	161	621	1
551	sandile	551	7	152	58	623	1
552	krokorok	552	10	334	123	624	1
553	krookodile	553	15	963	234	625	1
554	darumaka	554	6	375	63	626	1
555	darmanitan-standard	555	13	929	168	627	1
556	maractus	556	10	280	161	629	1
557	dwebble	557	3	145	65	630	1
558	crustle	558	14	2000	166	631	1
559	scraggy	559	6	118	70	632	1
560	scrafty	560	11	300	171	633	1
561	sigilyph	561	14	140	172	634	1
562	yamask	562	5	15	61	635	1
563	cofagrigus	563	17	765	169	636	1
564	tirtouga	564	7	165	71	637	1
565	carracosta	565	12	810	173	638	1
566	archen	566	5	95	71	639	1
567	archeops	567	14	320	177	640	1
568	trubbish	568	6	310	66	641	1
569	garbodor	569	19	1073	166	642	1
570	zorua	570	7	125	66	643	1
571	zoroark	571	16	811	179	644	1
572	minccino	572	4	58	60	645	1
573	cinccino	573	5	75	165	646	1
574	gothita	574	4	58	58	647	1
575	gothorita	575	7	180	137	648	1
576	gothitelle	576	15	440	221	649	1
577	solosis	577	3	10	58	650	1
578	duosion	578	6	80	130	651	1
579	reuniclus	579	10	201	221	652	1
580	ducklett	580	5	55	61	653	1
581	swanna	581	13	242	166	654	1
582	vanillite	582	4	57	61	655	1
583	vanillish	583	11	410	138	656	1
584	vanilluxe	584	13	575	241	657	1
585	deerling	585	6	195	67	658	1
586	sawsbuck	586	19	925	166	659	1
587	emolga	587	4	50	150	660	1
588	karrablast	588	5	59	63	661	1
589	escavalier	589	10	330	173	662	1
590	foongus	590	2	10	59	663	1
591	amoonguss	591	6	105	162	664	1
592	frillish	592	12	330	67	665	1
593	jellicent	593	22	1350	168	666	1
594	alomomola	594	12	316	165	667	1
595	joltik	595	1	6	64	668	1
596	galvantula	596	8	143	165	669	1
597	ferroseed	597	6	188	61	670	1
598	ferrothorn	598	10	1100	171	671	1
599	klink	599	3	210	60	672	1
600	klang	600	6	510	154	673	1
601	klinklang	601	6	810	234	674	1
602	tynamo	602	2	3	55	675	1
603	eelektrik	603	12	220	142	676	1
604	eelektross	604	21	805	232	677	1
605	elgyem	605	5	90	67	678	1
606	beheeyem	606	10	345	170	679	1
607	litwick	607	3	31	55	680	1
608	lampent	608	6	130	130	681	1
609	chandelure	609	10	343	234	682	1
610	axew	610	6	180	64	683	1
611	fraxure	611	10	360	144	684	1
612	haxorus	612	18	1055	243	685	1
613	cubchoo	613	5	85	61	686	1
614	beartic	614	26	2600	170	687	1
615	cryogonal	615	11	1480	170	688	1
616	shelmet	616	4	77	61	689	1
617	accelgor	617	8	253	173	690	1
618	stunfisk	618	7	110	165	691	1
619	mienfoo	619	9	200	70	692	1
620	mienshao	620	14	355	179	693	1
621	druddigon	621	16	1390	170	694	1
622	golett	622	10	920	61	695	1
623	golurk	623	28	3300	169	696	1
624	pawniard	624	5	102	68	697	1
625	bisharp	625	16	700	172	698	1
626	bouffalant	626	16	946	172	699	1
627	rufflet	627	5	105	70	700	1
628	braviary	628	15	410	179	701	1
629	vullaby	629	5	90	74	702	1
630	mandibuzz	630	12	395	179	703	1
631	heatmor	631	14	580	169	704	1
632	durant	632	3	330	169	705	1
633	deino	633	8	173	60	706	1
634	zweilous	634	14	500	147	707	1
635	hydreigon	635	18	1600	270	708	1
636	larvesta	636	11	288	72	709	1
637	volcarona	637	16	460	248	710	1
638	cobalion	638	21	2500	261	711	1
639	terrakion	639	19	2600	261	712	1
640	virizion	640	20	2000	261	713	1
641	tornadus-incarnate	641	15	630	261	714	1
642	thundurus-incarnate	642	15	610	261	716	1
643	reshiram	643	32	3300	306	718	1
644	zekrom	644	29	3450	306	719	1
645	landorus-incarnate	645	15	680	270	720	1
646	kyurem	646	30	3250	297	722	1
647	keldeo-ordinary	647	14	485	261	725	1
648	meloetta-aria	648	6	65	270	727	1
649	genesect	649	15	825	270	729	1
650	chespin	650	4	90	63	730	1
651	quilladin	651	7	290	142	731	1
652	chesnaught	652	16	900	239	732	1
653	fennekin	653	4	94	61	733	1
654	braixen	654	10	145	143	734	1
655	delphox	655	15	390	240	735	1
656	froakie	656	3	70	63	736	1
657	frogadier	657	6	109	142	737	1
658	greninja	658	15	400	239	738	1
659	bunnelby	659	4	50	47	739	1
660	diggersby	660	10	424	148	740	1
661	fletchling	661	3	17	56	741	1
662	fletchinder	662	7	160	134	742	1
663	talonflame	663	12	245	175	743	1
664	scatterbug	664	3	25	40	744	1
665	spewpa	665	3	84	75	745	1
666	vivillon	666	12	170	185	746	1
667	litleo	667	6	135	74	747	1
668	pyroar	668	15	815	177	748	1
669	flabebe	669	1	1	61	749	1
670	floette	670	2	9	130	750	1
671	florges	671	11	100	248	752	1
672	skiddo	672	9	310	70	753	1
673	gogoat	673	17	910	186	754	1
674	pancham	674	6	80	70	755	1
675	pangoro	675	21	1360	173	756	1
676	furfrou	676	12	280	165	757	1
677	espurr	677	3	35	71	758	1
678	meowstic-male	678	6	85	163	759	1
679	honedge	679	8	20	65	761	1
680	doublade	680	8	45	157	762	1
681	aegislash-shield	681	17	530	234	763	1
682	spritzee	682	2	5	68	765	1
683	aromatisse	683	8	155	162	766	1
684	swirlix	684	4	35	68	767	1
685	slurpuff	685	8	50	168	768	1
686	inkay	686	4	35	58	769	1
687	malamar	687	15	470	169	770	1
688	binacle	688	5	310	61	771	1
689	barbaracle	689	13	960	175	772	1
690	skrelp	690	5	73	64	773	1
691	dragalge	691	18	815	173	774	1
692	clauncher	692	5	83	66	775	1
693	clawitzer	693	13	353	100	776	1
694	helioptile	694	5	60	58	777	1
695	heliolisk	695	10	210	168	778	1
696	tyrunt	696	8	260	72	779	1
697	tyrantrum	697	25	2700	182	780	1
698	amaura	698	13	252	72	781	1
699	aurorus	699	27	2250	104	782	1
700	sylveon	700	10	235	184	185	1
701	hawlucha	701	8	215	175	783	1
702	dedenne	702	2	22	151	784	1
703	carbink	703	3	57	100	785	1
704	goomy	704	3	28	60	786	1
705	sliggoo	705	8	175	158	787	1
706	goodra	706	20	1505	270	788	1
707	klefki	707	2	30	165	789	1
708	phantump	708	4	70	62	790	1
709	trevenant	709	15	710	166	791	1
710	pumpkaboo-average	710	4	50	67	793	1
711	gourgeist-average	711	9	125	173	797	1
712	bergmite	712	10	995	61	800	1
713	avalugg	713	20	5050	180	801	1
714	noibat	714	5	80	49	802	1
715	noivern	715	15	850	187	803	1
716	xerneas	716	30	2150	306	804	1
717	yveltal	717	58	2030	306	805	1
718	zygarde	718	50	3050	270	806	1
719	diancie	719	7	88	270	807	1
720	hoopa	720	5	90	270	809	1
721	volcanion	721	17	1950	270	811	1
10001	deoxys-attack	386	17	608	270	470	0
10002	deoxys-defense	386	17	608	270	471	0
10003	deoxys-speed	386	17	608	270	472	0
10004	wormadam-sandy	413	5	65	148	498	0
10005	wormadam-trash	413	5	65	148	499	0
10006	shaymin-sky	492	4	52	270	562	0
10007	giratina-origin	487	69	6500	306	556	0
10008	rotom-heat	479	3	3	182	543	0
10009	rotom-wash	479	3	3	182	544	0
10010	rotom-frost	479	3	3	182	545	0
10011	rotom-fan	479	3	3	182	546	0
10012	rotom-mow	479	3	3	182	547	0
10013	castform-sunny	351	3	8	147	420	0
10014	castform-rainy	351	3	8	147	421	0
10015	castform-snowy	351	3	8	147	422	0
10016	basculin-blue-striped	550	10	180	161	622	0
10017	darmanitan-zen	555	13	929	189	628	0
10018	meloetta-pirouette	648	6	65	270	728	0
10019	tornadus-therian	641	14	630	261	715	0
10020	thundurus-therian	642	30	610	261	717	0
10021	landorus-therian	645	13	680	270	721	0
10022	kyurem-black	646	33	3250	315	723	0
10023	kyurem-white	646	36	3250	315	724	0
10024	keldeo-resolute	647	14	485	261	726	0
10025	meowstic-female	678	6	85	163	760	0
10026	aegislash-blade	681	17	530	234	764	0
10027	pumpkaboo-small	710	3	35	67	792	0
10028	pumpkaboo-large	710	5	75	67	794	0
10029	pumpkaboo-super	710	8	150	67	795	0
10030	gourgeist-small	711	7	95	173	796	0
10031	gourgeist-large	711	11	140	173	798	0
10032	gourgeist-super	711	17	390	173	799	0
10033	venusaur-mega	3	24	1555	281	4	0
10034	charizard-mega-x	6	17	1105	285	8	0
10035	charizard-mega-y	6	17	1005	285	9	0
10036	blastoise-mega	9	16	1011	284	13	0
10037	alakazam-mega	65	12	480	266	84	0
10038	gengar-mega	94	14	405	270	117	0
10039	kangaskhan-mega	115	22	1000	207	148	0
10040	pinsir-mega	127	17	590	210	170	0
10041	gyarados-mega	130	65	3050	224	174	0
10042	aerodactyl-mega	142	21	790	215	194	0
10043	mewtwo-mega-x	150	23	1270	351	204	0
10044	mewtwo-mega-y	150	15	330	351	205	0
10045	ampharos-mega	181	14	615	275	234	0
10046	scizor-mega	212	20	1250	210	160	0
10047	heracross-mega	214	17	625	210	269	0
10048	houndoom-mega	229	19	495	210	288	0
10049	tyranitar-mega	248	25	2550	315	300	0
10050	blaziken-mega	257	19	520	284	311	0
10051	gardevoir-mega	282	16	484	278	338	0
10052	mawile-mega	303	10	235	168	363	0
10053	aggron-mega	306	22	3950	284	367	0
10054	medicham-mega	308	13	315	179	370	0
10055	manectric-mega	310	18	440	201	373	0
10056	banette-mega	354	12	130	194	426	0
10057	absol-mega	359	12	490	198	434	0
10058	garchomp-mega	445	19	950	315	526	0
10059	lucario-mega	448	13	575	219	529	0
10060	abomasnow-mega	460	27	1850	208	541	0
10061	floette-eternal	670	2	9	243	751	0
10062	latias-mega	380	18	520	315	459	0
10063	latios-mega	381	23	700	315	461	0
10064	swampert-mega	260	19	1020	286	315	0
10065	sceptile-mega	254	19	552	284	307	0
10066	sableye-mega	302	5	1610	168	361	0
10067	altaria-mega	334	15	206	207	402	0
10068	gallade-mega	475	16	564	278	340	0
10069	audino-mega	531	15	320	425	602	0
10070	sharpedo-mega	319	25	1303	196	385	0
10071	slowbro-mega	80	20	1200	207	100	0
10072	steelix-mega	208	105	7400	214	120	0
10073	pidgeot-mega	18	22	505	261	24	0
10074	glalie-mega	362	21	3502	203	437	0
10075	diancie-mega	719	11	278	315	808	0
10076	metagross-mega	376	25	9429	315	454	0
10077	kyogre-primal	382	98	4300	347	463	0
10078	groudon-primal	383	50	9997	347	465	0
10079	rayquaza-mega	384	108	3920	351	467	0
10080	pikachu-rock-star	25	40	60	112	34	0
10081	pikachu-belle	25	40	60	112	35	0
10082	pikachu-pop-star	25	40	60	112	36	0
10083	pikachu-phd	25	40	60	112	37	0
10084	pikachu-libre	25	40	60	112	38	0
10085	pikachu-cosplay	25	40	60	112	33	0
10086	hoopa-unbound	720	65	4900	306	810	0
10087	camerupt-mega	323	25	3205	196	390	0
10088	lopunny-mega	428	13	283	203	514	0
10089	salamence-mega	373	18	1126	315	450	0
10090	beedrill-mega	15	14	405	223	20	0
\.


--
-- Data for Name: poke_types; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY poke_types (pokemon_id, type_id, slot) FROM stdin;
1	12	1
1	4	2
2	12	1
2	4	2
3	12	1
3	4	2
4	10	1
5	10	1
6	10	1
6	3	2
7	11	1
8	11	1
9	11	1
10	7	1
11	7	1
12	7	1
12	3	2
13	7	1
13	4	2
14	7	1
14	4	2
15	7	1
15	4	2
16	1	1
16	3	2
17	1	1
17	3	2
18	1	1
18	3	2
19	1	1
20	1	1
21	1	1
21	3	2
22	1	1
22	3	2
23	4	1
24	4	1
25	13	1
26	13	1
27	5	1
28	5	1
29	4	1
30	4	1
31	4	1
31	5	2
32	4	1
33	4	1
34	4	1
34	5	2
35	18	1
36	18	1
37	10	1
38	10	1
39	1	1
39	18	2
40	1	1
40	18	2
41	4	1
41	3	2
42	4	1
42	3	2
43	12	1
43	4	2
44	12	1
44	4	2
45	12	1
45	4	2
46	7	1
46	12	2
47	7	1
47	12	2
48	7	1
48	4	2
49	7	1
49	4	2
50	5	1
51	5	1
52	1	1
53	1	1
54	11	1
55	11	1
56	2	1
57	2	1
58	10	1
59	10	1
60	11	1
61	11	1
62	11	1
62	2	2
63	14	1
64	14	1
65	14	1
66	2	1
67	2	1
68	2	1
69	12	1
69	4	2
70	12	1
70	4	2
71	12	1
71	4	2
72	11	1
72	4	2
73	11	1
73	4	2
74	6	1
74	5	2
75	6	1
75	5	2
76	6	1
76	5	2
77	10	1
78	10	1
79	11	1
79	14	2
80	11	1
80	14	2
81	13	1
81	9	2
82	13	1
82	9	2
83	1	1
83	3	2
84	1	1
84	3	2
85	1	1
85	3	2
86	11	1
87	11	1
87	15	2
88	4	1
89	4	1
90	11	1
91	11	1
91	15	2
92	8	1
92	4	2
93	8	1
93	4	2
94	8	1
94	4	2
95	6	1
95	5	2
96	14	1
97	14	1
98	11	1
99	11	1
100	13	1
101	13	1
102	12	1
102	14	2
103	12	1
103	14	2
104	5	1
105	5	1
106	2	1
107	2	1
108	1	1
109	4	1
110	4	1
111	5	1
111	6	2
112	5	1
112	6	2
113	1	1
114	12	1
115	1	1
116	11	1
117	11	1
118	11	1
119	11	1
120	11	1
121	11	1
121	14	2
122	14	1
122	18	2
123	7	1
123	3	2
124	15	1
124	14	2
125	13	1
126	10	1
127	7	1
128	1	1
129	11	1
130	11	1
130	3	2
131	11	1
131	15	2
132	1	1
133	1	1
134	11	1
135	13	1
136	10	1
137	1	1
138	6	1
138	11	2
139	6	1
139	11	2
140	6	1
140	11	2
141	6	1
141	11	2
142	6	1
142	3	2
143	1	1
144	15	1
144	3	2
145	13	1
145	3	2
146	10	1
146	3	2
147	16	1
148	16	1
149	16	1
149	3	2
150	14	1
151	14	1
152	12	1
153	12	1
154	12	1
155	10	1
156	10	1
157	10	1
158	11	1
159	11	1
160	11	1
161	1	1
162	1	1
163	1	1
163	3	2
164	1	1
164	3	2
165	7	1
165	3	2
166	7	1
166	3	2
167	7	1
167	4	2
168	7	1
168	4	2
169	4	1
169	3	2
170	11	1
170	13	2
171	11	1
171	13	2
172	13	1
173	18	1
174	1	1
174	18	2
175	18	1
176	18	1
176	3	2
177	14	1
177	3	2
178	14	1
178	3	2
179	13	1
180	13	1
181	13	1
182	12	1
183	11	1
183	18	2
184	11	1
184	18	2
185	6	1
186	11	1
187	12	1
187	3	2
188	12	1
188	3	2
189	12	1
189	3	2
190	1	1
191	12	1
192	12	1
193	7	1
193	3	2
194	11	1
194	5	2
195	11	1
195	5	2
196	14	1
197	17	1
198	17	1
198	3	2
199	11	1
199	14	2
200	8	1
201	14	1
202	14	1
203	1	1
203	14	2
204	7	1
205	7	1
205	9	2
206	1	1
207	5	1
207	3	2
208	9	1
208	5	2
209	18	1
210	18	1
211	11	1
211	4	2
212	7	1
212	9	2
213	7	1
213	6	2
214	7	1
214	2	2
215	17	1
215	15	2
216	1	1
217	1	1
218	10	1
219	10	1
219	6	2
220	15	1
220	5	2
221	15	1
221	5	2
222	11	1
222	6	2
223	11	1
224	11	1
225	15	1
225	3	2
226	11	1
226	3	2
227	9	1
227	3	2
228	17	1
228	10	2
229	17	1
229	10	2
230	11	1
230	16	2
231	5	1
232	5	1
233	1	1
234	1	1
235	1	1
236	2	1
237	2	1
238	15	1
238	14	2
239	13	1
240	10	1
241	1	1
242	1	1
243	13	1
244	10	1
245	11	1
246	6	1
246	5	2
247	6	1
247	5	2
248	6	1
248	17	2
249	14	1
249	3	2
250	10	1
250	3	2
251	14	1
251	12	2
252	12	1
253	12	1
254	12	1
255	10	1
256	10	1
256	2	2
257	10	1
257	2	2
258	11	1
259	11	1
259	5	2
260	11	1
260	5	2
261	17	1
262	17	1
263	1	1
264	1	1
265	7	1
266	7	1
267	7	1
267	3	2
268	7	1
269	7	1
269	4	2
270	11	1
270	12	2
271	11	1
271	12	2
272	11	1
272	12	2
273	12	1
274	12	1
274	17	2
275	12	1
275	17	2
276	1	1
276	3	2
277	1	1
277	3	2
278	11	1
278	3	2
279	11	1
279	3	2
280	14	1
280	18	2
281	14	1
281	18	2
282	14	1
282	18	2
283	7	1
283	11	2
284	7	1
284	3	2
285	12	1
286	12	1
286	2	2
287	1	1
288	1	1
289	1	1
290	7	1
290	5	2
291	7	1
291	3	2
292	7	1
292	8	2
293	1	1
294	1	1
295	1	1
296	2	1
297	2	1
298	1	1
298	18	2
299	6	1
300	1	1
301	1	1
302	17	1
302	8	2
303	9	1
303	18	2
304	9	1
304	6	2
305	9	1
305	6	2
306	9	1
306	6	2
307	2	1
307	14	2
308	2	1
308	14	2
309	13	1
310	13	1
311	13	1
312	13	1
313	7	1
314	7	1
315	12	1
315	4	2
316	4	1
317	4	1
318	11	1
318	17	2
319	11	1
319	17	2
320	11	1
321	11	1
322	10	1
322	5	2
323	10	1
323	5	2
324	10	1
325	14	1
326	14	1
327	1	1
328	5	1
329	5	1
329	16	2
330	5	1
330	16	2
331	12	1
332	12	1
332	17	2
333	1	1
333	3	2
334	16	1
334	3	2
335	1	1
336	4	1
337	6	1
337	14	2
338	6	1
338	14	2
339	11	1
339	5	2
340	11	1
340	5	2
341	11	1
342	11	1
342	17	2
343	5	1
343	14	2
344	5	1
344	14	2
345	6	1
345	12	2
346	6	1
346	12	2
347	6	1
347	7	2
348	6	1
348	7	2
349	11	1
350	11	1
351	1	1
352	1	1
353	8	1
354	8	1
355	8	1
356	8	1
357	12	1
357	3	2
358	14	1
359	17	1
360	14	1
361	15	1
362	15	1
363	15	1
363	11	2
364	15	1
364	11	2
365	15	1
365	11	2
366	11	1
367	11	1
368	11	1
369	11	1
369	6	2
370	11	1
371	16	1
372	16	1
373	16	1
373	3	2
374	9	1
374	14	2
375	9	1
375	14	2
376	9	1
376	14	2
377	6	1
378	15	1
379	9	1
380	16	1
380	14	2
381	16	1
381	14	2
382	11	1
383	5	1
384	16	1
384	3	2
385	9	1
385	14	2
386	14	1
387	12	1
388	12	1
389	12	1
389	5	2
390	10	1
391	10	1
391	2	2
392	10	1
392	2	2
393	11	1
394	11	1
395	11	1
395	9	2
396	1	1
396	3	2
397	1	1
397	3	2
398	1	1
398	3	2
399	1	1
400	1	1
400	11	2
401	7	1
402	7	1
403	13	1
404	13	1
405	13	1
406	12	1
406	4	2
407	12	1
407	4	2
408	6	1
409	6	1
410	6	1
410	9	2
411	6	1
411	9	2
412	7	1
413	7	1
413	12	2
414	7	1
414	3	2
415	7	1
415	3	2
416	7	1
416	3	2
417	13	1
418	11	1
419	11	1
420	12	1
421	12	1
422	11	1
423	11	1
423	5	2
424	1	1
425	8	1
425	3	2
426	8	1
426	3	2
427	1	1
428	1	1
429	8	1
430	17	1
430	3	2
431	1	1
432	1	1
433	14	1
434	4	1
434	17	2
435	4	1
435	17	2
436	9	1
436	14	2
437	9	1
437	14	2
438	6	1
439	14	1
439	18	2
440	1	1
441	1	1
441	3	2
442	8	1
442	17	2
443	16	1
443	5	2
444	16	1
444	5	2
445	16	1
445	5	2
446	1	1
447	2	1
448	2	1
448	9	2
449	5	1
450	5	1
451	4	1
451	7	2
452	4	1
452	17	2
453	4	1
453	2	2
454	4	1
454	2	2
455	12	1
456	11	1
457	11	1
458	11	1
458	3	2
459	12	1
459	15	2
460	12	1
460	15	2
461	17	1
461	15	2
462	13	1
462	9	2
463	1	1
464	5	1
464	6	2
465	12	1
466	13	1
467	10	1
468	18	1
468	3	2
469	7	1
469	3	2
470	12	1
471	15	1
472	5	1
472	3	2
473	15	1
473	5	2
474	1	1
475	14	1
475	2	2
476	6	1
476	9	2
477	8	1
478	15	1
478	8	2
479	13	1
479	8	2
480	14	1
481	14	1
482	14	1
483	9	1
483	16	2
484	11	1
484	16	2
485	10	1
485	9	2
486	1	1
487	8	1
487	16	2
488	14	1
489	11	1
490	11	1
491	17	1
492	12	1
493	1	1
494	14	1
494	10	2
495	12	1
496	12	1
497	12	1
498	10	1
499	10	1
499	2	2
500	10	1
500	2	2
501	11	1
502	11	1
503	11	1
504	1	1
505	1	1
506	1	1
507	1	1
508	1	1
509	17	1
510	17	1
511	12	1
512	12	1
513	10	1
514	10	1
515	11	1
516	11	1
517	14	1
518	14	1
519	1	1
519	3	2
520	1	1
520	3	2
521	1	1
521	3	2
522	13	1
523	13	1
524	6	1
525	6	1
526	6	1
527	14	1
527	3	2
528	14	1
528	3	2
529	5	1
530	5	1
530	9	2
531	1	1
532	2	1
533	2	1
534	2	1
535	11	1
536	11	1
536	5	2
537	11	1
537	5	2
538	2	1
539	2	1
540	7	1
540	12	2
541	7	1
541	12	2
542	7	1
542	12	2
543	7	1
543	4	2
544	7	1
544	4	2
545	7	1
545	4	2
546	12	1
546	18	2
547	12	1
547	18	2
548	12	1
549	12	1
550	11	1
551	5	1
551	17	2
552	5	1
552	17	2
553	5	1
553	17	2
554	10	1
555	10	1
556	12	1
557	7	1
557	6	2
558	7	1
558	6	2
559	17	1
559	2	2
560	17	1
560	2	2
561	14	1
561	3	2
562	8	1
563	8	1
564	11	1
564	6	2
565	11	1
565	6	2
566	6	1
566	3	2
567	6	1
567	3	2
568	4	1
569	4	1
570	17	1
571	17	1
572	1	1
573	1	1
574	14	1
575	14	1
576	14	1
577	14	1
578	14	1
579	14	1
580	11	1
580	3	2
581	11	1
581	3	2
582	15	1
583	15	1
584	15	1
585	1	1
585	12	2
586	1	1
586	12	2
587	13	1
587	3	2
588	7	1
589	7	1
589	9	2
590	12	1
590	4	2
591	12	1
591	4	2
592	11	1
592	8	2
593	11	1
593	8	2
594	11	1
595	7	1
595	13	2
596	7	1
596	13	2
597	12	1
597	9	2
598	12	1
598	9	2
599	9	1
600	9	1
601	9	1
602	13	1
603	13	1
604	13	1
605	14	1
606	14	1
607	8	1
607	10	2
608	8	1
608	10	2
609	8	1
609	10	2
610	16	1
611	16	1
612	16	1
613	15	1
614	15	1
615	15	1
616	7	1
617	7	1
618	5	1
618	13	2
619	2	1
620	2	1
621	16	1
622	5	1
622	8	2
623	5	1
623	8	2
624	17	1
624	9	2
625	17	1
625	9	2
626	1	1
627	1	1
627	3	2
628	1	1
628	3	2
629	17	1
629	3	2
630	17	1
630	3	2
631	10	1
632	7	1
632	9	2
633	17	1
633	16	2
634	17	1
634	16	2
635	17	1
635	16	2
636	7	1
636	10	2
637	7	1
637	10	2
638	9	1
638	2	2
639	6	1
639	2	2
640	12	1
640	2	2
641	3	1
642	13	1
642	3	2
643	16	1
643	10	2
644	16	1
644	13	2
645	5	1
645	3	2
646	16	1
646	15	2
647	11	1
647	2	2
648	1	1
648	14	2
649	7	1
649	9	2
650	12	1
651	12	1
652	12	1
652	2	2
653	10	1
654	10	1
655	10	1
655	14	2
656	11	1
657	11	1
658	11	1
658	17	2
659	1	1
660	1	1
660	5	2
661	1	1
661	3	2
662	10	1
662	3	2
663	10	1
663	3	2
664	7	1
665	7	1
666	7	1
666	3	2
667	10	1
667	1	2
668	10	1
668	1	2
669	18	1
670	18	1
671	18	1
672	12	1
673	12	1
674	2	1
675	2	1
675	17	2
676	1	1
677	14	1
678	14	1
679	9	1
679	8	2
680	9	1
680	8	2
681	9	1
681	8	2
682	18	1
683	18	1
684	18	1
685	18	1
686	17	1
686	14	2
687	17	1
687	14	2
688	6	1
688	11	2
689	6	1
689	11	2
690	4	1
690	11	2
691	4	1
691	16	2
692	11	1
693	11	1
694	13	1
694	1	2
695	13	1
695	1	2
696	6	1
696	16	2
697	6	1
697	16	2
698	6	1
698	15	2
699	6	1
699	15	2
700	18	1
701	2	1
701	3	2
702	13	1
702	18	2
703	6	1
703	18	2
704	16	1
705	16	1
706	16	1
707	9	1
707	18	2
708	8	1
708	12	2
709	8	1
709	12	2
710	8	1
710	12	2
711	8	1
711	12	2
712	15	1
713	15	1
714	3	1
714	16	2
715	3	1
715	16	2
716	18	1
717	17	1
717	3	2
718	16	1
718	5	2
719	6	1
719	18	2
720	14	1
720	8	2
721	10	1
721	11	2
10001	14	1
10002	14	1
10003	14	1
10004	7	1
10004	5	2
10005	7	1
10005	9	2
10006	12	1
10006	3	2
10007	8	1
10007	16	2
10008	13	1
10008	10	2
10009	13	1
10009	11	2
10010	13	1
10010	15	2
10011	13	1
10011	3	2
10012	13	1
10012	12	2
10013	10	1
10014	11	1
10015	15	1
10016	11	1
10017	10	1
10017	14	2
10018	1	1
10018	2	2
10019	3	1
10020	13	1
10020	3	2
10021	5	1
10021	3	2
10022	16	1
10022	15	2
10023	16	1
10023	15	2
10024	11	1
10024	2	2
10025	14	1
10026	9	1
10026	8	2
10027	8	1
10027	12	2
10028	8	1
10028	12	2
10029	8	1
10029	12	2
10030	8	1
10030	12	2
10031	8	1
10031	12	2
10032	8	1
10032	12	2
10033	12	1
10033	4	2
10034	10	1
10034	16	2
10035	10	1
10035	3	2
10036	11	1
10037	14	1
10038	8	1
10038	4	2
10039	1	1
10040	7	1
10040	3	2
10041	11	1
10041	17	2
10042	6	1
10042	3	2
10043	14	1
10043	2	2
10044	14	1
10045	13	1
10045	16	2
10046	7	1
10046	9	2
10047	7	1
10047	2	2
10048	17	1
10048	10	2
10049	6	1
10049	17	2
10050	10	1
10050	2	2
10051	14	1
10051	18	2
10052	9	1
10052	18	2
10053	9	1
10054	2	1
10054	14	2
10055	13	1
10056	8	1
10057	17	1
10058	16	1
10058	5	2
10059	2	1
10059	9	2
10060	12	1
10060	15	2
10061	18	1
10062	16	1
10062	14	2
10063	16	1
10063	14	2
10064	11	1
10064	5	2
10065	12	1
10065	16	2
10066	17	1
10066	8	2
10067	16	1
10067	18	2
10068	14	1
10068	2	2
10069	1	1
10069	18	2
10070	11	1
10070	17	2
10071	11	1
10071	14	2
10072	9	1
10072	5	2
10073	1	1
10073	3	2
10074	15	1
10075	6	1
10075	18	2
10076	9	1
10076	14	2
10077	11	1
10078	5	1
10078	10	2
10079	16	1
10079	3	2
10080	13	1
10081	13	1
10082	13	1
10083	13	1
10084	13	1
10085	13	1
10086	14	1
10086	17	2
10087	10	1
10087	5	2
10088	1	1
10088	2	2
10089	16	1
10089	3	2
10090	7	1
10090	4	2
\.


--
-- Data for Name: types_base; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY types_base (id, identifier, generation_id, damage_class_id) FROM stdin;
1	normal	1	2
2	fighting	1	2
3	flying	1	2
4	poison	1	2
5	ground	1	2
6	rock	1	2
7	bug	1	2
8	ghost	1	2
9	steel	2	2
10	fire	1	3
11	water	1	3
12	grass	1	3
13	electric	1	3
14	psychic	1	3
15	ice	1	3
16	dragon	1	3
17	dark	2	3
18	fairy	6	\N
10001	unknown	2	\N
10002	shadow	3	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (user_id, email, password, first_name, last_name) FROM stdin;
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_user_id_seq', 1, false);


--
-- Name: encounters_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY encounters
    ADD CONSTRAINT encounters_pkey PRIMARY KEY (encounter_id);


--
-- Name: gyms_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY gyms
    ADD CONSTRAINT gyms_pkey PRIMARY KEY (location_id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (location_id);


--
-- Name: poke_base_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY poke_base
    ADD CONSTRAINT poke_base_pkey PRIMARY KEY (id);


--
-- Name: types_base_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY types_base
    ADD CONSTRAINT types_base_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: poke_types_pokemon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY poke_types
    ADD CONSTRAINT poke_types_pokemon_id_fkey FOREIGN KEY (pokemon_id) REFERENCES poke_base(id);


--
-- Name: poke_types_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY poke_types
    ADD CONSTRAINT poke_types_type_id_fkey FOREIGN KEY (type_id) REFERENCES types_base(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

