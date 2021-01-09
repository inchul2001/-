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
-- Table structure for table `indivscore`
--

DROP TABLE IF EXISTS `indivscore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indivscore` (
  `indivScoreNum` int NOT NULL AUTO_INCREMENT,
  `studentId` char(20) DEFAULT NULL,
  `testId` char(20) DEFAULT NULL,
  `indivAnswerString` char(100) DEFAULT NULL,
  `score` float DEFAULT NULL,
  `studentAge` int DEFAULT NULL,
  `comment` char(100) DEFAULT NULL,
  PRIMARY KEY (`indivScoreNum`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indivscore`
--

LOCK TABLES `indivscore` WRITE;
/*!40000 ALTER TABLE `indivscore` DISABLE KEYS */;
INSERT INTO `indivscore` VALUES (1,'mathmaster','고3이과단원평가','2#5#3#1#4#1#1#1#',100,19,''),(2,'dongjun','고3이과단원평가','2#4#3#1#4#1#1#0#',65,19,''),(3,'dongjun','고3이과단원평가','2#5#3#1#4#0#1#1#',90,19,'1차재시험'),(4,'minjae','고3이과단원평가','2#5#3#1#3#1#1#1#',85,19,''),(5,'minjae','고3이과단원평가','2#5#3#1#4#1#1#1#',100,19,'1차재시험'),(6,'psg2002','고3이과단원평가','3#5#3#4#4#1#0#1#',70,19,'저번에 조퇴해서 혼자서 늦게봄'),(7,'psg2002','고3이과단원평가','2#5#5#1#4#1#1#1#',90,19,'1차재시험'),(8,'studyYJ','고3이과단원평가','2#5#3#1#3#1#1#1#',85,18,'고3대상시험인데 고2가 봤음'),(9,'minjae','20년6월고1서울시모평','1#2#2#3#5#4#2#2#4#4#3#5#1#1#3#4#2#5#2#3#1#1#1#1#1#1#1#1#1#1#',100,19,'');
/*!40000 ALTER TABLE `indivscore` ENABLE KEYS */;
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
