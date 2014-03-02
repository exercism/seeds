--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
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
-- Name: alerts; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE alerts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    text text,
    url character varying(255),
    link_text character varying(255),
    read boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.alerts OWNER TO exercism;

--
-- Name: alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alerts_id_seq OWNER TO exercism;

--
-- Name: alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE alerts_id_seq OWNED BY alerts.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    user_id integer NOT NULL,
    submission_id integer NOT NULL,
    body text,
    html_body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO exercism;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO exercism;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE likes (
    id integer NOT NULL,
    submission_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.likes OWNER TO exercism;

--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE likes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.likes_id_seq OWNER TO exercism;

--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE likes_id_seq OWNED BY likes.id;


--
-- Name: log_entries; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE log_entries (
    id integer NOT NULL,
    user_id integer,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.log_entries OWNER TO exercism;

--
-- Name: log_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE log_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_entries_id_seq OWNER TO exercism;

--
-- Name: log_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE log_entries_id_seq OWNED BY log_entries.id;


--
-- Name: muted_submissions; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE muted_submissions (
    id integer NOT NULL,
    submission_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.muted_submissions OWNER TO exercism;

--
-- Name: muted_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE muted_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muted_submissions_id_seq OWNER TO exercism;

--
-- Name: muted_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE muted_submissions_id_seq OWNED BY muted_submissions.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    item_id integer,
    regarding character varying(255),
    read boolean,
    count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    item_type character varying(255),
    creator_id integer
);


ALTER TABLE public.notifications OWNER TO exercism;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO exercism;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO exercism;

--
-- Name: submission_viewers; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE submission_viewers (
    id integer NOT NULL,
    submission_id integer NOT NULL,
    viewer_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.submission_viewers OWNER TO exercism;

--
-- Name: submission_viewers_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE submission_viewers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submission_viewers_id_seq OWNER TO exercism;

--
-- Name: submission_viewers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE submission_viewers_id_seq OWNED BY submission_viewers.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE submissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    key character varying(255),
    state character varying(255),
    language character varying(255),
    slug character varying(255),
    code text,
    done_at timestamp without time zone,
    is_liked boolean,
    nit_count integer NOT NULL,
    version integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_exercise_id integer,
    filename character varying(255)
);


ALTER TABLE public.submissions OWNER TO exercism;

--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submissions_id_seq OWNER TO exercism;

--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE submissions_id_seq OWNED BY submissions.id;


--
-- Name: team_managers; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE team_managers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    team_id integer NOT NULL
);


ALTER TABLE public.team_managers OWNER TO exercism;

--
-- Name: team_managers_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE team_managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_managers_id_seq OWNER TO exercism;

--
-- Name: team_managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE team_managers_id_seq OWNED BY team_managers.id;


--
-- Name: team_memberships; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE team_memberships (
    id integer NOT NULL,
    team_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    confirmed boolean
);


ALTER TABLE public.team_memberships OWNER TO exercism;

--
-- Name: team_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE team_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_memberships_id_seq OWNER TO exercism;

--
-- Name: team_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE team_memberships_id_seq OWNED BY team_memberships.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE teams (
    id integer NOT NULL,
    slug character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255)
);


ALTER TABLE public.teams OWNER TO exercism;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_id_seq OWNER TO exercism;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: user_exercises; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE user_exercises (
    id integer NOT NULL,
    user_id integer NOT NULL,
    language character varying(255),
    slug character varying(255),
    iteration_count integer,
    state character varying(255),
    completed_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    key character varying(255),
    is_nitpicker boolean DEFAULT false
);


ALTER TABLE public.user_exercises OWNER TO exercism;

--
-- Name: user_exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE user_exercises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_exercises_id_seq OWNER TO exercism;

--
-- Name: user_exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE user_exercises_id_seq OWNED BY user_exercises.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: exercism; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    avatar_url character varying(255),
    github_id integer,
    key character varying(255),
    mastery text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO exercism;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO exercism;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY alerts ALTER COLUMN id SET DEFAULT nextval('alerts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY likes ALTER COLUMN id SET DEFAULT nextval('likes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY log_entries ALTER COLUMN id SET DEFAULT nextval('log_entries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY muted_submissions ALTER COLUMN id SET DEFAULT nextval('muted_submissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY submission_viewers ALTER COLUMN id SET DEFAULT nextval('submission_viewers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY submissions ALTER COLUMN id SET DEFAULT nextval('submissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY team_managers ALTER COLUMN id SET DEFAULT nextval('team_managers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY team_memberships ALTER COLUMN id SET DEFAULT nextval('team_memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY user_exercises ALTER COLUMN id SET DEFAULT nextval('user_exercises_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: likes_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: log_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY log_entries
    ADD CONSTRAINT log_entries_pkey PRIMARY KEY (id);


--
-- Name: muted_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY muted_submissions
    ADD CONSTRAINT muted_submissions_pkey PRIMARY KEY (id);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: submission_viewers_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY submission_viewers
    ADD CONSTRAINT submission_viewers_pkey PRIMARY KEY (id);


--
-- Name: submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: team_managers_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY team_managers
    ADD CONSTRAINT team_managers_pkey PRIMARY KEY (id);


--
-- Name: team_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY team_memberships
    ADD CONSTRAINT team_memberships_pkey PRIMARY KEY (id);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: user_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY user_exercises
    ADD CONSTRAINT user_exercises_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: by_submission; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE UNIQUE INDEX by_submission ON submission_viewers USING btree (submission_id, viewer_id);


--
-- Name: index_alerts_on_user_id; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE INDEX index_alerts_on_user_id ON alerts USING btree (user_id);


--
-- Name: index_submissions_on_key; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE INDEX index_submissions_on_key ON submissions USING btree (key);


--
-- Name: index_submissions_on_user_exercise_id; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE INDEX index_submissions_on_user_exercise_id ON submissions USING btree (user_exercise_id);


--
-- Name: index_teams_on_slug; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE UNIQUE INDEX index_teams_on_slug ON teams USING btree (slug);


--
-- Name: index_user_exercises_on_key; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE UNIQUE INDEX index_user_exercises_on_key ON user_exercises USING btree (key);


--
-- Name: index_user_exercises_on_language_and_slug_and_state; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE INDEX index_user_exercises_on_language_and_slug_and_state ON user_exercises USING btree (language, slug, state);


--
-- Name: index_user_exercises_on_user_id; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE INDEX index_user_exercises_on_user_id ON user_exercises USING btree (user_id);


--
-- Name: index_user_exercises_on_user_id_and_language_and_slug; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE UNIQUE INDEX index_user_exercises_on_user_id_and_language_and_slug ON user_exercises USING btree (user_id, language, slug);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: exercism; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

