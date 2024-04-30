
-- # DUMP DATABASES:
--  mariadb-dump --user=mlnck@localhost --lock-tables --all-databases > ./all-database-dump.sql

-- SELECT trigger_name, action_order FROM information_schema.triggers it WHERE event_object_table='accounts';
-- https://mariadb.com/kb/en/create-trigger/#followsprecedes-other_trigger_name

-- https://mariadb.com/kb/en/common-table-expressions/
-- https://www.techonthenet.com/mariadb/loops/repeat.php
/** MORE INTERIM WORK AT EOF*/
/*
##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$#
DROP PROCEDURE IF EXISTS CreatePaths;


##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$#

/*  USAGE:
  UPDATE `DownQuark`.accounts SET set_password = "goofy" WHERE id = 21;
  UPDATE `DownQuark`.accounts SET set_password = "mickeymouse" WHERE id = 22;
  UPDATE `DownQuark`.accounts SET set_password = "donaldduck" WHERE id = 23;
  SELECT trigger_name, action_order FROM information_schema.triggers it WHERE event_object_table='accounts';
  SELECT hex(kdf("mickeymouse","B8E3797AC1113561535E7BED4E", 1313, 'hkdf',128));
  SELECT hex(kdf("donaldduck","5F44617E66B5319CDAEF3A1CC4", 1313, 'hkdf',128));
  SELECT hex(kdf("goofy","4F9520CAF7A8F9B1A938CF36E5", 1313, 'hkdf',128));
 */

DROP PROCEDURE IF EXISTS `DownQuark`.SaltPassword;
DELIMITER ~!~
CREATE DEFINER=`root`@`localhost` PROCEDURE `DownQuark`.SaltPassword(usr_id TINYINT(4), passwrd VARCHAR(32))
BEGIN
 DECLARE salt VARCHAR(26);
 DECLARE pw VARCHAR(32);
 DECLARE insert_at TINYINT(4);
 
 SET insert_at = usr_id;
 IF insert_at IS NULL THEN
  SELECT LAST_VALUE(id) INTO insert_at FROM `DownQuark`.accounts a WHERE 1 ORDER BY id DESC LIMIT 1;
 END IF;
  SELECT hex(RANDOM_BYTES(13)) INTO salt;
    IF passwrd IS NULL THEN -- tmp password FOR NEW users
      SET pw = hex(RANDOM_BYTES(16));
      INSERT INTO `DownQuark`.`accounts_authorization` (id,salt,hash) VALUES (insert_at,salt,pw);
    END IF;
    IF passwrd IS NOT NULL THEN -- SET USER specified password
      SELECT `salt` INTO salt
        FROM `DownQuark`.`accounts_authorization` daa
        WHERE daa.id = insert_at;
      SET pw = hex(kdf(passwrd,salt, 1313, 'hkdf',128));
      UPDATE `DownQuark`.accounts_authorization daa
        SET hash = pw WHERE daa.id = insert_at;
    END IF;
  -- SET pw = passwrd;
  -- IF passwrd IS NULL THEN SET pw = hex(RANDOM_BYTES(26)); END IF;
  -- SELECT pw;
--  RETURN hex(kdf(pw,salt, 1313, 'hkdf',128));
 -- 
END ~!~

DELIMITER ;
##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$#
##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$#
##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$#
DROP PROCEDURE IF EXISTS CreatePaths;
DELIMITER ~!~

CREATE PROCEDURE CreatePaths ( proj_id UUID )
BEGIN
  DECLARE project_iteration_done INT DEFAULT FALSE;
  DECLARE concat_path_done INT DEFAULT FALSE;

DECLARE dev_control_int INT DEFAULT 0;

DECLARE fetch_project_id UUID;
DECLARE fetch_path_part VARCHAR(50);
DECLARE fetch_proj_parent UUID;

DECLARE file_path VARCHAR(255) DEFAULT "";
DECLARE proj_name VARCHAR(50);

  DECLARE cursor_dq_projects CURSOR FOR
    SELECT DISTINCT(uuid)
    FROM `downquark`.`_dq_projects`
    WHERE
        (proj_id IS NOT NULL AND uuid = proj_id)
        OR (proj_id IS NULL AND 1);

DECLARE CONTINUE HANDLER FOR NOT FOUND SET project_iteration_done = TRUE;

IF ISNULL(proj_id) THEN -- allows TO append IF id IS passed AS argument
  DROP TABLE IF EXISTS `QrxAggregate`.`dq_devqon_project`; -- timestamp IN TABLE below can be used WHEN adding NEW projects
  CREATE TABLE `QrxAggregate`.`dq_devqon_project` (pid UUID PRIMARY KEY, pname VARCHAR(50) UNIQUE, pth VARCHAR(255));
END IF;
CREATE TABLE IF NOT EXISTS `QrxAggregate`.`dq_devqon_project`;

  OPEN cursor_dq_projects;
    loop_project_uuids: LOOP
    
    FETCH cursor_dq_projects INTO fetch_project_id;
    IF project_iteration_done THEN LEAVE loop_project_uuids; END IF;

############ INNER ##############

-- FIRST run - BEFORE iterations
  -- - store the static data & config_file name
SELECT project_id,path_os_config_file
    INTO proj_name,file_path
  FROM `downquark`.`_dq_projects` dq
  WHERE `uuid` = fetch_project_id;

