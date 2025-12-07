--
-- PostgreSQL database dump
--

-- Dumped from database version 15.14
-- Dumped by pg_dump version 17.5

-- Started on 2025-10-07 07:42:39 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 20849)
-- Name: alerte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alerte (
    alerte_id integer NOT NULL,
    formulaire_id integer NOT NULL,
    statut_id integer NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 20852)
-- Name: alerte_alerte_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alerte_alerte_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 215
-- Name: alerte_alerte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alerte_alerte_id_seq OWNED BY public.alerte.alerte_id;


--
-- TOC entry 216 (class 1259 OID 20853)
-- Name: config_modif; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.config_modif (
    modif_id integer NOT NULL,
    type_id integer NOT NULL,
    contenu character varying
);


--
-- TOC entry 217 (class 1259 OID 20858)
-- Name: config_modif_modif_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.config_modif_modif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 217
-- Name: config_modif_modif_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.config_modif_modif_id_seq OWNED BY public.config_modif.modif_id;


--
-- TOC entry 218 (class 1259 OID 20859)
-- Name: connexion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.connexion (
    connexion_id character varying(255) NOT NULL,
    expiration timestamp without time zone,
    personne_id integer NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 20862)
-- Name: connexion_connexion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.connexion_connexion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 219
-- Name: connexion_connexion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.connexion_connexion_id_seq OWNED BY public.connexion.connexion_id;


--
-- TOC entry 220 (class 1259 OID 20863)
-- Name: date; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.date (
    date_id integer NOT NULL,
    date_debut timestamp without time zone NOT NULL,
    date_fin timestamp without time zone NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 20866)
-- Name: date_date_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.date_date_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 221
-- Name: date_date_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.date_date_id_seq OWNED BY public.date.date_id;


--
-- TOC entry 222 (class 1259 OID 20867)
-- Name: formulaire; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.formulaire (
    formulaire_id integer NOT NULL,
    personne_id integer NOT NULL,
    numero_scei character varying(16) NOT NULL,
    genre_id integer,
    date_de_naissance date,
    ville character varying(255),
    pays_id integer NOT NULL,
    mail character varying(255),
    numero_tel character varying(16),
    commentaires_ve text,
    commentaires_eleve text,
    est_boursier boolean,
    est_pmr boolean,
    numero_logement character varying(255),
    souhait_id integer,
    est_valide boolean DEFAULT false NOT NULL,
    est_conforme boolean DEFAULT false NOT NULL,
    date_validation timestamp without time zone,
    code_postal character varying,
    genre_attendu integer
);


--
-- TOC entry 223 (class 1259 OID 20874)
-- Name: formulaire_formulaire_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.formulaire_formulaire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 223
-- Name: formulaire_formulaire_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.formulaire_formulaire_id_seq OWNED BY public.formulaire.formulaire_id;


--
-- TOC entry 224 (class 1259 OID 20875)
-- Name: genre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genre (
    genre_id integer NOT NULL,
    genre_nom character varying(32) NOT NULL,
    genre_ordre integer
);


--
-- TOC entry 225 (class 1259 OID 20878)
-- Name: genre_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.genre_genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 225
-- Name: genre_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.genre_genre_id_seq OWNED BY public.genre.genre_id;


--
-- TOC entry 226 (class 1259 OID 20879)
-- Name: logement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.logement (
    numero_logement character varying(255) NOT NULL,
    genre_requis character varying(255),
    nb_places_dispo integer,
    type_appart_id integer NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 20884)
-- Name: mission_logement_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mission_logement_status (
    id integer NOT NULL,
    status integer NOT NULL,
    CONSTRAINT mission_logement_status_status_check CHECK ((status = ANY (ARRAY[0, 1, 2])))
);


--
-- TOC entry 228 (class 1259 OID 20888)
-- Name: mission_logement_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mission_logement_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 228
-- Name: mission_logement_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mission_logement_status_id_seq OWNED BY public.mission_logement_status.id;


--
-- TOC entry 229 (class 1259 OID 20889)
-- Name: pays; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pays (
    pays_id integer NOT NULL,
    pays_nom character varying(64) NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 20892)
-- Name: pays_pays_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pays_pays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 230
-- Name: pays_pays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pays_pays_id_seq OWNED BY public.pays.pays_id;


--
-- TOC entry 231 (class 1259 OID 20893)
-- Name: personne; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personne (
    personne_id integer NOT NULL,
    nom character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    login character varying(255),
    password character varying(255),
    role_id integer NOT NULL,
    first_connection_token character varying(255),
    first_connection_token_expiry timestamp without time zone
);


--
-- TOC entry 232 (class 1259 OID 20898)
-- Name: personne_personne_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personne_personne_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 232
-- Name: personne_personne_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.personne_personne_id_seq OWNED BY public.personne.personne_id;


--
-- TOC entry 233 (class 1259 OID 20899)
-- Name: role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    role_nom character varying(255) NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 20902)
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 234
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;


--
-- TOC entry 235 (class 1259 OID 20903)
-- Name: souhait; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.souhait (
    souhait_id integer NOT NULL,
    souhait_type character varying(255),
    souhait_ordre integer
);


--
-- TOC entry 236 (class 1259 OID 20906)
-- Name: souhait_souhait_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.souhait_souhait_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 236
-- Name: souhait_souhait_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.souhait_souhait_id_seq OWNED BY public.souhait.souhait_id;


--
-- TOC entry 237 (class 1259 OID 20907)
-- Name: statut; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.statut (
    statut_id integer NOT NULL,
    statut_nom character varying(32) NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 20910)
-- Name: statut_statut_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.statut_statut_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 238
-- Name: statut_statut_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.statut_statut_id_seq OWNED BY public.statut.statut_id;


--
-- TOC entry 239 (class 1259 OID 20911)
-- Name: type_appart; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.type_appart (
    type_appart_id integer NOT NULL,
    type_appart_nom character varying(255) NOT NULL
);


--
-- TOC entry 240 (class 1259 OID 20914)
-- Name: type_appart_type_appart_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.type_appart_type_appart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 240
-- Name: type_appart_type_appart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.type_appart_type_appart_id_seq OWNED BY public.type_appart.type_appart_id;


--
-- TOC entry 241 (class 1259 OID 20915)
-- Name: type_modif; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.type_modif (
    type_id integer NOT NULL,
    nom character varying
);


--
-- TOC entry 242 (class 1259 OID 20920)
-- Name: type_modif_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.type_modif_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 242
-- Name: type_modif_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.type_modif_type_id_seq OWNED BY public.type_modif.type_id;


--
-- TOC entry 3261 (class 2604 OID 20921)
-- Name: alerte alerte_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerte ALTER COLUMN alerte_id SET DEFAULT nextval('public.alerte_alerte_id_seq'::regclass);


--
-- TOC entry 3262 (class 2604 OID 20922)
-- Name: config_modif modif_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.config_modif ALTER COLUMN modif_id SET DEFAULT nextval('public.config_modif_modif_id_seq'::regclass);


--
-- TOC entry 3263 (class 2604 OID 20923)
-- Name: connexion connexion_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connexion ALTER COLUMN connexion_id SET DEFAULT nextval('public.connexion_connexion_id_seq'::regclass);


--
-- TOC entry 3264 (class 2604 OID 20924)
-- Name: date date_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date ALTER COLUMN date_id SET DEFAULT nextval('public.date_date_id_seq'::regclass);


