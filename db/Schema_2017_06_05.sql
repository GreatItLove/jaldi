-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 40.68.158.96    Database: jaldi
-- ------------------------------------------------------
-- Server version	5.7.18

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
-- Table structure for table `dataStore`
--

DROP TABLE IF EXISTS `dataStore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataStore` (
  `id` varchar(100) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `contentType` varchar(100) DEFAULT NULL,
  `url` varchar(4000) NOT NULL,
  `type` varchar(100) NOT NULL DEFAULT 'UNKNOWN',
  `creationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  `workers` int(11) NOT NULL,
  `hours` decimal(5,1) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `comment` text,
  `latitude` decimal(18,12) DEFAULT NULL,
  `longitude` decimal(18,12) DEFAULT NULL,
  `cost` decimal(15,2) NOT NULL,
  `paymentType` varchar(45) NOT NULL,
  `orderDate` datetime NOT NULL,
  `userId` int(11) NOT NULL,
  `userRating` decimal(3,2) DEFAULT NULL,
  `userFeedback` text,
  `creationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `orderUserId_fk_idx` (`userId`),
  CONSTRAINT `orderUserId_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orderWorker`
--

DROP TABLE IF EXISTS `orderWorker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderWorker` (
  `orderId` int(11) NOT NULL,
  `workerId` int(11) NOT NULL,
  PRIMARY KEY (`orderId`,`workerId`),
  KEY `orderWorkerWorkerId_fk_idx` (`workerId`),
  CONSTRAINT `orderWorkerOrderId_fk` FOREIGN KEY (`orderId`) REFERENCES `order` (`id`),
  CONSTRAINT `orderWorkerWorkerId_fk` FOREIGN KEY (`workerId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(100) NOT NULL,
  `userId` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tokenUserId_fk_idx` (`userId`),
  CONSTRAINT `tokenUserId_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(200) NOT NULL,
  `name` varchar(300) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL DEFAULT 'USER',
  `type` varchar(45) NOT NULL DEFAULT 'EXTERNAL',
  `profileImageId` varchar(100) DEFAULT NULL,
  `latitude` decimal(18,12) DEFAULT NULL,
  `longitude` decimal(18,12) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `creationDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `userProfileImageId_fk_idx` (`profileImageId`),
  CONSTRAINT `userProfileImageId_fk` FOREIGN KEY (`profileImageId`) REFERENCES `dataStore` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `verification`
--

DROP TABLE IF EXISTS `verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipient` varchar(100) NOT NULL,
  `code` varchar(45) NOT NULL,
  `creationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workerDetails`
--

DROP TABLE IF EXISTS `workerDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workerDetails` (
  `userId` int(11) NOT NULL,
  `isCleaner` tinyint(1) NOT NULL,
  `isCarpenter` tinyint(1) NOT NULL DEFAULT '0',
  `isElectrician` tinyint(1) NOT NULL DEFAULT '0',
  `isMason` tinyint(1) NOT NULL DEFAULT '0',
  `isPainter` tinyint(1) NOT NULL DEFAULT '0',
  `isPlumber` tinyint(1) NOT NULL DEFAULT '0',
  `isAcTechnical` tinyint(1) NOT NULL DEFAULT '0',
  `rating` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `workerDetailsUserId_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'jaldi'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-05 17:22:10
