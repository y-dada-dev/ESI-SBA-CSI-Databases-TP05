-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    
-- ------------------------------------------------------
-- Server version	5.7.14-log

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
-- Table structure for table `achat`
--

DROP TABLE IF EXISTS `achat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `achat` (
  `IdAchat` int(11) NOT NULL,
  `IdLivre` varchar(10) NOT NULL,
  `IdLib` int(11) NOT NULL,
  `IdClient` int(11) NOT NULL,
  `DateAchat` date DEFAULT NULL,
  `Quantite` int(11) DEFAULT NULL,
  PRIMARY KEY (`IdAchat`),
  KEY `fk_Achat_Livre1_idx` (`IdLivre`),
  KEY `fk_Achat_Librairie1_idx` (`IdLib`),
  KEY `fk_Achat_Client1_idx` (`IdClient`),
  CONSTRAINT `fk_Achat_Client1` FOREIGN KEY (`IdClient`) REFERENCES `client` (`IdClient`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Achat_Librairie1` FOREIGN KEY (`IdLib`) REFERENCES `librairie` (`IdLib`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Achat_Livre1` FOREIGN KEY (`IdLivre`) REFERENCES `livre` (`IdLivre`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achat`
--

LOCK TABLES `achat` WRITE;
/*!40000 ALTER TABLE `achat` DISABLE KEYS */;
INSERT INTO `achat` VALUES (1,'ISBN326845',1,1,'2016-05-10',2),(2,'ISBN658625',1,1,'2016-05-10',1),(3,'ISBN549215',1,2,'2016-09-12',1),(4,'ISBN658622',1,2,'2016-09-11',1),(5,'ISBN659552',1,2,'2016-09-11',2),(6,'ISBN597546',1,3,'2016-12-12',1),(7,'ISBN692324',1,3,'2016-12-12',1),(8,'ISBN568464',1,3,'2016-12-12',1),(9,'ISBN568464',1,1,'2016-05-10',1),(10,'ISBN659552',1,3,'2016-07-05',2),(11,'ISBN968236',1,4,'2016-08-12',1),(12,'ISBN568464',1,4,'2016-04-12',2),(13,'ISBN658625',1,4,'2016-04-12',1),(14,'ISBN326845',1,4,'2016-04-12',1),(15,'ISBN968236',1,5,'2016-05-12',3),(16,'ISBN556559',1,6,'2016-03-12',1),(17,'ISBN549215',1,5,'2016-05-12',1),(18,'ISBN692324',1,6,'2016-03-12',2),(19,'ISBN625833',1,7,'2016-12-31',1),(20,'ISBN664258',2,7,'2016-05-03',3);
/*!40000 ALTER TABLE `achat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auteur`
--

DROP TABLE IF EXISTS `auteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auteur` (
  `IdAuteur` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `prenom` varchar(45) DEFAULT NULL,
  `nationalité` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdAuteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auteur`
--

LOCK TABLES `auteur` WRITE;
/*!40000 ALTER TABLE `auteur` DISABLE KEYS */;
INSERT INTO `auteur` VALUES (1,'rafik','said','Algérie'),(2,'moussa','karim','algérie'),(3,'fabien','goblet','france'),(4,'michel','dirix','france'),(5,'rachid','bilel','algérie'),(6,'souad','aicha','algérie'),(7,'assad','mohamed','algérie'),(8,'hafed','djilalie','algérie'),(9,'antonio','max','france'),(10,'jean','moureux','france'),(11,'ali','mohamed','algérie');
/*!40000 ALTER TABLE `auteur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `IdClient` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `prenom` varchar(45) DEFAULT NULL,
  `contact` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'karim','fouad','0778954578'),(2,'ouafi','jalil','0770126587'),(3,'rachid','mohamed','0659569874'),(4,'nouri','bachir','0699456575'),(5,'tarek','nasim','0597126589'),(6,'maleh','rafik','0798563212'),(7,'bouayade',' bachir','0598563214');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ecrit`
--

DROP TABLE IF EXISTS `ecrit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecrit` (
  `IdLivre` varchar(10) NOT NULL,
  `IdAuteur` int(11) NOT NULL,
  PRIMARY KEY (`IdLivre`,`IdAuteur`),
  KEY `fk_Livre_has_Auteur_Auteur1_idx` (`IdAuteur`),
  KEY `fk_Livre_has_Auteur_Livre1_idx` (`IdLivre`),
  CONSTRAINT `fk_Livre_has_Auteur_Auteur1` FOREIGN KEY (`IdAuteur`) REFERENCES `auteur` (`IdAuteur`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livre_has_Auteur_Livre1` FOREIGN KEY (`IdLivre`) REFERENCES `livre` (`IdLivre`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecrit`
--

LOCK TABLES `ecrit` WRITE;
/*!40000 ALTER TABLE `ecrit` DISABLE KEYS */;
INSERT INTO `ecrit` VALUES ('ISBN326845',1),('ISBN549215',2),('ISBN658622',2),('ISBN326845',3),('ISBN597546',3),('ISBN968236',3),('ISBN658622',4),('ISBN659552',4),('ISBN322345',5),('ISBN664258',5),('ISBN978256',5),('ISBN316645',6),('ISBN568464',7),('ISBN597546',8),('ISBN625833',9),('ISBN692324',9),('ISBN978256',9),('ISBN556559',10),('ISBN658625',11);
/*!40000 ALTER TABLE `ecrit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editeur`
--

DROP TABLE IF EXISTS `editeur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editeur` (
  `IdEditeur` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `pays` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`IdEditeur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editeur`
--

LOCK TABLES `editeur` WRITE;
/*!40000 ALTER TABLE `editeur` DISABLE KEYS */;
INSERT INTO `editeur` VALUES (1,'DUNOD','france'),(2,'Eni','France'),(3,'Pearson','Algérie');
/*!40000 ALTER TABLE `editeur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `librairie`
--

DROP TABLE IF EXISTS `librairie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `librairie` (
  `IdLib` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `ville` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdLib`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `librairie`
--

LOCK TABLES `librairie` WRITE;
/*!40000 ALTER TABLE `librairie` DISABLE KEYS */;
INSERT INTO `librairie` VALUES (1,'houda','sba'),(2,'mibrass','oran');
/*!40000 ALTER TABLE `librairie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livre`
--

DROP TABLE IF EXISTS `livre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `livre` (
  `IdLivre` varchar(10) NOT NULL,
  `titre` varchar(45) DEFAULT NULL,
  `domaine` varchar(45) DEFAULT NULL,
  `NbPages` int(11) DEFAULT NULL,
  `DateEdition` date DEFAULT NULL,
  `IdEditeur` int(11) NOT NULL,
  PRIMARY KEY (`IdLivre`),
  KEY `fk_Livre_Editeur_idx` (`IdEditeur`),
  CONSTRAINT `fk_Livre_Editeur` FOREIGN KEY (`IdEditeur`) REFERENCES `editeur` (`IdEditeur`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livre`
--

LOCK TABLES `livre` WRITE;
/*!40000 ALTER TABLE `livre` DISABLE KEYS */;
INSERT INTO `livre` VALUES ('ISBN316645','Html5 et css3','informatique',580,'2013-05-02',2),('ISBN322345','Probabilité continue','mathématique',600,'2009-12-02',1),('ISBN326845','mathématique appliquée','mathématique',506,'2011-12-02',1),('ISBN549215','NodeJs','informatique',350,'2015-01-02',1),('ISBN556559','Spring en Action','informatique',1100,'2016-05-02',2),('ISBN568464','Statistique','mathématique',580,'2013-10-02',2),('ISBN597546','Logique Mathématique','mathématique',490,'2010-10-02',2),('ISBN625833','JAVA 8','Informatique',460,'2016-10-02',3),('ISBN658622','Oracle 12c','informatique',1200,'2017-01-02',2),('ISBN658625','Php5 et mysql','informatique',450,'2009-05-02',2),('ISBN659552','Analyse différentielle','mathématique',800,'2014-10-02',1),('ISBN664258','Analyse pour le 1 et 2 cycle','Mathématique',900,'2008-10-02',3),('ISBN692324','Big Data','informatique',250,'2016-10-02',1),('ISBN968236','Programmation orientée objet','informatique',900,'2012-05-04',1),('ISBN978256','Développer avec google Map','Informatique',569,'2011-10-02',1);
/*!40000 ALTER TABLE `livre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocklivre`
--

DROP TABLE IF EXISTS `stocklivre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocklivre` (
  `IdLib` int(11) NOT NULL,
  `IdLivre` varchar(10) NOT NULL,
  `prix` int(11) DEFAULT NULL,
  `NB_Exemplaires` int(11) DEFAULT NULL,
  PRIMARY KEY (`IdLib`,`IdLivre`),
  KEY `fk_Librairie_has_Livre_Livre1_idx` (`IdLivre`),
  KEY `fk_Librairie_has_Livre_Librairie1_idx` (`IdLib`),
  CONSTRAINT `fk_Librairie_has_Livre_Librairie1` FOREIGN KEY (`IdLib`) REFERENCES `librairie` (`IdLib`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Librairie_has_Livre_Livre1` FOREIGN KEY (`IdLivre`) REFERENCES `livre` (`IdLivre`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocklivre`
--

LOCK TABLES `stocklivre` WRITE;
/*!40000 ALTER TABLE `stocklivre` DISABLE KEYS */;
INSERT INTO `stocklivre` VALUES (1,'ISBN316645',2500,4),(1,'ISBN326845',4000,4),(1,'ISBN549215',5000,10),(1,'ISBN556559',6500,1),(1,'ISBN568464',3200,7),(1,'ISBN597546',6000,4),(1,'ISBN625833',6000,1),(1,'ISBN658622',9000,0),(1,'ISBN658625',3600,2),(1,'ISBN659552',2300,0),(1,'ISBN664258',3600,5),(1,'ISBN692324',6000,2),(1,'ISBN968236',7000,5),(1,'ISBN978256',4500,0),(2,'ISBN316645',2500,3),(2,'ISBN322345',5000,3),(2,'ISBN326845',4100,3),(2,'ISBN549215',5100,0),(2,'ISBN556559',5000,0),(2,'ISBN568464',3200,7),(2,'ISBN597546',6100,0),(2,'ISBN625833',6000,4),(2,'ISBN658622',8500,1),(2,'ISBN658625',2500,1),(2,'ISBN659552',2300,3),(2,'ISBN664258',3500,2),(2,'ISBN692324',6000,4),(2,'ISBN968236',6500,3),(2,'ISBN978256',4500,2);
/*!40000 ALTER TABLE `stocklivre` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-31 16:10:23
