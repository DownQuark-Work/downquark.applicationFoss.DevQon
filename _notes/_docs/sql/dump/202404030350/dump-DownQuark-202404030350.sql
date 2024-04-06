-- MySQL dump 10.13  Distrib 8.3.0, for macos14.2 (arm64)
--
-- Host: localhost    Database: DownQuark
-- ------------------------------------------------------
-- Server version	11.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `_downquark`
--

DROP TABLE IF EXISTS `_downquark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
INSERT INTO `_downquark` VALUES (4,'4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','DOWNQUARK','0.0.0-pre-alpha','n/a','2024-04-02 13:02:35','2024-04-02 13:02:35');
/*!40000 ALTER TABLE `_downquark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_dq`
--

DROP TABLE IF EXISTS `_dq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
INSERT INTO `_dq` VALUES ('ACCOUNT','ACCNT_DEVELOPMENT','ACCOUNT','2024-04-03 05:36:01','2024-04-03 05:36:01'),('ACCOUNT','ACCNT_INTERNAL','ACCOUNT','2024-04-03 07:12:58','2024-04-03 07:12:58'),('ACCOUNT','ACCNT_ORGANIZATION','ACCOUNT','2024-04-03 05:36:01','2024-04-03 05:36:01'),('ACCOUNT','ACCNT_PERSONAL','ACCOUNT','2024-04-03 05:36:01','2024-04-03 05:36:01'),('PROJECT','DEVELOPMENT_QONSOLE','PROJECT','2024-04-02 00:25:57','2024-04-02 00:25:57'),('PROJECT','DEVELOPMENT_QONSOLE__QANBAN_BOARD','PROJECT','2024-04-02 00:25:58','2024-04-02 00:25:58'),('PROJECT','DOWNQUARK','PROJECT','2024-04-02 00:25:56','2024-04-02 00:25:56'),('ROLE','0_UNCONFIRMED','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),('ROLE','1_CONFIRMED','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),('ROLE','1_ORG_EMPLOYEE','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),('ROLE','2_MOD','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),('ROLE','2_ORG_LEADER','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),('ROLE','3_ADMIN','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),('ROLE','4_SUDO','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23'),('ROLE','x_BANNED','ROLE','2024-04-03 05:42:23','2024-04-03 05:42:23');
/*!40000 ALTER TABLE `_dq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_dq_projects`
--

DROP TABLE IF EXISTS `_dq_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
INSERT INTO `_dq_projects` VALUES ('4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8',NULL,'DOWNQUARK','PROJECT','https://github.com/DownQuark-Work','https://www.downquark.work','.dq','_dq','2024-04-02 03:37:18','2024-04-02 03:37:18'),('59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE','PROJECT','https://github.com/DownQuark-Work/downquark.applicationFoss.DevQon','https://www.downquark.work/?projects_active_foss_devqon','devqon','_devqon','2024-04-02 03:44:47','2024-04-02 03:44:47'),('362b79ae-f0a4-11ee-96c2-c29d42d3cfc8','59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE__QANBAN_BOARD','PROJECT','https://github.com/DownQuark-Work/downquark.applicationFoss.QanbanBoard','https://www.downquark.work/?projects_active_foss_qanban','qanban','_qanban','2024-04-02 03:50:56','2024-04-02 03:50:56');
/*!40000 ALTER TABLE `_dq_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'used only inside the DownQuark database',
  `uuid` uuid NOT NULL DEFAULT uuid() COMMENT 'this will be the lookup reference in subsequent projects',
  `type` varchar(25) NOT NULL DEFAULT 'ACCNT_PERSONAL' CHECK (`enforce_account_type` = 'ACCOUNT'),
  `role` varchar(25) NOT NULL DEFAULT '0_UNCONFIRMED',
  `enforce_account_role` varchar(10) NOT NULL DEFAULT 'ROLE',
  `enforce_account_type` varchar(10) NOT NULL DEFAULT 'ACCOUNT',
  `created` timestamp NULL DEFAULT current_timestamp(),
  `edited` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `enforce_accounts_role` (`role`,`enforce_account_role`) USING BTREE,
  KEY `enforce_accounts_type` (`type`,`enforce_account_type`) USING BTREE,
  KEY `accounts__dq_FK` (`enforce_account_role`,`role`),
  KEY `accounts__dq_FK_1` (`enforce_account_type`,`type`),
  CONSTRAINT `accounts__dq_FK_1` FOREIGN KEY (`enforce_account_type`, `type`) REFERENCES `_dq` (`key`, `name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='\nall users across all projects will have a mapping on this database table.\nsubsequent projects and tables will store the relevant info required for their integrations\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'63a03700-f18d-11ee-96c2-c29d42d3cfc8','ACCNT_INTERNAL','4_SUDO','ROLE','ACCOUNT','2024-04-03 07:40:05','2024-04-03 07:40:05'),(3,'e9b17692-f18d-11ee-96c2-c29d42d3cfc8','ACCNT_PERSONAL','0_UNCONFIRMED','ROLE','ACCOUNT','2024-04-03 07:43:50','2024-04-03 07:43:50'),(4,'0cf18318-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_PERSONAL','1_CONFIRMED','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50'),(5,'0cf1b158-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_ORGANIZATION','2_ORG_LEADER','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50'),(6,'0cf1c8d2-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_DEVELOPMENT','x_BANNED','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50'),(7,'0cf23fd8-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_PERSONAL','2_MOD','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50'),(8,'0cf1b158-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_ORGANIZATION','1_ORG_EMPLOYEE','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50'),(9,'0cf1b158-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_ORGANIZATION','1_ORG_EMPLOYEE','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50'),(10,'0cf23fd8-f18e-11ee-96c2-c29d42d3cfc8','ACCNT_INTERNAL','3_ADMIN','ROLE','ACCOUNT','2024-04-03 07:44:50','2024-04-03 07:44:50');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_authorization`
--

DROP TABLE IF EXISTS `accounts_authorization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_authorization` (
  `id` tinyint(4) NOT NULL,
  `salt` bigint(20) unsigned DEFAULT uuid_short(),
  `hash` varchar(42) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_authorization`
--

LOCK TABLES `accounts_authorization` WRITE;
/*!40000 ALTER TABLE `accounts_authorization` DISABLE KEYS */;
INSERT INTO `accounts_authorization` VALUES (2,100770726486736908,'bac'),(3,100770726486736909,'123'),(4,100770726486736910,'321');
/*!40000 ALTER TABLE `accounts_authorization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_development`
--

DROP TABLE IF EXISTS `accounts_development`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_development` (
  `id` tinyint(4) NOT NULL,
  `api_key` tinytext NOT NULL,
  `expires` datetime DEFAULT NULL COMMENT '90 days?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_key` (`api_key`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_development`
--

LOCK TABLES `accounts_development` WRITE;
/*!40000 ALTER TABLE `accounts_development` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_development` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_organization`
--

DROP TABLE IF EXISTS `accounts_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_organization` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(30) DEFAULT NULL COMMENT 'the name of the organization',
  `address` varchar(200) DEFAULT NULL,
  `state` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_organization`
--

LOCK TABLES `accounts_organization` WRITE;
/*!40000 ALTER TABLE `accounts_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_personal`
--

DROP TABLE IF EXISTS `accounts_personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_personal` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `last_login` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_personal`
--

LOCK TABLES `accounts_personal` WRITE;
/*!40000 ALTER TABLE `accounts_personal` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'DownQuark'
--

--
-- Dumping routines for database 'DownQuark'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-03  3:50:47
