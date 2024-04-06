-- MySQL dump 10.13  Distrib 8.3.0, for macos14.2 (arm64)
--
-- Host: localhost    Database: DevQon
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
-- Table structure for table `_project`
--

DROP TABLE IF EXISTS `_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
INSERT INTO `_project` VALUES (1,'59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE','dq0.0.2-pre-release','e82c7c1367619c140662889313013b450cf9133c','2024-04-02 04:24:45','2024-04-02 04:53:05'),(3,'59e8e864-f0a3-11ee-96c2-c29d42d3cfc8','DEVELOPMENT_QONSOLE','dq0.2.0-pre-release','5282eff8121509048643e8bbdb870f86b98a314d','2024-04-02 04:24:45','2024-04-02 04:53:09');
/*!40000 ALTER TABLE `_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_associations`
--

DROP TABLE IF EXISTS `account_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_associations` (
  `from` uuid NOT NULL,
  `to` uuid NOT NULL,
  `updated` timestamp NULL DEFAULT current_timestamp(),
  KEY `from` (`from`),
  KEY `to` (`to`)
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
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics` (
  `account` uuid NOT NULL DEFAULT uuid(),
  `location` inet4 NOT NULL,
  `entry` timestamp NULL DEFAULT current_timestamp()
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
-- Dumping events for database 'DevQon'
--

--
-- Dumping routines for database 'DevQon'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-06  0:56:33
