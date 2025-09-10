-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: jdbctest
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `lugares_seguros`
--

DROP TABLE IF EXISTS `lugares_seguros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lugares_seguros` (
  `idMiLugarSeguro` int NOT NULL,
  `tecnicasDeRelajacion_idTecnicaRelajacion` int NOT NULL,
  `imagenesFondo_idImgFondo` int NOT NULL,
  `Usuario_idUsuario` int NOT NULL,
  PRIMARY KEY (`idMiLugarSeguro`),
  KEY `fk_miLugarSeguro_tecnicasDeRelajacion1_idx` (`tecnicasDeRelajacion_idTecnicaRelajacion`),
  KEY `fk_miLugarSeguro_imagenesFondo1_idx` (`imagenesFondo_idImgFondo`),
  KEY `fk_miLugarSeguro_Usuario1_idx` (`Usuario_idUsuario`),
  CONSTRAINT `fk_miLugarSeguro_imagenesFondo1` FOREIGN KEY (`imagenesFondo_idImgFondo`) REFERENCES `imagenes_fondo` (`idImgFondo`),
  CONSTRAINT `fk_miLugarSeguro_tecnicasDeRelajacion1` FOREIGN KEY (`tecnicasDeRelajacion_idTecnicaRelajacion`) REFERENCES `tecnicas_relajacion` (`idTecnicaRelajacion`),
  CONSTRAINT `fk_miLugarSeguro_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lugares_seguros`
--

LOCK TABLES `lugares_seguros` WRITE;
/*!40000 ALTER TABLE `lugares_seguros` DISABLE KEYS */;
/*!40000 ALTER TABLE `lugares_seguros` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-09 21:10:58
