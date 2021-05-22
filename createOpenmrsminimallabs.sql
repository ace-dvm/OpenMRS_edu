create database openmrsminimallabs;
ALTER DATABASE openmrsminimallabs CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- MySQL dump 10.13  Distrib 5.7.34, for Linux (x86_64)
--
-- Host: localhost    Database: openmrs
-- ------------------------------------------------------
-- Server version	5.7.34-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `allergy`
--

DROP TABLE IF EXISTS `allergy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allergy` (
  `allergy_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `severity_concept_id` int(11) DEFAULT NULL,
  `coded_allergen` int(11) NOT NULL,
  `non_coded_allergen` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `allergen_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `comments` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '1',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`allergy_id`),
  UNIQUE KEY `allergy_id` (`allergy_id`),
  KEY `allergy_changed_by_fk` (`changed_by`),
  KEY `allergy_coded_allergen_fk` (`coded_allergen`),
  KEY `allergy_creator_fk` (`creator`),
  KEY `allergy_patient_id_fk` (`patient_id`),
  KEY `allergy_severity_concept_id_fk` (`severity_concept_id`),
  KEY `allergy_voided_by_fk` (`voided_by`),
  CONSTRAINT `allergy_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_coded_allergen_fk` FOREIGN KEY (`coded_allergen`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_severity_concept_id_fk` FOREIGN KEY (`severity_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergy`
--

LOCK TABLES `allergy` WRITE;
/*!40000 ALTER TABLE `allergy` DISABLE KEYS */;
/*!40000 ALTER TABLE `allergy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allergy_reaction`
--

DROP TABLE IF EXISTS `allergy_reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allergy_reaction` (
  `allergy_reaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `allergy_id` int(11) NOT NULL,
  `reaction_concept_id` int(11) NOT NULL,
  `reaction_non_coded` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`allergy_reaction_id`),
  UNIQUE KEY `allergy_reaction_id` (`allergy_reaction_id`),
  KEY `allergy_reaction_allergy_id_fk` (`allergy_id`),
  KEY `allergy_reaction_reaction_concept_id_fk` (`reaction_concept_id`),
  CONSTRAINT `allergy_reaction_allergy_id_fk` FOREIGN KEY (`allergy_id`) REFERENCES `allergy` (`allergy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_reaction_reaction_concept_id_fk` FOREIGN KEY (`reaction_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergy_reaction`
--

LOCK TABLES `allergy_reaction` WRITE;
/*!40000 ALTER TABLE `allergy_reaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `allergy_reaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `care_setting`
--

DROP TABLE IF EXISTS `care_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `care_setting` (
  `care_setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `care_setting_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`care_setting_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `care_setting_changed_by` (`changed_by`),
  KEY `care_setting_creator` (`creator`),
  KEY `care_setting_retired_by` (`retired_by`),
  CONSTRAINT `care_setting_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `care_setting_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `care_setting_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `care_setting`
--

LOCK TABLES `care_setting` WRITE;
/*!40000 ALTER TABLE `care_setting` DISABLE KEYS */;
INSERT INTO `care_setting` VALUES (1,'Outpatient','Out-patient care setting','OUTPATIENT',1,'2013-12-27 00:00:00',0,NULL,NULL,NULL,NULL,NULL,'6f0c9a92-6f24-11e3-af88-005056821db0'),(2,'Inpatient','In-patient care setting','INPATIENT',1,'2013-12-27 00:00:00',0,NULL,NULL,NULL,NULL,NULL,'c365e560-c3ec-11e3-9c1a-0800200c9a66');
/*!40000 ALTER TABLE `care_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clob_datatype_storage`
--

DROP TABLE IF EXISTS `clob_datatype_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clob_datatype_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clob_datatype_storage`
--

LOCK TABLES `clob_datatype_storage` WRITE;
/*!40000 ALTER TABLE `clob_datatype_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `clob_datatype_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cohort`
--

DROP TABLE IF EXISTS `cohort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort` (
  `cohort_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`cohort_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `cohort_creator` (`creator`),
  KEY `user_who_changed_cohort` (`changed_by`),
  KEY `user_who_voided_cohort` (`voided_by`),
  CONSTRAINT `cohort_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_cohort` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_cohort` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort`
--

LOCK TABLES `cohort` WRITE;
/*!40000 ALTER TABLE `cohort` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cohort_member`
--

DROP TABLE IF EXISTS `cohort_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort_member` (
  `cohort_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `cohort_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`cohort_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `cohort_member_creator` (`creator`),
  KEY `member_patient` (`patient_id`),
  KEY `parent_cohort` (`cohort_id`),
  CONSTRAINT `cohort_member_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `member_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parent_cohort` FOREIGN KEY (`cohort_id`) REFERENCES `cohort` (`cohort_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort_member`
--

LOCK TABLES `cohort_member` WRITE;
/*!40000 ALTER TABLE `cohort_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept`
--

DROP TABLE IF EXISTS `concept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept` (
  `concept_id` int(11) NOT NULL AUTO_INCREMENT,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `short_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `form_text` text COLLATE utf8_unicode_ci,
  `datatype_id` int(11) NOT NULL DEFAULT '0',
  `class_id` int(11) NOT NULL DEFAULT '0',
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `version` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_classes` (`class_id`),
  KEY `concept_creator` (`creator`),
  KEY `concept_datatypes` (`datatype_id`),
  KEY `user_who_changed_concept` (`changed_by`),
  KEY `user_who_retired_concept` (`retired_by`),
  CONSTRAINT `concept_classes` FOREIGN KEY (`class_id`) REFERENCES `concept_class` (`concept_class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_datatypes` FOREIGN KEY (`datatype_id`) REFERENCES `concept_datatype` (`concept_datatype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_concept` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_concept` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept`
--

LOCK TABLES `concept` WRITE;
/*!40000 ALTER TABLE `concept` DISABLE KEYS */;
INSERT INTO `concept` VALUES (1,0,'','',NULL,4,11,0,1,'2018-06-04 18:29:58',NULL,NULL,NULL,NULL,NULL,NULL,'cf82933b-3f3f-45e7-a5ab-5d31aaee3da3'),(2,0,'','',NULL,4,11,0,1,'2018-06-04 18:29:58',NULL,NULL,NULL,NULL,NULL,NULL,'488b58ff-64f5-4f8a-8979-fa79940b1594'),(45,0,NULL,NULL,NULL,1,1,0,1,'2004-12-02 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1017AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(46,0,NULL,NULL,NULL,1,1,0,1,'2004-12-02 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1016AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(47,0,NULL,NULL,NULL,1,1,0,1,'2016-06-16 00:35:04',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'163426AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(48,0,NULL,NULL,NULL,1,1,0,1,'2004-12-02 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1015AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(49,0,NULL,NULL,NULL,1,1,0,1,'2004-01-01 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'21AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(50,0,NULL,NULL,NULL,1,1,0,1,'2004-12-02 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1018AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(51,0,NULL,NULL,NULL,1,1,0,1,'2004-05-05 04:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'851AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(52,0,NULL,NULL,NULL,1,1,0,1,'2004-01-01 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'678AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(53,0,NULL,NULL,NULL,1,1,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'729AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(54,0,NULL,NULL,NULL,1,1,0,1,'2006-06-09 18:21:12','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1336AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(55,0,NULL,NULL,NULL,1,1,0,1,'2006-06-09 18:24:35','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1338AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(56,0,NULL,NULL,NULL,1,1,0,1,'2004-01-01 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'679AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(57,0,NULL,NULL,NULL,4,8,1,1,'2004-12-02 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1019AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(58,0,NULL,NULL,NULL,4,11,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'664AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(59,0,NULL,NULL,NULL,4,11,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'703AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(60,0,NULL,NULL,NULL,2,1,0,1,'2011-10-26 17:53:12',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'160232AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(61,0,NULL,NULL,NULL,4,5,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'692AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(62,0,NULL,NULL,NULL,4,5,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'690AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(63,0,NULL,NULL,NULL,4,11,0,1,'2005-02-16 22:44:55',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1231AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(64,0,NULL,NULL,NULL,4,5,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'699AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(65,0,NULL,NULL,NULL,4,5,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'694AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(66,0,NULL,NULL,NULL,4,11,0,1,'2005-02-16 22:44:26',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1230AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(67,0,NULL,NULL,NULL,4,5,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'701AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(68,0,NULL,NULL,NULL,4,5,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'696AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(69,0,NULL,NULL,NULL,2,1,0,1,'2004-01-01 05:00:00',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'300AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(70,0,NULL,NULL,NULL,4,8,1,1,'2012-12-28 23:34:21',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'161473AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(71,0,NULL,NULL,NULL,4,10,1,1,'2018-07-20 16:32:39',NULL,1,'2021-05-22 06:54:55',NULL,NULL,NULL,'4eae0e35-eb07-44c4-a770-ef7854fc9e8c'),(72,0,NULL,NULL,NULL,1,1,0,1,'2004-01-01 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'655AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(73,0,NULL,NULL,NULL,1,1,0,1,'2004-12-02 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1006AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(74,0,NULL,NULL,NULL,1,1,0,1,'2004-12-02 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1009AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(75,0,NULL,NULL,NULL,1,1,0,1,'2004-12-02 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1008AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(76,0,NULL,NULL,NULL,1,1,0,1,'2006-06-02 20:01:56','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1298AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(77,0,NULL,NULL,NULL,1,1,0,1,'2004-12-02 05:00:00','0.1',1,'2021-05-22 06:54:55',NULL,NULL,NULL,'1007AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(78,0,NULL,NULL,NULL,4,8,1,1,'2004-12-02 05:00:00',NULL,1,'2021-05-22 06:54:56',NULL,NULL,NULL,'1010AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(79,0,NULL,NULL,NULL,3,1,0,1,'2012-12-27 20:55:09',NULL,1,'2021-05-22 06:54:56',NULL,NULL,NULL,'161445AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(80,0,NULL,NULL,NULL,1,1,0,1,'2004-04-08 04:00:00','0.1',1,'2021-05-22 06:54:56',NULL,NULL,NULL,'790AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(81,0,NULL,NULL,NULL,1,1,0,1,'2016-07-29 05:38:34',NULL,1,'2021-05-22 06:54:56',NULL,NULL,NULL,'163699AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(82,0,NULL,NULL,NULL,1,1,0,1,'2004-05-05 04:00:00','0.1',1,'2021-05-22 06:54:56',NULL,NULL,NULL,'857AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(83,0,NULL,NULL,NULL,1,1,0,1,'2004-05-31 04:00:00',NULL,1,'2021-05-22 06:54:56',NULL,NULL,NULL,'887AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(84,0,NULL,NULL,NULL,4,8,1,1,'2012-12-30 07:50:58',NULL,1,'2021-05-22 06:54:56',NULL,NULL,NULL,'161488AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(85,0,NULL,NULL,NULL,4,10,1,1,'2018-07-20 16:33:14',NULL,1,'2021-05-22 06:54:56',NULL,NULL,NULL,'956992bc-f7fe-4cf5-b1a0-794b19ff7a88'),(86,0,NULL,NULL,NULL,4,10,1,1,'2018-07-20 16:29:08',NULL,1,'2021-05-22 06:54:56',NULL,NULL,NULL,'da006137-88ca-4d11-ae58-8b4b439afdd6');
/*!40000 ALTER TABLE `concept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_answer`
--

DROP TABLE IF EXISTS `concept_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_answer` (
  `concept_answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `answer_concept` int(11) DEFAULT NULL,
  `answer_drug` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_answer_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `answer` (`answer_concept`),
  KEY `answer_answer_drug_fk` (`answer_drug`),
  KEY `answer_creator` (`creator`),
  KEY `answers_for_concept` (`concept_id`),
  CONSTRAINT `answer` FOREIGN KEY (`answer_concept`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answer_answer_drug_fk` FOREIGN KEY (`answer_drug`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answer_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answers_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_answer`
--

LOCK TABLES `concept_answer` WRITE;
/*!40000 ALTER TABLE `concept_answer` DISABLE KEYS */;
INSERT INTO `concept_answer` VALUES (11,60,58,NULL,1,'2011-10-26 17:53:12',3449,'3449CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),(12,60,59,NULL,1,'2011-10-26 17:53:12',3450,'3450CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),(13,69,61,NULL,1,'2005-02-16 22:56:08',20,'20CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),(14,69,62,NULL,1,'2005-02-16 22:56:08',19,'19CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),(15,69,63,NULL,1,'2005-02-16 22:49:53',26,'26CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),(16,69,64,NULL,1,'2005-02-16 22:49:53',23,'23CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),(17,69,65,NULL,1,'2005-02-16 22:56:08',21,'21CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),(18,69,66,NULL,1,'2005-02-16 22:49:53',25,'25CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),(19,69,67,NULL,1,'2005-02-16 22:49:53',24,'24CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),(20,69,68,NULL,1,'2005-02-16 22:56:08',22,'22CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
/*!40000 ALTER TABLE `concept_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_attribute`
--

DROP TABLE IF EXISTS `concept_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_attribute` (
  `concept_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text COLLATE utf8_unicode_ci NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`concept_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `concept_attribute_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_concept_fk` (`concept_id`),
  KEY `concept_attribute_creator_fk` (`creator`),
  KEY `concept_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `concept_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `concept_attribute_type` (`concept_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_concept_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_attribute`
--

LOCK TABLES `concept_attribute` WRITE;
/*!40000 ALTER TABLE `concept_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_attribute_type`
--

DROP TABLE IF EXISTS `concept_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_attribute_type` (
  `concept_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype_config` text COLLATE utf8_unicode_ci,
  `preferred_handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler_config` text COLLATE utf8_unicode_ci,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_type_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_type_creator_fk` (`creator`),
  KEY `concept_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `concept_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_attribute_type`
--

LOCK TABLES `concept_attribute_type` WRITE;
/*!40000 ALTER TABLE `concept_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_class`
--

DROP TABLE IF EXISTS `concept_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_class` (
  `concept_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_class_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_class_changed_by` (`changed_by`),
  KEY `concept_class_creator` (`creator`),
  KEY `concept_class_name_index` (`name`),
  KEY `concept_class_retired_status` (`retired`),
  KEY `user_who_retired_concept_class` (`retired_by`),
  CONSTRAINT `concept_class_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_class_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_concept_class` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_class`
--

LOCK TABLES `concept_class` WRITE;
/*!40000 ALTER TABLE `concept_class` DISABLE KEYS */;
INSERT INTO `concept_class` VALUES (1,'Test','Acq. during patient encounter (vitals, labs, etc.)',1,'2004-02-02 05:00:00',0,NULL,NULL,NULL,'8d4907b2-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',1),(2,'Procedure','Describes a clinical procedure',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d490bf4-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(3,'Drug','Drug',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d490dfc-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(4,'Diagnosis','Conclusion drawn through findings',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4918b0-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(5,'Finding','Practitioner observation/finding',1,'2004-03-02 05:00:00',0,NULL,NULL,NULL,'8d491a9a-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',1),(6,'Anatomy','Anatomic sites / descriptors',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491c7a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(7,'Question','Question (eg, patient history, SF36 items)',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491e50-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(8,'LabSet','Term to describe laboratory sets',1,'2004-03-02 05:00:00',0,NULL,NULL,NULL,'8d492026-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',1),(9,'MedSet','Term to describe medication sets',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4923b4-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(10,'ConvSet','Term to describe convenience sets',1,'2004-03-02 05:00:00',0,NULL,NULL,NULL,'8d492594-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',1),(11,'Misc','Terms which don\'t fit other categories',1,'2004-03-02 05:00:00',0,NULL,NULL,NULL,'8d492774-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',1),(12,'Symptom','Patient-reported observation',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492954-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(13,'Symptom/Finding','Observation that can be reported from patient or found on exam',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492b2a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(14,'Specimen','Body or fluid specimen',1,'2004-12-02 00:00:00',0,NULL,NULL,NULL,'8d492d0a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(15,'Misc Order','Orderable items which aren\'t tests or drugs',1,'2005-02-17 00:00:00',0,NULL,NULL,NULL,'8d492ee0-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(16,'Frequency','A class for order frequencies',1,'2014-03-06 00:00:00',0,NULL,NULL,NULL,'8e071bfe-520c-44c0-a89b-538e9129b42a',NULL,NULL);
/*!40000 ALTER TABLE `concept_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_complex`
--

DROP TABLE IF EXISTS `concept_complex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_complex` (
  `concept_id` int(11) NOT NULL,
  `handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `concept_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_complex`
--

LOCK TABLES `concept_complex` WRITE;
/*!40000 ALTER TABLE `concept_complex` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_complex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_datatype`
--

DROP TABLE IF EXISTS `concept_datatype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_datatype` (
  `concept_datatype_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `hl7_abbreviation` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_datatype_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_datatype_creator` (`creator`),
  KEY `concept_datatype_name_index` (`name`),
  KEY `concept_datatype_retired_status` (`retired`),
  KEY `user_who_retired_concept_datatype` (`retired_by`),
  CONSTRAINT `concept_datatype_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_concept_datatype` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_datatype`
--

LOCK TABLES `concept_datatype` WRITE;
/*!40000 ALTER TABLE `concept_datatype` DISABLE KEYS */;
INSERT INTO `concept_datatype` VALUES (1,'Numeric','NM','Numeric value, including integer or float (e.g., creatinine, weight)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4488-c2cc-11de-8d13-0010c6dffd0f'),(2,'Coded','CWE','Value determined by term dictionary lookup (i.e., term identifier)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a48b6-c2cc-11de-8d13-0010c6dffd0f'),(3,'Text','ST','Free text',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4ab4-c2cc-11de-8d13-0010c6dffd0f'),(4,'N/A','ZZ','Not associated with a datatype (e.g., term answers, sets)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4c94-c2cc-11de-8d13-0010c6dffd0f'),(5,'Document','RP','Pointer to a binary or text-based document (e.g., clinical document, RTF, XML, EKG, image, etc.) stored in complex_obs table',1,'2004-04-15 00:00:00',0,NULL,NULL,NULL,'8d4a4e74-c2cc-11de-8d13-0010c6dffd0f'),(6,'Date','DT','Absolute date',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a505e-c2cc-11de-8d13-0010c6dffd0f'),(7,'Time','TM','Absolute time of day',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a591e-c2cc-11de-8d13-0010c6dffd0f'),(8,'Datetime','TS','Absolute date and time',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a5af4-c2cc-11de-8d13-0010c6dffd0f'),(10,'Boolean','BIT','Boolean value (yes/no, true/false)',1,'2004-08-26 00:00:00',0,NULL,NULL,NULL,'8d4a5cca-c2cc-11de-8d13-0010c6dffd0f'),(11,'Rule','ZZ','Value derived from other data',1,'2006-09-11 00:00:00',0,NULL,NULL,NULL,'8d4a5e96-c2cc-11de-8d13-0010c6dffd0f'),(12,'Structured Numeric','SN','Complex numeric values possible (ie, <5, 1-10, etc.)',1,'2005-08-06 00:00:00',0,NULL,NULL,NULL,'8d4a606c-c2cc-11de-8d13-0010c6dffd0f'),(13,'Complex','ED','Complex value.  Analogous to HL7 Embedded Datatype',1,'2008-05-28 12:25:34',0,NULL,NULL,NULL,'8d4a6242-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `concept_datatype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_description`
--

DROP TABLE IF EXISTS `concept_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_description` (
  `concept_description_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_description_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `description_for_concept` (`concept_id`),
  KEY `user_who_changed_description` (`changed_by`),
  KEY `user_who_created_description` (`creator`),
  CONSTRAINT `description_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_description` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_description` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_description`
--

LOCK TABLES `concept_description` WRITE;
/*!40000 ALTER TABLE `concept_description` DISABLE KEYS */;
INSERT INTO `concept_description` VALUES (40,45,'Average concentration of hemoglobin in a given volume of blood.','en',1,'2004-12-02 05:00:00',NULL,'2016-06-16 00:27:23','1019FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(41,46,'Measurement of the amount that red blood cells vary in size','en',1,'2004-12-02 05:00:00',NULL,'2016-05-13 21:23:58','1018FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(42,47,'A lab test obtained by summing the monocytes, eosinophils and basophils.','en',1,'2016-06-16 00:35:04',NULL,'2016-07-29 05:41:40','17785FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(43,48,'Percent of whole blood that is composed of red blood cells.','en',1,'2004-12-02 05:00:00',NULL,'2016-05-13 21:19:31','1017FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(44,49,'خون کے سرخ ذرات میں موجود ائرن جو جسم میں اکسیجن بانٹتا ہے اور سانس لینے میں مدد کرتا ہے','ur',1,'2016-08-10 19:11:55',NULL,NULL,'18146FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(45,49,'The iron-containing respiratory pigment in red blood cells of vertebrates, consisting of about 6 percent heme and 94 percent globin.','en',1,'2004-01-01 05:00:00',NULL,'2016-08-10 19:11:55','21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(46,49,'ni kitukilichopo katitka chembecmbe nyekundu za damu inayoifanya damu kuwa nyekundu','sw',1,'2012-08-10 23:17:12',NULL,'2016-08-10 19:11:55','16956FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(47,50,'A calculation of the amount of oxygen-carrying hemoglobin inside RBCs. Since macrocytic RBCs are larger than either normal or microcytic RBCs, they would also tend to have higher MCH values.','en',1,'2004-12-02 05:00:00',NULL,'2016-06-16 00:26:55','1020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(48,51,'The volume of the average red blood cell in a given blood sample that is found by multiplying the hematocrit by 10 and dividing by the estimated number of red blood cells .','en',1,'2004-05-05 04:00:00',NULL,'2016-06-16 00:24:53','853FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(49,52,'Blood test to measure the number of white blood cells.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-13 21:25:10','678FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(50,53,'Minute, nonnucleated, disklike cytoplasmic bodies found in the blood plasma of mammals, derived from a megakaryocyte and function to promote blood clotting.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-13 21:22:30','729FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(51,54,'Test to find, count and examine Neutrophils the type of white blood cell which form an early line of defence against bacterial infections by using microscopic exam','en',1,'2006-06-09 18:21:12',NULL,'2016-06-16 00:28:58','1322FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(52,55,'Agranulocytic leukocyte that normally makes up about 25% of the total white blood cell count but increases in the presence of infection.  This is a microscopic exam.','en',1,'2006-06-09 18:24:35',NULL,'2016-06-16 00:31:03','1324FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(53,56,'Blood test to measure the number of red blood cells.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-13 21:23:21','679FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(54,57,'A broad screening test to check for such disorders as anemia, infection, and many other diseases. Includes white blood cell count, red blood cell count, hemoglobin, hematocrit, indices (MCV, MCH, MCHC, RDW), and often includes platelet count.','en',1,'2004-12-02 05:00:00',NULL,'2016-06-20 05:28:42','1021FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(55,58,'Response to a finding or test result.','en',1,'2004-01-01 05:00:00',NULL,'2017-07-03 19:48:11','664FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(56,59,'General finding of a positive result.','en',1,'2004-01-01 05:00:00',NULL,'2016-07-10 06:06:38','703FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(57,61,'Describes a particular antigen combination on the surface of red blood cells: A, Rh negative.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-16 21:50:46','692FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(58,62,'Describes a particular antigen combination on the surface of red blood cells: A, Rh positive.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-16 21:48:04','690FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(59,63,'Describes a particular antigen combination on the surface of red blood cells: AB, Rh negative.','en',1,'2005-02-16 22:44:55',NULL,'2016-05-16 21:54:29','1233FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(60,64,'Describes a particular antigen combination on the surface of red blood cells: O, Rh positive.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-16 21:53:04','699FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(61,65,'Describes a particular antigen combination on the surface of red blood cells: B, Rh positive.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-16 21:51:46','694FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(62,66,'Describes a particular antigen combination on the surface of red blood cells: AB, Rh positive.','en',1,'2005-02-16 22:44:26',NULL,'2016-05-16 21:54:59','1232FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(63,67,'Describes a particular antigen combination on the surface of red blood cells: O, Rh negative.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-16 21:53:49','701FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(64,68,'Describes a particular antigen combination on the surface of red blood cells: B, Rh negative.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-16 21:52:28','696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(65,69,'Blood typing tests are done before a person receives a blood transfusion and to check a pregnant woman\'s blood type. Human blood is classified, or typed, according to the presence or absence of certain markers (called antigens) on the surface of red blood cells.','en',1,'2004-01-01 05:00:00',NULL,'2016-05-16 21:47:12','301FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(66,72,'Bilirubin level assay from blood','en',1,'2004-01-01 05:00:00',NULL,'2016-07-26 04:50:26','655FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(67,73,'Test often used to help establish later risk of heart disease','en',1,'2004-12-02 05:00:00',NULL,'2016-07-26 05:17:23','1008FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(68,74,'Blood component, measure of fat concentration in blood.','en',1,'2004-12-02 05:00:00',NULL,'2016-07-26 05:17:41','1011FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(69,75,'Test for LDL cholesterol is used along with other lipid tests to determine risk of heart disease.','en',1,'2004-12-02 05:00:00',NULL,'2016-07-26 05:18:29','1010FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(70,76,'Very Low Density Lipoprotein (VLDL) is one of three major lipoprotein particles.  VLDL contains the highest amount of triglyceride. Since VLDL contains most of the circulating triglyceride and since the compositions of the different particles are relatively constant, it is possible to estimate the amount of VLDL cholesterol by dividing the triglyceride value (in mg/dL) by 5.','en',1,'2006-06-02 20:01:56',NULL,'2016-07-26 05:19:17','1299FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(71,77,'Test for HDL cholesterol is used along with other lipid tests to determine risk of heart disease.','en',1,'2004-12-02 05:00:00',NULL,'2016-07-26 05:18:05','1009FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(72,78,'Blood test, composed of cholesterol, HDL, LDL, and triglyceride levels.','en',1,'2004-12-02 05:00:00',NULL,'2016-07-28 17:31:44','1012FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(73,80,'Laboratory test that determines a blood serum creatinine level.  Often used with BUN to assess kidney function.','en',1,'2004-04-08 04:00:00',NULL,'2016-01-01 02:56:03','790FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(74,80,'CRÉATININE SANGUINE','fr',1,'2007-07-13 18:47:12',NULL,'2016-01-01 02:56:03','791FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(75,81,'A calculation based on creatinine and blood urea nitrogen..https://en.wikipedia.org/wiki/Blood_urea_nitrogen','en',1,'2016-07-29 05:38:34',NULL,'2016-07-29 05:38:46','18023FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(76,82,'Measure of urea levels in the blood often used to assess kidney status.','en',1,'2004-05-05 04:00:00',NULL,'2016-06-19 21:03:53','860FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(77,83,'Laboratory measurement of the glucose level in the blood in mg/ml','en',1,'2004-05-31 04:00:00',NULL,'2015-10-12 19:51:53','890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),(78,86,'Orderable Labs Demo Concept','en',1,'2018-07-20 16:29:08',NULL,NULL,'d25105aa-e98c-40e0-9079-a156d1cdd774');
/*!40000 ALTER TABLE `concept_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_map_type`
--

DROP TABLE IF EXISTS `concept_map_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_map_type` (
  `concept_map_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_map_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_user_changed_concept_map_type` (`changed_by`),
  KEY `mapped_user_creator_concept_map_type` (`creator`),
  KEY `mapped_user_retired_concept_map_type` (`retired_by`),
  CONSTRAINT `mapped_user_changed_concept_map_type` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_creator_concept_map_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_retired_concept_map_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_map_type`
--

LOCK TABLES `concept_map_type` WRITE;
/*!40000 ALTER TABLE `concept_map_type` DISABLE KEYS */;
INSERT INTO `concept_map_type` VALUES (1,'SAME-AS',NULL,1,'2017-11-18 05:00:00',1,'2021-05-22 06:54:56',0,0,NULL,NULL,NULL,'35543629-7d8c-11e1-909d-c80aa9edcf4e'),(2,'NARROWER-THAN',NULL,1,'2017-11-18 05:00:00',1,'2021-05-22 06:54:56',0,0,NULL,NULL,NULL,'43ac5109-7d8c-11e1-909d-c80aa9edcf4e'),(3,'BROADER-THAN',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'4b9d9421-7d8c-11e1-909d-c80aa9edcf4e'),(4,'Associated finding',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'55e02065-7d8c-11e1-909d-c80aa9edcf4e'),(5,'Associated morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'605f4a61-7d8c-11e1-909d-c80aa9edcf4e'),(6,'Associated procedure',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'6eb1bfce-7d8c-11e1-909d-c80aa9edcf4e'),(7,'Associated with',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'781bdc8f-7d8c-11e1-909d-c80aa9edcf4e'),(8,'Causative agent',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'808f9e19-7d8c-11e1-909d-c80aa9edcf4e'),(9,'Finding site',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'889c3013-7d8c-11e1-909d-c80aa9edcf4e'),(10,'Has specimen',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'929600b9-7d8c-11e1-909d-c80aa9edcf4e'),(11,'Laterality',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'999c6fc0-7d8c-11e1-909d-c80aa9edcf4e'),(12,'Severity',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'a0e52281-7d8c-11e1-909d-c80aa9edcf4e'),(13,'Access',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f9e90b29-7d8c-11e1-909d-c80aa9edcf4e'),(14,'After',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'01b60e29-7d8d-11e1-909d-c80aa9edcf4e'),(15,'Clinical course',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5f7c3702-7d8d-11e1-909d-c80aa9edcf4e'),(16,'Component',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'67debecc-7d8d-11e1-909d-c80aa9edcf4e'),(17,'Direct device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'718c00da-7d8d-11e1-909d-c80aa9edcf4e'),(18,'Direct morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7b9509cb-7d8d-11e1-909d-c80aa9edcf4e'),(19,'Direct substance',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'82bb495d-7d8d-11e1-909d-c80aa9edcf4e'),(20,'Due to',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'8b77f7d3-7d8d-11e1-909d-c80aa9edcf4e'),(21,'Episodicity',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'94a81179-7d8d-11e1-909d-c80aa9edcf4e'),(22,'Finding context',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'9d23c22e-7d8d-11e1-909d-c80aa9edcf4e'),(23,'Finding informer',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'a4524368-7d8d-11e1-909d-c80aa9edcf4e'),(24,'Finding method',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'af089254-7d8d-11e1-909d-c80aa9edcf4e'),(25,'Has active ingredient',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b65aa605-7d8d-11e1-909d-c80aa9edcf4e'),(26,'Has definitional manifestation',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'c2b7b2fa-7d8d-11e1-909d-c80aa9edcf4'),(27,'Has dose form',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'cc3878e6-7d8d-11e1-909d-c80aa9edcf4e'),(28,'Has focus',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'d67c5840-7d8d-11e1-909d-c80aa9edcf4e'),(29,'Has intent',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'de2fb2c5-7d8d-11e1-909d-c80aa9edcf4e'),(30,'Has interpretation',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'e758838b-7d8d-11e1-909d-c80aa9edcf4e'),(31,'Indirect device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'ee63c142-7d8d-11e1-909d-c80aa9edcf4e'),(32,'Indirect morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f4f36681-7d8d-11e1-909d-c80aa9edcf4e'),(33,'Interprets',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'fc7f5fed-7d8d-11e1-909d-c80aa9edcf4e'),(34,'Measurement method',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'06b11d79-7d8e-11e1-909d-c80aa9edcf4e'),(35,'Method',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'0efb4753-7d8e-11e1-909d-c80aa9edcf4e'),(36,'Occurrence',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'16e7b617-7d8e-11e1-909d-c80aa9edcf4e'),(37,'Part of',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'1e82007b-7d8e-11e1-909d-c80aa9edcf4e'),(38,'Pathological process',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'2969915e-7d8e-11e1-909d-c80aa9edcf4e'),(39,'Priority',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'32d57796-7d8e-11e1-909d-c80aa9edcf4e'),(40,'Procedure context',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'3f11904c-7d8e-11e1-909d-c80aa9edcf4e'),(41,'Procedure device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'468c4aa3-7d8e-11e1-909d-c80aa9edcf4e'),(42,'Procedure morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5383e889-7d8e-11e1-909d-c80aa9edcf4e'),(43,'Procedure site',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5ad2655d-7d8e-11e1-909d-c80aa9edcf4e'),(44,'Procedure site - Direct',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'66085196-7d8e-11e1-909d-c80aa9edcf4e'),(45,'Procedure site - Indirect',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7080e843-7d8e-11e1-909d-c80aa9edcf4e'),(46,'Property',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'76bfb796-7d8e-11e1-909d-c80aa9edcf4e'),(47,'Recipient category',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7e7d00e4-7d8e-11e1-909d-c80aa9edcf4e'),(48,'Revision status',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'851e14c1-7d8e-11e1-909d-c80aa9edcf4e'),(49,'Route of administration',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'8ee5b13d-7d8e-11e1-909d-c80aa9edcf4e'),(50,'Scale type',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'986acf48-7d8e-11e1-909d-c80aa9edcf4e'),(51,'Specimen procedure',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'a6937642-7d8e-11e1-909d-c80aa9edcf4e'),(52,'Specimen source identity',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b1d6941e-7d8e-11e1-909d-c80aa9edcf4e'),(53,'Specimen source morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b7c793c1-7d8e-11e1-909d-c80aa9edcf4e'),(54,'Specimen source topography',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'be9f9eb8-7d8e-11e1-909d-c80aa9edcf4e'),(55,'Specimen substance',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'c8f2bacb-7d8e-11e1-909d-c80aa9edcf4e'),(56,'Subject of information',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'d0664c4f-7d8e-11e1-909d-c80aa9edcf4e'),(57,'Subject relationship context',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'dace9d13-7d8e-11e1-909d-c80aa9edcf4e'),(58,'Surgical approach',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'e3cd666d-7d8e-11e1-909d-c80aa9edcf4e'),(59,'Temporal context',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'ed96447d-7d8e-11e1-909d-c80aa9edcf4e'),(60,'Time aspect',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f415bcce-7d8e-11e1-909d-c80aa9edcf4e'),(61,'Using access device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'fa9538a9-7d8e-11e1-909d-c80aa9edcf4e'),(62,'Using device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'06588655-7d8f-11e1-909d-c80aa9edcf4e'),(63,'Using energy',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'0c2ae0bc-7d8f-11e1-909d-c80aa9edcf4e'),(64,'Using substance',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'13d2c607-7d8f-11e1-909d-c80aa9edcf4e'),(65,'IS A',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'1ce7a784-7d8f-11e1-909d-c80aa9edcf4e'),(66,'MAY BE A',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'267812a3-7d8f-11e1-909d-c80aa9edcf4e'),(67,'MOVED FROM',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'2de3168e-7d8f-11e1-909d-c80aa9edcf4e'),(68,'MOVED TO',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'32f0fd99-7d8f-11e1-909d-c80aa9edcf4e'),(69,'REPLACED BY',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'3b3b9a7d-7d8f-11e1-909d-c80aa9edcf4e'),(70,'WAS A',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'41a034da-7d8f-11e1-909d-c80aa9edcf4e');
/*!40000 ALTER TABLE `concept_map_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name`
--

DROP TABLE IF EXISTS `concept_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name` (
  `concept_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `locale` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `locale_preferred` tinyint(1) DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `concept_name_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_name_changed_by` (`changed_by`),
  KEY `name_for_concept` (`concept_id`),
  KEY `name_of_concept` (`name`),
  KEY `user_who_created_name` (`creator`),
  KEY `user_who_voided_this_name` (`voided_by`),
  CONSTRAINT `concept_name_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `name_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_this_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=523 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name`
--

LOCK TABLES `concept_name` WRITE;
/*!40000 ALTER TABLE `concept_name` DISABLE KEYS */;
INSERT INTO `concept_name` VALUES (1,1,'Verdadeiro','pt',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'7561f550-ccee-43b6-bcf4-269992d6c284',NULL,NULL),(2,1,'Sim','pt',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'89522273-55b5-4c4a-8e0b-cc7a66f3f3aa',NULL,NULL),(3,1,'True','en',1,1,'2018-06-04 18:29:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'111eb000-3113-4d74-9d9b-98ae5d566a98',NULL,NULL),(4,1,'Yes','en',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'a31778d2-53ab-4c4b-a333-a0149d1c25c6',NULL,NULL),(5,1,'Vero','it',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'a069d777-3999-4bb4-8217-d4fae1f337bc',NULL,NULL),(6,1,'Sì','it',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'f16c811c-d970-4f02-be47-0c7afea9eddc',NULL,NULL),(7,1,'Vrai','fr',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'bb75175c-5d1b-492a-8c38-98506e2e6b2d',NULL,NULL),(8,1,'Oui','fr',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'c4c4b0f6-c80c-410b-9f48-72b683072184',NULL,NULL),(9,1,'Verdadero','es',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'bf9ace2a-ff96-44fc-b529-172f5c3ac0b0',NULL,NULL),(10,1,'Sí','es',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'b58d53a3-c6dd-469a-8db1-0a80dfe4c542',NULL,NULL),(11,2,'Falso','pt',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'2553457e-849d-4a5c-9824-2f0a9ba79461',NULL,NULL),(12,2,'Não','pt',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'38a0828c-c54e-4bdb-8217-defb0fdfc4b6',NULL,NULL),(13,2,'False','en',1,1,'2018-06-04 18:29:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'ac6d888e-dc00-4402-9a2a-576438161f96',NULL,NULL),(14,2,'No','en',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'17a5cdd3-a0a9-406a-b39f-5cd7e8d634c4',NULL,NULL),(15,2,'Falso','it',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'026e4e70-28c5-458d-8bbf-be7abaf09519',NULL,NULL),(16,2,'No','it',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'23851ffa-da5d-4086-8107-e0318b4d26eb',NULL,NULL),(17,2,'Faux','fr',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'5709a1b5-b3de-472f-bf7a-eb57c5cb7144',NULL,NULL),(18,2,'Non','fr',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'3990b17b-22a0-4b66-9d06-1645030e6b60',NULL,NULL),(19,2,'Falso','es',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'ae3cf994-72e1-471d-9af0-96dace0b6787',NULL,NULL),(20,2,'No','es',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'72071f05-d7e2-4687-ac2e-c7d9809d888a',NULL,NULL),(272,45,'Moyenne hémoglobine cellulaire concentration','fr',1,1,'2016-05-13 21:20:14','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136186BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(273,45,'MCHC','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86749BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(274,45,'CCMH','fr',0,1,'2016-06-16 00:27:23','SHORT',0,NULL,NULL,NULL,'136623BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(275,45,'Konsantrasyon mwayen emoglobin selilè','ht',1,1,'2016-05-13 21:20:14','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136187BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(276,45,'CCMH','ht',0,1,'2016-06-16 00:27:23','SHORT',0,NULL,NULL,NULL,'136624BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(277,45,'MEAN CELL HEMOGLOBIN CONCENTRATION','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1070BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(278,45,'MCHC','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'94456BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(279,46,'Lajè distribisyon globil wouj','ht',1,1,'2016-05-13 21:23:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136196BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(280,46,'RDW','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86748BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(281,46,'RED CELL DISTRIBUTION WIDTH','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1069BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(282,46,'Largeur de distribution des gloubules rouges','fr',1,1,'2016-05-13 21:23:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136195BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(283,46,'RDW','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'97273BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(284,47,'Combined % of monocytes, eosinophils and basophils','en',1,1,'2016-06-16 00:35:04','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136629BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(285,47,'Mélangés en pourcentage (monocytes, des éosinophiles et des basophiles), les cellules sanguines','fr',1,1,'2016-06-16 00:37:45','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136630BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(286,47,'Melanj an pousantaj (Monosit, eozinofil ak bazofil) selil san','ht',1,1,'2016-06-16 00:37:45','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136631BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(287,47,'Mixed percent (monocytes, eosinophils and basophils) blood cells','en',0,1,'2016-07-29 05:41:40',NULL,0,NULL,NULL,NULL,'138860BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(288,47,'Mixed %','en',0,1,'2016-06-30 06:33:13','SHORT',0,NULL,NULL,NULL,'137122BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(289,48,'PCV','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'96215BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(290,48,'ni kiasi cha chembe chembe nyeundu za damu mwilini','sw',1,1,'2008-01-16 06:26:38','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1068BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(291,48,'CRIT','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'90082BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(292,48,'HCT','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'92736BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(293,48,'HCT','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86747BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(294,48,'Ematokrit','ht',1,1,'2016-05-13 21:19:31','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136185BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(295,48,'Hématocrite','fr',1,1,'2007-07-13 19:04:57','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1067BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(296,48,'HEMATOCRIT','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1066BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(297,48,'PACKED CELL VOLUME','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'96001BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(298,49,'Haemoglobin','en',0,1,'2012-12-27 00:54:11',NULL,0,NULL,NULL,NULL,'110964BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(299,49,'ہیموگلوبن','ur',1,1,'2016-08-10 19:11:55','FULLY_SPECIFIED',0,NULL,NULL,NULL,'139777BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(300,49,'Hémoglobine','fr',1,1,'2007-07-13 14:42:09','FULLY_SPECIFIED',0,NULL,NULL,NULL,'24BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(301,49,'HB','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'92727BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(302,49,'Hemoglobin','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'23BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(303,49,'Emoglobin','ht',1,1,'2015-11-07 07:57:18','FULLY_SPECIFIED',0,NULL,NULL,NULL,'134735BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(304,49,'Kiwango Cha Damu','sw',1,1,'2008-01-16 06:27:12','FULLY_SPECIFIED',0,NULL,NULL,NULL,'25BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(305,49,'HGB','en',0,1,'2004-01-01 05:00:00','SHORT',0,NULL,NULL,NULL,'86714BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(306,49,'HGB','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'92819BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(307,50,'Hémoglobine corpusculaires moyenne','fr',1,1,'2016-05-13 21:20:43','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136188BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(308,50,'MEAN CORPUSCULAR HEMOGLOBIN','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1071BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(309,50,'TCMH','fr',0,1,'2016-06-16 00:26:55','SHORT',0,NULL,NULL,NULL,'136621BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(310,50,'MCH','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86750BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(311,50,'Mwayen emoglobin globulè','ht',1,1,'2016-05-13 21:20:43','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136189BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(312,50,'MCH','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'94455BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(313,50,'TCMH','ht',0,1,'2016-06-16 00:26:55','SHORT',0,NULL,NULL,NULL,'136622BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(314,51,'VGM','fr',0,1,'2016-06-16 00:24:53','SHORT',0,NULL,NULL,NULL,'136619BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(315,51,'MCV','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'94459BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(316,51,'Volume globulaire moyen','fr',1,1,'2016-05-13 21:21:16','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136190BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(317,51,'MEAN CORPUSCULAR VOLUME','en',1,1,'2004-05-05 04:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'893BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(318,51,'Mwayen volim globulè','ht',1,1,'2016-05-13 21:21:16','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136191BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(319,51,'VGM','ht',0,1,'2016-06-16 00:24:53','SHORT',0,NULL,NULL,NULL,'136620BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(320,51,'MCV','en',0,1,'2004-05-05 04:00:00','SHORT',0,NULL,NULL,NULL,'86731BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(321,52,'PUS CELLS','en',0,1,'2004-10-20 04:00:00',NULL,1,1,'2021-05-22 06:54:52','not appropriate','97096BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(322,52,'WBC','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'100165BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(323,52,'WBC','en',0,1,'2004-01-01 05:00:00','SHORT',0,NULL,NULL,NULL,'86724BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(324,52,'Total leukocyte count','en',0,1,'2012-12-27 01:47:17',NULL,0,NULL,NULL,NULL,'110967BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(325,52,'Total WBC count','en',0,1,'2010-09-30 19:06:37',NULL,0,NULL,NULL,NULL,'106843BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(326,52,'WHITE BLOOD CELLS','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'711BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(327,52,'WHITE CELLS','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'100191BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(328,52,'Globules blancs','fr',1,1,'2007-07-13 18:45:14','FULLY_SPECIFIED',0,NULL,NULL,NULL,'712BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(329,52,'LEUKOCYTE COUNT','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'93911BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(330,52,'Globil blan','ht',1,1,'2016-05-13 21:25:10','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136197BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(331,53,'BLOOD PLATELET','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'88766BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(332,53,'PLTS','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'96574BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(333,53,'Plaquettes','fr',1,1,'2007-07-13 19:20:03','FULLY_SPECIFIED',0,NULL,NULL,NULL,'765BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(334,53,'Platelet count','en',0,1,'2011-09-24 17:44:06',NULL,0,NULL,NULL,NULL,'108138BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(335,53,'Platelets','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'764BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(336,53,'THROMBOCYTE','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'98954BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(337,53,'Plakèt','ht',1,1,'2016-05-13 21:22:30','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136192BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(338,54,'Neutrophiles (%)','fr',1,1,'2016-06-16 00:28:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136625BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(339,54,'Netwofil (%)','ht',1,1,'2016-06-16 00:28:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136626BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(340,54,'NEUTROPHILS (%) - MICROSCOPIC EXAM','en',1,1,'2006-06-09 18:21:12','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1425BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(341,55,'LYMPHOCYTES (%) - MICROSCOPIC EXAM','en',1,1,'2006-06-09 18:24:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1427BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(342,55,'Limfosit (%)','ht',1,1,'2016-06-16 00:31:03','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136628BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(343,55,'Lymphocytes (%)','fr',1,1,'2016-06-16 00:31:03','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136627BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(344,56,'Globil wouj','ht',1,1,'2016-05-13 21:23:21','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136194BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(345,56,'RBC count','en',0,1,'2010-09-30 19:13:44',NULL,0,NULL,NULL,NULL,'106844BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(346,56,'RBC','en',0,1,'2004-01-01 05:00:00','SHORT',0,NULL,NULL,NULL,'86725BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(347,56,'Globules rouges','fr',1,1,'2016-05-13 21:23:21','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136193BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(348,56,'RB CELLS','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'97271BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(349,56,'RED BLOOD CELLS','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'713BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(350,56,'RBCS','en',0,1,'2006-06-06 14:11:51',NULL,0,NULL,NULL,NULL,'97272BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(351,57,'Kontrol konplè globil','ht',1,1,'2016-05-13 21:18:30','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136184BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(352,57,'FHG','en',0,1,'2006-02-13 18:54:55',NULL,1,1,'2021-05-22 06:54:52','ambiguous','91923BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(353,57,'CBC','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'89287BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(354,57,'Numération globulaire complète','fr',1,1,'2016-05-13 21:18:30','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136183BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(355,57,'FULL HEMOGRAM','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'92195BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(356,57,'CBC','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86751BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(357,57,'HEMOGRAM','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'92769BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(358,57,'COMPLETE BLOOD COUNT','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1072BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(359,57,'HGM','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'92820BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(360,58,'NEG','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'95210BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(361,58,'(-)','es',0,1,'2012-03-04 23:57:43',NULL,0,NULL,NULL,NULL,'108332BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(362,58,'Negative','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'696BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(363,58,'Hasi','sw',1,1,'2012-08-10 23:14:26','FULLY_SPECIFIED',0,NULL,NULL,NULL,'110112BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(364,58,'NÉGATIF','fr',1,1,'2007-07-13 19:10:12','FULLY_SPECIFIED',0,NULL,NULL,NULL,'697BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(365,58,'(-)','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'87074BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(366,58,'negatif','ht',1,1,'2016-07-10 06:06:14','FULLY_SPECIFIED',0,NULL,NULL,NULL,'137361BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(367,58,'Negativo','es',1,1,'2012-03-04 23:57:43','FULLY_SPECIFIED',0,NULL,NULL,NULL,'108329BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(368,58,'NEG','es',0,1,'2012-03-04 23:57:43',NULL,0,NULL,NULL,NULL,'108331BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(369,58,'Negativa','es',0,1,'2012-03-04 23:57:43',NULL,0,NULL,NULL,NULL,'108330BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(370,58,'-','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'87080BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(371,59,'POS','es',0,1,'2012-03-02 22:04:50',NULL,0,NULL,NULL,NULL,'108314BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(372,59,'ኣወንታዊ ውፅኢት መርመራ ወይ ፖዘቲቭ','ti',1,1,'2010-10-24 19:52:07','FULLY_SPECIFIED',0,NULL,NULL,NULL,'106895BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(373,59,'POS','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'96670BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(374,59,'Positiva','es',0,1,'2012-03-02 22:04:50',NULL,0,NULL,NULL,NULL,'108313BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(375,59,'Chanya','sw',1,1,'2012-08-10 23:13:43','FULLY_SPECIFIED',0,NULL,NULL,NULL,'110111BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(376,59,'Positivo','es',1,1,'2012-03-02 22:04:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'108312BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(377,59,'(+)','es',0,1,'2012-03-02 22:04:50',NULL,0,NULL,NULL,NULL,'108316BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(378,59,'POSITIVE','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'737BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(379,59,'+','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'87075BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(380,59,'POSITIF','fr',1,1,'2007-07-13 19:22:14','FULLY_SPECIFIED',0,NULL,NULL,NULL,'738BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(381,59,'(+)','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'87073BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(382,59,'+','es',0,1,'2012-03-02 22:04:50',NULL,0,NULL,NULL,NULL,'108315BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(383,59,'positif','ht',1,1,'2016-07-10 06:06:38','FULLY_SPECIFIED',0,NULL,NULL,NULL,'137362BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(384,60,'Groupe sanguin - rhesus','fr',1,1,'2016-06-16 01:22:13','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136682BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(385,60,'Rhesus blood grouping test','en',1,1,'2011-10-26 17:53:12','FULLY_SPECIFIED',0,NULL,NULL,NULL,'108158BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(386,61,'A-','es',0,1,'2012-03-02 22:06:52',NULL,0,NULL,NULL,NULL,'108320BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(387,61,'A negatif','fr',1,1,'2016-05-16 21:50:46','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136304BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(388,61,'A-','fr',0,1,'2016-05-16 21:50:46','SHORT',0,NULL,NULL,NULL,'136305BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(389,61,'A-','ht',0,1,'2016-05-16 21:50:46','SHORT',0,NULL,NULL,NULL,'136307BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(390,61,'A NEGATIVE','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'726BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(391,61,'A Negativo','es',1,1,'2012-03-02 22:06:52','FULLY_SPECIFIED',0,NULL,NULL,NULL,'108319BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(392,61,'A-','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'87109BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(393,61,'A negatif','ht',1,1,'2016-05-16 21:50:46','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136306BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(394,62,'A+','es',0,1,'2012-03-02 22:05:58',NULL,0,NULL,NULL,NULL,'108318BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(395,62,'A+','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'87108BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(396,62,'A POSITIVE','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'724BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(397,62,'A pozitif','ht',1,1,'2016-05-16 21:48:04','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136302BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(398,62,'A Positivo','es',1,1,'2012-03-02 22:05:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'108317BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(399,62,'A positif','fr',1,1,'2016-05-16 21:48:04','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136300BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(400,62,'A+','ht',0,1,'2016-05-16 21:48:04','SHORT',0,NULL,NULL,NULL,'136303BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(401,62,'A+','fr',0,1,'2016-05-16 21:48:04','SHORT',0,NULL,NULL,NULL,'136301BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(402,63,'AB NEGATIVE','en',1,1,'2005-02-16 22:44:55','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1310BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(403,63,'AB-','en',0,1,'2005-02-17 15:15:48',NULL,0,NULL,NULL,NULL,'87130BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(404,63,'AB-','fr',0,1,'2016-05-16 21:54:29','SHORT',0,NULL,NULL,NULL,'136325BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(405,63,'AB negatif','fr',1,1,'2016-05-16 21:54:29','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136324BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(406,63,'AB-','ht',0,1,'2016-05-16 21:54:29','SHORT',0,NULL,NULL,NULL,'136327BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(407,63,'AB negatif','ht',1,1,'2016-05-16 21:54:29','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136326BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(408,64,'O+','es',0,1,'2012-03-02 22:10:06',NULL,0,NULL,NULL,NULL,'108326BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(409,64,'O+','fr',0,1,'2016-05-16 21:53:04','SHORT',0,NULL,NULL,NULL,'136317BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(410,64,'O+','ht',0,1,'2016-05-16 21:53:04','SHORT',0,NULL,NULL,NULL,'136319BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(411,64,'O Positivo','es',1,1,'2012-03-02 22:10:06','FULLY_SPECIFIED',0,NULL,NULL,NULL,'108325BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(412,64,'O pozitif','ht',1,1,'2016-05-16 21:53:04','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136318BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(413,64,'O POSITIVE','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'733BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(414,64,'O+','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'95617BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(415,64,'O positif','fr',1,1,'2016-05-16 21:53:04','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136316BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(416,65,'B+','es',0,1,'2012-03-02 22:07:44',NULL,0,NULL,NULL,NULL,'108322BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(417,65,'B+','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'88416BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(418,65,'B+','ht',0,1,'2016-05-16 21:51:46','SHORT',0,NULL,NULL,NULL,'136311BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(419,65,'B POSITIVE','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'728BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(420,65,'B pozitif','ht',1,1,'2016-05-16 21:51:46','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136310BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(421,65,'B Positivo','es',1,1,'2012-03-02 22:07:44','FULLY_SPECIFIED',0,NULL,NULL,NULL,'108321BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(422,65,'B+','fr',0,1,'2016-05-16 21:51:46','SHORT',0,NULL,NULL,NULL,'136309BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(423,65,'B positif','fr',1,1,'2016-05-16 21:51:46','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136308BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(424,66,'AB+','ht',0,1,'2016-05-16 21:54:59','SHORT',0,NULL,NULL,NULL,'136331BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(425,66,'AB+','en',0,1,'2005-02-16 22:44:26',NULL,0,NULL,NULL,NULL,'87129BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(426,66,'AB+','fr',0,1,'2016-05-16 21:54:59','SHORT',0,NULL,NULL,NULL,'136329BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(427,66,'AB pozitif','ht',1,1,'2016-05-16 21:54:59','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136330BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(428,66,'AB POSITIVE','en',1,1,'2005-02-16 22:44:26','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1309BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(429,66,'AB positif','fr',1,1,'2016-05-16 21:54:59','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136328BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(430,67,'O-','es',0,1,'2012-03-02 22:11:01',NULL,0,NULL,NULL,NULL,'108328BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(431,67,'O-','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'95618BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(432,67,'O-','fr',0,1,'2016-05-16 21:53:49','SHORT',0,NULL,NULL,NULL,'136321BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(433,67,'O Negativo','es',1,1,'2012-03-02 22:11:01','FULLY_SPECIFIED',0,NULL,NULL,NULL,'108327BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(434,67,'O negatif','fr',1,1,'2016-05-16 21:53:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136320BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(435,67,'O negatif','ht',1,1,'2016-05-16 21:53:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136322BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(436,67,'O NEGATIVE','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'735BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(437,67,'O-','ht',0,1,'2016-05-16 21:53:49','SHORT',0,NULL,NULL,NULL,'136323BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(438,68,'B-','es',0,1,'2012-03-02 22:08:31',NULL,0,NULL,NULL,NULL,'108324BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(439,68,'B-','en',0,1,'2004-10-20 04:00:00',NULL,0,NULL,NULL,NULL,'88417BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(440,68,'B-','ht',0,1,'2016-05-16 21:52:28','SHORT',0,NULL,NULL,NULL,'136315BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(441,68,'B negatif','ht',1,1,'2016-05-16 21:52:28','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136314BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(442,68,'B negatif','fr',1,1,'2016-05-16 21:52:28','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136312BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(443,68,'B NEGATIVE','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'730BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(444,68,'B Negativo','es',1,1,'2012-03-02 22:08:31','FULLY_SPECIFIED',0,NULL,NULL,NULL,'108323BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(445,68,'B-','fr',0,1,'2016-05-16 21:52:28','SHORT',0,NULL,NULL,NULL,'136313BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(446,69,'Blood grouping and RH typing','en',0,1,'2012-12-28 22:31:25',NULL,0,NULL,NULL,NULL,'111024BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(447,69,'Tip san','ht',1,1,'2016-05-16 21:47:12','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136299BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(448,69,'Aina za damu','sw',1,1,'2007-12-12 02:19:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'327BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(449,69,'Groupe Sanguin','fr',1,1,'2007-09-06 11:53:18','FULLY_SPECIFIED',0,NULL,NULL,NULL,'326BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(450,69,'BLOOD TYPING','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'325BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(451,69,'BLOOD GROUP','en',0,1,'2005-02-16 22:41:16',NULL,0,NULL,NULL,NULL,'88764BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(452,70,'Panel groupage sanguin','fr',1,1,'2016-06-19 20:36:15','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136708BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(453,70,'Blood grouping test','en',1,1,'2012-12-28 23:34:21','FULLY_SPECIFIED',0,NULL,NULL,NULL,'111040BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(454,70,'Panel gwoup san','ht',1,1,'2016-06-19 20:36:15','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136709BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(455,71,'Hematology Order Set','en',1,1,'2018-07-20 16:32:39','FULLY_SPECIFIED',0,NULL,NULL,NULL,'776c762e-7c63-4d48-ae79-354561ae8705',NULL,NULL),(456,71,'Hematology','en',0,1,'2018-07-20 16:39:08','SHORT',0,NULL,NULL,NULL,'49b35229-2c27-4c7a-917a-cbcbc68669a5',NULL,NULL),(457,72,'BILI','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'88714BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(458,72,'TBILI','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'98727BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(459,72,'BILIRUBINE TOTALE','fr',1,1,'2016-07-26 04:50:26','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138047BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(460,72,'TBILI','en',0,1,'2004-01-01 05:00:00','SHORT',0,NULL,NULL,NULL,'86723BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(461,72,'Bilirubin total','ht',1,1,'2016-07-26 04:50:26','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138048BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(462,72,'TOTAL BILIRUBIN','en',1,1,'2004-01-01 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'687BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(463,72,'BILIRUBIN','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'88717BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(464,73,'kolestewòl total','ht',1,1,'2016-07-26 05:17:23','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138059BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(465,73,'CHOLESTEROL','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'89551BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(466,73,'CHOLESTÉROL TOTAL','fr',1,1,'2016-07-26 05:17:23','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138058BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(467,73,'TOTAL CHOLESTEROL','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1057BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(468,73,'CHOL','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86738BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(469,74,'TG','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86741BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(470,74,'TRIG','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'99277BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(471,74,'trigliserid','ht',1,1,'2016-07-26 05:17:41','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138061BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(472,74,'TRIGLYCÉRIDES','fr',1,1,'2016-07-26 05:17:41','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138060BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(473,74,'TRIGLYCERIDES','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1060BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(474,74,'TG','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'98857BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(475,75,'Lipoprotein dansite ba kolestewòl','ht',1,1,'2016-07-26 05:18:29','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138065BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(476,75,'LDL','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86740BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(477,75,'LOW-DENSITY LIPOPROTEIN CHOLESTEROL','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1059BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(478,75,'LDL','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'93877BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(479,75,'Lipoprotéines de basse densité CHOLESTÉROL','fr',1,1,'2016-07-26 05:18:29','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138064BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(480,76,'Dansite lipoprotein ki ba anpil','ht',1,1,'2016-07-26 05:19:17','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138067BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(481,76,'VLDL-CHOLESTEROL','en',0,1,'2006-06-05 19:45:41',NULL,0,NULL,NULL,NULL,'100120BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(482,76,'VLDL','en',0,1,'2006-06-02 20:01:56','SHORT',0,NULL,NULL,NULL,'86784BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(483,76,'Lipoprotéines de très basse densité','fr',1,1,'2016-07-26 05:19:17','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138066BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(484,76,'VERY LOW DENSITY LIPOPROTEIN','en',1,1,'2006-06-02 20:01:56','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1385BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(485,77,'HIGH-DENSITY LIPOPROTEIN CHOLESTEROL','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1058BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(486,77,'Lipoprotéines cholestérol de haute densité','fr',1,1,'2016-07-26 05:18:05','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138062BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(487,77,'HDL','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86739BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(488,77,'HDL','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'92738BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(489,77,'Mas volimik kolestewòl ki wo lipoprotein','ht',1,1,'2016-07-26 05:18:05','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138063BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(490,78,'LIPIDS','en',0,1,'2004-12-02 05:00:00','SHORT',0,NULL,NULL,NULL,'86742BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(491,78,'PANEL LIPIDES','fr',1,1,'2016-07-28 17:31:44','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138477BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(492,78,'LIPID PANEL','en',1,1,'2004-12-02 05:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1061BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(493,78,'Panel lipid','ht',1,1,'2016-07-28 17:31:44','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138478BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(494,79,'Urine routine and microscopy','en',1,1,'2012-12-27 20:55:09','FULLY_SPECIFIED',0,NULL,NULL,NULL,'110990BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(495,80,'Kreyatinin','ht',1,1,'2016-01-01 02:56:03','FULLY_SPECIFIED',0,NULL,NULL,NULL,'135343BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(496,80,'CR','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'90059BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(497,80,'CR','en',0,1,'2004-04-08 04:00:00','SHORT',0,NULL,NULL,NULL,'86729BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(498,80,'CRÉATININE','fr',1,1,'2007-07-13 18:47:12','FULLY_SPECIFIED',0,NULL,NULL,NULL,'828BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(499,80,'Serum creatinine (umol/L)','en',1,1,'2004-04-08 04:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'827BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(500,81,'Urea measurement (calculated)','en',1,1,'2016-07-29 05:38:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138858BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(501,81,'Mezi ure  (kalkile)','ht',1,1,'2016-07-29 05:38:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138859BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(502,81,'Mesure de l\'urée (calculée)','fr',1,1,'2016-07-29 05:38:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138857BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(503,82,'BUN','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'88961BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(504,82,'Azote de l\'Uree','fr',1,1,'2016-06-19 21:03:53','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136710BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(505,82,'BLOOD UREA NITROGEN','en',1,1,'2004-05-05 04:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'901BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(506,82,'UREA','en',0,1,'2004-12-02 05:00:00',NULL,0,NULL,NULL,NULL,'99741BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(507,82,'BUN','en',0,1,'2004-05-05 04:00:00','SHORT',0,NULL,NULL,NULL,'86733BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(508,82,'Azòt ire nan san','ht',1,1,'2016-06-19 21:03:53','FULLY_SPECIFIED',0,NULL,NULL,NULL,'136711BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(509,83,'Egzamen sik','ht',1,1,'2015-10-12 19:51:53','FULLY_SPECIFIED',0,NULL,NULL,NULL,'134361BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(510,83,'Glucose measurement, venous blood, random','en',0,1,'2011-09-24 17:39:46',NULL,0,NULL,NULL,NULL,'108137BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(511,83,'Blood glucose','en',0,1,'2012-12-30 07:16:39',NULL,0,NULL,NULL,NULL,'111055BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(512,83,'GLUCOSE','en',0,1,'2005-01-22 05:00:00',NULL,0,NULL,NULL,NULL,'92495BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(513,83,'BLOOD SUGAR','en',0,1,'2005-02-12 16:32:22',NULL,0,NULL,NULL,NULL,'88767BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(514,83,'SERUM GLUCOSE','en',1,1,'2004-05-31 04:00:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'931BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(515,83,'GLYCÉMIE','fr',1,1,'2007-07-13 19:03:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'932BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(516,83,'GLU','en',0,1,'2004-05-31 04:00:00','SHORT',0,NULL,NULL,NULL,'86735BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(517,84,'Renal function panel','en',1,1,'2012-12-30 07:50:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'111065BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(518,84,'Panèl fonksyon renal','ht',1,1,'2016-07-28 17:27:46','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138475BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(519,84,'Panel de la fonction rénale','fr',1,1,'2016-07-28 17:27:46','FULLY_SPECIFIED',0,NULL,NULL,NULL,'138474BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',NULL,NULL),(520,85,'Biochemistry','en',0,1,'2018-07-20 16:39:38','SHORT',0,NULL,NULL,NULL,'c8dbd8f0-7d18-4b0b-b2c3-06ad28fa07c6',NULL,NULL),(521,85,'Biochemistry Order Set','en',1,1,'2018-07-20 16:33:14','FULLY_SPECIFIED',0,NULL,NULL,NULL,'420c171d-d885-4e29-a42a-b308dbfa13c5',NULL,NULL),(522,86,'Lab Orderables','en',1,1,'2018-07-20 16:29:08','FULLY_SPECIFIED',0,NULL,NULL,NULL,'56d2866a-7a3e-4a35-9028-f27ad6aa18a4',NULL,NULL);
/*!40000 ALTER TABLE `concept_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag`
--

DROP TABLE IF EXISTS `concept_name_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag` (
  `concept_name_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_tag_id`),
  UNIQUE KEY `tag` (`tag`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_name_tag_changed_by` (`changed_by`),
  KEY `user_who_created_name_tag` (`creator`),
  KEY `user_who_voided_name_tag` (`voided_by`),
  CONSTRAINT `concept_name_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag`
--

LOCK TABLES `concept_name_tag` WRITE;
/*!40000 ALTER TABLE `concept_name_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag_map`
--

DROP TABLE IF EXISTS `concept_name_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag_map` (
  `concept_name_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_name` (`concept_name_id`),
  KEY `mapped_concept_name_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_name` FOREIGN KEY (`concept_name_id`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_name_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag_map`
--

LOCK TABLES `concept_name_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_name_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_numeric`
--

DROP TABLE IF EXISTS `concept_numeric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_numeric` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `hi_absolute` double DEFAULT NULL,
  `hi_critical` double DEFAULT NULL,
  `hi_normal` double DEFAULT NULL,
  `low_absolute` double DEFAULT NULL,
  `low_critical` double DEFAULT NULL,
  `low_normal` double DEFAULT NULL,
  `units` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `allow_decimal` tinyint(1) DEFAULT NULL,
  `display_precision` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `numeric_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_numeric`
--

LOCK TABLES `concept_numeric` WRITE;
/*!40000 ALTER TABLE `concept_numeric` DISABLE KEYS */;
INSERT INTO `concept_numeric` VALUES (45,NULL,NULL,37,0,NULL,33,'g/dL',1,NULL),(46,NULL,NULL,20,0,NULL,10,'%',1,NULL),(47,50,NULL,10,0,NULL,1,'%',0,NULL),(48,100,NULL,51.9,0,21,32.3,'%',1,NULL),(49,NULL,NULL,17.8,0,7,10.4,'g/dL',1,NULL),(50,NULL,NULL,34,0,NULL,26,'pg',1,NULL),(51,NULL,NULL,100,0,NULL,80,'fL',0,NULL),(52,NULL,NULL,11,0,1.4,4,'10^3/uL',1,NULL),(53,NULL,NULL,419,0,49,134,'10^3/mL',0,NULL),(54,100,NULL,NULL,0,NULL,NULL,'%',0,NULL),(55,100,NULL,NULL,0,NULL,NULL,'%',0,NULL),(56,NULL,NULL,6.1,0,2.3,4,'10^6/uL',1,NULL),(72,NULL,NULL,NULL,0,NULL,NULL,'umol/L',0,NULL),(73,NULL,NULL,5.17,0,NULL,NULL,'mmol/L',1,NULL),(74,NULL,NULL,2.26,0,NULL,NULL,'mmol/L',1,NULL),(75,NULL,NULL,2.59,0,NULL,NULL,'mmol/L',1,NULL),(76,NULL,NULL,NULL,0,NULL,NULL,'mmol/L',0,NULL),(77,NULL,NULL,NULL,0,NULL,0.91,'mmol/L',1,NULL),(80,NULL,NULL,NULL,0,NULL,NULL,'umol/L',1,NULL),(81,200,NULL,40,10,NULL,20,'mg/dl',0,NULL),(82,NULL,NULL,NULL,0,NULL,NULL,'mmol/L',1,NULL),(83,NULL,NULL,NULL,0,NULL,NULL,'mg/ml',0,NULL);
/*!40000 ALTER TABLE `concept_numeric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal`
--

DROP TABLE IF EXISTS `concept_proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal` (
  `concept_proposal_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `original_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `final_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `obs_concept_id` int(11) DEFAULT NULL,
  `state` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNMAPPED',
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `locale` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_proposal_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_for_proposal` (`concept_id`),
  KEY `encounter_for_proposal` (`encounter_id`),
  KEY `proposal_obs_concept_id` (`obs_concept_id`),
  KEY `proposal_obs_id` (`obs_id`),
  KEY `user_who_changed_proposal` (`changed_by`),
  KEY `user_who_created_proposal` (`creator`),
  CONSTRAINT `concept_for_proposal` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_for_proposal` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `proposal_obs_concept_id` FOREIGN KEY (`obs_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `proposal_obs_id` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_proposal` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_proposal` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal`
--

LOCK TABLES `concept_proposal` WRITE;
/*!40000 ALTER TABLE `concept_proposal` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal_tag_map`
--

DROP TABLE IF EXISTS `concept_proposal_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal_tag_map` (
  `concept_proposal_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_proposal` (`concept_proposal_id`),
  KEY `mapped_concept_proposal_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_proposal` FOREIGN KEY (`concept_proposal_id`) REFERENCES `concept_proposal` (`concept_proposal_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_proposal_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal_tag_map`
--

LOCK TABLES `concept_proposal_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_proposal_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_map`
--

DROP TABLE IF EXISTS `concept_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_map` (
  `concept_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_reference_term_id` int(11) NOT NULL,
  `concept_map_type_id` int(11) NOT NULL DEFAULT '1',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `map_creator` (`creator`),
  KEY `map_for_concept` (`concept_id`),
  KEY `mapped_concept_map_type` (`concept_map_type_id`),
  KEY `mapped_concept_reference_term` (`concept_reference_term_id`),
  KEY `mapped_user_changed_ref_term` (`changed_by`),
  CONSTRAINT `map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `map_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_map_type` FOREIGN KEY (`concept_map_type_id`) REFERENCES `concept_map_type` (`concept_map_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_reference_term` FOREIGN KEY (`concept_reference_term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_changed_ref_term` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_map`
--

LOCK TABLES `concept_reference_map` WRITE;
/*!40000 ALTER TABLE `concept_reference_map` DISABLE KEYS */;
INSERT INTO `concept_reference_map` VALUES (188,187,1,1,'2010-10-01 21:26:09',45,NULL,NULL,'133817ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(189,188,2,1,'2011-01-22 22:22:31',45,NULL,NULL,'138105ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(190,189,1,1,'2013-07-03 22:53:08',45,NULL,NULL,'171280ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(191,190,1,1,'2010-10-24 17:09:59',45,NULL,NULL,'134690ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(192,191,1,1,'2013-10-01 20:20:32',45,NULL,NULL,'274431ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(193,192,1,1,'2013-10-01 20:20:32',46,NULL,NULL,'274430ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(194,193,1,1,'2010-10-24 17:09:59',46,NULL,NULL,'134689ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(195,194,2,1,'2011-01-22 22:21:09',46,NULL,NULL,'138104ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(196,195,1,1,'2010-10-01 21:25:03',46,NULL,NULL,'133816ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(197,196,1,1,'2013-07-03 22:53:08',46,NULL,NULL,'171279ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(198,197,2,1,'2016-06-30 06:34:52',47,NULL,NULL,'279980ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(199,198,1,1,'2016-06-16 00:36:02',47,NULL,NULL,'279823ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(200,199,1,1,'2010-10-24 17:09:59',48,NULL,NULL,'134688ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(201,200,1,1,'2013-10-01 20:20:32',48,NULL,NULL,'274428ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(202,201,1,1,'2013-07-03 22:53:08',48,NULL,NULL,'171278ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(203,202,1,1,'2010-10-01 21:24:01',48,NULL,NULL,'133815ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(204,203,1,1,'2013-10-01 20:20:32',48,NULL,NULL,'274429ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(205,204,2,1,'2011-01-22 22:20:09',48,NULL,NULL,'138103ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(206,205,1,1,'2013-10-01 20:20:32',49,NULL,NULL,'274359ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(207,206,2,1,'2010-09-01 20:06:16',49,NULL,NULL,'132963ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(208,207,1,1,'2012-07-05 02:50:16',49,NULL,NULL,'144886ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(209,208,1,1,'2010-10-24 17:09:59',49,NULL,NULL,'133887ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(210,209,1,1,'2010-10-24 17:09:59',49,NULL,NULL,'134153ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(211,210,1,1,'2010-10-24 17:09:59',49,NULL,NULL,'134363ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(212,211,1,1,'2012-12-27 01:36:46',49,NULL,NULL,'146575ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(213,212,2,1,'2011-01-22 22:10:39',49,NULL,NULL,'138096ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(214,213,1,1,'2013-07-03 22:53:08',49,NULL,NULL,'170976ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(215,214,1,1,'2013-10-01 20:20:32',50,NULL,NULL,'274432ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(216,215,1,1,'2010-10-24 17:09:59',50,NULL,NULL,'134691ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(217,216,1,1,'2010-10-01 21:27:04',50,NULL,NULL,'133818ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(218,217,2,1,'2011-01-22 22:27:22',50,NULL,NULL,'138106ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(219,218,1,1,'2013-07-03 22:53:08',50,NULL,NULL,'171281ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(220,219,1,1,'2013-07-03 22:53:08',51,NULL,NULL,'171194ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(221,220,1,1,'2010-10-24 17:09:59',51,NULL,NULL,'134532ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(222,221,2,1,'2011-01-22 22:17:12',51,NULL,NULL,'138100ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(223,222,1,1,'2013-10-01 20:20:32',51,NULL,NULL,'274402ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(224,223,1,1,'2010-09-30 23:23:42',51,NULL,NULL,'133769ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(225,224,1,1,'2013-07-03 22:53:08',52,NULL,NULL,'171141ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(226,225,1,1,'2010-09-30 19:05:49',52,NULL,NULL,'133731ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(227,226,1,1,'2010-10-24 17:09:59',52,NULL,NULL,'134387ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(228,227,2,1,'2011-01-22 22:12:55',52,NULL,NULL,'138097ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(229,228,1,1,'2010-10-24 17:09:59',52,NULL,NULL,'134389ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(230,229,1,1,'2010-10-24 17:09:59',52,NULL,NULL,'134364ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(231,230,1,1,'2013-10-01 20:20:32',52,NULL,NULL,'274387ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(232,231,1,1,'2010-10-24 17:09:59',52,NULL,NULL,'134386ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(233,232,1,1,'2013-10-01 20:20:32',53,NULL,NULL,'274390ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(234,233,1,1,'2011-09-24 17:46:54',53,NULL,NULL,'144097ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(235,234,1,1,'2013-10-01 20:20:32',53,NULL,NULL,'274391ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(236,235,1,1,'2010-09-30 21:46:38',53,NULL,NULL,'133750ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(237,236,2,1,'2011-01-22 22:16:13',53,NULL,NULL,'138099ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(238,237,1,1,'2010-10-24 17:09:59',53,NULL,NULL,'134366ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(239,238,1,1,'2013-07-03 22:53:08',53,NULL,NULL,'171162ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(240,239,1,1,'2010-10-24 17:09:59',53,NULL,NULL,'134428ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(241,240,1,1,'2010-09-20 21:27:10',54,NULL,NULL,'133349ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(242,241,1,1,'2013-10-01 20:20:32',54,NULL,NULL,'274468ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(243,242,1,1,'2010-08-23 19:49:10',54,NULL,NULL,'132709ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(244,243,1,1,'2010-10-24 17:09:59',54,NULL,NULL,'135009ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(245,244,1,1,'2013-07-03 22:53:08',54,NULL,NULL,'171588ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(246,245,1,1,'2010-10-24 17:09:59',55,NULL,NULL,'135011ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(247,246,1,1,'2013-10-01 20:20:32',55,NULL,NULL,'274470ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(248,247,1,1,'2010-12-25 18:44:37',55,NULL,NULL,'137395ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(249,248,1,1,'2013-07-03 22:53:08',55,NULL,NULL,'171590ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(250,249,1,1,'2010-10-24 17:09:59',56,NULL,NULL,'134388ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(251,250,2,1,'2011-01-22 22:14:28',56,NULL,NULL,'138098ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(252,251,1,1,'2010-10-24 17:09:59',56,NULL,NULL,'134390ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(253,252,1,1,'2013-10-01 20:20:32',56,NULL,NULL,'274388ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(254,253,1,1,'2010-10-24 17:09:59',56,NULL,NULL,'134391ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(255,254,1,1,'2013-07-03 22:53:08',56,NULL,NULL,'171142ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(256,255,1,1,'2010-09-30 19:13:44',56,NULL,NULL,'133732ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(257,256,1,1,'2010-10-24 17:09:59',57,NULL,NULL,'134362ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(258,257,1,1,'2013-07-03 22:53:08',57,NULL,NULL,'171282ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(259,258,2,1,'2016-06-20 05:28:42',57,NULL,NULL,'279894ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(260,259,1,1,'2010-10-24 17:09:59',57,NULL,NULL,'134692ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(261,260,1,1,'2010-10-01 21:28:18',57,NULL,NULL,'133819ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(262,261,1,1,'2013-07-03 22:53:08',58,NULL,NULL,'171135ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(263,262,1,1,'2010-10-24 17:09:59',58,NULL,NULL,'134375ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(264,263,1,1,'2010-09-30 18:37:19',58,NULL,NULL,'133725ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(265,264,1,1,'2011-05-17 20:43:33',58,NULL,NULL,'143587ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(266,265,1,1,'2011-01-17 19:30:25',58,NULL,NULL,'137847ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(267,266,1,1,'2010-10-24 17:09:59',58,NULL,NULL,'134376ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(268,267,1,1,'2010-09-20 21:27:10',59,NULL,NULL,'133196ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(269,268,1,1,'2010-10-24 17:09:59',59,NULL,NULL,'134409ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(270,269,1,1,'2010-10-24 17:09:59',59,NULL,NULL,'134410ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(271,270,1,1,'2010-09-21 01:35:38',59,NULL,NULL,'133595ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(272,271,1,1,'2013-07-03 22:53:08',59,NULL,NULL,'171151ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(273,272,1,1,'2011-06-01 20:30:00',59,NULL,NULL,'143726ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(274,273,1,1,'2011-10-26 17:53:12',60,NULL,NULL,'144112ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(275,274,1,1,'2013-07-03 22:53:08',60,NULL,NULL,'217365ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(276,275,1,1,'2010-09-30 19:23:21',61,NULL,NULL,'133736ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(277,276,1,1,'2013-07-03 22:53:08',61,NULL,NULL,'171146ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(278,277,1,1,'2010-10-24 17:09:59',61,NULL,NULL,'134399ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(279,278,1,1,'2010-10-24 17:09:59',61,NULL,NULL,'134400ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(280,279,1,1,'2010-10-24 17:09:59',62,NULL,NULL,'134398ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(281,280,1,1,'2013-07-03 22:53:08',62,NULL,NULL,'171145ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(282,281,1,1,'2010-10-24 17:09:59',62,NULL,NULL,'134397ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(283,282,1,1,'2010-09-30 19:22:05',62,NULL,NULL,'133735ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(284,283,1,1,'2013-07-03 22:53:08',63,NULL,NULL,'171490ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(285,284,1,1,'2010-10-24 17:09:59',63,NULL,NULL,'134905ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(286,285,1,1,'2010-12-23 21:23:31',63,NULL,NULL,'137353ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(287,286,1,1,'2013-07-03 22:53:08',64,NULL,NULL,'171149ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(288,287,1,1,'2010-10-24 17:09:59',64,NULL,NULL,'134405ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(289,288,1,1,'2010-09-30 19:26:28',64,NULL,NULL,'133739ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(290,289,1,1,'2010-10-24 17:09:59',64,NULL,NULL,'134406ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(291,290,1,1,'2013-07-03 22:53:08',65,NULL,NULL,'171147ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(292,291,1,1,'2010-10-24 17:09:59',65,NULL,NULL,'134402ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(293,292,1,1,'2010-10-24 17:09:59',65,NULL,NULL,'134401ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(294,293,1,1,'2010-09-30 19:24:43',65,NULL,NULL,'133737ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(295,294,1,1,'2010-10-24 17:09:59',66,NULL,NULL,'134904ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(296,295,1,1,'2010-12-23 21:22:19',66,NULL,NULL,'137352ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(297,296,1,1,'2013-07-03 22:53:08',66,NULL,NULL,'171489ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(298,297,1,1,'2010-10-24 17:09:59',67,NULL,NULL,'134407ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(299,298,1,1,'2010-09-30 19:27:24',67,NULL,NULL,'133740ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(300,299,1,1,'2010-10-24 17:09:59',67,NULL,NULL,'134408ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(301,300,1,1,'2013-07-03 22:53:08',67,NULL,NULL,'171150ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(302,301,1,1,'2010-09-30 19:25:34',68,NULL,NULL,'133738ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(303,302,1,1,'2010-10-24 17:09:59',68,NULL,NULL,'134404ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(304,303,1,1,'2013-07-03 22:53:08',68,NULL,NULL,'171148ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(305,304,1,1,'2010-10-24 17:09:59',68,NULL,NULL,'134403ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(306,305,1,1,'2013-01-17 20:38:33',69,NULL,NULL,'146800ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(307,306,1,1,'2013-07-03 22:53:08',69,NULL,NULL,'171052ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(308,307,1,1,'2010-10-24 17:09:59',69,NULL,NULL,'134152ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(309,308,1,1,'2010-09-28 17:56:57',69,NULL,NULL,'133670ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(310,309,1,1,'2013-10-01 20:20:32',69,NULL,NULL,'274367ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(311,310,1,1,'2013-07-03 22:53:08',70,NULL,NULL,'218584ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(312,311,1,1,'2013-01-12 20:56:10',70,NULL,NULL,'146730ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(313,308,1,1,'2012-12-28 23:34:21',70,NULL,NULL,'146614ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(314,312,1,1,'2013-07-03 22:53:08',72,NULL,NULL,'171133ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(315,313,1,1,'2010-10-24 17:09:59',72,NULL,NULL,'134370ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(316,314,1,1,'2010-09-30 18:31:52',72,NULL,NULL,'133724ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(317,315,1,1,'2013-10-01 20:20:32',72,NULL,NULL,'274386ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(318,316,1,1,'2013-10-01 20:20:32',72,NULL,NULL,'274385ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(319,317,2,1,'2011-01-22 20:47:57',72,NULL,NULL,'138074ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(320,318,2,1,'2011-01-22 20:53:27',73,NULL,NULL,'138080ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(321,319,1,1,'2013-10-01 20:20:32',73,NULL,NULL,'274417ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(322,320,1,1,'2010-10-24 17:09:59',73,NULL,NULL,'134679ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(323,321,1,1,'2012-09-20 17:48:20',73,NULL,NULL,'145624ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(324,322,1,1,'2010-10-01 20:08:34',73,NULL,NULL,'133806ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(325,323,1,1,'2013-10-01 20:20:32',73,NULL,NULL,'274416ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(326,324,1,1,'2013-07-03 22:53:08',73,NULL,NULL,'171269ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(327,325,1,1,'2013-07-03 22:53:08',74,NULL,NULL,'171272ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(328,326,1,1,'2013-10-01 20:20:32',74,NULL,NULL,'274420ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(329,327,2,1,'2011-01-22 20:55:47',74,NULL,NULL,'138083ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(330,328,1,1,'2010-10-24 17:09:59',74,NULL,NULL,'134682ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(331,329,1,1,'2010-10-01 20:21:54',74,NULL,NULL,'133809ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(332,330,1,1,'2010-10-24 17:09:59',75,NULL,NULL,'134681ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(333,331,1,1,'2010-10-01 20:13:17',75,NULL,NULL,'133808ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(334,332,2,1,'2011-01-22 20:55:00',75,NULL,NULL,'138082ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(335,333,1,1,'2013-07-03 22:53:08',75,NULL,NULL,'171271ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(336,334,1,1,'2013-10-01 20:20:32',75,NULL,NULL,'274419ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(337,335,1,1,'2010-10-24 17:09:59',76,NULL,NULL,'134973ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(338,336,1,1,'2010-12-23 23:32:29',76,NULL,NULL,'137371ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(339,337,2,1,'2011-01-22 22:00:04',76,NULL,NULL,'138093ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(340,338,1,1,'2013-10-01 20:20:32',76,NULL,NULL,'274455ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(341,339,1,1,'2013-07-03 22:53:08',76,NULL,NULL,'171550ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(342,340,1,1,'2010-10-01 20:12:14',77,NULL,NULL,'133807ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(343,341,1,1,'2013-07-03 22:53:08',77,NULL,NULL,'171270ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(344,342,1,1,'2013-10-01 20:20:32',77,NULL,NULL,'274418ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(345,343,1,1,'2010-10-24 17:09:59',77,NULL,NULL,'134680ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(346,344,2,1,'2011-01-22 20:54:16',77,NULL,NULL,'138081ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(347,345,1,1,'2013-07-03 22:53:08',78,NULL,NULL,'171273ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(348,346,1,1,'2010-10-01 20:23:00',78,NULL,NULL,'133810ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(349,347,1,1,'2013-01-15 19:55:54',78,NULL,NULL,'146757ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(350,348,1,1,'2010-10-24 17:09:59',78,NULL,NULL,'134683ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(351,349,1,1,'2013-01-18 02:33:21',79,NULL,NULL,'146814ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(352,350,1,1,'2013-07-03 22:53:08',79,NULL,NULL,'218556ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(353,351,2,1,'2012-12-27 20:55:09',79,NULL,NULL,'146590ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(354,352,2,1,'2010-09-01 19:58:38',80,NULL,NULL,'132961ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(355,353,2,1,'2011-01-22 20:49:58',80,NULL,NULL,'138076ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(356,354,1,1,'2013-07-03 22:53:08',80,NULL,NULL,'171175ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(357,355,1,1,'2010-10-24 17:09:59',80,NULL,NULL,'134482ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(358,356,1,1,'2016-07-29 05:38:46',81,NULL,NULL,'280369ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(359,357,1,1,'2010-09-20 21:27:10',82,NULL,NULL,'133321ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(360,358,1,1,'2010-10-24 17:09:59',82,NULL,NULL,'134538ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(361,359,2,1,'2011-01-22 20:51:46',82,NULL,NULL,'138078ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(362,360,1,1,'2010-09-01 19:53:32',82,NULL,NULL,'132960ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(363,361,1,1,'2013-07-03 22:53:08',82,NULL,NULL,'171200ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(364,362,1,1,'2013-10-01 20:20:32',82,NULL,NULL,'274409ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(365,363,1,1,'2013-07-03 22:53:08',83,NULL,NULL,'171213ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(366,364,1,1,'2013-10-01 20:20:32',83,NULL,NULL,'274412ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(367,365,1,1,'2013-10-01 20:20:32',83,NULL,NULL,'274413ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(368,366,1,1,'2010-10-24 17:09:59',83,NULL,NULL,'133875ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(369,367,2,1,'2011-01-22 20:52:36',83,NULL,NULL,'138079ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(370,368,1,1,'2010-10-24 17:09:59',83,NULL,NULL,'134564ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(371,369,1,1,'2010-09-01 20:01:46',83,NULL,NULL,'132962ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(372,370,2,1,'2012-12-30 07:50:58',84,NULL,NULL,'146625ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(373,371,1,1,'2013-07-03 22:53:08',84,NULL,NULL,'218599ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),(374,372,1,1,'2013-01-13 23:48:43',84,NULL,NULL,'146741ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
/*!40000 ALTER TABLE `concept_reference_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_source`
--

DROP TABLE IF EXISTS `concept_reference_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_source` (
  `concept_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `hl7_code` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `unique_id` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `hl7_code` (`hl7_code`),
  UNIQUE KEY `unique_id` (`unique_id`),
  KEY `concept_reference_source_changed_by` (`changed_by`),
  KEY `concept_source_creator` (`creator`),
  KEY `user_who_retired_concept_source` (`retired_by`),
  CONSTRAINT `concept_reference_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_concept_source` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_source`
--

LOCK TABLES `concept_reference_source` WRITE;
/*!40000 ALTER TABLE `concept_reference_source` DISABLE KEYS */;
INSERT INTO `concept_reference_source` VALUES (10,'SNOMED CT','SNOMED Preferred mapping','SCT',1,'2009-11-20 01:19:16',0,NULL,NULL,NULL,'2b3c054a-768a-102f-83f4-12313b04a615',NULL,NULL,NULL),(11,'LOINC','LOINC code',NULL,1,'2010-04-25 15:14:13',0,NULL,NULL,NULL,'2b3c1ff8-768a-102f-83f4-12313b04a615',NULL,NULL,NULL),(12,'CIEL','Columbia International eHealth Laboratory concept ID',NULL,1,'2013-07-03 19:55:03',0,NULL,NULL,NULL,'249b13c8-72fa-4b96-8d3d-b200efed985e',NULL,NULL,NULL),(13,'AMPATH','AMPATH concept dictionary',NULL,1,'2010-10-24 21:02:38',0,NULL,NULL,NULL,'2b3c28ae-768a-102f-83f4-12313b04a615',NULL,NULL,NULL),(14,'IMO ProcedureIT','Intelligent Medical Objects, Inc. procedure/test datasource',NULL,1,'2013-10-01 17:34:40',0,NULL,NULL,NULL,'912025e5-edb1-4774-8a0c-59febe5600e4',NULL,NULL,NULL),(15,'SNOMED NP','Non-preferred SNOMED CT mappings',NULL,1,'2010-04-25 15:12:44',0,NULL,NULL,NULL,'2b3c09b4-768a-102f-83f4-12313b04a615',NULL,NULL,NULL),(16,'PIH Malawi','Partners in Health Malawi concept dictionary',NULL,1,'2010-10-24 21:02:20',0,NULL,NULL,NULL,'2b3c2778-768a-102f-83f4-12313b04a615',NULL,NULL,NULL),(17,'PIH','Equivalent concept ID in Master Partners-in-Health Concept dictionary',NULL,1,'2010-08-03 05:50:49',0,NULL,NULL,NULL,'fb9aaaf1-65e2-4c18-b53c-16b575f2f385',NULL,NULL,NULL),(18,'org.openmrs.module.mdrtb','The required concepts for the MDR-TB module',NULL,1,'2010-12-15 19:00:37',0,NULL,NULL,NULL,'ddb6b595-0b85-4a80-9243-efe4ba404eef',NULL,NULL,NULL);
/*!40000 ALTER TABLE `concept_reference_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_term`
--

DROP TABLE IF EXISTS `concept_reference_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_term` (
  `concept_reference_term_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_source_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_reference_term_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `idx_code_concept_reference_term` (`code`),
  KEY `mapped_concept_source` (`concept_source_id`),
  KEY `mapped_user_changed` (`changed_by`),
  KEY `mapped_user_creator` (`creator`),
  KEY `mapped_user_retired` (`retired_by`),
  CONSTRAINT `mapped_concept_source` FOREIGN KEY (`concept_source_id`) REFERENCES `concept_reference_source` (`concept_source_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_retired` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_term`
--

LOCK TABLES `concept_reference_term` WRITE;
/*!40000 ALTER TABLE `concept_reference_term` DISABLE KEYS */;
INSERT INTO `concept_reference_term` VALUES (187,10,NULL,'37254006',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'1de0f122-ac29-37b7-bad2-5e7f0e0ae0ef'),(188,11,NULL,'28540-3',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'fc3fa2ab-5e77-34cd-920f-b3cf4e891f0c'),(189,12,NULL,'1017',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'ad84e9a2-d169-373c-817a-8ca04feb0e52'),(190,13,NULL,'1017',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'f4181f1c-524d-352c-9437-442efc87e671'),(191,14,NULL,'1068576',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b1860fc6-9de3-3f27-a4a0-7ae69834bf61'),(192,14,NULL,'30929593',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'478d4a75-8fa9-313d-93b2-c3ffa620590a'),(193,13,NULL,'1016',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'0779fc92-5311-31ea-91ba-a273a44b0ac1'),(194,11,NULL,'30384-2',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'03978a1f-39e6-3cef-83ba-d21b9c8c7b5d'),(195,10,NULL,'66842004',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b17fda33-56df-30a0-b921-031ec3afb391'),(196,12,NULL,'1016',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'2bd72fd9-bee8-32c7-bd20-3d99dafcf097'),(197,15,NULL,'252305002',NULL,NULL,1,'2016-06-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'3ad6a87c-0d34-349f-817c-a1b45dd42c45'),(198,12,NULL,'163426',NULL,NULL,1,'2016-06-15 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'6d9f8b79-6604-3077-9046-f7ba1697a397'),(199,13,NULL,'1015',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b08479d1-e4aa-33c5-b844-024bc24d764b'),(200,14,NULL,'2464',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'365d93c7-435e-31ba-86e1-689b257fc9d9'),(201,12,NULL,'1015',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'ecee4613-55bb-37b0-b95f-c7a547d32649'),(202,10,NULL,'365616005',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b661c3ee-7927-3d51-91e3-ef3af4862934'),(203,14,NULL,'935674',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'f99e5b7d-cc07-3ffa-bf37-37b82b37d1a6'),(204,11,NULL,'20570-8',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'5828219b-a6b2-34e5-b6d0-6c9d6bfe16d5'),(205,14,NULL,'930136',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'eac15b53-533d-33f4-a99a-b059d67f50f8'),(206,15,NULL,'38082009',NULL,NULL,1,'2010-09-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'4431b53b-23d0-33bc-93f7-b6c88b669ebd'),(207,16,NULL,'7982',NULL,NULL,1,'2012-07-04 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'827d0afa-3dbc-3e61-81eb-865473c66784'),(208,13,NULL,'21',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'71e8df43-2289-383a-8d82-fed8523e0528'),(209,13,NULL,'301',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'97e7a542-c5d8-3831-9bc6-62beb02aac5e'),(210,13,NULL,'648',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'bed571c7-4bd0-31c9-aebc-6adc17b0bb36'),(211,10,NULL,'441689006',NULL,NULL,1,'2012-12-26 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'76f95225-f93b-3e25-893b-aea644d34c6d'),(212,11,NULL,'718-7',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'cd65ee1c-ea3a-35c0-988d-522c0bfc33e7'),(213,12,NULL,'21',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'357aa507-a1a9-3b8d-b747-09322e9c7f4d'),(214,14,NULL,'1074253',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'4caa369d-c8fd-36ec-9b91-04f78bf0fd9a'),(215,13,NULL,'1018',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'f3dd33cf-26ee-35f6-abff-5d64506d43c7'),(216,10,NULL,'54706004',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'19b675b5-ffa7-3aa4-9c7b-4a85bee6ecdb'),(217,11,NULL,'28539-5',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'eac141df-7455-34bc-acd1-98660406935f'),(218,12,NULL,'1018',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'277c280c-8722-3ece-835a-7e99e122d636'),(219,12,NULL,'851',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'98973517-8464-3fb9-9646-77932551d1c7'),(220,13,NULL,'851',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'5f881a8d-eebd-330f-a08c-5d17bba16cd2'),(221,11,NULL,'787-2',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'30859640-d704-35b7-9e09-daf546f53df2'),(222,14,NULL,'30929612',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'6c8b54af-1e74-3f12-b737-cacb5c52b483'),(223,10,NULL,'104133003',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'7df967c2-7c66-3cd7-af7c-abc736e8b745'),(224,12,NULL,'678',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'d512c7ac-151d-3582-8844-99c7ef83d8df'),(225,10,NULL,'391558003',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'577b508d-678d-3d65-9ec1-02dcbb96d112'),(226,13,NULL,'678',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'62552302-6c0e-3db7-a880-aaaaa1f33c22'),(227,11,NULL,'53225-9',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'957a10b2-9e69-3561-83eb-60aebbf90b13'),(228,13,NULL,'680',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'e14eccf2-9342-3a02-9102-64a24240716f'),(229,13,NULL,'649',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'fab351bc-40f0-3e11-b5f2-b1cb2f203b34'),(230,14,NULL,'923338',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b7847746-b015-3101-afba-f4bfb0586771'),(231,13,NULL,'676',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'a3d858d8-c686-31b9-a9b8-a9014b831bf5'),(232,14,NULL,'687330',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'36523093-341f-3e07-a333-cab333293361'),(233,17,NULL,'729',NULL,NULL,1,'2010-08-31 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'c450f464-0a69-34c1-b8c2-c3154235fe21'),(234,14,NULL,'6348',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'d2c19102-db63-3d69-b85b-7d35e31b8ac3'),(235,10,NULL,'61928009',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'62b83842-c7eb-3ced-8a92-774ff028454f'),(236,11,NULL,'26515-7',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'d7a7740f-604d-3090-a68c-78b5aee55286'),(237,13,NULL,'651',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'8b858349-31a2-362a-b696-8388daf41c8d'),(238,12,NULL,'729',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'773b4345-0e96-39ad-ba0a-8c741f571c33'),(239,13,NULL,'729',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'fe472e82-44b9-3b51-8093-6d1b1883c62f'),(240,17,NULL,'3060',NULL,NULL,1,'2010-09-20 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'0eb1dee8-fd70-3c44-a847-c2b0039b889d'),(241,14,NULL,'1060713',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'3def5280-5549-3b01-a43d-23b4345626e2'),(242,10,NULL,'30630007',NULL,NULL,1,'2010-08-23 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'40ad804a-86b5-3391-b82d-fcc69470cd30'),(243,13,NULL,'1336',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'d4a79f9a-0636-3470-bb22-4e662eada99a'),(244,12,NULL,'1336',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'c239c50c-fe2c-3e2f-be0e-d7d6b5e38004'),(245,13,NULL,'1338',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'f9406139-5b43-3617-a3fc-f74f5c2b779c'),(246,14,NULL,'1064629',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'c49656b8-df62-3478-8fbf-cf9dafeebf53'),(247,10,NULL,'271036002',NULL,NULL,1,'2010-12-25 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'916443f8-4208-3cde-a30e-7eed74c12a78'),(248,12,NULL,'1338',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'25ba6ffa-4d8a-3b8d-b345-3ca1a0be119c'),(249,13,NULL,'679',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'603610ed-b7e1-3a12-9467-23555b0412a1'),(250,11,NULL,'23859-2',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'2d48b572-b94a-304c-895d-4c64b97ed5e4'),(251,13,NULL,'681',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'2de09885-6c45-3b74-bb64-a7735da265a2'),(252,14,NULL,'923240',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'6cce87af-b8fa-34f4-9e8c-1359d8bb51ee'),(253,13,NULL,'682',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'aa0019ab-7ff5-3586-88e5-42ca532c3043'),(254,12,NULL,'679',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'1efa9ad1-40bb-39a7-b85f-4564f3b2b75d'),(255,10,NULL,'14089001',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'9d0299b7-19df-3541-a4ce-af5df16555f3'),(256,13,NULL,'647',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'abfd31fb-ef57-3a7f-ab05-e9e84604c0c6'),(257,12,NULL,'1019',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'049e682c-8727-3e41-91f4-93077f5ba928'),(258,11,NULL,'58410-2',NULL,NULL,1,'2016-06-20 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'fcc5416f-7e41-3b78-b2e3-f4c78ab1050e'),(259,13,NULL,'1019',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'4f7bfa97-556e-3703-b696-52b5944aeb50'),(260,10,NULL,'26604007',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'09bdde86-5bf6-3f82-b9bc-4f7388f66d24'),(261,12,NULL,'664',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'4ed9f7ac-ae89-34a3-a15d-f7563f9af7b9'),(262,13,NULL,'664',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'60a6399e-3b1b-35f7-ba68-6ee53827d969'),(263,10,NULL,'260385009',NULL,NULL,1,'2010-09-29 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'2e2c14de-f88c-396b-a102-b955eeb4159b'),(264,17,NULL,'664',NULL,NULL,1,'2011-05-17 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'2676fd8d-8614-36de-8cc0-0864af2eb7e2'),(265,18,NULL,'NEGATIVE',NULL,NULL,1,'2011-01-17 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'371705d3-874b-3578-a1a5-49abf402cca9'),(266,13,NULL,'665',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'468974d1-05ed-3ff2-9db9-7f5b3a8d35fa'),(267,17,NULL,'703',NULL,NULL,1,'2010-09-20 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'ca183449-7a70-339f-81dd-d4b72cd9d068'),(268,13,NULL,'703',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'f7ea97d1-9888-3da7-8dfd-68950adb3ffe'),(269,13,NULL,'704',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b44821a5-8cbf-3ce7-a253-e02b3103d7b4'),(270,10,NULL,'10828004',NULL,NULL,1,'2010-09-20 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'1163db8c-017c-35a8-bcde-00fe8c42fb3c'),(271,12,NULL,'703',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'d6cf4393-8bc2-3fa9-8aef-5e966df06586'),(272,18,NULL,'POSITIVE',NULL,NULL,1,'2011-06-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'3f33d629-595b-3d6e-b0b7-5b3113629265'),(273,10,NULL,'165745004',NULL,NULL,1,'2011-10-26 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'da8f7d93-af97-36cf-872e-985ecf2cd6eb'),(274,12,NULL,'160232',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'65be4d2a-61b4-387d-9fa6-d41a850780fc'),(275,10,NULL,'278152006',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'a124587c-9960-3f86-abaa-bbac9e42f0cf'),(276,12,NULL,'692',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b1efc43d-6131-3c7a-8ff7-c1286f1fca95'),(277,13,NULL,'691',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'07c0f029-d7e7-3c44-80d2-1d2033c8910b'),(278,13,NULL,'692',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'79f35f2e-0543-34f4-b92d-3d7bda8fb946'),(279,13,NULL,'690',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'3fbefdcb-6057-3c17-80fa-9092f23a00e1'),(280,12,NULL,'690',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'3ba91f69-5c91-3c10-9434-61f0eb27f74a'),(281,13,NULL,'688',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'0ebd91c7-eaa4-3d38-b7a8-deafb2dc2e77'),(282,10,NULL,'278149003',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'d2662e63-3ab5-30b1-96d8-ce0714573cd5'),(283,12,NULL,'1231',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'ce6781d5-179c-34af-9403-579b1536b43a'),(284,13,NULL,'1231',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'3507a6be-ac5c-36c5-ace3-503837a6d5f8'),(285,10,NULL,'278154007',NULL,NULL,1,'2010-12-23 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'1fe266d8-7866-3630-85b4-90fd84b27032'),(286,12,NULL,'699',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'4f66c4fb-ff23-3910-95dd-1e9c20fca864'),(287,13,NULL,'698',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'ba5fdb93-c1f6-3fd4-a804-6cb42b95aafd'),(288,10,NULL,'278147001',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'7b57f940-26d2-3b6c-9efe-621a90fbe574'),(289,13,NULL,'699',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'9960291b-8c0b-3871-ae85-3dd4b93e9d31'),(290,12,NULL,'694',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'bd7aed3b-2502-37e2-b2d5-2b25ab07fc25'),(291,13,NULL,'694',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'add4c160-0d77-3002-95db-35198c94cc99'),(292,13,NULL,'693',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'e4dfd153-72d5-386a-bb55-a213f0637887'),(293,10,NULL,'278150003',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'a56086ec-8718-312a-8ee4-f06fe9fc2714'),(294,13,NULL,'1230',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'a0dd1066-ab5a-3d4b-9a23-65f088789d61'),(295,10,NULL,'278151004',NULL,NULL,1,'2010-12-23 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'27dfc433-f2a7-3c87-9850-8945cb90cc9e'),(296,12,NULL,'1230',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'e42cc5f3-ef2b-31b6-892a-0ee087b1ce88'),(297,13,NULL,'700',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'234819ae-3ffb-3810-b462-2af74abc82d9'),(298,10,NULL,'278148006',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'871cebd2-730a-3a52-a41d-7923b2ae4aac'),(299,13,NULL,'701',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'3ad024b9-ac76-32d4-8d74-811e55ddf675'),(300,12,NULL,'701',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'ce98766d-7396-3b7d-9edb-e0afac50f4fd'),(301,10,NULL,'278153001',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'c0e80881-be0b-354c-aa1c-3f07f12d6ca6'),(302,13,NULL,'696',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'3330def4-ae26-33ed-94e8-ef4aff49e16a'),(303,12,NULL,'696',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'bbae724a-df8f-3af0-99a7-ab12db79b4e8'),(304,13,NULL,'695',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'32ba7395-96b6-3997-8e51-d3dca824b48c'),(305,11,NULL,'882-1',NULL,NULL,1,'2013-01-17 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'381461cd-786a-341a-9a60-5fdb36c910fc'),(306,12,NULL,'300',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b115d1ee-5318-3aeb-9796-d8a4625e16ba'),(307,13,NULL,'300',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'e6e51d1a-ba59-3ee6-8f31-5476e091e917'),(308,10,NULL,'44608003',NULL,NULL,1,'2010-09-28 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'e9ad45a6-aa6b-37fd-95a4-47d6cd890998'),(309,14,NULL,'869',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'18f827da-1a64-3d22-a5c6-d64d95af9fb7'),(310,12,NULL,'161473',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'7bf7a9a8-9112-325a-b632-39948e669c3d'),(311,11,NULL,'34530-6',NULL,NULL,1,'2013-01-12 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'421bd953-b837-3d05-8e8e-96cc30e9806f'),(312,12,NULL,'655',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'52b72ff4-804a-3e6d-abd4-080d21c27f10'),(313,13,NULL,'655',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'fe6f07c3-102e-3d01-bbfb-0c183beef181'),(314,10,NULL,'359986008',NULL,NULL,1,'2010-09-30 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'84053e83-f26c-3447-b7c7-6cd4e207e3ce'),(315,14,NULL,'27823581',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'2cbed242-902a-3ce2-bbf0-4edde0554835'),(316,14,NULL,'1738262',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'1e62de83-d5d2-3210-9382-2668cc81cdde'),(317,11,NULL,'14631-6',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'cfe97ad4-1f46-3511-9a93-0efba4e99eb4'),(318,11,NULL,'14647-2',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'edfc29c2-89d2-3ba8-8492-023ef121b70a'),(319,14,NULL,'923300',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'5dc697df-989e-3762-93c2-8c118ff32def'),(320,13,NULL,'1006',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'5ff6be37-e287-314e-ba61-3076f4386131'),(321,10,NULL,'121868005',NULL,NULL,1,'2012-09-20 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'c2e9d1d5-9aa5-3754-ac06-809d201c0831'),(322,10,NULL,'412808005',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'4cc4a1c9-5e77-301d-a040-3375bdded2d5'),(323,14,NULL,'829736',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'9790bc6d-deb5-3635-afa5-405cb188a6a1'),(324,12,NULL,'1006',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'42c93eeb-0475-3e49-8e24-15411f0acd35'),(325,12,NULL,'1009',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'09cdd6b2-3916-3d9d-89c8-433e4b07b48d'),(326,14,NULL,'30953289',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'2b97352e-9324-3835-912e-c5bc9a5de9a2'),(327,11,NULL,'14927-8',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'2f02dc72-97cb-3662-998a-b666a8408c83'),(328,13,NULL,'1009',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'bcb445f3-42e8-336e-9f62-de38d36348a7'),(329,10,NULL,'14740000',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'95f6f29f-48e0-327b-be75-100b6a07ccaf'),(330,13,NULL,'1008',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'4957e91d-8fe4-3415-9487-6676d55deb0f'),(331,10,NULL,'113079009',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'167fe0e2-38ba-373e-ba14-3337badbf994'),(332,11,NULL,'22748-8',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'a8bd4577-343e-3656-8469-df64e013fb4d'),(333,12,NULL,'1008',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'f904e05c-df9a-30df-8cb2-6fefe83cfa37'),(334,14,NULL,'29962510',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'235aa930-96b8-3c70-b0f4-f99b8f45df27'),(335,13,NULL,'1298',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'ee06d8fe-74b7-3178-be61-8d0056f9f9ab'),(336,10,NULL,'56516007',NULL,NULL,1,'2010-12-23 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'6d7c9458-1edd-31cc-8de4-d63d360f53a3'),(337,11,NULL,'25371-6',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'7084829f-1e96-37d2-a2b3-6329d5b9fdc2'),(338,14,NULL,'923333',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'0538b0ac-37f3-3108-9c40-e2f0d39c1106'),(339,12,NULL,'1298',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'4b9ca677-f6b2-3c13-b65d-22d70c19d7ae'),(340,10,NULL,'166832000',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'0c5459b5-2845-3c63-b8f8-6bad1baefdf8'),(341,12,NULL,'1007',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'97ca8366-aeb2-35a8-8422-f2c2a1eff06c'),(342,14,NULL,'687121',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b3eecee7-f640-376e-9de6-66fe9e1c5471'),(343,13,NULL,'1007',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'3dc318f0-c7c5-33b8-900e-10a698f86c04'),(344,11,NULL,'14646-4',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'c850044b-0b22-38dd-8870-5276db2badf0'),(345,12,NULL,'1010',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'ee911473-5e3d-3972-9728-98e7c05dddb1'),(346,10,NULL,'16254007',NULL,NULL,1,'2010-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'d2b0a6d7-6178-39db-8544-da84b1eb5973'),(347,11,NULL,'24331-1',NULL,NULL,1,'2013-01-15 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'a6382039-a25e-317c-8c87-892c28b3172f'),(348,13,NULL,'1010',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'08479a18-604a-3e96-8e20-a62e8c05d82b'),(349,11,NULL,'11279-7',NULL,NULL,1,'2013-01-17 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'1e7b7ce3-ba0d-3feb-9d8c-9dd236a35c4e'),(350,12,NULL,'161445',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'264c85bd-ede9-3849-978d-e55a92eb983d'),(351,15,NULL,'127800008',NULL,NULL,1,'2012-12-27 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'561353bb-f601-3e95-8e50-fa623a40b832'),(352,15,NULL,'113075003',NULL,NULL,1,'2010-09-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'ef0c1e8e-d8e6-3a85-919b-56c7b902f709'),(353,11,NULL,'14682-9',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'435360e8-f47b-36c3-bf59-002e301b70dd'),(354,12,NULL,'790',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'18395079-b94a-3a16-9318-e7bd1c646148'),(355,13,NULL,'790',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'4ad49ec8-2da5-30b9-b99f-4b246ec8219a'),(356,12,NULL,'163699',NULL,NULL,1,'2016-07-29 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'8861c67a-6096-321c-9c7b-e859a4ec3fef'),(357,17,NULL,'2555',NULL,NULL,1,'2010-09-20 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'005c51b5-a2dc-315b-b1a5-17faae4acd37'),(358,13,NULL,'857',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'491687f8-050a-379a-96ae-e8ea038a037e'),(359,11,NULL,'14937-7',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'d3e4aca7-ee8c-3c29-ba39-60bae59a41ab'),(360,10,NULL,'72341003',NULL,NULL,1,'2010-09-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'8ba89a31-ea63-3603-b114-81d67f0722d4'),(361,12,NULL,'857',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'5237f96d-492a-3194-b9e6-6a723beacf69'),(362,14,NULL,'923501',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'6889edca-ee74-3e15-8f33-49fc81880050'),(363,12,NULL,'887',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b9122128-43af-397a-bf74-46ea8100a3e1'),(364,14,NULL,'602403',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'fda4e03c-eaef-3cf4-b7d1-52008dc01a5c'),(365,14,NULL,'932390',NULL,NULL,1,'2013-10-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'29cc1c59-c75a-3bbd-8a2d-731075dc179f'),(366,13,NULL,'9',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'b5bee009-5072-3aa3-bece-adb468eae192'),(367,11,NULL,'14749-6',NULL,NULL,1,'2011-01-22 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'710bcf09-9d47-3dde-8686-2a958fb0567e'),(368,13,NULL,'887',NULL,NULL,1,'2010-10-24 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'060098ed-8631-30e8-ba5b-03030fe94cc7'),(369,10,NULL,'22569008',NULL,NULL,1,'2010-09-01 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'1a2ebd2d-7e78-3a7d-af50-d0a99413722b'),(370,15,NULL,'44277000',NULL,NULL,1,'2012-12-30 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'4dd5f03a-e85d-310b-a0ee-2ccaf42951df'),(371,12,NULL,'161488',NULL,NULL,1,'2013-07-03 04:00:00',NULL,NULL,0,NULL,NULL,NULL,'e9e507b8-41d1-373f-b0a7-5c831547141a'),(372,11,NULL,'24362-6',NULL,NULL,1,'2013-01-13 05:00:00',NULL,NULL,0,NULL,NULL,NULL,'b1066355-16a8-3984-94d2-1399946d0826');
/*!40000 ALTER TABLE `concept_reference_term` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_term_map`
--

DROP TABLE IF EXISTS `concept_reference_term_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_term_map` (
  `concept_reference_term_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `term_a_id` int(11) NOT NULL,
  `term_b_id` int(11) NOT NULL,
  `a_is_to_b_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_reference_term_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_concept_map_type_ref_term_map` (`a_is_to_b_id`),
  KEY `mapped_term_a` (`term_a_id`),
  KEY `mapped_term_b` (`term_b_id`),
  KEY `mapped_user_changed_ref_term_map` (`changed_by`),
  KEY `mapped_user_creator_ref_term_map` (`creator`),
  CONSTRAINT `mapped_concept_map_type_ref_term_map` FOREIGN KEY (`a_is_to_b_id`) REFERENCES `concept_map_type` (`concept_map_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_term_a` FOREIGN KEY (`term_a_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_term_b` FOREIGN KEY (`term_b_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_changed_ref_term_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_creator_ref_term_map` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_term_map`
--

LOCK TABLES `concept_reference_term_map` WRITE;
/*!40000 ALTER TABLE `concept_reference_term_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_term_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_set`
--

DROP TABLE IF EXISTS `concept_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_set` (
  `concept_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `concept_set` int(11) NOT NULL DEFAULT '0',
  `sort_weight` double DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `has_a` (`concept_set`),
  KEY `idx_concept_set_concept` (`concept_id`),
  KEY `user_who_created` (`creator`),
  CONSTRAINT `has_a` FOREIGN KEY (`concept_set`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_set`
--

LOCK TABLES `concept_set` WRITE;
/*!40000 ALTER TABLE `concept_set` DISABLE KEYS */;
INSERT INTO `concept_set` VALUES (33,45,57,2,1,'2005-12-15 18:26:49','118AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(34,46,57,7,1,'2005-12-15 18:26:49','117AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(35,47,57,11,1,'2016-06-19 20:38:20','2124AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(36,48,57,0,1,'2005-12-15 18:26:49','116AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(37,49,57,1,1,'2005-12-15 18:26:49','1AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(38,50,57,3,1,'2005-12-15 18:26:49','119AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(39,51,57,4,1,'2005-12-15 18:26:49','100AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(40,52,57,8,1,'2005-12-15 18:26:49','70AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(41,53,57,5,1,'2005-12-15 18:26:49','72AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(42,54,57,9,1,'2016-06-19 20:38:20','2122AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(43,55,57,10,1,'2016-06-19 20:38:20','2123AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(44,56,57,6,1,'2005-12-15 18:26:49','71AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(45,60,70,1,1,'2012-12-28 23:34:21','1019AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(46,69,70,0,1,'2012-12-28 23:34:21','1020AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(47,57,71,0,1,'2018-07-20 16:37:07','1b296054-7eda-408c-ae73-fa6bfa873737'),(48,70,71,1,1,'2018-07-20 16:37:07','91e3d73c-86fe-4588-b46c-37577fbf4929'),(49,74,78,4,1,'2012-12-31 20:30:00','1099AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(50,75,78,2,1,'2012-12-31 20:30:00','1097AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(51,76,78,3,1,'2012-12-31 20:30:00','1098AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(52,77,78,1,1,'2012-12-31 20:30:00','1096AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(53,73,78,0,1,'2012-12-31 20:30:00','1095AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(54,79,84,2,1,'2012-12-30 07:50:58','1070AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(55,80,84,1,1,'2012-12-30 07:50:58','1069AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(56,81,84,4,1,'2016-07-29 06:08:13','2252AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(57,82,84,0,1,'2012-12-30 07:50:58','1068AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(58,83,84,3,1,'2016-07-28 17:27:46','2190AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),(59,72,85,3,1,'2018-07-20 16:55:59','cc3da266-9be5-42a5-8bd6-8e1b8b51360e'),(60,73,85,2,1,'2018-07-20 16:35:59','9060a786-c4e2-4f2c-bab8-d9d6ea236674'),(61,78,85,0,1,'2018-07-20 16:35:00','a305fe05-8df3-49f7-b736-481ac6e551fa'),(62,84,85,1,1,'2018-07-20 16:35:00','3cf139a9-9edc-4d35-8be6-ab07fabe6f57'),(63,71,86,0,1,'2018-07-20 16:38:57','b3acee35-153b-4b83-a5a6-7ab3bab81602'),(64,85,86,1,1,'2018-07-20 16:38:57','a85b0286-933b-4173-a115-83c0b6ced07c');
/*!40000 ALTER TABLE `concept_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_state_conversion`
--

DROP TABLE IF EXISTS `concept_state_conversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_state_conversion` (
  `concept_state_conversion_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT '0',
  `program_workflow_id` int(11) DEFAULT '0',
  `program_workflow_state_id` int(11) DEFAULT '0',
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_state_conversion_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_workflow_concept_in_conversion` (`program_workflow_id`,`concept_id`),
  KEY `concept_triggers_conversion` (`concept_id`),
  KEY `conversion_to_state` (`program_workflow_state_id`),
  CONSTRAINT `concept_triggers_conversion` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `conversion_involves_workflow` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `conversion_to_state` FOREIGN KEY (`program_workflow_state_id`) REFERENCES `program_workflow_state` (`program_workflow_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_state_conversion`
--

LOCK TABLES `concept_state_conversion` WRITE;
/*!40000 ALTER TABLE `concept_state_conversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_state_conversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_stop_word`
--

DROP TABLE IF EXISTS `concept_stop_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_stop_word` (
  `concept_stop_word_id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`concept_stop_word_id`),
  UNIQUE KEY `Unique_StopWord_Key` (`word`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_stop_word`
--

LOCK TABLES `concept_stop_word` WRITE;
/*!40000 ALTER TABLE `concept_stop_word` DISABLE KEYS */;
INSERT INTO `concept_stop_word` VALUES (1,'A','en','f5f45540-e2a7-11df-87ae-18a905e044dc'),(2,'AND','en','f5f469ae-e2a7-11df-87ae-18a905e044dc'),(3,'AT','en','f5f47070-e2a7-11df-87ae-18a905e044dc'),(4,'BUT','en','f5f476c4-e2a7-11df-87ae-18a905e044dc'),(5,'BY','en','f5f47d04-e2a7-11df-87ae-18a905e044dc'),(6,'FOR','en','f5f4834e-e2a7-11df-87ae-18a905e044dc'),(7,'HAS','en','f5f48a24-e2a7-11df-87ae-18a905e044dc'),(8,'OF','en','f5f49064-e2a7-11df-87ae-18a905e044dc'),(9,'THE','en','f5f496ae-e2a7-11df-87ae-18a905e044dc'),(10,'TO','en','f5f49cda-e2a7-11df-87ae-18a905e044dc');
/*!40000 ALTER TABLE `concept_stop_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `condition_id` int(11) NOT NULL AUTO_INCREMENT,
  `additional_detail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `previous_version` int(11) DEFAULT NULL,
  `condition_coded` int(11) DEFAULT NULL,
  `condition_non_coded` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `condition_coded_name` int(11) DEFAULT NULL,
  `clinical_status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `verification_status` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `onset_date` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` varchar(38) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `form_namespace_and_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`condition_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `condition_changed_by_fk` (`changed_by`),
  KEY `condition_condition_coded_fk` (`condition_coded`),
  KEY `condition_condition_coded_name_fk` (`condition_coded_name`),
  KEY `condition_creator_fk` (`creator`),
  KEY `condition_patient_fk` (`patient_id`),
  KEY `condition_previous_version_fk` (`previous_version`),
  KEY `condition_voided_by_fk` (`voided_by`),
  KEY `conditions_encounter_id_fk` (`encounter_id`),
  CONSTRAINT `condition_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_condition_coded_fk` FOREIGN KEY (`condition_coded`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_condition_coded_name_fk` FOREIGN KEY (`condition_coded_name`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_previous_version_fk` FOREIGN KEY (`previous_version`) REFERENCES `conditions` (`condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `conditions_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug`
--

DROP TABLE IF EXISTS `drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `combination` tinyint(1) NOT NULL DEFAULT '0',
  `dosage_form` int(11) DEFAULT NULL,
  `maximum_daily_dose` double DEFAULT NULL,
  `minimum_daily_dose` double DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `strength` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dose_limit_units` int(11) DEFAULT NULL,
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `dosage_form_concept` (`dosage_form`),
  KEY `drug_changed_by` (`changed_by`),
  KEY `drug_creator` (`creator`),
  KEY `drug_dose_limit_units_fk` (`dose_limit_units`),
  KEY `drug_retired_by` (`retired_by`),
  KEY `primary_drug_concept` (`concept_id`),
  KEY `route_concept` (`route`),
  CONSTRAINT `dosage_form_concept` FOREIGN KEY (`dosage_form`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_dose_limit_units_fk` FOREIGN KEY (`dose_limit_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `primary_drug_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `route_concept` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug`
--

LOCK TABLES `drug` WRITE;
/*!40000 ALTER TABLE `drug` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_ingredient`
--

DROP TABLE IF EXISTS `drug_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_ingredient` (
  `drug_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `strength` double DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  PRIMARY KEY (`drug_id`,`ingredient_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `drug_ingredient_ingredient_id_fk` (`ingredient_id`),
  KEY `drug_ingredient_units_fk` (`units`),
  CONSTRAINT `drug_ingredient_drug_id_fk` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_ingredient_ingredient_id_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_ingredient_units_fk` FOREIGN KEY (`units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_ingredient`
--

LOCK TABLES `drug_ingredient` WRITE;
/*!40000 ALTER TABLE `drug_ingredient` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_order`
--

DROP TABLE IF EXISTS `drug_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `drug_inventory_id` int(11) DEFAULT NULL,
  `dose` double DEFAULT NULL,
  `as_needed` tinyint(1) DEFAULT NULL,
  `dosing_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `as_needed_condition` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_refills` int(11) DEFAULT NULL,
  `dosing_instructions` text COLLATE utf8_unicode_ci,
  `duration` int(11) DEFAULT NULL,
  `duration_units` int(11) DEFAULT NULL,
  `quantity_units` int(11) DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `dose_units` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `brand_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dispense_as_written` tinyint(1) NOT NULL DEFAULT '0',
  `drug_non_coded` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `drug_order_dose_units` (`dose_units`),
  KEY `drug_order_duration_units_fk` (`duration_units`),
  KEY `drug_order_frequency_fk` (`frequency`),
  KEY `drug_order_quantity_units` (`quantity_units`),
  KEY `drug_order_route_fk` (`route`),
  KEY `inventory_item` (`drug_inventory_id`),
  CONSTRAINT `drug_order_dose_units` FOREIGN KEY (`dose_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_duration_units_fk` FOREIGN KEY (`duration_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_frequency_fk` FOREIGN KEY (`frequency`) REFERENCES `order_frequency` (`order_frequency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_quantity_units` FOREIGN KEY (`quantity_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_route_fk` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `extends_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `inventory_item` FOREIGN KEY (`drug_inventory_id`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_order`
--

LOCK TABLES `drug_order` WRITE;
/*!40000 ALTER TABLE `drug_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_reference_map`
--

DROP TABLE IF EXISTS `drug_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_reference_map` (
  `drug_reference_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `drug_id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL,
  `concept_map_type` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`drug_reference_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_map_type_for_drug_reference_map` (`concept_map_type`),
  KEY `concept_reference_term_for_drug_reference_map` (`term_id`),
  KEY `drug_for_drug_reference_map` (`drug_id`),
  KEY `drug_reference_map_creator` (`creator`),
  KEY `user_who_changed_drug_reference_map` (`changed_by`),
  KEY `user_who_retired_drug_reference_map` (`retired_by`),
  CONSTRAINT `concept_map_type_for_drug_reference_map` FOREIGN KEY (`concept_map_type`) REFERENCES `concept_map_type` (`concept_map_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_reference_term_for_drug_reference_map` FOREIGN KEY (`term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_for_drug_reference_map` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_reference_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_drug_reference_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_drug_reference_map` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_reference_map`
--

LOCK TABLES `drug_reference_map` WRITE;
/*!40000 ALTER TABLE `drug_reference_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_reference_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter` (
  `encounter_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_type` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT NULL,
  `form_id` int(11) DEFAULT NULL,
  `encounter_datetime` datetime NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_changed_by` (`changed_by`),
  KEY `encounter_datetime_idx` (`encounter_datetime`),
  KEY `encounter_form` (`form_id`),
  KEY `encounter_ibfk_1` (`creator`),
  KEY `encounter_location` (`location_id`),
  KEY `encounter_patient` (`patient_id`),
  KEY `encounter_type_id` (`encounter_type`),
  KEY `encounter_visit_id_fk` (`visit_id`),
  KEY `user_who_voided_encounter` (`voided_by`),
  CONSTRAINT `encounter_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_form` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `encounter_type_id` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_visit_id_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_encounter` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_diagnosis`
--

DROP TABLE IF EXISTS `encounter_diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_diagnosis` (
  `diagnosis_id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_coded` int(11) DEFAULT NULL,
  `diagnosis_non_coded` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `diagnosis_coded_name` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `condition_id` int(11) DEFAULT NULL,
  `certainty` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rank` int(11) NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`diagnosis_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_diagnosis_changed_by_fk` (`changed_by`),
  KEY `encounter_diagnosis_coded_fk` (`diagnosis_coded`),
  KEY `encounter_diagnosis_coded_name_fk` (`diagnosis_coded_name`),
  KEY `encounter_diagnosis_condition_id_fk` (`condition_id`),
  KEY `encounter_diagnosis_creator_fk` (`creator`),
  KEY `encounter_diagnosis_encounter_id_fk` (`encounter_id`),
  KEY `encounter_diagnosis_patient_fk` (`patient_id`),
  KEY `encounter_diagnosis_voided_by_fk` (`voided_by`),
  CONSTRAINT `encounter_diagnosis_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_coded_fk` FOREIGN KEY (`diagnosis_coded`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_coded_name_fk` FOREIGN KEY (`diagnosis_coded_name`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_condition_id_fk` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_diagnosis`
--

LOCK TABLES `encounter_diagnosis` WRITE;
/*!40000 ALTER TABLE `encounter_diagnosis` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_provider`
--

DROP TABLE IF EXISTS `encounter_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_provider` (
  `encounter_provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `encounter_role_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`encounter_provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_id_fk` (`encounter_id`),
  KEY `encounter_provider_changed_by` (`changed_by`),
  KEY `encounter_provider_creator` (`creator`),
  KEY `encounter_provider_voided_by` (`voided_by`),
  KEY `encounter_role_id_fk` (`encounter_role_id`),
  KEY `provider_id_fk` (`provider_id`),
  CONSTRAINT `encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_provider_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_provider_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_provider_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_role_id_fk` FOREIGN KEY (`encounter_role_id`) REFERENCES `encounter_role` (`encounter_role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_id_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_provider`
--

LOCK TABLES `encounter_provider` WRITE;
/*!40000 ALTER TABLE `encounter_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_role`
--

DROP TABLE IF EXISTS `encounter_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_role` (
  `encounter_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`encounter_role_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_role_changed_by_fk` (`changed_by`),
  KEY `encounter_role_creator_fk` (`creator`),
  KEY `encounter_role_retired_by_fk` (`retired_by`),
  CONSTRAINT `encounter_role_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_role_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_role_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_role`
--

LOCK TABLES `encounter_role` WRITE;
/*!40000 ALTER TABLE `encounter_role` DISABLE KEYS */;
INSERT INTO `encounter_role` VALUES (1,'Unknown','Unknown encounter role for legacy providers with no encounter role set',1,'2011-08-18 14:00:00',NULL,NULL,0,NULL,NULL,NULL,'a0b03050-c99b-11e0-9572-0800200c9a66');
/*!40000 ALTER TABLE `encounter_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_type`
--

DROP TABLE IF EXISTS `encounter_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_type` (
  `encounter_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `edit_privilege` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `view_privilege` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_type_changed_by` (`changed_by`),
  KEY `encounter_type_retired_status` (`retired`),
  KEY `privilege_which_can_edit_encounter_type` (`edit_privilege`),
  KEY `privilege_which_can_view_encounter_type` (`view_privilege`),
  KEY `user_who_created_type` (`creator`),
  KEY `user_who_retired_encounter_type` (`retired_by`),
  CONSTRAINT `encounter_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privilege_which_can_edit_encounter_type` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privilege_which_can_view_encounter_type` FOREIGN KEY (`view_privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_encounter_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_type`
--

LOCK TABLES `encounter_type` WRITE;
/*!40000 ALTER TABLE `encounter_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_concept_source`
--

DROP TABLE IF EXISTS `fhir_concept_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_concept_source` (
  `fhir_concept_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_source_id` int(11) DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` varchar(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`fhir_concept_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_concept_source_concept_reference_source_fk` (`concept_source_id`),
  KEY `fhir_concept_source_creator_fk` (`creator`),
  KEY `fhir_concept_source_changed_by_fk` (`changed_by`),
  KEY `fhir_concept_source_retired_by_fk` (`retired_by`),
  CONSTRAINT `fhir_concept_source_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_concept_source_concept_reference_source_fk` FOREIGN KEY (`concept_source_id`) REFERENCES `concept_reference_source` (`concept_source_id`),
  CONSTRAINT `fhir_concept_source_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_concept_source_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_concept_source`
--

LOCK TABLES `fhir_concept_source` WRITE;
/*!40000 ALTER TABLE `fhir_concept_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_concept_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_diagnostic_report`
--

DROP TABLE IF EXISTS `fhir_diagnostic_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_diagnostic_report` (
  `diagnostic_report_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`diagnostic_report_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_diagnostic_report_creator` (`creator`),
  KEY `fhir_diagnostic_report_changed_by` (`changed_by`),
  KEY `fhir_diagnostic_report_voided_by` (`voided_by`),
  KEY `fhir_diagnostic_report_code` (`concept_id`),
  KEY `fhir_diagnostic_report_subject` (`subject_id`),
  KEY `fhir_diagnostic_report_encounter` (`encounter_id`),
  CONSTRAINT `fhir_diagnostic_report_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_diagnostic_report_code` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `fhir_diagnostic_report_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_diagnostic_report_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `fhir_diagnostic_report_subject` FOREIGN KEY (`subject_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fhir_diagnostic_report_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_diagnostic_report`
--

LOCK TABLES `fhir_diagnostic_report` WRITE;
/*!40000 ALTER TABLE `fhir_diagnostic_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_diagnostic_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_diagnostic_report_performers`
--

DROP TABLE IF EXISTS `fhir_diagnostic_report_performers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_diagnostic_report_performers` (
  `diagnostic_report_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  PRIMARY KEY (`diagnostic_report_id`,`provider_id`),
  KEY `fhir_diagnostic_report_performers_reference` (`provider_id`),
  CONSTRAINT `fhir_diagnostic_report_performers_diagnostic_report` FOREIGN KEY (`diagnostic_report_id`) REFERENCES `fhir_diagnostic_report` (`diagnostic_report_id`),
  CONSTRAINT `fhir_diagnostic_report_performers_reference` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_diagnostic_report_performers`
--

LOCK TABLES `fhir_diagnostic_report_performers` WRITE;
/*!40000 ALTER TABLE `fhir_diagnostic_report_performers` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_diagnostic_report_performers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_diagnostic_report_results`
--

DROP TABLE IF EXISTS `fhir_diagnostic_report_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_diagnostic_report_results` (
  `diagnostic_report_id` int(11) NOT NULL,
  `obs_id` int(11) NOT NULL,
  PRIMARY KEY (`diagnostic_report_id`,`obs_id`),
  KEY `fhir_diagnostic_report_results_reference` (`obs_id`),
  CONSTRAINT `fhir_diagnostic_report_results_diagnostic_report` FOREIGN KEY (`diagnostic_report_id`) REFERENCES `fhir_diagnostic_report` (`diagnostic_report_id`),
  CONSTRAINT `fhir_diagnostic_report_results_reference` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_diagnostic_report_results`
--

LOCK TABLES `fhir_diagnostic_report_results` WRITE;
/*!40000 ALTER TABLE `fhir_diagnostic_report_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_diagnostic_report_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_encounter_class_map`
--

DROP TABLE IF EXISTS `fhir_encounter_class_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_encounter_class_map` (
  `encounter_class_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) DEFAULT NULL,
  `encounter_class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`encounter_class_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_encounter_class_map_creator` (`creator`),
  KEY `fhir_encounter_class_map_changed_by` (`changed_by`),
  KEY `fhir_encounter_class_map_retired_by` (`retired_by`),
  KEY `fhir_encounter_class_map_location` (`location_id`),
  CONSTRAINT `fhir_encounter_class_map_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_encounter_class_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_encounter_class_map_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `fhir_encounter_class_map_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_encounter_class_map`
--

LOCK TABLES `fhir_encounter_class_map` WRITE;
/*!40000 ALTER TABLE `fhir_encounter_class_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_encounter_class_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_observation_category_map`
--

DROP TABLE IF EXISTS `fhir_observation_category_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_observation_category_map` (
  `observation_category_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_class_id` int(11) DEFAULT NULL,
  `observation_category` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`observation_category_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_observation_category_map_creator` (`creator`),
  KEY `fhir_observation_category_map_changed_by` (`changed_by`),
  KEY `fhir_observation_category_map_retired_by` (`retired_by`),
  KEY `fhir_observation_category_map_concept_class` (`concept_class_id`),
  KEY `fhir_observation_category_map_observation_category` (`observation_category`),
  CONSTRAINT `fhir_observation_category_map_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_observation_category_map_concept_class` FOREIGN KEY (`concept_class_id`) REFERENCES `concept_class` (`concept_class_id`),
  CONSTRAINT `fhir_observation_category_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_observation_category_map_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_observation_category_map`
--

LOCK TABLES `fhir_observation_category_map` WRITE;
/*!40000 ALTER TABLE `fhir_observation_category_map` DISABLE KEYS */;
INSERT INTO `fhir_observation_category_map` VALUES (1,1,'laboratory',1,'2021-05-22 06:43:50',NULL,NULL,0,NULL,NULL,NULL,'112ea1a6-bac9-11eb-aee7-5254002e30a8'),(2,2,'procedure',1,'2021-05-22 06:43:50',NULL,NULL,0,NULL,NULL,NULL,'1130dd95-bac9-11eb-aee7-5254002e30a8'),(3,5,'exam',1,'2021-05-22 06:43:50',NULL,NULL,0,NULL,NULL,NULL,'1131349a-bac9-11eb-aee7-5254002e30a8');
/*!40000 ALTER TABLE `fhir_observation_category_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_reference`
--

DROP TABLE IF EXISTS `fhir_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_reference` (
  `reference_id` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `reference` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` varchar(38) COLLATE utf8_unicode_ci NOT NULL,
  `target_uuid` char(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`reference_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `target_uuid` (`target_uuid`),
  KEY `fhir_reference_creator_fk` (`creator`),
  KEY `fhir_reference_changed_by_fk` (`changed_by`),
  KEY `fhir_reference_retired_by_fk` (`retired_by`),
  CONSTRAINT `fhir_reference_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_reference_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_reference_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_reference`
--

LOCK TABLES `fhir_reference` WRITE;
/*!40000 ALTER TABLE `fhir_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_task`
--

DROP TABLE IF EXISTS `fhir_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `status_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `intent` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `owner_reference_id` int(11) DEFAULT NULL,
  `encounter_reference_id` int(11) DEFAULT NULL,
  `for_reference_id` int(11) DEFAULT NULL,
  `based_on` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `task_creator` (`creator`),
  KEY `task_changed_by` (`changed_by`),
  KEY `fhir_task_retired_by_fk` (`retired_by`),
  KEY `task_owner_reference_fk` (`owner_reference_id`),
  KEY `task_for_reference_fk` (`for_reference_id`),
  KEY `task_encounter_reference_fk` (`encounter_reference_id`),
  CONSTRAINT `fhir_task_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `task_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `task_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `task_encounter_reference_fk` FOREIGN KEY (`encounter_reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `task_for_reference_fk` FOREIGN KEY (`for_reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `task_owner_reference_fk` FOREIGN KEY (`owner_reference_id`) REFERENCES `fhir_reference` (`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_task`
--

LOCK TABLES `fhir_task` WRITE;
/*!40000 ALTER TABLE `fhir_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_task_based_on_reference`
--

DROP TABLE IF EXISTS `fhir_task_based_on_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_task_based_on_reference` (
  `task_id` int(11) NOT NULL,
  `reference_id` int(11) NOT NULL,
  UNIQUE KEY `reference_id` (`reference_id`),
  KEY `task_based_on_fk` (`task_id`),
  CONSTRAINT `reference_based_on_fk` FOREIGN KEY (`reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `task_based_on_fk` FOREIGN KEY (`task_id`) REFERENCES `fhir_task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_task_based_on_reference`
--

LOCK TABLES `fhir_task_based_on_reference` WRITE;
/*!40000 ALTER TABLE `fhir_task_based_on_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_task_based_on_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_task_input`
--

DROP TABLE IF EXISTS `fhir_task_input`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_task_input` (
  `task_input_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value_reference_id` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` varchar(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`task_input_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_task_input_creator_fk` (`creator`),
  KEY `fhir_task_input_changed_by_fk` (`changed_by`),
  KEY `fhir_task_input_retired_by_fk` (`retired_by`),
  KEY `input_type_fk` (`type_id`),
  KEY `input_reference_fk` (`value_reference_id`),
  KEY `input_task_fk` (`task_id`),
  CONSTRAINT `fhir_task_input_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_task_input_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_task_input_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `input_reference_fk` FOREIGN KEY (`value_reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `input_task_fk` FOREIGN KEY (`task_id`) REFERENCES `fhir_task` (`task_id`),
  CONSTRAINT `input_type_fk` FOREIGN KEY (`type_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_task_input`
--

LOCK TABLES `fhir_task_input` WRITE;
/*!40000 ALTER TABLE `fhir_task_input` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_task_input` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_task_output`
--

DROP TABLE IF EXISTS `fhir_task_output`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_task_output` (
  `task_output_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value_reference_id` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` varchar(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`task_output_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_task_output_creator_fk` (`creator`),
  KEY `fhir_task_output_changed_by_fk` (`changed_by`),
  KEY `fhir_task_output_retired_by_fk` (`retired_by`),
  KEY `output_type_fk` (`type_id`),
  KEY `output_reference_fk` (`value_reference_id`),
  KEY `output_task_fk` (`task_id`),
  CONSTRAINT `fhir_task_output_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_task_output_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_task_output_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `output_reference_fk` FOREIGN KEY (`value_reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `output_task_fk` FOREIGN KEY (`task_id`) REFERENCES `fhir_task` (`task_id`),
  CONSTRAINT `output_type_fk` FOREIGN KEY (`type_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_task_output`
--

LOCK TABLES `fhir_task_output` WRITE;
/*!40000 ALTER TABLE `fhir_task_output` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_task_output` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `field_type` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `table_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attribute_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_value` text COLLATE utf8_unicode_ci,
  `select_multiple` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_for_field` (`concept_id`),
  KEY `field_retired_status` (`retired`),
  KEY `type_of_field` (`field_type`),
  KEY `user_who_changed_field` (`changed_by`),
  KEY `user_who_created_field` (`creator`),
  KEY `user_who_retired_field` (`retired_by`),
  CONSTRAINT `concept_for_field` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type_of_field` FOREIGN KEY (`field_type`) REFERENCES `field_type` (`field_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_field` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_answer`
--

DROP TABLE IF EXISTS `field_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_answer` (
  `field_id` int(11) NOT NULL DEFAULT '0',
  `answer_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`field_id`,`answer_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `field_answer_concept` (`answer_id`),
  KEY `user_who_created_field_answer` (`creator`),
  CONSTRAINT `answers_for_field` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `field_answer_concept` FOREIGN KEY (`answer_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_field_answer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_answer`
--

LOCK TABLES `field_answer` WRITE;
/*!40000 ALTER TABLE `field_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_type`
--

DROP TABLE IF EXISTS `field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_type` (
  `field_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`field_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_who_created_field_type` (`creator`),
  CONSTRAINT `user_who_created_field_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_type`
--

LOCK TABLES `field_type` WRITE;
/*!40000 ALTER TABLE `field_type` DISABLE KEYS */;
INSERT INTO `field_type` VALUES (1,'Concept','',0,1,'2005-02-22 00:00:00','8d5e7d7c-c2cc-11de-8d13-0010c6dffd0f'),(2,'Database element','',0,1,'2005-02-22 00:00:00','8d5e8196-c2cc-11de-8d13-0010c6dffd0f'),(3,'Set of Concepts','',1,1,'2005-02-22 00:00:00','8d5e836c-c2cc-11de-8d13-0010c6dffd0f'),(4,'Miscellaneous Set','',1,1,'2005-02-22 00:00:00','8d5e852e-c2cc-11de-8d13-0010c6dffd0f'),(5,'Section','',1,1,'2005-02-22 00:00:00','8d5e86fa-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `field_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `version` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `build` int(11) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `xslt` text COLLATE utf8_unicode_ci,
  `template` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `encounter_type` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `form_encounter_type` (`encounter_type`),
  KEY `form_published_and_retired_index` (`published`,`retired`),
  KEY `form_published_index` (`published`),
  KEY `form_retired_index` (`retired`),
  KEY `user_who_created_form` (`creator`),
  KEY `user_who_last_changed_form` (`changed_by`),
  KEY `user_who_retired_form` (`retired_by`),
  CONSTRAINT `form_encounter_type` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_form` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_last_changed_form` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_form` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_field`
--

DROP TABLE IF EXISTS `form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_field` (
  `form_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT '0',
  `field_id` int(11) NOT NULL DEFAULT '0',
  `field_number` int(11) DEFAULT NULL,
  `field_part` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `parent_form_field` int(11) DEFAULT NULL,
  `min_occurs` int(11) DEFAULT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `sort_weight` float DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`form_field_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `field_within_form` (`field_id`),
  KEY `form_containing_field` (`form_id`),
  KEY `form_field_hierarchy` (`parent_form_field`),
  KEY `user_who_created_form_field` (`creator`),
  KEY `user_who_last_changed_form_field` (`changed_by`),
  CONSTRAINT `field_within_form` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `form_containing_field` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `form_field_hierarchy` FOREIGN KEY (`parent_form_field`) REFERENCES `form_field` (`form_field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_form_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_last_changed_form_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_field`
--

LOCK TABLES `form_field` WRITE;
/*!40000 ALTER TABLE `form_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_resource`
--

DROP TABLE IF EXISTS `form_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_resource` (
  `form_resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value_reference` text COLLATE utf8_unicode_ci NOT NULL,
  `datatype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype_config` text COLLATE utf8_unicode_ci,
  `preferred_handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler_config` text COLLATE utf8_unicode_ci,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`form_resource_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_form_and_name` (`form_id`,`name`),
  KEY `form_resource_changed_by` (`changed_by`),
  CONSTRAINT `form_resource_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `form_resource_form_fk` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_resource`
--

LOCK TABLES `form_resource` WRITE;
/*!40000 ALTER TABLE `form_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_property`
--

DROP TABLE IF EXISTS `global_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_property` (
  `property` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `property_value` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `datatype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype_config` text COLLATE utf8_unicode_ci,
  `preferred_handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler_config` text COLLATE utf8_unicode_ci,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`property`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `global_property_changed_by` (`changed_by`),
  CONSTRAINT `global_property_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_property`
--

LOCK TABLES `global_property` WRITE;
/*!40000 ALTER TABLE `global_property` DISABLE KEYS */;
INSERT INTO `global_property` VALUES ('allergy.allergen.ConceptClasses','Drug,MedSet','A comma-separated list of the allowed concept classes for the allergen field of the allergy dialog','94c031d3-f829-4fc0-b08b-644f25c3429d',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.allergen.drug','162552AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the drug allergens concept','6816e758-284f-4dae-9666-b03d276ffd20',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.allergen.environment','162554AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the environment allergens concept','e4b58d36-0528-4459-8e9d-aa2066996bfb',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.allergen.food','162553AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the food allergens concept','48e9a574-2a9e-4800-aef6-644782a242db',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.otherNonCoded','5622AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the allergy other non coded concept','13f3ddf1-5a46-4c4c-ade1-5e9347050732',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.reactions','162555AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the allergy reactions concept','f12fa38b-3582-4768-9a45-39ee2b8a3be7',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.severity.mild','1498AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the MILD severity concept','ab753e31-8b59-46e3-b956-43d433a31794',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.severity.moderate','1499AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the MODERATE severity concept','8624a1b2-2ba4-4bb2-86e5-d56d40549b95',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.severity.severe','1500AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the SEVERE severity concept','eb8df649-ced5-4f7b-9cd8-bf2baee3ac09',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.unknown','1067AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the allergy unknown concept','524bff86-1488-4419-8747-b8f4b59a7f49',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.reaction.ConceptClasses','Symptom','A comma-separated list of the allowed concept classes for the reaction field of the allergy dialog','fbca299f-8aa3-40f5-852c-92ee4b5d9e81',NULL,NULL,NULL,NULL,NULL,NULL),('application.name','OpenMRS','The name of this application, as presented to the user, for example on the login and welcome pages.','f5c396a4-6999-4435-be10-1e8e13860dd3',NULL,NULL,NULL,NULL,NULL,NULL),('concept_map_type_management.enable','false','Enables or disables management of concept map types','cba3bb97-e890-40c6-919b-9632513942ba','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('concept.defaultConceptMapType','NARROWER-THAN','Default concept map type which is used when no other is set','4dbd2b80-0047-4368-b8d1-525f84f1ca7c',NULL,NULL,NULL,NULL,NULL,NULL),('concept.height','5090','Concept id of the concept defining the HEIGHT concept','9e777648-2bc1-4802-8db1-c9e77ae0898a',NULL,NULL,NULL,NULL,NULL,NULL),('concept.medicalRecordObservations','1238','The concept id of the MEDICAL_RECORD_OBSERVATIONS concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','b3e5ef32-cd02-4c05-aba9-4988803f2160',NULL,NULL,NULL,NULL,NULL,NULL),('concept.none','1107','Concept id of the concept defining the NONE concept','d5aca38c-86af-4dd9-a520-8d593a435717',NULL,NULL,NULL,NULL,NULL,NULL),('concept.otherNonCoded','5622','Concept id of the concept defining the OTHER NON-CODED concept','b41c8967-d84a-46b0-ab34-be217dc10bcb',NULL,NULL,NULL,NULL,NULL,NULL),('concept.problemList','1284','The concept id of the PROBLEM LIST concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','5c6feb4b-ea2b-4479-bc75-a46f7ae7705a',NULL,NULL,NULL,NULL,NULL,NULL),('concept.weight','5089','Concept id of the concept defining the WEIGHT concept','6369ccab-a94c-485f-891d-ec94f43e49c6',NULL,NULL,NULL,NULL,NULL,NULL),('conceptDrug.dosageForm.conceptClasses',NULL,'A comma-separated list of the allowed concept classes for the dosage form field of the concept drug management form.','460022af-5e9d-4905-993c-be88947aa866',NULL,NULL,NULL,NULL,NULL,NULL),('conceptDrug.route.conceptClasses',NULL,'A comma-separated list of the allowed concept classes for the route field of the concept drug management form.','821b0f23-2a8a-478e-af20-63d1eaa03e68',NULL,NULL,NULL,NULL,NULL,NULL),('concepts.locked','false','if true, do not allow editing concepts','3d225265-4fdf-4c41-9cfb-167ff4de5101','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.maximumNumberToShow','3','An integer which, if specified, would determine the maximum number of encounters to display on the encounter tab of the patient dashboard.','0419cd8e-79f4-456b-a69b-936ab4cfc52d',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.providerDisplayRoles',NULL,'A comma-separated list of encounter roles (by name or id). Providers with these roles in an encounter will be displayed on the encounter tab of the patient dashboard.','9e27bdc2-9a3b-475f-8514-dd44d4807871',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.showEditLink','true','true/false whether or not to show the \'Edit Encounter\' link on the patient dashboard','06afb001-e1b2-4718-b910-00ecb78b5fa1','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.showEmptyFields','true','true/false whether or not to show empty fields on the \'View Encounter\' window','063fb8f1-7871-4d4f-9567-7b279d6708bc','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.showViewLink','true','true/false whether or not to show the \'View Encounter\' link on the patient dashboard','6f280880-5721-4bca-bbee-4537c59f520c','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.usePages','smart','true/false/smart on how to show the pages on the \'View Encounter\' window.  \'smart\' means that if > 50% of the fields have page numbers defined, show data in pages','4e56eb36-2265-4a61-8f27-9ad64cc0bd6e',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.header.programs_to_show',NULL,'List of programs to show Enrollment details of in the patient header. (Should be an ordered comma-separated list of program_ids or names.)','00075b51-e0ec-42fc-a4c8-e06e83592be3',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.header.showConcept','5497','Comma delimited list of concepts ids to show on the patient header overview','ad47b75d-8f64-4cc9-9498-6f19d81fad65',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.header.workflows_to_show',NULL,'List of programs to show Enrollment details of in the patient header. List of workflows to show current status of in the patient header. These will only be displayed if they belong to a program listed above. (Should be a comma-separated list of program_workflow_ids.)','a2cba294-3f4f-4790-a12e-82409ea733a2',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.metadata.caseConversion',NULL,'Indicates which type automatic case conversion is applied to program/workflow/state in the patient dashboard. Valid values: lowercase, uppercase, capitalize. If empty no conversion is applied.','bab55d3d-68fe-48da-859b-645616771811',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.overview.showConcepts',NULL,'Comma delimited list of concepts ids to show on the patient dashboard overview tab','a1724cda-5333-4a12-871b-a646a2ad589d',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.regimen.displayDrugSetIds','ANTIRETROVIRAL DRUGS,TUBERCULOSIS TREATMENT DRUGS','Drug sets that appear on the Patient Dashboard Regimen tab. Comma separated list of name of concepts that are defined as drug sets.','5c9ca52a-8064-4f72-8893-bd61c558248d',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.regimen.displayFrequencies','7 days/week,6 days/week,5 days/week,4 days/week,3 days/week,2 days/week,1 days/week','Frequency of a drug order that appear on the Patient Dashboard. Comma separated list of name of concepts that are defined as drug frequencies.','47749f27-9643-4f7e-8fe9-85e870339516',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.relationships.show_types',NULL,'Types of relationships separated by commas.  Doctor/Patient,Parent/Child','c49c7c36-0aa9-4eed-a2c7-a2708613fb07',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.showPatientName','false','Whether or not to display the patient name in the patient dashboard title. Note that enabling this could be security risk if multiple users operate on the same computer.','36625b30-2985-49a8-9c98-25a520cb0892','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('datePicker.weekStart','0','First day of the week in the date picker. Domingo/Dimanche/Sunday:0  Lunes/Lundi/Monday:1','43bf1bcf-3ef0-4e52-bac3-966341d10ccb',NULL,NULL,NULL,NULL,NULL,NULL),('default_locale','en_GB','Specifies the default locale. You can specify both the language code(ISO-639) and the country code(ISO-3166), e.g. \'en_GB\' or just country: e.g. \'en\'','83c062f2-8965-4e87-a080-fdee292c107d',NULL,NULL,NULL,NULL,NULL,NULL),('default_location','Unknown Location','The name of the location to use as a system default','21b60a03-c1c6-4e6c-aadd-efe70190f11d',NULL,NULL,NULL,NULL,NULL,NULL),('default_theme',NULL,'Default theme for users.  OpenMRS ships with themes of \'green\', \'orange\', \'purple\', and \'legacy\'','d18e3053-48c8-4e20-b020-a6f5c025d028',NULL,NULL,NULL,NULL,NULL,NULL),('drugOrder.drugOther',NULL,'Specifies the uuid of the concept which represents drug other non coded','2fd6f4b6-e223-44c5-b20a-ba2466d9b3d1',NULL,NULL,NULL,NULL,NULL,NULL),('drugOrder.requireDrug','false','Set to value true if you need to specify a formulation(Drug) when creating a drug order.','d6d9400a-07f0-4abf-92ad-8bbb927e7c47',NULL,NULL,NULL,NULL,NULL,NULL),('encounterForm.obsSortOrder','number','The sort order for the obs listed on the encounter edit form.  \'number\' sorts on the associated numbering from the form schema.  \'weight\' sorts on the order displayed in the form schema.','d9b4a11e-635b-4236-ad15-d2efab441f81',NULL,NULL,NULL,NULL,NULL,NULL),('EncounterType.encounterTypes.locked','false','saving, retiring or deleting an Encounter Type is not permitted, if true','9588b0cd-7fed-4773-b1d8-3a09f13c919d','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('fhir2.locationContactPointAttributeTypeUuid','abcde432-1691-11df-97a5-7038c432abcd','Set location attribute type uuid','bc20c257-49d0-4aae-8259-98ba7a398920',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.mandatory','false','true/false whether or not the fhir2 module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','bc7f2329-6775-4d75-9225-63948760e77c',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.narrativesOverridePropertyFile',NULL,'Path of narrative override properties file','5543506a-c559-4e94-aad6-6d0f12538e25',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.paging.default','10','Set default page size','43dfcc41-4ee6-495b-bdaf-8008fe081d88',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.paging.maximum','100','Set maximum page size','4b4dd698-4765-4cbd-b0f1-11c298b0ee32',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.personContactPointAttributeTypeUuid','14d4f066-15f5-102d-96e4-000c29c2a5d7','Set person attribute type uuid','bff06d6a-9201-495d-aa34-320aed850052',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.providerContactPointAttributeTypeUuid','5021b1a1-e7f6-44b4-ba02-da2f2bcf8718','Set provider attribute type uuid','1a5f179a-8787-4ab7-8e1a-ecb2fe5825e6',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.started','true','DO NOT MODIFY. true/false whether or not the fhir2 module has been started.  This is used to make sure modules that were running  prior to a restart are started again','80da8bdc-9452-4909-b324-c9b830530cad',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.uriPrefix',NULL,'Prefix for the FHIR server in case this cannot be automatically detected','c2d0b10b-19d3-4e1c-af6b-936bc0263ad3',NULL,NULL,NULL,NULL,NULL,NULL),('FormEntry.enableDashboardTab','true','true/false whether or not to show a Form Entry tab on the patient dashboard','eb242305-8182-4b71-b896-1d16bcf170a2','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('FormEntry.enableOnEncounterTab','false','true/false whether or not to show a Enter Form button on the encounters tab of the patient dashboard','47fe4508-8cdb-49b1-a8a0-8a887847dd30','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('forms.locked','false','Set to a value of true if you do not want any changes to be made on forms, else set to false.','0ddbc255-1420-403f-bb00-3bd04e380b31',NULL,NULL,NULL,NULL,NULL,NULL),('graph.color.absolute','rgb(20,20,20)','Color of the \'invalid\' section of numeric graphs on the patient dashboard.','b571246f-5e45-4287-9c9e-bb1433ba070a',NULL,NULL,NULL,NULL,NULL,NULL),('graph.color.critical','rgb(200,0,0)','Color of the \'critical\' section of numeric graphs on the patient dashboard.','dab47315-61bb-4a1c-8042-02dea467e7de',NULL,NULL,NULL,NULL,NULL,NULL),('graph.color.normal','rgb(255,126,0)','Color of the \'normal\' section of numeric graphs on the patient dashboard.','8016296c-5570-425b-a15c-6f432f474e60',NULL,NULL,NULL,NULL,NULL,NULL),('gzip.enabled','false','Set to \'true\' to turn on OpenMRS\'s gzip filter, and have the webapp compress data before sending it to any client that supports it. Generally use this if you are running Tomcat standalone. If you are running Tomcat behind Apache, then you\'d want to use Apache to do gzip compression.','02f6b512-c35c-4cfd-9931-7843d287f993','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('hl7_archive.dir','hl7_archives','The default name or absolute path for the folder where to write the hl7_in_archives.','9f8f47f8-4a56-4cb4-b361-edce5570ba4d',NULL,NULL,NULL,NULL,NULL,NULL),('hl7_processor.ignore_missing_patient_non_local','false','If true, hl7 messages for patients that are not found and are non-local will silently be dropped/ignored','23a99af1-8e57-4b8c-8201-fea24688a7ba','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('host.url',NULL,'The URL to redirect to after requesting for a password reset. Always provide a place holder in this url with name {activationKey}, it will get substituted by the actual activation key.','c70f1f52-4126-4d69-8b64-639ff2b659c1',NULL,NULL,NULL,NULL,NULL,NULL),('layout.address.format','<org.openmrs.layout.address.AddressTemplate>\n    <nameMappings class=\"properties\">\n      <property name=\"postalCode\" value=\"Location.postalCode\"/>\n      <property name=\"address2\" value=\"Location.address2\"/>\n      <property name=\"address1\" value=\"Location.address1\"/>\n      <property name=\"country\" value=\"Location.country\"/>\n      <property name=\"stateProvince\" value=\"Location.stateProvince\"/>\n      <property name=\"cityVillage\" value=\"Location.cityVillage\"/>\n    </nameMappings>\n    <sizeMappings class=\"properties\">\n      <property name=\"postalCode\" value=\"10\"/>\n      <property name=\"address2\" value=\"40\"/>\n      <property name=\"address1\" value=\"40\"/>\n      <property name=\"country\" value=\"10\"/>\n      <property name=\"stateProvince\" value=\"10\"/>\n      <property name=\"cityVillage\" value=\"10\"/>\n    </sizeMappings>\n    <lineByLineFormat>\n      <string>address1</string>\n      <string>address2</string>\n      <string>cityVillage stateProvince country postalCode</string>\n    </lineByLineFormat>\n   <requiredElements>\\n\" + \" </requiredElements>\\n\" + \" </org.openmrs.layout.address.AddressTemplate>','XML description of address formats','577a1d75-13f2-4fc6-8046-cfb845734bf0',NULL,NULL,NULL,NULL,NULL,NULL),('layout.name.format','short','Format in which to display the person names.  Valid values are short, long','1fd03b19-10df-4ab8-bf7e-62ecaf19adf5',NULL,NULL,NULL,NULL,NULL,NULL),('legacyui.mandatory','false','true/false whether or not the legacyui module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','3cf8943e-284d-4054-b1a6-641efdbbed5d',NULL,NULL,NULL,NULL,NULL,NULL),('legacyui.started','true','DO NOT MODIFY. true/false whether or not the legacyui module has been started.  This is used to make sure modules that were running  prior to a restart are started again','e5deb5e4-bc4a-4cb2-be03-34a420edfb2f',NULL,NULL,NULL,NULL,NULL,NULL),('locale.allowed.list','en, en_GB, es, fr, it, pt','Comma delimited list of locales allowed for use on system','73aad0e2-f430-4b0d-b824-d632097c012d',NULL,NULL,NULL,NULL,NULL,NULL),('location.field.style','default','Type of widget to use for location fields','76bf5e24-69c7-4ba0-a807-75b43db7208f',NULL,NULL,NULL,NULL,NULL,NULL),('log.layout','%p - %C{1}.%M(%L) |%d{ISO8601}| %m%n','A log layout pattern which is used by the OpenMRS file appender.','110b23db-9c46-49ec-ad90-c2ba266f0fe9',NULL,NULL,NULL,NULL,NULL,NULL),('log.level','org.openmrs.api:info','Logging levels for log4j2.xml. Valid format is class:level,class:level. If class not specified, \'org.openmrs.api\' presumed. Valid levels are trace, debug, info, warn, error or fatal','d9590e3c-d6eb-4d4b-8cd0-7f0e5a272938',NULL,NULL,NULL,NULL,NULL,NULL),('log.location',NULL,'A directory where the OpenMRS log file appender is stored. The log file name is \'openmrs.log\'.','0b74ab84-696c-4f49-ae1d-74c18a7a71cc',NULL,NULL,NULL,NULL,NULL,NULL),('login.url','login.htm','Responsible for defining the Authentication URL','8f85f0d5-369f-4887-bcf8-05862670dcc7',NULL,NULL,NULL,NULL,NULL,NULL),('mail.debug','false','true/false whether to print debugging information during mailing','068c4137-540e-4fc9-8a21-e82d163b0f0c',NULL,NULL,NULL,NULL,NULL,NULL),('mail.default_content_type','text/plain','Content type to append to the mail messages','1c6eefbf-2d5b-40bd-93f9-baf28f8814a3',NULL,NULL,NULL,NULL,NULL,NULL),('mail.from','info@openmrs.org','Email address to use as the default from address','4a5aa53b-0349-4a49-a1c2-7becec546a1f',NULL,NULL,NULL,NULL,NULL,NULL),('mail.password','test','Password for the SMTP user (if smtp_auth is enabled)','082f71de-a601-4d2e-83a3-477ce4f8f093',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp_auth','false','true/false whether the smtp host requires authentication','8da96f4a-e489-4265-b79b-dacbc6be8f75',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp_host','localhost','SMTP host name','932da7c6-5eba-41ac-a55b-0e1ce8c20ee9',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp_port','25','SMTP port','f36a2228-6504-4d70-865d-13c00bf903e2',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp.starttls.enable','false','Set to true to enable TLS encryption, else set to false','eda81f64-12e2-4a5b-b2a0-da25f285eb5b',NULL,NULL,NULL,NULL,NULL,NULL),('mail.transport_protocol','smtp','Transport protocol for the messaging engine. Valid values: smtp','55995fff-b51a-4672-8c17-915088047ebf',NULL,NULL,NULL,NULL,NULL,NULL),('mail.user','test','Username of the SMTP user (if smtp_auth is enabled)','99a5b518-e9e7-4678-93b2-0821b5be0b22',NULL,NULL,NULL,NULL,NULL,NULL),('metadatadeploy.mandatory','false','true/false whether or not the metadatadeploy module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','f40d5794-88c4-4f40-baeb-28f5fa8d3edd',NULL,NULL,NULL,NULL,NULL,NULL),('metadatadeploy.started','true','DO NOT MODIFY. true/false whether or not the metadatadeploy module has been started.  This is used to make sure modules that were running  prior to a restart are started again','e1c8e821-81c4-48e1-9532-6b61b4f25268',NULL,NULL,NULL,NULL,NULL,NULL),('metadatamapping.addLocalMappings',NULL,'Specifies whether the concept mappings to the local dictionary should be created when exporting concepts','a2d0dd28-cac9-4947-82c5-fec42dd208e7',NULL,NULL,NULL,NULL,NULL,NULL),('metadatamapping.mandatory','false','true/false whether or not the metadatamapping module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','2d0be674-7a0f-4413-b96b-08dd3af83fdd',NULL,NULL,NULL,NULL,NULL,NULL),('metadatamapping.started','true','DO NOT MODIFY. true/false whether or not the metadatamapping module has been started.  This is used to make sure modules that were running  prior to a restart are started again','90a5abdb-a9c9-4a7e-ac99-678dc5a545f6',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.enableOnTheFlyPackages','false','Specifies whether metadata packages can be exported on the fly','2aa59497-3260-4dfa-9a5f-0865c8fe2b15',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.mandatory','false','true/false whether or not the metadatasharing module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','fe7bf13e-d5b6-49c5-8727-5b7b4883f609',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.persistIdsForClasses',NULL,'A comma separated list of class package/names that denotes classes to try and persist ids for. Common options: org.openmrs.Concept,org.openmrs.Form,org.openmrs.ConceptDatatype,org.openmrs.ConceptClass,org.openmrs.EncounterType,org.openmrs.IdentifierType,org.openmrs.RelationshipType,org.openmrs.Location','0b4389e6-e714-4769-875a-cea71068f883',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.preferredConceptSourceIds',NULL,'Comma-separated list of concept source Ids for preferred sources, in case an incoming concept \nhas duplicate mappings to any of these sources, no confirmation will be required unless its \ndatatype or concept class differs from that of the existing concept','2f795e86-e89f-4af7-b4c0-fd1c03ad66e1',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.started','true','DO NOT MODIFY. true/false whether or not the metadatasharing module has been started.  This is used to make sure modules that were running  prior to a restart are started again','1fd9c839-0af9-43b6-88b0-0d229eb0ba6e',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.webservicesKey',NULL,'Key to grant access to remote systems to consume module webservices RESTfully','8d1b88fe-b312-4401-937f-5336a4bc6df6',NULL,NULL,NULL,NULL,NULL,NULL),('minSearchCharacters','2','Number of characters user must input before searching is started.','85879a04-5cd0-413b-a79a-b0891ae6422d',NULL,NULL,NULL,NULL,NULL,NULL),('module_repository_folder','modules','Name of the folder in which to store the modules','f8dfd764-2b92-4716-aa6b-9e1245834553',NULL,NULL,NULL,NULL,NULL,NULL),('new_patient_form.showRelationships','false','true/false whether or not to show the relationship editor on the addPatient.htm screen','679c3721-9c17-4cc6-87a2-92093d4e7c4c','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('newPatientForm.relationships',NULL,'Comma separated list of the RelationshipTypes to show on the new/short patient form.  The list is defined like \'3a, 4b, 7a\'.  The number is the RelationshipTypeId and the \'a\' vs \'b\' part is which side of the relationship is filled in by the user.','6f6c2d8a-e211-4f42-a052-13bbbe885c98',NULL,NULL,NULL,NULL,NULL,NULL),('obs.complex_obs_dir','complex_obs','Default directory for storing complex obs.','5fb91287-2eba-4b4e-831b-5cdbce3ac62d',NULL,NULL,NULL,NULL,NULL,NULL),('order.drugDispensingUnitsConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible drug dispensing units','ab8320b9-710d-4e23-a871-52472c98109d',NULL,NULL,NULL,NULL,NULL,NULL),('order.drugDosingUnitsConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible drug dosing units','df7abbbd-7161-4dc5-a1b4-7002e3ed857a',NULL,NULL,NULL,NULL,NULL,NULL),('order.drugRoutesConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible drug routes','59aa1ba3-516f-4a60-94b0-d72a735e7cec',NULL,NULL,NULL,NULL,NULL,NULL),('order.durationUnitsConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible duration units','e945515b-5df0-4fd4-b645-1f4178657a7f',NULL,NULL,NULL,NULL,NULL,NULL),('order.nextOrderNumberSeed','1','The next order number available for assignment','88950514-eddb-4799-a1fa-125ac612b9b9',NULL,NULL,NULL,NULL,NULL,NULL),('order.orderNumberGeneratorBeanId',NULL,'Specifies spring bean id of the order generator to use when assigning order numbers','8be8e858-205a-4e96-b0a0-b217927f7e59',NULL,NULL,NULL,NULL,NULL,NULL),('order.testSpecimenSourcesConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible test specimen sources','2f76e910-4c41-4b6e-92ee-132a18c14460',NULL,NULL,NULL,NULL,NULL,NULL),('patient_identifier.importantTypes',NULL,'A comma delimited list of PatientIdentifier names : PatientIdentifier locations that will be displayed on the patient dashboard.  E.g.: TRACnet ID:Rwanda,ELDID:Kenya','65bfeedf-0e30-41a8-aa35-86b36d3a67de',NULL,NULL,NULL,NULL,NULL,NULL),('patient.defaultPatientIdentifierValidator','org.openmrs.patient.impl.LuhnIdentifierValidator','This property sets the default patient identifier validator.  The default validator is only used in a handful of (mostly legacy) instances.  For example, it\'s used to generate the isValidCheckDigit calculated column and to append the string \"(default)\" to the name of the default validator on the editPatientIdentifierType form.','a2004c81-bd63-418d-ab83-d790a49b21a5',NULL,NULL,NULL,NULL,NULL,NULL),('patient.headerAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that will be shown on the patient dashboard','130bffcb-a099-45ed-9e30-1601762b7841',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierPrefix',NULL,'This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','1fde0365-b64c-4ec8-af93-d2bffad7a6d0',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierRegex',NULL,'WARNING: Using this search property can cause a drop in mysql performance with large patient sets.  A MySQL regular expression for the patient identifier search strings.  The @SEARCH@ string is replaced at runtime with the user\'s search string.  An empty regex will cause a simply \'like\' sql search to be used. Example: ^0*@SEARCH@([A-Z]+-[0-9])?$','023a22c8-5e3c-49a8-944c-4f1453d7ca4f',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierSearchPattern',NULL,'If this is empty, the regex or suffix/prefix search is used.  Comma separated list of identifiers to check.  Allows for faster searching of multiple options rather than the slow regex. e.g. @SEARCH@,0@SEARCH@,@SEARCH-1@-@CHECKDIGIT@,0@SEARCH-1@-@CHECKDIGIT@ would turn a request for \"4127\" into a search for \"in (\'4127\',\'04127\',\'412-7\',\'0412-7\')\"','cc950791-da98-4588-8dc9-311892421441',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierSuffix',NULL,'This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','96a52093-5c01-46b8-8e8d-5676a5876dde',NULL,NULL,NULL,NULL,NULL,NULL),('patient.listingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for patients in _lists_','36e5ab7a-018c-4f06-aa5b-c7c65bc38160',NULL,NULL,NULL,NULL,NULL,NULL),('patient.nameValidationRegex',NULL,'Names of the patients must pass this regex. Eg : ^[a-zA-Z \\-]+$ contains only english alphabet letters, spaces, and hyphens. A value of .* or the empty string means no validation is done.','fdde5cb6-2872-4267-95bf-f32fe075a793',NULL,NULL,NULL,NULL,NULL,NULL),('patient.viewingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for patients when _viewing individually_','283a9573-ea62-4ab4-822e-ce0b60a43b77',NULL,NULL,NULL,NULL,NULL,NULL),('patientIdentifierSearch.matchMode','EXACT','Specifies how patient identifiers are matched while searching for a patient. Valid values are \'EXACT, \'ANYWHERE\' or \'START\'. Defaults to \'EXACT\' if missing or invalid value is present.','ee164015-0f1d-4dda-9e41-e0e9268d7074',NULL,NULL,NULL,NULL,NULL,NULL),('patientIdentifierTypes.locked','false','Set to a value of true if you do not want allow editing patient identifier types, else set to false.','ac1004f3-bc64-411d-936a-6d40094d3b9c',NULL,NULL,NULL,NULL,NULL,NULL),('patientSearch.matchMode','START','Specifies how patient names are matched while searching patient. Valid values are \'ANYWHERE\' or \'START\'. Defaults to start if missing or invalid value is present.','2c10efeb-5541-4bb7-a12f-1f7357126dcc',NULL,NULL,NULL,NULL,NULL,NULL),('person.attributeSearchMatchMode','EXACT','Specifies how person attributes are matched while searching person. Valid values are \'ANYWHERE\' or \'EXACT\'. Defaults to exact if missing or invalid value is present.','bb585ba2-b566-4db6-875f-a1e0974b8047',NULL,NULL,NULL,NULL,NULL,NULL),('person.searchMaxResults','1000','The maximum number of results returned by patient searches','0ab837b3-90a0-4ff0-a85c-65fb4adbf511',NULL,NULL,NULL,NULL,NULL,NULL),('personAttributeTypes.locked','false','Set to a value of true if you do not want allow editing person attribute types, else set to false.','32b242f7-deef-43cb-a80c-f392ae50c5dd',NULL,NULL,NULL,NULL,NULL,NULL),('provider.unknownProviderUuid',NULL,'Specifies the uuid of the Unknown Provider account','4f82ca5a-271c-4c98-8892-8945234db34d',NULL,NULL,NULL,NULL,NULL,NULL),('providerSearch.matchMode','EXACT','Specifies how provider identifiers are matched while searching for providers. Valid values are START,EXACT, END or ANYWHERE','fe2f887e-2a1f-47a2-9db9-d635b2b1f22e',NULL,NULL,NULL,NULL,NULL,NULL),('reportProblem.url','http://errors.openmrs.org/scrap','The openmrs url where to submit bug reports','e29b2820-8ae0-482e-a826-676c3d9cbca7',NULL,NULL,NULL,NULL,NULL,NULL),('scheduler.password','test','Password for the OpenMRS user that will perform the scheduler activities','1777eba3-c055-42b7-83b2-ee48f8208cf3',NULL,NULL,NULL,NULL,NULL,NULL),('scheduler.username','admin','Username for the OpenMRS user that will perform the scheduler activities','a4ceb9de-65af-4c5b-9258-1168186e887c',NULL,NULL,NULL,NULL,NULL,NULL),('search.caseSensitiveDatabaseStringComparison','false','Indicates whether database string comparison is case sensitive or not. Setting this to false for MySQL with a case insensitive collation improves search performance.','12019a66-3f3d-4bd6-ae00-1c44947931f6',NULL,NULL,NULL,NULL,NULL,NULL),('search.indexVersion','7','Indicates the index version. If it is blank, the index needs to be rebuilt.','db540a7b-d92a-46e4-b94c-98d917103291',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.batchSize','200','The maximum number of search results that are returned by an ajax call','63b172d6-7bb5-48ad-a291-43d24c198add',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.dateDisplayFormat',NULL,'Date display format to be used to display the date somewhere in the UI i.e the search widgets and autocompletes','d95d7d78-53ef-4cd6-84ee-99db1dd3edd3',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.maximumResults','2000','Specifies the maximum number of results to return from a single search in the search widgets','bff48abc-dadf-48b6-a7fc-7e70013880ef',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.runInSerialMode','false','Specifies whether the search widgets should make ajax requests in serial or parallel order, a value of true is appropriate for implementations running on a slow network connection and vice versa','28d98aa4-e111-4933-8c59-7031674de3a2','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('searchWidget.searchDelayInterval','300','Specifies time interval in milliseconds when searching, between keyboard keyup event and triggering the search off, should be higher if most users are slow when typing so as to minimise the load on the server','feaecf3b-c52e-4d55-abc5-e2deaf896e7e',NULL,NULL,NULL,NULL,NULL,NULL),('security.allowedFailedLoginsBeforeLockout','7','Maximum number of failed logins allowed after which username is locked out','7ca2ee3b-4194-4b7a-a2b6-26f0eaa14024',NULL,NULL,NULL,NULL,NULL,NULL),('security.passwordCannotMatchUsername','true','Configure whether passwords must not match user\'s username or system id','ffb0c3aa-eb1f-4205-b6e3-2e965485ace3','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.passwordCustomRegex',NULL,'Configure a custom regular expression that a password must match','eeae96b0-abd8-4210-9151-6dead4e3e645',NULL,NULL,NULL,NULL,NULL,NULL),('security.passwordMinimumLength','8','Configure the minimum length required of all passwords','fae0aed3-9de3-4445-b3d3-d4c8fe0861aa',NULL,NULL,NULL,NULL,NULL,NULL),('security.passwordRequiresDigit','true','Configure whether passwords must contain at least one digit','325a9bf1-6da7-4b01-8b99-1a412bce941e','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.passwordRequiresNonDigit','true','Configure whether passwords must contain at least one non-digit','5c6fd64c-c2ca-4e9d-a0ee-adcf5e61352b','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.passwordRequiresUpperAndLowerCase','true','Configure whether passwords must contain both upper and lower case characters','39d80c3c-977f-41f6-89a9-f002123a6032','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.validTime','600000','Specifies the duration of time in seconds for which a password reset token is valid, the default value is 10 minutes and the allowed values range from 1 minute to 12hrs','c5c2940a-0c34-410c-98b6-766ca2128b6a',NULL,NULL,NULL,NULL,NULL,NULL),('use_patient_attribute.healthCenter','false','Indicates whether or not the \'health center\' attribute is shown when viewing/searching for patients','e6036ef2-3fa4-4eed-8dbc-d58497974925','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('use_patient_attribute.mothersName','false','Indicates whether or not mother\'s name is able to be added/viewed for a patient','9d823ecb-e72b-40d7-9b31-069647873dc2','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('user.headerAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that will be shown on the user dashboard. (not used in v1.5)','e5c1d0eb-054a-4214-9032-2ec90dc5c850',NULL,NULL,NULL,NULL,NULL,NULL),('user.listingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for users in _lists_','324181cb-2b71-4583-862b-cff16ef8b05a',NULL,NULL,NULL,NULL,NULL,NULL),('user.requireEmailAsUsername','false','Indicates whether a username must be a valid e-mail or not.','855bbd43-74b0-40bd-a7d8-e18068ed0a67','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('user.viewingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for users when _viewing individually_','69a40d8c-5bb2-441e-aeb7-f074c5b91e03',NULL,NULL,NULL,NULL,NULL,NULL),('validation.disable','true','Disables validation of OpenMRS Objects. Only takes affect on next restart. Warning: only do this is you know what you are doing!','b68064cd-16b5-463b-823f-cda83f8bfbbf',NULL,NULL,NULL,NULL,NULL,NULL),('visits.allowOverlappingVisits','true','true/false whether or not to allow visits of a given patient to overlap','d10d4100-8fb7-4a94-b477-fc0e44a8d80e','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('visits.assignmentHandler','org.openmrs.api.handler.ExistingVisitAssignmentHandler','Set to the name of the class responsible for assigning encounters to visits.','81d8d2cb-86a0-439d-9106-4ef5c9d628e3',NULL,NULL,NULL,NULL,NULL,NULL),('visits.autoCloseVisitType',NULL,'comma-separated list of the visit type(s) to automatically close','9ca7fe73-1a23-4759-ac48-6b40b6e4123e',NULL,NULL,NULL,NULL,NULL,NULL),('visits.enabled','true','Set to true to enable the Visits feature. This will replace the \'Encounters\' tab with a \'Visits\' tab on the dashboard.','7eb786dc-45a8-4016-9570-35c07e75850f','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('visits.encounterTypeToVisitTypeMapping',NULL,'Specifies how encounter types are mapped to visit types when automatically assigning encounters to visits. e.g 1:1, 2:1, 3:2 in the format encounterTypeId:visitTypeId or encounterTypeUuid:visitTypeUuid or a combination of encounter/visit type uuids and ids e.g 1:759799ab-c9a5-435e-b671-77773ada74e4','7ad467b4-9f65-4539-acae-02bbdd860b59',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.allowedips',NULL,'A comma-separate list of IP addresses that are allowed to access the web services. An empty string allows everyone to access all ws. \n        IPs can be declared with bit masks e.g. 10.0.0.0/30 matches 10.0.0.0 - 10.0.0.3 and 10.0.0.0/24 matches 10.0.0.0 - 10.0.0.255.','469372d0-f58d-42fd-a963-d3efb5b10e6d',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.mandatory','false','true/false whether or not the webservices.rest module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','55fd6b42-a935-47f8-9e26-1465dc06a807',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.maxResultsAbsolute','100','The absolute max results limit. If the client requests a larger number of results, then will get an error','fe248c39-39df-479c-b039-c9cd4a62058b',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.maxResultsDefault','50','The default max results limit if the user does not provide a maximum when making the web service call.','2e9c3802-8a93-4830-b39a-2ebfe4e320bb',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.quietDocs','true','If the value of this setting is \"true\", then nothing is logged while the Swagger specification is being generated.','073c8b16-e74e-494b-9bf0-e15108700a01',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.started','true','DO NOT MODIFY. true/false whether or not the webservices.rest module has been started.  This is used to make sure modules that were running  prior to a restart are started again','e5f680d3-1b20-4da8-8a01-834a956b1527',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.uriPrefix',NULL,'The URI prefix through which clients consuming web services will connect to the web application, should be of the form http://{ipAddress}:{port}/{contextPath}','9ed9ca20-ec0e-4e2f-93ea-d650e0218eb6',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `global_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_archive`
--

DROP TABLE IF EXISTS `hl7_in_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_archive` (
  `hl7_in_archive_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hl7_data` text COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `message_state` int(11) DEFAULT '2',
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`hl7_in_archive_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `hl7_in_archive_message_state_idx` (`message_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_archive`
--

LOCK TABLES `hl7_in_archive` WRITE;
/*!40000 ALTER TABLE `hl7_in_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_error`
--

DROP TABLE IF EXISTS `hl7_in_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_error` (
  `hl7_in_error_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text COLLATE utf8_unicode_ci,
  `hl7_data` text COLLATE utf8_unicode_ci NOT NULL,
  `error` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `error_details` mediumtext COLLATE utf8_unicode_ci,
  `date_created` datetime NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`hl7_in_error_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_error`
--

LOCK TABLES `hl7_in_error` WRITE;
/*!40000 ALTER TABLE `hl7_in_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_queue`
--

DROP TABLE IF EXISTS `hl7_in_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_queue` (
  `hl7_in_queue_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text COLLATE utf8_unicode_ci,
  `hl7_data` text COLLATE utf8_unicode_ci NOT NULL,
  `message_state` int(11) NOT NULL DEFAULT '0',
  `date_processed` datetime DEFAULT NULL,
  `error_msg` text COLLATE utf8_unicode_ci,
  `date_created` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`hl7_in_queue_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `hl7_source_with_queue` (`hl7_source`),
  CONSTRAINT `hl7_source_with_queue` FOREIGN KEY (`hl7_source`) REFERENCES `hl7_source` (`hl7_source_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_queue`
--

LOCK TABLES `hl7_in_queue` WRITE;
/*!40000 ALTER TABLE `hl7_in_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_source`
--

DROP TABLE IF EXISTS `hl7_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_source` (
  `hl7_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`hl7_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_who_created_hl7_source` (`creator`),
  CONSTRAINT `user_who_created_hl7_source` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_source`
--

LOCK TABLES `hl7_source` WRITE;
/*!40000 ALTER TABLE `hl7_source` DISABLE KEYS */;
INSERT INTO `hl7_source` VALUES (1,'LOCAL','',1,'2006-09-01 00:00:00','8d6b8bb6-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `hl7_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangelog`
--

DROP TABLE IF EXISTS `liquibasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangelog` (
  `ID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `AUTHOR` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `FILENAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `MD5SUM` varchar(35) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COMMENTS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TAG` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LIQUIBASE` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CONTEXTS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LABELS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangelog`
--

LOCK TABLES `liquibasechangelog` WRITE;
/*!40000 ALTER TABLE `liquibasechangelog` DISABLE KEYS */;
INSERT INTO `liquibasechangelog` VALUES ('1582473628795-1','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:38',1,'EXECUTED','8:238fe3f03c37d18fd5117d58579b728e','createTable tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-2','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:39',2,'EXECUTED','8:66bfc8234785132bb19d738a38149dac','createTable tableName=allergy_reaction','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-3','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:39',3,'EXECUTED','8:a1cf873fe69c959aac6a8bc560123db3','createTable tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-4','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:39',4,'EXECUTED','8:08dd21485e374a9c23ba168f86e688d8','createTable tableName=clob_datatype_storage','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-5','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:39',5,'EXECUTED','8:98cad85af2e0bb7a64b85d4b476095a7','createTable tableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-6','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:39',6,'EXECUTED','8:4df18ea17f9c077a6c66cf1609c031dd','createTable tableName=cohort_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-7','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:39',7,'EXECUTED','8:439539bcb3d94c4d0e269296b23ef70b','createTable tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-8','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:39',8,'EXECUTED','8:c34dc6adc6f35bd0c9051ba65a015005','createTable tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-9','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:39',9,'EXECUTED','8:ef8fd51526a17665cadd10c91742740f','createTable tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-10','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:40',10,'EXECUTED','8:142ed55c82ea3c39531b89202caf1bc1','createTable tableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-11','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:40',11,'EXECUTED','8:f44a280ff3f4b390728c61c709126fbd','createTable tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-12','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:40',12,'EXECUTED','8:9095b0e88b571c2edd43af0e662c9d54','createTable tableName=concept_complex','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-13','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:40',13,'EXECUTED','8:3679f7729afe800446d8cedf68fd3c26','createTable tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-14','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:40',14,'EXECUTED','8:006e0e83f27be58d38265254c4c73a18','createTable tableName=concept_description','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-15','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:40',15,'EXECUTED','8:201f1eee264b3524160f726e2bb01ad4','createTable tableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-16','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:40',16,'EXECUTED','8:496f72fa38dba348042ab0cf169341cb','createTable tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-17','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:40',17,'EXECUTED','8:ef87738c7dadd667412bfa1d9b334ee0','createTable tableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-18','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:41',18,'EXECUTED','8:2ad1f3969d4447ec88134a92452372cc','createTable tableName=concept_name_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-19','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:41',19,'EXECUTED','8:5c452fab1bf82808191c0e716b21495d','createTable tableName=concept_numeric','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-20','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:41',20,'EXECUTED','8:19ca40eebcedeaaa6a79f23969cff287','createTable tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-21','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:41',21,'EXECUTED','8:32485f3a60b8038b6bec0697ec1925c8','createTable tableName=concept_proposal_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-22','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:41',22,'EXECUTED','8:6e89e74287cb308de5f82102413a0439','createTable tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-23','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:41',23,'EXECUTED','8:8c39f2171bac697c43c1aec40549978b','createTable tableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-24','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:41',24,'EXECUTED','8:2311a8ad536e93f51f23b6330144974c','createTable tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-25','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:42',25,'EXECUTED','8:db7361e2e3134136d7311020e001dfe3','createTable tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-26','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:42',26,'EXECUTED','8:6d84f3d7e12a72c45f6a9be7eb4b36a7','createTable tableName=concept_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-27','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:42',27,'EXECUTED','8:ec244808f1b0894a53f3c73acdd09692','createTable tableName=concept_state_conversion','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-28','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:42',28,'EXECUTED','8:03eb15e1b88a1c9f5d95079011881fcb','createTable tableName=concept_stop_word','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-29','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:42',29,'EXECUTED','8:dd9d9e6b445cbced1ae746e0bc039cd5','createTable tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-30','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:42',30,'EXECUTED','8:75fe79aac8155c708d4d886d97edc2ad','createTable tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-31','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:42',31,'EXECUTED','8:fa53b9d6b5ca90f4f1dd3f9b7dc6ac7b','createTable tableName=drug_ingredient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-32','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:42',32,'EXECUTED','8:e1931d61b5e0d3f19ca14dd4a3f8d470','createTable tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-33','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:43',33,'EXECUTED','8:789061a8116ebbcc436e7184ea642fc0','createTable tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-34','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:43',34,'EXECUTED','8:e01652d1cc10267c54c08aa6c69fa267','createTable tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-35','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:43',35,'EXECUTED','8:327278fc23b24c74246bc786b3aa86d9','createTable tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-36','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:43',36,'EXECUTED','8:d39433ac66c5db9697439993cd37745d','createTable tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-37','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:43',37,'EXECUTED','8:2ea2d318a7d4712bb4ec4ac5a23acb95','createTable tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-38','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:43',38,'EXECUTED','8:23ef531c5e1cfa984985d17897f153c8','createTable tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-39','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:43',39,'EXECUTED','8:948f7dfe7f7d954636d2ddceba471b2d','createTable tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-40','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:43',40,'EXECUTED','8:dd5b1cadb5a56575a7e8cd8462fbb7e1','createTable tableName=field_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-41','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:44',41,'EXECUTED','8:9d0f4e40b82245078bcd22174f82452f','createTable tableName=field_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-42','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:44',42,'EXECUTED','8:62cab75a02e38a79d1cf948219d8189a','createTable tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-43','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:44',43,'EXECUTED','8:3de5017a3753d3a6e0a7593c6411e260','createTable tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-44','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:44',44,'EXECUTED','8:91e80c748bf1462e41411ac3feadfd57','createTable tableName=form_resource','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-45','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:44',45,'EXECUTED','8:a295f3ad50a0faab26d885e4a3ffc386','createTable tableName=global_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-46','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:44',46,'EXECUTED','8:02ce7a54be6683048b3bfd01944c0303','createTable tableName=hl7_in_archive','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-47','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:44',47,'EXECUTED','8:089a56e623784de5510d377e1a5c0fb7','createTable tableName=hl7_in_error','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-48','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:44',48,'EXECUTED','8:ca099d7b4600624db7b78b762b0a3b02','createTable tableName=hl7_in_queue','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-49','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:45',49,'EXECUTED','8:0c39e5581a2dd23a769b82b1a0377d3a','createTable tableName=hl7_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-52','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:45',50,'EXECUTED','8:e8848a5f02cf220d27fb281cb8cc858c','createTable tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-53','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:45',51,'EXECUTED','8:f0ad9d30f2a4eb80b5d14f22fb2414e8','createTable tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-54','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:45',52,'EXECUTED','8:51c85eeebcc3a9312db41105fe3dca49','createTable tableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-55','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:45',53,'EXECUTED','8:b9360b112a62e90b0014e49f835c5d3d','createTable tableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-56','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:45',54,'EXECUTED','8:c1c62de3067d99bd88bd0ddda1e4ff19','createTable tableName=location_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-57','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:45',55,'EXECUTED','8:81ceb9f89c4271def4031a92a4c93664','createTable tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-58','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:46',56,'EXECUTED','8:eace5025507e76a3678701a1382782c4','createTable tableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-59','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:46',57,'EXECUTED','8:295b72dcc114cfa85d967adc8b27a01a','createTable tableName=notification_alert_recipient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-60','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:46',58,'EXECUTED','8:e9e05b5a3371d945f2e773f3d1ada6c1','createTable tableName=notification_template','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-61','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:46',59,'EXECUTED','8:9ec0fb1d838b0a5fdfed897f841c6c2e','createTable tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-62','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:46',60,'EXECUTED','8:53a44b946d8ca5c27930fa1b821a9c0b','createTable tableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-63','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:46',61,'EXECUTED','8:f21d6287908349a10902b5ddad46a444','createTable tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-64','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:46',62,'EXECUTED','8:b0e480c587aad19df5fe32c3e8de3026','createTable tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-65','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:46',63,'EXECUTED','8:51966d28f8d45998212887fc2d6658e0','createTable tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-66','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:47',64,'EXECUTED','8:f65d4f171b22df2632798a54d9d71bc5','createTable tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-67','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:47',65,'EXECUTED','8:3617a5326201bdd34ee64548fa81f670','createTable tableName=order_type_class_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-68','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:47',66,'EXECUTED','8:16b1d52d372ef877b87c83683a6f412e','createTable tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-69','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:47',67,'EXECUTED','8:8954c91117bc5b5d8c4e035c59f2d3f5','createTable tableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-70','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:47',68,'EXECUTED','8:8079e93f1a5eb390c72f60f03ea38633','createTable tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-71','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:47',69,'EXECUTED','8:45adf630810c6bc7baedc9e80f3fa78f','createTable tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-72','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:47',70,'EXECUTED','8:6441e3670907d81ad00d689d1b84a44b','createTable tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-73','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:47',71,'EXECUTED','8:05b0103e4d69508557b17249ff869b0c','createTable tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-74','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:48',72,'EXECUTED','8:c6e7edf42161c56fcab9d2cefb8053a8','createTable tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-75','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:48',73,'EXECUTED','8:2d5da170c140d7e80e2f9e8b6c0ea2f4','createTable tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-76','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:48',74,'EXECUTED','8:47e57060ce4d4799b75ed23a8c8d5069','createTable tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-77','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:48',75,'EXECUTED','8:5403117950f628ee69d642012e32ed76','createTable tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-78','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:48',76,'EXECUTED','8:805580f60917bb3713db9bf2bce7b8c5','createTable tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-79','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:48',77,'EXECUTED','8:ef9fa12dd20b6d69932251edf73787aa','createTable tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-80','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:48',78,'EXECUTED','8:bfd52cee713336403616d1c16ecfff94','createTable tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-81','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:48',79,'EXECUTED','8:bc93a477857f42a0a2f5ce0cf130c06f','createTable tableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-82','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:49',80,'EXECUTED','8:6d47747541bf72c208d48bd34639725d','createTable tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-83','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:49',81,'EXECUTED','8:0b8b7645ef730dba3a0845533b18d2cf','createTable tableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-84','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:49',82,'EXECUTED','8:52d5ade33710854bcdf137920a600e33','createTable tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-85','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:49',83,'EXECUTED','8:6165bf55147465316ff8a4db11aa3d7e','createTable tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-86','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:49',84,'EXECUTED','8:aad0b2a94e29051a379ec9d731994627','createTable tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-87','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:49',85,'EXECUTED','8:e707b8ba8979f2e6161dc9b2c3789165','createTable tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-88','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:49',86,'EXECUTED','8:b0ef5d173d29f94047ae72eaa975ec0e','createTable tableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-89','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:50',87,'EXECUTED','8:028a98c61666a9ef47936fd43f604f74','createTable tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-90','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:50',88,'EXECUTED','8:b9a14edd7429c747153832947b450e8f','createTable tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-91','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:50',89,'EXECUTED','8:206b767bb1c039465101506583b16269','createTable tableName=report_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-92','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:50',90,'EXECUTED','8:0d190523553cd8b01deffceac791821a','createTable tableName=report_schema_xml','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-93','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:50',91,'EXECUTED','8:aeae38f3d61d4fa234c16de406c8ce5a','createTable tableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-94','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:50',92,'EXECUTED','8:262d2a3bec8ed138c8341604ed61623b','createTable tableName=role_privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-95','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:50',93,'EXECUTED','8:08f5e5ca18573dc55e4b21c1310ea6a1','createTable tableName=role_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-96','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:50',94,'EXECUTED','8:795792e2c4a34a1b14e315c33c26aad7','createTable tableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-97','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:51',95,'EXECUTED','8:9417a129dd10a6b5084c58753a8d7e8e','createTable tableName=scheduler_task_config_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-98','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:51',96,'EXECUTED','8:af1fe94b4ccbbcb29ded2279e2b21e95','createTable tableName=serialized_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-99','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:51',97,'EXECUTED','8:43237f7dd8bb33bb478bdaf0bb725a05','createTable tableName=test_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-100','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:51',98,'EXECUTED','8:5311325d6a46d0feb522ff60d8a5cf80','createTable tableName=user_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-101','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:51',99,'EXECUTED','8:5a15316575ed6969069e2c906af3b12b','createTable tableName=user_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-102','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:51',100,'EXECUTED','8:8097a95686fc72d4eee52b904b8517f1','createTable tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-103','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:51',101,'EXECUTED','8:4c2f1c04b745bbf720c94d08f824439d','createTable tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-104','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:51',102,'EXECUTED','8:94fc7056b587c4d5291ae12880439d10','createTable tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-105','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',103,'EXECUTED','8:e3fff16d34de807a446d0d5a331ef929','createTable tableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-106','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',104,'EXECUTED','8:fe8c5f6c57c52f28ac22bcf213575434','createTable tableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-107','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',105,'EXECUTED','8:e6e767dc77131b1867f0eca3cf137607','addUniqueConstraint constraintName=Unique_StopWord_Key, tableName=concept_stop_word','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-108','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',106,'EXECUTED','8:89adbb595c96cd430a0b511ae01ff6a0','addUniqueConstraint constraintName=unique_form_and_name, tableName=form_resource','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-109','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',107,'EXECUTED','8:3164a86460597775566f339b7988025b','addUniqueConstraint constraintName=unique_workflow_concept_in_conversion, tableName=concept_state_conversion','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-110','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',108,'EXECUTED','8:b333d65cbce8404063a1a9c49de4448f','createIndex indexName=address_for_person, tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-111','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',109,'EXECUTED','8:66771b59765b7d074573fc820d0cd3fe','createIndex indexName=alert_creator, tableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-112','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',110,'EXECUTED','8:8147fa6e97c11507e1f592303259720e','createIndex indexName=alert_date_to_expire_idx, tableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-113','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',111,'EXECUTED','8:3191e265a3b57b0521ac0f34acec54a3','createIndex indexName=alert_read_by_user, tableName=notification_alert_recipient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-114','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:52',112,'EXECUTED','8:f5fae48654f180b62cf26898cd7f9459','createIndex indexName=allergy_changed_by_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-115','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',113,'EXECUTED','8:21221492eb4e97daa9035b20a84f906a','createIndex indexName=allergy_coded_allergen_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-116','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',114,'EXECUTED','8:b1d6b67f44e93f9b02919352b5aacaad','createIndex indexName=allergy_creator_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-117','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',115,'EXECUTED','8:3802de1996f1d6d8960ff81b4e7a8490','createIndex indexName=allergy_patient_id_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-118','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',116,'EXECUTED','8:73c8f4df0e4b017640c1dbd16aa29dc7','createIndex indexName=allergy_reaction_allergy_id_fk, tableName=allergy_reaction','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-119','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',117,'EXECUTED','8:0c7772d6190cbac7f586dddedfddc53a','createIndex indexName=allergy_reaction_reaction_concept_id_fk, tableName=allergy_reaction','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-120','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',118,'EXECUTED','8:1c9aac1012a9f0aa9ffd18108fb78c7b','createIndex indexName=allergy_severity_concept_id_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-121','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',119,'EXECUTED','8:26d5e7fcd5345ba55707d1e45d68f384','createIndex indexName=allergy_voided_by_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-122','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',120,'EXECUTED','8:6085d7b477502bb8c100914454572165','createIndex indexName=answer, tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-123','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',121,'EXECUTED','8:6b328688423a699018d015f3de50e7d9','createIndex indexName=answer_answer_drug_fk, tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-124','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',122,'EXECUTED','8:e149c8cd912ab791878266048cdc5f66','createIndex indexName=answer_concept, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-125','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:53',123,'EXECUTED','8:4cff1dfa775ab85432147fc7a9bc45bb','createIndex indexName=answer_concept_drug, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-126','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',124,'EXECUTED','8:cb0f8b09f946ae6f4de454a9b3c73d14','createIndex indexName=answer_creator, tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-127','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',125,'EXECUTED','8:aafb0f0bbcc38efaea28ef6a0d0279b9','createIndex indexName=answers_for_concept, tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-128','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',126,'EXECUTED','8:b932dbce6343d0824d78fb1ab6bafe63','createIndex indexName=attribute_changer, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-129','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',127,'EXECUTED','8:5efc1f8e26031e3b01c73abefbd04d97','createIndex indexName=attribute_creator, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-130','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',128,'EXECUTED','8:9685bc73a05b10f134eb4094de4454fd','createIndex indexName=attribute_is_searchable, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-131','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',129,'EXECUTED','8:8ee4bc666d3f825b7fd1b219483b31c9','createIndex indexName=attribute_type_changer, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-132','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',130,'EXECUTED','8:2d33f303d66728b36c2613fbdbf1aaee','createIndex indexName=attribute_type_creator, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-133','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',131,'EXECUTED','8:cdc02e232fe6637a419142acd22d6931','createIndex indexName=attribute_voider, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-134','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',132,'EXECUTED','8:58d7b7938a86384a410898cb2af13e8c','createIndex indexName=care_setting_changed_by, tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-135','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:54',133,'EXECUTED','8:bbe2e850c9553c682b0b81a09d28bea2','createIndex indexName=care_setting_creator, tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-136','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',134,'EXECUTED','8:5cf3a54d398cc896218fbf6e3b298995','createIndex indexName=care_setting_retired_by, tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-137','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',135,'EXECUTED','8:6e0c003dc134e780289f4bbed82aa8ac','createIndex indexName=category_order_set_fk, tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-138','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',136,'EXECUTED','8:f09e2fb2224ce21fcef36d29b130aa92','createIndex indexName=cohort_creator, tableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-139','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',137,'EXECUTED','8:4029038a2a09d5f0815d7e34592c64be','createIndex indexName=cohort_member_creator, tableName=cohort_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-140','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',138,'EXECUTED','8:606356b2cb0496204c4d88883957bd25','createIndex indexName=concept_attribute_attribute_type_id_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-141','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',139,'EXECUTED','8:1e05001c3a7a9e8a9eb97183fc608c2b','createIndex indexName=concept_attribute_changed_by_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-142','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',140,'EXECUTED','8:5f96f8798e5b7b9da72c45b3dc81ac9d','createIndex indexName=concept_attribute_concept_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-143','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',141,'EXECUTED','8:c89c712442a89f2d07ea21f6b60ffc1a','createIndex indexName=concept_attribute_creator_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-144','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',142,'EXECUTED','8:c10f39874bf68963958a72412fe6bcac','createIndex indexName=concept_attribute_type_changed_by_fk, tableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-145','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:55',143,'EXECUTED','8:28845acfb2c6fa84d47ce725c57f8794','createIndex indexName=concept_attribute_type_creator_fk, tableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-146','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',144,'EXECUTED','8:edf32967a9d82155a0ea8dd8eb2ab6e1','createIndex indexName=concept_attribute_type_retired_by_fk, tableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-147','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',145,'EXECUTED','8:723ad3f4df5d4e3dfd3a85d5ab9b541e','createIndex indexName=concept_attribute_voided_by_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-148','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',146,'EXECUTED','8:4074c61d6b4dae4ab5df098dc9546d7b','createIndex indexName=concept_class_changed_by, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-149','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',147,'EXECUTED','8:d2fe72bcd363d8819fae99cfa833b6bb','createIndex indexName=concept_class_creator, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-150','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',148,'EXECUTED','8:6e676415380fef7f1ac0d9f9033aca69','createIndex indexName=concept_class_name_index, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-151','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',149,'EXECUTED','8:38e8f613e1b7a518ba6ed47e80e6f8ca','createIndex indexName=concept_class_retired_status, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-152','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',150,'EXECUTED','8:b74346ab17f12599f02e5bea00781e31','createIndex indexName=concept_classes, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-153','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',151,'EXECUTED','8:f302942598e5281d4edaa8eab7b4ade4','createIndex indexName=concept_creator, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-154','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',152,'EXECUTED','8:8af66bd30f40514f5663229d3f558a52','createIndex indexName=concept_datatype_creator, tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-155','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:56',153,'EXECUTED','8:0eb97161e6a7cea441a2ed63e804feaa','createIndex indexName=concept_datatype_name_index, tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-156','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',154,'EXECUTED','8:988e10b41ee14ab190aabac3111ecc84','createIndex indexName=concept_datatype_retired_status, tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-157','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',155,'EXECUTED','8:e9d6fb1e47328e7d59c1ddbf308dea70','createIndex indexName=concept_datatypes, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-158','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',156,'EXECUTED','8:b245869dccd4b5adbc79240f66334db4','createIndex indexName=concept_for_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-159','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',157,'EXECUTED','8:b47fb81e5fd807f6999454f313e4fb88','createIndex indexName=concept_for_proposal, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-160','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',158,'EXECUTED','8:9d6067722574739babcf829fd7005083','createIndex indexName=concept_map_type_for_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-161','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',159,'EXECUTED','8:446797c99cbd566e631792db3f446eb0','createIndex indexName=concept_name_changed_by, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-162','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',160,'EXECUTED','8:fe80f22f46e05ec71478e7ce7c665681','createIndex indexName=concept_name_tag_changed_by, tableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-163','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',161,'EXECUTED','8:97a9fac7c24c6ceb695c173082b6de53','createIndex indexName=concept_reference_source_changed_by, tableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-164','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',162,'EXECUTED','8:983653514a7c9e3c9e7cb3f06f845759','createIndex indexName=concept_reference_term_for_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-165','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',163,'EXECUTED','8:11669081562535928754bc5bcc11a180','createIndex indexName=concept_source_creator, tableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-166','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:57',164,'EXECUTED','8:87a8f1b58cf4f932acdd05c7e1590ff4','createIndex indexName=concept_triggers_conversion, tableName=concept_state_conversion','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-167','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',165,'EXECUTED','8:7369c064030a14e98be1c1b9dd0680bb','createIndex indexName=condition_changed_by_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-168','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',166,'EXECUTED','8:b3b1a267e2f70b822a9ea1dfe6755b1e','createIndex indexName=condition_condition_coded_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-169','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',167,'EXECUTED','8:babb1074f32abb1122b552ca0eda2abd','createIndex indexName=condition_condition_coded_name_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-170','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',168,'EXECUTED','8:e2bda57c42c5a9bf7c854a67b55bf3c7','createIndex indexName=condition_creator_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-171','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',169,'EXECUTED','8:ee4160d92a93933a9b2d17ff9f6b60c5','createIndex indexName=condition_patient_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-172','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',170,'EXECUTED','8:1aa6149355334eb5629ba66c9f4e8488','createIndex indexName=condition_previous_version_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-173','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',171,'EXECUTED','8:a0f5c5a8139591a6dfaa0ebdcb1abf91','createIndex indexName=condition_voided_by_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-174','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',172,'EXECUTED','8:9036796f0a8298a97e6ebbbb44f60269','createIndex indexName=conversion_to_state, tableName=concept_state_conversion','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-175','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',173,'EXECUTED','8:ca5f8b4206708c7a0b265ec52b2036f1','createIndex indexName=defines_attribute_type, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-176','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:58',174,'EXECUTED','8:0e8c8a71f1d7106ab0ee2b7a4e9c1a8e','createIndex indexName=defines_identifier_type, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-177','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',175,'EXECUTED','8:21f248120c7e245a62a62a73f0bca3ac','createIndex indexName=description_for_concept, tableName=concept_description','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-178','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',176,'EXECUTED','8:3947bfa70f2dd628ef3693ef16865e27','createIndex indexName=discontinued_because, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-179','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',177,'EXECUTED','8:16bae96e0a9575b80f7436b65b3c901f','createIndex indexName=dosage_form_concept, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-180','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',178,'EXECUTED','8:aa2f3c125c218015850faf6902216f15','createIndex indexName=drug_changed_by, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-181','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',179,'EXECUTED','8:7923f05b615200e9a0074c5891d30bf9','createIndex indexName=drug_creator, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-182','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',180,'EXECUTED','8:12c2cab925c834a4e3cfd42d35177396','createIndex indexName=drug_dose_limit_units_fk, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-183','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',181,'EXECUTED','8:5504067b12cf6ae817487a6ca5d52d1d','createIndex indexName=drug_for_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-184','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',182,'EXECUTED','8:b3ff030e8d493d861782b7f31a050e0f','createIndex indexName=drug_ingredient_ingredient_id_fk, tableName=drug_ingredient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-185','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',183,'EXECUTED','8:bb3a92181d3b62e7473b880f3d1091c8','createIndex indexName=drug_ingredient_units_fk, tableName=drug_ingredient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-186','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:06:59',184,'EXECUTED','8:2247879088e4582d25b5375883a3831b','createIndex indexName=drug_order_dose_units, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-187','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',185,'EXECUTED','8:a120dbdf3e345dca7ed6ad9f16ee5ee2','createIndex indexName=drug_order_duration_units_fk, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-188','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',186,'EXECUTED','8:3b8d08a476c29d5fd436f49598aeff80','createIndex indexName=drug_order_frequency_fk, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-189','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',187,'EXECUTED','8:6abde870ce9c60dbf78776b3ab7b0747','createIndex indexName=drug_order_quantity_units, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-190','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',188,'EXECUTED','8:5962c1ccc35a4201ad511c5972e4d773','createIndex indexName=drug_order_route_fk, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-191','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',189,'EXECUTED','8:194d1348aad83d4663ff157b6980811b','createIndex indexName=drug_reference_map_creator, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-192','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',190,'EXECUTED','8:7197cb961f010b43e23b0f22fcc8f111','createIndex indexName=drug_retired_by, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-193','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',191,'EXECUTED','8:31c423c71c17e8760f26658c86d6f6e3','createIndex indexName=encounter_changed_by, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-194','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',192,'EXECUTED','8:4afd4079efd3ff663172a71a656cb0af','createIndex indexName=encounter_datetime_idx, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-195','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',193,'EXECUTED','8:dede34974de7f23b44244760df684f5a','createIndex indexName=encounter_diagnosis_changed_by_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-196','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:00',194,'EXECUTED','8:ce1e96338f2fd38358218a1b00930ecf','createIndex indexName=encounter_diagnosis_coded_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-197','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:01',195,'EXECUTED','8:4cf956666910b129c0ba36fc14010d11','createIndex indexName=encounter_diagnosis_coded_name_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-198','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:01',196,'EXECUTED','8:18e31313b0721289a6b9f980c3483ecc','createIndex indexName=encounter_diagnosis_condition_id_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-199','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:01',197,'EXECUTED','8:558a51844de3da4468a37e556f88550c','createIndex indexName=encounter_diagnosis_creator_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-200','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:01',198,'EXECUTED','8:ba1b9af8999b961c8bd24b959adda690','createIndex indexName=encounter_diagnosis_encounter_id_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-201','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:01',199,'EXECUTED','8:4751d44aad47533f7134557462f454d1','createIndex indexName=encounter_diagnosis_patient_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-202','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:01',200,'EXECUTED','8:517763278ae916a8f65aeb738b9071cb','createIndex indexName=encounter_diagnosis_voided_by_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-203','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:01',201,'EXECUTED','8:82914cb547a4e291a05eff545a62e372','createIndex indexName=encounter_for_proposal, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-204','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:01',202,'EXECUTED','8:dfea9f5ed02652ffc5e82180f2b5992e','createIndex indexName=encounter_form, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-205','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:01',203,'EXECUTED','8:6a5edd213c96575bd6da0b995778673c','createIndex indexName=encounter_ibfk_1, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-206','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',204,'EXECUTED','8:dda7f3b1c8972a907b426fd36ba0602e','createIndex indexName=encounter_id_fk, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-207','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',205,'EXECUTED','8:1b085e5a93b7f65318144bdce78c779a','createIndex indexName=encounter_location, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-208','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',206,'EXECUTED','8:3c53772159fdf4203993da96963deb97','createIndex indexName=encounter_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-209','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',207,'EXECUTED','8:4336db4180aeb8bb560bc2d8c97f6a73','createIndex indexName=encounter_observations, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-210','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',208,'EXECUTED','8:c12352d4cf4efd3d17dd66f10d27d583','createIndex indexName=encounter_patient, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-211','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',209,'EXECUTED','8:672cc0e9cd6fea831298ed3ffaf45b10','createIndex indexName=encounter_provider_changed_by, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-212','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',210,'EXECUTED','8:d77e3dc635af12b46d4053e839f9e56a','createIndex indexName=encounter_provider_creator, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-213','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',211,'EXECUTED','8:eda86bd1660dca81f84a0dd9779884f4','createIndex indexName=encounter_provider_voided_by, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-214','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',212,'EXECUTED','8:a0c736f940893bf5c0a56c15d99d7e21','createIndex indexName=encounter_role_changed_by_fk, tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-215','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',213,'EXECUTED','8:3b49284874dfe876e87273e8f2688bed','createIndex indexName=encounter_role_creator_fk, tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-216','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:02',214,'EXECUTED','8:a4a01769a58e5cd2dbd901d9b72c6dac','createIndex indexName=encounter_role_id_fk, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-217','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',215,'EXECUTED','8:4d72025c8c4bac3cd6be806e49d67b7c','createIndex indexName=encounter_role_retired_by_fk, tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-218','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',216,'EXECUTED','8:9d45a4c24d04a5d65220c7f89899c24a','createIndex indexName=encounter_type_changed_by, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-219','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',217,'EXECUTED','8:c5a4bab1f539bd4ced495c005c1a6f7f','createIndex indexName=encounter_type_id, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-220','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',218,'EXECUTED','8:06769795c33557f4889394fc30179450','createIndex indexName=encounter_type_retired_status, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-221','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',219,'EXECUTED','8:1a50f14ad002e48115436ef3665f4c43','createIndex indexName=encounter_visit_id_fk, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-222','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',220,'EXECUTED','8:d37207a166aaca60d194ee966bc7e120','createIndex indexName=family_name2, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-223','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',221,'EXECUTED','8:d4aa398734c837519572e6fcb143f355','createIndex indexName=field_answer_concept, tableName=field_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-224','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',222,'EXECUTED','8:5dd4c8d34f9c8e04b99ccb7c2d12598f','createIndex indexName=field_retired_status, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-225','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',223,'EXECUTED','8:3b5c94c711a49af9fb71d08971423bb8','createIndex indexName=field_within_form, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-226','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:03',224,'EXECUTED','8:38c45e1e9f4030e9e93022f6dc4ed350','createIndex indexName=first_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-227','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',225,'EXECUTED','8:5fcbc0fefca2b7bb36b0d15a0eb99e8f','createIndex indexName=fk_orderer_provider, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-228','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',226,'EXECUTED','8:92329d4c3a194f8543b93d67fccecd19','createIndex indexName=form_containing_field, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-229','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',227,'EXECUTED','8:a8c8db5b52aa3122f0d65888b7700398','createIndex indexName=form_encounter_type, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-230','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',228,'EXECUTED','8:5fd7daba08733913b3e5dcf044c4a82a','createIndex indexName=form_field_hierarchy, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-231','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',229,'EXECUTED','8:c8a1b0aeda085a3c343812e6e2daa18d','createIndex indexName=form_published_and_retired_index, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-232','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',230,'EXECUTED','8:024161f440c8e3fbbf85b098b439ae3f','createIndex indexName=form_published_index, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-233','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',231,'EXECUTED','8:4c6571095e0adeb94f37286e43b5b9d2','createIndex indexName=form_resource_changed_by, tableName=form_resource','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-234','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',232,'EXECUTED','8:023c3e2259f8bb56b2a1cb4a8c35a867','createIndex indexName=form_retired_index, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-235','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',233,'EXECUTED','8:077ed81c7d1f405c4ac4eac7e218fa43','createIndex indexName=global_property_changed_by, tableName=global_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-236','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:04',234,'EXECUTED','8:43a5867d586a7bb3465aa89d95198815','createIndex indexName=has_a, tableName=concept_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-237','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',235,'EXECUTED','8:117418151837815057613901205a080b','createIndex indexName=hl7_in_archive_message_state_idx, tableName=hl7_in_archive','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-238','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',236,'EXECUTED','8:6d3741d2da44192d82d16931f1ac6ac3','createIndex indexName=hl7_source_with_queue, tableName=hl7_in_queue','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-239','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',237,'EXECUTED','8:d95090902ac2b5d451f06d171c4cbf17','createIndex indexName=identifier_creator, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-240','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',238,'EXECUTED','8:5f75e8eaf134aa378d6abed32e7ffef2','createIndex indexName=identifier_name, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-241','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',239,'EXECUTED','8:27c4e5b6e65968bc70a736d1c002ee4f','createIndex indexName=identifier_voider, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-242','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',240,'EXECUTED','8:85e6b78d6cd2d2b38288c093ed45a50c','createIndex indexName=identifies_person, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-243','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',241,'EXECUTED','8:d2ad7f39efadf4ae6e8cc21e028d3ae2','createIndex indexName=idx_code_concept_reference_term, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-244','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',242,'EXECUTED','8:604f6d74b4b564008d52f4e4724025e0','createIndex indexName=idx_concept_set_concept, tableName=concept_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-245','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',243,'EXECUTED','8:073d2de556dcb0d7069d64fc1ac853ac','createIndex indexName=idx_patient_identifier_patient, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-246','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:05',244,'EXECUTED','8:a7118f2301f4b24a6342ef5b45ff9310','createIndex indexName=inherited_role, tableName=role_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-247','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',245,'EXECUTED','8:adebe6e37634bbab5e47e52c6f001b6e','createIndex indexName=inventory_item, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-248','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',246,'EXECUTED','8:9ab129f6cd9a2eb318aa9b6188e10a05','createIndex indexName=last_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-249','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',247,'EXECUTED','8:7116fd0aa0d86192591b5b05562321f7','createIndex indexName=location_attribute_attribute_type_id_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-250','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',248,'EXECUTED','8:55a0e386a302774eb39a51199113f194','createIndex indexName=location_attribute_changed_by_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-251','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',249,'EXECUTED','8:73ff410750d5bd6be3065cf8872da7ad','createIndex indexName=location_attribute_creator_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-252','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',250,'EXECUTED','8:49f63762203223d15f120ef9e10e0d37','createIndex indexName=location_attribute_location_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-253','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',251,'EXECUTED','8:9f081da2d2b5de2bde1c4fffa582c2ff','createIndex indexName=location_attribute_type_changed_by_fk, tableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-254','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',252,'EXECUTED','8:dc08777f447f2daa7b3882f86c1bc70e','createIndex indexName=location_attribute_type_creator_fk, tableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-255','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',253,'EXECUTED','8:08cd9b26671410fa217fcbda4a00df29','createIndex indexName=location_attribute_type_retired_by_fk, tableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-256','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:06',254,'EXECUTED','8:a8104ab3f954e872c1e57069d16b49ba','createIndex indexName=location_attribute_voided_by_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-257','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',255,'EXECUTED','8:f7bfde79464fa0eef95da29ea2ce350e','createIndex indexName=location_changed_by, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-258','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',256,'EXECUTED','8:da61c541398842b05fb3fdc5a2d44825','createIndex indexName=location_retired_status, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-259','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',257,'EXECUTED','8:a76d70c3f03f3db902cc9fb070564974','createIndex indexName=location_tag_changed_by, tableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-260','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',258,'EXECUTED','8:c1e4a003467d3a7586507788c79d6632','createIndex indexName=location_tag_creator, tableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-261','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',259,'EXECUTED','8:40cceeab104549fd7756a182c7b31fce','createIndex indexName=location_tag_map_tag, tableName=location_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-262','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',260,'EXECUTED','8:af9d4ce6100a5afe145c856afc419037','createIndex indexName=location_tag_retired_by, tableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-263','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',261,'EXECUTED','8:b88c90f1f923cde2f9e5b575bc897d24','createIndex indexName=map_creator, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-264','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',262,'EXECUTED','8:aaec6329d2d4888261e450178f7169e0','createIndex indexName=map_for_concept, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-265','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',263,'EXECUTED','8:30d99738aea457ba6229a7b6f5e20cbd','createIndex indexName=mapped_concept_map_type, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-266','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:07',264,'EXECUTED','8:10e3e6f6299728e62066649948857d9a','createIndex indexName=mapped_concept_map_type_ref_term_map, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-267','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',265,'EXECUTED','8:51f56c62985729cfea11d79bef2c188b','createIndex indexName=mapped_concept_name, tableName=concept_name_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-268','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',266,'EXECUTED','8:d83c81bd65c2723b6e2db5d44a0c99b1','createIndex indexName=mapped_concept_name_tag, tableName=concept_name_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-269','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',267,'EXECUTED','8:b0c3a30b6d83eba35cc271b97bf2b88f','createIndex indexName=mapped_concept_proposal, tableName=concept_proposal_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-270','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',268,'EXECUTED','8:a3c3c7616093618de7f90a3bac2d27bc','createIndex indexName=mapped_concept_proposal_tag, tableName=concept_proposal_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-271','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',269,'EXECUTED','8:17a6d1ea0726018afcd68f60d77159f4','createIndex indexName=mapped_concept_reference_term, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-272','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',270,'EXECUTED','8:9a0d34b3c6b7086cbc977a8be7baaff0','createIndex indexName=mapped_concept_source, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-273','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',271,'EXECUTED','8:b550cb7b0906479412351e273260ad7f','createIndex indexName=mapped_term_a, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-274','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',272,'EXECUTED','8:6e11a8dd0c3441dadbe67e7c9c68bf42','createIndex indexName=mapped_term_b, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-275','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',273,'EXECUTED','8:76d42b1c3a55e113b21aa47ccf41907e','createIndex indexName=mapped_user_changed, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-276','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:08',274,'EXECUTED','8:19b3d065a2f192cbe7698cdfdfec4eb0','createIndex indexName=mapped_user_changed_concept_map_type, tableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-277','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',275,'EXECUTED','8:46f0c2de79abb084376f3d0dd760bbd5','createIndex indexName=mapped_user_changed_ref_term, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-278','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',276,'EXECUTED','8:a2cf7b4567d193532eaefe2ce29aff62','createIndex indexName=mapped_user_changed_ref_term_map, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-279','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',277,'EXECUTED','8:64ea4ebae8ea496a009d1f525367370a','createIndex indexName=mapped_user_creator, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-280','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',278,'EXECUTED','8:b3435d6dd1b7880e93aa5edcc74846c7','createIndex indexName=mapped_user_creator_concept_map_type, tableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-281','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',279,'EXECUTED','8:3dc54f80ef612321c91462eccd3a55ec','createIndex indexName=mapped_user_creator_ref_term_map, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-282','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',280,'EXECUTED','8:0a3503af05a7bd7897d95be10c3b3688','createIndex indexName=mapped_user_retired, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-283','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',281,'EXECUTED','8:31d72025fbec4406f9f1cb7c1f033cdb','createIndex indexName=mapped_user_retired_concept_map_type, tableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-284','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',282,'EXECUTED','8:aad8af5f9b037c94eac525a386375b06','createIndex indexName=member_patient, tableName=cohort_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-285','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',283,'EXECUTED','8:bc24e713e119554b17147a3f6a2dfb93','createIndex indexName=middle_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-286','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:09',284,'EXECUTED','8:4ee87d8b126bd60cc9275e7f68c8015d','createIndex indexName=name_for_concept, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-287','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:10',285,'EXECUTED','8:b9d77080d671f9befc731734d1082d2c','createIndex indexName=name_for_person, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-288','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:10',286,'EXECUTED','8:e1cf3551a6093982be076e202c877bea','createIndex indexName=name_of_attribute, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-289','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:10',287,'EXECUTED','8:f20bfdf41671ea836878754bf85cefaf','createIndex indexName=name_of_concept, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-290','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:10',288,'EXECUTED','8:6ab3606ad0d1274f0f855eb01769c936','createIndex indexName=name_of_location, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-291','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:10',289,'EXECUTED','8:04a2e1643f8c67411cae4177290f22b5','createIndex indexName=note_hierarchy, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-292','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:10',290,'EXECUTED','8:502b5e5c51859e2eec91b875bc9abcb0','createIndex indexName=obs_concept, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-293','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:10',291,'EXECUTED','8:722b0dba4b61dcab30b52c887cf9e0b8','createIndex indexName=obs_datetime_idx, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-294','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:10',292,'EXECUTED','8:dce7042a64be9d3a55a5cbcf432e7bf5','createIndex indexName=obs_enterer, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-295','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:10',293,'EXECUTED','8:2c33da9c17d2eaeaee93fc90591b033d','createIndex indexName=obs_grouping_id, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-296','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:11',294,'EXECUTED','8:d84954ea35e785f43984207b617ed02f','createIndex indexName=obs_location, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-297','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:11',295,'EXECUTED','8:b5a33a8491f791f267384902aa798522','createIndex indexName=obs_name_of_coded_value, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-298','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:11',296,'EXECUTED','8:83f5de226100f7e8c6ee067396be02a7','createIndex indexName=obs_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-299','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:11',297,'EXECUTED','8:a192ac50b1fd406192f9924692d4b796','createIndex indexName=obs_order, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-300','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:11',298,'EXECUTED','8:0c18f787da491494b46284585cd17820','createIndex indexName=order_creator, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-301','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:11',299,'EXECUTED','8:1667c90052e388e32df606174648c13a','createIndex indexName=order_for_patient, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-302','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:11',300,'EXECUTED','8:c7b2f400292b0f1b2b3371c9c64e46f1','createIndex indexName=order_frequency_changed_by_fk, tableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-303','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:11',301,'EXECUTED','8:9dce146c0bdb56e141c57d01f0a3d7a6','createIndex indexName=order_frequency_creator_fk, tableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-304','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:11',302,'EXECUTED','8:87f2104877646004907ff88af1d0f110','createIndex indexName=order_frequency_retired_by_fk, tableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-305','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:12',303,'EXECUTED','8:a6d743bf0f9e2a56558455fa5a1d87fa','createIndex indexName=order_group_changed_by_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-306','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:12',304,'EXECUTED','8:a1aafa6be68646d6461ea2ffbf1a8eaa','createIndex indexName=order_group_creator_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-307','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:12',305,'EXECUTED','8:1fd62bd470c97ec9131e196ac9cb2653','createIndex indexName=order_group_encounter_id_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-308','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:12',306,'EXECUTED','8:b5d584dae229bb43b3d5dfac96ff4baa','createIndex indexName=order_group_patient_id_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-309','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:12',307,'EXECUTED','8:3f6b7823a7e57010dc4b96a25697e015','createIndex indexName=order_group_set_id_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-310','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:12',308,'EXECUTED','8:a2b48e2bbe4c1757ae3a99938d81eac5','createIndex indexName=order_group_voided_by_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-311','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:12',309,'EXECUTED','8:a5912184a23044851e8ef42a1b48a7e4','createIndex indexName=order_set_changed_by_fk, tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-312','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:12',310,'EXECUTED','8:fb89530b109069ba8be1c3bb717c2121','createIndex indexName=order_set_creator_fk, tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-313','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:12',311,'EXECUTED','8:a9f9b14070164cc2407c05f8d78b0aa2','createIndex indexName=order_set_member_changed_by_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-314','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',312,'EXECUTED','8:9e380798192199cc558dcf76b86ee383','createIndex indexName=order_set_member_concept_id_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-315','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',313,'EXECUTED','8:ab47cf75996ecd79d4f3e7d51add4f85','createIndex indexName=order_set_member_creator_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-316','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',314,'EXECUTED','8:a4486ddcf3e2bfe7c2af98f689f999f0','createIndex indexName=order_set_member_order_set_id_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-317','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',315,'EXECUTED','8:c33913fec57162ef1d536665aefaa1c4','createIndex indexName=order_set_member_order_type_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-318','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',316,'EXECUTED','8:2038b70c44473ef106edbf302edd26a4','createIndex indexName=order_set_member_retired_by_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-319','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',317,'EXECUTED','8:e6296cd5b7a15e29ffbcde45a4cd0268','createIndex indexName=order_set_retired_by_fk, tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-320','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',318,'EXECUTED','8:8cd746d20e2d3f0cfb478b8fbb3b7976','createIndex indexName=order_type_changed_by, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-321','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',319,'EXECUTED','8:f2dc37c519d6795fd871c18435980f70','createIndex indexName=order_type_parent_order_type, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-322','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',320,'EXECUTED','8:644ef92f3d47d365532eff9953db9793','createIndex indexName=order_type_retired_status, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-323','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:13',321,'EXECUTED','8:ecd6c3abe3ba7670d05bb4f66036e2d0','createIndex indexName=orders_care_setting, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-324','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',322,'EXECUTED','8:d43c7046b4cc96fb2bab5c015230ea82','createIndex indexName=orders_in_encounter, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-325','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',323,'EXECUTED','8:411231af101070ffc908d7c86640b5de','createIndex indexName=orders_order_group_id_fk, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-326','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',324,'EXECUTED','8:b015ed6aaed23eda9c8e04dad894a859','createIndex indexName=parent_cohort, tableName=cohort_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-327','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',325,'EXECUTED','8:7bd03f793dfec28e378b4c7b5f193b83','createIndex indexName=parent_location, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-328','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',326,'EXECUTED','8:e9b88deaeac31b0432fbd4d4d483691e','createIndex indexName=patient_address_creator, tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-329','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',327,'EXECUTED','8:4afe3b113bc16965b318ebd554a09bc8','createIndex indexName=patient_address_void, tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-330','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',328,'EXECUTED','8:ace943334658479bf77701411c6be732','createIndex indexName=patient_identifier_changed_by, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-331','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',329,'EXECUTED','8:6d42130aab478c32de45a24a4bac2a24','createIndex indexName=patient_identifier_ibfk_2, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-332','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',330,'EXECUTED','8:95435cb6c7ff578eb26059b6a7321f72','createIndex indexName=patient_identifier_type_changed_by, tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-333','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:14',331,'EXECUTED','8:38fdd8b1bdea75698ea31430790b340e','createIndex indexName=patient_identifier_type_retired_status, tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-334','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',332,'EXECUTED','8:dcfc5706248f1defc7ea124dbef8ec14','createIndex indexName=patient_in_program, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-335','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',333,'EXECUTED','8:0ef5c8042260eb5634b1665a3f970dc8','createIndex indexName=patient_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-336','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',334,'EXECUTED','8:f6981472e24eb69ed6a696561588fd0e','createIndex indexName=patient_program_attribute_attributetype_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-337','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',335,'EXECUTED','8:f449c5e93c69745dc202a964eb95b43f','createIndex indexName=patient_program_attribute_changed_by_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-338','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',336,'EXECUTED','8:2beba5b0be222efca6a121d118a4ab09','createIndex indexName=patient_program_attribute_creator_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-339','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',337,'EXECUTED','8:958d8644d04dcbe96aad90bb7ca4eed6','createIndex indexName=patient_program_attribute_programid_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-340','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',338,'EXECUTED','8:4b4e07cc31c923fa37f0caaa8bf323df','createIndex indexName=patient_program_attribute_voided_by_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-341','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',339,'EXECUTED','8:ef920ed5a34363bd9ece75f6eb9071d7','createIndex indexName=patient_program_creator, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-342','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',340,'EXECUTED','8:2ce117f1b4c309dd58b48915890bba97','createIndex indexName=patient_program_for_state, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-343','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:15',341,'EXECUTED','8:5e6d0c02499f229cf931498b8c6ae898','createIndex indexName=patient_program_location_id, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-344','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:16',342,'EXECUTED','8:e28c5452f1d034a0ad4f3cf5a0f1df95','createIndex indexName=patient_program_outcome_concept_id_fk, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-345','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:16',343,'EXECUTED','8:e1cab1a84a4e9594b95d9eb6e9643932','createIndex indexName=patient_state_changer, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-346','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:16',344,'EXECUTED','8:59094c6a8698fa471c9b14945960111a','createIndex indexName=patient_state_creator, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-347','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:16',345,'EXECUTED','8:f61e718deb4467f134397c85a65cd48c','createIndex indexName=patient_state_voider, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-348','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:16',346,'EXECUTED','8:c4934fbf7bce4899a852b7e2ac7a0c62','createIndex indexName=person_a_is_person, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-349','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:16',347,'EXECUTED','8:b66c5278a9277f8055bf6e303d4276e8','createIndex indexName=person_address_changed_by, tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-350','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:16',348,'EXECUTED','8:f3ec96539a9c6fa4a8e93f2387d65b25','createIndex indexName=person_attribute_type_retired_status, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-351','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:16',349,'EXECUTED','8:32c296ff73a60f3b9f44519f4e05ada3','createIndex indexName=person_b_is_person, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-352','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:16',350,'EXECUTED','8:0ffc099ac596e6a1e0623448a12d32b7','createIndex indexName=person_birthdate, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-353','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',351,'EXECUTED','8:5d335cd48c9c3622ecdbc9398fba5a49','createIndex indexName=person_death_date, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-354','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',352,'EXECUTED','8:fa9376ea58b6f400fd7b37c634f8439e','createIndex indexName=person_died_because, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-355','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',353,'EXECUTED','8:af83ca3362c3219a38a424b25e6cb9a0','createIndex indexName=person_id_for_user, tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-356','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',354,'EXECUTED','8:10e7a7009c8a68479c8b5d3a3bd723e1','createIndex indexName=person_merge_log_changed_by_fk, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-357','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',355,'EXECUTED','8:aeba6374ce79692cc6c4afdbcbdae230','createIndex indexName=person_merge_log_creator, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-358','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',356,'EXECUTED','8:44d3661ba03f1283fd7ad325dac42206','createIndex indexName=person_merge_log_loser, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-359','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',357,'EXECUTED','8:c85e6c020114981ada1c3e475de966c4','createIndex indexName=person_merge_log_voided_by_fk, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-360','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',358,'EXECUTED','8:03ad1a480aa9c0448d3fd383e831beff','createIndex indexName=person_merge_log_winner, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-361','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',359,'EXECUTED','8:f7b462971b2248a9a77bd476ce5591dc','createIndex indexName=person_obs, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-362','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:17',360,'EXECUTED','8:87b5dc4984cd482af28b829d4a3411e5','createIndex indexName=previous_order_id_order_id, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-363','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:18',361,'EXECUTED','8:481f14ae80e10723e8cdd4d957a32b18','createIndex indexName=previous_version, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-364','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:18',362,'EXECUTED','8:8b988fc20cd05cce87dfca918a67a853','createIndex indexName=primary_drug_concept, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-365','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:18',363,'EXECUTED','8:8035e065236d99f2120a0e0ae7e00e19','createIndex indexName=privilege_definitions, tableName=role_privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-366','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:18',364,'EXECUTED','8:569e556b5127fb85bbd2f762b8abcb0d','createIndex indexName=privilege_which_can_edit, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-367','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:18',365,'EXECUTED','8:b2d66237cf16273ca43a279787abd289','createIndex indexName=privilege_which_can_edit_encounter_type, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-368','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:18',366,'EXECUTED','8:0bad7afd4996f4532aabecc55c05c6f9','createIndex indexName=privilege_which_can_view_encounter_type, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-369','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:18',367,'EXECUTED','8:1b95d72f022d870a00e7a1306eaed6af','createIndex indexName=program_attribute_type_changed_by_fk, tableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-370','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:18',368,'EXECUTED','8:0666dfeda180082f4a8ce20d4672aabb','createIndex indexName=program_attribute_type_creator_fk, tableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-371','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:18',369,'EXECUTED','8:cb4803b0dcbc70a13a2bf54dd7b04c93','createIndex indexName=program_attribute_type_retired_by_fk, tableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-372','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',370,'EXECUTED','8:4fceeddc65527f6aff2db27629515acc','createIndex indexName=program_concept, tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-373','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',371,'EXECUTED','8:c860ac227d0114f62112a04072c5d8b3','createIndex indexName=program_creator, tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-374','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',372,'EXECUTED','8:fc67efa5176469047ee0366b3cf61606','createIndex indexName=program_for_patient, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-375','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',373,'EXECUTED','8:802d71f2abb2ed1c9596adaefa80f25a','createIndex indexName=program_for_workflow, tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-376','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',374,'EXECUTED','8:6de848917d554d43146c6d60ce7c1654','createIndex indexName=program_outcomes_concept_id_fk, tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-377','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',375,'EXECUTED','8:a40909e40fd6c37a4c77d0db07af0c35','createIndex indexName=proposal_obs_concept_id, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-378','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',376,'EXECUTED','8:97f396dababa47ad282f35d66387010f','createIndex indexName=proposal_obs_id, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-379','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',377,'EXECUTED','8:7878b52a263400367ae2f19ee2ffea2c','createIndex indexName=provider_attribute_attribute_type_id_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-380','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',378,'EXECUTED','8:b1e716f65494df103352dce39165d467','createIndex indexName=provider_attribute_changed_by_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-381','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',379,'EXECUTED','8:1a3991173a1a6c1cbedcfd8f38b23d46','createIndex indexName=provider_attribute_creator_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-382','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:19',380,'EXECUTED','8:2f926bc27f17c6b5761c743e12bc4704','createIndex indexName=provider_attribute_provider_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-383','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:20',381,'EXECUTED','8:c82699b775351d2324ca4f3797bd2aa0','createIndex indexName=provider_attribute_type_changed_by_fk, tableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-384','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:20',382,'EXECUTED','8:c8769a761efe89c1327d1f45c3e6804b','createIndex indexName=provider_attribute_type_creator_fk, tableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-385','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:20',383,'EXECUTED','8:5a015c038de4e1bfb150845cc8dcd1fd','createIndex indexName=provider_attribute_type_retired_by_fk, tableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-386','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:20',384,'EXECUTED','8:071b3b36b034dde1fb3eac03d76dc3c2','createIndex indexName=provider_attribute_voided_by_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-387','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:20',385,'EXECUTED','8:28391123e016ecedc9e92aaa7002a9a5','createIndex indexName=provider_changed_by_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-388','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:20',386,'EXECUTED','8:6150efa0ff3b5fd0ac858125c1a470ce','createIndex indexName=provider_creator_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-389','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:20',387,'EXECUTED','8:14b0b358db728ed4432e8de5dc0909e4','createIndex indexName=provider_id_fk, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-390','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:20',388,'EXECUTED','8:60671017da9f7c68ceeb70574da92295','createIndex indexName=provider_person_id_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-391','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:20',389,'EXECUTED','8:d1b4399b5599817e9b1159107eefe938','createIndex indexName=provider_retired_by_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-392','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:21',390,'EXECUTED','8:0faeedc4e3cb554ffcfb7d184a9b8ca5','createIndex indexName=provider_role_id_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-393','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:21',391,'EXECUTED','8:3b20f44b1dbc5ad8f3bd825b45e89984','createIndex indexName=provider_speciality_id_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-394','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:21',392,'EXECUTED','8:c1d0126a6bf573cae8fcb664270333c7','createIndex indexName=relation_creator, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-395','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:21',393,'EXECUTED','8:727751987bccbb0bd271dcb57a46e2f3','createIndex indexName=relation_voider, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-396','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:21',394,'EXECUTED','8:02c1b06ef9c6be308a00d4df8da55eb6','createIndex indexName=relationship_changed_by, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-397','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:21',395,'EXECUTED','8:975371d15b7b0a5e52af044c7d3f6a28','createIndex indexName=relationship_type_changed_by, tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-398','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:21',396,'EXECUTED','8:2f66bc5bb41570ae45a5ab255469fcd4','createIndex indexName=relationship_type_id, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-399','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:21',397,'EXECUTED','8:60c176b60dcff5580d0f22a012633b25','createIndex indexName=report_object_creator, tableName=report_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-400','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:21',398,'EXECUTED','8:7c638e546bd699a279d62b0d36489c57','createIndex indexName=role_definitions, tableName=user_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-401','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',399,'EXECUTED','8:c89862f1966d03c0884d245fdaf4a88f','createIndex indexName=role_privilege_to_role, tableName=role_privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-402','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',400,'EXECUTED','8:58a56ac393d2f6c48126a8adba8a9a66','createIndex indexName=route_concept, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-403','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',401,'EXECUTED','8:345907215bab087d0035d000afa9a514','createIndex indexName=scheduler_changer, tableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-404','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',402,'EXECUTED','8:8ba6f3cf03f4489d612f25773dcad889','createIndex indexName=scheduler_creator, tableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-405','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',403,'EXECUTED','8:99d9e2f3721be928d0c43ca256e12728','createIndex indexName=serialized_object_changed_by, tableName=serialized_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-406','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',404,'EXECUTED','8:dc694719e402b67c9639afee8af3b75c','createIndex indexName=serialized_object_creator, tableName=serialized_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-407','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',405,'EXECUTED','8:7437d93c8757fb55aa919bf21b456a0f','createIndex indexName=serialized_object_retired_by, tableName=serialized_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-408','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',406,'EXECUTED','8:e8e2d575a45d7de72c502acc8d6c006c','createIndex indexName=state_changed_by, tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-409','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',407,'EXECUTED','8:3f7b636456460832ee260a18eb162a6c','createIndex indexName=state_concept, tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-410','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:22',408,'EXECUTED','8:81fc984d8bff19515079254bdfce4802','createIndex indexName=state_creator, tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-411','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',409,'EXECUTED','8:f2c40d95494570530e077694d500fbba','createIndex indexName=state_for_patient, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-412','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',410,'EXECUTED','8:11c673d5fe793dde11022be10f69d93f','createIndex indexName=task_config_for_property, tableName=scheduler_task_config_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-413','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',411,'EXECUTED','8:0b3d1d47a36a661b8367b2d90e21e362','createIndex indexName=test_order_frequency_fk, tableName=test_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-414','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',412,'EXECUTED','8:cee34c547f13180783fb9f02e79a28e0','createIndex indexName=test_order_specimen_source_fk, tableName=test_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-415','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',413,'EXECUTED','8:30777b65a5778c2830ab812ea875d684','createIndex indexName=type_created_by, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-416','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',414,'EXECUTED','8:4f750963d8d22945764a40f9349c9bb9','createIndex indexName=type_creator, tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-417','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',415,'EXECUTED','8:72c791b5132cf0715a6f75e6339c2780','createIndex indexName=type_of_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-418','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',416,'EXECUTED','8:2635f2461e75c0f71a74049ee425d379','createIndex indexName=type_of_order, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-419','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',417,'EXECUTED','8:98a1414be57317ab27d544e18c5ff1a8','createIndex indexName=user_creator, tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-420','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:23',418,'EXECUTED','8:6a79b0e1a0cf53e5fe69cd7e9fdb1a23','createIndex indexName=user_role_to_users, tableName=user_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-421','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',419,'EXECUTED','8:4916c9528fc492d433ad57cef358518d','createIndex indexName=user_who_changed, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-422','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',420,'EXECUTED','8:2dcbd1f067b5fe3c83c2613efd2d1ce3','createIndex indexName=user_who_changed_alert, tableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-423','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',421,'EXECUTED','8:c22cb21d67fe46c765e31421cbdbba78','createIndex indexName=user_who_changed_cohort, tableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-424','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',422,'EXECUTED','8:12e40bf834814c64bd67441cc66450b8','createIndex indexName=user_who_changed_concept, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-425','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',423,'EXECUTED','8:97f4d48da9b98a9797f11bd2e121e3bb','createIndex indexName=user_who_changed_description, tableName=concept_description','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-426','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',424,'EXECUTED','8:31934f744d48a9d20bbd99af206f3666','createIndex indexName=user_who_changed_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-427','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',425,'EXECUTED','8:1b013a4f078f3b18bba0c97bd807be90','createIndex indexName=user_who_changed_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-428','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',426,'EXECUTED','8:84e66526131ba5b2f75ef7b0a475cb97','createIndex indexName=user_who_changed_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-429','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',427,'EXECUTED','8:3b0867d2fa7c5bbfa2e0151ff998c0a9','createIndex indexName=user_who_changed_pat, tableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-430','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:24',428,'EXECUTED','8:0122464ab2e25489a251a835254933b2','createIndex indexName=user_who_changed_person, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-431','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:25',429,'EXECUTED','8:295451a8413d60bf3a126b7c0a377dec','createIndex indexName=user_who_changed_program, tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-432','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:25',430,'EXECUTED','8:2a9363c78f4846cf41045c6f203573b8','createIndex indexName=user_who_changed_proposal, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-433','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:25',431,'EXECUTED','8:80eaf4b1de0dda76c24bf41ada886534','createIndex indexName=user_who_changed_report_object, tableName=report_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-434','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:25',432,'EXECUTED','8:d08c61d242968617b703fc25d88d2c97','createIndex indexName=user_who_changed_user, tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-435','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:25',433,'EXECUTED','8:e9b1959ae3773a7b5381225a307b25a7','createIndex indexName=user_who_created, tableName=concept_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-436','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:25',434,'EXECUTED','8:dec84946e9ef350fee9bf9e564565ae7','createIndex indexName=user_who_created_description, tableName=concept_description','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-437','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:25',435,'EXECUTED','8:2267a0e2ef7c5c12e1136d8fc58ee817','createIndex indexName=user_who_created_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-438','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:25',436,'EXECUTED','8:cc980da2d5334af135b31baab720a8b7','createIndex indexName=user_who_created_field_answer, tableName=field_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-439','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:25',437,'EXECUTED','8:b4e1b4ef31eed23b036e69759ed6d362','createIndex indexName=user_who_created_field_type, tableName=field_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-440','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:26',438,'EXECUTED','8:4c9ab7f6f116fb6d180165aa4314c4f9','createIndex indexName=user_who_created_form, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-441','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:26',439,'EXECUTED','8:d1435b63968d4ac2ff7656d2f26c596d','createIndex indexName=user_who_created_form_field, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-442','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:26',440,'EXECUTED','8:d60b12848c9dbbf1c87a640ba1f1464e','createIndex indexName=user_who_created_hl7_source, tableName=hl7_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-443','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:26',441,'EXECUTED','8:77e3f63aae12ba9d898a35ab6fe95592','createIndex indexName=user_who_created_location, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-444','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:26',442,'EXECUTED','8:e5b1e2c2a208fc667cab964139db2a5b','createIndex indexName=user_who_created_name, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-445','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:26',443,'EXECUTED','8:482b94f4c8a17498c0ea738a069e3b64','createIndex indexName=user_who_created_name_tag, tableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-446','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:26',444,'EXECUTED','8:b7ac3e14096bec7ec7488c25b0f3a459','createIndex indexName=user_who_created_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-447','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:26',445,'EXECUTED','8:831f45000783dbdccbd088d9f1fe2b94','createIndex indexName=user_who_created_patient, tableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-448','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',446,'EXECUTED','8:cf226ccbf7971a8a9ca0d248d495ba02','createIndex indexName=user_who_created_person, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-449','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',447,'EXECUTED','8:35887a2b53f4cdfc1d6bfbdf1f08c935','createIndex indexName=user_who_created_proposal, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-450','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',448,'EXECUTED','8:4f2fdf3f432374182921e1e7549ec23c','createIndex indexName=user_who_created_rel, tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-451','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',449,'EXECUTED','8:2e9acebbfe25234f77fb27d8073d54a3','createIndex indexName=user_who_created_type, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-452','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',450,'EXECUTED','8:efc6dd67eaa7c5c4d10a3ec3a31b6ffb','createIndex indexName=user_who_last_changed_form, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-453','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',451,'EXECUTED','8:3626af26aefa67355dbdc1443c425dc9','createIndex indexName=user_who_last_changed_form_field, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-454','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',452,'EXECUTED','8:dba003f29a0c1a018bb4d6b19bb8ea82','createIndex indexName=user_who_made_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-455','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',453,'EXECUTED','8:596d63992b7500d2857ff9b591a5867a','createIndex indexName=user_who_retired_concept, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-456','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',454,'EXECUTED','8:22c383f0c05fdab71781e7a590e548e6','createIndex indexName=user_who_retired_concept_class, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-457','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:27',455,'EXECUTED','8:38342c5f7d175b5085fe7779daed6a25','createIndex indexName=user_who_retired_concept_datatype, tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-458','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',456,'EXECUTED','8:6b4329d504bbeef8d05f63c829474fa5','createIndex indexName=user_who_retired_concept_source, tableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-459','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',457,'EXECUTED','8:be03b0886a60a4801fd01afe63879796','createIndex indexName=user_who_retired_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-460','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',458,'EXECUTED','8:e16cbf2b5aaefb822e1077ad4752fcd7','createIndex indexName=user_who_retired_encounter_type, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-461','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',459,'EXECUTED','8:cc548a866306eedbab3ba3ccd03d87fa','createIndex indexName=user_who_retired_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-462','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',460,'EXECUTED','8:81ce0f64dd3f0a7e91dcdbdeefd2eabf','createIndex indexName=user_who_retired_form, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-463','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',461,'EXECUTED','8:b71173f28e535bf7348e6a3c7557dd7b','createIndex indexName=user_who_retired_location, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-464','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',462,'EXECUTED','8:6372653c2c49f52453fbf46af792d8a8','createIndex indexName=user_who_retired_order_type, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-465','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',463,'EXECUTED','8:d3e96ecd89da6c8fe015b2574708eca0','createIndex indexName=user_who_retired_patient_identifier_type, tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-466','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',464,'EXECUTED','8:d833b27872a872339fc8028162d0cdc8','createIndex indexName=user_who_retired_person_attribute_type, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-467','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:28',465,'EXECUTED','8:7fd5577476509af77746aecc8b078ab6','createIndex indexName=user_who_retired_relationship_type, tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-468','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:29',466,'EXECUTED','8:1d661628f98b448fce38d7aa3e0bede7','createIndex indexName=user_who_retired_this_user, tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-469','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:29',467,'EXECUTED','8:5852f80d0e0ef4359873f542c2747a63','createIndex indexName=user_who_voided_cohort, tableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-470','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:29',468,'EXECUTED','8:ab96b9937398cd4e1449dec3506e528e','createIndex indexName=user_who_voided_encounter, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-471','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:29',469,'EXECUTED','8:2bf627a24b3a4101ad2cf42aebc6f170','createIndex indexName=user_who_voided_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-472','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:29',470,'EXECUTED','8:988da7b1d6f2c4056885ecfcf0f9a57d','createIndex indexName=user_who_voided_name_tag, tableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-473','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:29',471,'EXECUTED','8:2219bbfb05637be221bef4bc9a853477','createIndex indexName=user_who_voided_obs, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-474','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:29',472,'EXECUTED','8:9e19e62c8650a5aefb0e6c2602764586','createIndex indexName=user_who_voided_order, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-475','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:29',473,'EXECUTED','8:6e61ed99aa6f483b97bd3d01301171f9','createIndex indexName=user_who_voided_patient, tableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-476','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:29',474,'EXECUTED','8:35bb5780c5059d400cac524f0301abd0','createIndex indexName=user_who_voided_patient_program, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-477','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',475,'EXECUTED','8:714686779f3d31877568eccb91700375','createIndex indexName=user_who_voided_person, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-478','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',476,'EXECUTED','8:9eeded0707368de50c3ee0add3c2e8b2','createIndex indexName=user_who_voided_report_object, tableName=report_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-479','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',477,'EXECUTED','8:3f9860528ccc3a3ae04d7e8aca6f44e1','createIndex indexName=user_who_voided_this_name, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-480','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',478,'EXECUTED','8:b9a65b7ab309bdd46ba4f2c449115ff7','createIndex indexName=visit_attribute_attribute_type_id_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-481','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',479,'EXECUTED','8:abb19811e24e0f8e496c1fa04d44c32e','createIndex indexName=visit_attribute_changed_by_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-482','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',480,'EXECUTED','8:a2626b27d70186539932878526685946','createIndex indexName=visit_attribute_creator_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-483','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',481,'EXECUTED','8:303466c6d7bf9f3da0b0d284d6ceb254','createIndex indexName=visit_attribute_type_changed_by_fk, tableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-484','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',482,'EXECUTED','8:9e79bc736ad1da58baa5e7e6a7865b63','createIndex indexName=visit_attribute_type_creator_fk, tableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-485','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',483,'EXECUTED','8:d7b6dd39ec5c3dbd6ede2a3c125c2109','createIndex indexName=visit_attribute_type_retired_by_fk, tableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-486','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:30',484,'EXECUTED','8:7abf34988c450d665e0cdeb647f80119','createIndex indexName=visit_attribute_visit_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-487','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',485,'EXECUTED','8:a988a83b44131d10905757c01b41d39e','createIndex indexName=visit_attribute_voided_by_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-488','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',486,'EXECUTED','8:ed5026748c07dc69aa88ee02efc0d531','createIndex indexName=visit_changed_by_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-489','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',487,'EXECUTED','8:821728f2ac5511a778103702e2758d66','createIndex indexName=visit_creator_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-490','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',488,'EXECUTED','8:3c6b43e507d00b5bfb092c11eb16b0ec','createIndex indexName=visit_indication_concept_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-491','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',489,'EXECUTED','8:026070962492dcdc88e33096b8f34690','createIndex indexName=visit_location_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-492','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',490,'EXECUTED','8:fe8454bcd5df128318c029e22ad9e9ea','createIndex indexName=visit_patient_index, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-493','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',491,'EXECUTED','8:422143f23d4dd075db333a41c242fe94','createIndex indexName=visit_type_changed_by, tableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-494','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',492,'EXECUTED','8:d334a839fdff81402550989673440de6','createIndex indexName=visit_type_creator, tableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-495','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',493,'EXECUTED','8:42aae037b40bfe2fae6e57dba78e4381','createIndex indexName=visit_type_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-496','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:31',494,'EXECUTED','8:f947d1867f95025430145d95911af633','createIndex indexName=visit_type_retired_by, tableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-497','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:32',495,'EXECUTED','8:c4045e420af7ca5b14cf317fd211cda1','createIndex indexName=visit_voided_by_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-498','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:32',496,'EXECUTED','8:3d95ff0d3142092fa058978762d39599','createIndex indexName=workflow_changed_by, tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-499','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:32',497,'EXECUTED','8:3000c224f29f0dae2ab9005d36b178a0','createIndex indexName=workflow_concept, tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-500','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:32',498,'EXECUTED','8:6bcb3a192f7a5cf3c1ace2f3bd41cd77','createIndex indexName=workflow_creator, tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-501','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:32',499,'EXECUTED','8:eb75a8f45e6abce58d20c2215b7e4f14','createIndex indexName=workflow_for_state, tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-502','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:32',500,'EXECUTED','8:b6e1c8e8fc47af4830e99c9013b80fb2','addForeignKeyConstraint baseTableName=person_address, constraintName=address_for_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-503','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:33',501,'EXECUTED','8:1ec946ec8939be01efbbb88cf8fa56f9','addForeignKeyConstraint baseTableName=notification_alert, constraintName=alert_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-504','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:33',502,'EXECUTED','8:39db8f28c8000a553adb6ba15530c4b6','addForeignKeyConstraint baseTableName=notification_alert_recipient, constraintName=alert_read_by_user, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-505','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:33',503,'EXECUTED','8:973d36344c1dfc1c9b50e8e088c0652a','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-506','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:34',504,'EXECUTED','8:a8a2bfcfcd93cbed9981ac64456f5854','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_coded_allergen_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-507','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:34',505,'EXECUTED','8:25b1d85ad004674ca5a2eb96e5c42fb2','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-508','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:34',506,'EXECUTED','8:b8da87293e10f64fcfe4746997cf1194','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_patient_id_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-509','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:35',507,'EXECUTED','8:da9b1b2931d5cb6d8467df67e4170771','addForeignKeyConstraint baseTableName=allergy_reaction, constraintName=allergy_reaction_allergy_id_fk, referencedTableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-510','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:35',508,'EXECUTED','8:23d4467b422513efd10b68ef30607187','addForeignKeyConstraint baseTableName=allergy_reaction, constraintName=allergy_reaction_reaction_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-511','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:35',509,'EXECUTED','8:0b98d57fb66075dffdc6f0327b0ed51a','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_severity_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-512','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:36',510,'EXECUTED','8:76c04d554dccd13fe1668f569b17e62a','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-513','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:36',511,'EXECUTED','8:bacea2a759845361696795b01b15a774','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answer, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-514','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:37',512,'EXECUTED','8:5425a5305a81c382842f827738b2eba7','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answer_answer_drug_fk, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-515','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:37',513,'EXECUTED','8:d08eeab2acb74694acb823d3bd33683c','addForeignKeyConstraint baseTableName=obs, constraintName=answer_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-516','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:37',514,'EXECUTED','8:993ba5f29b8b033d85f2d67278b91aeb','addForeignKeyConstraint baseTableName=obs, constraintName=answer_concept_drug, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-517','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:38',515,'EXECUTED','8:ff36e32f75908f129f488a847418993a','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answer_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-518','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:38',516,'EXECUTED','8:99814a0e717b6e85599784487fa515ed','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answers_for_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-519','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:38',517,'EXECUTED','8:f654d22286db16b023d7c8efc12b6dbd','addForeignKeyConstraint baseTableName=field_answer, constraintName=answers_for_field, referencedTableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-520','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:39',518,'EXECUTED','8:8604b3b4fb3677cd5d849d27de8f6747','addForeignKeyConstraint baseTableName=person_attribute, constraintName=attribute_changer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-521','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:39',519,'EXECUTED','8:1f3af68eb9a72c0828976c0c988bc2ef','addForeignKeyConstraint baseTableName=person_attribute, constraintName=attribute_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-522','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:40',520,'EXECUTED','8:35eada7bb99cf639a17421fc86975d2a','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=attribute_type_changer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-523','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:40',521,'EXECUTED','8:5564f9398f0cb98de98d54685d56f91d','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=attribute_type_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-524','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:40',522,'EXECUTED','8:fd53f94868cf335848f17cc5af41ebe6','addForeignKeyConstraint baseTableName=person_attribute, constraintName=attribute_voider, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-525','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:41',523,'EXECUTED','8:6ff79c01470986df7e6fd8389a055b34','addForeignKeyConstraint baseTableName=care_setting, constraintName=care_setting_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-526','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:41',524,'EXECUTED','8:d5d65fa61eacf27e22c3b73bf4964280','addForeignKeyConstraint baseTableName=care_setting, constraintName=care_setting_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-527','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:41',525,'EXECUTED','8:1262c08379f097648c81983b83c828ab','addForeignKeyConstraint baseTableName=care_setting, constraintName=care_setting_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-528','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:42',526,'EXECUTED','8:14f51cb7024cf4b9d0cf5de40b1bd656','addForeignKeyConstraint baseTableName=order_set, constraintName=category_order_set_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-529','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:42',527,'EXECUTED','8:28f0560443db9c0778378585f3aba7c0','addForeignKeyConstraint baseTableName=cohort, constraintName=cohort_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-530','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:42',528,'EXECUTED','8:3b4adf2a5b7f7ceb9a15070e9a5a9dea','addForeignKeyConstraint baseTableName=cohort_member, constraintName=cohort_member_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-531','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:43',529,'EXECUTED','8:676a6c5d4e74361903a325056751786c','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_attribute_type_id_fk, referencedTableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-532','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:43',530,'EXECUTED','8:12553549877cfe05e628cc81edc92430','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-533','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:43',531,'EXECUTED','8:8f623fcdb9898edc0c01116c3e0246b7','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_concept_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-534','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:44',532,'EXECUTED','8:d78557d92aea1aab6f039afdd95277f6','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-535','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:44',533,'EXECUTED','8:d5726b2f1d411facb9f9cc2b4c1c8d74','addForeignKeyConstraint baseTableName=concept_attribute_type, constraintName=concept_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-536','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:44',534,'EXECUTED','8:d8810b69d852f158a0a6a8d090746c1d','addForeignKeyConstraint baseTableName=concept_attribute_type, constraintName=concept_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-537','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:45',535,'EXECUTED','8:4732421cdb4b33ae6a472a42ab7e5ac7','addForeignKeyConstraint baseTableName=concept_attribute_type, constraintName=concept_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-538','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:45',536,'EXECUTED','8:2818e68c416aa6371d7f7f2e0d5bf4a8','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-539','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:45',537,'EXECUTED','8:2a31268e8389ead337d01f761437ef02','addForeignKeyConstraint baseTableName=concept_complex, constraintName=concept_attributes, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-540','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:46',538,'EXECUTED','8:649f717179083bfdd1724cef6b4bae49','addForeignKeyConstraint baseTableName=concept_class, constraintName=concept_class_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-541','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:46',539,'EXECUTED','8:16116d24f478ae4256a3f4cd89ddf1b8','addForeignKeyConstraint baseTableName=concept_class, constraintName=concept_class_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-542','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:46',540,'EXECUTED','8:aa266368ce23dab47453fe16faf532fc','addForeignKeyConstraint baseTableName=concept, constraintName=concept_classes, referencedTableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-543','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:47',541,'EXECUTED','8:ae87e3825b9e50d9e517b0730d8283a9','addForeignKeyConstraint baseTableName=concept, constraintName=concept_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-544','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:47',542,'EXECUTED','8:d103964c3dc48330db9e9a25c14291bf','addForeignKeyConstraint baseTableName=concept_datatype, constraintName=concept_datatype_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-545','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:47',543,'EXECUTED','8:f373e4b204964bdfe5f5bd88655f08ca','addForeignKeyConstraint baseTableName=concept, constraintName=concept_datatypes, referencedTableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-546','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:48',544,'EXECUTED','8:da92ad33e8b6e0303f010ea16f828c4f','addForeignKeyConstraint baseTableName=field, constraintName=concept_for_field, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-547','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:48',545,'EXECUTED','8:c903a4ac7b7d7c3af47dff734b968c05','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=concept_for_proposal, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-548','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:49',546,'EXECUTED','8:1754fb36a03905b0820d15547552be80','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=concept_map_type_for_drug_reference_map, referencedTableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-549','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:49',547,'EXECUTED','8:f8cc69b9aaf639c2a557ed449dafb707','addForeignKeyConstraint baseTableName=concept_name, constraintName=concept_name_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-550','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:49',548,'EXECUTED','8:a0b92c973cbe7a7186c5b1b3247c8324','addForeignKeyConstraint baseTableName=concept_name_tag, constraintName=concept_name_tag_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-551','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:50',549,'EXECUTED','8:7f55c49f252271863a74efec5dca6963','addForeignKeyConstraint baseTableName=concept_reference_source, constraintName=concept_reference_source_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-552','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:50',550,'EXECUTED','8:8200585e5fc54aad32f7e13429a7b028','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=concept_reference_term_for_drug_reference_map, referencedTableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-553','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:50',551,'EXECUTED','8:45d8c4a52f4c4ae3d8a2bff4c1781651','addForeignKeyConstraint baseTableName=concept_reference_source, constraintName=concept_source_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-554','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:51',552,'EXECUTED','8:00339eef1ba1912570d3ea905417c5b1','addForeignKeyConstraint baseTableName=concept_state_conversion, constraintName=concept_triggers_conversion, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-555','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:51',553,'EXECUTED','8:e85ae80b67cfd4db417e33e318701d3c','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-556','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:52',554,'EXECUTED','8:ab139110539c388d66a8f2f0013d1b0b','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_condition_coded_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-557','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:52',555,'EXECUTED','8:58d73cee6c614043fb3733e0dbe6d479','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_condition_coded_name_fk, referencedTableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-558','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:52',556,'EXECUTED','8:bc12d124077f87e9da7cdb1e8ef07f1e','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-559','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:53',557,'EXECUTED','8:aa7b42a352b4fc7b59f2d8229b1c5bb6','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_patient_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-560','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:53',558,'EXECUTED','8:2090aa26bbe56d51c4b25f009036d3cd','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_previous_version_fk, referencedTableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-561','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:53',559,'EXECUTED','8:a6662d3138a91c5451f019920120b309','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-562','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:54',560,'EXECUTED','8:c45d4124278063454e28412966c3d075','addForeignKeyConstraint baseTableName=concept_state_conversion, constraintName=conversion_involves_workflow, referencedTableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-563','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:54',561,'EXECUTED','8:f783ec8d57cab054d9d241495c7cdcab','addForeignKeyConstraint baseTableName=concept_state_conversion, constraintName=conversion_to_state, referencedTableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-564','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:54',562,'EXECUTED','8:af744a99c04da67bf99e80174bebe15f','addForeignKeyConstraint baseTableName=person_attribute, constraintName=defines_attribute_type, referencedTableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-565','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:55',563,'EXECUTED','8:faed525320f2f83c920d665a965001e5','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=defines_identifier_type, referencedTableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-566','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:55',564,'EXECUTED','8:09c26ff9f5c725b7cb40b0c494295c95','addForeignKeyConstraint baseTableName=concept_description, constraintName=description_for_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-567','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:56',565,'EXECUTED','8:105fb4739f59d253dc1a015f98cd10d4','addForeignKeyConstraint baseTableName=orders, constraintName=discontinued_because, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-568','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:56',566,'EXECUTED','8:3830fd8cdd434be82eaac016e4edab36','addForeignKeyConstraint baseTableName=drug, constraintName=dosage_form_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-569','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:56',567,'EXECUTED','8:d03afbcbe53ba5021acef4dd28552fb7','addForeignKeyConstraint baseTableName=drug, constraintName=drug_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-570','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:57',568,'EXECUTED','8:5231d12b016b67bfb9e12b2d17abbfe6','addForeignKeyConstraint baseTableName=drug, constraintName=drug_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-571','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:57',569,'EXECUTED','8:f4810867e925ce07cf7d723360968d1a','addForeignKeyConstraint baseTableName=drug, constraintName=drug_dose_limit_units_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-572','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:58',570,'EXECUTED','8:a6c3f0bd9a47a1717f792d0578b70e2f','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=drug_for_drug_reference_map, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-573','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:58',571,'EXECUTED','8:d662c80d9c600f694ddaea7c0192f451','addForeignKeyConstraint baseTableName=drug_ingredient, constraintName=drug_ingredient_drug_id_fk, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-574','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:58',572,'EXECUTED','8:36e2d9e76e86ddcbea122d2e144cdbd9','addForeignKeyConstraint baseTableName=drug_ingredient, constraintName=drug_ingredient_ingredient_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-575','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:59',573,'EXECUTED','8:34084dad7a3a236ceebdb83b3a9e0c1f','addForeignKeyConstraint baseTableName=drug_ingredient, constraintName=drug_ingredient_units_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-576','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:59',574,'EXECUTED','8:c44f51f79df5d4e0468b64f40b5e4f97','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_dose_units, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-577','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:07:59',575,'EXECUTED','8:b33243e95f8262831338df6e20a6d881','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_duration_units_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-578','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:00',576,'EXECUTED','8:53cd923fbefd9a4dd6733945a28a9b62','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_frequency_fk, referencedTableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-579','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:00',577,'EXECUTED','8:0b31914637b8b4e844a556d5c1ea031a','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_quantity_units, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-580','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:00',578,'EXECUTED','8:c7f6ed748327e9baac7ed7953d18ec1c','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_route_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-581','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:01',579,'EXECUTED','8:0253b90367453adf19c09c3013fb8dc3','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=drug_reference_map_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-582','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:01',580,'EXECUTED','8:4dc230f5d02486b8d9c58ae8a01628fc','addForeignKeyConstraint baseTableName=drug, constraintName=drug_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-583','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:02',581,'EXECUTED','8:f143d21018358409bb9581c3e29fc160','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-584','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:02',582,'EXECUTED','8:e25f3380836582dc8052bc1c445f8b60','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-585','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:02',583,'EXECUTED','8:e8554f1f03f07ee3cd1f6b7fe3bf493e','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_coded_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-586','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:03',584,'EXECUTED','8:da2a7be9e55bd45cd780a8df20af60d4','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_coded_name_fk, referencedTableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-587','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:03',585,'EXECUTED','8:c5afe7b601dafc0c40a3cad845fe64fc','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_condition_id_fk, referencedTableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-588','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:04',586,'EXECUTED','8:36b1ccb71ae92fd5223d074da16d632b','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-589','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:04',587,'EXECUTED','8:801acff9a2798f43e2a3641139ad113b','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_encounter_id_fk, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-590','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:05',588,'EXECUTED','8:8aa55bb7c0d793aa392b59f9f93e99ee','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_patient_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-591','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:05',589,'EXECUTED','8:02bd0156780b3e6d53cc1e4bb4dce8cc','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-592','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:05',590,'EXECUTED','8:3970a663eed3b6c3f188662c64edc543','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=encounter_for_proposal, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-593','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:06',591,'EXECUTED','8:210039b231ee3c0e460e0218988e91cc','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_form, referencedTableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-594','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:06',592,'EXECUTED','8:e22246ade5c0e680a0e498c71dd213b7','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_ibfk_1, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-595','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:07',593,'EXECUTED','8:a67709326ffdec1fb396b1945a70027b','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_id_fk, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-596','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:07',594,'EXECUTED','8:e97e2d0264ee91758e2c6fba9d8c4588','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_location, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-597','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:08',595,'EXECUTED','8:012e16d01037b4d01bfb7116d59a8291','addForeignKeyConstraint baseTableName=note, constraintName=encounter_note, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-598','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:08',596,'EXECUTED','8:2d63bc1fade593ead70c0eea87128c8c','addForeignKeyConstraint baseTableName=obs, constraintName=encounter_observations, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-599','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:09',597,'EXECUTED','8:c7012fabbc2393f393eda9ce1520fd2b','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_patient, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-600','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:09',598,'EXECUTED','8:541ce5d1093fdecc87ecc8a765cc324f','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_provider_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-601','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:10',599,'EXECUTED','8:76deded3b3e88e71af862e958685591a','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_provider_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-602','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:10',600,'EXECUTED','8:d5db7b8e7b82e7ac83321c0f7db7fdaa','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_provider_voided_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-603','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:10',601,'EXECUTED','8:316c689f0dd949635c6b461d6da844cb','addForeignKeyConstraint baseTableName=encounter_role, constraintName=encounter_role_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-604','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:11',602,'EXECUTED','8:aad73f4eac8d37b4ff91cfae56647778','addForeignKeyConstraint baseTableName=encounter_role, constraintName=encounter_role_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-605','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:11',603,'EXECUTED','8:6b5d33f7502fa361cccb208ba3ca9612','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_role_id_fk, referencedTableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-606','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:12',604,'EXECUTED','8:63c33f11d1048f4a376ee1988bedcb22','addForeignKeyConstraint baseTableName=encounter_role, constraintName=encounter_role_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-607','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:12',605,'EXECUTED','8:e85bacc187b63072f286b97de56ed71d','addForeignKeyConstraint baseTableName=encounter_type, constraintName=encounter_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-608','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:13',606,'EXECUTED','8:4ecf31c173230b5b38207132ccc18bfd','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_type_id, referencedTableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-609','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:13',607,'EXECUTED','8:01343cf01ebe1e2d3fb1fe460d1b52fc','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_visit_id_fk, referencedTableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-610','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:13',608,'EXECUTED','8:fde37b9094cc447bbef2e81aea9d5f9a','addForeignKeyConstraint baseTableName=drug_order, constraintName=extends_order, referencedTableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-611','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:14',609,'EXECUTED','8:15986d2715766d22ca5aee2fc0fb9760','addForeignKeyConstraint baseTableName=field_answer, constraintName=field_answer_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-612','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:14',610,'EXECUTED','8:40aac8b7fd4955579e5a4335c1ad496e','addForeignKeyConstraint baseTableName=form_field, constraintName=field_within_form, referencedTableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-613','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:14',611,'EXECUTED','8:0fc24b5eb57987ea58550b45692a876d','addForeignKeyConstraint baseTableName=order_type_class_map, constraintName=fk_order_type_class_map_concept_class_concept_class_id, referencedTableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-614','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:15',612,'EXECUTED','8:f8ff2cf7060d71390dd68da84014956c','addForeignKeyConstraint baseTableName=order_type_class_map, constraintName=fk_order_type_order_type_id, referencedTableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-615','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:15',613,'EXECUTED','8:d6a297a45ab7034c4550d06b241d10a9','addForeignKeyConstraint baseTableName=orders, constraintName=fk_orderer_provider, referencedTableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-616','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:15',614,'EXECUTED','8:d4002ab7f9a0f0a7d4276f208e5496c7','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=fk_patient_id_patient_identifier, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-617','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:16',615,'EXECUTED','8:058ade5e67a5e4c9f6774fe26e41cb70','addForeignKeyConstraint baseTableName=form_field, constraintName=form_containing_field, referencedTableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-618','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:16',616,'EXECUTED','8:02b36c3723f68bc2b4bdd77b801e3b70','addForeignKeyConstraint baseTableName=form, constraintName=form_encounter_type, referencedTableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-619','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:17',617,'EXECUTED','8:6e714deb4047c385619bb35497f4dc4e','addForeignKeyConstraint baseTableName=form_field, constraintName=form_field_hierarchy, referencedTableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-620','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:17',618,'EXECUTED','8:ff86dcb00584315dbb04c6e51c410bb5','addForeignKeyConstraint baseTableName=form_resource, constraintName=form_resource_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-621','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:17',619,'EXECUTED','8:ae518a8608ae65f4606e10547d866504','addForeignKeyConstraint baseTableName=form_resource, constraintName=form_resource_form_fk, referencedTableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-622','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:18',620,'EXECUTED','8:66a6f7b82373f3c0c08a68a662f0b4af','addForeignKeyConstraint baseTableName=global_property, constraintName=global_property_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-623','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:18',621,'EXECUTED','8:0a584ebf18cd8dbc521ecb2689f0a1ac','addForeignKeyConstraint baseTableName=concept_set, constraintName=has_a, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-624','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:18',622,'EXECUTED','8:fc455ba76ca852afe49f6e7ce37b1c9d','addForeignKeyConstraint baseTableName=hl7_in_queue, constraintName=hl7_source_with_queue, referencedTableName=hl7_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-625','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:19',623,'EXECUTED','8:de4d1a28261c165a0f1b8f0cd3e2c00b','addForeignKeyConstraint baseTableName=notification_alert_recipient, constraintName=id_of_alert, referencedTableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-626','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:19',624,'EXECUTED','8:b89d5041997285d87092384134d988e2','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=identifier_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-627','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:19',625,'EXECUTED','8:45b1f2e72faae44c6aabb846eb7a7990','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=identifier_voider, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-628','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:20',626,'EXECUTED','8:1ec314a54566d8a1749a7ed7297cbda4','addForeignKeyConstraint baseTableName=person_attribute, constraintName=identifies_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-629','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:20',627,'EXECUTED','8:db807c956e45a33f21cc15672920101a','addForeignKeyConstraint baseTableName=role_role, constraintName=inherited_role, referencedTableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-630','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:20',628,'EXECUTED','8:da5615ab343e9ed9a7d0604ff50bb049','addForeignKeyConstraint baseTableName=drug_order, constraintName=inventory_item, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-631','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:21',629,'EXECUTED','8:559103057592c513461e34872ab98c82','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_attribute_type_id_fk, referencedTableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-632','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:21',630,'EXECUTED','8:f0ed1db50d2aaef52d7787e729067765','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-633','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:22',631,'EXECUTED','8:9053697625cec4b7181154ede82af8e1','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-634','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:22',632,'EXECUTED','8:25fa762d4a54cb768494393188a40f13','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_location_fk, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-635','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:22',633,'EXECUTED','8:55bfc1c498d66b56056252e5e1bf38e3','addForeignKeyConstraint baseTableName=location_attribute_type, constraintName=location_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-636','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:23',634,'EXECUTED','8:caaf7c26f7283691746ca5cf776e17e1','addForeignKeyConstraint baseTableName=location_attribute_type, constraintName=location_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-637','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:23',635,'EXECUTED','8:b28edd14d548454ee5e31d5129932600','addForeignKeyConstraint baseTableName=location_attribute_type, constraintName=location_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-638','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:23',636,'EXECUTED','8:c9858f861bc729085245ab56d1db294c','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-639','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:24',637,'EXECUTED','8:9c5f3393d4a9a88d9b4bd434ea9e1033','addForeignKeyConstraint baseTableName=location, constraintName=location_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-640','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:24',638,'EXECUTED','8:0bd00341f91fb696b1bedccccd73f6c2','addForeignKeyConstraint baseTableName=location_tag, constraintName=location_tag_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-641','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:24',639,'EXECUTED','8:91fc0e963eae16130bcfdd515a5ae281','addForeignKeyConstraint baseTableName=location_tag, constraintName=location_tag_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-642','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:25',640,'EXECUTED','8:61c3eccfbd38970237b9757fb3002fb8','addForeignKeyConstraint baseTableName=location_tag_map, constraintName=location_tag_map_location, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-643','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:25',641,'EXECUTED','8:49c4b5a03214ea9e7195d1a5fcc2b353','addForeignKeyConstraint baseTableName=location_tag_map, constraintName=location_tag_map_tag, referencedTableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-644','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:25',642,'EXECUTED','8:4f3813eecf2d7b5e04f9863404258d84','addForeignKeyConstraint baseTableName=location_tag, constraintName=location_tag_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-645','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:26',643,'EXECUTED','8:c5fdb5309db2ec8e9ed2f0510c9c2138','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=map_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-646','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:26',644,'EXECUTED','8:4a43c5a94c750536bee6b283c505f829','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=map_for_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-647','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:26',645,'EXECUTED','8:54becb16ae94c3222c044550d5d6f056','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=mapped_concept_map_type, referencedTableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-648','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:27',646,'EXECUTED','8:2467bca4029d86bceb6827936123016a','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_concept_map_type_ref_term_map, referencedTableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-649','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:27',647,'EXECUTED','8:2c8ee6ec62f93dcc0f2c5b8049c2302e','addForeignKeyConstraint baseTableName=concept_name_tag_map, constraintName=mapped_concept_name, referencedTableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-650','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:27',648,'EXECUTED','8:123dae6f3c1bdbba9f0e038a75cadd18','addForeignKeyConstraint baseTableName=concept_name_tag_map, constraintName=mapped_concept_name_tag, referencedTableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-651','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:28',649,'EXECUTED','8:6113bb795c41cd648452833ad0042a6f','addForeignKeyConstraint baseTableName=concept_proposal_tag_map, constraintName=mapped_concept_proposal, referencedTableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-652','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:28',650,'EXECUTED','8:bb379d0d109c494e25d0aad46c4b708a','addForeignKeyConstraint baseTableName=concept_proposal_tag_map, constraintName=mapped_concept_proposal_tag, referencedTableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-653','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:28',651,'EXECUTED','8:d43ec007e993bc1ba8a32131d99c4934','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=mapped_concept_reference_term, referencedTableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-654','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:29',652,'EXECUTED','8:082f379958b4b6b0b60f8dacf700120d','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_concept_source, referencedTableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-655','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:29',653,'EXECUTED','8:fbaa69db4de6c1eeb907ffe63b8c0c10','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_term_a, referencedTableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-656','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:29',654,'EXECUTED','8:24f9c07d372054537e2a2ea87bd9631c','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_term_b, referencedTableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-657','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:30',655,'EXECUTED','8:30b7404b3900c6211bca9aed71900491','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_user_changed, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-658','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:30',656,'EXECUTED','8:57c58bfdec0f073948d2e817b630dcab','addForeignKeyConstraint baseTableName=concept_map_type, constraintName=mapped_user_changed_concept_map_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-659','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:31',657,'EXECUTED','8:c821ce1c018a6faf63dd71082055395e','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=mapped_user_changed_ref_term, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-660','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:31',658,'EXECUTED','8:5b7076881c0ac0cf99d8c95b7d444aee','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_user_changed_ref_term_map, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-661','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:31',659,'EXECUTED','8:a1638b45c453e9eb9a3b134bde3f7511','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_user_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-662','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:32',660,'EXECUTED','8:7de2f45294f47a0e11920b3b35c80afc','addForeignKeyConstraint baseTableName=concept_map_type, constraintName=mapped_user_creator_concept_map_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-663','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:32',661,'EXECUTED','8:8e584e915ed85cf967e02bba69ac0dc8','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_user_creator_ref_term_map, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-664','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:33',662,'EXECUTED','8:9134c8a4af26c7c2ea22247618bdfb40','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_user_retired, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-665','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:33',663,'EXECUTED','8:9cc8c64a1e7940f2bb38355dd376c886','addForeignKeyConstraint baseTableName=concept_map_type, constraintName=mapped_user_retired_concept_map_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-666','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:33',664,'EXECUTED','8:3d4258ef0daff9793f9a952fdffb0c41','addForeignKeyConstraint baseTableName=cohort_member, constraintName=member_patient, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-667','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:34',665,'EXECUTED','8:666bc2a7c0279cbfd0305d8ff49ba8ee','addForeignKeyConstraint baseTableName=concept_name, constraintName=name_for_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-668','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:34',666,'EXECUTED','8:701e3bc4a6970fabf97dc342030a4c06','addForeignKeyConstraint baseTableName=person_name, constraintName=name_for_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-669','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:34',667,'EXECUTED','8:d1866f483f3bb96a94eac81896ac1953','addForeignKeyConstraint baseTableName=note, constraintName=note_hierarchy, referencedTableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-670','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:35',668,'EXECUTED','8:cb4d919e70133e597f64007fbf2948b3','addForeignKeyConstraint baseTableName=concept_numeric, constraintName=numeric_attributes, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-671','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:35',669,'EXECUTED','8:ce723ec131e65372d698e8f4f17c31ca','addForeignKeyConstraint baseTableName=obs, constraintName=obs_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-672','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:36',670,'EXECUTED','8:8f9bbcbadb0451fa6b7ce24203ce8657','addForeignKeyConstraint baseTableName=obs, constraintName=obs_enterer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-673','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:36',671,'EXECUTED','8:19db7630095b44733983eb4220261063','addForeignKeyConstraint baseTableName=obs, constraintName=obs_grouping_id, referencedTableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-674','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:37',672,'EXECUTED','8:f3778f9e0c00c315c3800bc7b782a671','addForeignKeyConstraint baseTableName=obs, constraintName=obs_location, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-675','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:37',673,'EXECUTED','8:b25c922870449bd0907794c59d83e383','addForeignKeyConstraint baseTableName=obs, constraintName=obs_name_of_coded_value, referencedTableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-676','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:38',674,'EXECUTED','8:04161767dc1175e6bcde6531da741346','addForeignKeyConstraint baseTableName=note, constraintName=obs_note, referencedTableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-677','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:38',675,'EXECUTED','8:e470661ffd302542439b7eb3609111cd','addForeignKeyConstraint baseTableName=obs, constraintName=obs_order, referencedTableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-678','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:39',676,'EXECUTED','8:2cb7f76a9d99495e812c39ec388a6bef','addForeignKeyConstraint baseTableName=orders, constraintName=order_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-679','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:39',677,'EXECUTED','8:d9ed04c8d5baddb3d68fb12d393837cc','addForeignKeyConstraint baseTableName=orders, constraintName=order_for_patient, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-680','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:39',678,'EXECUTED','8:82c1c50be676174f52ee01c3f08a6c97','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-681','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:40',679,'EXECUTED','8:1a5d93f4f0b06bd21bb8601483b68297','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-682','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:40',680,'EXECUTED','8:4e10969a38735815960341380ee10035','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-683','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:40',681,'EXECUTED','8:f1ccac259e4279e39ffaf281cb75e5ef','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-684','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:41',682,'EXECUTED','8:b06b7ad924250754d8e4ae05f8375ca6','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-685','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:41',683,'EXECUTED','8:db59f16b55000d806437669be4338965','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-686','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:41',684,'EXECUTED','8:801a71a6636913fac4ab3edba7b5ea43','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_encounter_id_fk, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-687','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:42',685,'EXECUTED','8:b51974fd7cb54147c5708857c63b5f4b','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_patient_id_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-688','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:42',686,'EXECUTED','8:054d2e2db4143462eeea6ad1e06e5356','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_set_id_fk, referencedTableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-689','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:43',687,'EXECUTED','8:1745fc0d80bb9bcbdb08abda3b6f7565','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-690','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:43',688,'EXECUTED','8:07198ea1b745a2d72fcaa28d994e72b9','addForeignKeyConstraint baseTableName=order_set, constraintName=order_set_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-691','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:43',689,'EXECUTED','8:83e6ccf66b8ed79ba263a796dd149baf','addForeignKeyConstraint baseTableName=order_set, constraintName=order_set_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-692','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:44',690,'EXECUTED','8:94e75871390bb64fcccb47aa1725903c','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-693','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:44',691,'EXECUTED','8:c8c694b06dd35f1da3426ac3181d9a74','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-694','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:44',692,'EXECUTED','8:384c4abbf62461cd49ef2dc527d12722','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-695','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:45',693,'EXECUTED','8:c6f489f4278cf19fa33e39a0cd31a101','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_order_set_id_fk, referencedTableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-696','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:45',694,'EXECUTED','8:2633d85c3af4c94cbf2301fd3146086c','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_order_type_fk, referencedTableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-697','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:46',695,'EXECUTED','8:fef4d230928bf3ea7e4ece1161013076','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-698','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:46',696,'EXECUTED','8:8cacc6031f21735211f4abcd31ddd88f','addForeignKeyConstraint baseTableName=order_set, constraintName=order_set_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-699','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:46',697,'EXECUTED','8:b68e6a401034b93cf919550ae7c01236','addForeignKeyConstraint baseTableName=order_type, constraintName=order_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-700','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:47',698,'EXECUTED','8:8f9a1f9b5c29d91a7cfca6410ff23f99','addForeignKeyConstraint baseTableName=order_type, constraintName=order_type_parent_order_type, referencedTableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-701','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:47',699,'EXECUTED','8:8a5e47f2adbd789c9b8ddbdefd413a27','addForeignKeyConstraint baseTableName=orders, constraintName=orders_care_setting, referencedTableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-702','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:48',700,'EXECUTED','8:b34eac879f2fb2d08e968218747ad8ab','addForeignKeyConstraint baseTableName=orders, constraintName=orders_in_encounter, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-703','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:48',701,'EXECUTED','8:9bddd80656976d26e20202f8e5f0ffc8','addForeignKeyConstraint baseTableName=orders, constraintName=orders_order_group_id_fk, referencedTableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-704','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:48',702,'EXECUTED','8:8669298d0fbb0b0136fdd9233857d4ad','addForeignKeyConstraint baseTableName=cohort_member, constraintName=parent_cohort, referencedTableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-705','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:49',703,'EXECUTED','8:1438af742d5acc5940365ede8f3ceceb','addForeignKeyConstraint baseTableName=location, constraintName=parent_location, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-706','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:49',704,'EXECUTED','8:9fcbe6d2601cac51aa3f458d6a035c60','addForeignKeyConstraint baseTableName=role_role, constraintName=parent_role, referencedTableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-707','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:49',705,'EXECUTED','8:1bd029cf8717e512c685cad38cf4d12b','addForeignKeyConstraint baseTableName=person_address, constraintName=patient_address_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-708','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:50',706,'EXECUTED','8:06fa710137b97c922bfaab061ad9293c','addForeignKeyConstraint baseTableName=person_address, constraintName=patient_address_void, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-709','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:50',707,'EXECUTED','8:aab960ea913b6ddd3127c14baf73c823','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=patient_identifier_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-710','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:50',708,'EXECUTED','8:17cb9af404062b01a5ab912efd281339','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=patient_identifier_ibfk_2, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-711','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:51',709,'EXECUTED','8:c0b1f393954a90918f009d1cbc32cb63','addForeignKeyConstraint baseTableName=patient_identifier_type, constraintName=patient_identifier_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-712','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:51',710,'EXECUTED','8:34dec67047f0a39b208918ec21db5893','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_in_program, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-713','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:52',711,'EXECUTED','8:9ee961926d38a101798bb447b92a6c2d','addForeignKeyConstraint baseTableName=note, constraintName=patient_note, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-714','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:52',712,'EXECUTED','8:52a51ec6cd1c0737ad6a5f719c910969','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_attributetype_fk, referencedTableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-715','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:52',713,'EXECUTED','8:e161fefafcfee7977591996d6a1c53d6','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-716','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:53',714,'EXECUTED','8:0bd38a9b69329f52f5468385a98d774f','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-717','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:53',715,'EXECUTED','8:60e5ba2f6405a0116d60c2a952a25190','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_programid_fk, referencedTableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-718','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:53',716,'EXECUTED','8:8f15d936795e44307bec87846cd65b00','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-719','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:54',717,'EXECUTED','8:391cfe0ab46ac6cea973cea3a3545e33','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_program_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-720','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:54',718,'EXECUTED','8:7bd5776b0be8fac9dc94dfb88f00da7f','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_program_for_state, referencedTableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-721','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:55',719,'EXECUTED','8:9190ba5bf9823cd885efa25a83a578d9','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_program_location_id, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-722','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:55',720,'EXECUTED','8:04b0bde679cb2101a63bd18d29aeee77','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_program_outcome_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-723','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:55',721,'EXECUTED','8:09c964b19c46ae35f0861344281d0d91','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_state_changer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-724','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:56',722,'EXECUTED','8:8b7ac0848be5c70d19764d59ca40aff4','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_state_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-725','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:56',723,'EXECUTED','8:b06ac13374b66e1d56e008b9dca28a88','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_state_voider, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-726','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:56',724,'EXECUTED','8:4166e03396d5cdbee3c4ea94ba58bfa2','addForeignKeyConstraint baseTableName=relationship, constraintName=person_a_is_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-727','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:57',725,'EXECUTED','8:996e5f32a4912adeed25e0bd685f1269','addForeignKeyConstraint baseTableName=person_address, constraintName=person_address_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-728','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:57',726,'EXECUTED','8:d4d0032894d6ebee123d06ce5349464e','addForeignKeyConstraint baseTableName=relationship, constraintName=person_b_is_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-729','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:58',727,'EXECUTED','8:22477dea7d8ed4bbc85cc65f207ee05d','addForeignKeyConstraint baseTableName=person, constraintName=person_died_because, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-730','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:58',728,'EXECUTED','8:7d03edea9ef8a1f11bf2f6116a9f47fe','addForeignKeyConstraint baseTableName=patient, constraintName=person_id_for_patient, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-731','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:58',729,'EXECUTED','8:6138e932a8f7dc672b976c44a3c5619c','addForeignKeyConstraint baseTableName=users, constraintName=person_id_for_user, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-732','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:59',730,'EXECUTED','8:567fe452a2e7ae893a17afcc6103dd6f','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-733','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:59',731,'EXECUTED','8:2ad1f60029f2ce1b182f59e5d4220425','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-734','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:08:59',732,'EXECUTED','8:0350eec9ec5bfdd57c8ad13fbf5bbb2d','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_loser, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-735','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:00',733,'EXECUTED','8:1c08d6a13ef8d9666cb6c1b83a73861f','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-736','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:00',734,'EXECUTED','8:f87ea09206b90f73bd071fb61cf567f4','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_winner, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-737','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:01',735,'EXECUTED','8:f0b2534406dbc50e53da76f45facc93e','addForeignKeyConstraint baseTableName=obs, constraintName=person_obs, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-738','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:01',736,'EXECUTED','8:70c3d0c0adaa5e68504b6f778c5dbc8c','addForeignKeyConstraint baseTableName=orders, constraintName=previous_order_id_order_id, referencedTableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-739','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:02',737,'EXECUTED','8:8bfedf09577dff4983a279b26382c718','addForeignKeyConstraint baseTableName=obs, constraintName=previous_version, referencedTableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-740','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:02',738,'EXECUTED','8:0e582969c42698d575c944782d71ec2c','addForeignKeyConstraint baseTableName=drug, constraintName=primary_drug_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-741','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:02',739,'EXECUTED','8:3504918956d1525b97cc077a5f91c544','addForeignKeyConstraint baseTableName=role_privilege, constraintName=privilege_definitions, referencedTableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-742','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:03',740,'EXECUTED','8:d1bda4909128e34a7312587b02425cb6','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=privilege_which_can_edit, referencedTableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-743','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:03',741,'EXECUTED','8:456e9cc829e92a93994e9029368d90f9','addForeignKeyConstraint baseTableName=encounter_type, constraintName=privilege_which_can_edit_encounter_type, referencedTableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-744','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:03',742,'EXECUTED','8:8ce1f2486f15760dc9c942bb41cafadb','addForeignKeyConstraint baseTableName=encounter_type, constraintName=privilege_which_can_view_encounter_type, referencedTableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-745','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:04',743,'EXECUTED','8:cf0afb19ccd46f8be51d48a105be071c','addForeignKeyConstraint baseTableName=program_attribute_type, constraintName=program_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-746','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:04',744,'EXECUTED','8:d72f0c2b1ada2b3b917ebe3937480494','addForeignKeyConstraint baseTableName=program_attribute_type, constraintName=program_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-747','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:04',745,'EXECUTED','8:3b575ae1da7da6e2bef9733217b30260','addForeignKeyConstraint baseTableName=program_attribute_type, constraintName=program_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-748','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:05',746,'EXECUTED','8:e1259106d9e68fbc9f745ff166d0f607','addForeignKeyConstraint baseTableName=program, constraintName=program_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-749','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:05',747,'EXECUTED','8:83c1da42e28b3ee703b4ba9f7a135b52','addForeignKeyConstraint baseTableName=program, constraintName=program_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-750','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:06',748,'EXECUTED','8:04b4751737c937eff17ef2586b6c329c','addForeignKeyConstraint baseTableName=patient_program, constraintName=program_for_patient, referencedTableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-751','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:06',749,'EXECUTED','8:7b2cc29cbc7bcfee9385f6c53f6c6d6c','addForeignKeyConstraint baseTableName=program_workflow, constraintName=program_for_workflow, referencedTableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-752','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:06',750,'EXECUTED','8:3debc27e4493cc2fc2e55763a55fd7c6','addForeignKeyConstraint baseTableName=program, constraintName=program_outcomes_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-753','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:07',751,'EXECUTED','8:0fb2cdfa9a72f2d9dccfc130f52f2d48','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=proposal_obs_concept_id, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-754','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:07',752,'EXECUTED','8:da7e5963f137ab11e91395eb1741fbd8','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=proposal_obs_id, referencedTableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-755','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:08',753,'EXECUTED','8:92a0046d7220d0babd6f79e0e9865916','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_attribute_type_id_fk, referencedTableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-756','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:08',754,'EXECUTED','8:20003c0fdad7306a5e412886292a7c77','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-757','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:08',755,'EXECUTED','8:feb5a286ea545d2728cdf5c68111912e','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-758','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:09',756,'EXECUTED','8:0b35858ba17ecf9119cf411483e8daed','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_provider_fk, referencedTableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-759','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:09',757,'EXECUTED','8:94a278f074a8888c6427057ccc32b1bb','addForeignKeyConstraint baseTableName=provider_attribute_type, constraintName=provider_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-760','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:09',758,'EXECUTED','8:11860c0597990b2c67542686de9d2cf6','addForeignKeyConstraint baseTableName=provider_attribute_type, constraintName=provider_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-761','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:10',759,'EXECUTED','8:8fdd1ede94e8599cf1d9fe227cfa8192','addForeignKeyConstraint baseTableName=provider_attribute_type, constraintName=provider_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-762','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:10',760,'EXECUTED','8:bbd0dc028d9a990920f3fede1a61b9d9','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-763','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:11',761,'EXECUTED','8:773a137334f412fdddd5794722a62d6f','addForeignKeyConstraint baseTableName=provider, constraintName=provider_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-764','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:11',762,'EXECUTED','8:678427eb05d7006cf4cb8ecbf476ae97','addForeignKeyConstraint baseTableName=provider, constraintName=provider_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-765','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:11',763,'EXECUTED','8:a98883bbc5a9e95b4b4339e582e68904','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=provider_id_fk, referencedTableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-766','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:12',764,'EXECUTED','8:a299d0163ac084da10e40fae6b26ceb7','addForeignKeyConstraint baseTableName=provider, constraintName=provider_person_id_fk, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-767','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:12',765,'EXECUTED','8:cbcc38df4bb40d2f4a3e452ebe63066b','addForeignKeyConstraint baseTableName=provider, constraintName=provider_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-768','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:12',766,'EXECUTED','8:c5138ee0dee48dc58d500b894959d6de','addForeignKeyConstraint baseTableName=provider, constraintName=provider_role_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-769','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:13',767,'EXECUTED','8:14d6672acbc0af6d8c20c6078cd17978','addForeignKeyConstraint baseTableName=provider, constraintName=provider_speciality_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-770','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:13',768,'EXECUTED','8:953e367b53682b0551c7e40af2068510','addForeignKeyConstraint baseTableName=relationship, constraintName=relation_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-771','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:14',769,'EXECUTED','8:4736f9c1f0b4e23b49eafbd66940897e','addForeignKeyConstraint baseTableName=relationship, constraintName=relation_voider, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-772','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:14',770,'EXECUTED','8:859f426e7688f2a6e3650dbac0c8f391','addForeignKeyConstraint baseTableName=relationship, constraintName=relationship_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-773','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:14',771,'EXECUTED','8:42d2aecdf81a6beccdae99a76efa2b82','addForeignKeyConstraint baseTableName=relationship_type, constraintName=relationship_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-774','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:15',772,'EXECUTED','8:db79dc9316e5eff81facd0534df2e867','addForeignKeyConstraint baseTableName=relationship, constraintName=relationship_type_id, referencedTableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-775','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:15',773,'EXECUTED','8:e9a4a2686ab894f6d6d65b1403bba1be','addForeignKeyConstraint baseTableName=report_object, constraintName=report_object_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-776','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:15',774,'EXECUTED','8:3605be008701c5f97ed0b61c9e8476ba','addForeignKeyConstraint baseTableName=user_role, constraintName=role_definitions, referencedTableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-777','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:16',775,'EXECUTED','8:ed35add50325e7e46d19eb06a86e3170','addForeignKeyConstraint baseTableName=role_privilege, constraintName=role_privilege_to_role, referencedTableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-778','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:16',776,'EXECUTED','8:c5e494e00386eed180600bd83720f4a8','addForeignKeyConstraint baseTableName=drug, constraintName=route_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-779','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:16',777,'EXECUTED','8:2471acb08411a2ed9b18e6d54e6d80af','addForeignKeyConstraint baseTableName=scheduler_task_config, constraintName=scheduler_changer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-780','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:17',778,'EXECUTED','8:91e35611e9aec46355a05e527e801108','addForeignKeyConstraint baseTableName=scheduler_task_config, constraintName=scheduler_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-781','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:17',779,'EXECUTED','8:306c6553b0165752abf8fc5692a40a1c','addForeignKeyConstraint baseTableName=serialized_object, constraintName=serialized_object_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-782','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:17',780,'EXECUTED','8:d776831690cd0c8ff682d473f4173ba6','addForeignKeyConstraint baseTableName=serialized_object, constraintName=serialized_object_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-783','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:18',781,'EXECUTED','8:7f585c84e6d7b418571133f2abcbe097','addForeignKeyConstraint baseTableName=serialized_object, constraintName=serialized_object_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-784','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:18',782,'EXECUTED','8:c4745e7a2ebce7e4de6c75bec8536a4c','addForeignKeyConstraint baseTableName=program_workflow_state, constraintName=state_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-785','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:18',783,'EXECUTED','8:543b58a4476314cc03d3e5aea555ed54','addForeignKeyConstraint baseTableName=program_workflow_state, constraintName=state_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-786','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:19',784,'EXECUTED','8:3b0623a033f8c4485d7de9608d4adc46','addForeignKeyConstraint baseTableName=program_workflow_state, constraintName=state_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-787','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:19',785,'EXECUTED','8:d259f64350c6bcc62781d0941e875a4b','addForeignKeyConstraint baseTableName=patient_state, constraintName=state_for_patient, referencedTableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-788','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:19',786,'EXECUTED','8:4699bb58a3e9c3109d45ec160b91a5c4','addForeignKeyConstraint baseTableName=scheduler_task_config_property, constraintName=task_config_for_property, referencedTableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-789','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:20',787,'EXECUTED','8:b2c41edb9570e45b19680dfb4313c7b8','addForeignKeyConstraint baseTableName=test_order, constraintName=test_order_frequency_fk, referencedTableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-790','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:20',788,'EXECUTED','8:851021811c95c7a27abec26b75eb967c','addForeignKeyConstraint baseTableName=test_order, constraintName=test_order_order_id_fk, referencedTableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-791','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:20',789,'EXECUTED','8:82e3660096af40dfdc2593f87134763d','addForeignKeyConstraint baseTableName=test_order, constraintName=test_order_specimen_source_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-792','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:20',790,'EXECUTED','8:08125ec6956668d97ce903be720109e5','addForeignKeyConstraint baseTableName=order_type, constraintName=type_created_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-793','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:21',791,'EXECUTED','8:30e98ca3bb206741fc25d7a34246a9e0','addForeignKeyConstraint baseTableName=patient_identifier_type, constraintName=type_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-794','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:21',792,'EXECUTED','8:452ad77fe1b9a2a6687e12c5908e5788','addForeignKeyConstraint baseTableName=field, constraintName=type_of_field, referencedTableName=field_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-795','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:22',793,'EXECUTED','8:00115b4d90be3b35a91bb9c4fbb2924f','addForeignKeyConstraint baseTableName=orders, constraintName=type_of_order, referencedTableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-796','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:22',794,'EXECUTED','8:ea9c4a34ef2daab2fd9bf8b0ff0140cb','addForeignKeyConstraint baseTableName=users, constraintName=user_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-797','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:22',795,'EXECUTED','8:723e6bb5c15ad073a48b332dcadf864a','addForeignKeyConstraint baseTableName=user_property, constraintName=user_property_to_users, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-798','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:23',796,'EXECUTED','8:fefff412b97d1d643149c053635ce767','addForeignKeyConstraint baseTableName=user_role, constraintName=user_role_to_users, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-799','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:23',797,'EXECUTED','8:1305a6c0dae52a22c43a9b57a940fa44','addForeignKeyConstraint baseTableName=patient_program, constraintName=user_who_changed, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-800','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:23',798,'EXECUTED','8:343eb8be828a5ba4f3841b8d77566b04','addForeignKeyConstraint baseTableName=notification_alert, constraintName=user_who_changed_alert, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-801','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:24',799,'EXECUTED','8:5fc975ec849f698e4287a09acb421d7e','addForeignKeyConstraint baseTableName=cohort, constraintName=user_who_changed_cohort, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-802','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:24',800,'EXECUTED','8:2265b40b243ac793f14ef309795080fc','addForeignKeyConstraint baseTableName=concept, constraintName=user_who_changed_concept, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-803','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:24',801,'EXECUTED','8:c261c1e65549e34ee71f80efb3505c60','addForeignKeyConstraint baseTableName=concept_description, constraintName=user_who_changed_description, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-804','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:25',802,'EXECUTED','8:77bb092390a513da2ffc945456c2d209','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=user_who_changed_drug_reference_map, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-805','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:25',803,'EXECUTED','8:f13ca2f63daf6edfabf8529407243217','addForeignKeyConstraint baseTableName=field, constraintName=user_who_changed_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-806','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:25',804,'EXECUTED','8:0fca81deba1a33b52f26baf88bbef7df','addForeignKeyConstraint baseTableName=note, constraintName=user_who_changed_note, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-807','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:26',805,'EXECUTED','8:20e416bb6651a6f0c9ed2e7573ddc370','addForeignKeyConstraint baseTableName=patient, constraintName=user_who_changed_pat, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-808','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:26',806,'EXECUTED','8:df236e4b1ed69a28387ff87739d53074','addForeignKeyConstraint baseTableName=person, constraintName=user_who_changed_person, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-809','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:26',807,'EXECUTED','8:bd1a4300a5ab91f5829e17f9e78685d2','addForeignKeyConstraint baseTableName=program, constraintName=user_who_changed_program, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-810','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:27',808,'EXECUTED','8:c06c37d1888e2616ed164c564c9691ea','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=user_who_changed_proposal, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-811','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:27',809,'EXECUTED','8:26a5df123f658da8ce9d43ee7be84c01','addForeignKeyConstraint baseTableName=report_object, constraintName=user_who_changed_report_object, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-812','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:27',810,'EXECUTED','8:08adce9cac2fc5812ae1467bb01f7c68','addForeignKeyConstraint baseTableName=users, constraintName=user_who_changed_user, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-813','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:28',811,'EXECUTED','8:dc181c03d81a5aa13b2adba0895e7cc7','addForeignKeyConstraint baseTableName=concept_set, constraintName=user_who_created, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-814','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:28',812,'EXECUTED','8:280744cd6ef9a10c033ea227aa23ad75','addForeignKeyConstraint baseTableName=concept_description, constraintName=user_who_created_description, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-815','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:28',813,'EXECUTED','8:c2ddd6a153ea5fac2642af8cd8b0f417','addForeignKeyConstraint baseTableName=field, constraintName=user_who_created_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-816','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:29',814,'EXECUTED','8:93f04f5f6488c7f6766b3b96133ec156','addForeignKeyConstraint baseTableName=field_answer, constraintName=user_who_created_field_answer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-817','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:29',815,'EXECUTED','8:9031282bc3ec4aeff106fdb5cc5a6cc9','addForeignKeyConstraint baseTableName=field_type, constraintName=user_who_created_field_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-818','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:29',816,'EXECUTED','8:8f148b88a5ad5a7b78587b3d31c8e684','addForeignKeyConstraint baseTableName=form, constraintName=user_who_created_form, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-819','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:30',817,'EXECUTED','8:603a206dd14a3675c9cef971ffa9020c','addForeignKeyConstraint baseTableName=form_field, constraintName=user_who_created_form_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-820','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:30',818,'EXECUTED','8:983988bb480395808f1e41aa51180e5c','addForeignKeyConstraint baseTableName=hl7_source, constraintName=user_who_created_hl7_source, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-821','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:30',819,'EXECUTED','8:1a458577d2ac4dfe1e97a89ae1f57368','addForeignKeyConstraint baseTableName=location, constraintName=user_who_created_location, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-822','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:31',820,'EXECUTED','8:5e7978a742cc48bf0314fa94ea09c2f9','addForeignKeyConstraint baseTableName=concept_name, constraintName=user_who_created_name, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-823','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:31',821,'EXECUTED','8:6db6284b31bcc268b3ac4e6fb8bd1a60','addForeignKeyConstraint baseTableName=note, constraintName=user_who_created_note, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-824','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:32',822,'EXECUTED','8:d9f70cb2cb2d2e385450fff9de81a3f0','addForeignKeyConstraint baseTableName=patient, constraintName=user_who_created_patient, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-825','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:32',823,'EXECUTED','8:f646acccb57f4c6fdf595d6cac79b9d6','addForeignKeyConstraint baseTableName=person, constraintName=user_who_created_person, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-826','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:32',824,'EXECUTED','8:96b9e9096245e655ed5447e1952205cb','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=user_who_created_proposal, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-827','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:33',825,'EXECUTED','8:fb7754b5708a79f2dfa48548a2a9927b','addForeignKeyConstraint baseTableName=relationship_type, constraintName=user_who_created_rel, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-828','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:33',826,'EXECUTED','8:bcb154a1a744dcabb2b0a086183cb828','addForeignKeyConstraint baseTableName=encounter_type, constraintName=user_who_created_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-829','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:33',827,'EXECUTED','8:13951420223e47ff313feb89df69fbee','addForeignKeyConstraint baseTableName=form, constraintName=user_who_last_changed_form, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-830','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:34',828,'EXECUTED','8:929037fffaac667470943ea65d399a45','addForeignKeyConstraint baseTableName=form_field, constraintName=user_who_last_changed_form_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-831','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:34',829,'EXECUTED','8:4f451f31dd229342b58289e42e768bd9','addForeignKeyConstraint baseTableName=person_name, constraintName=user_who_made_name, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-832','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:34',830,'EXECUTED','8:7eff96a285820c8da251930fa92ada8f','addForeignKeyConstraint baseTableName=concept, constraintName=user_who_retired_concept, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-833','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:35',831,'EXECUTED','8:9afbf53a06102f16c1f2390d0d46da52','addForeignKeyConstraint baseTableName=concept_class, constraintName=user_who_retired_concept_class, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-834','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:35',832,'EXECUTED','8:442e2f78bf23bcffe3965637d672416d','addForeignKeyConstraint baseTableName=concept_datatype, constraintName=user_who_retired_concept_datatype, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-835','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:35',833,'EXECUTED','8:0272c11d12cfea2978d5f553e74b1207','addForeignKeyConstraint baseTableName=concept_reference_source, constraintName=user_who_retired_concept_source, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-836','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:36',834,'EXECUTED','8:6750966353811ea85969a5b6652bd400','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=user_who_retired_drug_reference_map, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-837','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:36',835,'EXECUTED','8:d8872ccdfc762e9ce6e7886b20af7047','addForeignKeyConstraint baseTableName=encounter_type, constraintName=user_who_retired_encounter_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-838','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:37',836,'EXECUTED','8:0d01bd36170b64d389b69701c176442b','addForeignKeyConstraint baseTableName=field, constraintName=user_who_retired_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-839','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:37',837,'EXECUTED','8:5f23970d3a6caa80f3ecd0ef1900a45f','addForeignKeyConstraint baseTableName=form, constraintName=user_who_retired_form, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-840','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:37',838,'EXECUTED','8:5b0c2285f25c215a1bf6410892a713f5','addForeignKeyConstraint baseTableName=location, constraintName=user_who_retired_location, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-841','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:38',839,'EXECUTED','8:01b5dff30c21f152aa9bd8f401119e58','addForeignKeyConstraint baseTableName=order_type, constraintName=user_who_retired_order_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-842','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:38',840,'EXECUTED','8:10d3b2af7431d877008130ea136a8f8b','addForeignKeyConstraint baseTableName=patient_identifier_type, constraintName=user_who_retired_patient_identifier_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-843','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:39',841,'EXECUTED','8:38014a0af7e337583bef8e7e2589eabd','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=user_who_retired_person_attribute_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-844','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:39',842,'EXECUTED','8:8b7b02faed336699f601e3f2ca01c199','addForeignKeyConstraint baseTableName=relationship_type, constraintName=user_who_retired_relationship_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-845','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:39',843,'EXECUTED','8:a938f103add4c8156b7d6f4bdf9cf374','addForeignKeyConstraint baseTableName=users, constraintName=user_who_retired_this_user, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-846','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:40',844,'EXECUTED','8:67f1fa8fefbe2640ead279cb4e48ba0f','addForeignKeyConstraint baseTableName=cohort, constraintName=user_who_voided_cohort, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-847','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:40',845,'EXECUTED','8:5f9f7cd2bdd2ec0cd2d9bdd274457200','addForeignKeyConstraint baseTableName=encounter, constraintName=user_who_voided_encounter, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-848','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:40',846,'EXECUTED','8:b4973e2fd09493cf0f779120fa5dbec4','addForeignKeyConstraint baseTableName=person_name, constraintName=user_who_voided_name, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-849','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:41',847,'EXECUTED','8:3776cdd75708aa75f1b0c7f622897c64','addForeignKeyConstraint baseTableName=obs, constraintName=user_who_voided_obs, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-850','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:41',848,'EXECUTED','8:97cec80e22dce555f78fdc488260e742','addForeignKeyConstraint baseTableName=orders, constraintName=user_who_voided_order, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-851','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:42',849,'EXECUTED','8:eb239c8401ccfe026e802654d4a310e9','addForeignKeyConstraint baseTableName=patient, constraintName=user_who_voided_patient, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-852','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:42',850,'EXECUTED','8:613426ab4712afa00f70cf6f1afc96ef','addForeignKeyConstraint baseTableName=patient_program, constraintName=user_who_voided_patient_program, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-853','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:43',851,'EXECUTED','8:7ccc3031ce247fa4e894db35c9b50fd3','addForeignKeyConstraint baseTableName=person, constraintName=user_who_voided_person, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-854','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:43',852,'EXECUTED','8:e244aaca4e65338555a63e63c3a29d81','addForeignKeyConstraint baseTableName=report_object, constraintName=user_who_voided_report_object, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-855','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:43',853,'EXECUTED','8:b04b2982766556b661da185bcfd5fa3d','addForeignKeyConstraint baseTableName=concept_name, constraintName=user_who_voided_this_name, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-856','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:44',854,'EXECUTED','8:ed2242f9b321d4ea63f247eb2ccaab7f','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_attribute_type_id_fk, referencedTableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-857','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:44',855,'EXECUTED','8:ba1d3c056667eba3267ca5afb097d975','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-858','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:44',856,'EXECUTED','8:bbc8336b3b28d4287d5551a41b6fde79','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-859','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:45',857,'EXECUTED','8:f86c560b2a70405529674304425df5fd','addForeignKeyConstraint baseTableName=visit_attribute_type, constraintName=visit_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-860','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:45',858,'EXECUTED','8:277d9c4b7ca3a79e0a60454f1434bb3e','addForeignKeyConstraint baseTableName=visit_attribute_type, constraintName=visit_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-861','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:45',859,'EXECUTED','8:2b44a508a72aa9bd225c944bd3e784b9','addForeignKeyConstraint baseTableName=visit_attribute_type, constraintName=visit_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-862','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:46',860,'EXECUTED','8:7df3a3f6836940b959be0c1d6748b1f8','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_visit_fk, referencedTableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-863','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:46',861,'EXECUTED','8:d2fafd7800497279bd5d22adbf2c1d36','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-864','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:46',862,'EXECUTED','8:432af25b3923438b732e18b0fffbe3d0','addForeignKeyConstraint baseTableName=visit, constraintName=visit_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-865','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:47',863,'EXECUTED','8:faf16d1e38c1c8e3215f1060a914bec7','addForeignKeyConstraint baseTableName=visit, constraintName=visit_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-866','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:47',864,'EXECUTED','8:5fe911e0be2b2624c1f66d0bb0ea9aa2','addForeignKeyConstraint baseTableName=visit, constraintName=visit_indication_concept_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-867','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:48',865,'EXECUTED','8:769b35555b05d6fe5eb2b15a224c8993','addForeignKeyConstraint baseTableName=visit, constraintName=visit_location_fk, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-868','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:48',866,'EXECUTED','8:943d07508b9fe5db0c12046214218373','addForeignKeyConstraint baseTableName=visit, constraintName=visit_patient_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-869','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:48',867,'EXECUTED','8:c1a1fde06b4f60e5a7039dda1fd5deb8','addForeignKeyConstraint baseTableName=visit_type, constraintName=visit_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-870','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:49',868,'EXECUTED','8:c0157445b774208a4e1a6b155d825cda','addForeignKeyConstraint baseTableName=visit_type, constraintName=visit_type_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-871','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:49',869,'EXECUTED','8:3337dd30628c280bba9aefcb7259bf1d','addForeignKeyConstraint baseTableName=visit, constraintName=visit_type_fk, referencedTableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-872','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:49',870,'EXECUTED','8:7f760a43389b5133e928bd462a1cbfee','addForeignKeyConstraint baseTableName=visit_type, constraintName=visit_type_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-873','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:50',871,'EXECUTED','8:f80450b35384e476f2fad09174dc36e6','addForeignKeyConstraint baseTableName=visit, constraintName=visit_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-874','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:50',872,'EXECUTED','8:83bb8ae02918954c7eecc8830e5760cc','addForeignKeyConstraint baseTableName=program_workflow, constraintName=workflow_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-875','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:51',873,'EXECUTED','8:5f29c1197b461a3a2ab56cabe6393b12','addForeignKeyConstraint baseTableName=program_workflow, constraintName=workflow_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-876','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:51',874,'EXECUTED','8:2ca2fb755d66b8fc57de0239557b3836','addForeignKeyConstraint baseTableName=program_workflow, constraintName=workflow_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-877','wolf (generated)','liquibase-schema-only.xml','2021-05-22 06:09:51',875,'EXECUTED','8:f028f6c6fcd341c50dcf6b328bb20814','addForeignKeyConstraint baseTableName=program_workflow_state, constraintName=workflow_for_state, referencedTableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-17','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',876,'EXECUTED','8:255e6601599e56ae696678ceaa497147','insert tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-27','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',877,'EXECUTED','8:82560e46ae141efa9cae337db977af6d','insert tableName=users; insert tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-1','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',878,'EXECUTED','8:15e1a2cab8858f62d69204ccd0b30c82','insert tableName=care_setting; insert tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-3','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',879,'EXECUTED','8:7f05eb80307fdfc709eb088650d15a6e','insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concep...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-4','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',880,'EXECUTED','8:50ec890abd419ac57991bbd28127253d','insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; in...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-2','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',881,'EXECUTED','8:7cc25ed675cea3aab16933306a6f926c','insert tableName=concept; insert tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-5','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',882,'EXECUTED','8:5b490bb870c72fb23233b094c26046fe','insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; in...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-6','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',883,'EXECUTED','8:02641afe8826c2086d092326d2760279','insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name;...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-7','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',884,'EXECUTED','8:f20b5d7db739e72d0254bcc5badd9393','insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_w...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-8','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',885,'EXECUTED','8:6801580817ea05b1c8d3031de247112a','insert tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-9','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',886,'EXECUTED','8:80d9a081c517c5450b311b2076411160','insert tableName=field_type; insert tableName=field_type; insert tableName=field_type; insert tableName=field_type; insert tableName=field_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-11','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',887,'EXECUTED','8:98aae149885eadc3ec45db23026d263f','insert tableName=hl7_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-14','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',888,'EXECUTED','8:78aba44d5fd8096db49515cb30cec7b9','insert tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-15','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',889,'EXECUTED','8:01249863645b038d25a5e3865b630bee','insert tableName=order_type; insert tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-16','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:52',890,'EXECUTED','8:8d099363142933cea82f5ddfddcb28af','insert tableName=patient_identifier_type; insert tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-18','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:53',891,'EXECUTED','8:1690ac38e5c1c4dcea2d7dced569f187','insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert ...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-19','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:53',892,'EXECUTED','8:1458c1fc57bc69a529569da02ca87f72','insert tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-20','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:53',893,'EXECUTED','8:7d55ef76a56d3cc4bd16bf9f8bb5e918','insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privil...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-21','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:53',894,'EXECUTED','8:28a763094594b829bc80f3d6a894d450','insert tableName=relationship_type; insert tableName=relationship_type; insert tableName=relationship_type; insert tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-22','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:53',895,'EXECUTED','8:3e059f57b088f635d2c19d2e3cbb488e','insert tableName=role; insert tableName=role; insert tableName=role; insert tableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-23','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:53',896,'EXECUTED','8:21180f55b63fb7d74dc53d35b827746b','insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-24','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:53',897,'EXECUTED','8:0cb4daf54d5d34edb866c37179b22284','insert tableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-25','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:53',898,'EXECUTED','8:bc693063e2acfa6f3c00f400eee5d20b','insert tableName=user_property; insert tableName=user_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-26','wolf (generated)','liquibase-core-data.xml','2021-05-22 06:09:53',899,'EXECUTED','8:c2366d8db8ef9d8a623360430d7a1115','insert tableName=user_role; insert tableName=user_role','',NULL,'3.10.2',NULL,NULL,NULL),('20190815-Trunk-5412','gitacliff','liquibase-update-to-latest.xml','2021-05-22 06:09:54',900,'EXECUTED','8:097971ad4b683c624ef7b5d9afb8faea','addColumn tableName=order_group; addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_order_group_reason_fk, referencedTableName=concept','Adding \"order_group_reason\" column to order_group table',NULL,'3.10.2',NULL,NULL,NULL),('20190815-Trunk-5650','gitacliff','liquibase-update-to-latest.xml','2021-05-22 06:09:55',901,'EXECUTED','8:683558c2e7716af357494252a94aee20','addColumn tableName=order_group; addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_parent_order_group_fk, referencedTableName=order_group','Adding \"parent_order_group\" column to order_group table',NULL,'3.10.2',NULL,NULL,NULL),('TRUNK-5728-2020-05-20','samuel34','liquibase-update-to-latest.xml','2021-05-22 06:09:56',902,'EXECUTED','8:2a90bedc8b02e4c89e1a37dc1110014b','addColumn tableName=conditions; addForeignKeyConstraint baseTableName=conditions, constraintName=conditions_encounter_id_fk, referencedTableName=encounter','Adding \'encounter_id\' column to \'conditions\' table',NULL,'3.10.2',NULL,NULL,NULL),('20190815-Trunk-5651','gitacliff','liquibase-update-to-latest.xml','2021-05-22 06:09:56',903,'EXECUTED','8:f57b630542abaf86eb5f11cb4c3e9ad5','addColumn tableName=order_group; addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_previous_order_group_fk, referencedTableName=order_group','Adding \"previous_order_group\" column to order_group table',NULL,'3.10.2',NULL,NULL,NULL),('20200714-Trunk-5862','loliveira','liquibase-update-to-latest.xml','2021-05-22 06:09:57',904,'EXECUTED','8:c2d4c311dcab0c2c9507b75bfdd78a3c','addColumn tableName=conditions','Adding \"form_namespace_and_path\" column to conditions table',NULL,'3.10.2',NULL,NULL,NULL),('TRUNK-5835-2020-07-09-1600','gitacliff','liquibase-update-to-latest.xml','2021-05-22 06:09:58',905,'EXECUTED','8:b744e5bfec82a26f3ed1e8a71fc8d5e5','createTable tableName=order_set_attribute_type; addForeignKeyConstraint baseTableName=order_set_attribute_type, constraintName=order_set_attribute_type_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=order_set_attribut...','Creating order_set_attribute_type table',NULL,'3.10.2',NULL,NULL,NULL),('TRUNK-5835-2020-07-09-1700','gitacliff','liquibase-update-to-latest.xml','2021-05-22 06:10:00',906,'EXECUTED','8:8877d8978506c3107937fb42e6c6634b','createTable tableName=order_set_attribute; addForeignKeyConstraint baseTableName=order_set_attribute, constraintName=order_set_attribute_order_set_fk, referencedTableName=order_set; addForeignKeyConstraint baseTableName=order_set_attribute, constr...','Creating order_set_attribute table',NULL,'3.10.2',NULL,NULL,NULL),('TRUNK-5410','tendomart','liquibase-update-to-latest.xml','2021-05-22 06:10:01',907,'EXECUTED','8:7a314d2f15c425b8fc40545505441ce3','createTable tableName=order_group_attribute_type; addForeignKeyConstraint baseTableName=order_group_attribute_type, constraintName=order_group_attribute_type_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=order_group_...','Creating order_group_attribute_type table',NULL,'3.10.2',NULL,NULL,NULL),('20200723-TRUNK-5410','tendomart','liquibase-update-to-latest.xml','2021-05-22 06:10:02',908,'EXECUTED','8:47b18620e5dd10a8c0f7a13281af80ce','createTable tableName=order_group_attribute; addForeignKeyConstraint baseTableName=order_group_attribute, constraintName=order_group_attribute_order_group_fk, referencedTableName=order_group; addForeignKeyConstraint baseTableName=order_group_attri...','Creating order_group_attribute table',NULL,'3.10.2',NULL,NULL,NULL),('2020-08-31-2200-TRUNK-5821','miirochristopher','liquibase-update-to-latest.xml','2021-05-22 06:10:03',909,'EXECUTED','8:b19d78a89af7cbbc1146acfdc3bc9ee5','createIndex indexName=orders_order_number, tableName=orders','Adding index to order_number column in Orders table',NULL,'3.10.2',NULL,NULL,NULL),('2020-08-32-100-TRUNK-5821','miirochristopher','liquibase-update-to-latest.xml','2021-05-22 06:10:03',910,'EXECUTED','8:ebab8d61ca65d04b73dbed42acebbe6e','createIndex indexName=orders_accession_number, tableName=orders','Adding index to accession_number column in Orders table',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_concept_source_20200105','ibacher','liquibase.xml','2021-05-22 06:43:35',911,'EXECUTED','8:32021b3c1947c434aa9b2c00d550a0d4','createTable tableName=fhir_concept_source; addForeignKeyConstraint baseTableName=fhir_concept_source, constraintName=fhir_concept_source_concept_reference_source_fk, referencedTableName=concept_reference_source; addForeignKeyConstraint baseTableNa...','',NULL,'3.10.2',NULL,NULL,NULL),('add_loinc_fhir_concept_source_20200221','ibacher','liquibase.xml','2021-05-22 06:43:36',912,'EXECUTED','8:3a65e41b9238d0feab36ef2e7c0022d3','sql','',NULL,'3.10.2',NULL,NULL,NULL),('add_ciel_fhir_concept_source_20200221','ibacher','liquibase.xml','2021-05-22 06:43:36',913,'EXECUTED','8:719ab651e116abf26ad2d0aa3e0ff14e','sql','',NULL,'3.10.2',NULL,NULL,NULL),('change_ciel_url_fhir_concept_source_20200820','ibacher','liquibase.xml','2021-05-22 06:43:36',914,'EXECUTED','8:e21abac1fac251c4d8dfd0f8f732c765','sql','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_task_20200311','pmanko','liquibase.xml','2021-05-22 06:43:37',915,'EXECUTED','8:e1ec059d84b15074664e277fe1d2d2dd','createTable tableName=fhir_task; addForeignKeyConstraint baseTableName=fhir_task, constraintName=task_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_task, constraintName=task_changed_by, referencedTableName=users; a...','Create Task table for the Task FHIR resource',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_reference_20200311','pmanko','liquibase.xml','2021-05-22 06:43:39',916,'EXECUTED','8:4af2620a8401719ce59a4b4ba75b7eb4','createTable tableName=fhir_reference; addForeignKeyConstraint baseTableName=fhir_reference, constraintName=fhir_reference_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_reference, constraintName=fhir_reference_ch...','',NULL,'3.10.2',NULL,NULL,NULL),('add_based_on_reference_join_table_20200311','pmanko','liquibase.xml','2021-05-22 06:43:39',917,'EXECUTED','8:9fed57d573d504ea890f9f13132f55fe','createTable tableName=fhir_task_based_on_reference; addForeignKeyConstraint baseTableName=fhir_task_based_on_reference, constraintName=task_based_on_fk, referencedTableName=fhir_task; addForeignKeyConstraint baseTableName=fhir_task_based_on_refere...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_task_output_20200311','pmanko','liquibase.xml','2021-05-22 06:43:41',918,'EXECUTED','8:591e2822f354ee07598a8f13a8de6307','createTable tableName=fhir_task_output; addForeignKeyConstraint baseTableName=fhir_task_output, constraintName=fhir_task_output_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_task_output, constraintName=fhir_task...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_task_input_20200308','pmanko','liquibase.xml','2021-05-22 06:43:43',919,'EXECUTED','8:347812d29adfbbaf3b757f8e9832738e','createTable tableName=fhir_task_input; addForeignKeyConstraint baseTableName=fhir_task_input, constraintName=fhir_task_input_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_task_input, constraintName=fhir_task_inp...','',NULL,'3.10.2',NULL,NULL,NULL),('add_target_uuid_to_fhir_reference_202020917','ibacher','liquibase.xml','2021-05-22 06:43:44',920,'EXECUTED','8:34e6228e38f3e8434003dd0e71cbf682','addColumn tableName=fhir_reference; sql','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_diagnostic_report_20200917','ibacher','liquibase.xml','2021-05-22 06:43:46',921,'EXECUTED','8:8e027c92045d9cdc7817bcdcf72079ac','createTable tableName=fhir_diagnostic_report; addForeignKeyConstraint baseTableName=fhir_diagnostic_report, constraintName=fhir_diagnostic_report_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_diagnostic_report, con...','Create the table for storing Diagnostic Reports',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_diagnostic_report_performers_20200917','ibacher','liquibase.xml','2021-05-22 06:43:47',922,'EXECUTED','8:82f5bbdcf8b2bd705a2c20c61a27d977','createTable tableName=fhir_diagnostic_report_performers; addForeignKeyConstraint baseTableName=fhir_diagnostic_report_performers, constraintName=fhir_diagnostic_report_performers_diagnostic_report, referencedTableName=fhir_diagnostic_report; addFo...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_diagnostic_report_results_20201020','ibacher','liquibase.xml','2021-05-22 06:43:47',923,'EXECUTED','8:0e92072a259d4762a0f1b3bb2749f444','createTable tableName=fhir_diagnostic_report_results; addForeignKeyConstraint baseTableName=fhir_diagnostic_report_results, constraintName=fhir_diagnostic_report_results_diagnostic_report, referencedTableName=fhir_diagnostic_report; addForeignKeyC...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_encounter_class_map_20200930','ibacher','liquibase.xml','2021-05-22 06:43:49',924,'EXECUTED','8:c07b71cc89518e9c89054145d3d3851c','createTable tableName=fhir_encounter_class_map; addForeignKeyConstraint baseTableName=fhir_encounter_class_map, constraintName=fhir_encounter_class_map_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_encounter_class_...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_observation_category_map_20200930','ibacher','liquibase.xml','2021-05-22 06:43:50',925,'EXECUTED','8:8406cad7f81cab2dfa52a98702256f17','createTable tableName=fhir_observation_category_map; addForeignKeyConstraint baseTableName=fhir_observation_category_map, constraintName=fhir_observation_category_map_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_o...','',NULL,'3.10.2',NULL,NULL,NULL),('add_default_observation_categories_20200930','ibacher','liquibase.xml','2021-05-22 06:43:50',926,'EXECUTED','8:73affe6c6768796f73b415e5ce59f160','sql; sql; sql','',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2011-10-04-a','bwolfe','liquibase.xml','2021-05-22 06:43:51',927,'EXECUTED','8:9e1f4ac3d34f4b355f44d31a9bd15943','update tableName=global_property','Move MDS property addLocalMappings to metadatamapping',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2011-10-04-b','bwolfe','liquibase.xml','2021-05-22 06:43:52',928,'EXECUTED','8:d0b48291150cec09f8ec41e99777c14c','update tableName=global_property','Move MDS property localConceptSourceUuid to metadatamapping',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2015-10-11-1834','kosmik','liquibase.xml','2021-05-22 06:43:52',929,'EXECUTED','8:5fb6e7e2e4c13af7b81aa7ef15dbcbe8','createTable tableName=metadatamapping_metadata_source; addForeignKeyConstraint baseTableName=metadatamapping_metadata_source, constraintName=metadatamapping_metadata_source_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=...','Create metadata source table',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2015-10-11-1835','kosmik','liquibase.xml','2021-05-22 06:43:54',930,'EXECUTED','8:158f71d7f620046777fdb527ad9abc79','createTable tableName=metadatamapping_metadata_term_mapping; addForeignKeyConstraint baseTableName=metadatamapping_metadata_term_mapping, constraintName=metadatamapping_metadata_term_mapping_metadata_source_id, referencedTableName=metadatamapping_...','Create metadata term mapping table',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2015-10-25-1124','kosmik','liquibase.xml','2021-05-22 06:43:54',931,'EXECUTED','8:05e8c41b6de8ef7ab62058e8881a5cfe','addUniqueConstraint constraintName=metadatamapping_metadata_term_code_unique_within_source, tableName=metadatamapping_metadata_term_mapping','Add unique constraint on a code withing a source',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2015-11-16-1932','kosmik','liquibase.xml','2021-05-22 06:43:54',932,'EXECUTED','8:fffb52d06fd554d7e747e7fd0963bc21','addUniqueConstraint constraintName=metadatamapping_metadata_source_name_unique, tableName=metadatamapping_metadata_source','Add unique constraint on metadata source name',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-01-06-0800','jasonvena','liquibase.xml','2021-05-22 06:43:54',933,'EXECUTED','8:3f55b7f5a1b57b2dd0621e45f0f004f1','dropNotNullConstraint columnName=metadata_class, tableName=metadatamapping_metadata_term_mapping','Make MetadataTermMapping.metadataClass optional. We follow the openmrs convention of checking if the column\n			exists.',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-01-06-0801','jasonvena','liquibase.xml','2021-05-22 06:43:55',934,'EXECUTED','8:26aa09cc619f2d01fd680ce985b8ba56','dropNotNullConstraint columnName=metadata_uuid, tableName=metadatamapping_metadata_term_mapping','Make MetadataTermMapping.metadataUuid optional. We follow the openmrs convention of checking if the column\n			exists.',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-02-07-1310-a','kosmik','liquibase.xml','2021-05-22 06:43:55',935,'EXECUTED','8:befb1a2780e568d2cc0107d5e96d4a63','createIndex indexName=metadatamapping_idx_mdtm_retired, tableName=metadatamapping_metadata_term_mapping','Add index on metadata term mapping retired',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-02-07-1310-b-mysql','kosmik','liquibase.xml','2021-05-22 06:43:55',936,'EXECUTED','8:c20dfb62bce6b8ee4582072b1841d34e','sql','For mysql, add a prefix index on metadata term mapping metadata class, since there is a hard length limit\n			on varchar indexes starting from mysql 5.6.',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-02-07-1310-b-non-mysql','kosmik','liquibase.xml','2021-05-22 06:43:55',937,'MARK_RAN','8:7839394721a263fd56a6ee383e13e977','createIndex indexName=metadatamapping_idx_mdtm_mdclass, tableName=metadatamapping_metadata_term_mapping','Add index on metadata term mapping metadata class for any other dbms than mysql.',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-02-07-1310-c','kosmik','liquibase.xml','2021-05-22 06:43:55',938,'EXECUTED','8:2b8d054099da6178a6115659007babdc','createIndex indexName=metadatamapping_idx_mdtm_mdsource, tableName=metadatamapping_metadata_term_mapping','Add index on metadata term mapping source',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-02-07-1310-d','kosmik','liquibase.xml','2021-05-22 06:43:56',939,'EXECUTED','8:cc8edbfec4da38df5e325b34594047b5','createIndex indexName=metadatamapping_idx_mdtm_code, tableName=metadatamapping_metadata_term_mapping','Add index on metadata term mapping code',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-08-03-1044','adamgrzybkowski','liquibase.xml','2021-05-22 06:43:56',940,'EXECUTED','8:e781c9175e278eab3cfd3ff95a2ac61e','dropNotNullConstraint columnName=date_changed, tableName=metadatamapping_metadata_term_mapping; dropNotNullConstraint columnName=date_changed, tableName=metadatamapping_metadata_source','Make date_changed optional',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-08-04-1511','pgutkowski','liquibase.xml','2021-05-22 06:43:57',941,'EXECUTED','8:c229300c8e2b5d2da18d5e731b9aa551','createTable tableName=metadatamapping_metadata_set; addForeignKeyConstraint baseTableName=metadatamapping_metadata_set, constraintName=metadatamapping_metadata_set_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=metadatam...','Create metadata set table',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-08-04-1513','pgutkowski','liquibase.xml','2021-05-22 06:43:58',942,'EXECUTED','8:abaa1635197f59db3c990c8ef6f67a0b','createTable tableName=metadatamapping_metadata_set_member; addUniqueConstraint constraintName=metadatamapping_metadata_set_member_term_unique_within_set, tableName=metadatamapping_metadata_set_member; addForeignKeyConstraint baseTableName=metadata...','Create metadata set member table',NULL,'3.10.2',NULL,NULL,NULL),('metadatamapping-2016-08-05-8000','adamgrzybkowski','liquibase.xml','2021-05-22 06:43:59',943,'EXECUTED','8:ed8fe7976557830e75e7d59a42624345','dropNotNullConstraint columnName=name, tableName=metadatamapping_metadata_term_mapping','Make name optional',NULL,'3.10.2',NULL,NULL,NULL),('metadatasharing_create_table_exported_package','Dmytro Trifonov','liquibase.xml','2021-05-22 06:44:00',944,'EXECUTED','8:20f95ea1e7ec1d6a0cbcf599994d5e2b','createTable tableName=metadatasharing_exported_package; createIndex indexName=metadatasharing_package_group_uuid, tableName=metadatasharing_exported_package','Create table metadatasharing_exported_package',NULL,'3.10.2',NULL,NULL,NULL),('metadatasharing_create_table_imported_package','Dmytro Trifonov','liquibase.xml','2021-05-22 06:44:00',945,'EXECUTED','8:b5c327671c64ba1c2dfc6a8c62ff4f9e','createTable tableName=metadatasharing_imported_package; createIndex indexName=metadatasharing_package_uuid, tableName=metadatasharing_imported_package','Create table metadatasharing_imported_package',NULL,'3.10.2',NULL,NULL,NULL),('metadatasharing_create_table_imported_item','Dmytro Trifonov','liquibase.xml','2021-05-22 06:44:00',946,'EXECUTED','8:0769db0ae1028e871ba64d617b20a5df','createTable tableName=metadatasharing_imported_item; createIndex indexName=metadatasharing_item_uuid, tableName=metadatasharing_imported_item','Create table metadatasharing_imported_item',NULL,'3.10.2',NULL,NULL,NULL);
/*!40000 ALTER TABLE `liquibasechangelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangeloglock`
--

DROP TABLE IF EXISTS `liquibasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangeloglock`
--

LOCK TABLES `liquibasechangeloglock` WRITE;
/*!40000 ALTER TABLE `liquibasechangeloglock` DISABLE KEYS */;
INSERT INTO `liquibasechangeloglock` VALUES (1,0,NULL,NULL);
/*!40000 ALTER TABLE `liquibasechangeloglock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city_village` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_province` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `county_district` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address4` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address5` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address6` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_location` int(11) DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `address7` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address8` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address9` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address10` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address11` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address12` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address13` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address14` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address15` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_changed_by` (`changed_by`),
  KEY `location_retired_status` (`retired`),
  KEY `name_of_location` (`name`),
  KEY `parent_location` (`parent_location`),
  KEY `user_who_created_location` (`creator`),
  KEY `user_who_retired_location` (`retired_by`),
  CONSTRAINT `location_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parent_location` FOREIGN KEY (`parent_location`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_location` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_location` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Unknown Location',NULL,'','','','','','',NULL,NULL,1,'2005-09-22 00:00:00',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'8d6c993e-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_attribute`
--

DROP TABLE IF EXISTS `location_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_attribute` (
  `location_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text COLLATE utf8_unicode_ci NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`location_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `location_attribute_changed_by_fk` (`changed_by`),
  KEY `location_attribute_creator_fk` (`creator`),
  KEY `location_attribute_location_fk` (`location_id`),
  KEY `location_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `location_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `location_attribute_type` (`location_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_attribute`
--

LOCK TABLES `location_attribute` WRITE;
/*!40000 ALTER TABLE `location_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_attribute_type`
--

DROP TABLE IF EXISTS `location_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_attribute_type` (
  `location_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype_config` text COLLATE utf8_unicode_ci,
  `preferred_handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler_config` text COLLATE utf8_unicode_ci,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`location_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_type_changed_by_fk` (`changed_by`),
  KEY `location_attribute_type_creator_fk` (`creator`),
  KEY `location_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `location_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_attribute_type`
--

LOCK TABLES `location_attribute_type` WRITE;
/*!40000 ALTER TABLE `location_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag`
--

DROP TABLE IF EXISTS `location_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag` (
  `location_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`location_tag_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_tag_changed_by` (`changed_by`),
  KEY `location_tag_creator` (`creator`),
  KEY `location_tag_retired_by` (`retired_by`),
  CONSTRAINT `location_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_tag_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_tag_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag`
--

LOCK TABLES `location_tag` WRITE;
/*!40000 ALTER TABLE `location_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag_map`
--

DROP TABLE IF EXISTS `location_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag_map` (
  `location_id` int(11) NOT NULL,
  `location_tag_id` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`location_tag_id`),
  KEY `location_tag_map_tag` (`location_tag_id`),
  CONSTRAINT `location_tag_map_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_tag_map_tag` FOREIGN KEY (`location_tag_id`) REFERENCES `location_tag` (`location_tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag_map`
--

LOCK TABLES `location_tag_map` WRITE;
/*!40000 ALTER TABLE `location_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatamapping_metadata_set`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatamapping_metadata_set` (
  `metadata_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`metadata_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `metadatamapping_metadata_set_creator` (`creator`),
  KEY `metadatamapping_metadata_set_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_set_retired_by` (`retired_by`),
  CONSTRAINT `metadatamapping_metadata_set_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatamapping_metadata_set`
--

LOCK TABLES `metadatamapping_metadata_set` WRITE;
/*!40000 ALTER TABLE `metadatamapping_metadata_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadatamapping_metadata_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatamapping_metadata_set_member`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_set_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatamapping_metadata_set_member` (
  `metadata_set_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `metadata_set_id` int(11) NOT NULL,
  `metadata_class` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `metadata_uuid` varchar(38) COLLATE utf8_unicode_ci NOT NULL,
  `sort_weight` double DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`metadata_set_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `metadatamapping_metadata_set_member_term_unique_within_set` (`metadata_set_id`,`metadata_uuid`),
  KEY `metadatamapping_metadata_set_member_creator` (`creator`),
  KEY `metadatamapping_metadata_set_member_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_set_member_retired_by` (`retired_by`),
  CONSTRAINT `metadatamapping_metadata_set_member_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_member_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_member_metadata_set_id` FOREIGN KEY (`metadata_set_id`) REFERENCES `metadatamapping_metadata_set` (`metadata_set_id`),
  CONSTRAINT `metadatamapping_metadata_set_member_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatamapping_metadata_set_member`
--

LOCK TABLES `metadatamapping_metadata_set_member` WRITE;
/*!40000 ALTER TABLE `metadatamapping_metadata_set_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadatamapping_metadata_set_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatamapping_metadata_source`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatamapping_metadata_source` (
  `metadata_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`metadata_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `metadatamapping_metadata_source_name_unique` (`name`),
  KEY `metadatamapping_metadata_source_creator` (`creator`),
  KEY `metadatamapping_metadata_source_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_source_retired_by` (`retired_by`),
  CONSTRAINT `metadatamapping_metadata_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_source_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatamapping_metadata_source`
--

LOCK TABLES `metadatamapping_metadata_source` WRITE;
/*!40000 ALTER TABLE `metadatamapping_metadata_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadatamapping_metadata_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatamapping_metadata_term_mapping`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_term_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatamapping_metadata_term_mapping` (
  `metadata_term_mapping_id` int(11) NOT NULL AUTO_INCREMENT,
  `metadata_source_id` int(11) NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `metadata_class` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `metadata_uuid` varchar(38) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`metadata_term_mapping_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `metadatamapping_metadata_term_code_unique_within_source` (`metadata_source_id`,`code`),
  KEY `metadatamapping_metadata_term_mapping_creator` (`creator`),
  KEY `metadatamapping_metadata_term_mapping_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_term_mapping_retired_by` (`retired_by`),
  KEY `metadatamapping_idx_mdtm_retired` (`retired`),
  KEY `metadatamapping_idx_mdtm_mdclass` (`metadata_class`(255)),
  KEY `metadatamapping_idx_mdtm_mdsource` (`metadata_source_id`),
  KEY `metadatamapping_idx_mdtm_code` (`code`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_metadata_source_id` FOREIGN KEY (`metadata_source_id`) REFERENCES `metadatamapping_metadata_source` (`metadata_source_id`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatamapping_metadata_term_mapping`
--

LOCK TABLES `metadatamapping_metadata_term_mapping` WRITE;
/*!40000 ALTER TABLE `metadatamapping_metadata_term_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadatamapping_metadata_term_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatasharing_exported_package`
--

DROP TABLE IF EXISTS `metadatasharing_exported_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatasharing_exported_package` (
  `exported_package_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `group_uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `version` int(11) NOT NULL,
  `published` tinyint(1) NOT NULL,
  `date_created` datetime NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `content` longblob,
  PRIMARY KEY (`exported_package_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `metadatasharing_package_group_uuid` (`group_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatasharing_exported_package`
--

LOCK TABLES `metadatasharing_exported_package` WRITE;
/*!40000 ALTER TABLE `metadatasharing_exported_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadatasharing_exported_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatasharing_imported_item`
--

DROP TABLE IF EXISTS `metadatasharing_imported_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatasharing_imported_item` (
  `imported_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `classname` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `existing_uuid` char(38) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_imported` datetime DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `import_type` tinyint(4) DEFAULT '0',
  `assessed` tinyint(1) NOT NULL,
  PRIMARY KEY (`imported_item_id`),
  KEY `metadatasharing_item_uuid` (`uuid`,`existing_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=768 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatasharing_imported_item`
--

LOCK TABLES `metadatasharing_imported_item` WRITE;
/*!40000 ALTER TABLE `metadatasharing_imported_item` DISABLE KEYS */;
INSERT INTO `metadatasharing_imported_item` VALUES (1,'da006137-88ca-4d11-ae58-8b4b439afdd6','org.openmrs.Concept','da006137-88ca-4d11-ae58-8b4b439afdd6','2021-05-22 06:54:56',NULL,0,0),(2,'b3acee35-153b-4b83-a5a6-7ab3bab81602','org.openmrs.ConceptSet','b3acee35-153b-4b83-a5a6-7ab3bab81602','2021-05-22 06:54:56',NULL,0,0),(3,'4eae0e35-eb07-44c4-a770-ef7854fc9e8c','org.openmrs.Concept','4eae0e35-eb07-44c4-a770-ef7854fc9e8c','2021-05-22 06:54:56',NULL,0,0),(4,'1b296054-7eda-408c-ae73-fa6bfa873737','org.openmrs.ConceptSet','1b296054-7eda-408c-ae73-fa6bfa873737','2021-05-22 06:54:56',NULL,0,0),(5,'1019AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','1019AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(6,'118AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','118AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(7,'1017AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1017AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(8,'133817ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133817ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(9,'1de0f122-ac29-37b7-bad2-5e7f0e0ae0ef','org.openmrs.ConceptReferenceTerm','1de0f122-ac29-37b7-bad2-5e7f0e0ae0ef','2021-05-22 06:54:56',NULL,0,0),(10,'2b3c054a-768a-102f-83f4-12313b04a615','org.openmrs.ConceptSource','2b3c054a-768a-102f-83f4-12313b04a615','2021-05-22 06:54:56',NULL,0,0),(11,'35543629-7d8c-11e1-909d-c80aa9edcf4e','org.openmrs.ConceptMapType','35543629-7d8c-11e1-909d-c80aa9edcf4e','2021-05-22 06:54:56',NULL,4,0),(12,'138105ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138105ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(13,'fc3fa2ab-5e77-34cd-920f-b3cf4e891f0c','org.openmrs.ConceptReferenceTerm','fc3fa2ab-5e77-34cd-920f-b3cf4e891f0c','2021-05-22 06:54:56',NULL,0,0),(14,'2b3c1ff8-768a-102f-83f4-12313b04a615','org.openmrs.ConceptSource','2b3c1ff8-768a-102f-83f4-12313b04a615','2021-05-22 06:54:56',NULL,0,0),(15,'43ac5109-7d8c-11e1-909d-c80aa9edcf4e','org.openmrs.ConceptMapType','43ac5109-7d8c-11e1-909d-c80aa9edcf4e','2021-05-22 06:54:56',NULL,4,0),(16,'171280ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171280ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(17,'ad84e9a2-d169-373c-817a-8ca04feb0e52','org.openmrs.ConceptReferenceTerm','ad84e9a2-d169-373c-817a-8ca04feb0e52','2021-05-22 06:54:56',NULL,0,0),(18,'249b13c8-72fa-4b96-8d3d-b200efed985e','org.openmrs.ConceptSource','249b13c8-72fa-4b96-8d3d-b200efed985e','2021-05-22 06:54:56',NULL,0,0),(19,'134690ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134690ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(20,'f4181f1c-524d-352c-9437-442efc87e671','org.openmrs.ConceptReferenceTerm','f4181f1c-524d-352c-9437-442efc87e671','2021-05-22 06:54:56',NULL,0,0),(21,'2b3c28ae-768a-102f-83f4-12313b04a615','org.openmrs.ConceptSource','2b3c28ae-768a-102f-83f4-12313b04a615','2021-05-22 06:54:56',NULL,0,0),(22,'274431ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274431ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(23,'b1860fc6-9de3-3f27-a4a0-7ae69834bf61','org.openmrs.ConceptReferenceTerm','b1860fc6-9de3-3f27-a4a0-7ae69834bf61','2021-05-22 06:54:56',NULL,0,0),(24,'912025e5-edb1-4774-8a0c-59febe5600e4','org.openmrs.ConceptSource','912025e5-edb1-4774-8a0c-59febe5600e4','2021-05-22 06:54:56',NULL,0,0),(25,'8d4907b2-c2cc-11de-8d13-0010c6dffd0f','org.openmrs.ConceptClass','8d4907b2-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',NULL,4,0),(26,'8d4a4488-c2cc-11de-8d13-0010c6dffd0f','org.openmrs.ConceptDatatype','8d4a4488-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',NULL,1,0),(27,'136186BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136186BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(28,'86749BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86749BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(29,'136623BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136623BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(30,'136187BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136187BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(31,'136624BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136624BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(32,'1070BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1070BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(33,'94456BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','94456BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(34,'1019FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1019FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(35,'117AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','117AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(36,'1016AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1016AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(37,'274430ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274430ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(38,'478d4a75-8fa9-313d-93b2-c3ffa620590a','org.openmrs.ConceptReferenceTerm','478d4a75-8fa9-313d-93b2-c3ffa620590a','2021-05-22 06:54:56',NULL,0,0),(39,'134689ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134689ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(40,'0779fc92-5311-31ea-91ba-a273a44b0ac1','org.openmrs.ConceptReferenceTerm','0779fc92-5311-31ea-91ba-a273a44b0ac1','2021-05-22 06:54:56',NULL,0,0),(41,'138104ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138104ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(42,'03978a1f-39e6-3cef-83ba-d21b9c8c7b5d','org.openmrs.ConceptReferenceTerm','03978a1f-39e6-3cef-83ba-d21b9c8c7b5d','2021-05-22 06:54:56',NULL,0,0),(43,'133816ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133816ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(44,'b17fda33-56df-30a0-b921-031ec3afb391','org.openmrs.ConceptReferenceTerm','b17fda33-56df-30a0-b921-031ec3afb391','2021-05-22 06:54:56',NULL,0,0),(45,'171279ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171279ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(46,'2bd72fd9-bee8-32c7-bd20-3d99dafcf097','org.openmrs.ConceptReferenceTerm','2bd72fd9-bee8-32c7-bd20-3d99dafcf097','2021-05-22 06:54:56',NULL,0,0),(47,'136196BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136196BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(48,'86748BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86748BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(49,'1069BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1069BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(50,'136195BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136195BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(51,'97273BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','97273BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(52,'1018FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1018FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(53,'2124AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','2124AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(54,'163426AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','163426AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(55,'279980ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','279980ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(56,'3ad6a87c-0d34-349f-817c-a1b45dd42c45','org.openmrs.ConceptReferenceTerm','3ad6a87c-0d34-349f-817c-a1b45dd42c45','2021-05-22 06:54:56',NULL,0,0),(57,'2b3c09b4-768a-102f-83f4-12313b04a615','org.openmrs.ConceptSource','2b3c09b4-768a-102f-83f4-12313b04a615','2021-05-22 06:54:56',NULL,0,0),(58,'279823ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','279823ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(59,'6d9f8b79-6604-3077-9046-f7ba1697a397','org.openmrs.ConceptReferenceTerm','6d9f8b79-6604-3077-9046-f7ba1697a397','2021-05-22 06:54:56',NULL,0,0),(60,'136629BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136629BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(61,'136630BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136630BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(62,'136631BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136631BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(63,'138860BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138860BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(64,'137122BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','137122BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(65,'17785FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','17785FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(66,'116AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','116AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(67,'1015AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1015AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(68,'134688ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134688ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(69,'b08479d1-e4aa-33c5-b844-024bc24d764b','org.openmrs.ConceptReferenceTerm','b08479d1-e4aa-33c5-b844-024bc24d764b','2021-05-22 06:54:56',NULL,0,0),(70,'274428ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274428ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(71,'365d93c7-435e-31ba-86e1-689b257fc9d9','org.openmrs.ConceptReferenceTerm','365d93c7-435e-31ba-86e1-689b257fc9d9','2021-05-22 06:54:56',NULL,0,0),(72,'171278ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171278ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(73,'ecee4613-55bb-37b0-b95f-c7a547d32649','org.openmrs.ConceptReferenceTerm','ecee4613-55bb-37b0-b95f-c7a547d32649','2021-05-22 06:54:56',NULL,0,0),(74,'133815ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133815ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(75,'b661c3ee-7927-3d51-91e3-ef3af4862934','org.openmrs.ConceptReferenceTerm','b661c3ee-7927-3d51-91e3-ef3af4862934','2021-05-22 06:54:56',NULL,0,0),(76,'274429ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274429ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(77,'f99e5b7d-cc07-3ffa-bf37-37b82b37d1a6','org.openmrs.ConceptReferenceTerm','f99e5b7d-cc07-3ffa-bf37-37b82b37d1a6','2021-05-22 06:54:56',NULL,0,0),(78,'138103ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138103ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(79,'5828219b-a6b2-34e5-b6d0-6c9d6bfe16d5','org.openmrs.ConceptReferenceTerm','5828219b-a6b2-34e5-b6d0-6c9d6bfe16d5','2021-05-22 06:54:56',NULL,0,0),(80,'96215BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','96215BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(81,'1068BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1068BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(82,'90082BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','90082BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(83,'92736BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','92736BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(84,'86747BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86747BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(85,'136185BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136185BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(86,'1067BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1067BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(87,'1066BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1066BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(88,'96001BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','96001BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(89,'1017FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1017FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(90,'1AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(91,'21AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','21AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(92,'274359ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274359ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(93,'eac15b53-533d-33f4-a99a-b059d67f50f8','org.openmrs.ConceptReferenceTerm','eac15b53-533d-33f4-a99a-b059d67f50f8','2021-05-22 06:54:56',NULL,0,0),(94,'132963ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','132963ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(95,'4431b53b-23d0-33bc-93f7-b6c88b669ebd','org.openmrs.ConceptReferenceTerm','4431b53b-23d0-33bc-93f7-b6c88b669ebd','2021-05-22 06:54:56',NULL,0,0),(96,'144886ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','144886ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(97,'827d0afa-3dbc-3e61-81eb-865473c66784','org.openmrs.ConceptReferenceTerm','827d0afa-3dbc-3e61-81eb-865473c66784','2021-05-22 06:54:56',NULL,0,0),(98,'2b3c2778-768a-102f-83f4-12313b04a615','org.openmrs.ConceptSource','2b3c2778-768a-102f-83f4-12313b04a615','2021-05-22 06:54:56',NULL,0,0),(99,'133887ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133887ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(100,'71e8df43-2289-383a-8d82-fed8523e0528','org.openmrs.ConceptReferenceTerm','71e8df43-2289-383a-8d82-fed8523e0528','2021-05-22 06:54:56',NULL,0,0),(101,'134153ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134153ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(102,'97e7a542-c5d8-3831-9bc6-62beb02aac5e','org.openmrs.ConceptReferenceTerm','97e7a542-c5d8-3831-9bc6-62beb02aac5e','2021-05-22 06:54:56',NULL,0,0),(103,'134363ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134363ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(104,'bed571c7-4bd0-31c9-aebc-6adc17b0bb36','org.openmrs.ConceptReferenceTerm','bed571c7-4bd0-31c9-aebc-6adc17b0bb36','2021-05-22 06:54:56',NULL,0,0),(105,'146575ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','146575ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(106,'76f95225-f93b-3e25-893b-aea644d34c6d','org.openmrs.ConceptReferenceTerm','76f95225-f93b-3e25-893b-aea644d34c6d','2021-05-22 06:54:56',NULL,0,0),(107,'138096ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138096ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(108,'cd65ee1c-ea3a-35c0-988d-522c0bfc33e7','org.openmrs.ConceptReferenceTerm','cd65ee1c-ea3a-35c0-988d-522c0bfc33e7','2021-05-22 06:54:56',NULL,0,0),(109,'170976ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','170976ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(110,'357aa507-a1a9-3b8d-b747-09322e9c7f4d','org.openmrs.ConceptReferenceTerm','357aa507-a1a9-3b8d-b747-09322e9c7f4d','2021-05-22 06:54:56',NULL,0,0),(111,'110964BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','110964BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(112,'139777BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','139777BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(113,'24BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','24BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(114,'92727BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','92727BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(115,'23BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','23BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(116,'134735BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','134735BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(117,'25BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','25BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(118,'86714BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86714BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(119,'92819BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','92819BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(120,'18146FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','18146FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(121,'21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(122,'16956FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','16956FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(123,'119AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','119AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(124,'1018AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1018AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(125,'274432ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274432ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(126,'4caa369d-c8fd-36ec-9b91-04f78bf0fd9a','org.openmrs.ConceptReferenceTerm','4caa369d-c8fd-36ec-9b91-04f78bf0fd9a','2021-05-22 06:54:56',NULL,0,0),(127,'134691ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134691ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(128,'f3dd33cf-26ee-35f6-abff-5d64506d43c7','org.openmrs.ConceptReferenceTerm','f3dd33cf-26ee-35f6-abff-5d64506d43c7','2021-05-22 06:54:56',NULL,0,0),(129,'133818ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133818ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(130,'19b675b5-ffa7-3aa4-9c7b-4a85bee6ecdb','org.openmrs.ConceptReferenceTerm','19b675b5-ffa7-3aa4-9c7b-4a85bee6ecdb','2021-05-22 06:54:56',NULL,0,0),(131,'138106ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138106ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(132,'eac141df-7455-34bc-acd1-98660406935f','org.openmrs.ConceptReferenceTerm','eac141df-7455-34bc-acd1-98660406935f','2021-05-22 06:54:56',NULL,0,0),(133,'171281ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171281ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(134,'277c280c-8722-3ece-835a-7e99e122d636','org.openmrs.ConceptReferenceTerm','277c280c-8722-3ece-835a-7e99e122d636','2021-05-22 06:54:56',NULL,0,0),(135,'136188BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136188BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(136,'1071BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1071BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(137,'136621BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136621BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(138,'86750BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86750BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(139,'136189BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136189BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(140,'94455BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','94455BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(141,'136622BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136622BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(142,'1020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(143,'100AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','100AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(144,'851AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','851AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(145,'171194ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171194ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(146,'98973517-8464-3fb9-9646-77932551d1c7','org.openmrs.ConceptReferenceTerm','98973517-8464-3fb9-9646-77932551d1c7','2021-05-22 06:54:56',NULL,0,0),(147,'134532ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134532ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(148,'5f881a8d-eebd-330f-a08c-5d17bba16cd2','org.openmrs.ConceptReferenceTerm','5f881a8d-eebd-330f-a08c-5d17bba16cd2','2021-05-22 06:54:56',NULL,0,0),(149,'138100ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138100ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(150,'30859640-d704-35b7-9e09-daf546f53df2','org.openmrs.ConceptReferenceTerm','30859640-d704-35b7-9e09-daf546f53df2','2021-05-22 06:54:56',NULL,0,0),(151,'274402ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274402ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(152,'6c8b54af-1e74-3f12-b737-cacb5c52b483','org.openmrs.ConceptReferenceTerm','6c8b54af-1e74-3f12-b737-cacb5c52b483','2021-05-22 06:54:56',NULL,0,0),(153,'133769ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133769ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(154,'7df967c2-7c66-3cd7-af7c-abc736e8b745','org.openmrs.ConceptReferenceTerm','7df967c2-7c66-3cd7-af7c-abc736e8b745','2021-05-22 06:54:56',NULL,0,0),(155,'136619BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136619BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(156,'94459BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','94459BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(157,'136190BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136190BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(158,'893BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','893BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(159,'136191BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136191BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(160,'136620BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136620BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(161,'86731BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86731BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(162,'853FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','853FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(163,'70AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','70AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(164,'678AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','678AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(165,'171141ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171141ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(166,'d512c7ac-151d-3582-8844-99c7ef83d8df','org.openmrs.ConceptReferenceTerm','d512c7ac-151d-3582-8844-99c7ef83d8df','2021-05-22 06:54:56',NULL,0,0),(167,'133731ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133731ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(168,'577b508d-678d-3d65-9ec1-02dcbb96d112','org.openmrs.ConceptReferenceTerm','577b508d-678d-3d65-9ec1-02dcbb96d112','2021-05-22 06:54:56',NULL,0,0),(169,'134387ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134387ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(170,'62552302-6c0e-3db7-a880-aaaaa1f33c22','org.openmrs.ConceptReferenceTerm','62552302-6c0e-3db7-a880-aaaaa1f33c22','2021-05-22 06:54:56',NULL,0,0),(171,'138097ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138097ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(172,'957a10b2-9e69-3561-83eb-60aebbf90b13','org.openmrs.ConceptReferenceTerm','957a10b2-9e69-3561-83eb-60aebbf90b13','2021-05-22 06:54:56',NULL,0,0),(173,'134389ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134389ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(174,'e14eccf2-9342-3a02-9102-64a24240716f','org.openmrs.ConceptReferenceTerm','e14eccf2-9342-3a02-9102-64a24240716f','2021-05-22 06:54:56',NULL,0,0),(175,'134364ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134364ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(176,'fab351bc-40f0-3e11-b5f2-b1cb2f203b34','org.openmrs.ConceptReferenceTerm','fab351bc-40f0-3e11-b5f2-b1cb2f203b34','2021-05-22 06:54:56',NULL,0,0),(177,'274387ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274387ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(178,'b7847746-b015-3101-afba-f4bfb0586771','org.openmrs.ConceptReferenceTerm','b7847746-b015-3101-afba-f4bfb0586771','2021-05-22 06:54:56',NULL,0,0),(179,'134386ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134386ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(180,'a3d858d8-c686-31b9-a9b8-a9014b831bf5','org.openmrs.ConceptReferenceTerm','a3d858d8-c686-31b9-a9b8-a9014b831bf5','2021-05-22 06:54:56',NULL,0,0),(181,'97096BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','97096BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(182,'100165BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','100165BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(183,'86724BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86724BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(184,'110967BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','110967BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(185,'106843BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','106843BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(186,'711BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','711BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(187,'100191BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','100191BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(188,'712BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','712BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(189,'93911BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','93911BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(190,'136197BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136197BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(191,'678FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','678FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(192,'72AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','72AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(193,'729AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','729AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(194,'274390ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274390ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(195,'36523093-341f-3e07-a333-cab333293361','org.openmrs.ConceptReferenceTerm','36523093-341f-3e07-a333-cab333293361','2021-05-22 06:54:56',NULL,0,0),(196,'144097ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','144097ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(197,'c450f464-0a69-34c1-b8c2-c3154235fe21','org.openmrs.ConceptReferenceTerm','c450f464-0a69-34c1-b8c2-c3154235fe21','2021-05-22 06:54:56',NULL,0,0),(198,'fb9aaaf1-65e2-4c18-b53c-16b575f2f385','org.openmrs.ConceptSource','fb9aaaf1-65e2-4c18-b53c-16b575f2f385','2021-05-22 06:54:56',NULL,0,0),(199,'274391ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274391ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(200,'d2c19102-db63-3d69-b85b-7d35e31b8ac3','org.openmrs.ConceptReferenceTerm','d2c19102-db63-3d69-b85b-7d35e31b8ac3','2021-05-22 06:54:56',NULL,0,0),(201,'133750ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133750ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(202,'62b83842-c7eb-3ced-8a92-774ff028454f','org.openmrs.ConceptReferenceTerm','62b83842-c7eb-3ced-8a92-774ff028454f','2021-05-22 06:54:56',NULL,0,0),(203,'138099ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138099ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(204,'d7a7740f-604d-3090-a68c-78b5aee55286','org.openmrs.ConceptReferenceTerm','d7a7740f-604d-3090-a68c-78b5aee55286','2021-05-22 06:54:56',NULL,0,0),(205,'134366ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134366ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(206,'8b858349-31a2-362a-b696-8388daf41c8d','org.openmrs.ConceptReferenceTerm','8b858349-31a2-362a-b696-8388daf41c8d','2021-05-22 06:54:56',NULL,0,0),(207,'171162ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171162ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(208,'773b4345-0e96-39ad-ba0a-8c741f571c33','org.openmrs.ConceptReferenceTerm','773b4345-0e96-39ad-ba0a-8c741f571c33','2021-05-22 06:54:56',NULL,0,0),(209,'134428ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134428ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(210,'fe472e82-44b9-3b51-8093-6d1b1883c62f','org.openmrs.ConceptReferenceTerm','fe472e82-44b9-3b51-8093-6d1b1883c62f','2021-05-22 06:54:56',NULL,0,0),(211,'88766BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','88766BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(212,'96574BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','96574BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(213,'765BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','765BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(214,'108138BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108138BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(215,'764BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','764BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(216,'98954BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','98954BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(217,'136192BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136192BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(218,'729FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','729FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(219,'2122AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','2122AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(220,'1336AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1336AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(221,'133349ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133349ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(222,'0eb1dee8-fd70-3c44-a847-c2b0039b889d','org.openmrs.ConceptReferenceTerm','0eb1dee8-fd70-3c44-a847-c2b0039b889d','2021-05-22 06:54:56',NULL,0,0),(223,'274468ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274468ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(224,'3def5280-5549-3b01-a43d-23b4345626e2','org.openmrs.ConceptReferenceTerm','3def5280-5549-3b01-a43d-23b4345626e2','2021-05-22 06:54:56',NULL,0,0),(225,'132709ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','132709ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(226,'40ad804a-86b5-3391-b82d-fcc69470cd30','org.openmrs.ConceptReferenceTerm','40ad804a-86b5-3391-b82d-fcc69470cd30','2021-05-22 06:54:56',NULL,0,0),(227,'135009ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','135009ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(228,'d4a79f9a-0636-3470-bb22-4e662eada99a','org.openmrs.ConceptReferenceTerm','d4a79f9a-0636-3470-bb22-4e662eada99a','2021-05-22 06:54:56',NULL,0,0),(229,'171588ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171588ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(230,'c239c50c-fe2c-3e2f-be0e-d7d6b5e38004','org.openmrs.ConceptReferenceTerm','c239c50c-fe2c-3e2f-be0e-d7d6b5e38004','2021-05-22 06:54:56',NULL,0,0),(231,'136625BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136625BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(232,'136626BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136626BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(233,'1425BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1425BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(234,'1322FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1322FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(235,'2123AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','2123AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(236,'1338AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1338AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(237,'135011ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','135011ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(238,'f9406139-5b43-3617-a3fc-f74f5c2b779c','org.openmrs.ConceptReferenceTerm','f9406139-5b43-3617-a3fc-f74f5c2b779c','2021-05-22 06:54:56',NULL,0,0),(239,'274470ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274470ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(240,'c49656b8-df62-3478-8fbf-cf9dafeebf53','org.openmrs.ConceptReferenceTerm','c49656b8-df62-3478-8fbf-cf9dafeebf53','2021-05-22 06:54:56',NULL,0,0),(241,'137395ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','137395ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(242,'916443f8-4208-3cde-a30e-7eed74c12a78','org.openmrs.ConceptReferenceTerm','916443f8-4208-3cde-a30e-7eed74c12a78','2021-05-22 06:54:56',NULL,0,0),(243,'171590ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171590ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(244,'25ba6ffa-4d8a-3b8d-b345-3ca1a0be119c','org.openmrs.ConceptReferenceTerm','25ba6ffa-4d8a-3b8d-b345-3ca1a0be119c','2021-05-22 06:54:56',NULL,0,0),(245,'1427BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1427BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(246,'136628BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136628BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(247,'136627BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136627BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(248,'1324FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1324FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(249,'71AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','71AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(250,'679AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','679AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(251,'134388ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134388ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(252,'603610ed-b7e1-3a12-9467-23555b0412a1','org.openmrs.ConceptReferenceTerm','603610ed-b7e1-3a12-9467-23555b0412a1','2021-05-22 06:54:56',NULL,0,0),(253,'138098ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138098ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(254,'2d48b572-b94a-304c-895d-4c64b97ed5e4','org.openmrs.ConceptReferenceTerm','2d48b572-b94a-304c-895d-4c64b97ed5e4','2021-05-22 06:54:56',NULL,0,0),(255,'134390ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134390ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(256,'2de09885-6c45-3b74-bb64-a7735da265a2','org.openmrs.ConceptReferenceTerm','2de09885-6c45-3b74-bb64-a7735da265a2','2021-05-22 06:54:56',NULL,0,0),(257,'274388ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274388ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(258,'6cce87af-b8fa-34f4-9e8c-1359d8bb51ee','org.openmrs.ConceptReferenceTerm','6cce87af-b8fa-34f4-9e8c-1359d8bb51ee','2021-05-22 06:54:56',NULL,0,0),(259,'134391ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134391ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(260,'aa0019ab-7ff5-3586-88e5-42ca532c3043','org.openmrs.ConceptReferenceTerm','aa0019ab-7ff5-3586-88e5-42ca532c3043','2021-05-22 06:54:56',NULL,0,0),(261,'171142ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171142ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(262,'1efa9ad1-40bb-39a7-b85f-4564f3b2b75d','org.openmrs.ConceptReferenceTerm','1efa9ad1-40bb-39a7-b85f-4564f3b2b75d','2021-05-22 06:54:56',NULL,0,0),(263,'133732ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133732ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(264,'9d0299b7-19df-3541-a4ce-af5df16555f3','org.openmrs.ConceptReferenceTerm','9d0299b7-19df-3541-a4ce-af5df16555f3','2021-05-22 06:54:56',NULL,0,0),(265,'136194BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136194BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(266,'106844BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','106844BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(267,'86725BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86725BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(268,'136193BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136193BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(269,'97271BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','97271BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(270,'713BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','713BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(271,'97272BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','97272BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(272,'679FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','679FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(273,'134362ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134362ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(274,'abfd31fb-ef57-3a7f-ab05-e9e84604c0c6','org.openmrs.ConceptReferenceTerm','abfd31fb-ef57-3a7f-ab05-e9e84604c0c6','2021-05-22 06:54:56',NULL,0,0),(275,'171282ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171282ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(276,'049e682c-8727-3e41-91f4-93077f5ba928','org.openmrs.ConceptReferenceTerm','049e682c-8727-3e41-91f4-93077f5ba928','2021-05-22 06:54:56',NULL,0,0),(277,'279894ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','279894ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(278,'fcc5416f-7e41-3b78-b2e3-f4c78ab1050e','org.openmrs.ConceptReferenceTerm','fcc5416f-7e41-3b78-b2e3-f4c78ab1050e','2021-05-22 06:54:56',NULL,0,0),(279,'134692ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134692ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(280,'4f7bfa97-556e-3703-b696-52b5944aeb50','org.openmrs.ConceptReferenceTerm','4f7bfa97-556e-3703-b696-52b5944aeb50','2021-05-22 06:54:56',NULL,0,0),(281,'133819ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133819ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(282,'09bdde86-5bf6-3f82-b9bc-4f7388f66d24','org.openmrs.ConceptReferenceTerm','09bdde86-5bf6-3f82-b9bc-4f7388f66d24','2021-05-22 06:54:56',NULL,0,0),(283,'8d492026-c2cc-11de-8d13-0010c6dffd0f','org.openmrs.ConceptClass','8d492026-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',NULL,4,0),(284,'8d4a4c94-c2cc-11de-8d13-0010c6dffd0f','org.openmrs.ConceptDatatype','8d4a4c94-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',NULL,1,0),(285,'136184BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136184BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(286,'91923BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','91923BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(287,'89287BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','89287BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(288,'136183BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136183BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(289,'92195BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','92195BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(290,'86751BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86751BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(291,'92769BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','92769BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(292,'1072BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1072BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(293,'92820BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','92820BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(294,'1021FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1021FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(295,'91e3d73c-86fe-4588-b46c-37577fbf4929','org.openmrs.ConceptSet','91e3d73c-86fe-4588-b46c-37577fbf4929','2021-05-22 06:54:56',NULL,0,0),(296,'161473AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','161473AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(297,'1019AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1019AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(298,'160232AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','160232AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(299,'3449CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','3449CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(300,'664AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','664AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(301,'171135ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171135ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(302,'4ed9f7ac-ae89-34a3-a15d-f7563f9af7b9','org.openmrs.ConceptReferenceTerm','4ed9f7ac-ae89-34a3-a15d-f7563f9af7b9','2021-05-22 06:54:56',NULL,0,0),(303,'134375ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134375ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(304,'60a6399e-3b1b-35f7-ba68-6ee53827d969','org.openmrs.ConceptReferenceTerm','60a6399e-3b1b-35f7-ba68-6ee53827d969','2021-05-22 06:54:56',NULL,0,0),(305,'133725ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133725ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(306,'2e2c14de-f88c-396b-a102-b955eeb4159b','org.openmrs.ConceptReferenceTerm','2e2c14de-f88c-396b-a102-b955eeb4159b','2021-05-22 06:54:56',NULL,0,0),(307,'143587ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','143587ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(308,'2676fd8d-8614-36de-8cc0-0864af2eb7e2','org.openmrs.ConceptReferenceTerm','2676fd8d-8614-36de-8cc0-0864af2eb7e2','2021-05-22 06:54:56',NULL,0,0),(309,'137847ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','137847ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(310,'371705d3-874b-3578-a1a5-49abf402cca9','org.openmrs.ConceptReferenceTerm','371705d3-874b-3578-a1a5-49abf402cca9','2021-05-22 06:54:56',NULL,0,0),(311,'ddb6b595-0b85-4a80-9243-efe4ba404eef','org.openmrs.ConceptSource','ddb6b595-0b85-4a80-9243-efe4ba404eef','2021-05-22 06:54:56',NULL,0,0),(312,'134376ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134376ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(313,'468974d1-05ed-3ff2-9db9-7f5b3a8d35fa','org.openmrs.ConceptReferenceTerm','468974d1-05ed-3ff2-9db9-7f5b3a8d35fa','2021-05-22 06:54:56',NULL,0,0),(314,'8d492774-c2cc-11de-8d13-0010c6dffd0f','org.openmrs.ConceptClass','8d492774-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',NULL,4,0),(315,'95210BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','95210BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(316,'108332BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108332BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(317,'696BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','696BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(318,'110112BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','110112BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(319,'697BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','697BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(320,'87074BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','87074BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(321,'137361BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','137361BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(322,'108329BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108329BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(323,'108331BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108331BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(324,'108330BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108330BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(325,'87080BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','87080BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(326,'664FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','664FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(327,'3450CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','3450CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(328,'703AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','703AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(329,'133196ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133196ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(330,'ca183449-7a70-339f-81dd-d4b72cd9d068','org.openmrs.ConceptReferenceTerm','ca183449-7a70-339f-81dd-d4b72cd9d068','2021-05-22 06:54:56',NULL,0,0),(331,'134409ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134409ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(332,'f7ea97d1-9888-3da7-8dfd-68950adb3ffe','org.openmrs.ConceptReferenceTerm','f7ea97d1-9888-3da7-8dfd-68950adb3ffe','2021-05-22 06:54:56',NULL,0,0),(333,'134410ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134410ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(334,'b44821a5-8cbf-3ce7-a253-e02b3103d7b4','org.openmrs.ConceptReferenceTerm','b44821a5-8cbf-3ce7-a253-e02b3103d7b4','2021-05-22 06:54:56',NULL,0,0),(335,'133595ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133595ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(336,'1163db8c-017c-35a8-bcde-00fe8c42fb3c','org.openmrs.ConceptReferenceTerm','1163db8c-017c-35a8-bcde-00fe8c42fb3c','2021-05-22 06:54:56',NULL,0,0),(337,'171151ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171151ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(338,'d6cf4393-8bc2-3fa9-8aef-5e966df06586','org.openmrs.ConceptReferenceTerm','d6cf4393-8bc2-3fa9-8aef-5e966df06586','2021-05-22 06:54:56',NULL,0,0),(339,'143726ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','143726ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(340,'3f33d629-595b-3d6e-b0b7-5b3113629265','org.openmrs.ConceptReferenceTerm','3f33d629-595b-3d6e-b0b7-5b3113629265','2021-05-22 06:54:56',NULL,0,0),(341,'108314BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108314BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(342,'106895BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','106895BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(343,'96670BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','96670BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(344,'108313BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108313BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(345,'110111BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','110111BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(346,'108312BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108312BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(347,'108316BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108316BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(348,'737BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','737BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(349,'87075BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','87075BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(350,'738BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','738BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(351,'87073BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','87073BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(352,'108315BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108315BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(353,'137362BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','137362BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(354,'703FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','703FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(355,'144112ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','144112ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(356,'da8f7d93-af97-36cf-872e-985ecf2cd6eb','org.openmrs.ConceptReferenceTerm','da8f7d93-af97-36cf-872e-985ecf2cd6eb','2021-05-22 06:54:56',NULL,0,0),(357,'217365ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','217365ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(358,'65be4d2a-61b4-387d-9fa6-d41a850780fc','org.openmrs.ConceptReferenceTerm','65be4d2a-61b4-387d-9fa6-d41a850780fc','2021-05-22 06:54:56',NULL,0,0),(359,'8d4a48b6-c2cc-11de-8d13-0010c6dffd0f','org.openmrs.ConceptDatatype','8d4a48b6-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',NULL,1,0),(360,'136682BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136682BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(361,'108158BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108158BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(362,'1020AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1020AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(363,'300AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','300AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(364,'20CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','20CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(365,'692AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','692AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(366,'133736ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133736ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(367,'a124587c-9960-3f86-abaa-bbac9e42f0cf','org.openmrs.ConceptReferenceTerm','a124587c-9960-3f86-abaa-bbac9e42f0cf','2021-05-22 06:54:56',NULL,0,0),(368,'171146ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171146ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(369,'b1efc43d-6131-3c7a-8ff7-c1286f1fca95','org.openmrs.ConceptReferenceTerm','b1efc43d-6131-3c7a-8ff7-c1286f1fca95','2021-05-22 06:54:56',NULL,0,0),(370,'134399ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134399ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(371,'07c0f029-d7e7-3c44-80d2-1d2033c8910b','org.openmrs.ConceptReferenceTerm','07c0f029-d7e7-3c44-80d2-1d2033c8910b','2021-05-22 06:54:56',NULL,0,0),(372,'134400ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134400ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(373,'79f35f2e-0543-34f4-b92d-3d7bda8fb946','org.openmrs.ConceptReferenceTerm','79f35f2e-0543-34f4-b92d-3d7bda8fb946','2021-05-22 06:54:56',NULL,0,0),(374,'8d491a9a-c2cc-11de-8d13-0010c6dffd0f','org.openmrs.ConceptClass','8d491a9a-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',NULL,4,0),(375,'108320BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108320BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(376,'136304BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136304BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(377,'136305BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136305BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(378,'136307BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136307BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(379,'726BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','726BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(380,'108319BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108319BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(381,'87109BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','87109BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(382,'136306BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136306BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(383,'692FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','692FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(384,'19CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','19CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(385,'690AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','690AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(386,'134398ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134398ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(387,'3fbefdcb-6057-3c17-80fa-9092f23a00e1','org.openmrs.ConceptReferenceTerm','3fbefdcb-6057-3c17-80fa-9092f23a00e1','2021-05-22 06:54:56',NULL,0,0),(388,'171145ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171145ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(389,'3ba91f69-5c91-3c10-9434-61f0eb27f74a','org.openmrs.ConceptReferenceTerm','3ba91f69-5c91-3c10-9434-61f0eb27f74a','2021-05-22 06:54:56',NULL,0,0),(390,'134397ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134397ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(391,'0ebd91c7-eaa4-3d38-b7a8-deafb2dc2e77','org.openmrs.ConceptReferenceTerm','0ebd91c7-eaa4-3d38-b7a8-deafb2dc2e77','2021-05-22 06:54:56',NULL,0,0),(392,'133735ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133735ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(393,'d2662e63-3ab5-30b1-96d8-ce0714573cd5','org.openmrs.ConceptReferenceTerm','d2662e63-3ab5-30b1-96d8-ce0714573cd5','2021-05-22 06:54:56',NULL,0,0),(394,'108318BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108318BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(395,'87108BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','87108BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(396,'724BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','724BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(397,'136302BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136302BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(398,'108317BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108317BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(399,'136300BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136300BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(400,'136303BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136303BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(401,'136301BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136301BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(402,'690FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','690FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(403,'26CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','26CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(404,'1231AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','1231AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(405,'171490ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171490ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(406,'ce6781d5-179c-34af-9403-579b1536b43a','org.openmrs.ConceptReferenceTerm','ce6781d5-179c-34af-9403-579b1536b43a','2021-05-22 06:54:56',NULL,0,0),(407,'134905ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134905ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(408,'3507a6be-ac5c-36c5-ace3-503837a6d5f8','org.openmrs.ConceptReferenceTerm','3507a6be-ac5c-36c5-ace3-503837a6d5f8','2021-05-22 06:54:56',NULL,0,0),(409,'137353ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','137353ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(410,'1fe266d8-7866-3630-85b4-90fd84b27032','org.openmrs.ConceptReferenceTerm','1fe266d8-7866-3630-85b4-90fd84b27032','2021-05-22 06:54:56',NULL,0,0),(411,'1310BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1310BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(412,'87130BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','87130BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(413,'136325BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136325BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(414,'136324BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136324BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(415,'136327BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136327BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(416,'136326BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136326BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(417,'1233FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1233FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(418,'23CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','23CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(419,'699AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','699AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(420,'171149ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171149ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(421,'4f66c4fb-ff23-3910-95dd-1e9c20fca864','org.openmrs.ConceptReferenceTerm','4f66c4fb-ff23-3910-95dd-1e9c20fca864','2021-05-22 06:54:56',NULL,0,0),(422,'134405ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134405ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(423,'ba5fdb93-c1f6-3fd4-a804-6cb42b95aafd','org.openmrs.ConceptReferenceTerm','ba5fdb93-c1f6-3fd4-a804-6cb42b95aafd','2021-05-22 06:54:56',NULL,0,0),(424,'133739ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133739ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(425,'7b57f940-26d2-3b6c-9efe-621a90fbe574','org.openmrs.ConceptReferenceTerm','7b57f940-26d2-3b6c-9efe-621a90fbe574','2021-05-22 06:54:56',NULL,0,0),(426,'134406ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134406ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(427,'9960291b-8c0b-3871-ae85-3dd4b93e9d31','org.openmrs.ConceptReferenceTerm','9960291b-8c0b-3871-ae85-3dd4b93e9d31','2021-05-22 06:54:56',NULL,0,0),(428,'108326BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108326BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(429,'136317BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136317BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(430,'136319BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136319BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(431,'108325BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108325BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(432,'136318BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136318BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(433,'733BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','733BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(434,'95617BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','95617BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(435,'136316BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136316BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(436,'699FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','699FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(437,'21CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','21CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(438,'694AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','694AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(439,'171147ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171147ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(440,'bd7aed3b-2502-37e2-b2d5-2b25ab07fc25','org.openmrs.ConceptReferenceTerm','bd7aed3b-2502-37e2-b2d5-2b25ab07fc25','2021-05-22 06:54:56',NULL,0,0),(441,'134402ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134402ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(442,'add4c160-0d77-3002-95db-35198c94cc99','org.openmrs.ConceptReferenceTerm','add4c160-0d77-3002-95db-35198c94cc99','2021-05-22 06:54:56',NULL,0,0),(443,'134401ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134401ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(444,'e4dfd153-72d5-386a-bb55-a213f0637887','org.openmrs.ConceptReferenceTerm','e4dfd153-72d5-386a-bb55-a213f0637887','2021-05-22 06:54:56',NULL,0,0),(445,'133737ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133737ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(446,'a56086ec-8718-312a-8ee4-f06fe9fc2714','org.openmrs.ConceptReferenceTerm','a56086ec-8718-312a-8ee4-f06fe9fc2714','2021-05-22 06:54:56',NULL,0,0),(447,'108322BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108322BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(448,'88416BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','88416BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(449,'136311BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136311BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(450,'728BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','728BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(451,'136310BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136310BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(452,'108321BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108321BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(453,'136309BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136309BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(454,'136308BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136308BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(455,'694FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','694FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(456,'25CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','25CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(457,'1230AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','1230AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(458,'134904ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134904ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(459,'a0dd1066-ab5a-3d4b-9a23-65f088789d61','org.openmrs.ConceptReferenceTerm','a0dd1066-ab5a-3d4b-9a23-65f088789d61','2021-05-22 06:54:56',NULL,0,0),(460,'137352ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','137352ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(461,'27dfc433-f2a7-3c87-9850-8945cb90cc9e','org.openmrs.ConceptReferenceTerm','27dfc433-f2a7-3c87-9850-8945cb90cc9e','2021-05-22 06:54:56',NULL,0,0),(462,'171489ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171489ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(463,'e42cc5f3-ef2b-31b6-892a-0ee087b1ce88','org.openmrs.ConceptReferenceTerm','e42cc5f3-ef2b-31b6-892a-0ee087b1ce88','2021-05-22 06:54:56',NULL,0,0),(464,'136331BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136331BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(465,'87129BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','87129BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(466,'136329BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136329BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(467,'136330BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136330BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(468,'1309BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1309BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(469,'136328BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136328BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(470,'1232FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1232FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(471,'24CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','24CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(472,'701AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','701AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(473,'134407ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134407ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(474,'234819ae-3ffb-3810-b462-2af74abc82d9','org.openmrs.ConceptReferenceTerm','234819ae-3ffb-3810-b462-2af74abc82d9','2021-05-22 06:54:56',NULL,0,0),(475,'133740ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133740ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(476,'871cebd2-730a-3a52-a41d-7923b2ae4aac','org.openmrs.ConceptReferenceTerm','871cebd2-730a-3a52-a41d-7923b2ae4aac','2021-05-22 06:54:56',NULL,0,0),(477,'134408ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134408ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(478,'3ad024b9-ac76-32d4-8d74-811e55ddf675','org.openmrs.ConceptReferenceTerm','3ad024b9-ac76-32d4-8d74-811e55ddf675','2021-05-22 06:54:56',NULL,0,0),(479,'171150ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171150ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(480,'ce98766d-7396-3b7d-9edb-e0afac50f4fd','org.openmrs.ConceptReferenceTerm','ce98766d-7396-3b7d-9edb-e0afac50f4fd','2021-05-22 06:54:56',NULL,0,0),(481,'108328BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108328BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(482,'95618BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','95618BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(483,'136321BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136321BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(484,'108327BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108327BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(485,'136320BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136320BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(486,'136322BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136322BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(487,'735BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','735BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(488,'136323BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136323BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(489,'701FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','701FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(490,'22CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','org.openmrs.ConceptAnswer','22CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC','2021-05-22 06:54:56',NULL,0,0),(491,'696AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','696AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(492,'133738ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133738ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(493,'c0e80881-be0b-354c-aa1c-3f07f12d6ca6','org.openmrs.ConceptReferenceTerm','c0e80881-be0b-354c-aa1c-3f07f12d6ca6','2021-05-22 06:54:56',NULL,0,0),(494,'134404ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134404ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(495,'3330def4-ae26-33ed-94e8-ef4aff49e16a','org.openmrs.ConceptReferenceTerm','3330def4-ae26-33ed-94e8-ef4aff49e16a','2021-05-22 06:54:56',NULL,0,0),(496,'171148ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171148ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(497,'bbae724a-df8f-3af0-99a7-ab12db79b4e8','org.openmrs.ConceptReferenceTerm','bbae724a-df8f-3af0-99a7-ab12db79b4e8','2021-05-22 06:54:56',NULL,0,0),(498,'134403ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134403ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(499,'32ba7395-96b6-3997-8e51-d3dca824b48c','org.openmrs.ConceptReferenceTerm','32ba7395-96b6-3997-8e51-d3dca824b48c','2021-05-22 06:54:56',NULL,0,0),(500,'108324BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108324BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(501,'88417BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','88417BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(502,'136315BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136315BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(503,'136314BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136314BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(504,'136312BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136312BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(505,'730BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','730BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(506,'108323BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108323BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(507,'136313BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136313BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(508,'696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(509,'146800ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','146800ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(510,'381461cd-786a-341a-9a60-5fdb36c910fc','org.openmrs.ConceptReferenceTerm','381461cd-786a-341a-9a60-5fdb36c910fc','2021-05-22 06:54:56',NULL,0,0),(511,'171052ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171052ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(512,'b115d1ee-5318-3aeb-9796-d8a4625e16ba','org.openmrs.ConceptReferenceTerm','b115d1ee-5318-3aeb-9796-d8a4625e16ba','2021-05-22 06:54:56',NULL,0,0),(513,'134152ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134152ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(514,'e6e51d1a-ba59-3ee6-8f31-5476e091e917','org.openmrs.ConceptReferenceTerm','e6e51d1a-ba59-3ee6-8f31-5476e091e917','2021-05-22 06:54:56',NULL,0,0),(515,'133670ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133670ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(516,'e9ad45a6-aa6b-37fd-95a4-47d6cd890998','org.openmrs.ConceptReferenceTerm','e9ad45a6-aa6b-37fd-95a4-47d6cd890998','2021-05-22 06:54:56',NULL,0,0),(517,'274367ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274367ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(518,'18f827da-1a64-3d22-a5c6-d64d95af9fb7','org.openmrs.ConceptReferenceTerm','18f827da-1a64-3d22-a5c6-d64d95af9fb7','2021-05-22 06:54:56',NULL,0,0),(519,'111024BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','111024BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(520,'136299BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136299BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(521,'327BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','327BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(522,'326BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','326BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(523,'325BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','325BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(524,'88764BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','88764BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(525,'301FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','301FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(526,'218584ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','218584ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(527,'7bf7a9a8-9112-325a-b632-39948e669c3d','org.openmrs.ConceptReferenceTerm','7bf7a9a8-9112-325a-b632-39948e669c3d','2021-05-22 06:54:56',NULL,0,0),(528,'146730ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','146730ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(529,'421bd953-b837-3d05-8e8e-96cc30e9806f','org.openmrs.ConceptReferenceTerm','421bd953-b837-3d05-8e8e-96cc30e9806f','2021-05-22 06:54:56',NULL,0,0),(530,'146614ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','146614ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(531,'136708BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136708BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(532,'111040BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','111040BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(533,'136709BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136709BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(534,'8d492594-c2cc-11de-8d13-0010c6dffd0f','org.openmrs.ConceptClass','8d492594-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',NULL,4,0),(535,'776c762e-7c63-4d48-ae79-354561ae8705','org.openmrs.ConceptName','776c762e-7c63-4d48-ae79-354561ae8705','2021-05-22 06:54:56',NULL,0,0),(536,'49b35229-2c27-4c7a-917a-cbcbc68669a5','org.openmrs.ConceptName','49b35229-2c27-4c7a-917a-cbcbc68669a5','2021-05-22 06:54:56',NULL,0,0),(537,'a85b0286-933b-4173-a115-83c0b6ced07c','org.openmrs.ConceptSet','a85b0286-933b-4173-a115-83c0b6ced07c','2021-05-22 06:54:56',NULL,0,0),(538,'956992bc-f7fe-4cf5-b1a0-794b19ff7a88','org.openmrs.Concept','956992bc-f7fe-4cf5-b1a0-794b19ff7a88','2021-05-22 06:54:56',NULL,0,0),(539,'cc3da266-9be5-42a5-8bd6-8e1b8b51360e','org.openmrs.ConceptSet','cc3da266-9be5-42a5-8bd6-8e1b8b51360e','2021-05-22 06:54:56',NULL,0,0),(540,'655AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','655AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(541,'171133ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171133ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(542,'52b72ff4-804a-3e6d-abd4-080d21c27f10','org.openmrs.ConceptReferenceTerm','52b72ff4-804a-3e6d-abd4-080d21c27f10','2021-05-22 06:54:56',NULL,0,0),(543,'134370ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134370ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(544,'fe6f07c3-102e-3d01-bbfb-0c183beef181','org.openmrs.ConceptReferenceTerm','fe6f07c3-102e-3d01-bbfb-0c183beef181','2021-05-22 06:54:56',NULL,0,0),(545,'133724ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133724ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(546,'84053e83-f26c-3447-b7c7-6cd4e207e3ce','org.openmrs.ConceptReferenceTerm','84053e83-f26c-3447-b7c7-6cd4e207e3ce','2021-05-22 06:54:56',NULL,0,0),(547,'274386ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274386ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(548,'2cbed242-902a-3ce2-bbf0-4edde0554835','org.openmrs.ConceptReferenceTerm','2cbed242-902a-3ce2-bbf0-4edde0554835','2021-05-22 06:54:56',NULL,0,0),(549,'274385ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274385ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(550,'1e62de83-d5d2-3210-9382-2668cc81cdde','org.openmrs.ConceptReferenceTerm','1e62de83-d5d2-3210-9382-2668cc81cdde','2021-05-22 06:54:56',NULL,0,0),(551,'138074ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138074ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(552,'cfe97ad4-1f46-3511-9a93-0efba4e99eb4','org.openmrs.ConceptReferenceTerm','cfe97ad4-1f46-3511-9a93-0efba4e99eb4','2021-05-22 06:54:56',NULL,0,0),(553,'88714BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','88714BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(554,'98727BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','98727BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(555,'138047BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138047BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(556,'86723BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86723BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(557,'138048BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138048BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(558,'687BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','687BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(559,'88717BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','88717BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(560,'655FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','655FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(561,'9060a786-c4e2-4f2c-bab8-d9d6ea236674','org.openmrs.ConceptSet','9060a786-c4e2-4f2c-bab8-d9d6ea236674','2021-05-22 06:54:56',NULL,0,0),(562,'1006AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1006AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(563,'138080ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138080ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(564,'edfc29c2-89d2-3ba8-8492-023ef121b70a','org.openmrs.ConceptReferenceTerm','edfc29c2-89d2-3ba8-8492-023ef121b70a','2021-05-22 06:54:56',NULL,0,0),(565,'274417ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274417ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(566,'5dc697df-989e-3762-93c2-8c118ff32def','org.openmrs.ConceptReferenceTerm','5dc697df-989e-3762-93c2-8c118ff32def','2021-05-22 06:54:56',NULL,0,0),(567,'134679ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134679ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(568,'5ff6be37-e287-314e-ba61-3076f4386131','org.openmrs.ConceptReferenceTerm','5ff6be37-e287-314e-ba61-3076f4386131','2021-05-22 06:54:56',NULL,0,0),(569,'145624ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','145624ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(570,'c2e9d1d5-9aa5-3754-ac06-809d201c0831','org.openmrs.ConceptReferenceTerm','c2e9d1d5-9aa5-3754-ac06-809d201c0831','2021-05-22 06:54:56',NULL,0,0),(571,'133806ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133806ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(572,'4cc4a1c9-5e77-301d-a040-3375bdded2d5','org.openmrs.ConceptReferenceTerm','4cc4a1c9-5e77-301d-a040-3375bdded2d5','2021-05-22 06:54:56',NULL,0,0),(573,'274416ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274416ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(574,'9790bc6d-deb5-3635-afa5-405cb188a6a1','org.openmrs.ConceptReferenceTerm','9790bc6d-deb5-3635-afa5-405cb188a6a1','2021-05-22 06:54:56',NULL,0,0),(575,'171269ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171269ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(576,'42c93eeb-0475-3e49-8e24-15411f0acd35','org.openmrs.ConceptReferenceTerm','42c93eeb-0475-3e49-8e24-15411f0acd35','2021-05-22 06:54:56',NULL,0,0),(577,'138059BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138059BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(578,'89551BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','89551BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(579,'138058BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138058BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(580,'1057BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1057BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(581,'86738BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86738BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(582,'1008FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1008FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(583,'a305fe05-8df3-49f7-b736-481ac6e551fa','org.openmrs.ConceptSet','a305fe05-8df3-49f7-b736-481ac6e551fa','2021-05-22 06:54:56',NULL,0,0),(584,'1010AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','1010AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(585,'1099AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1099AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(586,'1009AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1009AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(587,'171272ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171272ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(588,'09cdd6b2-3916-3d9d-89c8-433e4b07b48d','org.openmrs.ConceptReferenceTerm','09cdd6b2-3916-3d9d-89c8-433e4b07b48d','2021-05-22 06:54:56',NULL,0,0),(589,'274420ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274420ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(590,'2b97352e-9324-3835-912e-c5bc9a5de9a2','org.openmrs.ConceptReferenceTerm','2b97352e-9324-3835-912e-c5bc9a5de9a2','2021-05-22 06:54:56',NULL,0,0),(591,'138083ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138083ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(592,'2f02dc72-97cb-3662-998a-b666a8408c83','org.openmrs.ConceptReferenceTerm','2f02dc72-97cb-3662-998a-b666a8408c83','2021-05-22 06:54:56',NULL,0,0),(593,'134682ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134682ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(594,'bcb445f3-42e8-336e-9f62-de38d36348a7','org.openmrs.ConceptReferenceTerm','bcb445f3-42e8-336e-9f62-de38d36348a7','2021-05-22 06:54:56',NULL,0,0),(595,'133809ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133809ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(596,'95f6f29f-48e0-327b-be75-100b6a07ccaf','org.openmrs.ConceptReferenceTerm','95f6f29f-48e0-327b-be75-100b6a07ccaf','2021-05-22 06:54:56',NULL,0,0),(597,'86741BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86741BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(598,'99277BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','99277BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(599,'138061BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138061BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(600,'138060BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138060BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(601,'1060BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1060BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(602,'98857BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','98857BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(603,'1011FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1011FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(604,'1097AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1097AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(605,'1008AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1008AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(606,'134681ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134681ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(607,'4957e91d-8fe4-3415-9487-6676d55deb0f','org.openmrs.ConceptReferenceTerm','4957e91d-8fe4-3415-9487-6676d55deb0f','2021-05-22 06:54:56',NULL,0,0),(608,'133808ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133808ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(609,'167fe0e2-38ba-373e-ba14-3337badbf994','org.openmrs.ConceptReferenceTerm','167fe0e2-38ba-373e-ba14-3337badbf994','2021-05-22 06:54:56',NULL,0,0),(610,'138082ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138082ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(611,'a8bd4577-343e-3656-8469-df64e013fb4d','org.openmrs.ConceptReferenceTerm','a8bd4577-343e-3656-8469-df64e013fb4d','2021-05-22 06:54:56',NULL,0,0),(612,'171271ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171271ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(613,'f904e05c-df9a-30df-8cb2-6fefe83cfa37','org.openmrs.ConceptReferenceTerm','f904e05c-df9a-30df-8cb2-6fefe83cfa37','2021-05-22 06:54:56',NULL,0,0),(614,'274419ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274419ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(615,'235aa930-96b8-3c70-b0f4-f99b8f45df27','org.openmrs.ConceptReferenceTerm','235aa930-96b8-3c70-b0f4-f99b8f45df27','2021-05-22 06:54:56',NULL,0,0),(616,'138065BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138065BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(617,'86740BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86740BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(618,'1059BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1059BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(619,'93877BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','93877BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(620,'138064BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138064BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(621,'1010FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1010FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(622,'1098AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1098AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(623,'1298AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1298AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(624,'134973ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134973ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(625,'ee06d8fe-74b7-3178-be61-8d0056f9f9ab','org.openmrs.ConceptReferenceTerm','ee06d8fe-74b7-3178-be61-8d0056f9f9ab','2021-05-22 06:54:56',NULL,0,0),(626,'137371ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','137371ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(627,'6d7c9458-1edd-31cc-8de4-d63d360f53a3','org.openmrs.ConceptReferenceTerm','6d7c9458-1edd-31cc-8de4-d63d360f53a3','2021-05-22 06:54:56',NULL,0,0),(628,'138093ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138093ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(629,'7084829f-1e96-37d2-a2b3-6329d5b9fdc2','org.openmrs.ConceptReferenceTerm','7084829f-1e96-37d2-a2b3-6329d5b9fdc2','2021-05-22 06:54:56',NULL,0,0),(630,'274455ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274455ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(631,'0538b0ac-37f3-3108-9c40-e2f0d39c1106','org.openmrs.ConceptReferenceTerm','0538b0ac-37f3-3108-9c40-e2f0d39c1106','2021-05-22 06:54:56',NULL,0,0),(632,'171550ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171550ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(633,'4b9ca677-f6b2-3c13-b65d-22d70c19d7ae','org.openmrs.ConceptReferenceTerm','4b9ca677-f6b2-3c13-b65d-22d70c19d7ae','2021-05-22 06:54:56',NULL,0,0),(634,'138067BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138067BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(635,'100120BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','100120BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(636,'86784BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86784BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(637,'138066BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138066BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(638,'1385BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1385BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(639,'1299FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1299FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(640,'1096AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1096AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(641,'1007AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','1007AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(642,'133807ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133807ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(643,'0c5459b5-2845-3c63-b8f8-6bad1baefdf8','org.openmrs.ConceptReferenceTerm','0c5459b5-2845-3c63-b8f8-6bad1baefdf8','2021-05-22 06:54:56',NULL,0,0),(644,'171270ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171270ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(645,'97ca8366-aeb2-35a8-8422-f2c2a1eff06c','org.openmrs.ConceptReferenceTerm','97ca8366-aeb2-35a8-8422-f2c2a1eff06c','2021-05-22 06:54:56',NULL,0,0),(646,'274418ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274418ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(647,'b3eecee7-f640-376e-9de6-66fe9e1c5471','org.openmrs.ConceptReferenceTerm','b3eecee7-f640-376e-9de6-66fe9e1c5471','2021-05-22 06:54:56',NULL,0,0),(648,'134680ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134680ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(649,'3dc318f0-c7c5-33b8-900e-10a698f86c04','org.openmrs.ConceptReferenceTerm','3dc318f0-c7c5-33b8-900e-10a698f86c04','2021-05-22 06:54:56',NULL,0,0),(650,'138081ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138081ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(651,'c850044b-0b22-38dd-8870-5276db2badf0','org.openmrs.ConceptReferenceTerm','c850044b-0b22-38dd-8870-5276db2badf0','2021-05-22 06:54:56',NULL,0,0),(652,'1058BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1058BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(653,'138062BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138062BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(654,'86739BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86739BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(655,'92738BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','92738BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(656,'138063BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138063BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(657,'1009FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1009FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(658,'1095AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1095AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(659,'171273ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171273ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(660,'ee911473-5e3d-3972-9728-98e7c05dddb1','org.openmrs.ConceptReferenceTerm','ee911473-5e3d-3972-9728-98e7c05dddb1','2021-05-22 06:54:56',NULL,0,0),(661,'133810ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133810ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(662,'d2b0a6d7-6178-39db-8544-da84b1eb5973','org.openmrs.ConceptReferenceTerm','d2b0a6d7-6178-39db-8544-da84b1eb5973','2021-05-22 06:54:56',NULL,0,0),(663,'146757ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','146757ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(664,'a6382039-a25e-317c-8c87-892c28b3172f','org.openmrs.ConceptReferenceTerm','a6382039-a25e-317c-8c87-892c28b3172f','2021-05-22 06:54:56',NULL,0,0),(665,'134683ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134683ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(666,'08479a18-604a-3e96-8e20-a62e8c05d82b','org.openmrs.ConceptReferenceTerm','08479a18-604a-3e96-8e20-a62e8c05d82b','2021-05-22 06:54:56',NULL,0,0),(667,'86742BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86742BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(668,'138477BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138477BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(669,'1061BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','1061BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(670,'138478BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138478BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(671,'1012FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','1012FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(672,'3cf139a9-9edc-4d35-8be6-ab07fabe6f57','org.openmrs.ConceptSet','3cf139a9-9edc-4d35-8be6-ab07fabe6f57','2021-05-22 06:54:56',NULL,0,0),(673,'161488AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','161488AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(674,'1070AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1070AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(675,'161445AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.Concept','161445AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(676,'146814ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','146814ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(677,'1e7b7ce3-ba0d-3feb-9d8c-9dd236a35c4e','org.openmrs.ConceptReferenceTerm','1e7b7ce3-ba0d-3feb-9d8c-9dd236a35c4e','2021-05-22 06:54:56',NULL,0,0),(678,'218556ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','218556ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(679,'264c85bd-ede9-3849-978d-e55a92eb983d','org.openmrs.ConceptReferenceTerm','264c85bd-ede9-3849-978d-e55a92eb983d','2021-05-22 06:54:56',NULL,0,0),(680,'146590ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','146590ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(681,'561353bb-f601-3e95-8e50-fa623a40b832','org.openmrs.ConceptReferenceTerm','561353bb-f601-3e95-8e50-fa623a40b832','2021-05-22 06:54:56',NULL,0,0),(682,'8d4a4ab4-c2cc-11de-8d13-0010c6dffd0f','org.openmrs.ConceptDatatype','8d4a4ab4-c2cc-11de-8d13-0010c6dffd0f','2021-05-22 06:54:56',NULL,1,0),(683,'110990BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','110990BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(684,'1069AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1069AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(685,'790AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','790AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(686,'132961ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','132961ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(687,'ef0c1e8e-d8e6-3a85-919b-56c7b902f709','org.openmrs.ConceptReferenceTerm','ef0c1e8e-d8e6-3a85-919b-56c7b902f709','2021-05-22 06:54:56',NULL,0,0),(688,'138076ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138076ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(689,'435360e8-f47b-36c3-bf59-002e301b70dd','org.openmrs.ConceptReferenceTerm','435360e8-f47b-36c3-bf59-002e301b70dd','2021-05-22 06:54:56',NULL,0,0),(690,'171175ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171175ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(691,'18395079-b94a-3a16-9318-e7bd1c646148','org.openmrs.ConceptReferenceTerm','18395079-b94a-3a16-9318-e7bd1c646148','2021-05-22 06:54:56',NULL,0,0),(692,'134482ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134482ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(693,'4ad49ec8-2da5-30b9-b99f-4b246ec8219a','org.openmrs.ConceptReferenceTerm','4ad49ec8-2da5-30b9-b99f-4b246ec8219a','2021-05-22 06:54:56',NULL,0,0),(694,'135343BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','135343BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(695,'90059BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','90059BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(696,'86729BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86729BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(697,'828BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','828BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(698,'827BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','827BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(699,'790FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','790FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(700,'791FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','791FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(701,'2252AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','2252AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(702,'163699AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','163699AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(703,'280369ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','280369ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(704,'8861c67a-6096-321c-9c7b-e859a4ec3fef','org.openmrs.ConceptReferenceTerm','8861c67a-6096-321c-9c7b-e859a4ec3fef','2021-05-22 06:54:56',NULL,0,0),(705,'138858BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138858BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(706,'138859BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138859BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(707,'138857BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138857BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(708,'18023FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','18023FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(709,'1068AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','1068AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(710,'857AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','857AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(711,'133321ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133321ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(712,'005c51b5-a2dc-315b-b1a5-17faae4acd37','org.openmrs.ConceptReferenceTerm','005c51b5-a2dc-315b-b1a5-17faae4acd37','2021-05-22 06:54:56',NULL,0,0),(713,'134538ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134538ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(714,'491687f8-050a-379a-96ae-e8ea038a037e','org.openmrs.ConceptReferenceTerm','491687f8-050a-379a-96ae-e8ea038a037e','2021-05-22 06:54:56',NULL,0,0),(715,'138078ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138078ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(716,'d3e4aca7-ee8c-3c29-ba39-60bae59a41ab','org.openmrs.ConceptReferenceTerm','d3e4aca7-ee8c-3c29-ba39-60bae59a41ab','2021-05-22 06:54:56',NULL,0,0),(717,'132960ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','132960ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(718,'8ba89a31-ea63-3603-b114-81d67f0722d4','org.openmrs.ConceptReferenceTerm','8ba89a31-ea63-3603-b114-81d67f0722d4','2021-05-22 06:54:56',NULL,0,0),(719,'171200ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171200ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(720,'5237f96d-492a-3194-b9e6-6a723beacf69','org.openmrs.ConceptReferenceTerm','5237f96d-492a-3194-b9e6-6a723beacf69','2021-05-22 06:54:56',NULL,0,0),(721,'274409ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274409ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(722,'6889edca-ee74-3e15-8f33-49fc81880050','org.openmrs.ConceptReferenceTerm','6889edca-ee74-3e15-8f33-49fc81880050','2021-05-22 06:54:56',NULL,0,0),(723,'88961BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','88961BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(724,'136710BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136710BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(725,'901BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','901BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(726,'99741BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','99741BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(727,'86733BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86733BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(728,'136711BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','136711BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(729,'860FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','860FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(730,'2190AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','org.openmrs.ConceptSet','2190AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE','2021-05-22 06:54:56',NULL,0,0),(731,'887AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','org.openmrs.ConceptNumeric','887AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','2021-05-22 06:54:56',NULL,0,0),(732,'171213ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','171213ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(733,'b9122128-43af-397a-bf74-46ea8100a3e1','org.openmrs.ConceptReferenceTerm','b9122128-43af-397a-bf74-46ea8100a3e1','2021-05-22 06:54:56',NULL,0,0),(734,'274412ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274412ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(735,'fda4e03c-eaef-3cf4-b7d1-52008dc01a5c','org.openmrs.ConceptReferenceTerm','fda4e03c-eaef-3cf4-b7d1-52008dc01a5c','2021-05-22 06:54:56',NULL,0,0),(736,'274413ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','274413ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(737,'29cc1c59-c75a-3bbd-8a2d-731075dc179f','org.openmrs.ConceptReferenceTerm','29cc1c59-c75a-3bbd-8a2d-731075dc179f','2021-05-22 06:54:56',NULL,0,0),(738,'133875ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','133875ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(739,'b5bee009-5072-3aa3-bece-adb468eae192','org.openmrs.ConceptReferenceTerm','b5bee009-5072-3aa3-bece-adb468eae192','2021-05-22 06:54:56',NULL,0,0),(740,'138079ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','138079ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(741,'710bcf09-9d47-3dde-8686-2a958fb0567e','org.openmrs.ConceptReferenceTerm','710bcf09-9d47-3dde-8686-2a958fb0567e','2021-05-22 06:54:56',NULL,0,0),(742,'134564ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','134564ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(743,'060098ed-8631-30e8-ba5b-03030fe94cc7','org.openmrs.ConceptReferenceTerm','060098ed-8631-30e8-ba5b-03030fe94cc7','2021-05-22 06:54:56',NULL,0,0),(744,'132962ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','132962ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(745,'1a2ebd2d-7e78-3a7d-af50-d0a99413722b','org.openmrs.ConceptReferenceTerm','1a2ebd2d-7e78-3a7d-af50-d0a99413722b','2021-05-22 06:54:56',NULL,0,0),(746,'134361BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','134361BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(747,'108137BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','108137BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(748,'111055BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','111055BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(749,'92495BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','92495BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(750,'88767BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','88767BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(751,'931BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','931BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(752,'932BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','932BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(753,'86735BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','86735BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(754,'890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','org.openmrs.ConceptDescription','890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF','2021-05-22 06:54:56',NULL,0,0),(755,'146625ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','146625ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(756,'4dd5f03a-e85d-310b-a0ee-2ccaf42951df','org.openmrs.ConceptReferenceTerm','4dd5f03a-e85d-310b-a0ee-2ccaf42951df','2021-05-22 06:54:56',NULL,0,0),(757,'218599ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','218599ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(758,'e9e507b8-41d1-373f-b0a7-5c831547141a','org.openmrs.ConceptReferenceTerm','e9e507b8-41d1-373f-b0a7-5c831547141a','2021-05-22 06:54:56',NULL,0,0),(759,'146741ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptMap','146741ABBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(760,'b1066355-16a8-3984-94d2-1399946d0826','org.openmrs.ConceptReferenceTerm','b1066355-16a8-3984-94d2-1399946d0826','2021-05-22 06:54:56',NULL,0,0),(761,'111065BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','111065BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(762,'138475BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138475BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(763,'138474BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','org.openmrs.ConceptName','138474BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB','2021-05-22 06:54:56',NULL,0,0),(764,'c8dbd8f0-7d18-4b0b-b2c3-06ad28fa07c6','org.openmrs.ConceptName','c8dbd8f0-7d18-4b0b-b2c3-06ad28fa07c6','2021-05-22 06:54:56',NULL,0,0),(765,'420c171d-d885-4e29-a42a-b308dbfa13c5','org.openmrs.ConceptName','420c171d-d885-4e29-a42a-b308dbfa13c5','2021-05-22 06:54:56',NULL,0,0),(766,'56d2866a-7a3e-4a35-9028-f27ad6aa18a4','org.openmrs.ConceptName','56d2866a-7a3e-4a35-9028-f27ad6aa18a4','2021-05-22 06:54:56',NULL,0,0),(767,'d25105aa-e98c-40e0-9079-a156d1cdd774','org.openmrs.ConceptDescription','d25105aa-e98c-40e0-9079-a156d1cdd774','2021-05-22 06:54:56',NULL,0,0);
/*!40000 ALTER TABLE `metadatasharing_imported_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatasharing_imported_package`
--

DROP TABLE IF EXISTS `metadatasharing_imported_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatasharing_imported_package` (
  `imported_package_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `group_uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `subscription_url` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subscription_status` tinyint(4) DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_imported` datetime DEFAULT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `import_config` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remote_version` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`imported_package_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `metadatasharing_package_uuid` (`group_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatasharing_imported_package`
--

LOCK TABLES `metadatasharing_imported_package` WRITE;
/*!40000 ALTER TABLE `metadatasharing_imported_package` DISABLE KEYS */;
INSERT INTO `metadatasharing_imported_package` VALUES (1,'b361db25-a6ee-492b-ad87-36c3e5c0984c','9f2e81ef-50dc-4c3b-9882-839bc5446093',NULL,0,'2018-07-20 17:45:24','2021-05-22 06:54:56','Lab Orderables','Lab Orderables','<org.openmrs.module.metadatasharing.ImportConfig id=\"1\">\n  <previous>false</previous>\n  <exactMatch>OVERWRITE_MINE</exactMatch>\n  <possibleMatch>OVERWRITE_MINE</possibleMatch>\n  <noMatch>CREATE</noMatch>\n  <confirmExactMatch>false</confirmExactMatch>\n  <confirmPossibleMatch>false</confirmPossibleMatch>\n  <confirmNoMatch>false</confirmNoMatch>\n  <skipAssessing>true</skipAssessing>\n</org.openmrs.module.metadatasharing.ImportConfig>',NULL,1);
/*!40000 ALTER TABLE `metadatasharing_imported_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `note_id` int(11) NOT NULL DEFAULT '0',
  `note_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`note_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_note` (`encounter_id`),
  KEY `note_hierarchy` (`parent`),
  KEY `obs_note` (`obs_id`),
  KEY `patient_note` (`patient_id`),
  KEY `user_who_changed_note` (`changed_by`),
  KEY `user_who_created_note` (`creator`),
  CONSTRAINT `encounter_note` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `note_hierarchy` FOREIGN KEY (`parent`) REFERENCES `note` (`note_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_note` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_note` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_note` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_note` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert`
--

DROP TABLE IF EXISTS `notification_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `satisfied_by_any` tinyint(1) NOT NULL DEFAULT '0',
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_to_expire` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`alert_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `alert_creator` (`creator`),
  KEY `alert_date_to_expire_idx` (`date_to_expire`),
  KEY `user_who_changed_alert` (`changed_by`),
  CONSTRAINT `alert_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_alert` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert`
--

LOCK TABLES `notification_alert` WRITE;
/*!40000 ALTER TABLE `notification_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert_recipient`
--

DROP TABLE IF EXISTS `notification_alert_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert_recipient` (
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`alert_id`,`user_id`),
  KEY `alert_read_by_user` (`user_id`),
  CONSTRAINT `alert_read_by_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_of_alert` FOREIGN KEY (`alert_id`) REFERENCES `notification_alert` (`alert_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert_recipient`
--

LOCK TABLES `notification_alert_recipient` WRITE;
/*!40000 ALTER TABLE `notification_alert_recipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_alert_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_template`
--

DROP TABLE IF EXISTS `notification_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` text COLLATE utf8_unicode_ci,
  `subject` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recipients` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ordinal` int(11) DEFAULT '0',
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_template`
--

LOCK TABLES `notification_template` WRITE;
/*!40000 ALTER TABLE `notification_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obs`
--

DROP TABLE IF EXISTS `obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs` (
  `obs_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `encounter_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `obs_datetime` datetime NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `obs_group_id` int(11) DEFAULT NULL,
  `accession_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value_group_id` int(11) DEFAULT NULL,
  `value_coded` int(11) DEFAULT NULL,
  `value_coded_name_id` int(11) DEFAULT NULL,
  `value_drug` int(11) DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_modifier` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value_text` text COLLATE utf8_unicode_ci,
  `value_complex` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `previous_version` int(11) DEFAULT NULL,
  `form_namespace_and_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'FINAL',
  `interpretation` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `answer_concept` (`value_coded`),
  KEY `answer_concept_drug` (`value_drug`),
  KEY `encounter_observations` (`encounter_id`),
  KEY `obs_concept` (`concept_id`),
  KEY `obs_datetime_idx` (`obs_datetime`),
  KEY `obs_enterer` (`creator`),
  KEY `obs_grouping_id` (`obs_group_id`),
  KEY `obs_location` (`location_id`),
  KEY `obs_name_of_coded_value` (`value_coded_name_id`),
  KEY `obs_order` (`order_id`),
  KEY `person_obs` (`person_id`),
  KEY `previous_version` (`previous_version`),
  KEY `user_who_voided_obs` (`voided_by`),
  CONSTRAINT `answer_concept` FOREIGN KEY (`value_coded`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answer_concept_drug` FOREIGN KEY (`value_drug`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_observations` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_enterer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_grouping_id` FOREIGN KEY (`obs_group_id`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_name_of_coded_value` FOREIGN KEY (`value_coded_name_id`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_obs` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `previous_version` FOREIGN KEY (`previous_version`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_obs` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obs`
--

LOCK TABLES `obs` WRITE;
/*!40000 ALTER TABLE `obs` DISABLE KEYS */;
/*!40000 ALTER TABLE `obs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_frequency`
--

DROP TABLE IF EXISTS `order_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_frequency` (
  `order_frequency_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `frequency_per_day` double DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`order_frequency_id`),
  UNIQUE KEY `concept_id` (`concept_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_frequency_changed_by_fk` (`changed_by`),
  KEY `order_frequency_creator_fk` (`creator`),
  KEY `order_frequency_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_frequency_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_frequency_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_frequency_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_frequency_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_frequency`
--

LOCK TABLES `order_frequency` WRITE;
/*!40000 ALTER TABLE `order_frequency` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_group`
--

DROP TABLE IF EXISTS `order_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_group` (
  `order_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_set_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `order_group_reason` int(11) DEFAULT NULL,
  `parent_order_group` int(11) DEFAULT NULL,
  `previous_order_group` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_group_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_group_changed_by_fk` (`changed_by`),
  KEY `order_group_creator_fk` (`creator`),
  KEY `order_group_encounter_id_fk` (`encounter_id`),
  KEY `order_group_patient_id_fk` (`patient_id`),
  KEY `order_group_set_id_fk` (`order_set_id`),
  KEY `order_group_voided_by_fk` (`voided_by`),
  KEY `order_group_order_group_reason_fk` (`order_group_reason`),
  KEY `order_group_parent_order_group_fk` (`parent_order_group`),
  KEY `order_group_previous_order_group_fk` (`previous_order_group`),
  CONSTRAINT `order_group_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_order_group_reason_fk` FOREIGN KEY (`order_group_reason`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `order_group_parent_order_group_fk` FOREIGN KEY (`parent_order_group`) REFERENCES `order_group` (`order_group_id`),
  CONSTRAINT `order_group_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_previous_order_group_fk` FOREIGN KEY (`previous_order_group`) REFERENCES `order_group` (`order_group_id`),
  CONSTRAINT `order_group_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_group`
--

LOCK TABLES `order_group` WRITE;
/*!40000 ALTER TABLE `order_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_group_attribute`
--

DROP TABLE IF EXISTS `order_group_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_group_attribute` (
  `order_group_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_group_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text COLLATE utf8_unicode_ci NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`order_group_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_group_attribute_order_group_fk` (`order_group_id`),
  KEY `order_group_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `order_group_attribute_creator_fk` (`creator`),
  KEY `order_group_attribute_changed_by_fk` (`changed_by`),
  KEY `order_group_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `order_group_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `order_group_attribute_type` (`order_group_attribute_type_id`),
  CONSTRAINT `order_group_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_attribute_order_group_fk` FOREIGN KEY (`order_group_id`) REFERENCES `order_group` (`order_group_id`),
  CONSTRAINT `order_group_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_group_attribute`
--

LOCK TABLES `order_group_attribute` WRITE;
/*!40000 ALTER TABLE `order_group_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_group_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_group_attribute_type`
--

DROP TABLE IF EXISTS `order_group_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_group_attribute_type` (
  `order_group_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype_config` text COLLATE utf8_unicode_ci,
  `preferred_handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler_config` text COLLATE utf8_unicode_ci,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`order_group_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_group_attribute_type_creator_fk` (`creator`),
  KEY `order_group_attribute_type_changed_by_fk` (`changed_by`),
  KEY `order_group_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_group_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_group_attribute_type`
--

LOCK TABLES `order_group_attribute_type` WRITE;
/*!40000 ALTER TABLE `order_group_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_group_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set`
--

DROP TABLE IF EXISTS `order_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set` (
  `order_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `category_order_set_fk` (`category`),
  KEY `order_set_changed_by_fk` (`changed_by`),
  KEY `order_set_creator_fk` (`creator`),
  KEY `order_set_retired_by_fk` (`retired_by`),
  CONSTRAINT `category_order_set_fk` FOREIGN KEY (`category`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set`
--

LOCK TABLES `order_set` WRITE;
/*!40000 ALTER TABLE `order_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set_attribute`
--

DROP TABLE IF EXISTS `order_set_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set_attribute` (
  `order_set_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_set_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text COLLATE utf8_unicode_ci NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`order_set_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_attribute_order_set_fk` (`order_set_id`),
  KEY `order_set_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `order_set_attribute_creator_fk` (`creator`),
  KEY `order_set_attribute_changed_by_fk` (`changed_by`),
  KEY `order_set_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `order_set_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `order_set_attribute_type` (`order_set_attribute_type_id`),
  CONSTRAINT `order_set_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_attribute_order_set_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`),
  CONSTRAINT `order_set_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set_attribute`
--

LOCK TABLES `order_set_attribute` WRITE;
/*!40000 ALTER TABLE `order_set_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set_attribute_type`
--

DROP TABLE IF EXISTS `order_set_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set_attribute_type` (
  `order_set_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype_config` text COLLATE utf8_unicode_ci,
  `preferred_handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler_config` text COLLATE utf8_unicode_ci,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`order_set_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_attribute_type_creator_fk` (`creator`),
  KEY `order_set_attribute_type_changed_by_fk` (`changed_by`),
  KEY `order_set_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_set_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set_attribute_type`
--

LOCK TABLES `order_set_attribute_type` WRITE;
/*!40000 ALTER TABLE `order_set_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set_member`
--

DROP TABLE IF EXISTS `order_set_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set_member` (
  `order_set_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type` int(11) NOT NULL,
  `order_template` text COLLATE utf8_unicode_ci,
  `order_template_type` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_set_id` int(11) NOT NULL,
  `sequence_number` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`order_set_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_member_changed_by_fk` (`changed_by`),
  KEY `order_set_member_concept_id_fk` (`concept_id`),
  KEY `order_set_member_creator_fk` (`creator`),
  KEY `order_set_member_order_set_id_fk` (`order_set_id`),
  KEY `order_set_member_order_type_fk` (`order_type`),
  KEY `order_set_member_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_set_member_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_order_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_order_type_fk` FOREIGN KEY (`order_type`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set_member`
--

LOCK TABLES `order_set_member` WRITE;
/*!40000 ALTER TABLE `order_set_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_type`
--

DROP TABLE IF EXISTS `order_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_type` (
  `order_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `java_class_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`order_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_type_changed_by` (`changed_by`),
  KEY `order_type_parent_order_type` (`parent`),
  KEY `order_type_retired_status` (`retired`),
  KEY `type_created_by` (`creator`),
  KEY `user_who_retired_order_type` (`retired_by`),
  CONSTRAINT `order_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_type_parent_order_type` FOREIGN KEY (`parent`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type_created_by` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_order_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_type`
--

LOCK TABLES `order_type` WRITE;
/*!40000 ALTER TABLE `order_type` DISABLE KEYS */;
INSERT INTO `order_type` VALUES (2,'Drug Order','An order for a medication to be given to the patient',1,'2010-05-12 00:00:00',0,NULL,NULL,NULL,'131168f4-15f5-102d-96e4-000c29c2a5d7','org.openmrs.DrugOrder',NULL,NULL,NULL),(3,'Test Order','Order type for test orders',1,'2014-03-09 00:00:00',0,NULL,NULL,NULL,'52a447d3-a64a-11e3-9aeb-50e549534c5e','org.openmrs.TestOrder',NULL,NULL,NULL);
/*!40000 ALTER TABLE `order_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_type_class_map`
--

DROP TABLE IF EXISTS `order_type_class_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_type_class_map` (
  `order_type_id` int(11) NOT NULL,
  `concept_class_id` int(11) NOT NULL,
  PRIMARY KEY (`order_type_id`,`concept_class_id`),
  UNIQUE KEY `concept_class_id` (`concept_class_id`),
  CONSTRAINT `fk_order_type_class_map_concept_class_concept_class_id` FOREIGN KEY (`concept_class_id`) REFERENCES `concept_class` (`concept_class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_type_order_type_id` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_type_class_map`
--

LOCK TABLES `order_type_class_map` WRITE;
/*!40000 ALTER TABLE `order_type_class_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_type_class_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `orderer` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `instructions` text COLLATE utf8_unicode_ci,
  `date_activated` datetime DEFAULT NULL,
  `auto_expire_date` datetime DEFAULT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `order_reason` int(11) DEFAULT NULL,
  `order_reason_non_coded` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `accession_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `urgency` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ROUTINE',
  `order_number` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `previous_order_id` int(11) DEFAULT NULL,
  `order_action` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `comment_to_fulfiller` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `care_setting` int(11) NOT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `order_group_id` int(11) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `fulfiller_comment` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fulfiller_status` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `discontinued_because` (`order_reason`),
  KEY `fk_orderer_provider` (`orderer`),
  KEY `order_creator` (`creator`),
  KEY `order_for_patient` (`patient_id`),
  KEY `orders_care_setting` (`care_setting`),
  KEY `orders_in_encounter` (`encounter_id`),
  KEY `orders_order_group_id_fk` (`order_group_id`),
  KEY `previous_order_id_order_id` (`previous_order_id`),
  KEY `type_of_order` (`order_type_id`),
  KEY `user_who_voided_order` (`voided_by`),
  KEY `orders_order_number` (`order_number`),
  KEY `orders_accession_number` (`accession_number`),
  CONSTRAINT `discontinued_because` FOREIGN KEY (`order_reason`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderer_provider` FOREIGN KEY (`orderer`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `orders_care_setting` FOREIGN KEY (`care_setting`) REFERENCES `care_setting` (`care_setting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orders_in_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orders_order_group_id_fk` FOREIGN KEY (`order_group_id`) REFERENCES `order_group` (`order_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `previous_order_id_order_id` FOREIGN KEY (`previous_order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type_of_order` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_order` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `allergy_status` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`patient_id`),
  KEY `user_who_changed_pat` (`changed_by`),
  KEY `user_who_created_patient` (`creator`),
  KEY `user_who_voided_patient` (`voided_by`),
  CONSTRAINT `person_id_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_pat` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_patient` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_patient` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier`
--

DROP TABLE IF EXISTS `patient_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier` (
  `patient_identifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `identifier` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `identifier_type` int(11) NOT NULL DEFAULT '0',
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`patient_identifier_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `defines_identifier_type` (`identifier_type`),
  KEY `identifier_creator` (`creator`),
  KEY `identifier_name` (`identifier`),
  KEY `identifier_voider` (`voided_by`),
  KEY `idx_patient_identifier_patient` (`patient_id`),
  KEY `patient_identifier_changed_by` (`changed_by`),
  KEY `patient_identifier_ibfk_2` (`location_id`),
  CONSTRAINT `defines_identifier_type` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_id_patient_identifier` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifier_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifier_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_identifier_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_identifier_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier`
--

LOCK TABLES `patient_identifier` WRITE;
/*!40000 ALTER TABLE `patient_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier_type`
--

DROP TABLE IF EXISTS `patient_identifier_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier_type` (
  `patient_identifier_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `check_digit` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `format_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `validator` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location_behavior` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `uniqueness_behavior` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`patient_identifier_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_identifier_type_changed_by` (`changed_by`),
  KEY `patient_identifier_type_retired_status` (`retired`),
  KEY `type_creator` (`creator`),
  KEY `user_who_retired_patient_identifier_type` (`retired_by`),
  CONSTRAINT `patient_identifier_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_patient_identifier_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier_type`
--

LOCK TABLES `patient_identifier_type` WRITE;
/*!40000 ALTER TABLE `patient_identifier_type` DISABLE KEYS */;
INSERT INTO `patient_identifier_type` VALUES (1,'OpenMRS Identification Number','Unique number used in OpenMRS','',1,1,'2005-09-22 00:00:00',0,NULL,'org.openmrs.patient.impl.LuhnIdentifierValidator',NULL,0,NULL,NULL,NULL,'8d793bee-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL,NULL),(2,'Old Identification Number','Number given out prior to the OpenMRS system (No check digit)','',0,1,'2005-09-22 00:00:00',0,NULL,NULL,NULL,0,NULL,NULL,NULL,'8d79403a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL,NULL);
/*!40000 ALTER TABLE `patient_identifier_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program`
--

DROP TABLE IF EXISTS `patient_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_program` (
  `patient_program_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `program_id` int(11) NOT NULL DEFAULT '0',
  `date_enrolled` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `outcome_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`patient_program_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_in_program` (`patient_id`),
  KEY `patient_program_creator` (`creator`),
  KEY `patient_program_location_id` (`location_id`),
  KEY `patient_program_outcome_concept_id_fk` (`outcome_concept_id`),
  KEY `program_for_patient` (`program_id`),
  KEY `user_who_changed` (`changed_by`),
  KEY `user_who_voided_patient_program` (`voided_by`),
  CONSTRAINT `patient_in_program` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `patient_program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_outcome_concept_id_fk` FOREIGN KEY (`outcome_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_for_patient` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_patient_program` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program`
--

LOCK TABLES `patient_program` WRITE;
/*!40000 ALTER TABLE `patient_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program_attribute`
--

DROP TABLE IF EXISTS `patient_program_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_program_attribute` (
  `patient_program_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text COLLATE utf8_unicode_ci NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`patient_program_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_program_attribute_attributetype_fk` (`attribute_type_id`),
  KEY `patient_program_attribute_changed_by_fk` (`changed_by`),
  KEY `patient_program_attribute_creator_fk` (`creator`),
  KEY `patient_program_attribute_programid_fk` (`patient_program_id`),
  KEY `patient_program_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `patient_program_attribute_attributetype_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `program_attribute_type` (`program_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_programid_fk` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program_attribute`
--

LOCK TABLES `patient_program_attribute` WRITE;
/*!40000 ALTER TABLE `patient_program_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_state`
--

DROP TABLE IF EXISTS `patient_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_state` (
  `patient_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`patient_state_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_program_for_state` (`patient_program_id`),
  KEY `patient_state_changer` (`changed_by`),
  KEY `patient_state_creator` (`creator`),
  KEY `patient_state_voider` (`voided_by`),
  KEY `state_for_patient` (`state`),
  CONSTRAINT `patient_program_for_state` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_state_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_state_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `state_for_patient` FOREIGN KEY (`state`) REFERENCES `program_workflow_state` (`program_workflow_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_state`
--

LOCK TABLES `patient_state` WRITE;
/*!40000 ALTER TABLE `patient_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `birthdate` date DEFAULT NULL,
  `birthdate_estimated` tinyint(1) NOT NULL DEFAULT '0',
  `dead` tinyint(1) NOT NULL DEFAULT '0',
  `death_date` datetime DEFAULT NULL,
  `cause_of_death` int(11) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `deathdate_estimated` tinyint(1) NOT NULL DEFAULT '0',
  `birthtime` time DEFAULT NULL,
  `cause_of_death_non_coded` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `person_birthdate` (`birthdate`),
  KEY `person_death_date` (`death_date`),
  KEY `person_died_because` (`cause_of_death`),
  KEY `user_who_changed_person` (`changed_by`),
  KEY `user_who_created_person` (`creator`),
  KEY `user_who_voided_person` (`voided_by`),
  CONSTRAINT `person_died_because` FOREIGN KEY (`cause_of_death`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_person` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_person` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_person` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'M',NULL,0,0,NULL,NULL,NULL,'2005-01-01 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'5f87c042-6814-11e8-923f-e9a88dcb533f',0,NULL,NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_address` (
  `person_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city_village` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_province` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `county_district` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address4` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address5` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address6` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `address7` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address8` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address9` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address10` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address11` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address12` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address13` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address14` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address15` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`person_address_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `address_for_person` (`person_id`),
  KEY `patient_address_creator` (`creator`),
  KEY `patient_address_void` (`voided_by`),
  KEY `person_address_changed_by` (`changed_by`),
  CONSTRAINT `address_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `patient_address_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_address_void` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_address_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_address`
--

LOCK TABLES `person_address` WRITE;
/*!40000 ALTER TABLE `person_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute`
--

DROP TABLE IF EXISTS `person_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute` (
  `person_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `person_attribute_type_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`person_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `attribute_changer` (`changed_by`),
  KEY `attribute_creator` (`creator`),
  KEY `attribute_voider` (`voided_by`),
  KEY `defines_attribute_type` (`person_attribute_type_id`),
  KEY `identifies_person` (`person_id`),
  CONSTRAINT `attribute_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `attribute_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `attribute_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `defines_attribute_type` FOREIGN KEY (`person_attribute_type_id`) REFERENCES `person_attribute_type` (`person_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifies_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute`
--

LOCK TABLES `person_attribute` WRITE;
/*!40000 ALTER TABLE `person_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute_type`
--

DROP TABLE IF EXISTS `person_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute_type` (
  `person_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `format` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foreign_key` int(11) DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `edit_privilege` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`person_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `attribute_is_searchable` (`searchable`),
  KEY `attribute_type_changer` (`changed_by`),
  KEY `attribute_type_creator` (`creator`),
  KEY `name_of_attribute` (`name`),
  KEY `person_attribute_type_retired_status` (`retired`),
  KEY `privilege_which_can_edit` (`edit_privilege`),
  KEY `user_who_retired_person_attribute_type` (`retired_by`),
  CONSTRAINT `attribute_type_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `attribute_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privilege_which_can_edit` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_person_attribute_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute_type`
--

LOCK TABLES `person_attribute_type` WRITE;
/*!40000 ALTER TABLE `person_attribute_type` DISABLE KEYS */;
INSERT INTO `person_attribute_type` VALUES (1,'Race','Group of persons related by common descent or heredity','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,6,'8d871386-c2cc-11de-8d13-0010c6dffd0f'),(2,'Birthplace','Location of persons birth','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,0,'8d8718c2-c2cc-11de-8d13-0010c6dffd0f'),(3,'Citizenship','Country of which this person is a member','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,1,'8d871afc-c2cc-11de-8d13-0010c6dffd0f'),(4,'Mother\'s Name','First or last name of this person\'s mother','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,5,'8d871d18-c2cc-11de-8d13-0010c6dffd0f'),(5,'Civil Status','Marriage status of this person','org.openmrs.Concept',1054,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,2,'8d871f2a-c2cc-11de-8d13-0010c6dffd0f'),(6,'Health District','District/region in which this patient\' home health center resides','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,4,'8d872150-c2cc-11de-8d13-0010c6dffd0f'),(7,'Health Center','Specific Location of this person\'s home health center.','org.openmrs.Location',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,3,'8d87236c-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `person_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_merge_log`
--

DROP TABLE IF EXISTS `person_merge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_merge_log` (
  `person_merge_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `winner_person_id` int(11) NOT NULL,
  `loser_person_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `merged_data` text COLLATE utf8_unicode_ci NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`person_merge_log_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `person_merge_log_changed_by_fk` (`changed_by`),
  KEY `person_merge_log_creator` (`creator`),
  KEY `person_merge_log_loser` (`loser_person_id`),
  KEY `person_merge_log_voided_by_fk` (`voided_by`),
  KEY `person_merge_log_winner` (`winner_person_id`),
  CONSTRAINT `person_merge_log_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_loser` FOREIGN KEY (`loser_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_winner` FOREIGN KEY (`winner_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_merge_log`
--

LOCK TABLES `person_merge_log` WRITE;
/*!40000 ALTER TABLE `person_merge_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_merge_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_name`
--

DROP TABLE IF EXISTS `person_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_name` (
  `person_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `person_id` int(11) NOT NULL,
  `prefix` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `given_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `family_name_prefix` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `family_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `family_name2` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `family_name_suffix` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `degree` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`person_name_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `family_name2` (`family_name2`),
  KEY `first_name` (`given_name`),
  KEY `last_name` (`family_name`),
  KEY `middle_name` (`middle_name`),
  KEY `name_for_person` (`person_id`),
  KEY `user_who_made_name` (`creator`),
  KEY `user_who_voided_name` (`voided_by`),
  CONSTRAINT `name_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `user_who_made_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_name`
--

LOCK TABLES `person_name` WRITE;
/*!40000 ALTER TABLE `person_name` DISABLE KEYS */;
INSERT INTO `person_name` VALUES (1,1,1,NULL,'Super','',NULL,'User',NULL,NULL,NULL,1,'2005-01-01 00:00:00',0,NULL,NULL,NULL,NULL,NULL,'5f897a68-6814-11e8-923f-e9a88dcb533f');
/*!40000 ALTER TABLE `person_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privilege` (
  `privilege` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`privilege`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilege`
--

LOCK TABLES `privilege` WRITE;
/*!40000 ALTER TABLE `privilege` DISABLE KEYS */;
INSERT INTO `privilege` VALUES ('Add Allergies','Add allergies','8d04fc61-45de-4d16-a2f7-39ccbda88739'),('Add Cohorts','Able to add a cohort to the system','5f8a2896-6814-11e8-923f-e9a88dcb533f'),('Add Concept Proposals','Able to add concept proposals to the system','5f8a2a1c-6814-11e8-923f-e9a88dcb533f'),('Add Encounters','Able to add patient encounters','5f8a2a8a-6814-11e8-923f-e9a88dcb533f'),('Add HL7 Inbound Archive','Able to add an HL7 archive item','3192b2c9-3844-42f7-8e8e-f8964768ca26'),('Add HL7 Inbound Exception','Able to add an HL7 error item','e41c644c-1866-4572-a78d-6bfe36dd6a4b'),('Add HL7 Inbound Queue','Able to add an HL7 Queue item','b20ee658-9faa-4c6a-bc95-b5a9a4bfa4c2'),('Add HL7 Source','Able to add an HL7 Source','b8a2625f-3130-4b15-a3ba-907600d1bb03'),('Add Observations','Able to add patient observations','5f8a2ada-6814-11e8-923f-e9a88dcb533f'),('Add Orders','Able to add orders','5f8a2b7a-6814-11e8-923f-e9a88dcb533f'),('Add Patient Identifiers','Able to add patient identifiers','5f8a2bc0-6814-11e8-923f-e9a88dcb533f'),('Add Patient Programs','Able to add patients to programs','5f8a2c10-6814-11e8-923f-e9a88dcb533f'),('Add Patients','Able to add patients','5f8a2c56-6814-11e8-923f-e9a88dcb533f'),('Add People','Able to add person objects','5f8a2c92-6814-11e8-923f-e9a88dcb533f'),('Add Problems','Add problems','2f6d256a-1f73-4776-ad5b-f94c80f7beea'),('Add Relationships','Able to add relationships','5f8a2cce-6814-11e8-923f-e9a88dcb533f'),('Add Report Objects','Able to add report objects','5f8a2cf6-6814-11e8-923f-e9a88dcb533f'),('Add Reports','Able to add reports','5f8a2d32-6814-11e8-923f-e9a88dcb533f'),('Add Users','Able to add users to OpenMRS','5f8a2d5a-6814-11e8-923f-e9a88dcb533f'),('Add Visits','Able to add visits','65d14b28-3989-11e6-899a-a4d646d86a8a'),('Assign System Developer Role','Able to assign System Developer role','09cbaabc-ae63-44ed-9d4d-34ec6610e0a5'),('Configure Visits','Able to choose encounter visit handler and enable/disable encounter visits','d7899df6-68d7-49f1-bc3a-a1a64be157d6'),('Delete Cohorts','Able to add a cohort to the system','5f8a2d8c-6814-11e8-923f-e9a88dcb533f'),('Delete Concept Proposals','Able to delete concept proposals from the system','5f8a2dbe-6814-11e8-923f-e9a88dcb533f'),('Delete Conditions','Able to delete conditions','ef725ffa-2d14-41d8-b655-2d2430963b21'),('Delete Diagnoses','Able to delete diagnoses','a7882352-41b4-4da7-b422-84470ede7052'),('Delete Encounters','Able to delete patient encounters','5f8a2de6-6814-11e8-923f-e9a88dcb533f'),('Delete HL7 Inbound Archive','Able to delete/retire an HL7 archive item','7cd1f479-4e6a-422d-8b4d-7a7e5758d253'),('Delete HL7 Inbound Exception','Able to delete an HL7 archive item','25109fd5-edd1-4d11-84fe-a50b4001b50b'),('Delete HL7 Inbound Queue','Able to delete an HL7 Queue item','0e39bf44-a08b-4d61-9d20-08d2cc0ab51e'),('Delete Notes','Able to delete patient notes','ff39bade-4ea2-463b-8a66-ff4b26f85f25'),('Delete Observations','Able to delete patient observations','5f8a2e18-6814-11e8-923f-e9a88dcb533f'),('Delete Orders','Able to delete orders','5f8a2e40-6814-11e8-923f-e9a88dcb533f'),('Delete Patient Identifiers','Able to delete patient identifiers','5f8a2e72-6814-11e8-923f-e9a88dcb533f'),('Delete Patient Programs','Able to delete patients from programs','5f8a2ea4-6814-11e8-923f-e9a88dcb533f'),('Delete Patients','Able to delete patients','5f8a2ecc-6814-11e8-923f-e9a88dcb533f'),('Delete People','Able to delete objects','5f8a2efe-6814-11e8-923f-e9a88dcb533f'),('Delete Relationships','Able to delete relationships','5f8a2f26-6814-11e8-923f-e9a88dcb533f'),('Delete Report Objects','Able to delete report objects','5f8a2f58-6814-11e8-923f-e9a88dcb533f'),('Delete Reports','Able to delete reports','5f8a2f8a-6814-11e8-923f-e9a88dcb533f'),('Delete Users','Able to delete users in OpenMRS','5f8a2fb2-6814-11e8-923f-e9a88dcb533f'),('Delete Visits','Able to delete visits','02d02051-931b-4325-88d9-bf1a6cc85f5d'),('Edit Allergies','Able to edit allergies','507e9f66-ee25-4113-a55a-4b050022f55a'),('Edit Cohorts','Able to add a cohort to the system','5f8a2fe4-6814-11e8-923f-e9a88dcb533f'),('Edit Concept Proposals','Able to edit concept proposals in the system','5f8a300c-6814-11e8-923f-e9a88dcb533f'),('Edit Conditions','Able to edit conditions','910ec2ec-a87b-4528-ad5c-02c500068bf0'),('Edit Diagnoses','Able to edit diagnoses','107f5169-77a2-48d3-9f69-9f2ca9b419ca'),('Edit Encounters','Able to edit patient encounters','5f8a303e-6814-11e8-923f-e9a88dcb533f'),('Edit Notes','Able to edit patient notes','888fe070-549c-429a-9784-edbaf42e3229'),('Edit Observations','Able to edit patient observations','5f8a3066-6814-11e8-923f-e9a88dcb533f'),('Edit Orders','Able to edit orders','5f8a308e-6814-11e8-923f-e9a88dcb533f'),('Edit Patient Identifiers','Able to edit patient identifiers','5f8a30c0-6814-11e8-923f-e9a88dcb533f'),('Edit Patient Programs','Able to edit patients in programs','5f8a30e8-6814-11e8-923f-e9a88dcb533f'),('Edit Patients','Able to edit patients','5f8a311a-6814-11e8-923f-e9a88dcb533f'),('Edit People','Able to edit person objects','5f8a3142-6814-11e8-923f-e9a88dcb533f'),('Edit Problems','Able to edit problems','5131daf7-2c4d-4c2b-8f6e-bf7cf8290444'),('Edit Relationships','Able to edit relationships','5f8a3174-6814-11e8-923f-e9a88dcb533f'),('Edit Report Objects','Able to edit report objects','5f8a319c-6814-11e8-923f-e9a88dcb533f'),('Edit Reports','Able to edit reports','5f8a31ce-6814-11e8-923f-e9a88dcb533f'),('Edit User Passwords','Able to change the passwords of users in OpenMRS','5f8a31f6-6814-11e8-923f-e9a88dcb533f'),('Edit Users','Able to edit users in OpenMRS','5f8a3228-6814-11e8-923f-e9a88dcb533f'),('Edit Visits','Able to edit visits','14f4da3c-d1e1-4571-b379-0b533496f5b7'),('Form Entry','Allows user to access Form Entry pages/functions','5f8a3250-6814-11e8-923f-e9a88dcb533f'),('Get Allergies','Able to get allergies','d05118c6-2490-4d78-a41a-390e3596a220'),('Get Care Settings','Able to get Care Settings','1ab26030-a207-4a22-be52-b40be3e401dd'),('Get Concept Attribute Types','Able to get concept attribute types','498317ea-e55f-4488-9e87-0db1349c3d11'),('Get Concept Classes','Able to get concept classes','d05118c6-2490-4d78-a41a-390e3596a238'),('Get Concept Datatypes','Able to get concept datatypes','d05118c6-2490-4d78-a41a-390e3596a237'),('Get Concept Map Types','Able to get concept map types','d05118c6-2490-4d78-a41a-390e3596a230'),('Get Concept Proposals','Able to get concept proposals to the system','d05118c6-2490-4d78-a41a-390e3596a250'),('Get Concept Reference Terms','Able to get concept reference terms','d05118c6-2490-4d78-a41a-390e3596a229'),('Get Concept Sources','Able to get concept sources','d05118c6-2490-4d78-a41a-390e3596a231'),('Get Concepts','Able to get concept entries','d05118c6-2490-4d78-a41a-390e3596a251'),('Get Conditions','Able to get conditions','6b470c18-04e8-42c5-bc34-0ac871a0beb6'),('Get Database Changes','Able to get database changes from the admin screen','d05118c6-2490-4d78-a41a-390e3596a222'),('Get Diagnoses','Able to get diagnoses','77b0b402-c928-4811-b084-f0ef7087a49c'),('Get Encounter Roles','Able to get encounter roles','d05118c6-2490-4d78-a41a-390e3596a210'),('Get Encounter Types','Able to get encounter types','d05118c6-2490-4d78-a41a-390e3596a247'),('Get Encounters','Able to get patient encounters','d05118c6-2490-4d78-a41a-390e3596a248'),('Get Field Types','Able to get field types','d05118c6-2490-4d78-a41a-390e3596a234'),('Get Forms','Able to get forms','d05118c6-2490-4d78-a41a-390e3596a240'),('Get Global Properties','Able to get global properties on the administration screen','d05118c6-2490-4d78-a41a-390e3596a226'),('Get HL7 Inbound Archive','Able to get an HL7 archive item','d05118c6-2490-4d78-a41a-390e3596a217'),('Get HL7 Inbound Exception','Able to get an HL7 error item','d05118c6-2490-4d78-a41a-390e3596a216'),('Get HL7 Inbound Queue','Able to get an HL7 Queue item','d05118c6-2490-4d78-a41a-390e3596a218'),('Get HL7 Source','Able to get an HL7 Source','d05118c6-2490-4d78-a41a-390e3596a219'),('Get Identifier Types','Able to get patient identifier types','d05118c6-2490-4d78-a41a-390e3596a239'),('Get Location Attribute Types','Able to get location attribute types','d05118c6-2490-4d78-a41a-390e3596a212'),('Get Locations','Able to get locations','d05118c6-2490-4d78-a41a-390e3596a246'),('Get Notes','Able to get patient notes','dcd11774-e77c-48d5-8f34-685741dec359'),('Get Observations','Able to get patient observations','d05118c6-2490-4d78-a41a-390e3596a245'),('Get Order Frequencies','Able to get Order Frequencies','c78007dd-c641-400b-9aac-04420aecc5b6'),('Get Order Set Attribute Types','Able to get order set attribute types','3add2609-3d16-4790-8ec5-b15a8e1e57f8'),('Get Order Sets','Able to get order sets','e52af909-2baf-4ab6-9862-8a6848448ec0'),('Get Order Types','Able to get order types','d05118c6-2490-4d78-a41a-390e3596a233'),('Get Orders','Able to get orders','d05118c6-2490-4d78-a41a-390e3596a241'),('Get Patient Cohorts','Able to get patient cohorts','d05118c6-2490-4d78-a41a-390e3596a242'),('Get Patient Identifiers','Able to get patient identifiers','d05118c6-2490-4d78-a41a-390e3596a243'),('Get Patient Programs','Able to get which programs that patients are in','d05118c6-2490-4d78-a41a-390e3596a227'),('Get Patients','Able to get patients','d05118c6-2490-4d78-a41a-390e3596a244'),('Get People','Able to get person objects','d05118c6-2490-4d78-a41a-390e3596a224'),('Get Person Attribute Types','Able to get person attribute types','d05118c6-2490-4d78-a41a-390e3596a225'),('Get Privileges','Able to get user privileges','d05118c6-2490-4d78-a41a-390e3596a236'),('Get Problems','Able to get problems','d05118c6-2490-4d78-a41a-390e3596a221'),('Get Programs','Able to get patient programs','d05118c6-2490-4d78-a41a-390e3596a228'),('Get Providers','Able to get Providers','d05118c6-2490-4d78-a41a-390e3596a211'),('Get Relationship Types','Able to get relationship types','d05118c6-2490-4d78-a41a-390e3596a232'),('Get Relationships','Able to get relationships','d05118c6-2490-4d78-a41a-390e3596a223'),('Get Roles','Able to get user roles','d05118c6-2490-4d78-a41a-390e3596a235'),('Get Users','Able to get users in OpenMRS','d05118c6-2490-4d78-a41a-390e3596a249'),('Get Visit Attribute Types','Able to get visit attribute types','d05118c6-2490-4d78-a41a-390e3596a213'),('Get Visit Types','Able to get visit types','d05118c6-2490-4d78-a41a-390e3596a215'),('Get Visits','Able to get visits','d05118c6-2490-4d78-a41a-390e3596a214'),('Manage Address Templates','Able to add/edit/delete address templates','fb21b9ee-fd8a-47b6-8656-bd3a68a44925'),('Manage Alerts','Able to add/edit/delete user alerts','5f8a3282-6814-11e8-923f-e9a88dcb533f'),('Manage Concept Attribute Types','Able to add/edit/retire concept attribute types','7550fbcb-cb61-4a9f-94d5-eb376afc727f'),('Manage Concept Classes','Able to add/edit/retire concept classes','5f8a32aa-6814-11e8-923f-e9a88dcb533f'),('Manage Concept Datatypes','Able to add/edit/retire concept datatypes','5f8a32dc-6814-11e8-923f-e9a88dcb533f'),('Manage Concept Map Types','Able to add/edit/retire concept map types','385096c5-6492-41f3-8304-c0144e8fb2e6'),('Manage Concept Name tags','Able to add/edit/delete concept name tags','401cc09a-84c6-4d9e-bf93-4659837edbde'),('Manage Concept Reference Terms','Able to add/edit/retire reference terms','80e45896-d4cd-48a1-b35e-30709bab36b6'),('Manage Concept Sources','Able to add/edit/delete concept sources','5f8a3304-6814-11e8-923f-e9a88dcb533f'),('Manage Concept Stop Words','Able to view/add/remove the concept stop words','47b5b16e-0ff5-4a4a-ae26-947af73c88ca'),('Manage Concepts','Able to add/edit/delete concept entries','5f8a3336-6814-11e8-923f-e9a88dcb533f'),('Manage Encounter Roles','Able to add/edit/retire encounter roles','0fbaddea-b053-4841-a1f1-2ca93fd71d9a'),('Manage Encounter Types','Able to add/edit/delete encounter types','5f8a3368-6814-11e8-923f-e9a88dcb533f'),('Manage Field Types','Able to add/edit/retire field types','5f8a3390-6814-11e8-923f-e9a88dcb533f'),('Manage FormEntry XSN','Allows user to upload and edit the xsns stored on the server','5f8a33b8-6814-11e8-923f-e9a88dcb533f'),('Manage Forms','Able to add/edit/delete forms','5f8a33ea-6814-11e8-923f-e9a88dcb533f'),('Manage Global Properties','Able to add/edit global properties','5f8a341c-6814-11e8-923f-e9a88dcb533f'),('Manage HL7 Messages','Able to add/edit/delete HL7 messages','e43b8830-7c95-42e6-8259-538fec951c66'),('Manage Identifier Types','Able to add/edit/delete patient identifier types','5f8a3444-6814-11e8-923f-e9a88dcb533f'),('Manage Implementation Id','Able to view/add/edit the implementation id for the system','20e102e1-74b4-4198-905e-9b598c8474f1'),('Manage Location Attribute Types','Able to add/edit/retire location attribute types','5c266720-20c2-4fa2-89d3-56886176d63a'),('Manage Location Tags','Able to add/edit/delete location tags','d6d83d7f-9241-42e6-9689-393920a4f733'),('Manage Locations','Able to add/edit/delete locations','5f8a3476-6814-11e8-923f-e9a88dcb533f'),('Manage Metadata Mapping','Able to manage metadata mappings','6b62661a-ec08-4b7d-a11a-b73bab3d6c33'),('Manage Modules','Able to add/remove modules to the system','5f8a349e-6814-11e8-923f-e9a88dcb533f'),('Manage Order Frequencies','Able to add/edit/retire Order Frequencies','e3a5205d-ab12-40ca-9160-9ba02198e389'),('Manage Order Set Attribute Types','Able to add/edit/retire order set attribute types','fc4221f4-29ea-41d6-b02d-902623cfb338'),('Manage Order Sets','Able to manage order sets','059955e6-014f-4e50-b198-24e179784025'),('Manage Order Types','Able to add/edit/retire order types','5f8a34c6-6814-11e8-923f-e9a88dcb533f'),('Manage Person Attribute Types','Able to add/edit/delete person attribute types','5f8a34f8-6814-11e8-923f-e9a88dcb533f'),('Manage Privileges','Able to add/edit/delete privileges','5f8a3520-6814-11e8-923f-e9a88dcb533f'),('Manage Programs','Able to add/view/delete patient programs','5f8a3552-6814-11e8-923f-e9a88dcb533f'),('Manage Providers','Able to edit Provider','b0b6fe18-9940-42b4-80fc-b05e6ee546f5'),('Manage Relationship Types','Able to add/edit/retire relationship types','5f8a357a-6814-11e8-923f-e9a88dcb533f'),('Manage Relationships','Able to add/edit/delete relationships','5f8a35ac-6814-11e8-923f-e9a88dcb533f'),('Manage RESTWS','Allows to configure RESTWS module','bbddf8f3-41f2-40e5-a799-6a3e60b74a65'),('Manage Roles','Able to add/edit/delete user roles','5f8a35d4-6814-11e8-923f-e9a88dcb533f'),('Manage Scheduler','Able to add/edit/remove scheduled tasks','5f8a3606-6814-11e8-923f-e9a88dcb533f'),('Manage Search Index','Able to manage the search index','657bfbbb-a008-43f3-85ac-3163d201b389'),('Manage Visit Attribute Types','Able to add/edit/retire visit attribute types','d0e19ed6-a299-4435-ab8f-2ea76e22fcc4'),('Manage Visit Types','Able to add/edit/delete visit types','f9196849-164f-4522-80d8-488d36faeec2'),('Patient Dashboard - View Demographics Section','Able to view the \'Demographics\' tab on the patient dashboard','5f8a362e-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Encounters Section','Able to view the \'Encounters\' tab on the patient dashboard','5f8a3660-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Forms Section','Allows user to view the Forms tab on the patient dashboard','5f8a3692-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Graphs Section','Able to view the \'Graphs\' tab on the patient dashboard','5f8a36ce-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Overview Section','Able to view the \'Overview\' tab on the patient dashboard','5f8a3700-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Patient Summary','Able to view the \'Summary\' tab on the patient dashboard','5f8a3732-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Regimen Section','Able to view the \'Regimen\' tab on the patient dashboard','5f8a375a-6814-11e8-923f-e9a88dcb533f'),('Patient Overview - View Allergies','Able to view the Allergies portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a261'),('Patient Overview - View Patient Actions','Able to view the Patient Actions portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a264'),('Patient Overview - View Problem List','Able to view the Problem List portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a260'),('Patient Overview - View Programs','Able to view the Programs portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a263'),('Patient Overview - View Relationships','Able to view the Relationships portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a262'),('Purge Field Types','Able to purge field types','5f8a3796-6814-11e8-923f-e9a88dcb533f'),('Remove Allergies','Remove allergies','dbdea8f5-9fca-4527-9ef6-5fa03eebf2bd'),('Remove Problems','Remove problems','28ea7e84-e21a-4031-9f9f-2d3eda9d1200'),('Share Metadata','Allows user to export and import metadata','047c9f76-83c8-4a1b-a459-f2f87b6d93ce'),('Task: Modify Allergies','Able to add, edit, delete allergies','eeb9108e-6905-4712-a13c-b9435db4abcb'),('Update HL7 Inbound Archive','Able to update an HL7 archive item','5dd8306f-eeb4-430e-b5da-a6e02bcafb79'),('Update HL7 Inbound Exception','Able to update an HL7 archive item','e2614f6d-a730-4292-9c10-baf6d912500f'),('Update HL7 Inbound Queue','Able to update an HL7 Queue item','f82b7723-110e-47d3-a35b-4552ea1bff9e'),('Update HL7 Source','Able to update an HL7 Source','6e0abfb7-e95c-4efd-82a0-00a02b0e8335'),('Upload XSN','Allows user to upload/overwrite the XSNs defined for forms','5f8a37c8-6814-11e8-923f-e9a88dcb533f'),('View Administration Functions','Able to view the \'Administration\' link in the navigation bar','5f8a37fa-6814-11e8-923f-e9a88dcb533f'),('View Allergies','Able to view allergies in OpenMRS','5f8a382c-6814-11e8-923f-e9a88dcb533f'),('View Concept Classes','Able to view concept classes','5f8a3958-6814-11e8-923f-e9a88dcb533f'),('View Concept Datatypes','Able to view concept datatypes','5f8a398a-6814-11e8-923f-e9a88dcb533f'),('View Concept Proposals','Able to view concept proposals to the system','5f8a39bc-6814-11e8-923f-e9a88dcb533f'),('View Concept Sources','Able to view concept sources','5f8a39ee-6814-11e8-923f-e9a88dcb533f'),('View Concepts','Able to view concept entries','5f8a3a16-6814-11e8-923f-e9a88dcb533f'),('View Data Entry Statistics','Able to view data entry statistics from the admin screen','5f8a3a48-6814-11e8-923f-e9a88dcb533f'),('View Encounter Types','Able to view encounter types','5f8a3a7a-6814-11e8-923f-e9a88dcb533f'),('View Encounters','Able to view patient encounters','5f8a3aa2-6814-11e8-923f-e9a88dcb533f'),('View Field Types','Able to view field types','5f8a3ad4-6814-11e8-923f-e9a88dcb533f'),('View Forms','Able to view forms','5f8a3afc-6814-11e8-923f-e9a88dcb533f'),('View Global Properties','Able to view global properties on the administration screen','5f8a3b2e-6814-11e8-923f-e9a88dcb533f'),('View Identifier Types','Able to view patient identifier types','5f8a3b60-6814-11e8-923f-e9a88dcb533f'),('View Locations','Able to view locations','5f8a3b88-6814-11e8-923f-e9a88dcb533f'),('View Metadata Via Mapping','Able to view metadata via a mapping','ff08b6a6-8e7d-4701-aa26-455170cdda64'),('View Navigation Menu','Ability to see the navigation menu','5f8a3bba-6814-11e8-923f-e9a88dcb533f'),('View Observations','Able to view patient observations','5f8a3be2-6814-11e8-923f-e9a88dcb533f'),('View Order Types','Able to view order types','5f8a3c14-6814-11e8-923f-e9a88dcb533f'),('View Orders','Able to view orders','5f8a3c46-6814-11e8-923f-e9a88dcb533f'),('View Patient Cohorts','Able to view patient cohorts','5f8a3c6e-6814-11e8-923f-e9a88dcb533f'),('View Patient Identifiers','Able to view patient identifiers','5f8a3ca0-6814-11e8-923f-e9a88dcb533f'),('View Patient Programs','Able to see which programs that patients are in','5f8a3cd2-6814-11e8-923f-e9a88dcb533f'),('View Patients','Able to view patients','5f8a3cfa-6814-11e8-923f-e9a88dcb533f'),('View People','Able to view person objects','5f8a3d2c-6814-11e8-923f-e9a88dcb533f'),('View Person Attribute Types','Able to view person attribute types','5f8a3d5e-6814-11e8-923f-e9a88dcb533f'),('View Privileges','Able to view user privileges','5f8a3d86-6814-11e8-923f-e9a88dcb533f'),('View Problems','Able to view problems in OpenMRS','5f8a3db8-6814-11e8-923f-e9a88dcb533f'),('View Programs','Able to view patient programs','5f8a3de0-6814-11e8-923f-e9a88dcb533f'),('View Relationship Types','Able to view relationship types','5f8a3e12-6814-11e8-923f-e9a88dcb533f'),('View Relationships','Able to view relationships','5f8a3e44-6814-11e8-923f-e9a88dcb533f'),('View Report Objects','Able to view report objects','5f8a3e6c-6814-11e8-923f-e9a88dcb533f'),('View Reports','Able to view reports','5f8a3e9e-6814-11e8-923f-e9a88dcb533f'),('View RESTWS','Gives access to RESTWS in administration','3cc106d4-4f52-4f20-84e0-40c40c033c44'),('View Roles','Able to view user roles','5f8a3ec6-6814-11e8-923f-e9a88dcb533f'),('View Unpublished Forms','Able to view and fill out unpublished forms','5f8a3ef8-6814-11e8-923f-e9a88dcb533f'),('View Users','Able to view users in OpenMRS','5f8a3f2a-6814-11e8-923f-e9a88dcb533f');
/*!40000 ALTER TABLE `privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `outcomes_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `program_concept` (`concept_id`),
  KEY `program_creator` (`creator`),
  KEY `program_outcomes_concept_id_fk` (`outcomes_concept_id`),
  KEY `user_who_changed_program` (`changed_by`),
  CONSTRAINT `program_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_outcomes_concept_id_fk` FOREIGN KEY (`outcomes_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_program` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_attribute_type`
--

DROP TABLE IF EXISTS `program_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_attribute_type` (
  `program_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype_config` text COLLATE utf8_unicode_ci,
  `preferred_handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler_config` text COLLATE utf8_unicode_ci,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`program_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `program_attribute_type_changed_by_fk` (`changed_by`),
  KEY `program_attribute_type_creator_fk` (`creator`),
  KEY `program_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `program_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_attribute_type`
--

LOCK TABLES `program_attribute_type` WRITE;
/*!40000 ALTER TABLE `program_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow`
--

DROP TABLE IF EXISTS `program_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow` (
  `program_workflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`program_workflow_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `program_for_workflow` (`program_id`),
  KEY `workflow_changed_by` (`changed_by`),
  KEY `workflow_concept` (`concept_id`),
  KEY `workflow_creator` (`creator`),
  CONSTRAINT `program_for_workflow` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `workflow_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `workflow_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `workflow_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow`
--

LOCK TABLES `program_workflow` WRITE;
/*!40000 ALTER TABLE `program_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow_state`
--

DROP TABLE IF EXISTS `program_workflow_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow_state` (
  `program_workflow_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_workflow_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `initial` tinyint(1) NOT NULL DEFAULT '0',
  `terminal` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`program_workflow_state_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `state_changed_by` (`changed_by`),
  KEY `state_concept` (`concept_id`),
  KEY `state_creator` (`creator`),
  KEY `workflow_for_state` (`program_workflow_id`),
  CONSTRAINT `state_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `state_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `workflow_for_state` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow_state`
--

LOCK TABLES `program_workflow_state` WRITE;
/*!40000 ALTER TABLE `program_workflow_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider` (
  `provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `speciality_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_changed_by_fk` (`changed_by`),
  KEY `provider_creator_fk` (`creator`),
  KEY `provider_person_id_fk` (`person_id`),
  KEY `provider_retired_by_fk` (`retired_by`),
  KEY `provider_role_id_fk` (`role_id`),
  KEY `provider_speciality_id_fk` (`speciality_id`),
  CONSTRAINT `provider_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_person_id_fk` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_speciality_id_fk` FOREIGN KEY (`speciality_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_attribute`
--

DROP TABLE IF EXISTS `provider_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_attribute` (
  `provider_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text COLLATE utf8_unicode_ci NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`provider_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `provider_attribute_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_creator_fk` (`creator`),
  KEY `provider_attribute_provider_fk` (`provider_id`),
  KEY `provider_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `provider_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `provider_attribute_type` (`provider_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_provider_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_attribute`
--

LOCK TABLES `provider_attribute` WRITE;
/*!40000 ALTER TABLE `provider_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_attribute_type`
--

DROP TABLE IF EXISTS `provider_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_attribute_type` (
  `provider_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype_config` text COLLATE utf8_unicode_ci,
  `preferred_handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler_config` text COLLATE utf8_unicode_ci,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`provider_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_type_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_type_creator_fk` (`creator`),
  KEY `provider_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `provider_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_attribute_type`
--

LOCK TABLES `provider_attribute_type` WRITE;
/*!40000 ALTER TABLE `provider_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship` (
  `relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_a` int(11) NOT NULL,
  `relationship` int(11) NOT NULL DEFAULT '0',
  `person_b` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`relationship_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `person_a_is_person` (`person_a`),
  KEY `person_b_is_person` (`person_b`),
  KEY `relation_creator` (`creator`),
  KEY `relation_voider` (`voided_by`),
  KEY `relationship_changed_by` (`changed_by`),
  KEY `relationship_type_id` (`relationship`),
  CONSTRAINT `person_a_is_person` FOREIGN KEY (`person_a`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_b_is_person` FOREIGN KEY (`person_b`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relation_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relation_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relationship_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relationship_type_id` FOREIGN KEY (`relationship`) REFERENCES `relationship_type` (`relationship_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship`
--

LOCK TABLES `relationship` WRITE;
/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship_type`
--

DROP TABLE IF EXISTS `relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship_type` (
  `relationship_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_is_to_b` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `b_is_to_a` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `weight` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`relationship_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `relationship_type_changed_by` (`changed_by`),
  KEY `user_who_created_rel` (`creator`),
  KEY `user_who_retired_relationship_type` (`retired_by`),
  CONSTRAINT `relationship_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_rel` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_relationship_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship_type`
--

LOCK TABLES `relationship_type` WRITE;
/*!40000 ALTER TABLE `relationship_type` DISABLE KEYS */;
INSERT INTO `relationship_type` VALUES (1,'Doctor','Patient',0,0,'Relationship from a primary care provider to the patient',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d919b58-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(2,'Sibling','Sibling',0,0,'Relationship between brother/sister, brother/brother, and sister/sister',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d91a01c-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(3,'Parent','Child',0,0,'Relationship from a mother/father to the child',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d91a210-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(4,'Aunt/Uncle','Niece/Nephew',0,0,'Relationship from a parent\'s sibling to a child of that parent',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d91a3dc-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL);
/*!40000 ALTER TABLE `relationship_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_object`
--

DROP TABLE IF EXISTS `report_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_object` (
  `report_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `report_object_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `report_object_sub_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `xml_data` text COLLATE utf8_unicode_ci,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`report_object_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `report_object_creator` (`creator`),
  KEY `user_who_changed_report_object` (`changed_by`),
  KEY `user_who_voided_report_object` (`voided_by`),
  CONSTRAINT `report_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_report_object` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_report_object` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_object`
--

LOCK TABLES `report_object` WRITE;
/*!40000 ALTER TABLE `report_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_schema_xml`
--

DROP TABLE IF EXISTS `report_schema_xml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_schema_xml` (
  `report_schema_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `xml_data` text COLLATE utf8_unicode_ci NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`report_schema_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_schema_xml`
--

LOCK TABLES `report_schema_xml` WRITE;
/*!40000 ALTER TABLE `report_schema_xml` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_schema_xml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`role`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('Anonymous','Privileges for non-authenticated users.','774b2af3-6437-4e5a-a310-547554c7c65c'),('Authenticated','Privileges gained once authentication has been established.','f7fd42ef-880e-40c5-972d-e4ae7c990de2'),('Provider','All users with the \'Provider\' role will appear as options in the default Infopath ','8d94f280-c2cc-11de-8d13-0010c6dffd0f'),('System Developer','Developers of the OpenMRS .. have additional access to change fundamental structure of the database model.','8d94f852-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_privilege`
--

DROP TABLE IF EXISTS `role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_privilege` (
  `role` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `privilege` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`role`,`privilege`),
  KEY `privilege_definitions` (`privilege`),
  KEY `role_privilege_to_role` (`role`),
  CONSTRAINT `privilege_definitions` FOREIGN KEY (`privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `role_privilege_to_role` FOREIGN KEY (`role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_privilege`
--

LOCK TABLES `role_privilege` WRITE;
/*!40000 ALTER TABLE `role_privilege` DISABLE KEYS */;
INSERT INTO `role_privilege` VALUES ('Authenticated','Get Concept Classes'),('Authenticated','Get Concept Datatypes'),('Authenticated','Get Encounter Types'),('Authenticated','Get Field Types'),('Authenticated','Get Global Properties'),('Authenticated','Get Identifier Types'),('Authenticated','Get Locations'),('Authenticated','Get Order Types'),('Authenticated','Get Person Attribute Types'),('Authenticated','Get Privileges'),('Authenticated','Get Relationship Types'),('Authenticated','Get Relationships'),('Authenticated','Get Roles'),('Authenticated','Patient Overview - View Relationships'),('Authenticated','View Concept Classes'),('Authenticated','View Concept Datatypes'),('Authenticated','View Encounter Types'),('Authenticated','View Field Types'),('Authenticated','View Global Properties'),('Authenticated','View Identifier Types'),('Authenticated','View Locations'),('Authenticated','View Order Types'),('Authenticated','View Person Attribute Types'),('Authenticated','View Privileges'),('Authenticated','View Relationship Types'),('Authenticated','View Relationships'),('Authenticated','View Roles');
/*!40000 ALTER TABLE `role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_role`
--

DROP TABLE IF EXISTS `role_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_role` (
  `parent_role` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `child_role` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`parent_role`,`child_role`),
  KEY `inherited_role` (`child_role`),
  CONSTRAINT `inherited_role` FOREIGN KEY (`child_role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parent_role` FOREIGN KEY (`parent_role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_role`
--

LOCK TABLES `role_role` WRITE;
/*!40000 ALTER TABLE `role_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config`
--

DROP TABLE IF EXISTS `scheduler_task_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config` (
  `task_config_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `schedulable_class` text COLLATE utf8_unicode_ci,
  `start_time` datetime DEFAULT NULL,
  `start_time_pattern` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `repeat_interval` int(11) NOT NULL DEFAULT '0',
  `start_on_startup` tinyint(1) NOT NULL DEFAULT '0',
  `started` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(11) DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `last_execution_time` datetime DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`task_config_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `scheduler_changer` (`changed_by`),
  KEY `scheduler_creator` (`created_by`),
  CONSTRAINT `scheduler_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `scheduler_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config`
--

LOCK TABLES `scheduler_task_config` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config` DISABLE KEYS */;
INSERT INTO `scheduler_task_config` VALUES (2,'Auto Close Visits Task','Stops all active visits that match the visit type(s) specified by the value of the global property \'visits.autoCloseVisitType\'','org.openmrs.scheduler.tasks.AutoCloseVisitsTask','2011-11-28 23:59:59','MM/dd/yyyy HH:mm:ss',86400,0,0,1,'2018-06-04 18:30:16',NULL,NULL,NULL,'8c17b376-1a2b-11e1-a51a-00248140a5eb');
/*!40000 ALTER TABLE `scheduler_task_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config_property`
--

DROP TABLE IF EXISTS `scheduler_task_config_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config_property` (
  `task_config_property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `task_config_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_config_property_id`),
  KEY `task_config_for_property` (`task_config_id`),
  CONSTRAINT `task_config_for_property` FOREIGN KEY (`task_config_id`) REFERENCES `scheduler_task_config` (`task_config_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config_property`
--

LOCK TABLES `scheduler_task_config_property` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_config_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serialized_object`
--

DROP TABLE IF EXISTS `serialized_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serialized_object` (
  `serialized_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(5000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subtype` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `serialization_class` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `serialized_data` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`serialized_object_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `serialized_object_changed_by` (`changed_by`),
  KEY `serialized_object_creator` (`creator`),
  KEY `serialized_object_retired_by` (`retired_by`),
  CONSTRAINT `serialized_object_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `serialized_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `serialized_object_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serialized_object`
--

LOCK TABLES `serialized_object` WRITE;
/*!40000 ALTER TABLE `serialized_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `serialized_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_order`
--

DROP TABLE IF EXISTS `test_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `specimen_source` int(11) DEFAULT NULL,
  `laterality` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `clinical_history` text COLLATE utf8_unicode_ci,
  `frequency` int(11) DEFAULT NULL,
  `number_of_repeats` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `test_order_frequency_fk` (`frequency`),
  KEY `test_order_specimen_source_fk` (`specimen_source`),
  CONSTRAINT `test_order_frequency_fk` FOREIGN KEY (`frequency`) REFERENCES `order_frequency` (`order_frequency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `test_order_order_id_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `test_order_specimen_source_fk` FOREIGN KEY (`specimen_source`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_order`
--

LOCK TABLES `test_order` WRITE;
/*!40000 ALTER TABLE `test_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_property`
--

DROP TABLE IF EXISTS `user_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_property` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `property` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `property_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`property`),
  CONSTRAINT `user_property_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_property`
--

LOCK TABLES `user_property` WRITE;
/*!40000 ALTER TABLE `user_property` DISABLE KEYS */;
INSERT INTO `user_property` VALUES (1,'loginAttempts','0');
/*!40000 ALTER TABLE `user_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`role`),
  KEY `role_definitions` (`role`),
  KEY `user_role_to_users` (`user_id`),
  CONSTRAINT `role_definitions` FOREIGN KEY (`role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_role_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'Provider'),(1,'System Developer');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `username` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `secret_question` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `secret_answer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `activation_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `person_id_for_user` (`person_id`),
  KEY `user_creator` (`creator`),
  KEY `user_who_changed_user` (`changed_by`),
  KEY `user_who_retired_this_user` (`retired_by`),
  CONSTRAINT `person_id_for_user` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_this_user` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','','0435203a74a44f3e37961842f6a0e534586c41784f5b4a89a6fb11d0fbe0cf7aad54565d020b32ed3b02f63502c13d12c5115b8848eac8b004f26d70ce8aef37','3cb2600248dfabeb51459ad35eb0fea50794b90955e4db92f4d16ac787e2a64d33122df0223dae55b163720df17bea0861e49077ef1246ad003310e2f295012b',NULL,NULL,1,'2005-01-01 00:00:00',1,'2021-05-22 06:10:13',1,0,NULL,NULL,NULL,'82f18b44-6814-11e8-923f-e9a88dcb533f',NULL,NULL),(2,'daemon','daemon',NULL,NULL,NULL,NULL,1,'2010-04-26 13:25:00',NULL,NULL,1,0,NULL,NULL,NULL,'A4F30A1B-5EB9-11DF-A648-37A07F9C90FB',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit` (
  `visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `visit_type_id` int(11) NOT NULL,
  `date_started` datetime NOT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `indication_concept_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`visit_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_changed_by_fk` (`changed_by`),
  KEY `visit_creator_fk` (`creator`),
  KEY `visit_indication_concept_fk` (`indication_concept_id`),
  KEY `visit_location_fk` (`location_id`),
  KEY `visit_patient_index` (`patient_id`),
  KEY `visit_type_fk` (`visit_type_id`),
  KEY `visit_voided_by_fk` (`voided_by`),
  CONSTRAINT `visit_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_indication_concept_fk` FOREIGN KEY (`indication_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_type_fk` FOREIGN KEY (`visit_type_id`) REFERENCES `visit_type` (`visit_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit`
--

LOCK TABLES `visit` WRITE;
/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_attribute`
--

DROP TABLE IF EXISTS `visit_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_attribute` (
  `visit_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text COLLATE utf8_unicode_ci NOT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`visit_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `visit_attribute_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_creator_fk` (`creator`),
  KEY `visit_attribute_visit_fk` (`visit_id`),
  KEY `visit_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `visit_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `visit_attribute_type` (`visit_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_visit_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_attribute`
--

LOCK TABLES `visit_attribute` WRITE;
/*!40000 ALTER TABLE `visit_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_attribute_type`
--

DROP TABLE IF EXISTS `visit_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_attribute_type` (
  `visit_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datatype_config` text COLLATE utf8_unicode_ci,
  `preferred_handler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler_config` text COLLATE utf8_unicode_ci,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`visit_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_type_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_type_creator_fk` (`creator`),
  KEY `visit_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `visit_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_attribute_type`
--

LOCK TABLES `visit_attribute_type` WRITE;
/*!40000 ALTER TABLE `visit_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_type`
--

DROP TABLE IF EXISTS `visit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_type` (
  `visit_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(38) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`visit_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_type_changed_by` (`changed_by`),
  KEY `visit_type_creator` (`creator`),
  KEY `visit_type_retired_by` (`retired_by`),
  CONSTRAINT `visit_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_type_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_type`
--

LOCK TABLES `visit_type` WRITE;
/*!40000 ALTER TABLE `visit_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-22  8:55:24
