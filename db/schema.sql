--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acls; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE acls (
    id integer NOT NULL,
    user_id integer NOT NULL,
    language character varying NOT NULL,
    slug character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE acls OWNER TO exercism;

--
-- Name: acls_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE acls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acls_id_seq OWNER TO exercism;

--
-- Name: acls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE acls_id_seq OWNED BY acls.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: exercism
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


ALTER TABLE comments OWNER TO exercism;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_id_seq OWNER TO exercism;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: conversation_subscriptions; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE conversation_subscriptions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    solution_id integer NOT NULL,
    subscribed boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE conversation_subscriptions OWNER TO exercism;

--
-- Name: conversation_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE conversation_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE conversation_subscriptions_id_seq OWNER TO exercism;

--
-- Name: conversation_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE conversation_subscriptions_id_seq OWNED BY conversation_subscriptions.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE likes (
    id integer NOT NULL,
    submission_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE likes OWNER TO exercism;

--
-- Name: submissions; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE submissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    key character varying,
    state character varying,
    language character varying,
    slug character varying,
    done_at timestamp without time zone,
    is_liked boolean,
    nit_count integer NOT NULL,
    version integer,
    user_exercise_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    solution text
);


ALTER TABLE submissions OWNER TO exercism;

--
-- Name: user_exercises; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE user_exercises (
    id integer NOT NULL,
    user_id integer NOT NULL,
    language character varying,
    slug character varying,
    iteration_count integer,
    state character varying,
    key character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    archived boolean DEFAULT false,
    last_iteration_at timestamp without time zone,
    last_activity_at timestamp without time zone,
    last_activity character varying,
    fetched_at timestamp without time zone,
    skipped_at timestamp without time zone,
    help_requested boolean DEFAULT false
);


ALTER TABLE user_exercises OWNER TO exercism;

--
-- Name: users; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE users (
    id integer NOT NULL,
    username citext,
    email character varying,
    avatar_url character varying,
    github_id integer,
    key character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    onboarded_at timestamp without time zone,
    track_mentor text,
    joined_as character varying,
    api_secret character varying,
    api_key character varying,
    share_key character varying
);


ALTER TABLE users OWNER TO exercism;

--
-- Name: dailies; Type: VIEW; Schema: public; Owner: exercism
--

CREATE VIEW dailies AS
 SELECT acls.user_id,
    ue.key,
    u.username,
    ue.slug,
    ue.language,
    COALESCE(count(c.id), (0)::bigint) AS count,
    ucl.user_exercise_id
   FROM (((((acls
     JOIN user_exercises ue ON ((((ue.language)::text = (acls.language)::text) AND ((ue.slug)::text = (acls.slug)::text))))
     JOIN submissions s ON ((ue.id = s.user_exercise_id)))
     JOIN users u ON ((u.id = ue.user_id)))
     LEFT JOIN comments c ON ((c.submission_id = s.id)))
     LEFT JOIN ( SELECT submissions.user_exercise_id,
            comments.user_id
           FROM (comments
             JOIN submissions ON ((submissions.id = comments.submission_id)))
        UNION
         SELECT submissions.user_exercise_id,
            likes.user_id
           FROM (likes
             JOIN submissions ON ((submissions.id = likes.submission_id)))) ucl ON (((ucl.user_id = acls.user_id) AND (ue.id = ucl.user_exercise_id))))
  WHERE ((ue.archived = false) AND ((ue.slug)::text <> 'hello-world'::text) AND (ue.user_id <> acls.user_id) AND (ue.last_iteration_at > (now() - '30 days'::interval)) AND (ucl.user_exercise_id IS NULL))
  GROUP BY acls.user_id, ue.key, u.username, ue.slug, ue.language, ucl.user_exercise_id
  ORDER BY COALESCE(count(c.id), (0)::bigint);


ALTER TABLE dailies OWNER TO exercism;

--
-- Name: daily_counts; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE daily_counts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    total integer NOT NULL,
    day date NOT NULL
);


ALTER TABLE daily_counts OWNER TO exercism;

--
-- Name: daily_counts_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE daily_counts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE daily_counts_id_seq OWNER TO exercism;

--
-- Name: daily_counts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE daily_counts_id_seq OWNED BY daily_counts.id;


--
-- Name: deleted_iterations; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE deleted_iterations (
    id integer NOT NULL,
    user_id integer NOT NULL,
    submission_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE deleted_iterations OWNER TO exercism;

--
-- Name: deleted_iterations_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE deleted_iterations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE deleted_iterations_id_seq OWNER TO exercism;

--
-- Name: deleted_iterations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE deleted_iterations_id_seq OWNED BY deleted_iterations.id;


--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE likes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE likes_id_seq OWNER TO exercism;

--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE likes_id_seq OWNED BY likes.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    read boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    action character varying,
    actor_id integer,
    solution_id integer,
    iteration_id integer
);


ALTER TABLE notifications OWNER TO exercism;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notifications_id_seq OWNER TO exercism;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO exercism;

--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE submissions_id_seq OWNER TO exercism;

--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE submissions_id_seq OWNED BY submissions.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE tags OWNER TO exercism;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tags_id_seq OWNER TO exercism;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: team_managers; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE team_managers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    team_id integer NOT NULL
);


ALTER TABLE team_managers OWNER TO exercism;

--
-- Name: team_managers_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE team_managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE team_managers_id_seq OWNER TO exercism;

--
-- Name: team_managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE team_managers_id_seq OWNED BY team_managers.id;


--
-- Name: team_memberships; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE team_memberships (
    id integer NOT NULL,
    team_id integer NOT NULL,
    user_id integer NOT NULL,
    confirmed boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    inviter_id integer
);


ALTER TABLE team_memberships OWNER TO exercism;

