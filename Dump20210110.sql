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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (3,'mathmaster','2021-01-03','05:14:14',NULL),(4,'mathmaster','2021-01-03','05:25:55',NULL),(6,'mathmaster','2021-01-03',NULL,'05:26:11'),(7,'studyYJ','2021-01-03','05:27:13',NULL),(8,'studyYJ','2021-01-03',NULL,'05:27:13'),(9,'studyYJ','2021-01-03','05:27:16',NULL),(10,'studyYJ','2021-01-03',NULL,'05:27:17'),(11,'psg2002','2021-01-03','05:27:28',NULL),(12,'psg2002','2021-01-03',NULL,'05:27:29'),(13,'mathmaster','2021-01-03',NULL,'05:27:30'),(14,'mathmaster','2021-01-03','05:27:31',NULL),(18,'mathmaster','2021-01-03',NULL,'05:27:41'),(21,'studyYJ','2021-01-07','10:00:00',NULL),(22,'studyYJ','2021-01-07',NULL,'11:32:31'),(23,'studyYJ','2021-01-07','11:45:17',NULL),(24,'studyYJ','2021-01-07',NULL,'11:45:19'),(25,'studyYJ','2021-01-09','18:00:00',NULL),(26,'studyYJ','2021-01-09',NULL,'20:07:01'),(27,'dongjun','2020-12-20','12:12:37',NULL),(28,'dongjun','2020-12-20',NULL,'16:03:43'),(29,'dongjun','2020-12-21','14:02:37',NULL),(30,'dongjun','2020-12-21',NULL,'21:11:03'),(31,'dongjun','2020-12-23','19:02:14',NULL),(32,'dongjun','2020-12-23',NULL,'20:58:14'),(33,'dongjun','2020-12-25','19:13:40',NULL),(34,'dongjun','2020-12-25',NULL,'21:15:32'),(35,'dongjun','2020-12-27','11:58:03',NULL),(36,'dongjun','2020-12-27',NULL,'15:48:43'),(37,'dongjun','2020-12-30','19:00:37',NULL),(38,'dongjun','2020-12-30',NULL,'20:58:30'),(39,'dongjun','2021-01-01','19:12:37',NULL),(40,'dongjun','2021-01-01',NULL,'21:03:15'),(41,'dongjun','2021-01-03','11:47:37',NULL),(42,'dongjun','2021-01-03',NULL,'15:55:12'),(43,'dongjun','2021-01-04','14:03:03',NULL),(44,'dongjun','2021-01-04',NULL,'20:58:13'),(45,'dongjun','2021-01-06','19:03:07',NULL),(46,'dongjun','2021-01-06',NULL,'21:02:14'),(47,'dongjun','2021-01-08','18:55:15',NULL),(48,'dongjun','2021-01-08',NULL,'20:18:43'),(49,'kdw5334','2021-01-10','05:34:07',NULL),(50,'kdw5334','2021-01-10',NULL,'05:34:18');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `classroom` char(20) NOT NULL,
  PRIMARY KEY (`classroom`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES ('301호'),('302호'),('303호'),('401호'),('402호'),('777호');
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indivscore`
--

LOCK TABLES `indivscore` WRITE;
/*!40000 ALTER TABLE `indivscore` DISABLE KEYS */;
INSERT INTO `indivscore` VALUES (1,'mathmaster','고3이과단원평가','2#5#3#1#4#1#1#1#',100,19,''),(2,'dongjun','고3이과단원평가','2#4#3#1#4#1#1#0#',65,19,''),(3,'dongjun','고3이과단원평가','2#5#3#1#4#0#1#1#',90,19,'1차재시험'),(4,'minjae','고3이과단원평가','2#5#3#1#3#1#1#1#',85,19,''),(5,'minjae','고3이과단원평가','2#5#3#1#4#1#1#1#',100,19,'1차재시험'),(6,'psg2002','고3이과단원평가','3#5#3#4#4#1#0#1#',70,19,'저번에 조퇴해서 혼자서 늦게봄'),(7,'psg2002','고3이과단원평가','2#5#5#1#4#1#1#1#',90,19,'1차재시험'),(8,'studyYJ','고3이과단원평가','2#5#3#1#3#1#1#1#',85,18,'고3대상시험인데 고2가 봤음'),(9,'minjae','20년6월고1서울시모평','1#2#2#3#5#4#2#2#4#4#3#5#1#1#3#4#2#5#2#3#1#1#1#1#1#1#1#1#1#1#',100,19,''),(10,'psg2002','새로운시험2','1#2#2#4#5#1#4#5#5#4#0#1#1#',87,19,''),(11,'psg2002','새로운시험2','1#2#2#4#5#1#4#5#3#4#1#1#1#',100,19,'1차재시험');
/*!40000 ALTER TABLE `indivscore` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `sugang`
--

DROP TABLE IF EXISTS `sugang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sugang` (
  `sugangNum` int NOT NULL AUTO_INCREMENT,
  `studentId` char(20) DEFAULT NULL,
  `lectureNum` int DEFAULT NULL,
  PRIMARY KEY (`sugangNum`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sugang`
--

LOCK TABLES `sugang` WRITE;
/*!40000 ALTER TABLE `sugang` DISABLE KEYS */;
INSERT INTO `sugang` VALUES (1,'dongjun',6),(2,'dongjun',7),(3,'dongjun',8),(4,'dongjun',9),(5,'dongjun',16),(6,'dongjun',17),(7,'dongjun',22),(8,'dongjun',25),(9,'dongjun',26),(10,'dongjun',29),(11,'dongjun',30);
/*!40000 ALTER TABLE `sugang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `teacherId` char(20) NOT NULL,
  `uploadedPictureName` char(50) DEFAULT NULL,
  `originalPictureName` char(50) DEFAULT NULL,
  `yakRyeok` char(50) DEFAULT NULL,
  `hanMaDi` char(100) DEFAULT NULL,
  PRIMARY KEY (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES ('굳건이선생님','다운로드1.jpg','다운로드.jpg','한밭대학교','너희들도 갈 수 있다! 한밭 대학교!'),('김선생님','images (1).jpg','images (1).jpg','.','중등부의 수학실력, 내가 지킨다..'),('박인철','화면 캡처 2020-10-06 1429146.png','화면 캡처 2020-10-06 142914.png','짱짱','으하하 열심히 수-학 공부하십쇼'),('토끼선생님','다운로드 (1).jpg','다운로드 (1).jpg','사육장 졸업','모두들 화이팅!');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `testmetadata` VALUES ('20년6월고1서울시모평','2#3#3#2#4#3#3#4#3#3#4#3#4#3#3#4#3#4#4#4#4#2#3#3#3#3#4#4#4#4#','1#2#2#3#5#4#2#2#4#4#3#5#1#1#3#4#2#5#2#3#1#','없음','이차부등식까지','GL_32403526_20201006155126.pdf','GL_32403526_20201006155126.pdf',100,'2020-12-15'),('고1단원평가','10#10#10#15#10#','3#4#2#5#','쉬운시험','이차부등식까지','화면 캡처 2020-10-01 191037.png','화면 캡처 2020-10-01 191037.png',55,'2020-12-26'),('고3이과단원평가','10#10#10#10#15#10#10#25#','2#5#3#1#4#','마지막문제빼고는조금쉬운시험','도함수의활용','주석 2020-09-07 183535.png','주석 2020-09-07 183535.png',100,'2020-12-24'),('새로운시험2','8#8#8#8#9#10#10#6#6#10#7#6#4#','1#2#2#4#5#1#4#5#3#4#','없음','전범위','화면 캡처 2020-11-09 1335431.png','화면 캡처 2020-11-09 133543.png',100,'2021-01-19');
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

-- Dump completed on 2021-01-10 21:20:15
