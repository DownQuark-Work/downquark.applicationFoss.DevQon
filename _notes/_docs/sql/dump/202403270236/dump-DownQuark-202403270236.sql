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
-- Table structure for table `Map_Projects`
--

DROP TABLE IF EXISTS `Map_Projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Map_Projects` (
  `id` enum('DEVELOPMENT_QONSOLE','DEVELOPMENT_QONSOLE__QANBAN_BOARD') NOT NULL,
  `name` varchar(50) NOT NULL,
  `path` varchar(100) DEFAULT NULL COMMENT '\nthis will most likely be the database table\n- but could be github, etc\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Map_Projects`
--

LOCK TABLES `Map_Projects` WRITE;
/*!40000 ALTER TABLE `Map_Projects` DISABLE KEYS */;
INSERT INTO `Map_Projects` VALUES ('DEVELOPMENT_QONSOLE','devqon','/_devqon'),('DEVELOPMENT_QONSOLE__QANBAN_BOARD','qanban','/');
/*!40000 ALTER TABLE `Map_Projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_downquark`
--

DROP TABLE IF EXISTS `_downquark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_downquark` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `version` tinytext DEFAULT '0.0.0-pre-alpha',
  `path_repository` tinytext DEFAULT 'https://github.com/DownQuark-Work',
  `path_website` tinytext DEFAULT 'https://www.downquark.work',
  `created` timestamp NULL DEFAULT current_timestamp(),
  `edited` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='tbd';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_downquark`
--

LOCK TABLES `_downquark` WRITE;
/*!40000 ALTER TABLE `_downquark` DISABLE KEYS */;
INSERT INTO `_downquark` VALUES ('4dab21ba-ebea-11ee-8343-c29d42d3cfc7','0.0.0-pre-alpha','https://github.com/DownQuark-Work','https://www.downquark.work','2024-03-27 03:30:05','2024-03-27 03:30:05');
/*!40000 ALTER TABLE `_downquark` ENABLE KEYS */;
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
  `type` enum('DEVELOPMENT','PERSONAL','ORGANIZATION') NOT NULL DEFAULT 'PERSONAL',
  `created` timestamp NULL DEFAULT current_timestamp(),
  `edited` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='\nall users across all projects will have a mapping on this database table.\nsubsequent projects and tables will store the relevant info required for their integrations\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'65bd3162-ebea-11ee-8343-c29d42d3cfc7','PERSONAL','2024-03-27 03:30:45','2024-03-27 03:30:45'),(2,'65bd5f84-ebea-11ee-8343-c29d42d3cfc7','PERSONAL','2024-03-27 03:30:45','2024-03-27 03:30:45'),(3,'65bd7f00-ebea-11ee-8343-c29d42d3cfc7','PERSONAL','2024-03-27 03:30:45','2024-03-27 03:30:45'),(4,'65bd901c-ebea-11ee-8343-c29d42d3cfc7','PERSONAL','2024-03-27 03:30:45','2024-03-27 03:30:45'),(5,'65bda192-ebea-11ee-8343-c29d42d3cfc7','PERSONAL','2024-03-27 03:30:45','2024-03-27 03:30:45');
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
  PRIMARY KEY (`id`),
  CONSTRAINT `accounts_authorization_ibfk_1` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
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
  UNIQUE KEY `api_key` (`api_key`) USING HASH,
  CONSTRAINT `accounts_development_ibfk_1` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`)
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
  PRIMARY KEY (`id`),
  CONSTRAINT `accounts_organization_ibfk_1` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`)
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
  PRIMARY KEY (`id`),
  CONSTRAINT `accounts_personal_ibfk_1` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`)
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
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `project_id` enum('DEVELOPMENT_QONSOLE','DEVELOPMENT_QONSOLE__QANBAN_BOARD') DEFAULT NULL,
  `created` timestamp NULL DEFAULT current_timestamp(),
  `edited` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `Map_Projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='each project deemed sufficient will have their row here';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'DEVELOPMENT_QONSOLE','2024-03-27 03:38:36','2024-03-27 03:38:36');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
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

-- Dump completed on 2024-03-27  2:36:32
