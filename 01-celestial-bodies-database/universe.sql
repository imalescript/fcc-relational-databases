--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: anomaly; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.anomaly (
    anomaly_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.anomaly OWNER TO freecodecamp;

--
-- Name: anomaly_anomaly_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.anomaly_anomaly_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.anomaly_anomaly_id_seq OWNER TO freecodecamp;

--
-- Name: anomaly_anomaly_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.anomaly_anomaly_id_seq OWNED BY public.anomaly.anomaly_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(255) NOT NULL,
    distance_from_earth numeric NOT NULL,
    has_life boolean NOT NULL,
    madness_level integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(255) NOT NULL,
    is_cursed boolean NOT NULL,
    orbital_period_days integer,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(255) NOT NULL,
    has_cult boolean NOT NULL,
    planet_type character varying(100),
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(255) NOT NULL,
    is_dormant boolean NOT NULL,
    age_in_millions_of_years integer,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: anomaly anomaly_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.anomaly ALTER COLUMN anomaly_id SET DEFAULT nextval('public.anomaly_anomaly_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: anomaly; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.anomaly VALUES (1, 'Euclidean Distortion', 'Space bends at impossible angles, driving observers mad.');
INSERT INTO public.anomaly VALUES (2, 'Whisper Resonance', 'Background radiation sounds like ancient, forbidden tongues.');
INSERT INTO public.anomaly VALUES (3, 'Abyssal Rift', 'A tear in the fabric of space leaking dark matter.');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Void-of-Rlyeh', 1000.5, true, 99);
INSERT INTO public.galaxy VALUES (2, 'End-of-Reason', 2500.0, false, 80);
INSERT INTO public.galaxy VALUES (3, 'Dark Helix', 5000.75, true, 85);
INSERT INTO public.galaxy VALUES (4, 'Azathoth-Dream', 10000.1, false, 100);
INSERT INTO public.galaxy VALUES (5, 'Nyarlathotep-Web', 3333.3, true, 90);
INSERT INTO public.galaxy VALUES (6, 'Forgotten Cosmos', 9999.9, false, 50);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Whispering-Orb', true, 30, 1);
INSERT INTO public.moon VALUES (2, 'Black-Mirror', true, 15, 1);
INSERT INTO public.moon VALUES (3, 'Echo-Moon', false, 45, 2);
INSERT INTO public.moon VALUES (4, 'Screaming-Shard', true, 10, 2);
INSERT INTO public.moon VALUES (5, 'Silent-Tear', false, 20, 3);
INSERT INTO public.moon VALUES (6, 'Bleak-Satellite', true, 25, 3);
INSERT INTO public.moon VALUES (7, 'Madness-Rock', true, 18, 4);
INSERT INTO public.moon VALUES (8, 'Pale-Watcher', false, 60, 4);
INSERT INTO public.moon VALUES (9, 'Crimson-Eye', true, 33, 5);
INSERT INTO public.moon VALUES (10, 'Void-Stone', true, 12, 5);
INSERT INTO public.moon VALUES (11, 'Forgotten-Dust', false, 50, 6);
INSERT INTO public.moon VALUES (12, 'Abyssal-Fragment', true, 22, 6);
INSERT INTO public.moon VALUES (13, 'Drowned-Moon', true, 28, 7);
INSERT INTO public.moon VALUES (14, 'Sunken-Rock', false, 40, 7);
INSERT INTO public.moon VALUES (15, 'Rotting-Orb', true, 14, 8);
INSERT INTO public.moon VALUES (16, 'Flesh-Moon', true, 16, 8);
INSERT INTO public.moon VALUES (17, 'Bone-Satellite', false, 11, 9);
INSERT INTO public.moon VALUES (18, 'Cursed-Pebble', true, 9, 9);
INSERT INTO public.moon VALUES (19, 'Torn-Fragment', true, 35, 10);
INSERT INTO public.moon VALUES (20, 'Lost-Sphere', false, 42, 10);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Yuggoth-Prime', true, 'Ice Rock', 1);
INSERT INTO public.planet VALUES (2, 'Yuggoth-Secundus', false, 'Gas Giant', 1);
INSERT INTO public.planet VALUES (3, 'Kadath-4', true, 'Barren', 2);
INSERT INTO public.planet VALUES (4, 'Kadath-5', false, 'Toxic', 2);
INSERT INTO public.planet VALUES (5, 'Carcosa-Alpha', true, 'Desert', 3);
INSERT INTO public.planet VALUES (6, 'Carcosa-Beta', true, 'Desert', 3);
INSERT INTO public.planet VALUES (7, 'Leng-Plateau-World', false, 'Frozen', 4);
INSERT INTO public.planet VALUES (8, 'Innsmouth-Sphere', true, 'Oceanic', 4);
INSERT INTO public.planet VALUES (9, 'Dunwich-Orb', true, 'Swamp', 5);
INSERT INTO public.planet VALUES (10, 'Arkham-Rock', false, 'Rocky', 5);
INSERT INTO public.planet VALUES (11, 'Miskatonic-Globe', false, 'Gaseous', 6);
INSERT INTO public.planet VALUES (12, 'Ulthar-Mass', true, 'Forest', 6);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Azathoth-Eye', true, 5000, 1);
INSERT INTO public.star VALUES (2, 'Pale Beacon', false, 1000, 2);
INSERT INTO public.star VALUES (3, 'Bleeding Sun', false, 2000, 3);
INSERT INTO public.star VALUES (4, 'Dormant Ember', true, 8000, 4);
INSERT INTO public.star VALUES (5, 'Crawling Light', false, 3000, 5);
INSERT INTO public.star VALUES (6, 'Silent Flare', true, 4000, 6);


--
-- Name: anomaly_anomaly_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.anomaly_anomaly_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: anomaly anomaly_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.anomaly
    ADD CONSTRAINT anomaly_name_key UNIQUE (name);


--
-- Name: anomaly anomaly_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.anomaly
    ADD CONSTRAINT anomaly_pkey PRIMARY KEY (anomaly_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