--
-- TOC entry 3265 (class 2604 OID 20925)
-- Name: formulaire formulaire_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulaire ALTER COLUMN formulaire_id SET DEFAULT nextval('public.formulaire_formulaire_id_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 20926)
-- Name: genre genre_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genre ALTER COLUMN genre_id SET DEFAULT nextval('public.genre_genre_id_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 20927)
-- Name: mission_logement_status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mission_logement_status ALTER COLUMN id SET DEFAULT nextval('public.mission_logement_status_id_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 20928)
-- Name: pays pays_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pays ALTER COLUMN pays_id SET DEFAULT nextval('public.pays_pays_id_seq'::regclass);


--
-- TOC entry 3271 (class 2604 OID 20929)
-- Name: personne personne_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personne ALTER COLUMN personne_id SET DEFAULT nextval('public.personne_personne_id_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 20930)
-- Name: role role_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- TOC entry 3273 (class 2604 OID 20931)
-- Name: souhait souhait_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.souhait ALTER COLUMN souhait_id SET DEFAULT nextval('public.souhait_souhait_id_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 20932)
-- Name: statut statut_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statut ALTER COLUMN statut_id SET DEFAULT nextval('public.statut_statut_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 20933)
-- Name: type_appart type_appart_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_appart ALTER COLUMN type_appart_id SET DEFAULT nextval('public.type_appart_type_appart_id_seq'::regclass);


--
-- TOC entry 3276 (class 2604 OID 20934)
-- Name: type_modif type_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_modif ALTER COLUMN type_id SET DEFAULT nextval('public.type_modif_type_id_seq'::regclass);


--
-- TOC entry 3462 (class 0 OID 20849)
-- Dependencies: 214
-- Data for Name: alerte; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3464 (class 0 OID 20853)
-- Dependencies: 216
-- Data for Name: config_modif; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (3, 3, 'message page de connexion');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (5, 4, 'message page d''information');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (6, 5, 'message page d''attente');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (7, 6, 'message mission fermée');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (8, 7, 'message 1er contact');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (29, 6, 'message mission fermé');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (30, 6, 'message mission fermée');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (31, 3, 'Vous savez moi je pense pas qu''il y ait de bonnes ou de mauvaises situations.');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (2, 1, '2025-01-30T09:00');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (4, 2, '2025-02-28T21:00');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (32, 4, 'Je pense que la vie c''est avant tout des rencontres');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (33, 5, 'Si je devais dire quelque chose aux personnes qui m''ont tendu la main par le passé');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (34, 6, 'Ce serait merci à la vie, oui merci');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (9, 8, 'mailcontact@gmail.com');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (35, 3, 'Bienvenue sur la plateforme mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (36, 4, 'Numéro de la mission logement : ');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (37, 6, 'Mission fermée');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (38, 3, 'Bienvenue sur la plateforme mission logement et informations');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (39, 4, 'Informations sur la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (40, 5, 'Avant mission (inutile pour le moment)');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (19, 7, 'message 2eme contact');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (20, 7, 'message 3eme contact');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (21, 7, 'message 1er contact');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (22, 1, '2025-02-02T09:00');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (23, 2, '2025-02-28T20:00');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (24, 8, 'mailcontact@hotmail.com');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (25, 7, 'message premier contact');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (26, 5, 'message page d''attente la mission logement est actuellement fermée');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (27, 6, 'message mission fermée, test');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (28, 6, 'message mission fermée');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (41, 1, '2025-07-30T10:00');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (42, 2, '2025-07-31T14:00');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (43, 8, 'mission.logement@ec-nantes.frail.com');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (44, 7, 'Bonjour,

Toutes nos félicitations pour votre admission à l’école Centrale de Nantes!
Après l’admission, vient l’étape de recherche de logement.

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt.

Si vous êtes intéressé.e, vous pouvez faire une demande de place. Pour cela, nous vous invitons à remplir le formulaire en ligne afin d ‘indiquer vos préférences de logement et transmettre les justificatifs éventuels (notification conditionnelle de bourse CROUS par exemple).

Attention, il y a des critères de priorité (car le nombre de place est limité) et les délais sont très courts afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement.

Vous pourrez vous connecter selon les consignes reçues par mail.

Si vous rencontrez des difficultés particulières ou si vous avez besoin de conseils, nous vous invitons à contacter le standard de la mission logement au numéro indiqué sur la page : https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Au plaisir de vous retrouver à la rentrée !

D’ici là n’oubliez pas de préparer tous les éléments utiles pour votre inscription :  https://www.ec-nantes.fr/version-francaise/formation/inscription-1 

Le service vie étudiante et la mission logement
');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (45, 3, 'Bienvenu.e sur la plateforme de la mission logement !
Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail pour vous authentifier et pouvoir compléter le formulaire (vérifiez vos spams !).
Attention, la mission logement se déroule dans des délais très courts, afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement. 
>> Remplissez donc rapidement votre formulaire et pensez à valider à la fin de la démarche !
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 
Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 
Nous serons ravis de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.
Le service vie étudiante et la mission logement
');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (46, 5, 'La Mission logement est actuellement fermée.
Nous vous invitons à consulter la page logement du site de l’école https://www.ec-nantes.fr/version-francaise/campus/logement ; vous y trouverez les informations utiles pour orienter vos recherches.
Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Rendez-vous à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (47, 6, 'La Mission logement est actuellement fermée.
Si vous avez formulé une demande de logement via le formulaire, une réponse vous sera transmise par mail avant le 2 août 2025.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.
Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (60, 5, 'Bonjour,

La Mission logement est désormais clôturée.

Nous vous invitons à consulter la page logement du site de l’école https://www.ec-nantes.fr/version-francaise/campus/logement ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Rendez-vous à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (48, 7, 'Bonjour,

Toutes nos félicitations pour votre admission à l’école Centrale de Nantes!
Après l’admission, vient l’étape de recherche de logement.

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt.

Si vous êtes intéressé.e, vous pouvez faire une demande de place. Pour cela, nous vous invitons à remplir le formulaire en ligne afin d ‘indiquer vos préférences de logement et transmettre les justificatifs éventuels (notification conditionnelle de bourse CROUS par exemple).

Attention, il y a des critères de priorité (car le nombre de place est limité) et les délais sont très courts afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement.

Vous pourrez vous connecter selon les consignes reçues par mail.

Si vous rencontrez des difficultés particulières ou si vous avez besoin de conseils, nous vous invitons à contacter le standard de la mission logement au numéro indiqué sur la page : https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Au plaisir de vous retrouver à la rentrée !

D’ici là n’oubliez pas de préparer tous les éléments utiles pour votre inscription :  https://www.ec-nantes.fr/version-francaise/formation/inscription-1 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (49, 3, 'Bienvenu.e sur la plateforme de la mission logement !

Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail pour vous authentifier et pouvoir compléter le formulaire (vérifiez vos spams !).
Attention, la mission logement se déroule dans des délais très courts, afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à valider à la fin de la démarche !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravis de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement
');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (50, 4, 'Bienvenu.e sur la plateforme de la mission logement !

Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail pour vous authentifier et pouvoir compléter le formulaire (vérifiez vos spams !).
Attention, la mission logement se déroule dans des délais très courts, afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à valider à la fin de la démarche !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravis de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (51, 5, 'La Mission logement est actuellement fermée.

Nous vous invitons à consulter la page logement du site de l’école https://www.ec-nantes.fr/version-francaise/campus/logement ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Rendez-vous à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (52, 4, 'Bienvenu.e sur la plateforme de la mission logement !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (73, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt. Vous pouvez faire une demande de place via cette plateforme ''Mission Logement''. 

Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail avec les informations utiles pour faire votre demande.

Attention, la mission logement se déroule sur des délais très courts ! Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !
>> 1ère étape : créer un compte ! 

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (53, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La plateforme Mission logement est activée !

Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail pour vous redonner les informations utiles pour faire votre demande.

Attention, la mission logement se déroule dans des délais très courts, afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à transmettre votre formulaire à la fin de la démarche !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (54, 4, 'Vous êtes bien connecté.e à la plateforme de la mission logement.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (55, 5, 'La Mission logement est désormais clôturée.

Nous vous invitons à consulter la page logement du site de l’école https://www.ec-nantes.fr/version-francaise/campus/logement ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Rendez-vous à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (56, 7, 'Bonjour,

Toutes nos félicitations pour votre admission à l’école Centrale de Nantes!
Après l’admission, vient l’étape de recherche de logement.

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt.

Si vous êtes intéressé.e, vous pouvez faire une demande de place. Pour cela, nous vous invitons à remplir le formulaire en ligne afin d ‘indiquer vos préférences de logement et transmettre les justificatifs éventuels (notification conditionnelle de bourse CROUS par exemple).

Attention, il y a des critères de priorité (car le nombre de place est limité) et les délais sont très courts afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement.

Vous pouvez vous connecter selon les consignes reçues par mail.

>> 1ère étape : créer un compte ! 
(vous avez besoin pour cela de votre numéro SCEI et de votre mail transmis lors du concours). 
Notez précieusement vos identifiants et mot de passe ensuite.

Si vous rencontrez des difficultés particulières ou si vous avez besoin de conseils, nous vous invitons à contacter le standard de la mission logement au numéro indiqué sur la page : https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Au plaisir de vous retrouver à la rentrée !

D’ici là n’oubliez pas de préparer tous les éléments utiles pour votre inscription :  https://www.ec-nantes.fr/version-francaise/formation/inscription-1 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (57, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Pour le moment celle-ci n''est pas activée, elle le sera à partir du mercredi 30 juillet 10h00.

Vous pouvez vous connecter à la plateforme à deux conditions:
- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez
- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.
Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (58, 6, 'Bonjour,

La Mission logement est actuellement fermée.

Si vous avez formulé une demande de logement via le formulaire, une réponse vous sera transmise par mail avant le 2 août 2025.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.
Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (59, 7, 'Bonjour,

Toutes nos félicitations pour votre admission à l’école Centrale de Nantes!
Après l’admission, vient l’étape de recherche de logement.

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt.

Si vous êtes intéressé.e, vous pouvez faire une demande de place. Pour cela, nous vous invitons à remplir le formulaire en ligne sur cette plateforme afin d ‘indiquer vos préférences de logement et transmettre les justificatifs éventuels (notification conditionnelle de bourse CROUS par exemple).

Attention, il y a des critères de priorité (car le nombre de place est limité) et les délais sont très courts afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement.

>> 1ère étape : créer un compte ! 
(vous avez besoin pour cela de votre numéro SCEI et de votre mail transmis lors du concours). 
Notez précieusement vos identifiants et mot de passe ensuite.

Si vous rencontrez des difficultés particulières ou si vous avez besoin de conseils, nous vous invitons à contacter le standard de la mission logement au numéro indiqué sur la page : https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Au plaisir de vous retrouver à la rentrée !

D’ici là n’oubliez pas de préparer tous les éléments utiles pour votre inscription :  https://www.ec-nantes.fr/version-francaise/formation/inscription-1 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (61, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte !

Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail pour vous redonner les informations utiles pour faire votre demande.

Attention, la mission logement se déroule dans des délais très courts, afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à transmettre votre formulaire à la fin de la démarche !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (62, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Pour le moment celle-ci n''est pas ouverte, elle le sera à partir du mercredi 30 juillet 10h00 et se terminera le jeudi 31 juillet à 14h00.

Vous pouvez vous connecter à la plateforme à deux conditions:
- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu oui def avant 8h00 le mercredi, vous devez avoir répondu "oui def" au plus tard jeudi 31 juillet avant 8h00)
- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (63, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Pour le moment celle-ci n''est pas ouverte, elle le sera à partir du mercredi 30 juillet 10h00 et se terminera le jeudi 31 juillet à 14h00.

Vous pouvez vous connecter à la plateforme à deux conditions:
- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu oui def avant 8h00 le mercredi, vous devez avoir répondu "oui def" au plus tard jeudi 31 juillet avant 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (64, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Pour le moment celle-ci n''est pas ouverte, elle le sera à partir du mercredi 30 juillet 10h00 et se terminera le jeudi 31 juillet à 14h00.

Vous pouvez vous connecter à la plateforme à deux conditions:

- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu oui def avant 8h00 le mercredi, vous devez avoir répondu "oui def" au plus tard jeudi 31 juillet avant 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (65, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Pour le moment celle-ci n''est pas ouverte, elle le sera à partir du mercredi 30 juillet 10h00 et se terminera le jeudi 31 juillet à 14h00.

Vous pouvez vous connecter à la plateforme à deux conditions:

- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, vous devez avoir répondu "oui def" au plus tard jeudi 31 juillet avant 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (66, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Pour le moment celle-ci n''est pas ouverte, elle le sera à partir du mercredi 30 juillet 10h00 et se terminera le jeudi 31 juillet à 14h00.

Vous pouvez vous connecter à la plateforme à deux conditions:

- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" au plus tard jeudi 31 juillet avant 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (67, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Pour le moment celle-ci n''est pas ouverte, elle le sera à partir du mercredi 30 juillet 10h00 et se terminera le jeudi 31 juillet à 14h00.

Vous pouvez vous connecter à la plateforme à deux conditions:

- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (68, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte !

Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail pour vous redonner les informations utiles pour faire votre demande.

Attention, la mission logement se déroule sur des délais très courts ! Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à transmettre votre formulaire à la fin de la démarche !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (69, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt. 
Si vous êtes intéressé.e, vous pouvez faire une demande de place via la Mission Logement. 

Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail avec les informations utiles pour faire votre demande.

Attention, la mission logement se déroule sur des délais très courts ! Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (70, 7, 'Bonjour,

Toutes nos félicitations pour votre admission à l’école Centrale de Nantes!
Après l’admission, vient l’étape de recherche de logement.

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt.

Si vous êtes intéressé.e, vous pouvez faire une demande de place. Pour cela, nous vous invitons à remplir le formulaire en ligne sur la plateforme dédiée afin d ‘indiquer vos préférences de logement et transmettre les justificatifs éventuels (notification conditionnelle de bourse CROUS par exemple).

Attention, il y a des critères de priorité (car le nombre de place est limité) et les délais sont très courts afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement.

>> 1ère étape : créer un compte ! 
(vous avez besoin pour cela de votre numéro SCEI et de votre mail transmis lors du concours). 
Notez précieusement vos identifiants et mot de passe ensuite.

Si vous rencontrez des difficultés particulières ou si vous avez besoin de conseils, nous vous invitons à contacter le standard de la mission logement au numéro indiqué sur la page : https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Au plaisir de vous retrouver à la rentrée !

D’ici là n’oubliez pas de préparer tous les éléments utiles pour votre inscription :  https://www.ec-nantes.fr/version-francaise/formation/inscription-1 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (71, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt.

Si vous êtes intéressé.e, vous pouvez faire une demande de place sur cette plateforme.

Pour le moment la mission est fermée.
Elle ouvrira à partir du mercredi 30 juillet 10h00 et se terminera le jeudi 31 juillet à 14h00.

Vous pouvez vous connecter à la plateforme à deux conditions:

- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (72, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt. Vous pouvez faire une demande de place via cette plateforme ''Mission Logement''. 

Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail avec les informations utiles pour faire votre demande.

Attention, la mission logement se déroule sur des délais très courts ! Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )
NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (74, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt. Vous pouvez faire une demande de place via cette plateforme ''Mission Logement''. 

Si vous avez répondu « oui définitif » dans les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez , vous avez dû recevoir un mail avec les informations utiles pour faire votre demande.

Attention, la mission logement se déroule sur des délais très courts ! Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !
>> 1ère étape : créer un compte ! 

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :  https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, pas de panique ! 
La mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (75, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt.

Si vous êtes intéressé.e, vous pouvez faire une demande de place sur cette plateforme.

Pour le moment la mission est fermée.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 14h00.

Vous pouvez vous connecter à la plateforme à deux conditions:

- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (76, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt. Vous pouvez faire une demande de place via cette plateforme ''Mission Logement''. 

Si vous avez répondu « oui définitif » dans les délais indiqués, vous avez dû recevoir un mail avec les informations utiles pour faire votre demande.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Remplissez donc rapidement votre formulaire et pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !
>> 1ère étape : créer un compte 
>> puis remplissez le formulaire et transmettez le à la mission logement.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :  https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes de logement, notamment dans les résidences partenaires de l’école et vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (77, 5, 'Bonjour,

La Mission logement est désormais clôturée.

Nous vous invitons à consulter la page logement du site de l’école https://www.ec-nantes.fr/version-francaise/campus/logement ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (78, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt. 

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créer votre compte puis remplissez rapidement votre formulaire
Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :  https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence) 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (79, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt.

Si vous êtes intéressé.e, vous pouvez faire une demande de place sur cette plateforme.

Pour le moment la mission est fermée.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

Vous pouvez vous connecter à la plateforme si:

- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (80, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Retrouvez toutes les informations concernant la résidence Max Schmitt sur la page dédiée: https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :  https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (81, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Retrouvez toutes les informations concernant la résidence Max Schmitt sur la page dédiée: https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est fermée.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

Vous pouvez vous connecter à la plateforme si:

- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (82, 4, 'Vous êtes bien connecté.e à la plateforme de la mission logement.

Une fois votre formulaire rempli, vous devez cliqué sur "transmettre". Vous serez recontacté par mail par la mission logement.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (83, 4, 'Vous êtes bien connecté.e à la plateforme de la mission logement.

Une fois votre formulaire rempli, vous devez cliquer sur "transmettre" et quitter la page. 
Vous serez recontacté par mail par la mission logement.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (84, 4, 'Vous êtes bien connecté.e à la plateforme de la mission logement.

Les étapes à suivre:
- Compléter le formulaire
- Cliquer sur "Sauvegarder et Soumettre" 
- Quitter la page (en haut à droite) 
Vous serez  ensuite recontacté.e par mail par la mission logement.

Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

NB: pour revenir à la page d''accueil: cliquer sur le logo 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (85, 4, 'Vous êtes bien connecté.e à la plateforme de la mission logement.

Les étapes à suivre:
- Compléter le formulaire
- Cliquer sur "Sauvegarder et Soumettre" 
- Quitter la page (en haut à droite) 
Vous serez  ensuite recontacté.e par mail par la mission logement.

Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur la page dédiée à la résidence Max Schmitt :
 https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

NB: pour revenir à la page d''accueil 
> cliquer sur le logo "Centrale Nantes" en haut à gauche.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (86, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est fermée.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

Vous pouvez vous connecter à la plateforme si:

- vous avez répondu "oui définitif" selon les délais indiqués sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (87, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>..

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :  https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (88, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à la résidence Max Schmitt :  https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant la page : https://www.ec-nantes.fr/version-francaise/formation/inscription-1 )

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (89, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est ouverte jusqu''au jeudi 31 juillet 13h59 !

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">la page dédiée</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (90, 4, 'Vous êtes bien connecté.e à la plateforme de la mission logement.

Les étapes à suivre:
- Compléter le formulaire
- Cliquer sur "Sauvegarder et Soumettre" 
- Quitter la page (en haut à droite) 
Vous serez  ensuite recontacté.e par mail par la mission logement.

Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmit</a>

NB: pour revenir à la page d''accueil 
> cliquer sur le logo "Centrale Nantes" en haut à gauche.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (91, 5, 'Bonjour,

La Mission logement est désormais clôturée.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement">la page logement du site de l’école</a>

; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">la page du site</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (92, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est fermée.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

Vous pouvez vous connecter à la plateforme si:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (115, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a>. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">la page du site</a><\h1>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (93, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est <b>ouverte<b> jusqu''au jeudi 31 juillet 13h59 !

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (94, 5, 'Bonjour,

La Mission logement est désormais <b>clôturée<b>.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement">la page logement du site de l’école</a>

; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">la page du site</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (95, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée<b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

Vous pouvez vous connecter à la plateforme si:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (96, 3, 'Bienvenu.e sur la plateforme de la mission logement !

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (97, 5, 'Bonjour,

La Mission logement est désormais <b>clôturée</b>.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement">la page logement du site de l’école</a>

; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">la page du site</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (98, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

Vous pouvez vous connecter à la plateforme si:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (116, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a>. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">la page du site</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (99, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

Vous pouvez vous connecter à la plateforme si:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (</i>ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00</i>)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (100, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

Vous pouvez vous connecter à la plateforme si:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (</em>ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00</em>)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (101, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

Vous pouvez vous connecter à la plateforme si:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (<i>ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00</i>)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (102, 9, 'Bienvenu.e sur la plateforme de la mission logement ! 

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (<i>ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00</i>)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (103, 9, '<h1>Bienvenu.e sur la plateforme de la mission logement ! </h1>

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (<i>ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00</i>)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (117, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h3>Informations pratiques</h3>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (104, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (<i>ex: vous ne pouvez pas vous connecter mercredi après-midi si vous n''avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devez avoir répondu "oui def" avant le jeudi 31 juillet 8h00</i>)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (105, 5, 'Bonjour,

La Mission logement est désormais <b>clôturée</b>.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">la page du site</a><\h1>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (106, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">plus d''informations sur la résidence ici</a>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (<i>ex: vous pouvez vous connecter mercredi après-midi uniquement si vous avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (107, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attirbution, localisation, informations pratiques..)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu "oui définitif" selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> (<i>ex: vous pouvez vous connecter mercredi après-midi uniquement si vous avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre numéro SCEI et de votre mail utilisé au concours.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (108, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"<\b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi après-midi uniquement si vous avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI<\b> et de votre <b>mail utilisé au concours<\b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (134, 4, '<h2>Informations pratiques de la plateforme Mission logement ! </h2>

 <div style="margin: 25px;">Vous êtes bien connecté.e à la plateforme de la mission logement.

<u>Les étapes à suivre:</u>
<li> Compléter le formulaire</li>
<li> Cliquer sur "Sauvegarder et Soumettre" </li>
<li> Quitter la page (en haut à droite) </li>

Vous serez  ensuite recontacté.e par mail par la mission logement.

Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmit</a>

NB: pour revenir à la page d''accueil 
> cliquer sur le logo "Centrale Nantes" en haut à gauche.

Le service vie étudiante et la mission logement</div>');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (109, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi après-midi uniquement si vous avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (110, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi après-midi uniquement si vous avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr.  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (111, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' si vous répondez « oui définitif » dans les délais indiqués.

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi après-midi uniquement si vous avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (112, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (113, 4, '<h2>Informations pratiques de la plateforme Mission logement ! </h2>

Vous êtes bien connecté.e à la plateforme de la mission logement.

Les étapes à suivre:
- Compléter le formulaire
- Cliquer sur "Sauvegarder et Soumettre" 
- Quitter la page (en haut à droite) 
Vous serez  ensuite recontacté.e par mail par la mission logement.

Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmit</a>

NB: pour revenir à la page d''accueil 
> cliquer sur le logo "Centrale Nantes" en haut à gauche.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (114, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : vie.etudiante@ec-nantes.fr. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">la page du site</a><\h1>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (118, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (119, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

<h4>Etapes</h4>
>> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">le site</a> 
>> Créez votre compte puis remplissez rapidement votre formulaire.
>> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (120, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">le site</a> </li>
<li> Créez votre compte puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (121, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">le site</a> </li>
<li> Créez votre compte puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (122, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">le site</a> </li>
<li> Créez votre compte puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?</h4>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>
Vous retrouverez également sur cette page toutes les informations utiles (notamment les règles de priorité pour l’attribution des logements pour la résidence). 

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (135, 4, '<h2>Informations pratiques de la plateforme Mission logement ! </h2>
 <div style="margin: 25px;">Vous êtes bien connecté.e à la plateforme de la mission logement.

<u>Les étapes à suivre:</u>
<li> Compléter le formulaire</li>
<li> Cliquer sur "Sauvegarder et Soumettre" </li>
<li> Quitter la page (en haut à droite) </li>

Vous serez  ensuite recontacté.e par mail par la mission logement.

Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmit</a>

NB: pour revenir à la page d''accueil 
> cliquer sur le logo "Centrale Nantes" en haut à gauche.

Le service vie étudiante et la mission logement</div>');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (123, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Vous pouvez faire une demande de place via cette plateforme ''Mission Logement'' si vous avez répondu « oui définitif » dans les délais indiqués.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">le site</a> </li>
<li> Créez votre compte puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?</h4>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (124, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a>. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">la page du site</a> </i>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (125, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">le site</a> </li>
<li> Créez votre compte puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?</h4>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (126, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">le site</a> </li>
<li> Créez votre compte puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?</h4>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (127, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle ouvrira à partir du mercredi 30 juillet 9h00 et se terminera le jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi après-midi uniquement si vous avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (128, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi après-midi uniquement si vous avez pas répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (129, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (130, 4, '<h2>Informations pratiques de la plateforme Mission logement ! </h2>

Vous êtes bien connecté.e à la plateforme de la mission logement.

Les étapes à suivre:
<li>  Compléter le formulaire</li>
<li> Cliquer sur "Sauvegarder et Soumettre" </li>
<li> Quitter la page (en haut à droite) </li>
Vous serez  ensuite recontacté.e par mail par la mission logement.

Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmit</a>

NB: pour revenir à la page d''accueil 
> cliquer sur le logo "Centrale Nantes" en haut à gauche.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (131, 4, '<h2>Informations pratiques de la plateforme Mission logement ! </h2>

  Vous êtes bien connecté.e à la plateforme de la mission logement.

  Les étapes à suivre:
  <li>  Compléter le formulaire</li>
  <li> Cliquer sur "Sauvegarder et Soumettre" </li>
  <li> Quitter la page (en haut à droite) </li>
  Vous serez  ensuite recontacté.e par mail par la mission logement.

  Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

  Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmit</a>

  NB: pour revenir à la page d''accueil 
  > cliquer sur le logo "Centrale Nantes" en haut à gauche.

  Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (132, 4, '<h2>Informations pratiques de la plateforme Mission logement ! </h2>

 <div style="margin: 15px;">Vous êtes bien connecté.e à la plateforme de la mission logement.

  Les étapes à suivre:
  <li> Compléter le formulaire</li>
  <li> Cliquer sur "Sauvegarder et Soumettre" </li>
  <li> Quitter la page (en haut à droite) </li>
  Vous serez  ensuite recontacté.e par mail par la mission logement.

  Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

  Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmit</a>

  NB: pour revenir à la page d''accueil 
  > cliquer sur le logo "Centrale Nantes" en haut à gauche.

  Le service vie étudiante et la mission logement</div>');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (133, 4, '<h2>Informations pratiques de la plateforme Mission logement ! </h2>

 <div style="margin: 25px;">Vous êtes bien connecté.e à la plateforme de la mission logement.

  Les étapes à suivre:
  <li> Compléter le formulaire</li>
  <li> Cliquer sur "Sauvegarder et Soumettre" </li>
  <li> Quitter la page (en haut à droite) </li>
  Vous serez  ensuite recontacté.e par mail par la mission logement.

  Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

  Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmit</a>

  NB: pour revenir à la page d''accueil 
  > cliquer sur le logo "Centrale Nantes" en haut à gauche.

  Le service vie étudiante et la mission logement</div>');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (136, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée</a>.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">le site</a> </li>
<li> Créez votre compte </li>
<li> Connectez vous avec votre identifiant et mot de passe nouvellement créé</li>
<li>puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?</h4>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (137, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page dédiée</a>.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">le site</a> </li>
<li> Créez votre compte </li>
<li> Connectez vous avec votre identifiant et mot de passe nouvellement créé</li>
<li>puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?</h4>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page dédiée à la résidence Max Schmitt</a>

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (138, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (139, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page dédiée</a>.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">le site</a> </li>
<li> Créez votre compte </li>
<li> Connectez vous avec votre identifiant et mot de passe nouvellement créé</li>
<li>puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?</h4>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page dédiée à la résidence Max Schmitt</a>

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de procéder à votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1" target="new">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (140, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">>la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (141, 4, '<h2>Informations pratiques de la plateforme Mission logement ! </h2>
 <div style="margin: 25px;">Vous êtes bien connecté.e à la plateforme de la mission logement.

<u>Les étapes à suivre:</u>
<li> Compléter le formulaire</li>
<li> Cliquer sur "Sauvegarder et Soumettre" </li>
<li> Quitter la page (en haut à droite) </li>

Vous serez  ensuite recontacté.e par mail par la mission logement.

Vous pouvez revenir sur votre formulaire pour vérifier les informations transmises mais ne pourrez plus les modifier.

Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page dédiée à la résidence Max Schmit</a>

NB: pour revenir à la page d''accueil 
> cliquer sur le logo "Centrale Nantes" en haut à gauche.

Le service vie étudiante et la mission logement</div>');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (142, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement" target="new">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail : <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a>. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1" target="new">la page du site</a> </i>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (143, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (144, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr" target="new">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (145, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr" target="blank">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (146, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le jeudi 31 juillet 8h00 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (147, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.
Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le mercredi 30 juillet 23h59 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (148, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La Mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page dédiée</a>.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">le site</a> </li>
<li> Créez votre compte </li>
<li> Connectez vous avec votre identifiant et mot de passe nouvellement créé</li>
<li>puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?</h4>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page dédiée à la résidence Max Schmitt</a>

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de préparer les éléments pour votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1" target="new">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (149, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la mission est <b>fermée</b>.

Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59> vous pourrez alors créer votre compte.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le mercredi 30 juillet 23h59 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

- La plateforme est notée comme <b>ouverte</b>

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (150, 3, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

La plateforme mission logement est <b>ouverte</b> jusqu''au jeudi 31 juillet 13h59 !

<h4>Informations pratiques</h4>
Retrouvez toutes les informations concernant la résidence Max Schmitt sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page dédiée</a>.

Attention, la mission logement se déroule sur des délais très courts. Cela permet aux étudiants qui n’obtiendraient pas une place à la résidence Max Schmitt d’avoir le temps de trouver une autre solution de logement. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

<h4>Etapes</h4>
<li> Répondez "oui définitif" sur le site du concours avant les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">le site</a> </li>
<li> Créez votre compte </li>
<li> Connectez vous avec votre identifiant et mot de passe nouvellement créé</li>
<li>puis remplissez rapidement votre formulaire.</li>
<li> Pensez à transmettre votre formulaire à la fin de la démarche avant la fin de la mission !</li>

<h4>Un problème ?</h4>
Si vous rencontrez une difficulté particulière, nous vous invitons à contacter le standard de la mission logement aux horaires et au numéro indiqué sur la page dédiée à <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page dédiée à la résidence Max Schmitt</a>

Si vous n’obtenez pas de logement à la résidence, la mission logement vous enverra un mail avec plusieurs pistes pour vous aider dans vos recherches, notamment dans les résidences partenaires de l’école
Vous pourrez également contacter la mission logement par téléphone, pendant les horaires indiqués sur le site. 

Nous serons ravi.es de vous retrouver à la rentrée ! 

<h4>En attendant la rentrée</h4>
D’ici là n’oubliez pas de préparer les éléments pour votre inscription administrative (<a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1" target="new">plus d''informations ici</a>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (151, 9, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Vous êtes sur la plateforme permettant de faire une demande de place pour la  Résidence Max Schmitt : <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">retrouvez toutes les informations sur la résidence ici </a> <i>(critères d''attribution, localisation, informations pratiques...)</i>.

Vous pourrez faire une demande de place via cette plateforme ''Mission Logement'' lorsque vous aurez répondu « oui définitif » dans les délais indiqués. 
Elle est réservée aux élèves-ingénieurs de première année admis par la voie du concours Centrale-Supélec (dont les résultats sont connus fin juillet).

Pour le moment la plateforme mission logement est <b>fermée</b>.

Elle sera ouverte du mercredi 30 juillet 9h00 au jeudi 31 juillet à 13h59> vous pourrez alors créer votre compte.

<u>Vous pouvez vous connecter à la plateforme si</u>:

- vous avez répondu <b>"oui définitif"</b> selon les délais indiqués sur <a href="https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez" target="new">la page </a> 
(<i>ex: vous pouvez vous connecter mercredi 30 juillet après-midi uniquement si vous avez répondu "oui def" avant 8h00 le mercredi, et dans tous les cas, vous devrez avoir répondu "oui def" avant le mercredi 30 juillet 23h59 pour vous connecter le jeudi matin</i>)

- vous êtes en possession de votre <b>numéro SCEI</b> et de votre <b>mail utilisé au concours</b>.

- La plateforme mission logement est notée comme <b>ouverte</b>

Pour toute question en dehors des horaires d’ouverture de la mission logement, vous pouvez contactez le service vie étudiante par mail :  <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a> 

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (152, 7, 'Bonjour,

Toutes nos félicitations pour votre admission à l’école Centrale de Nantes!
Après l’admission, vient souvent l’étape de recherche de logement.

Comme indiqué sur notre site internet (https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez), l’école dispose d’une résidence proche de l’école dont une centaine de places sont réservés aux étudiants de première année admis par la voie du concours Centrale : la résidence Max Schmitt.

Si vous êtes intéressé.e, vous pouvez faire une demande de place. Pour cela, nous vous invitons à remplir le formulaire en ligne sur la plateforme dédiée afin d ‘indiquer vos préférences de logement et transmettre les justificatifs éventuels (notification conditionnelle de bourse CROUS 2025/26 par exemple si vous êtes boursier.e).

Attention, il y a des critères de priorité (car le nombre de place est limité) et les délais sont très courts afin de permettre aux étudiants qui n’obtiendraient pas une place à la résidence d’avoir le temps de trouver une autre solution de logement.

Si vous rencontrez des difficultés particulières ou si vous avez besoin de conseils, nous vous invitons à contacter le standard de la mission logement au numéro indiqué sur la page : https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez 

Au plaisir de vous retrouver à la rentrée !

D’ici là n’oubliez pas de préparer tous les éléments utiles pour votre inscription :  https://www.ec-nantes.fr/version-francaise/formation/inscription-1 

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (153, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement" target="new">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour bénéficier du partenariat avec Les Estudines (résidence La Beaujoire et René Cassin) voici la marche à suivre:
1-	S’inscrire sur leur site internet et déposer vos pièces justificatives  
2-	Noter votre numéro de dossier 
3-	Contacter par mail la centrale de réservation pour obtenir la priorisation : partenaires.estudines@reside-etudes.fr   (en indiquant votre statut de futur·e étudiant·e de l’école Centrale de Nantes, votre nom et le numéro de dossier)

Pour les autres partenariat et des conseils, vous pouvez contactez le service vie étudiante par mail à partir du 18 août : <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a>. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1" target="new">la page du site</a> </i>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (154, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.
Pour les étudiants ayant formulé une demande de logement, la réponse va être envoyée par mail au plus tard vendredi 1er août matin. 

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement" target="new">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour bénéficier du partenariat avec Les Estudines (résidence La Beaujoire et René Cassin) voici la marche à suivre:
1-	S’inscrire sur leur site internet et déposer vos pièces justificatives  
2-	Noter votre numéro de dossier 
3-	Contacter par mail la centrale de réservation pour obtenir la priorisation : partenaires.estudines@reside-etudes.fr   (en indiquant votre statut de futur·e étudiant·e de l’école Centrale de Nantes, votre nom et le numéro de dossier)

Pour les autres partenariat et des conseils, vous pouvez contactez le service vie étudiante par mail à partir du 18 août : <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a>. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1" target="new">la page du site</a> </i>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (155, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.
Pour les étudiants ayant formulé une demande de logement, la réponse a été transmise par mail le 30/07/2025.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement" target="new">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour bénéficier du partenariat avec Les Estudines (résidence La Beaujoire et René Cassin) voici la marche à suivre:
1-	S’inscrire sur leur site internet et déposer vos pièces justificatives  
2-	Noter votre numéro de dossier 
3-	Contacter par mail la centrale de réservation pour obtenir la priorisation : partenaires.estudines@reside-etudes.fr   (en indiquant votre statut de futur·e étudiant·e de l’école Centrale de Nantes, votre nom et le numéro de dossier)

Pour les autres partenariat et des conseils, vous pouvez contactez la mission logement le vendredi 1er août (9h30-12h30/13h30-15h30)  puis le service vie étudiante par mail à partir du 18 août : <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a>. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1" target="new">la page du site</a> </i>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (156, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.
Pour les étudiants ayant formulé une demande de logement, la réponse a été transmise par mail le 30/07/2025.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement" target="new">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour bénéficier du partenariat avec Les Estudines (résidence La Beaujoire et René Cassin) voici la marche à suivre:
1-	S’inscrire sur leur site internet et déposer vos pièces justificatives  
2-	Noter votre numéro de dossier 
3-	Contacter par mail la centrale de réservation pour obtenir la priorisation : partenaires.estudines@reside-etudes.fr   (en indiquant votre statut de futur·e étudiant·e de l’école Centrale de Nantes, votre nom et le numéro de dossier)

Pour les autres partenariats et des conseils, vous pouvez contactez la mission logement le vendredi 1er août (9h30-12h30/13h30-15h30)  puis le service vie étudiante par mail à partir du 18 août : <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a>. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1" target="new">la page du site</a> </i>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');
INSERT INTO public.config_modif (modif_id, type_id, contenu) VALUES (157, 5, '<h2>Bienvenu.e sur la plateforme de la mission logement ! </h2>

Bonjour,

La Mission logement est désormais <b>clôturée</b>.
Pour les étudiants ayant formulé une demande de logement, la réponse a été transmise par mail le 30/07/2025.

Nous vous invitons à consulter <a href="https://www.ec-nantes.fr/version-francaise/campus/logement" target="new">la page logement du site de l’école</a> ; vous y trouverez les informations utiles pour orienter vos recherches.

Pour bénéficier du partenariat avec Les Estudines (résidence La Beaujoire et René Cassin) voici la marche à suivre:
1-	S’inscrire sur leur site internet et déposer vos pièces justificatives  
2-	Noter votre numéro de dossier 
3-	Contacter par mail la centrale de réservation pour obtenir la priorisation : partenaires.estudines@reside-etudes.fr   (en indiquant votre statut de futur·e étudiant·e de l’école Centrale de Nantes, votre nom et le numéro de dossier)

Pour les autres partenariats et des conseils, vous pouvez contactez la mission logement le vendredi 1er août (9h30-12h30/13h30-15h30) au 02 40 37 15 22  puis le service vie étudiante par mail à partir du 18 août : <a href="mailto:vie.etudiante@ec-nantes.fr">vie.etudiante@ec-nantes.fr</a>. 
Nous serons ravi.es de vous retrouver à la rentrée ! 

D’ici là n’oubliez pas de procéder à votre inscription administrative (<i>vous pouvez préparer en amont tous les éléments en consultant <a href="https://www.ec-nantes.fr/version-francaise/formation/inscription-1" target="new">la page du site</a> </i>)

NB : l’école sera fermée du 2 au 17 août 2025 inclus.

Le service vie étudiante et la mission logement');


--
-- TOC entry 3466 (class 0 OID 20859)
-- Dependencies: 218
-- Data for Name: connexion; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.connexion (connexion_id, expiration, personne_id) VALUES ('125bcb18-f1f2-4a33-bb01-1939986cd876', '2025-10-02 12:47:40.417', 2);


--
-- TOC entry 3468 (class 0 OID 20863)
-- Dependencies: 220
-- Data for Name: date; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3470 (class 0 OID 20867)
-- Dependencies: 222
-- Data for Name: formulaire; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3472 (class 0 OID 20875)
-- Dependencies: 224
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.genre (genre_id, genre_nom, genre_ordre) VALUES (1, 'Masculin', 2);
INSERT INTO public.genre (genre_id, genre_nom, genre_ordre) VALUES (2, 'Féminin', 1);
INSERT INTO public.genre (genre_id, genre_nom, genre_ordre) VALUES (3, 'Autre', 3);
INSERT INTO public.genre (genre_id, genre_nom, genre_ordre) VALUES (4, 'ne souhaite pas répondre', 4);


--
-- TOC entry 3474 (class 0 OID 20879)
-- Dependencies: 226
-- Data for Name: logement; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3475 (class 0 OID 20884)
-- Dependencies: 227
-- Data for Name: mission_logement_status; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.mission_logement_status (id, status) VALUES (1, 2);


--
-- TOC entry 3477 (class 0 OID 20889)
-- Dependencies: 229
-- Data for Name: pays; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.pays (pays_id, pays_nom) VALUES (1, 'France');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (2, 'Afghanistan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (3, 'Afrique du sud');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (4, 'Albanie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (6, 'Allemagne');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (7, 'Arabie saoudite');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (8, 'Argentine');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (9, 'Australie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (10, 'Autriche');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (11, 'Belgique');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (12, 'Brésil');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (13, 'Bulgarie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (14, 'Canada');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (15, 'Chili');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (16, 'Chine');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (17, 'Colombie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (18, 'Corée du Sud');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (19, 'Costa Rica');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (20, 'Croatie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (21, 'Danemark');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (22, 'Egypte');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (23, 'Emirats arabes unis');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (24, 'Equateur');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (25, 'Etats-Unis');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (26, 'El Salvador');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (27, 'Espagne');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (28, 'Finlande');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (29, 'Grèce');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (30, 'Hong Kong');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (31, 'Hongrie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (32, 'Inde');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (33, 'Indonésie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (34, 'Irlande');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (35, 'Israël');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (36, 'Italie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (37, 'Japon');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (38, 'Jordanie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (39, 'Liban');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (40, 'Malaisie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (41, 'Maroc');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (42, 'Mexique');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (43, 'Norvège');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (44, 'Nouvelle-Zélande');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (45, 'Pérou');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (46, 'Pakistan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (47, 'Pays-Bas');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (48, 'Philippines');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (49, 'Pologne');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (50, 'Porto Rico');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (51, 'Portugal');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (52, 'République tchèque');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (53, 'Roumanie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (54, 'Royaume-Uni');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (55, 'Russie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (56, 'Singapour');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (57, 'Suède');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (58, 'Suisse');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (59, 'Taiwan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (60, 'Thailande');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (61, 'Turquie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (62, 'Ukraine');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (63, 'Venezuela');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (64, 'Serbie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (65, 'Kosovo');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (66, 'Samoa');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (67, 'Andorre');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (68, 'Angola');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (69, 'Anguilla');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (70, 'Antarctique');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (71, 'Antigua et Barbuda');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (72, 'Arménie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (73, 'Aruba');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (74, 'Azerbaïdjan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (75, 'Bahamas');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (76, 'Bahrain');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (77, 'Bangladesh');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (78, 'Biélorussie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (79, 'Belize');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (80, 'Benin');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (81, 'Bermudes');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (82, 'Bhoutan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (83, 'Bolivie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (84, 'Bosnie-Herzégovine');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (85, 'Botswana');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (86, 'Les Bouvet');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (87, 'Territoire britannique de l''océan Indien');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (88, 'Iles Vierges britanniques');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (89, 'Brunei');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (90, 'Burkina Faso');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (91, 'Burundi');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (92, 'Cambodge');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (93, 'Cameroun');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (94, 'Cap Vert');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (95, 'Iles Cayman');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (96, 'République centrafricaine');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (97, 'Tchad');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (98, 'Ile Christmas');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (99, 'Les Cocos');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (100, 'Comores');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (101, 'Rép. Dém. du Congo');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (102, 'Iles Cook');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (103, 'Cuba');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (104, 'Chypre');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (105, 'Djibouti');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (106, 'Dominique');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (107, 'République Dominicaine');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (108, 'Timor');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (109, 'Guinée Equatoriale');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (110, 'Erythrée');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (111, 'Estonie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (112, 'Ethiopie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (5, 'Algérie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (113, 'Ile Falkland');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (114, 'Iles Féroé');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (115, 'Fidji');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (116, 'Guyane française');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (117, 'Polynésie française');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (118, 'Territoires français du sud');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (119, 'Gabon');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (120, 'Gambie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (121, 'Géorgie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (122, 'Ghana');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (123, 'Gibraltar');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (124, 'Groenland');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (125, 'Grenade');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (126, 'Guadeloupe');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (127, 'Guam');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (128, 'Guatemala');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (129, 'Guinée');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (130, 'Guinée-Bissau');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (131, 'Guyane');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (132, 'Haïti');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (133, 'Iles Heard et McDonald');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (134, 'Honduras');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (135, 'Islande');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (136, 'Iran');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (137, 'Irak');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (138, 'Côte d''Ivoire');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (139, 'Jamaïque');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (140, 'Kazakhstan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (141, 'Kenya');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (142, 'Kiribati');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (143, 'Corée du Nord');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (144, 'Koweit');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (145, 'Kirghizistan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (146, 'Laos');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (147, 'Lettonie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (148, 'Lesotho');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (149, 'Libéria');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (150, 'Libye');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (151, 'Liechtenstein');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (152, 'Lithuanie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (153, 'Luxembourg');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (154, 'Macau');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (155, 'Macédoine du Nord');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (156, 'Madagascar');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (157, 'Malawi');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (158, 'Maldives');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (159, 'Mali');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (160, 'Malte');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (161, 'Iles Marshall');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (162, 'Martinique');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (163, 'Mauritanie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (164, 'Maurice');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (165, 'Mayotte');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (167, 'Moldavie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (168, 'Monaco');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (169, 'Mongolie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (170, 'Montserrat');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (171, 'Mozambique');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (172, 'Myanmar');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (173, 'Namibie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (174, 'Nauru');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (175, 'Nepal');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (176, 'Antilles néerlandaises');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (177, 'Nouvelle Calédonie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (178, 'Nicaragua');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (179, 'Niger');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (180, 'Nigeria');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (181, 'Niue');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (182, 'Iles Norfolk');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (183, 'Iles Mariannes du Nord');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (184, 'Oman');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (185, 'Palau');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (186, 'Panama');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (188, 'Paraguay');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (189, 'Iles Pitcairn');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (190, 'Qatar');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (191, 'La Réunion');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (192, 'Rwanda');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (193, 'Iles Géorgie du Sud et Sandwich du Sud');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (194, 'Saint-Kitts et Nevis');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (195, 'Sainte Lucie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (196, 'Saint Vincent et les Grenadines');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (198, 'Saint-Marin');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (199, 'Sao Tomé-et-Principe');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (200, 'Sénégal');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (201, 'Seychelles');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (202, 'Sierra Leone');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (203, 'Slovaquie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (204, 'Slovénie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (205, 'Somalie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (206, 'Sri Lanka');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (207, 'Sainte Hélène');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (208, 'Saint Pierre et Miquelon');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (209, 'Soudan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (210, 'Soudan du Sud');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (211, 'Suriname');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (212, 'Iles Svalbard et Jan Mayen');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (213, 'Swaziland');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (214, 'Syrie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (215, 'Tadjikistan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (216, 'Tanzanie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (217, 'Togo');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (218, 'Tokelau');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (219, 'Tonga');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (220, 'Trinité et Tobago');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (221, 'Tunisie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (222, 'Turkménistan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (223, 'Iles Turks et Caïques');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (224, 'Tuvalu');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (225, 'Iles Mineures éloignées des Etats-Unis');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (226, 'Ouganda');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (227, 'Uruguay');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (228, 'Ouzbékistan');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (229, 'Vanuatu');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (230, 'Vatican');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (231, 'Vietnam');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (232, 'Iles Vierges');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (233, 'Wallis et Futuna');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (234, 'Yemen');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (235, 'Zaïre');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (236, 'Zambie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (237, 'Zimbabwe');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (238, 'La Barbad');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (166, 'Micronésie');
INSERT INTO public.pays (pays_id, pays_nom) VALUES (187, 'Papouasie-Nouvelle-Guinée');


--
-- TOC entry 3479 (class 0 OID 20893)
-- Dependencies: 231
-- Data for Name: personne; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.personne (personne_id, nom, prenom, login, password, role_id, first_connection_token, first_connection_token_expiry) VALUES (2, 'Smith', 'Alice', 'admin', '$2a$15$DjmRqv2N0PE7bHpAJWSTz.5VvxjJtrg0kIpeQfDQDmw/BiIk1RAdu', 2, NULL, NULL);
INSERT INTO public.personne (personne_id, nom, prenom, login, password, role_id, first_connection_token, first_connection_token_expiry) VALUES (541, 'M', 'JYM', 'JYM', '$2a$15$70bCEAl4FT37ZosLlPKdoOfvrZSq57aSGfrOjoUrKQoy06s9EEtqG', 2, NULL, NULL);
INSERT INTO public.personne (personne_id, nom, prenom, login, password, role_id, first_connection_token, first_connection_token_expiry) VALUES (1595, 'GUYOT', 'Emilie', 'EmilieVE', '$2a$15$Xj4LJRSK.J6WHQ8EWvR1duj/VF/xBy.w7OMSlkN3qXoAx2HblVsrS', 3, NULL, NULL);


--
-- TOC entry 3481 (class 0 OID 20899)
-- Dependencies: 233
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.role (role_id, role_nom) VALUES (2, 'Admin');
INSERT INTO public.role (role_id, role_nom) VALUES (3, 'Assistant');
INSERT INTO public.role (role_id, role_nom) VALUES (1, 'Eleve');


--
-- TOC entry 3483 (class 0 OID 20903)
-- Dependencies: 235
-- Data for Name: souhait; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.souhait (souhait_id, souhait_type, souhait_ordre) VALUES (1, 'Seul absolument', 1);
INSERT INTO public.souhait (souhait_id, souhait_type, souhait_ordre) VALUES (2, 'De préférence seul', 2);
INSERT INTO public.souhait (souhait_id, souhait_type, souhait_ordre) VALUES (3, 'Peu importe', 5);
INSERT INTO public.souhait (souhait_id, souhait_type, souhait_ordre) VALUES (4, 'De préférence en colocation', 3);
INSERT INTO public.souhait (souhait_id, souhait_type, souhait_ordre) VALUES (5, 'En colocation absolument', 4);


--
-- TOC entry 3485 (class 0 OID 20907)
-- Dependencies: 237
-- Data for Name: statut; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.statut (statut_id, statut_nom) VALUES (1, 'Non traitée');
INSERT INTO public.statut (statut_id, statut_nom) VALUES (2, 'Traitée');


--
-- TOC entry 3487 (class 0 OID 20911)
-- Dependencies: 239
-- Data for Name: type_appart; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.type_appart (type_appart_id, type_appart_nom) VALUES (1, 'Studio');
INSERT INTO public.type_appart (type_appart_id, type_appart_nom) VALUES (2, 'T1');
INSERT INTO public.type_appart (type_appart_id, type_appart_nom) VALUES (3, 'Colocation');


--
-- TOC entry 3489 (class 0 OID 20915)
-- Dependencies: 241
-- Data for Name: type_modif; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.type_modif (type_id, nom) VALUES (1, 'date_debut');
INSERT INTO public.type_modif (type_id, nom) VALUES (2, 'date_fin');
INSERT INTO public.type_modif (type_id, nom) VALUES (3, 'message_pge_connexion');
INSERT INTO public.type_modif (type_id, nom) VALUES (4, 'message_page_informations');
INSERT INTO public.type_modif (type_id, nom) VALUES (5, 'message_page_attente');
INSERT INTO public.type_modif (type_id, nom) VALUES (6, 'message_mission_fermee');
INSERT INTO public.type_modif (type_id, nom) VALUES (8, 'adresse_mail_envoyeur');
INSERT INTO public.type_modif (type_id, nom) VALUES (7, 'message_contact');
INSERT INTO public.type_modif (type_id, nom) VALUES (9, 'message_avant_connexion');


--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 215
-- Name: alerte_alerte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.alerte_alerte_id_seq', 64, true);


--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 217
-- Name: config_modif_modif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.config_modif_modif_id_seq', 157, true);


--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 219
-- Name: connexion_connexion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.connexion_connexion_id_seq', 3, true);


--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 221
-- Name: date_date_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.date_date_id_seq', 1, false);


--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 223
-- Name: formulaire_formulaire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.formulaire_formulaire_id_seq', 1557, true);


--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 225
-- Name: genre_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.genre_genre_id_seq', 3, true);


--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 228
-- Name: mission_logement_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.mission_logement_status_id_seq', 1, false);


--
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 230
-- Name: pays_pays_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pays_pays_id_seq', 240, true);


--
-- TOC entry 3519 (class 0 OID 0)
-- Dependencies: 232
-- Name: personne_personne_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.personne_personne_id_seq', 1613, true);


--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 234
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.role_role_id_seq', 3, true);


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 236
-- Name: souhait_souhait_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.souhait_souhait_id_seq', 5, true);


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 238
-- Name: statut_statut_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.statut_statut_id_seq', 2, true);


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 240
-- Name: type_appart_type_appart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.type_appart_type_appart_id_seq', 3, true);


--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 242
-- Name: type_modif_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.type_modif_type_id_seq', 8, true);


--
-- TOC entry 3281 (class 2606 OID 20936)
-- Name: config_modif config_modif_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.config_modif
    ADD CONSTRAINT config_modif_pk PRIMARY KEY (modif_id);


--
-- TOC entry 3283 (class 2606 OID 20938)
-- Name: connexion connexion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connexion
    ADD CONSTRAINT connexion_pkey PRIMARY KEY (connexion_id);


--
-- TOC entry 3285 (class 2606 OID 20940)
-- Name: date date_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date
    ADD CONSTRAINT date_pk PRIMARY KEY (date_id);


--
-- TOC entry 3287 (class 2606 OID 20942)
-- Name: formulaire formulaire_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulaire
    ADD CONSTRAINT formulaire_pk PRIMARY KEY (formulaire_id);


--
-- TOC entry 3289 (class 2606 OID 20944)
-- Name: genre genre_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pk PRIMARY KEY (genre_id);


--
-- TOC entry 3291 (class 2606 OID 20946)
-- Name: logement logement_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logement
    ADD CONSTRAINT logement_pk PRIMARY KEY (numero_logement);


--
-- TOC entry 3293 (class 2606 OID 20948)
-- Name: mission_logement_status mission_logement_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mission_logement_status
    ADD CONSTRAINT mission_logement_status_pkey PRIMARY KEY (id);


--
-- TOC entry 3295 (class 2606 OID 20950)
-- Name: pays pays_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pays
    ADD CONSTRAINT pays_pk PRIMARY KEY (pays_id);


--
-- TOC entry 3297 (class 2606 OID 20952)
-- Name: personne personne_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT personne_pk PRIMARY KEY (personne_id);


--
-- TOC entry 3279 (class 2606 OID 20954)
-- Name: alerte pk_alerte; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerte
    ADD CONSTRAINT pk_alerte PRIMARY KEY (alerte_id);


--
-- TOC entry 3299 (class 2606 OID 20956)
-- Name: role role_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pk PRIMARY KEY (role_id);


--
-- TOC entry 3301 (class 2606 OID 20958)
-- Name: souhait souhait_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.souhait
    ADD CONSTRAINT souhait_pk PRIMARY KEY (souhait_id);


--
-- TOC entry 3303 (class 2606 OID 20960)
-- Name: statut statut_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statut
    ADD CONSTRAINT statut_pk PRIMARY KEY (statut_id);


--
-- TOC entry 3305 (class 2606 OID 20962)
-- Name: type_appart type_appart_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_appart
    ADD CONSTRAINT type_appart_pk PRIMARY KEY (type_appart_id);


--
-- TOC entry 3307 (class 2606 OID 20964)
-- Name: type_modif type_modif_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_modif
    ADD CONSTRAINT type_modif_pk PRIMARY KEY (type_id);


--
-- TOC entry 3308 (class 2606 OID 20965)
-- Name: alerte eleve_alerte_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerte
    ADD CONSTRAINT eleve_alerte_fk FOREIGN KEY (formulaire_id) REFERENCES public.formulaire(formulaire_id);


--
-- TOC entry 3312 (class 2606 OID 20970)
-- Name: formulaire genre_attendy_formulaire_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulaire
    ADD CONSTRAINT genre_attendy_formulaire_fk FOREIGN KEY (genre_attendu) REFERENCES public.genre(genre_id) NOT VALID;


--
-- TOC entry 3313 (class 2606 OID 20975)
-- Name: formulaire genre_formulaire_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulaire
    ADD CONSTRAINT genre_formulaire_fk FOREIGN KEY (genre_id) REFERENCES public.genre(genre_id);


--
-- TOC entry 3314 (class 2606 OID 20980)
-- Name: formulaire logement_eleve_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulaire
    ADD CONSTRAINT logement_eleve_fk FOREIGN KEY (numero_logement) REFERENCES public.logement(numero_logement);


--
-- TOC entry 3315 (class 2606 OID 20985)
-- Name: formulaire pays_formulaire_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulaire
    ADD CONSTRAINT pays_formulaire_fk FOREIGN KEY (pays_id) REFERENCES public.pays(pays_id);


--
-- TOC entry 3311 (class 2606 OID 20990)
-- Name: connexion personne_connexion_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connexion
    ADD CONSTRAINT personne_connexion_fk FOREIGN KEY (personne_id) REFERENCES public.personne(personne_id);


--
-- TOC entry 3316 (class 2606 OID 20995)
-- Name: formulaire personne_eleve_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulaire
    ADD CONSTRAINT personne_eleve_fk FOREIGN KEY (personne_id) REFERENCES public.personne(personne_id);


--
-- TOC entry 3319 (class 2606 OID 21000)
-- Name: personne role_personne_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT role_personne_fk FOREIGN KEY (role_id) REFERENCES public.role(role_id);


--
-- TOC entry 3317 (class 2606 OID 21005)
-- Name: formulaire souhait_eleve_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulaire
    ADD CONSTRAINT souhait_eleve_fk FOREIGN KEY (souhait_id) REFERENCES public.souhait(souhait_id);


--
-- TOC entry 3309 (class 2606 OID 21010)
-- Name: alerte statut_alerte_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerte
    ADD CONSTRAINT statut_alerte_fk FOREIGN KEY (statut_id) REFERENCES public.statut(statut_id);


--
-- TOC entry 3318 (class 2606 OID 21015)
-- Name: logement type_appart_logement_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logement
    ADD CONSTRAINT type_appart_logement_fk FOREIGN KEY (type_appart_id) REFERENCES public.type_appart(type_appart_id);


--
-- TOC entry 3310 (class 2606 OID 21020)
-- Name: config_modif type_modif_config_modif_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.config_modif
    ADD CONSTRAINT type_modif_config_modif_fk FOREIGN KEY (type_id) REFERENCES public.type_modif(type_id);


-- Completed on 2025-10-07 07:42:40 CEST

--
-- PostgreSQL database dump complete
--

