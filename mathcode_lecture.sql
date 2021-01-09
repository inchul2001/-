-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: mathcode
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `lecture`
--

DROP TABLE IF EXISTS `lecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecture` (
  `lectureNum` int NOT NULL AUTO_INCREMENT,
  `day` int DEFAULT NULL,
  `time` int DEFAULT NULL,
  `classroom` char(20) DEFAULT NULL,
  `teacherId` char(20) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  PRIMARY KEY (`lectureNum`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecture`
--

LOCK TABLES `lecture` WRITE;
/*!40000 ALTER TABLE `lecture` DISABLE KEYS */;
INSERT INTO `lecture` VALUES (1,0,0,'301호','굳건이선생님',10,NULL,NULL),(2,0,1,'301호','굳건이선생님',10,NULL,NULL),(3,0,2,'301호','굳건이선생님',10,NULL,NULL),(4,0,4,'301호','굳건이선생님',10,NULL,NULL),(5,0,5,'301호','굳건이선생님',10,NULL,NULL),(6,0,4,'401호','김선생님',10,NULL,NULL),(7,0,5,'401호','김선생님',10,NULL,NULL),(8,0,6,'401호','김선생님',10,NULL,NULL),(9,0,7,'401호','김선생님',10,NULL,NULL),(10,0,4,'302호','토끼선생님',10,NULL,NULL),(11,0,5,'302호','토끼선생님',10,NULL,NULL),(12,1,8,'301호','굳건이선생님',10,NULL,NULL),(13,1,9,'301호','굳건이선생님',10,NULL,NULL),(14,1,10,'301호','굳건이선생님',10,NULL,NULL),(15,1,11,'301호','굳건이선생님',10,NULL,NULL),(16,1,6,'301호','김선생님',5,NULL,NULL),(17,1,7,'301호','김선생님',5,NULL,NULL),(18,1,8,'302호','토끼선생님',10,NULL,NULL),(19,1,9,'302호','토끼선생님',10,NULL,NULL),(20,1,10,'302호','토끼선생님',10,NULL,NULL),(21,1,11,'302호','토끼선생님',10,NULL,NULL),(22,1,12,'302호','토끼선생님',10,NULL,NULL),(23,5,0,'301호','박인철',10,NULL,NULL),(24,3,10,'401호','김선생님',10,NULL,NULL),(25,3,11,'401호','김선생님',10,NULL,NULL),(26,3,12,'401호','김선생님',10,NULL,NULL),(27,3,13,'401호','김선생님',10,NULL,NULL),(28,5,10,'401호','김선생님',10,NULL,NULL),(29,5,11,'401호','김선생님',10,NULL,NULL),(30,5,12,'401호','김선생님',10,NULL,NULL),(31,5,13,'401호','김선생님',10,NULL,NULL);
/*!40000 ALTER TABLE `lecture` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-09 21:45:53