--
-- Name: team_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE team_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE team_memberships_id_seq OWNER TO exercism;

--
-- Name: team_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE team_memberships_id_seq OWNED BY team_memberships.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE teams (
    id integer NOT NULL,
    slug character varying NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text,
    public boolean DEFAULT false,
    tags integer[] DEFAULT '{}'::integer[]
);


ALTER TABLE teams OWNER TO exercism;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teams_id_seq OWNER TO exercism;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: user_exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE user_exercises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_exercises_id_seq OWNER TO exercism;

--
-- Name: user_exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE user_exercises_id_seq OWNED BY user_exercises.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO exercism;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: views; Type: TABLE; Schema: public; Owner: exercism
--

CREATE TABLE views (
    id integer NOT NULL,
    user_id integer NOT NULL,
    exercise_id integer NOT NULL,
    last_viewed_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE views OWNER TO exercism;

--
-- Name: views_id_seq; Type: SEQUENCE; Schema: public; Owner: exercism
--

CREATE SEQUENCE views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE views_id_seq OWNER TO exercism;

--
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exercism
--

ALTER SEQUENCE views_id_seq OWNED BY views.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY acls ALTER COLUMN id SET DEFAULT nextval('acls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY conversation_subscriptions ALTER COLUMN id SET DEFAULT nextval('conversation_subscriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY daily_counts ALTER COLUMN id SET DEFAULT nextval('daily_counts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY deleted_iterations ALTER COLUMN id SET DEFAULT nextval('deleted_iterations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY likes ALTER COLUMN id SET DEFAULT nextval('likes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY submissions ALTER COLUMN id SET DEFAULT nextval('submissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


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
-- Name: id; Type: DEFAULT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY views ALTER COLUMN id SET DEFAULT nextval('views_id_seq'::regclass);


--
-- Name: acls_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY acls
    ADD CONSTRAINT acls_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: conversation_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY conversation_subscriptions
    ADD CONSTRAINT conversation_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: daily_counts_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY daily_counts
    ADD CONSTRAINT daily_counts_pkey PRIMARY KEY (id);


--
-- Name: deleted_iterations_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY deleted_iterations
    ADD CONSTRAINT deleted_iterations_pkey PRIMARY KEY (id);


--
-- Name: likes_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: team_managers_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY team_managers
    ADD CONSTRAINT team_managers_pkey PRIMARY KEY (id);


--
-- Name: team_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY team_memberships
    ADD CONSTRAINT team_memberships_pkey PRIMARY KEY (id);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: user_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY user_exercises
    ADD CONSTRAINT user_exercises_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: views_pkey; Type: CONSTRAINT; Schema: public; Owner: exercism
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- Name: index_acls_on_user_id_and_language_and_slug; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX index_acls_on_user_id_and_language_and_slug ON acls USING btree (user_id, language, slug);


--
-- Name: index_comments_on_submission_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_comments_on_submission_id ON comments USING btree (submission_id);


--
-- Name: index_conversation_subscriptions_on_solution_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_conversation_subscriptions_on_solution_id ON conversation_subscriptions USING btree (solution_id);


--
-- Name: index_conversation_subscriptions_on_user_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_conversation_subscriptions_on_user_id ON conversation_subscriptions USING btree (user_id);


--
-- Name: index_conversation_subscriptions_on_user_solution; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX index_conversation_subscriptions_on_user_solution ON conversation_subscriptions USING btree (user_id, solution_id);


--
-- Name: index_conversation_subscriptions_on_user_submission; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX index_conversation_subscriptions_on_user_submission ON deleted_iterations USING btree (user_id, submission_id);


--
-- Name: index_daily_counts_on_user_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_daily_counts_on_user_id ON daily_counts USING btree (user_id);


--
-- Name: index_daily_counts_on_user_id_and_day; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX index_daily_counts_on_user_id_and_day ON daily_counts USING btree (user_id, day);


--
-- Name: index_deleted_iterations_on_submission_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_deleted_iterations_on_submission_id ON deleted_iterations USING btree (submission_id);


--
-- Name: index_deleted_iterations_on_user_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_deleted_iterations_on_user_id ON deleted_iterations USING btree (user_id);


--
-- Name: index_notifications_on_user_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_notifications_on_user_id ON notifications USING btree (user_id);


--
-- Name: index_submissions_on_key; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_submissions_on_key ON submissions USING btree (key);


--
-- Name: index_submissions_on_user_exercise_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_submissions_on_user_exercise_id ON submissions USING btree (user_exercise_id);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_tags_similarity_on_name; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_tags_similarity_on_name ON tags USING gist (name gist_trgm_ops);


--
-- Name: index_teams_on_public; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_teams_on_public ON teams USING btree (public);


--
-- Name: index_teams_on_slug; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX index_teams_on_slug ON teams USING btree (slug);


--
-- Name: index_teams_on_tags; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_teams_on_tags ON teams USING gin (tags);


--
-- Name: index_user_exercises_on_key; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX index_user_exercises_on_key ON user_exercises USING btree (key);


--
-- Name: index_user_exercises_on_language_and_slug_and_state; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_user_exercises_on_language_and_slug_and_state ON user_exercises USING btree (language, slug, state);


--
-- Name: index_user_exercises_on_user_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_user_exercises_on_user_id ON user_exercises USING btree (user_id);


--
-- Name: index_user_exercises_on_user_id_and_language_and_slug; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX index_user_exercises_on_user_id_and_language_and_slug ON user_exercises USING btree (user_id, language, slug);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: exercism
--

CREATE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: index_views_on_user_id_and_exercise_id; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX index_views_on_user_id_and_exercise_id ON views USING btree (user_id, exercise_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: exercism
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

