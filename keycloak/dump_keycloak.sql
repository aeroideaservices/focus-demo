--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

\c postgres
DROP DATABASE keycloak  WITH (FORCE);




--
-- Drop roles
--

DROP ROLE keycloak;


--
-- Roles
--

CREATE ROLE keycloak;
ALTER ROLE keycloak WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:f46G66+kC34EZXGzP81yXg==$/7Px379SoBstwVOgZXoBcx2jGActYoaoEB8RSR+hXeg=:0TPUB/4SVojUSq5mVCfTlRurntGeEjM0vmYxx6jI3ys=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO keycloak;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: keycloak
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: keycloak
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: keycloak
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "keycloak" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

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
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO keycloak;

\connect keycloak

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
235be761-d204-48bb-8f23-9a72add1b5c2	f4853d92-95f8-416f-9ae0-3f8e314aa1e4
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
df9ebd87-025e-46f1-9236-334109ad5fbd	\N	auth-cookie	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	d0c3fe24-66ee-496d-8053-dd806c2b45b2	2	10	f	\N	\N
23679908-1fce-4fa9-ad92-796283f4dd99	\N	auth-spnego	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	d0c3fe24-66ee-496d-8053-dd806c2b45b2	3	20	f	\N	\N
fbe9a933-2ff0-41ab-8a54-d853b1dde43f	\N	identity-provider-redirector	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	d0c3fe24-66ee-496d-8053-dd806c2b45b2	2	25	f	\N	\N
f5668924-f45e-41f1-b78d-9a48166ccf04	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	d0c3fe24-66ee-496d-8053-dd806c2b45b2	2	30	t	169760d7-264b-45a0-83fa-5b23d8ea1b5d	\N
93ec4d6d-bee5-4a36-8195-fa3b7c6d61bb	\N	auth-username-password-form	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	169760d7-264b-45a0-83fa-5b23d8ea1b5d	0	10	f	\N	\N
2bad0d3e-fc73-4659-953d-28474876ecbf	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	169760d7-264b-45a0-83fa-5b23d8ea1b5d	1	20	t	1fa7e89b-91ef-413f-bd12-d0d7dfe75c4a	\N
5ac37bee-1ed2-4637-9ee6-f378dfce1f29	\N	conditional-user-configured	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	1fa7e89b-91ef-413f-bd12-d0d7dfe75c4a	0	10	f	\N	\N
d3244838-ca88-4aec-a06d-5d1a8a2dc5d3	\N	auth-otp-form	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	1fa7e89b-91ef-413f-bd12-d0d7dfe75c4a	0	20	f	\N	\N
b804c286-20a5-4268-9eb0-6521113693c3	\N	direct-grant-validate-username	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	e8100237-cf94-435d-83a8-9a55f172fcf5	0	10	f	\N	\N
9d778085-077e-4c32-90ff-580c36bb1c6f	\N	direct-grant-validate-password	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	e8100237-cf94-435d-83a8-9a55f172fcf5	0	20	f	\N	\N
398b9340-cb95-4d29-b5de-03c54b990ccd	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	e8100237-cf94-435d-83a8-9a55f172fcf5	1	30	t	a64c2f32-ea3a-4e82-90be-92ed68f03940	\N
c8128c45-d001-419e-aa81-b52e165a6c27	\N	conditional-user-configured	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	a64c2f32-ea3a-4e82-90be-92ed68f03940	0	10	f	\N	\N
6e3501cc-20c9-4dc9-93ee-1258ca07b83c	\N	direct-grant-validate-otp	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	a64c2f32-ea3a-4e82-90be-92ed68f03940	0	20	f	\N	\N
d4af9037-704b-4ee4-ad45-ad3e9d778d73	\N	registration-page-form	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	cacc2361-9f62-4181-b18a-91325963ca60	0	10	t	1e5c89a9-0c9d-4c1a-be24-a346416ec040	\N
f7635c4b-78cf-4c74-a536-9d1637c79a6b	\N	registration-user-creation	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	1e5c89a9-0c9d-4c1a-be24-a346416ec040	0	20	f	\N	\N
393f0830-dc8a-471f-8896-bca56755f6bc	\N	registration-profile-action	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	1e5c89a9-0c9d-4c1a-be24-a346416ec040	0	40	f	\N	\N
67ee35ee-9ab0-4fc9-b5f3-5535d4117268	\N	registration-password-action	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	1e5c89a9-0c9d-4c1a-be24-a346416ec040	0	50	f	\N	\N
f07dbb48-69ed-40af-81a6-552eb8292976	\N	registration-recaptcha-action	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	1e5c89a9-0c9d-4c1a-be24-a346416ec040	3	60	f	\N	\N
5951c1b4-0e74-4fc1-835d-a27aa77cabd5	\N	reset-credentials-choose-user	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	b6ad110e-135d-4fea-8ec7-818f13db76e7	0	10	f	\N	\N
db08360d-1bff-4295-b878-2370e8b67394	\N	reset-credential-email	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	b6ad110e-135d-4fea-8ec7-818f13db76e7	0	20	f	\N	\N
d23b2dbd-bd04-41e8-937d-0a4f0f288667	\N	reset-password	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	b6ad110e-135d-4fea-8ec7-818f13db76e7	0	30	f	\N	\N
02a7f7ed-b239-4d67-8664-1a4139e4add0	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	b6ad110e-135d-4fea-8ec7-818f13db76e7	1	40	t	11e32156-6138-413f-84e4-82b83b7df67d	\N
0ba5a747-63e0-484a-8a83-4eaba8df3bf5	\N	conditional-user-configured	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	11e32156-6138-413f-84e4-82b83b7df67d	0	10	f	\N	\N
55997c09-63ee-499f-9b4b-596f608c85b0	\N	reset-otp	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	11e32156-6138-413f-84e4-82b83b7df67d	0	20	f	\N	\N
168462fe-7ac3-48c7-8756-e8c8b34e4c0d	\N	client-secret	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	7cf6446c-a53a-4eb5-b5c2-c7132692491b	2	10	f	\N	\N
524f17d0-f282-4625-add1-2b5cd34c06b6	\N	client-jwt	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	7cf6446c-a53a-4eb5-b5c2-c7132692491b	2	20	f	\N	\N
d4f434ad-fed1-4a28-a8d8-9c2fc945a880	\N	client-secret-jwt	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	7cf6446c-a53a-4eb5-b5c2-c7132692491b	2	30	f	\N	\N
39c84809-ff5a-48e6-a91d-a69c02eb2478	\N	client-x509	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	7cf6446c-a53a-4eb5-b5c2-c7132692491b	2	40	f	\N	\N
f47ca29e-0832-4d34-82e0-85a735aa6706	\N	idp-review-profile	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	8b161065-38b6-4f67-8a94-c67e5adc1119	0	10	f	\N	106b1c6e-594a-4ebf-841b-c43b95330e12
7b12acc8-71fc-4163-9522-20c12e52b5ea	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	8b161065-38b6-4f67-8a94-c67e5adc1119	0	20	t	5426eaf1-70eb-4f76-b980-4abd73070942	\N
f02d9bc9-ca20-4fee-b87e-b9fe79d33705	\N	idp-create-user-if-unique	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	5426eaf1-70eb-4f76-b980-4abd73070942	2	10	f	\N	de54662d-2438-4e58-8e66-d1d3b115ffd3
a9a9e1e9-a92a-4918-992e-f77bc7c19f64	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	5426eaf1-70eb-4f76-b980-4abd73070942	2	20	t	bf2a260f-b7a7-4baf-b915-9ade4ab4752c	\N
30f9e2c9-2944-4885-a928-09a253b63943	\N	idp-confirm-link	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	bf2a260f-b7a7-4baf-b915-9ade4ab4752c	0	10	f	\N	\N
4b1fef03-b6c3-42bd-b5dc-a97c404d3b82	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	bf2a260f-b7a7-4baf-b915-9ade4ab4752c	0	20	t	f730014b-2fbe-43d2-8415-3c2b6c44c904	\N
8af47a39-08f9-41d0-b68e-86af5577774a	\N	idp-email-verification	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	f730014b-2fbe-43d2-8415-3c2b6c44c904	2	10	f	\N	\N
6fb4c0f6-ccff-4ee9-8fa4-d48dd2569761	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	f730014b-2fbe-43d2-8415-3c2b6c44c904	2	20	t	020a658d-d330-4499-a581-9abecd8496ba	\N
04caef66-64de-4614-b4ab-c45a949725f3	\N	idp-username-password-form	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	020a658d-d330-4499-a581-9abecd8496ba	0	10	f	\N	\N
e65fa8b7-4870-4a58-8bae-ff81bdd37599	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	020a658d-d330-4499-a581-9abecd8496ba	1	20	t	e7b0c0ca-36a3-47b8-8989-f5a78b4bd258	\N
9d644180-7b3b-4fd2-8d2e-d21bce1be4df	\N	conditional-user-configured	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	e7b0c0ca-36a3-47b8-8989-f5a78b4bd258	0	10	f	\N	\N
c12ac007-36ef-4303-8c92-b5b370fd3c21	\N	auth-otp-form	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	e7b0c0ca-36a3-47b8-8989-f5a78b4bd258	0	20	f	\N	\N
b3b3901f-2532-49d4-9fcc-57c47f9048f1	\N	http-basic-authenticator	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	069b6fc0-19cb-4f8d-862d-e3d511f8eac1	0	10	f	\N	\N
e05d87d0-bfc8-4358-850b-aa72b7bede83	\N	docker-http-basic-authenticator	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	591ed8c8-25a7-4fe6-80dc-85a10fee54d9	0	10	f	\N	\N
8571ca18-eda8-4926-86cb-1b48aebcf5df	\N	no-cookie-redirect	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	89fa1ede-13d4-4b17-be8c-d76346a93cf2	0	10	f	\N	\N
91fc190d-074d-4cfb-aa0c-c42acb5ebe6f	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	89fa1ede-13d4-4b17-be8c-d76346a93cf2	0	20	t	d1373acf-bc53-47fb-8b25-9c3472f01b95	\N
bd9f60c2-bcbe-44c8-afa3-ad1d09c5428d	\N	basic-auth	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	d1373acf-bc53-47fb-8b25-9c3472f01b95	0	10	f	\N	\N
8e347ae9-2148-4cb1-b628-9d5c9a339875	\N	basic-auth-otp	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	d1373acf-bc53-47fb-8b25-9c3472f01b95	3	20	f	\N	\N
3cc3e5e6-d66b-44e3-994a-e7dbbbb497a4	\N	auth-spnego	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	d1373acf-bc53-47fb-8b25-9c3472f01b95	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
d0c3fe24-66ee-496d-8053-dd806c2b45b2	browser	browser based authentication	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	t	t
169760d7-264b-45a0-83fa-5b23d8ea1b5d	forms	Username, password, otp and other auth forms.	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
1fa7e89b-91ef-413f-bd12-d0d7dfe75c4a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
e8100237-cf94-435d-83a8-9a55f172fcf5	direct grant	OpenID Connect Resource Owner Grant	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	t	t
a64c2f32-ea3a-4e82-90be-92ed68f03940	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
cacc2361-9f62-4181-b18a-91325963ca60	registration	registration flow	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	t	t
1e5c89a9-0c9d-4c1a-be24-a346416ec040	registration form	registration form	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	form-flow	f	t
b6ad110e-135d-4fea-8ec7-818f13db76e7	reset credentials	Reset credentials for a user if they forgot their password or something	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	t	t
11e32156-6138-413f-84e4-82b83b7df67d	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
7cf6446c-a53a-4eb5-b5c2-c7132692491b	clients	Base authentication for clients	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	client-flow	t	t
8b161065-38b6-4f67-8a94-c67e5adc1119	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	t	t
5426eaf1-70eb-4f76-b980-4abd73070942	User creation or linking	Flow for the existing/non-existing user alternatives	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
bf2a260f-b7a7-4baf-b915-9ade4ab4752c	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
f730014b-2fbe-43d2-8415-3c2b6c44c904	Account verification options	Method with which to verity the existing account	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
020a658d-d330-4499-a581-9abecd8496ba	Verify Existing Account by Re-authentication	Reauthentication of existing account	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
e7b0c0ca-36a3-47b8-8989-f5a78b4bd258	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
069b6fc0-19cb-4f8d-862d-e3d511f8eac1	saml ecp	SAML ECP Profile Authentication Flow	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	t	t
591ed8c8-25a7-4fe6-80dc-85a10fee54d9	docker auth	Used by Docker clients to authenticate against the IDP	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	t	t
89fa1ede-13d4-4b17-be8c-d76346a93cf2	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	t	t
d1373acf-bc53-47fb-8b25-9c3472f01b95	Authentication Options	Authentication options.	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
106b1c6e-594a-4ebf-841b-c43b95330e12	review profile config	2fffb7fc-8a60-4911-8ea7-cf471918a4f8
de54662d-2438-4e58-8e66-d1d3b115ffd3	create unique user config	2fffb7fc-8a60-4911-8ea7-cf471918a4f8
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
106b1c6e-594a-4ebf-841b-c43b95330e12	missing	update.profile.on.first.login
de54662d-2438-4e58-8e66-d1d3b115ffd3	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
18602e15-4147-450e-a300-bafd1e217611	t	f	master-realm	0	f	\N	\N	t	\N	f	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
517c0b1a-9196-423a-aa7d-b34d90563f16	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
93c6f138-60a1-4c3d-8de6-4d18812c97b6	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3dd5827d-d97e-4d60-8393-34c783c8dc1e	t	f	broker	0	f	\N	\N	t	\N	f	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
dedc7b04-c6e5-48a4-907d-c14066908803	t	f	admin-cli	0	t	\N	\N	f	\N	f	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
7ced6891-759d-44fb-86e7-93a616211016	t	t	focus	0	f	wg4tu0juuDYombim5Ri7ZEVUR3TaPKrJ		f		f	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	openid-connect	-1	t	f		t	client-secret			\N	t	t	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
517c0b1a-9196-423a-aa7d-b34d90563f16	+	post.logout.redirect.uris
93c6f138-60a1-4c3d-8de6-4d18812c97b6	+	post.logout.redirect.uris
93c6f138-60a1-4c3d-8de6-4d18812c97b6	S256	pkce.code.challenge.method
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	+	post.logout.redirect.uris
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	S256	pkce.code.challenge.method
7ced6891-759d-44fb-86e7-93a616211016	1699947910	client.secret.creation.time
7ced6891-759d-44fb-86e7-93a616211016	false	oauth2.device.authorization.grant.enabled
7ced6891-759d-44fb-86e7-93a616211016	false	oidc.ciba.grant.enabled
7ced6891-759d-44fb-86e7-93a616211016	true	backchannel.logout.session.required
7ced6891-759d-44fb-86e7-93a616211016	false	backchannel.logout.revoke.offline.tokens
7ced6891-759d-44fb-86e7-93a616211016	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	offline_access	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	OpenID Connect built-in scope: offline_access	openid-connect
9fa556a9-2de3-4249-8dba-01f33294ec1c	role_list	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	SAML role list	saml
0753949e-e1ac-4070-84c9-a17166fb8e15	profile	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	OpenID Connect built-in scope: profile	openid-connect
efee9e8c-eb99-4329-b8d5-1b4c69ae9110	email	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	OpenID Connect built-in scope: email	openid-connect
b4f5c965-e38a-4142-a223-306670728a4b	address	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	OpenID Connect built-in scope: address	openid-connect
d7742b3f-208e-4106-9c3c-c68f3b331dbf	phone	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	OpenID Connect built-in scope: phone	openid-connect
e1119a42-a4d3-4043-a236-9f72872781f8	roles	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	OpenID Connect scope for add user roles to the access token	openid-connect
c1e7706f-b07e-4858-b0d2-f5095446ad3d	web-origins	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	OpenID Connect scope for add allowed web origins to the access token	openid-connect
4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	microprofile-jwt	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	Microprofile - JWT built-in scope	openid-connect
bf580cc3-5425-49d0-803f-178880e0f39d	acr	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
6be4966f-5a90-4999-9047-1fe703562f3a	*	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	all	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	true	display.on.consent.screen
acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	${offlineAccessScopeConsentText}	consent.screen.text
9fa556a9-2de3-4249-8dba-01f33294ec1c	true	display.on.consent.screen
9fa556a9-2de3-4249-8dba-01f33294ec1c	${samlRoleListScopeConsentText}	consent.screen.text
0753949e-e1ac-4070-84c9-a17166fb8e15	true	display.on.consent.screen
0753949e-e1ac-4070-84c9-a17166fb8e15	${profileScopeConsentText}	consent.screen.text
0753949e-e1ac-4070-84c9-a17166fb8e15	true	include.in.token.scope
efee9e8c-eb99-4329-b8d5-1b4c69ae9110	true	display.on.consent.screen
efee9e8c-eb99-4329-b8d5-1b4c69ae9110	${emailScopeConsentText}	consent.screen.text
efee9e8c-eb99-4329-b8d5-1b4c69ae9110	true	include.in.token.scope
b4f5c965-e38a-4142-a223-306670728a4b	true	display.on.consent.screen
b4f5c965-e38a-4142-a223-306670728a4b	${addressScopeConsentText}	consent.screen.text
b4f5c965-e38a-4142-a223-306670728a4b	true	include.in.token.scope
d7742b3f-208e-4106-9c3c-c68f3b331dbf	true	display.on.consent.screen
d7742b3f-208e-4106-9c3c-c68f3b331dbf	${phoneScopeConsentText}	consent.screen.text
d7742b3f-208e-4106-9c3c-c68f3b331dbf	true	include.in.token.scope
e1119a42-a4d3-4043-a236-9f72872781f8	true	display.on.consent.screen
e1119a42-a4d3-4043-a236-9f72872781f8	${rolesScopeConsentText}	consent.screen.text
e1119a42-a4d3-4043-a236-9f72872781f8	false	include.in.token.scope
c1e7706f-b07e-4858-b0d2-f5095446ad3d	false	display.on.consent.screen
c1e7706f-b07e-4858-b0d2-f5095446ad3d		consent.screen.text
c1e7706f-b07e-4858-b0d2-f5095446ad3d	false	include.in.token.scope
4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	false	display.on.consent.screen
4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	true	include.in.token.scope
bf580cc3-5425-49d0-803f-178880e0f39d	false	display.on.consent.screen
bf580cc3-5425-49d0-803f-178880e0f39d	false	include.in.token.scope
6be4966f-5a90-4999-9047-1fe703562f3a		consent.screen.text
6be4966f-5a90-4999-9047-1fe703562f3a	true	display.on.consent.screen
6be4966f-5a90-4999-9047-1fe703562f3a	true	include.in.token.scope
6be4966f-5a90-4999-9047-1fe703562f3a		gui.order
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
517c0b1a-9196-423a-aa7d-b34d90563f16	c1e7706f-b07e-4858-b0d2-f5095446ad3d	t
517c0b1a-9196-423a-aa7d-b34d90563f16	e1119a42-a4d3-4043-a236-9f72872781f8	t
517c0b1a-9196-423a-aa7d-b34d90563f16	efee9e8c-eb99-4329-b8d5-1b4c69ae9110	t
517c0b1a-9196-423a-aa7d-b34d90563f16	bf580cc3-5425-49d0-803f-178880e0f39d	t
517c0b1a-9196-423a-aa7d-b34d90563f16	0753949e-e1ac-4070-84c9-a17166fb8e15	t
517c0b1a-9196-423a-aa7d-b34d90563f16	b4f5c965-e38a-4142-a223-306670728a4b	f
517c0b1a-9196-423a-aa7d-b34d90563f16	acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	f
517c0b1a-9196-423a-aa7d-b34d90563f16	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	f
517c0b1a-9196-423a-aa7d-b34d90563f16	d7742b3f-208e-4106-9c3c-c68f3b331dbf	f
93c6f138-60a1-4c3d-8de6-4d18812c97b6	c1e7706f-b07e-4858-b0d2-f5095446ad3d	t
93c6f138-60a1-4c3d-8de6-4d18812c97b6	e1119a42-a4d3-4043-a236-9f72872781f8	t
93c6f138-60a1-4c3d-8de6-4d18812c97b6	efee9e8c-eb99-4329-b8d5-1b4c69ae9110	t
93c6f138-60a1-4c3d-8de6-4d18812c97b6	bf580cc3-5425-49d0-803f-178880e0f39d	t
93c6f138-60a1-4c3d-8de6-4d18812c97b6	0753949e-e1ac-4070-84c9-a17166fb8e15	t
93c6f138-60a1-4c3d-8de6-4d18812c97b6	b4f5c965-e38a-4142-a223-306670728a4b	f
93c6f138-60a1-4c3d-8de6-4d18812c97b6	acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	f
93c6f138-60a1-4c3d-8de6-4d18812c97b6	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	f
93c6f138-60a1-4c3d-8de6-4d18812c97b6	d7742b3f-208e-4106-9c3c-c68f3b331dbf	f
dedc7b04-c6e5-48a4-907d-c14066908803	c1e7706f-b07e-4858-b0d2-f5095446ad3d	t
dedc7b04-c6e5-48a4-907d-c14066908803	e1119a42-a4d3-4043-a236-9f72872781f8	t
dedc7b04-c6e5-48a4-907d-c14066908803	efee9e8c-eb99-4329-b8d5-1b4c69ae9110	t
dedc7b04-c6e5-48a4-907d-c14066908803	bf580cc3-5425-49d0-803f-178880e0f39d	t
dedc7b04-c6e5-48a4-907d-c14066908803	0753949e-e1ac-4070-84c9-a17166fb8e15	t
dedc7b04-c6e5-48a4-907d-c14066908803	b4f5c965-e38a-4142-a223-306670728a4b	f
dedc7b04-c6e5-48a4-907d-c14066908803	acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	f
dedc7b04-c6e5-48a4-907d-c14066908803	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	f
dedc7b04-c6e5-48a4-907d-c14066908803	d7742b3f-208e-4106-9c3c-c68f3b331dbf	f
3dd5827d-d97e-4d60-8393-34c783c8dc1e	c1e7706f-b07e-4858-b0d2-f5095446ad3d	t
3dd5827d-d97e-4d60-8393-34c783c8dc1e	e1119a42-a4d3-4043-a236-9f72872781f8	t
3dd5827d-d97e-4d60-8393-34c783c8dc1e	efee9e8c-eb99-4329-b8d5-1b4c69ae9110	t
3dd5827d-d97e-4d60-8393-34c783c8dc1e	bf580cc3-5425-49d0-803f-178880e0f39d	t
3dd5827d-d97e-4d60-8393-34c783c8dc1e	0753949e-e1ac-4070-84c9-a17166fb8e15	t
3dd5827d-d97e-4d60-8393-34c783c8dc1e	b4f5c965-e38a-4142-a223-306670728a4b	f
3dd5827d-d97e-4d60-8393-34c783c8dc1e	acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	f
3dd5827d-d97e-4d60-8393-34c783c8dc1e	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	f
3dd5827d-d97e-4d60-8393-34c783c8dc1e	d7742b3f-208e-4106-9c3c-c68f3b331dbf	f
18602e15-4147-450e-a300-bafd1e217611	c1e7706f-b07e-4858-b0d2-f5095446ad3d	t
18602e15-4147-450e-a300-bafd1e217611	e1119a42-a4d3-4043-a236-9f72872781f8	t
18602e15-4147-450e-a300-bafd1e217611	efee9e8c-eb99-4329-b8d5-1b4c69ae9110	t
18602e15-4147-450e-a300-bafd1e217611	bf580cc3-5425-49d0-803f-178880e0f39d	t
18602e15-4147-450e-a300-bafd1e217611	0753949e-e1ac-4070-84c9-a17166fb8e15	t
18602e15-4147-450e-a300-bafd1e217611	b4f5c965-e38a-4142-a223-306670728a4b	f
18602e15-4147-450e-a300-bafd1e217611	acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	f
18602e15-4147-450e-a300-bafd1e217611	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	f
18602e15-4147-450e-a300-bafd1e217611	d7742b3f-208e-4106-9c3c-c68f3b331dbf	f
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	c1e7706f-b07e-4858-b0d2-f5095446ad3d	t
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	e1119a42-a4d3-4043-a236-9f72872781f8	t
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	efee9e8c-eb99-4329-b8d5-1b4c69ae9110	t
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	bf580cc3-5425-49d0-803f-178880e0f39d	t
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	0753949e-e1ac-4070-84c9-a17166fb8e15	t
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	b4f5c965-e38a-4142-a223-306670728a4b	f
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	f
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	f
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	d7742b3f-208e-4106-9c3c-c68f3b331dbf	f
7ced6891-759d-44fb-86e7-93a616211016	c1e7706f-b07e-4858-b0d2-f5095446ad3d	t
7ced6891-759d-44fb-86e7-93a616211016	e1119a42-a4d3-4043-a236-9f72872781f8	t
7ced6891-759d-44fb-86e7-93a616211016	efee9e8c-eb99-4329-b8d5-1b4c69ae9110	t
7ced6891-759d-44fb-86e7-93a616211016	bf580cc3-5425-49d0-803f-178880e0f39d	t
7ced6891-759d-44fb-86e7-93a616211016	0753949e-e1ac-4070-84c9-a17166fb8e15	t
7ced6891-759d-44fb-86e7-93a616211016	b4f5c965-e38a-4142-a223-306670728a4b	f
7ced6891-759d-44fb-86e7-93a616211016	acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	f
7ced6891-759d-44fb-86e7-93a616211016	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	f
7ced6891-759d-44fb-86e7-93a616211016	d7742b3f-208e-4106-9c3c-c68f3b331dbf	f
7ced6891-759d-44fb-86e7-93a616211016	6be4966f-5a90-4999-9047-1fe703562f3a	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	b7625a11-0a22-4d35-991c-553eba365b35
6be4966f-5a90-4999-9047-1fe703562f3a	12466ca8-22bb-4186-9a3d-74ee031dbe28
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
978b1ac5-2ad5-42f6-9754-1d59eb84b119	Trusted Hosts	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	anonymous
9bc30d2b-715f-4b5a-aa54-041ae6f15bb5	Consent Required	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	anonymous
5bb7ca3b-c700-4a76-b2df-7d7b2a8dcca2	Full Scope Disabled	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	anonymous
1ee63faa-bfd2-423c-b55e-97b71e910f75	Max Clients Limit	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	anonymous
c9c47b16-33f2-47f3-b01b-3c2a2894c28a	Allowed Protocol Mapper Types	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	anonymous
5e5f28fa-4634-4703-83d3-787118d22ea1	Allowed Client Scopes	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	anonymous
bf19d93b-f1bd-4ef4-883f-8ffdcc4c546b	Allowed Protocol Mapper Types	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	authenticated
b4473238-b57a-49cf-81a7-b7efd976357a	Allowed Client Scopes	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	authenticated
a4ebd141-f8f9-4b6a-adab-66a304a24b21	rsa-generated	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	rsa-generated	org.keycloak.keys.KeyProvider	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N
e45056ea-d8c0-4079-b9fe-00bf0b90b547	rsa-enc-generated	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	rsa-enc-generated	org.keycloak.keys.KeyProvider	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N
a4a8734b-c03a-4dff-bea5-eea308c6fe1c	hmac-generated	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	hmac-generated	org.keycloak.keys.KeyProvider	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N
c3bca5b9-07dc-48ee-9f84-25ec70ff5ada	aes-generated	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	aes-generated	org.keycloak.keys.KeyProvider	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N
bd6dc467-eeba-4ea8-beb3-3ffb38bb7df3	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
944bfcc8-3622-4ea3-bb1e-dd12aa6ffa09	978b1ac5-2ad5-42f6-9754-1d59eb84b119	host-sending-registration-request-must-match	true
c6d59a0e-965e-4501-836d-ae5a204a3439	978b1ac5-2ad5-42f6-9754-1d59eb84b119	client-uris-must-match	true
c2d9e7e4-9e64-4edc-b59a-56cdbbf58096	1ee63faa-bfd2-423c-b55e-97b71e910f75	max-clients	200
1e19d79b-9a4f-46d9-87fd-9f26c9a4830e	bf19d93b-f1bd-4ef4-883f-8ffdcc4c546b	allowed-protocol-mapper-types	saml-user-property-mapper
2113dade-2a75-4dc5-a2fc-eff9700c63e9	bf19d93b-f1bd-4ef4-883f-8ffdcc4c546b	allowed-protocol-mapper-types	saml-role-list-mapper
3269304a-f108-4ac3-9e11-f3158c728ff5	bf19d93b-f1bd-4ef4-883f-8ffdcc4c546b	allowed-protocol-mapper-types	saml-user-attribute-mapper
8475bf5c-ea33-4041-bf66-891d5b047877	bf19d93b-f1bd-4ef4-883f-8ffdcc4c546b	allowed-protocol-mapper-types	oidc-address-mapper
933864f2-86bd-4069-954d-8b2fa409dd37	bf19d93b-f1bd-4ef4-883f-8ffdcc4c546b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1968b088-af69-4c06-baea-289dd33b5f2a	bf19d93b-f1bd-4ef4-883f-8ffdcc4c546b	allowed-protocol-mapper-types	oidc-full-name-mapper
c53e8acd-09c1-42fc-a2b8-e58a65757240	bf19d93b-f1bd-4ef4-883f-8ffdcc4c546b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
48e73355-ae09-4609-b457-4c3ffcc9caa1	bf19d93b-f1bd-4ef4-883f-8ffdcc4c546b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
8bda9f44-25fc-47d5-b05e-328e2b282aa7	b4473238-b57a-49cf-81a7-b7efd976357a	allow-default-scopes	true
de9634d6-a87a-485c-9f60-01ac40b90160	c9c47b16-33f2-47f3-b01b-3c2a2894c28a	allowed-protocol-mapper-types	saml-user-property-mapper
e2bf2547-5ca7-4074-bef5-e85782814e63	c9c47b16-33f2-47f3-b01b-3c2a2894c28a	allowed-protocol-mapper-types	saml-user-attribute-mapper
eb46aafd-abad-4617-8271-706816b2c00d	c9c47b16-33f2-47f3-b01b-3c2a2894c28a	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
368c8b9d-e3df-49d6-9e17-89027296b170	c9c47b16-33f2-47f3-b01b-3c2a2894c28a	allowed-protocol-mapper-types	oidc-full-name-mapper
edb64fea-d743-499a-8761-67e1b587ed59	c9c47b16-33f2-47f3-b01b-3c2a2894c28a	allowed-protocol-mapper-types	saml-role-list-mapper
7fac7a77-48ab-4218-884a-42156a8bd2ea	c9c47b16-33f2-47f3-b01b-3c2a2894c28a	allowed-protocol-mapper-types	oidc-address-mapper
18f3be50-3563-4f03-a176-d7c049b577b9	c9c47b16-33f2-47f3-b01b-3c2a2894c28a	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
78319680-a2ea-4c1c-8f90-dc9815a6c80f	c9c47b16-33f2-47f3-b01b-3c2a2894c28a	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
b4c2231c-2de9-4150-b3d1-de2010111c9a	5e5f28fa-4634-4703-83d3-787118d22ea1	allow-default-scopes	true
e0d33238-9451-4b70-a641-a237a24ef9ee	c3bca5b9-07dc-48ee-9f84-25ec70ff5ada	kid	0846967a-79ca-4ed1-904f-557ab7796c84
ba8a8433-0795-4cde-ba19-de57d1bfd17d	c3bca5b9-07dc-48ee-9f84-25ec70ff5ada	secret	kgHi7kBMdQA_WWAzNm6Tnw
5e0d5edc-ca90-4661-afc9-400b5e32849d	c3bca5b9-07dc-48ee-9f84-25ec70ff5ada	priority	100
04981d1a-fc7a-49bf-9ae0-83c1bb65cdc8	a4ebd141-f8f9-4b6a-adab-66a304a24b21	privateKey	MIIEpAIBAAKCAQEAso2jyH2kYXqMFgebcTGt3A4e8lS/Qz6aiLkyVJUi2qtIQ10AmVk9edmMleUasjkPtz7FrxSmPzAhZN61cXWPb//IiYm9Dmyr3/ssXls+gxQKZ+BOK+9cvKXIkERPk7sWUG0sRQ6ZiWGlocFIuy94MBkClmycVZ9yBvd4UpybvimGzEax/sX+ukizNWGE/CHSgEyQbWP6DwPTnScj4+P2fI17ZLZ8XCChtUMzhUyOakpW6QIZUXfdmG36w53PMY0npzEGekyAzOgL9cC5vk4Vb1gkqIu4UrxRddbE36wh6bopMVdQSAJG0oRCjfpkng2RbthE9BSONgQG7d0gGUXM/QIDAQABAoIBACnBfnUnTs8eD88iEcu3rLs60SlmQMFKzWxedQL7SoadSj24rOhvynTpt5shVCwsNHzr0OKoH1XFHXYfsAp7zeLJDD5/5+bM6qfrbx2U1IpmYCWZOubC6CrU0VHNq9d2R9pgoZr3tle+rnOkxivCRubmnmiLt0a9zjaLXofhSHnAi2MDwb86ZWrUfzYylNLQ9DaVXWAREucm3Ob+I2cn4OCf0avHdXidadqh6EU5sW1dokRd5vMvVLE3cg0oCYj9YeyKkHYPNhE531dBIlewd+/lUIkhZ/vuAE3AobJt/PNvfHkHVdE1ak+x9+pEwNWkwyoK4BbposB2P+zGOvOP9oECgYEA69iHm7VDHVpx0Y0TnfTZYcOM2UTrkD/+pVWdTwSb7yeMqFKX4QFxw98HwN9yI29TczcUaEpFPxRQ31cIxmfClXEopz7+U1PtWnnN4M8s5XxNGBVpA+T2QTwVAzRhD9phQYt9EwmZnq8BU9v6xlMBOnpeIuZe/fq2XnyqpjUVnX0CgYEAwc/AoLQ8KxyePEhRU4fz5mQaUcP/DBHc2G0yClWzCciA9I0RE74WNOXxCTSkfiE34UkaifhSp3W+CRHSq7VRijt4R8UL/QiqtUYSg+8A2xcWyM0/X8y8nAuW/ypsdVmoTk1mGnELnVE4P/L1kt6poD+an3/YAMTbBk9+21vmBYECgYEAqN4QMwg1dvYEmwNFcYsYfyyyU/tKI63+mclUanilYjbSOs9wmhYbrCCsf4g+RGr4uH1OqmHLdSAJy/CYgt9WbwRoFGBBX86vG2ItbHNK9UHsPXtPBw/Q1uK7NOEzQlOd4X2L3663BOzPqYjP5WMXdRSbBKgoifgSzlK7KWjHAk0CgYBgMo8o9OzcdTLxNu/u5w8fbtZFeWQRiJg2cFSjHpBkLbocKByu0O3SycMOz6tJ05EZ6CAdFT1pUx7E/6yyf6f+VbBI5zwhFvksSqCMDcg99sLfXkizczq2tWX4NwVoZd0NKIuiWjPqnNKvoxdTE+Pb31YPDvSWxR71jeWoWX/dgQKBgQCtBv1ZcvVw0VFdgJUSj8H7qqDOoSOnRdFi8nogLEnqoohQ/LcIuYZb7MYRvxGhE09/zHd2vSqu9J6JWqigI60C/CiF7FK7GSoRNOn5I1MjWGSUo1MAwH4FEf4/4CkGawleiqDSC1JWKq58Bkm5gkhqd30OMifuC5H0XME3aAEeXA==
a537da07-72bd-4d7c-89bb-5fe06fdf465b	a4ebd141-f8f9-4b6a-adab-66a304a24b21	certificate	MIICmzCCAYMCBgGLzK4GEjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMxMTE0MDcxMjE4WhcNMzMxMTE0MDcxMzU4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyjaPIfaRheowWB5txMa3cDh7yVL9DPpqIuTJUlSLaq0hDXQCZWT152YyV5RqyOQ+3PsWvFKY/MCFk3rVxdY9v/8iJib0ObKvf+yxeWz6DFApn4E4r71y8pciQRE+TuxZQbSxFDpmJYaWhwUi7L3gwGQKWbJxVn3IG93hSnJu+KYbMRrH+xf66SLM1YYT8IdKATJBtY/oPA9OdJyPj4/Z8jXtktnxcIKG1QzOFTI5qSlbpAhlRd92YbfrDnc8xjSenMQZ6TIDM6Av1wLm+ThVvWCSoi7hSvFF11sTfrCHpuikxV1BIAkbShEKN+mSeDZFu2ET0FI42BAbt3SAZRcz9AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJL+ZMxT4IKhS8YYQZYETrdi3BTzwfZAmLX/A8ZbBsQaZVR/jqBEUe/UH/eiVZMc4ZNtjUQ8vYJSuT7cDPtaoIypcxRWMP5RecPeD8XlOViZ57vX8iJ3Z+3UeyyAuRnMXCKFyDW0rW9dFfOKq2lF7tSlFQKejDDQ8NdnZW3FxYzEQm6vD9nDfKbImjIqqW43sNJYTUxqqtUT7BpuUcjH/T1uzhSekhoTjjA43gXGqfGxdes2BMRKafOTVooP0XiDvENcG3x1m8dE77k/6eR3fXyomLK/3WSrFFvrHPlonbv9N5CzMtkDV8VGWITVTYk+6R4a+sIYlR8Mj3vfFDIfKvA=
f23a994f-5326-4d5e-96c4-fdd2a6ddd990	a4ebd141-f8f9-4b6a-adab-66a304a24b21	keyUse	SIG
f7219cd0-6df2-4349-927f-a0f49d4d5f82	a4ebd141-f8f9-4b6a-adab-66a304a24b21	priority	100
bd9a8cd3-dbe4-4185-8abe-94b9ece4f1fb	e45056ea-d8c0-4079-b9fe-00bf0b90b547	privateKey	MIIEowIBAAKCAQEAv0hKxNczzaJKTYaWSnsUMUKDRl5UmcahznN/8wxmgQDvjb3AVhr9TJ9RoWqZ4s/Pqppkw9hwzwX0ZMpArR9oPhtW+RiHigDI8r2ieYKuF4PLDUV4McHS/Fjr619qgUBOibOZm3byU/Y+/W1FfkQXSFa0LBjvvy9EnVi9BvszR4xa4U9y3+65EGJ93mqAAHy9wXnxBewpXfEASUw3MKASJjh6UcjgtiMHviqO83wKGmEBH5q7HYHRgPwxUCCNftozwVo0+/+kcdLWXNrSxD459PN22xxIFy2QM60t2y3Pz5eq6qLegsc/0H3NQcoKBIE0+M4bC16Ke4lvFgOnR/h1ZwIDAQABAoIBAAISQKpZq42aKJ8m9PEA3NrHs0TgzUkOVemMEKJLdmoGiObfsM8ojaj1v1w1xk18He3lVsVUI6yU45eaembQL0B06qqEhyXfFPij8GLLynd7Yt3VlxPwMF5b1s9+rK2SSlzCssgfL/KUI7ck0XAo6+5JmhExgpnEY5l8lizBgvBPDPYLcMldTt7lsF9WIdbQED05sSU1Urxh9kpTXkhkeSRNyKPYGwv5BOKBwBom5JXz/L9K79VCpysHv80O5CP6Cd4Zijz0UOXkfUg2cIpzcrxv5IvzbzYf1fyDVkK0Q0w8t9TEcH43vGUXmgwWVriznZ5tbyUaXbyHF4mKQy/+YvkCgYEA8tCFz1mO4RTD9mU5UY3lN+7bbq65/hmI9QoZPZiXFs50kEhOdEFlxvkbBgAEoyd5n9cYToI/to0XvbrXJ/63/P/jmk83RTMlivtwO/xq1BiTuLfZ41/r//zSvFfTPx0HbOeYNk/VNedTK1iBZuxZIR7jyRFECqCLJe0Sa5dfQsUCgYEAyatlqAtUk31mwkOAW+t49kRlI5/GVH8xz74PSI93LFzXp45R0gi8dnMQwhov1MmS1g9EVTU8a2PentIAN1/X9YiPnQWQRW/1IzTJMJzIRJg1ivhWxsD6lEwFF29x5FPOJLSqP1l2Fh4TQToRolu7gGqMzeARDt04OFaWTnnM6jsCgYEAvj6K2M7+l3PBpgfhRPi8I3rOCoZzy5cOK49h/1TS7FeOFI3SilvC9oaumaDiAUMolAffT4PVj540f78oXHnChkOnfHucfmd4ftBKO3Wl7c/jzdKesPuy2LqqEk9tgAGqk7VRGRyrnLRGAawylwWPP9gH+L3CZeErpOd+izXquVECgYA8M7pJC/jXfpvqahQrXIPjoE9A7zVZjA7moSoW0x0UVTLbhhTOymTYR0k9aGvW7cWzuSMA/L9on4uZhb8iyK3DUlzs1vhWgjF/rQZSSLtQHs/9CF1/P6SOGJN8h3xMWOg09OnNt3sU5y2AT0FsYk3669PUsYrmEQvzZYXBL4MIeQKBgEslvrpxI9+HFjWCOn7Gra4JGeJu/pp2ipGMR0/L6hKbQwkKeO2bgjDH8W8N0ghF5aP0iwXZp3BwFIfw2rzj9Gb9CRgPSyYpTELOiToCkoxcKh8+GtiFpRQ0XcAQ7oT3VL5ccGF/ixpW0TN4e4fT112q5CcCB1ZVTUBSMbpZC1o2
523eeb5b-afdc-423c-9871-76afb49dfeb1	e45056ea-d8c0-4079-b9fe-00bf0b90b547	keyUse	ENC
9a9fc7f9-71c7-403d-8c3d-c57a7da224f8	e45056ea-d8c0-4079-b9fe-00bf0b90b547	priority	100
240f5a7b-463b-4966-b9d8-f936394838aa	e45056ea-d8c0-4079-b9fe-00bf0b90b547	certificate	MIICmzCCAYMCBgGLzK4G/zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMxMTE0MDcxMjE5WhcNMzMxMTE0MDcxMzU5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/SErE1zPNokpNhpZKexQxQoNGXlSZxqHOc3/zDGaBAO+NvcBWGv1Mn1Ghapniz8+qmmTD2HDPBfRkykCtH2g+G1b5GIeKAMjyvaJ5gq4Xg8sNRXgxwdL8WOvrX2qBQE6Js5mbdvJT9j79bUV+RBdIVrQsGO+/L0SdWL0G+zNHjFrhT3Lf7rkQYn3eaoAAfL3BefEF7Cld8QBJTDcwoBImOHpRyOC2Iwe+Ko7zfAoaYQEfmrsdgdGA/DFQII1+2jPBWjT7/6Rx0tZc2tLEPjn083bbHEgXLZAzrS3bLc/Pl6rqot6Cxz/Qfc1BygoEgTT4zhsLXop7iW8WA6dH+HVnAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAG++8Dnepgxki9AjLrPK+Y2Y8xKsvY6Vo+kiES5xlFsulrsKB1bWHajq4rbBPXPCTVMN/ynAmiG5RHK8ZcfQx3dFemqLUM0qWzzf3+KqjueYKcF+Wt7gTYutUXN0Vm9LXoeag9g1vG48qdbq579qf0tiB0ZsSqq+Kn4MihNsq9XyrSBuUzfu6X0ZpLgv/l7PH46TJKTq3oqFzTAk4lS0pRpkKZct9Y4F4RXSJgWi+C9LOJdpEIVKT9X0jsGr4w3a7ZN7FYtZ1oAtHcmn26xFIC6V48aBZii10O3u3izrLy0Tjsj9YdKH8xR/IuykTXdthZNkF3guhSl/3QggBMka6OM=
90b061f0-57f9-46e8-8294-f5649e472436	e45056ea-d8c0-4079-b9fe-00bf0b90b547	algorithm	RSA-OAEP
ce87ecf8-a457-4453-a0b1-449406d5e07b	a4a8734b-c03a-4dff-bea5-eea308c6fe1c	kid	2c7b5c15-84a7-478d-9170-f44050056a37
821269cf-56f5-4472-859e-853fac2a1493	a4a8734b-c03a-4dff-bea5-eea308c6fe1c	secret	2oN0lib6ZBFYujeZBzcGSAf7R9xGdRVUxbu5HlbbU_Vrrx1OOE1O2C6aSoHL4OVMiesgLJbcueRgi74K361MOQ
b3dcd1ec-09ee-4188-8f56-0cd33893e7b5	a4a8734b-c03a-4dff-bea5-eea308c6fe1c	algorithm	HS256
6e941aae-9c07-41a3-80b5-471be93a80a7	a4a8734b-c03a-4dff-bea5-eea308c6fe1c	priority	100
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
b594d158-3634-4acb-b873-bf9f7957d5e1	bcb0da87-78f7-41b4-8562-d422f7a3c6aa
b594d158-3634-4acb-b873-bf9f7957d5e1	acba8b3d-3bc1-4e00-9d43-7e4705297021
b594d158-3634-4acb-b873-bf9f7957d5e1	ceae72eb-1fe3-44df-8785-7c14c367e49a
b594d158-3634-4acb-b873-bf9f7957d5e1	681e4836-a064-4ddd-bfb1-8ca66b60574b
b594d158-3634-4acb-b873-bf9f7957d5e1	1dcd0167-a4cf-40e0-a92c-c1fb7cc34a8e
b594d158-3634-4acb-b873-bf9f7957d5e1	d170574d-5e77-45ed-b139-f91b1f4dc50a
b594d158-3634-4acb-b873-bf9f7957d5e1	b369586e-654a-48e7-b155-6d9f8f3d8053
b594d158-3634-4acb-b873-bf9f7957d5e1	f5e350d1-d818-458a-ad7f-dbebab4e0994
b594d158-3634-4acb-b873-bf9f7957d5e1	45950f40-9747-40d1-8201-1c412b8d6cd3
b594d158-3634-4acb-b873-bf9f7957d5e1	5439f41f-d025-4db4-99a5-b1e8253b4c9b
b594d158-3634-4acb-b873-bf9f7957d5e1	6425ce65-8917-4833-8d5d-5a695d0cc7df
b594d158-3634-4acb-b873-bf9f7957d5e1	3515e7e7-0261-4031-928d-5ad672440b9a
b594d158-3634-4acb-b873-bf9f7957d5e1	9ebf3f85-ae24-4409-bfa7-6edf5889f047
b594d158-3634-4acb-b873-bf9f7957d5e1	d43492b8-17f4-4bc5-ac4e-54e5b2e602c6
b594d158-3634-4acb-b873-bf9f7957d5e1	b67db2ac-0839-40cf-8a30-27f15d74b2c2
b594d158-3634-4acb-b873-bf9f7957d5e1	3148a8e0-2c40-43ab-bf6a-6600774cf605
b594d158-3634-4acb-b873-bf9f7957d5e1	91ac78f9-66cd-40ef-82de-c9291765d89c
b594d158-3634-4acb-b873-bf9f7957d5e1	6f57f657-af90-4e7c-8802-2503aa0d6f8a
1dcd0167-a4cf-40e0-a92c-c1fb7cc34a8e	3148a8e0-2c40-43ab-bf6a-6600774cf605
681e4836-a064-4ddd-bfb1-8ca66b60574b	b67db2ac-0839-40cf-8a30-27f15d74b2c2
681e4836-a064-4ddd-bfb1-8ca66b60574b	6f57f657-af90-4e7c-8802-2503aa0d6f8a
d311508e-26cc-48b8-a746-b73fe4178903	c7e77d08-2acc-46ac-b516-8515ca458e3c
d311508e-26cc-48b8-a746-b73fe4178903	d5f603cb-45dc-40b1-9085-f5fd9effa6f1
d5f603cb-45dc-40b1-9085-f5fd9effa6f1	9158b8bf-6453-4cd5-90ab-fff380a44357
fd2ccca6-9721-49a2-8d2b-fc06f74e671b	bee1c5c0-89ac-4a28-93f9-df375a710ed4
b594d158-3634-4acb-b873-bf9f7957d5e1	59ea3a30-a7d0-4d1a-ae70-4347f904f306
d311508e-26cc-48b8-a746-b73fe4178903	b7625a11-0a22-4d35-991c-553eba365b35
d311508e-26cc-48b8-a746-b73fe4178903	bdc1e5dc-8c27-4aa2-bc39-596d9adba56f
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
f24f1692-1183-4e13-938f-4e7233d84478	\N	password	bbcb5b30-59a5-45e5-8210-930b4a015819	1699946039342	\N	{"value":"hyOfmlwInkATLmTsh7jgMBaliS/S5mU2LHDQzt4Ih6aK1zwwSUkO4jOwH2314qI0DfZiBmqlt4+3G1Eqi6gO/A==","salt":"nGfdNk3y6T1EbumUhuyEHA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
14484ad7-3201-4bdc-91b7-0bc45bbd8de7	\N	password	8182d86e-705a-4808-b40a-f85eda15ad01	1699948184751	My password	{"value":"mALy7RWJOn2OvPfE6j4DcEKukyi8ChfMTo1Wwymx5kS8NZNQnJoMTQsok4VcG/FF6GWohnlT/7xXAEf7N+1I3A==","salt":"lCMMVjlNMT1kYHb7DQfqHg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-11-14 07:13:51.742012	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	9946030940
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-11-14 07:13:51.75839	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	9946030940
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-11-14 07:13:51.86205	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	9946030940
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-11-14 07:13:51.865904	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	9946030940
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-11-14 07:13:52.160236	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	9946030940
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-11-14 07:13:52.163102	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	9946030940
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-11-14 07:13:52.356051	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	9946030940
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-11-14 07:13:52.359054	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	9946030940
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-11-14 07:13:52.362441	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	9946030940
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-11-14 07:13:52.780255	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	9946030940
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-11-14 07:13:52.900991	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	9946030940
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-11-14 07:13:52.903382	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	9946030940
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-11-14 07:13:52.919178	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	9946030940
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-11-14 07:13:52.975056	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	9946030940
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-11-14 07:13:52.976967	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	9946030940
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-11-14 07:13:52.979091	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	9946030940
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-11-14 07:13:52.980688	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	9946030940
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-11-14 07:13:53.096753	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	9946030940
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-11-14 07:13:53.215924	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	9946030940
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-11-14 07:13:53.222446	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	9946030940
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-11-14 07:13:54.80866	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	9946030940
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-11-14 07:13:53.224752	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	9946030940
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-11-14 07:13:53.23653	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	9946030940
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-11-14 07:13:53.306834	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	9946030940
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-11-14 07:13:53.310909	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	9946030940
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-11-14 07:13:53.313117	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	9946030940
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-11-14 07:13:53.481786	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	9946030940
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-11-14 07:13:53.745511	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	9946030940
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-11-14 07:13:53.750354	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	9946030940
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-11-14 07:13:53.956341	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	9946030940
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-11-14 07:13:53.999623	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	9946030940
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-11-14 07:13:54.026971	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	9946030940
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-11-14 07:13:54.030739	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	9946030940
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-11-14 07:13:54.03439	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	9946030940
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-11-14 07:13:54.035986	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	9946030940
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-11-14 07:13:54.089091	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	9946030940
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-11-14 07:13:54.093013	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	9946030940
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-11-14 07:13:54.1048	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	9946030940
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-11-14 07:13:54.108014	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	9946030940
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-11-14 07:13:54.110586	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	9946030940
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-11-14 07:13:54.111972	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	9946030940
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-11-14 07:13:54.113304	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	9946030940
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-11-14 07:13:54.116561	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	9946030940
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-11-14 07:13:54.80164	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	9946030940
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-11-14 07:13:54.805332	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	9946030940
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-11-14 07:13:54.813955	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	9946030940
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-11-14 07:13:54.815454	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	9946030940
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-11-14 07:13:54.936967	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	9946030940
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-11-14 07:13:54.94131	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	9946030940
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-11-14 07:13:55.037907	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	9946030940
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-11-14 07:13:55.185052	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	9946030940
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-11-14 07:13:55.188432	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9946030940
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-11-14 07:13:55.191542	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	9946030940
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-11-14 07:13:55.193994	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	9946030940
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-11-14 07:13:55.208804	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	9946030940
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-11-14 07:13:55.238047	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	9946030940
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-11-14 07:13:55.307703	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	9946030940
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-11-14 07:13:55.583974	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	9946030940
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-11-14 07:13:55.650269	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	9946030940
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-11-14 07:13:55.659934	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	9946030940
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-11-14 07:13:55.670335	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	9946030940
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-11-14 07:13:55.680167	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	9946030940
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-11-14 07:13:55.683435	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	9946030940
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-11-14 07:13:55.687406	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	9946030940
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-11-14 07:13:55.689894	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	9946030940
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-11-14 07:13:55.730436	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	9946030940
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-11-14 07:13:55.750414	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	9946030940
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-11-14 07:13:55.753645	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	9946030940
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-11-14 07:13:55.773361	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	9946030940
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-11-14 07:13:55.779737	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	9946030940
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-11-14 07:13:55.784815	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	9946030940
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-11-14 07:13:55.788391	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	9946030940
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-11-14 07:13:55.795862	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	9946030940
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-11-14 07:13:55.797017	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	9946030940
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-11-14 07:13:55.843787	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	9946030940
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-11-14 07:13:55.862731	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	9946030940
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-11-14 07:13:55.86549	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	9946030940
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-11-14 07:13:55.866983	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	9946030940
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-11-14 07:13:55.905659	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	9946030940
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-11-14 07:13:55.907141	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	9946030940
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-11-14 07:13:55.922115	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	9946030940
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-11-14 07:13:55.923655	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	9946030940
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-11-14 07:13:55.929858	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	9946030940
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-11-14 07:13:55.931463	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	9946030940
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-11-14 07:13:55.946051	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	9946030940
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-11-14 07:13:55.949171	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	9946030940
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-11-14 07:13:55.95324	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	9946030940
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-11-14 07:13:55.979703	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	9946030940
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-11-14 07:13:55.985677	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	9946030940
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-11-14 07:13:56.019567	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	9946030940
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-11-14 07:13:56.03443	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	9946030940
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-11-14 07:13:56.039918	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	9946030940
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-11-14 07:13:56.04129	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	9946030940
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-11-14 07:13:56.058462	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	9946030940
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-11-14 07:13:56.061719	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	9946030940
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-11-14 07:13:56.069072	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	9946030940
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-11-14 07:13:56.107255	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	9946030940
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-11-14 07:13:56.10871	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9946030940
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-11-14 07:13:56.135073	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9946030940
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-11-14 07:13:56.150387	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9946030940
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-11-14 07:13:56.151988	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9946030940
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-11-14 07:13:56.166216	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	9946030940
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-11-14 07:13:56.169324	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	9946030940
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-11-14 07:13:56.175957	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	9946030940
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-11-14 07:13:56.192272	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	9946030940
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-11-14 07:13:56.206862	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	9946030940
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-11-14 07:13:56.209721	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	9946030940
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	acbd6e67-c9a2-4631-b4d0-ed02ae30ddc4	f
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	9fa556a9-2de3-4249-8dba-01f33294ec1c	t
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	0753949e-e1ac-4070-84c9-a17166fb8e15	t
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	efee9e8c-eb99-4329-b8d5-1b4c69ae9110	t
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	b4f5c965-e38a-4142-a223-306670728a4b	f
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	d7742b3f-208e-4106-9c3c-c68f3b331dbf	f
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	e1119a42-a4d3-4043-a236-9f72872781f8	t
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	c1e7706f-b07e-4858-b0d2-f5095446ad3d	t
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7	f
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	bf580cc3-5425-49d0-803f-178880e0f39d	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
d311508e-26cc-48b8-a746-b73fe4178903	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	f	${role_default-roles}	default-roles-master	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N	\N
b594d158-3634-4acb-b873-bf9f7957d5e1	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	f	${role_admin}	admin	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N	\N
bcb0da87-78f7-41b4-8562-d422f7a3c6aa	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	f	${role_create-realm}	create-realm	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N	\N
acba8b3d-3bc1-4e00-9d43-7e4705297021	18602e15-4147-450e-a300-bafd1e217611	t	${role_create-client}	create-client	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
ceae72eb-1fe3-44df-8785-7c14c367e49a	18602e15-4147-450e-a300-bafd1e217611	t	${role_view-realm}	view-realm	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
681e4836-a064-4ddd-bfb1-8ca66b60574b	18602e15-4147-450e-a300-bafd1e217611	t	${role_view-users}	view-users	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
1dcd0167-a4cf-40e0-a92c-c1fb7cc34a8e	18602e15-4147-450e-a300-bafd1e217611	t	${role_view-clients}	view-clients	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
d170574d-5e77-45ed-b139-f91b1f4dc50a	18602e15-4147-450e-a300-bafd1e217611	t	${role_view-events}	view-events	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
b369586e-654a-48e7-b155-6d9f8f3d8053	18602e15-4147-450e-a300-bafd1e217611	t	${role_view-identity-providers}	view-identity-providers	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
f5e350d1-d818-458a-ad7f-dbebab4e0994	18602e15-4147-450e-a300-bafd1e217611	t	${role_view-authorization}	view-authorization	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
45950f40-9747-40d1-8201-1c412b8d6cd3	18602e15-4147-450e-a300-bafd1e217611	t	${role_manage-realm}	manage-realm	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
5439f41f-d025-4db4-99a5-b1e8253b4c9b	18602e15-4147-450e-a300-bafd1e217611	t	${role_manage-users}	manage-users	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
6425ce65-8917-4833-8d5d-5a695d0cc7df	18602e15-4147-450e-a300-bafd1e217611	t	${role_manage-clients}	manage-clients	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
3515e7e7-0261-4031-928d-5ad672440b9a	18602e15-4147-450e-a300-bafd1e217611	t	${role_manage-events}	manage-events	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
9ebf3f85-ae24-4409-bfa7-6edf5889f047	18602e15-4147-450e-a300-bafd1e217611	t	${role_manage-identity-providers}	manage-identity-providers	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
d43492b8-17f4-4bc5-ac4e-54e5b2e602c6	18602e15-4147-450e-a300-bafd1e217611	t	${role_manage-authorization}	manage-authorization	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
b67db2ac-0839-40cf-8a30-27f15d74b2c2	18602e15-4147-450e-a300-bafd1e217611	t	${role_query-users}	query-users	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
3148a8e0-2c40-43ab-bf6a-6600774cf605	18602e15-4147-450e-a300-bafd1e217611	t	${role_query-clients}	query-clients	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
91ac78f9-66cd-40ef-82de-c9291765d89c	18602e15-4147-450e-a300-bafd1e217611	t	${role_query-realms}	query-realms	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
6f57f657-af90-4e7c-8802-2503aa0d6f8a	18602e15-4147-450e-a300-bafd1e217611	t	${role_query-groups}	query-groups	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
c7e77d08-2acc-46ac-b516-8515ca458e3c	517c0b1a-9196-423a-aa7d-b34d90563f16	t	${role_view-profile}	view-profile	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	517c0b1a-9196-423a-aa7d-b34d90563f16	\N
d5f603cb-45dc-40b1-9085-f5fd9effa6f1	517c0b1a-9196-423a-aa7d-b34d90563f16	t	${role_manage-account}	manage-account	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	517c0b1a-9196-423a-aa7d-b34d90563f16	\N
9158b8bf-6453-4cd5-90ab-fff380a44357	517c0b1a-9196-423a-aa7d-b34d90563f16	t	${role_manage-account-links}	manage-account-links	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	517c0b1a-9196-423a-aa7d-b34d90563f16	\N
7dc2c1c7-c1c1-4bfc-8759-823c6bdd813e	517c0b1a-9196-423a-aa7d-b34d90563f16	t	${role_view-applications}	view-applications	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	517c0b1a-9196-423a-aa7d-b34d90563f16	\N
bee1c5c0-89ac-4a28-93f9-df375a710ed4	517c0b1a-9196-423a-aa7d-b34d90563f16	t	${role_view-consent}	view-consent	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	517c0b1a-9196-423a-aa7d-b34d90563f16	\N
fd2ccca6-9721-49a2-8d2b-fc06f74e671b	517c0b1a-9196-423a-aa7d-b34d90563f16	t	${role_manage-consent}	manage-consent	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	517c0b1a-9196-423a-aa7d-b34d90563f16	\N
1a1f1bf6-fd94-4963-be15-25a3e71d189f	517c0b1a-9196-423a-aa7d-b34d90563f16	t	${role_delete-account}	delete-account	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	517c0b1a-9196-423a-aa7d-b34d90563f16	\N
f8c5454b-89d9-46c6-94ab-5a04bd488b42	3dd5827d-d97e-4d60-8393-34c783c8dc1e	t	${role_read-token}	read-token	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	3dd5827d-d97e-4d60-8393-34c783c8dc1e	\N
59ea3a30-a7d0-4d1a-ae70-4347f904f306	18602e15-4147-450e-a300-bafd1e217611	t	${role_impersonation}	impersonation	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	18602e15-4147-450e-a300-bafd1e217611	\N
b7625a11-0a22-4d35-991c-553eba365b35	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	f	${role_offline-access}	offline_access	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N	\N
bdc1e5dc-8c27-4aa2-bc39-596d9adba56f	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	f	${role_uma_authorization}	uma_authorization	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	\N	\N
89eb80a6-3195-48b2-b9fb-ab48c520ef29	7ced6891-759d-44fb-86e7-93a616211016	t	\N	uma_protection	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	7ced6891-759d-44fb-86e7-93a616211016	\N
12466ca8-22bb-4186-9a3d-74ee031dbe28	7ced6891-759d-44fb-86e7-93a616211016	t	\N	admin	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	7ced6891-759d-44fb-86e7-93a616211016	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
z6q5e	19.0.3	1699946037
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
f4853d92-95f8-416f-9ae0-3f8e314aa1e4	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
235be761-d204-48bb-8f23-9a72add1b5c2	defaultResourceType	urn:focus:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
d87b4f2d-e631-46e4-a6ac-5d02e8e6d6e3	audience resolve	openid-connect	oidc-audience-resolve-mapper	93c6f138-60a1-4c3d-8de6-4d18812c97b6	\N
b9d098f2-c727-474a-ac2c-82c774ad2d5f	locale	openid-connect	oidc-usermodel-attribute-mapper	d5d1b9a2-4d07-4271-9c04-f3a6c214362e	\N
62534a4b-7b87-48d3-bfdb-74489c5e87bd	role list	saml	saml-role-list-mapper	\N	9fa556a9-2de3-4249-8dba-01f33294ec1c
be818fd0-e436-4d21-9a99-1218032ef592	full name	openid-connect	oidc-full-name-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
f82612a9-0bc6-4a99-994e-d28a28cf0752	family name	openid-connect	oidc-usermodel-property-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
474f41c4-af6f-401d-ba6a-766bf7e024fb	given name	openid-connect	oidc-usermodel-property-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
cc724578-e568-4d9d-83cd-725b0c2224ac	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
1b0d8523-a98e-4beb-affb-36a709b32805	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
1916bbf9-83dc-43aa-8f21-905dea961e3c	username	openid-connect	oidc-usermodel-property-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
c6c4fdfa-64f3-4811-b979-cf5933343a95	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
eeff9a3e-1d30-4ea8-966c-49e9c72aecaf	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
58de7adc-9924-47e2-8c04-e56967b9ce79	website	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
3d5c763f-7d95-4c4d-be96-466fb71f1675	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
4438fc84-c885-4ff0-8716-f69c6a53891d	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
e1de1342-0538-4651-8b42-f2959087781c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
7ace7755-30fb-4a6a-9c80-ed97ded6d7c9	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
43bc1e6d-c2b3-4b9c-bfce-b93323369f85	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	0753949e-e1ac-4070-84c9-a17166fb8e15
393644f7-0c83-4de2-8638-f39b5f365cf9	email	openid-connect	oidc-usermodel-property-mapper	\N	efee9e8c-eb99-4329-b8d5-1b4c69ae9110
5ec31769-b274-4f45-b531-f88225ccb13c	email verified	openid-connect	oidc-usermodel-property-mapper	\N	efee9e8c-eb99-4329-b8d5-1b4c69ae9110
6d656b0b-62ab-450b-8307-2437368ce10b	address	openid-connect	oidc-address-mapper	\N	b4f5c965-e38a-4142-a223-306670728a4b
d1538cda-73c6-42b0-a6ae-580ab16a80f5	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d7742b3f-208e-4106-9c3c-c68f3b331dbf
3aede5f0-c5bb-4ed9-953a-2ee6fb5e3903	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d7742b3f-208e-4106-9c3c-c68f3b331dbf
6842b4a0-401f-4759-9e48-250d66f3aae1	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e1119a42-a4d3-4043-a236-9f72872781f8
6667fe51-3217-477c-a06c-f5eb30ca3692	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e1119a42-a4d3-4043-a236-9f72872781f8
7ab532a1-199d-45cc-a7cb-fe51e6901abf	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e1119a42-a4d3-4043-a236-9f72872781f8
8808151b-8f2e-4107-a9e0-f40542540348	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	c1e7706f-b07e-4858-b0d2-f5095446ad3d
0dde474d-e319-40c4-8d2f-84216ad72cba	upn	openid-connect	oidc-usermodel-property-mapper	\N	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7
66c372bc-52e5-4ce0-80a3-2fbbce9a803c	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	4f6ffca0-a107-4896-b1c7-3eb90e28e2e7
9d5120d4-f056-4d42-9870-52cb4ba5d1ac	acr loa level	openid-connect	oidc-acr-mapper	\N	bf580cc3-5425-49d0-803f-178880e0f39d
792931bd-16dd-4af3-91a5-892699415ada	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	7ced6891-759d-44fb-86e7-93a616211016	\N
985211d6-eda8-49b7-b7ad-f987cb391b53	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	7ced6891-759d-44fb-86e7-93a616211016	\N
28eb611c-7aaf-43f9-becb-f2e79fe1d579	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	7ced6891-759d-44fb-86e7-93a616211016	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
b9d098f2-c727-474a-ac2c-82c774ad2d5f	true	userinfo.token.claim
b9d098f2-c727-474a-ac2c-82c774ad2d5f	locale	user.attribute
b9d098f2-c727-474a-ac2c-82c774ad2d5f	true	id.token.claim
b9d098f2-c727-474a-ac2c-82c774ad2d5f	true	access.token.claim
b9d098f2-c727-474a-ac2c-82c774ad2d5f	locale	claim.name
b9d098f2-c727-474a-ac2c-82c774ad2d5f	String	jsonType.label
62534a4b-7b87-48d3-bfdb-74489c5e87bd	false	single
62534a4b-7b87-48d3-bfdb-74489c5e87bd	Basic	attribute.nameformat
62534a4b-7b87-48d3-bfdb-74489c5e87bd	Role	attribute.name
be818fd0-e436-4d21-9a99-1218032ef592	true	userinfo.token.claim
be818fd0-e436-4d21-9a99-1218032ef592	true	id.token.claim
be818fd0-e436-4d21-9a99-1218032ef592	true	access.token.claim
f82612a9-0bc6-4a99-994e-d28a28cf0752	true	userinfo.token.claim
f82612a9-0bc6-4a99-994e-d28a28cf0752	lastName	user.attribute
f82612a9-0bc6-4a99-994e-d28a28cf0752	true	id.token.claim
f82612a9-0bc6-4a99-994e-d28a28cf0752	true	access.token.claim
f82612a9-0bc6-4a99-994e-d28a28cf0752	family_name	claim.name
f82612a9-0bc6-4a99-994e-d28a28cf0752	String	jsonType.label
474f41c4-af6f-401d-ba6a-766bf7e024fb	true	userinfo.token.claim
474f41c4-af6f-401d-ba6a-766bf7e024fb	firstName	user.attribute
474f41c4-af6f-401d-ba6a-766bf7e024fb	true	id.token.claim
474f41c4-af6f-401d-ba6a-766bf7e024fb	true	access.token.claim
474f41c4-af6f-401d-ba6a-766bf7e024fb	given_name	claim.name
474f41c4-af6f-401d-ba6a-766bf7e024fb	String	jsonType.label
cc724578-e568-4d9d-83cd-725b0c2224ac	true	userinfo.token.claim
cc724578-e568-4d9d-83cd-725b0c2224ac	middleName	user.attribute
cc724578-e568-4d9d-83cd-725b0c2224ac	true	id.token.claim
cc724578-e568-4d9d-83cd-725b0c2224ac	true	access.token.claim
cc724578-e568-4d9d-83cd-725b0c2224ac	middle_name	claim.name
cc724578-e568-4d9d-83cd-725b0c2224ac	String	jsonType.label
1b0d8523-a98e-4beb-affb-36a709b32805	true	userinfo.token.claim
1b0d8523-a98e-4beb-affb-36a709b32805	nickname	user.attribute
1b0d8523-a98e-4beb-affb-36a709b32805	true	id.token.claim
1b0d8523-a98e-4beb-affb-36a709b32805	true	access.token.claim
1b0d8523-a98e-4beb-affb-36a709b32805	nickname	claim.name
1b0d8523-a98e-4beb-affb-36a709b32805	String	jsonType.label
1916bbf9-83dc-43aa-8f21-905dea961e3c	true	userinfo.token.claim
1916bbf9-83dc-43aa-8f21-905dea961e3c	username	user.attribute
1916bbf9-83dc-43aa-8f21-905dea961e3c	true	id.token.claim
1916bbf9-83dc-43aa-8f21-905dea961e3c	true	access.token.claim
1916bbf9-83dc-43aa-8f21-905dea961e3c	preferred_username	claim.name
1916bbf9-83dc-43aa-8f21-905dea961e3c	String	jsonType.label
c6c4fdfa-64f3-4811-b979-cf5933343a95	true	userinfo.token.claim
c6c4fdfa-64f3-4811-b979-cf5933343a95	profile	user.attribute
c6c4fdfa-64f3-4811-b979-cf5933343a95	true	id.token.claim
c6c4fdfa-64f3-4811-b979-cf5933343a95	true	access.token.claim
c6c4fdfa-64f3-4811-b979-cf5933343a95	profile	claim.name
c6c4fdfa-64f3-4811-b979-cf5933343a95	String	jsonType.label
eeff9a3e-1d30-4ea8-966c-49e9c72aecaf	true	userinfo.token.claim
eeff9a3e-1d30-4ea8-966c-49e9c72aecaf	picture	user.attribute
eeff9a3e-1d30-4ea8-966c-49e9c72aecaf	true	id.token.claim
eeff9a3e-1d30-4ea8-966c-49e9c72aecaf	true	access.token.claim
eeff9a3e-1d30-4ea8-966c-49e9c72aecaf	picture	claim.name
eeff9a3e-1d30-4ea8-966c-49e9c72aecaf	String	jsonType.label
58de7adc-9924-47e2-8c04-e56967b9ce79	true	userinfo.token.claim
58de7adc-9924-47e2-8c04-e56967b9ce79	website	user.attribute
58de7adc-9924-47e2-8c04-e56967b9ce79	true	id.token.claim
58de7adc-9924-47e2-8c04-e56967b9ce79	true	access.token.claim
58de7adc-9924-47e2-8c04-e56967b9ce79	website	claim.name
58de7adc-9924-47e2-8c04-e56967b9ce79	String	jsonType.label
3d5c763f-7d95-4c4d-be96-466fb71f1675	true	userinfo.token.claim
3d5c763f-7d95-4c4d-be96-466fb71f1675	gender	user.attribute
3d5c763f-7d95-4c4d-be96-466fb71f1675	true	id.token.claim
3d5c763f-7d95-4c4d-be96-466fb71f1675	true	access.token.claim
3d5c763f-7d95-4c4d-be96-466fb71f1675	gender	claim.name
3d5c763f-7d95-4c4d-be96-466fb71f1675	String	jsonType.label
4438fc84-c885-4ff0-8716-f69c6a53891d	true	userinfo.token.claim
4438fc84-c885-4ff0-8716-f69c6a53891d	birthdate	user.attribute
4438fc84-c885-4ff0-8716-f69c6a53891d	true	id.token.claim
4438fc84-c885-4ff0-8716-f69c6a53891d	true	access.token.claim
4438fc84-c885-4ff0-8716-f69c6a53891d	birthdate	claim.name
4438fc84-c885-4ff0-8716-f69c6a53891d	String	jsonType.label
e1de1342-0538-4651-8b42-f2959087781c	true	userinfo.token.claim
e1de1342-0538-4651-8b42-f2959087781c	zoneinfo	user.attribute
e1de1342-0538-4651-8b42-f2959087781c	true	id.token.claim
e1de1342-0538-4651-8b42-f2959087781c	true	access.token.claim
e1de1342-0538-4651-8b42-f2959087781c	zoneinfo	claim.name
e1de1342-0538-4651-8b42-f2959087781c	String	jsonType.label
7ace7755-30fb-4a6a-9c80-ed97ded6d7c9	true	userinfo.token.claim
7ace7755-30fb-4a6a-9c80-ed97ded6d7c9	locale	user.attribute
7ace7755-30fb-4a6a-9c80-ed97ded6d7c9	true	id.token.claim
7ace7755-30fb-4a6a-9c80-ed97ded6d7c9	true	access.token.claim
7ace7755-30fb-4a6a-9c80-ed97ded6d7c9	locale	claim.name
7ace7755-30fb-4a6a-9c80-ed97ded6d7c9	String	jsonType.label
43bc1e6d-c2b3-4b9c-bfce-b93323369f85	true	userinfo.token.claim
43bc1e6d-c2b3-4b9c-bfce-b93323369f85	updatedAt	user.attribute
43bc1e6d-c2b3-4b9c-bfce-b93323369f85	true	id.token.claim
43bc1e6d-c2b3-4b9c-bfce-b93323369f85	true	access.token.claim
43bc1e6d-c2b3-4b9c-bfce-b93323369f85	updated_at	claim.name
43bc1e6d-c2b3-4b9c-bfce-b93323369f85	long	jsonType.label
393644f7-0c83-4de2-8638-f39b5f365cf9	true	userinfo.token.claim
393644f7-0c83-4de2-8638-f39b5f365cf9	email	user.attribute
393644f7-0c83-4de2-8638-f39b5f365cf9	true	id.token.claim
393644f7-0c83-4de2-8638-f39b5f365cf9	true	access.token.claim
393644f7-0c83-4de2-8638-f39b5f365cf9	email	claim.name
393644f7-0c83-4de2-8638-f39b5f365cf9	String	jsonType.label
5ec31769-b274-4f45-b531-f88225ccb13c	true	userinfo.token.claim
5ec31769-b274-4f45-b531-f88225ccb13c	emailVerified	user.attribute
5ec31769-b274-4f45-b531-f88225ccb13c	true	id.token.claim
5ec31769-b274-4f45-b531-f88225ccb13c	true	access.token.claim
5ec31769-b274-4f45-b531-f88225ccb13c	email_verified	claim.name
5ec31769-b274-4f45-b531-f88225ccb13c	boolean	jsonType.label
6d656b0b-62ab-450b-8307-2437368ce10b	formatted	user.attribute.formatted
6d656b0b-62ab-450b-8307-2437368ce10b	country	user.attribute.country
6d656b0b-62ab-450b-8307-2437368ce10b	postal_code	user.attribute.postal_code
6d656b0b-62ab-450b-8307-2437368ce10b	true	userinfo.token.claim
6d656b0b-62ab-450b-8307-2437368ce10b	street	user.attribute.street
6d656b0b-62ab-450b-8307-2437368ce10b	true	id.token.claim
6d656b0b-62ab-450b-8307-2437368ce10b	region	user.attribute.region
6d656b0b-62ab-450b-8307-2437368ce10b	true	access.token.claim
6d656b0b-62ab-450b-8307-2437368ce10b	locality	user.attribute.locality
d1538cda-73c6-42b0-a6ae-580ab16a80f5	true	userinfo.token.claim
d1538cda-73c6-42b0-a6ae-580ab16a80f5	phoneNumber	user.attribute
d1538cda-73c6-42b0-a6ae-580ab16a80f5	true	id.token.claim
d1538cda-73c6-42b0-a6ae-580ab16a80f5	true	access.token.claim
d1538cda-73c6-42b0-a6ae-580ab16a80f5	phone_number	claim.name
d1538cda-73c6-42b0-a6ae-580ab16a80f5	String	jsonType.label
3aede5f0-c5bb-4ed9-953a-2ee6fb5e3903	true	userinfo.token.claim
3aede5f0-c5bb-4ed9-953a-2ee6fb5e3903	phoneNumberVerified	user.attribute
3aede5f0-c5bb-4ed9-953a-2ee6fb5e3903	true	id.token.claim
3aede5f0-c5bb-4ed9-953a-2ee6fb5e3903	true	access.token.claim
3aede5f0-c5bb-4ed9-953a-2ee6fb5e3903	phone_number_verified	claim.name
3aede5f0-c5bb-4ed9-953a-2ee6fb5e3903	boolean	jsonType.label
6842b4a0-401f-4759-9e48-250d66f3aae1	true	multivalued
6842b4a0-401f-4759-9e48-250d66f3aae1	foo	user.attribute
6842b4a0-401f-4759-9e48-250d66f3aae1	true	access.token.claim
6842b4a0-401f-4759-9e48-250d66f3aae1	realm_access.roles	claim.name
6842b4a0-401f-4759-9e48-250d66f3aae1	String	jsonType.label
6667fe51-3217-477c-a06c-f5eb30ca3692	true	multivalued
6667fe51-3217-477c-a06c-f5eb30ca3692	foo	user.attribute
6667fe51-3217-477c-a06c-f5eb30ca3692	true	access.token.claim
6667fe51-3217-477c-a06c-f5eb30ca3692	resource_access.${client_id}.roles	claim.name
6667fe51-3217-477c-a06c-f5eb30ca3692	String	jsonType.label
0dde474d-e319-40c4-8d2f-84216ad72cba	true	userinfo.token.claim
0dde474d-e319-40c4-8d2f-84216ad72cba	username	user.attribute
0dde474d-e319-40c4-8d2f-84216ad72cba	true	id.token.claim
0dde474d-e319-40c4-8d2f-84216ad72cba	true	access.token.claim
0dde474d-e319-40c4-8d2f-84216ad72cba	upn	claim.name
0dde474d-e319-40c4-8d2f-84216ad72cba	String	jsonType.label
66c372bc-52e5-4ce0-80a3-2fbbce9a803c	true	multivalued
66c372bc-52e5-4ce0-80a3-2fbbce9a803c	foo	user.attribute
66c372bc-52e5-4ce0-80a3-2fbbce9a803c	true	id.token.claim
66c372bc-52e5-4ce0-80a3-2fbbce9a803c	true	access.token.claim
66c372bc-52e5-4ce0-80a3-2fbbce9a803c	groups	claim.name
66c372bc-52e5-4ce0-80a3-2fbbce9a803c	String	jsonType.label
9d5120d4-f056-4d42-9870-52cb4ba5d1ac	true	id.token.claim
9d5120d4-f056-4d42-9870-52cb4ba5d1ac	true	access.token.claim
792931bd-16dd-4af3-91a5-892699415ada	clientId	user.session.note
792931bd-16dd-4af3-91a5-892699415ada	true	id.token.claim
792931bd-16dd-4af3-91a5-892699415ada	true	access.token.claim
792931bd-16dd-4af3-91a5-892699415ada	clientId	claim.name
792931bd-16dd-4af3-91a5-892699415ada	String	jsonType.label
985211d6-eda8-49b7-b7ad-f987cb391b53	clientHost	user.session.note
985211d6-eda8-49b7-b7ad-f987cb391b53	true	id.token.claim
985211d6-eda8-49b7-b7ad-f987cb391b53	true	access.token.claim
985211d6-eda8-49b7-b7ad-f987cb391b53	clientHost	claim.name
985211d6-eda8-49b7-b7ad-f987cb391b53	String	jsonType.label
28eb611c-7aaf-43f9-becb-f2e79fe1d579	clientAddress	user.session.note
28eb611c-7aaf-43f9-becb-f2e79fe1d579	true	id.token.claim
28eb611c-7aaf-43f9-becb-f2e79fe1d579	true	access.token.claim
28eb611c-7aaf-43f9-becb-f2e79fe1d579	clientAddress	claim.name
28eb611c-7aaf-43f9-becb-f2e79fe1d579	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	60	300	5880	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	18602e15-4147-450e-a300-bafd1e217611	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	d0c3fe24-66ee-496d-8053-dd806c2b45b2	cacc2361-9f62-4181-b18a-91325963ca60	e8100237-cf94-435d-83a8-9a55f172fcf5	b6ad110e-135d-4fea-8ec7-818f13db76e7	7cf6446c-a53a-4eb5-b5c2-c7132692491b	2592000	f	900	t	f	591ed8c8-25a7-4fe6-80dc-85a10fee54d9	0	f	0	0	d311508e-26cc-48b8-a746-b73fe4178903
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
cibaBackchannelTokenDeliveryMode	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	poll
cibaExpiresIn	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	120
cibaAuthRequestedUserHint	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	login_hint
parRequestUriLifespan	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	60
cibaInterval	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	5
actionTokenGeneratedByUserLifespan-verify-email	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	
actionTokenGeneratedByUserLifespan-idp-verify-account-via-email	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	
actionTokenGeneratedByUserLifespan-reset-credentials	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	
actionTokenGeneratedByUserLifespan-execute-actions	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	
displayName	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	Keycloak
displayNameHtml	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	<div class="kc-logo-text"><span>Keycloak</span></div>
bruteForceProtected	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	false
permanentLockout	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	false
maxFailureWaitSeconds	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	900
minimumQuickLoginWaitSeconds	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	60
waitIncrementSeconds	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	60
quickLoginCheckMilliSeconds	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	1000
maxDeltaTimeSeconds	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	43200
failureFactor	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	30
actionTokenGeneratedByAdminLifespan	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	43200
actionTokenGeneratedByUserLifespan	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	300
oauth2DeviceCodeLifespan	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	600
oauth2DevicePollingInterval	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	5
defaultSignatureAlgorithm	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	RS256
offlineSessionMaxLifespanEnabled	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	false
offlineSessionMaxLifespan	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	5184000
clientSessionIdleTimeout	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	0
clientSessionMaxLifespan	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	0
clientOfflineSessionIdleTimeout	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	0
clientOfflineSessionMaxLifespan	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	0
webAuthnPolicyRpEntityName	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	keycloak
webAuthnPolicySignatureAlgorithms	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	ES256
webAuthnPolicyRpId	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	
webAuthnPolicyAttestationConveyancePreference	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	not specified
webAuthnPolicyAuthenticatorAttachment	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	not specified
webAuthnPolicyRequireResidentKey	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	not specified
webAuthnPolicyUserVerificationRequirement	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	not specified
webAuthnPolicyCreateTimeout	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	0
webAuthnPolicyAvoidSameAuthenticatorRegister	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	false
webAuthnPolicyRpEntityNamePasswordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	ES256
webAuthnPolicyRpIdPasswordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	
webAuthnPolicyAttestationConveyancePreferencePasswordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	not specified
webAuthnPolicyRequireResidentKeyPasswordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	not specified
webAuthnPolicyCreateTimeoutPasswordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	false
client-policies.profiles	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	{"profiles":[]}
client-policies.policies	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	
_browser_header.xContentTypeOptions	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	nosniff
_browser_header.xRobotsTag	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	none
_browser_header.xFrameOptions	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	SAMEORIGIN
_browser_header.xXSSProtection	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	1; mode=block
_browser_header.contentSecurityPolicy	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
2fffb7fc-8a60-4911-8ea7-cf471918a4f8	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	2fffb7fc-8a60-4911-8ea7-cf471918a4f8
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
517c0b1a-9196-423a-aa7d-b34d90563f16	/realms/master/account/*
93c6f138-60a1-4c3d-8de6-4d18812c97b6	/realms/master/account/*
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	/admin/master/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
c3aa505a-1933-4dee-b96a-1aa37da15012	VERIFY_EMAIL	Verify Email	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	t	f	VERIFY_EMAIL	50
b774ae55-dec9-4202-8ed4-fdf3666751b5	UPDATE_PROFILE	Update Profile	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	t	f	UPDATE_PROFILE	40
137406c0-8b2c-42bb-b850-f48b6eb40e39	CONFIGURE_TOTP	Configure OTP	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	t	f	CONFIGURE_TOTP	10
1af636e3-7c73-4419-aa4d-935b50c759bc	UPDATE_PASSWORD	Update Password	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	t	f	UPDATE_PASSWORD	30
40d86abb-d184-4db4-abca-b33474c0e45a	terms_and_conditions	Terms and Conditions	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	f	f	terms_and_conditions	20
cb9e0967-7729-4191-a791-a3c815e327ec	update_user_locale	Update User Locale	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	t	f	update_user_locale	1000
c8275b90-8af7-4b88-93b8-6045b5af6049	delete_account	Delete Account	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	f	f	delete_account	60
39e39dc8-432c-4d7a-9a0e-58bcaf5b1704	webauthn-register	Webauthn Register	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	t	f	webauthn-register	70
49ff33b4-d3ce-4382-abf4-db9905ec9a45	webauthn-register-passwordless	Webauthn Register Passwordless	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
7ced6891-759d-44fb-86e7-93a616211016	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
f4853d92-95f8-416f-9ae0-3f8e314aa1e4	Default Policy	A policy that grants access only for users within this realm	js	0	0	7ced6891-759d-44fb-86e7-93a616211016	\N
235be761-d204-48bb-8f23-9a72add1b5c2	Default Permission	A permission that applies to the default resource type	resource	1	0	7ced6891-759d-44fb-86e7-93a616211016	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
8e18f659-345f-4213-af9e-583351679b8d	Default Resource	urn:focus:resources:default	\N	7ced6891-759d-44fb-86e7-93a616211016	7ced6891-759d-44fb-86e7-93a616211016	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
8e18f659-345f-4213-af9e-583351679b8d	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
93c6f138-60a1-4c3d-8de6-4d18812c97b6	d5f603cb-45dc-40b1-9085-f5fd9effa6f1
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
bbcb5b30-59a5-45e5-8210-930b4a015819	\N	3afe0040-4a5c-4eed-84b9-c3794652ef2f	f	t	\N	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	admin	1699946039299	\N	0
c13d4427-8382-4dad-8f77-256143b5123c	\N	4a57de24-786a-443e-a0b1-51d7cab8f4cc	f	t	\N	\N	\N	2fffb7fc-8a60-4911-8ea7-cf471918a4f8	service-account-focus	1699947910860	7ced6891-759d-44fb-86e7-93a616211016	0
8182d86e-705a-4808-b40a-f85eda15ad01	\N	27f83ba3-5f6f-4a18-9e6e-159b99588429	t	t	\N			2fffb7fc-8a60-4911-8ea7-cf471918a4f8	adm1	1699948164405	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
d311508e-26cc-48b8-a746-b73fe4178903	bbcb5b30-59a5-45e5-8210-930b4a015819
b594d158-3634-4acb-b873-bf9f7957d5e1	bbcb5b30-59a5-45e5-8210-930b4a015819
d311508e-26cc-48b8-a746-b73fe4178903	c13d4427-8382-4dad-8f77-256143b5123c
89eb80a6-3195-48b2-b9fb-ab48c520ef29	c13d4427-8382-4dad-8f77-256143b5123c
12466ca8-22bb-4186-9a3d-74ee031dbe28	8182d86e-705a-4808-b40a-f85eda15ad01
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
d5d1b9a2-4d07-4271-9c04-f3a6c214362e	+
7ced6891-759d-44fb-86e7-93a616211016	http://localhost:3000
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO keycloak;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: keycloak
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

