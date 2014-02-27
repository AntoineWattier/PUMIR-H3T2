# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Hôte: 127.0.0.1 (MySQL 5.6.16)
# Base de données: WTFDIET
# Temps de génération: 2014-02-27 17:05:05 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Affichage de la table USER
# ------------------------------------------------------------

DROP TABLE IF EXISTS `USER`;

CREATE TABLE `USER` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `slug_user` varchar(100) NOT NULL,
  `adminLevel_user` int(1) NOT NULL DEFAULT '0',
  `firstname_user` varchar(50) NOT NULL,
  `lastname_user` varchar(50) NOT NULL,
  `mail_user` varchar(100) NOT NULL,
  `password_user` varchar(100) DEFAULT NULL,
  `bio_user` text,
  `urlImage_user` varchar(255) DEFAULT NULL,
  `karmaPoints_user` int(11) DEFAULT NULL,
  `facebookId_user` varchar(50) DEFAULT NULL,
  `instagramId_user` varchar(50) DEFAULT NULL,
  `subscribeDate_user` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastLogin_user` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `USER` WRITE;
/*!40000 ALTER TABLE `USER` DISABLE KEYS */;

INSERT INTO `USER` (`id_user`, `slug_user`, `adminLevel_user`, `firstname_user`, `lastname_user`, `mail_user`, `password_user`, `bio_user`, `urlImage_user`, `karmaPoints_user`, `facebookId_user`, `instagramId_user`, `subscribeDate_user`, `lastLogin_user`)
VALUES
	(1,'antoine-wattier',0,'Antoine','WATTIER','wattier.antoine@gmail.com','test','',NULL,NULL,NULL,NULL,'2014-02-19 16:36:22','2014-02-27 17:29:04'),
	(2,'laure-boutmy',0,'Laure','Boutmy','laureboutmy@gmail.com','test','',NULL,NULL,NULL,NULL,'2014-02-19 18:35:23','2014-02-21 23:03:56'),
	(6,'hugo-m',0,'Hugo','M','hugomingoia@gmail.com','untrucbidon','',NULL,NULL,NULL,NULL,'2014-02-21 10:03:38','0000-00-00 00:00:00'),
	(7,'valentin-beunard',0,'Valentin','Beunard','beunard@gmail.c','test','',NULL,NULL,NULL,NULL,'2014-02-21 11:23:01','2014-02-21 11:31:42'),
	(8,'antoine-wattier',0,'Antoine','WATTIER','wattier.antoine@gmail.com','azerty','',NULL,NULL,NULL,NULL,'2014-02-21 12:53:20','0000-00-00 00:00:00'),
	(33,'antoine-wattier',0,'Antoine','Wattier','wattier.antoine@gmail.com',NULL,'',NULL,NULL,'100001487385616',NULL,'2014-02-23 11:01:23','2014-02-27 17:22:58'),
	(34,'test-test',0,'Test','TEST','test@tes',NULL,NULL,NULL,NULL,NULL,NULL,'2014-02-27 17:23:31','0000-00-00 00:00:00');

/*!40000 ALTER TABLE `USER` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
