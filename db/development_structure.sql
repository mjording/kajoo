CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "issue_id" integer, "text" varchar(255), "user_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "issues" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "description" text, "lat" float, "lon" float, "radius" integer, "created_at" datetime, "updated_at" datetime, "address" varchar(255), "resolved" boolean, "ip_address" varchar(255), "location" text, "city" varchar(255), "state" varchar(255), "country_code" varchar(255), "country_name" varchar(255), "street_address" varchar(255), "zipcode" varchar(255), "vote_count" integer DEFAULT 0, "resolved_at" datetime, "resolver_id" integer, "creator_id" integer);
CREATE TABLE "reports" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "title" varchar(255), "description" text, "lat" float, "lon" float, "radius" integer, "created_at" datetime, "updated_at" datetime, "issue_id" integer, "tags" varchar(255), "address" text, "ip_address" varchar(255), "location" text, "city" varchar(255), "state" varchar(255), "country_code" varchar(255), "country_name" varchar(255), "street_address" varchar(255), "zipcode" varchar(255));
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "solutions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "user_id" integer, "issue_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "user_tokens" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "provider" varchar(255), "uid" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "remember_token" varchar(255), "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "created_at" datetime, "updated_at" datetime, "avatar_url" varchar(255), "twitter_id" integer, "name" varchar(255), "points" integer DEFAULT 0, "twitter_username" varchar(255));
CREATE TABLE "versions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "versioned_id" integer, "versioned_type" varchar(255), "user_id" integer, "user_type" varchar(255), "user_name" varchar(255), "modifications" text, "number" integer, "reverted_from" integer, "tag" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "votes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "issue_id" integer, "solution_id" integer, "type" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE INDEX "index_versions_on_created_at" ON "versions" ("created_at");
CREATE INDEX "index_versions_on_number" ON "versions" ("number");
CREATE INDEX "index_versions_on_tag" ON "versions" ("tag");
CREATE INDEX "index_versions_on_user_id_and_user_type" ON "versions" ("user_id", "user_type");
CREATE INDEX "index_versions_on_user_name" ON "versions" ("user_name");
CREATE INDEX "index_versions_on_versioned_id_and_versioned_type" ON "versions" ("versioned_id", "versioned_type");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20110313201332');

INSERT INTO schema_migrations (version) VALUES ('20110308174646');

INSERT INTO schema_migrations (version) VALUES ('20110309000513');

INSERT INTO schema_migrations (version) VALUES ('20110309030251');

INSERT INTO schema_migrations (version) VALUES ('20110309072305');

INSERT INTO schema_migrations (version) VALUES ('20110309072547');

INSERT INTO schema_migrations (version) VALUES ('20110309072917');

INSERT INTO schema_migrations (version) VALUES ('20110309165423');

INSERT INTO schema_migrations (version) VALUES ('20110309183246');

INSERT INTO schema_migrations (version) VALUES ('20110309183506');

INSERT INTO schema_migrations (version) VALUES ('20110309210727');

INSERT INTO schema_migrations (version) VALUES ('20110310004950');

INSERT INTO schema_migrations (version) VALUES ('20110310041001');

INSERT INTO schema_migrations (version) VALUES ('20110310050857');

INSERT INTO schema_migrations (version) VALUES ('20110310054739');

INSERT INTO schema_migrations (version) VALUES ('20110310142438');

INSERT INTO schema_migrations (version) VALUES ('20110310143832');

INSERT INTO schema_migrations (version) VALUES ('20110310145327');

INSERT INTO schema_migrations (version) VALUES ('20110310154306');

INSERT INTO schema_migrations (version) VALUES ('20110310163038');

INSERT INTO schema_migrations (version) VALUES ('20110310164156');

INSERT INTO schema_migrations (version) VALUES ('20110310164948');

INSERT INTO schema_migrations (version) VALUES ('20110310171938');

INSERT INTO schema_migrations (version) VALUES ('20110312224301');

INSERT INTO schema_migrations (version) VALUES ('20110313200407');