-- MariaDB dump 10.19-11.3.2-MariaDB, for osx10.19 (arm64)
--
-- Host: localhost    Database: DownQuark
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `DownQuark`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `DownQuark` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `DownQuark`;

--
-- Table structure for table `_downquark`
--

DROP TABLE IF EXISTS `_downquark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_downquark` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `uuid` uuid NOT NULL,
  `project_id` varchar(50) NOT NULL DEFAULT 'DOWNQUARK' CHECK (`project_id` = 'DOWNQUARK'),
  `version` tinytext DEFAULT '0.0.0-pre-alpha',
  `commit` tinytext NOT NULL DEFAULT 'n/a',
  `created` timestamp NULL DEFAULT current_timestamp(),
  `edited` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `_downquark__dq_projects_FK` (`uuid`,`project_id`),
  CONSTRAINT `_downquark__dq_projects_FK` FOREIGN KEY (`uuid`, `project_id`) REFERENCES `_dq_projects` (`uuid`, `project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='tbd: most updates will be version related';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_downquark`
--

LOCK TABLES `_downquark` WRITE;
/*!40000 ALTER TABLE `_downquark` DISABLE KEYS */;
INSERT INTO `_downquark` VALUES
(4,'4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','DOWNQUARK','0.0.0-pre-alpha','n/a','2024-04-02 13:02:35','2024-04-02 13:02:35');
/*!40000 ALTER TABLE `_downquark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_dq`
--

DROP TABLE IF EXISTS `_dq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_dq` (
  `key` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `enforce_key` enum('PROJECT','ACCOUNT','ROLE','DEVELOP') NOT NULL COMMENT 'This will be the enum that ``CHECK`` is run against to ensure ``type`` is valid.',
  `created` timestamp NULL DEFAULT current_timestamp(),
  `edited` timestamp NULL DEFAULT current_timestamp(),
  UNIQUE KEY `_dq_unique_key_name` (`key`,`name`) USING BTREE,
  CONSTRAINT `_dq_CHECK_enum` CHECK (field(`enforce_key`,`key`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The source of truth for anything being overseen by this database. Compound index of type and key will ensure unique values throughout all dbs/tables involved.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_dq`
--

LOCK TABLES `_dq` WRITE;
/*!40000 ALTER TABLE `_dq` DISABLE KEYS */;
INSERT INTO `_dq` VALUES
('ACCOUNT','ACCNT_DEVELOPMENT','ACCOUNT','2024-04-03 05:36:01','2024-04-03 05:36:01'),
('ACCOUNT','ACCNT_INTERNAL','ACCOUNT','2024-04-03 07:12:58','2024-04-03 07:12:58'),
('ACCOUNT','ACCNT_ORGANIZATION','ACCOUNT','2024-04-03 05:36:01','2024-04-03 05:36:01'),
('ACCOUNT','ACCNT_PERSONAL','ACCOUNT','2024-04-03 05:36:01','2024-04-03 05:36:01'),
('PROJECT','API_ARACHNID','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','AUGMENTED_SOCIAL_ORACLE','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','AURA_VIDEO_MORPHER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','BABEL_TEXT_TWISTER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','BYTE_BEHEMOTH','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','CLOUD_CHRONICLER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','COSMIC_CODE_FORGER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','CRYPTIC_CYBERSPACE_CHRONICLER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','CRYPTO_FORUM_PHOENIX','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','CRYPTO_SPECTRAL_NAVIGATOR','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','CYBER_ENCRYPTOR','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','CYBER_PLANET_CRUISER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','DELETE_INSERT_TRIGGER_TEST','PROJECT','2024-04-06 06:34:32','2024-04-06 06:34:32'),
('PROJECT','DEVELOPMENT_QONSOLE','PROJECT','2024-04-02 00:25:57','2024-04-02 00:25:57'),
('PROJECT','DEVELOPMENT_QONSOLE__QANBAN_BOARD','PROJECT','2024-04-02 00:25:58','2024-04-02 00:25:58'),
('PROJECT','DIGI_CONVERTER_3000','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','DIGI_LINGUIST','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','DOWNQUARK','PROJECT','2024-04-02 00:25:56','2024-04-02 00:25:56'),
('PROJECT','ELECTRONIC_DB_PHANTOM','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','ELECTRO_SCRAPER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','ETHER_REMOTE_TELEPORTER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','E_TEACHING_PALADIN','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','HOLO_CHAT_WIZARD','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','HYPER_NETWORK_SENTINEL','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','ILLUMINATI_CODE_ALCHEMY','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','ILLUMINATI_CODE_MAGE','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','INTERGALACTIC_EMAIL_OCTOPUS','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','LINGO_LUMINARY','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','META_DATA_DREAMER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','MIND_MACHINE','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','NANO_FLUX_ANALYZER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','NANO_MARKET_METEOR','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','NANO_TASK_SYNCOPATOR','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','NEON_PLAYER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','NEO_DOCU_GENIE','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','NEURON_SCREEN_FLICKER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','NEURO_BUG_MASTER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','PASSWORD_PANIC_MAKER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','PIXEL_VISION_MAGUS','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','PLASMA_WEATHER_WEAVER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','QUANTUM_CODE_ENCHANTER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','QUANTUM_QUBIT_QUICKSILVER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','SONIC_AUDIO_ALCHEMIST','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','SYNAPSE_SYNC_TOOL','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','SYNTHETIC_TASK_ORGANIZER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','TASK_TELEPORTER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','TIME_WARP_CALENDAR','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','TRANSCENDENT_PASSKEY_KEEPER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','VERSO_VERSION_WAND','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','VIRAL_BLOG_BOT','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','VIRTUALITY_VIEWER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','VIRTUAL_FILE_JUGGLER','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','VIRTUAL_STREAM_GENIE','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','VOICE_VISIONARY','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','WEB_VORTEX_SCORPION','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('PROJECT','ZERO_GRAVITY_DATA_DEITY','PROJECT','2024-04-05 05:52:07','2024-04-05 05:52:07'),
('ROLE','0_UNCONFIRMED','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),
('ROLE','1_CONFIRMED','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),
('ROLE','1_ORG_EMPLOYEE','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),
('ROLE','2_MOD','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),
('ROLE','2_ORG_LEADER','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),
('ROLE','3_ADMIN','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),
('ROLE','4_SUDO','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),
('ROLE','x_BANNED','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23');
/*!40000 ALTER TABLE `_dq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_dq_projects`
--

DROP TABLE IF EXISTS `_dq_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_dq_projects` (
  `uuid` uuid NOT NULL DEFAULT uuid(),
  `parent` uuid DEFAULT NULL,
  `project_id` varchar(50) NOT NULL,
  `key` varchar(10) NOT NULL DEFAULT 'PROJECT' CHECK (`key` = 'PROJECT'),
  `url_repository` varchar(100) DEFAULT NULL,
  `url_application` varchar(100) DEFAULT NULL,
  `path_os_config_dir` tinytext DEFAULT NULL,
  `path_os_config_file` tinytext DEFAULT NULL,
  `created` timestamp NULL DEFAULT current_timestamp(),
  `edited` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `_dq_projects_key_IDX` (`key`,`project_id`) USING BTREE,
  UNIQUE KEY `_dq_projects_uuid_IDX` (`uuid`,`project_id`) USING BTREE,
  KEY `_dq_projects__dq_projects_FK` (`parent`),
  CONSTRAINT `_dq_projects__dq_FK` FOREIGN KEY (`key`, `project_id`) REFERENCES `_dq` (`key`, `name`),
  CONSTRAINT `_dq_projects__dq_projects_FK` FOREIGN KEY (`parent`) REFERENCES `_dq_projects` (`uuid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='this holds the high level information of projects and their organizational hierarchy. validated against the enum in ``_dq_``';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_dq_projects`
--

LOCK TABLES `_dq_projects` WRITE;
/*!40000 ALTER TABLE `_dq_projects` DISABLE KEYS */;
INSERT INTO `_dq_projects` VALUES
('4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8',NULL,'DOWNQUARK','PROJECT','https://github.com/DownQuark-Work','https://www.downquark.work','.dq','_dq','2024-04-02 03:37:18','2024-04-02 03:37:18'),
('59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE','PROJECT','https://github.com/DownQuark-Work/downquark.applicationFoss.DevQon','https://www.downquark.work/?projects_active_foss_devqon','devqon','_devqon','2024-04-02 03:44:47','2024-04-02 03:44:47'),
('362b79ae-f0a4-11ee-96c2-c29d42d3cfc8','59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE__QANBAN_BOARD','PROJECT','https://github.com/DownQuark-Work/downquark.applicationFoss.QanbanBoard','https://www.downquark.work/?projects_active_foss_qanban','qanban','_qanban','2024-04-02 03:50:56','2024-04-02 03:50:56'),
('d5e42e42-f2fb-11ee-96c2-c29d42d3cfc8','d5e42e93-f2fb-11ee-96c2-c29d42d3cfc8','NANO_FLUX_ANALYZER','PROJECT',NULL,NULL,'CC','_C','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e56-f2fb-11ee-96c2-c29d42d3cfc8','d5e42e88-f2fb-11ee-96c2-c29d42d3cfc8','QUANTUM_CODE_ENCHANTER','PROJECT',NULL,NULL,'DD','_D','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e57-f2fb-11ee-96c2-c29d42d3cfc8','d5e430b9-f2fb-11ee-96c2-c29d42d3cfc8','SYNTHETIC_TASK_ORGANIZER','PROJECT',NULL,NULL,'EE','_E','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e60-f2fb-11ee-96c2-c29d42d3cfc8','d5e430b8-f2fb-11ee-96c2-c29d42d3cfc8','NEURO_BUG_MASTER','PROJECT',NULL,NULL,'FF','_F','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e61-f2fb-11ee-96c2-c29d42d3cfc8','d5e42e89-f2fb-11ee-96c2-c29d42d3cfc8','CYBER_ENCRYPTOR','PROJECT',NULL,NULL,'GG','_G','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e62-f2fb-11ee-96c2-c29d42d3cfc8','d5e42eb2-f2fb-11ee-96c2-c29d42d3cfc8','HOLO_CHAT_WIZARD','PROJECT',NULL,NULL,'HH','_H','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e6a-f2fb-11ee-96c2-c29d42d3cfc8','d5e42e88-f2fb-11ee-96c2-c29d42d3cfc8','VIRTUAL_FILE_JUGGLER','PROJECT',NULL,NULL,'II','_I','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e6b-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ee2-f2fb-11ee-96c2-c29d42d3cfc8','HYPER_NETWORK_SENTINEL','PROJECT',NULL,NULL,'JJ','_J','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e74-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ec4-f2fb-11ee-96c2-c29d42d3cfc8','META_DATA_DREAMER','PROJECT',NULL,NULL,'KK','_K','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e75-f2fb-11ee-96c2-c29d42d3cfc8','d5e430a4-f2fb-11ee-96c2-c29d42d3cfc8','AURA_VIDEO_MORPHER','PROJECT',NULL,NULL,'LL','_L','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e76-f2fb-11ee-96c2-c29d42d3cfc8','d5e42e7e-f2fb-11ee-96c2-c29d42d3cfc8','SONIC_AUDIO_ALCHEMIST','PROJECT',NULL,NULL,'MM','_M','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e7e-f2fb-11ee-96c2-c29d42d3cfc8','59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','PIXEL_VISION_MAGUS','PROJECT',NULL,NULL,'NN','_N','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e7f-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ec5-f2fb-11ee-96c2-c29d42d3cfc8','TRANSCENDENT_PASSKEY_KEEPER','PROJECT',NULL,NULL,'OO','_O','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e80-f2fb-11ee-96c2-c29d42d3cfc8','d5e42eba-f2fb-11ee-96c2-c29d42d3cfc8','INTERGALACTIC_EMAIL_OCTOPUS','PROJECT',NULL,NULL,'PP','_P','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e88-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ec6-f2fb-11ee-96c2-c29d42d3cfc8','TIME_WARP_CALENDAR','PROJECT',NULL,NULL,'QQ','_Q','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e89-f2fb-11ee-96c2-c29d42d3cfc8','362b79ae-f0a4-11ee-96c2-c29d42d3cfc8','PLASMA_WEATHER_WEAVER','PROJECT',NULL,NULL,'RR','_R','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e8a-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ece-f2fb-11ee-96c2-c29d42d3cfc8','CRYPTO_SPECTRAL_NAVIGATOR','PROJECT',NULL,NULL,'SS','_S','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e92-f2fb-11ee-96c2-c29d42d3cfc8','4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','DIGI_LINGUIST','PROJECT',NULL,NULL,'TT','_T','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e93-f2fb-11ee-96c2-c29d42d3cfc8','d5e430c3-f2fb-11ee-96c2-c29d42d3cfc8','ILLUMINATI_CODE_MAGE','PROJECT',NULL,NULL,'UU','_U','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e94-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ee2-f2fb-11ee-96c2-c29d42d3cfc8','NEO_DOCU_GENIE','PROJECT',NULL,NULL,'VV','_V','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e9c-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ece-f2fb-11ee-96c2-c29d42d3cfc8','COSMIC_CODE_FORGER','PROJECT',NULL,NULL,'WW','_W','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e9d-f2fb-11ee-96c2-c29d42d3cfc8','4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','ETHER_REMOTE_TELEPORTER','PROJECT',NULL,NULL,'XX','_X','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42e9e-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ec6-f2fb-11ee-96c2-c29d42d3cfc8','VIRTUALITY_VIEWER','PROJECT',NULL,NULL,'YY','_Y','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ea6-f2fb-11ee-96c2-c29d42d3cfc8','d5e4309a-f2fb-11ee-96c2-c29d42d3cfc8','NEURON_SCREEN_FLICKER','PROJECT',NULL,NULL,'ZZ','_Z','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ea7-f2fb-11ee-96c2-c29d42d3cfc8','d5e430ae-f2fb-11ee-96c2-c29d42d3cfc8','ELECTRONIC_DB_PHANTOM','PROJECT',NULL,NULL,'ZZ','_Z','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ea8-f2fb-11ee-96c2-c29d42d3cfc8','d5e430ba-f2fb-11ee-96c2-c29d42d3cfc8','VERSO_VERSION_WAND','PROJECT',NULL,NULL,'aAaA','_aA','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42eb0-f2fb-11ee-96c2-c29d42d3cfc8','d5e430c2-f2fb-11ee-96c2-c29d42d3cfc8','SYNAPSE_SYNC_TOOL','PROJECT',NULL,NULL,'aBaB','_aB','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42eb1-f2fb-11ee-96c2-c29d42d3cfc8','d5e430a4-f2fb-11ee-96c2-c29d42d3cfc8','NANO_TASK_SYNCOPATOR','PROJECT',NULL,NULL,'bCbC','_bC','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42eb2-f2fb-11ee-96c2-c29d42d3cfc8','d5e4309a-f2fb-11ee-96c2-c29d42d3cfc8','CYBER_PLANET_CRUISER','PROJECT',NULL,NULL,'cDcD','_cD','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42eba-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ec4-f2fb-11ee-96c2-c29d42d3cfc8','ZERO_GRAVITY_DATA_DEITY','PROJECT',NULL,NULL,'dEdE','_dE','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ebb-f2fb-11ee-96c2-c29d42d3cfc8','d5e430ae-f2fb-11ee-96c2-c29d42d3cfc8','AUGMENTED_SOCIAL_ORACLE','PROJECT',NULL,NULL,'eFeF','_eF','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ebc-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ee2-f2fb-11ee-96c2-c29d42d3cfc8','MIND_MACHINE','PROJECT',NULL,NULL,'fGfG','_fG','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ec4-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ed8-f2fb-11ee-96c2-c29d42d3cfc8','WEB_VORTEX_SCORPION','PROJECT',NULL,NULL,'gHgH','_gH','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ec5-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ed0-f2fb-11ee-96c2-c29d42d3cfc8','ELECTRO_SCRAPER','PROJECT',NULL,NULL,'hIhI','_hI','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ec6-f2fb-11ee-96c2-c29d42d3cfc8','d5e430a4-f2fb-11ee-96c2-c29d42d3cfc8','DIGI_CONVERTER_3000','PROJECT',NULL,NULL,'iJiJ','_iJ','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ece-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ed0-f2fb-11ee-96c2-c29d42d3cfc8','VOICE_VISIONARY','PROJECT',NULL,NULL,'jKjK','_jK','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ecf-f2fb-11ee-96c2-c29d42d3cfc8','59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','BYTE_BEHEMOTH','PROJECT',NULL,NULL,'kLkL','_kL','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ed0-f2fb-11ee-96c2-c29d42d3cfc8','d5e42ed9-f2fb-11ee-96c2-c29d42d3cfc8','BABEL_TEXT_TWISTER','PROJECT',NULL,NULL,'lMlM','_lM','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ed8-f2fb-11ee-96c2-c29d42d3cfc8','d5e430c4-f2fb-11ee-96c2-c29d42d3cfc8','VIRAL_BLOG_BOT','PROJECT',NULL,NULL,'mNmN','_mN','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ed9-f2fb-11ee-96c2-c29d42d3cfc8','d5e430b9-f2fb-11ee-96c2-c29d42d3cfc8','CRYPTO_FORUM_PHOENIX','PROJECT',NULL,NULL,'nOnO','_nO','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e42ee2-f2fb-11ee-96c2-c29d42d3cfc8','d5e430ae-f2fb-11ee-96c2-c29d42d3cfc8','NANO_MARKET_METEOR','PROJECT',NULL,NULL,'oPoP','_oP','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e4309a-f2fb-11ee-96c2-c29d42d3cfc8','d5e430b8-f2fb-11ee-96c2-c29d42d3cfc8','E_TEACHING_PALADIN','PROJECT',NULL,NULL,'pQpQ','_pQ','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430a4-f2fb-11ee-96c2-c29d42d3cfc8','d5e430b9-f2fb-11ee-96c2-c29d42d3cfc8','VIRTUAL_STREAM_GENIE','PROJECT',NULL,NULL,'qRqR','_qR','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430ae-f2fb-11ee-96c2-c29d42d3cfc8','4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','ILLUMINATI_CODE_ALCHEMY','PROJECT',NULL,NULL,'rSrS','_rS','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430af-f2fb-11ee-96c2-c29d42d3cfc8','d5e430c2-f2fb-11ee-96c2-c29d42d3cfc8','PASSWORD_PANIC_MAKER','PROJECT',NULL,NULL,'sTsT','_sT','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430b0-f2fb-11ee-96c2-c29d42d3cfc8','d5e430ba-f2fb-11ee-96c2-c29d42d3cfc8','NEON_PLAYER','PROJECT',NULL,NULL,'tUtU','_tU','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430b8-f2fb-11ee-96c2-c29d42d3cfc8','4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','LINGO_LUMINARY','PROJECT',NULL,NULL,'uVuV','_uV','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430b9-f2fb-11ee-96c2-c29d42d3cfc8','d5e430c2-f2fb-11ee-96c2-c29d42d3cfc8','CLOUD_CHRONICLER','PROJECT',NULL,NULL,'vWvW','_vW','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430ba-f2fb-11ee-96c2-c29d42d3cfc8','4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','TASK_TELEPORTER','PROJECT',NULL,NULL,'wXwX','_wX','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430c2-f2fb-11ee-96c2-c29d42d3cfc8','4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','CRYPTIC_CYBERSPACE_CHRONICLER','PROJECT',NULL,NULL,'xYxY','_xY','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430c3-f2fb-11ee-96c2-c29d42d3cfc8','4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','QUANTUM_QUBIT_QUICKSILVER','PROJECT',NULL,NULL,'yZyZ','_yZ','2024-04-05 05:57:43','2024-04-05 05:57:43'),
('d5e430c4-f2fb-11ee-96c2-c29d42d3cfc8','362b79ae-f0a4-11ee-96c2-c29d42d3cfc8','API_ARACHNID','PROJECT',NULL,NULL,'zZzZ','_zZ','2024-04-05 05:57:43','2024-04-05 05:57:43');
/*!40000 ALTER TABLE `_dq_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'used only inside the DownQuark database',
  `uuid` uuid NOT NULL DEFAULT uuid() COMMENT 'this will be the lookup reference in subsequent projects',
  `type` varchar(25) NOT NULL DEFAULT 'ACCNT_PERSONAL' CHECK (`enforce_account_type` = 'ACCOUNT'),
  `role` varchar(25) NOT NULL DEFAULT '0_UNCONFIRMED' CHECK (`enforce_account_role` = 'ROLE'),
  `enforce_account_role` varchar(10) NOT NULL DEFAULT 'ROLE',
  `enforce_account_type` varchar(10) NOT NULL DEFAULT 'ACCOUNT',
  `created` timestamp NULL DEFAULT current_timestamp(),
  `edited` timestamp NULL DEFAULT current_timestamp(),
  `set_password` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_uuid_IDX` (`uuid`) USING BTREE,
  KEY `enforce_accounts_role` (`role`,`enforce_account_role`) USING BTREE,
  KEY `enforce_accounts_type` (`type`,`enforce_account_type`) USING BTREE,
  KEY `accounts__dq_FK` (`enforce_account_role`,`role`),
  KEY `accounts__dq_FK_1` (`enforce_account_type`,`type`),
  CONSTRAINT `accounts__dq_FK_1` FOREIGN KEY (`enforce_account_type`, `type`) REFERENCES `_dq` (`key`, `name`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='\nall users across all projects will have a mapping on this database table.\nsubsequent projects and tables will store the relevant info required for their integrations\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES
(1,'63a03700-f18d-11ee-96c2-c29d42d3cfc8','ACCNT_INTERNAL','4_SUDO','ROLE','ACCOUNT','2024-04-03 07:40:05','2024-04-03 07:40:05','2024-04-08 02:03:40'),
(3,'e9b17692-f18d-11ee-96c2-c29d42d3cfc8','ACCNT_PERSONAL','0_UNCONFIRMED','ROLE','ACCOUNT','2024-04-03 07:43:50','2024-04-03 07:43:50','2024-04-08 02:03:40'),
(4,'0cf18318-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_PERSONAL','1_CONFIRMED','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50','2024-04-08 02:03:40'),
(5,'0cf1b158-f18e-11ee-96c2-c29d42d3cfc7','ACCNT_ORGANIZATION','2_ORG_LEADER','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50','2024-04-08 02:03:40'),
(6,'0cf1c8d2-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_DEVELOPMENT','x_BANNED','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50','2024-04-08 02:03:40'),
(7,'0cf23fd8-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_PERSONAL','2_MOD','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50','2024-04-08 02:03:40'),
(8,'0cf1b158-f18e-11ee-96c2-c29d42d3cfc6','ACCNT_ORGANIZATION','1_ORG_EMPLOYEE','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50','2024-04-08 02:03:40'),
(9,'0cf1b158-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_ORGANIZATION','1_ORG_EMPLOYEE','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50','2024-04-08 02:03:40'),
(10,'3cf23fd8-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_INTERNAL','3_ADMIN','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50','2024-04-08 02:03:40'),
(11,'df4b1258-f197-11ee-96c2-c29d42d3cfc8','ACCNT_PERSONAL','0_UNCONFIRMED','ROLE','ACCOUNT','2024-04-03 08:55:08','2024-04-03 08:55:08','2024-04-08 02:03:40'),
(21,'f07ddc36-f566-11ee-a619-c29d42d3cfc8','ACCNT_PERSONAL','2_ORG_LEADER','ROLE','ACCOUNT','2024-04-08 05:14:56','2024-04-08 05:14:56','2024-04-08 23:57:01'),
(22,'af9287ee-f56b-11ee-a619-c29d42d3cfc8','ACCNT_PERSONAL','0_UNCONFIRMED','ROLE','ACCOUNT','2024-04-08 05:48:55','2024-04-08 05:48:55','2024-04-08 03:03:10'),
(23,'f1bb5e20-f575-11ee-a619-c29d42d3cfc8','ACCNT_PERSONAL','0_UNCONFIRMED','ROLE','ACCOUNT','2024-04-08 07:02:21','2024-04-08 07:02:21','2024-04-08 23:26:34'),
(27,'55f105ea-f623-11ee-a619-c29d42d3cfc8','ACCNT_PERSONAL','1_ORG_EMPLOYEE','ROLE','ACCOUNT','2024-04-09 03:43:32','2024-04-09 03:43:32','2024-04-08 23:57:01'),
(32,'0af170f0-f625-11ee-a619-c29d42d3cfc8','ACCNT_PERSONAL','0_UNCONFIRMED','ROLE','ACCOUNT','2024-04-09 03:55:45','2024-04-09 03:55:45','2024-04-08 23:57:18'),
(33,'2655f230-f625-11ee-a619-c29d42d3cfc8','ACCNT_PERSONAL','0_UNCONFIRMED','ROLE','ACCOUNT','2024-04-09 03:56:31','2024-04-09 03:56:31','2024-04-08 23:57:18');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AutoAuth
AFTER INSERT
ON accounts FOR EACH ROW
CALL `DownQuark`.SaltPassword(NEW.id,NULL) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AggregateAccount
AFTER INSERT
ON accounts FOR EACH ROW
SET @hmm = "not sure where the implicit commit is -  run aggregation manually for now" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DownQuark`.PassToHash
BEFORE UPDATE 
ON accounts FOR EACH ROW

CALL `DownQuark`.SaltPassword(NEW.id,NEW.set_password) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DownQuark`.PassToTime
BEFORE UPDATE
ON accounts FOR EACH ROW

SET NEW.set_password = CURRENT_TIMESTAMP() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `accounts_authorization`
--

DROP TABLE IF EXISTS `accounts_authorization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_authorization` (
  `id` tinyint(4) NOT NULL DEFAULT 0,
  `salt` varchar(26) DEFAULT NULL,
  `hash` varchar(320) DEFAULT NULL COMMENT 'hex((kdf(''_password_'',''@salt_val'', 1313, ''hkdf'',136)))',
  PRIMARY KEY (`id`),
  CONSTRAINT `accounts_authorization_accounts_FK` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Do not access this table directly. create a user and subsequently ``set_password`` from the same level ``accounts`` table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_authorization`
--

LOCK TABLES `accounts_authorization` WRITE;
/*!40000 ALTER TABLE `accounts_authorization` DISABLE KEYS */;
INSERT INTO `accounts_authorization` VALUES
(21,'4F9520CAF7A8F9B1A938CF36E5','8D9DA977783AD0EED49C7283D9A3FA16'),
(22,'B8E3797AC1113561535E7BED4E','79868460957EF805A8CF2DAA15ABD4E1'),
(23,'5F44617E66B5319CDAEF3A1CC4','0CA14525B335C9F66B17753382CB6629'),
(27,'E2E968C5FBA46671923435BBF8','9807D4E931C62EFE346D360533A3C304'),
(32,'93CD369293232D0883AC771465','41993D29085F4168F16DFA9C04BABE4F'),
(33,'19E14E12BF028C3B8F85A7FDFB','3C66630DBE594D88A55D0E492999C9AE');
/*!40000 ALTER TABLE `accounts_authorization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_development`
--

DROP TABLE IF EXISTS `accounts_development`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_development` (
  `id` tinyint(4) NOT NULL,
  `api_key` tinytext NOT NULL,
  `expires` datetime DEFAULT NULL COMMENT '90 days?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_key` (`api_key`) USING HASH,
  CONSTRAINT `accounts_development_accounts_FK` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_development`
--

LOCK TABLES `accounts_development` WRITE;
/*!40000 ALTER TABLE `accounts_development` DISABLE KEYS */;
INSERT INTO `accounts_development` VALUES
(1,'c29d42d3cfc8d84d71a8','2024-05-09 21:44:08');
/*!40000 ALTER TABLE `accounts_development` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_metrics`
--

DROP TABLE IF EXISTS `accounts_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_metrics` (
  `id` tinyint(4) NOT NULL,
  `last_login` timestamp NULL DEFAULT current_timestamp(),
  `ip_address` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `accounts_metrics_accounts_FK` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='INET_ATON(''11.11.11.111'')';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_metrics`
--

LOCK TABLES `accounts_metrics` WRITE;
/*!40000 ALTER TABLE `accounts_metrics` DISABLE KEYS */;
INSERT INTO `accounts_metrics` VALUES
(1,'2024-04-08 23:53:30','1276647013');
/*!40000 ALTER TABLE `accounts_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_organization`
--

DROP TABLE IF EXISTS `accounts_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_organization` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(30) DEFAULT NULL COMMENT 'the name of the organization',
  `address` varchar(200) DEFAULT NULL,
  `state` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_organization_state_IDX` (`state`) USING BTREE,
  CONSTRAINT `accounts_organization_Location_FK` FOREIGN KEY (`state`) REFERENCES `QrxJoin`.`Location` (`reference`),
  CONSTRAINT `accounts_organization_accounts_FK` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_organization`
--

LOCK TABLES `accounts_organization` WRITE;
/*!40000 ALTER TABLE `accounts_organization` DISABLE KEYS */;
INSERT INTO `accounts_organization` VALUES
(1,'DownQuark','downquark.work','MA');
/*!40000 ALTER TABLE `accounts_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_personal`
--

DROP TABLE IF EXISTS `accounts_personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_personal` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `last_login` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  CONSTRAINT `accounts_personal_accounts_FK` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_personal`
--

LOCK TABLES `accounts_personal` WRITE;
/*!40000 ALTER TABLE `accounts_personal` DISABLE KEYS */;
INSERT INTO `accounts_personal` VALUES
(1,'downquark','dq','dq@downquark.work','2024-04-08 19:47:15');
/*!40000 ALTER TABLE `accounts_personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'DownQuark'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AggregateProjectFilePaths` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AggregateProjectFilePaths`( proj_id UUID )
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
  DROP TABLE IF EXISTS `QrxAggregate`.`dq_devqon_project`;
END IF;
CREATE TABLE IF NOT EXISTS `QrxAggregate`.`dq_devqon_project` (
  `pid` uuid NOT NULL,
  `pname` varchar(50) DEFAULT NULL,
  `pth` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `pname` (`pname`),
  CONSTRAINT `dq_devqon_project__dq_projects_FK` FOREIGN KEY (`pid`) REFERENCES `DownQuark`.`_dq_projects` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AggregateUserLookup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AggregateUserLookup`( usr_id TINYINT(4) )
BEGIN
  DECLARE user_iteration_done INT DEFAULT FALSE;
  DECLARE fetch_lookup_id TINYINT(4);
  DECLARE fetch_lookup_user_id_encrypt VARCHAR(15);
  DECLARE fetch_user_id UUID;
--  DECLARE fetch_user_id_encrypt VARCHAR(15);
  DECLARE fetch_user_role VARCHAR(25);

  DECLARE cursor_user_ids CURSOR FOR
    SELECT `id`,`uuid`,`role`
    FROM `DownQuark`.accounts
    WHERE
        (usr_id IS NOT NULL AND id = usr_id)
        OR (usr_id IS NULL AND 1);
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET user_iteration_done = TRUE;

IF ISNULL(usr_id) THEN -- allows TO append IF id IS passed AS argument
  DROP TABLE IF EXISTS `QrxAggregate`.`dq_lookup_users`;
END IF;
CREATE TABLE IF NOT EXISTS QrxAggregate.`dq_lookup_users` (
  `usr` varchar(15) NOT NULL COMMENT 'lookup key',
  `usr_id` uuid NOT NULL,
  `role` varchar(25) NOT NULL,
  PRIMARY KEY (`usr_id`),
  UNIQUE KEY `dq_lookup_users_unique` (`usr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
    COMMENT='TODO: create queries to populate this with relevant user information from all applicable `accounts_*` tables.';

    OPEN cursor_user_ids;
    loop_user_uuids: LOOP
    
    FETCH cursor_user_ids INTO fetch_lookup_id, fetch_user_id, fetch_user_role;
    IF user_iteration_done THEN LEAVE loop_user_uuids; END IF;
    
    SET fetch_lookup_user_id_encrypt = HEX(TO_BASE64(fetch_lookup_id));
    INSERT INTO `QrxAggregate`.`dq_lookup_users` (usr,usr_id,role) VALUES (fetch_lookup_user_id_encrypt,fetch_user_id,fetch_user_role);

-- DEV+DEBUG BELOW
-- SET dev_control_int = dev_control_int + 1;
-- IF dev_control_int>=5 THEN SET project_iteration_done = TRUE; END IF;

    END LOOP loop_user_uuids;
  CLOSE cursor_user_ids;
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SaltPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaltPassword`(usr_id TINYINT(4), passwrd VARCHAR(32))
BEGIN
 DECLARE salt_var VARCHAR(26);
 DECLARE pw VARCHAR(32);
 DECLARE insert_at TINYINT(4);
 
 SET insert_at = usr_id;
 IF insert_at IS NULL THEN
  SELECT LAST_VALUE(id) INTO insert_at FROM `DownQuark`.accounts a WHERE 1 ORDER BY id DESC LIMIT 1;
 END IF;
    IF passwrd IS NULL THEN -- tmp password FOR NEW users
      SELECT hex(RANDOM_BYTES(13)) INTO salt_var;
      SET pw = hex(RANDOM_BYTES(16));
      INSERT INTO `DownQuark`.`accounts_authorization` (id,salt,hash) VALUES (insert_at,salt_var,pw);
    END IF;
    IF passwrd IS NOT NULL THEN -- SET USER specified password
      SELECT `salt` INTO salt_var
        FROM `DownQuark`.`accounts_authorization` daa
        WHERE daa.id = insert_at;
      SET pw = hex(kdf(passwrd,salt_var, 1313, 'hkdf',128));
      UPDATE `DownQuark`.accounts_authorization daa
        SET hash = pw -- CONCAT(usr_id,"--",passwrd,salt_var) -- DEBUG
        WHERE daa.id = insert_at;
    END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `DevQon`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `DevQon` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `DevQon`;

--
-- Table structure for table `_project`
--

DROP TABLE IF EXISTS `_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_project` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `uuid` uuid NOT NULL,
  `project_id` varchar(50) NOT NULL DEFAULT 'DEVELOPMENT_QONSOLE' CHECK (`project_id` = 'DEVELOPMENT_QONSOLE'),
  `version` tinytext DEFAULT '0.0.0-pre-alpha',
  `commit` tinytext NOT NULL DEFAULT 'n/a',
  `created` timestamp NULL DEFAULT current_timestamp(),
  `edited` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `_project__dq_projects_FK` (`uuid`,`project_id`),
  CONSTRAINT `_project__dq_projects_FK` FOREIGN KEY (`uuid`, `project_id`) REFERENCES `DownQuark`.`_dq_projects` (`uuid`, `project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='tbd: most updates will be version related';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_project`
--

LOCK TABLES `_project` WRITE;
/*!40000 ALTER TABLE `_project` DISABLE KEYS */;
INSERT INTO `_project` VALUES
(1,'59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE','dq0.0.2-pre-release','e82c7c1367619c140662889313013b450cf9133c','2024-04-02 04:24:45','2024-04-02 04:53:05'),
(3,'59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE','dq0.2.0-pre-release','5282eff8121509048643e8bbdb870f86b98a314d','2024-04-02 04:24:45','2024-04-02 04:53:09');
/*!40000 ALTER TABLE `_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_associations`
--

DROP TABLE IF EXISTS `account_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_associations` (
  `from` uuid NOT NULL,
  `to` uuid NOT NULL,
  `updated` timestamp NULL DEFAULT current_timestamp(),
  KEY `from` (`from`),
  KEY `to` (`to`),
  CONSTRAINT `account_associations_accounts_FK` FOREIGN KEY (`from`) REFERENCES `DownQuark`.`accounts` (`uuid`),
  CONSTRAINT `account_associations_accounts_FK_1` FOREIGN KEY (`to`) REFERENCES `DownQuark`.`accounts` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='\nsocial aspects - tbd\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_associations`
--

LOCK TABLES `account_associations` WRITE;
/*!40000 ALTER TABLE `account_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` tinyint(4) NOT NULL,
  `uuid` uuid NOT NULL,
  `ip_address` inet4 DEFAULT NULL,
  `last_active` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `accounts_uuid_IDX` (`uuid`) USING BTREE,
  CONSTRAINT `accounts_accounts_FK` FOREIGN KEY (`uuid`) REFERENCES `DownQuark`.`accounts` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='this table will be expanded as we continue';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics`
--

DROP TABLE IF EXISTS `metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics` (
  `account` uuid NOT NULL DEFAULT uuid(),
  `location` inet4 NOT NULL,
  `entry` timestamp NULL DEFAULT current_timestamp(),
  KEY `metrics_accounts_FK` (`account`),
  CONSTRAINT `metrics_accounts_FK` FOREIGN KEY (`account`) REFERENCES `DownQuark`.`accounts` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='tbd';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics`
--

LOCK TABLES `metrics` WRITE;
/*!40000 ALTER TABLE `metrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'DevQon'
--

--
-- Current Database: `QrxAggregate`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `QrxAggregate` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `QrxAggregate`;

--
-- Table structure for table `dq_devqon_project`
--

DROP TABLE IF EXISTS `dq_devqon_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_devqon_project` (
  `pid` uuid NOT NULL,
  `pname` varchar(50) DEFAULT NULL,
  `pth` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `pname` (`pname`),
  CONSTRAINT `dq_devqon_project__dq_projects_FK` FOREIGN KEY (`pid`) REFERENCES `DownQuark`.`_dq_projects` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dq_devqon_project`
--

LOCK TABLES `dq_devqon_project` WRITE;
/*!40000 ALTER TABLE `dq_devqon_project` DISABLE KEYS */;
INSERT INTO `dq_devqon_project` VALUES
('4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','DOWNQUARK','.dq/_dq'),
('59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE','.dq/devqon/_devqon'),
('362b79ae-f0a4-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE__QANBAN_BOARD','.dq/devqon/qanban/_qanban'),
('d5e42e42-f2fb-11ee-96c2-c29d42d3cfc8','NANO_FLUX_ANALYZER','.dq/yZyZ/UU/CC/_C'),
('d5e42e56-f2fb-11ee-96c2-c29d42d3cfc8','QUANTUM_CODE_ENCHANTER','.dq/xYxY/vWvW/qRqR/iJiJ/QQ/DD/_D'),
('d5e42e57-f2fb-11ee-96c2-c29d42d3cfc8','SYNTHETIC_TASK_ORGANIZER','.dq/xYxY/vWvW/EE/_E'),
('d5e42e60-f2fb-11ee-96c2-c29d42d3cfc8','NEURO_BUG_MASTER','.dq/uVuV/FF/_F'),
('d5e42e61-f2fb-11ee-96c2-c29d42d3cfc8','CYBER_ENCRYPTOR','.dq/devqon/qanban/RR/GG/_G'),
('d5e42e62-f2fb-11ee-96c2-c29d42d3cfc8','HOLO_CHAT_WIZARD','.dq/uVuV/pQpQ/cDcD/HH/_H'),
('d5e42e6a-f2fb-11ee-96c2-c29d42d3cfc8','VIRTUAL_FILE_JUGGLER','.dq/xYxY/vWvW/qRqR/iJiJ/QQ/II/_I'),
('d5e42e6b-f2fb-11ee-96c2-c29d42d3cfc8','HYPER_NETWORK_SENTINEL','.dq/rSrS/oPoP/JJ/_J'),
('d5e42e74-f2fb-11ee-96c2-c29d42d3cfc8','META_DATA_DREAMER','.dq/devqon/qanban/zZzZ/mNmN/gHgH/KK/_K'),
('d5e42e75-f2fb-11ee-96c2-c29d42d3cfc8','AURA_VIDEO_MORPHER','.dq/xYxY/vWvW/qRqR/LL/_L'),
('d5e42e76-f2fb-11ee-96c2-c29d42d3cfc8','SONIC_AUDIO_ALCHEMIST','.dq/devqon/NN/MM/_M'),
('d5e42e7e-f2fb-11ee-96c2-c29d42d3cfc8','PIXEL_VISION_MAGUS','.dq/devqon/NN/_N'),
('d5e42e7f-f2fb-11ee-96c2-c29d42d3cfc8','TRANSCENDENT_PASSKEY_KEEPER','.dq/xYxY/vWvW/nOnO/lMlM/hIhI/OO/_O'),
('d5e42e80-f2fb-11ee-96c2-c29d42d3cfc8','INTERGALACTIC_EMAIL_OCTOPUS','.dq/devqon/qanban/zZzZ/mNmN/gHgH/dEdE/PP/_P'),
('d5e42e88-f2fb-11ee-96c2-c29d42d3cfc8','TIME_WARP_CALENDAR','.dq/xYxY/vWvW/qRqR/iJiJ/QQ/_Q'),
('d5e42e89-f2fb-11ee-96c2-c29d42d3cfc8','PLASMA_WEATHER_WEAVER','.dq/devqon/qanban/RR/_R'),
('d5e42e8a-f2fb-11ee-96c2-c29d42d3cfc8','CRYPTO_SPECTRAL_NAVIGATOR','.dq/xYxY/vWvW/nOnO/lMlM/jKjK/SS/_S'),
('d5e42e92-f2fb-11ee-96c2-c29d42d3cfc8','DIGI_LINGUIST','.dq/TT/_T'),
('d5e42e93-f2fb-11ee-96c2-c29d42d3cfc8','ILLUMINATI_CODE_MAGE','.dq/yZyZ/UU/_U'),
('d5e42e94-f2fb-11ee-96c2-c29d42d3cfc8','NEO_DOCU_GENIE','.dq/rSrS/oPoP/VV/_V'),
('d5e42e9c-f2fb-11ee-96c2-c29d42d3cfc8','COSMIC_CODE_FORGER','.dq/xYxY/vWvW/nOnO/lMlM/jKjK/WW/_W'),
('d5e42e9d-f2fb-11ee-96c2-c29d42d3cfc8','ETHER_REMOTE_TELEPORTER','.dq/XX/_X'),
('d5e42e9e-f2fb-11ee-96c2-c29d42d3cfc8','VIRTUALITY_VIEWER','.dq/xYxY/vWvW/qRqR/iJiJ/YY/_Y'),
('d5e42ea6-f2fb-11ee-96c2-c29d42d3cfc8','NEURON_SCREEN_FLICKER','.dq/uVuV/pQpQ/ZZ/_Z'),
('d5e42ea7-f2fb-11ee-96c2-c29d42d3cfc8','ELECTRONIC_DB_PHANTOM','.dq/rSrS/ZZ/_Z'),
('d5e42ea8-f2fb-11ee-96c2-c29d42d3cfc8','VERSO_VERSION_WAND','.dq/wXwX/aAaA/_aA'),
('d5e42eb0-f2fb-11ee-96c2-c29d42d3cfc8','SYNAPSE_SYNC_TOOL','.dq/xYxY/aBaB/_aB'),
('d5e42eb1-f2fb-11ee-96c2-c29d42d3cfc8','NANO_TASK_SYNCOPATOR','.dq/xYxY/vWvW/qRqR/bCbC/_bC'),
('d5e42eb2-f2fb-11ee-96c2-c29d42d3cfc8','CYBER_PLANET_CRUISER','.dq/uVuV/pQpQ/cDcD/_cD'),
('d5e42eba-f2fb-11ee-96c2-c29d42d3cfc8','ZERO_GRAVITY_DATA_DEITY','.dq/devqon/qanban/zZzZ/mNmN/gHgH/dEdE/_dE'),
('d5e42ebb-f2fb-11ee-96c2-c29d42d3cfc8','AUGMENTED_SOCIAL_ORACLE','.dq/rSrS/eFeF/_eF'),
('d5e42ebc-f2fb-11ee-96c2-c29d42d3cfc8','MIND_MACHINE','.dq/rSrS/oPoP/fGfG/_fG'),
('d5e42ec4-f2fb-11ee-96c2-c29d42d3cfc8','WEB_VORTEX_SCORPION','.dq/devqon/qanban/zZzZ/mNmN/gHgH/_gH'),
('d5e42ec5-f2fb-11ee-96c2-c29d42d3cfc8','ELECTRO_SCRAPER','.dq/xYxY/vWvW/nOnO/lMlM/hIhI/_hI'),
('d5e42ec6-f2fb-11ee-96c2-c29d42d3cfc8','DIGI_CONVERTER_3000','.dq/xYxY/vWvW/qRqR/iJiJ/_iJ'),
('d5e42ece-f2fb-11ee-96c2-c29d42d3cfc8','VOICE_VISIONARY','.dq/xYxY/vWvW/nOnO/lMlM/jKjK/_jK'),
('d5e42ecf-f2fb-11ee-96c2-c29d42d3cfc8','BYTE_BEHEMOTH','.dq/devqon/kLkL/_kL'),
('d5e42ed0-f2fb-11ee-96c2-c29d42d3cfc8','BABEL_TEXT_TWISTER','.dq/xYxY/vWvW/nOnO/lMlM/_lM'),
('d5e42ed8-f2fb-11ee-96c2-c29d42d3cfc8','VIRAL_BLOG_BOT','.dq/devqon/qanban/zZzZ/mNmN/_mN'),
('d5e42ed9-f2fb-11ee-96c2-c29d42d3cfc8','CRYPTO_FORUM_PHOENIX','.dq/xYxY/vWvW/nOnO/_nO'),
('d5e42ee2-f2fb-11ee-96c2-c29d42d3cfc8','NANO_MARKET_METEOR','.dq/rSrS/oPoP/_oP'),
('d5e4309a-f2fb-11ee-96c2-c29d42d3cfc8','E_TEACHING_PALADIN','.dq/uVuV/pQpQ/_pQ'),
('d5e430a4-f2fb-11ee-96c2-c29d42d3cfc8','VIRTUAL_STREAM_GENIE','.dq/xYxY/vWvW/qRqR/_qR'),
('d5e430ae-f2fb-11ee-96c2-c29d42d3cfc8','ILLUMINATI_CODE_ALCHEMY','.dq/rSrS/_rS'),
('d5e430af-f2fb-11ee-96c2-c29d42d3cfc8','PASSWORD_PANIC_MAKER','.dq/xYxY/sTsT/_sT'),
('d5e430b0-f2fb-11ee-96c2-c29d42d3cfc8','NEON_PLAYER','.dq/wXwX/tUtU/_tU'),
('d5e430b8-f2fb-11ee-96c2-c29d42d3cfc8','LINGO_LUMINARY','.dq/uVuV/_uV'),
('d5e430b9-f2fb-11ee-96c2-c29d42d3cfc8','CLOUD_CHRONICLER','.dq/xYxY/vWvW/_vW'),
('d5e430ba-f2fb-11ee-96c2-c29d42d3cfc8','TASK_TELEPORTER','.dq/wXwX/_wX'),
('d5e430c2-f2fb-11ee-96c2-c29d42d3cfc8','CRYPTIC_CYBERSPACE_CHRONICLER','.dq/xYxY/_xY'),
('d5e430c3-f2fb-11ee-96c2-c29d42d3cfc8','QUANTUM_QUBIT_QUICKSILVER','.dq/yZyZ/_yZ'),
('d5e430c4-f2fb-11ee-96c2-c29d42d3cfc8','API_ARACHNID','.dq/devqon/qanban/zZzZ/_zZ');
/*!40000 ALTER TABLE `dq_devqon_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dq_lookup_users`
--

DROP TABLE IF EXISTS `dq_lookup_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dq_lookup_users` (
  `usr` varchar(15) NOT NULL COMMENT 'lookup key',
  `usr_id` uuid NOT NULL,
  `role` varchar(25) NOT NULL,
  PRIMARY KEY (`usr_id`),
  UNIQUE KEY `dq_lookup_users_unique` (`usr`),
  CONSTRAINT `dq_lookup_users_accounts_FK` FOREIGN KEY (`usr_id`) REFERENCES `DownQuark`.`accounts` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='TODO: create queries to populate this with relevant user information from all applicable `accounts_*` tables.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dq_lookup_users`
--

LOCK TABLES `dq_lookup_users` WRITE;
/*!40000 ALTER TABLE `dq_lookup_users` DISABLE KEYS */;
INSERT INTO `dq_lookup_users` VALUES
('4F413D3D','0cf1b158-f18e-11ee-96c2-c29d42d3cfc6','1_ORG_EMPLOYEE'),
('4E513D3D','0cf1b158-f18e-11ee-96c2-c29d42d3cfc7','2_ORG_LEADER'),
('4D513D3D','63a03700-f18d-11ee-96c2-c29d42d3cfc8','4_SUDO'),
('4D773D3D','e9b17692-f18d-11ee-96c2-c29d42d3cfc8','0_UNCONFIRMED'),
('4E413D3D','0cf18318-f18e-11ee-96c2-c29d42d3cfc8','1_CONFIRMED'),
('4F513D3D','0cf1b158-f18e-11ee-96c2-c29d42d3cfc8','1_ORG_EMPLOYEE'),
('4E673D3D','0cf1c8d2-f18e-11ee-96c2-c29d42d3cfc8','x_BANNED'),
('4E773D3D','0cf23fd8-f18e-11ee-96c2-c29d42d3cfc8','2_MOD'),
('4D54413D','3cf23fd8-f18e-11ee-96c2-c29d42d3cfc8','3_ADMIN'),
('4D54453D','df4b1258-f197-11ee-96c2-c29d42d3cfc8','0_UNCONFIRMED'),
('4D6A453D','f07ddc36-f566-11ee-a619-c29d42d3cfc8','2_MOD'),
('4D6A493D','af9287ee-f56b-11ee-a619-c29d42d3cfc8','0_UNCONFIRMED'),
('4D6A4D3D','f1bb5e20-f575-11ee-a619-c29d42d3cfc8','1_CONFIRMED'),
('4D6A633D','55f105ea-f623-11ee-a619-c29d42d3cfc8','0_UNCONFIRMED');
/*!40000 ALTER TABLE `dq_lookup_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'QrxAggregate'
--

--
-- Current Database: `QrxJoin`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `QrxJoin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `QrxJoin`;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Location` (
  `reference` varchar(15) NOT NULL,
  `type` varchar(20) NOT NULL CHECK (field(`enforce_type`,`type`)),
  `value` varchar(50) DEFAULT NULL,
  `extra` varchar(50) DEFAULT NULL,
  `enforce_type` enum('STATE','COUNTRY','ZIP_CODE','AREA_CODE') NOT NULL,
  UNIQUE KEY `Location_reference_type_IDX` (`reference`,`type`) USING BTREE,
  UNIQUE KEY `Location_reference_IDX` (`reference`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` VALUES
('$','STATE','$',NULL,'STATE'),
('AK','STATE','Alaska',NULL,'STATE'),
('AL','STATE','Alabama',NULL,'STATE'),
('AR','STATE','Arkansas',NULL,'STATE'),
('AZ','STATE','Arizona',NULL,'STATE'),
('CA','STATE','California',NULL,'STATE'),
('CO','STATE','Colorado',NULL,'STATE'),
('CT','STATE','Connecticut',NULL,'STATE'),
('DC','STATE','District of Columbia',NULL,'STATE'),
('DE','STATE','Delaware',NULL,'STATE'),
('FL','STATE','Florida',NULL,'STATE'),
('GA','STATE','Georgia',NULL,'STATE'),
('HI','STATE','Hawaii',NULL,'STATE'),
('IA','STATE','Iowa',NULL,'STATE'),
('ID','STATE','Idaho',NULL,'STATE'),
('IL','STATE','Illinois',NULL,'STATE'),
('IN','STATE','Indiana',NULL,'STATE'),
('KS','STATE','Kansas',NULL,'STATE'),
('KY','STATE','Kentucky',NULL,'STATE'),
('LA','STATE','Louisiana',NULL,'STATE'),
('MA','STATE','Massachusetts',NULL,'STATE'),
('MD','STATE','Maryland',NULL,'STATE'),
('ME','STATE','Maine',NULL,'STATE'),
('MI','STATE','Michigan',NULL,'STATE'),
('MN','STATE','Minnesota',NULL,'STATE'),
('MO','STATE','Missouri',NULL,'STATE'),
('MS','STATE','Mississippi',NULL,'STATE'),
('MT','STATE','Montana',NULL,'STATE'),
('NC','STATE','North Carolina',NULL,'STATE'),
('ND','STATE','North Dakota',NULL,'STATE'),
('NE','STATE','Nebraska',NULL,'STATE'),
('NH','STATE','New Hampshire',NULL,'STATE'),
('NJ','STATE','New Jersey',NULL,'STATE'),
('NM','STATE','New Mexico',NULL,'STATE'),
('NV','STATE','Nevada',NULL,'STATE'),
('NY','STATE','New York',NULL,'STATE'),
('OH','STATE','Ohio',NULL,'STATE'),
('OK','STATE','Oklahoma',NULL,'STATE'),
('OR','STATE','Oregon',NULL,'STATE'),
('PA','STATE','Pennsylvania',NULL,'STATE'),
('RI','STATE','Rhode Island',NULL,'STATE'),
('SC','STATE','South Carolina',NULL,'STATE'),
('SD','STATE','South Dakota',NULL,'STATE'),
('TN','STATE','Tennessee',NULL,'STATE'),
('TX','STATE','Texas',NULL,'STATE'),
('UT','STATE','Utah',NULL,'STATE'),
('VA','STATE','Virginia',NULL,'STATE'),
('VT','STATE','Vermont',NULL,'STATE'),
('WA','STATE','Washington',NULL,'STATE'),
('WI','STATE','Wisconsin',NULL,'STATE'),
('WV','STATE','West Virginia',NULL,'STATE'),
('WY','STATE','Wyoming',NULL,'STATE'),
('_','STATE','_',NULL,'STATE');
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'QrxJoin'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-01  1:17:16
