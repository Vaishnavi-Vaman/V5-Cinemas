-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: v5_cinemas
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `movie_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `language` varchar(50) NOT NULL,
  `duration` int DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `poster_url` varchar(500) DEFAULT NULL,
  `trailer_url` varchar(500) DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (5,'v','tamil',2,'action','2025-08-10','poster/v.jpeg','ex.com',NULL),(6,'Su From So','Kannada',3,'Comedy','2025-08-23','poster/SufromSo.jpeg','ex.com',NULL),(7,'Param Sundari ','Hindi',120,'Romantic/Drama','2025-08-11','poster/ParamSundari.jpg','ex.com',NULL),(8,'Vash Level-2','Hindi',120,'Horror/Suspense','2025-08-11','poster/Vashlevel2.jpg','ex.com',NULL),(9,'Mahavatar Narsimha','Telugu/Hindi/Tamil/Kannada',120,'Animation','2025-08-20','poster/MN.jpg','ex.com',NULL),(10,'WAR-2','Hindi',120,'Action/Drama','2025-08-14','poster/WAR.webp','ex.com',NULL),(11,'Coolie','Tamil/Hindi/Kannada',120,'Action/Drama','2025-08-14','poster/coolie.jpeg','ex.com',NULL),(12,'The Roses','English',120,'Comedy/Drama','2025-08-28','poster/Rose.jpg','ex.com',NULL),(13,'Hridayapoorvam','Malyalam',120,'Comedy/Drama','2025-08-28','poster/Hridaya.jpeg','ex.com',NULL),(14,'Weapon','English',120,'Horror/Suspense','2025-08-28','poster/Weapon.webp','ex.com',NULL),(15,'LOKAH','Malyalam',120,'Suspense/Thriller','2025-08-28','poster/Lokah.jpg','ex.com',NULL),(16,'F1 The Movie','English',120,'Adventure/Drama','2025-08-28','poster/F1.jpg','ex.com',NULL),(17,'HATSUNE MIKU: COLORFUL STAGE!','English',120,'Animation','2025-08-28','poster/CS.jpg','ex.com',NULL),(18,'Dhadak-2','Hindi',120,'Romantic/Drama','2025-08-26','poster/D2.jpg','ex.com',NULL),(19,'SuperMan','English/Tamil/Hindi/Kannada',120,'Sci-Fi','2025-08-03','poster/superman.jpg','ex.com',NULL),(20,'Jurassic World Rebirth 2025 ','English/Hindi',133,'Sci-Fi/Action','2025-08-03','poster/JVB.jpg','ex.com',NULL),(21,'The Fantastic Four: First Steps ','English/Hindi',133,'Sci-Fi/Action','2025-08-03','poster/F4.jpg','ex.com',NULL),(22,'Mission: Impossible – The Final Reckoning CBFC: U/A','English/Hindi',169,'Adventure/Drama/Thriller','2025-08-03','poster/MI.jpg','ex.com',NULL),(23,'The Bad Guys 2','English/Hindi',169,'Animation','2025-08-03','poster/TBG.jpg','ex.com',NULL);
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-01 14:42:53
