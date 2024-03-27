-- https://mariadb.com/kb/en/data-types/
-- https://mariadb.com/kb/en/development-writing-plugins-for-mariadb/
-- SELECT UUID();
-- SELECT UUID_SHORT();
-- SELECT SYS_GUID();

DROP SCHEMA IF EXISTS `DevQon`;
DROP SCHEMA IF EXISTS `DownQuark`;


CREATE SCHEMA `DownQuark`;

CREATE SCHEMA `DevQon`;

CREATE TABLE `DownQuark`.`_downquark` (
  `id` uuid DEFAULT UUID() PRIMARY KEY NOT NULL,
  `version` tinytext DEFAULT '0.0.0-pre-alpha',
  `path_repository` tinytext DEFAULT 'https://github.com/DownQuark-Work',
  `path_website` tinytext DEFAULT 'https://www.downquark.work',
  `created` timestamp DEFAULT (now()),
  `edited` timestamp DEFAULT (now())
);

CREATE TABLE `DownQuark`.`projects` (
  `id` tinyint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `project_id` ENUM ('DEVELOPMENT_QONSOLE', 'DEVELOPMENT_QONSOLE__QANBAN_BOARD'),
  `created` timestamp DEFAULT (now()),
  `edited` timestamp DEFAULT (now())
);

CREATE TABLE `DownQuark`.`accounts` (
  `id` tinyint PRIMARY KEY AUTO_INCREMENT COMMENT 'used only inside the DownQuark database',
  `uuid` uuid DEFAULT UUID() UNIQUE NOT NULL COMMENT 'this will be the lookup reference in subsequent projects',
  `type` ENUM ('DEVELOPMENT', 'PERSONAL', 'ORGANIZATION') NOT NULL DEFAULT 'PERSONAL',
  `created` timestamp DEFAULT (now()),
  `edited` timestamp DEFAULT (now())
);

CREATE TABLE `DownQuark`.`accounts_authorization` (
  `id` tinyint PRIMARY KEY,
  `salt` BIGINT UNSIGNED DEFAULT UUID_SHORT(),
  `hash` varchar(256)
);

CREATE TABLE `DownQuark`.`accounts_development` (
  `id` tinyint PRIMARY KEY,
  `api_key` tinytext UNIQUE NOT NULL,
  `expires` datetime COMMENT '90 days?'
);

CREATE TABLE `DownQuark`.`accounts_organization` (
  `id` tinyint PRIMARY KEY,
  `name` varchar(30) COMMENT 'the name of the organization',
  `address` varchar(200),
  `state` varchar(15)
);

CREATE TABLE `DownQuark`.`accounts_personal` (
  `id` tinyint PRIMARY KEY,
  `name` varchar(30),
  `username` varchar(30),
  `email` varchar(50),
  `last_login` datetime DEFAULT (now())
);

CREATE TABLE `DownQuark`.`Map_Projects` (
  `id` ENUM ('DEVELOPMENT_QONSOLE', 'DEVELOPMENT_QONSOLE__QANBAN_BOARD') PRIMARY KEY,
  `name` varchar(50) NOT NULL,
  `path` varchar(100) COMMENT '
this will most likely be the database table
- but could be github, etc
'
);

CREATE TABLE `DevQon`.`_project` (
  `id` ENUM ('DEVELOPMENT_QONSOLE', 'DEVELOPMENT_QONSOLE__QANBAN_BOARD') DEFAULT 'DEVELOPMENT_QONSOLE',
  `version` tinytext DEFAULT '0.0.0-pre-alpha',
  `path_repository` tinytext DEFAULT 'https://github.com/DownQuark-Work/downquark.applicationFoss.DevQon',
  `path_website` tinytext DEFAULT 'https://www.downquark.work/?projects_active_foss_devqon',
  `created` timestamp DEFAULT (now()),
  `edited` timestamp DEFAULT (now())
);

CREATE TABLE `DevQon`.`metrics` (
  `account` uuid  DEFAULT UUID() NOT NULL,
  `location` INET4,
  `entry` timestamp DEFAULT (now()),
  PRIMARY KEY (`account`, `location`)
);

CREATE TABLE `DevQon`.`accounts` (
  `id` uuid PRIMARY KEY NOT NULL,
  `ip_address` INET4,
  `last_active` timestamp DEFAULT (now()),
  UNIQUE (`id`,`ip_address`)
);

CREATE TABLE `DevQon`.`account_associations` (
  `from` uuid NOT NULL,
  `to` uuid NOT NULL,
  `updated` timestamp DEFAULT (now())
);

ALTER TABLE `DownQuark`.`_downquark` COMMENT = 'tbd';

ALTER TABLE `DownQuark`.`projects` COMMENT = 'each project deemed sufficient will have their row here';

ALTER TABLE `DownQuark`.`accounts` COMMENT = '
all users across all projects will have a mapping on this database table.
subsequent projects and tables will store the relevant info required for their integrations
';

ALTER TABLE `DevQon`.`_project` COMMENT = 'tbd';

ALTER TABLE `DevQon`.`metrics` COMMENT = 'tbd';

ALTER TABLE `DevQon`.`accounts` COMMENT = '
this table will be expanded as we continue to figure out what
metrics we want to track, etc
';

ALTER TABLE `DevQon`.`account_associations` COMMENT = '
social aspects - tbd
';

ALTER TABLE `DownQuark`.`projects` ADD FOREIGN KEY (`project_id`) REFERENCES `DownQuark`.`Map_Projects` (`id`);

ALTER TABLE `DownQuark`.`accounts_authorization` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`id`) ON DELETE CASCADE;

ALTER TABLE `DownQuark`.`accounts_development` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`id`);

ALTER TABLE `DownQuark`.`accounts_organization` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`id`);

ALTER TABLE `DownQuark`.`accounts_personal` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`id`);

ALTER TABLE `DevQon`.`_project` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`Map_Projects` (`id`);

ALTER TABLE `DevQon`.`accounts` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`uuid`);

ALTER TABLE `DevQon`.`account_associations` ADD FOREIGN KEY (`from`) REFERENCES `DevQon`.`accounts` (`id`);

ALTER TABLE `DevQon`.`account_associations` ADD FOREIGN KEY (`to`) REFERENCES `DevQon`.`accounts` (`id`);

ALTER TABLE `DevQon`.`metrics` ADD FOREIGN KEY (`account`,`location`) REFERENCES `DevQon`.`accounts`(`id`,`ip_address`);
