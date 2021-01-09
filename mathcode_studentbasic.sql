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
-- Table structure for table `studentbasic`
--

DROP TABLE IF EXISTS `studentbasic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentbasic` (
  `studentId` char(20) NOT NULL,
  `studentPassword` char(20) DEFAULT NULL,
  `studentName` char(20) DEFAULT NULL,
  `studentAge` int DEFAULT NULL,
  `studentSchool` char(20) DEFAULT NULL,
  `studentPhone` char(20) DEFAULT NULL,
  `studentMotherPhone` char(20) DEFAULT NULL,
  PRIMARY KEY (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentbasic`
--

LOCK TABLES `studentbasic` WRITE;
/*!40000 ALTER TABLE `studentbasic` DISABLE KEYS */;
INSERT INTO `studentbasic` VALUES ('dongjun','1234','김동준',19,'성남서고','번호9','부모님번호3'),('kdw5334','1234','김동운',18,'성남서고','번호4','부모님번호3'),('mathmaster','1234','김수학',19,'성남서고','번호6','부모님번호5'),('minjae','1234','최민재',19,'풍생고','번호1','부모님번호1'),('psg2002','1234','박승준',19,'풍생고','번호2','부모님번호2'),('studyYJ','1234','신영준',18,'성남서고','번호5','부모님번호4');
/*!40000 ALTER TABLE `studentbasic` ENABLE KEYS */;
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