-- needed for initial select statement to find a match
SET fetch_proj_parent = fetch_project_id;

repeat_concat_file_path: REPEAT

  SELECT `parent`,`path_os_config_dir`
      INTO fetch_proj_parent, fetch_path_part
    FROM `downquark`.`_dq_projects` dq
    WHERE `dq`.`uuid` = fetch_proj_parent;

  SET file_path = CONCAT_WS( "/", fetch_path_part, file_path);

UNTIL ISNULL(fetch_proj_parent)
  END REPEAT repeat_concat_file_path;

############ END INNER ##############

INSERT INTO `QrxAggregate`.`dq_devqon_project` (pid,pname,pth) VALUES (fetch_project_id,proj_name,file_path);

-- DEV+DEBUG BELOW
-- SET dev_control_int = dev_control_int + 1;
-- IF dev_control_int>=5 THEN SET project_iteration_done = TRUE; END IF;

    END LOOP loop_project_uuids;
  CLOSE cursor_dq_projects;

END; ~!~

DELIMITER ;

-- CALL CreatePaths('362b79ae-f0a4-11ee-96c2-c29d42d3cfc8');
-- CALL CreatePaths ('4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8'); -- ROOT: DOWNQUARK
CALL CreatePaths(NULL); -- run ON ALL rows

SELECT * FROM `QrxAggregate`.`dq_devqon_project`;
##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$##$#

-- https://mariadb.com/kb/en/common-table-expressions/

-- https://www.techonthenet.com/mariadb/loops/repeat.php
-----------------------

-- https://mariadb.com/kb/en/triggers-events/
--  https://mariadb.com/kb/en/create-event/
 -- https://mariadb.com/kb/en/show-tables/
--  https://mariadb.com/kb/en/default/
*/

-- https://mariadb.com/kb/en/data-types/
-- https://mariadb.com/kb/en/development-writing-plugins-for-mariadb/
-- SELECT UUID();
-- SELECT UUID_SHORT();
-- SELECT SYS_GUID();

DROP SCHEMA IF EXISTS `DevQon`;
DROP SCHEMA IF EXISTS `DownQuark`;

/*
 * Needs to be updated but this will help with how we're handling user registration:
 * 
 * CREATE DEFINER=`root`@`localhost` TRIGGER memberadded
AFTER INSERT
ON `member` FOR EACH ROW
  INSERT INTO qollection (`key.id.member`)
    VALUES (NEW.id)
 */

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

ALTER TABLE `DownQuark`.`accounts_authorization` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`id`) ON DELETE CASCADE;

ALTER TABLE `DownQuark`.`accounts_development` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`id`);

ALTER TABLE `DownQuark`.`accounts_organization` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`id`);

ALTER TABLE `DownQuark`.`accounts_personal` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`id`);

ALTER TABLE `DevQon`.`_project` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`Map_Projects` (`id`);

ALTER TABLE `DevQon`.`accounts` ADD FOREIGN KEY (`id`) REFERENCES `DownQuark`.`accounts` (`uuid`);

ALTER TABLE `DevQon`.`account_associations` ADD FOREIGN KEY (`from`) REFERENCES `DevQon`.`accounts` (`id`);

ALTER TABLE `DevQon`.`account_associations` ADD FOREIGN KEY (`to`) REFERENCES `DevQon`.`accounts` (`id`);

ALTER TABLE `DevQon`.`metrics` ADD FOREIGN KEY (`account`,`location`) REFERENCES `DevQon`.`accounts`(`id`,`ip_address`);


/*Re-integrate into procedure after outerloop complete*/
/*
##########################
-- FIRST run - BEFORE iterations - store the name OF the file
SELECT path_os_config_file INTO file_path
FROM `downquark`.`_dq_projects` dq
WHERE `uuid` = proj_id;
  
  OPEN cursor_create_file_path(proj_id);
  loop_concat_path: LOOP
-- qrk_rpt: REPEAT
  
-- CURRENT!! UPDATE TO USE REPEAT!! FROM ABOVE LINE
--   THEN USE BBELOW FOR THE NULL CHECK
--   SHOWULD BE ABLE TO USE THE SAME QUERY -- I THINK
--   `REPEAT` ALLOWS US TO MAKE NEW QUERIES EACH TIME
  -- NOWHERE NEAR AS EFFECTIVE BUT FINE FOR US FOR NOW
  /*
   SELECT `parent` INTO @nullTst
    FROM `downquark`.`_dq_projects` dq
    WHERE uuid = '4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8';
  SELECT ISNULL(@nullTst); 
   */

  FETCH cursor_create_file_path INTO proj_parent,path_part;

SET file_path = CONCAT_WS( "/", path_part , file_path);

INSERT INTO dqrx (pid) VALUES (proj_parent);
INSERT INTO dqrx (pth) VALUES (file_path);
SELECT(file_path);

  IF concat_path_done THEN LEAVE loop_concat_path; END IF;

--     SET done = TRUE;
  
  --     SELECT `uuid`, `parent`, `path_os_config_dir`, `path_os_config_file`

  -- SELECT `downquark`.`_dq_projects`.`parent` INTO @prnt
--   FROM `downquark`.`_dq_projects` `dp`
--   WHERE `dp`.`key` = 'PROJECT' LIMIT 1;
-- SET file_path = "pool";

  END LOOP loop_concat_path;
  CLOSE cursor_create_file_path;
#################################
*/