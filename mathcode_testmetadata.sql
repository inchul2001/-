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
-- Table structure for table `testmetadata`
--

DROP TABLE IF EXISTS `testmetadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testmetadata` (
  `testID` char(100) NOT NULL,
  `baejumString` char(100) DEFAULT NULL,
  `answerString` char(100) DEFAULT NULL,
  `descript` char(100) DEFAULT NULL,
  `testRange` char(100) DEFAULT NULL,
  `uploadedfileName` char(100) DEFAULT NULL,
  `originalfileName` char(100) DEFAULT NULL,
  `totalScore` float DEFAULT NULL,
  `testDate` date DEFAULT NULL,
  PRIMARY KEY (`testID`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testmetadata`
--

LOCK TABLES `testmetadata` WRITE;
/*!40000 ALTER TABLE `testmetadata` DISABLE KEYS */;
INSERT INTO `testmetadata` VALUES ('20년6월고1서울시모평','2#3#3#2#4#3#3#4#3#3#4#3#4#3#3#4#3#4#4#4#4#2#3#3#3#3#4#4#4#4#','1#2#2#3#5#4#2#2#4#4#3#5#1#1#3#4#2#5#2#3#1#','없음','이차부등식까지','GL_32403526_20201006155126.pdf','GL_32403526_20201006155126.pdf',100,'2020-12-15'),('고1단원평가','10#10#10#15#10#','3#4#2#5#','쉬운시험','이차부등식까지','화면 캡처 2020-10-01 191037.png','화면 캡처 2020-10-01 191037.png',55,'2020-12-26'),('고3이과단원평가','10#10#10#10#15#10#10#25#','2#5#3#1#4#','마지막문제빼고는조금쉬운시험','도함수의활용','주석 2020-09-07 183535.png','주석 2020-09-07 183535.png',100,'2020-12-24');
/*!40000 ALTER TABLE `testmetadata` ENABLE KEYS */;
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
