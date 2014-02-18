SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

USE `WTFDIET_DEV`;

DROP TABLE IF EXISTS `ADAPT`;
CREATE TABLE `ADAPT` (
  `id_recipe` int(11) NOT NULL,
  `id_ambiance` int(11) NOT NULL,
  PRIMARY KEY (`id_recipe`,`id_ambiance`),
  KEY `id_ambiance` (`id_ambiance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `AMBIANCE`;
CREATE TABLE `AMBIANCE` (
  `id_ambiance` int(11) NOT NULL AUTO_INCREMENT,
  `slug_ambiance` varchar(100) NOT NULL,
  `name_ambiance` varchar(100) NOT NULL,
  PRIMARY KEY (`id_ambiance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `COMMENT`;
CREATE TABLE `COMMENT` (
  `id_recipe` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_comment` int(11) NOT NULL,
  `content_comment` text NOT NULL,
  `dateAdd_comment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateUpdate_comment` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id_recipe`,`id_user`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `COMPOSE`;
CREATE TABLE `COMPOSE` (
  `id_ingredient` int(11) NOT NULL,
  `id_recipe` int(11) NOT NULL,
  `quantity_ingredient` int(5) NOT NULL,
  `measure_ingredient` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_ingredient`,`id_recipe`),
  KEY `id_recipe` (`id_recipe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `INGREDIENT`;
CREATE TABLE `INGREDIENT` (
  `id_ingredient` int(11) NOT NULL AUTO_INCREMENT,
  `slug_ingredient` varchar(100) NOT NULL,
  `name_ingredient` varchar(100) NOT NULL,
  `kcal_ingredient` int(5) NOT NULL,
  PRIMARY KEY (`id_ingredient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `MEDIA`;
CREATE TABLE `MEDIA` (
  `id_media` int(11) NOT NULL AUTO_INCREMENT,
  `slug_media` varchar(100) NOT NULL,
  `type_media` varchar(50) NOT NULL,
  `url_media` text,
  `name_media` varchar(100) NOT NULL,
  `dateAdd_media` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_media`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `RECIPE`;
CREATE TABLE `RECIPE` (
  `id_recipe` int(11) NOT NULL AUTO_INCREMENT,
  `slug_recipe` varchar(50) NOT NULL,
  `name_recipe` varchar(50) NOT NULL,
  `numberOfPeople_recipe` int(11) NOT NULL,
  `preparationTime_recipe` int(11) NOT NULL,
  `difficulty_recipe` int(1) NOT NULL DEFAULT '1',
  `dateAdd_recipe` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateUpdate_recipe` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id_recipe`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `STEP`;
CREATE TABLE `STEP` (
  `id_step` int(11) NOT NULL AUTO_INCREMENT,
  `order_step` int(5) NOT NULL,
  `content_step` text NOT NULL,
  `id_recipe` int(11) NOT NULL,
  PRIMARY KEY (`id_step`),
  KEY `id_recipe` (`id_recipe`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `USE`;
CREATE TABLE `USE` (
  `id_ustensil` int(11) NOT NULL,
  `id_recipe` int(11) NOT NULL,
  PRIMARY KEY (`id_ustensil`,`id_recipe`),
  KEY `id_recipe` (`id_recipe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `USER`;
CREATE TABLE `USER` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `slug_user` varchar(100) NOT NULL,
  `adminLevel_user` int(1) NOT NULL DEFAULT '0',
  `firstname_user` varchar(50) NOT NULL,
  `lastname_user` varchar(50) NOT NULL,
  `mail_user` varchar(100) NOT NULL,
  `password_user` varchar(100) NOT NULL,
  `karmaPoints_user` int(11) DEFAULT NULL,
  `facebookId_user` int(50) DEFAULT NULL,
  `subscribeDate_user` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastLogin_user` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `USTENSIL`;
CREATE TABLE `USTENSIL` (
  `id_ustensil` int(11) NOT NULL AUTO_INCREMENT,
  `name_ustensil` varchar(50) NOT NULL,
  PRIMARY KEY (`id_ustensil`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


ALTER TABLE `ADAPT`
  ADD CONSTRAINT `adapt_ibfk_2` FOREIGN KEY (`id_ambiance`) REFERENCES `AMBIANCE` (`id_ambiance`),
  ADD CONSTRAINT `adapt_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `RECIPE` (`id_recipe`);

ALTER TABLE `COMMENT`
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `USER` (`id_user`),
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `RECIPE` (`id_recipe`);

ALTER TABLE `COMPOSE`
  ADD CONSTRAINT `compose_ibfk_2` FOREIGN KEY (`id_recipe`) REFERENCES `RECIPE` (`id_recipe`),
  ADD CONSTRAINT `compose_ibfk_1` FOREIGN KEY (`id_ingredient`) REFERENCES `INGREDIENT` (`id_ingredient`);

ALTER TABLE `RECIPE`
  ADD CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `USER` (`id_user`);

ALTER TABLE `STEP`
  ADD CONSTRAINT `step_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `RECIPE` (`id_recipe`);

ALTER TABLE `USE`
  ADD CONSTRAINT `use_ibfk_2` FOREIGN KEY (`id_recipe`) REFERENCES `RECIPE` (`id_recipe`),
  ADD CONSTRAINT `use_ibfk_1` FOREIGN KEY (`id_ustensil`) REFERENCES `USTENSIL` (`id_ustensil`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
