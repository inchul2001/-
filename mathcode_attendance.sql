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
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `attendanceNum` int NOT NULL AUTO_INCREMENT,
  `studentId` char(20) DEFAULT NULL,
  `attendDate` date DEFAULT NULL,
  `comeTime` time DEFAULT NULL,
  `goTime` time DEFAULT NULL,
  PRIMARY KEY (`attendanceNum`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (3,'mathmaster','2021-01-03','05:14:14',NULL),(4,'mathmaster','2021-01-03','05:25:55',NULL),(6,'mathmaster','2021-01-03',NULL,'05:26:11'),(7,'studyYJ','2021-01-03','05:27:13',NULL),(8,'studyYJ','2021-01-03',NULL,'05:27:13'),(9,'studyYJ','2021-01-03','05:27:16',NULL),(10,'studyYJ','2021-01-03',NULL,'05:27:17'),(11,'psg2002','2021-01-03','05:27:28',NULL),(12,'psg2002','2021-01-03',NULL,'05:27:29'),(13,'mathmaster','2021-01-03',NULL,'05:27:30'),(14,'mathmaster','2021-01-03','05:27:31',NULL),(18,'mathmaster','2021-01-03',NULL,'05:27:41'),(21,'studyYJ','2021-01-07','10:00:00',NULL),(22,'studyYJ','2021-01-07',NULL,'11:32:31'),(23,'studyYJ','2021-01-07','11:45:17',NULL),(24,'studyYJ','2021-01-07',NULL,'11:45:19'),(25,'studyYJ','2021-01-09','18:00:00',NULL),(26,'studyYJ','2021-01-09',NULL,'20:07:01'),(27,'dongjun','2020-12-20','12:12:37',NULL),(28,'dongjun','2020-12-20',NULL,'16:03:43'),(29,'dongjun','2020-12-21','14:02:37',NULL),(30,'dongjun','2020-12-21',NULL,'21:11:03'),(31,'dongjun','2020-12-23','19:02:14',NULL),(32,'dongjun','2020-12-23',NULL,'20:58:14'),(33,'dongjun','2020-12-25','19:13:40',NULL),(34,'dongjun','2020-12-25',NULL,'21:15:32'),(35,'dongjun','2020-12-27','11:58:03',NULL),(36,'dongjun','2020-12-27',NULL,'15:48:43'),(37,'dongjun','2020-12-30','19:00:37',NULL),(38,'dongjun','2020-12-30',NULL,'20:58:30'),(39,'dongjun','2021-01-01','19:12:37',NULL),(40,'dongjun','2021-01-01',NULL,'21:03:15'),(41,'dongjun','2021-01-03','11:47:37',NULL),(42,'dongjun','2021-01-03',NULL,'15:55:12'),(43,'dongjun','2021-01-04','14:03:03',NULL),(44,'dongjun','2021-01-04',NULL,'20:58:13'),(45,'dongjun','2021-01-06','19:03:07',NULL),(46,'dongjun','2021-01-06',NULL,'21:02:14'),(47,'dongjun','2021-01-08','18:55:15',NULL),(48,'dongjun','2021-01-08',NULL,'20:18:43');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-09 21:45:52
