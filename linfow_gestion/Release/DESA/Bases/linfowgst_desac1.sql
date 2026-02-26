-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: linfowgst_desac1
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `linfowgst_desac1`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `linfowgst_desac1` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;

USE `linfowgst_desac1`;

--
-- Table structure for table `accesos`
--

DROP TABLE IF EXISTS `accesos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accesos` (
  `idAcceso` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `idMenue` int(11) NOT NULL,
  PRIMARY KEY (`idAcceso`),
  KEY `fk_Accesos_Usuarios` (`idUsuario`),
  KEY `fk_Accesos_Menues1` (`idMenue`),
  CONSTRAINT `fk_Accesos_Menues1` FOREIGN KEY (`idMenue`) REFERENCES `menues` (`idMenue`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accesos_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accesos`
--

LOCK TABLES `accesos` WRITE;
/*!40000 ALTER TABLE `accesos` DISABLE KEYS */;
INSERT INTO `accesos` VALUES
(1,1,1),
(2,1,2),
(3,1,11),
(4,1,12),
(5,1,13),
(6,1,14),
(7,1,15),
(8,1,16),
(9,1,17),
(10,1,18),
(11,1,19),
(12,1,20),
(13,1,3),
(14,1,95),
(15,1,21),
(16,1,22),
(17,1,23),
(18,1,112),
(19,1,113),
(20,1,114),
(21,1,4),
(22,1,5),
(23,1,6),
(24,1,7),
(25,1,8),
(26,1,9),
(27,1,10),
(28,1,126),
(29,1,127),
(30,1,128),
(31,1,129),
(32,1,130),
(33,1,131),
(34,1,132),
(35,1,158),
(36,1,159),
(37,1,73),
(38,1,74),
(39,1,82),
(40,1,83),
(41,1,120),
(42,1,75),
(43,1,76),
(44,1,91),
(45,1,94),
(46,1,80),
(47,1,81),
(48,1,116),
(49,1,117),
(50,1,140),
(51,1,141),
(52,1,148),
(53,1,149),
(54,1,151),
(55,1,152),
(56,1,153),
(57,1,157),
(58,1,154),
(59,1,155),
(60,1,156),
(61,1,24),
(62,1,25),
(63,1,85),
(64,1,110),
(65,1,106),
(66,1,107),
(67,1,111),
(68,1,134),
(69,1,137),
(70,1,143),
(71,1,144),
(72,1,162),
(73,1,26),
(74,1,27),
(75,1,28),
(76,1,29),
(77,1,30),
(78,1,92),
(79,1,78),
(80,1,79),
(81,1,31),
(82,1,32),
(83,1,33),
(84,1,34),
(85,1,35),
(86,1,36),
(87,1,84),
(88,1,37),
(89,1,39),
(90,1,48),
(91,1,104),
(92,1,105),
(93,1,108),
(94,1,109),
(95,1,118),
(96,1,119),
(97,1,138),
(98,1,139),
(99,1,142),
(100,1,41),
(102,1,146),
(103,1,115),
(104,1,93),
(105,1,42),
(106,1,43),
(107,1,44),
(108,1,46),
(109,1,47),
(110,1,49),
(111,1,50),
(112,1,57),
(113,1,58),
(114,1,136),
(115,1,160),
(116,1,161),
(117,1,51),
(118,1,133),
(119,1,52),
(120,1,53),
(121,1,86),
(122,1,54),
(123,1,55),
(124,1,56),
(125,1,59),
(126,1,60),
(127,1,61),
(128,1,62),
(129,1,63),
(130,1,64),
(131,1,65),
(132,1,66),
(133,1,87),
(134,1,88),
(135,1,89),
(136,1,147),
(137,1,70),
(138,1,71),
(139,1,72),
(140,1,96),
(141,1,97),
(142,1,123),
(143,1,124),
(144,1,125),
(145,1,98),
(146,1,99),
(147,1,100),
(148,1,101),
(149,1,102),
(150,1,103),
(151,1,121),
(152,1,122),
(153,1,163),
(154,1,164);
/*!40000 ALTER TABLE `accesos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accesos_tm`
--

DROP TABLE IF EXISTS `accesos_tm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accesos_tm` (
  `idAccesoTM` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `idTipomov` int(11) NOT NULL,
  PRIMARY KEY (`idAccesoTM`),
  UNIQUE KEY `idAccesoTM` (`idAccesoTM`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idTipomov` (`idTipomov`),
  CONSTRAINT `accesos_tm_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `accesos_tm_ibfk_2` FOREIGN KEY (`idTipomov`) REFERENCES `stk_tipomov` (`idTipomov`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accesos_tm`
--

LOCK TABLES `accesos_tm` WRITE;
/*!40000 ALTER TABLE `accesos_tm` DISABLE KEYS */;
INSERT INTO `accesos_tm` VALUES
(1,1,1),
(2,1,2),
(3,1,3),
(4,1,4);
/*!40000 ALTER TABLE `accesos_tm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alic_ivas`
--

DROP TABLE IF EXISTS `alic_ivas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alic_ivas` (
  `id_aliciva` int(11) NOT NULL AUTO_INCREMENT,
  `alicuota` decimal(5,2) NOT NULL,
  `id_afip` int(11) NOT NULL,
  PRIMARY KEY (`id_aliciva`),
  UNIQUE KEY `id_aliciva` (`id_aliciva`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alic_ivas`
--

LOCK TABLES `alic_ivas` WRITE;
/*!40000 ALTER TABLE `alic_ivas` DISABLE KEYS */;
INSERT INTO `alic_ivas` VALUES
(1,21.00,5),
(2,10.50,4),
(3,0.00,3);
/*!40000 ALTER TABLE `alic_ivas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art_cbios`
--

DROP TABLE IF EXISTS `art_cbios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art_cbios` (
  `idArtCbios` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `prAnt` float NOT NULL,
  `prNuevo` float NOT NULL,
  `porVar` float NOT NULL,
  PRIMARY KEY (`idArtCbios`),
  KEY `fk_articulos_cambios_idx` (`idArticulo`),
  CONSTRAINT `fk_articulos_cambios` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art_cbios`
--

LOCK TABLES `art_cbios` WRITE;
/*!40000 ALTER TABLE `art_cbios` DISABLE KEYS */;
INSERT INTO `art_cbios` VALUES
(1,3,'2022-10-05 10:34:30',221.92,244.109,9.9987),
(2,4,'2022-10-05 10:34:30',220.86,242.942,9.998),
(3,5,'2022-10-05 10:34:30',474.9,522.386,9.9992),
(4,6,'2022-10-05 10:34:30',552.47,607.719,10.0004),
(5,3,'2022-10-05 10:35:44',244.109,265.33,8.6932),
(6,3,'2023-07-26 20:31:23',265.33,309.56,16.6698),
(7,143,'2024-06-10 21:29:24',180.66,36000,19826.9),
(8,144,'2024-06-10 21:29:24',179.79,43200,23928),
(9,145,'2024-06-10 21:29:24',386.6,7200,1762.39),
(10,146,'2024-06-10 21:29:24',449.75,115200,25514.2),
(11,147,'2024-06-10 21:29:24',180.66,57600,31783.1),
(12,143,'2024-06-10 22:39:56',36000,4320,-88),
(13,144,'2024-06-10 22:39:56',43200,7200,-83.3333),
(14,143,'2024-06-10 22:39:56',4320,36000,733.333),
(15,144,'2024-06-10 22:39:56',7200,43200,500),
(16,143,'2024-06-10 22:40:57',36000,4320,-88),
(17,143,'2024-06-10 22:42:01',4320,4860,12.5),
(18,144,'2024-06-10 22:42:01',43200,48600,12.5),
(19,145,'2024-06-10 22:42:01',7200,8100,12.5),
(20,146,'2024-06-10 22:42:01',115200,129600,12.5),
(21,147,'2024-06-10 22:42:01',57600,64800,12.5),
(22,143,'2024-06-10 22:44:05',4860,5400,11.1111),
(23,144,'2024-06-10 22:44:05',48600,54000,11.1111),
(24,145,'2024-06-10 22:44:05',8100,9000,11.1111),
(25,146,'2024-06-10 22:44:05',129600,144000,11.1111),
(26,147,'2024-06-10 22:44:05',64800,72000,11.1111),
(27,3,'2024-06-27 14:23:25',309.56,8844.5,2757.12),
(28,4,'2024-06-27 14:23:25',242.942,13266.8,5360.87),
(29,5,'2024-06-27 14:23:25',522.386,26533.5,4979.29),
(30,6,'2024-06-27 14:23:25',607.719,176890,29007.2),
(31,7,'2024-06-27 14:23:25',221.92,44222.5,19827.2),
(32,8,'2024-06-27 14:23:25',220.86,26533.5,11913.7),
(33,9,'2024-06-27 14:23:25',229.25,17689,7616.03),
(34,10,'2024-06-27 14:23:25',227.27,39800.2,17412.3),
(35,11,'2024-06-27 14:23:25',6.37,10613.4,166515),
(36,12,'2024-06-27 14:23:25',6.72,132668,1974120);
/*!40000 ALTER TABLE `art_cbios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art_dep`
--

DROP TABLE IF EXISTS `art_dep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art_dep` (
  `idArticulo` int(11) NOT NULL,
  `idStkDep` int(11) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idArticulo`,`idStkDep`),
  KEY `idStkDep` (`idStkDep`),
  CONSTRAINT `art_dep_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`),
  CONSTRAINT `art_dep_ibfk_2` FOREIGN KEY (`idStkDep`) REFERENCES `stk_deps` (`idStkDep`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art_dep`
--

LOCK TABLES `art_dep` WRITE;
/*!40000 ALTER TABLE `art_dep` DISABLE KEYS */;
INSERT INTO `art_dep` VALUES
(1,1,'SUPER','2022-03-30 17:47:13','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,1,'SUPER','2022-03-30 17:47:44','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(143,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(144,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(145,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(146,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(147,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(148,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(149,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(150,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(151,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(152,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(153,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(154,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(155,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(156,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(157,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(158,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(159,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(160,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(161,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(162,1,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(213,1,'SUPER','2023-02-09 18:56:25','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `art_dep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art_dtos`
--

DROP TABLE IF EXISTS `art_dtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art_dtos` (
  `idArtDto` int(11) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `porDto1` float NOT NULL,
  `porDto2` float NOT NULL,
  `porDto3` float NOT NULL,
  `porDto4` float NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idArtDto`),
  UNIQUE KEY `idArtDto` (`idArtDto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art_dtos`
--

LOCK TABLES `art_dtos` WRITE;
/*!40000 ALTER TABLE `art_dtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `art_dtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art_equiv`
--

DROP TABLE IF EXISTS `art_equiv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art_equiv` (
  `idArtEqui` int(11) NOT NULL,
  `idArtic_A` int(11) NOT NULL,
  `idArtic_B` int(11) NOT NULL,
  `codArt_A` varchar(20) NOT NULL,
  `codArt_B` varchar(20) NOT NULL,
  PRIMARY KEY (`idArtEqui`),
  UNIQUE KEY `idArtEqui` (`idArtEqui`),
  KEY `idArtic_A` (`idArtic_A`),
  KEY `idArtic_B` (`idArtic_B`),
  KEY `codArt_A` (`codArt_A`),
  KEY `codArt_B` (`codArt_B`),
  CONSTRAINT `art_equiv_ibfk_1` FOREIGN KEY (`idArtic_A`) REFERENCES `articulos` (`idArticulo`),
  CONSTRAINT `art_equiv_ibfk_2` FOREIGN KEY (`idArtic_B`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art_equiv`
--

LOCK TABLES `art_equiv` WRITE;
/*!40000 ALTER TABLE `art_equiv` DISABLE KEYS */;
/*!40000 ALTER TABLE `art_equiv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art_exivapto`
--

DROP TABLE IF EXISTS `art_exivapto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art_exivapto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idArticulo` int(11) NOT NULL,
  `habilitado` bit(1) NOT NULL DEFAULT b'1',
  `usualta` varchar(5) NOT NULL,
  `fecalta` datetime NOT NULL,
  `idhostalta` varchar(50) NOT NULL,
  `usumodi` varchar(5) DEFAULT NULL,
  `fecmodi` datetime DEFAULT NULL,
  `idhostmodi` varchar(50) DEFAULT NULL,
  `usubaja` varchar(5) DEFAULT NULL,
  `fecbaja` datetime DEFAULT NULL,
  `idhostbaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `idArticulo` (`idArticulo`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art_exivapto`
--

LOCK TABLES `art_exivapto` WRITE;
/*!40000 ALTER TABLE `art_exivapto` DISABLE KEYS */;
INSERT INTO `art_exivapto` VALUES
(1,143,'','SUPER','2022-10-11 10:57:57','ESCRITORIO # Leonardo','SUPER','2022-10-11 13:00:33','ESCRITORIO # Leonardo','SUPER','2023-02-09 00:00:00','LEO_NOTEBOOK # LINFOW'),
(2,144,'','SUPER','2022-10-11 10:58:06','ESCRITORIO # Leonardo',NULL,NULL,NULL,'SUPER','2023-02-09 00:00:00','LEO_NOTEBOOK # LINFOW'),
(3,143,'','SUPER','2023-02-09 18:08:15','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,'SUPER','2023-02-09 00:00:00','LEO_NOTEBOOK # LINFOW'),
(4,149,'','SUPER','2023-02-09 21:16:09','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(5,150,'','SUPER','2023-02-09 21:16:21','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(6,151,'','SUPER','2023-02-09 21:16:31','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(7,143,'','SUPER','2023-02-10 11:04:37','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(8,144,'','SUPER','2023-02-10 11:04:42','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(9,145,'','SUPER','2023-02-10 11:04:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `art_exivapto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art_mrv`
--

DROP TABLE IF EXISTS `art_mrv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art_mrv` (
  `idMarcaV` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  PRIMARY KEY (`idMarcaV`,`idArticulo`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `art_mrv_ibfk_1` FOREIGN KEY (`idMarcaV`) REFERENCES `marcas_v` (`idMarcaV`),
  CONSTRAINT `art_mrv_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art_mrv`
--

LOCK TABLES `art_mrv` WRITE;
/*!40000 ALTER TABLE `art_mrv` DISABLE KEYS */;
/*!40000 ALTER TABLE `art_mrv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art_tempo`
--

DROP TABLE IF EXISTS `art_tempo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art_tempo` (
  `idArtTempo` int(11) NOT NULL AUTO_INCREMENT,
  `idprov` int(11) NOT NULL,
  `idFamilia` int(11) NOT NULL,
  `idSubFam` int(11) NOT NULL,
  `idMarca` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `codArtPV` varchar(40) DEFAULT NULL,
  `descripcio` varchar(200) DEFAULT NULL,
  `alicIVA` double NOT NULL,
  `prListaPV` double NOT NULL,
  `bonif1` double NOT NULL,
  `bonif2` double NOT NULL,
  `bonif3` double NOT NULL,
  `bonif4` double NOT NULL,
  `costoRep` double NOT NULL,
  `margenMay` double NOT NULL,
  `margenMin` double NOT NULL,
  `prVentaMay` double NOT NULL,
  `prVentaMin` double NOT NULL,
  `procesado` bit(1) NOT NULL DEFAULT b'0',
  `cou` char(32) DEFAULT NULL,
  UNIQUE KEY `idArtTempo` (`idArtTempo`),
  KEY `idx_art_tempo_cou` (`cou`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art_tempo`
--

LOCK TABLES `art_tempo` WRITE;
/*!40000 ALTER TABLE `art_tempo` DISABLE KEYS */;
/*!40000 ALTER TABLE `art_tempo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art_unid`
--

DROP TABLE IF EXISTS `art_unid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art_unid` (
  `idArtUnid` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `cantUD` float NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idArtUnid`),
  UNIQUE KEY `idArtUnid` (`idArtUnid`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `art_unid_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art_unid`
--

LOCK TABLES `art_unid` WRITE;
/*!40000 ALTER TABLE `art_unid` DISABLE KEYS */;
/*!40000 ALTER TABLE `art_unid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art_upd_tempo`
--

DROP TABLE IF EXISTS `art_upd_tempo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art_upd_tempo` (
  `idArticulo` int(11) DEFAULT NULL,
  `idProv` int(11) NOT NULL,
  `stock` varchar(10) DEFAULT NULL,
  `codigo` varchar(40) DEFAULT NULL,
  `codArt` varchar(20) DEFAULT NULL,
  `articulo` varchar(200) DEFAULT NULL,
  `linea` varchar(60) DEFAULT NULL,
  `rubro` varchar(60) DEFAULT NULL,
  `venta` double DEFAULT NULL,
  `lista` double DEFAULT NULL,
  `bonif1` double DEFAULT NULL,
  `bonif2` double DEFAULT NULL,
  `bonif3` double DEFAULT NULL,
  `bonif4` double DEFAULT NULL,
  `margenMax` double DEFAULT NULL,
  `margenMin` double DEFAULT NULL,
  `costo` double DEFAULT NULL,
  `esNuevo` bit(1) DEFAULT NULL,
  `cou` char(32) DEFAULT NULL,
  KEY `idx_artupdtempo_idArticulo` (`idArticulo`),
  KEY `idx_artupdtempo_idProv` (`idProv`),
  KEY `idx_artupdtempo_codigo` (`codigo`),
  KEY `idx_artupdtempo_codArt` (`codArt`),
  KEY `idx_art_upd_tempo_cou` (`cou`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art_upd_tempo`
--

LOCK TABLES `art_upd_tempo` WRITE;
/*!40000 ALTER TABLE `art_upd_tempo` DISABLE KEYS */;
/*!40000 ALTER TABLE `art_upd_tempo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articulos`
--

DROP TABLE IF EXISTS `articulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulos` (
  `idArticulo` int(11) NOT NULL,
  `idProv` int(11) NOT NULL,
  `idFamilia` int(11) NOT NULL,
  `idSubFam` int(11) NOT NULL,
  `idmarca` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `descripcio` varchar(200) NOT NULL,
  `alicIVA` float NOT NULL,
  `tmon` varchar(3) NOT NULL DEFAULT 'PSO',
  `usarMonExt` bit(1) NOT NULL DEFAULT b'0',
  `prListaExt` float DEFAULT NULL,
  `cotizac` float DEFAULT NULL,
  `prLista` float NOT NULL,
  `bonif1` float NOT NULL,
  `bonif2` float NOT NULL,
  `bonif3` float NOT NULL,
  `bonif4` float NOT NULL,
  `costoRep` float NOT NULL,
  `margenMax` float NOT NULL,
  `margenMin` float NOT NULL,
  `prventaMax` float NOT NULL,
  `prventaMin` float NOT NULL,
  `prfinalMax` float NOT NULL,
  `prfinalMin` float NOT NULL,
  `usarImpuIn` bit(1) NOT NULL DEFAULT b'0',
  `porImpuIn` decimal(5,2) DEFAULT 0.00,
  `impImInMay` decimal(20,2) DEFAULT 0.00,
  `impImInMin` decimal(20,2) DEFAULT 0.00,
  `observ` text DEFAULT NULL,
  `habilitado` bit(1) NOT NULL,
  `linkfoto` varchar(100) DEFAULT NULL,
  `usualta` varchar(5) DEFAULT NULL,
  `fecalta` datetime DEFAULT NULL,
  `idhostalta` varchar(50) DEFAULT NULL,
  `usumodi` varchar(5) DEFAULT NULL,
  `fecmodi` datetime DEFAULT NULL,
  `idhostmodi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `esServ` bit(1) NOT NULL DEFAULT b'0',
  `idUniMed` int(11) DEFAULT NULL,
  `codArtPV` varchar(45) DEFAULT NULL,
  `mostrador` bit(1) NOT NULL DEFAULT b'0',
  `fecActuPre` datetime DEFAULT NULL,
  `equiv` int(11) NOT NULL DEFAULT 0,
  `promocion` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Indica si es merchandising o no',
  `cou` char(32) DEFAULT NULL,
  `llevastk` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`idArticulo`),
  KEY `fk_Articulos_Proveedores1` (`idProv`),
  KEY `fk_Articulos_Familias1` (`idFamilia`),
  KEY `fk_Articulos_SubFamilias1` (`idSubFam`),
  KEY `fk_Articulos_Marcas` (`idmarca`),
  KEY `fk_art_unimed` (`idUniMed`),
  KEY `idx_codArt` (`codArt`),
  KEY `codArtPV` (`codArtPV`),
  KEY `idx_articulos_cou` (`cou`),
  CONSTRAINT `fk_Articulos_Familias1` FOREIGN KEY (`idFamilia`) REFERENCES `familias` (`idFamilia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulos_Marcas` FOREIGN KEY (`idmarca`) REFERENCES `marcas` (`idmarca`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulos_Proveedores1` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulos_SubFamilias1` FOREIGN KEY (`idSubFam`) REFERENCES `subfam` (`idSubFam`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_art_unimed` FOREIGN KEY (`idUniMed`) REFERENCES `unidmed` (`idUniMed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulos`
--

LOCK TABLES `articulos` WRITE;
/*!40000 ALTER TABLE `articulos` DISABLE KEYS */;
INSERT INTO `articulos` VALUES
(1,1,1,1,1,'1ARX','ARTICULO VARIO (IVA 21 %)',21,'PSO','\0',0,0,0.01,0,0,0,0,0.01,0,0,0.01,0.01,0.01,0.01,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 17:47:13','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'1ARX','\0',NULL,1,'\0','54e47bb9ad074e2d5082c51e0b0f574f','\0'),
(2,1,1,1,1,'2ARX','ARTICULO VARIO (IVA 10,5%)',10.5,'PSO','\0',0,0,0.01,0,0,0,0,0.01,0,0,0.01,0.01,0.01,0.01,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 17:47:44','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'2ARX','\0',NULL,2,'\0','fbcab55efacad422c0e4bcd3b9637fa2','\0'),
(3,2,2,2,2,'PROD071','PRODUCTO PRUEBA PROD071',21,'PSO','\0',0,0,10000,5,5,2,0,8844.5,0,0,8844.5,8844.5,10701.8,10701.8,'\0',0.00,0.00,0.00,'','\0','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00001','\0','2024-06-27 14:23:25',3,'\0','850167759ee3df626af01ee92958b2d0',''),
(4,2,2,2,2,'PROD072','PRODUCTO PRUEBA PROD072',21,'PSO','\0',0,0,15000,5,5,2,0,13266.8,0,0,13266.8,13266.8,16052.8,16052.8,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00002','\0','2024-06-27 14:23:25',4,'\0','365cf3372e6d25a33a5545e4f567af57',''),
(5,2,2,2,2,'PROD073','PRODUCTO PRUEBA PROD073',21,'PSO','\0',0,0,30000,5,5,2,0,26533.5,0,0,26533.5,26533.5,32105.5,32105.5,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00003','\0','2024-06-27 14:23:25',5,'\0','ba4f4ea60cc3fa798bfcba3af0f0f496',''),
(6,2,2,2,2,'PROD074','PRODUCTO PRUEBA PROD074',21,'PSO','\0',0,0,200000,5,5,2,0,176890,0,0,176890,176890,214037,214037,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00004','\0','2024-06-27 14:23:25',6,'\0','0ca4ec31ec3bc2006e54a95f292e6324',''),
(7,2,2,3,2,'PROD075','PRODUCTO PRUEBA PROD075',21,'PSO','\0',0,0,50000,5,5,2,0,44222.5,0,50,44222.5,66333.8,53509.2,80263.8,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00005','\0','2024-06-27 14:23:25',7,'\0','12be03fbf0a24d63a2f1a21f5754e95c',''),
(8,2,2,3,2,'PROD076','PRODUCTO PRUEBA PROD076',21,'PSO','\0',0,0,30000,5,5,2,0,26533.5,0,0,26533.5,26533.5,32105.5,32105.5,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00006','\0','2024-06-27 14:23:25',8,'\0','a7ca869fdba4fef03bf8ec64023061d6',''),
(9,2,2,4,2,'PROD077','PRODUCTO PRUEBA PROD077',21,'PSO','\0',0,0,20000,5,5,2,0,17689,0,0,17689,17689,21403.7,21403.7,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00007','\0','2024-06-27 14:23:25',9,'\0','750363d2dc4e63e40f9e988eee116c79',''),
(10,2,2,4,2,'PROD078','PRODUCTO PRUEBA PROD078',21,'PSO','\0',0,0,45000,5,5,2,0,39800.2,0,0,39800.2,39800.2,48158.3,48158.3,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00008','\0','2024-06-27 14:23:25',10,'\0','a22f3aecd4f9ef172e5b1f5a3a2d154f',''),
(11,2,3,5,2,'PROD079','PRODUCTO PRUEBA PROD079',21,'PSO','\0',0,0,12000,5,5,2,0,10613.4,0,0,10613.4,10613.4,12842.2,12842.2,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00009','\0','2024-06-27 14:23:25',11,'\0','63be1cc7b4fe4ee7b2de2bde58938a24',''),
(12,2,3,5,2,'PROD080','PRODUCTO PRUEBA PROD080',21,'PSO','\0',0,0,150000,5,5,2,0,132668,0,0,132668,132668,160528,160528,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-27 14:23:25','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00010','\0','2024-06-27 14:23:25',12,'\0','927e17392cb95588da155638b386a401',''),
(13,2,3,5,2,'PROD081','PRODUCTO PRUEBA PROD081',21,'PSO','\0',0,0,8.6,5,5,2,0,7.61,0,0,7.61,7.61,9.21,9.21,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00011','\0',NULL,13,'\0','df3c9c00f5e0bcde7159ab2d242828eb',''),
(14,2,3,5,2,'PROD082','PRODUCTO PRUEBA PROD082',21,'PSO','\0',0,0,9.6,5,5,2,0,8.49,0,0,8.49,8.49,10.27,10.27,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00012','\0',NULL,14,'\0','ff3526961962fd79dbe3b6c4c1a91f6a',''),
(15,2,3,6,2,'PROD083','PRODUCTO PRUEBA PROD083',21,'PSO','\0',0,0,8.8,5,5,2,0,7.78,0,0,7.78,7.78,9.41,9.41,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00013','\0',NULL,15,'\0','603c7235b53dec5bfa50f73353332bce',''),
(16,2,3,6,2,'PROD084','PRODUCTO PRUEBA PROD084',21,'PSO','\0',0,0,9.8,5,5,2,0,8.67,0,0,8.67,8.67,10.49,10.49,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00014','\0',NULL,16,'\0','967352d1624aff256a930272b16145d3',''),
(17,2,3,7,2,'PROD085','PRODUCTO PRUEBA PROD085',21,'PSO','\0',0,0,32.6,5,5,2,0,28.83,0,0,28.83,28.83,34.88,34.88,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00015','\0',NULL,17,'\0','4503fa44678f883a0091e10ab7ce2b47',''),
(18,2,3,7,2,'PROD086','PRODUCTO PRUEBA PROD086',21,'PSO','\0',0,0,38.6,5,5,2,0,34.14,0,0,34.14,34.14,41.31,41.31,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00016','\0',NULL,18,'\0','d4e59ac9cf7392e4caa3d60f9e932cfe',''),
(19,2,3,7,2,'PROD087','PRODUCTO PRUEBA PROD087',21,'PSO','\0',0,0,24,5,5,2,0,21.23,0,0,21.23,21.23,25.69,25.69,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00017','\0',NULL,19,'\0','0d0c011852b258c4cc0f5589de221c38',''),
(20,2,3,8,2,'PROD088','PRODUCTO PRUEBA PROD088',21,'PSO','\0',0,0,57.2,5,5,2,0,50.59,0,0,50.59,50.59,61.21,61.21,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00018','\0',NULL,20,'\0','7da5c6d4ad79937840df94e5f5a5e02e',''),
(21,2,4,9,2,'PROD089','PRODUCTO PRUEBA PROD089',21,'PSO','\0',0,0,44.9,5,5,2,0,39.71,0,0,39.71,39.71,48.05,48.05,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00019','\0',NULL,21,'\0','254bbe79cf7c17bf76b2c19cafd81699',''),
(22,2,5,10,2,'PROD090','PRODUCTO PRUEBA PROD090',21,'PSO','\0',0,0,7.32,5,5,2,0,6.47,40,60,9.06,10.36,10.97,12.53,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2023-07-26 20:22:48','ESCRITORIO # leonardo',NULL,NULL,NULL,'\0',1,'ACEIN00020','\0',NULL,22,'\0','e2d6cf1ad51cd4c2ca5d2374a268487a',''),
(23,2,5,10,2,'PROD091','PRODUCTO PRUEBA PROD091',21,'PSO','\0',0,0,17.13,5,5,2,0,15.15,0,0,15.15,15.15,18.33,18.33,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2025-12-20 10:55:28','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00021','\0',NULL,23,'\0','652ad56ae7c8729cb83e7a5f6872b961',''),
(24,2,5,10,2,'PROD092','PRODUCTO PRUEBA PROD092',21,'PSO','\0',0,0,19.9,5,5,2,0,17.6,0,0,17.6,17.6,21.3,21.3,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00022','\0',NULL,24,'\0','5bc5aef2f0ac88e135385ba03523446a',''),
(25,2,5,10,2,'PROD093','PRODUCTO PRUEBA PROD093',21,'PSO','\0',0,0,27.95,5,5,2,0,24.72,0,0,24.72,24.72,29.91,29.91,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2025-12-20 10:33:58','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'ACEIN00023','\0',NULL,25,'\0','453beaab555be169809590e6c9d8d557',''),
(26,2,5,10,2,'PROD094','PRODUCTO PRUEBA PROD094',21,'PSO','\0',0,0,27.1,5,5,2,0,23.97,0,0,23.97,23.97,29,29,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00024','\0',NULL,26,'\0','ab4385bb49bd6292be2c3535451c0f3f',''),
(27,2,5,10,2,'PROD095','PRODUCTO PRUEBA PROD095',21,'PSO','\0',0,0,39.3,5,5,2,0,34.76,0,0,34.76,34.76,42.06,42.06,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00025','\0',NULL,27,'\0','25e34b6625945dd5075f4f4122d17919',''),
(28,2,5,10,2,'PROD096','PRODUCTO PRUEBA PROD096',21,'PSO','\0',0,0,43.61,5,5,2,0,38.57,0,0,38.57,38.57,46.67,46.67,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00026','\0',NULL,28,'\0','ba04253d5cc92e17d8539213d96c8923',''),
(29,2,5,10,2,'PROD097','PRODUCTO PRUEBA PROD097',21,'PSO','\0',0,0,60.13,5,5,2,0,53.18,0,0,53.18,53.18,64.35,64.35,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00027','\0',NULL,29,'\0','9425cf63b0d86db7ff0452f1bdde47c1',''),
(30,2,5,10,2,'PROD098','PRODUCTO PRUEBA PROD098',21,'PSO','\0',0,0,108.3,5,5,2,0,95.79,0,0,95.79,95.79,115.91,115.91,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00028','\0',NULL,30,'\0','c377c2d28a59ec371f387a757f9b01b9',''),
(31,2,5,10,2,'PROD099','PRODUCTO PRUEBA PROD099',21,'PSO','\0',0,0,67.43,5,5,2,0,59.64,0,0,59.64,59.64,72.16,72.16,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00029','\0',NULL,31,'\0','e141c35884da3896f2a24e4337afe206',''),
(32,2,5,10,2,'PROD100','PRODUCTO PRUEBA PROD100',21,'PSO','\0',0,0,76.86,5,5,2,0,67.98,0,0,67.98,67.98,82.26,82.26,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00030','\0',NULL,32,'\0','96b7437d2940ccd57f50e5b54485a24c',''),
(33,2,5,10,2,'PROD101','PRODUCTO PRUEBA PROD101',21,'PSO','\0',0,0,149.2,5,5,2,0,131.96,0,0,131.96,131.96,159.67,159.67,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00031','\0',NULL,33,'\0','4ddcf3baefb0f2f9c14d2382a4a9dc54',''),
(34,2,5,10,2,'PROD102','PRODUCTO PRUEBA PROD102',21,'PSO','\0',0,0,176.23,5,5,2,0,155.87,0,0,155.87,155.87,188.6,188.6,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00032','\0',NULL,34,'\0','5bd573505b94004778dab6b7f26b0c34',''),
(35,2,6,11,2,'PROD103','PRODUCTO PRUEBA PROD103',21,'PSO','\0',0,0,152.02,5,5,2,0,134.45,0,0,134.45,134.45,162.68,162.68,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00033','\0',NULL,35,'\0','aa3ea245203a7b4e5aba2d856598c2e9',''),
(36,2,6,11,2,'PROD104','PRODUCTO PRUEBA PROD104',21,'PSO','\0',0,0,181.98,5,5,2,0,160.95,0,0,160.95,160.95,194.75,194.75,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00034','\0',NULL,36,'\0','780ac987affe0f7170062e61e2f952c8',''),
(37,2,6,11,2,'PROD105','PRODUCTO PRUEBA PROD105',21,'PSO','\0',0,0,138.8,5,5,2,0,122.76,0,0,122.76,122.76,148.54,148.54,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00035','\0',NULL,37,'\0','a5cb8b23cf6bed6f7afe0ff3190a9b5f',''),
(38,2,6,12,2,'PROD106','PRODUCTO PRUEBA PROD106',21,'PSO','\0',0,0,154.22,5,5,2,0,136.4,0,0,136.4,136.4,165.04,165.04,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00036','\0',NULL,38,'\0','4f798e2fabd88a02951a811139b03a04',''),
(39,2,6,12,2,'PROD107','PRODUCTO PRUEBA PROD107',21,'PSO','\0',0,0,159.73,5,5,2,0,141.27,0,0,141.27,141.27,170.94,170.94,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00037','\0',NULL,39,'\0','4a12c53629317c5b2a7a2d8ea5af0601',''),
(40,2,6,12,2,'PROD108','PRODUCTO PRUEBA PROD108',21,'PSO','\0',0,0,159.73,5,5,2,0,141.27,0,0,141.27,141.27,170.94,170.94,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00038','\0',NULL,40,'\0','b3856ff20f84e3984d252476fecb8a5a',''),
(41,2,6,12,2,'PROD109','PRODUCTO PRUEBA PROD109',21,'PSO','\0',0,0,200,5,5,2,0,176.89,0,0,176.89,176.89,214.04,214.04,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00039','\0',NULL,41,'\0','2c438f984c80a6f05eddcd155dafacfa',''),
(42,2,6,13,2,'PROD110','PRODUCTO PRUEBA PROD110',21,'PSO','\0',0,0,318.36,5,5,2,0,281.57,0,0,281.57,281.57,340.7,340.7,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00040','\0',NULL,42,'\0','2d62271bf30c3c17401d6a8f7be3edbb',''),
(43,2,6,13,2,'PROD111','PRODUCTO PRUEBA PROD111',21,'PSO','\0',0,0,425,5,5,2,0,375.89,0,0,375.89,375.89,454.83,454.83,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00041','\0',NULL,43,'\0','8e8ca0eab5113b3806db75af778f843c',''),
(44,2,6,13,2,'PROD112','PRODUCTO PRUEBA PROD112',21,'PSO','\0',0,0,221,5,5,2,0,195.46,0,0,195.46,195.46,236.51,236.51,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00042','\0',NULL,44,'\0','a19a18ebe87ed08348d4531a1113a0c6',''),
(45,2,6,13,2,'PROD113','PRODUCTO PRUEBA PROD113',21,'PSO','\0',0,0,223,5,5,2,0,197.23,0,0,197.23,197.23,238.65,238.65,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00043','\0',NULL,45,'\0','275bb6f4614e171ca58ab9a9a8486d95',''),
(46,2,6,14,2,'PROD114','PRODUCTO PRUEBA PROD114',21,'PSO','\0',0,0,200.49,5,5,2,0,177.32,0,0,177.32,177.32,214.56,214.56,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00044','\0',NULL,46,'\0','a5743c43fb0a107f4d5979526b8bed3f',''),
(47,2,6,14,2,'PROD115','PRODUCTO PRUEBA PROD115',21,'PSO','\0',0,0,206.21,5,5,2,0,182.38,0,0,182.38,182.38,220.68,220.68,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00045','\0',NULL,47,'\0','303e28517024921593aa40405c6a3969',''),
(48,2,6,14,2,'PROD116','PRODUCTO PRUEBA PROD116',21,'PSO','\0',0,0,236.84,5,5,2,0,209.47,0,0,209.47,209.47,253.46,253.46,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00046','\0',NULL,48,'\0','480702b5c48d08853522839fd59d4388',''),
(49,2,6,14,2,'PROD117','PRODUCTO PRUEBA PROD117',21,'PSO','\0',0,0,200.49,5,5,2,0,177.32,0,0,177.32,177.32,214.56,214.56,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00047','\0',NULL,49,'\0','2c93eae28e368ede663ca5643b6a3546',''),
(50,2,6,14,2,'PROD118','PRODUCTO PRUEBA PROD118',21,'PSO','\0',0,0,206.21,5,5,2,0,182.38,0,0,182.38,182.38,220.68,220.68,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00048','\0',NULL,50,'\0','d68cf9706645d7abf6a2de87d0f5c089',''),
(51,2,6,14,2,'PROD119','PRODUCTO PRUEBA PROD119',21,'PSO','\0',0,0,236.84,5,5,2,0,209.47,0,0,209.47,209.47,253.46,253.46,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00049','\0',NULL,51,'\0','1ea52ee49463da3395216494156af9e0',''),
(52,2,6,15,2,'PROD120','PRODUCTO PRUEBA PROD120',21,'PSO','\0',0,0,169.65,5,5,2,0,150.05,0,0,150.05,150.05,181.56,181.56,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00050','\0',NULL,52,'\0','50d9116a1e507451e0658ff05e6122fc',''),
(53,2,6,15,2,'PROD121','PRODUCTO PRUEBA PROD121',21,'PSO','\0',0,0,187.27,5,5,2,0,165.63,0,0,165.63,165.63,200.41,200.41,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00051','\0',NULL,53,'\0','62280a6485858d3b883e7e6b00764240',''),
(54,2,6,15,2,'PROD122','PRODUCTO PRUEBA PROD122',21,'PSO','\0',0,0,169.65,5,5,2,0,150.05,0,0,150.05,150.05,181.56,181.56,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00052','\0',NULL,54,'\0','bd6a9a460a1a43358670917ba052ec77',''),
(55,2,6,15,2,'PROD123','PRODUCTO PRUEBA PROD123',21,'PSO','\0',0,0,187.27,5,5,2,0,165.63,0,0,165.63,165.63,200.41,200.41,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00053','\0',NULL,55,'\0','2c623f295670d2f3c1a1b03264cec700',''),
(56,2,6,15,2,'PROD124','PRODUCTO PRUEBA PROD124',21,'PSO','\0',0,0,204.89,5,5,2,0,181.21,0,0,181.21,181.21,219.26,219.26,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00054','\0',NULL,56,'\0','861736c944dd51c1fc1add2a2a4d3489',''),
(57,2,6,15,2,'PROD125','PRODUCTO PRUEBA PROD125',21,'PSO','\0',0,0,264.38,5,5,2,0,233.83,0,0,233.83,233.83,282.93,282.93,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00055','\0',NULL,57,'\0','e4489ca6db8575faf5fff7df46b44e9c',''),
(58,2,6,16,2,'PROD126','PRODUCTO PRUEBA PROD126',21,'PSO','\0',0,0,487.79,5,5,2,0,431.43,0,0,431.43,431.43,522.03,522.03,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00056','\0',NULL,58,'\0','53adb139f6f7f8ad3f74fa90de1dc33e',''),
(59,2,6,16,2,'PROD127','PRODUCTO PRUEBA PROD127',21,'PSO','\0',0,0,529.65,5,5,2,0,468.45,0,0,468.45,468.45,566.82,566.82,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00057','\0',NULL,59,'\0','faaafb5c8d2aca6307fee136088ff503',''),
(60,2,6,16,2,'PROD128','PRODUCTO PRUEBA PROD128',21,'PSO','\0',0,0,577.68,5,5,2,0,510.93,0,0,510.93,510.93,618.23,618.23,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00058','\0',NULL,60,'\0','177ae250a9c0a4fc57d8b1a3e95a0202',''),
(61,2,6,17,2,'PROD129','PRODUCTO PRUEBA PROD129',21,'PSO','\0',0,0,321.66,5,5,2,0,284.49,0,0,284.49,284.49,344.23,344.23,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00059','\0',NULL,61,'\0','ba25cead286d570dbe89444e8dd0cf4f',''),
(62,2,6,17,2,'PROD130','PRODUCTO PRUEBA PROD130',21,'PSO','\0',0,0,800.64,5,5,2,0,708.13,0,0,708.13,708.13,856.84,856.84,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00060','\0',NULL,62,'\0','db3930d0aeda7d8898b6f6d80a0174da',''),
(63,2,6,17,2,'PROD131','PRODUCTO PRUEBA PROD131',21,'PSO','\0',0,0,91.64,5,5,2,0,81.05,0,0,81.05,81.05,98.07,98.07,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00061','\0',NULL,63,'\0','32c3c0e3e229b92851c5a72a2db9ad22',''),
(64,2,6,17,2,'PROD132','PRODUCTO PRUEBA PROD132',21,'PSO','\0',0,0,96.49,5,5,2,0,85.34,0,0,85.34,85.34,103.26,103.26,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00062','\0',NULL,64,'\0','13c78c624161fd6aa8370646c580a86b',''),
(65,2,6,17,2,'PROD133','PRODUCTO PRUEBA PROD133',21,'PSO','\0',0,0,169.66,5,5,2,0,150.06,0,0,150.06,150.06,181.57,181.57,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00063','\0',NULL,65,'\0','ec1fc7ac5158e9b640acf711e7247b72',''),
(66,2,6,17,2,'PROD134','PRODUCTO PRUEBA PROD134',21,'PSO','\0',0,0,188.81,5,5,2,0,166.99,0,0,166.99,166.99,202.06,202.06,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00064','\0',NULL,66,'\0','968749279149fd3e4ee9b63e24647954',''),
(67,2,6,18,2,'PROD135','PRODUCTO PRUEBA PROD135',21,'PSO','\0',0,0,50,5,5,2,0,44.22,0,0,44.22,44.22,53.51,53.51,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00065','\0',NULL,67,'\0','f5ffc1b4d08f1a9a9fbfb10d17df9415',''),
(68,2,6,18,2,'PROD136','PRODUCTO PRUEBA PROD136',21,'PSO','\0',0,0,45,5,5,2,0,39.8,0,0,39.8,39.8,48.16,48.16,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00066','\0',NULL,68,'\0','e6e2abd0acae03464ed286a06fff6bb9',''),
(69,2,6,18,2,'PROD137','PRODUCTO PRUEBA PROD137',21,'PSO','\0',0,0,63,5,5,2,0,55.72,0,0,55.72,55.72,67.42,67.42,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00067','\0',NULL,69,'\0','a72b10372bf556095d7fb251efe041a4',''),
(70,2,6,18,2,'PROD138','PRODUCTO PRUEBA PROD138',21,'PSO','\0',0,0,21,5,5,2,0,18.57,0,0,18.57,18.57,22.47,22.47,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00068','\0',NULL,70,'\0','d178bb961e49c37fe498f0b43b95ac4f',''),
(71,2,6,18,2,'PROD139','PRODUCTO PRUEBA PROD139',21,'PSO','\0',0,0,42,5,5,2,0,37.15,0,0,37.15,37.15,44.95,44.95,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00069','\0',NULL,71,'\0','e7d1100d9425c4da9a398e562e95e419',''),
(72,2,6,18,2,'PROD140','PRODUCTO PRUEBA PROD140',21,'PSO','\0',0,0,24,5,5,2,0,21.23,0,0,21.23,21.23,25.69,25.69,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'ACEIN00070','\0',NULL,72,'\0','35fcb9784beff43e42d6829593ad8558',''),
(73,3,2,2,3,'PROD141','PRODUCTO PRUEBA PROD141',21,'PSO','\0',0,0,250.91,5,5,2,0,221.92,0,0,221.92,221.92,268.52,268.52,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00001','\0',NULL,73,'\0','5a388c0596314e2c288890a80ac33689',''),
(74,3,2,2,3,'PROD142','PRODUCTO PRUEBA PROD142',21,'PSO','\0',0,0,249.71,5,5,2,0,220.86,0,0,220.86,220.86,267.24,267.24,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00002','\0',NULL,74,'\0','1da991875c20efe539af0303ca56add6',''),
(75,3,2,2,3,'PROD143','PRODUCTO PRUEBA PROD143',21,'PSO','\0',0,0,536.94,5,5,2,0,474.9,0,0,474.9,474.9,574.63,574.63,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00003','\0',NULL,75,'\0','4eed57c92ab01c41bed0d0b1fcd9da19',''),
(76,3,2,2,3,'PROD144','PRODUCTO PRUEBA PROD144',21,'PSO','\0',0,0,624.65,5,5,2,0,552.47,0,0,552.47,552.47,668.49,668.49,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00004','\0',NULL,76,'\0','9335ece0b5e698bd169afcfdfb07c8fb',''),
(77,3,2,3,3,'PROD145','PRODUCTO PRUEBA PROD145',21,'PSO','\0',0,0,250.91,5,5,2,0,221.92,0,0,221.92,221.92,268.52,268.52,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00005','\0',NULL,77,'\0','7bbf879811913ce8c045f085ec3dcd1f',''),
(78,3,2,3,3,'PROD146','PRODUCTO PRUEBA PROD146',21,'PSO','\0',0,0,249.71,5,5,2,0,220.86,0,0,220.86,220.86,267.24,267.24,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00006','\0',NULL,78,'\0','7aa9fb98ec6aa373a024c10c7fcff402',''),
(79,3,2,4,3,'PROD147','PRODUCTO PRUEBA PROD147',21,'PSO','\0',0,0,259.2,5,5,2,0,229.25,0,0,229.25,229.25,277.39,277.39,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00007','\0',NULL,79,'\0','74373abaaa0e666d9fa8c4408b87848d',''),
(80,3,2,4,3,'PROD148','PRODUCTO PRUEBA PROD148',21,'PSO','\0',0,0,256.96,5,5,2,0,227.27,0,0,227.27,227.27,275,275,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00008','\0',NULL,80,'\0','ca6436c1dbc9916527750a8211f44627',''),
(81,3,3,5,3,'PROD149','PRODUCTO PRUEBA PROD149',21,'PSO','\0',0,0,7.2,5,5,2,0,6.37,0,0,6.37,6.37,7.71,7.71,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00009','\0',NULL,81,'\0','0559b241307a5f20d0b5a2ab6fd3ee2a',''),
(82,3,3,5,3,'PROD150','PRODUCTO PRUEBA PROD150',21,'PSO','\0',0,0,7.6,5,5,2,0,6.72,0,0,6.72,6.72,8.13,8.13,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00010','\0',NULL,82,'\0','0ca2a7ce47f9563a6fa9b3bdd1d9a040',''),
(83,3,3,5,3,'PROD151','PRODUCTO PRUEBA PROD151',21,'PSO','\0',0,0,8.6,5,5,2,0,7.61,0,0,7.61,7.61,9.21,9.21,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00011','\0',NULL,83,'\0','dc4e0d7f67507f842fc09f8c9f9d26e8',''),
(84,3,3,5,3,'PROD152','PRODUCTO PRUEBA PROD152',21,'PSO','\0',0,0,9.6,5,5,2,0,8.49,0,0,8.49,8.49,10.27,10.27,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00012','\0',NULL,84,'\0','a468a89a781d31f52df379190acf2f6b',''),
(85,3,3,6,3,'PROD153','PRODUCTO PRUEBA PROD153',21,'PSO','\0',0,0,8.8,5,5,2,0,7.78,0,0,7.78,7.78,9.41,9.41,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00013','\0',NULL,85,'\0','b6e2b746ada75d47ef06a14219ad1a32',''),
(86,3,3,6,3,'PROD154','PRODUCTO PRUEBA PROD154',21,'PSO','\0',0,0,9.8,5,5,2,0,8.67,0,0,8.67,8.67,10.49,10.49,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00014','\0',NULL,86,'\0','d73dbc32e28727c3bc3a499c2c02bb7a',''),
(87,3,3,7,3,'PROD155','PRODUCTO PRUEBA PROD155',21,'PSO','\0',0,0,32.6,5,5,2,0,28.83,0,0,28.83,28.83,34.88,34.88,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00015','\0',NULL,87,'\0','cc60be982f0cfdb4083f3ea2b09a68b2',''),
(88,3,3,7,3,'PROD156','PRODUCTO PRUEBA PROD156',21,'PSO','\0',0,0,38.6,5,5,2,0,34.14,0,0,34.14,34.14,41.31,41.31,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00016','\0',NULL,88,'\0','3d4c2911f05b29b33a63c2258dfaa83d',''),
(89,3,3,7,3,'PROD157','PRODUCTO PRUEBA PROD157',21,'PSO','\0',0,0,24,5,5,2,0,21.23,0,0,21.23,21.23,25.69,25.69,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00017','\0',NULL,89,'\0','707e9d6d1672b9c4b7ff780d638e9613',''),
(90,3,3,8,3,'PROD158','PRODUCTO PRUEBA PROD158',21,'PSO','\0',0,0,57.2,5,5,2,0,50.59,0,0,50.59,50.59,61.21,61.21,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00018','\0',NULL,90,'\0','b67e3e263aaed657c26931bc6e7267ae',''),
(91,3,4,9,3,'PROD159','PRODUCTO PRUEBA PROD159',21,'PSO','\0',0,0,44.9,5,5,2,0,39.71,0,0,39.71,39.71,48.05,48.05,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00019','\0',NULL,91,'\0','8cc9a388042404b5cd2e9f9097a7170f',''),
(92,3,5,10,3,'PROD160','PRODUCTO PRUEBA PROD160',21,'PSO','\0',0,0,7.32,5,5,2,0,6.47,0,0,6.47,6.47,7.83,7.83,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00020','\0',NULL,92,'\0','8b14ebf150bbc66a3f92ef9c59baa261',''),
(93,3,5,10,3,'PROD161','PRODUCTO PRUEBA PROD161',21,'PSO','\0',0,0,17.13,5,5,2,0,15.15,0,0,15.15,15.15,18.33,18.33,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00021','\0',NULL,93,'\0','03235449f1d2044c1f5c03d2c4e50053',''),
(94,3,5,10,3,'PROD162','PRODUCTO PRUEBA PROD162',21,'PSO','\0',0,0,19.9,5,5,2,0,17.6,0,0,17.6,17.6,21.3,21.3,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00022','\0',NULL,94,'\0','51e5c4a28049de66db5642fe20f668fc',''),
(95,3,5,10,3,'PROD163','PRODUCTO PRUEBA PROD163',21,'PSO','\0',0,0,27.95,5,5,2,0,24.72,0,0,24.72,24.72,29.91,29.91,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00023','\0',NULL,95,'\0','d123f855ca7ee7b7793827776e574065',''),
(96,3,5,10,3,'PROD164','PRODUCTO PRUEBA PROD164',21,'PSO','\0',0,0,27.1,5,5,2,0,23.97,0,0,23.97,23.97,29,29,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00024','\0',NULL,96,'\0','36e65be23b8ea6ebc12897d356655a1a',''),
(97,3,5,10,3,'PROD165','PRODUCTO PRUEBA PROD165',21,'PSO','\0',0,0,39.3,5,5,2,0,34.76,0,0,34.76,34.76,42.06,42.06,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00025','\0',NULL,97,'\0','4a3b53b73b8829c319dfa611b0decd67',''),
(98,3,5,10,3,'PROD166','PRODUCTO PRUEBA PROD166',21,'PSO','\0',0,0,43.61,5,5,2,0,38.57,0,0,38.57,38.57,46.67,46.67,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00026','\0',NULL,98,'\0','6b6dafab858cb1d933f884cfca52abd8',''),
(99,3,5,10,3,'PROD167','PRODUCTO PRUEBA PROD167',21,'PSO','\0',0,0,60.13,5,5,2,0,53.18,0,0,53.18,53.18,64.35,64.35,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00027','\0',NULL,99,'\0','255fb570a6c024cf310db7fe3e373b7a',''),
(100,3,5,10,3,'PROD168','PRODUCTO PRUEBA PROD168',21,'PSO','\0',0,0,108.3,5,5,2,0,95.79,0,0,95.79,95.79,115.91,115.91,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00028','\0',NULL,100,'\0','2afdc70853b997f28104ab2dc0948393',''),
(101,3,5,10,3,'PROD169','PRODUCTO PRUEBA PROD169',21,'PSO','\0',0,0,67.43,5,5,2,0,59.64,0,0,59.64,59.64,72.16,72.16,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00029','\0',NULL,101,'\0','865f1dfe42599eef054145b5007049d1',''),
(102,3,5,10,3,'PROD170','PRODUCTO PRUEBA PROD170',21,'PSO','\0',0,0,76.86,5,5,2,0,67.98,0,0,67.98,67.98,82.26,82.26,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00030','\0',NULL,102,'\0','d969b60b2ff573597cb259a416e97ff7',''),
(103,3,5,10,3,'PROD171','PRODUCTO PRUEBA PROD171',21,'PSO','\0',0,0,149.2,5,5,2,0,131.96,0,0,131.96,131.96,159.67,159.67,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00031','\0',NULL,103,'\0','98898f229de71f9338d4f10ff0610169',''),
(104,3,5,10,3,'PROD172','PRODUCTO PRUEBA PROD172',21,'PSO','\0',0,0,176.23,5,5,2,0,155.87,0,0,155.87,155.87,188.6,188.6,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00032','\0',NULL,104,'\0','452d3f1b6cb9aff9d7744c0e8f49353a',''),
(105,3,6,11,3,'PROD173','PRODUCTO PRUEBA PROD173',21,'PSO','\0',0,0,152.02,5,5,2,0,134.45,0,0,134.45,134.45,162.68,162.68,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00033','\0',NULL,105,'\0','6c7644a35e4d7ac8ddec555a01e24a3b',''),
(106,3,6,11,3,'PROD174','PRODUCTO PRUEBA PROD174',21,'PSO','\0',0,0,181.98,5,5,2,0,160.95,0,0,160.95,160.95,194.75,194.75,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00034','\0',NULL,106,'\0','416d91c9adfdf9cced7c4a103fd92b5b',''),
(107,3,6,11,3,'PROD175','PRODUCTO PRUEBA PROD175',21,'PSO','\0',0,0,138.8,5,5,2,0,122.76,0,0,122.76,122.76,148.54,148.54,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00035','\0',NULL,107,'\0','5178596bcb2496ea91fd14188b96a6e8',''),
(108,3,6,12,3,'PROD176','PRODUCTO PRUEBA PROD176',21,'PSO','\0',0,0,154.22,5,5,2,0,136.4,0,0,136.4,136.4,165.04,165.04,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00036','\0',NULL,108,'\0','c68f543db2d802baa7b908becbf528b7',''),
(109,3,6,12,3,'PROD177','PRODUCTO PRUEBA PROD177',21,'PSO','\0',0,0,159.73,5,5,2,0,141.27,0,0,141.27,141.27,170.94,170.94,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00037','\0',NULL,109,'\0','2ea4e5eb5db314b3e249e6fdf29a0d1e',''),
(110,3,6,12,3,'PROD178','PRODUCTO PRUEBA PROD178',21,'PSO','\0',0,0,159.73,5,5,2,0,141.27,0,0,141.27,141.27,170.94,170.94,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00038','\0',NULL,110,'\0','adeae988712a06f42488e6ba73015839',''),
(111,3,6,12,3,'PROD179','PRODUCTO PRUEBA PROD179',21,'PSO','\0',0,0,200,5,5,2,0,176.89,0,0,176.89,176.89,214.04,214.04,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00039','\0',NULL,111,'\0','3b75a64a81d7fe5567437023ead52050',''),
(112,3,6,13,3,'PROD180','PRODUCTO PRUEBA PROD180',21,'PSO','\0',0,0,318.36,5,5,2,0,281.57,0,0,281.57,281.57,340.7,340.7,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00040','\0',NULL,112,'\0','1684182cdeba1c89e2ef82df83c765d6',''),
(113,3,6,13,3,'PROD181','PRODUCTO PRUEBA PROD181',21,'PSO','\0',0,0,425,5,5,2,0,375.89,0,0,375.89,375.89,454.83,454.83,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00041','\0',NULL,113,'\0','e716c5cf11acc12a18ada9bd2db91011',''),
(114,3,6,13,3,'PROD182','PRODUCTO PRUEBA PROD182',21,'PSO','\0',0,0,221,5,5,2,0,195.46,0,0,195.46,195.46,236.51,236.51,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00042','\0',NULL,114,'\0','d56f54f66f61283abc97f4030d7bcf06',''),
(115,3,6,13,3,'PROD183','PRODUCTO PRUEBA PROD183',21,'PSO','\0',0,0,223,5,5,2,0,197.23,0,0,197.23,197.23,238.65,238.65,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00043','\0',NULL,115,'\0','6911b516de87f914e075c082dbbdc37b',''),
(116,3,6,14,3,'PROD184','PRODUCTO PRUEBA PROD184',21,'PSO','\0',0,0,200.49,5,5,2,0,177.32,0,0,177.32,177.32,214.56,214.56,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00044','\0',NULL,116,'\0','faf472ec95f526c6a708c51f574a52c0',''),
(117,3,6,14,3,'PROD185','PRODUCTO PRUEBA PROD185',21,'PSO','\0',0,0,206.21,5,5,2,0,182.38,0,0,182.38,182.38,220.68,220.68,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00045','\0',NULL,117,'\0','69626ed6a29b459e9c9420c7fefe9f95',''),
(118,3,6,14,3,'PROD186','PRODUCTO PRUEBA PROD186',21,'PSO','\0',0,0,236.84,5,5,2,0,209.47,0,0,209.47,209.47,253.46,253.46,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00046','\0',NULL,118,'\0','39f8add0a2d458b47ce3e59b122f2d77',''),
(119,3,6,14,3,'PROD187','PRODUCTO PRUEBA PROD187',21,'PSO','\0',0,0,200.49,5,5,2,0,177.32,0,0,177.32,177.32,214.56,214.56,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00047','\0',NULL,119,'\0','c5be1de947fb4df225c90e05ae1fba3c',''),
(120,3,6,14,3,'PROD188','PRODUCTO PRUEBA PROD188',21,'PSO','\0',0,0,206.21,5,5,2,0,182.38,0,0,182.38,182.38,220.68,220.68,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00048','\0',NULL,120,'\0','c4ce000894901ba6cc1a3da6bf689b4a',''),
(121,3,6,14,3,'PROD189','PRODUCTO PRUEBA PROD189',21,'PSO','\0',0,0,236.84,5,5,2,0,209.47,0,0,209.47,209.47,253.46,253.46,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00049','\0',NULL,121,'\0','56280dc5e6a423f1113d85ed0c0177bc',''),
(122,3,6,15,3,'PROD190','PRODUCTO PRUEBA PROD190',21,'PSO','\0',0,0,169.65,5,5,2,0,150.05,0,0,150.05,150.05,181.56,181.56,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00050','\0',NULL,122,'\0','fcbdd3a23c3421e4c9f8d230580386a4',''),
(123,3,6,15,3,'PROD191','PRODUCTO PRUEBA PROD191',21,'PSO','\0',0,0,187.27,5,5,2,0,165.63,0,0,165.63,165.63,200.41,200.41,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00051','\0',NULL,123,'\0','7d7e909acae440dc726f60d5eef7a880',''),
(124,3,6,15,3,'PROD192','PRODUCTO PRUEBA PROD192',21,'PSO','\0',0,0,169.65,5,5,2,0,150.05,0,0,150.05,150.05,181.56,181.56,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00052','\0',NULL,124,'\0','9dc9e19ee922dbd766d480f82d4d4daa',''),
(125,3,6,15,3,'PROD193','PRODUCTO PRUEBA PROD193',21,'PSO','\0',0,0,187.27,5,5,2,0,165.63,0,0,165.63,165.63,200.41,200.41,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00053','\0',NULL,125,'\0','09c98faef92c24d7d7ee0d1de7fedee3',''),
(126,3,6,15,3,'PROD194','PRODUCTO PRUEBA PROD194',21,'PSO','\0',0,0,204.89,5,5,2,0,181.21,0,0,181.21,181.21,219.26,219.26,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00054','\0',NULL,126,'\0','49c329616c12ce350ae5fce1562893ae',''),
(127,3,6,15,3,'PROD195','PRODUCTO PRUEBA PROD195',21,'PSO','\0',0,0,264.38,5,5,2,0,233.83,0,0,233.83,233.83,282.93,282.93,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00055','\0',NULL,127,'\0','dd52f1b6ed4a64a7d278cae2a391fb19',''),
(128,3,6,16,3,'PROD196','PRODUCTO PRUEBA PROD196',21,'PSO','\0',0,0,487.79,5,5,2,0,431.43,0,0,431.43,431.43,522.03,522.03,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00056','\0',NULL,128,'\0','c320289dd343d9a1bddd23733e66749f',''),
(129,3,6,16,3,'PROD197','PRODUCTO PRUEBA PROD197',21,'PSO','\0',0,0,529.65,5,5,2,0,468.45,0,0,468.45,468.45,566.82,566.82,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00057','\0',NULL,129,'\0','ed47b7e0e2cba33488f4b9c5d652764b',''),
(130,3,6,16,3,'PROD198','PRODUCTO PRUEBA PROD198',21,'PSO','\0',0,0,577.68,5,5,2,0,510.93,0,0,510.93,510.93,618.23,618.23,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00058','\0',NULL,130,'\0','65273b36509ab1784c9190d18b1f9fdd',''),
(131,3,6,17,3,'PROD199','PRODUCTO PRUEBA PROD199',21,'PSO','\0',0,0,321.66,5,5,2,0,284.49,0,0,284.49,284.49,344.23,344.23,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00059','\0',NULL,131,'\0','32df6557305af22ed968b6748cdd6cec',''),
(132,3,6,17,3,'PROD200','PRODUCTO PRUEBA PROD200',21,'PSO','\0',0,0,800.64,5,5,2,0,708.13,0,0,708.13,708.13,856.84,856.84,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00060','\0',NULL,132,'\0','5da749b3e3eea9a596c3cefba6b83d73',''),
(133,3,6,17,3,'PROD201','PRODUCTO PRUEBA PROD201',21,'PSO','\0',0,0,91.64,5,5,2,0,81.05,0,0,81.05,81.05,98.07,98.07,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00061','\0',NULL,133,'\0','0c77960d2572faa5d5cd17c4e9316c28',''),
(134,3,6,17,3,'PROD202','PRODUCTO PRUEBA PROD202',21,'PSO','\0',0,0,96.49,5,5,2,0,85.34,0,0,85.34,85.34,103.26,103.26,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00062','\0',NULL,134,'\0','6eb43c62487c95c809f1816e512d4ff3',''),
(135,3,6,17,3,'PROD203','PRODUCTO PRUEBA PROD203',21,'PSO','\0',0,0,169.66,5,5,2,0,150.06,0,0,150.06,150.06,181.57,181.57,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00063','\0',NULL,135,'\0','1cfacb23650fb1a123e3addd98996cf6',''),
(136,3,6,17,3,'PROD204','PRODUCTO PRUEBA PROD204',21,'PSO','\0',0,0,188.81,5,5,2,0,166.99,0,0,166.99,166.99,202.06,202.06,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00064','\0',NULL,136,'\0','e3cc5d0158c487e0c9c5a20053158231',''),
(137,3,6,18,3,'PROD205','PRODUCTO PRUEBA PROD205',21,'PSO','\0',0,0,50,5,5,2,0,44.22,0,0,44.22,44.22,53.51,53.51,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00065','\0',NULL,137,'\0','a8d30850b8e7791749d3de548b2326b3',''),
(138,3,6,18,3,'PROD206','PRODUCTO PRUEBA PROD206',21,'PSO','\0',0,0,45,5,5,2,0,39.8,0,0,39.8,39.8,48.16,48.16,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00066','\0',NULL,138,'\0','770a92c21e5d88d23b5fa0e5bc3f5c3e',''),
(139,3,6,18,3,'PROD207','PRODUCTO PRUEBA PROD207',21,'PSO','\0',0,0,63,5,5,2,0,55.72,0,0,55.72,55.72,67.42,67.42,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00067','\0',NULL,139,'\0','d6d55e4ea015cf48b3094272c756c694',''),
(140,3,6,18,3,'PROD208','PRODUCTO PRUEBA PROD208',21,'PSO','\0',0,0,21,5,5,2,0,18.57,0,0,18.57,18.57,22.47,22.47,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00068','\0',NULL,140,'\0','26d95aefc8b8b20b2f99a4d7610b6d0a',''),
(141,3,6,18,3,'PROD209','PRODUCTO PRUEBA PROD209',21,'PSO','\0',0,0,42,5,5,2,0,37.15,0,0,37.15,37.15,44.95,44.95,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00069','\0',NULL,141,'\0','c6358c92e5839d667e7602fa28dd049e',''),
(142,3,6,18,3,'PROD210','PRODUCTO PRUEBA PROD210',21,'PSO','\0',0,0,24,5,5,2,0,21.23,0,0,21.23,21.23,25.69,25.69,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'IND00070','\0',NULL,142,'\0','42df22d18e16b564430129de1096f417',''),
(143,4,2,2,4,'PROD001','PRODUCTO PRUEBA PROD001',21,'PSO','\0',0,0,6000,10,0,0,0,5400,30,40,7020,7560,8494.2,9147.6,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2026-01-26 19:08:39','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'110FCPSOL','\0','2024-06-10 22:46:48',143,'\0','85f955b5a6d08ae7f6ee2a4ce8709665',''),
(144,4,2,2,4,'PROD002','PRODUCTO PRUEBA PROD002',21,'PSO','\0',0,0,60000,10,0,0,0,54000,30,40,70200,75600,84942,91476,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2026-01-26 19:08:45','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'110FSPSOL','\0','2024-06-10 22:46:48',144,'\0','5485cdc93a7803e62b660cb7753a5c00',''),
(145,4,2,2,4,'PROD003','PRODUCTO PRUEBA PROD003',10.5,'PSO','\0',0,0,10000,10,0,0,0,9000,30,40,11700,12600,12928.5,13923,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-10 22:46:48','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'104FCPSOL','\0','2024-06-10 22:46:48',145,'\0','936605e2415c6eda9aaf4ff30414ee4c',''),
(146,4,2,2,4,'PROD004','PRODUCTO PRUEBA PROD004',10.5,'PSO','\0',0,0,160000,10,0,0,0,144000,30,40,187200,201600,206856,222768,'\0',0.00,0.00,0.00,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-10 22:46:48','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'103FCPSOL','\0','2024-06-10 22:46:48',146,'\0','338a399fc8a1f8dc9d26c70ea48bcba7',''),
(147,4,2,3,4,'PROD005','PRODUCTO PRUEBA PROD005',21,'PSO','\0',0,0,80000,10,0,0,0,72000,30,40,93600,100800,113256,121968,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2024-06-10 22:46:48','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',1,'105FCPSOL','\0','2024-06-10 22:46:48',147,'\0','8de383b85e77a97eb064934d1beeec3b',''),
(148,4,2,3,4,'PROD006','PRODUCTO PRUEBA PROD006',21,'PSO','\0',0,0,249.71,20,10,0,0,179.79,0,0,179.79,179.79,217.55,217.55,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'102FCPSOL','\0',NULL,148,'\0','1fc07a9460c245899cefe22c8efe444d',''),
(149,4,2,4,4,'PROD007','PRODUCTO PRUEBA PROD007',21,'PSO','\0',0,0,259.2,20,10,0,0,186.62,0,0,186.62,186.62,225.81,225.81,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'106FCPSOL','\0',NULL,149,'\0','ce72deca635a53db7640e1516490e06d',''),
(150,4,2,4,4,'PROD008','PRODUCTO PRUEBA PROD008',21,'PSO','\0',0,0,256.96,20,10,0,0,185.01,0,0,185.01,185.01,223.86,223.86,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'106FSPSOL','\0',NULL,150,'\0','8f973b3a8eca434433bd673f0ceda45b',''),
(151,4,3,5,4,'PROD009','PRODUCTO PRUEBA PROD009',21,'PSO','\0',0,0,7.2,20,10,0,0,5.18,0,0,5.18,5.18,6.27,6.27,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'GMBESOL','\0',NULL,151,'\0','4d4d1808df01e4de1bcb9ef7bfd96640',''),
(152,4,3,5,4,'PROD010','PRODUCTO PRUEBA PROD010',21,'PSO','\0',0,0,2000,20,10,0,0,1440,0,0,1440,1440,1742.4,1742.4,'',75.00,1306.80,1306.80,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2023-02-11 11:39:37','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,'\0',1,'GMBCSOL','\0','2023-02-11 11:39:37',152,'\0','44bbd3226ece37072e8d6b7364cf723d',''),
(153,4,3,5,4,'PROD011','PRODUCTO PRUEBA PROD011',21,'PSO','\0',0,0,1000,20,10,0,0,720,0,0,720,720,871.2,871.2,'',75.00,653.40,653.40,'','','','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo','SUPER','2023-02-11 11:39:55','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,'\0',1,'GMBPSOL','\0','2023-02-11 11:39:55',153,'\0','252907122b76c9db68aec297dd62bc3c',''),
(154,4,3,5,4,'PROD012','PRODUCTO PRUEBA PROD012',21,'PSO','\0',0,0,9.6,20,10,0,0,6.91,0,0,6.91,6.91,8.36,8.36,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'GMBRSOL','\0',NULL,154,'\0','bfb9f9824e16548c20979cce0e0a1891',''),
(155,4,3,6,4,'PROD013','PRODUCTO PRUEBA PROD013',21,'PSO','\0',0,0,8.8,20,10,0,0,6.34,0,0,6.34,6.34,7.67,7.67,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'GMNLSOL','\0',NULL,155,'\0','a38360b4d2e2de5c8d858ce86a2b3d41',''),
(156,4,3,6,4,'PROD014','PRODUCTO PRUEBA PROD014',21,'PSO','\0',0,0,9.8,20,10,0,0,7.06,0,0,7.06,7.06,8.54,8.54,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'GMNPSOL','\0',NULL,156,'\0','01186f6072fb2de6ce97791a8dc2aa99',''),
(157,4,3,7,4,'PROD015','PRODUCTO PRUEBA PROD015',21,'PSO','\0',0,0,32.6,20,10,0,0,23.47,0,0,23.47,23.47,28.4,28.4,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'GDCSOL','\0',NULL,157,'\0','066f8c64a6e5d4cc685465bde46a20b1',''),
(158,4,3,7,4,'PROD016','PRODUCTO PRUEBA PROD016',21,'PSO','\0',0,0,38.6,20,10,0,0,27.79,0,0,27.79,27.79,33.63,33.63,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'GDLSOL','\0',NULL,158,'\0','f2f3507def8393888cd957ef44577452',''),
(159,4,3,7,4,'PROD017','PRODUCTO PRUEBA PROD017',21,'PSO','\0',0,0,24,20,10,0,0,17.28,0,0,17.28,17.28,20.91,20.91,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'GDESOL','\0',NULL,159,'\0','d86f5fa1700313d33a3a1831fca67f7e',''),
(160,4,3,8,4,'PROD018','PRODUCTO PRUEBA PROD018',21,'PSO','\0',0,0,57.2,20,10,0,0,41.18,0,0,41.18,41.18,49.83,49.83,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'GPVCSOL','\0',NULL,160,'\0','a65adefcc58a626e415fc21b3a2c98b9',''),
(161,4,4,9,4,'PROD019','PRODUCTO PRUEBA PROD019',21,'PSO','\0',0,0,44.9,20,10,0,0,32.33,0,0,32.33,32.33,39.12,39.12,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'285SOL','\0',NULL,161,'\0','c96d91431030b89bbbc49d9d2ef0d4d6',''),
(162,4,5,10,4,'PROD020','PRODUCTO PRUEBA PROD020',21,'PSO','\0',0,0,7.32,20,10,0,0,5.27,0,0,5.27,5.27,6.38,6.38,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'8033ESOL','\0',NULL,162,'\0','acf12a0e731be0dc0ac53ad52ca0e3ec',''),
(163,4,5,10,4,'PROD021','PRODUCTO PRUEBA PROD021',21,'PSO','\0',0,0,17.13,20,10,0,0,12.33,0,0,12.33,12.33,14.92,14.92,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'8040ESOL','\0',NULL,163,'\0','60f2c9b5f72ead994a456d42ae62427f',''),
(164,4,5,10,4,'PROD022','PRODUCTO PRUEBA PROD022',21,'PSO','\0',0,0,19.9,20,10,0,0,14.33,0,0,14.33,14.33,17.34,17.34,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'8034ESOL','\0',NULL,164,'\0','d84a72e2eca8321a0496bdbc387ec821',''),
(165,4,5,10,4,'PROD023','PRODUCTO PRUEBA PROD023',21,'PSO','\0',0,0,27.95,20,10,0,0,20.12,0,0,20.12,20.12,24.35,24.35,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'8036GSOL','\0',NULL,165,'\0','b412c35972e418ed115f12f1cbfd3bb5',''),
(166,4,5,10,4,'PROD024','PRODUCTO PRUEBA PROD024',21,'PSO','\0',0,0,27.1,20,10,0,0,19.51,0,0,19.51,19.51,23.61,23.61,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'8032ESOL','\0',NULL,166,'\0','69df73c3ed90e385fe0cad0f9ed45c2e',''),
(167,4,5,10,4,'PROD025','PRODUCTO PRUEBA PROD025',21,'PSO','\0',0,0,39.3,20,10,0,0,28.3,0,0,28.3,28.3,34.24,34.24,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'8037ESOL','\0',NULL,167,'\0','5390c560b504158a9ff7f769df7460b2',''),
(168,4,5,10,4,'PROD026','PRODUCTO PRUEBA PROD026',21,'PSO','\0',0,0,43.61,20,10,0,0,31.4,0,0,31.4,31.4,37.99,37.99,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'8039ESOL','\0',NULL,168,'\0','a466fb762f15b430e8b7f9a1331cc6fd',''),
(169,4,5,10,4,'PROD027','PRODUCTO PRUEBA PROD027',21,'PSO','\0',0,0,60.13,20,10,0,0,43.29,0,0,43.29,43.29,52.38,52.38,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'9040ESOL','\0',NULL,169,'\0','db20e7bb90a0ad156e58df7ad0ad2317',''),
(170,4,5,10,4,'PROD028','PRODUCTO PRUEBA PROD028',21,'PSO','\0',0,0,108.3,20,10,0,0,77.98,0,0,77.98,77.98,94.36,94.36,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'8038ESOL','\0',NULL,170,'\0','094176ec649fc5b0fa4610c9b9a5d701',''),
(171,4,5,10,4,'PROD029','PRODUCTO PRUEBA PROD029',21,'PSO','\0',0,0,67.43,20,10,0,0,48.55,0,0,48.55,48.55,58.75,58.75,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'9441ESOL','\0',NULL,171,'\0','608cb4e1bfdf21794d7720d5f8223bd8',''),
(172,4,5,10,4,'PROD030','PRODUCTO PRUEBA PROD030',21,'PSO','\0',0,0,76.86,20,10,0,0,55.34,0,0,55.34,55.34,66.96,66.96,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'9442ESOL','\0',NULL,172,'\0','3dc41ed541b6815ed8ea629d583f3bcf',''),
(173,4,5,10,4,'PROD031','PRODUCTO PRUEBA PROD031',21,'PSO','\0',0,0,149.2,20,10,0,0,107.42,0,0,107.42,107.42,129.98,129.98,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'9443ESOL','\0',NULL,173,'\0','48efbc0a37409ef014af8ff7d74da65e',''),
(174,4,5,10,4,'PROD032','PRODUCTO PRUEBA PROD032',21,'PSO','\0',0,0,176.23,20,10,0,0,126.89,0,0,126.89,126.89,153.54,153.54,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'9444ESOL','\0',NULL,174,'\0','5c70801f2fcacee2e1ee621ca95fbc1f',''),
(175,4,6,11,4,'PROD033','PRODUCTO PRUEBA PROD033',21,'PSO','\0',0,0,152.02,20,10,0,0,109.45,0,0,109.45,109.45,132.43,132.43,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'100SOL','\0',NULL,175,'\0','10822c3cd0e2905662bfc3b1cbdc4458',''),
(176,4,6,11,4,'PROD034','PRODUCTO PRUEBA PROD034',21,'PSO','\0',0,0,181.98,20,10,0,0,131.03,0,0,131.03,131.03,158.55,158.55,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'109SOL','\0',NULL,176,'\0','75c9a2e436dc9919a4852c2729b34abe',''),
(177,4,6,11,4,'PROD035','PRODUCTO PRUEBA PROD035',21,'PSO','\0',0,0,138.8,20,10,0,0,99.94,0,0,99.94,99.94,120.93,120.93,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'129SOL','\0',NULL,177,'\0','7c4c27096ce51b8999f175e2fcaf89b4',''),
(178,4,6,12,4,'PROD036','PRODUCTO PRUEBA PROD036',21,'PSO','\0',0,0,154.22,20,10,0,0,111.04,0,0,111.04,111.04,134.36,134.36,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'110SOL','\0',NULL,178,'\0','4d798afe22682bf1a84a674915062c83',''),
(179,4,6,12,4,'PROD037','PRODUCTO PRUEBA PROD037',21,'PSO','\0',0,0,159.73,20,10,0,0,115.01,0,0,115.01,115.01,139.16,139.16,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'119SOL','\0',NULL,179,'\0','7c1c3a562a4c1b1774a01229413f4485',''),
(180,4,6,12,4,'PROD038','PRODUCTO PRUEBA PROD038',21,'PSO','\0',0,0,159.73,20,10,0,0,115.01,0,0,115.01,115.01,139.16,139.16,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'118SOL','\0',NULL,180,'\0','e2347d332d39df94d42699ee767e0850',''),
(181,4,6,12,4,'PROD039','PRODUCTO PRUEBA PROD039',21,'PSO','\0',0,0,200,20,10,0,0,144,0,0,144,144,174.24,174.24,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'131SOL','\0',NULL,181,'\0','000821012493080452c4e4061730b2be',''),
(182,4,6,13,4,'PROD040','PRODUCTO PRUEBA PROD040',21,'PSO','\0',0,0,318.36,20,10,0,0,229.22,0,0,229.22,229.22,277.36,277.36,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'220SOL','\0',NULL,182,'\0','a71c6c4834e2a41a98edfdf583131b95',''),
(183,4,6,13,4,'PROD041','PRODUCTO PRUEBA PROD041',21,'PSO','\0',0,0,425,20,10,0,0,306,0,0,306,306,370.26,370.26,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'229SOL','\0',NULL,183,'\0','d121eb21da8f5789db5c70b70db3ff6d',''),
(184,4,6,13,4,'PROD042','PRODUCTO PRUEBA PROD042',21,'PSO','\0',0,0,221,20,10,0,0,159.12,0,0,159.12,159.12,192.54,192.54,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'221SOL','\0',NULL,184,'\0','522dd12103b16c81dfc1058e43919c6c',''),
(185,4,6,13,4,'PROD043','PRODUCTO PRUEBA PROD043',21,'PSO','\0',0,0,223,20,10,0,0,160.56,0,0,160.56,160.56,194.28,194.28,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'223SOL','\0',NULL,185,'\0','c4c2df09687a746cd53c340e5d275385',''),
(186,4,6,14,4,'PROD044','PRODUCTO PRUEBA PROD044',21,'PSO','\0',0,0,200.49,20,10,0,0,144.35,0,0,144.35,144.35,174.66,174.66,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'170SOL','\0',NULL,186,'\0','a73f1bfc4a569895b92a5345c42e3283',''),
(187,4,6,14,4,'PROD045','PRODUCTO PRUEBA PROD045',21,'PSO','\0',0,0,206.21,20,10,0,0,148.47,0,0,148.47,148.47,179.65,179.65,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'190SOL','\0',NULL,187,'\0','80070e0bb38f392f96c9593adcfd679a',''),
(188,4,6,14,4,'PROD046','PRODUCTO PRUEBA PROD046',21,'PSO','\0',0,0,236.84,20,10,0,0,170.52,0,0,170.52,170.52,206.33,206.33,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'199SOL','\0',NULL,188,'\0','642ed68e6b969c3f5c3181261c8418ce',''),
(189,4,6,14,4,'PROD047','PRODUCTO PRUEBA PROD047',21,'PSO','\0',0,0,200.49,20,10,0,0,144.35,0,0,144.35,144.35,174.66,174.66,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'180SOL','\0',NULL,189,'\0','db7abca77312a47c2b5bd7c430e42ed4',''),
(190,4,6,14,4,'PROD048','PRODUCTO PRUEBA PROD048',21,'PSO','\0',0,0,206.21,20,10,0,0,148.47,0,0,148.47,148.47,179.65,179.65,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'200SOL','\0',NULL,190,'\0','0065c0517c7fd3535087bb30391084dd',''),
(191,4,6,14,4,'PROD049','PRODUCTO PRUEBA PROD049',21,'PSO','\0',0,0,236.84,20,10,0,0,170.52,0,0,170.52,170.52,206.33,206.33,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'201SOL','\0',NULL,191,'\0','65bfda44f7bbc7a3318f2621bdcc80bd',''),
(192,4,6,15,4,'PROD050','PRODUCTO PRUEBA PROD050',21,'PSO','\0',0,0,169.65,20,10,0,0,122.15,0,0,122.15,122.15,147.8,147.8,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'336SOL','\0',NULL,192,'\0','88d1345223031e649ec8288b47a88cda',''),
(193,4,6,15,4,'PROD051','PRODUCTO PRUEBA PROD051',21,'PSO','\0',0,0,187.27,20,10,0,0,134.83,0,0,134.83,134.83,163.14,163.14,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'336ESOL','\0',NULL,193,'\0','f2728df65c0a94187098696d82babdce',''),
(194,4,6,15,4,'PROD052','PRODUCTO PRUEBA PROD052',21,'PSO','\0',0,0,169.65,20,10,0,0,122.15,0,0,122.15,122.15,147.8,147.8,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'723SOL','\0',NULL,194,'\0','ffe2c1c387960c965a8ae6911895d222',''),
(195,4,6,15,4,'PROD053','PRODUCTO PRUEBA PROD053',21,'PSO','\0',0,0,187.27,20,10,0,0,134.83,0,0,134.83,134.83,163.14,163.14,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'723ESOL','\0',NULL,195,'\0','55a0e6228ea74dd83d1849deb373b581',''),
(196,4,6,15,4,'PROD054','PRODUCTO PRUEBA PROD054',21,'PSO','\0',0,0,204.89,20,10,0,0,147.52,0,0,147.52,147.52,178.5,178.5,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'333SOL','\0',NULL,196,'\0','0e70e43ca98a466b40c1dc8d5d483f51',''),
(197,4,6,15,4,'PROD055','PRODUCTO PRUEBA PROD055',21,'PSO','\0',0,0,264.38,20,10,0,0,190.35,0,0,190.35,190.35,230.32,230.32,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'344SOL','\0',NULL,197,'\0','7a21001a9e73923dfbb68f177bf21a5d',''),
(198,4,6,16,4,'PROD056','PRODUCTO PRUEBA PROD056',21,'PSO','\0',0,0,487.79,20,10,0,0,351.21,0,0,351.21,351.21,424.96,424.96,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'230SOL','\0',NULL,198,'\0','14ab5b0e0d3bd83d40a21aa6d4410da7',''),
(199,4,6,16,4,'PROD057','PRODUCTO PRUEBA PROD057',21,'PSO','\0',0,0,529.65,20,10,0,0,381.35,0,0,381.35,381.35,461.43,461.43,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'214SOL','\0',NULL,199,'\0','7b2bd090bd5f16b05bb4a5f42ca6bac4',''),
(200,4,6,16,4,'PROD058','PRODUCTO PRUEBA PROD058',21,'PSO','\0',0,0,577.68,20,10,0,0,415.93,0,0,415.93,415.93,503.28,503.28,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'216SOL','\0',NULL,200,'\0','9043b53f6081003e7585341fcd928e25',''),
(201,4,6,17,4,'PROD059','PRODUCTO PRUEBA PROD059',21,'PSO','\0',0,0,321.66,20,10,0,0,231.6,0,0,231.6,231.6,280.24,280.24,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'215SOL','\0',NULL,201,'\0','1023656a0b4a7c00604c151766a37aa2',''),
(202,4,6,17,4,'PROD060','PRODUCTO PRUEBA PROD060',21,'PSO','\0',0,0,800.64,20,10,0,0,576.46,0,0,576.46,576.46,697.52,697.52,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'222SOL','\0',NULL,202,'\0','2913fde9566412bb3d135eced4bb8e8f',''),
(203,4,6,17,4,'PROD061','PRODUCTO PRUEBA PROD061',21,'PSO','\0',0,0,91.64,20,10,0,0,65.98,0,0,65.98,65.98,79.84,79.84,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'159SOL','\0',NULL,203,'\0','a4683092af55f0454212286797974b0a',''),
(204,4,6,17,4,'PROD062','PRODUCTO PRUEBA PROD062',21,'PSO','\0',0,0,96.49,20,10,0,0,69.47,0,0,69.47,69.47,84.06,84.06,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'159ESOL','\0',NULL,204,'\0','e172ddcbdc7e880a9415f7c1be5f42d6',''),
(205,4,6,17,4,'PROD063','PRODUCTO PRUEBA PROD063',21,'PSO','\0',0,0,169.66,20,10,0,0,122.16,0,0,122.16,122.16,147.81,147.81,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'165SOL','\0',NULL,205,'\0','8205474a2ed662ad7f6869ceb901561a',''),
(206,4,6,17,4,'PROD064','PRODUCTO PRUEBA PROD064',21,'PSO','\0',0,0,188.81,20,10,0,0,135.94,0,0,135.94,135.94,164.49,164.49,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'165ESOL','\0',NULL,206,'\0','a083c15bcad3843cf2d70db3a1b9e33b',''),
(207,4,6,18,4,'PROD065','PRODUCTO PRUEBA PROD065',21,'PSO','\0',0,0,50,20,10,0,0,36,0,0,36,36,43.56,43.56,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'DG01SOL','\0',NULL,207,'\0','bd8466a38edbb508ba574675a19c9065',''),
(208,4,6,18,4,'PROD066','PRODUCTO PRUEBA PROD066',21,'PSO','\0',0,0,45,20,10,0,0,32.4,0,0,32.4,32.4,39.2,39.2,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'DG02SOL','\0',NULL,208,'\0','f1a52187b6cef19b915b5f9b975522fa',''),
(209,4,6,18,4,'PROD067','PRODUCTO PRUEBA PROD067',21,'PSO','\0',0,0,63,20,10,0,0,45.36,0,0,45.36,45.36,54.89,54.89,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'DG03SOL','\0',NULL,209,'\0','ea8428ddf083c768543db65d9713bac1',''),
(210,4,6,18,4,'PROD068','PRODUCTO PRUEBA PROD068',21,'PSO','\0',0,0,21,20,10,0,0,15.12,0,0,15.12,15.12,18.3,18.3,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'DG04SOL','\0',NULL,210,'\0','a16f4d2def97220f886c86ce6af4fbf4',''),
(211,4,6,18,4,'PROD069','PRODUCTO PRUEBA PROD069',21,'PSO','\0',0,0,42,20,10,0,0,30.24,0,0,30.24,30.24,36.59,36.59,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'DG05SOL','\0',NULL,211,'\0','79068f54d1db811cbe35fa5205af80f8',''),
(212,4,6,18,4,'PROD070','PRODUCTO PRUEBA PROD070',21,'PSO','\0',0,0,24,20,10,0,0,17.28,0,0,17.28,17.28,20.91,20.91,'\0',0.00,0.00,0.00,'','',NULL,'SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'DG06SOL','\0',NULL,212,'\0','0bba2e6ee6bf1508d3a90fadc9bbd9c0',''),
(213,1,1,1,1,'RZL115-226','BANDA INTERMEDIA',21,'PSO','\0',0,0,26777,0,0,0,0,26777,0,0,26777,26777,32400.2,32400.2,'\0',0.00,0.00,0.00,'','','','SUPER','2023-02-09 18:56:25','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'RZ-115-226','\0',NULL,213,'\0','0abdc5df1150f162777984e88895fd98','');
/*!40000 ALTER TABLE `articulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bancos`
--

DROP TABLE IF EXISTS `bancos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bancos` (
  `idBanco` int(11) NOT NULL,
  `idPlanCta` int(11) DEFAULT NULL,
  `codBco` varchar(5) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `nroCuit` varchar(20) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idBanco`),
  UNIQUE KEY `idBanco` (`idBanco`),
  KEY `fk_bancos_planctas1_idx` (`idPlanCta`),
  CONSTRAINT `fk_bancos_planctas1` FOREIGN KEY (`idPlanCta`) REFERENCES `planctas` (`idPlanCta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bancos`
--

LOCK TABLES `bancos` WRITE;
/*!40000 ALTER TABLE `bancos` DISABLE KEYS */;
INSERT INTO `bancos` VALUES
(1,NULL,'001','DEUTSCHE BANK','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,NULL,'003','B.E.A.L.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3,NULL,'005','A.B.N. AMRO BANK N.V.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4,NULL,'006','SUDAMERIS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,NULL,'007','DE GALICIA Y BS.AS.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(6,NULL,'010','LLOYDS BANK','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7,NULL,'011','DE LA NACION ARGENTINA','20123355645','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8,NULL,'012','DE CREDITO ARGENTINO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9,NULL,'013','POPULAR ARGENTINO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(10,NULL,'014','PROVINCIA BUENOS AIRES','12345551237','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(11,NULL,'015','STANDARD BANK','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(12,NULL,'016','CITIBANK N.A.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(13,129,'017','FRANCES','20123451784','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo','SUPER','2020-08-06 00:00:00','SERVER # mgcarburacion',NULL,NULL,NULL),
(14,NULL,'018','OF TOKYO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(15,NULL,'020','PROVINCIA DE CORDOBA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(16,129,'025','SANTANDER','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo','SUPER','2020-08-06 00:00:00','SERVER # mgcarburacion',NULL,NULL,NULL),
(17,NULL,'027','SUPERVIELLE','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(18,NULL,'029','DE LA CIUDAD DE BS.AS.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(19,NULL,'030','BANCO CENTRAL DE LA REP. ARGEN','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20,129,'034','PATAGONIA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo','SUPER','2020-08-06 00:00:00','SERVER # mgcarburacion',NULL,NULL,NULL),
(21,NULL,'039','CAJA DE AHORRO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(22,NULL,'040','COOPERATIVO DE CASEROS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(23,NULL,'042','CHASE MANHATTAN BANK','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(24,NULL,'043','QUILMES','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(25,NULL,'044','HIPOTECARIO NACIONAL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(26,NULL,'045','DE SAN JUAN','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(27,NULL,'046','DO BRASIL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(28,NULL,'049','PROVINCIA DE JUJUY','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(29,NULL,'050','CREDIT LYONNAIS ARG.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(30,NULL,'054','COMERCIAL ISRAELITA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(31,NULL,'056','DE CREDITO PROVINCIAL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(32,NULL,'059','DE ENTRE RIOS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(33,NULL,'060','PROVINCIA DE TUCUMAN','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(34,NULL,'061','DE MENDOZA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(35,NULL,'062','ISRAELITA DE CORDOBA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(36,NULL,'065','MUNICIPAL DE ROSARIO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(37,NULL,'066','MUNICIPAL DE TUCUMAN','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(38,NULL,'067','BANSUD','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(39,NULL,'071','DE SANTA FE','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(40,NULL,'072','SANTANDER RIO','20123456085','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(41,NULL,'075','DE PREVISION SOCIAL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(42,NULL,'079','REGIONAL DE CUYO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(43,NULL,'081','SOCIAL DE CORDOBA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(44,NULL,'083','PROVINCIA DEL CHUBUT','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(45,NULL,'084','PROVINCIA DE RIO NEGRO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(46,NULL,'085','PROVINCIA DE SAN LUIS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(47,NULL,'086','PROVINCIA DE SANTA CRUZ','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(48,NULL,'087','PROVINCIA DE STGO.ESTERO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(49,NULL,'089','PROVINCIAL DE SALTA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(50,NULL,'092','DE CATAMARCA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(51,NULL,'093','DE LA PAMPA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(52,NULL,'094','DE CORRIENTES','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(53,NULL,'095','PROVINCIA DE FORMOSA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(54,NULL,'097','PROVINCIA DEL NEUQUEN','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(55,NULL,'098','PROVINCIA DE MISIONES','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(56,NULL,'100','MUNICIPAL DE PARANA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(57,NULL,'105','COMERCIAL DEL TANDIL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(58,NULL,'107','COMERCIAL DE TRES ARROYOS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(59,NULL,'110','CNEL.DORREGO Y T.LAUQUEN','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(60,NULL,'112','DE JUNIN','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(61,NULL,'113','EDIFICADORA DE OLAVARRIA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(62,NULL,'115','DE OLAVARRIA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(63,NULL,'128','NUEVO BANCO DE AZUL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(64,NULL,'130','POPULAR FINANCIERO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(65,NULL,'133','CREDITO DE CUYO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(66,NULL,'135','UNION COMERCIAL E INDUST.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(67,NULL,'137','EMPRESARIO DE TUCUMAN','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(68,NULL,'140','FEDERAL ARGENTINO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(69,NULL,'141','SANTAFESINO DE INV.Y DES.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(70,NULL,'147','INTERFINANZAS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(71,NULL,'148','MUNICIPAL DE LA PLATA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(72,NULL,'149','COFIRENE BANCO DE INVERS.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(73,NULL,'150','HSBC','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(74,NULL,'153','GENERAL DE NEGOCIOS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(75,NULL,'156','BICA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(76,NULL,'161','PLATENSE','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(77,NULL,'162','MAYO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(78,NULL,'165','MORGAN GUARANTY TRUST CO.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(79,NULL,'167','REAL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(80,NULL,'172','COOP. NICOLAS LEVALLE','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(81,NULL,'175','SUDECOR LITORAL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(82,NULL,'178','DE BALCARCE','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(83,NULL,'179','ALMAFUERTE','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(84,NULL,'191','CREDICOOP','20123456883','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(85,NULL,'198','DE VALORES','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(86,NULL,'206','INTEGRADO DEPARTAMENTAL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(87,NULL,'229','DEL BUEN AYRE','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(88,NULL,'231','DE RIO TERCERO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(89,NULL,'235','COOPESUR','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(90,NULL,'236','DO ESTADO DE SAO PAULO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(91,NULL,'247','ROELA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(92,NULL,'249','PATRICIOS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(93,NULL,'253','OF NEW YORK','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(94,NULL,'254','MARIVA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(95,NULL,'255','DEL SUQUIA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(96,NULL,'256','CITICORP','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(97,NULL,'259','ITAU','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(98,NULL,'260','EXTERIOR','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(99,NULL,'262','NAT.TRUST AND SAVINGS AS.','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(100,NULL,'263','CHEMICAL BANK','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(101,NULL,'265','NAZIONALE DEL LAVORO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(102,NULL,'266','NATIONALE DE PARIS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(103,NULL,'267','REP. NAT. OF NEW YORK','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(104,NULL,'268','PROV. DE TIERRA DEL FUEGO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(105,NULL,'269','REP. ORIENTAL DEL URUGUAY','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(106,NULL,'271','VELOX','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(107,NULL,'273','LOS TILOS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(108,NULL,'275','REPUBLICA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(109,NULL,'277','SAENZ','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(110,NULL,'280','FLORENCIA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(111,NULL,'281','LINIERS SUDAMERICANO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(112,NULL,'284','BAIRES','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(113,NULL,'285','MACRO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(114,NULL,'286','MILDESA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(115,NULL,'287','MEDEFIN','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(116,NULL,'288','UNB','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(117,NULL,'290','CAUDAL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(118,NULL,'291','DEL FUERTE','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(119,NULL,'293','MERCURIO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(120,NULL,'294','INTERN. NEDERLANDER','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(121,NULL,'295','AMERICAN EXPRESS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(122,NULL,'297','BANEX','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(123,NULL,'298','AUSTRAL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(124,NULL,'299','COMAFI','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(125,NULL,'300','DE INV. Y COM. EXTERIOR','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(126,NULL,'301','PIANO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(127,NULL,'303','FINANSUR','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(128,NULL,'304','DE LA CUENCA DEL PLATA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(129,NULL,'305','JULIO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(130,NULL,'306','PRIVADO DE INVERSIONES','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(131,NULL,'307','MAYORISTA DEL PLATA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(132,NULL,'308','TRANSANDINO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(133,NULL,'309','NUEVO BANCO DE LA RIOJA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(134,NULL,'310','DEL SOL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(135,NULL,'311','NUEVO BANCO DEL CHACO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(136,NULL,'312','M.B.A. BCO.DE INVERSIONES','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(137,NULL,'313','ARGENCOOP','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(138,NULL,'314','BISEL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(139,NULL,'315','BANCO DE FORMOSA SA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(140,NULL,'319','BANCO CMF S.A','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(141,NULL,'321','BCO. SANTIAGO DEL ESTERO','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(142,NULL,'322','BANCO INDUSTRIAL DE AZUL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(143,NULL,'330','BANCO DE SANTA FE','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(144,NULL,'341','MASVENTAS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(145,NULL,'386','BCO. DE LA PCIA. DE SANTA CRUZ','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(146,NULL,'387','NUEVO BANCO SUQUIA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(147,NULL,'388','BANCO BISEL','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(148,NULL,'389','BANCO COLUMBIA','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(149,NULL,'REM','REMESAS','20123456789','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(150,129,'00002','GALICIA','30500001735','SUPER','2015-07-20 16:14:36','FACTURACION # Facturación','SUPER','2017-08-14 00:00:00','SERVER # mgcarburacion',NULL,NULL,''),
(151,129,'00390','ICBC','30709447846','SUPER','2017-08-14 09:28:15','SERVER # mgcarburacion','SUPER','2017-08-14 00:00:00','SERVER # mgcarburacion',NULL,NULL,'');
/*!40000 ALTER TABLE `bancos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_cli`
--

DROP TABLE IF EXISTS `cc_cli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_cli` (
  `idCC_Cli` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idCC_Orig` int(11) DEFAULT NULL,
  `idVentasC` int(11) DEFAULT NULL,
  `cbte` varchar(3) NOT NULL,
  `tipoDoc` varchar(1) NOT NULL,
  `ptoVta` int(11) NOT NULL,
  `nroCbte` int(11) NOT NULL,
  `fecEmis` datetime NOT NULL,
  `fecVto` datetime DEFAULT NULL,
  `impDebe` double NOT NULL,
  `impHaber` double NOT NULL,
  `idOper` int(11) NOT NULL,
  `observ` varchar(100) DEFAULT NULL,
  `idCondPago` int(11) DEFAULT NULL,
  `idSitIVA` int(11) DEFAULT NULL,
  `idVendedor` int(11) NOT NULL DEFAULT 1,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idCC_Cli`),
  UNIQUE KEY `idCC_Cli` (`idCC_Cli`),
  KEY `idCliente` (`idCliente`),
  KEY `idVentasC` (`idVentasC`),
  KEY `idCondPago` (`idCondPago`),
  KEY `idSitIVA` (`idSitIVA`),
  KEY `fk_cc_cli_Vendedores1` (`idVendedor`),
  KEY `idOper` (`idOper`),
  CONSTRAINT `cc_cli_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `cc_cli_ibfk_3` FOREIGN KEY (`idVentasC`) REFERENCES `ventascab` (`idVentasC`),
  CONSTRAINT `cc_cli_ibfk_4` FOREIGN KEY (`idCondPago`) REFERENCES `condpagos` (`idCondPago`),
  CONSTRAINT `cc_cli_ibfk_5` FOREIGN KEY (`idSitIVA`) REFERENCES `sitiva` (`idSitIVA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_cli`
--

LOCK TABLES `cc_cli` WRITE;
/*!40000 ALTER TABLE `cc_cli` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_cli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_prov`
--

DROP TABLE IF EXISTS `cc_prov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_prov` (
  `idCC_Prov` int(11) NOT NULL,
  `idCompraC` int(11) DEFAULT NULL,
  `idProv` int(11) NOT NULL,
  `idOper` int(11) NOT NULL,
  `idSitIVA` int(11) NOT NULL,
  `idCondPago` int(11) NOT NULL,
  `cbte` varchar(3) NOT NULL,
  `tipoDoc` varchar(1) NOT NULL,
  `ptoVta` int(11) NOT NULL,
  `nroCbte` int(11) NOT NULL,
  `fecEmis` datetime NOT NULL,
  `fecVto` datetime NOT NULL,
  `impDebe` double DEFAULT NULL,
  `impHaber` double DEFAULT NULL,
  `observ` varchar(255) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idCC_Prov`),
  UNIQUE KEY `idCC_Prov` (`idCC_Prov`),
  KEY `idCompraC` (`idCompraC`),
  KEY `idProv` (`idProv`),
  KEY `idSitIVA` (`idSitIVA`),
  KEY `idCondPago` (`idCondPago`),
  CONSTRAINT `cc_prov_ibfk_1` FOREIGN KEY (`idCompraC`) REFERENCES `comprascab` (`idCompraC`),
  CONSTRAINT `cc_prov_ibfk_2` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`),
  CONSTRAINT `cc_prov_ibfk_3` FOREIGN KEY (`idSitIVA`) REFERENCES `sitiva` (`idSitIVA`),
  CONSTRAINT `cc_prov_ibfk_4` FOREIGN KEY (`idCondPago`) REFERENCES `condpagos` (`idCondPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_prov`
--

LOCK TABLES `cc_prov` WRITE;
/*!40000 ALTER TABLE `cc_prov` DISABLE KEYS */;
INSERT INTO `cc_prov` VALUES
(1,1,2,1,1,1,'FC','A',1,1,'2022-10-05 00:00:00','2022-10-05 00:00:00',60500,0,'','SUPER','2022-10-05 10:27:12','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,1,2,1,1,1,'OP','',0,1,'2022-10-05 10:28:24','2022-10-05 10:28:24',0,60500,'','SUPER','2022-10-05 10:28:24','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(3,2,1,2,1,1,'FC','A',1,212121,'2023-02-09 00:00:00','2023-02-09 00:00:00',12100,0,'','SUPER','2023-02-09 19:12:16','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(4,2,1,2,1,1,'OP','',0,2,'2023-02-09 19:15:35','2023-02-09 19:15:35',0,10000,'','SUPER','2023-02-09 19:15:35','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(5,3,3,3,1,2,'FC','A',1,1000,'2023-08-09 00:00:00','2023-08-30 00:00:00',12100,0,'','SUPER','2023-08-09 19:18:05','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(6,3,3,3,1,2,'OP','',0,3,'2023-08-09 19:18:48','2023-08-09 19:18:48',0,12100,'','SUPER','2023-08-09 19:18:48','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(7,4,2,4,1,2,'FC','A',1,10001,'2023-08-09 00:00:00','2023-08-30 00:00:00',12100,0,'','SUPER','2023-08-09 19:24:55','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8,4,2,4,1,2,'OP','',0,4,'2023-08-09 19:25:26','2023-08-09 19:25:26',0,5000,'','SUPER','2023-08-09 19:25:26','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(9,4,2,4,1,2,'OP','',0,5,'2023-08-09 19:32:25','2023-08-09 19:32:25',0,5445,'','SUPER','2023-08-09 19:32:25','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(10,4,2,4,1,2,'OP','',0,6,'2023-08-10 15:51:29','2023-08-10 15:51:29',0,1655,'','SUPER','2023-08-10 15:51:29','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(11,5,2,5,1,2,'FC','A',2,1,'2023-08-10 00:00:00','2023-08-31 00:00:00',6050,0,'','SUPER','2023-08-10 16:10:41','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(12,6,2,6,1,3,'FC','A',2,2,'2023-08-10 00:00:00','2023-09-09 00:00:00',14520,0,'','SUPER','2023-08-10 16:11:13','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(13,5,2,5,1,2,'OP','',0,7,'2023-08-10 16:12:11','2023-08-10 16:12:11',0,1000,'','SUPER','2023-08-10 16:12:11','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(14,5,2,5,1,2,'OP','',0,8,'2023-08-10 16:26:58','2023-08-10 16:26:58',0,2000,'','SUPER','2023-08-10 16:26:58','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(15,5,2,5,1,2,'OP','',0,9,'2023-08-10 16:28:28','2023-08-10 16:28:28',0,3050,'','SUPER','2023-08-10 16:28:28','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(16,6,2,6,1,3,'OP','',0,10,'2023-08-10 16:34:17','2023-08-10 16:34:17',0,14520,'','SUPER','2023-08-10 16:34:17','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(17,7,2,7,1,2,'FC','A',2,3,'2023-08-10 00:00:00','2023-08-31 00:00:00',24200,0,'','SUPER','2023-08-10 16:47:20','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(18,7,2,7,1,2,'OP','',0,11,'2023-08-10 16:50:32','2023-08-10 16:50:32',0,24200,'','SUPER','2023-08-10 16:50:32','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(19,8,2,8,1,2,'FC','A',2,10,'2023-08-11 00:00:00','2023-09-01 00:00:00',24700,0,'','SUPER','2023-08-11 17:48:17','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20,8,2,8,1,2,'OP','',0,12,'2023-08-11 17:49:42','2023-08-11 17:49:42',0,24700,'','SUPER','2023-08-11 17:49:42','SUPER',NULL,NULL,NULL,NULL,NULL,NULL),
(21,9,5,9,1,2,'FC','A',10,1,'2024-07-22 00:00:00','2024-07-22 00:00:00',24200,0,'','SUPER','2024-07-22 07:50:23','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `cc_prov` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chequeras`
--

DROP TABLE IF EXISTS `chequeras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chequeras` (
  `idChequera` int(11) NOT NULL,
  `idBanco` int(11) NOT NULL,
  `numDesde` int(11) NOT NULL,
  `numHasta` int(11) NOT NULL,
  `numActual` int(11) NOT NULL,
  `habilitado` bit(1) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idChequera`),
  UNIQUE KEY `idChequera` (`idChequera`),
  KEY `idBanco` (`idBanco`),
  CONSTRAINT `chequeras_ibfk_1` FOREIGN KEY (`idBanco`) REFERENCES `bancos` (`idBanco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chequeras`
--

LOCK TABLES `chequeras` WRITE;
/*!40000 ALTER TABLE `chequeras` DISABLE KEYS */;
INSERT INTO `chequeras` VALUES
(1,20,22040244,22040250,1,'','SUPER','2020-09-23 11:01:42','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,NULL),
(2,16,1,99999,7,'','SUPER','2023-08-10 15:50:23','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `chequeras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cheques`
--

DROP TABLE IF EXISTS `cheques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cheques` (
  `idCheque` int(11) NOT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `idBanco` int(11) NOT NULL,
  `tipo` varchar(1) NOT NULL,
  `sucursal` varchar(60) NOT NULL,
  `chq_nro` varchar(20) DEFAULT NULL,
  `fecEmis` datetime NOT NULL,
  `fecVto` datetime NOT NULL,
  `importe` double NOT NULL,
  `estado` varchar(1) NOT NULL,
  `tipoDoc` varchar(5) DEFAULT NULL,
  `nroCUIT` varchar(20) DEFAULT NULL,
  `titular` varchar(60) DEFAULT NULL,
  `NroRec` varchar(13) NOT NULL DEFAULT '',
  `anulado` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`idCheque`),
  UNIQUE KEY `idCheque` (`idCheque`),
  KEY `idCliente` (`idCliente`),
  KEY `idBanco` (`idBanco`),
  CONSTRAINT `cheques_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `cheques_ibfk_2` FOREIGN KEY (`idBanco`) REFERENCES `bancos` (`idBanco`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cheques`
--

LOCK TABLES `cheques` WRITE;
/*!40000 ALTER TABLE `cheques` DISABLE KEYS */;
INSERT INTO `cheques` VALUES
(1,2,10,'T','','00001000','2023-02-09 00:00:00','2023-02-15 00:00:00',500,'R','CUIT','20280456919','LEONARDO D.  ZULLI','0001-00000015','\0'),
(2,2,10,'T','','00000001','2023-08-09 00:00:00','2023-08-15 00:00:00',5445,'U','CUIT','20280456919','LEONARDO D. ZULLI','0001-00000018','\0'),
(3,2,10,'T','','00010000','2023-08-10 00:00:00','2023-09-10 00:00:00',4605.99,'U','CUIT','20280456919','LEONARDO DIEGO ZULLI','0001-00000019','\0');
/*!40000 ALTER TABLE `cheques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chequesp`
--

DROP TABLE IF EXISTS `chequesp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chequesp` (
  `idChequeP` int(11) NOT NULL,
  `idChequera` int(11) NOT NULL,
  `idBanco` int(11) NOT NULL,
  `idProv` int(11) DEFAULT NULL,
  `idOrdPagC` int(11) DEFAULT NULL,
  `nroCheque` int(11) DEFAULT NULL,
  `fecEmis` datetime NOT NULL,
  `fecVto` datetime NOT NULL,
  `importe` float NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idChequeP`),
  UNIQUE KEY `idChequeP` (`idChequeP`),
  KEY `idChequera` (`idChequera`),
  KEY `idBanco` (`idBanco`),
  KEY `idProv` (`idProv`),
  KEY `idOrdPagC` (`idOrdPagC`),
  CONSTRAINT `chequesp_ibfk_1` FOREIGN KEY (`idChequera`) REFERENCES `chequeras` (`idChequera`),
  CONSTRAINT `chequesp_ibfk_2` FOREIGN KEY (`idBanco`) REFERENCES `bancos` (`idBanco`),
  CONSTRAINT `chequesp_ibfk_3` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`),
  CONSTRAINT `chequesp_ibfk_4` FOREIGN KEY (`idOrdPagC`) REFERENCES `ordpag_c` (`idOrdPagC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chequesp`
--

LOCK TABLES `chequesp` WRITE;
/*!40000 ALTER TABLE `chequesp` DISABLE KEYS */;
INSERT INTO `chequesp` VALUES
(1,2,16,2,6,1,'2023-08-10 00:00:00','2023-09-10 00:00:00',1655,'SUPER','2023-08-10 15:51:29','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,2,16,2,7,2,'2023-08-10 00:00:00','2023-08-10 00:00:00',1000,'SUPER','2023-08-10 16:12:11','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3,2,16,2,8,3,'2023-08-10 00:00:00','2023-09-10 00:00:00',2000,'SUPER','2023-08-10 16:26:58','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4,2,16,2,9,4,'2023-08-10 00:00:00','2023-09-10 00:00:00',2000,'SUPER','2023-08-10 16:28:28','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,2,16,2,9,4,'2023-08-10 00:00:00','2023-09-20 00:00:00',1050,'SUPER','2023-08-10 16:28:28','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(6,2,16,2,11,5,'2023-08-10 00:00:00','2023-09-10 00:00:00',10000,'SUPER','2023-08-10 16:50:32','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7,2,16,2,12,6,'2023-08-11 00:00:00','2023-09-11 00:00:00',5000,'SUPER','2023-08-11 17:49:42','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `chequesp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citi_alicuotas`
--

DROP TABLE IF EXISTS `citi_alicuotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citi_alicuotas` (
  `codAlicuota` varchar(4) NOT NULL,
  `alicuota` double NOT NULL,
  PRIMARY KEY (`codAlicuota`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citi_alicuotas`
--

LOCK TABLES `citi_alicuotas` WRITE;
/*!40000 ALTER TABLE `citi_alicuotas` DISABLE KEYS */;
INSERT INTO `citi_alicuotas` VALUES
('0003',0),
('0004',10.5),
('0005',21),
('0006',27),
('0008',5),
('0009',2.5);
/*!40000 ALTER TABLE `citi_alicuotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citicpa_alic`
--

DROP TABLE IF EXISTS `citicpa_alic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citicpa_alic` (
  `idCitiCpaAlic` int(11) NOT NULL AUTO_INCREMENT,
  `idCompraC` int(11) NOT NULL,
  `tipoCbte` varchar(3) NOT NULL,
  `ptoVta` varchar(5) NOT NULL,
  `nroCbte` varchar(20) NOT NULL,
  `codDocVdor` varchar(2) NOT NULL,
  `cuitPV` varchar(20) NOT NULL,
  `impNetoGrav` double NOT NULL,
  `alicIVA` varchar(4) NOT NULL,
  `impLiq` double NOT NULL,
  PRIMARY KEY (`idCitiCpaAlic`),
  UNIQUE KEY `idCitiCpaAlic` (`idCitiCpaAlic`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citicpa_alic`
--

LOCK TABLES `citicpa_alic` WRITE;
/*!40000 ALTER TABLE `citicpa_alic` DISABLE KEYS */;
INSERT INTO `citicpa_alic` VALUES
(1,252,'001','00002','00000000000000000224','80','00000000000000000001',6305.52,'0005',1324.16),
(2,227,'001','00002','00000000000000014789','80','00000000020184903351',33290.92,'0005',6991.09),
(3,228,'001','00002','00000000000000014790','80','00000000020184903351',4944.56,'0005',1038.36),
(4,266,'001','00002','00000000000000014842','80','00000000020184903351',9359.13,'0005',1965.42),
(5,234,'002','00003','00000000000000000066','80','00000000001111111111',410.18,'0005',86.14),
(6,225,'001','00003','00000000000000000469','80','00000000001111111111',8203.5,'0005',1722.74),
(7,222,'001','00003','00000000000000014511','80','00000000003068283582',11954.98,'0005',2510.55),
(8,230,'001','00003','00000000000000043189','80','00000000030708972335',171.86,'0005',36.09),
(9,229,'001','00003','00000000000000043219','80','00000000030708972335',2638.28,'0005',554.04),
(10,235,'001','00003','00000000000000043263','80','00000000030708972335',2508.76,'0005',526.84),
(11,192,'001','00003','00000000000000043449','80','00000000030708972335',1577.25,'0005',331.22),
(12,188,'001','00003','00000000000000189096','80','00000000033709450129',3047.04,'0005',639.88),
(13,198,'001','00003','00000000000000189142','80','00000000033709450129',3834.37,'0005',805.22),
(14,197,'001','00003','00000000000000189145','80','00000000033709450129',7360.45,'0005',1545.69),
(15,214,'001','00003','00000000000000189306','80','00000000033709450129',7165.99,'0005',1504.86),
(16,215,'001','00003','00000000000000189361','80','00000000033709450129',1135.86,'0004',119.27),
(17,215,'001','00003','00000000000000189361','80','00000000033709450129',5185.43,'0005',1088.94),
(18,217,'001','00003','00000000000000189472','80','00000000033709450129',22314.63,'0005',4686.07),
(19,216,'001','00003','00000000000000189523','80','00000000033709450129',2383.85,'0004',250.3),
(20,200,'001','00003','00000000000000189608','80','00000000033709450129',8710.72,'0005',1829.25),
(21,199,'001','00003','00000000000000189644','80','00000000033709450129',1339.92,'0004',140.69),
(22,199,'001','00003','00000000000000189644','80','00000000033709450129',7463.36,'0005',1567.31),
(23,201,'001','00003','00000000000000189739','80','00000000033709450129',1729.46,'0004',181.59),
(24,201,'001','00003','00000000000000189739','80','00000000033709450129',23001.01,'0005',4830.21),
(25,202,'001','00003','00000000000000189783','80','00000000033709450129',27500,'0005',5775),
(26,203,'001','00003','00000000000000189913','80','00000000033709450129',2692.21,'0004',282.68),
(27,203,'001','00003','00000000000000189913','80','00000000033709450129',9398.78,'0005',1973.74),
(28,205,'001','00003','00000000000000190029','80','00000000033709450129',1458.86,'0005',306.36),
(29,207,'001','00003','00000000000000190036','80','00000000033709450129',3089.33,'0005',648.76),
(30,206,'001','00003','00000000000000190070','80','00000000033709450129',691.4,'0004',72.6),
(31,206,'001','00003','00000000000000190070','80','00000000033709450129',966.32,'0005',202.93),
(32,208,'001','00003','00000000000000190270','80','00000000033709450129',7901.6,'0004',829.67),
(33,208,'001','00003','00000000000000190270','80','00000000033709450129',19703.43,'0005',4137.72),
(34,209,'001','00003','00000000000000190276','80','00000000033709450129',1780.26,'0005',373.85),
(35,210,'001','00003','00000000000000190369','80','00000000033709450129',7440.16,'0005',1562.43),
(36,211,'001','00003','00000000000000190370','80','00000000033709450129',3560.66,'0004',373.87),
(37,212,'001','00003','00000000000000190489','80','00000000033709450129',4457.87,'0005',936.15),
(38,190,'001','00003','00000000000000190585','80','00000000033709450129',3692.68,'0005',775.46),
(39,240,'001','00003','00000000000000190659','80','00000000033709450129',8731.12,'0005',1833.54),
(40,245,'001','00003','00000000000000190754','80','00000000033709450129',3562.99,'0005',748.23),
(41,242,'001','00003','00000000000000190784','80','00000000033709450129',335.52,'0005',70.46),
(42,257,'001','00003','00000000000000190877','80','00000000030708607459',3254.17,'0005',683.38),
(43,256,'001','00003','00000000000000190888','80','00000000030708607459',5230.77,'0005',1098.46),
(44,255,'001','00003','00000000000000190943','80','00000000030708607459',11906.93,'0005',2500.46),
(45,258,'001','00003','00000000000000190954','80','00000000030708607459',864.68,'0005',181.58),
(46,270,'001','00003','00000000000000191042','80','00000000030708607459',4188.8,'0005',879.65),
(47,281,'001','00003','00000000000000191097','80','00000000033709450129',206.19,'0005',43.3),
(48,226,'001','00003','00000000000000344272','80','00000000030535994923',42139.01,'0005',8849.19),
(49,251,'001','00004','00000000000000001049','80','00000000030697635773',10060.71,'0005',2112.75),
(50,232,'001','00004','00000000000000001831','80','00000000000000000001',32382.53,'0005',6800.33),
(51,233,'001','00004','00000000000000001832','80','00000000000000000001',3212.65,'0005',674.66),
(52,224,'001','00005','00000000000000009244','80','00000000030708607459',27007.2,'0005',5671.51),
(53,254,'001','00005','00000000000000009313','80','00000000030708607459',69719,'0005',14640.99),
(54,265,'001','00005','00000000000000009317','80','00000000033708765959',62868,'0005',13202.28),
(55,238,'001','00007','00000000000000063610','80','00000000030709771147',1640.05,'0003',0),
(56,177,'001','00010','00000000000000000427','80','00000000030709771147',9545.38,'0005',2004.53),
(57,176,'001','00010','00000000000000000432','80','00000000030709771147',6352.69,'0005',1334.06),
(58,223,'001','00010','00000000000000017012','80','00000000030708607459',79509,'0005',16696.89),
(59,221,'001','00010','00000000000000017059','80','00000000030708607459',40718.2,'0005',8550.82),
(60,219,'001','00010','00000000000000017080','80','00000000030708607459',14272.6,'0004',1498.62),
(61,220,'001','00010','00000000000000017081','80','00000000030708607459',110953.4,'0005',23300.21),
(62,195,'001','00010','00000000000000017135','80','00000000030708607459',92661,'0005',19458.81),
(63,204,'001','00010','00000000000000017146','80','00000000030708607459',79706.5,'0005',16738.37),
(64,213,'001','00010','00000000000000017147','80','00000000030708607459',58905.3,'0005',12370.11),
(65,244,'001','00010','00000000000000017164','80','00000000030708607459',174818.3,'0005',36711.84),
(66,243,'001','00010','00000000000000017165','80','00000000030708607459',8019,'0004',842),
(67,264,'001','00010','00000000000000017189','80','00000000030708607459',48096.6,'0005',10100.29),
(68,218,'001','00010','00000000000000083627','80','00000000030643786938',348.61,'0005',73.21),
(69,262,'003','00017','00000000000000002525','80','00000000030709771147',4600.6,'0005',966.13),
(70,263,'003','00017','00000000000000002526','80','00000000030709771147',470.47,'0005',98.8),
(71,182,'001','00018','00000000000000022871','80','00000000030709771147',3636.7,'0004',381.85),
(72,173,'001','00018','00000000000000022954','80','00000000020184903351',844.21,'0005',177.28),
(73,175,'001','00018','00000000000000022955','80','00000000030709771147',6767.67,'0005',1421.21),
(74,179,'001','00018','00000000000000023115','80','00000000030709771147',2363.39,'0005',496.31),
(75,174,'001','00018','00000000000000023116','80','00000000030709771147',8892.03,'0005',1867.33),
(76,178,'001','00018','00000000000000023128','80','00000000030709771147',17654.54,'0005',3707.45),
(77,186,'001','00018','00000000000000023203','80','00000000030709771147',15620.25,'0004',1640.13),
(78,186,'001','00018','00000000000000023203','80','00000000030709771147',18189,'0005',3819.69),
(79,181,'001','00018','00000000000000023370','80','00000000030709771147',6712,'0005',1409.52),
(80,180,'001','00018','00000000000000023371','80','00000000030709771147',33881.97,'0005',7115.21),
(81,185,'001','00018','00000000000000023455','80','00000000030709771147',1364.06,'0005',286.45),
(82,184,'001','00018','00000000000000023456','80','00000000030709771147',3508.39,'0005',736.76),
(83,239,'001','00018','00000000000000023497','80','00000000030709771147',769.68,'0005',161.63),
(84,236,'001','00018','00000000000000023593','80','00000000030709771147',1640.05,'0005',344.41),
(85,237,'001','00018','00000000000000023594','80','00000000030709771147',1308.71,'0005',274.83),
(86,250,'001','00018','00000000000000023614','80','00000000030709771147',76540.72,'0005',16073.55),
(87,271,'001','00018','00000000000000023794','80','00000000030709771147',1877.97,'0005',394.37),
(88,272,'001','00018','00000000000000023795','80','00000000030709771147',5024.36,'0005',1055.12),
(89,261,'001','00018','00000000000000023890','80','00000000030709771147',5145.64,'0005',1080.58),
(90,260,'001','00018','00000000000000023891','80','00000000030709771147',6662.63,'0005',1399.15),
(91,276,'001','00018','00000000000000023998','80','00000000030709771147',156.81,'0005',32.93),
(92,274,'001','00018','00000000000000024009','80','00000000030709771147',2223.93,'0005',467.03),
(93,280,'001','00018','00000000000000024152','80','00000000030709771147',3706.56,'0005',778.38),
(94,196,'001','00021','00000000000000064938','80','00000000030500728317',1614,'0005',338.94),
(95,189,'001','00022','00000000000000004848','80','000000033-71620259-9',72426.6,'0005',15209.59),
(96,187,'001','00022','00000000000000004858','80','000000033-71620259-9',72426.6,'0005',15209.59),
(97,283,'001','00032','00000000000000002915','80','00000000030701530264',247,'0005',51.87),
(98,149,'001','00101','00000000000000246118','80','00000000030708698152',638.24,'0004',67.02),
(99,149,'001','00101','00000000000000246118','80','00000000030708698152',19405.69,'0005',4075.19),
(100,150,'001','00101','00000000000000246119','80','00000000030708698152',6052.48,'0005',1271.02),
(101,165,'001','00101','00000000000000246507','80','00000000030708698152',110.64,'0004',11.62),
(102,165,'001','00101','00000000000000246507','80','00000000030708698152',5722.24,'0005',1201.67),
(103,267,'001','00101','00000000000000247066','80','00000000030708698152',7833.35,'0005',1645),
(104,169,'001','00102','00000000000000245244','80','00000000030708698152',2090.89,'0004',219.54),
(105,169,'001','00102','00000000000000245244','80','00000000030708698152',19136.58,'0005',4018.68),
(106,171,'001','00102','00000000000000245245','80','00000000030708698152',12696.95,'0005',2666.36),
(107,170,'001','00102','00000000000000245246','80','00000000030708698152',1883.32,'0005',395.5),
(108,148,'001','00102','00000000000000245412','80','00000000030708698152',1178.77,'0005',247.54),
(109,145,'001','00102','00000000000000245413','80','00000000030708698152',8622.74,'0005',1810.78),
(110,143,'001','00102','00000000000000245414','80','00000000030708698152',16562.77,'0005',3478.18),
(111,146,'001','00102','00000000000000245415','80','00000000030708698152',20458.76,'0005',4296.34),
(112,163,'001','00102','00000000000000245912','80','00000000030708698152',13722.27,'0005',2881.68),
(113,162,'001','00102','00000000000000245913','80','00000000030708698152',884.67,'0005',185.78),
(114,161,'001','00102','00000000000000245948','80','00000000030708698152',621.52,'0005',130.52),
(115,166,'001','00102','00000000000000246037','80','00000000030708698152',15645.18,'0005',3285.49),
(116,160,'001','00102','00000000000000246412','80','00000000030708698152',847.19,'0004',88.95),
(117,160,'001','00102','00000000000000246412','80','00000000030708698152',20410.09,'0005',4286.12),
(118,159,'001','00102','00000000000000246537','80','00000000030708698152',8101.38,'0005',1701.29),
(119,157,'001','00102','00000000000000246691','80','00000000030708698152',12286.55,'0005',2580.18),
(120,154,'001','00102','00000000000000246832','80','00000000030708698152',29610.89,'0005',6218.29),
(121,156,'001','00102','00000000000000246833','80','00000000030708698152',2808.99,'0005',589.89),
(122,152,'001','00102','00000000000000246925','80','00000000030708698152',23592.88,'0005',4954.5),
(123,153,'001','00102','00000000000000246929','80','00000000030708698152',1137.54,'0005',238.88),
(124,151,'001','00102','00000000000000247123','80','00000000030708698152',13129.46,'0005',2757.19),
(125,191,'001','00102','00000000000000247231','80','00000000030708698152',12372.06,'0005',2598.13),
(126,241,'001','00102','00000000000000247397','80','00000000030708698152',11792.73,'0005',2476.47),
(127,247,'001','00102','00000000000000247575','80','00000000030708698152',665.43,'0004',69.87),
(128,247,'001','00102','00000000000000247575','80','00000000030708698152',22885.28,'0005',4805.91),
(129,246,'001','00102','00000000000000247576','80','00000000030708698152',18055.74,'0005',3791.71),
(130,248,'001','00102','00000000000000247621','80','00000000030708698152',30627.77,'0005',6431.83),
(131,249,'001','00102','00000000000000247634','80','00000000030708698152',298.14,'0005',62.61),
(132,253,'001','00102','00000000000000247776','80','00000000030708698152',18503.55,'0005',3885.75),
(133,268,'001','00102','00000000000000248020','80','00000000030708698152',13442.89,'0005',2823.01),
(134,136,'001','00103','00000000000000251590','80','00000000030708698152',12688.08,'0005',2664.5),
(135,167,'001','00103','00000000000000251959','80','00000000030708698152',21400.78,'0005',4494.16),
(136,168,'001','00103','00000000000000251960','80','00000000030708698152',6534.57,'0005',1372.26),
(137,158,'001','00103','00000000000000252301','80','00000000030708698152',307.79,'0005',64.64),
(138,155,'001','00103','00000000000000252522','80','00000000030708698152',1371.62,'0005',288.04),
(139,259,'001','00103','00000000000000253289','80','00000000030708698152',30069.44,'0005',6314.58),
(140,269,'001','00103','00000000000000253323','80','00000000030708698152',453.64,'0005',95.26),
(141,172,'001','00104','00000000000000113346','80','00000000030708698152',1677.26,'0005',352.22),
(142,144,'001','00104','00000000000000113415','80','00000000030708698152',1037.5,'0005',217.88),
(143,142,'001','00104','00000000000000113432','80','00000000030708698152',6281.66,'0005',1319.15),
(144,147,'001','00104','00000000000000113434','80','00000000030708698152',1178.77,'0005',247.54),
(145,139,'001','00104','00000000000000113578','80','00000000030708698152',14525.21,'0005',3050.29),
(146,138,'001','00104','00000000000000113579','80','00000000030708698152',15139.24,'0005',3179.24),
(147,137,'001','00104','00000000000000113580','80','00000000030708698152',6481.16,'0005',1361.04),
(148,164,'001','00104','00000000000000113741','80','00000000030708698152',4593.78,'0005',964.69),
(149,141,'003','00200','00000000000000190578','80','00000000030708698152',2803.14,'0005',588.66),
(150,140,'003','00200','00000000000000190677','80','00000000030708698152',567.01,'0005',119.07),
(151,273,'003','00200','00000000000000192356','80','00000000030708698152',8632.82,'0005',1812.89),
(152,275,'003','00200','00000000000000192430','80','00000000030708698152',2494.82,'0005',523.91),
(153,193,'002','09032','00000000000000000665','80','00000000030691323958',43567.05,'0003',0),
(154,194,'001','09032','00000000000000018682','80','00000000030691323958',18786.96,'0005',3945.26);
/*!40000 ALTER TABLE `citicpa_alic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citicpa_cab`
--

DROP TABLE IF EXISTS `citicpa_cab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citicpa_cab` (
  `idCitiCpa` int(11) NOT NULL AUTO_INCREMENT,
  `idCompraC` int(11) NOT NULL,
  `fecEmis` varchar(8) NOT NULL,
  `tipoCbte` varchar(3) NOT NULL,
  `ptoVta` varchar(5) NOT NULL,
  `nroCbte` varchar(20) NOT NULL,
  `nroDespImp` varchar(16) NOT NULL,
  `codDoc` varchar(2) NOT NULL,
  `cuitPV` varchar(20) NOT NULL,
  `razSocPV` varchar(30) NOT NULL,
  `impTotOper` varchar(15) NOT NULL,
  `ImpConceptos` varchar(15) NOT NULL,
  `ioe` varchar(15) NOT NULL,
  `impPercValAg` varchar(15) NOT NULL,
  `impPercOIN` varchar(15) NOT NULL,
  `impPerIIBB` varchar(15) NOT NULL,
  `impPerImpMun` varchar(15) NOT NULL,
  `impImpInt` varchar(15) NOT NULL,
  `codMon` varchar(3) NOT NULL,
  `tipoCbio` varchar(10) NOT NULL,
  `cantAlicIVA` varchar(1) NOT NULL,
  `codOper` varchar(1) NOT NULL,
  `credFisComp` varchar(15) NOT NULL,
  `otrosTrib` varchar(15) NOT NULL,
  `cuitEmisCorr` varchar(11) NOT NULL,
  `denomEmisCorr` varchar(30) NOT NULL,
  `ivaCom` varchar(15) NOT NULL,
  `procesado` bit(1) NOT NULL DEFAULT b'0',
  `fecProceso` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idCitiCpa`),
  UNIQUE KEY `idCitiCpa` (`idCitiCpa`),
  KEY `citicpa_idCompraC` (`idCompraC`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citicpa_cab`
--

LOCK TABLES `citicpa_cab` WRITE;
/*!40000 ALTER TABLE `citicpa_cab` DISABLE KEYS */;
INSERT INTO `citicpa_cab` VALUES
(1,136,'20200706','001','00103','00000000000000251590','                ','80','00000000030708698152','DER S.A','000000001268808','000000000000000','000000000000000','000000000000000','000000000000000','000000000088814','000000000000000','000000000000000','PES','0001000000','1','0','000000000266450','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(2,137,'20200723','001','00104','00000000000000113580','                ','80','00000000030708698152','DER S.A','000000000648116','000000000000000','000000000000000','000000000000000','000000000000000','000000000045368','000000000000000','000000000000000','PES','0001000000','1','0','000000000136104','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(3,138,'20200723','001','00104','00000000000000113579','                ','80','00000000030708698152','DER S.A','000000001513924','000000000000000','000000000000000','000000000000000','000000000000000','000000000105975','000000000000000','000000000000000','PES','0001000000','1','0','000000000317924','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(4,139,'20200723','001','00104','00000000000000113578','                ','80','00000000030708698152','DER S.A','000000001452521','000000000000000','000000000000000','000000000000000','000000000000000','000000000101677','000000000000000','000000000000000','PES','0001000000','1','0','000000000305029','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(5,142,'20200723','001','00104','00000000000000113432','                ','80','00000000030708698152','DER S.A','000000000628166','000000000000000','000000000000000','000000000000000','000000000000000','000000000043972','000000000000000','000000000000000','PES','0001000000','1','0','000000000131915','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(6,143,'20200723','001','00102','00000000000000245414','                ','80','00000000030708698152','DER S.A','000000001656277','000000000000000','000000000000000','000000000000000','000000000000000','000000000115939','000000000000000','000000000000000','PES','0001000000','1','0','000000000347818','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(7,144,'20200723','001','00104','00000000000000113415','                ','80','00000000030708698152','DER S.A','000000000103750','000000000000000','000000000000000','000000000000000','000000000000000','000000000007262','000000000000000','000000000000000','PES','0001000000','1','0','000000000021788','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(8,145,'20200723','001','00102','00000000000000245413','                ','80','00000000030708698152','DER S.A','000000000862274','000000000000000','000000000000000','000000000000000','000000000000000','000000000060359','000000000000000','000000000000000','PES','0001000000','1','0','000000000181078','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(9,146,'20200723','001','00102','00000000000000245415','                ','80','00000000030708698152','DER S.A','000000002045876','000000000000000','000000000000000','000000000000000','000000000000000','000000000143241','000000000000000','000000000000000','PES','0001000000','1','0','000000000429634','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(10,147,'20200723','001','00104','00000000000000113434','                ','80','00000000030708698152','DER S.A','000000000117877','000000000000000','000000000000000','000000000000000','000000000000000','000000000008251','000000000000000','000000000000000','PES','0001000000','1','0','000000000024754','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(11,148,'20200723','001','00102','00000000000000245412','                ','80','00000000030708698152','DER S.A','000000000117877','000000000000000','000000000000000','000000000000000','000000000000000','000000000008251','000000000000000','000000000000000','PES','0001000000','1','0','000000000024754','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(12,149,'20200723','001','00101','00000000000000246118','                ','80','00000000030708698152','DER S.A','000000002004393','000000000000000','000000000000000','000000000000000','000000000000000','000000000140308','000000000000000','000000000000000','PES','0001000000','2','0','000000000414221','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(13,150,'20200723','001','00101','00000000000000246119','                ','80','00000000030708698152','DER S.A','000000000605248','000000000000000','000000000000000','000000000000000','000000000000000','000000000042367','000000000000000','000000000000000','PES','0001000000','1','0','000000000127102','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(14,151,'20200723','001','00102','00000000000000247123','                ','80','00000000030708698152','DER S.A','000000001312946','000000000000000','000000000000000','000000000000000','000000000000000','000000000091906','000000000000000','000000000000000','PES','0001000000','1','0','000000000275719','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(15,152,'20200723','001','00102','00000000000000246925','                ','80','00000000030708698152','DER S.A','000000002359288','000000000000000','000000000000000','000000000000000','000000000000000','000000000165151','000000000000000','000000000000000','PES','0001000000','1','0','000000000495450','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(16,153,'20200723','001','00102','00000000000000246929','                ','80','00000000030708698152','DER S.A','000000000113754','000000000000000','000000000000000','000000000000000','000000000000000','000000000007963','000000000000000','000000000000000','PES','0001000000','1','0','000000000023888','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(17,154,'20200723','001','00102','00000000000000246832','                ','80','00000000030708698152','DER S.A','000000002961089','000000000000000','000000000000000','000000000000000','000000000000000','000000000207277','000000000000000','000000000000000','PES','0001000000','1','0','000000000621829','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(18,155,'20200723','001','00103','00000000000000252522','                ','80','00000000030708698152','DER S.A','000000000137162','000000000000000','000000000000000','000000000000000','000000000000000','000000000009601','000000000000000','000000000000000','PES','0001000000','1','0','000000000028804','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(19,156,'20200723','001','00102','00000000000000246833','                ','80','00000000030708698152','DER S.A','000000000280899','000000000000000','000000000000000','000000000000000','000000000000000','000000000019663','000000000000000','000000000000000','PES','0001000000','1','0','000000000058989','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(20,157,'20200723','001','00102','00000000000000246691','                ','80','00000000030708698152','DER S.A','000000001228655','000000000000000','000000000000000','000000000000000','000000000000000','000000000086006','000000000000000','000000000000000','PES','0001000000','1','0','000000000258018','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(21,158,'20200723','001','00103','00000000000000252301','                ','80','00000000030708698152','DER S.A','000000000030779','000000000000000','000000000000000','000000000000000','000000000000000','000000000002154','000000000000000','000000000000000','PES','0001000000','1','0','000000000006464','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(22,159,'20200723','001','00102','00000000000000246537','                ','80','00000000030708698152','DER S.A','000000000810138','000000000000000','000000000000000','000000000000000','000000000000000','000000000056710','000000000000000','000000000000000','PES','0001000000','1','0','000000000170129','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(23,160,'20200723','001','00102','00000000000000246412','                ','80','00000000030708698152','DER S.A','000000002125728','000000000000000','000000000000000','000000000000000','000000000000000','000000000148801','000000000000000','000000000000000','PES','0001000000','2','0','000000000437507','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(24,161,'20200723','001','00102','00000000000000245948','                ','80','00000000030708698152','DER S.A','000000000062152','000000000000000','000000000000000','000000000000000','000000000000000','000000000004351','000000000000000','000000000000000','PES','0001000000','1','0','000000000013052','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(25,162,'20200723','001','00102','00000000000000245913','                ','80','00000000030708698152','DER S.A','000000000088467','000000000000000','000000000000000','000000000000000','000000000000000','000000000006193','000000000000000','000000000000000','PES','0001000000','1','0','000000000018578','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(26,163,'20200723','001','00102','00000000000000245912','                ','80','00000000030708698152','DER S.A','000000001372227','000000000000000','000000000000000','000000000000000','000000000000000','000000000096056','000000000000000','000000000000000','PES','0001000000','1','0','000000000288168','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(27,164,'20200723','001','00104','00000000000000113741','                ','80','00000000030708698152','DER S.A','000000000459378','000000000000000','000000000000000','000000000000000','000000000000000','000000000032156','000000000000000','000000000000000','PES','0001000000','1','0','000000000096469','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(28,165,'20200723','001','00101','00000000000000246507','                ','80','00000000030708698152','DER S.A','000000000583288','000000000000000','000000000000000','000000000000000','000000000000000','000000000040834','000000000000000','000000000000000','PES','0001000000','2','0','000000000121329','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(29,166,'20200723','001','00102','00000000000000246037','                ','80','00000000030708698152','DER S.A','000000001564518','000000000000000','000000000000000','000000000000000','000000000000000','000000000109517','000000000000000','000000000000000','PES','0001000000','1','0','000000000328549','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(30,167,'20200723','001','00103','00000000000000251959','                ','80','00000000030708698152','DER S.A','000000002140078','000000000000000','000000000000000','000000000000000','000000000000000','000000000149805','000000000000000','000000000000000','PES','0001000000','1','0','000000000449416','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(31,168,'20200723','001','00103','00000000000000251960','                ','80','00000000030708698152','DER S.A','000000000653457','000000000000000','000000000000000','000000000000000','000000000000000','000000000045742','000000000000000','000000000000000','PES','0001000000','1','0','000000000137226','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(32,169,'20200723','001','00102','00000000000000245244','                ','80','00000000030708698152','DER S.A','000000002122747','000000000000000','000000000000000','000000000000000','000000000000000','000000000148592','000000000000000','000000000000000','PES','0001000000','2','0','000000000423822','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(33,170,'20200723','001','00102','00000000000000245246','                ','80','00000000030708698152','DER S.A','000000000188332','000000000000000','000000000000000','000000000000000','000000000000000','000000000013183','000000000000000','000000000000000','PES','0001000000','1','0','000000000039550','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(34,171,'20200723','001','00102','00000000000000245245','                ','80','00000000030708698152','DER S.A','000000001269695','000000000000000','000000000000000','000000000000000','000000000000000','000000000088879','000000000000000','000000000000000','PES','0001000000','1','0','000000000266636','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(35,172,'20200723','001','00104','00000000000000113346','                ','80','00000000030708698152','DER S.A','000000000167726','000000000000000','000000000000000','000000000000000','000000000000000','000000000011741','000000000000000','000000000000000','PES','0001000000','1','0','000000000035222','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(36,188,'20200701','001','00003','00000000000000189096','                ','80','00000000033709450129','SUPPLY PART S.A','000000000304704','000000000000000','000000000000000','000000000000000','000000000000000','000000000009141','000000000000000','000000000000000','PES','0001000000','1','0','000000000063988','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(37,190,'20200723','001','00003','00000000000000190585','                ','80','00000000033709450129','SUPPLY PART S.A','000000000369268','000000000000000','000000000000000','000000000000000','000000000000000','000000000011078','000000000000000','000000000000000','PES','0001000000','1','0','000000000077546','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(38,191,'20200723','001','00102','00000000000000247231','                ','80','00000000030708698152','DER S.A','000000001237206','000000000000000','000000000000000','000000000000000','000000000000000','000000000086604','000000000000000','000000000000000','PES','0001000000','1','0','000000000259813','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(39,194,'20200717','001','09032','00000000000000018682','                ','80','00000000030691323958','BATERIAS MOURA DE ARGENTINA S.','000000001878696','000000000000000','000000000000000','000000000000000','000000000000000','000000000131509','000000000000000','000000000000000','PES','0001000000','1','0','000000000394526','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(40,196,'20200722','001','00021','00000000000000064938','                ','80','00000000030500728317','CROMOSOL S.A.I.C.F.','000000000161400','000000000000000','000000000000000','000000000000000','000000000000000','000000000006456','000000000000000','000000000000000','PES','0001000000','1','0','000000000033894','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(41,197,'20200702','001','00003','00000000000000189145','                ','80','00000000033709450129','SUPPLY PART S.A','000000000736045','000000000000000','000000000000000','000000000000000','000000000000000','000000000022081','000000000000000','000000000000000','PES','0001000000','1','0','000000000154569','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(42,198,'20200702','001','00003','00000000000000189142','                ','80','00000000033709450129','SUPPLY PART S.A','000000000383437','000000000000000','000000000000000','000000000000000','000000000000000','000000000011503','000000000000000','000000000000000','PES','0001000000','1','0','000000000080522','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(43,199,'20200708','001','00003','00000000000000189644','                ','80','00000000033709450129','SUPPLY PART S.A','000000000880328','000000000000000','000000000000000','000000000000000','000000000000000','000000000026410','000000000000000','000000000000000','PES','0001000000','2','0','000000000170800','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(44,200,'20200708','001','00003','00000000000000189608','                ','80','00000000033709450129','SUPPLY PART S.A','000000000871072','000000000000000','000000000000000','000000000000000','000000000000000','000000000026132','000000000000000','000000000000000','PES','0001000000','1','0','000000000182925','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(45,201,'20200714','001','00003','00000000000000189739','                ','80','00000000033709450129','SUPPLY PART S.A','000000002473047','000000000000000','000000000000000','000000000000000','000000000000000','000000000074191','000000000000000','000000000000000','PES','0001000000','2','0','000000000501180','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(46,202,'20200714','001','00003','00000000000000189783','                ','80','00000000033709450129','SUPPLY PART S.A','000000002750000','000000000000000','000000000000000','000000000000000','000000000000000','000000000082500','000000000000000','000000000000000','PES','0001000000','1','0','000000000577500','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(47,203,'20200715','001','00003','00000000000000189913','                ','80','00000000033709450129','SUPPLY PART S.A','000000001209099','000000000000000','000000000000000','000000000000000','000000000000000','000000000036273','000000000000000','000000000000000','PES','0001000000','2','0','000000000225642','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(48,205,'20200716','001','00003','00000000000000190029','                ','80','00000000033709450129','SUPPLY PART S.A','000000000145886','000000000000000','000000000000000','000000000000000','000000000000000','000000000004377','000000000000000','000000000000000','PES','0001000000','1','0','000000000030636','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(49,206,'20200716','001','00003','00000000000000190070','                ','80','00000000033709450129','SUPPLY PART S.A','000000000165772','000000000000000','000000000000000','000000000000000','000000000000000','000000000004973','000000000000000','000000000000000','PES','0001000000','2','0','000000000027553','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(50,207,'20200716','001','00003','00000000000000190036','                ','80','00000000033709450129','SUPPLY PART S.A','000000000308933','000000000000000','000000000000000','000000000000000','000000000000000','000000000009268','000000000000000','000000000000000','PES','0001000000','1','0','000000000064876','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(51,208,'20200720','001','00003','00000000000000190270','                ','80','00000000033709450129','SUPPLY PART S.A','000000002760503','000000000000000','000000000000000','000000000000000','000000000000000','000000000082815','000000000000000','000000000000000','PES','0001000000','2','0','000000000496739','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(52,209,'20200720','001','00003','00000000000000190276','                ','80','00000000033709450129','SUPPLY PART S.A','000000000178026','000000000000000','000000000000000','000000000000000','000000000000000','000000000005341','000000000000000','000000000000000','PES','0001000000','1','0','000000000037385','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(53,210,'20200721','001','00003','00000000000000190369','                ','80','00000000033709450129','SUPPLY PART S.A','000000000744016','000000000000000','000000000000000','000000000000000','000000000000000','000000000022320','000000000000000','000000000000000','PES','0001000000','1','0','000000000156243','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(54,211,'20200721','001','00003','00000000000000190370','                ','80','00000000033709450129','SUPPLY PART S.A','000000000356066','000000000000000','000000000000000','000000000000000','000000000000000','000000000010682','000000000000000','000000000000000','PES','0001000000','1','0','000000000037387','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(55,212,'20200722','001','00003','00000000000000190489','                ','80','00000000033709450129','SUPPLY PART S.A','000000000445787','000000000000000','000000000000000','000000000000000','000000000000000','000000000013374','000000000000000','000000000000000','PES','0001000000','1','0','000000000093615','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(56,214,'20200706','001','00003','00000000000000189306','                ','80','00000000033709450129','SUPPLY PART S.A','000000000716599','000000000000000','000000000000000','000000000000000','000000000000000','000000000021498','000000000000000','000000000000000','PES','0001000000','1','0','000000000150486','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(57,215,'20200706','001','00003','00000000000000189361','                ','80','00000000033709450129','SUPPLY PART S.A','000000000632129','000000000000000','000000000000000','000000000000000','000000000000000','000000000018964','000000000000000','000000000000000','PES','0001000000','2','0','000000000120821','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(58,216,'20200707','001','00003','00000000000000189523','                ','80','00000000033709450129','SUPPLY PART S.A','000000000238385','000000000000000','000000000000000','000000000000000','000000000000000','000000000007152','000000000000000','000000000000000','PES','0001000000','1','0','000000000025030','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(59,217,'20200707','001','00003','00000000000000189472','                ','80','00000000033709450129','SUPPLY PART S.A','000000002231463','000000000000000','000000000000000','000000000000000','000000000000000','000000000066944','000000000000000','000000000000000','PES','0001000000','1','0','000000000468607','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(60,226,'20200707','001','00003','00000000000000344272','                ','80','00000000030535994923','GOICOECHEA HNOS S.A','000000004213901','000000000000000','000000000000000','000000000000000','000000000000000','000000000294973','000000000000000','000000000000000','PES','0001000000','1','0','000000000884919','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(61,240,'20200724','001','00003','00000000000000190659','                ','80','00000000033709450129','SUPPLY PART S.A','000000000873112','000000000000000','000000000000000','000000000000000','000000000000000','000000000026193','000000000000000','000000000000000','PES','0001000000','1','0','000000000183354','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(62,241,'20200724','001','00102','00000000000000247397','                ','80','00000000030708698152','DER S.A','000000001179273','000000000000000','000000000000000','000000000000000','000000000000000','000000000082549','000000000000000','000000000000000','PES','0001000000','1','0','000000000247647','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(63,245,'20200727','001','00003','00000000000000190754','                ','80','00000000033709450129','SUPPLY PART S.A','000000000356299','000000000000000','000000000000000','000000000000000','000000000000000','000000000010689','000000000000000','000000000000000','PES','0001000000','1','0','000000000074823','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(64,246,'20200727','001','00102','00000000000000247576','                ','80','00000000030708698152','DER S.A','000000001805574','000000000000000','000000000000000','000000000000000','000000000000000','000000000126390','000000000000000','000000000000000','PES','0001000000','1','0','000000000379171','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(65,247,'20200729','001','00102','00000000000000247575','                ','80','00000000030708698152','DER S.A','000000002355071','000000000000000','000000000000000','000000000000000','000000000000000','000000000164855','000000000000000','000000000000000','PES','0001000000','2','0','000000000487578','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(66,248,'20200727','001','00102','00000000000000247621','                ','80','00000000030708698152','DER S.A','000000003062777','000000000000000','000000000000000','000000000000000','000000000000000','000000000214394','000000000000000','000000000000000','PES','0001000000','1','0','000000000643183','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(67,249,'20200727','001','00102','00000000000000247634','                ','80','00000000030708698152','DER S.A','000000000029814','000000000000000','000000000000000','000000000000000','000000000000000','000000000002087','000000000000000','000000000000000','PES','0001000000','1','0','000000000006261','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(68,253,'20200728','001','00102','00000000000000247776','                ','80','00000000030708698152','DER S.A','000000001850355','000000000000000','000000000000000','000000000000000','000000000000000','000000000129525','000000000000000','000000000000000','PES','0001000000','1','0','000000000388575','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(69,255,'20200729','001','00003','00000000000000190943','                ','80','00000000030708607459','IFR S.A','000000001190693','000000000000000','000000000000000','000000000000000','000000000000000','000000000035721','000000000000000','000000000000000','PES','0001000000','1','0','000000000250046','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(70,256,'20200728','001','00003','00000000000000190888','                ','80','00000000030708607459','IFR S.A','000000000523077','000000000000000','000000000000000','000000000000000','000000000000000','000000000015692','000000000000000','000000000000000','PES','0001000000','1','0','000000000109846','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(71,257,'20200728','001','00003','00000000000000190877','                ','80','00000000030708607459','IFR S.A','000000000325417','000000000000000','000000000000000','000000000000000','000000000000000','000000000009763','000000000000000','000000000000000','PES','0001000000','1','0','000000000068338','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(72,258,'20200729','001','00003','00000000000000190954','                ','80','00000000030708607459','IFR S.A','000000000086468','000000000000000','000000000000000','000000000000000','000000000000000','000000000002594','000000000000000','000000000000000','PES','0001000000','1','0','000000000018158','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(73,259,'20200729','001','00103','00000000000000253289','                ','80','00000000030708698152','DER S.A','000000003006944','000000000000000','000000000000000','000000000000000','000000000000000','000000000210486','000000000000000','000000000000000','PES','0001000000','1','0','000000000631458','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(74,267,'20200729','001','00101','00000000000000247066','                ','80','00000000030708698152','DER S.A','000000000783335','000000000000000','000000000000000','000000000000000','000000000000000','000000000054833','000000000000000','000000000000000','PES','0001000000','1','0','000000000164500','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(75,268,'20200730','001','00102','00000000000000248020','                ','80','00000000030708698152','DER S.A','000000001344289','000000000000000','000000000000000','000000000000000','000000000000000','000000000094101','000000000000000','000000000000000','PES','0001000000','1','0','000000000282301','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(76,269,'20200729','001','00103','00000000000000253323','                ','80','00000000030708698152','DER S.A','000000000045364','000000000000000','000000000000000','000000000000000','000000000000000','000000000003176','000000000000000','000000000000000','PES','0001000000','1','0','000000000009526','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(77,270,'20200730','001','00003','00000000000000191042','                ','80','00000000030708607459','IFR S.A','000000000418880','000000000000000','000000000000000','000000000000000','000000000000000','000000000012566','000000000000000','000000000000000','PES','0001000000','1','0','000000000087965','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(78,275,'20200731','003','00200','00000000000000192430','                ','80','00000000030708698152','DER S.A','000000000249482','000000000000000','000000000000000','000000000000000','000000000000000','000000000009979','000000000000000','000000000000000','PES','0001000000','1','0','000000000052391','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(79,140,'20200723','003','00200','00000000000000190677','                ','80','00000000030708698152','DER S.A','000000000056701','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000011907','000000000022.68','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(80,141,'20200723','003','00200','00000000000000190578','                ','80','00000000030708698152','DER S.A','000000000280314','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000058866','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(81,173,'20200702','001','00018','00000000000000022954','                ','80','00000000020184903351','ZEMEL JAVIER','000000000084421','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000017728','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(82,174,'20200710','001','00018','00000000000000023116','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000889203','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000186733','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(83,175,'20200702','001','00018','00000000000000022955','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000676767','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000142121','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(84,176,'20200713','001','00010','00000000000000000432','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000635269','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000133406','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(85,177,'20200713','001','00010','00000000000000000427','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000954538','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000200453','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(86,178,'20200711','001','00018','00000000000000023128','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000001765454','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000370745','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(87,179,'20200710','001','00018','00000000000000023115','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000236339','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000049631','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(88,180,'20200720','001','00018','00000000000000023371','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000003388197','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000711521','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(89,181,'20200720','001','00018','00000000000000023370','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000671200','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000140952','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(90,182,'20200701','001','00018','00000000000000022871','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000363670','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000038185','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(91,184,'20200721','001','00018','00000000000000023456','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000350839','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000073676','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(92,185,'20200721','001','00018','00000000000000023455','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000136406','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000028645','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(93,186,'20200713','001','00018','00000000000000023203','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000003380925','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','2','0','000000000545982','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(94,187,'20200721','001','00022','00000000000000004858','                ','80','000000033-71620259-9','ALEMAR GRUP','000000007242660','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001520959','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(95,189,'20200721','001','00022','00000000000000004848','                ','80','000000033-71620259-9','ALEMAR GRUP','000000007242660','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001520959','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(96,192,'20200723','001','00003','00000000000000043449','                ','80','00000000030708972335','CUR-MAN','000000000157725','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000033122','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(97,193,'20200714','002','09032','00000000000000000665','                ','80','00000000030691323958','BATERIAS MOURA DE ARGENTINA S.','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','0','0','000000000000000','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(98,195,'20200723','001','00010','00000000000000017135','                ','80','00000000030708607459','IFR S.A','000000009266100','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001945881','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(99,204,'20200724','001','00010','00000000000000017146','                ','80','00000000030708607459','IFR S.A','000000007970650','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001673837','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(100,213,'20200724','001','00010','00000000000000017147','                ','80','00000000030708607459','IFR S.A','000000005890530','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001237011','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(101,218,'20200722','001','00010','00000000000000083627','                ','80','00000000030643786938','GARIN GAS SA','000000000034861','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000007321','000000000073.22','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(102,219,'20200715','001','00010','00000000000000017080','                ','80','00000000030708607459','IFR S.A','000000001427260','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000149862','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(103,220,'20200715','001','00010','00000000000000017081','                ','80','00000000030708607459','IFR S.A','000000011095340','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000002330021','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(104,221,'20200713','001','00010','00000000000000017059','                ','80','00000000030708607459','IFR S.A','000000004071820','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000855082','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(105,222,'20200713','001','00003','00000000000000014511','                ','80','00000000003068283582','HOME SRL','000000001195498','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000251055','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(106,223,'20200706','001','00010','00000000000000017012','                ','80','00000000030708607459','IFR S.A','000000007950900','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001669689','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(107,224,'20200701','001','00005','00000000000000009244','                ','80','00000000030708607459','IFR S.A','000000002700720','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000567151','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(108,225,'20200710','001','00003','00000000000000000469','                ','80','00000000001111111111','WIRE ARGENTINE CONNECTIONS','000000000820350','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000172274','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(109,227,'20200720','001','00002','00000000000000014789','                ','80','00000000020184903351','ZEMEL JAVIER','000000003329092','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000699109','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(110,228,'20200720','001','00002','00000000000000014790','                ','80','00000000020184903351','ZEMEL JAVIER','000000000494456','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000103836','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(111,229,'20200716','001','00003','00000000000000043219','                ','80','00000000030708972335','CUR-MAN','000000000263828','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000055404','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(112,230,'20200716','001','00003','00000000000000043189','                ','80','00000000030708972335','CUR-MAN','000000000017186','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000003609','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(113,232,'20200716','001','00004','00000000000000001831','                ','80','00000000000000000001','DEMILTA RAUL ADOLFO','000000003238253','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000680033','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(114,233,'20200716','001','00004','00000000000000001832','                ','80','00000000000000000001','DEMILTA RAUL ADOLFO','000000000321265','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000067466','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(115,234,'20200716','002','00003','00000000000000000066','                ','80','00000000001111111111','WIRE ARGENTINE CONNECTIONS','000000000041018','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000008614','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(116,235,'20200720','001','00003','00000000000000043263','                ','80','00000000030708972335','CUR-MAN','000000000250876','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000052684','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(117,236,'20200723','001','00018','00000000000000023593','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000164005','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000034441','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(118,237,'20200723','001','00018','00000000000000023594','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000130871','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000027483','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(119,238,'20200723','001','00007','00000000000000063610','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','0','0','000000000000000','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(120,239,'20200722','001','00018','00000000000000023497','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000076968','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000016163','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(121,242,'20200727','001','00003','00000000000000190784','                ','80','00000000033709450129','SUPPLY PART S.A','000000000033552','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000007046','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(122,243,'20200727','001','00010','00000000000000017165','                ','80','00000000030708607459','IFR S.A','000000000801900','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000084200','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(123,244,'20200727','001','00010','00000000000000017164','                ','80','00000000030708607459','IFR S.A','000000017481830','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000003671184','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(124,250,'20200724','001','00018','00000000000000023614','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000007654072','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001607355','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(125,251,'20200727','001','00004','00000000000000001049','                ','80','00000000030697635773','FARCA DE NOEL MISTROT SRL','000000001006071','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000211275','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(126,252,'20200722','001','00002','00000000000000000224','                ','80','00000000000000000001','MOTORMAN','000000000630552','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000132416','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(127,254,'20200728','001','00005','00000000000000009313','                ','80','00000000030708607459','IFR S.A','000000006971900','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001464099','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(128,260,'20200728','001','00018','00000000000000023891','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000666263','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000139915','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(129,261,'20200728','001','00018','00000000000000023890','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000514564','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000108058','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(130,262,'20200729','003','00017','00000000000000002525','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000460060','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000096613','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(131,263,'20200729','003','00017','00000000000000002526','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000047047','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000009880','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(132,264,'20200729','001','00010','00000000000000017189','                ','80','00000000030708607459','IFR S.A','000000004809660','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001010029','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(133,265,'20200729','001','00005','00000000000000009317','                ','80','00000000033708765959','VIRIJO S.A.','000000006286800','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000001320228','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(134,266,'20200729','001','00002','00000000000000014842','                ','80','00000000020184903351','ZEMEL JAVIER','000000000935913','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000196542','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(135,271,'20200727','001','00018','00000000000000023794','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000187797','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000039437','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(136,272,'20200727','001','00018','00000000000000023795','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000502436','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000105512','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(137,273,'20200731','003','00200','00000000000000192356','                ','80','00000000030708698152','DER S.A','000000000863282','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000181289','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(138,274,'20200730','001','00018','00000000000000024009','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000222393','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000046703','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(139,276,'20200730','001','00018','00000000000000023998','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000015681','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000003293','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(140,280,'20200731','001','00018','00000000000000024152','                ','80','00000000030709771147','NICOSMAR S.R.L.','000000000370656','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000077838','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(141,281,'20200730','001','00003','00000000000000191097','                ','80','00000000033709450129','SUPPLY PART S.A','000000000020619','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000004330','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56'),
(142,283,'20200731','001','00032','00000000000000002915','                ','80','00000000030701530264','EXPRESO BRIO SRL','000000000034700','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','000000000000000','PES','0001000000','1','0','000000000007287','000000000000000','00000000000','                              ','000000000000000','\0','2020-08-04 10:34:56');
/*!40000 ALTER TABLE `citicpa_cab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citicpas_cbtes`
--

DROP TABLE IF EXISTS `citicpas_cbtes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citicpas_cbtes` (
  `idCbte` int(11) NOT NULL AUTO_INCREMENT,
  `cod_afip` varchar(3) NOT NULL,
  `codigo` varchar(3) NOT NULL,
  `tipoDoc` varchar(1) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  PRIMARY KEY (`idCbte`),
  UNIQUE KEY `idCbte` (`idCbte`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citicpas_cbtes`
--

LOCK TABLES `citicpas_cbtes` WRITE;
/*!40000 ALTER TABLE `citicpas_cbtes` DISABLE KEYS */;
INSERT INTO `citicpas_cbtes` VALUES
(1,'001','FC','A','FACTURA A'),
(2,'002','ND','A','NOTA DE DEBITO A'),
(3,'003','NC','A','NOTA DE CREIDITO A'),
(4,'006','FC','B','FACTURA B'),
(5,'007','ND','B','NOTA DE DEBITO A'),
(6,'008','NC','B','NOTA DE CREDITO A'),
(7,'011','FC','C','FACTURA C'),
(8,'012','ND','C','NOTA DE DEBITO A'),
(9,'013','NC','C','NOTA DE CREDITO A');
/*!40000 ALTER TABLE `citicpas_cbtes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL,
  `razSoc` varchar(60) NOT NULL,
  `nomFant` varchar(60) DEFAULT NULL,
  `direccion` varchar(60) NOT NULL,
  `idLocalid` int(11) NOT NULL,
  `idCondPago` int(11) NOT NULL,
  `idSitIVA` int(11) NOT NULL,
  `idVendedor` int(11) NOT NULL DEFAULT 1,
  `idTipoCli` int(11) NOT NULL,
  `idTransp` int(11) DEFAULT NULL,
  `nroCUIT` varchar(20) NOT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `celular` varchar(60) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `eMail` varchar(60) DEFAULT NULL,
  `pagWeb` varchar(60) DEFAULT NULL,
  `observ` text DEFAULT NULL,
  `contacto` varchar(60) DEFAULT NULL,
  `habilitado` bit(1) NOT NULL,
  `mayorista` bit(1) NOT NULL DEFAULT b'0',
  `desc1` float NOT NULL DEFAULT 0,
  `desc2` float NOT NULL DEFAULT 0,
  `desc3` float NOT NULL DEFAULT 0,
  `desc4` float NOT NULL DEFAULT 0,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `ctrMoro` bit(1) NOT NULL DEFAULT b'0',
  `recargo` float NOT NULL DEFAULT 0,
  `contrCM` bit(1) NOT NULL DEFAULT b'0',
  `credMax` float NOT NULL DEFAULT 0,
  `idRamo` int(11) DEFAULT NULL,
  `idTipoDoc` int(11) DEFAULT NULL,
  `usuWeb` varchar(20) DEFAULT NULL,
  `claveWeb` varchar(20) DEFAULT NULL,
  `envCbte` bit(1) NOT NULL DEFAULT b'0',
  `mailFC` varchar(60) DEFAULT NULL,
  `printCbte` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`idCliente`),
  KEY `fk_Clientes_Localidades1` (`idLocalid`),
  KEY `fk_Clientes_CondPagos1` (`idCondPago`),
  KEY `fk_Clientes_SitIVA1` (`idSitIVA`),
  KEY `fk_cli_transp` (`idTransp`),
  KEY `fk_clientes_vendedores1_idx` (`idVendedor`),
  KEY `fk_clientes_tiposcli1_idx` (`idTipoCli`),
  KEY `idRamo` (`idRamo`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`idRamo`) REFERENCES `ramos` (`idRamo`),
  CONSTRAINT `fk_Clientes_CondPagos1` FOREIGN KEY (`idCondPago`) REFERENCES `condpagos` (`idCondPago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_Localidades1` FOREIGN KEY (`idLocalid`) REFERENCES `localidad` (`idLocalid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_SitIVA1` FOREIGN KEY (`idSitIVA`) REFERENCES `sitiva` (`idSitIVA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cli_transp` FOREIGN KEY (`idTransp`) REFERENCES `transp` (`idTransp`),
  CONSTRAINT `fk_clientes_tiposcli1` FOREIGN KEY (`idTipoCli`) REFERENCES `tiposcli` (`idTipoCli`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_vendedores1` FOREIGN KEY (`idVendedor`) REFERENCES `vendedores` (`idVendedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES
(1,'CONSUMIDOR FINAL','CONSUMIDOR FINAL','X',2628,1,3,1,1,1,'1','','','','','','Cliente para facturar a consumidor final.','','','\0',0,0,0,0,'SUPER','2022-03-30 17:00:49','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',0,'\0',0,1,2,'','','\0','info@linfow.com.ar',''),
(2,'CLIENTE PRUEBA A','CLIENTE PRUEBA A','AV. X 500',2628,2,1,1,1,2,'20223773169','','','','','','','','','',0,0,0,0,'SUPER','2022-03-31 11:43:32','ESCRITORIO # Leonardo','SUPER','2025-12-03 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',0,'\0',0,1,1,'','','\0','info@linfow.com.ar',''),
(3,'CLIENTE DE PRUEBA B','CLIENTE DE PRUEBA B1','AV. X 3000',2628,1,6,1,1,1,'20130695699','','','','','','Cliente de prueba','','','\0',0,0,0,0,'SUPER','2022-03-31 19:18:58','ESCRITORIO # Leonardo','SUPER','2024-11-01 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0',0,'\0',0,1,1,'','','\0','info@linfow.com.ar','');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `codiart`
--

DROP TABLE IF EXISTS `codiart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `codiart` (
  `idCodArt` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `codigos` varchar(20) NOT NULL,
  `tipo` varchar(2) NOT NULL,
  `cantiDesp` float(10,2) NOT NULL,
  `procesado` bit(1) NOT NULL,
  `circuito` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`idCodArt`),
  UNIQUE KEY `idCodArt` (`idCodArt`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `codiart_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `codiart`
--

LOCK TABLES `codiart` WRITE;
/*!40000 ALTER TABLE `codiart` DISABLE KEYS */;
INSERT INTO `codiart` VALUES
(1,1,'1ARX','1ARX','CP',1.00,'\0','CV'),
(2,2,'2ARX','2ARX','CP',1.00,'\0','CV'),
(4,4,'PROD072','PROD072','CP',1.00,'\0','CV'),
(5,5,'PROD073','PROD073','CP',1.00,'\0','CV'),
(6,6,'PROD074','PROD074','CP',1.00,'\0','CV'),
(8,8,'PROD076','PROD076','CP',1.00,'\0','CV'),
(9,9,'PROD077','PROD077','CP',1.00,'\0','CV'),
(10,10,'PROD078','PROD078','CP',1.00,'\0','CV'),
(11,11,'PROD079','PROD079','CP',1.00,'\0','CV'),
(12,12,'PROD080','PROD080','CP',1.00,'\0','CV'),
(13,13,'PROD081','PROD081','CP',1.00,'\0','CV'),
(14,14,'PROD082','PROD082','CP',1.00,'\0','CV'),
(15,15,'PROD083','PROD083','CP',1.00,'\0','CV'),
(16,16,'PROD084','PROD084','CP',1.00,'\0','CV'),
(17,17,'PROD085','PROD085','CP',1.00,'\0','CV'),
(18,18,'PROD086','PROD086','CP',1.00,'\0','CV'),
(19,19,'PROD087','PROD087','CP',1.00,'\0','CV'),
(20,20,'PROD088','PROD088','CP',1.00,'\0','CV'),
(21,21,'PROD089','PROD089','CP',1.00,'\0','CV'),
(24,24,'PROD092','PROD092','CP',1.00,'\0','CV'),
(26,26,'PROD094','PROD094','CP',1.00,'\0','CV'),
(27,27,'PROD095','PROD095','CP',1.00,'\0','CV'),
(28,28,'PROD096','PROD096','CP',1.00,'\0','CV'),
(29,29,'PROD097','PROD097','CP',1.00,'\0','CV'),
(30,30,'PROD098','PROD098','CP',1.00,'\0','CV'),
(31,31,'PROD099','PROD099','CP',1.00,'\0','CV'),
(32,32,'PROD100','PROD100','CP',1.00,'\0','CV'),
(33,33,'PROD101','PROD101','CP',1.00,'\0','CV'),
(34,34,'PROD102','PROD102','CP',1.00,'\0','CV'),
(35,35,'PROD103','PROD103','CP',1.00,'\0','CV'),
(36,36,'PROD104','PROD104','CP',1.00,'\0','CV'),
(37,37,'PROD105','PROD105','CP',1.00,'\0','CV'),
(38,38,'PROD106','PROD106','CP',1.00,'\0','CV'),
(39,39,'PROD107','PROD107','CP',1.00,'\0','CV'),
(40,40,'PROD108','PROD108','CP',1.00,'\0','CV'),
(41,41,'PROD109','PROD109','CP',1.00,'\0','CV'),
(42,42,'PROD110','PROD110','CP',1.00,'\0','CV'),
(43,43,'PROD111','PROD111','CP',1.00,'\0','CV'),
(44,44,'PROD112','PROD112','CP',1.00,'\0','CV'),
(45,45,'PROD113','PROD113','CP',1.00,'\0','CV'),
(46,46,'PROD114','PROD114','CP',1.00,'\0','CV'),
(47,47,'PROD115','PROD115','CP',1.00,'\0','CV'),
(48,48,'PROD116','PROD116','CP',1.00,'\0','CV'),
(49,49,'PROD117','PROD117','CP',1.00,'\0','CV'),
(50,50,'PROD118','PROD118','CP',1.00,'\0','CV'),
(51,51,'PROD119','PROD119','CP',1.00,'\0','CV'),
(52,52,'PROD120','PROD120','CP',1.00,'\0','CV'),
(53,53,'PROD121','PROD121','CP',1.00,'\0','CV'),
(54,54,'PROD122','PROD122','CP',1.00,'\0','CV'),
(55,55,'PROD123','PROD123','CP',1.00,'\0','CV'),
(56,56,'PROD124','PROD124','CP',1.00,'\0','CV'),
(57,57,'PROD125','PROD125','CP',1.00,'\0','CV'),
(58,58,'PROD126','PROD126','CP',1.00,'\0','CV'),
(59,59,'PROD127','PROD127','CP',1.00,'\0','CV'),
(60,60,'PROD128','PROD128','CP',1.00,'\0','CV'),
(61,61,'PROD129','PROD129','CP',1.00,'\0','CV'),
(62,62,'PROD130','PROD130','CP',1.00,'\0','CV'),
(63,63,'PROD131','PROD131','CP',1.00,'\0','CV'),
(64,64,'PROD132','PROD132','CP',1.00,'\0','CV'),
(65,65,'PROD133','PROD133','CP',1.00,'\0','CV'),
(66,66,'PROD134','PROD134','CP',1.00,'\0','CV'),
(67,67,'PROD135','PROD135','CP',1.00,'\0','CV'),
(68,68,'PROD136','PROD136','CP',1.00,'\0','CV'),
(69,69,'PROD137','PROD137','CP',1.00,'\0','CV'),
(70,70,'PROD138','PROD138','CP',1.00,'\0','CV'),
(71,71,'PROD139','PROD139','CP',1.00,'\0','CV'),
(72,72,'PROD140','PROD140','CP',1.00,'\0','CV'),
(73,73,'PROD141','PROD141','CP',1.00,'\0','CV'),
(74,74,'PROD142','PROD142','CP',1.00,'\0','CV'),
(75,75,'PROD143','PROD143','CP',1.00,'\0','CV'),
(76,76,'PROD144','PROD144','CP',1.00,'\0','CV'),
(77,77,'PROD145','PROD145','CP',1.00,'\0','CV'),
(78,78,'PROD146','PROD146','CP',1.00,'\0','CV'),
(79,79,'PROD147','PROD147','CP',1.00,'\0','CV'),
(80,80,'PROD148','PROD148','CP',1.00,'\0','CV'),
(81,81,'PROD149','PROD149','CP',1.00,'\0','CV'),
(82,82,'PROD150','PROD150','CP',1.00,'\0','CV'),
(83,83,'PROD151','PROD151','CP',1.00,'\0','CV'),
(84,84,'PROD152','PROD152','CP',1.00,'\0','CV'),
(85,85,'PROD153','PROD153','CP',1.00,'\0','CV'),
(86,86,'PROD154','PROD154','CP',1.00,'\0','CV'),
(87,87,'PROD155','PROD155','CP',1.00,'\0','CV'),
(88,88,'PROD156','PROD156','CP',1.00,'\0','CV'),
(89,89,'PROD157','PROD157','CP',1.00,'\0','CV'),
(90,90,'PROD158','PROD158','CP',1.00,'\0','CV'),
(91,91,'PROD159','PROD159','CP',1.00,'\0','CV'),
(92,92,'PROD160','PROD160','CP',1.00,'\0','CV'),
(93,93,'PROD161','PROD161','CP',1.00,'\0','CV'),
(94,94,'PROD162','PROD162','CP',1.00,'\0','CV'),
(95,95,'PROD163','PROD163','CP',1.00,'\0','CV'),
(96,96,'PROD164','PROD164','CP',1.00,'\0','CV'),
(97,97,'PROD165','PROD165','CP',1.00,'\0','CV'),
(98,98,'PROD166','PROD166','CP',1.00,'\0','CV'),
(99,99,'PROD167','PROD167','CP',1.00,'\0','CV'),
(100,100,'PROD168','PROD168','CP',1.00,'\0','CV'),
(101,101,'PROD169','PROD169','CP',1.00,'\0','CV'),
(102,102,'PROD170','PROD170','CP',1.00,'\0','CV'),
(103,103,'PROD171','PROD171','CP',1.00,'\0','CV'),
(104,104,'PROD172','PROD172','CP',1.00,'\0','CV'),
(105,105,'PROD173','PROD173','CP',1.00,'\0','CV'),
(106,106,'PROD174','PROD174','CP',1.00,'\0','CV'),
(107,107,'PROD175','PROD175','CP',1.00,'\0','CV'),
(108,108,'PROD176','PROD176','CP',1.00,'\0','CV'),
(109,109,'PROD177','PROD177','CP',1.00,'\0','CV'),
(110,110,'PROD178','PROD178','CP',1.00,'\0','CV'),
(111,111,'PROD179','PROD179','CP',1.00,'\0','CV'),
(112,112,'PROD180','PROD180','CP',1.00,'\0','CV'),
(113,113,'PROD181','PROD181','CP',1.00,'\0','CV'),
(114,114,'PROD182','PROD182','CP',1.00,'\0','CV'),
(115,115,'PROD183','PROD183','CP',1.00,'\0','CV'),
(116,116,'PROD184','PROD184','CP',1.00,'\0','CV'),
(117,117,'PROD185','PROD185','CP',1.00,'\0','CV'),
(118,118,'PROD186','PROD186','CP',1.00,'\0','CV'),
(119,119,'PROD187','PROD187','CP',1.00,'\0','CV'),
(120,120,'PROD188','PROD188','CP',1.00,'\0','CV'),
(121,121,'PROD189','PROD189','CP',1.00,'\0','CV'),
(122,122,'PROD190','PROD190','CP',1.00,'\0','CV'),
(123,123,'PROD191','PROD191','CP',1.00,'\0','CV'),
(124,124,'PROD192','PROD192','CP',1.00,'\0','CV'),
(125,125,'PROD193','PROD193','CP',1.00,'\0','CV'),
(126,126,'PROD194','PROD194','CP',1.00,'\0','CV'),
(127,127,'PROD195','PROD195','CP',1.00,'\0','CV'),
(128,128,'PROD196','PROD196','CP',1.00,'\0','CV'),
(129,129,'PROD197','PROD197','CP',1.00,'\0','CV'),
(130,130,'PROD198','PROD198','CP',1.00,'\0','CV'),
(131,131,'PROD199','PROD199','CP',1.00,'\0','CV'),
(132,132,'PROD200','PROD200','CP',1.00,'\0','CV'),
(133,133,'PROD201','PROD201','CP',1.00,'\0','CV'),
(134,134,'PROD202','PROD202','CP',1.00,'\0','CV'),
(135,135,'PROD203','PROD203','CP',1.00,'\0','CV'),
(136,136,'PROD204','PROD204','CP',1.00,'\0','CV'),
(137,137,'PROD205','PROD205','CP',1.00,'\0','CV'),
(138,138,'PROD206','PROD206','CP',1.00,'\0','CV'),
(139,139,'PROD207','PROD207','CP',1.00,'\0','CV'),
(140,140,'PROD208','PROD208','CP',1.00,'\0','CV'),
(141,141,'PROD209','PROD209','CP',1.00,'\0','CV'),
(142,142,'PROD210','PROD210','CP',1.00,'\0','CV'),
(147,147,'PROD005','PROD005','CP',1.00,'\0','CV'),
(148,148,'PROD006','PROD006','CP',1.00,'\0','CV'),
(149,149,'PROD007','PROD007','CP',1.00,'\0','CV'),
(150,150,'PROD008','PROD008','CP',1.00,'\0','CV'),
(151,151,'PROD009','PROD009','CP',1.00,'\0','CV'),
(154,154,'PROD012','PROD012','CP',1.00,'\0','CV'),
(155,155,'PROD013','PROD013','CP',1.00,'\0','CV'),
(156,156,'PROD014','PROD014','CP',1.00,'\0','CV'),
(157,157,'PROD015','PROD015','CP',1.00,'\0','CV'),
(158,158,'PROD016','PROD016','CP',1.00,'\0','CV'),
(159,159,'PROD017','PROD017','CP',1.00,'\0','CV'),
(160,160,'PROD018','PROD018','CP',1.00,'\0','CV'),
(161,161,'PROD019','PROD019','CP',1.00,'\0','CV'),
(162,162,'PROD020','PROD020','CP',1.00,'\0','CV'),
(163,163,'PROD021','PROD021','CP',1.00,'\0','CV'),
(164,164,'PROD022','PROD022','CP',1.00,'\0','CV'),
(165,165,'PROD023','PROD023','CP',1.00,'\0','CV'),
(166,166,'PROD024','PROD024','CP',1.00,'\0','CV'),
(167,167,'PROD025','PROD025','CP',1.00,'\0','CV'),
(168,168,'PROD026','PROD026','CP',1.00,'\0','CV'),
(169,169,'PROD027','PROD027','CP',1.00,'\0','CV'),
(170,170,'PROD028','PROD028','CP',1.00,'\0','CV'),
(171,171,'PROD029','PROD029','CP',1.00,'\0','CV'),
(172,172,'PROD030','PROD030','CP',1.00,'\0','CV'),
(173,173,'PROD031','PROD031','CP',1.00,'\0','CV'),
(174,174,'PROD032','PROD032','CP',1.00,'\0','CV'),
(175,175,'PROD033','PROD033','CP',1.00,'\0','CV'),
(176,176,'PROD034','PROD034','CP',1.00,'\0','CV'),
(177,177,'PROD035','PROD035','CP',1.00,'\0','CV'),
(178,178,'PROD036','PROD036','CP',1.00,'\0','CV'),
(179,179,'PROD037','PROD037','CP',1.00,'\0','CV'),
(180,180,'PROD038','PROD038','CP',1.00,'\0','CV'),
(181,181,'PROD039','PROD039','CP',1.00,'\0','CV'),
(182,182,'PROD040','PROD040','CP',1.00,'\0','CV'),
(183,183,'PROD041','PROD041','CP',1.00,'\0','CV'),
(184,184,'PROD042','PROD042','CP',1.00,'\0','CV'),
(185,185,'PROD043','PROD043','CP',1.00,'\0','CV'),
(186,186,'PROD044','PROD044','CP',1.00,'\0','CV'),
(187,187,'PROD045','PROD045','CP',1.00,'\0','CV'),
(188,188,'PROD046','PROD046','CP',1.00,'\0','CV'),
(189,189,'PROD047','PROD047','CP',1.00,'\0','CV'),
(190,190,'PROD048','PROD048','CP',1.00,'\0','CV'),
(191,191,'PROD049','PROD049','CP',1.00,'\0','CV'),
(192,192,'PROD050','PROD050','CP',1.00,'\0','CV'),
(193,193,'PROD051','PROD051','CP',1.00,'\0','CV'),
(194,194,'PROD052','PROD052','CP',1.00,'\0','CV'),
(195,195,'PROD053','PROD053','CP',1.00,'\0','CV'),
(196,196,'PROD054','PROD054','CP',1.00,'\0','CV'),
(197,197,'PROD055','PROD055','CP',1.00,'\0','CV'),
(198,198,'PROD056','PROD056','CP',1.00,'\0','CV'),
(199,199,'PROD057','PROD057','CP',1.00,'\0','CV'),
(200,200,'PROD058','PROD058','CP',1.00,'\0','CV'),
(201,201,'PROD059','PROD059','CP',1.00,'\0','CV'),
(202,202,'PROD060','PROD060','CP',1.00,'\0','CV'),
(203,203,'PROD061','PROD061','CP',1.00,'\0','CV'),
(204,204,'PROD062','PROD062','CP',1.00,'\0','CV'),
(205,205,'PROD063','PROD063','CP',1.00,'\0','CV'),
(206,206,'PROD064','PROD064','CP',1.00,'\0','CV'),
(207,207,'PROD065','PROD065','CP',1.00,'\0','CV'),
(208,208,'PROD066','PROD066','CP',1.00,'\0','CV'),
(209,209,'PROD067','PROD067','CP',1.00,'\0','CV'),
(210,210,'PROD068','PROD068','CP',1.00,'\0','CV'),
(211,211,'PROD069','PROD069','CP',1.00,'\0','CV'),
(212,212,'PROD070','PROD070','CP',1.00,'\0','CV'),
(213,3,'PROD071','PROD071','CP',1.00,'\0','CV'),
(214,7,'PROD075','PROD075','CP',1.00,'\0','CV'),
(215,145,'PROD003','PROD003','CP',1.00,'\0','CV'),
(216,146,'PROD004','PROD004','CP',1.00,'\0','CV'),
(217,213,'RZL115-226','RZL115-226','CP',1.00,'\0','CV'),
(218,152,'PROD010','PROD010','CP',1.00,'\0','CV'),
(219,153,'PROD011','PROD011','CP',1.00,'\0','CV'),
(222,22,'PROD090','PROD090','CP',1.00,'\0','CV'),
(223,25,'PROD093','PROD093','CP',1.00,'\0','CV'),
(224,23,'PROD091','PROD091','CP',1.00,'\0','CV'),
(225,143,'PROD001','PROD001','CP',1.00,'\0','CV'),
(226,143,'PROD001','PROD001-TEST','CP',1.00,'\0','V'),
(227,144,'PROD002','PROD002','CP',1.00,'\0','CV');
/*!40000 ALTER TABLE `codiart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `columnas`
--

DROP TABLE IF EXISTS `columnas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `columnas` (
  `idColumna` int(11) NOT NULL,
  `idTabla` int(11) NOT NULL,
  `fieldName` varchar(15) NOT NULL,
  `dataType` varchar(1) NOT NULL,
  `nroColRef` int(11) NOT NULL,
  PRIMARY KEY (`idColumna`,`idTabla`),
  KEY `idTabla` (`idTabla`),
  CONSTRAINT `columnas_ibfk_1` FOREIGN KEY (`idTabla`) REFERENCES `tablas` (`idTabla`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `columnas`
--

LOCK TABLES `columnas` WRITE;
/*!40000 ALTER TABLE `columnas` DISABLE KEYS */;
INSERT INTO `columnas` VALUES
(1,1,'codArtPV','C',1),
(2,1,'prListaPV','N',2);
/*!40000 ALTER TABLE `columnas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comprascab`
--

DROP TABLE IF EXISTS `comprascab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comprascab` (
  `idCompraC` int(11) NOT NULL,
  `idProv` int(11) NOT NULL,
  `idCondPago` int(11) NOT NULL,
  `idSitIVA` int(11) NOT NULL,
  `razSocPV` varchar(60) NOT NULL,
  `cuitPV` varchar(20) NOT NULL,
  `fecEmis` datetime NOT NULL,
  `fecVto` datetime NOT NULL,
  `cbte` varchar(3) NOT NULL,
  `tipoDoc` varchar(1) NOT NULL,
  `ptoVta` int(11) NOT NULL,
  `numCbte` int(11) NOT NULL,
  `noGravado` double DEFAULT NULL,
  `totNeto` double DEFAULT NULL,
  `alicIVA21` double DEFAULT NULL,
  `impIVA21` double DEFAULT NULL,
  `alicIVA105` double DEFAULT NULL,
  `impIVA105` double DEFAULT NULL,
  `retIVA` double DEFAULT NULL,
  `retIIBB` double DEFAULT NULL,
  `idProvin` int(11) DEFAULT NULL,
  `retGan` double DEFAULT NULL,
  `retSUSS` double DEFAULT NULL,
  `totFinal` double DEFAULT NULL,
  `saldo` double DEFAULT NULL,
  `observ` varchar(255) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `impuestos` double DEFAULT NULL,
  PRIMARY KEY (`idCompraC`),
  UNIQUE KEY `idCompraC` (`idCompraC`),
  KEY `idProv` (`idProv`),
  KEY `idCondPago` (`idCondPago`),
  KEY `idSitIVA` (`idSitIVA`),
  CONSTRAINT `comprascab_ibfk_1` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`),
  CONSTRAINT `comprascab_ibfk_2` FOREIGN KEY (`idCondPago`) REFERENCES `condpagos` (`idCondPago`),
  CONSTRAINT `comprascab_ibfk_3` FOREIGN KEY (`idSitIVA`) REFERENCES `sitiva` (`idSitIVA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprascab`
--

LOCK TABLES `comprascab` WRITE;
/*!40000 ALTER TABLE `comprascab` DISABLE KEYS */;
INSERT INTO `comprascab` VALUES
(1,2,1,1,'PROVEEDOR A','2','2022-10-05 00:00:00','2022-10-05 00:00:00','FC','A',1,1,0,50000,21,10500,0,0,0,0,NULL,0,0,60500,0,'','SUPER','2022-10-05 10:27:12','ESCRITORIO # Leonardo','SUPER','2022-10-05 10:28:24','ESCRITORIO # Leonardo',NULL,NULL,NULL,0),
(2,1,1,1,'PROVEEDOR X','1','2023-02-09 00:00:00','2023-02-09 00:00:00','FC','A',1,212121,0,10000,21,2100,0,0,0,0,NULL,0,0,12100,2100,'','SUPER','2023-02-09 19:12:16','LEO_NOTEBOOK # LINFOW','SUPER','2023-02-09 19:15:35','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,0),
(3,3,2,1,'PROVEEDOR B','3','2023-08-09 00:00:00','2023-08-30 00:00:00','FC','A',1,1000,0,10000,21,2100,0,0,0,0,NULL,0,0,12100,0,'','SUPER','2023-08-09 19:18:05','ESCRITORIO # leonardo','SUPER','2023-08-09 19:18:48','ESCRITORIO # leonardo',NULL,NULL,NULL,0),
(4,2,2,1,'PROVEEDOR A','2','2023-08-09 00:00:00','2023-08-30 00:00:00','FC','A',1,10001,0,10000,21,2100,0,0,0,0,NULL,0,0,12100,0,'','SUPER','2023-08-09 19:24:55','ESCRITORIO # leonardo','SUPER','2023-08-10 15:51:29','ESCRITORIO # leonardo',NULL,NULL,NULL,0),
(5,2,2,1,'PROVEEDOR A','2','2023-08-10 00:00:00','2023-08-31 00:00:00','FC','A',2,1,0,5000,21,1050,0,0,0,0,NULL,0,0,6050,0,'','SUPER','2023-08-10 16:10:41','ESCRITORIO # leonardo','SUPER','2023-08-10 16:28:28','ESCRITORIO # leonardo',NULL,NULL,NULL,0),
(6,2,3,1,'PROVEEDOR A','2','2023-08-10 00:00:00','2023-09-09 00:00:00','FC','A',2,2,0,12000,21,2520,0,0,0,0,NULL,0,0,14520,0,'','SUPER','2023-08-10 16:11:13','ESCRITORIO # leonardo','SUPER','2023-08-10 16:34:17','ESCRITORIO # leonardo',NULL,NULL,NULL,0),
(7,2,2,1,'PROVEEDOR A','2','2023-08-10 00:00:00','2023-08-31 00:00:00','FC','A',2,3,0,20000,21,4200,0,0,0,0,NULL,0,0,24200,0,'','SUPER','2023-08-10 16:47:20','ESCRITORIO # leonardo','SUPER','2023-08-10 16:50:32','ESCRITORIO # leonardo',NULL,NULL,NULL,0),
(8,2,2,1,'PROVEEDOR A','2','2023-08-11 00:00:00','2023-09-01 00:00:00','FC','A',2,10,0,20000,21,4200,0,0,100,100,1,100,100,24700,0,'','SUPER','2023-08-11 17:48:17','ESCRITORIO # leonardo','SUPER','2023-08-11 17:49:42','ESCRITORIO # leonardo',NULL,NULL,NULL,100),
(9,5,2,1,'LEONARDO D. ZULLI','20280456919','2024-07-22 00:00:00','2024-07-22 00:00:00','FC','A',10,1,0,20000,21,4200,0,0,0,0,NULL,0,0,24200,24200,'','SUPER','2024-07-22 07:50:23','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `comprascab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comprasdet`
--

DROP TABLE IF EXISTS `comprasdet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comprasdet` (
  `idCompraD` int(11) NOT NULL,
  `idCompraC` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `descripcio` varchar(100) NOT NULL,
  `idUniMed` int(11) NOT NULL,
  `cantidad` double DEFAULT NULL,
  `cantPack` double DEFAULT NULL,
  `cantNC` double DEFAULT NULL,
  `prLista` double DEFAULT NULL,
  `porDesc1` double DEFAULT NULL,
  `porDesc2` double DEFAULT NULL,
  `porDesc3` double DEFAULT NULL,
  `porDesc4` double DEFAULT NULL,
  `impDesc1` double DEFAULT NULL,
  `impDesc2` double DEFAULT NULL,
  `impDesc3` double DEFAULT NULL,
  `impDesc4` double DEFAULT NULL,
  `costoNeto` double DEFAULT NULL,
  `alicIVA` double DEFAULT NULL,
  `impIVA` double DEFAULT NULL,
  `costoFinal` double DEFAULT NULL,
  `totNeto` double DEFAULT NULL,
  `totFinal` double DEFAULT NULL,
  PRIMARY KEY (`idCompraD`,`idCompraC`),
  KEY `idCompraC` (`idCompraC`),
  KEY `idArticulo` (`idArticulo`),
  KEY `idUniMed` (`idUniMed`),
  CONSTRAINT `comprasdet_ibfk_1` FOREIGN KEY (`idCompraC`) REFERENCES `comprascab` (`idCompraC`),
  CONSTRAINT `comprasdet_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`),
  CONSTRAINT `comprasdet_ibfk_3` FOREIGN KEY (`idUniMed`) REFERENCES `unidmed` (`idUniMed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprasdet`
--

LOCK TABLES `comprasdet` WRITE;
/*!40000 ALTER TABLE `comprasdet` DISABLE KEYS */;
/*!40000 ALTER TABLE `comprasdet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comprasret`
--

DROP TABLE IF EXISTS `comprasret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comprasret` (
  `idCompraR` int(11) NOT NULL,
  `idCompraC` int(11) NOT NULL,
  `tipo` varchar(5) NOT NULL,
  `idProvin` int(11) NOT NULL,
  `importe` double DEFAULT NULL,
  PRIMARY KEY (`idCompraR`,`idCompraC`),
  KEY `idCompraC` (`idCompraC`),
  KEY `idProvin` (`idProvin`),
  CONSTRAINT `comprasret_ibfk_1` FOREIGN KEY (`idCompraC`) REFERENCES `comprascab` (`idCompraC`),
  CONSTRAINT `comprasret_ibfk_2` FOREIGN KEY (`idProvin`) REFERENCES `provincias` (`idProvin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprasret`
--

LOCK TABLES `comprasret` WRITE;
/*!40000 ALTER TABLE `comprasret` DISABLE KEYS */;
INSERT INTO `comprasret` VALUES
(1,8,'RIB',1,100);
/*!40000 ALTER TABLE `comprasret` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conccj`
--

DROP TABLE IF EXISTS `conccj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conccj` (
  `idConcCJ` int(11) NOT NULL,
  `codConcCJ` varchar(6) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `signo` int(11) NOT NULL DEFAULT 1,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idConcCJ`),
  UNIQUE KEY `idConcCJ` (`idConcCJ`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conccj`
--

LOCK TABLES `conccj` WRITE;
/*!40000 ALTER TABLE `conccj` DISABLE KEYS */;
INSERT INTO `conccj` VALUES
(1,'APECJA','APERTURA DE CAJA',1,'SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,'SALCJA','SALIDA DE CAJA',-1,'SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'APLCMP','APLICACION DE COMPROBANTE',1,'SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4,'ANUMOV','ANULACION POR ERROR DE MOVIMIENTO',1,'SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,'VC','VALE POR COMBUSTIBLE',-1,'SUPER','2023-03-22 09:37:22','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `conccj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condpagos`
--

DROP TABLE IF EXISTS `condpagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `condpagos` (
  `idCondPago` int(11) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `cntDias` int(11) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idCondPago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condpagos`
--

LOCK TABLES `condpagos` WRITE;
/*!40000 ALTER TABLE `condpagos` DISABLE KEYS */;
INSERT INTO `condpagos` VALUES
(1,'CONTADO',0,'SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,'A 21 DIAS',21,'SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'A 30 DIAS',30,'SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4,'A 45 DIAS',45,'SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,'A 40 DIAS',40,'SUPER','2014-12-05 00:00:00','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(6,'A 60 DIAS',60,'SUPER','2017-09-19 16:51:00','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(7,'A 10 DIAS',10,'SUPER','2017-09-19 16:59:49','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(8,'A 35 DIAS',35,'SUPER','2019-07-11 17:58:06','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(9,'CONTAREMBOLSO',0,'SUPER','2020-06-17 12:39:34','FACTURACION # Facturación',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `condpagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cpasdet_cp`
--

DROP TABLE IF EXISTS `cpasdet_cp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cpasdet_cp` (
  `idCpaDCP` int(11) NOT NULL,
  `idCompraC` int(11) NOT NULL,
  `idPlanCta` int(11) NOT NULL,
  `idBanco` int(11) DEFAULT NULL,
  `idCheque` int(11) DEFAULT NULL,
  `cheque_nro` varchar(8) DEFAULT NULL,
  `impNeto` double DEFAULT NULL,
  `ivaPor` double DEFAULT NULL,
  `ivaImp` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`idCpaDCP`,`idCompraC`),
  KEY `idCompraC` (`idCompraC`),
  KEY `idPlanCta` (`idPlanCta`),
  KEY `idCheque` (`idCheque`),
  KEY `idBanco` (`idBanco`),
  CONSTRAINT `cpasdet_cp_ibfk_1` FOREIGN KEY (`idCompraC`) REFERENCES `comprascab` (`idCompraC`),
  CONSTRAINT `cpasdet_cp_ibfk_2` FOREIGN KEY (`idPlanCta`) REFERENCES `planctas` (`idPlanCta`),
  CONSTRAINT `cpasdet_cp_ibfk_3` FOREIGN KEY (`idCheque`) REFERENCES `cheques` (`idCheque`),
  CONSTRAINT `cpasdet_cp_ibfk_4` FOREIGN KEY (`idBanco`) REFERENCES `bancos` (`idBanco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cpasdet_cp`
--

LOCK TABLES `cpasdet_cp` WRITE;
/*!40000 ALTER TABLE `cpasdet_cp` DISABLE KEYS */;
INSERT INTO `cpasdet_cp` VALUES
(1,1,22,NULL,NULL,NULL,50000,21,10500,60500),
(1,2,85,NULL,NULL,NULL,10000,21,2100,12100),
(1,3,22,NULL,NULL,NULL,10000,21,2100,12100),
(1,4,22,NULL,NULL,NULL,10000,21,2100,12100),
(1,5,22,NULL,NULL,NULL,5000,21,1050,6050),
(1,6,22,NULL,NULL,NULL,12000,21,2520,14520),
(1,7,22,NULL,NULL,NULL,20000,21,4200,24200),
(1,8,22,NULL,NULL,NULL,20000,21,4200,24200),
(1,9,74,NULL,NULL,NULL,20000,21,4200,24200);
/*!40000 ALTER TABLE `cpasdet_cp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ctacja`
--

DROP TABLE IF EXISTS `ctacja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctacja` (
  `idCtaCja` int(11) NOT NULL,
  `codCtaCj` varchar(5) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `esCheque` bit(1) NOT NULL,
  `esVale` bit(1) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `idPlanCta` int(11) DEFAULT NULL,
  `esRetIB` bit(1) NOT NULL DEFAULT b'0',
  `esRetIVA` bit(1) NOT NULL DEFAULT b'0',
  `esRetSUSS` bit(1) NOT NULL DEFAULT b'0',
  `esGcias` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`idCtaCja`),
  UNIQUE KEY `idCtaCja` (`idCtaCja`),
  KEY `fk_ctacja_plancta` (`idPlanCta`),
  CONSTRAINT `fk_ctacja_plancta` FOREIGN KEY (`idPlanCta`) REFERENCES `planctas` (`idPlanCta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctacja`
--

LOCK TABLES `ctacja` WRITE;
/*!40000 ALTER TABLE `ctacja` DISABLE KEYS */;
INSERT INTO `ctacja` VALUES
(1,'EFVO','EFECTIVO','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,4,'\0','\0','\0','\0'),
(2,'VANC','VALE POR NOTA DE CREDITO','\0','','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,7,'\0','\0','\0','\0'),
(3,'CHEQ','CHEQUES','','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,12,'\0','\0','\0','\0'),
(4,'TADB','TARJETA DE DEBITO','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,185,'\0','\0','\0','\0'),
(5,'TACR','TARJETA DE CREDITO','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,184,'\0','\0','\0','\0'),
(6,'SALF','SALDO A FAVOR','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0','\0','\0','\0'),
(7,'CAJU','CUENTA AJUSTE','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,63,'\0','\0','\0','\0'),
(8,'RSUSS','RET. S.U.S.S.','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,174,'\0','\0','','\0'),
(9,'RIVA','RET. I.V.A.','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,171,'\0','','\0','\0'),
(10,'RIB','RET. I.I.B.B.','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,172,'','\0','\0','\0'),
(11,'RGAN','GANANCIAS','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,173,'\0','\0','\0',''),
(12,'DEP','DEP. /  TRANS. BCO','\0','\0','SUPER','2015-09-17 00:00:00','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0','\0','\0','\0');
/*!40000 ALTER TABLE `ctacja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faltantes`
--

DROP TABLE IF EXISTS `faltantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faltantes` (
  `idFaltante` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `uniCpr` float NOT NULL,
  `cantidad` float NOT NULL,
  `procesado` bit(1) NOT NULL,
  `idOcCab` int(11) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `idVentasC` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`idFaltante`),
  UNIQUE KEY `idFaltante` (`idFaltante`),
  KEY `idArticulo` (`idArticulo`),
  KEY `idOcCab` (`idOcCab`),
  KEY `fk_falt_cli` (`idCliente`),
  CONSTRAINT `faltantes_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`),
  CONSTRAINT `faltantes_ibfk_2` FOREIGN KEY (`idOcCab`) REFERENCES `occab` (`idOcCab`),
  CONSTRAINT `fk_falt_cli` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faltantes`
--

LOCK TABLES `faltantes` WRITE;
/*!40000 ALTER TABLE `faltantes` DISABLE KEYS */;
/*!40000 ALTER TABLE `faltantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `familias`
--

DROP TABLE IF EXISTS `familias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `familias` (
  `idFamilia` int(11) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idFamilia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familias`
--

LOCK TABLES `familias` WRITE;
/*!40000 ALTER TABLE `familias` DISABLE KEYS */;
INSERT INTO `familias` VALUES
(1,'VARIOS','SUPER','2022-03-30 17:46:28','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,''),
(2,'RUBRO A','SUPER',NULL,'LEONZ_XP # Leonardo','SUPER','2025-12-11 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL),
(3,'RUBRO B','SUPER',NULL,'LEONZ_XP # Leonardo','SUPER','2025-12-11 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL),
(4,'RUBRO C','SUPER',NULL,'LEONZ_XP # Leonardo','SUPER','2025-12-11 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL),
(5,'RUBRO D','SUPER',NULL,'LEONZ_XP # Leonardo','SUPER','2025-12-11 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL),
(6,'RUBRO E','SUPER',NULL,'LEONZ_XP # Leonardo','SUPER','2025-12-11 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL);
/*!40000 ALTER TABLE `familias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_cfg`
--

DROP TABLE IF EXISTS `global_cfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_cfg` (
  `idGlobalCF` int(11) NOT NULL,
  `cfg_Key` varchar(10) NOT NULL,
  `cfg_Type` varchar(1) NOT NULL,
  `cfg_Value` varchar(255) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime NOT NULL DEFAULT '2014-01-01 00:00:00',
  `idHostAlta` varchar(60) NOT NULL DEFAULT 'LEONZ_XP #Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(60) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idGlobalCF`),
  UNIQUE KEY `idGlobalCFG` (`idGlobalCF`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_cfg`
--

LOCK TABLES `global_cfg` WRITE;
/*!40000 ALTER TABLE `global_cfg` DISABLE KEYS */;
INSERT INTO `global_cfg` VALUES
(1,'STK_MODULE','L','true','SUPER','2014-04-03 18:05:42','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,'FAC_MODULE','L','true','SUPER','2014-04-03 18:05:42','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'DERCLI_MRC','C','11,17,20,23,28,33,35,50,55,69,77,88,131,121,135,137','SUPER','2014-04-03 18:05:42','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4,'TRANS_PED','L','true','SUPER','2014-04-03 18:05:42','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,'BINLOGFMT','L','true','SUPER','2014-04-03 18:05:42','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(6,'DISTRIMAR','C','','SUPER','2014-04-03 18:06:32','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7,'DIST_PATCH','C','','SUPER','2014-04-03 18:06:32','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8,'NRC_AUTO','L','true','SUPER','2014-10-22 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL),
(9,'SISUR_DB','C',' ','SUPER','2014-10-13 10:28:43','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(10,'ENVIAR_OC','L','false','SUPER','2015-01-08 23:43:58','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL),
(11,'NOTIF_TAL','L','false','SUPER','2015-01-08 23:43:58','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(12,'CTRFCO_MAI','L','false','SUPER','2015-04-16 19:25:55','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(13,'CTRFCO_WSA','C','http://direccion_ws_mail','SUPER','2015-04-16 19:25:55','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(14,'INGFCFALT','L','false','SUPER','2015-02-20 00:00:00','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(15,'FEDEBUG','L','true','SUPER','2015-06-14 23:40:08','LDZ_PC1 # Leonardo','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(16,'FECUIT','C','20280456919','SUPER','2015-06-14 23:40:08','LDZ_PC1 # Leonardo','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(17,'FE_FILE','C','20280456919.pfx','SUPER','2015-06-14 23:40:08','LDZ_PC1 # Leonardo','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(18,'FE_LIC','C','','SUPER','2015-06-14 23:40:09','LDZ_PC1 # Leonardo','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(19,'FE_PWD','C','2048','SUPER','2015-06-14 23:40:09','LDZ_PC1 # Leonardo','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(20,'FE_TICKACC','C','D:\\sistemas\\lg-v1-dev\\archivos-afip\\ticket\\ticket.txt','SUPER','2015-07-03 12:51:22','LDZ_PC1 # Leonardo','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(21,'CLI_CF','N','1','SUPER','2015-07-09 09:15:02','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(22,'PRG','N','12','SUPER','2015-08-07 15:54:28','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(23,'VERFOTODER','L','false','SUPER','2015-10-09 13:26:28','SIS-01',NULL,NULL,NULL,NULL,NULL,NULL),
(24,'PRINT_RTO','L','true','SUPER','2016-02-06 07:35:06','ESCRIPTIRIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(25,'IVA_1','N','21','SUPER','2016-10-05 23:17:29','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(26,'IVA_2','F','10.5','SUPER','2016-10-05 23:17:30','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(27,'PAGCTDO','L','true','SUPER','2019-12-23 09:11:43','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(28,'FACPDFPATH','C','D:\\sistemas\\lg-v1-dev\\archivos-afip\\cbtes\\','SUPER','2020-04-14 15:56:50','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(29,'EMAILSMTP','C','c0050506.ferozo.com','SUPER','2020-04-14 15:58:12','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(30,'EMAILPORT','N','465','SUPER','2020-04-14 15:58:12','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(31,'EMAILSSL','L','true','SUPER','2020-04-14 15:58:12','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(32,'EMAILEMP','C','LINFOW DESA','SUPER','2020-04-14 15:58:12','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(33,'EMAILADDR','C','no-reply@c0050506.ferozo.com','SUPER','2020-04-14 15:58:12','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(34,'EMAILUSR','C','no-reply@c0050506.ferozo.com','SUPER','2020-04-14 15:58:12','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(35,'EMAILPWD','C','EkWTtS4NGv','SUPER','2020-04-14 15:58:12','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(36,'EMAILFIRMA','C','LINFOW GestiÃ³n DESA','SUPER','2020-04-14 15:58:12','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(37,'FACITMCANT','N','0','SUPER','2020-05-26 10:15:43','ESCRITORIO',NULL,NULL,NULL,NULL,NULL,NULL),
(38,'USECOBMOS','L','false','SUPER','2020-07-01 19:25:26','ESCRITORIO',NULL,NULL,NULL,NULL,NULL,NULL),
(39,'INGSTKCOMP','L','false','SUPER','2020-07-13 15:47:58','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(40,'TRANSP_DEF','N','1','SUPER','2020-07-13 15:48:32','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(41,'CBTEACTPRE','L','false','SUPER','2020-07-27 16:33:19','ESCRITORIO',NULL,NULL,NULL,NULL,NULL,NULL),
(42,'CPADIAS','N','45','SUPER','2020-07-27 16:36:43','ESCRITORIO',NULL,NULL,NULL,NULL,NULL,NULL),
(43,'FETLS','N','12','SUPER','2020-09-23 10:00:46','ESCRITORIO','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(44,'FCIMPDNI','N','100000','SUPER','2020-09-23 10:01:52','ESCRITORIO',NULL,NULL,NULL,NULL,NULL,NULL),
(45,'QRPATH','C','D:\\sistemas\\lg-v1-dev\\archivos-afip\\qr\\','SUPER','2021-03-06 19:06:57','ESCRITORIO # Leonardo','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(46,'EMPFANT','C','DESARROLLO','SUPER','2021-03-06 19:08:22','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(47,'EMPRAZSOC','C','DESARROLLO','SUPER','2021-03-06 19:08:22','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(48,'EMPCUIT','C','20-28045691-9','SUPER','2021-03-06 19:08:22','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(49,'EMPIIBB','C','20-28045691-9','SUPER','2021-03-06 19:08:23','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(50,'EMPDIREC','C','RUTA 226 KM 282,5','SUPER','2021-03-06 19:08:23','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(51,'EMPCODPOS','C','7400','SUPER','2021-03-06 19:08:23','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(52,'EMPLOC','C','OLAVARRIA','SUPER','2021-03-06 19:08:23','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(53,'EMPPCIA','C','BUENOS AIRES','SUPER','2021-03-06 19:08:23','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(54,'EMPINIACT','C','11/2014','SUPER','2021-03-06 19:08:23','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(55,'EMPIVA','C','IVA RESPONSABLE INSCRIPTO','SUPER','2021-03-06 19:08:23','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(56,'EMPIDIVA','N','1','SUPER','2021-03-06 19:08:23','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(57,'EMAILCC','C','ldz.software@gmail.com','SUPER','2021-04-07 11:39:05','ESCRITORIO # Leonardo','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(58,'UPDSQLLOC','L','true','ROOT','2021-07-27 19:28:48','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(59,'UPDSQLPATH','C','D:\\sistemas\\lg-v1-dev\\bd-linfow-gestion\\sp','ROOT','2021-07-27 19:29:14','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(60,'MODODESA','L','true','ROOT','2021-09-16 13:25:54','LINFOW GESTION # Upgrade','DESA','2022-03-30 11:23:22','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(61,'UPD_URL','C','D:\\sistemas\\lg-v1-dev\\deploys\\linfow_gestion\\','ROOT','2021-09-23 12:23:59','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(62,'UPD_EXEC1','C','linfow_gestion.exe','ROOT','2021-09-23 12:23:59','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(63,'UPD_EXEC2','C','linfow_gestion_demo.exe','ROOT','2021-09-23 12:23:59','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(64,'TEMPDIR','C','D:\\Temp\\lf-v1-db\\','ROOT','2021-10-14 08:10:45','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(65,'FTPHOST','C','','ROOT','2021-10-14 08:10:45','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(66,'FTPUSER','C','','ROOT','2021-10-14 08:10:45','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(67,'FTPPASS','C','','ROOT','2021-10-14 08:10:45','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(68,'FTPPORT','C','','ROOT','2021-10-14 08:10:45','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(69,'FTPINIDIR','C','','ROOT','2021-10-14 08:10:45','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(70,'USA_SFTP','L','true','ROOT','2021-10-14 08:10:45','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(71,'URLUPDATER','C','','ROOT','2021-10-14 08:10:45','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(72,'FELOCAL','L','true','ROOT','2021-12-14 11:39:26','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(73,'FETKDIRFTP','C','/var/www/html/wsafip/ticket/desa','ROOT','2021-12-14 11:39:26','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(74,'PTOINCIVA','L','true','ROOT','2022-10-04 12:04:15','LINFOW GESTION # Upgrade','DESA','2023-02-09 17:54:46','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(75,'RCIMPSEL','L','false','ROOT','2022-10-04 12:04:15','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(76,'FE_IVAREC','L','true','ROOT','2025-03-13 09:03:21','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(77,'FCDESC1','L','true','ROOT','2025-04-11 09:14:07','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(78,'FCDESC2','L','true','ROOT','2025-04-11 09:14:07','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(79,'FCDESC3','L','true','ROOT','2025-04-11 09:14:07','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(80,'FCDESC4','L','true','ROOT','2025-04-11 09:14:07','LINFOW GESTION # Upgrade','DESA','2026-02-10 10:10:16','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(81,'MODOMOST','L','false','ROOT','2025-12-01 09:18:47','LINFOW GESTION # Upgrade',NULL,NULL,NULL,NULL,NULL,NULL),
(82,'RTPIMPXFC','L','false','ROOT','2025-12-17 17:41:45','LINFOW GESTION # Upgrade',NULL,NULL,NULL,NULL,NULL,NULL),
(83,'RTOIMPXFC','L','false','ROOT','2025-12-17 17:46:25','LINFOW GESTION # Upgrade',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `global_cfg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hojas`
--

DROP TABLE IF EXISTS `hojas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hojas` (
  `idHoja` int(11) NOT NULL,
  `idPlanilla` int(11) NOT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idHoja`,`idPlanilla`),
  KEY `idPlanilla` (`idPlanilla`),
  CONSTRAINT `hojas_ibfk_1` FOREIGN KEY (`idPlanilla`) REFERENCES `planillas` (`idPlanilla`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hojas`
--

LOCK TABLES `hojas` WRITE;
/*!40000 ALTER TABLE `hojas` DISABLE KEYS */;
INSERT INTO `hojas` VALUES
(1,1,'Hoja1');
/*!40000 ALTER TABLE `hojas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impresoras`
--

DROP TABLE IF EXISTS `impresoras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impresoras` (
  `idImpres` int(11) NOT NULL,
  `idNum` int(11) NOT NULL,
  `hostName` varchar(50) NOT NULL,
  `impresora` varchar(100) NOT NULL,
  `copias` int(11) NOT NULL DEFAULT 0,
  `usa_ticket` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`idImpres`),
  UNIQUE KEY `idImpres` (`idImpres`),
  KEY `idNum` (`idNum`),
  CONSTRAINT `impresoras_ibfk_1` FOREIGN KEY (`idNum`) REFERENCES `numerador` (`idNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impresoras`
--

LOCK TABLES `impresoras` WRITE;
/*!40000 ALTER TABLE `impresoras` DISABLE KEYS */;
INSERT INTO `impresoras` VALUES
(1,1,'ESCRITORIO # Leonardo','Bullzip PDF Printer',1,'\0'),
(2,2,'ESCRITORIO # Leonardo','Microsoft Print to PDF',1,'\0'),
(3,3,'ESCRITORIO # Leonardo','Microsoft Print to PDF',1,'\0'),
(4,4,'ESCRITORIO # Leonardo','Microsoft Print to PDF',1,'\0'),
(5,5,'ESCRITORIO # Leonardo','Microsoft Print to PDF',1,'\0'),
(6,6,'ESCRITORIO # Leonardo','Microsoft Print to PDF',1,'\0'),
(7,7,'ESCRITORIO # Leonardo','Microsoft Print to PDF',1,'\0'),
(8,8,'ESCRITORIO # Leonardo','Microsoft Print to PDF',1,'\0'),
(9,9,'ESCRITORIO # Leonardo','Microsoft Print to PDF',1,'\0'),
(10,14,'ESCRITORIO # Leonardo','Microsoft Print to PDF',1,'\0'),
(11,1,'LEO_NOTEBOOK # LINFOW','Microsoft Print to PDF',1,'\0'),
(12,2,'LEO_NOTEBOOK # LINFOW','Microsoft Print to PDF',1,'\0'),
(13,3,'LEO_NOTEBOOK # LINFOW','Microsoft Print to PDF',1,'\0'),
(14,4,'LEO_NOTEBOOK # LINFOW','Microsoft Print to PDF',1,'\0'),
(15,5,'LEO_NOTEBOOK # LINFOW','Microsoft Print to PDF',1,'\0'),
(16,6,'LEO_NOTEBOOK # LINFOW','Microsoft Print to PDF',1,'\0'),
(17,8,'LEO_NOTEBOOK # LINFOW','Microsoft Print to PDF',1,'\0'),
(18,9,'LEO_NOTEBOOK # LINFOW','Microsoft Print to PDF',1,'\0'),
(19,14,'LEO_NOTEBOOK # LINFOW','Microsoft Print to PDF',1,'\0'),
(20,1,'LINFOW-PRINCIPA # Usuario','Adobe PDF',1,'\0'),
(21,14,'LINFOW-PRINCIPA # Usuario','Bullzip PDF Printer',1,'\0'),
(22,38,'LINFOW-PRINCIPA # Usuario','Adobe PDF',1,'\0'),
(23,3,'LINFOW-PRINCIPA # Usuario','Adobe PDF',1,'\0'),
(24,4,'LINFOW-PRINCIPA # Usuario','Adobe PDF',1,'\0'),
(25,5,'LINFOW-PRINCIPA # Usuario','Adobe PDF',1,'\0'),
(26,6,'LINFOW-PRINCIPA # Usuario','Adobe PDF',1,'\0'),
(27,8,'LINFOW-PRINCIPA # Usuario','Adobe PDF',1,'\0'),
(28,9,'LINFOW-PRINCIPA # Usuario','Adobe PDF',1,'\0');
/*!40000 ALTER TABLE `impresoras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localidad`
--

DROP TABLE IF EXISTS `localidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `localidad` (
  `idLocalid` int(11) NOT NULL,
  `idProvin` int(11) NOT NULL,
  `idPais` int(11) NOT NULL,
  `codPostal` varchar(10) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idLocalid`),
  KEY `fk_Localidades_Provincias` (`idProvin`),
  KEY `fk_localidad_paises1_idx` (`idPais`),
  CONSTRAINT `fk_Localidades_Provincias` FOREIGN KEY (`idProvin`) REFERENCES `provincias` (`idProvin`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_localidad_paises1` FOREIGN KEY (`idPais`) REFERENCES `paises` (`idPais`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localidad`
--

LOCK TABLES `localidad` WRITE;
/*!40000 ALTER TABLE `localidad` DISABLE KEYS */;
INSERT INTO `localidad` VALUES
(1,1,1,'1761','20 DE JUNIO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,1,1,'6660','25 DE MAYO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,1,1,'6500','9 DE JULIO ESTAFETA Nº2','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(6,1,1,'6500','9 DE JULIO (PARTIDO NUEVE DE JULIO)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(11,1,1,'1640','ACASSUSO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(38,1,1,'6634','ALBERTI','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(68,1,1,'1617','GENERAL PACHECHO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo','SUPER','2021-08-20 00:00:00','SERVER # mgcarburacion',NULL,NULL,NULL),
(70,1,1,'7303','ALTONA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(102,1,1,'2740','ARRECIFES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(360,1,1,'7165','AUTOCAMPING EL PINAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(362,1,1,'1870','AVELLANEDA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(368,1,1,'7300','AZUL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(373,1,1,'8000','BAHIA BLANCA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(378,1,1,'7620','BALCARCE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(401,1,1,'1665','BARRIO 9 DE JULIO (JOSE C. PAZ, PDO. GRAL. SARMIENTO)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(405,1,1,'1714','BARRIO AERONAUTICO (ITUZAINGO, PDO. MORON)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(429,1,1,'1611','BARRIO BAIRES - NO VA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo','SUPER','2021-08-20 00:00:00','SERVER # mgcarburacion',NULL,NULL,NULL),
(433,1,1,'1619','BARRIO BELIERA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,'SUPER','2020-01-24 00:00:00','MG # betiana'),
(455,1,1,'6600','BARRIO DE LA CARCEL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(582,1,1,'1763','BARRIO LA RECOLETA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(726,1,1,'1617','BARRIO RICARDO ROJAS (GRAL. PACHECO, PDO. TIGRE)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(750,1,1,'1646','BARRIO SAN JORGE (SAN FERNANDO, PDO. SAN FERNANDO)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(790,1,1,'6700','BARRIO SANTA MARTA (LUJAN, PDO.LUJAN)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(860,1,1,'1625','BELEN DE ESCOBAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(865,1,1,'1621','BENAVIDEZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(871,1,1,'1884','BERAZATEGUI','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(901,1,1,'6550','BOLIVAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(909,1,1,'1609','BOULOGNE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(913,1,1,'6640','BRAGADO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(954,1,1,'2804','CAMPANA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1026,1,1,'2812','CAPILLA DEL SEÑOR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1029,1,1,'2752','CAPITAN SARMIENTO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1046,1,1,'8504','CARMEN DE PATAGONES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1051,1,1,'1678','CASEROS ESTAFETA NO.1','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1053,1,1,'1678','CASEROS (PDO. 3 DE FEBRERO)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1056,1,1,'7114','CASTELLI','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1187,1,1,'8150','CORONEL DORREGO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1198,1,1,'7540','CORONEL SUAREZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1229,1,1,'6740','CHACABUCO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1238,1,1,'7130','CHASCOMUS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1246,1,1,'6620','CHIVILCOY','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1256,1,1,'6555','DAIREAUX','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1266,1,1,'1669','DEL VISO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1299,1,1,'1611','DON TORCUATO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1370,1,1,'1684','EL PALOMAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1409,1,1,'1617','EL TALAR - NO VA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo','SUPER','2021-08-20 00:00:00','SERVER # mgcarburacion',NULL,NULL,NULL),
(1453,1,1,'1625','ESCOBAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1537,1,1,'8160','TORNQUIST','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo','SUPER','2015-09-14 00:00:00','SERVER # mgcarburacion',NULL,NULL,NULL),
(1575,1,1,'1619','GARIN','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1581,1,1,'7263','GENERAL ALVEAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1606,1,1,'1748','GENERAL RODRIGUEZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1616,1,1,'1824','GERLI (PDO. LANUS)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1657,1,1,'1615','GRAND BOURG','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1708,1,1,'6465','HENDERSON','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1714,1,1,'7318','HINOJO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1748,1,1,'1623','INGENIERO MASCHWITZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1750,1,1,'1613','INGENIERO PABLO NOGUES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1766,1,1,'1765','ISIDRO CASANOVA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1799,1,1,'1665','JOSE C. PAZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1813,1,1,'1702','JOSE INGENIEROS (PDO. 3 DE FEBRERO)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1818,1,1,'1846','JOSE MARMOL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1846,1,1,'6000','JUNIN','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1886,1,1,'1615','KILOMETRO 38 (PDO. GRAL. SARMIENTO)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2033,1,1,'1669','LA LONJA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2084,1,1,'1900','LA PLATA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2227,1,1,'7200','LAS FLORES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2232,1,1,'1741','LAS HERAS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2269,1,1,'7116','LEZAMA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2285,1,1,'7240','LOBOS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2306,1,1,'1752','LOMAS DEL MIRADOR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2323,1,1,'2814','LOS CARDALES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2350,1,1,'1613','LOS POLVORINES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2354,1,1,'1621','LOS SANTOS VIEJOS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,'SUPER','2020-01-24 00:00:00','MG # betiana'),
(2356,1,1,'6015','LOS TOLDOS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2363,1,1,'6700','LUJAN','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2381,1,1,'1667','MANUEL ALBERTI (APEADERO FCGB)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2392,1,1,'1619','MAQUINISTA FRANCISCO SAVIO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2394,1,1,'7109','MAR DE AJO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2448,1,1,'7108','MAR DEL TUYU','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2450,1,1,'1727','MARCOS PAZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2470,1,1,'1640','MARTINEZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2476,1,1,'1640','MARTINEZ ESTAFETA NO.6','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2480,1,1,'1627','MATHEU','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2499,1,1,'8132','MEDANOS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2503,1,1,'6600','MERCEDES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2511,1,1,'1722','MERLO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2534,1,1,'2743','MONROE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2537,1,1,'7220','MONTE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2562,1,1,'1744','MORENO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2586,1,1,'7404','MUÑOZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2587,1,1,'1605','MUNRO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2594,1,1,'6605','NAVARRO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2596,1,1,'7630','NECOCHEA ESTAFETA Nº1','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2619,1,1,'6663','NORBERTO DE LA RIESTRA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2625,1,1,'1648','NUEVO PUERTO TIGRE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2628,1,1,'7400','OLAVARRIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2655,1,1,'1657','PABLO PODESTA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2705,1,1,'6503','PATRICIOS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2716,1,1,'6450','PEHUAJO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2728,1,1,'2700','PERGAMINO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2747,1,1,'8170','PIGUE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2749,1,1,'1629','PILAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2751,1,1,'7167','PINAMAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2790,1,1,'8180','PUAN','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2805,1,1,'6620','PUENTE BATALLA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2811,1,1,'1602','PUENTE SAAVEDRA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2826,1,1,'8109','PUNTA ALTA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2828,1,1,'1623','PUNTA DE CANAL (APEADERO FCGM)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,'SUPER','2020-01-24 00:00:00','MG # betiana'),
(2844,1,1,'1878','QUILMES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2869,1,1,'1704','RAMOS MEJIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2885,1,1,'1826','REMEDIOS DE ESCALADA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2925,1,1,'2705','ROJAS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2931,1,1,'7245','ROQUE PEREZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2949,1,1,'1619','RUTA 26 MAQUINISTA FRANCISCO SAVIO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,'SUPER','2020-01-24 00:00:00','MG # betiana'),
(2963,1,1,'8174','SAAVEDRA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2968,1,1,'7260','SALADILLO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2976,1,1,'2741','SALTO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2985,1,1,'6720','SAN ANDRES DE GILES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2992,1,1,'7111','SAN BERNARDO (PARTIDO DE LA COSTA)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2997,1,1,'7105','SAN CLEMENTE DEL TUYU','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3026,1,1,'1642','SAN ISIDRO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3032,1,1,'1642','SAN ISIDRO ESTAFETA Nº6','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3033,1,1,'7400','SAN JACINTO (OLAVARRIA, PDO. OLAVARRIA)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3049,1,1,'1754','SAN JUSTO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3053,1,1,'1650','SAN MARTIN (PDO. GRAL. SAN MARTIN)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3056,1,1,'1663','SAN MIGUEL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3080,1,1,'2930','SAN PEDRO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3102,1,1,'7609','SANTA CLARA DEL MAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3127,1,1,'7107','SANTA TERESITA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3137,1,1,'1688','SANTOS TESEI','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3169,1,1,'6612','SUIPACHA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3177,1,1,'7000','TANDIL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3178,1,1,'7000','TANDIL ESTAFETA Nº1','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3183,1,1,'7303','TAPALQUE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3188,1,1,'1834','TEMPERLEY','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3200,1,1,'1648','TIGRE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3216,1,1,'1667','TORTUGUITAS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3217,1,1,'6400','TRENQUE LAUQUEN','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3220,1,1,'7500','TRES ARROYOS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3254,1,1,'7167','VALERIA DE MAR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3269,1,1,'1638','VICENTE LOPEZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3271,1,1,'1644','VICTORIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3301,1,1,'1665','VILLA BARRIO ALTUBE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3341,1,1,'1669','VILLA DEL CARMEN (DEL VISO, PDO. GRAL. SARMIENTO)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3356,1,1,'1704','VILLA DON BOSCO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3383,1,1,'7165','VILLA GESELL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3450,1,1,'1650','VILLA LIBERTAD','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3457,1,1,'1754','VILLA LUZURIAGA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3459,1,1,'1672','VILLA LYNCH (PDO. GRAL. SAN MARTIN)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3461,1,1,'1768','VILLA MADERO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3467,1,1,'1650','VILLA MAIPU','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3474,1,1,'1603','VILLA MARTELLI','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3490,1,1,'1744','VILLA MONSEGUR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3524,1,1,'1900','VILLA RIVERA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3525,1,1,'1631','VILLA ROSA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3551,1,1,'1676','VILLA SANTOS LUGARES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3560,1,1,'8000','VILLA SOLDATI','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3570,1,1,'1625','VILLA VALLIER','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3573,1,1,'7600','VILLA VIGNOLO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3583,1,1,'1646','VIRREYES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3593,1,1,'1875','WILDE ESTE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3599,1,1,'1727','ZAMUDIO (APEADERO FCDFS)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3603,1,1,'2800','ZARATE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3607,1,1,'2800','ZARATE ESTAFETA Nº4','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4277,2,1,'5317','RETIRO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4308,2,1,'4700','SAN FERNANDO DEL VALLE DE CATAMARCA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4792,3,1,'3500','RESISTENCIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4906,4,1,'9210','BUENOS AIRES CHICO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4969,4,1,'9005','COMODORO RIVADAVIA (SUC. BARRIO GRAL. ENRIQUE MOSCONI)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5042,4,1,'9200','ESQUEL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5203,4,1,'9120','PUERTO MADRYN','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7640,5,1,'5000','VILLA REVOL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7683,6,1,'3445','9 DE JULIO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7796,6,1,'3432','BELLA VISTA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7960,6,1,'3400','CORRIENTES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7989,6,1,'3460','CURUZU-CUATIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8055,6,1,'3418','EMPEDRADO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8065,6,1,'3196','ESQUINA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8105,6,1,'3450','GOYA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8141,6,1,'3480','ITA-IBATE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8232,6,1,'3346','LA CRUZ (DPTO. SAN MARTIN)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8401,6,1,'3470','MERCEDES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8408,6,1,'3226','MOCORETA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8411,6,1,'3220','MONTE CASEROS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8485,6,1,'3230','PASO DE LOS LIBRES','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8506,6,1,'3461','PERUGORRIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8595,6,1,'3420','SALADAS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8705,6,1,'3448','SAN ROQUE (DPTO. SAN ROQUE)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo','SUPER','2021-03-23 00:00:00','SERVER # mgcarburacion',NULL,NULL,NULL),
(8734,6,1,'3440','SANTA LUCIA (DPTO. LAVALLE)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8748,6,1,'3421','SANTA ROSA (DPTO.CONCEPCION)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8895,7,1,'3150','NOGOYA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8919,7,1,'2826','ALDEA SAN ANTONIO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9058,7,1,'3170','BASAVILBASO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9069,7,1,'3142','BOVRIL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9096,7,1,'3262','CASEROS','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9107,7,1,'3280','COLON','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9136,7,1,'3122','COLONIA CERRITO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9268,7,1,'3260','CONCEPCION DEL URUGUAY','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9269,7,1,'3200','CONCORDIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9280,7,1,'3116','CRESPO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9294,7,1,'3228','CHAJARI','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9397,7,1,'3206','FEDERACION','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9398,7,1,'3180','FEDERAL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9411,7,1,'2843','GENERAL GALARZA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9414,7,1,'3164','GENERAL RAMIREZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9425,7,1,'2840','GUALEGUAY','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9426,7,1,'2820','GUALEGUAYCHU','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9435,7,1,'3272','HERRERA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9570,7,1,'3190','LA PAZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9589,7,1,'2854','LARROQUE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9634,7,1,'3158','LUCAS GONZALEZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9643,7,1,'3177','MACIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9648,7,1,'3133','MARIA GRANDE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9678,7,1,'3100','ORO VERDE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9692,7,1,'3100','PARANA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9715,7,1,'2854','PEHUAJO SUD','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9764,7,1,'3105','PUERTO DIAMANTE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9816,7,1,'3174','ROSARIO DEL TALA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9828,7,1,'3107','SAN BENITO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9837,7,1,'3185','SAN JAIME DE LA FRONTERA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9839,7,1,'3187','SAN JOSE DE FELICIANO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9840,7,1,'3283','SAN JOSE (DPTO. COLON)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9855,7,1,'3218','SAN SALVADOR','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9863,7,1,'3192','SANTA ELENA (DPTO. LA PAZ)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9879,7,1,'3150','SAUCE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9897,7,1,'3101','STROBEL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9901,7,1,'3200','TABLADA OESTE, CONCORDIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9921,7,1,'2826','URDINARRAIN','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9923,7,1,'3101','VALLE MARIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9925,7,1,'3109','VIALE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9927,7,1,'3153','VICTORIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9936,7,1,'3265','VILLA ELISA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9942,7,1,'3103','VILLA LIBERTADOR GENERAL SAN MARTIN','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9943,7,1,'2820','VILLA LILA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9959,7,1,'3240','VILLAGUAY','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(11047,10,1,'8200','GENERAL ACHA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(11475,10,1,'6300','SANTA ROSA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(11490,10,1,'6303','TOAY','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(13716,15,1,'8520','SAN ANTONIO OESTE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(13744,15,1,'8532','SIERRA GRANDE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(13764,15,1,'8500','VIEDMA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(16842,20,1,'3001','COLASTINE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(17379,20,1,'3014','POMPEYA (APEADERO FCGB)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(17415,20,1,'3560','RECONQUISTA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(17436,20,1,'2000','ROSARIO','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(17498,20,1,'3000','SANTA FE','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(18334,21,1,'4230','KILOMETRO 1073 (APEADERO FCGB)','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(18820,21,1,'4201','NUÑEZ','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(19497,21,1,'4200','VILLA GRIMANESA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20521,23,1,'4000','SAN MIGUEL DE TUCUMAN','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20640,23,1,'4000','VILLA AMALIA','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20643,1,1,'1419','CAPITAL FEDERAL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20644,1,1,'1416','CAPITAL FEDERAL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20645,1,1,'1440','CAPITAL FEDERAL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20646,1,1,'1414','CAPITAL FEDERAL','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20647,4,1,'9100','TRELEW','SUPER','2017-02-09 08:37:39','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(20648,1,1,'1618','EL TALAR','SUPER','2017-02-14 15:29:08','MOSTRADOR2 # Propietario',NULL,NULL,NULL,NULL,NULL,''),
(20649,1,1,'1107','CABA','SUPER','2017-10-05 15:56:18','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(20650,1,1,'1009','CIUDAD AUTONOMA BUENOS AIRES','SUPER','2017-12-26 15:34:25','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(20652,1,1,'1431','CIUDAD AUTONOMA BUENOS AIRES','SUPER','2020-02-17 15:38:19','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(20653,1,1,'1427','BUENOS AIRES NORTE COMUNA 15','SUPER','2020-07-24 10:35:54','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(20654,8,1,'3600','FORMOSA CAPITAL','SUPER','2021-09-15 17:20:00','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(20655,17,1,'5413','VILLA PAULA','SUPER','2021-10-19 11:21:50','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(20656,23,1,'4146','CONCEPCION','SUPER','2021-10-25 08:41:14','SERVER-NUEVO # usuario',NULL,NULL,NULL,NULL,NULL,''),
(20657,5,1,'2400','SAN FRANCISCO','SUPER','2021-11-08 14:44:49','SERVER-NUEVO # usuario',NULL,NULL,NULL,NULL,NULL,''),
(20658,1,1,'4401','VILLA SAN LORENZO','SUPER','2021-11-27 09:04:38','SERVER-NUEVO # usuario',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `localidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_sps`
--

DROP TABLE IF EXISTS `log_sps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_sps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sp_name` varchar(60) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `msgerror` text NOT NULL,
  `usuario` varchar(5) NOT NULL,
  `host` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_sps`
--

LOCK TABLES `log_sps` WRITE;
/*!40000 ALTER TABLE `log_sps` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_sps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logupdcat`
--

DROP TABLE IF EXISTS `logupdcat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logupdcat` (
  `idUpdCat` int(11) NOT NULL,
  `descripcio` varchar(30) NOT NULL,
  `accion` varchar(30) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `bonif1` float(10,2) NOT NULL,
  `bonif2` float(10,2) NOT NULL,
  `bonif3` float(10,2) NOT NULL,
  `bonif4` float(10,2) NOT NULL,
  `margenMay` float(10,2) NOT NULL,
  `margenMin` float(10,2) NOT NULL,
  `prListaAnt` float(10,2) NOT NULL,
  `prListaNew` float(10,2) NOT NULL,
  `porVar` float(10,2) NOT NULL,
  PRIMARY KEY (`idUpdCat`),
  UNIQUE KEY `idUpdCat` (`idUpdCat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logupdcat`
--

LOCK TABLES `logupdcat` WRITE;
/*!40000 ALTER TABLE `logupdcat` DISABLE KEYS */;
/*!40000 ALTER TABLE `logupdcat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marcas` (
  `idmarca` int(11) NOT NULL,
  `descripcio` varchar(60) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idmarca`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES
(1,'VARIOS','SUPER','2022-03-30 17:46:43','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,''),
(2,'MARCA A','SUPER',NULL,'LEONZ_XP # Leonardo','SUPER','2025-12-11 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL),
(3,'MARCA B','SUPER',NULL,'LEONZ_XP # Leonardo','SUPER','2025-12-11 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL),
(4,'MARCA C','SUPER',NULL,'LEONZ_XP # Leonardo','SUPER','2025-12-11 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL);
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas_v`
--

DROP TABLE IF EXISTS `marcas_v`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marcas_v` (
  `idMarcaV` int(11) NOT NULL,
  `descripcio` varchar(30) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(60) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(60) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idMarcaV`),
  UNIQUE KEY `idMarcaV` (`idMarcaV`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas_v`
--

LOCK TABLES `marcas_v` WRITE;
/*!40000 ALTER TABLE `marcas_v` DISABLE KEYS */;
INSERT INTO `marcas_v` VALUES
(1,'FIAT','SUPER','2015-05-05 16:08:06','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(2,'FORD','SUPER','2015-05-05 16:08:17','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(3,'CHEVROLET','SUPER','2015-05-05 16:08:34','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(4,'ALFA ROMEO','SUPER','2015-05-05 16:13:35','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(5,'AUDI','SUPER','2015-05-05 16:13:49','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(6,'CHRYSLER','SUPER','2015-05-05 16:16:34','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(7,'DAEWOO','SUPER','2015-05-05 16:16:52','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(8,'DODGE','SUPER','2015-05-05 16:17:09','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(9,'HONDA','SUPER','2015-05-05 16:17:22','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(10,'HYUNDAI','SUPER','2015-05-05 16:17:39','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(11,'JEEP','SUPER','2015-05-05 16:17:52','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(12,'KIA','SUPER','2015-05-05 16:18:04','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(13,'MAZDA','SUPER','2015-05-05 16:20:33','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(14,'MERCEDES BENZ','SUPER','2015-05-05 16:20:51','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(15,'MITSUBISHI','SUPER','2015-05-05 16:21:09','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(16,'NISSAN','SUPER','2015-05-05 16:21:20','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(17,'PEUGEOT','SUPER','2015-05-05 16:21:33','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(18,'RENAULT','SUPER','2015-05-05 16:21:45','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(19,'ROVER','SUPER','2015-05-05 16:22:06','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(20,'SEAT','SUPER','2015-05-05 16:22:16','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(21,'SUZUKI','SUPER','2015-05-05 16:22:29','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(22,'TOYOTA','SUPER','2015-05-05 16:22:41','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(23,'VOLKSWAGEN','SUPER','2015-05-05 16:22:59','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,''),
(24,'VOLVO','SUPER','2015-05-05 16:23:14','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `marcas_v` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menues`
--

DROP TABLE IF EXISTS `menues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menues` (
  `idMenue` int(11) NOT NULL,
  `CodMenu` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nombre` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Procedim` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `IsChild` bit(1) NOT NULL,
  `Enlace` int(11) NOT NULL,
  `acc_key` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(60) NOT NULL DEFAULT '',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(60) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idMenue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menues`
--

LOCK TABLES `menues` WRITE;
/*!40000 ALTER TABLE `menues` DISABLE KEYS */;
INSERT INTO `menues` VALUES
(1,'1','Archivos','','\0',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1000),
(2,'1.1','Condiciones de Pago','DO FORM frmabmCondPag','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1001),
(3,'1.2','\\-','-','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1002),
(4,'1.3','Paises','DO FORM frmpaises','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1003),
(5,'1.4','Provincias','DO FORM frmabmprovincias','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1004),
(6,'1.5','Localidades','DO FORM frmabmlocalidades','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1005),
(7,'1.6','\\-','-','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1006),
(8,'1.7','Tipos de Clientes','DO FORM frmabmtiposcli','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1007),
(9,'1.8','Clientes','DO FORM frmabmClientes','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1008),
(10,'1.9','\\-','-','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1009),
(11,'1.10','Bancos','DO FORM frmbancos','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1010),
(12,'1.11','Plan de Cuentas','DO FORM frmconceptos','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1011),
(13,'1.12','\\-','-','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1012),
(14,'1.13','Proveedores','DO FORM frmabmProv','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1013),
(15,'1.14','Familias','DO FORM frmabmfamilias','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1014),
(16,'1.15','SubFamilias','DO FORM frmabmsubfamilias','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1015),
(17,'1.16','Marcas','DO FORM frmabmmarca','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1016),
(18,'1.17','Depósitos','DO FORM frmdepositos','',1,'','SUPER','2014-04-03 18:08:52','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1017),
(19,'1.18','Artículos','DO FORM frmabmArticulos','',1,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1018),
(20,'1.19','Descuentos','DO FORM frmartdtos','',1,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1019),
(21,'1.21','\\-','-','',1,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1021),
(22,'1.22','Vendedores','DO FORM frmabmvendedores','',1,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1022),
(23,'1.23','Transportes','DO FORM frmTransportes','',1,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1023),
(24,'2','Artículos','','\0',2,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2000),
(25,'2.1','Asignar Artículos a Depósitos','DO FORM frmasigdep','',2,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2001),
(26,'2.2','\\-','-','',2,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2002),
(27,'2.3','Importar Artículos','DO FORM frm_imp_precios','',2,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2003),
(28,'2.4','Actualización Masiva','DO FORM frm_actu_lista','',2,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2004),
(29,'2.5','Actualizar por Código','DO FORM frm_actu_byCodigo','',2,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2005),
(30,'2.6','Actualizar Precios desde Catálogos','DO FORM frmactu_catalogo_lista','',2,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2006),
(31,'3','Stock','','\0',3,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,3000),
(32,'3.1','Ingreso de Mercadería','DO FORM frm_ing_merc','',3,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,3001),
(33,'3.2','Control Físico de Mercadería','DO FORM frm_busq_rtos_ctrfis','',3,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,3002),
(34,'3.3','Ajustes de Stock','DO FORM frmIngMovStock','',3,'','SUPER','2014-04-03 18:08:53','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,3003),
(35,'3.4','\\-','-','',3,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,3004),
(36,'3.5','Listados','DO FORM frm_cons_stock','',3,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,3005),
(37,'4','Ventas','','\0',4,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4000),
(39,'4.1','Ingreso de Pedidos','DO FORM frmPedidos','',4,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4001),
(41,'4.2','Consulta y Baja de Pedidos','DO FORM frmConsBajaPed','',4,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4002),
(42,'4.5','\\-','-','',4,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4005),
(43,'4.6','Ingreso de Facturas','DO FORM frm_factura_fe','',4,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4006),
(44,'4.7','Ingreso de Nota de Crédito por Devolución','DO FORM frm_ncdev_fe','',4,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4007),
(46,'4.8','Consulta y Baja de Comprobantes','DO FORM frmConsBjaFC_SF','',4,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4008),
(47,'4.9','\\-','-','',4,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4009),
(48,'4.10','Listado de IVA Ventas','DO FORM frmivaventas','',4,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4010),
(49,'5','Cobranzas','','\0',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,5000),
(50,'5.1','Cuentas Corrientes','DO FORM frm_ctacte_fe','',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,5001),
(51,'5.2','Ingreso de Recibos','DO FORM frmRecibos','',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,5002),
(52,'5.4','\\-','-','',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,5004),
(53,'5.5','Ingreso de Cheques Utilizados','DO FORM frmchequesmarcarusado','',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,5005),
(54,'5.7','\\-','-','',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,5007),
(55,'5.8','Listado de Cheques en Cartera','DO FORM frmchequescar','',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,5008),
(56,'5.9','Listado de Cheques Utilizados','DO FORM frmchequesuti','',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,5009),
(57,'5.10','Listado de Cheques Rechazados','DO FORM frmchequesrech','',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,5010),
(58,'5.11','Listado de Cuentas Corrientes','DO FORM frmlistadoctacte','',5,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,5011),
(59,'6','Caja Diaria','','\0',6,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,6000),
(60,'6.1','Conceptos de Caja','DO FORM frm_conccj','',6,'','SUPER','2014-04-03 18:08:54','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,6001),
(61,'6.2','Cuentas de Caja','DO FORM frm_ctacja','',6,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,6002),
(62,'6.3','\\-','-','',6,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,6003),
(63,'6.4','Apertura de Caja','DO FORM frmabrircaja','',6,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,6004),
(64,'6.5','Ingreso de Pagos','DO FORM frmcaja','',6,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,6005),
(65,'6.6','Control de Caja','DO FORM frmcontrolcajader','',6,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,6006),
(66,'6.7','Cerrar Caja','DO FORM frmCerrarCaja','',6,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,6007),
(70,'8','Cotizaciones','','\0',8,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,8000),
(71,'8.1','Ingreso de Cotizaciones','DO FORM frmCotizacion','',8,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,8001),
(72,'8.2','Consulta y Baja de Cotizaciones','DO FORM frmConsBajaCot','',8,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,8002),
(73,'11','Sistemas','','\0',11,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,11000),
(74,'11.1','Usuarios','DO FORM frmabmusuarios','',11,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,11001),
(75,'11.2','Permisos','DO FORM frmPermisos','',11,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,11002),
(76,'11.3','\\-','-','',11,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,11003),
(77,'11.4','Parámetros','DO FORM frmConfiguracion','',11,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,11004),
(78,'2.8','\\-','-','',2,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2008),
(79,'2.9','Consulta de Artículos','DO FORM frm_cons_artic','',2,'','SUPER','2014-04-03 18:08:55','LEON_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2009),
(80,'11.8','\\-','-','',11,'','SUPER','2014-04-03 18:08:55','LEONZ_XP #Leonardo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,11008),
(81,'11.9','Talonarios','DO FORM frmabmtalonarios','',11,'','SUPER','2014-04-03 18:08:55','LEONZ_XP #Leonardo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,11009),
(82,'11.10','Menues','DO FORM frmabmmenues','',11,'','SUPER','2014-04-03 18:08:55','LEONZ_XP #Leonardo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,11010),
(83,'11.11','Configurar Excel por Proveedor','DO FORM frm_xls_config','',11,'','SUPER','2014-04-03 18:08:55','LEONZ_XP #Leonardo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,11011),
(84,'3.6','Consulta de Ingresos de Mercadería','DO FORM frmconsingresos','',3,'','SUPER','2014-09-28 00:00:00','PABLITO # pablo',NULL,NULL,NULL,NULL,NULL,NULL,3006),
(85,'2.10','Ofertas','DO FORM frm_ofertas','',2,'','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,NULL,NULL,NULL,2010),
(86,'5.6','Ingreso de Cheques Rechazados','DO FORM frmingchequesrech','',5,'','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,NULL,NULL,NULL,5006),
(87,'7','Presupuestos','','\0',7,'','SUPER','2014-09-29 00:00:00','PABLITO # pablo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,7000),
(88,'7.1','Ingreso de Presupuestos','DO FORM frm_pto_c2_v2','',7,'','SUPER','2014-09-29 00:00:00','PABLITO # pablo','SUPER','2023-02-09 00:00:00','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,7001),
(89,'7.2','Consulta y Baja de Presupuestos','DO FORM frmConsBajaPTO','',7,'','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,NULL,NULL,NULL,7002),
(90,'11.5','\\-','-','',11,'','SUPER','2014-09-29 00:00:00','PABLITO # pablo','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,11005),
(91,'11.6','Actualizar Padrón IIBB','DO FORM frm_padron_iibb','',11,'','SUPER','2014-09-29 00:00:00','PABLITO # pablo',NULL,NULL,NULL,NULL,NULL,NULL,11006),
(92,'2.7','Generar Archivo de Precios','DO FORM frm_exporttxt','',2,'','SUPER','2014-11-07 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,2007),
(93,'4.4','Pedidos Pendientes On-Line','DO FORM form_pedido_online','',4,'','SUPER','2014-11-07 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,4004),
(94,'11.7','Actualizar Web','DO actualizar_scw','',11,'','SUPER','2014-11-07 00:00:00','SIS-65','SUPER','2014-11-07 00:00:00','SIS-65',NULL,NULL,NULL,11007),
(95,'1.20','Unidades de Medida','do form frmabmunidmed.scx','',1,'','SUPER','2015-01-08 23:51:44','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1020),
(96,'9','Compras','','\0',9,'','SUPER','2014-12-05 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,9000),
(97,'9.1','Ingreso de Planificación de Compras','DO FORM frmplanif_cpr','',9,'','SUPER','2014-12-05 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,9001),
(98,'9.2','Modificación y Baja de Planificación','DO FORM frmplanif_cbcpr','',9,'','SUPER','2014-12-05 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,9002),
(99,'9.3','\\-','-','',9,'','SUPER','2014-12-05 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,9003),
(100,'9.4','Ingreso de Ordenes de Compra','DO FORM frming_oc','',9,'','SUPER','2014-12-05 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,9004),
(101,'9.5','Consulta de Ordenes de Compra','DO FORM frmconsulta_oc','',9,'','SUPER','2014-12-05 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,9005),
(102,'9.6','Consulta de Ordenes de Compra por Artículo','DO FORM frmconsulta_ocart','',9,'','SUPER','2014-12-05 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,9006),
(103,'9.7','Baja de Pendientes','DO FORM frmoc_bajapend','',9,'','SUPER','2014-12-05 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,9007),
(104,'4.11','\\-','','',4,'','SUPER','2015-01-21 19:46:59','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4011),
(105,'4.12','Comisiones de Vendedores','DO FORM frm_vnd_comisiones','',4,'','SUPER','2015-01-21 19:47:06','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4012),
(106,'2.12','\\-','-','',2,NULL,'SUPER','2015-02-06 13:49:57','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2012),
(107,'2.13','Administrador de Faltantes','DO FORM frm_adminfaltantes','',2,NULL,'SUPER','2015-02-06 13:49:58','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2013),
(108,'4.13','\\-','-','',4,'','SUPER','2015-02-12 23:25:52','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4013),
(109,'4.14','Rankings de Ventas','DO FORM frm_vtarep_rankings','',4,'','SUPER','2015-02-12 23:25:52','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4014),
(110,'2.11','Lista de precios impresa','DO FORM frm_listaprec_imprimir','',2,'','SUPER','2015-02-12 23:25:52','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2011),
(111,'2.14','Listado de faltantes por clientes','DO FORM frm_rep_faltbycli','',2,'','SUPER','2015-04-16 19:29:26','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,2014),
(112,'1.24','\\-','-','',1,'','SUPER','2015-04-16 19:30:10','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1024),
(113,'1.25','Marcas de Vehículos','DO FORM frmabmmarcasv','',1,'','SUPER','2015-04-16 19:30:10','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1025),
(114,'1.26','Ramos','DO FORM frmabmramos','',1,'','SUPER','2015-04-16 19:30:10','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,1026),
(115,'4.3','Control de Salida','DO FORM frm_ctrl_salida_ped','',4,'','SUPER','2015-04-16 19:30:59','LDZ_PC1 #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4003),
(116,'12','Listados','','\0',12,'','SUPER','2015-05-22 11:13:24','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,12000),
(117,'12.1','Nomina de clientes','DO FORM frm_listado_clientes','',12,'','SUPER','2015-05-22 11:13:24','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,12001),
(118,'4.15','\\-','','',4,'','SUPER','2015-06-14 23:59:15','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4015),
(119,'4.16','Autorizar Comprobantes','DO FORM frm_autoriza_cbte','',4,'','SUPER','2015-06-14 23:59:15','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,4016),
(120,'11.12','Configurar Impresoras','DO FORM frm_config_printer','',11,'','SUPER','2015-12-10 17:36:53','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,11012),
(121,'9.8','\\-','','',9,'','SUPER','2016-10-05 23:21:03','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,9008),
(122,'9.9','Ingreso de Facturas','DO FORM frm_cpas_ingcbte','',9,'','SUPER','2016-10-05 23:21:03','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,9009),
(123,'9.10','Consulta y Baja de Comprobantes','DO FORM frm_cb_cbtescpa','',9,'','SUPER','2016-10-05 23:21:03','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,9010),
(124,'9.11','\\-','','',9,'','SUPER','2016-10-05 23:21:03','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,9011),
(125,'9.12','Listado de IVA Compras','DO FORM frm_iva_cpas','',9,'','SUPER','2016-10-05 23:21:04','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,9012),
(126,'10','Pagos','','\0',10,'','SUPER','2016-10-05 23:21:04','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,10000),
(127,'10.1','Cuentas Corrientes Proveedores','DO FORM frm_ctacte_prov','',10,'','SUPER','2016-10-05 23:21:04','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,10001),
(128,'10.2','Ingresar Ordenes de Pago','DO FORM frm_orden_pago','',10,'','SUPER','2016-10-05 23:21:04','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,10002),
(129,'10.3','\\-','','',10,'','SUPER','2016-10-05 23:21:04','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,10003),
(130,'10.4','Listado de Cuentas Corrientes','DO FORM frm_listado_ccpv','',10,'','SUPER','2016-10-05 23:21:04','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,10004),
(131,'10.5','\\-','','',10,'','SUPER','2016-10-05 23:21:04','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,10005),
(132,'10.6','Alta de chequeras','DO FORM frm_alta_chequera','',10,'','SUPER','2016-10-05 23:21:04','LDZ_PC1 # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,10006),
(133,'5.3','Consulta y Baja de Recibos','DO FORM frm_recibos_cons','',5,'','SUPER','2017-03-09 16:05:36','ESCRITORIO',NULL,NULL,NULL,NULL,NULL,NULL,5003),
(134,'2.15','Actualizar desde Excel v2','DO FORM frm_xls_updater_v2','',2,'','SUPER','2018-03-27 11:10:40','ESCRITORIO # Leonardo','SUPER','2024-06-27 00:00:00','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,2015),
(136,'5.12','Verificar clientes morosos','DO FORM frm_clientes_morosos','',5,'','SUPER','2020-05-26 10:17:40','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,5012),
(137,'2.16','Controlar Precios','DO FORM frm_control_precios','',2,'','SUPER','2020-07-27 17:05:43','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,NULL,2016),
(138,'4.17','\\-','','',4,'','SUPER','2021-04-07 16:34:56','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,NULL,4017),
(139,'4.18','Consultar facturas x artículo','DO FORM frm_cons_cbtes_by_articulo','',4,'','SUPER','2021-04-07 16:35:39','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,NULL,4018),
(140,'13','Procesos / Controles','','\0',13,'','SUPER','2021-05-13 12:30:15','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,NULL,13000),
(141,'13.1','Control ventas / compras','DO FORM frm_control_iva','',13,'','SUPER','2021-05-13 12:31:07','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,NULL,13001),
(142,'4.19','Promociones','DO FORM frm_abm_promociones','',4,'','SUPER','2021-09-16 13:28:49','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,4019),
(143,'2.17','\\-','-','',2,'','SUPER','2022-10-04 12:04:15','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,2017),
(144,'2.18','Actualizar x C.B y precio final','DO FORM frm_articulos_actualizar_codiart','',2,'','SUPER','2022-10-04 12:04:15','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,2018),
(146,'4.21','Emitir Remitos','DO FORM frm_emision_remitos','',4,'','SUPER','2022-10-04 12:04:15','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,4021),
(147,'7.4','Artículos Exceptuados IVA PTO','DO FORM frm_abm_art_exivapto','',7,'','SUPER','2022-10-04 12:04:15','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,7004),
(148,'14','Reconstrucciones','','\0',14,'','SUPER','2023-05-03 11:58:29','ESCRITORIO',NULL,NULL,NULL,NULL,NULL,NULL,14000),
(149,'14.1','Estados','DO FORM frm_rcn_abm_estados','',14,'','SUPER','2023-05-03 11:58:32','ESCRITORIO',NULL,NULL,NULL,NULL,NULL,NULL,14001),
(151,'14.3','Tipos de remitos','DO FORM frm_rcn_abm_tiporemito','',14,'','SUPER','2023-05-04 16:30:11','ESCRITORIO',NULL,NULL,NULL,NULL,NULL,NULL,14003),
(152,'14.4','Estados de craters','DO FORM frm_rcn_abm_estcra','',14,'','SUPER','2023-05-09 10:42:58','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,14004),
(153,'14.5','Lista de operadores','DO FORM frm_rcn_abm_operadores','',14,'','SUPER','2023-05-09 10:42:58','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,14005),
(154,'14.7','\\-','','',14,'','SUPER','2023-05-19 17:55:44','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,14007),
(155,'14.8','Ingreso de remitos','DO FORM frm_rcn_ingreso_remitos','',14,'','SUPER','2023-05-19 17:55:44','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,14008),
(156,'14.9','Gestionar fichas','DO FORM frm_rcn_fichas','',14,'','SUPER','2023-05-24 11:46:33','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,14009),
(157,'14.6','Motivos de rechazo','DO FORM frm_abm_motrec','',14,'','SUPER','2023-05-24 15:24:30','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,14006),
(158,'10.7','\\-','','',10,'','SUPER','2023-08-08 15:11:03','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,10007),
(159,'10.8','Consulta de ordenes de pagos','DO FORM frm_orden_pago_consulta','',10,'','SUPER','2023-08-08 15:11:22','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,10007),
(160,'5.13','\\-','','',5,'','SUPER','2024-06-07 16:12:36','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,5013),
(161,'5.14','Enviar Resumenes','DO FORM frm_envio_resumen_ctactecli','',5,'','SUPER','2024-06-07 16:12:36','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,5014),
(162,'2.19','Actualizador Excel V1','DO FORM frm_xls_updater','',2,'','SUPER','2024-06-27 13:46:32','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,NULL,NULL,NULL,2019),
(163,'4.22','Consulta y reimpresión de remitos','DO FORM frm_rtos_consulta','',4,'','SUPER','2025-12-05 10:58:10','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,4022),
(164,'4.20','\\-','','',4,'','SUPER','2025-12-09 10:02:58','SISTEMA',NULL,NULL,NULL,NULL,NULL,NULL,4020);
/*!40000 ALTER TABLE `menues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movcjacab`
--

DROP TABLE IF EXISTS `movcjacab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movcjacab` (
  `idMovCjaC` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `estado` varchar(1) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `conDiferencia` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`idMovCjaC`),
  UNIQUE KEY `idMovCjaC` (`idMovCjaC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movcjacab`
--

LOCK TABLES `movcjacab` WRITE;
/*!40000 ALTER TABLE `movcjacab` DISABLE KEYS */;
/*!40000 ALTER TABLE `movcjacab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movcjadet`
--

DROP TABLE IF EXISTS `movcjadet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movcjadet` (
  `idMovCjaD` int(11) NOT NULL,
  `idMovCjaC` int(11) NOT NULL,
  `idConcCJ` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `cbte` varchar(3) DEFAULT NULL,
  `tipodoc` varchar(1) DEFAULT NULL,
  `ptovta` int(11) DEFAULT NULL,
  `nrocbte` int(11) DEFAULT NULL,
  `importe` float NOT NULL DEFAULT 0,
  `usuAlta` varchar(5) DEFAULT NULL,
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) DEFAULT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idMovCjaD`,`idMovCjaC`),
  KEY `idMovCjaC` (`idMovCjaC`),
  KEY `idConcCJ` (`idConcCJ`),
  CONSTRAINT `movcjadet_ibfk_1` FOREIGN KEY (`idMovCjaC`) REFERENCES `movcjacab` (`idMovCjaC`),
  CONSTRAINT `movcjadet_ibfk_2` FOREIGN KEY (`idConcCJ`) REFERENCES `conccj` (`idConcCJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movcjadet`
--

LOCK TABLES `movcjadet` WRITE;
/*!40000 ALTER TABLE `movcjadet` DISABLE KEYS */;
/*!40000 ALTER TABLE `movcjadet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movcjadetp`
--

DROP TABLE IF EXISTS `movcjadetp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movcjadetp` (
  `idMovCjaDP` int(11) NOT NULL,
  `idMovCjaD` int(11) NOT NULL,
  `idMovCjaC` int(11) NOT NULL,
  `idCtaCja` int(11) NOT NULL,
  `tipoPago` varchar(5) DEFAULT NULL,
  `importe` float NOT NULL,
  `idPlanCta` int(11) DEFAULT NULL,
  `idBanco` int(11) DEFAULT NULL,
  `idCheque` int(11) DEFAULT NULL,
  `chq_nro` varchar(8) DEFAULT NULL,
  `idProvin` int(11) DEFAULT NULL,
  `retCompro` int(11) DEFAULT NULL,
  `retFecha` datetime DEFAULT NULL,
  PRIMARY KEY (`idMovCjaDP`,`idMovCjaD`,`idMovCjaC`),
  KEY `idMovCjaD` (`idMovCjaD`,`idMovCjaC`),
  KEY `idCtaCja` (`idCtaCja`),
  KEY `idPlanCta` (`idPlanCta`),
  KEY `idBanco` (`idBanco`),
  KEY `idCheque` (`idCheque`),
  CONSTRAINT `movcjadetp_ibfk_1` FOREIGN KEY (`idMovCjaD`, `idMovCjaC`) REFERENCES `movcjadet` (`idMovCjaD`, `idMovCjaC`),
  CONSTRAINT `movcjadetp_ibfk_2` FOREIGN KEY (`idCtaCja`) REFERENCES `ctacja` (`idCtaCja`),
  CONSTRAINT `movcjadetp_ibfk_3` FOREIGN KEY (`idPlanCta`) REFERENCES `planctas` (`idPlanCta`),
  CONSTRAINT `movcjadetp_ibfk_4` FOREIGN KEY (`idBanco`) REFERENCES `bancos` (`idBanco`),
  CONSTRAINT `movcjadetp_ibfk_5` FOREIGN KEY (`idCheque`) REFERENCES `cheques` (`idCheque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movcjadetp`
--

LOCK TABLES `movcjadetp` WRITE;
/*!40000 ALTER TABLE `movcjadetp` DISABLE KEYS */;
/*!40000 ALTER TABLE `movcjadetp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movcjadif`
--

DROP TABLE IF EXISTS `movcjadif`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movcjadif` (
  `idMovCjaDif` int(11) NOT NULL,
  `idMovCjaC` int(11) NOT NULL,
  `idPlanCta` int(11) DEFAULT NULL,
  `idCtaCja` int(11) NOT NULL,
  `descripcio` varchar(50) NOT NULL,
  `importe` float NOT NULL,
  `imp_fisico` float NOT NULL,
  `diferencia` float NOT NULL,
  `usuCierre` varchar(5) DEFAULT NULL,
  `fecCierre` datetime DEFAULT NULL,
  `idHostCierre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idMovCjaDif`,`idMovCjaC`),
  KEY `idMovCjaC` (`idMovCjaC`),
  KEY `idCtaCja` (`idCtaCja`),
  KEY `idPlanCta` (`idPlanCta`),
  CONSTRAINT `movcjadif_ibfk_1` FOREIGN KEY (`idMovCjaC`) REFERENCES `movcjacab` (`idMovCjaC`),
  CONSTRAINT `movcjadif_ibfk_2` FOREIGN KEY (`idCtaCja`) REFERENCES `ctacja` (`idCtaCja`),
  CONSTRAINT `movcjadif_ibfk_3` FOREIGN KEY (`idPlanCta`) REFERENCES `planctas` (`idPlanCta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movcjadif`
--

LOCK TABLES `movcjadif` WRITE;
/*!40000 ALTER TABLE `movcjadif` DISABLE KEYS */;
/*!40000 ALTER TABLE `movcjadif` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movcjarel`
--

DROP TABLE IF EXISTS `movcjarel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movcjarel` (
  `idMovCjaR` int(11) NOT NULL,
  `idMovCjaD` int(11) NOT NULL,
  `idMovCjaC` int(11) NOT NULL,
  `idVentasC` int(11) NOT NULL,
  `cbte` varchar(3) NOT NULL,
  `tipoDoc` varchar(1) NOT NULL,
  `ptoVta` int(11) NOT NULL,
  `numCbte` int(11) NOT NULL,
  `importe` float NOT NULL,
  `saldo` float NOT NULL,
  `idCC_Cli` int(11) DEFAULT NULL,
  PRIMARY KEY (`idMovCjaR`),
  KEY `idMovCjaD` (`idMovCjaD`,`idMovCjaC`),
  KEY `idVentasC` (`idVentasC`),
  CONSTRAINT `movcjarel_ibfk_1` FOREIGN KEY (`idMovCjaD`, `idMovCjaC`) REFERENCES `movcjadet` (`idMovCjaD`, `idMovCjaC`),
  CONSTRAINT `movcjarel_ibfk_2` FOREIGN KEY (`idVentasC`) REFERENCES `ventascab` (`idVentasC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movcjarel`
--

LOCK TABLES `movcjarel` WRITE;
/*!40000 ALTER TABLE `movcjarel` DISABLE KEYS */;
/*!40000 ALTER TABLE `movcjarel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movcom`
--

DROP TABLE IF EXISTS `movcom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movcom` (
  `idMovCom` int(11) NOT NULL,
  `idVendedor` int(11) NOT NULL,
  `idRCCob_C` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `porComis` float NOT NULL,
  `importe` double NOT NULL,
  PRIMARY KEY (`idMovCom`),
  UNIQUE KEY `idMovCom` (`idMovCom`),
  KEY `idVendedor` (`idVendedor`),
  KEY `idRCCob_C` (`idRCCob_C`),
  CONSTRAINT `movcom_ibfk_1` FOREIGN KEY (`idVendedor`) REFERENCES `vendedores` (`idVendedor`),
  CONSTRAINT `movcom_ibfk_2` FOREIGN KEY (`idRCCob_C`) REFERENCES `rccob_c` (`idRCCob_C`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movcom`
--

LOCK TABLES `movcom` WRITE;
/*!40000 ALTER TABLE `movcom` DISABLE KEYS */;
/*!40000 ALTER TABLE `movcom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `numerador`
--

DROP TABLE IF EXISTS `numerador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `numerador` (
  `idNum` int(11) NOT NULL,
  `cbte` varchar(3) NOT NULL,
  `tipoDoc` varchar(1) NOT NULL,
  `ptoVta` int(11) NOT NULL,
  `numActual` int(11) NOT NULL,
  `cai` varchar(60) DEFAULT NULL,
  `fecVto` date DEFAULT NULL,
  `impresora` varchar(60) DEFAULT NULL,
  `cantCpia` int(11) NOT NULL DEFAULT 0,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime NOT NULL DEFAULT '2014-01-01 00:00:00',
  `idHostAlta` varchar(60) NOT NULL DEFAULT 'LEONZ_XP #Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(60) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(60) DEFAULT NULL,
  `bloqueado` bit(1) NOT NULL DEFAULT b'0',
  `repname` varchar(100) DEFAULT NULL COMMENT 'Nombre de reporte a invocar',
  `repnamecp` varchar(100) DEFAULT NULL COMMENT 'Nombre de reporte a invocar en comprobantes por conceptos',
  `codafip` int(11) DEFAULT 0,
  PRIMARY KEY (`idNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `numerador`
--

LOCK TABLES `numerador` WRITE;
/*!40000 ALTER TABLE `numerador` DISABLE KEYS */;
INSERT INTO `numerador` VALUES
(1,'PTO','X',9999,6,'','9999-12-31','HP1102 PTO',2,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0','reppto',NULL,-1),
(2,'PED','P',1,536,'','9999-12-31','HP1102 PTO',1,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0','ejb_reppedido',NULL,-1),
(3,'FC','A',1,364,'','9999-12-31','HP1102 FC',3,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0','repcbtesvta',NULL,1),
(4,'FC','B',1,200,'','9999-12-31','HP1102 FC',3,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0','repcbtesvta_b',NULL,6),
(5,'NC','A',1,0,'1','9999-12-31','HP1102 FC',3,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo','SUPER','2016-09-07 00:00:00','MG # betiana',NULL,NULL,NULL,'\0','repcbtesvta','repncnd',3),
(6,'NC','B',1,0,'1','9999-12-31','HP1102 FC',3,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo','SUPER','2016-09-07 00:00:00','MG # betiana',NULL,NULL,NULL,'\0','repcbtesvta_b','repncnd_b',8),
(7,'COT','X',1,74,'1','9999-12-31','HP1102 PTO',2,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,'\0','repcot',NULL,-1),
(8,'ND','A',1,0,'1','9999-12-31','HP1102 FC',2,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo','SUPER','2016-09-07 00:00:00','MG # betiana',NULL,NULL,NULL,'\0',NULL,'repncnd',2),
(9,'ND','B',1,0,'1','9999-12-31','HP1102 FC',2,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo','SUPER','2016-09-07 00:00:00','MG # betiana',NULL,NULL,NULL,'\0',NULL,'repncnd_b',7),
(10,'AC','X',0,306,' ','9999-12-31',' ',0,'SUPER','2014-01-01 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,NULL,-1),
(11,'AD','X',0,155,' ','9999-12-31',' ',0,'SUPER','2014-01-01 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,NULL,-1),
(12,'CJA','',1,0,' ','9999-12-31',' ',0,'SUPER','2014-01-01 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,NULL,-1),
(13,'OC','',0,3,'','9999-12-31','',0,'SUPER','2014-01-01 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,NULL,-1),
(14,'RC','X',1,28,'','9999-12-31','',0,'SUPER','2014-01-01 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL,'\0','rep_recibos',NULL,-1),
(36,'ACP','X',1,0,'','2999-12-21','',0,'SUPER','2016-10-05 23:17:02','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,NULL,-1),
(37,'ADP','X',1,1,'','2999-12-21','',0,'SUPER','2016-10-05 23:17:02','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,NULL,-1),
(38,'RTO','R',1,0,'78888989888','2026-12-31',NULL,0,'SUPER','2014-01-01 00:00:00','LEONZ_XP #Leonardo','SUPER','2026-01-12 08:52:57','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,'\0','rep_rtos',NULL,0);
/*!40000 ALTER TABLE `numerador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occab`
--

DROP TABLE IF EXISTS `occab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `occab` (
  `idOcCab` int(11) NOT NULL,
  `idProv` int(11) NOT NULL,
  `idMarca` int(11) DEFAULT NULL,
  `idPcCab` int(11) DEFAULT NULL,
  `Fecha` datetime NOT NULL,
  `FecEnt` datetime NOT NULL,
  `iTotCosto` float NOT NULL,
  `iTotLista` float NOT NULL,
  `cantTot` float NOT NULL,
  `observ` text DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idOcCab`),
  KEY `idProv` (`idProv`),
  KEY `idMarca` (`idMarca`),
  CONSTRAINT `occab_ibfk_1` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`),
  CONSTRAINT `occab_ibfk_2` FOREIGN KEY (`idMarca`) REFERENCES `marcas` (`idmarca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occab`
--

LOCK TABLES `occab` WRITE;
/*!40000 ALTER TABLE `occab` DISABLE KEYS */;
/*!40000 ALTER TABLE `occab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ocdet`
--

DROP TABLE IF EXISTS `ocdet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ocdet` (
  `idOcDet` int(11) NOT NULL,
  `idOcCab` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `UniDesp` float DEFAULT NULL,
  `cantPack` float DEFAULT NULL,
  `codUM` varchar(3) DEFAULT NULL,
  `CantPed` float NOT NULL,
  `CantRec` float NOT NULL,
  `Pendiente` float NOT NULL,
  `Costo` float NOT NULL,
  `PrLista` float NOT NULL,
  `TotCosto` float NOT NULL,
  `TotPrLista` float NOT NULL,
  `Activo` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`idOcDet`,`idOcCab`),
  KEY `idOcCab` (`idOcCab`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `ocdet_ibfk_1` FOREIGN KEY (`idOcCab`) REFERENCES `occab` (`idOcCab`),
  CONSTRAINT `ocdet_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ocdet`
--

LOCK TABLES `ocdet` WRITE;
/*!40000 ALTER TABLE `ocdet` DISABLE KEYS */;
/*!40000 ALTER TABLE `ocdet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofertas`
--

DROP TABLE IF EXISTS `ofertas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofertas` (
  `idOferta` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `fecVigDD` datetime NOT NULL,
  `fecVigHH` datetime NOT NULL,
  `porOfert` float NOT NULL DEFAULT 0,
  `impOfert` float NOT NULL DEFAULT 0,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `codArt` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idOferta`),
  UNIQUE KEY `idOferta` (`idOferta`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `ofertas_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofertas`
--

LOCK TABLES `ofertas` WRITE;
/*!40000 ALTER TABLE `ofertas` DISABLE KEYS */;
INSERT INTO `ofertas` VALUES
(1,143,'2023-02-09 00:00:00','2023-02-09 00:00:00',10,162.59,'SUPER','2023-02-09 13:55:15','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL,'PROD001'),
(2,144,'2023-02-09 00:00:00','2023-02-09 00:00:00',10,161.81,'SUPER','2023-02-09 13:55:15','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL,'PROD002'),
(3,145,'2023-02-09 00:00:00','2023-02-09 00:00:00',10,347.94,'SUPER','2023-02-09 13:55:15','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL,'PROD003');
/*!40000 ALTER TABLE `ofertas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordpag_c`
--

DROP TABLE IF EXISTS `ordpag_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordpag_c` (
  `idOrdPagC` int(11) NOT NULL,
  `idProv` int(11) NOT NULL,
  `nroOP` int(11) NOT NULL,
  `fecEmis` datetime NOT NULL,
  `importe` float NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idOrdPagC`),
  UNIQUE KEY `idOrdPagC` (`idOrdPagC`),
  KEY `idProv` (`idProv`),
  CONSTRAINT `ordpag_c_ibfk_1` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordpag_c`
--

LOCK TABLES `ordpag_c` WRITE;
/*!40000 ALTER TABLE `ordpag_c` DISABLE KEYS */;
INSERT INTO `ordpag_c` VALUES
(1,2,1,'2022-10-05 10:28:24',60500,'SUPER','2022-10-05 10:28:24','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,1,2,'2023-02-09 19:15:35',10000,'SUPER','2023-02-09 19:15:35','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(3,3,3,'2023-08-09 19:18:48',12100,'SUPER','2023-08-09 19:18:48','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4,2,4,'2023-08-09 19:25:26',5000,'SUPER','2023-08-09 19:25:26','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,2,5,'2023-08-09 19:32:25',5445,'SUPER','2023-08-09 19:32:25','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(6,2,6,'2023-08-10 15:51:29',1655,'SUPER','2023-08-10 15:51:29','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7,2,7,'2023-08-10 16:12:00',1000,'SUPER','2023-08-10 16:12:00','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8,2,8,'2023-08-10 16:26:58',2000,'SUPER','2023-08-10 16:26:58','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9,2,9,'2023-08-10 16:28:28',3050,'SUPER','2023-08-10 16:28:28','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(10,2,10,'2023-08-10 16:34:17',14520,'SUPER','2023-08-10 16:34:17','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(11,2,11,'2023-08-10 16:50:32',24200,'SUPER','2023-08-10 16:50:32','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(12,2,12,'2023-08-11 17:49:42',24700,'SUPER','2023-08-11 17:49:42','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ordpag_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordpag_d`
--

DROP TABLE IF EXISTS `ordpag_d`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordpag_d` (
  `idOrdPagD` int(11) NOT NULL,
  `idOrdPagC` int(11) NOT NULL,
  `tipoPago` varchar(5) NOT NULL,
  `importe` float NOT NULL DEFAULT 0,
  `idPlanCta` int(11) DEFAULT NULL,
  `idBanco` int(11) DEFAULT NULL,
  `idCheque` int(11) DEFAULT NULL,
  `idChequeP` int(11) DEFAULT NULL,
  `idProvin` int(11) DEFAULT NULL,
  `retCompro` int(11) DEFAULT NULL,
  `retFecha` datetime DEFAULT NULL,
  `fecTrans` datetime DEFAULT NULL,
  `nomOrig` varchar(60) DEFAULT NULL,
  `docOrig` varchar(20) DEFAULT NULL,
  `nroTrans` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`idOrdPagD`,`idOrdPagC`),
  UNIQUE KEY `idOrdPagD` (`idOrdPagD`),
  KEY `idOrdPagC` (`idOrdPagC`),
  KEY `idCheque` (`idCheque`),
  KEY `idChequeP` (`idChequeP`),
  KEY `idPlanCta` (`idPlanCta`),
  KEY `idProvin` (`idProvin`),
  KEY `idBanco` (`idBanco`),
  CONSTRAINT `ordpag_d_ibfk_1` FOREIGN KEY (`idOrdPagC`) REFERENCES `ordpag_c` (`idOrdPagC`),
  CONSTRAINT `ordpag_d_ibfk_2` FOREIGN KEY (`idCheque`) REFERENCES `cheques` (`idCheque`),
  CONSTRAINT `ordpag_d_ibfk_3` FOREIGN KEY (`idChequeP`) REFERENCES `chequesp` (`idChequeP`),
  CONSTRAINT `ordpag_d_ibfk_4` FOREIGN KEY (`idPlanCta`) REFERENCES `planctas` (`idPlanCta`),
  CONSTRAINT `ordpag_d_ibfk_5` FOREIGN KEY (`idProvin`) REFERENCES `provincias` (`idProvin`),
  CONSTRAINT `ordpag_d_ibfk_6` FOREIGN KEY (`idBanco`) REFERENCES `bancos` (`idBanco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordpag_d`
--

LOCK TABLES `ordpag_d` WRITE;
/*!40000 ALTER TABLE `ordpag_d` DISABLE KEYS */;
INSERT INTO `ordpag_d` VALUES
(1,1,'EFVO',60500,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(2,2,'EFVO',10000,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(3,3,'EFVO',12100,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(4,4,'EFVO',5000,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(5,5,'CHEQ',5445,12,10,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(6,6,'CHEQP',1655,129,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(7,7,'CHEQP',1000,129,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(8,8,'CHEQP',2000,129,16,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(9,9,'CHEQP',2000,129,16,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10,9,'CHEQP',1050,129,16,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(11,10,'TRAN',14520,129,16,NULL,NULL,NULL,NULL,NULL,'2023-08-10 00:00:00','LEONARDO D. ZULLI','20280456919','00000001'),
(12,11,'EFVO',5000,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(13,11,'CHEQ',4605.99,12,10,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(14,11,'TRAN',4594.01,129,150,NULL,NULL,NULL,NULL,NULL,'2023-08-10 00:00:00','LEONARDO D. ZULLI','20280456919','00000002'),
(15,11,'CHEQP',10000,129,16,NULL,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(16,12,'EFVO',5000,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(17,12,'TRAN',14300,129,16,NULL,NULL,NULL,NULL,NULL,'2023-08-11 00:00:00','LEONARDO D. ZULLI','2','00000004'),
(18,12,'CHEQP',5000,129,16,NULL,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(19,12,'RGAN',100,173,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20,12,'RIB',100,172,NULL,NULL,NULL,1,0,'0000-00-00 00:00:00',NULL,NULL,NULL,NULL),
(21,12,'RIVA',100,171,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(22,12,'RSUSS',100,174,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ordpag_d` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordpag_dc`
--

DROP TABLE IF EXISTS `ordpag_dc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordpag_dc` (
  `idOrdPagDC` int(11) NOT NULL,
  `idOrdPagC` int(11) NOT NULL,
  `idCompraC` int(11) NOT NULL,
  `imppag` decimal(20,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`idOrdPagDC`),
  UNIQUE KEY `idOrdPagDC` (`idOrdPagDC`),
  KEY `idOrdPagC` (`idOrdPagC`),
  KEY `idCompraC` (`idCompraC`),
  CONSTRAINT `ordpag_dc_ibfk_1` FOREIGN KEY (`idOrdPagC`) REFERENCES `ordpag_c` (`idOrdPagC`),
  CONSTRAINT `ordpag_dc_ibfk_2` FOREIGN KEY (`idCompraC`) REFERENCES `comprascab` (`idCompraC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordpag_dc`
--

LOCK TABLES `ordpag_dc` WRITE;
/*!40000 ALTER TABLE `ordpag_dc` DISABLE KEYS */;
INSERT INTO `ordpag_dc` VALUES
(1,1,1,0.00),
(2,2,2,0.00),
(3,3,3,0.00),
(4,4,4,5000.00),
(5,5,4,5445.00),
(6,6,4,1655.00),
(7,7,5,1000.00),
(8,8,5,2000.00),
(9,9,5,3050.00),
(10,10,6,14520.00),
(11,11,7,24200.00),
(12,12,8,24700.00);
/*!40000 ALTER TABLE `ordpag_dc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordtrabajo`
--

DROP TABLE IF EXISTS `ordtrabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordtrabajo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `cantidad` decimal(10,2) NOT NULL DEFAULT 1.00,
  `detalle` varchar(60) NOT NULL,
  `precio` decimal(20,2) NOT NULL,
  `facturado` bit(1) NOT NULL DEFAULT b'0',
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL DEFAULT current_timestamp(),
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `idCliente` (`idCliente`),
  CONSTRAINT `ordtrabajo_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordtrabajo`
--

LOCK TABLES `ordtrabajo` WRITE;
/*!40000 ALTER TABLE `ordtrabajo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordtrabajo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `padronib`
--

DROP TABLE IF EXISTS `padronib`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `padronib` (
  `Publicacion` datetime DEFAULT NULL,
  `Vigencia_Desde` datetime DEFAULT NULL,
  `Vigencia_Hasta` datetime DEFAULT NULL,
  `CUIT` char(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Tipo` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Estado` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CambioAlicuota` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `AlicuotaPer` float DEFAULT NULL,
  `AlicuotaRet` float DEFAULT NULL,
  `NoGrupoPer` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `NoGrupoRet` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`CUIT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `padronib`
--

LOCK TABLES `padronib` WRITE;
/*!40000 ALTER TABLE `padronib` DISABLE KEYS */;
/*!40000 ALTER TABLE `padronib` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paises` (
  `idPais` int(11) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(60) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(60) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idPais`),
  UNIQUE KEY `idPais` (`idPais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paises`
--

LOCK TABLES `paises` WRITE;
/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
INSERT INTO `paises` VALUES
(1,'ARGENTINA','SUPER','2014-02-02 00:00:00','LDZ_PC1 # usuario',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pccab`
--

DROP TABLE IF EXISTS `pccab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pccab` (
  `idPCCab` int(11) NOT NULL,
  `idProv` int(11) NOT NULL,
  `idMarca` int(11) DEFAULT NULL,
  `fecDesde` datetime NOT NULL,
  `fecHasta` datetime NOT NULL,
  `fecEnt` datetime DEFAULT NULL,
  `baseCalc` int(11) DEFAULT NULL,
  `cntDS` int(11) DEFAULT NULL,
  `observ` text DEFAULT NULL,
  `emitido` bit(1) DEFAULT NULL,
  `estado` varchar(2) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idPCCab`),
  UNIQUE KEY `idPCCab` (`idPCCab`),
  KEY `idProv` (`idProv`),
  CONSTRAINT `pccab_ibfk_1` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pccab`
--

LOCK TABLES `pccab` WRITE;
/*!40000 ALTER TABLE `pccab` DISABLE KEYS */;
/*!40000 ALTER TABLE `pccab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pcdet`
--

DROP TABLE IF EXISTS `pcdet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcdet` (
  `idPCDet` int(11) NOT NULL,
  `idPCCab` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `vtaMax` float NOT NULL,
  `promed` float NOT NULL,
  `stkMin` float NOT NULL,
  `stkDis` float NOT NULL,
  `cantPed` float NOT NULL,
  `pendi` float NOT NULL DEFAULT 0,
  `faltant` float NOT NULL DEFAULT 0,
  `diasCub` int(11) NOT NULL DEFAULT 0,
  `costo` float NOT NULL DEFAULT 0,
  `prLista` float NOT NULL DEFAULT 0,
  `UniDesp` float DEFAULT NULL,
  `cantPack` float DEFAULT NULL,
  PRIMARY KEY (`idPCDet`,`idPCCab`),
  KEY `idPCCab` (`idPCCab`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `pcdet_ibfk_1` FOREIGN KEY (`idPCCab`) REFERENCES `pccab` (`idPCCab`),
  CONSTRAINT `pcdet_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pcdet`
--

LOCK TABLES `pcdet` WRITE;
/*!40000 ALTER TABLE `pcdet` DISABLE KEYS */;
/*!40000 ALTER TABLE `pcdet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedext`
--

DROP TABLE IF EXISTS `pedext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedext` (
  `idPedExt` int(11) NOT NULL AUTO_INCREMENT,
  `idPedCab` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `idVentasC` int(11) DEFAULT NULL,
  `fecEmis` datetime NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `observ` text DEFAULT NULL,
  `procesado` bit(1) NOT NULL DEFAULT b'0',
  `tipoSist` int(11) DEFAULT 0,
  PRIMARY KEY (`idPedExt`),
  UNIQUE KEY `idPedExt` (`idPedExt`),
  KEY `idArticulo` (`idArticulo`),
  KEY `idCliente` (`idCliente`),
  KEY `idVentasC` (`idVentasC`),
  CONSTRAINT `pedext_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `pedext_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`),
  CONSTRAINT `pedext_ibfk_3` FOREIGN KEY (`idVentasC`) REFERENCES `ventascab` (`idVentasC`)
) ENGINE=InnoDB AUTO_INCREMENT=11059 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci AVG_ROW_LENGTH=420;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedext`
--

LOCK TABLES `pedext` WRITE;
/*!40000 ALTER TABLE `pedext` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedextinv`
--

DROP TABLE IF EXISTS `pedextinv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedextinv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPedCab` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idArticulo` int(11) DEFAULT NULL,
  `idVentasC` int(11) DEFAULT NULL,
  `fecEmis` datetime DEFAULT NULL,
  `codArt` varchar(20) DEFAULT NULL,
  `cantidad` decimal(10,5) DEFAULT NULL,
  `observ` text DEFAULT NULL,
  `tipoSist` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `idCliente` (`idCliente`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `pedextinv_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `pedextinv_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedextinv`
--

LOCK TABLES `pedextinv` WRITE;
/*!40000 ALTER TABLE `pedextinv` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedextinv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planctas`
--

DROP TABLE IF EXISTS `planctas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planctas` (
  `idPlanCta` int(11) NOT NULL,
  `codPlanCta` varchar(20) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `esImput` bit(1) NOT NULL,
  `esCtaBco` bit(1) NOT NULL,
  `codAbr` varchar(10) NOT NULL,
  `esChqT` bit(1) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idPlanCta`),
  UNIQUE KEY `idPlanCta` (`idPlanCta`),
  KEY `codAbr` (`codAbr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planctas`
--

LOCK TABLES `planctas` WRITE;
/*!40000 ALTER TABLE `planctas` DISABLE KEYS */;
INSERT INTO `planctas` VALUES
(1,'01.00.00.00','ACTIVO','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,'01.01.00.00','ACTIVO CORRIENTE','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'01.01.01.00','DISPONIBILIDADES','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4,'01.01.01.01','CAJA EN $','','\0','FPCJP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,'01.01.01.02','CAJA EN U$S','','\0','FPCJD','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(6,'01.01.01.03','CAJA CHICA','','\0','FPCJC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7,'01.01.01.04','REINTEGROS','','\0','REI','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8,'01.01.01.05','BANCO SANTANDER RIO CTA.CTE','','','BCOSRIOCC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9,'01.01.01.06','BANCO CREDICOOP CTA CTE','','','BCOCREDCC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(10,'01.01.01.07','BANCO NACION CTA CTE','','','BCONACICC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(11,'01.01.01.08','BANCO PROV. BS.AS. CTA CTE','','','BCOPROVCC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(12,'01.01.01.09','CHEQUES EN CARTERA','','\0','CHC','','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo','SUPER','2014-02-02 00:00:00','LDZ_PC1 # usuario',NULL,NULL,NULL),
(13,'01.01.02.00','CRÉDITOS POR VENTAS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(14,'01.01.02.01','DEUDORES POR VENTAS','','\0','DXV','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(15,'01.01.02.02','DEUDORES EN LITIGIO','','\0','DEL','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(16,'01.01.02.03','CHEQUES RECHAZADOS','','\0','CHR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(17,'01.01.02.04','OTROS CRÉDITOS','','\0','OCR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(18,'01.01.02.05','I.V.A CRÉDITO FISCAL','','\0','ICF','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(19,'01.01.03.00','GASTOS A DEVENGAR','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20,'01.01.03.01','CUENTAS ESPECIFICAS A DEVENGAR','','\0','CED','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(21,'01.01.04.00','BIENES DE CAMBIO','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(22,'01.01.04.01','MERCADERÍA DE REVENTA','','\0','MCR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(23,'01.02.00.00','ACTIVO NO CORRIENTE','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(24,'01.02.01.00','BIENES DE USO','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(25,'01.02.01.01','INMUEBLES','','\0','INM','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(26,'01.02.01.02','RODADOS','','\0','ROD','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(27,'01.02.01.03','MUEBLES Y ÚTILIES','','\0','MUT','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(28,'01.02.01.04','EQUIPOS DE COMPUTACIÓN','','\0','EQUICOMPU','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(29,'01.02.01.05','INSTALACIONES','','\0','INSTALA_1','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(30,'02.00.00.00','PASIVO','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(31,'02.01.00.00','PASIVO CORRIENTE','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(32,'02.01.01.00','CUENTA A PAGAR','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(33,'02.01.01.01','PROVEEDORES EN CTA CTE','','\0','PCC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(34,'02.01.01.02','ANTICIPO A PROVEEDORES','','\0','APR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(35,'02.01.01.03','ACREEDORES VARIOS','','\0','ACV','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(36,'02.01.02.00','OTRAS DEUDAS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(37,'02.01.02.01','SUELDOS A PAGAR','','\0','SPA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(38,'02.01.02.02','IMPUESTOS A PAGAR','','\0','IPA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(39,'02.01.02.03','I.V.A DÉBITO FISCAL','','\0','IDF','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(40,'03.00.00.00','P.N','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(41,'03.00.00.01','CAPITAL','','\0','CAP_1','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(42,'03.00.00.02','RESULTADO DEL EJ.','','\0','REJ','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(43,'05.00.00.00','CUENTAS DE RESULTADO POSITIVO','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(44,'05.01.00.00','VENTAS','','\0','VTA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(45,'05.02.00.00','DESCUENTOS PRONTO PAGO','','\0','DPP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(46,'04.00.00.00','CUENTAS DE RESULTADO NEGATIVO','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(47,'04.01.00.00','COSTO MERCADERIA VENDIDA','','\0','CMV','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(48,'04.02.00.00','GASTOS OPERATIVOS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(49,'04.02.01.00','SUELDOS PERSONAL OPERATIVO','','\0','SPO','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(50,'04.02.02.00','REPARTOS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(51,'04.02.02.01','DESPACHOS','','\0','DPCHOS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(52,'04.02.02.02','CAPITAL','','\0','CAP_2','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(53,'04.02.02.03','MOTIVO','','\0','MOTIVO','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(54,'04.02.02.04','ZONA NORTE','','\0','ZNANOR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(55,'04.02.02.05','ZONA OESTE','','\0','ZNAOES','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(56,'04.02.02.06','ZONA SUR','','\0','ZNASUR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(57,'04.02.02.07','SAN MIGUEL','','\0','SANMIG','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(58,'04.02.02.08','ZARATE CAMPANA','','\0','ZARCAMP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(59,'04.02.02.09','PILAR','','\0','PILAR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(60,'04.02.02.10','MOTOS','','\0','MOTOS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(61,'04.02.02.11','REMISES','','\0','REMISES','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(62,'04.02.03.00','MATERIALES','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(63,'04.02.03.01','CAJAS','','\0','CJA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(64,'04.02.03.02','CINTA ADHESIVA','','\0','CTAADH','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(65,'04.02.03.03','FLEJES','','\0','FLEJES','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(66,'04.02.03.04','BOLSAS','','\0','BOLSAS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(67,'04.02.03.05','RÓTULOS','','\0','ROTULOS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(68,'04.02.03.06','SOBRES ','','\0','SOBRES','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(69,'04.02.03.07','NOTAS DE PEDIDO','','\0','NTAPED','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(70,'04.02.04.00','SERVICIOS PÚBLICOS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(71,'04.02.04.01','LUZ ','','\0','LUZ','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(72,'04.02.04.02','GAS ','','\0','GAS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(73,'04.02.04.03','AGUA','','\0','AGUA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(74,'04.02.99.00','OTROS GASTOS OPERATIVOS','','\0','OGO','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(75,'04.03.00.00','GASTOS COMERCIALES','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(76,'04.03.01.00','SUELDOS PERSONAL COMERCIAL','','\0','SPC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(77,'04.03.02.00','COMISIONES VENDEDORES','','\0','COV','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(78,'04.03.03.00','MARKETING','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(79,'04.03.03.01','PUBLICIDAD Y PROPAGANDA','','\0','PYP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(80,'04.03.03.02','EVENTOS','','\0','EVE','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(81,'04.03.03.03','CAMPAÑAS','','\0','CAMP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(82,'04.03.03.04','CATÁLOGOS','','\0','CAT','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(83,'04.03.03.05','LISTAS DE PRECIOS','','\0','LDP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(84,'04.03.03.06','MERCHANDISING','','\0','MRDSING','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(85,'04.03.99.00','OTROS GASTOS COMERCIALES','','\0','OGC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(86,'04.04.00.00','GASTOS DE ADMINISTRACIÓN','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(87,'04.04.01.00','SUELDOS PERSONAL DE ADMINISTRACIÓN','','\0','SPADM','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(88,'04.04.02.00','HONORARIOS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(89,'04.04.02.01','ABOGADOS','','\0','ABOG','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(90,'04.04.02.02','ASESORAMIENTO','','\0','ASE','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(91,'04.04.02.03','CÁMARA DE COMERCIO','','\0','CDC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(92,'04.04.02.04','CLÍNICA PRIVADA','','\0','CLP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(93,'04.04.02.05','ESCRIBANÍA','','\0','ESC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(94,'04.04.02.06','ESTUDIO CONTABLE','','\0','ESCONT','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(95,'04.04.02.07','REINGENIERÍA','','\0','REING','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(96,'04.04.03.00','SEGUROS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(97,'04.04.03.01','VEHÍCULOS','','\0','VEHIC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(98,'04.04.03.02','INCENDIO','','\0','INCEND','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(99,'04.04.03.03','DE VIDA COLECTIVO','','\0','DVC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(100,'04.04.03.04','CAUCIÓN','','\0','CAU','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(101,'04.04.04.00','SEGURIDAD','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(102,'04.04.04.01','ALARMAS','','\0','ALARMAS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(103,'04.04.04.02','MATAFUEGOS','','\0','MATAFUEG','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(104,'04.04.04.03','SATELITAL','','\0','SATELITAL','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(105,'04.04.05.00','TELEFONOS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(106,'04.04.05.01','NEXTEL','','\0','NEXTEL','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(107,'04.04.05.02','TELECOM','','\0','TELECOM','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(108,'04.04.05.03','TELECOM 0800','','\0','TELEC0800','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(109,'04.04.05.04','MATERTEL','','\0','MTERTEL','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(110,'04.04.05.05','CELULARES VARIOS','','\0','CELVRIOS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(111,'04.04.06.00','PAPELERÍA Y LIBRERÍA','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(112,'04.04.06.01','ARTÍCULOS DE LIBRERÍA','','\0','ARTLIB','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(113,'04.04.06.02','FORMULARIOS FISCALES','','\0','FORMFISC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(114,'04.04.06.03','FOTOCOPIADORA','','\0','FOTOCOP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(115,'04.04.06.04','PAPELERÍA','','\0','PAPELERIA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(116,'04.04.07.00','GASTOS DE CORRESPONDENCIA','','\0','GDC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(117,'04.04.08.00','LIMPIEZA Y MANTENIMIENTO','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(118,'04.04.08.01','SUELDO PERSONAL DE LIMPIEZA','','\0','SPL','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(119,'04.04.08.02','ARTÍCULOS DE LIMPIEZA','','\0','ARTLIM','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(120,'04.04.08.03','REPARACIÓN Y MEJORAS','','\0','REPYMEJ','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(121,'04.04.09.00','AMORTIZACIÓN DE BIENES DE USO','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(122,'04.04.09.01','MUEBLES Y ÚTILES','','\0','MUEYUT','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(123,'04.04.09.02','RODADOS','','\0','RODADOS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(124,'04.04.09.03','MAQUINAS Y HERRAMIENTAS','','\0','MAQYHERR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(125,'04.04.09.04','INSTALACIONES','','\0','INSTALA_2','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(126,'04.04.99.00','OTROS GASTOS DE ADMINISTRACIÓN','','\0','OGA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(127,'04.05.00.00','GASTOS DE SISTEMAS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(128,'04.05.01.00','SUELDOS PERSONAL DE SISTEMAS','','\0','SPS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(129,'04.05.02.00','ABONOS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(130,'04.05.02.01','SERVICIOS DE EMAIL','','\0','SE','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(131,'04.05.02.02','CONEXIÓN INTERNET','','\0','CONINT','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(132,'04.05.02.03','SERVICIO TÉCNICO','','\0','ST','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(133,'04.05.02.04','PÁGINA WEB','','\0','PWE','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(134,'04.05.03.00','INSUMOS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(135,'04.05.03.01','CARTUCHOS','','\0','CAR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(136,'04.05.03.02','TONERS','','\0','TONERS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(137,'04.05.03.03','CD`S','','\0','CDS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(138,'04.05.03.04','OTROS','','\0','OTROS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(139,'04.05.04.00','AMORTIZACIÓN DE BIENES DE USO','','\0','ABU','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(140,'04.06.00.00','IMPUESTOS Y OTROS GASTOS','\0','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(141,'04.06.01.00','RETIRO DE LOS SOCIOS','','\0','RSO','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(142,'04.06.02.00','IMPUESTO AL VALOR AGREGADO','','\0','IVA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(143,'04.06.01.01','IMPUESTO A LAS GANANCIAS','','\0','IAG','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(144,'04.06.02.01','IMPUESTO A LOS INGRESOS BRUTOS','','\0','IIBB','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(145,'04.06.01.02','APORTES Y CARGAS SOCIALES','','\0','ACS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(146,'04.06.02.02','AUTÓNOMOS','','\0','AUTONOMOS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(147,'04.06.01.03','IMPUESTO A LOS BIENES PERSONALES','','\0','IABP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(148,'04.06.02.03','IMPUESTO INMOBILIARIO','','\0','IINMO','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(149,'04.06.01.04','PATENTES VEHÍCULOS','','\0','PVE','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(150,'04.06.02.04','IMPUESTO A LOS DÉBITOS Y CRÉDITOS','','\0','IDC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(151,'04.06.01.05','INTERESES Y GASTOS BANCARIOS','','\0','IGB','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(152,'04.06.02.05','DESPERDICIO DE MERCADERÍA POR ROBO, ROTURA O EXTRAVÍO','','\0','DMRRE','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(154,'02.01.02.04','RETENCIONES A PAGAR','','\0','RAP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(155,'02.01.02.06','COMISIONES A PAGAR','','\0','COMPAG','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(156,'04.01.00.01','RECARGOS ','','\0','REC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(157,'04.02.99.01','ROPA DE TRABAJO','','\0','RDT','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(158,'05.03.00.00','DESCUENTOS OBTENIDOS','','\0','DTOOBTEN','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(159,'01.01.01.10','BANCO FRANCES CTA CTE $','','','BCOFRACC$','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(160,'06.00.00.00','GASTOS NO IMPUTABLES','','\0','GNI','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(161,'04.04.99.01','GASTOS POR CHEQUES RECHAZADOS','','\0','GCR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(162,'05.04.00.00','GASTOS DE IMPORTACION RECUPERADOS','','\0','GIR','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(163,'04.05.04.01','SOFTWARE Y LICENCIAS V.O.','','\0','SFTLIC','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(164,'04.02.99.02','FLETES ','','\0','FLETES','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(165,'04.02.99.03','ALMUERZOS','','\0','ALMUERZOS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(166,'04.04.02.08','SEGURIDAD E HIGIENE','','\0','SEH','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(167,'04.04.99.02','CAFE Y AGUA','','\0','CAFEAGUA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(168,'02.01.03.02','PERCEPCION IIBB A PAGAR','','\0','PERIIBB','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(169,'02.01.02.05','PERCEPCIONES A PAGAR','','\0','PAP','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(170,'05.05.00.00','DESCUENTOS ESPECIALES OTORGADOS','','\0','DSCEO','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(171,'01.01.02.06','RETENCIONES A DESCONTAR IVA','','\0','RETDIVA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(172,'01.01.02.07','RETENCIONES A DESCONTAR IIBB','','\0','RETDIB','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(173,'01.01.02.08','RETENCIONES A DESCONTAR GANANCIAS','','\0','RETDGAN','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(174,'01.01.02.09','RETENCIONES A DESCONTAR SUSS','','\0','RETDSUS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(175,'01.01.02.10','PERCEPCIONES A DESCONTAR IVA','','\0','PERDIVA','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(176,'01.01.02.11','PERCEPCIONES A DESCONTAR IIBB','','\0','PERDIB','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(177,'01.01.02.12','PERCEPCIONES A DESCONTAR GANANCIAS','\0','\0','PERDGAN','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(178,'01.01.02.13','PERCEPCIONES A DESCONTAR SUSS','\0','\0','PERDSUS','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(179,'04.06.02.06','IMPUESTOS INTERNOS','','\0','IMPINT','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(180,'04.03.99.01','GASTOS EN CONCEPTO DE PROMOCION','','\0','','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(181,'05.01.00.01','DEVOLUCIONES DE MERCADERIA','','\0','DEVOL','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(182,'04.06.02.07','AJUSTE CTA CTE PROVEEDORES','','\0','AJCPROV','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(183,'04.06.02.08','AJUSTE CTA CTE CLIENTES','','\0','AJCCLI','\0','SUPER','2013-07-30 23:54:50','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(184,'01.01.01.11','TARJETA DE CREDITO','','\0','TARCR','\0','SUPER','2014-06-11 00:00:00','PC-MG # admin',NULL,NULL,NULL,NULL,NULL,''),
(185,'01.01.01.12','TARJETA DE DEBITO','','\0','TARDB','\0','SUPER','2014-06-11 00:00:00','PC-MG # admin',NULL,NULL,NULL,NULL,NULL,''),
(186,'01.01.04.02','ARTICULO PROVEEDOR','','\0','ART','\0','SUPER','2017-03-07 09:17:30','MG # betiana','SUPER','2017-03-07 00:00:00','MG # betiana',NULL,NULL,''),
(187,'01.01.01.13','COMBUSTIBLE','','\0','COMB','\0','SUPER','2019-09-04 10:30:27','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(188,'01.01.02.06','CHEQUE SIN FONDOS','\0','\0','CHSF','','SUPER','2020-04-20 11:39:53','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(189,'01.01.02.07','CHEQUE MAL CONFECCIONADO','\0','\0','CHMC','\0','SUPER','2020-04-24 09:40:47','MG # betiana',NULL,NULL,NULL,NULL,NULL,''),
(190,'04.02.01.01','ERROR DE COMPROBANTE','','\0','ERRCB','\0','SUPER','2021-02-26 12:31:14','SERVER # mgcarburacion',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `planctas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planillas`
--

DROP TABLE IF EXISTS `planillas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planillas` (
  `idPlanilla` int(11) NOT NULL,
  `idProv` int(11) NOT NULL,
  `ruta` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idPlanilla`),
  UNIQUE KEY `idPlanilla` (`idPlanilla`),
  KEY `idProv` (`idProv`),
  CONSTRAINT `planillas_ibfk_1` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planillas`
--

LOCK TABLES `planillas` WRITE;
/*!40000 ALTER TABLE `planillas` DISABLE KEYS */;
INSERT INTO `planillas` VALUES
(1,2,'X');
/*!40000 ALTER TABLE `planillas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promo_artic`
--

DROP TABLE IF EXISTS `promo_artic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promo_artic` (
  `idpromo_c` int(11) NOT NULL COMMENT 'Id. de cabecera de promoción',
  `idArticulo` int(11) NOT NULL COMMENT 'Id. de artículo merchandising',
  PRIMARY KEY (`idpromo_c`,`idArticulo`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `promo_artic_ibfk_1` FOREIGN KEY (`idpromo_c`) REFERENCES `promo_cab` (`idpromo_c`),
  CONSTRAINT `promo_artic_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Merchandising asociado a la promoción';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promo_artic`
--

LOCK TABLES `promo_artic` WRITE;
/*!40000 ALTER TABLE `promo_artic` DISABLE KEYS */;
/*!40000 ALTER TABLE `promo_artic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promo_cab`
--

DROP TABLE IF EXISTS `promo_cab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promo_cab` (
  `idpromo_c` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id. de promoción',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre de la promoción',
  `vigencia_d` datetime NOT NULL COMMENT 'Fecha de vigencia desde',
  `vigencia_h` datetime NOT NULL COMMENT 'Fecha de vigencia hasta',
  `imp_tope` decimal(20,2) NOT NULL COMMENT 'Importe tope',
  `usuAlta` varchar(5) NOT NULL COMMENT 'Usuario de alta',
  `fecAlta` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de alta',
  `idHostAlta` varchar(50) NOT NULL COMMENT 'Id. Host de alta',
  `usuModi` varchar(5) DEFAULT NULL COMMENT 'Usuario de modificación',
  `fecModi` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `idHostModi` varchar(50) DEFAULT NULL COMMENT 'Id. host de modificación',
  `usuBaja` varchar(5) DEFAULT NULL COMMENT 'Usuario de baja',
  `fecBaja` datetime DEFAULT NULL COMMENT 'Fecha de baja',
  `idHostBaja` varchar(50) DEFAULT NULL COMMENT 'Id. host baja',
  PRIMARY KEY (`idpromo_c`),
  UNIQUE KEY `idpromo_c` (`idpromo_c`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Cabecera de promociones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promo_cab`
--

LOCK TABLES `promo_cab` WRITE;
/*!40000 ALTER TABLE `promo_cab` DISABLE KEYS */;
/*!40000 ALTER TABLE `promo_cab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promo_cli`
--

DROP TABLE IF EXISTS `promo_cli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promo_cli` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id. de medición',
  `idpromo_c` int(11) NOT NULL COMMENT 'Id. de cabecera de promoción a analizar',
  `idCliente` int(11) NOT NULL COMMENT 'Id. de cliente analizado',
  `idVentasC` int(11) NOT NULL COMMENT 'Id. de cabecera de venta',
  `cbte` varchar(3) NOT NULL COMMENT 'Tipo de comprobante',
  `cuenta` int(11) NOT NULL COMMENT 'Indica si los valores corresponden a cuenta 1 o 2',
  `imp_tope` decimal(20,2) NOT NULL COMMENT 'Importe tope de la promoción',
  `total_vend` decimal(20,2) NOT NULL COMMENT 'Total vendido vendido de las marcas que se incluyen en la promo',
  PRIMARY KEY (`id`),
  KEY `idpromo_c` (`idpromo_c`),
  KEY `idCliente` (`idCliente`),
  CONSTRAINT `promo_cli_ibfk_1` FOREIGN KEY (`idpromo_c`) REFERENCES `promo_cab` (`idpromo_c`),
  CONSTRAINT `promo_cli_ibfk_2` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Esta tabla contiene las mediciones por cliente para alcanzar la promo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promo_cli`
--

LOCK TABLES `promo_cli` WRITE;
/*!40000 ALTER TABLE `promo_cli` DISABLE KEYS */;
/*!40000 ALTER TABLE `promo_cli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promo_clim`
--

DROP TABLE IF EXISTS `promo_clim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promo_clim` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id.',
  `idpromocli` int(11) NOT NULL COMMENT 'Id. de medición asociada',
  `idCliente` int(11) NOT NULL COMMENT 'Id. de cliente asociado',
  `idArticulo` int(11) NOT NULL COMMENT 'Id. de artículo',
  `codArt` varchar(20) NOT NULL COMMENT 'Código de artículo merchandisign',
  `descripcio` varchar(200) NOT NULL COMMENT 'Descripción del artículo merchandising',
  `cantidad` decimal(20,2) NOT NULL COMMENT 'Cantidad que se lleva',
  PRIMARY KEY (`id`),
  KEY `idpromocli` (`idpromocli`),
  KEY `idCliente` (`idCliente`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `promo_clim_ibfk_1` FOREIGN KEY (`idpromocli`) REFERENCES `promo_cli` (`id`),
  CONSTRAINT `promo_clim_ibfk_2` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `promo_clim_ibfk_3` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Esta tabla contiene los merchandasing que se llevará el cliente si alcanza el tope';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promo_clim`
--

LOCK TABLES `promo_clim` WRITE;
/*!40000 ALTER TABLE `promo_clim` DISABLE KEYS */;
/*!40000 ALTER TABLE `promo_clim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promo_marcas`
--

DROP TABLE IF EXISTS `promo_marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promo_marcas` (
  `idpromo_c` int(11) NOT NULL COMMENT 'Id. de cabecera de promoción',
  `idmarca` int(11) NOT NULL COMMENT 'Id. de marca asocada',
  PRIMARY KEY (`idpromo_c`,`idmarca`),
  KEY `idmarca` (`idmarca`),
  CONSTRAINT `promo_marcas_ibfk_1` FOREIGN KEY (`idpromo_c`) REFERENCES `promo_cab` (`idpromo_c`),
  CONSTRAINT `promo_marcas_ibfk_2` FOREIGN KEY (`idmarca`) REFERENCES `marcas` (`idmarca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Marcas que intervienen en la promoción';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promo_marcas`
--

LOCK TABLES `promo_marcas` WRITE;
/*!40000 ALTER TABLE `promo_marcas` DISABLE KEYS */;
/*!40000 ALTER TABLE `promo_marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `idProv` int(11) NOT NULL,
  `razSoc` varchar(60) NOT NULL,
  `nomFant` varchar(60) DEFAULT NULL,
  `direccion` varchar(60) NOT NULL,
  `idLocalid` int(11) NOT NULL,
  `idCondPago` int(11) NOT NULL,
  `idSitIVA` int(11) NOT NULL,
  `nroCUIT` varchar(20) NOT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `eMail` varchar(60) DEFAULT NULL,
  `pagWeb` varchar(60) DEFAULT NULL,
  `observ` text DEFAULT NULL,
  `contacto` varchar(60) DEFAULT NULL,
  `habilitado` bit(1) NOT NULL,
  `tMon` varchar(3) NOT NULL DEFAULT 'PSO',
  `cotizac` float NOT NULL DEFAULT 0,
  `idTransp` int(11) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `proc_name` varchar(20) DEFAULT NULL,
  `idTipoDoc` int(11) DEFAULT NULL,
  PRIMARY KEY (`idProv`),
  KEY `fk_Proveedores_Localidades1` (`idLocalid`),
  KEY `fk_Proveedores_CondPagos1` (`idCondPago`),
  KEY `fk_Proveedores_SitIVA1` (`idSitIVA`),
  KEY `fk_prov_transp` (`idTransp`),
  CONSTRAINT `fk_Proveedores_CondPagos1` FOREIGN KEY (`idCondPago`) REFERENCES `condpagos` (`idCondPago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proveedores_Localidades1` FOREIGN KEY (`idLocalid`) REFERENCES `localidad` (`idLocalid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proveedores_SitIVA1` FOREIGN KEY (`idSitIVA`) REFERENCES `sitiva` (`idSitIVA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_prov_transp` FOREIGN KEY (`idTransp`) REFERENCES `transp` (`idTransp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES
(1,'PROVEEDOR X','PROVEEDOR X','AV. X',2628,1,1,'1','','','','','Proveedor para artículos varios','','\0','PSO',0,1,'SUPER','2022-03-30 16:58:08','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'',0),
(2,'PROVEEDOR A','PROVEEDOR A','AV. X 100',2628,1,1,'2','','','','','','','','PSO',0,1,'SUPER','2022-03-30 18:01:56','ESCRITORIO # Leonardo','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,'',0),
(3,'PROVEEDOR B','PROVEEDOR B','AV X 200',68,1,1,'3','','','','','','','','PSO',0,1,'SUPER','2022-03-30 18:02:22','ESCRITORIO # Leonardo','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,'',0),
(4,'PROVEEDOR C','PROVEEDOR C','AV. X 400',2628,1,1,'4','','','','','','','','PSO',0,1,'SUPER','2022-03-30 18:02:53','ESCRITORIO # Leonardo','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,'',0),
(5,'LEONARDO D. ZULLI','','',3033,2,1,'20280456919','','','','','','','','PSO',0,1,'SUPER','2024-07-22 07:49:45','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,NULL,NULL,NULL,'',1);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provincias`
--

DROP TABLE IF EXISTS `provincias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provincias` (
  `idProvin` int(11) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idProvin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincias`
--

LOCK TABLES `provincias` WRITE;
/*!40000 ALTER TABLE `provincias` DISABLE KEYS */;
INSERT INTO `provincias` VALUES
(1,'BUENOS AIRES','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,'CATAMARCA','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'CHACO','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4,'CHUBUT','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,'CÓRDOBA','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(6,'CORRIENTES','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7,'ENTRE RÍOS','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8,'FORMOSA','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9,'JUJUY','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(10,'LA PAMPA','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(11,'LA RIOJA','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(12,'MENDOZA','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(13,'MISIONES','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(14,'NEUQUÉN','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(15,'RIO NEGRO','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(16,'SALTA','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(17,'SAN JUAN','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(18,'SAN LUIS','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(19,'SANTA CRUZ','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(20,'SANTA FE','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(21,'SANTIAGO DEL ESTERO','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(22,'TIERRA DEL FUEGO','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(23,'TUCUMÁN','SUPER','2013-07-30 23:55:11','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(24,'CAPITAL FEDERAL','SUPER','2017-08-31 16:14:02','MG # betiana',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `provincias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ramo_mrcv`
--

DROP TABLE IF EXISTS `ramo_mrcv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ramo_mrcv` (
  `idMarcaV` int(11) NOT NULL,
  `idRamo` int(11) NOT NULL,
  PRIMARY KEY (`idMarcaV`,`idRamo`),
  KEY `idRamo` (`idRamo`),
  CONSTRAINT `ramo_mrcv_ibfk_1` FOREIGN KEY (`idMarcaV`) REFERENCES `marcas_v` (`idMarcaV`),
  CONSTRAINT `ramo_mrcv_ibfk_2` FOREIGN KEY (`idRamo`) REFERENCES `ramos` (`idRamo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ramo_mrcv`
--

LOCK TABLES `ramo_mrcv` WRITE;
/*!40000 ALTER TABLE `ramo_mrcv` DISABLE KEYS */;
/*!40000 ALTER TABLE `ramo_mrcv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ramo_sf`
--

DROP TABLE IF EXISTS `ramo_sf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ramo_sf` (
  `idSubFam` int(11) NOT NULL,
  `idRamo` int(11) NOT NULL,
  PRIMARY KEY (`idSubFam`,`idRamo`),
  KEY `idRamo` (`idRamo`),
  CONSTRAINT `ramo_sf_ibfk_1` FOREIGN KEY (`idSubFam`) REFERENCES `subfam` (`idSubFam`),
  CONSTRAINT `ramo_sf_ibfk_2` FOREIGN KEY (`idRamo`) REFERENCES `ramos` (`idRamo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ramo_sf`
--

LOCK TABLES `ramo_sf` WRITE;
/*!40000 ALTER TABLE `ramo_sf` DISABLE KEYS */;
/*!40000 ALTER TABLE `ramo_sf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ramofam`
--

DROP TABLE IF EXISTS `ramofam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ramofam` (
  `idFamilia` int(11) NOT NULL,
  `idRamo` int(11) NOT NULL,
  PRIMARY KEY (`idFamilia`,`idRamo`),
  KEY `idRamo` (`idRamo`),
  CONSTRAINT `ramofam_ibfk_1` FOREIGN KEY (`idRamo`) REFERENCES `ramos` (`idRamo`),
  CONSTRAINT `ramofam_ibfk_2` FOREIGN KEY (`idFamilia`) REFERENCES `familias` (`idFamilia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ramofam`
--

LOCK TABLES `ramofam` WRITE;
/*!40000 ALTER TABLE `ramofam` DISABLE KEYS */;
/*!40000 ALTER TABLE `ramofam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ramos`
--

DROP TABLE IF EXISTS `ramos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ramos` (
  `idRamo` int(11) NOT NULL,
  `descripcio` varchar(30) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(60) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(60) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idRamo`),
  UNIQUE KEY `idRamo` (`idRamo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ramos`
--

LOCK TABLES `ramos` WRITE;
/*!40000 ALTER TABLE `ramos` DISABLE KEYS */;
INSERT INTO `ramos` VALUES
(1,'RAMO GENERAL','SUPER','2015-04-17 12:39:38','FACTURACION # Facturación',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `ramos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rccob_c`
--

DROP TABLE IF EXISTS `rccob_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rccob_c` (
  `idRCCob_C` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `nroRec` varchar(13) NOT NULL,
  `fecEmis` datetime NOT NULL,
  `importe` double NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idRCCob_C`),
  UNIQUE KEY `idRCCob_C` (`idRCCob_C`),
  KEY `idCliente` (`idCliente`),
  CONSTRAINT `rccob_c_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rccob_c`
--

LOCK TABLES `rccob_c` WRITE;
/*!40000 ALTER TABLE `rccob_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `rccob_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rccob_d`
--

DROP TABLE IF EXISTS `rccob_d`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rccob_d` (
  `idRCCob_D` int(11) NOT NULL,
  `idRCCob_C` int(11) NOT NULL,
  `idCheque` int(11) DEFAULT NULL,
  `idPlanCta` int(11) DEFAULT NULL,
  `idBanco` int(11) DEFAULT NULL,
  `chq_nro` varchar(60) DEFAULT NULL,
  `importe` double NOT NULL,
  `tipopago` varchar(5) DEFAULT NULL,
  `idProvin` int(11) DEFAULT NULL,
  `retCompro` int(11) DEFAULT NULL,
  `retFecha` datetime DEFAULT NULL,
  `nroTransf` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idRCCob_D`),
  UNIQUE KEY `idRCCob_D` (`idRCCob_D`),
  KEY `idCheque` (`idCheque`),
  KEY `idPlanCta` (`idPlanCta`),
  KEY `fk_rccob_d_rccob_c1_idx` (`idRCCob_C`),
  KEY `fk_rccob_d_provincias1_idx` (`idProvin`),
  CONSTRAINT `fk_rccob_d_provincias1` FOREIGN KEY (`idProvin`) REFERENCES `provincias` (`idProvin`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rccob_d_rccob_c1` FOREIGN KEY (`idRCCob_C`) REFERENCES `rccob_c` (`idRCCob_C`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `rccob_d_ibfk_1` FOREIGN KEY (`idCheque`) REFERENCES `cheques` (`idCheque`),
  CONSTRAINT `rccob_d_ibfk_2` FOREIGN KEY (`idPlanCta`) REFERENCES `planctas` (`idPlanCta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rccob_d`
--

LOCK TABLES `rccob_d` WRITE;
/*!40000 ALTER TABLE `rccob_d` DISABLE KEYS */;
/*!40000 ALTER TABLE `rccob_d` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rccob_dv`
--

DROP TABLE IF EXISTS `rccob_dv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rccob_dv` (
  `idRCCob_DV` int(11) NOT NULL,
  `idRCCob_C` int(11) NOT NULL,
  `idVentasC` int(11) NOT NULL,
  `totCbte` double NOT NULL DEFAULT 0,
  `impApl` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`idRCCob_DV`),
  UNIQUE KEY `idRCCob_DV` (`idRCCob_DV`),
  KEY `idRCCob_C` (`idRCCob_C`),
  KEY `idVentasC` (`idVentasC`),
  CONSTRAINT `rccob_dv_ibfk_1` FOREIGN KEY (`idRCCob_C`) REFERENCES `rccob_c` (`idRCCob_C`),
  CONSTRAINT `rccob_dv_ibfk_2` FOREIGN KEY (`idVentasC`) REFERENCES `ventascab` (`idVentasC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rccob_dv`
--

LOCK TABLES `rccob_dv` WRITE;
/*!40000 ALTER TABLE `rccob_dv` DISABLE KEYS */;
/*!40000 ALTER TABLE `rccob_dv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_aux_fichadet`
--

DROP TABLE IF EXISTS `rcn_aux_fichadet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_aux_fichadet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_ficha` int(11) NOT NULL,
  `cantidad` decimal(20,2) DEFAULT NULL,
  `idArticulo` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `descripcio` varchar(200) NOT NULL,
  `usuario` varchar(5) NOT NULL,
  `host` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_aux_fichadet`
--

LOCK TABLES `rcn_aux_fichadet` WRITE;
/*!40000 ALTER TABLE `rcn_aux_fichadet` DISABLE KEYS */;
/*!40000 ALTER TABLE `rcn_aux_fichadet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_aux_fichas_rtosal`
--

DROP TABLE IF EXISTS `rcn_aux_fichas_rtosal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_aux_fichas_rtosal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_ficha` int(11) NOT NULL,
  `usuario` varchar(5) NOT NULL,
  `host` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_aux_fichas_rtosal`
--

LOCK TABLES `rcn_aux_fichas_rtosal` WRITE;
/*!40000 ALTER TABLE `rcn_aux_fichas_rtosal` DISABLE KEYS */;
/*!40000 ALTER TABLE `rcn_aux_fichas_rtosal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_aux_rtitem`
--

DROP TABLE IF EXISTS `rcn_aux_rtitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_aux_rtitem` (
  `id` int(11) NOT NULL,
  `idmarca` int(11) NOT NULL COMMENT 'Marca',
  `medida` decimal(20,2) NOT NULL COMMENT 'Medida',
  `nro_serie` varchar(20) NOT NULL COMMENT 'Número de serie',
  `trabajo` varchar(100) NOT NULL COMMENT 'Trabajo a realizar',
  `usuario` varchar(5) NOT NULL,
  `host` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_aux_rtitem`
--

LOCK TABLES `rcn_aux_rtitem` WRITE;
/*!40000 ALTER TABLE `rcn_aux_rtitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `rcn_aux_rtitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_estado`
--

DROP TABLE IF EXISTS `rcn_estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_estado` (
  `id_estado` int(11) NOT NULL,
  `descripcio` varchar(30) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_estado`),
  UNIQUE KEY `id_estado` (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_estado`
--

LOCK TABLES `rcn_estado` WRITE;
/*!40000 ALTER TABLE `rcn_estado` DISABLE KEYS */;
INSERT INTO `rcn_estado` VALUES
(1,'PENDIENTE','SUPER','2023-05-03 12:05:46','LEO_NOTEBOOK # LINFOW','SUPER','2023-05-03 00:00:00','LEO_NOTEBOOK # LINFOW',NULL,NULL,''),
(2,'EN PROCESO','SUPER','2023-06-19 12:51:39','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(3,'FINALIZADO','SUPER','2023-06-19 12:51:54','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(4,'ENTREGADO','SUPER','2023-06-19 12:52:15','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `rcn_estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_estcra`
--

DROP TABLE IF EXISTS `rcn_estcra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_estcra` (
  `id_estcra` int(11) NOT NULL,
  `descripcio` varchar(30) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_estcra`),
  UNIQUE KEY `id_estcra` (`id_estcra`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_estcra`
--

LOCK TABLES `rcn_estcra` WRITE;
/*!40000 ALTER TABLE `rcn_estcra` DISABLE KEYS */;
INSERT INTO `rcn_estcra` VALUES
(1,'SIN ESTADO','SUPER','2023-06-09 16:41:15','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(2,'NORMAL DE CRATER','SUPER','2023-06-09 16:41:28','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(3,'EXESO DE CRATER','SUPER','2023-06-09 16:41:38','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(4,'ABERTURA CANALETA','SUPER','2023-06-09 16:41:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(5,'RETIRADA 4° CINTA','SUPER','2023-06-09 16:41:57','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `rcn_estcra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_ficha`
--

DROP TABLE IF EXISTS `rcn_ficha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_ficha` (
  `id_ficha` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id. de ficha',
  `id_estado` int(11) NOT NULL COMMENT 'Estado',
  `id_motrec` int(11) DEFAULT NULL COMMENT 'Motivo de rechazo',
  `idmarca` int(11) NOT NULL COMMENT 'Marca de la cubierta',
  `medida` decimal(20,2) NOT NULL,
  `nro_serie` varchar(20) NOT NULL,
  `trabajo` varchar(100) NOT NULL,
  `camsecgdo` decimal(20,2) DEFAULT NULL,
  `matricula` varchar(100) DEFAULT NULL COMMENT 'Matricula',
  `referencia` int(11) DEFAULT NULL COMMENT 'Número de referencia',
  `vulcaniza` bit(1) NOT NULL DEFAULT b'0',
  `aprobado` bit(1) NOT NULL DEFAULT b'0',
  `aprob_sg` bit(1) NOT NULL DEFAULT b'0',
  `rechazado` bit(1) NOT NULL DEFAULT b'0',
  `radio` decimal(20,2) DEFAULT NULL COMMENT 'Radio',
  `perimetro` decimal(20,2) DEFAULT NULL COMMENT 'Perimetro',
  `ancho` decimal(20,2) DEFAULT NULL COMMENT 'Ancho',
  `observ` text DEFAULT NULL,
  `parch_ant` bit(1) NOT NULL DEFAULT b'0',
  `id_rtoent` int(11) DEFAULT NULL,
  `id_rtosal` int(11) DEFAULT NULL,
  `id_operad` int(11) DEFAULT NULL,
  `id_estcra` int(11) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `idop_recep` int(11) DEFAULT NULL COMMENT 'Id. Operador recepcion',
  `idop_exapr` int(11) DEFAULT NULL COMMENT 'Id. Operador examen preliminar',
  `idop_rasp` int(11) DEFAULT NULL COMMENT 'Id. operador raspado',
  `idop_esca` int(11) DEFAULT NULL COMMENT 'Id. operador ecareacion',
  `idop_appar` int(11) DEFAULT NULL COMMENT 'Id. operador de aplicación de parches',
  `idVentasC` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ficha`),
  UNIQUE KEY `id_ficha` (`id_ficha`),
  KEY `id_rtoent` (`id_rtoent`),
  KEY `id_operad` (`id_operad`),
  KEY `id_estcra` (`id_estcra`),
  KEY `id_estado` (`id_estado`),
  KEY `id_motrec` (`id_motrec`),
  KEY `idmarca` (`idmarca`),
  KEY `fk_rcn_ficha_rcn_remito_salida` (`id_rtosal`),
  KEY `fk_rcn_ficha_rcn_ventas` (`idVentasC`),
  CONSTRAINT `fk_rcn_ficha_rcn_remito_salida` FOREIGN KEY (`id_rtosal`) REFERENCES `rcn_remito` (`id_rtoent`),
  CONSTRAINT `fk_rcn_ficha_rcn_ventas` FOREIGN KEY (`idVentasC`) REFERENCES `ventascab` (`idVentasC`),
  CONSTRAINT `rcn_ficha_ibfk_1` FOREIGN KEY (`id_rtoent`) REFERENCES `rcn_remito` (`id_rtoent`),
  CONSTRAINT `rcn_ficha_ibfk_2` FOREIGN KEY (`id_operad`) REFERENCES `rcn_operad` (`id_operad`),
  CONSTRAINT `rcn_ficha_ibfk_3` FOREIGN KEY (`id_estcra`) REFERENCES `rcn_estcra` (`id_estcra`),
  CONSTRAINT `rcn_ficha_ibfk_5` FOREIGN KEY (`id_estado`) REFERENCES `rcn_estado` (`id_estado`),
  CONSTRAINT `rcn_ficha_ibfk_6` FOREIGN KEY (`id_motrec`) REFERENCES `rcn_motrec` (`id_motrec`),
  CONSTRAINT `rcn_ficha_ibfk_7` FOREIGN KEY (`idmarca`) REFERENCES `marcas` (`idmarca`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Factura asociadas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_ficha`
--

LOCK TABLES `rcn_ficha` WRITE;
/*!40000 ALTER TABLE `rcn_ficha` DISABLE KEYS */;
INSERT INTO `rcn_ficha` VALUES
(1,2,1,2,675.00,'55487','RL002',600.00,'',0,'\0','\0','\0','',20.00,60.00,20.00,'Esto es una prueba de grabación y recuperación de observaciones.','',2,NULL,NULL,2,'SUPER','2023-05-24 15:16:53','LEO_NOTEBOOK # LINFOW','SUPER','2023-06-21 19:49:03','ESCRITORIO # leonardo',NULL,NULL,NULL,1,1,1,1,NULL,NULL),
(2,2,1,2,654.00,'1234','RL001',6.00,'1221',1,'\0','','\0','\0',6.00,6.00,6.00,'Prueba','',2,NULL,NULL,2,'SUPER','2023-05-24 15:16:53','LEO_NOTEBOOK # LINFOW','SUPER','2023-06-21 20:48:06','ESCRITORIO # leonardo',NULL,NULL,NULL,1,1,1,1,NULL,NULL),
(3,1,NULL,2,675.00,'1235545','RZL0002',0.00,'',0,'\0','\0','\0','\0',0.00,0.00,0.00,'','\0',3,NULL,NULL,1,'SUPER','2023-05-31 10:03:57','LEO_NOTEBOOK # LINFOW','SUPER','2023-06-21 21:05:25','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `rcn_ficha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_fichadet`
--

DROP TABLE IF EXISTS `rcn_fichadet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_fichadet` (
  `id_fichadet` int(11) NOT NULL,
  `id_ficha` bigint(20) NOT NULL,
  `idArticulo` int(11) DEFAULT NULL,
  `cantidad` decimal(20,2) DEFAULT NULL,
  `codArt` varchar(20) DEFAULT NULL,
  `descripcio` varchar(200) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_fichadet`,`id_ficha`),
  KEY `id_ficha` (`id_ficha`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `rcn_fichadet_ibfk_1` FOREIGN KEY (`id_ficha`) REFERENCES `rcn_ficha` (`id_ficha`),
  CONSTRAINT `rcn_fichadet_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_fichadet`
--

LOCK TABLES `rcn_fichadet` WRITE;
/*!40000 ALTER TABLE `rcn_fichadet` DISABLE KEYS */;
INSERT INTO `rcn_fichadet` VALUES
(1,1,143,5.00,'PROD001','ECONOMICOS CON PUNTERA ACOL. PVC','SUPER','2023-06-21 19:49:03','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(1,2,143,5.00,'PROD001','ECONOMICOS CON PUNTERA ACOL. PVC','SUPER','2023-06-21 20:48:06','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(2,1,144,2.00,'PROD002','ECONOMICOS SIN PUNTERA ACOL. PVC','SUPER','2023-06-21 19:49:03','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3,1,145,1.00,'PROD003','SENIOR FORRADO CON CUERO BOX C/PUNT','SUPER','2023-06-21 19:49:03','ESCRITORIO # leonardo',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `rcn_fichadet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_motrec`
--

DROP TABLE IF EXISTS `rcn_motrec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_motrec` (
  `id_motrec` int(11) NOT NULL,
  `descripcio` varchar(30) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_motrec`),
  UNIQUE KEY `id_motrec` (`id_motrec`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_motrec`
--

LOCK TABLES `rcn_motrec` WRITE;
/*!40000 ALTER TABLE `rcn_motrec` DISABLE KEYS */;
INSERT INTO `rcn_motrec` VALUES
(1,'EXCESO DE PARCHES','SUPER','2023-05-24 15:27:16','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(2,'EXCESO DE PICADURAS','SUPER','2023-05-24 15:31:02','LEO_NOTEBOOK # LINFOW','SUPER','2023-05-24 00:00:00','LEO_NOTEBOOK # LINFOW',NULL,NULL,''),
(3,'DESCOLOCAMIENTO ENTRE TELAS','SUPER','2023-05-24 15:31:35','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(4,'DESGASTE EXCESIVO','SUPER','2023-05-24 15:31:54','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(5,'RODAJE CON BAJA PRESION','SUPER','2023-05-24 15:32:27','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(6,'NUMEROSAS GRIETAS RADIALES','SUPER','2023-05-24 15:32:42','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(7,'DETERIORO DE TALON','SUPER','2023-05-24 15:33:02','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(8,'CONTAMINACION C/ACEITE O GRASA','SUPER','2023-05-24 15:33:46','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(9,'OTROS','SUPER','2023-05-24 15:33:59','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `rcn_motrec` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_operad`
--

DROP TABLE IF EXISTS `rcn_operad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_operad` (
  `id_operad` int(11) NOT NULL,
  `apelnom` varchar(60) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_operad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_operad`
--

LOCK TABLES `rcn_operad` WRITE;
/*!40000 ALTER TABLE `rcn_operad` DISABLE KEYS */;
INSERT INTO `rcn_operad` VALUES
(1,'LEONARDO','SUPER','2023-05-31 10:00:57','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(2,'GISEL','SUPER','2023-05-31 10:01:03','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `rcn_operad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_remito`
--

DROP TABLE IF EXISTS `rcn_remito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_remito` (
  `id_rtoent` int(11) NOT NULL,
  `id_tiporto` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `destino` varchar(200) NOT NULL,
  `observaciones` text DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_rtoent`),
  UNIQUE KEY `id_rtoent` (`id_rtoent`),
  KEY `fk_rcn_tiporto_id_tiporto` (`id_tiporto`),
  KEY `fk_clientes_idCliente` (`idCliente`),
  CONSTRAINT `fk_clientes_idCliente` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `fk_rcn_tiporto_id_tiporto` FOREIGN KEY (`id_tiporto`) REFERENCES `rcn_tiporto` (`id_tiporto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_remito`
--

LOCK TABLES `rcn_remito` WRITE;
/*!40000 ALTER TABLE `rcn_remito` DISABLE KEYS */;
INSERT INTO `rcn_remito` VALUES
(1,1,2,'100','MINGO','','SUPER','2023-05-24 15:11:07','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(2,1,2,'100','MINGO','','SUPER','2023-05-24 15:16:53','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL),
(3,1,2,'1000','MINGO','','SUPER','2023-05-31 10:03:57','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `rcn_remito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rcn_tiporto`
--

DROP TABLE IF EXISTS `rcn_tiporto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcn_tiporto` (
  `id_tiporto` int(11) NOT NULL,
  `descripcio` varchar(30) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_tiporto`),
  UNIQUE KEY `id_tiporto` (`id_tiporto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rcn_tiporto`
--

LOCK TABLES `rcn_tiporto` WRITE;
/*!40000 ALTER TABLE `rcn_tiporto` DISABLE KEYS */;
INSERT INTO `rcn_tiporto` VALUES
(1,'ENTRADA','SUPER','2023-05-04 16:33:13','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,''),
(2,'SALIDA','SUPER','2023-05-04 16:33:18','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `rcn_tiporto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retiroscab`
--

DROP TABLE IF EXISTS `retiroscab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retiroscab` (
  `idRetiroC` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idVendedor` int(11) NOT NULL,
  `pendFC` bit(1) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idRetiroC`),
  UNIQUE KEY `idRetiroC` (`idRetiroC`),
  KEY `idCliente` (`idCliente`),
  KEY `idVendedor` (`idVendedor`),
  CONSTRAINT `retiroscab_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `retiroscab_ibfk_2` FOREIGN KEY (`idVendedor`) REFERENCES `vendedores` (`idVendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retiroscab`
--

LOCK TABLES `retiroscab` WRITE;
/*!40000 ALTER TABLE `retiroscab` DISABLE KEYS */;
/*!40000 ALTER TABLE `retiroscab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retirosdet`
--

DROP TABLE IF EXISTS `retirosdet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retirosdet` (
  `idRetiroC` int(11) NOT NULL,
  `idRetiroD` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecRetiro` datetime NOT NULL,
  `alicIVA` float NOT NULL,
  `prVenta` float NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idRetiroC`,`idRetiroD`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `retirosdet_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retirosdet`
--

LOCK TABLES `retirosdet` WRITE;
/*!40000 ALTER TABLE `retirosdet` DISABLE KEYS */;
/*!40000 ALTER TABLE `retirosdet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicios` (
  `idServ` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idVendedor` int(11) NOT NULL,
  `descripcio` varchar(100) NOT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `fecFact` datetime DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idServ`),
  UNIQUE KEY `idServ` (`idServ`),
  KEY `idCliente` (`idCliente`),
  KEY `idVendedor` (`idVendedor`),
  CONSTRAINT `servicios_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `servicios_ibfk_2` FOREIGN KEY (`idVendedor`) REFERENCES `vendedores` (`idVendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitiva`
--

DROP TABLE IF EXISTS `sitiva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitiva` (
  `idSitIVA` int(11) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `CodFiscal` int(11) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `codIVA` varchar(3) DEFAULT NULL,
  `conivareid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idSitIVA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitiva`
--

LOCK TABLES `sitiva` WRITE;
/*!40000 ALTER TABLE `sitiva` DISABLE KEYS */;
INSERT INTO `sitiva` VALUES
(1,'INSCRIPTO',73,'SUPER','2013-07-30 23:54:54','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'RI',1),
(2,'NO INSCRIPTO',78,'SUPER','2013-07-30 23:54:54','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'RNI',0),
(3,'CONSUMIDOR FINAL',67,'SUPER','2013-07-30 23:54:54','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'CF',5),
(4,'NO RESPONSABLE',65,'SUPER','2013-07-30 23:54:54','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'NR',0),
(5,'EXENTO',69,'SUPER','2013-07-30 23:54:54','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'EXE',4),
(6,'RESPONSABLE MONOTRIBUTO',77,'SUPER','2013-07-30 23:54:54','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'RM',6),
(7,'SUJETO NO CATEGORIZADO',84,'SUPER','2013-07-30 23:54:54','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL,'SNC',7);
/*!40000 ALTER TABLE `sitiva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stk_cab`
--

DROP TABLE IF EXISTS `stk_cab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stk_cab` (
  `idStkCab` int(11) NOT NULL,
  `circuito` varchar(1) NOT NULL,
  `cbte` varchar(3) DEFAULT NULL,
  `tipoDoc` varchar(1) DEFAULT NULL,
  `numCbte` varchar(20) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `idProv` int(11) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `idVentasC` int(11) DEFAULT NULL,
  `id_ficha` int(11) DEFAULT NULL,
  PRIMARY KEY (`idStkCab`),
  UNIQUE KEY `idStkCab` (`idStkCab`),
  KEY `fk_stk_cab_clientes1_idx` (`idCliente`),
  KEY `fk_stk_cab_proveedor1_idx` (`idProv`),
  CONSTRAINT `fk_stk_cab_clientes1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_stk_cab_proveedor1` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stk_cab`
--

LOCK TABLES `stk_cab` WRITE;
/*!40000 ALTER TABLE `stk_cab` DISABLE KEYS */;
INSERT INTO `stk_cab` VALUES
(1,'S','','','',NULL,4,'SUPER','2023-02-10 18:37:48','LEO_NOTEBOOK # LINFOW',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `stk_cab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stk_deps`
--

DROP TABLE IF EXISTS `stk_deps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stk_deps` (
  `idStkDep` int(11) NOT NULL,
  `codDep` varchar(5) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idStkDep`),
  UNIQUE KEY `idStkDep` (`idStkDep`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stk_deps`
--

LOCK TABLES `stk_deps` WRITE;
/*!40000 ALTER TABLE `stk_deps` DISABLE KEYS */;
INSERT INTO `stk_deps` VALUES
(1,'DEP','DEPOSITO PREDEFINIDO','SUPER','2013-08-21 09:00:53','LEONZXP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `stk_deps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stk_det`
--

DROP TABLE IF EXISTS `stk_det`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stk_det` (
  `idStkDet` int(11) NOT NULL,
  `idStkCab` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `idStkDep` int(11) NOT NULL,
  `tipoMov` varchar(3) NOT NULL,
  `cantidad` float NOT NULL,
  `costoRep` float NOT NULL DEFAULT 0,
  `nroPart` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idStkDet`,`idStkCab`),
  KEY `idStkCab` (`idStkCab`),
  KEY `idArticulo` (`idArticulo`),
  KEY `idStkDep` (`idStkDep`),
  CONSTRAINT `stk_det_ibfk_1` FOREIGN KEY (`idStkCab`) REFERENCES `stk_cab` (`idStkCab`),
  CONSTRAINT `stk_det_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`),
  CONSTRAINT `stk_det_ibfk_3` FOREIGN KEY (`idStkDep`) REFERENCES `stk_deps` (`idStkDep`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stk_det`
--

LOCK TABLES `stk_det` WRITE;
/*!40000 ALTER TABLE `stk_det` DISABLE KEYS */;
INSERT INTO `stk_det` VALUES
(1,1,143,1,'AJU',999,180.66,''),
(2,1,144,1,'AJU',999,179.79,''),
(3,1,145,1,'AJU',999,386.6,''),
(4,1,146,1,'AJU',999,449.75,''),
(5,1,147,1,'AJU',999,180.66,''),
(6,1,148,1,'AJU',999,179.79,''),
(7,1,149,1,'AJU',999,186.62,''),
(8,1,150,1,'AJU',999,185.01,''),
(9,1,151,1,'AJU',999,5.18,''),
(10,1,152,1,'AJU',999,5.47,''),
(11,1,153,1,'AJU',999,6.19,''),
(12,1,154,1,'AJU',999,6.91,''),
(13,1,155,1,'AJU',999,6.34,''),
(14,1,156,1,'AJU',999,7.06,''),
(15,1,157,1,'AJU',999,23.47,''),
(16,1,158,1,'AJU',999,27.79,''),
(17,1,159,1,'AJU',999,17.28,''),
(18,1,160,1,'AJU',999,41.18,''),
(19,1,161,1,'AJU',999,32.33,''),
(20,1,162,1,'AJU',999,5.27,'');
/*!40000 ALTER TABLE `stk_det` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stk_ingcab`
--

DROP TABLE IF EXISTS `stk_ingcab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stk_ingcab` (
  `idIngCab` int(11) NOT NULL,
  `idProv` int(11) NOT NULL,
  `cbte` varchar(3) NOT NULL,
  `tipo` varchar(1) NOT NULL,
  `numero` varchar(13) NOT NULL,
  `fecha` datetime NOT NULL,
  `controla` bit(1) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuCtrl` varchar(5) DEFAULT NULL,
  `fecCtrl` datetime DEFAULT NULL,
  `idHostCtrl` varchar(50) DEFAULT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `idstkcab` int(11) DEFAULT NULL,
  PRIMARY KEY (`idIngCab`),
  KEY `idProv` (`idProv`),
  CONSTRAINT `stk_ingcab_ibfk_1` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stk_ingcab`
--

LOCK TABLES `stk_ingcab` WRITE;
/*!40000 ALTER TABLE `stk_ingcab` DISABLE KEYS */;
/*!40000 ALTER TABLE `stk_ingcab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stk_ingdet`
--

DROP TABLE IF EXISTS `stk_ingdet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stk_ingdet` (
  `idIngDet` int(11) NOT NULL,
  `idIngCab` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `cantidad` float NOT NULL,
  `cantReci` float NOT NULL,
  `nroPart` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idIngDet`,`idIngCab`),
  KEY `idIngCab` (`idIngCab`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `stk_ingdet_ibfk_1` FOREIGN KEY (`idIngCab`) REFERENCES `stk_ingcab` (`idIngCab`),
  CONSTRAINT `stk_ingdet_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stk_ingdet`
--

LOCK TABLES `stk_ingdet` WRITE;
/*!40000 ALTER TABLE `stk_ingdet` DISABLE KEYS */;
/*!40000 ALTER TABLE `stk_ingdet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stk_part`
--

DROP TABLE IF EXISTS `stk_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stk_part` (
  `idStkPart` int(11) NOT NULL,
  `idStkCab` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `codArt` varchar(20) NOT NULL,
  `nroPart` varchar(30) NOT NULL,
  `cantidad` float NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`idStkPart`),
  UNIQUE KEY `idStkPart` (`idStkPart`),
  KEY `idArticulo` (`idArticulo`),
  KEY `fk_stk_part_stk_cab1_idx` (`idStkCab`),
  CONSTRAINT `fk_stk_part_stk_cab1` FOREIGN KEY (`idStkCab`) REFERENCES `stk_cab` (`idStkCab`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `stk_part_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stk_part`
--

LOCK TABLES `stk_part` WRITE;
/*!40000 ALTER TABLE `stk_part` DISABLE KEYS */;
/*!40000 ALTER TABLE `stk_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stk_tipomov`
--

DROP TABLE IF EXISTS `stk_tipomov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stk_tipomov` (
  `idTipomov` int(11) NOT NULL,
  `codMov` varchar(3) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `signo` int(11) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idTipomov`),
  UNIQUE KEY `idTipomov` (`idTipomov`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stk_tipomov`
--

LOCK TABLES `stk_tipomov` WRITE;
/*!40000 ALTER TABLE `stk_tipomov` DISABLE KEYS */;
INSERT INTO `stk_tipomov` VALUES
(1,'AJU','AJUSTE DE STOCK',0,'SUPER','2014-09-18 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL),
(2,'ENT','ENTRADA',1,'SUPER','2014-09-18 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'SAL','SALIDA',-1,'SUPER','2014-09-18 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL),
(4,'SAG','SALIDA GARANTIA',-1,'SUPER','2014-09-18 00:00:00','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `stk_tipomov` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subfam`
--

DROP TABLE IF EXISTS `subfam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subfam` (
  `idSubFam` int(11) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idSubFam`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subfam`
--

LOCK TABLES `subfam` WRITE;
/*!40000 ALTER TABLE `subfam` DISABLE KEYS */;
INSERT INTO `subfam` VALUES
(1,'VARIOS','SUPER','2022-03-30 17:46:35','ESCRITORIO # Leonardo',NULL,NULL,NULL,NULL,NULL,''),
(2,'SUBRUBRO 2','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'SUBRUBRO 3','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(4,'SUBRUBRO 4','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(5,'SUBRUBRO 5','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(6,'SUBRUBRO 6','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(7,'SUBRUBRO 7','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(8,'SUBRUBRO 8','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(9,'SUBRUBRO 9','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(10,'SUBRUBRO 10','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(11,'SUBRUBRO 11','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(12,'SUBRUBRO 12','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(13,'SUBRUBRO 13','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(14,'SUBRUBRO 14','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(15,'SUBRUBRO 15','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(16,'SUBRUBRO 16','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(17,'SUBRUBRO 17','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL),
(18,'SUBRUBRO 18','SUPER',NULL,'LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `subfam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tablas`
--

DROP TABLE IF EXISTS `tablas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tablas` (
  `idTabla` int(11) NOT NULL,
  `idHoja` int(11) NOT NULL,
  `idPlanilla` int(11) NOT NULL,
  `tableName` varchar(15) NOT NULL,
  `nFilaDD` int(11) NOT NULL,
  `nFilaHH` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idTabla`),
  UNIQUE KEY `idTabla` (`idTabla`),
  KEY `idHoja` (`idHoja`),
  KEY `idPlanilla` (`idPlanilla`),
  CONSTRAINT `tablas_ibfk_1` FOREIGN KEY (`idHoja`) REFERENCES `hojas` (`idHoja`),
  CONSTRAINT `tablas_ibfk_2` FOREIGN KEY (`idPlanilla`) REFERENCES `planillas` (`idPlanilla`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tablas`
--

LOCK TABLES `tablas` WRITE;
/*!40000 ALTER TABLE `tablas` DISABLE KEYS */;
INSERT INTO `tablas` VALUES
(1,1,1,'articulos',2,0);
/*!40000 ALTER TABLE `tablas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terminales`
--

DROP TABLE IF EXISTS `terminales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminales` (
  `idTerminal` int(11) NOT NULL,
  `hostName` varchar(60) NOT NULL,
  `fecha` datetime NOT NULL,
  `codUsu` varchar(5) NOT NULL,
  PRIMARY KEY (`idTerminal`),
  UNIQUE KEY `idTerminal` (`idTerminal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminales`
--

LOCK TABLES `terminales` WRITE;
/*!40000 ALTER TABLE `terminales` DISABLE KEYS */;
/*!40000 ALTER TABLE `terminales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipodoc`
--

DROP TABLE IF EXISTS `tipodoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipodoc` (
  `idTipoDoc` int(11) NOT NULL,
  `TipoDoc` varchar(4) NOT NULL,
  `Descripcio` varchar(40) NOT NULL,
  `CodAfip` varchar(2) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  PRIMARY KEY (`idTipoDoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipodoc`
--

LOCK TABLES `tipodoc` WRITE;
/*!40000 ALTER TABLE `tipodoc` DISABLE KEYS */;
INSERT INTO `tipodoc` VALUES
(1,'CUIT','CUIT','80',NULL),
(2,'DNI','DOC. NACIONAL DE IDENTIDAD','96',NULL),
(3,'CI','CEDULA DE IDENTIDAD','87',NULL),
(4,'LE','LIBRETA DE ENROLAMIENTO','89',NULL),
(5,'LC','LIBRETA CIVICA','90',NULL),
(6,'CUIL','CUIL','86',NULL),
(7,'CIE','','91',NULL),
(8,'PAS','PASAPORTE','94',NULL),
(9,'DESC','DESCONOCIDO','99',NULL);
/*!40000 ALTER TABLE `tipodoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposcli`
--

DROP TABLE IF EXISTS `tiposcli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tiposcli` (
  `idTipoCli` int(11) NOT NULL,
  `descripcio` varchar(60) NOT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(60) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(60) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`idTipoCli`),
  UNIQUE KEY `idTipoCli` (`idTipoCli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposcli`
--

LOCK TABLES `tiposcli` WRITE;
/*!40000 ALTER TABLE `tiposcli` DISABLE KEYS */;
INSERT INTO `tiposcli` VALUES
(1,'SIN CATEGORIZAR','SUPER','2014-02-02 00:00:00','LDZ_PC1 # usuario',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `tiposcli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipospagos`
--

DROP TABLE IF EXISTS `tipospagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipospagos` (
  `idTipoPago` int(11) NOT NULL AUTO_INCREMENT,
  `codTipoPag` varchar(10) NOT NULL,
  `descripcio` varchar(200) NOT NULL,
  PRIMARY KEY (`idTipoPago`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipospagos`
--

LOCK TABLES `tipospagos` WRITE;
/*!40000 ALTER TABLE `tipospagos` DISABLE KEYS */;
INSERT INTO `tipospagos` VALUES
(1,'CHEQ','Cheque'),
(2,'DEP','Depósito'),
(3,'EFVO','Efectivo'),
(4,'RIB','Retención Ingreso Brutos'),
(5,'TACR','Tarjeta de Crédito'),
(6,'TADB','Tarjeta de Débito'),
(7,'TRB','Transferencia Bancaria'),
(8,'CHEQ','Cheque'),
(9,'DEP','Depósito'),
(10,'EFVO','Efectivo'),
(11,'RIB','Retención Ingreso Brutos'),
(12,'TACR','Tarjeta de Crédito'),
(13,'TADB','Tarjeta de Débito'),
(14,'TRB','Transferencia Bancaria'),
(15,'CHEQ','Cheque'),
(16,'DEP','Depósito'),
(17,'EFVO','Efectivo'),
(18,'RIB','Retención Ingreso Brutos'),
(19,'TACR','Tarjeta de Crédito'),
(20,'TADB','Tarjeta de Débito'),
(21,'TRB','Transferencia Bancaria'),
(22,'CHEQ','Cheque'),
(23,'DEP','Depósito'),
(24,'EFVO','Efectivo'),
(25,'RIB','Retención Ingreso Brutos'),
(26,'TACR','Tarjeta de Crédito'),
(27,'TADB','Tarjeta de Débito'),
(28,'TRB','Transferencia Bancaria');
/*!40000 ALTER TABLE `tipospagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transp`
--

DROP TABLE IF EXISTS `transp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transp` (
  `idTransp` int(11) NOT NULL,
  `codTrans` int(11) NOT NULL,
  `razSoc` varchar(60) NOT NULL,
  `idLocalid` int(11) DEFAULT NULL,
  `direccion` varchar(60) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(50) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idTransp`),
  UNIQUE KEY `idTransp` (`idTransp`),
  KEY `idLocalid` (`idLocalid`),
  CONSTRAINT `transp_ibfk_1` FOREIGN KEY (`idLocalid`) REFERENCES `localidad` (`idLocalid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transp`
--

LOCK TABLES `transp` WRITE;
/*!40000 ALTER TABLE `transp` DISABLE KEYS */;
INSERT INTO `transp` VALUES
(1,1,'NO DEFINIDO',2628,'X','1','','.','SUPER','2014-01-01 00:00:00','PC-MG # admin','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL),
(2,2,'LA ESTRELLA',2628,'AV. PRINGLES 1111','','','','SUPER','2025-12-03 10:24:27','LINFOW-PRINCIPA # Usuario',NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `transp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidmed`
--

DROP TABLE IF EXISTS `unidmed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidmed` (
  `idUniMed` int(11) NOT NULL,
  `codUM` varchar(3) NOT NULL,
  `descripcio` varchar(30) NOT NULL,
  `cod_arca` varchar(10) DEFAULT NULL,
  `usuAlta` varchar(5) NOT NULL,
  `fecAlta` datetime NOT NULL,
  `idHostAlta` varchar(60) NOT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(60) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idUniMed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidmed`
--

LOCK TABLES `unidmed` WRITE;
/*!40000 ALTER TABLE `unidmed` DISABLE KEYS */;
INSERT INTO `unidmed` VALUES
(1,'UNI','UNIDADES','07','SUPER','2015-01-08 23:17:07','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL),
(2,'MET','METROS','02','SUPER','2015-01-08 23:17:07','SIS-65',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `unidmed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `CodUsu` varchar(5) NOT NULL,
  `ApelNom` varchar(60) NOT NULL,
  `Password` varchar(10) NOT NULL,
  `Habilitado` bit(1) NOT NULL,
  `usuAlta` varchar(5) NOT NULL DEFAULT 'SUPER',
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) NOT NULL DEFAULT 'LEONZ_XP # Leonardo',
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
(1,'SUPER','USUARIO SUPERVISOR','SUPER','','SUPER','2013-07-30 23:54:53','LEONZ_XP # Leonardo',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedores`
--

DROP TABLE IF EXISTS `vendedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendedores` (
  `idVendedor` int(11) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Direccion` varchar(60) NOT NULL,
  `IdLocalid` int(11) NOT NULL,
  `Telefono` varchar(30) DEFAULT NULL,
  `Celular` varchar(20) DEFAULT NULL,
  `EMail` varchar(60) DEFAULT NULL,
  `Habilitado` bit(1) NOT NULL DEFAULT b'1',
  `UsuAlta` varchar(5) NOT NULL,
  `FecAlta` datetime NOT NULL,
  `IdHostAlta` varchar(50) NOT NULL,
  `UsuModi` varchar(5) DEFAULT NULL,
  `FecModi` datetime DEFAULT NULL,
  `IdHostModi` varchar(50) DEFAULT NULL,
  `UsuBaja` varchar(5) DEFAULT NULL,
  `FecBaja` datetime DEFAULT NULL,
  `IdHostBaja` varchar(50) DEFAULT NULL,
  `porComis` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`idVendedor`),
  KEY `fk_Vendedores_Localidades1` (`IdLocalid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedores`
--

LOCK TABLES `vendedores` WRITE;
/*!40000 ALTER TABLE `vendedores` DISABLE KEYS */;
INSERT INTO `vendedores` VALUES
(1,'NO DEFINIDO','X',2628,'','','','','SUPER','2013-11-25 00:00:00','SIS-65','SUPER','2022-03-30 00:00:00','ESCRITORIO # Leonardo',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `vendedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventascab`
--

DROP TABLE IF EXISTS `ventascab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventascab` (
  `idVentasC` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idCondPago` int(11) DEFAULT NULL,
  `idSitIVA` int(11) DEFAULT NULL,
  `idVendedor` int(11) NOT NULL DEFAULT 1,
  `fecEmision` datetime DEFAULT NULL,
  `fecVto` datetime DEFAULT NULL,
  `cbte` varchar(3) NOT NULL,
  `tipoDoc` varchar(1) NOT NULL,
  `ptoVta` int(11) NOT NULL,
  `numCbte` int(11) NOT NULL,
  `anulado` bit(1) NOT NULL,
  `impNeto` float NOT NULL,
  `impFinal` float NOT NULL,
  `porIVA21` float NOT NULL,
  `impIVA21` float NOT NULL,
  `porIVA105` float NOT NULL,
  `impIVA105` float NOT NULL,
  `porIIBB` float DEFAULT NULL,
  `impIIBB` float DEFAULT NULL,
  `porDesc1` float NOT NULL,
  `impDesc1` float NOT NULL,
  `porDesc2` float NOT NULL,
  `impDesc2` float NOT NULL,
  `porDesc3` float NOT NULL,
  `impDesc3` float NOT NULL,
  `porDesc4` float NOT NULL,
  `impDesc4` float NOT NULL,
  `totaNoGrav` decimal(20,2) NOT NULL DEFAULT 0.00,
  `totFact` float NOT NULL,
  `saldo` float DEFAULT NULL,
  `esPendi` bit(1) NOT NULL DEFAULT b'0',
  `observ` text DEFAULT NULL,
  `procesado` bit(1) NOT NULL DEFAULT b'0',
  `usuAlta` varchar(5) DEFAULT NULL,
  `fecAlta` datetime DEFAULT NULL,
  `idHostAlta` varchar(50) DEFAULT NULL,
  `usuModi` varchar(5) DEFAULT NULL,
  `fecModi` datetime DEFAULT NULL,
  `idHostModi` varchar(50) DEFAULT NULL,
  `usuBaja` varchar(5) DEFAULT NULL,
  `fecBaja` datetime DEFAULT NULL,
  `idHostBaja` varchar(50) DEFAULT NULL,
  `porRec` float NOT NULL DEFAULT 0,
  `impRec` float NOT NULL DEFAULT 0,
  `aut_CAE` varchar(15) DEFAULT NULL,
  `aut_CAE_Vto` datetime DEFAULT NULL,
  `aut_Resultado` varchar(1) DEFAULT NULL,
  `aut_Motivo` varchar(254) DEFAULT NULL,
  `aut_tipoCbte` varchar(2) DEFAULT NULL,
  `razSoc` varchar(60) DEFAULT NULL,
  `idTipoDoc` int(11) DEFAULT NULL,
  `nroDoc` varchar(20) DEFAULT NULL,
  `nroOC` int(11) DEFAULT NULL,
  `nroRemito` varchar(20) DEFAULT NULL,
  `aut_qr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idVentasC`),
  KEY `fk_VentasCab_Clientes1` (`idCliente`),
  KEY `idCondPago` (`idCondPago`),
  KEY `idSitIVA` (`idSitIVA`),
  KEY `fk_VentasCab_Vendedores1` (`idVendedor`),
  CONSTRAINT `fk_VentasCab_Clientes1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ventascab_ibfk_1` FOREIGN KEY (`idCondPago`) REFERENCES `condpagos` (`idCondPago`),
  CONSTRAINT `ventascab_ibfk_2` FOREIGN KEY (`idSitIVA`) REFERENCES `sitiva` (`idSitIVA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventascab`
--

LOCK TABLES `ventascab` WRITE;
/*!40000 ALTER TABLE `ventascab` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventascab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventasdet`
--

DROP TABLE IF EXISTS `ventasdet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventasdet` (
  `idVentasD` int(11) NOT NULL,
  `idVentasC` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  `cantidad` float NOT NULL,
  `cantNC` float NOT NULL DEFAULT 0,
  `costoRep` float NOT NULL,
  `prArtic` float NOT NULL DEFAULT 0,
  `prVenta` float NOT NULL,
  `porDesc1` float NOT NULL DEFAULT 0,
  `porDesc2` float NOT NULL DEFAULT 0,
  `porDesc3` float NOT NULL DEFAULT 0,
  `porDesc4` float NOT NULL DEFAULT 0,
  `impDesc1` float NOT NULL DEFAULT 0,
  `impDesc2` float NOT NULL DEFAULT 0,
  `impDesc3` float NOT NULL DEFAULT 0,
  `impDesc4` float NOT NULL DEFAULT 0,
  `pDtoVta1` float NOT NULL DEFAULT 0,
  `pDtoVta2` float NOT NULL DEFAULT 0,
  `pDtoVta3` float NOT NULL DEFAULT 0,
  `pDtoVta4` float NOT NULL DEFAULT 0,
  `iDtoVta1` float NOT NULL DEFAULT 0,
  `iDtoVta2` float NOT NULL DEFAULT 0,
  `iDtoVta3` float NOT NULL DEFAULT 0,
  `iDtoVta4` float NOT NULL DEFAULT 0,
  `impNeto` float DEFAULT NULL,
  `porNoGrav` decimal(5,2) NOT NULL DEFAULT 0.00,
  `baseGrav` decimal(20,2) NOT NULL DEFAULT 0.00,
  `subtNoGrav` decimal(20,2) NOT NULL DEFAULT 0.00,
  `totNeto` float NOT NULL,
  `alicIVA` float NOT NULL,
  `impIVA` float NOT NULL,
  `subTotal` float NOT NULL,
  `nroPart` varchar(30) DEFAULT NULL,
  `esOferta` bit(1) NOT NULL DEFAULT b'0',
  `pRecVta` float NOT NULL DEFAULT 0,
  `iRecVta` float NOT NULL DEFAULT 0,
  `UniDesp` float DEFAULT NULL,
  `cantPack` float DEFAULT NULL,
  `codUM` varchar(3) DEFAULT NULL,
  `cant_pri1` float DEFAULT NULL,
  `cant_pri2` float DEFAULT NULL,
  `cant_pri3` float NOT NULL DEFAULT 0,
  `descripcio` varchar(200) DEFAULT NULL,
  `cant_falt` float NOT NULL DEFAULT 0,
  `pRecItem` float NOT NULL DEFAULT 0,
  `iRecItem` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`idVentasD`,`idVentasC`),
  KEY `fk_VentasDet_VentasCab1` (`idVentasC`),
  KEY `fk_VentasDet_Articulos1` (`idArticulo`),
  CONSTRAINT `fk_VentasDet_Articulos1` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentasDet_VentasCab1` FOREIGN KEY (`idVentasC`) REFERENCES `ventascab` (`idVentasC`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventasdet`
--

LOCK TABLES `ventasdet` WRITE;
/*!40000 ALTER TABLE `ventasdet` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventasdet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventasdet_tmp`
--

DROP TABLE IF EXISTS `ventasdet_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventasdet_tmp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idArticulo` int(11) DEFAULT NULL,
  `cantidad` decimal(20,2) DEFAULT 0.00,
  `cantNC` decimal(20,2) DEFAULT 0.00,
  `costoRep` decimal(20,2) DEFAULT 0.00,
  `prArtic` decimal(20,2) DEFAULT 0.00,
  `prVenta` decimal(20,2) DEFAULT 0.00,
  `porDesc1` decimal(5,2) DEFAULT 0.00,
  `porDesc2` decimal(5,2) DEFAULT 0.00,
  `porDesc3` decimal(5,2) DEFAULT 0.00,
  `porDesc4` decimal(5,2) DEFAULT 0.00,
  `impDesc1` decimal(20,2) DEFAULT 0.00,
  `impDesc2` decimal(20,2) DEFAULT 0.00,
  `impDesc3` decimal(20,2) DEFAULT 0.00,
  `impDesc4` decimal(20,2) DEFAULT 0.00,
  `pDtoVta1` decimal(5,2) DEFAULT 0.00,
  `pDtoVta2` decimal(5,2) DEFAULT 0.00,
  `pDtoVta3` decimal(5,2) DEFAULT 0.00,
  `pDtoVta4` decimal(5,2) DEFAULT 0.00,
  `iDtoVta1` decimal(20,2) DEFAULT 0.00,
  `iDtoVta2` decimal(20,2) DEFAULT 0.00,
  `iDtoVta3` decimal(20,2) DEFAULT 0.00,
  `iDtoVta4` decimal(20,2) DEFAULT 0.00,
  `impNeto` decimal(20,2) DEFAULT 0.00,
  `porNoGrav` decimal(5,2) DEFAULT 0.00,
  `baseGrav` decimal(20,2) DEFAULT 0.00,
  `subtNoGrav` decimal(20,2) DEFAULT 0.00,
  `totNeto` decimal(20,2) DEFAULT 0.00,
  `alicIVA` decimal(5,2) DEFAULT 0.00,
  `impIVA` decimal(20,2) DEFAULT 0.00,
  `subTotal` decimal(20,2) DEFAULT 0.00,
  `nroPart` varchar(30) DEFAULT NULL,
  `esOferta` bit(1) DEFAULT b'0',
  `pRecVta` decimal(5,2) DEFAULT 0.00,
  `iRecVta` decimal(20,2) DEFAULT 0.00,
  `UniDesp` decimal(20,2) DEFAULT 0.00,
  `cantPack` decimal(20,2) DEFAULT 0.00,
  `codUM` varchar(3) DEFAULT NULL,
  `cant_pri1` decimal(20,2) DEFAULT 0.00,
  `cant_pri2` decimal(20,2) DEFAULT 0.00,
  `cant_pri3` decimal(20,2) DEFAULT 0.00,
  `descripcio` varchar(200) DEFAULT NULL,
  `cant_falt` decimal(20,2) DEFAULT 0.00,
  `pRecItem` decimal(5,2) DEFAULT 0.00,
  `iRecItem` decimal(20,2) DEFAULT 0.00,
  `usuario` varchar(5) DEFAULT NULL,
  `host` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventasdet_tmp`
--

LOCK TABLES `ventasdet_tmp` WRITE;
/*!40000 ALTER TABLE `ventasdet_tmp` DISABLE KEYS */;
INSERT INTO `ventasdet_tmp` VALUES
(82,143,10.00,0.00,180.66,180.66,180.66,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,180.66,0.00,1806.60,0.00,1806.60,21.00,379.39,2185.99,'','\0',0.00,0.00,1.00,10.00,'UNI',0.00,0.00,0.00,'ECONOMICOS CON PUNTERA ACOL. PVC',0.00,0.00,0.00,'SUPER','ESCRITORIO # Leonardo'),
(108,143,10.00,0.00,180.66,180.66,180.66,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,180.66,0.00,1806.60,0.00,1806.60,21.00,379.39,2185.99,'','\0',0.00,0.00,1.00,10.00,'UNI',0.00,0.00,0.00,'ECONOMICOS CON PUNTERA ACOL. PVC',0.00,0.00,0.00,'SUPER','LEO_NOTEBOOK # LINFOW');
/*!40000 ALTER TABLE `ventasdet_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventasrel`
--

DROP TABLE IF EXISTS `ventasrel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventasrel` (
  `idvtarel` int(11) NOT NULL,
  `idVtaCO` int(11) NOT NULL,
  `idVtaCD` int(11) NOT NULL,
  PRIMARY KEY (`idvtarel`),
  KEY `fk_ventasrel_ventascab1` (`idVtaCO`),
  KEY `fk_ventasrel_ventascab2` (`idVtaCD`),
  CONSTRAINT `fk_ventasrel_ventascab1` FOREIGN KEY (`idVtaCO`) REFERENCES `ventascab` (`idVentasC`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventasrel_ventascab2` FOREIGN KEY (`idVtaCD`) REFERENCES `ventascab` (`idVentasC`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventasrel`
--

LOCK TABLES `ventasrel` WRITE;
/*!40000 ALTER TABLE `ventasrel` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventasrel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vtadcp`
--

DROP TABLE IF EXISTS `vtadcp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vtadcp` (
  `id_vtadcp` int(11) NOT NULL,
  `idVentasC` int(11) NOT NULL,
  `idPlanCta` int(11) NOT NULL,
  `idBanco` int(11) DEFAULT NULL,
  `cheque_nro` varchar(8) DEFAULT NULL,
  `impNeto` float NOT NULL,
  `ivaPor` float NOT NULL DEFAULT 0,
  `ivaImp` float NOT NULL DEFAULT 0,
  `total` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_vtadcp`),
  UNIQUE KEY `id_vtadcp` (`id_vtadcp`),
  KEY `idVentasC` (`idVentasC`),
  KEY `idPlanCta` (`idPlanCta`),
  KEY `idBanco` (`idBanco`),
  CONSTRAINT `vtadcp_ibfk_1` FOREIGN KEY (`idVentasC`) REFERENCES `ventascab` (`idVentasC`),
  CONSTRAINT `vtadcp_ibfk_2` FOREIGN KEY (`idPlanCta`) REFERENCES `planctas` (`idPlanCta`),
  CONSTRAINT `vtadcp_ibfk_3` FOREIGN KEY (`idBanco`) REFERENCES `bancos` (`idBanco`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vtadcp`
--

LOCK TABLES `vtadcp` WRITE;
/*!40000 ALTER TABLE `vtadcp` DISABLE KEYS */;
/*!40000 ALTER TABLE `vtadcp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vtasret`
--

DROP TABLE IF EXISTS `vtasret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vtasret` (
  `idRetiroC` int(11) NOT NULL,
  `idVentasC` int(11) NOT NULL,
  PRIMARY KEY (`idRetiroC`,`idVentasC`),
  KEY `idVentasC` (`idVentasC`),
  CONSTRAINT `vtasret_ibfk_1` FOREIGN KEY (`idRetiroC`) REFERENCES `retiroscab` (`idRetiroC`),
  CONSTRAINT `vtasret_ibfk_2` FOREIGN KEY (`idVentasC`) REFERENCES `ventascab` (`idVentasC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vtasret`
--

LOCK TABLES `vtasret` WRITE;
/*!40000 ALTER TABLE `vtasret` DISABLE KEYS */;
/*!40000 ALTER TABLE `vtasret` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vtasrtos`
--

DROP TABLE IF EXISTS `vtasrtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vtasrtos` (
  `idVtaRto` int(11) NOT NULL COMMENT 'Identificación única del remito',
  `idVentasC` int(11) NOT NULL COMMENT 'Id. de comprobante de venta asociado',
  `idTransp` int(11) NOT NULL COMMENT 'Id. de transporte asociado',
  `codTrans` int(11) NOT NULL COMMENT 'Código de transporte asociado',
  `razSocTrn` varchar(60) NOT NULL COMMENT 'Razón Social del transporte asociado',
  `fecha` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de emisión del remito',
  `cbte` varchar(3) NOT NULL COMMENT 'Tipo de comprobante',
  `tipoDoc` varchar(1) NOT NULL COMMENT 'Letra del comprobante',
  `ptovta` int(11) NOT NULL COMMENT 'Punto de venta de donde sale el remito',
  `numCbte` int(11) NOT NULL COMMENT 'Número de remito',
  `nrocomp` varchar(20) NOT NULL COMMENT 'Número completo de remito',
  `cantItems` int(11) NOT NULL COMMENT 'Cantidad de ítem que tiene el remito',
  `usuAlta` varchar(5) NOT NULL COMMENT 'Usuario de alta',
  `fecAlta` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Usuario de baja',
  `idHostAlta` varchar(50) NOT NULL COMMENT 'Host de alta',
  `usuModi` varchar(5) DEFAULT NULL COMMENT 'Usuario de modificación',
  `fecModi` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `idHostModi` varchar(50) DEFAULT NULL COMMENT 'Host de modificación',
  `usuBaja` varchar(5) DEFAULT NULL COMMENT 'Usuario de baja',
  `fecBaja` datetime DEFAULT NULL COMMENT 'Fecha de baja',
  `idHostBaja` varchar(50) DEFAULT NULL COMMENT 'Host de baja',
  PRIMARY KEY (`idVtaRto`,`idVentasC`),
  KEY `idVentasC` (`idVentasC`),
  KEY `idTransp` (`idTransp`),
  CONSTRAINT `vtasrtos_ibfk_1` FOREIGN KEY (`idVentasC`) REFERENCES `ventascab` (`idVentasC`),
  CONSTRAINT `vtasrtos_ibfk_2` FOREIGN KEY (`idTransp`) REFERENCES `transp` (`idTransp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vtasrtos`
--

LOCK TABLES `vtasrtos` WRITE;
/*!40000 ALTER TABLE `vtasrtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `vtasrtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'linfowgst_desac1'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `articulos_calcPrFinal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `articulos_calcPrFinal`(precio double, alicIVA double) RETURNS double
    DETERMINISTIC
BEGIN
	RETURN precio + (precio * (alicIVA / 100));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `articulos_calcularCosto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `articulos_calcularCosto`(precio double, bonif1 double, bonif2 double, bonif3 double, bonif4 double) RETURNS double
    DETERMINISTIC
BEGIN
	DECLARE costo double;
    
    set costo = precio - (precio * (bonif1 / 100));
    set costo = costo - (costo * (bonif2 / 100));
    set costo = costo - (costo * (bonif3 / 100));
    set costo = costo - (costo * (bonif4 / 100));
    RETURN costo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `articulos_calcularVenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `articulos_calcularVenta`(precio double, rentabilidad double) RETURNS double
    DETERMINISTIC
BEGIN
	RETURN precio + (precio * (rentabilidad / 100));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `articulos_costo_to_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `articulos_costo_to_lista`(costo DECIMAL(20, 2),
	bonif1 DECIMAL(5, 2),
	bonif2 DECIMAL(5, 2),
	bonif3 DECIMAL(5, 2),
	bonif4 DECIMAL(5, 2)) RETURNS decimal(20,2)
    DETERMINISTIC
BEGIN
	DECLARE lista DECIMAL(20, 2);
	
	SET lista = costo + (costo * (bonif4 / 100));
	SET lista = lista + (lista * (bonif3 / 100));
	SET lista = lista + (lista * (bonif2 / 100));
	SET lista = lista + (lista * (bonif1 / 100));
	
	RETURN ROUND(lista, 2);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `art_cdp_formatear_string` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `art_cdp_formatear_string`(xstr varchar(255)) RETURNS varchar(255) CHARSET latin1 COLLATE latin1_swedish_ci
    DETERMINISTIC
begin
	set xstr = replace(xstr, ' ', '');
	set xstr = replace(xstr, '(', '');
    set xstr = replace(xstr, ')', '');
    set xstr = replace(xstr, '/', '');
    set xstr = replace(xstr, '.', '');
    set xstr = replace(xstr, '-', '');
	set xstr = replace(xstr, '*', '');
	set xstr = replace(xstr, '\"', '');
	set xstr = replace(xstr, ',', '');
	set xstr = replace(xstr, '\'', '');
	set xstr = replace(xstr, '=>', '');
	set xstr = replace(xstr, ':', '');
	set xstr = replace(xstr, ';', '');
	set xstr = replace(xstr, '>', '');
	set xstr = replace(xstr, '<', '');
	set xstr = replace(xstr, '=', '');
	set xstr = replace(xstr, '+', '');
	set xstr = replace(xstr, '-', '');
    set xstr = replace(xstr, '}', '');
    return xstr;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `art_generar_cdp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `art_generar_cdp`(xidprov int,
	xcodArtPV varchar(40),
    xdescripcion varchar(200)) RETURNS char(32) CHARSET latin1 COLLATE latin1_swedish_ci
    DETERMINISTIC
begin
	declare xcodArtPV_aux varchar(40);
    declare xdescripcion_aux varchar(200);

    set xcodArtPV_aux = art_cdp_formatear_string(xcodArtPV);
    set xdescripcion_aux = art_cdp_formatear_string(xdescripcion);
    return md5(concat(ltrim(rtrim(xcodArtPV_aux)), ltrim(rtrim(xdescripcion_aux)), xidprov));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `calcular_total_byc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `calcular_total_byc`() RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
	DECLARE total  DECIMAL(10, 2);
	SELECT
		SUM(CASE WHEN ventascab.cbte = 'FC' THEN 
			ventasdet.cantidad
		ELSE
			ventasdet.cantidad * -1
		END) INTO total
	FROM
		ventasdet
			INNER JOIN ventascab ON ventascab.idVentasC = ventasdet.idVentasC 
			INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
	WHERE
		articulos.idmarca = 64 AND
		ventascab.cbte IN ('FC', 'NC') AND
		YEAR(ventascab.fecEmision) IN (2018, 2019, 2020) AND
		ventascab.fecBaja IS NULL AND
		ventascab.aut_Resultado = 'A';	
	RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `calcular_total_universo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `calcular_total_universo`() RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
	DECLARE total  DECIMAL(10, 2);
	SELECT SUM(cantidad) INTO total FROM temp_universo;
	RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `citicpas_calcCreditoFiscal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `citicpas_calcCreditoFiscal`(pImpIVA21 double, pImpIVA105 double) RETURNS varchar(15) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
    DETERMINISTIC
begin
	declare vResult varchar(15);
    declare vTotIVA double;
    set vTotIVA = round((pImpIVA21 + pImpIVA105) * 100, 2);
    set vResult = concat(repeat('0', 15 - length(vTotIVA)), vTotIVA);
    return vResult;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `citicpas_formatImporte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `citicpas_formatImporte`(pTotNeto double) RETURNS varchar(15) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
    DETERMINISTIC
begin
	declare vResult varchar(15);
    declare vTotNeto double;
    set vTotNeto = round(pTotNeto * 100, 2);
    set vResult = concat(repeat('0', 15 - length(vTotNeto)), vTotNeto);
    return vResult;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `equiv_tieneEquiv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `equiv_tieneEquiv`(pIdArticulo int) RETURNS bit(1)
    DETERMINISTIC
BEGIN
	DECLARE vTieneEquiv bit;
	DECLARE vEquiv int;

	SELECT equiv INTO vEquiv
	FROM articulos
	WHERE articulos.idArticulo = pIdArticulo;

	SELECT
		CASE
			WHEN COUNT(*) > 1 THEN 1
			ELSE 0
		END INTO vTieneEquiv
	FROM articulos
	WHERE articulos.equiv = vEquiv;
	RETURN vTieneEquiv;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `formatear_NroCbte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `formatear_NroCbte`(ptoVta int, nroCbte int) RETURNS varchar(15) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
    DETERMINISTIC
begin
	declare vPtoVta varchar(4);
	declare vNroCbte varchar(8);

	set vPtoVta = cast(ptoVta as char);
	set vPtoVta = concat(repeat('0', 4 - length(vPtoVta)), vPtoVta);
    	set vNroCbte = cast(nroCbte as char);
    	set vNroCbte = concat(repeat('0', 8 - length(vNroCbte)), vNroCbte);
    	return concat(vPtoVta, '-', vNroCbte);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `globalCFG_getByKey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `globalCFG_getByKey`(pKey varchar(10)) RETURNS varchar(255) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
    DETERMINISTIC
BEGIN
	DECLARE vResult varchar(255);

	SELECT 
		cfg_value INTO vResult 
	FROM 
		global_cfg 
	WHERE 
		cfg_key = pKey;

	RETURN vResult;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `promo_calcular_cant_merchandisign` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `promo_calcular_cant_merchandisign`(ximp_tope decimal(20, 2),
    xtotal_vend decimal(20, 2)
) RETURNS decimal(20,2)
    DETERMINISTIC
BEGIN
    

    DECLARE vcantidad decimal(20, 2);
    DECLARE vimporte decimal(20, 2);
    
    SET vcantidad = 0;
    SET vimporte = ximp_tope;
    WHILE vimporte <= xtotal_vend DO
        SET vcantidad = vcantidad + 1;
        SET vimporte = vimporte + ximp_tope;
    END WHILE;
    RETURN vcantidad;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `promo_calcular_faltan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `promo_calcular_faltan`(xtope decimal(20, 2),
       xtotal_v decimal(20, 2)) RETURNS decimal(20,2)
    DETERMINISTIC
BEGIN
  
  DECLARE vMultiplo int DEFAULT 0;
  DECLARE vFaltan decimal(20, 2);

  IF xtotal_v > xtope THEN
  	
    WHILE xtotal_v > (xtope * vMultiplo) DO
      SET vMultiplo = vMultiplo + 1;
      SET vFaltan = (xtope * vMultiplo) - xtotal_v;
    END WHILE;
  ELSE
  	
	SET vFaltan = xtope - xtotal_v;
  END IF;
  RETURN vFaltan;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `upd_ArtNuevosFormatCod` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE FUNCTION `upd_ArtNuevosFormatCod`(pIdProv int, pCodigo varchar(20)) RETURNS varchar(20) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
    DETERMINISTIC
BEGIN
	DECLARE vResult varchar(20);
	DECLARE i int;
	DECLARE caracter varchar(1);
	DECLARE codigo_auxiliar varchar(20);

   	SET vResult = UPPER(SUBSTR(replace(pCodigo, ' ', ''), 1, 16));
	SET i = 1;
	SET codigo_auxiliar = '';

   	WHILE i <= LENGTH(vResult) DO
   		SET caracter = SUBSTRING(vResult, i, 1);
   		IF (ASCII(caracter) >= 65 AND ASCII(caracter) <= 90) 
   				OR ASCII(caracter) = 47 THEN
   			SET codigo_auxiliar = CONCAT(codigo_auxiliar, caracter);
   		ELSE
   			IF ASCII(caracter) >= 48 AND ASCII(caracter) <= 57 THEN
   				SET codigo_auxiliar = CONCAT(codigo_auxiliar, caracter);
   			END IF;
   		END IF;
   		SET i = i + 1;
   	END WHILE;
    SET vResult = codigo_auxiliar;

    IF pIdProv < 10 THEN
		set vResult = concat(vResult, '-P0', pIdProv);
    ELSE
		set vResult = concat(vResult, '-P', pIdProv);
    END IF;

    RETURN vResult;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agregar_faltantes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `agregar_faltantes`(
	xidArticulo int,
	xcodArt varchar(20),
	xuniCpr float,
	xcantidad float,
	xidcliente int,
	xusuario varchar(5),
	xhost varchar(50))
BEGIN
	DECLARE vMensaje VARCHAR(200);
	DECLARE vCantReg INT;
	DECLARE vProxID INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
	END;
	
	START TRANSACTION;
	
	-- Verifico si el artÃ­culo existe
	SELECT
		COUNT(*)
	INTO
		vCantReg
	FROM
		faltantes
	WHERE
		idArticulo = xidArticulo AND
                procesado = 0 AND
		fecBaja IS NULL;
	
	IF vCantReg = 0 THEN
		SELECT
			IFNULL(MAX(idFaltante), 0) + 1
		INTO
			vProxID
		FROM
			faltantes;
	
		INSERT INTO faltantes (
			idFaltante,
			idArticulo,
			codArt,
			uniCpr,
			cantidad,
			procesado,
			idCliente,
			usuAlta,
			fecAlta,
			idHostAlta)
		VALUES (
			vProxID,
			xidArticulo,
			xcodArt,
			xuniCpr,
			xcantidad,
			0,
			CASE WHEN xidcliente = 0 THEN NULL ELSE xidcliente END,
			xusuario,
			CURRENT_TIMESTAMP,
			xhost);
	ELSE
		UPDATE
			faltantes
		SET
			cantidad = cantidad + xcantidad
		WHERE
			idArticulo = xidArticulo;
	END IF;
	
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agregar_menu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `agregar_menu`(
	  xCodMenu	varchar(20),
	  xNombre	varchar(60),
	  xProcedim	varchar(60),
	  xIsChild	bit(1),
	  xEnlace	int(11),
	  xacc_key	varchar(30),
	  xorden	int
	)
BEGIN
		/**
	     * Agrega un menú al sistema si no existe.
	    */
		DECLARE vProxId int;
	    DECLARE vExisteMenu bit;
	    DECLARE vIdAcceso int;
	    DECLARE mensaje text;

	    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	    BEGIN
	    	ROLLBACK;
	        GET DIAGNOSTICS CONDITION 1 mensaje = MESSAGE_TEXT;
	        SELECT mensaje;
	    END;

	    SET vExisteMenu = (
	    	SELECT
	        	CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
	        FROM
	        	menues
	        WHERE
	        	menues.CodMenu = xCodMenu);

	    IF vExisteMenu = 0 THEN
	    	START TRANSACTION;

			SET vProxId = (
	        	SELECT
	            	CASE WHEN MAX(idMenue) IS NULL THEN 1 ELSE MAX(idMenue) + 1 END
	            FROM
	            	menues);

	        INSERT INTO menues (
	          idMenue,
	          CodMenu,
	          Nombre,
	          Procedim,
	          IsChild,
	          Enlace,
	          acc_key,
	          orden,
	          usuAlta,
	          fecAlta,
	          idHostAlta)
	        VALUES (
	          vProxId,
	          xCodMenu,
	          xNombre,
	          xProcedim,
	          xIsChild,
	          xEnlace,
	          xacc_key,
	          xorden,
	          'SUPER',
	          current_timestamp,
	          'SISTEMA');

	    	/* Asocio el menú al usuario SUPER */
	        SET vIdAcceso = (
	        	SELECT
	            	CASE WHEN MAX(idAcceso) IS NULL THEN 1 ELSE MAX(idAcceso) + 1 END
	            FROM
	            	accesos);

	        INSERT INTO accesos (
	        	idAcceso,
	            idUsuario,
	            idMenue
	        ) VALUES (
	        	vIdAcceso,
	            1,
				vProxId);

			COMMIT;
	    END IF;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `alic_ivas_agregar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `alic_ivas_agregar`(
	xalicuota DECIMAL(5, 2),
    xid_afip INT)
BEGIN
	DECLARE vCantReg INT;
    DECLARE vMensaje TEXT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		INSERT INTO log_sps (sp_name, fecha, msgerror, usuario, host)
		VALUES ('alic_ivas_agregar', current_timestamp, vMensaje, '', '');
    END;
	
	START TRANSACTION;
    
	SELECT
		COUNT(*)
	INTO
		vCantReg
	FROM
		alic_ivas
	WHERE
		alic_ivas.alicuota = xalicuota;
		
	IF vCantReg = 0 THEN
		INSERT INTO alic_ivas (
			alicuota, id_afip)
		VALUES (
			xalicuota, xid_afip);
	END IF;
	
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `artcat_addFamilia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `artcat_addFamilia`(
	pUsuario VARCHAR(5),
	pHostName VARCHAR(50)
)
BEGIN
	SELECT
		CASE WHEN MAX(idFamilia) IS NULL THEN 0
		ELSE MAX(idFamilia) END
	INTO
		@idFamilia
	FROM
		familias;
		
	CREATE TEMPORARY TABLE tmp_familias
		SELECT 
			familia AS descripcio,
			pUsuario AS usuAlta,
			CURRENT_TIMESTAMP AS fecAlta,
			pHostName AS idHostAlta
		FROM 
			tmp_artcat 
		WHERE 
			idArticulo = 0 AND
			familia NOT IN (
				SELECT
					descripcio
				FROM
					familias)
		GROUP BY
			familia;
		
	INSERT INTO familias (
		idFamilia,
		descripcio,
		usuAlta,
		fecAlta,
		idHostAlta)
			SELECT
				@idFamilia := @idFamilia + 1 AS idFamilia,
				tmp_familias.*
			FROM
				tmp_familias;
	DROP TABLE tmp_familias;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `artcat_addMarca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `artcat_addMarca`(
	pUsuario VARCHAR(5),
	pHostName VARCHAR(50)
)
BEGIN
	SELECT
		CASE WHEN MAX(idmarca) IS NULL THEN 0
		ELSE MAX(idmarca) END
	INTO
		@idmarca
	FROM
		marcas;
		
	CREATE TEMPORARY TABLE tmp_marcas
		SELECT 
			marca AS descripcio,
			pUsuario AS usuAlta,
			CURRENT_TIMESTAMP AS fecAlta,
			pHostName AS idHostAlta
		FROM 
			tmp_artcat 
		WHERE 
			idArticulo = 0 AND
			marca NOT IN (
				SELECT
					descripcio
				FROM
					marcas)
		GROUP BY
			marca;
		
	INSERT INTO marcas (
		idmarca,
		descripcio,
		usuAlta,
		fecAlta,
		idHostAlta)
			SELECT
				(@idmarca := @idmarca + 1) AS idmarca,
				tmp_marcas.*
			FROM
				tmp_marcas;
	DROP TABLE tmp_marcas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `artcat_AddSubFam` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `artcat_AddSubFam`(
	pUsuario VARCHAR(5),
	pHostName VARCHAR(50)
)
BEGIN
	SELECT
		CASE WHEN MAX(idSubFam) IS NULL THEN 0
		ELSE MAX(idSubFam) END
	INTO
		@idSubFam
	FROM
		subfam;
		
	CREATE TEMPORARY TABLE tmp_subfam
		SELECT 
			subfam AS descripcio,
			pUsuario AS usuAlta,
			CURRENT_TIMESTAMP AS fecAlta,
			pHostName AS idHostAlta
		FROM 
			tmp_artcat 
		WHERE 
			idArticulo = 0 AND
			subfam NOT IN (
				SELECT
					descripcio
				FROM
					subfam)
		GROUP BY
			subfam;	
	
	INSERT INTO subfam (
		idSubFam,
		descripcio,
		usuAlta,
		fecAlta,
		idHostAlta)
			SELECT 
				@idSubFam := @idSubFam + 1 AS idSubFam,
				tmp_subfam.*
			FROM
				tmp_subfam;
	DROP TABLE tmp_subfam;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `artcat_CrearTemps` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `artcat_CrearTemps`(
	pIdProv INT,
    pPermitirDuplicado bit
)
BEGIN
	DROP TABLE IF EXISTS tmp_artcat;
    IF pPermitirDuplicado THEN
		CREATE TEMPORARY TABLE tmp_artcat (
			codArt VARCHAR(25) NOT NULL,
			descripcio VARCHAR(200) NOT NULL,
			familia VARCHAR(60) NOT NULL,
			subfam VARCHAR(60) NOT NULL,
			marca VARCHAR(60) NOT NULL,
			prLista DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif1 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif2 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif3 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif4 DECIMAL(20,2) NOT NULL DEFAULT 0,
			costoRep DECIMAL(20,2) NOT NULL DEFAULT 0,
			margenMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			margenMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			prVentaMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			prVentaMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			prFinalMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			prFinalMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			alicIVA DECIMAL(20,2) NOT NULL DEFAULT 0,
			costoAnt DECIMAL(20,2) NOT NULL DEFAULT 0,
			idArticulo INT NULL NOT NULL,
			linkFoto varchar(255),
			hostName VARCHAR(50) NOT NULL) ENGINE=MyISAM;
	ELSE
		CREATE TEMPORARY TABLE tmp_artcat (
			codArt VARCHAR(25) NOT NULL,
			descripcio VARCHAR(200) NOT NULL,
			familia VARCHAR(60) NOT NULL,
			subfam VARCHAR(60) NOT NULL,
			marca VARCHAR(60) NOT NULL,
			prLista DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif1 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif2 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif3 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif4 DECIMAL(20,2) NOT NULL DEFAULT 0,
			costoRep DECIMAL(20,2) NOT NULL DEFAULT 0,
			margenMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			margenMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			prVentaMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			prVentaMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			prFinalMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			prFinalMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			alicIVA DECIMAL(20,2) NOT NULL DEFAULT 0,
			costoAnt DECIMAL(20,2) NOT NULL DEFAULT 0,
			idArticulo INT NULL NOT NULL,
			linkFoto varchar(255),
			hostName VARCHAR(50) NOT NULL,
            PRIMARY KEY (codArt)) ENGINE=MyISAM; 
    END IF;
	CREATE INDEX idxtmp_id ON tmp_artcat (idArticulo);
	CREATE INDEX ifxtmp_id ON tmp_artcat (codArt);   
    
	DROP TABLE IF EXISTS tmp_artic;
	CREATE TEMPORARY TABLE tmp_artic
		SELECT
			idArticulo,
			codArtPV,
			bonif1,
			bonif2,
			bonif3,
			bonif4,
			margenMax,
			margenMin,
			costoRep,
			alicIVA
		FROM
			articulos
		WHERE
			articulos.idProv = pIdProv AND
			articulos.fecBaja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `artcat_DropTemps` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `artcat_DropTemps`()
BEGIN
	DROP TABLE IF EXISTS tmp_artcat;
	DROP TABLE IF EXISTS tmp_artic;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `artcat_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `artcat_insert`(
	pIdProv INT,
    pBonif1 decimal(5, 2),
    pBonif2 decimal(5, 2),
    pBonif3 decimal(5, 2),
    pBonif4 decimal(5, 2),
    pMargenMay decimal(5, 2),
    pMargenMin decimal(5, 2),
	pUsuario VARCHAR(5),
	pHostName VARCHAR(50)
)
BEGIN
	DECLARE vMensaje VARCHAR(200);
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;	
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;	
    
	START TRANSACTION;
	CALL artcat_addFamilia ('SUPER', 'ESCRITORIO');
	CALL artcat_AddSubFam ('SUPER', 'ESCRITORIO');
	CALL artcat_addMarca ('SUPER', 'ESCRITORIO');
	
	CREATE TEMPORARY TABLE tmp_familias
		SELECT
			familias.*
		FROM
			familias
				INNER JOIN tmp_artcat ON tmp_artcat.familia = familias.descripcio
		GROUP BY
			familias.idFamilia;
			
	CREATE TEMPORARY TABLE tmp_subfam
		SELECT
			subfam.*
		FROM
			subfam
				INNER JOIN tmp_artcat ON tmp_artcat.subfam = subfam.descripcio
		GROUP BY
			subfam.idSubFam;
			
	CREATE TEMPORARY TABLE tmp_marcas
		SELECT
			marcas.*
		FROM
			marcas
				INNER JOIN tmp_artcat ON tmp_artcat.marca = marcas.descripcio
		GROUP BY
			marcas.idmarca;
			
	CREATE INDEX idxtemp_familia ON tmp_familias (descripcio);
	CREATE INDEX idxtemp_subfam ON tmp_subfam (descripcio);
	CREATE INDEX idxtemp_marcas ON tmp_marcas (descripcio);
	CREATE INDEX idxtemp_familias1 ON tmp_artcat (familia);
	CREATE INDEX idxtemp_subfam1 ON tmp_artcat (subfam);
	CREATE INDEX idxtemp_marcas1 ON tmp_artcat (marca);
	
	SELECT
		CASE WHEN MAX(idArticulo) IS NULL THEN 0
		ELSE MAX(idArticulo) END
	INTO
		@idArticulo
	FROM
		articulos;
	
	INSERT INTO articulos (
		idArticulo,
        equiv,
		idProv,
		idFamilia,
		idSubFam,
		idmarca,
		idUniMed,
		codArt,
		codArtPV,
		descripcio,
		alicIVA,
		tmon,
		prListaExt,
		cotizac,
		prLista,
		bonif1,
		bonif2,
		bonif3,
		bonif4,
		costoRep,
		margenMax,
		margenMin,
		prVentaMax,
		prVentaMin,
		prFinalMax,
		prFinalMin,
		observ,
		habilitado,
		linkFoto,
		usuAlta,
		fecAlta,
		idHostAlta)
			SELECT
				@idArticulo := @idArticulo + 1 AS idArticulo,
                @idArticulo AS equiv,
				pIdProv AS idProv,
				tmp_familias.idFamilia,
				tmp_subfam.idSubFam,
				tmp_marcas.idmarca,
				1 AS idUniMed,
				CONCAT(LTRIM(RTRIM(tmp_artcat.codArt))) ,
				LTRIM(RTRIM(tmp_artcat.codArt)) AS codArtPV,
				tmp_artcat.descripcio,
				tmp_artcat.alicIVA,
				'PSO' AS tmon,
				0 AS prListaExt,
				0 AS cotizac,
				tmp_artcat.prLista,
				pBonif1,
				pBonif2,
				pBonif3, 
				pBonif4,
				articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4),
				pMargenMay,
				pMargenMin,
				articulos_calcularVenta(
					articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4), pMargenMay),
				articulos_calcularVenta(
					articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4), pMargenMin),
				articulos_calcPrFinal(
					articulos_calcularVenta(
					articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4), pMargenMay), tmp_artcat.alicIVA),
				articulos_calcPrFinal(
					articulos_calcularVenta(
					articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4), pMargenMin), tmp_artcat.alicIVA),
				'' AS observ,
				1 AS habilitado,
				'' AS linkFoto,
				pUsuario AS usualta,
				CURRENT_TIMESTAMP AS fecalta,
				pHostName AS idHostAlta
			FROM
				tmp_artcat
					INNER JOIN tmp_familias ON tmp_familias.descripcio = tmp_artcat.familia
					INNER JOIN tmp_subfam ON tmp_subfam.descripcio = tmp_artcat.subfam
					INNER JOIN tmp_marcas ON tmp_marcas.descripcio = tmp_artcat.marca
			WHERE
				tmp_artcat.idArticulo = 0;
                
    SET @idCodiArt = (
		SELECT
			CASE WHEN max(idCodArt) IS NULL
				THEN 0 ELSE max(idCodArt) + 1 END
		FROM codiart);
    INSERT INTO codiart
		SELECT
				@idCodiArt := @idCodiArt + 1 AS idCodArt,
				articulos.idArticulo,
				articulos.codArt,
				articulos.codArt AS codigo,
				'CP' as tipo,
				1 as cantiDesp,
				0 as procesado,
				'CV' as circuito
			FROM
				articulos
			WHERE
				articulos.idArticulo NOT IN (
					SELECT
						idArticulo
					FROM
						codiart);
    
	DROP TABLE IF EXISTS tmp_familias;
	DROP TABLE IF EXISTS tmp_subfam;
	DROP TABLE IF EXISTS tmp_marcas;
	DROP TABLE IF EXISTS tmp_artcat;					
	COMMIT;
	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `artcat_insertToTemp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `artcat_insertToTemp`(
	pIdProv INT,
	pBonif1 DECIMAL (10, 2),
	pBonif2 DECIMAL (10, 2),
	pBonif3 DECIMAL (10, 2),
	pBonif4 DECIMAL (10, 2),
    pMargenMay DECIMAL (10, 2),
    pMargenMin DECIMAL (10, 2),
	pHostName VARCHAR(50)
)
BEGIN
	DECLARE vErrorMessage VARCHAR(254);
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vErrorMessage = message_text;
		SELECT vErrorMessage AS 'result';
	END;
               
	UPDATE 
		tmp_artcat
			INNER JOIN articulos ON articulos.codArtPV = tmp_artcat.codArt
	SET
		tmp_artcat.idArticulo = articulos.idArticulo,
		tmp_artcat.bonif1 = CASE WHEN pBonif1 = 0 THEN IFNULL(articulos.bonif1, 0) ELSE pBonif1 END,
        tmp_artcat.bonif2 = CASE WHEN pBonif2 = 0 THEN IFNULL(articulos.bonif2, 0) ELSE pBonif2 END,
        tmp_artcat.bonif3 = CASE WHEN pBonif3 = 0 THEN IFNULL(articulos.bonif3, 0) ELSE pBonif3 END,
        tmp_artcat.bonif4 = CASE WHEN pBonif4 = 0 THEN IFNULL(articulos.bonif4, 0) ELSE pBonif4 END,
        tmp_artcat.costoAnt = articulos.costoRep,
        tmp_artcat.margenMay = CASE WHEN pMargenMay = 0 THEN IFNULL(articulos.margenMax, 0) ELSE pMargenMay END,
        tmp_artcat.margenMin = CASE WHEN pMargenMin = 0 THEN IFNULL(articulos.margenMin, 0) ELSE pMargenMin END,
        tmp_artcat.alicIVA = IFNULL(articulos.alicIVA, 21)
	WHERE
		articulos.idProv = pIdProv AND
		articulos.fecBaja IS NULL;
        
	UPDATE
		tmp_artcat
	SET
		tmp_artcat.costoRep = articulos_calcularCosto(tmp_artcat.prLista, tmp_artcat.bonif1,
			tmp_artcat.bonif2, tmp_artcat.bonif3, tmp_artcat.bonif4);
            
	UPDATE
		tmp_artcat
	SET
		tmp_artcat.prVentaMay = articulos_calcularVenta(tmp_artcat.costoRep, tmp_artcat.margenMay),
		tmp_artcat.prVentaMin = articulos_calcularVenta(tmp_artcat.costoRep, tmp_artcat.margenMin);
            
	UPDATE
		tmp_artcat
	SET
		tmp_artcat.prFinalMay = articulos_calcPrFinal(tmp_artcat.prVentaMay, tmp_artcat.alicIVA),
        tmp_artcat.prFinalMin = articulos_calcPrFinal(tmp_artcat.prVentaMin, tmp_artcat.alicIVA);

	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `artcat_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `artcat_update`(
	pUsuario VARCHAR(5),
	pHostName VARCHAR(50)
)
BEGIN
	DECLARE vMensaje VARCHAR(200);
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;	
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;
	
	START TRANSACTION;	

	UPDATE 
		articulos
			INNER JOIN tmp_artcat ON tmp_artcat.idArticulo = articulos.idArticulo
	SET
		articulos.prLista = 	tmp_artcat.prLista,
		articulos.bonif1 = tmp_artcat.bonif1,
		articulos.bonif2 = tmp_artcat.bonif2,
		articulos.bonif3 = tmp_artcat.bonif3,
		articulos.bonif4 = tmp_artcat.bonif4,
		articulos.costoRep = tmp_artcat.costoRep,
		articulos.margenMax = tmp_artcat.margenMay,
		articulos.margenMin = tmp_artcat.margenMin,
		articulos.prVentaMax = tmp_artcat.prVentaMay,
		articulos.prVentaMin = tmp_artcat.prVentaMin,		
		articulos.prFinalMax = tmp_artcat.prFinalMay,
		articulos.prFinalMin = tmp_artcat.prFinalMin,
		articulos.usuModi = pUsuario,
		articulos.fecmodi = CURRENT_TIMESTAMP,
		articulos.idhostmodi = pHostName;
		
	
	SELECT 
		CASE WHEN MAX(idArtCbios) IS NULL THEN 0 
		ELSE MAX(idArtCbios) END 
	INTO 
		@idArtCbio 
	FROM 
		art_cbios;
	
	INSERT INTO art_cbios
		SELECT
			(@idArtCbio := @idArtCbio + 1) AS idArtCbios,
			a.idArticulo,
			CURRENT_TIMESTAMP AS fecha,
			a.costoAnt AS prAnt,
			a.costoRep AS prNuevo,
			ROUND(((a.CostoRep - a.CostoAnt) * 100) / a.CostoAnt, 4) AS porcentaje
		FROM
			tmp_artcat a
				INNER JOIN articulos b ON b.idArticulo = a.idArticulo
		WHERE
			a.CostoAnt <> 0;
		
	COMMIT;
	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_actPrecProcesar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_actPrecProcesar`(
	pIdFamiliaDD int,
	pIdFamiliaHH int,
	pIdSubFamDD int,
	pIdSubFamHH int,
	pIdProvDD int,
	pIdProvHH int,
	pIdMarcaDD int,
	pIdMarcaHH int,
	pBonif1 double,
	pBonif2 double,
	pBonif3 double,
	pBonif4 double,
	pMargenMax double,
	pMargenMin double,
	pPorVariacion DOUBLE,
	pTMon VARCHAR(3),
	pCotizac double
)
BEGIN
	DROP TABLE IF EXISTS tmp_artic;
	CREATE TEMPORARY TABLE tmp_artic AS (
		SELECT
			articulos.idArticulo,
			articulos.idProv,
			articulos.idFamilia,
			articulos.idSubFam,
			articulos.idmarca,
			articulos.codArt,
			articulos.descripcio,
			articulos.alicIVA,
			articulos.prLista,
			articulos.prListaExt,
			articulos.tmon,
			articulos.cotizac,			
			articulos.bonif1,
			articulos.bonif2,
			articulos.bonif3,
			articulos.bonif4,
			articulos.costoRep,
			articulos.margenMax,
			articulos.margenMin,
			articulos.prventaMax,
			articulos.prventaMin,
			articulos.prfinalMax,
			articulos.prfinalMin,
			articulos.observ
		FROM
			articulos
		WHERE
			CASE WHEN pIdFamiliaDD = -1 AND pIdFamiliaHH = -1 
				THEN 1
				ELSE articulos.idFamilia BETWEEN pIdFamiliaDD AND pIdFamiliaHH END
			AND
			CASE WHEN pIdSubFamDD = -1	AND pIdSubFamHH = -1 
				THEN 1
				ELSE articulos.idSubFam BETWEEN pIdSubFamDD AND pIdSubFamHH END
			AND
			CASE WHEN pIdProvDD = -1 AND pIdProvHH = -1 
				THEN 1
				ELSE articulos.idProv BETWEEN pIdProvDD AND pIdProvHH END
			AND
			CASE WHEN pIdMarcaDD = -1 AND pIdMarcaHH = -1 
				THEN 1
				ELSE articulos.idmarca BETWEEN pIdMarcaDD AND pIdMarcaHH END
			AND articulos.tmon = pTMon
			AND
				articulos.fecBaja IS NULL
		ORDER BY
			articulos.codArt);

	UPDATE
		tmp_artic
	SET
		tmp_artic.bonif1 = CASE WHEN pBonif1 = -1 THEN tmp_artic.bonif1 ELSE pBonif1 END,
		tmp_artic.bonif2 = CASE WHEN pBonif2 = -1 THEN tmp_artic.bonif2 ELSE pBonif2 END,
		tmp_artic.bonif3 = CASE WHEN pBonif3 = -1 THEN tmp_artic.bonif3 ELSE pBonif3 END,
		tmp_artic.bonif4 = CASE WHEN pBonif4 = -1 THEN tmp_artic.bonif4 ELSE pBonif4 END,
		tmp_artic.margenMax = CASE WHEN pMargenMax = -1 THEN tmp_artic.margenMax ELSE pMargenMax END,
		tmp_artic.margenMin = CASE WHEN pMargenMin = -1 THEN tmp_artic.margenMin ELSE pMargenMin END;

	IF pPorVariacion != 0 THEN
		UPDATE
			tmp_artic
		SET
			tmp_artic.prLista = tmp_artic.prLista + (tmp_artic.prLista * (pPorVariacion / 100));
	END IF;
	
	IF pTMon != 'PSO' THEN
		UPDATE
			tmp_artic
		SET
			tmp_artic.cotizac = pCotizac,
			tmp_artic.prLista = tmp_artic.prListaExt * pCotizac;
	END IF;

	UPDATE
		tmp_artic
	SET
		tmp_artic.costoRep = articulos_calcularCosto (
			tmp_artic.prLista,
			tmp_artic.bonif1,
			tmp_artic.bonif2,
			tmp_artic.bonif3,
			tmp_artic.bonif4),
		tmp_artic.prventaMax = articulos_calcularVenta (
			tmp_artic.costoRep,
			tmp_artic.margenMax),
		tmp_artic.prventaMin = articulos_calcularVenta (
			tmp_artic.costoRep,
			tmp_artic.margenMin),
		tmp_artic.prfinalMax = articulos_calcPrFinal (
			tmp_artic.prventaMax,
			tmp_artic.alicIVA),
		tmp_artic.prfinalMin = articulos_calcPrFinal (
			tmp_artic.prventaMin,
			tmp_artic.alicIVA);

	SELECT * FROM tmp_artic;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_actPreGrabar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_actPreGrabar`(
	pUsuModi varchar(5),
	pIdHostModi varchar(50)
)
BEGIN
	DECLARE vIdArticulo INT;
	DECLARE vCostoAnt DOUBLE;
	DECLARE vCostoNuevo DOUBLE;
	DECLARE vFin INT;
	DECLARE cur_art CURSOR FOR
		SELECT
			articulos.idArticulo,
			articulos.costoRep AS costoAnt,
			tmp_artic.costoRep AS costoNuevo
		FROM
			articulos
				INNER JOIN tmp_artic
					ON tmp_artic.idArticulo = articulos.idArticulo
		GROUP BY
			articulos.idArticulo;	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFin = 1;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT 'Error en articulos_actPreGrabar' AS result;
	END;
			
	START TRANSACTION;
	
	OPEN cur_art;
	get_articulo: LOOP
		FETCH cur_art INTO vIdArticulo, vCostoAnt, vCostoNuevo;
		IF vFin = 1 THEN
			LEAVE get_articulo;
		END IF;
		CALL art_cbios_insert (vIdArticulo, vCostoAnt, vCostoNuevo);
	END LOOP get_articulo;
	CLOSE cur_art;
	
	UPDATE
		articulos a
			INNER JOIN tmp_artic b
				ON b.idArticulo = a.idArticulo
	SET
		a.prListaExt = b.prListaExt,
		a.cotizac = b.cotizac,
		a.prLista = b.prLista,
		a.bonif1 = b.bonif1,
		a.bonif2 = b.bonif2,
		a.bonif3 = b.bonif3,
		a.bonif4 = b.bonif4,
		a.costoRep = b.costoRep,
		a.margenMax = b.margenMax,
		a.margenMin = b.margenMin,
		a.prventaMax = b.prventaMax,
		a.prventaMin = b.prventaMin,
		a.prfinalMax = b.prfinalMax,
		a.prfinalMin = b.prfinalMin,
        a.fecActuPre = CURRENT_TIMESTAMP,
		a.usumodi = pUsuModi,
		a.fecmodi = CURRENT_TIMESTAMP,
		a.idhostmodi = pIdHostModi;

	COMMIT;
	SELECT 'OK' AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_actuPreCatalogo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_actuPreCatalogo`(
	pCodArt VARCHAR(20),
	pIdProv INT,
	pPrLista double,
	pBonif1 double,
	pBonif2 double,
	pBonif3 double,
	pBonif4 double,
	pCostoRep double,
	pMargenMax double,
	pMargenMin double,
	pPrVentaMax double,
	pPrVentaMin double,
	pPrFinalMax double,
	pPrFinalMin double,
	pCodUsu varchar(5),
	pIdHostModi varchar(50))
BEGIN
	DECLARE vMensaje text;
	DECLARE vCostoAnt DOUBLE;
	DECLARE vIdArticulo INT;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;
	
	SELECT
		IFNULL(articulos.idArticulo, -1) AS idArticulo,
		articulos.costoRep
	INTO
		vIdArticulo,
		vCostoAnt
	FROM
		articulos
	WHERE
		articulos.codArt = pCodArt AND
		articulos.idProv = pIdProv AND
		articulos.fecBaja IS NULL
	GROUP BY
		articulos.codArt,
		articulos.idProv;
	
	IF vIdArticulo IS NOT NULL THEN
		UPDATE
			articulos
		SET
			articulos.prLista = pPrLista,
			articulos.bonif1 = pBonif1,
			articulos.bonif2 = pBonif2,
			articulos.bonif3 = pBonif3,
			articulos.bonif4 = pBonif4,
			articulos.costoRep = pCostoRep,
			articulos.margenMax = pMargenMax,
			articulos.margenMin = pMargenMin,
			articulos.prventaMax = pPrVentaMax,
			articulos.prventaMin = pPrVentaMin,
			articulos.prfinalMax = pPrFinalMax,
			articulos.prfinalMin = pPrFinalMin,
			articulos.fecActuPre = CURRENT_TIMESTAMP,
			articulos.usumodi = pCodUsu,
			articulos.fecmodi = CURRENT_TIMESTAMP,
			articulos.idhostmodi = pIdHostModi
		WHERE
			articulos.codArt = pCodArt AND
			articulos.idProv = pIdProv AND
			articulos.fecBaja IS NULL;
			
		CALL art_cbios_insert(vIdArticulo, vCostoAnt, pCostoRep);
	END IF;
	
	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getAll`()
BEGIN
	SELECT
		articulos.*,
		proveedor.razSoc,
		marcas.descripcio AS 'marca',
		familias.descripcio AS 'familia',
		subfam.descripcio AS 'subfam'
	FROM
		articulos
			INNER JOIN proveedor ON proveedor.idProv = articulos.idProv
			INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
			INNER JOIN familias ON familias.idFamilia = articulos.idFamilia
			INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam
	WHERE
		articulos.`fecBaja` IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getAllConsulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getAllConsulta`()
BEGIN
	SELECT   	
		articulos.idArticulo,
		articulos.codArt, 
		articulos.descripcio, 
		marcas.descripcio AS descMarca, 
		subfam.descripcio AS descsubfam, 
		articulos.idprov, 
		proveedor.razSoc,
		articulos.alicIVA, 
		articulos.prLista, 
		articulos.bonif1, 
		articulos.bonif2,
		articulos.bonif3, 
		articulos.bonif4, 
		articulos.costoRep,  
		articulos.margenMax, 
		articulos.margenMin, 
		articulos.prventaMax, 
		articulos.prventaMin, 
		articulos.prfinalMax, 
		articulos.prfinalMin, 
		IFNULL(articulos.linkFoto, '') AS linkFoto,
		articulos.fecActuPre
	FROM 
		articulos 
			INNER JOIN marcas 
				ON articulos.idmarca = marcas.idmarca 
			INNER JOIN subfam 
				ON articulos.idSubFam = subfam.idSubFam 
			INNER JOIN proveedor 
				ON proveedor.idprov = articulos.idprov 
	WHERE articulos.fecBaja IS NULL 
		AND articulos.habilitado = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getAllForSISCLI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getAllForSISCLI`()
BEGIN
	SELECT
		articulos.idArticulo,
		articulos.codArt,
		articulos.descripcio,
		marcas.descripcio as linea,
		familias.descripcio as familia,
		subfam.descripcio as subFam,
		articulos.alicIVA,
		articulos.prVentaMin AS pr_lista_min,
		articulos.prVentaMax AS pr_lista_may,
		articulos.linkfoto,
		articulos.habilitado,
		articulos.fecBaja
	FROM
		articulos
	    	INNER JOIN marcas
	    		ON marcas.idMarca = articulos.idMarca
		    INNER JOIN familias
		    	ON familias.idFamilia = articulos.idFamilia
		    INNER JOIN subfam
		    	ON subfam.idSubFam = articulos.idSubFam
	WHERE
		articulos.codArt NOT LIKE '%ARX'
	ORDER BY
		articulos.idArticulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getAllForUpgrade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getAllForUpgrade`()
BEGIN
	SELECT 
		*
	FROM 
		articulos
    WHERE 
   		articulos.fecBaja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getByCod` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getByCod`(pCodArt varchar(20))
BEGIN
	SELECT
		*
   	FROM
    		articulos
	WHERE
    		articulos.codArt = pCodArt AND
		articulos.fecBaja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getById`(pIdArticulo int)
BEGIN
	SELECT 
		*
    FROM 
    	articulos
    WHERE 
   		articulos.idArticulo = pIdArticulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getEtiquetas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getEtiquetas`(
	pIdProv INT,
	pIdFamilia INT,
	pIdSubFam INT,
	pModificadosHoy BIT
)
BEGIN
	SELECT
		0 AS sel,
		codArt,
		descripcio,
		prFinalMin
	FROM
		articulos
	WHERE
		CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END AND
		CASE WHEN pIdFamilia = 0 THEN 1 ELSE articulos.idFamilia = pIdFamilia END AND
		CASE WHEN pIdSubFam = 0 THEN 1 ELSE articulos.idSubFAm = pIdSubFam END AND
		CASE WHEN pModificadosHoy = 0 
			THEN 1
			ELSE
				((CAST(articulos.fecAlta AS DATE) = CURRENT_DATE) OR
					(CAST(articulos.fecModi AS DATE) = CURRENT_DATE))
			END
	ORDER BY codArt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getSugerencias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getSugerencias`(
	pCodArt varchar(20))
BEGIN
	SET pCodArt = REPLACE(pCodArt, ' ', '%');
	SELECT
		idArticulo, codArt, descripcio
	FROM
		articulos
	WHERE
		(articulos.codArt LIKE CONCAT(pCodArt, '%') OR articulos.codArt LIKE CONCAT('%', pCodArt))
		AND articulos.fecBaja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getTotVendido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getTotVendido`(
	p_idarticulo VARCHAR(50),
	p_fecha_inicio DATE,
    p_fecha_fin DATE
)
BEGIN
    SELECT
        IFNULL(SUM(
            CASE 
                WHEN vc.cbte = 'NC' THEN -vd.cantidad
                ELSE vd.cantidad 
            END
        ), 0) AS vtotal,
        IFNULL(SUM(
            CASE 
                WHEN vc.cbte = 'NC' THEN -(vd.cantidad * vd.prVenta)
                ELSE (vd.cantidad * vd.prVenta)
            END
        ), 0) AS importe_total
    FROM ventascab vc
    INNER JOIN ventasdet vd 
        ON vc.idventasC = vd.idventasC
    INNER JOIN articulos art 
        ON art.idArticulo = vd.idArticulo
    WHERE (p_idArticulo = 0 OR art.idArticulo = p_idArticulo)
   	AND vc.cbte IN ('FC','NC') 
    AND vc.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
    AND vc.fecBaja is NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_getTotVendidoDesc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_getTotVendidoDesc`(
	p_idarticulo VARCHAR(50),
	p_fecha_inicio DATE,
    p_fecha_fin DATE
)
BEGIN
    SELECT
	art.codArt as 'codigo',
	cli.razSoc AS 'cliente',
	vc.fecEmision AS 'fecemis',
	CONCAT(vc.cbte, ' ', vc.tipoDoc, ' ', REPEAT('0', 4 - LENGTH(vc.ptoVta)), vc.ptoVta, '-', REPEAT('0', 8 - LENGTH(vc.numCbte)), vc.numCbte) AS 'cbte',
	art.descripcio AS 'descripcion',
	CASE
	 WHEN vc.cbte = 'NC' THEN -vd.cantidad
	 ELSE vd.cantidad
	END AS 'cantidad',
	CASE
	 WHEN vc.cbte = 'NC' THEN -(vd.cantidad * vd.prVenta)
	 ELSE (vd.cantidad * vd.prVenta)
	END AS 'importe'
	
	FROM ventascab vc
	JOIN ventasdet vd   ON vc.idventasC = vd.idventasC
	JOIN articulos art  ON art.idArticulo = vd.idArticulo
	JOIN clientes cli	  ON cli.idcliente = vc.idcliente
	
	WHERE vc.cbte IN ('FC','NC')
	  AND (p_idArticulo = 0 OR art.idArticulo = p_idArticulo)
	  AND vc.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
	  AND vc.fecBaja IS NULL
	ORDER BY
	  cantidad DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_insert`(
	p_idprov int, 
	p_idfamilia int, 
	p_idsubfam int, 
	p_idmarca int, 
	p_codart varchar(20), 
	p_descripcio varchar(200), 
	p_aliciva  decimal(10, 2), 
	p_tmon varchar(3), 
	p_prlistaext  decimal(10, 2), 
	p_cotizac  decimal(10, 2), 
	p_prlista  decimal(10, 2), 
	p_bonif1  decimal(10, 2), 
	p_bonif2  decimal(10, 2), 
	p_bonif3  decimal(10, 2), 
	p_bonif4  decimal(10, 2), 
	p_costorep  decimal(10, 2), 
	p_margenmax  decimal(10, 2), 
	p_margenmin  decimal(10, 2), 
	p_prventamax  decimal(10, 2), 
	p_prventamin  decimal(10, 2), 
	p_prfinalmax  decimal(10, 2), 
	p_prfinalmin  decimal(10, 2), 
    p_usarImpIn bit,
    p_porImpuIn decimal(5, 2),
    p_impImInMay decimal(20, 2),
    p_impImInMin decimal(20, 2),
	p_observ text, 
	p_habilitado bit,
	p_linkfoto varchar(100), 
	p_usualta varchar(5), 
	p_idhostalta varchar(50),
	p_esserv bit, 
	p_idunimed int, 
	p_codartpv varchar(45), 
	p_mostrador bit,
	p_llevastk bit,
    p_usarMonExt bit,
	p_promocion bit)
BEGIN
	

	DECLARE v_idarticulo int;

	
	SET v_idarticulo = (
		SELECT CASE
			WHEN MAX(idarticulo) IS NULL THEN 1
            ELSE MAX(idarticulo) + 1 END
		FROM articulos);

	
    INSERT INTO articulos (
		idarticulo, 
		idprov, 
		idfamilia, 
		idsubfam, 
		idmarca, 
		codart, 
		descripcio,
		aliciva, 
		tmon, 
		prlistaext, 
		cotizac, 
		prlista, 
		bonif1, 
		bonif2, 
		bonif3,
		bonif4, 
		costorep, 
		margenmax, 
		margenmin, 
		prventamax, 
		prventamin, 
		prfinalmax,
		prfinalmin,
        usarImpuIn,
        porImpuIn,
        impImInMay,
        impImInMin,
		observ, 
		habilitado, 
		linkfoto, 
		usualta, 
		fecalta, 
		idhostalta,
		esserv, 
		idunimed, 
		codartpv, 
		mostrador,
		llevastk, 
		equiv,
        usarMonExt,
		promocion)
	VALUES (
		v_idarticulo, 
		p_idprov,  
		p_idfamilia, 
		p_idsubfam, 
		p_idmarca, 
		p_codart, 
		p_descripcio,
		p_aliciva, 
		p_tmon, 
		p_prlistaext, 
		p_cotizac, 
		p_prlista, 
		p_bonif1, 
		p_bonif2, 
		p_bonif3,
		p_bonif4, 
		p_costorep, 
		p_margenmax, 
		p_margenmin, 
		p_prventamax, 
		p_prventamin, 
		p_prfinalmax,
		p_prfinalmin,
        p_usarImpIn,
        p_porImpuIn,
        p_impImInMay,
        p_impImInMin,
		p_observ, 
		p_habilitado, 
		p_linkfoto, 
		p_usualta, 
		current_timestamp, 
		p_idhostalta,
		p_esserv, 
		p_idunimed, 
		p_codartpv, 
		p_mostrador,
		p_llevastk, 
		v_idarticulo,
        p_usarMonExt,
		p_promocion);

	
    CALL codiart_insert (v_idarticulo, p_codart, p_codart, 'CP', 1, 'CV');

	
    INSERT INTO art_dep (
		idarticulo, 
		idstkdep, 
		usualta, 
		fecalta, 
		idhostalta)
	VALUES (
		v_idarticulo, 
		1, 
		p_usualta, 
		current_timestamp, 
		p_idhostalta);

    SELECT v_idarticulo AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_update`(p_idarticulo int,
  p_idprov int,
  p_idfamilia int,
  p_idsubfam int,
  p_idmarca int,
  p_codart varchar(20),
  p_descripcio varchar(200),
  p_aliciva decimal(10, 2),
  p_tmon varchar(3),
  p_prlistaext decimal(10, 2),
  p_cotizac decimal(10, 2),
  p_prlista decimal(10, 2),
  p_bonif1 decimal(10, 2),
  p_bonif2 decimal(10, 2),
  p_bonif3 decimal(10, 2),
  p_bonif4 decimal(10, 2),
  p_costorep decimal(10, 2),
  p_margenmax decimal(10, 2),
  p_margenmin decimal(10, 2),
  p_prventamax decimal(10, 2),
  p_prventamin decimal(10, 2),
  p_prfinalmax decimal(10, 2),
  p_prfinalmin decimal(10, 2),
  p_usarImpuIn bit,
  p_porImpuIn decimal(5, 2),
  p_impImInMay decimal(20, 2),
  p_impImInMin decimal(20, 2),
  p_observ text,
  p_habilitado bit,
  p_linkfoto varchar(100),
  p_usumodi varchar(5),
  p_idhostmodi varchar(50),
  p_esserv bit,
  p_idunimed int,
  p_codartpv varchar(45),
  p_mostrador bit,
  p_llevastk bit,
  p_usarMonExt bit,
  p_promocion bit)
BEGIN
  DECLARE vCostoAnt decimal(10, 2);
  DECLARE vMensaje text;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
    SELECT
      '0' AS 'result';
  END;

  SELECT
    articulos.costoRep INTO vCostoAnt
  FROM articulos
  WHERE articulos.idArticulo = p_idarticulo;

  UPDATE articulos
  SET articulos.idprov = p_idprov,
      articulos.idfamilia = p_idfamilia,
      articulos.idsubfam = p_idsubfam,
      articulos.idmarca = p_idmarca,
      articulos.codart = p_codart,
      articulos.descripcio = p_descripcio,
      articulos.aliciva = p_aliciva,
      articulos.tmon = p_tmon,
      articulos.prlistaext = p_prlistaext,
      articulos.cotizac = p_cotizac,
      articulos.prlista = p_prlista,
      articulos.bonif1 = p_bonif1,
      articulos.bonif2 = p_bonif2,
      articulos.bonif3 = p_bonif3,
      articulos.bonif4 = p_bonif4,
      articulos.costorep = p_costorep,
      articulos.margenmax = p_margenmax,
      articulos.margenmin = p_margenmin,
      articulos.prventamax = p_prventamax,
      articulos.prventamin = p_prventamin,
      articulos.prfinalMax = p_prfinalmax,
      articulos.prfinalMin = p_prfinalmin,
      articulos.usarImpuIn = p_usarImpuIn,
      articulos.porImpuIn = p_porImpuIn,
      articulos.impImInMay = p_impImInMay,
      articulos.impImInMin = p_impImInMin,
      articulos.observ = p_observ,
      articulos.habilitado = p_habilitado,
      articulos.linkfoto = p_linkfoto,
      articulos.usumodi = p_usumodi,
      articulos.fecmodi = CURRENT_TIMESTAMP,
      articulos.idhostmodi = p_idhostmodi,
      articulos.idunimed = p_idunimed,
      articulos.codartpv = p_codartpv,
      articulos.mostrador = p_mostrador,
      articulos.llevastk = p_llevastk,
      articulos.usarMonExt = p_usarMonExt,
      articulos.promocion = p_promocion
  WHERE articulos.idarticulo = p_idarticulo;
  
  -- Si cambia el costo del artículo, entonces, modifico la 
  -- última fecha de actualización
  IF ROUND(p_costorep, 0) <> ROUND(vCostoAnt, 0) THEN
    UPDATE
      articulos
    SET
      articulos.fecActuPre = CURRENT_TIMESTAMP()
    WHERE
      articulos.idArticulo = p_idarticulo;
  END IF;

  /*CALL art_cbios_insert(p_idarticulo, vCostoAnt, p_costorep);*/

  SELECT
    '1' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_updateByPrecioFinal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_updateByPrecioFinal`(
	IN `pIdArticulo` INT,
	IN `pPreVtaFinal` DECIMAL(20, 2),
	IN `pUsuario` VARCHAR(5),
	IN `pHostName` VARCHAR(50)
)
BEGIN
	DECLARE vPrLista DECIMAL(20, 2);
	DECLARE vAlicIVA DECIMAL(5, 2);
	DECLARE vBonif1 DECIMAL(5, 2);
	DECLARE vBonif2 DECIMAL(5, 2);
	DECLARE vBonif3 DECIMAL(5, 2);
	DECLARE vBonif4 DECIMAL(5, 2);
	DECLARE vCosto DECIMAL(20, 2);
	DECLARE vCostoAnt DECIMAL(20, 2);
	DECLARE vMargenMay DECIMAL(5, 2);
	DECLARE vMargenMin DECIMAL(5, 2);
	DECLARE vPrVenta DECIMAL(20, 2);
    DECLARE vUsarImpuIn BIT;
    DECLARE vPorImpuIn DECIMAL(5, 2);
    DECLARE vImpImInMay DECIMAL(20, 2);
    DECLARE vImpImInMin DECIMAL(20, 2);
	DECLARE vMensaje TEXT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;
	
	SELECT
		alicIVA,
		bonif1,
		bonif2,
		bonif3,
		bonif4,
		margenMax,
		margenMin,
		costoRep,
        usarImpuIn,
        porImpuIn
	INTO
		vAlicIVA,
		vBonif1,
		vBonif2,
		vBonif3,
		vBonif4,
		vMargenMay,
		vMargenMin,
		vCostoAnt,
        vUsarImpuIn,
        vPorImpuIn
	FROM
		articulos
	WHERE
		articulos.idArticulo = pIdArticulo;
	
    SET vPrVenta = pPreVtaFinal / (1 + (vAlicIVA / 100));
    SET vCosto = vPrVenta / (1 + (vMargenMin / 100));

    IF vUsarImpuIn THEN
        SET vImpImInMin = pPreVtaFinal * (vPorImpuIn / 100);
    END IF;
	
	SET vPrLista = articulos_costo_to_lista(vCosto, vBonif1, vBonif2, vBonif3, vBonif4);
		
	START TRANSACTION;
	UPDATE
		articulos
	SET
		articulos.prLista = vPrLista,
		articulos.costorep = vCosto
	WHERE
		articulos.idArticulo = pIdArticulo;
	
	UPDATE
		articulos
	SET
		articulos.prVentaMin = vPrVenta,
		articulos.prFinalMin = pPreVtaFinal,
		articulos.impImInMin = vImpImInMin,
		articulos.fecActuPre = CURRENT_TIMESTAMP,
		articulos.usuModi = pUsuario,
		articulos.fecModi = CURRENT_TIMESTAMP,
		articulos.idHostModi = pHostName
	WHERE
		articulos.idArticulo = pIdArticulo;
		
	-- Calculo el precio de venta mayorista a partir del costo obtenido
	-- al calcularlo en base al precio de final minorista.
	SET vPrVenta = articulos_calcularVenta(vCosto, vMargenMay);
	UPDATE
		articulos
	SET
		articulos.prventaMax = vPrVenta,
		articulos.prfinalMax = vPrVenta + (vPrVenta * (vAlicIVA / 100))
	WHERE
		articulos.idArticulo = pIdArticulo;

	CALL art_cbios_insert(pIdArticulo, vCostoAnt, vCosto);
	COMMIT;
	
	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_updateFromCbte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_updateFromCbte`(
	IN `pIdArticulo` INT,
	IN `pIdCliente` INT,
	IN `pPreVtaFinal` DOUBLE,
	IN `pUsuario` VARCHAR(5),
	IN `pHostName` VARCHAR(50)
)
BEGIN
	DECLARE vPrLista DOUBLE;
	DECLARE vAlicIVA DOUBLE;
	DECLARE vBonif1 DOUBLE;
	DECLARE vBonif2 DOUBLE;
	DECLARE vBonif3 DOUBLE;
	DECLARE vBonif4 DOUBLE;
	DECLARE vCosto DOUBLE;
	DECLARE vCostoAnt DOUBLE;
	DECLARE vMargenMay DOUBLE;
	DECLARE vMargenMin DOUBLE;
	DECLARE vPrVenta DOUBLE;
	DECLARE vEsMayorista BIT;
    DECLARE vUsarImpuIn BIT;
    DECLARE vPorImpuIn DECIMAL(5, 2);
    DECLARE vImpImInMay DECIMAL(20, 2);
    DECLARE vImpImInMin DECIMAL(20, 2);
	DECLARE vMensaje TEXT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;
	
	SELECT
		alicIVA,
		bonif1,
		bonif2,
		bonif3,
		bonif4,
		margenMax,
		margenMin,
		costoRep,
        usarImpuIn,
        porImpuIn
	INTO
		vAlicIVA,
		vBonif1,
		vBonif2,
		vBonif3,
		vBonif4,
		vMargenMay,
		vMargenMin,
		vCostoAnt,
        vUsarImpuIn,
        vPorImpuIn
	FROM
		articulos
	WHERE
		articulos.idArticulo = pIdArticulo;
	
	SELECT
		mayorista
	INTO
		vEsMayorista
	FROM
		clientes
	WHERE
		clientes.idCliente = pIdCliente;
	
	IF vEsMayorista THEN
		
		SET vPrVenta = pPreVtaFinal / (1 + (vAlicIVA / 100));
		SET vCosto = vPrVenta / (1 + (vMargenMay / 100));

		
		
		IF vUsarImpuIn THEN
			SET vImpImInMay = pPreVtaFinal * (vPorImpuIn / 100);
		END IF;
	ELSE
		
		SET vPrVenta = pPreVtaFinal / (1 + (vAlicIVA / 100));
		SET vCosto = vPrVenta / (1 + (vMargenMin / 100));

		
		
		IF vUsarImpuIn THEN
			SET vImpImInMin = pPreVtaFinal * (vPorImpuIn / 100);
		END IF;
	END IF;
    
	
	SET vPrLista = articulos_costo_to_lista(vCosto, vBonif1, vBonif2, vBonif3, vBonif4);
		
	START TRANSACTION;
	UPDATE
		articulos
	SET
		articulos.prLista = vPrLista,
		articulos.costorep = vCosto
	WHERE
		articulos.idArticulo = pIdArticulo;
	
	IF vEsMayorista THEN
		UPDATE
			articulos
		SET
			articulos.prVentaMax = vPrVenta,
			articulos.prFinalMax = pPreVtaFinal,
			articulos.impImInMay = vImpImInMay,
			articulos.fecActuPre = CURRENT_TIMESTAMP,
			articulos.usuModi = pUsuario,
			articulos.fecModi = CURRENT_TIMESTAMP,
			articulos.idHostModi = pHostName
		WHERE
			articulos.idArticulo = pIdArticulo;
	ELSE
		UPDATE
			articulos
		SET
			articulos.prVentaMin = vPrVenta,
			articulos.prFinalMin = pPreVtaFinal,
			articulos.impImInMin = vImpImInMin,
			articulos.fecActuPre = CURRENT_TIMESTAMP,
			articulos.usuModi = pUsuario,
			articulos.fecModi = CURRENT_TIMESTAMP,
			articulos.idHostModi = pHostName
		WHERE
			articulos.idArticulo = pIdArticulo;
	END IF;
	CALL art_cbios_insert(pIdArticulo, vCostoAnt, vCosto);
	COMMIT;
	
	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulos_validarCodigo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `articulos_validarCodigo`(
	pCodArt varchar(20))
BEGIN
	SELECT
		CASE WHEN COUNT(*) > 0 THEN 1
			ELSE 0 END 'result'
	FROM
		articulos
	WHERE
		articulos.codArt = pCodArt AND
		articulos.fecBaja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `arti_actupreGetByAny` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `arti_actupreGetByAny`(
	pIdProvDD int,
	pIdProvHH int,
	pIdFamiliaDD int,
	pIdFamiliaHH int,
	pIdSubFamDD int,
	pIdSubFamHH int,
	pIdMarcaDD int,
	pIdMarcaHH int,
	pCodArtDD varchar(20),
	pCodArtHH varchar(20))
BEGIN
	SELECT
		articulos.idArticulo,
		articulos.codArt,
		articulos.descripcio,
		articulos.alicIVA,
		articulos.prLista,
		articulos.bonif1,
		articulos.bonif2,
		articulos.bonif3,
		articulos.bonif4,
		articulos.costoRep,
		articulos.margenMax,
		articulos.margenMin,
		articulos.prventaMax,
		articulos.prventaMin,
		articulos.prfinalMax,
		articulos.prfinalMin
	FROM
		articulos
	WHERE
		articulos.fecBaja IS NULL AND
		CASE WHEN pIdProvDD = -1 AND pIdProvHH = -1 THEN 1
			ELSE articulos.idProv BETWEEN pIdProvDD AND pIdProvHH END AND
		CASE WHEN pIdFamiliaDD = -1 AND pIdFamiliaHH = -1 THEN 1
			ELSE articulos.idFamilia BETWEEN pIdFamiliaDD AND pIdFamiliaHH END AND
		CASE WHEN pIdSubFamDD = -1 AND pIdSubFamHH = -1 THEN 1
			ELSE articulos.idSubFam BETWEEN pIdSubFamDD AND pIdSubFamHH END AND
		CASE WHEN pIdMarcaDD = -1 AND pIdMarcaHH = -1 THEN 1
			ELSE articulos.idmarca BETWEEN pIdMarcaDD AND pIdMarcaHH END AND
		CASE WHEN pCodArtDD = '' AND pCodArtHH = '' THEN 1
			ELSE articulos.codArt BETWEEN pCodArtDD AND pCodArtHH END
	ORDER BY articulos.codArt ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `arti_actupreGrabar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `arti_actupreGrabar`(
	pIdArticulo int,
	pPrLista double,
	pBonif1 double,
	pBonif2 double,
	pBonif3 double,
	pBonif4 double,
	pCostoRep double,
	pMargenMax double,
	pMargenMin double,
	pPrVentaMax double,
	pPrVentaMin double,
	pPrFinalMax double,
	pPrFinalMin double,
	pCodUsu varchar(5),
	pIdHostModi varchar(50))
BEGIN
	DECLARE vCostoAnt DOUBLE;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT 'Error en arti_actupreGrabar' AS result;
	END;
	START TRANSACTION;
	
	SELECT
		articulos.costoRep
	INTO
		vCostoAnt
	FROM
		articulos
	WHERE
		articulos.idArticulo = pIdArticulo;
	
	UPDATE
		articulos
	SET
		articulos.prLista = pPrLista,
		articulos.bonif1 = pBonif1,
		articulos.bonif2 = pBonif2,
		articulos.bonif3 = pBonif3,
		articulos.bonif4 = pBonif4,
		articulos.costoRep = pCostoRep,
		articulos.margenMax = pMargenMax,
		articulos.margenMin = pMargenMin,
		articulos.prventaMax = pPrVentaMax,
		articulos.prventaMin = pPrVentaMin,
		articulos.prfinalMax = pPrFinalMax,
		articulos.prfinalMin = pPrFinalMin,
        articulos.fecActuPre = CURRENT_TIMESTAMP,
		articulos.usumodi = pCodUsu,
		articulos.fecmodi = CURRENT_TIMESTAMP,
		articulos.idhostmodi = pIdHostModi
	WHERE
		articulos.idArticulo = pIdArticulo;
		
	CALL art_cbios_insert(pIdArticulo, vCostoAnt, pCostoRep);
	COMMIT;
	SELECT 'OK' AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_cbios_getByArt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_cbios_getByArt`(
	pIdArticulo INT
)
BEGIN
	SELECT
		art_cbios.fecha,
		art_cbios.prAnt,
		art_cbios.prNuevo,
		art_cbios.porVar
	FROM
		art_cbios
	WHERE
		art_cbios.idArticulo = pIdArticulo
    ORDER BY art_cbios.fecha DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_cbios_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_cbios_insert`(
	pIdArticulo INT,
	pPrAnt DOUBLE,
	pPrNuevo DOUBLE
)
BEGIN
	DECLARE vIdArtCbio INT;
	DECLARE vPorcentaje DOUBLE;

    IF pPrAnt <> 0 THEN
    	SET vPorcentaje = ROUND(((pPrNuevo - pPrAnt) * 100) / pPrAnt, 4);
    ELSE
        SET vPorcentaje = 0;
    END IF;

	IF vPorcentaje != 0 THEN		
		SELECT
			CASE 
				WHEN MAX(idArtCbios) IS NULL THEN 1 
					ELSE MAX(idArtCbios) + 1 END
			INTO vIdArtCbio
		FROM
			art_cbios;
					
		INSERT INTO art_cbios (
			idArtCbios,
			idArticulo,
			fecha,
			prAnt,
			prNuevo,
			porVar)
		VALUES (
			vIdArtCbio,
			pIdArticulo,
			CURRENT_TIMESTAMP,
			pPrAnt,
			pPrNuevo,
			vPorcentaje
		);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_mrv_deleteByArt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_mrv_deleteByArt`(pIdArticulo int)
BEGIN
	DELETE 
	FROM 
		art_mrv
    WHERE 
   		art_mrv.idArticulo = pIdArticulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_mrv_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_mrv_insert`(pIdMarcaV int, pIdArticulo int)
BEGIN
	INSERT INTO art_mrv ( 
		idMarcaV,
		idArticulo)
	VALUES ( 
		pIdMarcaV,
		pIdArticulo);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_tempo_delByProv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_tempo_delByProv`(_idProv int)
begin
	delete from art_tempo
    where idprov = _idProv;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_tempo_getPend` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_tempo_getPend`(_idProv int)
begin
	select *
    from art_tempo
    where art_tempo.procesado = 0
		and art_tempo.idprov = _idProv;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_tempo_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_tempo_insert`(
    _idprov int,
    _idFamilia int,
    _idSubFam int,
    _idMarca int,
    _codArt varchar(20),
    _codArtPV varchar(20),
    _descripcio varchar(200),
    _alicIVA double,
    _prListaPV double,
    _bonif1 double,
    _bonif2 double,
    _bonif3 double,
    _bonif4 double,
    _costoRep double,
    _margenMay double,
    _margenMin double,
    _prVentaMay double,
    _prVentaMin double)
begin
	insert into art_tempo (
		idprov, idFamilia, idSubFam, idMarca, codArt, codArtPV, descripcio,
        alicIVA, prListaPV, bonif1, bonif2, bonif3, bonif4,
        costoRep, margenMay, margenMin, prVentaMay, prVentaMin)
	values (
		_idprov, _idFamilia, _idSubFam, _idMarca, _codArt, _codArtPV, _descripcio,
        _alicIVA, _prListaPV, _bonif1, _bonif2, _bonif3, _bonif4,
        _costoRep, _margenMay, _margenMin, _prVentaMay, _prVentaMin);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_tempo_marcarProc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_tempo_marcarProc`(_idArtTempo int)
begin
	update art_tempo
    set art_tempo.procesado = 1
    where art_tempo.idArtTempo = _idArtTempo;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_tempo_tienePend` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_tempo_tienePend`(_idProv int)
begin
	declare cantReg int;
    declare resultado bit;
    set cantReg = (select count(*)
		from art_tempo
        where procesado = 0
			and idprov = _idProv);
	if cantReg > 0 then
		set resultado = 1;
	else
		set resultado = 0;
    end if;
    select resultado as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_tempo_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_tempo_update`(
    _idFamilia int,
    _idSubFam int,
    _idMarca int,
    _codArt varchar(20),
    _codArtPV varchar(20),
    _descripcio varchar(200),
    _alicIVA double,
    _prListaPV double,
    _bonif1 double,
    _bonif2 double,
    _bonif3 double,
    _bonif4 double,
    _costoRep double,
    _margenMay double,
    _margenMin double,
    _prVentaMay double,
    _prVentaMin double,
    _procesado bit)
begin
	update art_tempo
    set idFamilia = _idFamilia,
		idSubFam = _idSubFam,
        idMarca = _idMarca,
        codArt = _codArt,
        descripcio = _descripcio,
        alicIVA = _alicIVA,
        bonif1 = _bonif1,
        bonif2 = _bonif2,
        bonif3 = _bonif3,
        bonif4 = _bonif4,
        costoRep = _costoRep,
        margenMay = _margenMay,
        margenMin = _margenMin,
        prVentaMay = _prVentaMay,
        prVentaMin = _prVentaMin,
        procesado = _procesado
	where codArtPV = _codArtPV
		and procesado = 0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_upd_tempo_getByPv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_upd_tempo_getByPv`(pIdProv int)
begin
	select *
    from art_upd_tempo
    where idProv = pIdProv;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_upd_tempo_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_upd_tempo_insert`(
	pIdArticulo int, pIdProv int, pStock varchar(10), pCodigo varchar(20),
    pCodArt varchar(20), pArticulo varchar(200), pLinea varchar(60),
    pRubro varchar(60), pVenta double, pLista double, pCosto double)
begin
	declare vIdArticulo int;
    declare vEsNuevo bit;
	declare mensaje text;
	declare exit handler for sqlexception
    begin
        get diagnostics condition 1 mensaje = message_text;
        select mensaje as result;
    end;
    
    select articulos.idArticulo into vIdArticulo
    from articulos
    where articulos.codArtPV = pCodigo
		and articulos.idprov = pIdProv
		and articulos.fecBaja is null;
    
    if (vIdArticulo is null) then
		set vEsNuevo = 1;
	else
		set vEsNuevo = 0;
    end if;
    
    insert into art_upd_tempo (
		idArticulo, idProv, stock, codigo, codArt, articulo, linea, rubro,
		venta, lista, bonif1, bonif2, bonif3, bonif4, margenMax, margenMin, costo, esNuevo)
	values (
		vIdArticulo, pIdProv, pStock, pCodigo, pCodArt, pArticulo, pLinea, pRubro,
		pVenta, pLista, 0, 0, 0, 0, 0, 0, pCosto, vEsNuevo);
    select 'OK' as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_upd_tempo_limpiar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_upd_tempo_limpiar`(pIdProv int)
begin
	declare exit handler for sqlexception
    begin
		rollback;
        select 0 as result;
    end;
    delete from art_upd_tempo where idProv = pIdProv;
    commit;
    select 1 as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `art_upd_tempo_procesar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `art_upd_tempo_procesar`(pIdProv int,
	pBonif1 double, pBonif2 double, pBonif3 double, pBonif4 double,
    pMargenMax double, pMargenMin double)
begin
	declare exit handler for sqlexception
    begin
		select 0 as result;
    end;   
    
    
    
    if (pBonif1 = 0) and (pBonif2 = 0) and (pBonif3 = 0) and (pBonif4 = 0) then
		update art_upd_tempo
			inner join articulos on articulos.idArticulo = art_upd_tempo.idArticulo
		set art_upd_tempo.bonif1 = articulos.bonif1,
			art_upd_tempo.bonif2 = articulos.bonif2,
            art_upd_tempo.bonif3 = articulos.bonif3,
            art_upd_tempo.bonif4 = articulos.bonif4;
	else
		update art_upd_tempo
			inner join articulos on articulos.idArticulo = art_upd_tempo.idArticulo
		set art_upd_tempo.bonif1 = pBonif1,
			art_upd_tempo.bonif2 = pBonif2,
            art_upd_tempo.bonif3 = pBonif3,
            art_upd_tempo.bonif4 = pBonif4;
    end if;
    
    
    if (pMargenMax = 0) and (pMargenMin = 0) then
		update art_upd_tempo
			inner join articulos on articulos.codArtPV = art_upd_tempo.codigo
		set art_upd_tempo.margenMax = articulos.margenMax,
			art_upd_tempo.margenMin = articulos.margenMin;
	else
		update art_upd_tempo
			inner join articulos on articulos.idArticulo = art_upd_tempo.idArticulo
		set art_upd_tempo.margenMax = pMargenMax,
			art_upd_tempo.margenMin = pMargenMin;		
    end if;    
	select 1 as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cccli_getForSISCLI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cccli_getForSISCLI`()
BEGIN
	SELECT cc.idCC_Cli,
		cc.idCliente,
		cc.idVendedor,
		cc.idCC_Orig,
		cc.idVentasC,
		cc.cbte,
		cc.tipoDoc,
		cc.ptoVta,
		cc.nroCbte,
		cc.fecEmis,
		cc.fecVto,
		cc.impDebe,
		cc.impHaber,
		cc.idOper,
		cc.observ,
		'' AS linkArchCbte
	FROM cc_cli cc
		LEFT JOIN(SELECT idoper, MAX(fecemis) AS 'fecfc'
			FROM cc_cli
			WHERE cbte IN('FC') and idoper != 0
			GROUP BY idoper) AS operfc ON cc.idoper = operfc.idoper
		LEFT JOIN (SELECT idoper, MAX(fecemis) AS 'fecadnd'
			FROM cc_cli
			WHERE cbte IN('AD', 'ND') and idoper != 0
			GROUP BY idoper) AS operadnd ON cc.idoper = operadnd.idoper
	WHERE cc.idOper IN (SELECT cc_cli.idOper
			FROM cc_cli
			WHERE(UsuBaja IS NULL OR UsuBaja = '')
			GROUP BY cc_cli.idOper HAVING ROUND(SUM(cc_cli.impDebe - cc_cli.impHaber), 2) <> 0)
		AND(UsuBaja IS NULL OR UsuBaja = '')
	ORDER BY cc.fecEmis, cc.idOper, nroCbte;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cccli_getIdOper` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cccli_getIdOper`(id_vta_origen int)
begin
    select idOper
    from cc_cli
    where cc_cli.idVentasC = id_vta_origen;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cccli_getNextIdOper` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cccli_getNextIdOper`()
begin
	select case when max(idOper) is null then 1
		else max(idOper) + 1 end as proxIdOper
	from cc_cli;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cccli_getSaldoMoroso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cccli_getSaldoMoroso`(
	pIdClienteDD int,
    pIdClienteHH int,
    pIdVendedorDD int,
    pIdVendedorHH int,
    pIdLocalidadDD int,
    pIdLocalidadHH int
)
BEGIN
	DROP TABLE IF EXISTS tmp_sdm;
    DROP TABLE IF EXISTS tmp_sda;
    DROP TABLE IF EXISTS tmp_operconsaldo;
    
    CREATE TEMPORARY TABLE tmp_operconsaldo
		SELECT 
			idOper 
		FROM 
			cc_cli 
		WHERE 
			fecBaja IS NULL AND 
			idCliente BETWEEN pIdClienteDD AND pIdClienteHH
		GROUP BY idOper
		HAVING ROUND(SUM(impDebe - impHaber), 2) != 0;
    
    CREATE INDEX idx_operconsaldo_id ON tmp_operconsaldo (idOper);
    
    CREATE TEMPORARY TABLE tmp_sda
		SELECT
			cc_cli.idCliente,
			ROUND(SUM(impDebe) - SUM(impHaber), 2) AS saldo_actual
		FROM
			cc_cli
		WHERE
			cc_cli.idCliente BETWEEN pIdClienteDD AND pIdClienteHH AND
            cc_cli.fecBaja IS NULL
		GROUP BY
			cc_cli.idCliente;
            
    
	CREATE INDEX idx_sdmidcliente ON tmp_sda (idCliente);
    
    
    
	CREATE TEMPORARY TABLE tmp_sdm
		SELECT 
			a.idCliente, 
			MAX(clientes.razSoc) AS razSoc, 
			MAX(clientes.telefono) AS telefono, 
			MAX(clientes.eMail) AS mail, 
			MAX(localidad.descripcio) AS localidad, 
			MAX(localidad.codPostal) AS codPostal, 
			MAX(localidad.idLocalid) AS idLocalid, 
			SUM(a.impDebe) - SUM(a.impHaber) AS saldo, 
			CASE
				WHEN a.cbte = 'FC' OR a.cbte = 'AD' THEN
					a.fecVto END fecVtoMin,
			IFNULL(CASE 	
				WHEN a.cbte = 'FC' OR a.cbte = 'AD' THEN
					DATEDIFF(CURRENT_TIMESTAMP, MIN(a.fecVto))
			END, 0) AS dias,
            tmp_sda.saldo_actual
		FROM 
			cc_cli a 
				INNER JOIN clientes ON clientes.idCliente = a.idCliente 
				INNER JOIN localidad ON localidad.idLocalid = clientes.idLocalid 
				INNER JOIN condpagos ON condpagos.idCondPago = a.idCondPago 
                INNER JOIN tmp_sda ON tmp_sda.idCliente = a.idCliente
                INNER JOIN tmp_operconsaldo ON tmp_operconsaldo.idOper = a.idOper
		WHERE 
			a.idCliente BETWEEN pIdClienteDD AND pIdClienteHH AND 
			a.idVendedor BETWEEN pIdVendedorDD AND pIdVendedorHH AND 
			localidad.idLocalid BETWEEN pIdLocalidadDD AND pIdLocalidadHH AND 
			a.fecBaja IS NULL AND 
			a.fecVto < CURRENT_TIMESTAMP
		GROUP BY 
			a.idOper,
			a.idCliente 
		HAVING
			ROUND(SUM(a.impDebe) - SUM(a.impHaber), 2) > 0
		ORDER BY 
			localidad.idLocalid, 
            a.idCliente;

    
    
	SELECT 
		idCliente,
		razSoc,
		telefono,
		mail,
		localidad,
		codPostal,
		idLocalid,
		ROUND(SUM(saldo), 2) AS saldo,
		ROUND(AVG(dias), 0) AS dias,
        saldo_actual
	FROM 
		tmp_sdm
	WHERE
		tmp_sdm.dias != 0
	GROUP BY
		idCliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cccli_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cccli_insert`(
    _idCliente int,
    _idCC_Orig int,
    _idVentasC int,
    _cbte varchar(3),
    _tipoDoc varchar(1),
    _ptoVta int,
    _nroCbte int,
    _fecEmis datetime,
    _fecVto datetime,
    _impDebe double,
    _impHaber double,
    _idOper int,
    _observ varchar(100),
    _usuAlta varchar(5),
    _fecAlta datetime,
    _idHostAlta varchar(50),
    _idCondPago int,
    _idSitIVA int,
    _idVendedor int)
begin
	declare proxID int;
    set proxID = (select
		case when max(idCC_Cli) is null then 1
        else max(idCC_Cli) + 1 end
        from cc_cli);
	insert into cc_cli (
		idCC_Cli, 
        idCliente,
        idCC_Orig,
        idVentasC,
        cbte,
        tipoDoc,
        ptoVta,
        nroCbte,
        fecEmis,
        fecVto,
        impDebe,
        impHaber,
        idOper,
        observ,
        usuAlta,
        fecAlta,
        idHostAlta,
        idCondPago,
        idSitIVA,
        idVendedor)
	values (
		proxID,
        _idCliente,
        _idCC_Orig,
        _idVentasC,
        _cbte,
        _tipoDoc,
        _ptoVta,
        _nroCbte,
        _fecEmis,
        _fecVto,
        _impDebe,
        _impHaber,
        _idOper,
        _observ,
        _usuAlta,
        _fecAlta,
        _idHostAlta,
        _idCondPago,
        _idSitIVA,
        _idVendedor);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cccli_insertarFactura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cccli_insertarFactura`(
	xidVentaC int)
BEGIN
	DECLARE vidCC_Cli int;
	DECLARE vidCliente int;
	DECLARE vCbte varchar(3);
	DECLARE vTipoDoc varchar(3);
	DECLARE vPtoVta int;
	DECLARE vNroCbte int;
	DECLARE vFecEmision datetime;
	DECLARE vFecVto datetime;
	DECLARE vImpDebe decimal(20, 2);
	DECLARE vidCondPago int;
	DECLARE vidSitIVA int;
	DECLARE vidVendedor int;
	DECLARE vidOper int;
	DECLARE vUsuario varchar(5);
	DECLARE vHost varchar(50);
	DECLARE vMensaje text;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		
		-- Guardo el error capturado en la tabla log_sps.
		INSERT INTO log_sps (
			sp_name, 
			fecha, 
			msgerror, 
			usuario, 
			host)
		VALUES (
			'cc_cli_insertDebe',
			current_timestamp,
			CONCAT('Error: ', vMensaje, 'Id Venta: ', xidVentaC),
			vUsuario,
			vHost
		);
	END;

	--	Obtengo los datos de la cabecera de ventas
	SELECT
		idCliente,
		idCondPago,
		idSitIVA,
		idVendedor,
		fecEmision,
		fecVto,
		cbte,
		tipoDoc,
		ptoVta,
		numCbte,
		totFact,
		usuAlta,
		idHostAlta
	INTO
		vidCliente,
		vidCondPago,
		vidSitIVA,
		vidVendedor,
		vFecEmision,
		vFecVto,
		vCbte,
		vTipoDoc,
		vPtoVta,
		vNroCbte,
		vImpDebe,
		vUsuario,
		vHost
	FROM
		ventascab
	WHERE
		ventascab.idVentasC = xidVentaC;
		
	-- Calculo el prÃ³ximo id.
	SELECT
		CASE WHEN MAX(idCC_Cli) IS NULL THEN 1 ELSE MAX(idCC_Cli) + 1 END
	INTO
		vidCC_Cli
	FROM
		cc_cli;
		
	-- Calculo el prÃ³ximo ID. de OperaciÃ³n
	SELECT
		CASE WHEN MAX(idOper) IS NULL THEN 1 ELSE MAX(idOper) + 1 END
	INTO
		vidOper
	FROM
		cc_cli;
		
	-- Inserto el registro en la tabla cc_cli.
	
	INSERT INTO cc_cli (
		idCC_Cli,
		idCliente,
		idVentasC,
		cbte,
		tipoDoc,
		ptoVta,
		nroCbte,
		fecEmis,
		fecVto,
		impDebe,
		impHaber,
		idOper,
		idCondPago,
		idSitIVA,
		idVendedor,
		usuAlta,
		fecAlta,
		idHostAlta)
	VALUES (
		vidCC_Cli,
		vidCliente,
		xidVentaC,
		vCbte,
		vTipoDoc,
		vPtoVta,
		vNroCbte,
		vFecEmision,
		vFecVto,
		vImpDebe,
		0,
		vidOper,
		vidCondPago,
		vidSitIVA,
		vidVendedor,
		vUsuario,
		current_timestamp,
		vHost);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cccli_insertCOB` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cccli_insertCOB`(

	pIdVentaC INT,

	pPtoVta INT,

	pImporte  DECIMAL(10, 2),

	pUsuAlta VARCHAR(5),

	pIdHostAlta VARCHAR(50)

)
BEGIN

	DECLARE mensaje_error TEXT;

	DECLARE vIdCliente INT;

	DECLARE vIdCC_Orig INT;

	DECLARE vIdOper INT;

	DECLARE vIdCondPago INT;

	DECLARE vIdSitIVA INT;

	DECLARE vIdVendedor INT;

	DECLARE vProxNroCbte INT;

	

	DECLARE EXIT handler FOR SQLEXCEPTION

	BEGIN

		GET DIAGNOSTICS CONDITION 1 mensaje_error = MESSAGE_TEXT;

		SELECT mensaje_error AS 'result';

	END;

	

	SELECT idOper, idCC_Cli INTO vIdOper, vIdCC_Orig

	FROM cc_cli

	WHERE cc_cli.idVentasC = pIdVentaC;

	

	SELECT idCondPago, idSitIVA, idVendedor, idCliente

	INTO vIdCondPago, vIdSitIVA, vIdVendedor, vIdCliente

	FROM ventascab

	WHERE ventascab.idVentasC = pIdVentaC;

	

	SELECT

		CASE WHEN MAX(nroCbte) IS NULL THEN 1

			ELSE MAX(nroCbte) + 1 END

	INTO vProxNroCbte

	FROM cc_cli

	WHERE cc_cli.ptovta = pPtoVta;

	

	CALL cccli_insert (

		vIdCliente,

		vIdCC_Orig,

		pIdVentaC,

		'COB',

		'',

		pPtoVta,

		vProxNroCbte,

		CURRENT_TIMESTAMP,

		NULL,

		0,

		pImporte,

		vIdOper,

		'COBRANZA CONTADO',

		pUsuAlta,

		CURRENT_TIMESTAMP,

		pIdHostAlta,

		vIdCondPago,

		vIdSitIVA,

		vIdVendedor);

		

	SELECT 'OK' AS 'result';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cccli_validar_saldos_a_favor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cccli_validar_saldos_a_favor`(
	pIdCliente int)
begin
	select
		case
			when count(*) > 0 then 1 else 0 end hay_cbte
	from
		cc_cli
	where
		cc_cli.idCliente = pIdCliente and
		cc_cli.impHaber <> 0 and
		cc_cli.idOper in (
			select
				idOper
			from
				cc_cli
			where
				idCliente = pIdCliente
			group by
				idOper
			having
				count(*) = 1
			order by
				idOper);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cccli_verificarEstadoCbte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cccli_verificarEstadoCbte`(_idVentasC int)
begin
	select idVentasC, round(saldo, 2) as saldo
	from cc_cli
		inner join (
			select idOper, sum(impDebe - impHaber) as saldo
			from cc_cli
			group by idOper) as saldo on saldo.idOper = cc_cli.idOper
	where idVentasC = _idVentasC;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cheques_buscarND` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cheques_buscarND`(
	_nroCheque varchar(8),
    _idBanco int)
begin
	select *
    from cheques
    where cheques.chq_nro = _nroCheque
		and cheques.idBanco = _idBanco
        and cheques.estado != 'R';
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `citicpas_calcCantAlic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `citicpas_calcCantAlic`()
begin
    declare v_idCitiCpa int;
    declare v_idCompraC int;
    declare v_cuitPV varchar(20);
    declare v_nroCbte varchar(20);
    declare v_cuitPVAnt varchar(20);
    declare v_nroCbteAnt varchar(20);
    declare v_cantAlicIVA int;
    declare v_impIVA21 double;
    declare v_impIVA105 double;
    declare fin int default 0;

    declare cur_citi cursor for
    select idCitiCpa, idCompraC, cuitPV, nroCbte 
    from citicpa_cab
    order by cuitPV, nroCbte;

    declare continue handler for not found set fin = 1;
    open cur_citi;

    set v_cuitPVAnt = '';
    set v_nroCbteAnt = '';
    get_citi: loop
		fetch cur_citi into v_idCitiCpa, v_IdCompraC, v_cuitPV, v_nroCbte;
        if fin = 1 then
			leave get_citi;
        end if;

        select impIVA21, impIVA105 into v_impIVA21, v_impIVA105
        from comprascab
        where comprascab.idCompraC = v_IdCompraC;

        if (v_impIVA21 = 0) and (v_impIVA105 = 0) then
	    set v_cantAlicIVA = 0;
        else
  	    if (v_impIVA21 <> 0) and (v_impIVA105 <> 0) then
	        set v_cantAlicIVA = 2;
            else
	        set v_cantAlicIVA = 1;
            end if;
        end if;

        update citicpa_cab
        set cantAlicIVA = convert(v_cantAlicIVA, char(1))
        where citicpa_cab.idCitiCpa = v_idCitiCpa;

        set v_cuitPVAnt = v_cuitPV;
        set v_nroCbteAnt = v_nroCbte;
	end loop get_citi;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `citicpas_generarCabecera` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `citicpas_generarCabecera`(p_anio int, p_mes int)
begin
	set binlog_format = mixed;   
    drop table if exists tmp_percIIBB;    
	truncate table citicpa_cab;

	create temporary table if not exists tmp_percIIBB as (
		select 
			idCompraC, 
			replace(round(sum(importe), 2), '.', '') as impPerIIBB
		from comprasret
		where comprasret.tipo = 'RIB'
		group by idCompraC);

	/* En el select paso los impuestos internos de otros tributos a conceptos no grabado
		segÃºn recomendaciÃ³n del estudio contable */
	insert into citicpa_cab (
		idCompraC,
		fecEmis,
		tipoCbte,
		ptoVta,
		nroCbte,
		nroDespImp,
		codDoc,
		cuitPV,
		razSocPV,
		impTotOper,
		ImpConceptos,
		ioe,
		impPercValAg,
		impPercOIN,
		impPerIIBB,
		impPerImpMun,
		impImpInt,
		codMon,
		tipoCbio,
		cantAlicIVA,
		codOper,
		credFisComp,
		otrosTrib,
		cuitEmisCorr,
		denomEmisCorr,
		ivaCom)
	select 
		comprascab.idCompraC,
		replace(cast(cast(comprascab.fecEmis as date) as char(10)), '-', '') as fecEmis,
		citicpas_cbtes.cod_afip as tipoCbte,
		concat(repeat('0', 5 - length(comprascab.ptoVta)), comprascab.ptovta) as ptoVta,
		concat(repeat('0', 20 - length(comprascab.numCbte)), comprascab.numCbte) as nroCbte,
		repeat(' ', 16) as nroDespImp,
		80 as codDoc, 
		concat(repeat('0', 20 - length(comprascab.cuitPV)), comprascab.cuitPV) as cuitPV,
		substring(comprascab.razSocPV, 1, 30) as razSocPV,
		citicpas_formatImporte(comprascab.totFinal) as totImpOper,
		concat(repeat('0', 15 - length((round(impuestos * 100, 0)))), (round(impuestos * 100, 0))) as ImpConceptos,
		repeat('0', 15) as ioe,
		concat(repeat('0', 15 - length(round(retIVA * 100, 0))), round(retIVA * 100, 0)) as impPercValAg,
		repeat('0', 15) as impPercOIN,
		case 
			when impPerIIBB is null then 
				repeat('0', 15) 
			else 
				concat(repeat('0', 15 - length(impPerIIBB)), impPerIIBB)
			end as impPerIIBB,
		repeat('0', 15) as impPerImpMun,
		repeat('0', 15) as impImpInt,
		'PES' as codMon,
		concat(repeat('0', 10 - length('1000000')), '1000000') as tipoCbio,
		'0' as cantAlicIVA,
		'0' as codOper,
		citicpas_calcCreditoFiscal(comprascab.impIVA21, comprascab.impIVA105) as credFisComp,
		repeat('0', 15) as otrosTrib,
		repeat('0', 11) as cuitEmisCorr,
		repeat(' ', 30) as denomEmisCorr,
		repeat('0', 15) as ivaCom
	from comprascab
		inner join citicpas_cbtes on citicpas_cbtes.codigo = comprascab.cbte
			and citicpas_cbtes.tipoDoc = comprascab.tipoDoc
		left outer join tmp_percIIBB as retenciones on retenciones.idCompraC = comprascab.idCompraC
	where year(comprascab.fecEmis) = p_anio
		and month(comprascab.fecEmis) = p_mes
        and comprascab.fecBaja IS NULL
	order by
		citicpas_cbtes.cod_afip,
        comprascab.ptovta,
        comprascab.numCbte;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `citicpas_generarCitiCpa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `citicpas_generarCitiCpa`(p_anio int, p_mes int)
begin
    call citicpas_generarCabecera (p_anio, p_mes);
    call citicpas_calcCantAlic ();
    call citicpa_generarAlic (p_anio, p_mes);
    select * from citicpa_cab;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `citicpas_obtenerAlicuotas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `citicpas_obtenerAlicuotas`()
begin
	select
		tipoCbte,
		ptoVta,
		nroCbte,
		codDocVdor,
		cuitPV,
		citicpas_formatImporte(sum(impNetoGrav)) as impNetoGrav,
		alicIVA,
		citicpas_formatImporte(sum(impLiq)) as impLiq
	from
		citicpa_alic
	group by
		alicIVA,
		tipoCbte,
		ptoVta,
		nroCbte,
		cuitPV
	order by
		tipoCbte,
        ptoVta,
        nroCbte;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `citicpa_generarAlic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `citicpa_generarAlic`(pAnio int, pMes int)
begin
	truncate table citicpa_alic;
    
	insert into citicpa_alic (
			idCompraC, tipoCbte, ptoVta, nroCbte, codDocVdor,
			cuitPV, impNetoGrav, alicIVA, impLiq)
		select
			comprascab.idCompraC,
			citicpas_cbtes.cod_afip as tipoCbte,
			concat(repeat('0', 5 - length(comprascab.ptoVta)), comprascab.ptovta) as ptoVta,
			concat(repeat('0', 20 - length(comprascab.numCbte)), comprascab.numCbte) as nroCbte,
			'80' as codDocVdor, 
			concat(repeat('0', 20 - length(comprascab.cuitPV)), comprascab.cuitPV) as cuitPV,
			concat(repeat('0', 15 - length(round(impNeto * 100, 0))), round(impNeto * 100, 0)) as impNetoGrav,
			citi_alicuotas.codAlicuota,
			concat(repeat('0', 15 - length(round(cpasdet_cp.ivaImp * 100, 0))), round(cpasdet_cp.ivaImp * 100, 0)) as impLiq
		from comprascab
			inner join cpasdet_cp on cpasdet_cp.idCompraC	= comprascab.idCompraC
			inner join citicpas_cbtes on citicpas_cbtes.codigo = comprascab.cbte
				and citicpas_cbtes.tipoDoc = comprascab.tipoDoc
			inner join citi_alicuotas on citi_alicuotas.alicuota = cpasdet_cp.ivaPor
		where year(comprascab.fecEmis) = pAnio
			and month(comprascab.fecEmis) = pMes and
            comprascab.fecBaja IS NULL
		group by tipoCbte, ptoVta, numCbte, codAlicuota
		order by tipoCbte, ptoVta, numCbte;

	insert into citicpa_alic (
			idCompraC, tipoCbte, ptoVta, nroCbte, codDocVdor,
			cuitPV, impNetoGrav, alicIVA, impLiq)
		select
			comprascab.idCompraC,
			citicpas_cbtes.cod_afip as tipoCbte,
			concat(repeat('0', 5 - length(comprascab.ptoVta)), comprascab.ptovta) as ptoVta,
			concat(repeat('0', 20 - length(comprascab.numCbte)), comprascab.numCbte) as nroCbte,
			'80' as codDocVdor, 
			concat(repeat('0', 20 - length(comprascab.cuitPV)), comprascab.cuitPV) as cuitPV,
			comprasdet.totNeto as impNetoGrav,
			citi_alicuotas.codAlicuota,
			comprasdet.impIVA as impLiq 
		from comprascab
			inner join comprasdet on comprasdet.idCompraC	= comprascab.idCompraC
			inner join citicpas_cbtes on citicpas_cbtes.codigo = comprascab.cbte
				and citicpas_cbtes.tipoDoc = comprascab.tipoDoc
			inner join citi_alicuotas on citi_alicuotas.alicuota = comprasdet.alicIVA
		where year(comprascab.fecEmis) = pAnio
			and month(comprascab.fecEmis) = pMes
		group by tipoCbte, ptoVta, numCbte, codAlicuota
		order by tipoCbte, ptoVta, numCbte;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientesGetAllForUpgrade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `clientesGetAllForUpgrade`()
BEGIN
	SELECT
		clientes.`idCliente`,
		clientes.`idVendedor`,
		clientes.`razSoc`,
		clientes.`nomFant`,
		clientes.`direccion`,
		localidad.`descripcio` AS localidad,
		provincias.`descripcio` AS provincia,
		localidad.`codPostal`,
		sitiva.`descripcio` AS sitIVA,
		clientes.`nroCUIT`,
		condpagos.`descripcio` AS condPago,
		clientes.`telefono`,
		clientes.`fax`,
		clientes.`eMail`,
		clientes.`habilitado`,
		clientes.`usuWeb`,
		clientes.`claveWeb`,
		clientes.`mayorista`
	FROM clientes
		INNER JOIN localidad ON localidad.`idLocalid` = clientes.`idLocalid`
		INNER JOIN provincias ON provincias.`idProvin` = localidad.`idProvin`
		INNER JOIN sitiva ON sitiva.`idSitIVA` = clientes.`idSitIVA`
		INNER JOIN `condpagos` ON condpagos.`idCondPago` = clientes.`idCondPago`
	WHERE clientes.`fecBaja` IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientesGetByIdForUpgrade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `clientesGetByIdForUpgrade`(_id INT)
BEGIN
	SELECT
		clientes.`idCliente`,
		clientes.`idVendedor`,
		clientes.`razSoc`,
		clientes.`nomFant`,
		clientes.`direccion`,
		localidad.`descripcio` AS localidad,
		provincias.`descripcio` AS provincia,
		localidad.`codPostal`,
		sitiva.`descripcio` AS sitIVA,
		clientes.`nroCUIT`,
		condpagos.`descripcio` AS condPago,
		clientes.`telefono`,
		clientes.`fax`,
		clientes.`eMail`,
		clientes.`habilitado`,
		clientes.`usuWeb`,
		clientes.`claveWeb`,
		clientes.`mayorista`
	FROM clientes
		INNER JOIN localidad ON localidad.`idLocalid` = clientes.`idLocalid`
		INNER JOIN provincias ON provincias.`idProvin` = localidad.`idProvin`
		INNER JOIN sitiva ON sitiva.`idSitIVA` = clientes.`idSitIVA`
		INNER JOIN `condpagos` ON condpagos.`idCondPago` = clientes.`idCondPago`
	WHERE clientes.`fecBaja` IS NULL
		AND clientes.`idCliente` = _id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientes_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `clientes_getById`( _idCliente int)
BEGIN
	SELECT *
    FROM clientes
    WHERE idCliente = _idCliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientes_getMorosos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `clientes_getMorosos`()
BEGIN

	DECLARE vIdClienteCF int;
	
	select cast(cfg_value as int) into vIdClienteCF from global_cfg where cfg_key = 'CLI_CF';

	/*drop table if exists tmp_clientes_morosos;
	create temporary table tmp_clientes_morosos (
		idCliente int not null unique,
		habilitado bit not null,
		razSoc varchar(60) not null,
		telefono varchar(30) null,
		eMail varchar(60) null,
		primary key (idCliente));*/

	drop table if exists x_op_con_saldo;
	create temporary table x_op_con_saldo
		select
			idOper
		from
			cc_cli as aux
		where
			aux.fecBaja IS NULL
		group by
			idOper
		having
			(round(sum(aux.impDebe), 2) - round(sum(aux.impHaber), 2)) != 0;


	select
		clientes.habilitado AS habilitado,
		clientes.idCliente,
		clientes.razSoc, 
		clientes.telefono,
		clientes.eMail
	from
		cc_cli
			inner join x_op_con_saldo on x_op_con_saldo.idOper = cc_cli.idOper
			inner join clientes on clientes.idCliente = cc_cli.idCliente
	where
		cc_cli.impDebe != 0 and
		current_date() > cast(cc_cli.fecVto as date) and
		cc_cli.idCliente != vIdClienteCF
	group by
		cc_cli.idCliente;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientes_getTrasp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `clientes_getTrasp`(
	p_idCliente int
)
BEGIN
	SELECT
		transp.*, localidad.codPostal, localidad.descripcio
	FROM
		transp
			INNER JOIN clientes
				ON clientes.idTransp = transp.idTransp
			INNER JOIN localidad ON localidad.idLocalid = transp.idLocalid
	WHERE
		clientes.idCliente = p_idCliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientes_habilitar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `clientes_habilitar`(
	pIdCliente INT,
	pHabilitado bit)
BEGIN
	DECLARE vMensaje TEXT;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		SELECT vMensaje AS 'result';
	END;
	UPDATE
		clientes
	SET
		clientes.habilitado = pHabilitado
	WHERE
		clientes.idCliente = pIdCliente;
	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientes_insert_rapido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `clientes_insert_rapido`(
	IN prazSoc varchar(60),
	IN pdireccion varchar(60),
	IN pidLocalid int,
	IN pidCondPago int,
	IN pidSitIVA int,
	IN pidVendedor int,
	IN pidTipoCli int,
	IN pidTransp int,
	IN pidTipoDoc int,
	IN pidRamo int,
	IN pnroCUIT varchar(20),
	IN ptelefono varchar(20),
	IN pcelular varchar(20),
	IN pfax varchar(20),
	IN peMail varchar(60),
	IN phabilitado bit,
	IN pmayorista bit,
	IN pdesc1 decimal(5, 2),
	IN pdesc2 decimal(5, 2),
	IN pdesc3 decimal(5, 2),
	IN pdesc4 decimal(5, 2),
	IN precargo decimal(5, 2),
	IN pusuAlta varchar(5),
	IN pidHostAlta varchar(50),
	IN penvCbte bit,
	IN pprintCbte bit,
	IN pmailFC varchar(60),
	IN pctrMoro bit
)
begin
	declare mensaje varchar(255);
    declare exit handler for sqlexception
    begin
		rollback;
        get diagnostics condition 1 mensaje = message_text;
        select mensaje as result;
    end;
    start transaction;
	set @maxID = (select MAX(idCliente) + 1 from clientes);
	insert into clientes (
		idCliente,
		razSoc,
		direccion,
		idLocalid,
		idCondPago,
		idSitIVA,
		idVendedor,
		idTipoCli,
		idTransp,
		idTipoDoc,
		idRamo,
		nroCUIT,
		telefono,
		celular,
		fax,
		eMail,
		habilitado,
		mayorista,
		desc1,
		desc2,
		desc3,
		desc4,
		recargo,
		usuAlta,
		fecAlta,
		idHostAlta,
		envCbte,
		printCbte,
		mailFC,
		ctrMoro)
	values (
		@maxID,
		prazSoc,
		pdireccion,
		pidLocalid,
		pidCondPago,
		pidSitIVA,
		pidVendedor,
		pidTipoCli,
		pidTransp,
		pidTipoDoc,
		pidRamo,
		pnroCUIT,
		ptelefono,
		pcelular,
		pfax,
		peMail,
		phabilitado,
		pmayorista,
		pdesc1,
		pdesc2,
		pdesc3,
		pdesc4,
		precargo,
		pusuAlta,
		current_timestamp,
		pidHostAlta,
		penvCbte,
		pprintCbte,
		pmailFC,
		pctrMoro
		);
	commit;
	select @maxID as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientes_updateClave` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `clientes_updateClave`(pIdCliente int, pUsuario varchar(20), pClave varchar(20))
BEGIN
	DECLARE vMensaje text;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
    END;
    START TRANSACTION;
    UPDATE clientes
    SET usuWeb = pUsuario,
		claveWeb = pClave
	WHERE clientes.idCliente = pIdCliente;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `codiart_deleteByArtic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `codiart_deleteByArtic`(pIdArticulo int)
BEGIN
	DELETE
	FROM
		codiart
	WHERE
		idArticulo = pIdArticulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `codiart_getByArticulo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `codiart_getByArticulo`(pIdArticulo int)
BEGIN
	SELECT *
	FROM codiart
	WHERE idArticulo = pIdArticulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `codiart_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `codiart_insert`(pIdArticulo int,
	pCodArt varchar(20), pCodigos varchar(20), pTipo varchar(2),
    pCantiDesp double, pCircuito varchar(2))
BEGIN
	DECLARE pIdCodArt int;

	SET	pIdCodArt = (
			SELECT
				CASE WHEN MAX(idCodArt) IS NULL THEN 1
				ELSE MAX(idCodArt) + 1 END
			FROM
				codiart);

	INSERT INTO codiart (
		idCodArt,
		idArticulo,
		codArt,
		codigos,
		tipo,
		cantiDesp,
		procesado,
		circuito)
	VALUES (
		pIdCodArt,
		pIdArticulo,
        pCodArt,
        pCodigos,
        pTipo,
        pCantiDesp,
        0,
        pCircuito);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `compras_getResumenByCpto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `compras_getResumenByCpto`(
	pAnio int,
	pMes int
)
BEGIN
	SELECT
		YEAR(comprascab.fecAlta) AS anio,
		YEAR(comprascab.fecAlta) AS mes,
		cpasdet_cp.idPlanCta,
		planctas.codPlanCta,
		planctas.descripcio,
		ROUND(SUM(cpasdet_cp.impNeto), 2) AS totalNeto,
		ROUND(SUM(cpasdet_cp.ivaImp), 2) AS totalIvaImp,
		ROUND(SUM(cpasdet_cp.total), 2) AS total
	FROM
		cpasdet_cp
			INNER JOIN comprascab ON comprascab.idCompraC = cpasdet_cp.idCompraC
			INNER JOIN planctas ON planctas.idPlanCta = cpasdet_cp.idPlanCta
	WHERE
		YEAR(comprascab.fecAlta) = pAnio AND
		MONTH(comprascab.fecAlta) = pMes
	GROUP BY
		YEAR(comprascab.fecAlta),
		MONTH(comprascab.fecAlta),
		cpasdet_cp.idPlanCta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `compras_libroIVA` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `compras_libroIVA`(pAnio int, pMes int)
begin
	select	comprascab.idcomprac,
		date(comprascab.fecEmis) as 'fecEmision',
		comprascab.cbte,
		comprascab.tipoDoc,
		comprascab.ptoVta,
		comprascab.numCbte,
		proveedor.razSoc as 'Proveedor',
		provincias.descripcio AS 'Juris',
		sitiva.codIVA as 'Cat',
		proveedor.nroCUIT,
		round(comprascab.totNeto * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Neto_Grav',
		round(comprascab.noGravado * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Neto_No_Grav',
		round(comprascab.impIVA21 * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'IVA_21',
		round(comprascab.impIVA105 * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'IVA_105',
		round(comprascab.retIVA * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retIVA',
		round(comprascab.retIIBB * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retIIBB',
		round(comprascab.retGan * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retGan',
		round(comprascab.retSUSS * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retSUSS',
		round(comprascab.impuestos * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Impuestos',
		round(comprascab.totFinal * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Total'
	from comprascab
		inner join proveedor on proveedor.idProv = comprascab.idProv
		inner join localidad on proveedor.idlocalid = localidad.idlocalid
		inner join provincias on localidad.idprovin = provincias.idprovin
		inner join sitiva on sitiva.idSitIVA = proveedor.idSitIVA
	where year(comprascab.fecEmis) = pAnio
		and month(comprascab.fecEmis) = pMes
        and comprascab.fecBaja is null
	order by comprascab.fecEmis asc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `compras_libroIVA_control` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `compras_libroIVA_control`(pAnio int, pMes int)
begin
	drop table if exists tmp_ivacpa;
    create temporary table tmp_ivacpa
		select	comprascab.idcomprac,
			date(comprascab.fecEmis) as 'fecEmision',
			comprascab.cbte,
			comprascab.tipoDoc,
			comprascab.ptoVta,
			comprascab.numCbte,
			proveedor.razSoc as 'Proveedor',
			provincias.descripcio AS 'Juris',
			sitiva.codIVA as 'Cat',
			proveedor.nroCUIT,
			round(comprascab.totNeto * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Neto_Grav',
			round(comprascab.noGravado * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Neto_No_Grav',
			round(comprascab.impIVA21 * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'IVA_21',
			round(comprascab.impIVA105 * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'IVA_105',
			round(comprascab.retIVA * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retIVA',
			round(comprascab.retIIBB * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retIIBB',
			round(comprascab.retGan * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retGan',
			round(comprascab.retSUSS * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retSUSS',
			round(comprascab.impuestos * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Impuestos',
			round(comprascab.totFinal * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Total'
		from comprascab
			inner join proveedor on proveedor.idProv = comprascab.idProv
			inner join localidad on proveedor.idlocalid = localidad.idlocalid
			inner join provincias on localidad.idprovin = provincias.idprovin
			inner join sitiva on sitiva.idSitIVA = proveedor.idSitIVA
		where year(comprascab.fecEmis) = pAnio
			and month(comprascab.fecEmis) = pMes
		order by comprascab.fecEmis asc;
        
	select
		'IVACPA' as codigo,
        sum(Neto_Grav) as total_netograv,
        sum(IVA_21) as total_iva21,
        sum(IVA_105) as total_iva105,
        sum(retIVA) as retIVA,
        sum(total) as total
	from
		tmp_ivacpa;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cpa_getIndicadorArticulos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cpa_getIndicadorArticulos`(
	pId INT,
	pAgrupadoPor VARCHAR(3)
)
BEGIN
	DROP TABLE IF EXISTS _artcbios;
	CREATE TEMPORARY TABLE _artcbios
		SELECT
			art_cbios.idArticulo,
            MAX(art_cbios.idArtCbios) AS maxIdArtCbios
		FROM
			art_cbios
				INNER JOIN articulos ON articulos.idArticulo = art_cbios.idArticulo
		WHERE
			(CASE WHEN pAgrupadoPor = 'MRC' THEN articulos.idMarca = pId
				ELSE articulos.idProv = pId END)
		GROUP BY
			art_cbios.idArticulo;
				
	SELECT
		articulos.idArticulo,
		CASE WHEN MAX(art_cbios.fecha) IS NULL THEN 'NUNCA'
			ELSE MAX(art_cbios.fecha) END fecha,
		MAX(articulos.codArt) AS codArt,
		MAX(articulos.descripcio) AS descripcio,
		CASE WHEN MAX(art_cbios.prAnt) IS NULL THEN -1
			ELSE MAX(art_cbios.prAnt) END prAnt,
		CASE WHEN MAX(art_cbios.prNuevo) IS NULL THEN -1
			ELSE MAX(art_cbios.prNuevo) END prNuevo,
		CASE WHEN MAX(art_cbios.porVar) IS NULL THEN -1
			ELSE MAX(art_cbios.porVar) END porVar,
		CASE WHEN DATEDIFF(NOW(), MAX(art_cbios.fecha)) IS NULL THEN -1
			ELSE DATEDIFF(NOW(), MAX(art_cbios.fecha)) END cantDias
	FROM
		articulos
			LEFT OUTER JOIN art_cbios
				ON art_cbios.idArticulo = articulos.idArticulo
			INNER JOIN _artcbios
				ON _artcbios.maxIdArtCbios = art_cbios.idArtCbios
	WHERE
		(CASE WHEN pAgrupadoPor = 'MRC' THEN articulos.idMarca = pId
			ELSE articulos.idProv = pId END) AND
        articulos.fecBaja IS NULL
	GROUP BY
		articulos.idArticulo
	ORDER BY
		articulos.codArt ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cpa_getIndicadorGeneral` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cpa_getIndicadorGeneral`(
	pAgrupadoPor VARCHAR(3)
)
BEGIN
	IF pAgrupadoPor = 'PRV' THEN
		SELECT
			proveedor.idProv AS id,
			proveedor.razSoc AS descripcio,
			CASE WHEN MAX(art_cbios.fecha) IS NULL THEN 'NUNCA'
				ELSE MAX(art_cbios.fecha) END ultimaAct,
			CASE WHEN DATEDIFF(NOW(), MAX(art_cbios.fecha)) IS NULL THEN -1
				ELSE DATEDIFF(NOW(), MAX(art_cbios.fecha)) END cantDias,
			CASE WHEN COUNT(*) IS NULL THEN -1
				ELSE COUNT(*) END cantArticulos,
			CASE WHEN AVG(art_cbios.porVar) IS NULL THEN -1
				ELSE ROUND(AVG(art_cbios.porVar), 2) END promedioVar
		FROM
			proveedor
				INNER JOIN articulos ON articulos.idProv = proveedor.idProv
				LEFT OUTER JOIN art_cbios ON art_cbios.idArticulo = articulos.idArticulo
		GROUP BY
			proveedor.idProv
		ORDER BY
			proveedor.razSoc ASC;
	ELSE
		SELECT
			marcas.idMarca AS id,
			marcas.descripcio AS descripcio,
			CASE WHEN MAX(art_cbios.fecha) IS NULL THEN 'NUNCA'
				ELSE MAX(art_cbios.fecha) END ultimaAct,
			CASE WHEN DATEDIFF(NOW(), MAX(art_cbios.fecha)) IS NULL THEN -1
				ELSE DATEDIFF(NOW(), MAX(art_cbios.fecha)) END cantDias,
			CASE WHEN COUNT(*) IS NULL THEN -1
				ELSE COUNT(*) END cantArticulos,
			CASE WHEN AVG(art_cbios.porVar) IS NULL THEN -1
				ELSE ROUND(AVG(art_cbios.porVar), 2) END promedioVar
		FROM
			marcas
				INNER JOIN articulos ON articulos.idMarca = marcas.idMarca
				LEFT OUTER JOIN art_cbios ON art_cbios.idArticulo = articulos.idArticulo
		GROUP BY
			marcas.idMarca
		ORDER BY
			marcas.descripcio ASC;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `equiv_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `equiv_eliminar`(pIdArticulo int)
BEGIN
	DECLARE vEquiv int;
	DECLARE vMensaje text;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS result;
	END;
	SELECT
		CASE WHEN MIN(equiv) > 0 THEN -1
			ELSE MIN(equiv) - 1 END INTO vEquiv
	FROM articulos;
	UPDATE articulos
	SET articulos.equiv = vEquiv
	WHERE articulos.idArticulo = pIdArticulo;
	SELECT 'OK' AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `equiv_grabar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `equiv_grabar`(
	pIdArticulo_A int,
	pIdArticulo_B int,
	pEsNuevo bit)
BEGIN
	DECLARE vIdArticuloAct int;
	DECLARE vEquiv int;
	DECLARE vMensaje text;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS result;
	END;
	IF pEsNuevo = 1 THEN
		IF equiv_tieneEquiv(pIdArticulo_B) = 1 THEN
			SELECT articulos.equiv into vEquiv
			FROM articulos
			WHERE articulos.idArticulo = pIdArticulo_B;
			SET vIdArticuloAct = pIdArticulo_A;
		ELSE
			SELECT articulos.equiv INTO vEquiv
			FROM articulos
			WHERE articulos.idArticulo = pIdArticulo_A;
			SET vIdArticuloAct = pIdArticulo_B;
		END IF;

		UPDATE articulos
		SET articulos.equiv = vEquiv
		WHERE articulos.idArticulo = vIdArticuloAct;
	END IF;
	SELECT 'OK' AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `equiv_leer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `equiv_leer`(pIdArticulo int)
BEGIN
	DECLARE vEquiv int;
	SELECT articulos.equiv INTO vEquiv
	FROM articulos
	WHERE articulos.idArticulo = pIdArticulo;

	SELECT
		idArticulo,
		codArt, descripcio,
		0 AS esNuevo
	FROM articulos
	WHERE articulos.equiv = vEquiv
		AND articulos.idArticulo <> pIdArticulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `faltantes_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `faltantes_delete`( _idVentasC int )
begin
    delete from faltantes
    where idVentasC = _idVentasC
	and fecBaja is null;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `faltantes_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `faltantes_insert`(
	_idArticulo int,
    _idCliente int,
    _idVentasC int,
    _codArt varchar(20),
    _uniCpr double,
    _cantidad double,
    _procesado bit,
    _idOcCab int,
    _usuAlta varchar(5),
    _idHostAlta varchar(50))
begin
    declare _proxID int;
    
    
    delete 
    from 
		faltantes 
	where 
		idArticulo = _idArticulo and
        idCliente = _idCliente;
    
    
    set _proxID = (
	select
		case when max(idFaltante) is null then 1
		else max(idFaltante) + 1 end
	from 
		faltantes);
    insert into faltantes (
		idFaltante,
		idArticulo,
		idCliente,
		idVentasC,
		codArt,
		uniCpr,
		cantidad,
		procesado,
		idOcCab,
		usuAlta,
		fecAlta,
		idHostAlta)
	values (
		_proxID,
		_idArticulo,
		_idCliente,
		_idVentasC,
		_codArt,
		_uniCpr,
		_cantidad,
		_procesado,
		_idOcCab,
		_usuAlta,
		current_timestamp,
		_idHostAlta);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `familias_getAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `familias_getAll`()
BEGIN
	SELECT *
	FROM familias
	WHERE familias.`fecBaja` IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `familias_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `familias_getById`(_id INT)
BEGIN
	SELECT *
	FROM familias
	WHERE familias.`idFamilia` = _id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `globalcfg_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `globalcfg_insert`(
			xkey varchar(10),
		    xtype varchar(1),
		    xvalue varchar(255),
		    xreemplazar bit
		)
BEGIN
		    DECLARE proximoId int;
			DECLARE existeParametro bit;
		    SET existeParametro = (
		        SELECT
		            CASE WHEN count(*) > 0 THEN 1 ELSE 0 END
		        FROM
		            global_cfg
		        WHERE 
		            global_cfg.cfg_key = xkey
		    );

		    IF NOT existeParametro THEN
		        SET proximoId = (
		            SELECT
		                MAX(idGlobalCF) + 1
		            FROM
		                global_cfg
		        );

		        INSERT INTO global_cfg (
		            idGlobalCF,
		            cfg_key,
		            cfg_Type,
		            cfg_Value,
		            usuAlta,
		            fecAlta,
		            idHostAlta
		        ) VALUES (
		            proximoId,
		            xkey,
		            xtype,
		            xvalue,
		            'ROOT',
		            current_timestamp,
		            'LINFOW GESTION # Upgrade'
		        );
		    ELSE
		    	-- Solo reemplazo el valor si le indico que lo tiene que hacer.
		    	IF xreemplazar = 1 THEN
		    		UPDATE
		    			global_cfg
		    		SET
		    			cfg_value = xvalue,
		    			usuModi = 'DESA',
		    			fecModi = current_timestamp,
		    			idHostModi = 'ESCRITORIO # Leonardo'
		    		WHERE
		    			cfg_key = xkey;
		    	END IF;
		    END IF;
		END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lfwcat_getArticulos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `lfwcat_getArticulos`()
BEGIN
	SELECT
		articulos.idArticulo AS idArticuloLG,
		marcas.idmarca AS idMarcaLG,
		familias.idFamilia AS idRubroLG,
		subfam.idSubFam AS idSubrubroLG,
		articulos.codArt,
		articulos.descripcio AS descripcion,
		articulos.prventaMax AS precio_lista,
		articulos.equiv AS equivalencia,
		articulos.habilitado AS habilitado,
		0 AS eliminado,
		articulos.alicIVA,
		marcas.descripcio AS marca,
		familias.descripcio AS rubro,
		subfam.descripcio AS subrubro,
		observ AS descripcion_larga,
		COALESCE(unidades.envase, 1) AS 'envase'
	FROM articulos
		INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
		INNER JOIN familias ON familias.idFamilia = articulos.idFamilia
		INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam
		LEFT JOIN (
			SELECT
				codiart.idArticulo,
				MIN(cantiDesp) AS envase
			FROM
				codiart
			GROUP BY
				codiart.idCodArt) unidades ON unidades.idArticulo = articulos.idArticulo
	WHERE
		articulos.fecBaja IS NULL AND
		articulos.codArt NOT LIKE '%ARX';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lfwcat_getClientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `lfwcat_getClientes`()
BEGIN
	UPDATE
		clientes
	SET
		usuWeb = idCliente,
        claveWeb = concat(right(nrocuit, 3), left(razSoc, 3), idCliente)
	WHERE
		claveWeb = '' OR claveWeb IS NULL;

	SELECT
		clientes.idCliente AS idClienteLG,
		clientes.razSoc,
		clientes.eMail AS mail,
		clientes.claveWeb AS password,
		clientes.desc1 AS bonif1,
		clientes.desc2 AS bonif2,
		clientes.desc3 AS bonif3,
		clientes.desc4 AS bonif4,
		clientes.habilitado AS habilitado,
		0 AS eliminado,
		clientes.recargo AS recargo
	FROM
		clientes
	WHERE
		clientes.fecBaja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lfwcat_getOfertas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `lfwcat_getOfertas`()
begin
	select
    idOferta as idOfertaLG,
		idArticulo as idArticuloLG,
		fecVigDD as vigencia_desde,
		fecVigHH as vigencia_hasta,
		codArt,
		porOfert,
		impOfert,
		1 as habilitado,
		case when fecBaja is null then 0 else 1 end eliminado
	from
		ofertas
	where
		cast(ofertas.fecVigDD as date) <= current_date()
		and cast(ofertas.fecVigHH as date) >= current_date();
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `localidad_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `localidad_getById`( _idLocalid int )
begin
	select *
    from localidad
    where idLocalid = _idLocalid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_transacciones_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `log_transacciones_insert`(
	IN `xcomponente` varchar(50),
	IN `xmodulo` varchar(50),
	IN `xdescripcio` varchar(100),
	IN `xvaloresref` text,
	IN `xlinea_cod` int,
	IN `xsql_stmt` text,
	IN `xerror_msg` text
)
begin
	declare v_message text;
    declare exit handler for sqlexception
    begin
		rollback;
        get diagnostics condition 1 v_message = message_text;
        select v_message as result;
    end;
    start transaction;
    insert into log_transacciones (
		componente,
        modulo,
        descripcio,
        valoresref,
        linea_cod,
        sql_stmt,
        error_msg)
	values (
		xcomponente,
        xmodulo,
        xdescripcio,
        xvaloresref,
        xlinea_cod,
        xsql_stmt,
        xerror_msg    
    );
    commit;
    select 'OK' as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `marcas_getAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `marcas_getAll`()
BEGIN
	SELECT *
	FROM marcas
	WHERE marcas.`fecBaja` IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `marcas_getByArticulo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `marcas_getByArticulo`(pIdArticulo int)
BEGIN
	SELECT marcas_v.*
	FROM marcas_v
		INNER JOIN art_mrv ON marcas_v.idMarcaV = art_mrv.idMarcaV
	WHERE art_mrv.idArticulo = pIdArticulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `marcas_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `marcas_getById`(_id INT)
BEGIN
	SELECT *
	FROM marcas
	WHERE idMarca = _id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `num_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `num_actualizar`(
	p_idNum int,
	p_numActual int
)
BEGIN
	DECLARE vMensaje text;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;
	START TRANSACTION;
	UPDATE
		numerador
	SET
		numerador.numActual = p_numActual
	WHERE
		numerador.idNum = p_idNum;
	COMMIT;
	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `num_getNroCbte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `num_getNroCbte`(
	p_cbte varchar(3),
	p_ptoVta int,
	p_hostName varchar(50)
)
BEGIN
	DECLARE v_idNum int;
	DECLARE v_nroActual int;
	DECLARE v_rtoPrinter varchar(100);
	DECLARE v_cantCpias int;
	DECLARE v_hayNumerador bit;	
	DECLARE v_hayImpresora bit;
    DECLARE v_usaTicket bit;

	SET v_rtoPrinter = '';
	SET v_cantCpias = 0;
	SET v_idNum = 0;
	SET v_nroActual = 0;
	SET v_hayImpresora = 0;
	SET v_hayNumerador = 0;
    SET v_usaTicket = 0;

	SELECT 
		CASE 
			WHEN COUNT(*) > 0 THEN 1
			ELSE 0 END INTO v_hayNumerador
	FROM
		numerador n
	WHERE
		n.cbte = p_cbte AND
		n.ptoVta = p_ptoVta;

	IF v_hayNumerador = 1 THEN
		SELECT
			n.idNum,
			n.numActual + 1
		INTO
			v_idNum,
			v_nroActual
		FROM
			numerador n
		WHERE
			n.cbte = p_cbte AND
			n.ptoVta = p_ptoVta;
		
		SELECT
			CASE
				WHEN COUNT(*) > 0 THEN 1
				ELSE 0 END INTO v_hayImpresora
		FROM
			impresoras i
		WHERE
			i.hostName = p_hostName AND		
			i.idNum = v_idNum;
		
		IF v_hayImpresora = 1 THEN
			SELECT
				impresora,
				copias,
                usa_ticket
			INTO
				v_rtoPrinter,
				v_cantCpias,
                v_usaTicket
			FROM
				impresoras i
			WHERE
				i.hostName = p_hostName AND		
				i.idNum = v_idNum;
		END IF;
	END IF;
	SELECT
		v_idNum AS idNum,
		v_nroActual AS numActual,
		v_rtoPrinter AS impresora,
		v_cantCpias AS copias,
		v_hayNumerador AS hayNumerador,
		v_hayImpresora AS hayImpresora,
        v_usaTicket AS usa_ticket;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_Ranking_BYC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `obtener_Ranking_BYC`()
BEGIN
	DECLARE total  DECIMAL(10, 2);
	
	SET total = calcular_total_universo();
	SELECT
		codArt,
		cantidad,
		(cantidad * 100) / total AS porcentaje
	FROM temp_universo
	GROUP BY codArt
	ORDER BY (cantidad * 100) / total DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ofertas_getVigenteByArt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ofertas_getVigenteByArt`(_idArticulo int)
begin
	select *
    from ofertas
    where ofertas.idArticulo = _idArticulo
		and ofertas.fecVigDD <= current_timestamp
        and ofertas.fecVigHH >= current_timestamp;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ordpag_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ordpag_delete`(
	xidProv int,
	xidOrdPagC int,
	xusuario varchar(5),
	xhost varchar(50))
BEGIN
	DECLARE vMensaje TEXT;
	DECLARE vNumeroOP int;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', vMensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	/* Paso 1: Recupero el nÃºmero de orden de pago */
	SELECT
		nroOP
	INTO
		vNumeroOP
	FROM
		ordpag_c
	WHERE
		ordpag_c.idOrdPagC = xidOrdPagC AND
		ordpag_c.idProv = xidProv;
		
	/* Paso 2: Doy de baja la orden en la cuenta corriente de proveedores */
	UPDATE
		cc_prov
	SET
		cc_prov.usuBaja = xusuario,
		cc_prov.fecBaja = current_timestamp,
		cc_prov.idHostBaja = xhost
	WHERE
		cc_prov.cbte = 'OP' AND
		cc_prov.nroCbte = vNumeroOP;
		
	/* Paso 3: Doy de baja la cabecera de la orden de pago  */
	UPDATE
		ordpag_c
	SET
		ordpag_c.usuBaja = xusuario,
		ordpag_c.fecBaja = current_timestamp,
		ordpag_c.idHostBaja = xhost
	WHERE
		ordpag_c.idProv = xidProv AND
		ordpag_c.idOrdPagC = xidOrdPagC;

	/* Pago 4: Vuelvo a habilitar los cheques */
	UPDATE
		cheques
			INNER JOIN ordpag_d ON ordpag_d.idCheque = cheques.idCheque
	SET
		cheques.estado = 'D'
	WHERE
		ordpag_d.idOrdPagC = xidOrdPagC;

	COMMIT;
	SELECT 1 AS 'result', 'La orden se eliminÃ³ satisfactoriamente' AS 'mensaje';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ordtrabajo_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ordtrabajo_delete`(
	xid int, xusuario varchar(5), xhost varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 @mensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', @mensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	
	UPDATE
		ordtrabajo
	SET
		ordtrabajo.usuBaja = xusuario,
		ordtrabajo.fecBaja = CURRENT_TIMESTAMP,
		ordtrabajo.idHostBaja = xhost
	WHERE
		ordtrabajo.id = xid;
	
	COMMIT;
	SELECT 1 AS 'result', 'La orden de trabajo se eliminÃ³ con Ã©xito' AS 'mensaje';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ordtrabajo_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ordtrabajo_insert`(
	xidcliente int, xfecha datetime, xcantidad decimal(10, 2),
	xdetalle VARCHAR(60), xprecio DECIMAL(20, 2), xfacturado bit,
	xusuario varchar(5), xHost varchar(50)
)
BEGIN
	DECLARE vIdOrden int;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 @mensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', @mensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	
	INSERT INTO ordtrabajo (
		idCliente, fecha, cantidad, detalle,
		precio, facturado, usuAlta, fecAlta, idHostAlta) 
	VALUES (
		xidcliente, CAST(xfecha AS DATE), xcantidad, xdetalle,
		xprecio, xfacturado, xusuario, CURRENT_TIMESTAMP, xHost);
	
	COMMIT;
	
	/* Obtengo el Ãºltimo id generado */
	SELECT
		CASE WHEN MAX(id) IS NULL THEN 1 ELSE MAX(id) END
	INTO
		vIdOrden
	FROM
		ordtrabajo;
		
	SELECT vIdOrden AS 'result', 'El trabajo fue grabada con Ã©xito' as 'mensaje';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ordtrabajo_marcar_facturado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ordtrabajo_marcar_facturado`(x_id INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 @mensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', @mensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	UPDATE
		ordtrabajo
	SET
		ordtrabajo.facturado = 1
	WHERE
		id = x_id;
		
	COMMIT;
	SELECT 1 AS 'result', 'El trabajo ya fue facturado' as 'mensaje';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ordtrabajo_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ordtrabajo_update`(
	x_id INT, xidcliente INT, xfecha DATETIME, xcantidad DECIMAL(10, 2),
	xdetalle VARCHAR(60), xprecio DECIMAL(20, 2), xfacturado bit,
	xusuario varchar(5), xHost varchar(50)
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 @mensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', @mensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	UPDATE
		ordtrabajo
	SET
		ordtrabajo.idCliente = xidcliente,
		ordtrabajo.fecha = CAST(xfecha AS DATE),
		ordtrabajo.cantidad = xcantidad,
		ordtrabajo.detalle = xdetalle,
		ordtrabajo.precio = xprecio,
		ordtrabajo.facturado = xfacturado,
		ordtrabajo.usuModi = xusuario,
		ordtrabajo.fecModi = CURRENT_TIMESTAMP,
		ordtrabajo.idHostModi = xHost
	WHERE
		id = x_id;
		
	COMMIT;
	SELECT 1 AS 'result', 'El trabajo fue grabada con Ã©xito' as 'mensaje';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pedext_eliminarPed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `pedext_eliminarPed`(pIdPedCab int)
begin
	declare mensaje text;
	declare exit handler for sqlexception
    begin
		rollback;
        get diagnostics condition 1 mensaje = message_text;
        select mensaje as result;
    end;
    start transaction;
	delete from pedext where pedext.idPedCab = pIdPedCab;
    commit;
    select 'OK' as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pedext_getDescargados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `pedext_getDescargados`()
begin
	select 
		pedext.idPedCab,
		pedext.idCliente,
		pedext.fecEmis,
		clientes.razSoc   
	from pedext
		inner join clientes on clientes.idCliente = pedext.idCliente
	where procesado = 0
	group by idPedCab;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pedext_getPedByCab` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `pedext_getPedByCab`(pIdPedCab int)
BEGIN
	SELECT pedext.idPedExt,
		pedext.idArticulo,
		pedext.codArt,
        MAX(pedext.cantidad) AS cantidad
	FROM pedext
    WHERE pedext.procesado = 0
		and pedext.idPedCab = pIdPedCab
    GROUP BY
        pedext.idArticulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pedext_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `pedext_insert`(
	_idPedCab int,
    _idCliente int,
    _tipoSist int,
    _idArticulo int,
    _fecEmis datetime,
    _codArt varchar(20),
    _cantidad double,
    _observ text)
BEGIN
    IF _idArticulo <> 0 THEN
        INSERT INTO pedext (
            idPedCab, idCliente, tipoSist, idArticulo, 
            fecEmis, codArt, cantidad, observ, procesado)
        VALUES (
            _idPedCab, _idCliente, _tipoSist, _idArticulo,
            _fecEmis, _codArt, _cantidad, _observ, 0);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pedonline_verificar_unidvta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `pedonline_verificar_unidvta`(
	xcodart varchar(20)
)
BEGIN
	SELECT
		COUNT(*) AS 'cantDuplicado'
	INTO
		@cantDuplicado
	FROM
		articulos
	WHERE
		articulos.codArt = xcodart AND
		articulos.fecBaja IS NULL AND
		articulos.habilitado = 1;
	
	IF @cantDuplicado > 1 THEN
		SELECT 
			CONCAT('El articulo: ', xcodart, ' se encuentra repetido ', @cantDuplicado, ' veces. Corregir esta situacion desde el ABM de articulos.') AS 'mensaje', 
			-1 AS 'cantiDesp';
	ELSE
		SELECT
			idArticulo
		INTO
			@idArticulo
		FROM
			articulos
		WHERE
			articulos.codArt = xcodart AND
			articulos.fecBaja IS NULL AND
			articulos.habilitado = 1;
			
		SELECT
			'OK' AS 'mensaje',
			MIN(cantiDesp) AS 'cantiDesp'
		FROM
			codiart
		WHERE
			codiart.idArticulo = @idArticulo AND
			codiart.circuito IN ('CV', 'V')
		GROUP BY
			idArticulo;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_artic_getByCab` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_artic_getByCab`(
    xidpromo_c int
)
BEGIN
    SELECT
        promo_artic.idpromo_c,
        promo_artic.idArticulo,
        articulos.codArt,
        articulos.descripcio
    FROM
        promo_artic
            INNER JOIN articulos ON articulos.idArticulo = promo_artic.idArticulo
    WHERE
        promo_artic.idpromo_c = xidpromo_c;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_cab_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_cab_getById`(
    xidpromo_cab int
)
BEGIN
    SELECT
        *
    FROM
        promo_cab
    WHERE
        promo_cab.idpromo_c = xidpromo_cab;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_calcular_importes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_calcular_importes`()
BEGIN
    DECLARE v_mensaje varchar(255);
	
    DECLARE EXIT handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 v_mensaje = MESSAGE_TEXT;
        SELECT v_mensaje AS 'result';
    END;

    START TRANSACTION;
    
    DELETE FROM promo_clim;

    ALTER TABLE promo_clim AUTO_INCREMENT = 0;    

    DELETE FROM promo_cli;

    ALTER TABLE promo_cli AUTO_INCREMENT = 0;

    INSERT INTO promo_cli (
        idpromo_c,
        idCliente,
        idVentasC,
        cbte,
        cuenta,
        imp_tope,
        total_vend)
            SELECT
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte,
                1 AS cuenta,
                prc.imp_tope,
                sum(det.subTotal) as total_vend
            FROM
                ventasdet det
                    INNER JOIN ventascab cab 
                        ON cab.idVentasC = det.idVentasC
                    INNER JOIN articulos art 
                        ON art.idArticulo = det.idArticulo
                    INNER JOIN promo_marcas prm
                        ON prm.idmarca = art.idmarca
                    INNER JOIN promo_cab prc
                        ON prc.idpromo_c = prm.idpromo_c
            WHERE
                cast(cab.fecEmision AS DATE) between cast(prc.vigencia_d AS DATE) AND cast(prc.vigencia_h AS DATE) AND
                cab.cbte IN ('FC', 'NC') AND
                prc.fecBaja IS NULL
            GROUP BY
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte;       
    
    INSERT INTO promo_cli (
        idpromo_c,
        idCliente,
        idVentasC,
        cbte,
        cuenta,
        imp_tope,
        total_vend)
            SELECT
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte,            
                2 AS cuenta,
                prc.imp_tope,
                round(sum(det.subTotal), 2) as total_vend
            FROM
                linfowgst_mgc2.ventasdet det
                    INNER JOIN linfowgst_mgc2.ventascab cab
                        ON cab.idVentasC = det.idVentasC
                    INNER JOIN articulos art 
                        ON art.idArticulo = det.idArticulo
                    INNER JOIN promo_marcas prm
                        ON prm.idmarca = art.idmarca
                    INNER JOIN promo_cab prc
                        ON prc.idpromo_c = prm.idpromo_c
            WHERE
                cast(cab.fecEmision AS DATE) between cast(prc.vigencia_d AS DATE) AND cast(prc.vigencia_h AS DATE) AND
                cab.cbte IN ('FC', 'NC') AND
                prc.fecBaja IS NULL
            GROUP BY
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte;
    
    UPDATE
        promo_cli
    SET
        total_vend = total_vend * -1
    WHERE
        cbte = 'NC' AND
        total_vend > 0;
    
    DROP TABLE IF EXISTS tmp_promo_cli_merch;

    CREATE TEMPORARY TABLE tmp_promo_cli_merch
        SELECT
            promo_cli.idpromo_c,
            promo_cli.id AS idpromo_cli,
            promo_cab.nombre,
            promo_cli.idCliente,
            clientes.razSoc,
            promo_cli.imp_tope,
            sum(promo_cli.total_vend) as total_vend,
            promo_cli.imp_tope - sum(promo_cli.total_vend) as faltan
        FROM
            promo_cli
                INNER JOIN clientes 
                    ON clientes.idCliente = promo_cli.idCliente
                INNER JOIN promo_cab
                    ON promo_cab.idpromo_c = promo_cli.idpromo_c
         WHERE
   			cast(CURRENT_TIMESTAMP() AS DATE) <= cast(promo_cab.vigencia_h AS DATE)
        GROUP BY
            promo_cli.idpromo_c,
            promo_cli.idCliente
        ORDER BY
            sum(promo_cli.total_vend) ASC;

    INSERT INTO promo_clim (
            idpromocli,
            idCliente,
            idArticulo,
            codArt,
            descripcio,
            cantidad
        )
        SELECT 
            tmp_promo_cli_merch.idpromo_cli,
            tmp_promo_cli_merch.idCliente,
            articulos.idArticulo,
            articulos.codArt,
            articulos.descripcio,
            promo_calcular_cant_merchandisign(tmp_promo_cli_merch.imp_tope, tmp_promo_cli_merch.total_vend) AS cantidad
        FROM 
            promo_artic
                INNER JOIN articulos ON articulos.idArticulo = promo_artic.idArticulo
                INNER JOIN tmp_promo_cli_merch ON tmp_promo_cli_merch.idpromo_c = promo_artic.idpromo_c
                INNER JOIN promo_cli ON promo_cli.id = tmp_promo_cli_merch.idpromo_cli;

    COMMIT;

    SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_create_temps` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_create_temps`()
BEGIN
    
    DROP TABLE IF EXISTS tmp_promo_marcas;
    DROP TABLE IF EXISTS tmp_promo_artic;

    
    CREATE TEMPORARY TABLE tmp_promo_marcas (
        idpromo_c int not null default 0,
        idmarca int not null,
        primary key (idpromo_c, idmarca)
    );

    CREATE TEMPORARY TABLE tmp_promo_artic (
        idpromo_c int not null default 0,
        idArticulo int not null,
        primary key (idpromo_c, idArticulo)
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_delete`(
    xidpromo_cab int,
    xusuarioActual varchar(5),
    xhost varchar(50)
)
BEGIN
    DECLARE v_mensaje varchar(255);
    DECLARE EXIT handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 v_mensaje = MESSAGE_TEXT;
        SELECT v_mensaje AS 'result';
    END;

    START TRANSACTION;

    UPDATE
        promo_cab
    SET
        promo_cab.usuBaja = xusuarioActual,
        promo_cab.fecBaja = current_timestamp,
        promo_cab.idHostBaja = xhost
    WHERE
        promo_cab.idpromo_cab = xidpromo_cab;

    COMMIT;
    SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_getInforme` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_getInforme`()
BEGIN
    

    SELECT
        promo_cli.idpromo_c,
        promo_cab.nombre,
        promo_cli.idCliente,
        clientes.razSoc,
        promo_cli.imp_tope,
        sum(promo_cli.total_vend) as total_vend,
        promo_calcular_faltan(promo_cli.imp_tope, sum(promo_cli.total_vend)) as faltan
    FROM
        promo_cli
            INNER JOIN clientes 
                ON clientes.idCliente = promo_cli.idCliente
            INNER JOIN promo_cab
                ON promo_cab.idpromo_c = promo_cli.idpromo_c
    GROUP BY
        promo_cli.idpromo_c,
        promo_cli.idCliente
    ORDER BY
        sum(promo_cli.total_vend) DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_getInformeMerchandising` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_getInformeMerchandising`(
    xidcliente int
)
BEGIN
    

    SELECT 
        * 
    FROM 
        promo_clim 
    WHERE 
        promo_clim.idCliente = xidcliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_insert`(
    xnombre varchar(60),
    xvigencia_d datetime, 
    xvigencia_h datetime, 
    ximp_tope decimal(20,2),
    xusuarioActual varchar(5),
    xhost varchar(50)
)
BEGIN
    DECLARE v_mensaje varchar(255);
    DECLARE v_idpromo_c int;

    DECLARE EXIT handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 v_mensaje = MESSAGE_TEXT;
        SELECT v_mensaje AS 'result';
    END;

    START TRANSACTION;

    
    INSERT INTO promo_cab (
        nombre,
        vigencia_d,
        vigencia_h,
        imp_tope,
        usuAlta,
        fecAlta,
        idHostAlta
    ) VALUES (
        xnombre,
        xvigencia_d,
        xvigencia_h,
        ximp_tope,
        xusuarioActual,
        current_timestamp,
        xhost
    );

    
    SET v_idpromo_c = (
        SELECT
            MAX(idpromo_c)
        FROM
            promo_cab);

    
    UPDATE
        tmp_promo_marcas
    SET
        tmp_promo_marcas.idpromo_c = v_idpromo_c;
    
    
    UPDATE
        tmp_promo_artic
    SET
        tmp_promo_artic.idpromo_c = v_idpromo_c;

    
    INSERT INTO promo_marcas
        SELECT
            idpromo_c,
            idmarca
        FROM
            tmp_promo_marcas;

    
    INSERT INTO promo_artic
        SELECT
            idpromo_c,
            idArticulo
        FROM
            tmp_promo_artic;

    COMMIT;
    SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_marcas_getByCab` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_marcas_getByCab`(
    xidpromo_cab int
)
BEGIN
    SELECT
        promo_marcas.idpromo_c,
        promo_marcas.idmarca,
        marcas.descripcio
    FROM
        promo_marcas
            INNER JOIN marcas ON marcas.idmarca = promo_marcas.idmarca
    WHERE
        promo_marcas.idpromo_c = xidpromo_cab;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_tempo_artic_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_tempo_artic_insert`(
    xidpromo_c int,
    xidArticulo int
)
BEGIN
    INSERT INTO tmp_promo_artic (
        idpromo_c,
        idArticulo
    ) VALUES (
        xidpromo_c,
        xidArticulo
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_tempo_marcas_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_tempo_marcas_insert`(
    xidpromo_c int,
    xidmarca int
)
BEGIN
    INSERT INTO tmp_promo_marcas (
        idpromo_c,
        idmarca
    ) VALUES (
        xidpromo_c,
        xidmarca
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `promo_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `promo_update`(
    xidpromo_c int,
    xnombre varchar(60),
    xvigencia_d datetime, 
    xvigencia_h datetime, 
    ximp_tope decimal(20,2),
    xusuarioActual varchar(5),
    xhost varchar(50)
)
BEGIN
    DECLARE v_mensaje varchar(255);
    DECLARE EXIT handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 v_mensaje = MESSAGE_TEXT;
        SELECT v_mensaje AS 'result';
    END;

    START TRANSACTION;

    
    UPDATE
        promo_cab
    SET
        promo_cab.nombre = xnombre,
        promo_cab.vigencia_d = xvigencia_d,
        promo_cab.vigencia_h = xvigencia_h,
        promo_cab.imp_tope = ximp_tope,
        promo_cab.usuModi = xusuarioActual,
        promo_cab.fecModi = current_timestamp,
        promo_cab.idHostModi = xhost
    WHERE
        promo_cab.idpromo_c = xidpromo_c;

    
    DELETE 
    FROM 
        promo_marcas
    WHERE
        promo_marcas.idpromo_c = xidpromo_c;

    INSERT INTO promo_marcas
        SELECT
            idpromo_c,
            idmarca
        FROM
            tmp_promo_marcas;
    
    
    DELETE
    FROM
        promo_artic
    WHERE
        promo_artic.idpromo_c = xidpromo_c;

    INSERT INTO promo_artic
        SELECT
            idpromo_c,
            idArticulo
        FROM
            tmp_promo_artic;

    COMMIT;
    SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proveedor_getByCuit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `proveedor_getByCuit`(_nroCUIT varchar(20))
begin
    select *
    from proveedor
    where nroCUIT = _nroCUIT;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proveedor_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `proveedor_insert`(
	_razSoc varchar(60),
	_nomFant varchar(60),
	_direccion varchar(60),
	_idLocalid int,
	_idCondPago int,
	_idSitIVA int,
	_nroCUIT varchar(20),
	_telefono varchar(20),
	_fax varchar(20),
	_eMail varchar(60),
	_pagWeb varchar(60),
	_observ text,
	_contacto varchar(60),
	_habilitado bit,
	_tMon varchar(3),
	_cotizac double,
	_idTransp int,
	_usuAlta varchar(5),
	_fecAlta datetime,
	_idHostAlta varchar(50),
	_proc_name varchar(20),
	_idTipoDoc int)
begin
	declare proxId int;
    	set proxId = (select
		case when max(idProv) is null then 1
	        else max(idProv) + 1 end
        from proveedor);

	insert into proveedor (
		idprov, razSoc, nomFant, direccion, idLocalid, idCondPago, idSitIVA,
		nroCUIT, telefono, fax, eMail, pagWeb, observ, contacto,
		habilitado, tMon, cotizac, idTransp, usuAlta, fecAlta,
		idHostAlta, proc_name, idTipoDoc)
	values 	(
		proxId, _razSoc, _nomFant, _direccion, _idLocalid, _idCondPago, _idSitIVA,
		_nroCUIT, _telefono, _fax, _eMail, _pagWeb, _observ, _contacto,
		_habilitado, _tMon, _cotizac, _idTransp, _usuAlta, _fecAlta,
		_idHostAlta, _proc_name, _idTipoDoc);
	select proxId AS idprov;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `provincias_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `provincias_getById`(_id int)
begin
	select *
    from provincias
    where provincias.idProvin = _id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ranking_Articulos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ranking_Articulos`(
	p_SeparoPorMes INT,
	p_fechaInicio DATE,
	p_fechaFin DATE
)
BEGIN
    IF p_SeparoPorMes = 1 THEN
        -- Consulta con separaciÃ³n por mes
        SELECT  
            articulos.idArticulo AS idarticulo,
            articulos.codart AS codart,
            MAX(articulos.descripcio) AS descripcio,
            ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.cantidad * -1 ELSE ventasdet.cantidad END), 2) AS cantidad,
            ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2) AS importe,
            YEAR(ventascab.fecEmision) AS anio,
            MONTH(ventascab.fecEmision) AS mes
        FROM ventascab   
            INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC     
            INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo 
        WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
            AND ventascab.fecEmision BETWEEN p_fechaInicio AND p_fechaFin
        GROUP BY articulos.idArticulo, articulos.codart, YEAR(ventascab.fecEmision), MONTH(ventascab.fecEmision)
        ORDER BY articulos.idarticulo, YEAR(ventascab.fecEmision), MONTH(ventascab.fecEmision);
    ELSE
        -- Consulta sin separaciÃ³n mensual
        SELECT  
            articulos.idArticulo AS idarticulo,
            articulos.codart AS codart,
            MAX(articulos.descripcio) AS descripcio,
            ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.cantidad * -1 ELSE ventasdet.cantidad END), 2) AS cantidad,
            ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2) AS importe
        FROM ventascab   
            INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC     
            INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
        WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
            AND ventascab.fecEmision BETWEEN p_fechaInicio AND p_fechaFin
        GROUP BY articulos.idArticulo, articulos.codart
        ORDER BY cantidad DESC;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ranking_ventas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ranking_ventas`(
    IN p_tipo_ranking VARCHAR(20),  -- 'clientes', 'proveedores', 'marcas', 'subfamilias', 'articulos'
    IN p_detalle_mes INT,           -- 1 = Con detalle por mes, 0 = Sin detalle
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
	IN p_importe_con_iva INT		-- 1 = Tomar el importe con IVA incluÃ­do, 0 = Tomar el importe neto sin IVA
)
BEGIN
	DECLARE vIdClienteCF INT;
	
	SELECT
		CAST(global_cfg.cfg_value AS INT)
	INTO
		vIdClienteCF
	FROM
		global_cfg
	WHERE
		global_cfg.cfg_key = 'CLI_CF';
	
    /* Ranking de clientes */
    IF p_tipo_ranking = 'clientes' THEN
        
        IF p_detalle_mes = 1 THEN
            /* Con detalle mensual */
            SELECT 
                clientes.idCliente AS codigo,
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes,
                MAX(clientes.razSoc) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.subTotal * -1 ELSE ventasdet.subTotal END), 2) 
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente
            WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
				AND ventascab.idCliente != vIdClienteCF
            GROUP BY 
                clientes.idCliente,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                clientes.idCliente,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            /* Sin detalle mensual */
            SELECT 
                clientes.idCliente AS codigo,
                MAX(clientes.razSoc) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.subTotal * -1 ELSE ventasdet.subTotal END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente
            WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
				AND ventascab.idCliente != vIdClienteCF
            GROUP BY clientes.idCliente
            ORDER BY importe DESC;
        END IF;
    
	/* Ranking de proveedores */
    ELSEIF p_tipo_ranking = 'proveedores' THEN
        
        IF p_detalle_mes = 1 THEN
            /* Con detalle mensual */
            SELECT 
                proveedor.idProv AS codigo,
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes,
                MAX(proveedor.razSoc) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN proveedor ON proveedor.idProv = articulos.idProv
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                proveedor.idProv,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                proveedor.idProv,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            /* Sin detalle mensual */
            SELECT 
                proveedor.idProv AS codigo,
                MAX(proveedor.razSoc) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN proveedor ON proveedor.idProv = articulos.idProv
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY proveedor.idProv
            ORDER BY importe DESC;
        END IF;
    
    /* Ranking de Marcas */
    ELSEIF p_tipo_ranking = 'marcas' THEN
        
        IF p_detalle_mes = 1 THEN
            /* Con detalle mensual */
            SELECT 
                marcas.idmarca AS codigo,
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes,
                MAX(marcas.descripcio) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                marcas.idmarca,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                marcas.idmarca,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            /* Sin detalle mensual */
            SELECT 
                marcas.idmarca AS codigo,
                MAX(marcas.descripcio) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY marcas.idmarca
            ORDER BY importe DESC;
        END IF;
    
    -- ============================================================
    -- RANKING DE SUBFAMILIAS
    -- ============================================================
    ELSEIF p_tipo_ranking = 'subfamilias' THEN
        
        IF p_detalle_mes = 1 THEN
            /* Con detalle mensual */
            SELECT 
                subfam.idSubFam AS codigo,
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes,
                MAX(subfam.descripcio) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                subfam.idSubFam,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                subfam.idSubFam,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            /* Sin detalle mensual */
            SELECT 
                subfam.idSubFam AS codigo,
                MAX(subfam.descripcio) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY subfam.idSubFam
            ORDER BY importe DESC;
        END IF;
    
    /* Ranking de artÃ­culos */
    ELSEIF p_tipo_ranking = 'articulos' THEN
        
        IF p_detalle_mes = 1 THEN
            /* Con detalle mensual */
            SELECT 
                articulos.idArticulo AS idarticulo,
                articulos.codart AS codart,
                MAX(articulos.descripcio) AS descripcio,
                ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.cantidad * -1 ELSE ventasdet.cantidad END), 2) AS cantidad,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.subTotal * -1 ELSE ventasdet.subTotal END), 2)
				END 'importe',
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
            WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                articulos.idArticulo,
                articulos.codart,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                articulos.idArticulo,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            /* Sin detalle mensual */
            SELECT 
                articulos.idArticulo AS idarticulo,
                articulos.codart AS codart,
                MAX(articulos.descripcio) AS descripcio,
                ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.cantidad * -1 ELSE ventasdet.cantidad END), 2) AS cantidad,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.subTotal * -1 ELSE ventasdet.subTotal END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
            WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                articulos.idArticulo,
                articulos.codart
            ORDER BY cantidad DESC;
        END IF;
    
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rccob_c_getIdByCC_Cli` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `rccob_c_getIdByCC_Cli`(
	pIdCC_Cli INT)
BEGIN
	SELECT
		rccob_c.idrccob_c,
		rccob_c.nroRec
	FROM cc_cli 
		INNER JOIN rccob_c ON
				rccob_c.nroRec COLLATE latin1_swedish_ci  = formatear_NroCbte(cc_cli.ptoVta, cc_cli.nroCbte)							COLLATE utf8_general_ci AND
				rccob_c.idCliente = cc_cli.idCliente
	WHERE 
		idcc_cli = pIdCC_Cli
	GROUP BY
		rccob_c.idrccob_c;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rcn_agregar_remito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `rcn_agregar_remito`(
	xid_tiporto int,
	xidCliente int, 
	xnumero varchar(20), 
	xdestino varchar(200), 
	xobservaciones text, 
	xusuario varchar(5), 
	xhostname varchar(50)
)
BEGIN
	DECLARE vMensaje text;
	DECLARE vIdRtoEnt int;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 
			vMensaje = MESSAGE_TEXT;
		
		/* Limpio la tabla temporal */
		DELETE FROM rcn_aux_rtitem WHERE usuario = xusuario AND host = xhostname;
		
		SELECT 'BD_ERROR' AS 'result', vMensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	
	/* Calculo el prÃ³ximo ID. */		
	SELECT COALESCE(MAX(id_rtoent), 0) + 1 INTO vIdRtoEnt FROM rcn_remito;
		
	/* Creo el registro en la cabecera de remito*/
	INSERT INTO rcn_remito (
		id_rtoent, id_tiporto, idCliente, numero,
		destino, observaciones, usuAlta, fecAlta,
		idHostAlta)
	VALUES (
		vIdRtoEnt, xid_tiporto, xidCliente, xnumero,
		xdestino, xobservaciones, xusuario, current_timestamp,
		xhostname);
					
	/* Agrego el detalle en la ficha */
	INSERT INTO rcn_ficha (
		id_estado, id_rtoent, idmarca, medida, nro_serie, trabajo,
		usuAlta, fecAlta, idHostAlta)
			SELECT
				1 AS 'id_estado', vIdRtoEnt, idmarca, medida, nro_serie, trabajo,
				usuario, current_timestamp, host
			FROM
				rcn_aux_rtitem
			WHERE
				usuario = xusuario AND
				host = xhostname;
			
	COMMIT;
	
	/* Limpio la tabla temporal */
	DELETE FROM rcn_aux_rtitem WHERE usuario = xusuario AND host = xhostname;
	
	SELECT 'OK' AS 'result', 'El remito se grabÃ³ satisfactoriamente' AS 'mensaje';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rcn_generar_remito_salida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `rcn_generar_remito_salida`(
	xidCliente int,
	xid_rtoent int,
	xobservaciones varchar(200),
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	DECLARE vProxID int;
	DECLARE vNumeroRemito int;
	DECLARE vDestino varchar(200);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
			@mensaje = MESSAGE_TEXT;
			
		SELECT 0 AS 'result', @mensaje AS 'mensaje', -1 AS 'id_rtosal';
	END;
	
	START TRANSACTION;

	/* Pago 1: Grabo la cabecera */
	SELECT
		CASE WHEN MAX(id_rtoent) IS NULL THEN 1 ELSE MAX(id_rtoent) + 1 END
	INTO
		vProxID
	FROM
		rcn_remito;
	
	-- Calculo el prÃ³ximo nÃºmero de remito de salida
	SELECT
		CASE WHEN MAX(CONVERT(numero, SIGNED integer)) IS NULL THEN 1 ELSE MAX(CONVERT(numero, SIGNED integer)) + 1 END
	INTO
		vNumeroRemito
	FROM
		rcn_remito
	WHERE
		rcn_remito.id_tiporto = 2;
		
	SELECT
		destino
	INTO
		vDestino
	FROM
		rcn_remito
	WHERE
		rcn_remito.id_rtoent = xid_rtoent;
		
	INSERT INTO rcn_remito (
		id_rtoent, id_tiporto, idCliente, numero,
		destino, observaciones, usuAlta, fecAlta,
		idHostAlta)
	VALUES (
		vProxID, 2, xidCliente, CONCAT(REPEAT('0', 8 - LENGTH(vNumeroRemito)), vNumeroRemito),
		vDestino, xobservaciones, xusuario, current_timestamp,
		xhost);
	
	/* Paso 2: Actualiza el id_rtosal en rcn_ficha y cambio el estado
		a entregado.*/
	UPDATE
		rcn_ficha rf
			INNER JOIN rcn_remito rr ON rf.id_rtoent = rr.id_rtoent
			INNER JOIN rcn_aux_fichas_rtosal temp ON temp.id_ficha = rf.id_ficha
	SET
		rf.id_rtosal = vProxID,
		rf.id_estado = 4,
		rf.usuModi = xusuario,
		rf.fecModi = current_timestamp,
		rf.idHostModi = xhost
	WHERE
		rr.idCliente = xidCliente AND
		rf.id_estado = 3;
	
	COMMIT;
	SELECT 1 AS 'result', 'El remito de salida se grabÃ³ satisfactoriamente' AS 'mensaje', vProxID AS 'id_rtosal';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rcn_generar_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `rcn_generar_stock`(
	xid_ficha int,
	xusuario varchar(5),
	xhost varchar(50))
BEGIN

	/* Verifico si el stock estÃ¡ habilitado*/
	SELECT
		cfg_value
	INTO
		@habilitar_stock
	FROM
		global_cfg gc
	WHERE
		gc.cfg_key = 'STK_MODULE';
	
	IF @habilitar_stock = 'true' THEN
		/* Levanto los datos que necesito de tipos de movimientos */
		SELECT
			codMov,
			signo
		INTO
			@codMov,
			@signo
		FROM
			stk_tipomov stm
		WHERE
			stm.codMov = 'SAL';
		
		/* Pongo el circuto R en referencia al mÃ³dulo de reconstrucciones */
		SET @circuito = 'R';
		
		SELECT
			idCliente
		INTO
			@idCliente
		FROM
			rcn_ficha
				INNER JOIN rcn_remito ON rcn_remito.id_rtoent = rcn_ficha.id_rtoent
		WHERE
			rcn_ficha.id_ficha = xid_ficha;
			
		/* Armo la cabecera */
		SELECT
			CASE WHEN MAX(idStkCab) IS NULL THEN 1 ELSE MAX(idStkCab) + 1 END
		INTO
			@proximo_idStkCab
		FROM
			stk_cab;
			
		/* Verifico si la cabecera para esta ficha ya existe. Solo
			Genero la cabecera en caso de que no exista */
		SELECT
		  idStkCab
		INTO
		  @idStkCab
		FROM
		  stk_cab
		WHERE
		  stk_cab.id_ficha = xid_ficha;

		IF @idStkCab IS NULL THEN
			
			INSERT INTO stk_cab (
				idStkCab, circuito, numCbte, idCliente, 
				usuAlta, fecAlta, idHostAlta, id_ficha)
			VALUES (
				@proximo_idStkCab, @circuito, CONCAT('Ficha Nro: ', xid_ficha), @idCliente, 
				xusuario, current_timestamp, xhost, xid_ficha);
		END IF;
			
		/* Cargo el detalle de stock */
		
		SET @proximo_idStkDet = 0;
		
		/* Elimino los movimientos de stock asociados a la ficha y
			cargo los movimentos con las modificaciones */
			
		
		DELETE
		FROM
			stk_det
		WHERE
			stk_det.idStkCab = @idStkCab;
		
		/* Inserto los movimientos de salida de stock */
		INSERT INTO stk_det (
			idStkDet, idStkCab, idArticulo, idStkDep,
			tipoMov, cantidad, costoRep, nroPart)
				SELECT
					@proximo_idStkDet := @proximo_idStkDet + 1 AS idStkDet,
					CASE WHEN @idStkCab IS NULL THEN @proximo_idStkCab ELSE @idStkCab END idStkCab,
					raf.idArticulo,
					ad.idStkDep,
					@codMov,
					raf.cantidad * @signo,
					a.costoRep * @signo,
					'' AS nroPart
				FROM 
					rcn_aux_fichadet raf
						INNER JOIN articulos a ON a.idArticulo = raf.idArticulo
						INNER JOIN art_dep ad ON a.idArticulo = ad.idArticulo
				WHERE
					raf.host = xhost;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rcn_insertar_items_temporal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `rcn_insertar_items_temporal`(
	IN iditem_param INT(11),
    IN idmarca_param INT(11),
    IN medida_param DECIMAL(20, 2),
    IN nro_serie_param VARCHAR(20),
    IN trabajo_param VARCHAR(100),
    IN usuario_param VARCHAR(5),
    IN host_param VARCHAR(50)
)
BEGIN    
    INSERT INTO rcn_aux_rtitem (id, idmarca, medida, nro_serie, trabajo, usuario, host)
    VALUES (iditem_param, idmarca_param, medida_param, nro_serie_param, trabajo_param, usuario_param, host_param);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rcn_insert_aux_fichadet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `rcn_insert_aux_fichadet`(
	xid_ficha int,
	xcantidad decimal(20, 2),
	xidArticulo int,
	xcodArt varchar(20),
	xdescripcion varchar(200),
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	INSERT INTO rcn_aux_fichadet (
		id_ficha, cantidad, idArticulo, codArt,
		descripcio, usuario, host)
	VALUES (
	 xid_ficha, xcantidad, xidArticulo, xcodArt,
	 xdescripcion, xusuario, xhost);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rcn_limpiar_aux_fichadet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `rcn_limpiar_aux_fichadet`(
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	DELETE FROM rcn_aux_fichadet
	WHERE
		usuario = xusuario AND
		host = xhost;
		
	ALTER TABLE rcn_aux_fichadet AUTO_INCREMENT = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rcn_limpiar_temporal_items` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `rcn_limpiar_temporal_items`(
	xusuario varchar(5),
	xhostname varchar(50))
BEGIN
	DELETE FROM rcn_aux_rtitem WHERE usuario = xusuario AND host = xhostname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rcn_update_ficha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `rcn_update_ficha`(
	 xidFicha int,
	 xid_motrec int,
	 xidmarca int,
	 xmedida decimal(20, 2),
	 xnro_serie varchar(20),
	 xtrabajo varchar(100),
	 xid_estado int,
	 xcamsecgdo decimal(20, 2),
	 xmatricula varchar(100),
	 xreferencia int,
	 xvulcaniza bit,
	 xaprobado bit,
	 xaprob_sg bit,
	 xrechazado bit,
	 xradio decimal(20, 2),
	 xperimetro decimal(20, 2),
	 xancho decimal(20, 2),
	 xobserv text,
	 xparch_ant bit,
	 xid_estcra int,
	 xidop_recep int,
	 xidop_exapr int,
	 xidop_rasp int,
	 xidop_esca int,
	 xidop_appar int,
	 xusuario varchar(5),
	 xidHost varchar(50),
	 xidVentasC int
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
			@mensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', @mensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	
	UPDATE
		rcn_ficha
	SET
		rcn_ficha.id_motrec = CASE WHEN xid_motrec = 0 THEN NULL ELSE xid_motrec END,
		rcn_ficha.idmarca = xidmarca,
		rcn_ficha.medida = xmedida,
		rcn_ficha.nro_serie = xnro_serie,
		rcn_ficha.trabajo = xtrabajo,
		rcn_ficha.id_estado = CASE WHEN xid_estado = 0 THEN rcn_ficha.id_estado ELSE xid_estado END,
		rcn_ficha.id_estcra = CASE WHEN xid_estcra = 0 THEN rcn_ficha.id_estcra ELSE xid_estcra END,
		rcn_ficha.camsecgdo = xcamsecgdo,
		rcn_ficha.matricula = xmatricula,
		rcn_ficha.referencia = xreferencia,
		rcn_ficha.vulcaniza = xvulcaniza,
		rcn_ficha.aprobado = xaprobado,
		rcn_ficha.aprob_sg = xaprob_sg,
		rcn_ficha.rechazado = xrechazado,
		rcn_ficha.radio = xradio,
		rcn_ficha.perimetro = xperimetro,
		rcn_ficha.ancho = xancho,
		rcn_ficha.observ = xobserv,
		rcn_ficha.parch_ant = xparch_ant,
		rcn_ficha.idop_recep = CASE WHEN xidop_recep = 0 THEN NULL ELSE xidop_recep END,
		rcn_ficha.idop_exapr = CASE WHEN xidop_exapr = 0 THEN NULL ELSE xidop_exapr END,
		rcn_ficha.idop_rasp = CASE WHEN xidop_rasp = 0 THEN NULL ELSE xidop_rasp END,
		rcn_ficha.idop_esca = CASE WHEN xidop_esca = 0 THEN NULL ELSE xidop_esca END,
		rcn_ficha.idop_appar = CASE WHEN xidop_appar = 0 THEN NULL ELSE xidop_appar END,
		rcn_ficha.usuModi = xusuario,
		rcn_ficha.fecModi = current_timestamp,
		rcn_ficha.idHostModi = xidHost,
		rcn_ficha.idVentasC = CASE WHEN xidVentasC = 0 THEN NULL ELSE xidVentasC END
	WHERE
		rcn_ficha.id_ficha = xidFicha;
		
	/* 
		Guardo el detalle de la ficha a partir de la tabla auxiliar.
		Limpio la tabla para que no se dupliquen registros y guarde todos
		los cambios y luego grabo todos los registros.
	*/
	DELETE
	FROM
		rcn_fichadet
	WHERE
		rcn_fichadet.id_ficha = xidFicha;
	
	INSERT INTO rcn_fichadet (
		id_fichadet, id_ficha, cantidad, idArticulo,
		codArt, descripcio, usuAlta, fecAlta, idHostAlta)
			SELECT
				id, id_ficha, cantidad, idArticulo,
				codArt, descripcio, usuario, current_timestamp, host
			FROM
				rcn_aux_fichadet fd
			WHERE
				fd.usuario = xusuario AND
				fd.host = xidHost AND
				fd.id_ficha = xidFicha;
	
	/* Hago el movimiento de stock*/
	CALL rcn_generar_stock (xidFicha, xusuario, xidHost);
	
	COMMIT;
	DELETE FROM rcn_aux_fichadet WHERE host = xidHost;
	SELECT 1 AS 'result', 'Los cambios fueron grabados satsifactoriamente' AS 'mensaje';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sitiva_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `sitiva_getById`(_id int)
begin
    select *
    from sitiva
    where sitiva.idSitIVA = _id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_articulos_updateByPrecioFinal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_articulos_updateByPrecioFinal`(
	IN `pIdArticulo` INT,
	IN `pPreVtaFinal` DOUBLE,
	IN `pUsuario` VARCHAR(5),
	IN `pHostName` VARCHAR(50)
)
BEGIN
	DECLARE vPrLista DOUBLE;
	DECLARE vAlicIVA DOUBLE;
	DECLARE vBonif1 DOUBLE;
	DECLARE vBonif2 DOUBLE;
	DECLARE vBonif3 DOUBLE;
	DECLARE vBonif4 DOUBLE;
	DECLARE vCosto DOUBLE;
	DECLARE vCostoAnt DOUBLE;
	DECLARE vMargenMay DOUBLE;
	DECLARE vMargenMin DOUBLE;
	DECLARE vPrVentaMay DOUBLE;
	DECLARE vPrVentaMin DOUBLE;
	DECLARE vEsMayorista BIT;
    DECLARE vUsarImpuIn BIT;
    DECLARE vPorImpuIn DECIMAL(5, 2);
    DECLARE vImpImInMay DECIMAL(20, 2);
    DECLARE vImpImInMin DECIMAL(20, 2);
    DECLARE vPrFinalMay DECIMAL(20, 2);
	DECLARE vMensaje TEXT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;
	
	SET vImpImInMay = 0.00;
	
	SELECT
		alicIVA, bonif1, bonif2, bonif3, bonif4,
		margenMax, margenMin, costoRep, 
        usarImpuIn, porImpuIn
	INTO
		vAlicIVA, vBonif1, vBonif2, vBonif3, vBonif4,
		vMargenMay, vMargenMin, vCostoAnt, 
		vUsarImpuIn, vPorImpuIn
	FROM
		articulos
	WHERE
		articulos.idArticulo = pIdArticulo;
	
	SET vPrVentaMin = pPreVtaFinal / (1 + (vAlicIVA / 100));
	SET vCosto = vPrVentaMin / (1 + (vMargenMin / 100));
		
	SET vPrVentaMay = vCosto + (vCosto * (vMargenMay / 100));
	SET vPrFinalMay = vPrVentaMay + (vPrVentaMay * (vAlicIVA / 100));
	
	IF vUsarImpuIn THEN
		SET vImpImInMin = pPreVtaFinal * (vPorImpuIn / 100);
		SET vImpImInMay = vPrFinalMay * (vPorImpuIn / 100);
	END IF;
	
	SET vPrLista = articulos_costo_to_lista(vCosto, vBonif1, vBonif2, vBonif3, vBonif4);
		
	START TRANSACTION;
	UPDATE
		articulos
	SET
		articulos.prLista = vPrLista,
		articulos.costorep = vCosto
	WHERE
		articulos.idArticulo = pIdArticulo;
	
	UPDATE
		articulos
	SET
		articulos.prVentaMin = vPrVentaMin,
		articulos.prVentaMax = vPrVentaMay,
		articulos.prFinalMin = pPreVtaFinal,
		articulos.prFinalMax = vPrFinalMay,
		articulos.impImInMay = vImpImInMay,
		articulos.impImInMin = vImpImInMin,
		articulos.fecActuPre = CURRENT_TIMESTAMP,
		articulos.usuModi = pUsuario,
		articulos.fecModi = CURRENT_TIMESTAMP,
		articulos.idHostModi = pHostName
	WHERE
		articulos.idArticulo = pIdArticulo;

	CALL art_cbios_insert(pIdArticulo, vCostoAnt, vCosto);
	COMMIT;
	
	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `subfam_getAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `subfam_getAll`()
BEGIN
	SELECT *
	FROM subfam
	WHERE subfam.`fecBaja` IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `subfam_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `subfam_getById`(_id INT)
BEGIN
	SELECT *
	FROM subfam
	WHERE subfam.`idSubFam` = _id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `test`()
BEGIN
	SELECT 'Prueba de modificación de un procedimiento almacenado';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_actualizar`(
	pIdProv int, 
	pUsuario varchar(5), 
	pIdHost varchar(50))
begin
	declare mensaje text;
	declare exit handler for sqlexception
    begin
		rollback;
		get diagnostics condition 1 mensaje = message_text;
        select mensaje as result;
    end;
	start transaction;
    call art_tempo_delByProv (pIdProv);
	call upd_actualizarExistentes (pIdProv, pUsuario, pIdHost);
	call upd_pasarNuevosATemporal ();
	commit;
    select 'OK' as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_actualizarExistentes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_actualizarExistentes`(
	IN `pIdProv` int,
	IN `pUsuario` varchar(5),
	IN `pIdHost` varchar(50)
)
begin
	declare mensaje text;
    declare exit handler for sqlexception
    begin
		get diagnostics condition 1 mensaje = message_text;
        call art_upd_log_insert ('upd_actualizarExistentes', 'OK');
    end;

	update articulos
		inner join (
			select 
					*
         from 
				art_upd_tempo
         where 
				esNuevo = 0 and
				idProv = pIdProv) as tempo on tempo.idArticulo = articulos.idArticulo
	set articulos.prLista = tempo.lista,
		articulos.bonif1 = tempo.bonif1,
        articulos.bonif2 = tempo.bonif2,
        articulos.bonif3 = tempo.bonif3,
        articulos.bonif4 = tempo.bonif4,
        articulos.costoRep = articulos_calcularCosto(tempo.lista,
				tempo.bonif1, tempo.bonif2, tempo.bonif3, tempo.bonif4),
		articulos.margenMax = tempo.margenMax,
        articulos.margenMin = tempo.margenMin,
        articulos.prventaMax = articulos_calcularVenta(
				articulos_calcularCosto(tempo.lista, tempo.bonif1, tempo.bonif2,
					tempo.bonif3, tempo.bonif4), tempo.margenMax),
		articulos.prventaMin = articulos_calcularVenta(
				articulos_calcularCosto(tempo.lista, tempo.bonif1, tempo.bonif2,
					tempo.bonif3, tempo.bonif4), tempo.margenMin),
		articulos.prfinalMax = articulos_calcPrFinal(
				articulos_calcularVenta(
					articulos_calcularCosto(tempo.lista, tempo.bonif1, tempo.bonif2,
						tempo.bonif3, tempo.bonif4), tempo.margenMax), articulos.alicIVA),
		articulos.prfinalMin = articulos_calcPrFinal(
				articulos_calcularVenta(
					articulos_calcularCosto(tempo.lista,
						tempo.bonif1, tempo.bonif2,
						tempo.bonif3, tempo.bonif4), tempo.margenMin), articulos.alicIVA),
		articulos.fecActuPre = current_timestamp,
		articulos.usuModi = pUsuario,
        articulos.fecModi = current_timestamp,
        articulos.idHostModi = pIdHost;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_artInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_artInsert`(
	_idProv INT,
	_idFamilia INT,
	_idSubFam INT,
	_idMarca INT,
	_codArt VARCHAR(20),
	_codArtPV VARCHAR(20),
	_descripcio VARCHAR(200),
	_alicIVA DOUBLE,
	_prListaExt DOUBLE,
	_cotizac DOUBLE, 
	_prLista DOUBLE, 
	_bonif1 DOUBLE, 
	_bonif2 DOUBLE, 
	_bonif3 DOUBLE, 
	_bonif4 DOUBLE, 
	_costoRep DOUBLE,
	_margenMax DOUBLE,
	_margenMin DOUBLE, 
	_prVentaMax DOUBLE, 
	_prVentaMin DOUBLE,
	_prFinalMax DOUBLE, 
	_prFinalMin DOUBLE, 
	_esNuevo DOUBLE, 
	_habilitado DOUBLE, 
	_usuAlta VARCHAR(5), 
	_idHostAlta VARCHAR(50))
BEGIN
	DECLARE proxIdArticulo INT;
	DECLARE proxIdCodArt INT;
	
	SET proxIdArticulo = (
		SELECT
			CASE
				WHEN MAX(idArticulo) IS NULL THEN 1
				ELSE MAX(idArticulo) + 1
			END
		FROM articulos);
	
	INSERT INTO articulos (
		idArticulo, idProv, idFamilia, idSubFam,
		idMarca, codArt, codArtPV, descripcio, alicIVA, prListaExt,
		cotizac, prLista, bonif1, bonif2, bonif3, bonif4, costoRep,
		margenMax, margenMin, prVentaMax, prVentaMin,
		prFinalMax, prFinalMin, esNuevo, habilitado, usuAlta, fecAlta,
		idHostAlta, fecActuPre)
	VALUES (
		proxIdArticulo, _idProv, _idFamilia, _idSubFam,
		_idMarca, _codArt, _codArtPV, _descripcio, _alicIVA, _prListaExt,
		_cotizac, _prLista, _bonif1, _bonif2, _bonif3, _bonif4, _costoRep,
		_margenMax, _margenMin, _prVentaMax, _prVentaMin,
		articulos_calcPrFinal(_prVentaMax, _alicIVA), 
        articulos_calcPrFinal(_prVentaMin, _alicIVA), 
        _esNuevo, _habilitado, usuAlta, CURRENT_TIMESTAMP,
		_idHostAlta, CURRENT_TIMESTAMP);
	
	SET proxIdCodArt = (SELECT 
		CASE 
			WHEN MAX(idCodArt) IS NULL THEN 1
			ELSE MAX(idCodArt) + 1
		END
		FROM codiart);
		
	INSERT INTO codiart (
		idCodArt, idArticulo, codArt, codigos,
		tipo, cantiDesp, procesado, circuito)
	VALUES (
		proxIdCodArt, proxIdArticulo, _codArt, _codArt,
		'CP', 1, 0, 'CV');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_ArtNuevoGrabar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_ArtNuevoGrabar`(pIdProv int, pUsuario varchar(5), pIdHost varchar(50))
begin
	declare vMensaje text;
	declare exit handler for sqlexception
    begin
		rollback;
        get diagnostics condition 1 vMensaje = message_text;
        select vMensaje as result;
    end;
    start transaction;
    
    set @vIdArticulo = (
		select case when max(idArticulo) is null then 1
			else max(idArticulo) + 1 end
		from articulos);
	insert into articulos (
		idArticulo, 
		idprov, 
		idFamilia, 
		idSubFam, 
		idMarca, 
		codArt, 
		descripcio,
        alicIVA, 
        prLista,
        prListaExt,
        cotizac,
        bonif1, 
        bonif2, 
        bonif3, 
        bonif4, 
        costoRep,
        margenMax, 
        margenMin,
        prventaMax, 
        prventaMin, 
        prfinalMax,
        prfinalMin, 
        habilitado, 
        usuAlta, 
        fecAlta, 
        idHostAlta, 
        esServ,
        idUniMed, 
        codArtPV, 
        mostrador, 
        fecActuPre, 
        esNuevo)
			select (
				@vIdArticulo := @vIdArticulo + 1), 
				idprov, 
				idFamilia, 
				idSubFam, 
				idMarca, 
				codArt, 
				UPPER(descripcio),
				alicIVA, 
				prListaPV as prLista,
				0 as prListaExt,
				0 as cotizac,
				bonif1, 
				bonif2, 
				bonif3, 
				bonif4, 
				costoRep,
				margenMay, 
				margenMin, 
				prventaMay, 
				prventaMin, 
				articulos_calcPrFinal(prventaMay, alicIVA) as prfinalMax,
				articulos_calcPrFinal(prventaMin, alicIVA) as prfinalMin, 
				1 as habilitado, pUsuario as usuAlta, 
				current_timestamp as fecAlta, 
				pIdHost as idHostAlta, 
				0 as esServ, 
				1 as idUniMed,
				codArtPV, 0 as mostrador, 
				current_timestamp as fecActuPre, 
				1 as esNuevo
			from art_tempo
			where idProv = pIdProv;
		
	set @vIdCodArt = (
		select case when max(idCodArt) is null then 1
				else max(idCodArt) + 1 end
		from codiart);
	insert into codiart (
		idCodArt, idArticulo, codArt, codigos, tipo, cantiDesp, procesado, circuito)
			select (@vIdCodArt := @vIdCodArt + 1),
				idArticulo, codArt, codArt, 'CP', 1, 0, 'CV'
			from articulos
			where articulos.idprov = pIdProv
				and articulos.esNuevo = 1;
	
	update articulos
	set articulos.esNuevo = 0
	where articulos.idprov = pIdProv;
    
    update art_tempo
    set procesado = 1
    where idProv = pIdProv;
    commit;
    select 'OK' as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_ArtNuevosLeerPend` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_ArtNuevosLeerPend`(pIdProv int)
begin
	select *
    from art_tempo
    where art_tempo.idProv = pIdProv
		and art_tempo.procesado = 0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_ArtNuevosProcesar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_ArtNuevosProcesar`(pIdProv int,
	pBonif1 double, pBonif2 double, pBonif3 double, pBonif4 double,
    pMargenMay double, pMargenMin double)
begin
	declare mensaje text;
	declare exit handler for sqlexception
    begin
		rollback;
		get diagnostics condition 1 mensaje = message_text;
        select mensaje as result;
    end;
    start transaction;

	update art_tempo
    set art_tempo.codArt = upd_ArtNuevosFormatCod(art_tempo.idProv, art_tempo.codArt),
		art_tempo.bonif1 = pBonif1,
		art_tempo.bonif2 = pBonif2,
        art_tempo.bonif3 = pBonif3,
        art_tempo.bonif4 = pBonif4,
        art_tempo.margenMay = pMargenMay,
        art_tempo.margenMin = pMargenMin,
        art_tempo.costoRep = articulos_calcularCosto(art_tempo.prListaPV,
				pBonif1, pBonif2, pBonif3, pBonif4),
		art_tempo.prVentaMay = articulos_calcularVenta(
				articulos_calcularCosto(art_tempo.prListaPV, pBonif1, pBonif2, pBonif3, pBonif4), art_tempo.margenMay),
		art_tempo.prVentaMin = articulos_calcularVenta(
				articulos_calcularCosto(art_tempo.prListaPV, pBonif1, pBonif2, pBonif3, pBonif4), art_tempo.margenMin)
    where art_tempo.idProv = pIdProv;

    commit;
    select 'OK' as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_ArtNuevoTienePend` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_ArtNuevoTienePend`(_idProv int)
begin
	declare cantReg int;
    declare resultado bit;
    set cantReg = (select count(*)
		from art_tempo
        where procesado = 0
			and idprov = _idProv);
	if cantReg > 0 then
		set resultado = 1;
	else
		set resultado = 0;
    end if;
    select resultado as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_ArtTempUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_ArtTempUpdate`(
    pidFamilia int,
    pidSubFam int,
    pidMarca int,
    pcodArt varchar(20),
    pcodArtPV varchar(20),
    pdescripcio varchar(200),
    palicIVA double,
    pprListaPV double,
    pbonif1 double,
    pbonif2 double,
    pbonif3 double,
    pbonif4 double,
    pcostoRep double,
    pmargenMay double,
    pmargenMin double,
    pprVentaMay double,
    pprVentaMin double,
    pprocesado bit)
begin
	update art_tempo
    set idFamilia = pidFamilia,
		idSubFam = pidSubFam,
        idMarca = pidMarca,
        codArt = pcodArt,
        descripcio = UPPER(pdescripcio),
        alicIVA = palicIVA,
        bonif1 = pbonif1,
        bonif2 = pbonif2,
        bonif3 = pbonif3,
        bonif4 = pbonif4,
        costoRep = pcostoRep,
        margenMay = pmargenMay,
        margenMin = pmargenMin,
        prVentaMay = pprVentaMay,
        prVentaMin = pprVentaMin,
        procesado = pprocesado
	where codArtPV = pcodArtPV
		and procesado = 0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_artUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_artUpdate`(
	_idArticulo INT,
	_prLista DOUBLE,
	_bonif1 DOUBLE,
	_bonif2 DOUBLE,
	_bonif3 DOUBLE,
	_bonif4 DOUBLE,
	_costoRep DOUBLE,
	_margenMax DOUBLE,
	_margenMin DOUBLE,
	_prVentaMax DOUBLE,
	_prVentaMin DOUBLE,
	_prFinalMax DOUBLE,
	_prFinalMin DOUBLE,
	_idMarca INT,
	_usuModi VARCHAR(5),
	_hostModi VARCHAR(50))
BEGIN
	UPDATE articulos
	SET prLista = _prLista,
		bonif1 = _bonif1,
		bonif2 = _bonif2,
		bonif3 = _bonif3,
		bonif4 = _bonif4,
		costoRep = _costoRep,
		margenMax = _margenMax,
		margenMin = _margenMin,
		prVentaMax = _prVentaMax,
		prVentaMin = _prVentaMin,
		prFinalMax = articulos_calcPrFinal(_prVentaMax, articulos.alicIVA),
		prFinalMin = articulos_calcPrFinal(_prventaMin, articulos.alicIVA),
		idMarca = _idMarca,
		usuModi = _usuModi,
		fecModi = CURRENT_TIMESTAMP,
		idHostModi = _hostModi,
		fecActuPre = CURRENT_TIMESTAMP
	WHERE articulos.`idArticulo` = _idArticulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_artVerify` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_artVerify`(_idprov INT, _codArtPV VARCHAR(20))
BEGIN
	SELECT idArticulo
	FROM articulos
	WHERE articulos.`idProv` = _idprov
		AND articulos.`codArtPV` = _codArtPV;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_getPorcentajes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_getPorcentajes`(_idProv INT)
BEGIN
	SELECT DISTINCT bonif1, bonif2, bonif3, bonif4, margenMax, margenMin
	FROM articulos
	WHERE articulos.`idprov` = _idProv;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_marcaInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_marcaInsert`(
	_descripcio VARCHAR(60),
	_usuAlta VARCHAR(5),
	_idHostAlta VARCHAR(50))
BEGIN
	DECLARE proxID INT;
	SET proxID = (
		SELECT
			CASE 
				WHEN MAX(idmarca) IS NULL THEN 1
				ELSE MAX(idmarca) + 1
			END
		FROM marcas);
		
	INSERT INTO marcas (
		idmarca, descripcio, usuAlta, fecAlta, idHostAlta)
	VALUES (proxID, _descripcio, _usuAlta, CURRENT_TIMESTAMP, _idHostAlta);
    SELECT proxID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_marcasVerify` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_marcasVerify`(
	_descripcion VARCHAR(60))
BEGIN
	SELECT idmarca
	FROM marcas
	WHERE marcas.`descripcio` = _descripcion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_pasarNuevosATemporal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `upd_pasarNuevosATemporal`()
begin
	declare vIdFamilia int;
    declare vIdSubFam int;
    declare vIdMarca int;
	
	set vIdFamilia = globalCFG_getByKey ('UPDFAMDEF');
	set vIdSubFam = globalCFG_getByKey ('UPDSUBFDEF');
	set vIdMarca = globalCFG_getByKey ('UPDMARDEF');
	
	insert into art_tempo (
		idprov, idFamilia, idSubFam, idMarca, codArt, codArtPV,
        descripcio, alicIVA, prListaPV, bonif1, bonif2, bonif3, bonif4,
        costoRep, margenMay, margenMin, prVentaMay, prVentaMin, procesado)
			select 
				idprov, vIdFamilia, vIdSubFam, vIdMarca, codArt,
				codigo, UPPER(articulo), 21 as alicIVA, lista, 0 as bonif1,
				0 as bonif2, 0 as bonif3, 0 as bonif4, 0 as costoRep, 0 as margenMay,
				0 as margenMin, 0 as prVentaMay, 0 as prVentaMin, 0 as procesado
			from art_upd_tempo
			where art_upd_tempo.esNuevo = 1;	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `utilGenerarFCCtaCte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `utilGenerarFCCtaCte`(_idCliente INT, _nroCbte INT)
BEGIN
	DECLARE proxIdCC_Cli INT;
	DECLARE proxIdOper INT;
	DECLARE _idVentasC INT;
	
	SET _idVentasC = (SELECT idVentasC 
		FROM ventascab 
		WHERE numCbte = _nroCbte AND idCliente = _idCliente);
	SET proxIdCC_Cli = (SELECT MAX(idCC_Cli) + 1 FROM cc_cli);
	SET proxIdOper = (SELECT MAX(idOper) + 1 FROM cc_cli);
	
	INSERT INTO cc_cli (
		idCC_Cli,
		idCliente,
		idCC_Orig,
		idVentasC,
		cbte,
		tipoDoc,
		ptoVta,
		nroCbte,
		fecEmis,
		fecVto,
		impDebe,
		impHaber,
		idOper,
		observ,
		idCOndPago,
		idSitIVA,
		idVendedor,
		usuAlta,
		fecAlta,
		idHostAlta
	)
		SELECT
			proxIdCC_Cli,
			idCliente,
			NULL AS idCC_Orig,
			idVentasC,
			cbte,
			tipoDoc,
			ptoVta,
			numCbte,
			fecEmision,
			fecVto,
			totFact AS impDebe,
			0 AS impHaber,
			proxIdOper AS idOper,
			'' AS observ,
			idCondPago,
			idSitIVA,
			idVendedor,
			usuAlta,
			CURRENT_TIMESTAMP AS fecAlta,
			idHostAlta
		FROM ventascab
		WHERE idVentasC = _idVentasC;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `utilGenerarNCCtaCte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `utilGenerarNCCtaCte`(_idCliente INT, _nroCbte INT)
BEGIN
	DECLARE proxIdCC_Cli INT;
	DECLARE proxIdOper INT;
	DECLARE _idVentasC INT;
	
	SET _idVentasC = (SELECT idVentasC 
		FROM ventascab 
		WHERE numCbte = _nroCbte AND idCliente = _idCliente);
	SET proxIdCC_Cli = (SELECT MAX(idCC_Cli) + 1 FROM cc_cli);
	SET proxIdOper = (SELECT MAX(idOper) + 1 FROM cc_cli);
	
	INSERT INTO cc_cli (
		idCC_Cli,
		idCliente,
		idCC_Orig,
		idVentasC,
		cbte,
		tipoDoc,
		ptoVta,
		nroCbte,
		fecEmis,
		fecVto,
		impDebe,
		impHaber,
		idOper,
		observ,
		idCOndPago,
		idSitIVA,
		idVendedor,
		usuAlta,
		fecAlta,
		idHostAlta
	)
		SELECT
			proxIdCC_Cli,
			idCliente,
			NULL AS idCC_Orig,
			idVentasC,
			cbte,
			tipoDoc,
			ptoVta,
			numCbte,
			fecEmision,
			fecVto,
			0 AS impDebe,
			totFact AS impHaber,
			proxIdOper AS idOper,
			'' AS observ,
			idCondPago,
			idSitIVA,
			idVendedor,
			usuAlta,
			CURRENT_TIMESTAMP AS fecAlta,
			idHostAlta
		FROM ventascab
		WHERE idVentasC = _idVentasC;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `util_acomodar_marcas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `util_acomodar_marcas`(

	pMarcaBuscada varchar(60),

    pNombreMarca varchar(60))
BEGIN

	DECLARE vIdMarca int;

    DECLARE vMensaje text;

    DECLARE EXIT handler FOR SQLEXCEPTION

    BEGIN

		ROLLBACK;

        GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;

        SELECT vMensaje AS 'Resultado';

    END;

    

    SELECT 

		idMarca INTO vIdMarca

    FROM

		marcas

	WHERE

		marcas.descripcio LIKE CONCAT('%', pNombreMarca, '%');

	

    START TRANSACTION;

    IF vIdMarca IS NOT NULL THEN

		UPDATE

			articulos

				INNER JOIN tmp_artvarios

					ON tmp_artvarios.idArticulo = articulos.idArticulo

		SET

			articulos.idMarca = vIdMarca

		WHERE

			tmp_artvarios.descripcio LIKE CONCAT('%', pMarcaBuscada, '%');

		SELECT CONCAT('Filas afectadas: ', ROW_COUNT()) AS 'Resultado';

	ELSE

		SET vIdMarca = (SELECT MAX(idMarca) + 1 FROM marcas);

        

		INSERT INTO marcas (

			idMarca, descripcio, usuAlta, fecAlta, idHostAlta)

		VALUES (

			vIdMarca, pNombreMarca, 'SUPER', current_timestamp, 'ESCRITORIO # Leonardo');

            

		UPDATE

			articulos

				INNER JOIN tmp_artvarios

					ON tmp_artvarios.idArticulo = articulos.idArticulo

		SET

			articulos.idMarca = vIdMarca

		WHERE

			tmp_artvarios.descripcio LIKE CONCAT('%', pMarcaBuscada, '%');

		

        SELECT CONCAT('Filas afectadas: ', ROW_COUNT(), '. Se agregó una marca nueva') AS 'Resultado';

	END IF;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `util_deleteArtByProv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `util_deleteArtByProv`(pIdProv int)
BEGIN
	
	DELETE FROM codiart
	WHERE idArticulo IN (
		SELECT idArticulo 
		FROM articulos
		WHERE articulos.idProv = pIdProv);
	
	DELETE 
	FROM art_cbios
	WHERE art_cbios.idArticulo IN (
		SELECT idArticulo
		FROM articulos
		WHERE articulos.idProv = pIdProv);
	
	DELETE 
	FROM faltantes
	WHERE faltantes.idArticulo IN (
		SELECT idArticulo
		FROM articulos
		WHERE articulos.idProv = pIdProv);
	
	DELETE 
	FROM ocdet
	WHERE ocdet.idArticulo IN (
		SELECT idArticulo
		FROM articulos
		WHERE articulos.idProv = pIdProv);
	
	DELETE FROM articulos 
	WHERE idProv = pIdProv
		AND idArticulo NOT IN (
			SELECT idArticulo
			FROM ventasdet);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `util_generar_rutasFotos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `util_generar_rutasFotos`(
	pIdMarca int,
	pMarca varchar(60),
    pIdProv int)
BEGIN
	DECLARE vMensaje text;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;

	START TRANSACTION;

	UPDATE	articulos
	SET 	linkfoto = CONCAT('C:\\MG_FOTOS\\', pMarca, '\\', articulos.codart, '.JPG')
	WHERE	articulos.idmarca = pIdMarca AND
			articulos.fecBaja IS NULL AND
            CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END;
	
	UPDATE 	articulos
	SET		linkfoto = CONCAT('C:\\MG_FOTOS\\', pMarca, '\\', 
				REPLACE(articulos.codArt, '/', '-'), '.JPG')
	WHERE articulos.idmarca = pIdMarca AND 
		articulos.codArt LIKE '%/%' AND
		articulos.fecBaja IS NULL  AND
        CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END;
	
	COMMIT;

	SELECT codart, linkfoto, marcas.descripcio, articulos.idProv
	FROM articulos
		INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
	WHERE marcas.idmarca = pIdMarca AND
		articulos.fecBaja IS NULL AND
        CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `util_generar_rutasFotos_sin_fotos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `util_generar_rutasFotos_sin_fotos`(
	pIdMarca int,
	pMarca varchar(60),
    pIdProv int)
BEGIN
	DECLARE vMensaje text;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;

	START TRANSACTION;
    
    DROP TABLE IF EXISTS tmp_sin_fotos;
    CREATE TEMPORARY TABLE tmp_sin_fotos
		SELECT
			idArticulo
		FROM
			articulos
		WHERE
			articulos.linkFoto IS NULL AND
			articulos.idmarca = pIdMarca AND
            articulos.fecBaja IS NULL;

	UPDATE	articulos
		INNER JOIN tmp_sin_fotos ON tmp_sin_fotos.idArticulo = articulos.idArticulo
	SET 	articulos.linkfoto = CONCAT('C:\\MG_FOTOS\\', pMarca, '\\', articulos.codart, '.JPG')
	WHERE	articulos.idmarca = pIdMarca AND
			articulos.fecBaja IS NULL AND
            CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END;
	
	UPDATE 	articulos
		INNER JOIN tmp_sin_fotos ON tmp_sin_fotos.idArticulo = articulos.idArticulo
	SET		articulos.linkfoto = CONCAT('C:\\MG_FOTOS\\', pMarca, '\\', 
				REPLACE(articulos.codArt, '/', '-'), '.JPG')
	WHERE articulos.idmarca = pIdMarca 
		AND articulos.codArt LIKE '%/%'
		AND articulos.fecBaja IS NULL AND
        CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END;
	
	COMMIT;

	SELECT codart, linkfoto, marcas.descripcio, articulos.idProv
	FROM articulos
		INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
        INNER JOIN tmp_sin_fotos ON tmp_sin_fotos.idArticulo = articulos.idArticulo
	WHERE marcas.idmarca = pIdMarca
		AND articulos.fecBaja IS NULL AND
        CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vendedoresGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `vendedoresGetAll`()
BEGIN
	SELECT *
	FROM vendedores
	WHERE fecBaja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vendedoresGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `vendedoresGetById`(_id INT)
BEGIN
	SELECT *
	FROM vendedores
	WHERE vendedores.`idVendedor` = _id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_actualizarNroRTO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_actualizarNroRTO`(
	p_idventasc int,
	p_nroRemito varchar(20)
)
BEGIN
	DECLARE vMensaje text;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;
	START TRANSACTION;
	UPDATE
		ventascab
	SET
		ventascab.nroRemito = p_nroRemito
	WHERE
		ventascab.idVentasC = p_idventasc;
	COMMIT;
	SELECT 'OK' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_CITIVtaAlic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_CITIVtaAlic`(
	pIdVentasC int)
BEGIN
	SELECT
		alicIVA,
		CASE 
			WHEN alicIVA = 21 THEN '0005'
			WHEN alicIVA = 10.5 THEN'0004'
			WHEN alicIVA = 0 THEN '0003'
			WHEN alicIVA = 27 THEN '0006'
			WHEN alicIVA = 5 THEN '0008'
			WHEN alicIVA = 2.5 THEN '0009' END codAlicIVA,
		sum(totNeto) AS impNeto,
		sum(impIVA) AS impIva
	FROM
		ventasdet
	WHERE
		idVentasC = pIdVentasC
	GROUP BY
		alicIVA;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_CITIVtaAlicCptos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_CITIVtaAlicCptos`(
	pIdVentasC int)
BEGIN
	SELECT
		ivaPor,
		CASE 
			WHEN ivaPor = 21 THEN '0005'
			WHEN ivaPor = 10.5 THEN'0004'
			WHEN ivaPor = 0 THEN '0003'
			WHEN ivaPor = 27 THEN '0006'
			WHEN ivaPor = 5 THEN '0008'
			WHEN ivaPor = 2.5 THEN '0009' END codAlicIVA,
		sum(impNeto) AS impNeto,
		sum(ivaImp) AS impIva

	FROM
		vtadcp
	WHERE
		idVentasC = pIdVentasC
	GROUP BY
		ivaPor;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_consultar`(
	_tipoConsulta varchar(20),
	_fechaDesde datetime,
	_fechaHasta datetime,
	_idClienteDesde int,
	_idClienteHasta int,
	_cbte varchar(5),
	_tipoDoc varchar(5),
	_ptoVta int,
	_numCbte int)
begin
	select ventascab.idVentasC, ventascab.idCliente, ventascab.razSoc,
        	ventascab.fecEmision, ventascab.cbte, ventascab.tipoDoc, ventascab.ptoVta,
	        ventascab.numCbte, ventascab.totFact, ventascab.usuAlta, ventascab.fecAlta, ventascab.idHostAlta,
        	ventascab.observ, ventascab.aut_Resultado, ventascab.aut_CAE, ventascab.aut_CAE_Vto
	from ventascab
		inner join clientes on ventascab.idCliente = clientes.idCliente
	where ventascab.anulado = 0
		and ventascab.fecBaja is null
        and case
			when (_fechaDesde is null and _fechaHasta is null) then 1
			else cast(ventascab.fecEmision as date) between _fechaDesde and _fechaHasta end
		and case
			when (_idClienteDesde = 0 and _idClienteHasta = 0) then 1
			else ventascab.idCliente between _idClienteDesde and _idClienteHasta end
		and case
			when _cbte = 'TODOS' then
				case
					when _tipoConsulta = 'facturacion' then ventascab.cbte in ('FC', 'NC', 'ND')
					when _tipoConsulta = 'pedidos' then ventascab.cbte = 'PED'
					when _tipoConsulta = 'presupuesto' then ventascab.cbte in ('FC', 'NC', 'ND')
					when _tipoConsulta = 'cotizador' then ventascab.cbte in ('COT') end
			else case
				when _cbte is null then 1
				else ventascab.cbte = _cbte end
			end
		and case
			when _tipoConsulta = 'facturacion' then ventascab.aut_Resultado = 'A'
            else 1 end
		and case
			when _tipoDoc = 'TODOS' then 1
			else ventascab.tipodoc = _tipoDoc end
        and case
			when _ptoVta = 0 then 1
			else ventascab.ptovta = _ptoVta end
		and case
			when _numCbte = 0 then 1
			else ventascab.numCbte = _numCbte end
	order by ventascab.fecEmision;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_getById`(_idVentasC int)
begin
	select ventascab.*, tipodoc.CodAfip, sitiva.conivareid, condpagos.cntDias
	from ventascab
		inner join tipodoc on tipodoc.idTipoDoc = ventascab.idTipoDoc
        inner join sitiva on sitiva.idSitIVA = ventascab.idSitIVA
        inner join condpagos on condpagos.idCondPago = ventascab.idCondPago
	where ventascab.idVentasC = _idVentasC;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_getCbteRel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_getCbteRel`(pIdVentaC int)
BEGIN
	SELECT
		ventascab.*,
        tipodoc.CodAfip
	FROM
		ventascab
			inner join ventasrel on ventasrel.idVtaCO = ventascab.idVentasC
            inner join tipodoc on tipodoc.idTipoDoc = ventascab.idTipoDoc
	WHERE
		ventasrel.idVtaCD = pIdVentaC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_getCITIVta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_getCITIVta`(
	fechaDD DATE,
    fechaHH DATE)
BEGIN
	/* Ultima version agrego total no gravado */
	SELECT 
		ventascab.fecEmision,
		ventascab.cbte, 
		ventascab.aut_tipoCbte, 
		ventascab.ptoVta, 
		ventascab.numCbte, 
		tipodoc.CodAfip, 
		ventascab.nroDoc, 
		ventascab.razSoc, 
		ventascab.totFact, 
		ventascab.impFinal, 
		ventascab.porIVA21, 
		ventascab.impIVA21, 
		ventascab.porIVA105, 
		ventascab.impIVA105,
		ventascab.totaNoGrav,
		ventascab.fecVto, 
		ventascab.idVentasC 
	FROM ventascab 
	  INNER JOIN tipodoc ON tipodoc.idTipoDoc = ventascab.idTipoDoc 
	WHERE  
		CAST(ventascab.FecEmision AS DATE) between  fechaDD and fechaHH
	 AND ventascab.cbte NOT IN ('PED', 'COT', 'PTO')
	 AND ventascab.fecBaja IS NULL 
	 AND ventascab.aut_Resultado = 'A';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_getControlSalida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_getControlSalida`()
BEGIN
  SELECT
    ventascab.idVentasC,
    ventascab.fecEmision,
    clientes.idCliente,
    clientes.razSoc,
    ventascab.cbte,
    formatear_NroCbte(ventascab.ptovta, ventascab.numCbte) AS numCbte
  FROM ventascab
    INNER JOIN clientes
      ON clientes.idCliente = ventascab.idCliente
  WHERE ventascab.cbte = 'PED'
  AND ventascab.fecBaja IS NULL
  AND ventascab.idVentasC NOT IN (SELECT
      idVtaCO
    FROM ventasrel)
  ORDER BY ventascab.fecEmision DESC, ventascab.idCliente ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_getFacturasByCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_getFacturasByCliente`(
	xidCliente int
)
begin
	select
		idVentasC,
		fecEmision,
		cbte,
		tipoDoc,
		concat(repeat('0', 5 - length(ptoVta)), ptoVta) as ptoVta,
		concat(repeat('0', 8 - length(numCbte)), numCbte) as numero
	from 
		ventascab v 
	where 
		v.idCliente = xidCliente and
		v.cbte = 'FC';	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_getIVAVtas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_getIVAVtas`(
	pFechaDD DATE,
	pFechaHH DATE)
BEGIN
	DROP TABLE IF EXISTS tmp_ivavtas;
	CREATE TEMPORARY TABLE tmp_ivavtas
		SELECT 
			ventascab.IdVentasc,
			ventascab.FecEmision,
			ventascab.Cbte,
			ventascab.TipoDoc,
			ventascab.PtoVta,
			ventascab.NumCbte,
			clientes.razsoc as 'Cliente',
			provincias.descripcio as 'Juris',
			Case sitiva.idsitiva
				When 1 Then 'RI'
				When 3 Then 'CF'
				When 6 Then 'MON' 	
			Else 'EXE'  End as 'Cat',  
			ventascab.nroDoc,
			Round(SUM(
				Case When ventasdet.AlicIVA = 21 Then ventasdet.TotNeto Else 0 END) *
						(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21', 
					Round(SUM(Case When ventasdet.AlicIVA = 10.5 Then ventasdet.TotNeto Else 0 End) * 
						(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105',
			Round(ventascab.totaNoGrav * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'No_Grav',
			Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB',
			Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21',
			Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105',
			Round(ventascab.totfact * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Total'
		FROM  
			ventascab  	
				left join ventasdet on ventascab.idventasc = ventasdet.idventasc 
				inner join clientes on ventascab.idcliente = clientes.idcliente  
				inner join localidad on clientes.idlocalid = localidad.idlocalid 
				inner join provincias on localidad.idprovin = provincias.idprovin 
				inner join sitiva on clientes.idsitiva = sitiva.idsitiva  
		WHERE   
			ventascab.Cbte NOT IN ('PED','COT','PTO')  AND 
			ventascab.idventasc NOT IN (select idventasc from vtadcp) AND 
			ventascab.fecBaja IS NULL AND 
			ventascab.aut_Resultado = 'A' and 
			CAST(ventascab.FecEmision AS DATE) between pFechaDD and pFechaHH
		GROUP BY 
			ventascab.IdVentasc, 
			ventascab.FecEmision, 
			ventascab.Cbte,
			ventascab.TipoDoc,
			ventascab.PtoVta,
			ventascab.NumCbte,
			clientes.razsoc,
			ventascab.nroDoc,
			provincias.descripcio,
			sitiva.idsitiva,
			ventasdet.IdVentasc
		UNION 
		SELECT
			ventascab.IdVentasc,  
			ventascab.FecEmision,  
			ventascab.Cbte,  
			ventascab.TipoDoc,  
			ventascab.PtoVta,  
			ventascab.NumCbte,  
			clientes.razsoc as 'Cliente',  
			provincias.descripcio as 'Juris',  
			Case sitiva.idsitiva
				When 1 Then 'RI' 
				When 3 Then 'CF' 
				When 6 Then 'MON' 	
				Else 'EXE'  
			End as 'Cat',  
			ventascab.nroDoc,  
			Round(SUM(Case When vtadcp.ivaPor = 21 Then vtadcp.impNeto Else 0 End) * 
				(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21',  
			Round(SUM(Case When vtadcp.ivaPor = 10.5 Then vtadcp.impNeto Else 0 End) * 
				(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105',  
			Round(ventascab.totaNoGrav * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'No_Grav',
			Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB',  
			Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21',  
			Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105',  
			Round(ventascab.totfact * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Total'  
		FROM    
			ventascab  	
				left join vtadcp on ventascab.idventasc = vtadcp.idventasc    
				inner join clientes on ventascab.idcliente = clientes.idcliente    
				inner join localidad on clientes.idlocalid = localidad.idlocalid    
				inner join provincias on localidad.idprovin = provincias.idprovin   
				inner join sitiva on clientes.idsitiva = sitiva.idsitiva  
		WHERE   
			ventascab.Cbte NOT IN ('PED','COT','PTO') AND 
			ventascab.idventasc IN (select idventasc from vtadcp) AND 
			ventascab.fecBaja IS NULL AND 
			ventascab.aut_Resultado = 'A' and 
			CAST(ventascab.FecEmision AS DATE) between pFechaDD and pFechaHH
		GROUP BY  
			ventascab.IdVentasc,
			ventascab.FecEmision,
			ventascab.Cbte,
			ventascab.TipoDoc,
			ventascab.PtoVta,
			ventascab.NumCbte,
			clientes.razsoc,
			ventascab.nroDoc,
			provincias.descripcio,
			sitiva.idsitiva,
			vtadcp.IdVentasc
		ORDER BY 	
			fecEmision, 
			tipodoc;
			
	SELECT
		*
	FROM
		tmp_ivavtas
	ORDER BY
		fecEmision,
		cbte,
		ptovta,
		numcbte;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventascab_getIVAVtas_control` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventascab_getIVAVtas_control`(
	panio int,
	pmes int)
BEGIN
	
	DROP TABLE IF EXISTS tmp_ivavtas;
	CREATE TEMPORARY TABLE tmp_ivavtas
		SELECT 
			ventascab.IdVentasc,
			ventascab.FecEmision,
			ventascab.Cbte,
			ventascab.TipoDoc,
			ventascab.PtoVta,
			ventascab.NumCbte,
			clientes.razsoc as 'Cliente',
			provincias.descripcio as 'Juris',
			Case sitiva.idsitiva
				When 1 Then 'RI'
				When 3 Then 'CF'
				When 6 Then 'MON' 	
			Else 'EXE'  End as 'Cat',  
			ventascab.nroDoc,
			0 as 'Grav_3',
			0 as 'Exen_3',
			Round(SUM(
				Case When ventasdet.AlicIVA = 21 Then ventasdet.TotNeto Else 0 END) *
						(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21', 
					Round(SUM(Case When ventasdet.AlicIVA = 10.5 Then ventasdet.TotNeto Else 0 End) * 
						(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105',
			0 as 'Exen_P',
			Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB',
			Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21',
			Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105',
			Round(ventascab.totfact * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Total'
		FROM  
			ventascab  	
				left join ventasdet on ventascab.idventasc = ventasdet.idventasc 
				inner join clientes on ventascab.idcliente = clientes.idcliente  
				inner join localidad on clientes.idlocalid = localidad.idlocalid 
				inner join provincias on localidad.idprovin = provincias.idprovin 
				inner join sitiva on clientes.idsitiva = sitiva.idsitiva  
		WHERE   
			ventascab.Cbte NOT IN ('PED','COT','PTO')  AND 
			ventascab.idventasc NOT IN (select idventasc from vtadcp) AND 
			ventascab.fecBaja IS NULL AND 
			ventascab.aut_Resultado = 'A' and 
			YEAR(ventascab.FecEmision) = panio AND
            MONTH(ventascab.FecEmision) = pmes
		GROUP BY 
			ventascab.IdVentasc, 
			ventascab.FecEmision, 
			ventascab.Cbte,
			ventascab.TipoDoc,
			ventascab.PtoVta,
			ventascab.NumCbte,
			clientes.razsoc,
			ventascab.nroDoc,
			provincias.descripcio,
			sitiva.idsitiva,
			ventasdet.IdVentasc,
			ventascab.ImpNeto,
			ventascab.impIIBB,
			ventascab.impIVA21,
			ventascab.impIVA105,
			ventascab.totfact
		UNION 
		SELECT
			ventascab.IdVentasc,  
			ventascab.FecEmision,  
			ventascab.Cbte,  
			ventascab.TipoDoc,  
			ventascab.PtoVta,  
			ventascab.NumCbte,  
			clientes.razsoc as 'Cliente',  
			provincias.descripcio as 'Juris',  
			Case sitiva.idsitiva
				When 1 Then 'RI' 
				When 3 Then 'CF' 
				When 6 Then 'MON' 	
				Else 'EXE'  
			End as 'Cat',  
			ventascab.nroDoc,  0 as 'Grav_3',  
			0 as 'Exen_3',  
			Round(SUM(Case When vtadcp.ivaPor = 21 Then vtadcp.impNeto Else 0 End) * 
				(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21',  
			Round(SUM(Case When vtadcp.ivaPor = 10.5 Then vtadcp.impNeto Else 0 End) * 
				(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105',  
			0 as 'Exen_P',  
			Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB',  
			Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21',  
			Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105',  
			Round(ventascab.totfact * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Total'  
		FROM    
			ventascab  	
				left join vtadcp on ventascab.idventasc = vtadcp.idventasc    
				inner join clientes on ventascab.idcliente = clientes.idcliente    
				inner join localidad on clientes.idlocalid = localidad.idlocalid    
				inner join provincias on localidad.idprovin = provincias.idprovin   
				inner join sitiva on clientes.idsitiva = sitiva.idsitiva  
		WHERE   
			ventascab.Cbte NOT IN ('PED','COT','PTO') AND 
			ventascab.idventasc IN (select idventasc from vtadcp) AND 
			ventascab.fecBaja IS NULL AND 
			ventascab.aut_Resultado = 'A' AND
            YEAR(ventascab.FecEmision) = panio AND
            MONTH(ventascab.FecEmision) = pmes
		GROUP BY  
			ventascab.IdVentasc,
			ventascab.FecEmision,
			ventascab.Cbte,
			ventascab.TipoDoc,
			ventascab.PtoVta,
			ventascab.NumCbte,
			clientes.razsoc,
			ventascab.nroDoc,
			provincias.descripcio,
			sitiva.idsitiva,
			vtadcp.IdVentasc,
			ventascab.ImpNeto,
			ventascab.impIIBB,
			ventascab.impIVA21,
			ventascab.impIVA105,
			ventascab.totfact  
		ORDER BY 	
			fecEmision, 
			tipodoc;
	
	SELECT
		'IVAVTA' AS codigo,
		sum(Grav_P_21) AS totgrav_p21,
		sum(Grav_P_105) AS totgrav_p105,
		sum(IVA_21) AS totiva_21,
		sum(IVA_105) AS totiva_105,
        sum(Total) AS total
	FROM
		tmp_ivavtas;
            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventasdet_abrirPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventasdet_abrirPedido`( _idVentasC int)
begin
	SELECT ventasdet.idVentasC, ventasdet.idVentasD, ventasdet.idArticulo,
		articulos.codArt, articulos.descripcio, ventasdet.cantidad,
		ventasdet.cant_pri1, ventasdet.cant_pri2, ventasdet.cant_falt
	FROM ventasdet
		INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
	WHERE ventasdet.idVentasC =  _idVentasC;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventasdet_ctrlSalidaGrabar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventasdet_ctrlSalidaGrabar`(
	_idVentasD int,
	_idVentasC int,
	_cant_pri1 double,
	_cant_pri2 double,
	_cant_falt double,
	_usuModi varchar(10),
	_idHostModi varchar(50))
begin
	update ventasdet
	set cant_pri1 =  _cant_pri1,
		cant_pri2 =  _cant_pri2,
		cant_falt =  _cant_falt
	where idVentasD = _idVentasD
		and idVentasC = _idVentasC;

	update ventascab
    set ventascab.usuModi = _usuModi,
		ventascab.fecModi = current_timestamp,
        ventascab.idHostModi = _idHostModi
	where ventascab.idVentasC = _idVentasC;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventasdet_getByCab` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventasdet_getByCab`(_idVentasC int)
BEGIN
	SELECT  ventasdet.idventasc,
	        ventasdet.idarticulo,
	        articulos.codart,
	        ventasdet.descripcio,
	        ventasdet.cantidad,
	        ventasdet.prVenta,
		ventasdet.prArtic,
	        ventasdet.pDtoVta1,
	        ventasdet.pDtoVta2,
	        ventasdet.pDtoVta3,
	        ventasdet.pDtoVta4,
	        ventasdet.iDtoVta1,
	        ventasdet.iDtoVta2,
	        ventasdet.iDtoVta3,
	        ventasdet.iDtoVta4,
	        ventasdet.porDesc1,
	        ventasdet.porDesc2,
	        ventasdet.porDesc3,
	        ventasdet.porDesc4,
	        ventasdet.impDesc1,
	        ventasdet.impDesc2,
	        ventasdet.impDesc3,
	        ventasdet.impDesc4,
	        ventasdet.alicIVA,
	        ventasdet.impIVA,
	        ventasdet.impNeto,
	        ventasdet.totNeto,
	        ventasdet.subTotal,
	        marcas.descripcio AS marca
	FROM    ventasdet 
	INNER JOIN articulos
	   ON ventasdet.idArticulo = articulos.idArticulo
	INNER JOIN marcas 
		ON articulos.idMarca = marcas.idMarca
	WHERE idVentasC =  _idVentasC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventasdet_temp_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventasdet_temp_insert`(
	xidArticulo int,
	xcantidad decimal(20, 2),
	xcantNC decimal(20, 2),
	xcostoRep decimal(20, 2),
	xprArtic decimal(20, 2),
	xprVenta decimal(20, 2),
	xporDesc1 decimal(5, 2),
	xporDesc2 decimal(5, 2),
	xporDesc3 decimal(5, 2),
	xporDesc4 decimal(5, 2),
	ximpDesc1 decimal(20, 2),
	ximpDesc2 decimal(20, 2),
	ximpDesc3 decimal(20, 2),
	ximpDesc4 decimal(20, 2),
	xpDtoVta1 decimal(5, 2),
	xpDtoVta2 decimal(5, 2),
	xpDtoVta3 decimal(5, 2),
	xpDtoVta4 decimal(5, 2),
	xiDtoVta1 decimal(20, 2),
	xiDtoVta2 decimal(20, 2),
	xiDtoVta3 decimal(20, 2),
	xiDtoVta4 decimal(20, 2),
	ximpNeto decimal(20, 2),
	xporNoGrav decimal(20, 2),
	xbaseGrav decimal(20, 2),
	xsubtNoGrav decimal(20, 2),
	xtotNeto decimal(20, 2),
	xalicIVA decimal(5, 2),
	ximpIVA decimal(20, 2),
	xsubTotal decimal(20, 2),
	xnroPart varchar(30),
	xesOferta bit,
	xpRecVta decimal(5, 2),
	xiRecVta decimal(20, 2),
	xUniDesp decimal(20, 2),
	xcantPack decimal(20, 2),
	xcodUM varchar(3),
	xcant_pri1 decimal(20, 2),
	xcant_pri2 decimal(20, 2),
	xcant_pri3 decimal(20, 2),
	xdescripcio varchar(200),
	xcant_falt decimal(20, 2),
	xpRecItem decimal(5, 2),
	xiRecItem decimal(5, 2),
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	DECLARE vMensaje TEXT;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		INSERT INTO log_sps (sp_name, msgerror, usuario, host)
		VALUES ('ventasdet_temp_insert', vMensaje, xusuario, xhost);
		SELECT 0 AS 'result';
	END;

	INSERT INTO ventasdet_tmp (
		idArticulo,
		cantidad,
		cantNC,
		costoRep,
		prArtic,
		prVenta,
		porDesc1,
		porDesc2,
		porDesc3,
		porDesc4,
		impDesc1,
		impDesc2,
		impDesc3,
		impDesc4,
		pDtoVta1,
		pDtoVta2,
		pDtoVta3,
		pDtoVta4,
		iDtoVta1,
		iDtoVta2,
		iDtoVta3,
		iDtoVta4,
		impNeto,
		porNoGrav,
		baseGrav,
		subtNoGrav,
		totNeto,
		alicIVA,
		impIVA,
		subTotal,
		nroPart,
		esOferta,
		pRecVta,
		iRecVta,
		UniDesp,
		cantPack,
		codUM,
		cant_pri1,
		cant_pri2,
		cant_pri3,
		descripcio,
		cant_falt,
		pRecItem,
		iRecItem,
		usuario,
		host)
	VALUES (
		xidArticulo,
		xcantidad,
		xcantNC,
		xcostoRep,
		xprArtic,
		xprVenta,
		xporDesc1,
		xporDesc2,
		xporDesc3,
		xporDesc4,
		ximpDesc1,
		ximpDesc2,
		ximpDesc3,
		ximpDesc4,
		xpDtoVta1,
		xpDtoVta2,
		xpDtoVta3,
		xpDtoVta4,
		xiDtoVta1,
		xiDtoVta2,
		xiDtoVta3,
		xiDtoVta4,
		ximpNeto,
		xporNoGrav,
		xbaseGrav,
		xsubtNoGrav,
		xtotNeto,
		xalicIVA,
		ximpIVA,
		xsubTotal,
		xnroPart,
		xesOferta,
		xpRecVta,
		xiRecVta,
		xUniDesp,
		xcantPack,
		xcodUM,
		xcant_pri1,
		xcant_pri2,
		xcant_pri3,
		xdescripcio,
		xcant_falt,
		xpRecItem,
		xiRecItem,
		xusuario,
		xhost);

	SELECT 1 AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventas_generar_cbtes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventas_generar_cbtes`(
	xidCliente	int(11),
	xidCondPago	int(11),
	xidSitIVA	int(11),
	xidVendedor	int(11),
	xfecEmision	datetime,
	xfecVto		datetime,
	xcbte		varchar(3),
	xtipoDoc	varchar(1),
	xptoVta		int(11),
	xnumCbte	int(11),
	ximpNeto	decimal(20, 2),
	ximpFinal	decimal(20, 2),
	xporIVA21	decimal(5, 2),
	ximpIVA21	decimal(20, 2),
	xporIVA105	decimal(5, 2),
	ximpIVA105	decimal(20, 2),
	xporIIBB	decimal(5, 2),
	ximpIIBB	decimal(20, 2),
	xporDesc1	decimal(5, 2),
	ximpDesc1	decimal(20, 2),
	xporDesc2	decimal(5, 2),
	ximpDesc2	decimal(20, 2),
	xporDesc3	decimal(5, 2),
	ximpDesc3	decimal(20, 2),
	xporDesc4	decimal(5, 2),
	ximpDesc4	decimal(20, 2),
	xporRec		decimal(5, 2),
	ximpRec		decimal(5, 2),
	xtotaNoGrav	decimal(20,2),
	xtotFact	decimal(20, 2),
	xsaldo		decimal(20, 2),
	xusuario	varchar(5),
	xhost		varchar(50),
	xidTipoDoc	int,
	xnroDoc		varchar(20),
	xrazSoc		varchar(60)
)
BEGIN
	DECLARE vMensaje TEXT;
	DECLARE vProxID int;
	DECLARE vProxIdItems int;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		INSERT INTO log_sps (sp_name, msgerror, usuario, host)
		VALUES ('ventas_generar_cbtes', vMensaje, xusuario, xhost);
		SELECT '0' AS 'result', vMensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	
	-- Calculo el prÃ³ximo Id. de venta.
	SELECT
		CASE WHEN MAX(idVentasC) IS NULL THEN 1 ELSE MAX(idVentasC) + 1 END
	INTO
		vProxId
	FROM
		ventascab;
		
	-- Hago el INSERT INTO de la cabecera
	INSERT INTO ventascab (
		idVentasC,
		idCliente,
		idCondPago,
		idSitIVA,
		idVendedor,
		fecEmision,
		fecVto,
		cbte,
		tipoDoc,
		ptoVta,
		numCbte,
		impNeto,
		impFinal,
		porIVA21,
		impIVA21,
		porIVA105,
		impIVA105,
		porIIBB,
		impIIBB,
		porDesc1,
		impDesc1,
		porDesc2,
		impDesc2,
		porDesc3,
		impDesc3,
		porDesc4,
		impDesc4,
		porRec,
		impRec,
		totaNoGrav,
		totFact,
		saldo,
		usuAlta,
		fecAlta,
		idHostAlta,
		idTipoDoc,
		nroDoc,
		anulado,
		razSoc)
	VALUES (
		vProxID,
		xidCliente,
		xidCondPago,
		xidSitIVA,
		xidVendedor,
		xfecEmision,
		xfecVto,
		xcbte,
		xtipoDoc,
		xptoVta,
		xnumCbte,
		ximpNeto,
		ximpFinal,
		xporIVA21,
		ximpIVA21,
		xporIVA105,
		ximpIVA105,
		xporIIBB,
		ximpIIBB,
		xporDesc1,
		ximpDesc1,
		xporDesc2,
		ximpDesc2,
		xporDesc3,
		ximpDesc3,
		xporDesc4,
		ximpDesc4,
		xporRec,
		ximpRec,
		xtotaNoGrav,
		xtotFact,
		xsaldo,
		xusuario,
		current_timestamp,
		xhost,
		xidTipoDoc,
		xnroDoc,
		0,
		xrazSoc);	
		
	/* Genero el detalle del comprobante.*/
		
	-- Inserto los Ã­tems a partir de la tabla temporal
	-- En la tabla temporal ya se cargan todos los datos calculados.
	INSERT INTO ventasdet (
		idVentasD,
		idVentasC,
		idArticulo,
		cantidad,
		cantNC,
		costoRep,
		prArtic,
		prVenta,
		porDesc1,
		porDesc2,
		porDesc3,
		porDesc4,
		impDesc1,
		impDesc2,
		impDesc3,
		impDesc4,
		pDtoVta1,
		pDtoVta2,
		pDtoVta3,
		pDtoVta4,
		iDtoVta1,
		iDtoVta2,
		iDtoVta3,
		iDtoVta4,
		impNeto,
		porNoGrav,
		baseGrav,
		subtNoGrav,
		totNeto,
		alicIVA,
		impIVA,
		subTotal,
		nroPart,
		esOferta,
		pRecVta,
		iRecVta,
		UniDesp,
		cantPack,
		codUM,
		cant_pri1,
		cant_pri2,
		cant_pri3,
		descripcio,
		cant_falt,
		pRecItem,
		iRecItem) 
			SELECT
				(@id := @id + 1),
				vProxID,
				idArticulo,
				cantidad,
				cantNC,
				costoRep,
				prArtic,
				prVenta,
				porDesc1,
				porDesc2,
				porDesc3,
				porDesc4,
				impDesc1,
				impDesc2,
				impDesc3,
				impDesc4,
				pDtoVta1,
				pDtoVta2,
				pDtoVta3,
				pDtoVta4,
				iDtoVta1,
				iDtoVta2,
				iDtoVta3,
				iDtoVta4,
				impNeto,
				porNoGrav,
				baseGrav,
				subtNoGrav,
				totNeto,
				alicIVA,
				impIVA,
				subTotal,
				nroPart,
				esOferta,
				pRecVta,
				iRecVta,
				UniDesp,
				cantPack,
				codUM,
				cant_pri1,
				cant_pri2,
				cant_pri3,
				descripcio,
				cant_falt,
				pRecItem,
				iRecItem
			FROM
				(
					SELECT
						@id := 0,
						idArticulo,
						cantidad,
						cantNC,
						costoRep,
						prArtic,
						prVenta,
						porDesc1,
						porDesc2,
						porDesc3,
						porDesc4,
						impDesc1,
						impDesc2,
						impDesc3,
						impDesc4,
						pDtoVta1,
						pDtoVta2,
						pDtoVta3,
						pDtoVta4,
						iDtoVta1,
						iDtoVta2,
						iDtoVta3,
						iDtoVta4,
						impNeto,
						porNoGrav,
						baseGrav,
						subtNoGrav,
						totNeto,
						alicIVA,
						impIVA,
						subTotal,
						nroPart,
						esOferta,
						pRecVta,
						iRecVta,
						UniDesp,
						cantPack,
						codUM,
						cant_pri1,
						cant_pri2,
						cant_pri3,
						descripcio,
						cant_falt,
						pRecItem,
						iRecItem
					FROM
						ventasdet_tmp
					WHERE
						host = xhost) ventasdet_tmp;
				
	COMMIT;
	SELECT vProxID AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventas_getByTipoPago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventas_getByTipoPago`(_fechaDesde DATE, _fechaHasta DATE,_tipoPago int)
BEGIN
		SELECT clientes.idcliente, clientes.razSoc, rccob_c.nroRec, rccob_c.fecAlta, rccob_c.usuAlta, rccob_c.idHostAlta, tipospagos.descripcio, rccob_d.importe
	FROM rccob_c
		INNER JOIN rccob_d ON rccob_c.idRCCob_C = rccob_d.idRCCob_C 
		INNER JOIN clientes ON rccob_c.idCliente = clientes.idCliente
		INNER JOIN tipospagos ON rccob_d.tipopago = tipospagos.codTipoPag
	WHERE rccob_c.fecEmis BETWEEN _fechaDesde AND _fechaHasta
			AND (
			_tipoPago = 0 -- TODOS
			OR tipospagos.idTipoPago = _tipoPago)
			AND rccob_c.fecBaja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventas_getFCByArtCli` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventas_getFCByArtCli`(
    xIdArticulo int,
    xFechaDD datetime,
    xFechaHH datetime,
    xIdCliente int
)
BEGIN
	SELECT	
		ventascab.idVentasC,
		ventascab.fecEmision AS fecemis,
		ventascab.idCliente,
		ventascab.razSoc,
		CONCAT(REPEAT('0', 4 - LENGTH(ventascab.ptoVta)), ventascab.ptoVta) AS ptoVta,
		CONCAT(REPEAT('0', 8 - LENGTH(ventascab.numcbte)), ventascab.numcbte) AS numCbte,
		ventascab.totFact,
		ventascab.observ,
		ventascab.nroDoc
	FROM
		ventasdet
			INNER JOIN ventascab ON ventascab.idVentasC = ventasdet.idVentasC
	WHERE
		ventasdet.idArticulo = xIdArticulo AND
		ventascab.cbte = 'FC' AND
		ventascab.fecEmision BETWEEN xFechaDD AND xFechaHH AND
		CASE WHEN xidCliente = 0 THEN 1 ELSE ventascab.idCliente = xidCliente END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventas_getRankingGeneral` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventas_getRankingGeneral`(
    IN _fechaDesde DATE,
    IN _fechaHasta DATE,
    IN _indicador INT,    -- 1:Cliente, 2:Proveedor, 3:Marca, 4:Subfamilia, 5:Artículo
    IN _detallarMes INT,  -- 0: Total general, 1: Apertura por mes
    IN _idArticulo INT    -- 0 para todos, o ID específico para filtrar
)
BEGIN
    SELECT 
        -- Identificador dinámico según el indicador seleccionado
        CASE 
            WHEN _indicador = 1 THEN vc.idCliente
            WHEN _indicador = 2 THEN art.idProv
            WHEN _indicador = 3 THEN art.idMarca
            WHEN _indicador = 4 THEN art.idSubFam
            WHEN _indicador = 5 THEN vd.idArticulo
        END AS id_entidad,

        -- Descripción dinámica para el reporte
        CASE 
            WHEN _indicador = 1 THEN vc.razSoc
            WHEN _indicador = 2 THEN prov.razSoc
            WHEN _indicador = 3 THEN mrc.descripcio
            WHEN _indicador = 4 THEN sf.descripcio
            WHEN _indicador = 5 THEN vd.descripcio
        END AS descripcion_entidad,

        -- Apertura por mes (retorna 0 si no se solicita detalle)
        IF(_detallarMes = 1, MONTH(vc.fecEmision), 0) AS mes_comercial,
        IF(_detallarMes = 1, YEAR(vc.fecEmision), 0) AS anio_comercial,

        -- Cálculo: Suma de netos, restando Notas de Crédito por Devolución [1]
        SUM(CASE 
            WHEN vc.cbte = 'NC' THEN -vd.totNeto 
            ELSE vd.totNeto 
        END) AS total_importe_neto,

        -- Conteo de unidades físicas
        SUM(CASE 
            WHEN vc.cbte = 'NC' THEN -vd.cantidad 
            ELSE vd.cantidad 
        END) AS total_unidades

    FROM ventascab vc
    INNER JOIN ventasdet vd ON vc.idVentasC = vd.idVentasC
    INNER JOIN articulos art ON vd.idArticulo = art.idArticulo
    LEFT JOIN proveedor prov ON art.idProv = prov.idProv
    LEFT JOIN marcas mrc ON art.idMarca = mrc.idMarca
    LEFT JOIN subfam sf ON art.idSubFam = sf.idSubFam

    WHERE vc.fecEmision BETWEEN _fechaDesde AND _fechaHasta
      AND vc.fecBaja IS NULL -- Solo registros activos [2]
      AND vc.anulado = 0     -- Excluir comprobantes anulados
      -- Filtro por artículo específico si fue cargado en el formulario [1]
      AND (CASE WHEN _idArticulo = 0 THEN 1 ELSE vd.idArticulo = _idArticulo END)

    GROUP BY 
        id_entidad, 
        descripcion_entidad,
        IF(_detallarMes = 1, mes_comercial, 1),
        IF(_detallarMes = 1, anio_comercial, 1)

    ORDER BY 
        anio_comercial DESC, 
        mes_comercial DESC, 
        total_importe_neto DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventas_restar_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventas_restar_stock`(
	xidVentaC int,
	xusuario varchar(5),
	xhost varchar(50),
	xautoTransaction bit)
BEGIN
	DECLARE vMensaje TEXT;
	DECLARE vidStkCab int;
	DECLARE vCbte varchar(3);
	DECLARE vtipoDoc varchar(1);
	DECLARE vnumCbte varchar(20);
	DECLARE vidCliente int;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		IF xautoTransaction = 1 THEN
			ROLLBACK;
		END IF;
	
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		INSERT INTO log_sps (sp_name, msgerror, usuario, host)
		VALUES ('ventas_restar_stock', vMensaje, xusuario, xhost);
		SELECT '0' AS 'result';
	END;
	
	IF xautoTransaction = 1 THEN
		START TRANSACTION;
	END IF;
	
	-- Caclulo el prÃ³ximo Id. de cabecera de stock
	SELECT
		CASE WHEN MAX(idStkCab) IS NULL THEN 1 ELSE MAX(idStkCab) + 1 END
	INTO
		vidStkCab
	FROM
		stk_cab;
	
	-- Recupero los datos que necesito de la tabla de ventas.
	SELECT
		cbte, 
		tipoDoc, 	
		CONCAT(REPEAT('0', 5 - length(ptoVta)), ptoVta, '-', REPEAT('0', 8 - LENGTH(numCbte)), numCbte) AS numCbte, 
		idCliente
	INTO
		vCbte, 
		vtipoDoc, 
		vnumCbte, 
		vidCliente
	FROM
		ventascab
	WHERE
		ventascab.idVentasC = xidVentaC;
			
	-- Genero el registro de cabecera de stock
	INSERT INTO stk_cab (
		idStkCab, circuito, cbte, tipoDoc, numCbte, idCliente, usuAlta, fecAlta, idHostAlta)
	VALUES (
		vidStkCab, 'V', vCbte, vtipoDoc, vnumCbte, vidCliente, xusuario, current_timestamp, xhost);
	
	-- Recupero los Ã­tems.
	INSERT INTO stk_det (
		idStkDet, idStkCab, idArticulo, idStkDep,
		tipoMov, cantidad, costoRep, nroPart)
			SELECT
				ventasdet.idVentasD, vidStkCab AS idStkCab, ventasdet.idArticulo, art_dep.idStkDep,
				'SAL', ventasdet.cantidad * -1, articulos.costoRep, '' AS nroPart
			FROM
				ventasdet
					INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
					INNER JOIN art_dep ON art_dep.idArticulo = ventasdet.idArticulo
			WHERE
				ventasdet.idVentasC = xidVentaC;
				
	IF xautoTransaction = 1 THEN
		COMMIT;
	END IF;
	SELECT '1' AS 'result';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ventas_setcae` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `ventas_setcae`(
	xidventac int, 
	xptoVta int, 
	xnumcbte int, 
	xaut_CAE varchar(15),
	xaut_CAE_Vto datetime, 
	xaut_Resultado varchar(1), 
	xaut_Motivo varchar(254),
	xaut_tipoCbte varchar(2), 
	xaut_qr varchar(255))
BEGIN
	DECLARE vMensaje TEXT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
	
		-- Guardo el log en el SP.
		INSERT INTO log_sps (
			sp_name, msgerror, usuario, host)
		VALUES (
			'ventas_generar_cbtes', vMensaje, xusuario, xhost);	
	END;
	
	START TRANSACTION;
	
	UPDATE ventascab
	SET
		ventascab.ptoVta = xptoVta, 
		ventascab.numCbte = xnumcbte,
		ventascab.aut_CAE = xaut_CAE, 
		ventascab.aut_CAE_VTO = xaut_CAE_Vto,
		ventascab.aut_Resultado = xaut_Resultado, 
		ventascab.aut_Motivo = xaut_Motivo,
		ventascab.aut_tipoCbte = xaut_tipoCbte, 
		ventascab.aut_qr = xaut_qr,
		ventascab.fecEmision = CAST(current_timestamp AS DATE)
	WHERE
		ventascab.idVentasC = xidventac;
	
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vtadcp_getByCab` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `vtadcp_getByCab`( _idVentasC int)
begin
	select vtadcp.*,
		planctas.codPlanCta,
	        planctas.descripcio
	from vtadcp
		inner join planctas on planctas.idPlanCta = vtadcp.idPlanCta
	where idVentasC = _idVentasC;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vtasrtos_generar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `vtasrtos_generar`(
	xidVentasC int,
	xidTransp int,
	xidNum int,
	xfecha datetime,
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	DECLARE vProxID int;
	DECLARE vCodTrans int;
	DECLARE vrazSocTrn varchar(60);
	DECLARE vnrocomp varchar(20);
	DECLARE vcantItems int;
	DECLARE vnumCbte int;
	DECLARE vCbte varchar(3);
	DECLARE vTipoDoc varchar(1);
	DECLARE vPtoVta int;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 @mensaje = MESSAGE_TEXT;
		SELECT @mensaje AS 'result';
	END;
	
	/* Recupero los datos del transporte */
	SELECT
		codTrans, razSoc
	INTO
		vCodTrans, vrazSocTrn
	FROM
		transp
	WHERE
		transp.idTransp = xidTransp;
		
	/* Obtengo la cantidad de items que tiene el remito */
	SELECT
		COUNT(*)
	INTO
		vcantItems
	FROM
		ventasdet
	WHERE
		ventasdet.idVentasC = xidVentasC;
		
	/* 
		Obtengo el proximo id de remito por comprobante seleccionado.
		Tener en cuenta que empiza de 1 por cbte porque es clave primaria compuesta.
	*/
	SELECT
		CASE WHEN MAX(vtasrtos.idVtaRto) IS NULL THEN 1 ELSE MAX(vtasrtos.idVtaRto) + 1 END
	INTO
		vProxID
	FROM
		vtasrtos
	WHERE
		vtasrtos.idVentasC = xidVentasC;
		
	/* Calculo el proximo numero de remito */
	SELECT
		numerador.cbte,
		numerador.tipoDoc,
		numerador.ptoVta,
		numerador.numActual + 1
	INTO
		vCbte,
		vTipoDoc,
		vPtoVta,
		vnumCbte
	FROM
		numerador
	WHERE
		numerador.idNum = xidNum;
		
	SET vnrocomp = CONCAT(
		vCbte, ' ', 
		vTipoDoc, ' ', 
		REPEAT('0', 5 - LENGTH(vPtoVta)), vPtoVta, '-', 
		REPEAT('0', 8 - LENGTH(vnumCbte)), vnumCbte);
	
	START TRANSACTION;
		/* Grabo el registro del remito */
	
		INSERT INTO vtasrtos (
			idVtaRto, idVentasC, idTransp, codTrans, razSocTrn, fecha, cbte, tipoDoc, ptoVta,
			numCbte, nrocomp, cantItems, usuAlta, fecAlta, idHostAlta)
		VALUES (
			vProxID, xidVentasC, xidTransp, vCodTrans, vrazSocTrn, xfecha, vCbte, vTipoDoc, vPtoVta,
			vnumCbte, vnrocomp, vcantItems, xusuario, current_timestamp, xhost
		);
		
		/* Actualizo el numero de remito */
		UPDATE
			numerador
		SET
			numerador.numActual = vnumCbte
		WHERE
			numerador.idNum = xidNum;
	COMMIT;
	
	SET @mensaje = 'OK';
	SELECT @mensaje AS 'result', vnrocomp as 'nro_rto';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vtasrtos_generar_c2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `vtasrtos_generar_c2`(
	xidVentasC int,
	xidTransp int,
	xcbte varchar(3),
	xtipoDoc varchar(1),
	xptoVta int,
	xnumCbte int,
	xfecha datetime,
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	DECLARE vProxID int;
	DECLARE vCodTrans int;
	DECLARE vrazSocTrn varchar(60);
	DECLARE vnrocomp varchar(20);
	DECLARE vcantItems int;
	DECLARE vnumCbte int;
	DECLARE vCbte varchar(3);
	DECLARE vTipoDoc varchar(1);
	DECLARE vPtoVta int;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @mensaje = MESSAGE_TEXT;
		SELECT @mensaje AS 'result';
	END;
	 
	/* Recupero los datos del transporte */
	SELECT
		codTrans, razSoc
	INTO
		vCodTrans, vrazSocTrn
	FROM
		transp
	WHERE
		transp.idTransp = xidTransp;
		
	/* Obtengo la cantidad de items que tiene el remito */
	SELECT
		COUNT(*)
	INTO
		vcantItems
	FROM
		ventasdet
	WHERE
		ventasdet.idVentasC = xidVentasC;
		
	/* 
		Obtengo el proximo id de remito por comprobante seleccionado.
		Tener en cuenta que empiza de 1 por cbte porque es clave primaria compuesta.
	*/
	SELECT
		CASE WHEN MAX(vtasrtos.idVtaRto) IS NULL THEN 1 ELSE MAX(vtasrtos.idVtaRto) + 1 END
	INTO
		vProxID
	FROM
		vtasrtos
	WHERE
		vtasrtos.idVentasC = xidVentasC;
	
	/* Armo el nÃºmero completo */
	SET vnrocomp = CONCAT(
		xcbte, ' ', 
		xtipoDoc, ' ', 
		REPEAT('0', 5 - LENGTH(xptoVta)), xptoVta, '-', 
		REPEAT('0', 8 - LENGTH(xnumCbte)), xnumCbte);
	
	/* Grabo el registro del remito */
	INSERT INTO vtasrtos (
		idVtaRto, idVentasC, idTransp, codTrans, razSocTrn, fecha, cbte, tipoDoc, ptoVta,
		numCbte, nrocomp, cantItems, usuAlta, fecAlta, idHostAlta)
	VALUES (
		vProxID, xidVentasC, xidTransp, vCodTrans, vrazSocTrn, xfecha, xcbte, xtipoDoc, xptoVta,
		xnumCbte, vnrocomp, vcantItems, xusuario, current_timestamp, xhost
	);
	
	SET @mensaje = 'OK';
	SELECT @mensaje AS 'result', vnrocomp as 'nro_rto';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-10 10:20:24
