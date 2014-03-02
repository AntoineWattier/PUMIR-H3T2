# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Hôte: 127.0.0.1 (MySQL 5.6.16)
# Base de données: WTFDIET
# Temps de génération: 2014-03-02 11:07:42 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Affichage de la table adapt
# ------------------------------------------------------------

DROP VIEW IF EXISTS `adapt`;

CREATE TABLE `adapt` (
   `id_ambiance` INT(11) NOT NULL DEFAULT '0',
   `name_ambiance` VARCHAR(100) NOT NULL,
   `id_recipe` INT(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Affichage de la table AMBIANCE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AMBIANCE`;

CREATE TABLE `AMBIANCE` (
  `id_ambiance` int(11) NOT NULL AUTO_INCREMENT,
  `slug_ambiance` varchar(100) NOT NULL,
  `name_ambiance` varchar(100) NOT NULL,
  `description_ambiance` varchar(255) DEFAULT '',
  `urlImage_ambiance` varchar(255) DEFAULT '',
  PRIMARY KEY (`id_ambiance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `AMBIANCE` WRITE;
/*!40000 ALTER TABLE `AMBIANCE` DISABLE KEYS */;

INSERT INTO `AMBIANCE` (`id_ambiance`, `slug_ambiance`, `name_ambiance`, `description_ambiance`, `urlImage_ambiance`)
VALUES
	(1,'repas-leger','Repas léger','Description d\'un repas léger','public/images/assets/repas-leger.png'),
	(2,'repas-rapide','Repas rapide','Description d\'un repas léger','public/images/assets/repas-rapide.png'),
	(3,'saveurs-d-ailleurs','Saveurs d\'ailleurs','Description d\'un repas léger','public/images/assets/repas-ailleurs.png'),
	(4,'repas-vegetarien','Repas végétarien','Description d\'un repas léger','public/images/assets/repas-vegetarien.png'),
	(5,'repas-gourmand','Repas gourmand','Description d\'un repas léger','public/images/assets/repas-gourmand.png');

/*!40000 ALTER TABLE `AMBIANCE` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table associate
# ------------------------------------------------------------

DROP VIEW IF EXISTS `associate`;

CREATE TABLE `associate` (
   `id_ingredient` INT(11) NOT NULL DEFAULT '0',
   `name_ingredient` VARCHAR(100) NOT NULL,
   `id_recipe` INT(11) NOT NULL,
   `quantity_ingredient` VARCHAR(50) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Affichage de la table COMMENT
# ------------------------------------------------------------

DROP TABLE IF EXISTS `COMMENT`;

CREATE TABLE `COMMENT` (
  `id_step` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_comment` int(11) NOT NULL AUTO_INCREMENT,
  `content_comment` text NOT NULL,
  `dateAdd_comment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateUpdate_comment` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id_comment`),
  KEY `id_user` (`id_user`),
  KEY `id_step` (`id_step`),
  CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`id_step`) REFERENCES `STEP` (`id_step`) ON DELETE CASCADE,
  CONSTRAINT `comment_ibfk_4` FOREIGN KEY (`id_user`) REFERENCES `USER` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `COMMENT` WRITE;
/*!40000 ALTER TABLE `COMMENT` DISABLE KEYS */;

INSERT INTO `COMMENT` (`id_step`, `id_user`, `id_comment`, `content_comment`, `dateAdd_comment`, `dateUpdate_comment`)
VALUES
	(5,35,10,'Trop bien','2014-03-01 22:04:26','0000-00-00 00:00:00'),
	(5,35,11,'J\'aime pas l\'sel','2014-03-01 22:30:15','0000-00-00 00:00:00');

/*!40000 ALTER TABLE `COMMENT` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `INCREMENT_COMMENT` AFTER INSERT ON `COMMENT` FOR EACH ROW UPDATE STEP SET countComment_step = countComment_step + 1
WHERE id_step = NEW.id_step; */;;
/*!50003 SET SESSION SQL_MODE="STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `DECREMENT_COMMENT` BEFORE DELETE ON `COMMENT` FOR EACH ROW UPDATE STEP SET countComment_step = countComment_step - 1
WHERE id_step = OLD.id_step; */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Affichage de la table COMPOSE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `COMPOSE`;

CREATE TABLE `COMPOSE` (
  `id_ingredient` int(11) NOT NULL,
  `id_recipe` int(11) NOT NULL,
  `quantity_ingredient` varchar(50) DEFAULT NULL,
  `measure_ingredient` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_ingredient`,`id_recipe`),
  KEY `id_recipe` (`id_recipe`),
  CONSTRAINT `compose_ibfk_1` FOREIGN KEY (`id_ingredient`) REFERENCES `INGREDIENT` (`id_ingredient`),
  CONSTRAINT `compose_ibfk_3` FOREIGN KEY (`id_recipe`) REFERENCES `RECIPE` (`id_recipe`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `COMPOSE` WRITE;
/*!40000 ALTER TABLE `COMPOSE` DISABLE KEYS */;

INSERT INTO `COMPOSE` (`id_ingredient`, `id_recipe`, `quantity_ingredient`, `measure_ingredient`)
VALUES
	(1033,3,'3 gros',NULL),
	(1035,3,'500g',NULL),
	(1050,6,NULL,NULL),
	(1121,6,NULL,NULL),
	(1123,5,NULL,NULL),
	(1217,6,NULL,NULL),
	(1507,7,NULL,NULL),
	(1520,7,NULL,NULL),
	(1640,6,NULL,NULL),
	(1730,7,NULL,NULL),
	(1743,1,NULL,NULL),
	(1743,2,'1',NULL),
	(1793,7,NULL,NULL),
	(1794,3,NULL,NULL),
	(1800,1,NULL,NULL),
	(1822,2,'500',NULL),
	(1850,6,NULL,NULL),
	(1896,7,NULL,NULL),
	(1927,1,NULL,NULL),
	(1937,7,NULL,NULL),
	(1964,1,NULL,NULL),
	(2022,6,NULL,NULL),
	(2043,7,NULL,NULL);

/*!40000 ALTER TABLE `COMPOSE` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table DIFFICULTY
# ------------------------------------------------------------

DROP TABLE IF EXISTS `DIFFICULTY`;

CREATE TABLE `DIFFICULTY` (
  `id_difficulty` int(11) NOT NULL AUTO_INCREMENT,
  `slug_difficulty` varchar(100) NOT NULL DEFAULT '',
  `name_difficulty` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_difficulty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `DIFFICULTY` WRITE;
/*!40000 ALTER TABLE `DIFFICULTY` DISABLE KEYS */;

INSERT INTO `DIFFICULTY` (`id_difficulty`, `slug_difficulty`, `name_difficulty`)
VALUES
	(1,'facile','Facile'),
	(2,'moyen','Moyen'),
	(3,'avance','Avancé');

/*!40000 ALTER TABLE `DIFFICULTY` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table favorite
# ------------------------------------------------------------

DROP VIEW IF EXISTS `favorite`;

CREATE TABLE `favorite` (
   `id_user` INT(11) NOT NULL DEFAULT '0',
   `lastname_user` VARCHAR(50) NOT NULL,
   `firstname_user` VARCHAR(50) NOT NULL,
   `id_recipe` INT(11) NOT NULL DEFAULT '0',
   `name_recipe` VARCHAR(50) NOT NULL,
   `urlImage_recipe` VARCHAR(255) NULL DEFAULT NULL,
   `votes_recipe` INT(11) NULL DEFAULT '0',
   `dateAdd_recipe` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
   `id_ambiance` INT(11) NOT NULL,
   `id_preparationTime` INT(11) NOT NULL,
   `id_difficulty` INT(1) NOT NULL DEFAULT '1',
   `id_type` INT(1) NOT NULL DEFAULT '1',
   `numberOfPeople_recipe` INT(11) NOT NULL,
   `name_ambiance` VARCHAR(100) NOT NULL,
   `name_preparationTime` VARCHAR(100) NOT NULL DEFAULT '',
   `name_difficulty` VARCHAR(100) NOT NULL DEFAULT '',
   `name_type` VARCHAR(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM;



# Affichage de la table FOLLOW
# ------------------------------------------------------------

DROP TABLE IF EXISTS `FOLLOW`;

CREATE TABLE `FOLLOW` (
  `id_follow` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_following` int(11) NOT NULL,
  `id_follower` int(11) NOT NULL,
  `date_follow` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_follow`),
  KEY `id_follower` (`id_follower`),
  KEY `id_follow` (`id_following`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`id_following`) REFERENCES `USER` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`id_follower`) REFERENCES `USER` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `FOLLOW` WRITE;
/*!40000 ALTER TABLE `FOLLOW` DISABLE KEYS */;

INSERT INTO `FOLLOW` (`id_follow`, `id_following`, `id_follower`, `date_follow`)
VALUES
	(6,35,1,'2014-02-27 23:52:42'),
	(7,35,2,'2014-02-27 23:52:50'),
	(14,7,35,'2014-02-27 23:53:29'),
	(15,1,35,'2014-02-28 01:08:37'),
	(34,37,35,'2014-03-02 02:20:55');

/*!40000 ALTER TABLE `FOLLOW` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table fullrecipe
# ------------------------------------------------------------

DROP VIEW IF EXISTS `fullrecipe`;

CREATE TABLE `fullrecipe` (
   `id_user` INT(11) NOT NULL DEFAULT '0',
   `lastname_user` VARCHAR(50) NOT NULL,
   `firstname_user` VARCHAR(50) NOT NULL,
   `id_recipe` INT(11) NOT NULL DEFAULT '0',
   `name_recipe` VARCHAR(50) NOT NULL,
   `urlImage_recipe` VARCHAR(255) NULL DEFAULT NULL,
   `votes_recipe` INT(11) NULL DEFAULT '0',
   `dateAdd_recipe` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
   `id_ambiance` INT(11) NOT NULL,
   `id_preparationTime` INT(11) NOT NULL,
   `id_difficulty` INT(1) NOT NULL DEFAULT '1',
   `id_type` INT(1) NOT NULL DEFAULT '1',
   `numberOfPeople_recipe` INT(11) NOT NULL,
   `name_ambiance` VARCHAR(100) NOT NULL,
   `name_preparationTime` VARCHAR(100) NOT NULL DEFAULT '',
   `name_difficulty` VARCHAR(100) NOT NULL DEFAULT '',
   `name_type` VARCHAR(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM;



# Affichage de la table INGREDIENT
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INGREDIENT`;

CREATE TABLE `INGREDIENT` (
  `id_ingredient` int(11) NOT NULL AUTO_INCREMENT,
  `slug_ingredient` varchar(100) DEFAULT NULL,
  `name_ingredient` varchar(100) NOT NULL,
  `kcal_ingredient` int(5) DEFAULT NULL,
  PRIMARY KEY (`id_ingredient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `INGREDIENT` WRITE;
/*!40000 ALTER TABLE `INGREDIENT` DISABLE KEYS */;

INSERT INTO `INGREDIENT` (`id_ingredient`, `slug_ingredient`, `name_ingredient`, `kcal_ingredient`)
VALUES
	(1031,'abadeche','Abadèche',NULL),
	(1032,'abondance','Abondance',NULL),
	(1033,'abricot','Abricot',NULL),
	(1034,'agar-agar','Agar-agar',NULL),
	(1035,'agneau','Agneau',NULL),
	(1036,'aiguillette-de-canard','Aiguillette de canard',NULL),
	(1037,'aiguillette-de-poulet','Aiguillette de poulet',NULL),
	(1038,'aiguillettes-de-dinde','Aiguillettes de dinde',NULL),
	(1039,'ail','Ail',NULL),
	(1040,'aile-de-poulet','Aile de poulet',NULL),
	(1041,'airelles','Airelles',NULL),
	(1042,'alevin','Alevin',NULL),
	(1043,'aligot','Aligot',NULL),
	(1044,'amande','Amande',NULL),
	(1045,'amaretto','Amaretto',NULL),
	(1046,'amidon','Amidon',NULL),
	(1047,'ananas','Ananas',NULL),
	(1048,'anchoiade','Anchoïade',NULL),
	(1049,'anchois','Anchois',NULL),
	(1050,'andouille','Andouille',NULL),
	(1051,'andouillette','Andouillette',NULL),
	(1052,'aneth','Aneth',NULL),
	(1053,'anguille','Anguille',NULL),
	(1054,'anis-etoile','Anis étoilé',NULL),
	(1055,'anis-vert','Anis vert',NULL),
	(1056,'appenzeller','Appenzeller',NULL),
	(1057,'arachide','Arachide',NULL),
	(1058,'araignee-de-mer','Araignée de mer',NULL),
	(1059,'arbois','Arbois',NULL),
	(1060,'arbouse','Arbouse',NULL),
	(1061,'armagnac','Armagnac',NULL),
	(1062,'arome','Arôme',NULL),
	(1063,'artichaut','Artichaut',NULL),
	(1064,'asperge','Asperge',NULL),
	(1065,'aubergine','Aubergine',NULL),
	(1066,'autruche','Autruche',NULL),
	(1067,'avocat','Avocat',NULL),
	(1068,'avoine','Avoine',NULL),
	(1069,'bacon','Bacon',NULL),
	(1070,'badiane','Badiane',NULL),
	(1071,'baguette','Baguette',NULL),
	(1072,'baie-de-genevrier','Baie de genévrier',NULL),
	(1073,'baie-rouge','Baie rouge',NULL),
	(1074,'baies-rose','Baies rose',NULL),
	(1075,'bambou','Bambou',NULL),
	(1076,'banane','Banane',NULL),
	(1077,'banane-plantain','Banane plantain',NULL),
	(1078,'banon','Banon',NULL),
	(1079,'bar','Bar',NULL),
	(1080,'barbue','Barbue',NULL),
	(1081,'baron','Baron',NULL),
	(1082,'basilic','Basilic',NULL),
	(1083,'bastogne','Bastogne',NULL),
	(1084,'beaufort','Beaufort',NULL),
	(1085,'beaujolais','Beaujolais',NULL),
	(1086,'becasse','Bécasse',NULL),
	(1087,'bechamel','Béchamel',NULL),
	(1088,'beef-steak','Beef steak',NULL),
	(1089,'belangere','Bélangère',NULL),
	(1090,'bergamote','Bergamote',NULL),
	(1091,'bergerac','Bergerac',NULL),
	(1092,'bernique','Bernique',NULL),
	(1093,'betterave','Betterave',NULL),
	(1094,'bettes-a-cardes','Bettes à cardes',NULL),
	(1095,'beurre','Beurre',NULL),
	(1096,'beurre-allege','Beurre allégé',NULL),
	(1097,'beurre-de-cacahuete','Beurre de cacahuète',NULL),
	(1098,'beurre-doux','Beurre doux',NULL),
	(1099,'beurre-tendre','Beurre tendre',NULL),
	(1100,'bicarbonate','Bicarbonate',NULL),
	(1101,'biere','Bière',NULL),
	(1102,'bigarade','Bigarade',NULL),
	(1103,'bigorneau','Bigorneau',NULL),
	(1104,'biscotte','Biscotte',NULL),
	(1105,'biscuit-cuiller','Biscuit cuiller',NULL),
	(1106,'biscuit-sec','Biscuit sec',NULL),
	(1107,'biscuits-a-la-cuillere','Biscuits à la cuillère',NULL),
	(1108,'bison','Bison',NULL),
	(1109,'blanc-de-dinde','Blanc de dinde',NULL),
	(1110,'blanc-de-poulet','Blanc de poulet',NULL),
	(1111,'blanquette-de-veau','Blanquette de veau',NULL),
	(1112,'ble','Blé',NULL),
	(1113,'blette','Blette',NULL),
	(1114,'bleu','Bleu',NULL),
	(1115,'bleu-de-bresse','Bleu de bresse',NULL),
	(1116,'bleu-de-gex','Bleu de gex',NULL),
	(1117,'bleu-des-causses','Bleu des causses',NULL),
	(1118,'blini','Blini',NULL),
	(1119,'bocconcini','Bocconcini',NULL),
	(1120,'boeuf','Boeuf',NULL),
	(1121,'bok-choy','Bok choy',NULL),
	(1122,'bolet','Bolet',NULL),
	(1123,'bonbon-arlequin','Bonbon arlequin',NULL),
	(1124,'bonnet','Bonnet',NULL),
	(1125,'bordeaux','Bordeaux',NULL),
	(1126,'boudin-blanc','Boudin blanc',NULL),
	(1127,'boudin-noir','Boudin noir',NULL),
	(1128,'boudoir','Boudoir',NULL),
	(1129,'bouillon','Bouillon',NULL),
	(1130,'bouillon-de-boeuf','Bouillon de boeuf',NULL),
	(1131,'bouillon-de-legume','Bouillon de légume',NULL),
	(1132,'bouillon-de-poule','Bouillon de poule',NULL),
	(1133,'bouillon-de-volaille','Bouillon de volaille',NULL),
	(1134,'boulgour','Boulgour',NULL),
	(1135,'bouquet-garni','Bouquet garni',NULL),
	(1136,'bourgeois','Bourgeois',NULL),
	(1137,'bourgogne','Bourgogne',NULL),
	(1138,'bourguignon','Bourguignon',NULL),
	(1139,'bourrache','Bourrache',NULL),
	(1140,'boursault','Boursault',NULL),
	(1141,'boursin','Boursin',NULL),
	(1142,'bresaola','Bresaola',NULL),
	(1143,'brick','Brick',NULL),
	(1144,'brie-de-meaux','Brie de meaux',NULL),
	(1145,'brillat-savarin','Brillat-savarin',NULL),
	(1146,'brioche','Brioche',NULL),
	(1147,'brique','Brique',NULL),
	(1148,'brocciu','Brocciu',NULL),
	(1149,'brochet','Brochet',NULL),
	(1150,'brocoli','Brocoli',NULL),
	(1151,'brousse','Brousse',NULL),
	(1152,'brownie','Brownie',NULL),
	(1153,'brugnon','Brugnon',NULL),
	(1154,'bulot','Bulot',NULL),
	(1155,'butternut','Butternut',NULL),
	(1156,'cabecou','Cabécou',NULL),
	(1157,'cabillaud','Cabillaud',NULL),
	(1158,'cacao','Cacao',NULL),
	(1159,'cafe','Café',NULL),
	(1160,'cafe-soluble','Café soluble',NULL),
	(1161,'caille','Caille',NULL),
	(1162,'caillette','Caillette',NULL),
	(1163,'calamar','Calamar',NULL),
	(1164,'calvados','Calvados',NULL),
	(1165,'camembert','Camembert',NULL),
	(1166,'canard','Canard',NULL),
	(1167,'cancoillotte','Cancoillotte',NULL),
	(1168,'canette','Canette',NULL),
	(1169,'canneberge','Canneberge',NULL),
	(1170,'cannelle','Cannelle',NULL),
	(1171,'canneloni','Canneloni',NULL),
	(1172,'cantal','Cantal',NULL),
	(1173,'capelan','Capelan',NULL),
	(1174,'capres','Câpres',NULL),
	(1175,'caprice-des-dieux','Caprice des dieux',NULL),
	(1176,'capucine','Capucine',NULL),
	(1177,'carambole','Carambole',NULL),
	(1178,'caramel','Caramel',NULL),
	(1179,'caramel-au-beurre-sale','Caramel au beurre salé',NULL),
	(1180,'cardamome','Cardamome',NULL),
	(1181,'cardon','Cardon',NULL),
	(1182,'carotte','Carotte',NULL),
	(1183,'carpe','Carpe',NULL),
	(1184,'carre-frais','Carré frais',NULL),
	(1185,'carrelet','Carrelet',NULL),
	(1186,'cassis','Cassis',NULL),
	(1187,'cassonade','Cassonade',NULL),
	(1188,'caviar','Caviar',NULL),
	(1189,'cedrat','Cédrat',NULL),
	(1190,'celeri','Céleri',NULL),
	(1191,'celeri-rave','Céleri-rave',NULL),
	(1192,'cepe','Cèpe',NULL),
	(1193,'cereale','Céréale',NULL),
	(1194,'cerf','Cerf',NULL),
	(1195,'cerfeuil','Cerfeuil',NULL),
	(1196,'cerise','Cerise',NULL),
	(1197,'cerise-de-terre','Cerise de terre',NULL),
	(1198,'cervelas','Cervelas',NULL),
	(1199,'cervelle','Cervelle',NULL),
	(1200,'chabichou','Chabichou',NULL),
	(1201,'chair-a-saucisse','Chair à saucisse',NULL),
	(1202,'champagne','Champagne',NULL),
	(1203,'champignon','Champignon',NULL),
	(1204,'champignon-frais','Champignon frais',NULL),
	(1205,'champignon-noir','Champignon noir',NULL),
	(1206,'chanterelle','Chanterelle',NULL),
	(1207,'chaource','Chaource',NULL),
	(1208,'chapelure','Chapelure',NULL),
	(1209,'chapon','Chapon',NULL),
	(1210,'charolais','Charolais',NULL),
	(1211,'chataigne','Châtaigne',NULL),
	(1212,'chaume','Chaume',NULL),
	(1213,'chayote','Chayote',NULL),
	(1214,'cheddar','Cheddar',NULL),
	(1215,'chene','Chêne',NULL),
	(1216,'chermoula','Chermoula',NULL),
	(1217,'chevre','Chèvre',NULL),
	(1218,'chevreau','Chevreau',NULL),
	(1219,'chevreuil','Chevreuil',NULL),
	(1220,'chicon','Chicon',NULL),
	(1221,'chicoree','Chicorée',NULL),
	(1222,'chili','Chili',NULL),
	(1223,'chipiron','Chipiron',NULL),
	(1224,'chipolata','Chipolata',NULL),
	(1225,'chips','Chips',NULL),
	(1226,'chocolat','Chocolat',NULL),
	(1227,'chocolat-a-tartiner','Chocolat à tartiner',NULL),
	(1228,'chocolat-amer','Chocolat amer',NULL),
	(1229,'chocolat-au-lait','Chocolat au lait',NULL),
	(1230,'chocolat-au-riz-souffle','Chocolat au riz soufflé',NULL),
	(1231,'chocolat-aux-noisettes','Chocolat aux noisettes',NULL),
	(1232,'chocolat-blanc','Chocolat blanc',NULL),
	(1233,'chocolat-de-couverture','Chocolat de couverture',NULL),
	(1234,'chocolat-en-poudre','Chocolat en poudre',NULL),
	(1235,'chocolat-noir','Chocolat noir',NULL),
	(1236,'chocolat-patissier','Chocolat pâtissier',NULL),
	(1237,'chorizo','Chorizo',NULL),
	(1238,'chou','Chou',NULL),
	(1239,'chou-chinois','Chou chinois',NULL),
	(1240,'chou-de-bruxelles','Chou de bruxelles',NULL),
	(1241,'chou-romanesco','Chou romanesco',NULL),
	(1242,'chouchou','Chouchou',NULL),
	(1243,'chou-fleur','Chou-fleur',NULL),
	(1244,'christophine','Christophine',NULL),
	(1245,'ciboule','Ciboule',NULL),
	(1246,'ciboulette','Ciboulette',NULL),
	(1247,'cidre','Cidre',NULL),
	(1248,'cigale-de-mer','Cigale de mer',NULL),
	(1249,'cigarette-russe','Cigarette russe',NULL),
	(1250,'cinq-parfums','Cinq parfums',NULL),
	(1251,'cinq-epices','Cinq-épices',NULL),
	(1252,'citron','Citron',NULL),
	(1253,'citron-confit','Citron confit',NULL),
	(1254,'citron-vert','Citron vert',NULL),
	(1255,'citronnelle','Citronnelle',NULL),
	(1256,'citrouille','Citrouille',NULL),
	(1257,'clams','Clams',NULL),
	(1258,'clementine','Clémentine',NULL),
	(1259,'clou-de-girofle','Clou de girofle',NULL),
	(1260,'coeur','Coeur',NULL),
	(1261,'coeur-de-palmier','Coeur de palmier',NULL),
	(1262,'cognac','Cognac',NULL),
	(1263,'coing','Coing',NULL),
	(1264,'coleslaw','Coleslaw',NULL),
	(1265,'colin','Colin',NULL),
	(1266,'colorant','Colorant',NULL),
	(1267,'colorant-alimentaire','Colorant alimentaire',NULL),
	(1268,'combava','Combava',NULL),
	(1269,'compote','Compote',NULL),
	(1270,'comte','Comté',NULL),
	(1271,'concentre-de-tomate','Concentré de tomate',NULL),
	(1272,'conchiglione','Conchiglione',NULL),
	(1273,'concombre','Concombre',NULL),
	(1274,'confit-de-canard','Confit de canard',NULL),
	(1275,'confiture','Confiture',NULL),
	(1276,'congre','Congre',NULL),
	(1277,'cookie','Cookie',NULL),
	(1278,'coppa','Coppa',NULL),
	(1279,'coq','Coq',NULL),
	(1280,'coque','Coque',NULL),
	(1281,'coquelet','Coquelet',NULL),
	(1282,'coquille-saint-jacques','Coquille saint-jacques',NULL),
	(1283,'coquillettes','Coquillettes',NULL),
	(1284,'coriandre','Coriandre',NULL),
	(1285,'corn-flakes','Corn flakes',NULL),
	(1286,'cornichons','Cornichons',NULL),
	(1287,'cotes-de-porc','Côtes de porc',NULL),
	(1288,'couche','Couche',NULL),
	(1289,'coude','Coude',NULL),
	(1290,'coulis-de-tomate','Coulis de tomate',NULL),
	(1291,'coulommier','Coulommier',NULL),
	(1292,'courge','Courge',NULL),
	(1293,'courge-musquee','Courge musquée',NULL),
	(1294,'courge-spaghetti','Courge spaghetti',NULL),
	(1295,'courgette','Courgette',NULL),
	(1296,'court-bouillon','Court-bouillon',NULL),
	(1297,'couscous','Couscous',NULL),
	(1298,'couteau','Couteau',NULL),
	(1299,'crabe','Crabe',NULL),
	(1300,'cranberrie','Cranberrie',NULL),
	(1301,'cream-cheese','Cream cheese',NULL),
	(1302,'cremant','Crémant',NULL),
	(1303,'creme','Crème',NULL),
	(1304,'creme-anglaise','Crème anglaise',NULL),
	(1305,'creme-chantilly','Crème chantilly',NULL),
	(1306,'creme-de-soja','Crème de soja',NULL),
	(1307,'creme-epaisse','Crème épaisse',NULL),
	(1308,'creme-fouettee','Crème fouettée',NULL),
	(1309,'creme-fraiche-allegee','Crème fraîche allégée',NULL),
	(1310,'creme-fraiche-epaisse','Crème fraîche épaisse',NULL),
	(1311,'creme-liquide','Crème liquide',NULL),
	(1312,'creme-semi-epaisse','Crème semi-épaisse',NULL),
	(1313,'crepe','Crêpe',NULL),
	(1314,'crepinette','Crépinette',NULL),
	(1315,'cresson','Cresson',NULL),
	(1316,'crevette','Crevette',NULL),
	(1317,'crevette-bouquet','Crevette bouquet',NULL),
	(1318,'crevette-rose','Crevette rose',NULL),
	(1319,'crevette-tigree','Crevette tigrée',NULL),
	(1320,'crevettes-grises','Crevettes grises',NULL),
	(1321,'croissant','Croissant',NULL),
	(1322,'crosne-de-fougere','Crosne de fougère',NULL),
	(1323,'crottins-de-chavignol','Crottins de chavignol',NULL),
	(1324,'croutons','Croûtons',NULL),
	(1325,'crozet','Crozet',NULL),
	(1326,'cuisse-de-canard','Cuisse de canard',NULL),
	(1327,'cuisse-de-dinde','Cuisse de dinde',NULL),
	(1328,'cuisse-de-poulet','Cuisse de poulet',NULL),
	(1329,'cuisses-de-lapin','Cuisses de lapin',NULL),
	(1330,'cumin','Cumin',NULL),
	(1331,'curcuma','Curcuma',NULL),
	(1332,'cure-nantais','Curé nantais',NULL),
	(1333,'curry','Curry',NULL),
	(1334,'dachine','Dachine',NULL),
	(1335,'daikon','Daikon',NULL),
	(1336,'daim','Daim',NULL),
	(1337,'datte','Datte',NULL),
	(1338,'daurade','Daurade',NULL),
	(1339,'decor-en-sucre','Décor en sucre',NULL),
	(1340,'dinde','Dinde',NULL),
	(1341,'dindonneau','Dindonneau',NULL),
	(1342,'diot','Diot',NULL),
	(1343,'dorade','Dorade',NULL),
	(1344,'dore','Doré',NULL),
	(1345,'dragibus','Dragibus',NULL),
	(1346,'earl-grey','Earl grey',NULL),
	(1347,'eau','Eau',NULL),
	(1348,'echine-de-porc','Échine de porc',NULL),
	(1349,'ecrevisse','Écrevisse',NULL),
	(1350,'edam','Edam',NULL),
	(1351,'edelzwicker','Edelzwicker',NULL),
	(1352,'edulcorant','Édulcorant',NULL),
	(1353,'eglefin','Églefin',NULL),
	(1354,'emmental','Emmental',NULL),
	(1355,'encornet','Encornet',NULL),
	(1356,'endive','Endive',NULL),
	(1357,'entrecote','Entrecôte',NULL),
	(1358,'epeautre','Épeautre',NULL),
	(1359,'eperlan','Éperlan',NULL),
	(1360,'epinard','Épinard',NULL),
	(1361,'epoisse','Époisse',NULL),
	(1362,'erable','Érable',NULL),
	(1363,'escalope','Escalope',NULL),
	(1364,'escalope-de-dinde','Escalope de dinde',NULL),
	(1365,'escalope-de-poulet','Escalope de poulet',NULL),
	(1366,'escargot','Escargot',NULL),
	(1367,'espadon','Espadon',NULL),
	(1368,'estomac','Estomac',NULL),
	(1369,'estragon','Estragon',NULL),
	(1370,'esturgeon','Esturgeon',NULL),
	(1371,'etorki','Etorki',NULL),
	(1372,'etrilles','Étrilles',NULL),
	(1373,'extrait-de-vanille-liquide','Extrait de vanille liquide',NULL),
	(1374,'faisan','Faisan',NULL),
	(1375,'faisselle','Faisselle',NULL),
	(1376,'fajitas','Fajitas',NULL),
	(1377,'farce','Farce',NULL),
	(1378,'farfalle','Farfalle',NULL),
	(1379,'farine','Farine',NULL),
	(1380,'farine-de-ble','Farine de blé',NULL),
	(1381,'farine-de-ble-noir','Farine de blé noir',NULL),
	(1382,'farine-de-chataigne','Farine de chataîgne',NULL),
	(1383,'farine-de-mais','Farine de maïs',NULL),
	(1384,'fecule','Fécule',NULL),
	(1385,'fecule-de-mais','Fécule de maïs',NULL),
	(1386,'fecule-de-pomme-de-terre','Fécule de pomme de terre',NULL),
	(1387,'fenouil','Fenouil',NULL),
	(1388,'fenouil-en-grains','Fenouil en grains',NULL),
	(1389,'fenugreek','Fenugreek',NULL),
	(1390,'fera','Féra',NULL),
	(1391,'feta','Feta',NULL),
	(1392,'feuille-de-brick','Feuille de brick',NULL),
	(1393,'feuille-de-menthe','Feuille de menthe',NULL),
	(1394,'feuillet','Feuillet',NULL),
	(1395,'feuillets-a-raviolis','Feuillets à raviolis',NULL),
	(1396,'feve','Fève',NULL),
	(1397,'figue','Figue',NULL),
	(1398,'figue-de-barbarie','Figue de barbarie',NULL),
	(1399,'filet-de-poulet','Filet de poulet',NULL),
	(1400,'filo','Filo',NULL),
	(1401,'fixe-chantilly','Fixe chantilly',NULL),
	(1402,'flageolet','Flageolet',NULL),
	(1403,'fletan','Flétan',NULL),
	(1404,'fleur-de-sel','Fleur de sel',NULL),
	(1405,'foie','Foie',NULL),
	(1406,'foie-gras','Foie gras',NULL),
	(1407,'fond-de-veau','Fond de veau',NULL),
	(1408,'fond-de-volaille','Fond de volaille',NULL),
	(1409,'fonds','Fonds',NULL),
	(1410,'fourme-de-montbrison','Fourme de montbrison',NULL),
	(1411,'fraise','Fraise',NULL),
	(1412,'fraise-des-bois','Fraise des bois',NULL),
	(1413,'fraise-gariguette','Fraise gariguette',NULL),
	(1414,'framboise','Framboise',NULL),
	(1415,'fribourg','Fribourg',NULL),
	(1416,'frisee','Frisée',NULL),
	(1417,'fromage-ail-et-fines-herbes','Fromage ail et fines herbes',NULL),
	(1418,'fromage-blanc','Fromage blanc',NULL),
	(1419,'fromage-blanc-sucre','Fromage blanc sucré',NULL),
	(1420,'fromage-rape','Fromage râpé',NULL),
	(1421,'fromages-italiens','Fromages italiens',NULL),
	(1422,'fromages-suisses','Fromages suisses',NULL),
	(1423,'fructose','Fructose',NULL),
	(1424,'fruit-a-pain','Fruit à pain',NULL),
	(1425,'fruit-confit','Fruit confit',NULL),
	(1426,'fruit-de-la-passion','Fruit de la passion',NULL),
	(1427,'fruit-de-mer','Fruit de mer',NULL),
	(1428,'fruit-rouge','Fruit rouge',NULL),
	(1429,'fusilli','Fusilli',NULL),
	(1430,'galette','Galette',NULL),
	(1431,'galettes-bretonnes','Galettes (bretonnes)',NULL),
	(1432,'galettes-de-riz','Galettes de riz',NULL),
	(1433,'gambas','Gambas',NULL),
	(1434,'gaperon','Gaperon',NULL),
	(1435,'garam-massala','Garam massala',NULL),
	(1436,'gateaux','Gâteaux',NULL),
	(1437,'gaufre','Gaufre',NULL),
	(1438,'gaufrette','Gaufrette',NULL),
	(1439,'gavotte','Gavotte',NULL),
	(1440,'gelatine','Gélatine',NULL),
	(1441,'gelatine-en-poudre','Gélatine en poudre',NULL),
	(1442,'gelee','Gelée',NULL),
	(1443,'gelee-au-madere','Gelée au madère',NULL),
	(1444,'genievre','Genièvre',NULL),
	(1445,'genoise','Génoise',NULL),
	(1446,'germes-de-soja','Germes de soja',NULL),
	(1447,'gesiers','Gésiers',NULL),
	(1448,'gewurztraminer','Gewurztraminer',NULL),
	(1449,'gin','Gin',NULL),
	(1450,'gingembre','Gingembre',NULL),
	(1451,'gingembre-confit','Gingembre confit',NULL),
	(1452,'giraumon','Giraumon',NULL),
	(1453,'girofle','Girofle',NULL),
	(1454,'girolle','Girolle',NULL),
	(1455,'gite','Gîte',NULL),
	(1456,'glace-pilee','Glace pilée',NULL),
	(1457,'glace-vanille','Glace vanille',NULL),
	(1458,'glacon','Glaçon',NULL),
	(1459,'glucose','Glucose',NULL),
	(1460,'gnocchi','Gnocchi',NULL),
	(1461,'golden-sirup','Golden sirup',NULL),
	(1462,'gombo','Gombo',NULL),
	(1463,'gomme-de-xanthane','Gomme de xanthane',NULL),
	(1464,'gorgonzola','Gorgonzola',NULL),
	(1465,'gouda','Gouda',NULL),
	(1466,'goyave','Goyave',NULL),
	(1467,'graine-de-lin','Graine de lin',NULL),
	(1468,'graine-germee','Graine germée',NULL),
	(1469,'graines-de-tournesol','Graines de tournesol',NULL),
	(1470,'grana-padano','Grana padano',NULL),
	(1471,'grand-marnier','Grand-marnier',NULL),
	(1472,'grenade','Grenade',NULL),
	(1473,'grenadier','Grenadier',NULL),
	(1474,'grenadin','Grenadin',NULL),
	(1475,'grenaille','Grenaille',NULL),
	(1476,'gressin','Gressin',NULL),
	(1477,'griotte','Griotte',NULL),
	(1478,'grondin','Grondin',NULL),
	(1479,'gros-sel','Gros sel',NULL),
	(1480,'groseille','Groseille',NULL),
	(1481,'groseille-a-maquereaux','Groseille à maquereaux',NULL),
	(1482,'gruyere','Gruyère',NULL),
	(1483,'guacamole','Guacamole',NULL),
	(1484,'guimauve','Guimauve',NULL),
	(1485,'haddock','Haddock',NULL),
	(1486,'hampe','Hampe',NULL),
	(1487,'hareng','Hareng',NULL),
	(1488,'haricot-beurre','Haricot beurre',NULL),
	(1489,'haricot-blanc','Haricot blanc',NULL),
	(1490,'haricot-coco','Haricot coco',NULL),
	(1491,'haricot-de-lima','Haricot de lima',NULL),
	(1492,'haricot-de-soissons','Haricot de soissons',NULL),
	(1493,'haricot-lingot','Haricot lingot',NULL),
	(1494,'haricot-mange-tout','Haricot mange-tout',NULL),
	(1495,'haricot-mungo','Haricot mungo',NULL),
	(1496,'haricot-noir','Haricot noir',NULL),
	(1497,'haricot-pinto','Haricot pinto',NULL),
	(1498,'haricot-plat','Haricot plat',NULL),
	(1499,'haricot-rouge','Haricot rouge',NULL),
	(1500,'haricot-sec','Haricot sec',NULL),
	(1501,'haricot-tarbais','Haricot tarbais',NULL),
	(1502,'haricot-vert','Haricot vert',NULL),
	(1503,'harissa','Harissa',NULL),
	(1504,'herbes-de-provence','Herbes de provence',NULL),
	(1505,'homard','Homard',NULL),
	(1506,'houblon','Houblon',NULL),
	(1507,'huile','Huile',NULL),
	(1508,'huile-de-colza','Huile de colza',NULL),
	(1509,'huile-de-noisette','Huile de noisette',NULL),
	(1510,'huile-de-palme','Huile de palme',NULL),
	(1511,'huile-de-pepin-de-raisin','Huile de pépin de raisin',NULL),
	(1512,'huile-de-sesame','Huile de sésame',NULL),
	(1513,'huile-de-tournesol','Huile de tournesol',NULL),
	(1514,'huitre','Huître',NULL),
	(1515,'iceberg','Iceberg',NULL),
	(1516,'igname','Igname',NULL),
	(1517,'jambon','Jambon',NULL),
	(1518,'jambon-blanc','Jambon blanc',NULL),
	(1519,'jambon-de-bayonne','Jambon de bayonne',NULL),
	(1520,'jambon-de-parme','Jambon de parme',NULL),
	(1521,'jambon-de-vendee','Jambon de vendée',NULL),
	(1522,'jambon-de-virginie','Jambon de virginie',NULL),
	(1523,'jambon-fume','Jambon fumé',NULL),
	(1524,'jambon-persille','Jambon persillé',NULL),
	(1525,'jambon-sec','Jambon sec',NULL),
	(1526,'jambonneau','Jambonneau',NULL),
	(1527,'jarret-de-veau','Jarret de veau',NULL),
	(1528,'jesus','Jésus',NULL),
	(1529,'joue','Joue',NULL),
	(1530,'joue-de-lotte','Joue de lotte',NULL),
	(1531,'julienne','Julienne',NULL),
	(1532,'jus-de-citron','Jus de citron',NULL),
	(1533,'jus-de-fruit-de-la-passion','Jus de fruit de la passion',NULL),
	(1534,'kaki','Kaki',NULL),
	(1535,'kangourou','Kangourou',NULL),
	(1536,'kefalotiri','Kefalotiri',NULL),
	(1537,'ketchup','Ketchup',NULL),
	(1538,'kirsch','Kirsch',NULL),
	(1539,'kiwi','Kiwi',NULL),
	(1540,'knacki','Knacki',NULL),
	(1541,'kub-or','Kub or',NULL),
	(1542,'kumquat','Kumquat',NULL),
	(1543,'lait','Lait',NULL),
	(1544,'lait-concentre','Lait concentré',NULL),
	(1545,'lait-concentre-non-sucre','Lait concentré non sucré',NULL),
	(1546,'lait-concentre-sucre','Lait concentré sucré',NULL),
	(1547,'lait-de-chevre','Lait de chèvre',NULL),
	(1548,'lait-de-coco','Lait de coco',NULL),
	(1549,'lait-de-soja','Lait de soja',NULL),
	(1550,'lait-ecreme','Lait écrémé',NULL),
	(1551,'lait-en-poudre','Lait en poudre',NULL),
	(1552,'lait-en-poudre-ecreme','Lait en poudre écrémé',NULL),
	(1553,'lait-en-poudre-entier','Lait en poudre entier',NULL),
	(1554,'lait-entier','Lait entier',NULL),
	(1555,'lait-entier-concentre','Lait entier concentré',NULL),
	(1556,'lait-fermente','Lait fermenté',NULL),
	(1557,'laitue','Laitue',NULL),
	(1558,'langouste','Langouste',NULL),
	(1559,'langoustine','Langoustine',NULL),
	(1560,'langres','Langres',NULL),
	(1561,'langue','Langue',NULL),
	(1562,'langue-de-chat','Langue de chat',NULL),
	(1563,'lapin','Lapin',NULL),
	(1564,'lapin-entier','Lapin entier',NULL),
	(1565,'lard','Lard',NULL),
	(1566,'lardons','Lardons',NULL),
	(1567,'lardons-fumes','Lardons fumés',NULL),
	(1568,'lasagnes','Lasagnes',NULL),
	(1569,'laurier','Laurier',NULL),
	(1570,'lavande','Lavande',NULL),
	(1571,'legine-australe','Légine australe',NULL),
	(1572,'lemon-curd','Lemon curd',NULL),
	(1573,'lentille','Lentille',NULL),
	(1574,'lentille-corail','Lentille corail',NULL),
	(1575,'lentille-verte','Lentille verte',NULL),
	(1576,'lentin','Lentin',NULL),
	(1577,'levure','Levure',NULL),
	(1578,'levure-chimique','Levure chimique',NULL),
	(1579,'levure-de-boulanger-fraiche','Levure de boulanger fraîche',NULL),
	(1580,'levure-de-boulanger-seche','Levure de boulanger sèche',NULL),
	(1581,'lieu-jaune','Lieu jaune',NULL),
	(1582,'lieu-noir','Lieu noir',NULL),
	(1583,'limande','Limande',NULL),
	(1584,'lingue','Lingue',NULL),
	(1585,'linguine','Linguine',NULL),
	(1586,'litchi','Litchi',NULL),
	(1587,'livarot','Livarot',NULL),
	(1588,'liveche','Livèche',NULL),
	(1589,'lotte','Lotte',NULL),
	(1590,'lotus','Lotus',NULL),
	(1591,'loup','Loup',NULL),
	(1592,'loup-de-mer','Loup de mer',NULL),
	(1593,'maasdam','Maasdam',NULL),
	(1594,'macaroni','Macaroni',NULL),
	(1595,'mache','Mâche',NULL),
	(1596,'madeleine','Madeleine',NULL),
	(1597,'madere','Madère',NULL),
	(1598,'magret-de-canard','Magret de canard',NULL),
	(1599,'magret-de-canard-fume','Magret de canard fumé',NULL),
	(1600,'mahi-mahi','Mahi mahi',NULL),
	(1601,'mais','Maïs',NULL),
	(1602,'maizena','Maïzena',NULL),
	(1603,'manchego','Manchego',NULL),
	(1604,'mandarine','Mandarine',NULL),
	(1605,'mangue','Mangue',NULL),
	(1606,'manioc','Manioc',NULL),
	(1607,'manouri','Manouri',NULL),
	(1608,'maquereau','Maquereau',NULL),
	(1609,'margarine','Margarine',NULL),
	(1610,'marjolaine','Marjolaine',NULL),
	(1611,'maroilles','Maroilles',NULL),
	(1612,'marrons','Marrons',NULL),
	(1613,'martini-blanc','Martini blanc',NULL),
	(1614,'mascarpone','Mascarpone',NULL),
	(1615,'massala','Massala',NULL),
	(1616,'mayonnaise','Mayonnaise',NULL),
	(1617,'melisse','Mélisse',NULL),
	(1618,'melon','Melon',NULL),
	(1619,'merguez','Merguez',NULL),
	(1620,'meringue','Meringue',NULL),
	(1621,'merlan','Merlan',NULL),
	(1622,'merlu','Merlu',NULL),
	(1623,'mesclun','Mesclun',NULL),
	(1624,'miel','Miel',NULL),
	(1625,'miel-liquide','Miel liquide',NULL),
	(1626,'miette-de-crabe','Miette de crabe',NULL),
	(1627,'millet','Millet',NULL),
	(1628,'mimolette','Mimolette',NULL),
	(1629,'mini-smarties','Mini smarties',NULL),
	(1630,'mirabelle','Mirabelle',NULL),
	(1631,'mirin','Mirin',NULL),
	(1632,'miso','Miso',NULL),
	(1633,'mogette','Mogette',NULL),
	(1634,'montasio','Montasio',NULL),
	(1635,'morbier','Morbier',NULL),
	(1636,'morille','Morille',NULL),
	(1637,'mortadelle','Mortadelle',NULL),
	(1638,'morue','Morue',NULL),
	(1639,'moules','Moules',NULL),
	(1640,'mousse-de-foie','Mousse de foie',NULL),
	(1641,'mousseron','Mousseron',NULL),
	(1642,'moutarde','Moutarde',NULL),
	(1643,'moutarde-de-dijon','Moutarde de dijon',NULL),
	(1644,'moutarde-de-meaux','Moutarde de meaux',NULL),
	(1645,'mouton','Mouton',NULL),
	(1646,'mozzarella','Mozzarella',NULL),
	(1647,'mozzarella-di-buffala','Mozzarella di buffala',NULL),
	(1648,'muesli','Muesli',NULL),
	(1649,'muffin-plat','Muffin plat',NULL),
	(1650,'munster','Munster',NULL),
	(1651,'mure','Mûre',NULL),
	(1652,'muscade','Muscade',NULL),
	(1653,'muscat','Muscat',NULL),
	(1654,'museau','Museau',NULL),
	(1655,'myrtille','Myrtille',NULL),
	(1656,'navet','Navet',NULL),
	(1657,'nectarine','Nectarine',NULL),
	(1658,'nefle','Nèfle',NULL),
	(1659,'niebe','Niébé',NULL),
	(1660,'noilly-prat','Noilly prat',NULL),
	(1661,'noisette','Noisette',NULL),
	(1662,'noix','Noix',NULL),
	(1663,'noix-de-cajou','Noix de cajou',NULL),
	(1664,'noix-de-coco','Noix de coco',NULL),
	(1665,'noix-de-coco-rapee','Noix de coco rapée',NULL),
	(1666,'nopal','Nopal',NULL),
	(1667,'nori','Nori',NULL),
	(1668,'nougat','Nougat',NULL),
	(1669,'nougatine','Nougatine',NULL),
	(1670,'nouilles','Nouilles',NULL),
	(1671,'nouilles-chinoises','Nouilles chinoises',NULL),
	(1672,'nouilles-de-riz','Nouilles de riz',NULL),
	(1673,'nouilles-soba','Nouilles soba',NULL),
	(1674,'nugget','Nugget',NULL),
	(1675,'nuoc-mam','Nuoc mam',NULL),
	(1676,'nutella','Nutella',NULL),
	(1677,'oeuf','Oeuf',NULL),
	(1678,'oeuf-de-caille','Oeuf de caille',NULL),
	(1679,'oeufs-de-saumon','Oeufs de saumon',NULL),
	(1680,'oie','Oie',NULL),
	(1681,'oignon','Oignon',NULL),
	(1682,'oignon-blanc','Oignon blanc',NULL),
	(1683,'oignon-nouveau','Oignon nouveau',NULL),
	(1684,'oignon-rouge','Oignon rouge',NULL),
	(1685,'oka','Oka',NULL),
	(1686,'okra','Okra',NULL),
	(1687,'olives','Olives',NULL),
	(1688,'omble-chevalier','Omble chevalier',NULL),
	(1689,'onglet','Onglet',NULL),
	(1690,'orange','Orange',NULL),
	(1691,'orange-amere','Orange amère',NULL),
	(1692,'orecchiette','Orecchiette',NULL),
	(1693,'oreilles','Oreilles',NULL),
	(1694,'oreo','Oréo',NULL),
	(1695,'orge','Orge',NULL),
	(1696,'origan','Origan',NULL),
	(1697,'ormeau','Ormeau',NULL),
	(1698,'oronge','Oronge',NULL),
	(1699,'oseille','Oseille',NULL),
	(1700,'ossau-iraty','Ossau iraty',NULL),
	(1701,'oursin','Oursin',NULL),
	(1702,'ourson-en-guimauve','Ourson en guimauve',NULL),
	(1703,'pain','Pain',NULL),
	(1704,'pain-au-lait','Pain au lait',NULL),
	(1705,'pain-aux-cereales','Pain aux céréales',NULL),
	(1706,'pain-brioche','Pain brioché',NULL),
	(1707,'pain-complet','Pain complet',NULL),
	(1708,'pain-de-campagne','Pain de campagne',NULL),
	(1709,'pain-de-mie','Pain de mie',NULL),
	(1710,'pain-de-seigle','Pain de seigle',NULL),
	(1711,'pain-indien-naan','Pain indien naan',NULL),
	(1712,'pain-pita','Pain pita',NULL),
	(1713,'pain-pour-hamburger','Pain pour hamburger',NULL),
	(1714,'pain-viennois','Pain viennois',NULL),
	(1715,'palets-bretons','Palets bretons',NULL),
	(1716,'palombe','Palombe',NULL),
	(1717,'palourde','Palourde',NULL),
	(1718,'pamplemousse','Pamplemousse',NULL),
	(1719,'panais','Panais',NULL),
	(1720,'pancetta','Pancetta',NULL),
	(1721,'panga','Panga',NULL),
	(1722,'pangasius','Pangasius',NULL),
	(1723,'panse','Panse',NULL),
	(1724,'pansette','Pansette',NULL),
	(1725,'papaye','Papaye',NULL),
	(1726,'papier-sulfurise','Papier sulfurisé',NULL),
	(1727,'papillons','Papillons',NULL),
	(1728,'pappardelles','Pappardelles',NULL),
	(1729,'paprika','Paprika',NULL),
	(1730,'parmesan','Parmesan',NULL),
	(1731,'pasteque','Pastèque',NULL),
	(1732,'pastis','Pastis',NULL),
	(1733,'patate-douce','Patate douce',NULL),
	(1734,'pate','Pâte',NULL),
	(1735,'pate','Pâté',NULL),
	(1736,'pate-a-pizza','Pâte à pizza',NULL),
	(1737,'pate-a-raviolis','Pâte à raviolis',NULL),
	(1738,'pate-a-tartiner','Pâte à tartiner',NULL),
	(1739,'pate-brisee','Pâte brisée',NULL),
	(1740,'pate-de-campagne','Pâté de campagne',NULL),
	(1741,'pate-de-curry','Pâte de curry',NULL),
	(1742,'pate-de-foie','Pâté de foie',NULL),
	(1743,'pate-feuilletee','Pâte feuilletée',NULL),
	(1744,'pate-sablee','Pâte sablée',NULL),
	(1745,'pates','Pâtes',NULL),
	(1746,'pates-fraiches','Pâtes fraîches',NULL),
	(1747,'patisson','Pâtisson',NULL),
	(1748,'pavot','Pavot',NULL),
	(1749,'peche','Pêche',NULL),
	(1750,'pecorino-pepato','Pecorino pepato',NULL),
	(1751,'pecorino-romano','Pecorino romano',NULL),
	(1752,'pelardon','Pélardon',NULL),
	(1753,'penne','Penne',NULL),
	(1754,'pensee','Pensée',NULL),
	(1755,'perail','Pérail',NULL),
	(1756,'perche','Perche',NULL),
	(1757,'perche-du-nil','Perche du nil',NULL),
	(1758,'persil','Persil',NULL),
	(1759,'pesto','Pesto',NULL),
	(1760,'pesto-rosso','Pesto rosso',NULL),
	(1761,'petit-beurre','Petit beurre',NULL),
	(1762,'petit-pois','Petit pois',NULL),
	(1763,'petit-sale','Petit salé',NULL),
	(1764,'petit-suisse','Petit suisse',NULL),
	(1765,'petoncle','Pétoncle',NULL),
	(1766,'picodon','Picodon',NULL),
	(1767,'pied-de-mouton','Pied-de-mouton',NULL),
	(1768,'pieds','Pieds',NULL),
	(1769,'pieds-de-mouton','Pieds de mouton',NULL),
	(1770,'pieuvre','Pieuvre',NULL),
	(1771,'pigeon','Pigeon',NULL),
	(1772,'pignon','Pignon',NULL),
	(1773,'pilon-de-poulet','Pilon de poulet',NULL),
	(1774,'piment','Piment',NULL),
	(1775,'piment-de-cayenne','Piment de Cayenne',NULL),
	(1776,'piments-mexicains','Piments mexicains',NULL),
	(1777,'pineau-des-charentes','Pineau des charentes',NULL),
	(1778,'pinot-noir','Pinot noir',NULL),
	(1779,'pintade','Pintade',NULL),
	(1780,'piquillo','Piquillo',NULL),
	(1781,'pissenlit','Pissenlit',NULL),
	(1782,'pistache','Pistache',NULL),
	(1783,'pistou','Pistou',NULL),
	(1784,'plantain','Plantain',NULL),
	(1785,'pleurote','Pleurote',NULL),
	(1786,'plie','Plie',NULL),
	(1787,'poire','Poire',NULL),
	(1788,'poireau','Poireau',NULL),
	(1789,'pois-casses','Pois cassés',NULL),
	(1790,'pois-chiche','Pois chiche',NULL),
	(1791,'poitrine-fumee','Poitrine fumée',NULL),
	(1792,'poivrade','Poivrade',NULL),
	(1793,'poivre','Poivre',NULL),
	(1794,'poivre-5-baies','Poivre 5 baies',NULL),
	(1795,'poivre-de-sichuan','Poivre de sichuan',NULL),
	(1796,'poivre-long','Poivre long',NULL),
	(1797,'poivre-vert','Poivre vert',NULL),
	(1798,'poivron','Poivron',NULL),
	(1799,'polenta','Polenta',NULL),
	(1800,'pomme','Pomme',NULL),
	(1801,'pomme-de-terre','Pomme de terre',NULL),
	(1802,'pommeau','Pommeau',NULL),
	(1803,'porc','Porc',NULL),
	(1804,'porto','Porto',NULL),
	(1805,'port-salut','Port-salut',NULL),
	(1806,'potimarron','Potimarron',NULL),
	(1807,'potiron','Potiron',NULL),
	(1808,'poudre-a-lever','Poudre à lever',NULL),
	(1809,'poudre-de-colombo','Poudre de colombo',NULL),
	(1810,'poularde','Poularde',NULL),
	(1811,'poule','Poule',NULL),
	(1812,'poulet','Poulet',NULL),
	(1813,'poulet-entier','Poulet entier',NULL),
	(1814,'poulpe','Poulpe',NULL),
	(1815,'poumons','Poumons',NULL),
	(1816,'pourpier','Pourpier',NULL),
	(1817,'poutargue','Poutargue',NULL),
	(1818,'praire','Praire',NULL),
	(1819,'pralin','Pralin',NULL),
	(1820,'pralinoise','Pralinoise',NULL),
	(1821,'provolone','Provolone',NULL),
	(1822,'prune','Prune',NULL),
	(1823,'pruneaux','Pruneaux',NULL),
	(1824,'pulpe-de-tomate','Pulpe de tomate',NULL),
	(1825,'puree','Purée',NULL),
	(1826,'puree-de-piment','Purée de piment',NULL),
	(1827,'pyrenees','Pyrénées',NULL),
	(1828,'quatre-epices','Quatre-épices',NULL),
	(1829,'quatre-quarts','Quatre-quarts',NULL),
	(1830,'quenelle','Quenelle',NULL),
	(1831,'quetsche','Quetsche',NULL),
	(1832,'queue','Queue',NULL),
	(1833,'quinoa','Quinoa',NULL),
	(1834,'rable-de-lapin','Râble de lapin',NULL),
	(1835,'raclette','Raclette',NULL),
	(1836,'radis','Radis',NULL),
	(1837,'raie','Raie',NULL),
	(1838,'raifort','Raifort',NULL),
	(1839,'raisin','Raisin',NULL),
	(1840,'raisins-secs','Raisins secs',NULL),
	(1841,'ras-el-hanout','Ras el Hanout',NULL),
	(1842,'rascasse','Rascasse',NULL),
	(1843,'ratatouille','Ratatouille',NULL),
	(1844,'rate','Rate',NULL),
	(1845,'ratte','Ratte',NULL),
	(1846,'ravioli','Ravioli',NULL),
	(1847,'reblochon','Reblochon',NULL),
	(1848,'reglisse','Réglisse',NULL),
	(1849,'renne','Renne',NULL),
	(1850,'requin','Requin',NULL),
	(1851,'rhubarbe','Rhubarbe',NULL),
	(1852,'rhum','Rhum',NULL),
	(1853,'ricotta','Ricotta',NULL),
	(1854,'riesling','Riesling',NULL),
	(1855,'rillettes','Rillettes',NULL),
	(1856,'rillons','Rillons',NULL),
	(1857,'ris-de-veau','Ris de veau',NULL),
	(1858,'risotto','Risotto',NULL),
	(1859,'riz','Riz',NULL),
	(1860,'riz-basmati','Riz basmati',NULL),
	(1861,'riz-gluant','Riz gluant',NULL),
	(1862,'riz-long','Riz long',NULL),
	(1863,'riz-rond','Riz rond',NULL),
	(1864,'riz-sauvage','Riz sauvage',NULL),
	(1865,'riz-surinam','Riz surinam',NULL),
	(1866,'riz-thai','Riz thaï',NULL),
	(1867,'rocamadour','Rocamadour',NULL),
	(1868,'rognons','Rognons',NULL),
	(1869,'romaine','Romaine',NULL),
	(1870,'romarin','Romarin',NULL),
	(1871,'roquefort','Roquefort',NULL),
	(1872,'roquette','Roquette',NULL),
	(1873,'rosbif','Rosbif',NULL),
	(1874,'rose','Rose',NULL),
	(1875,'rosette','Rosette',NULL),
	(1876,'roti-de-boeuf','Roti de boeuf',NULL),
	(1877,'roti-de-porc','Roti de porc',NULL),
	(1878,'roti-de-veau','Rôti de veau',NULL),
	(1879,'rougail','Rougail',NULL),
	(1880,'rouget','Rouget',NULL),
	(1881,'rouille','Rouille',NULL),
	(1882,'rumsteck','Rumsteck',NULL),
	(1883,'rutabaga','Rutabaga',NULL),
	(1884,'sables','Sablés',NULL),
	(1885,'sabodet','Sabodet',NULL),
	(1886,'safran','Safran',NULL),
	(1887,'saindoux','Saindoux',NULL),
	(1888,'saint-moret','Saint Morêt',NULL),
	(1889,'sainte-maure-de-touraine','Sainte-maure de Touraine',NULL),
	(1890,'saint-florentin','Saint-florentin',NULL),
	(1891,'saint-marcellin','Saint-marcellin',NULL),
	(1892,'saint-nectaire','Saint-nectaire',NULL),
	(1893,'saint-paulin','Saint-paulin',NULL),
	(1894,'saint-pierre','Saint-pierre',NULL),
	(1895,'sake','Saké',NULL),
	(1896,'salade','Salade',NULL),
	(1897,'salami','Salami',NULL),
	(1898,'salers','Salers',NULL),
	(1899,'salicorne','Salicorne',NULL),
	(1900,'salsifi','Salsifi',NULL),
	(1901,'sancerre','Sancerre',NULL),
	(1902,'sandre','Sandre',NULL),
	(1903,'sanglier','Sanglier',NULL),
	(1904,'sardine','Sardine',NULL),
	(1905,'sarrasin','Sarrasin',NULL),
	(1906,'sarriette','Sarriette',NULL),
	(1907,'sate','Saté',NULL),
	(1908,'sauce-bolognaise','Sauce bolognaise',NULL),
	(1909,'sauce-cocktail','Sauce cocktail',NULL),
	(1910,'sauce-hoisin','Sauce hoisin',NULL),
	(1911,'sauce-nuoc-mam','Sauce nuoc mam',NULL),
	(1912,'sauce-piquante','Sauce piquante',NULL),
	(1913,'sauce-soja','Sauce soja',NULL),
	(1914,'sauce-tartare','Sauce tartare',NULL),
	(1915,'sauce-tomate','Sauce tomate',NULL),
	(1916,'sauce-worcestershire','Sauce worcestershire',NULL),
	(1917,'saucisse-de-francfort','Saucisse de Francfort',NULL),
	(1918,'saucisse-de-montbeliard','Saucisse de Montbéliard',NULL),
	(1919,'saucisse-de-morteau','Saucisse de morteau',NULL),
	(1920,'saucisse-de-strasboug','Saucisse de Strasboug',NULL),
	(1921,'saucisse-de-toulouse','Saucisse de Toulouse',NULL),
	(1922,'saucisse-seche','Saucisse sèche',NULL),
	(1923,'saucisses','Saucisses',NULL),
	(1924,'saucisson','Saucisson',NULL),
	(1925,'saucisson-sec','Saucisson sec',NULL),
	(1926,'sauge','Sauge',NULL),
	(1927,'saumon','Saumon',NULL),
	(1928,'saumon-fume','Saumon fumé',NULL),
	(1929,'saute','Sauté',NULL),
	(1930,'saute-de-porc','Sauté de porc',NULL),
	(1931,'savora','Savora',NULL),
	(1932,'sbrinz','Sbrinz',NULL),
	(1933,'scampi','Scampi',NULL),
	(1934,'scarole','Scarole',NULL),
	(1935,'seiche','Seiche',NULL),
	(1936,'seigle','Seigle',NULL),
	(1937,'sel','Sel',NULL),
	(1938,'sel-de-celeri','Sel de céleri',NULL),
	(1939,'sel-et-poivre','Sel et poivre',NULL),
	(1940,'semoule','Semoule',NULL),
	(1941,'semoule-fine','Semoule fine',NULL),
	(1942,'semoule-moyenne','Semoule moyenne',NULL),
	(1943,'sere','Séré',NULL),
	(1944,'serpolet','Serpolet',NULL),
	(1945,'sesame','Sésame',NULL),
	(1946,'shortbread','Shortbread',NULL),
	(1947,'silure','Silure',NULL),
	(1948,'sirop-de-canne','Sirop de canne',NULL),
	(1949,'sirop-de-liege','Sirop de Liège',NULL),
	(1950,'soja','Soja',NULL),
	(1951,'sole','Sole',NULL),
	(1952,'sorgho','Sorgho',NULL),
	(1953,'soucis','Soucis',NULL),
	(1954,'soumaintrain','Soumaintrain',NULL),
	(1955,'spaghetti','Spaghetti',NULL),
	(1956,'spatzle','Spätzle',NULL),
	(1957,'speculoos','Spéculoos',NULL),
	(1958,'spigol','Spigol',NULL),
	(1959,'sprat','Sprat',NULL),
	(1960,'steak','Steak',NULL),
	(1961,'steak-hache','Steak haché',NULL),
	(1962,'stevia','Stévia',NULL),
	(1963,'stilton','Stilton',NULL),
	(1964,'sucre','Sucre',NULL),
	(1965,'sucre-de-canne','Sucre de canne',NULL),
	(1966,'sucre-en-poudre','Sucre en poudre',NULL),
	(1967,'sucre-roux','Sucre roux',NULL),
	(1968,'sucre-vanille','Sucre vanillé',NULL),
	(1969,'sucre-vanilline','Sucre vanilliné',NULL),
	(1970,'sumac','Sumac',NULL),
	(1971,'surimi','Surimi',NULL),
	(1972,'sylvaner','Sylvaner',NULL),
	(1973,'tabasco','Tabasco',NULL),
	(1974,'tacaud','Tacaud',NULL),
	(1975,'tagliatelle','Tagliatelle',NULL),
	(1976,'tamarin','Tamarin',NULL),
	(1977,'tandoori','Tandoori',NULL),
	(1978,'tapenade','Tapenade',NULL),
	(1979,'tapenade-noire','Tapenade noire',NULL),
	(1980,'tapenade-verte','Tapenade verte',NULL),
	(1981,'tarama','Tarama',NULL),
	(1982,'tellines','Tellines',NULL),
	(1983,'tete-de-moine','Tête de moine',NULL),
	(1984,'tete-de-veau','Tête de veau',NULL),
	(1985,'tetine','Tétine',NULL),
	(1986,'the','Thé',NULL),
	(1987,'the-matcha','Thé matcha',NULL),
	(1988,'the-vert','Thé vert',NULL),
	(1989,'thon','Thon',NULL),
	(1990,'thon-blanc','Thon blanc',NULL),
	(1991,'thon-rouge','Thon rouge',NULL),
	(1992,'thym','Thym',NULL),
	(1993,'tilleul','Tilleul',NULL),
	(1994,'tobiko','Tobiko',NULL),
	(1995,'tofu','Tofu',NULL),
	(1996,'tofu-soyeux','Tofu soyeux',NULL),
	(1997,'tomate','Tomate',NULL),
	(1998,'tomate-cerise','Tomate cerise',NULL),
	(1999,'tomate-pelee','Tomate pelée',NULL),
	(2000,'tome-piemontaise','Tome piemontaise',NULL),
	(2001,'tomme','Tomme',NULL),
	(2002,'tomme-vaudoise','Tomme vaudoise',NULL),
	(2003,'tonka-feve','Tonka (fève)',NULL),
	(2004,'topinambour','Topinambour',NULL),
	(2005,'torsades','Torsades',NULL),
	(2006,'torsette','Torsette',NULL),
	(2007,'tortellini','Tortellini',NULL),
	(2008,'tortilla','Tortilla',NULL),
	(2009,'tortilla-chips','Tortilla chips',NULL),
	(2010,'tournedos','Tournedos',NULL),
	(2011,'tourteau','Tourteau',NULL),
	(2012,'travers-de-porc','Travers de porc',NULL),
	(2013,'trevise','Trévise',NULL),
	(2014,'tripes','Tripes',NULL),
	(2015,'trompette-de-la-mort','Trompette de la mort',NULL),
	(2016,'truffe','Truffe',NULL),
	(2017,'truffe-noire-de-bourgogne','Truffe noire de bourgogne',NULL),
	(2018,'truite','Truite',NULL),
	(2019,'truite-saumonee','Truite saumonée',NULL),
	(2020,'turbot','Turbot',NULL),
	(2021,'tzatziki','Tzatziki',NULL),
	(2022,'vache-qui-rit','Vache qui rit',NULL),
	(2023,'vacherin','Vacherin',NULL),
	(2024,'vanille','Vanille',NULL),
	(2025,'veau','Veau',NULL),
	(2026,'vegetaline','Végétaline',NULL),
	(2027,'vergeoise','Vergeoise',NULL),
	(2028,'vergeoise-blonde','Vergeoise blonde',NULL),
	(2029,'vergeoise-brune','Vergeoise brune',NULL),
	(2030,'vermicelles','Vermicelles',NULL),
	(2031,'vermicelles-de-riz','Vermicelles de riz',NULL),
	(2032,'vermicelles-de-soja','Vermicelles de soja',NULL),
	(2033,'verveine','Verveine',NULL),
	(2034,'viande-de-grison','Viande de grison',NULL),
	(2035,'viandox','Viandox',NULL),
	(2036,'vieux-lille','Vieux lille',NULL),
	(2037,'vieux-pane','Vieux pané',NULL),
	(2038,'vin-blanc','Vin blanc',NULL),
	(2039,'vin-rose','Vin rosé',NULL),
	(2040,'vin-rouge','Vin rouge',NULL),
	(2041,'vinaigre','Vinaigre',NULL),
	(2042,'vinaigre-aromatise','Vinaigre aromatisé',NULL),
	(2043,'vinaigre-balsamique','Vinaigre balsamique',NULL),
	(2044,'vinaigre-de-cidre','Vinaigre de cidre',NULL),
	(2045,'vinaigre-de-datte','Vinaigre de datte',NULL),
	(2046,'vinaigre-de-framboise','Vinaigre de framboise',NULL),
	(2047,'vinaigre-de-riz','Vinaigre de riz',NULL),
	(2048,'vinaigre-de-vin','Vinaigre de vin',NULL),
	(2049,'vinaigre-de-xeres','Vinaigre de xeres',NULL),
	(2050,'vodka','Vodka',NULL),
	(2051,'wasabi','Wasabi',NULL),
	(2052,'whisky','Whisky',NULL),
	(2053,'xeres','Xérès',NULL),
	(2054,'yaourt-a-la-grecque','Yaourt à la grecque',NULL),
	(2055,'yaourt-allege','Yaourt allégé',NULL),
	(2056,'yaourt-aromatise','Yaourt aromatisé',NULL),
	(2057,'yaourt-aux-fruits','Yaourt aux fruits',NULL),
	(2058,'yaourt-brasse','Yaourt brassé',NULL),
	(2059,'yaourt-nature','Yaourt nature',NULL),
	(2060,'yaourts','Yaourts',NULL);

/*!40000 ALTER TABLE `INGREDIENT` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table MEDIA
# ------------------------------------------------------------

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



# Affichage de la table post
# ------------------------------------------------------------

DROP VIEW IF EXISTS `post`;

CREATE TABLE `post` (
   `id_user` INT(11) NOT NULL DEFAULT '0',
   `firstname_user` VARCHAR(50) NOT NULL,
   `lastname_user` VARCHAR(50) NOT NULL,
   `urlImage_user` VARCHAR(255) NULL DEFAULT NULL,
   `id_comment` INT(11) NOT NULL DEFAULT '0',
   `content_comment` TEXT NOT NULL,
   `dateAdd_comment` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
   `id_step` INT(11) NOT NULL,
   `id_recipe` INT(11) NOT NULL
) ENGINE=MyISAM;



# Affichage de la table PREPARATIONTIME
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PREPARATIONTIME`;

CREATE TABLE `PREPARATIONTIME` (
  `id_preparationTime` int(11) NOT NULL AUTO_INCREMENT,
  `slug_preparationTime` varchar(100) NOT NULL DEFAULT '',
  `name_preparationTime` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_preparationTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `PREPARATIONTIME` WRITE;
/*!40000 ALTER TABLE `PREPARATIONTIME` DISABLE KEYS */;

INSERT INTO `PREPARATIONTIME` (`id_preparationTime`, `slug_preparationTime`, `name_preparationTime`)
VALUES
	(1,'30-min','30 min'),
	(2,'60-min','60 min'),
	(3,'90-min+','90 min+');

/*!40000 ALTER TABLE `PREPARATIONTIME` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table RECIPE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RECIPE`;

CREATE TABLE `RECIPE` (
  `id_recipe` int(11) NOT NULL AUTO_INCREMENT,
  `slug_recipe` varchar(50) NOT NULL,
  `name_recipe` varchar(50) NOT NULL,
  `urlImage_recipe` varchar(255) DEFAULT NULL,
  `numberOfPeople_recipe` int(11) NOT NULL,
  `id_preparationTime` int(11) NOT NULL,
  `id_difficulty` int(1) NOT NULL DEFAULT '1',
  `id_type` int(1) NOT NULL DEFAULT '1',
  `dateAdd_recipe` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateUpdate_recipe` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `id_user` int(11) NOT NULL,
  `id_ambiance` int(11) NOT NULL,
  `votes_recipe` int(11) DEFAULT '0',
  PRIMARY KEY (`id_recipe`),
  KEY `id_user` (`id_user`),
  KEY `id_ambiance` (`id_ambiance`),
  KEY `difficulty_recipe` (`id_difficulty`),
  KEY `type_recipe` (`id_type`),
  KEY `preparationTime_recipe` (`id_preparationTime`),
  CONSTRAINT `recipe_ibfk_2` FOREIGN KEY (`id_ambiance`) REFERENCES `AMBIANCE` (`id_ambiance`),
  CONSTRAINT `recipe_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `USER` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `recipe_ibfk_4` FOREIGN KEY (`id_difficulty`) REFERENCES `DIFFICULTY` (`id_difficulty`),
  CONSTRAINT `recipe_ibfk_5` FOREIGN KEY (`Id_type`) REFERENCES `TYPE` (`id_type`),
  CONSTRAINT `recipe_ibfk_6` FOREIGN KEY (`id_preparationTime`) REFERENCES `PREPARATION_TIME` (`id_PREPARATION_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `RECIPE` WRITE;
/*!40000 ALTER TABLE `RECIPE` DISABLE KEYS */;

INSERT INTO `RECIPE` (`id_recipe`, `slug_recipe`, `name_recipe`, `urlImage_recipe`, `numberOfPeople_recipe`, `id_preparationTime`, `id_difficulty`, `id_type`, `dateAdd_recipe`, `dateUpdate_recipe`, `id_user`, `id_ambiance`, `votes_recipe`)
VALUES
	(1,'tarte-aux-pommes','Tarte aux pommes','',8,3,1,3,'2014-02-19 17:27:46','2014-02-23 17:56:46',1,5,1),
	(2,'tarte-aux-prunes','Tarte aux prunes','',2,1,1,3,'2014-02-19 17:27:46','0000-00-00 00:00:00',2,2,2),
	(3,'agneau-a-l-abricot','Agneau à l\'abricot','',1,1,1,2,'2014-02-20 15:29:03','2014-02-22 19:59:00',1,3,2),
	(5,'repoune-de-baleine','Repoune de baleine','http://distilleryimage10.ak.instagram.com/2edcbb1a9fa411e3859712a851556c4a_8.jpg',6,3,1,2,'2014-02-21 09:41:43','0000-00-00 00:00:00',2,3,1),
	(6,'salade-a-la-mingogo','Salade à la Mingogo','',2,1,1,1,'2014-02-21 10:13:21','0000-00-00 00:00:00',2,4,0),
	(7,'salade-facon-mingoia','Salade façon Mingoia','',2,1,1,2,'2014-02-21 10:15:41','0000-00-00 00:00:00',6,1,0);

/*!40000 ALTER TABLE `RECIPE` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table STEP
# ------------------------------------------------------------

DROP TABLE IF EXISTS `STEP`;

CREATE TABLE `STEP` (
  `id_step` int(11) NOT NULL AUTO_INCREMENT,
  `order_step` int(5) NOT NULL,
  `content_step` text NOT NULL,
  `id_recipe` int(11) NOT NULL,
  `countComment_step` int(11) NOT NULL,
  PRIMARY KEY (`id_step`),
  UNIQUE KEY `order_step` (`order_step`,`id_recipe`),
  KEY `id_recipe` (`id_recipe`),
  CONSTRAINT `step_ibfk_2` FOREIGN KEY (`id_recipe`) REFERENCES `RECIPE` (`id_recipe`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `STEP` WRITE;
/*!40000 ALTER TABLE `STEP` DISABLE KEYS */;

INSERT INTO `STEP` (`id_step`, `order_step`, `content_step`, `id_recipe`, `countComment_step`)
VALUES
	(3,1,'Faire cuire',2,0),
	(5,1,'Sortir les casseroles',5,2),
	(6,2,'Mettre du sel',5,0),
	(7,1,'Sortir la salade de la casserole',6,0),
	(8,1,'Pour la sauce, mélanger une cuillère à café de moutarde de Dijon, 3 cuillères à soupe d\'huile d\'olive, 1 cuillère à soupe de vinaigre balsamique, et assaisonner à sa guise',7,0),
	(9,2,'Disposer la salade dans des assiettes',7,0),
	(10,3,'Y mettre la sauce',7,0),
	(11,4,'Déposer deux tranches fines de jambon de Parme découenné par assiette',7,0),
	(12,5,'Saupoudrer de copeaux de parmesan',7,0),
	(13,6,'Servir rapidement',7,0),
	(73,1,'Tuer l\'agneau',3,0),
	(91,1,'Faire cuire',1,0),
	(98,2,'TEST3',1,0),
	(99,2,'Manger',3,0);

/*!40000 ALTER TABLE `STEP` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table submit
# ------------------------------------------------------------

DROP VIEW IF EXISTS `submit`;

CREATE TABLE `submit` (
   `id_user` INT(11) NOT NULL DEFAULT '0',
   `firstname_user` VARCHAR(50) NOT NULL,
   `lastname_user` VARCHAR(50) NOT NULL,
   `id_recipe` INT(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Affichage de la table subscribe
# ------------------------------------------------------------

DROP VIEW IF EXISTS `subscribe`;

CREATE TABLE `subscribe` (
   `id_follower` INT(11) NOT NULL,
   `firstname_follower` VARCHAR(50) NOT NULL,
   `lastname_follower` VARCHAR(50) NOT NULL,
   `bio_follower` TEXT NULL DEFAULT NULL,
   `id_following` INT(11) NOT NULL,
   `firstname_following` VARCHAR(50) NOT NULL,
   `lastname_following` VARCHAR(50) NOT NULL,
   `bio_following` TEXT NULL DEFAULT NULL
) ENGINE=MyISAM;



# Affichage de la table TYPE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TYPE`;

CREATE TABLE `TYPE` (
  `id_type` int(11) NOT NULL AUTO_INCREMENT,
  `slug_type` varchar(100) NOT NULL DEFAULT '',
  `name_type` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `TYPE` WRITE;
/*!40000 ALTER TABLE `TYPE` DISABLE KEYS */;

INSERT INTO `TYPE` (`id_type`, `slug_type`, `name_type`)
VALUES
	(1,'entree','Entrée'),
	(2,'plat','Plat'),
	(3,'dessert','Dessert');

/*!40000 ALTER TABLE `TYPE` ENABLE KEYS */;
UNLOCK TABLES;


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
	(1,'antoine-wattier',0,'Antoine','WATTIER','wattier.antoine@gmail.com','test','Salut je suis le premier utilisateur du site, c\'est un grand honneur.','public/uploads/user/1/panda.jpg',NULL,NULL,NULL,'2014-02-19 16:36:22','2014-03-01 14:40:02'),
	(2,'laure-boutmy',0,'Laure','Boutmy','laureboutmy@gmail.com','test','','',NULL,NULL,NULL,'2014-02-19 18:35:23','2014-03-01 14:12:20'),
	(6,'hugo-m',0,'Hugo','M','hugomingoia@gmail.com','untrucbidon','',NULL,NULL,NULL,NULL,'2014-02-21 10:03:38','0000-00-00 00:00:00'),
	(7,'valentin-beunard',0,'Valentin','Beunard','beunard@gmail.c','test','',NULL,NULL,NULL,NULL,'2014-02-21 11:23:01','2014-02-21 11:31:42'),
	(8,'antoine-wattier',0,'Antoine','WATTIER','wattier.antoine@gmail.com','azerty','',NULL,NULL,NULL,NULL,'2014-02-21 12:53:20','0000-00-00 00:00:00'),
	(35,'antoine-wattier',0,'Antoine','Wattier','wattier.antoine@gmail.com','','Marre de la vie, heureusement qu\'il y a les cookies et les raviolis...','public/uploads/user/35/PP.jpg',NULL,'100001487385616',NULL,'2014-02-27 19:48:01','2014-03-02 02:19:32'),
	(37,'julien-perriere',0,'Julien','Perrière','julien@creativecretin.com','test','Photoshop master. Short trousers lover. Yoga addict','public/uploads/user/37/ju.jpg',NULL,NULL,NULL,'2014-03-02 02:15:09','0000-00-00 00:00:00');

/*!40000 ALTER TABLE `USER` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table VOTE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `VOTE`;

CREATE TABLE `VOTE` (
  `id_vote` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_recipe` int(11) NOT NULL,
  `date_vote` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_vote`),
  KEY `id_user` (`id_user`),
  KEY `id_recipe` (`id_recipe`),
  CONSTRAINT `vote_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `USER` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `vote_ibfk_4` FOREIGN KEY (`id_recipe`) REFERENCES `RECIPE` (`id_recipe`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `VOTE` WRITE;
/*!40000 ALTER TABLE `VOTE` DISABLE KEYS */;

INSERT INTO `VOTE` (`id_vote`, `id_user`, `id_recipe`, `date_vote`)
VALUES
	(435,1,5,'2014-02-22 00:15:00'),
	(442,1,1,'2014-02-22 12:31:21'),
	(445,1,2,'2014-02-22 17:09:12'),
	(446,1,3,'2014-02-22 19:59:09'),
	(469,35,3,'2014-03-02 00:09:17');

/*!40000 ALTER TABLE `VOTE` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `INCREMENT_VOTE` AFTER INSERT ON `VOTE` FOR EACH ROW UPDATE RECIPE SET votes_recipe = votes_recipe + 1
WHERE id_recipe = NEW.id_recipe; */;;
/*!50003 SET SESSION SQL_MODE="STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `DECREMENT_VOTE` BEFORE DELETE ON `VOTE` FOR EACH ROW UPDATE RECIPE SET votes_recipe = votes_recipe - 1
WHERE id_recipe = OLD.id_recipe; */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;




# Replace placeholder table for submit with correct view syntax
# ------------------------------------------------------------

DROP TABLE `submit`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `submit`
AS SELECT
   `user`.`id_user` AS `id_user`,
   `user`.`firstname_user` AS `firstname_user`,
   `user`.`lastname_user` AS `lastname_user`,
   `recipe`.`id_recipe` AS `id_recipe`
FROM (`user` join `recipe` on((`user`.`id_user` = `recipe`.`id_user`)));


# Replace placeholder table for post with correct view syntax
# ------------------------------------------------------------

DROP TABLE `post`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `post`
AS SELECT
   `u`.`id_user` AS `id_user`,
   `u`.`firstname_user` AS `firstname_user`,
   `u`.`lastname_user` AS `lastname_user`,
   `u`.`urlImage_user` AS `urlImage_user`,
   `c`.`id_comment` AS `id_comment`,
   `c`.`content_comment` AS `content_comment`,
   `c`.`dateAdd_comment` AS `dateAdd_comment`,
   `c`.`id_step` AS `id_step`,
   `s`.`id_recipe` AS `id_recipe`
FROM ((`comment` `c` join `user` `u` on((`c`.`id_user` = `u`.`id_user`))) join `step` `s` on((`c`.`id_step` = `s`.`id_step`)));


# Replace placeholder table for favorite with correct view syntax
# ------------------------------------------------------------

DROP TABLE `favorite`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `favorite`
AS SELECT
   `user`.`id_user` AS `id_user`,
   `user`.`lastname_user` AS `lastname_user`,
   `user`.`firstname_user` AS `firstname_user`,
   `recipe`.`id_recipe` AS `id_recipe`,
   `recipe`.`name_recipe` AS `name_recipe`,
   `recipe`.`urlImage_recipe` AS `urlImage_recipe`,
   `recipe`.`votes_recipe` AS `votes_recipe`,
   `recipe`.`dateAdd_recipe` AS `dateAdd_recipe`,
   `recipe`.`id_ambiance` AS `id_ambiance`,
   `recipe`.`id_preparationTime` AS `id_preparationTime`,
   `recipe`.`id_difficulty` AS `id_difficulty`,
   `recipe`.`id_type` AS `id_type`,
   `recipe`.`numberOfPeople_recipe` AS `numberOfPeople_recipe`,
   `ambiance`.`name_ambiance` AS `name_ambiance`,
   `preparationtime`.`name_preparationTime` AS `name_preparationTime`,
   `difficulty`.`name_difficulty` AS `name_difficulty`,
   `type`.`name_type` AS `name_type`
FROM ((((((`vote` `v` join `user` on((`v`.`id_user` = `user`.`id_user`))) join `recipe` on((`v`.`id_recipe` = `recipe`.`id_recipe`))) join `ambiance` on((`recipe`.`id_ambiance` = `ambiance`.`id_ambiance`))) join `preparationtime` on((`recipe`.`id_preparationTime` = `preparationtime`.`id_preparationTime`))) join `difficulty` on((`recipe`.`id_difficulty` = `difficulty`.`id_difficulty`))) join `type` on((`recipe`.`id_type` = `type`.`id_type`)));


# Replace placeholder table for fullrecipe with correct view syntax
# ------------------------------------------------------------

DROP TABLE `fullrecipe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `fullrecipe`
AS SELECT
   `user`.`id_user` AS `id_user`,
   `user`.`lastname_user` AS `lastname_user`,
   `user`.`firstname_user` AS `firstname_user`,
   `recipe`.`id_recipe` AS `id_recipe`,
   `recipe`.`name_recipe` AS `name_recipe`,
   `recipe`.`urlImage_recipe` AS `urlImage_recipe`,
   `recipe`.`votes_recipe` AS `votes_recipe`,
   `recipe`.`dateAdd_recipe` AS `dateAdd_recipe`,
   `recipe`.`id_ambiance` AS `id_ambiance`,
   `recipe`.`id_preparationTime` AS `id_preparationTime`,
   `recipe`.`id_difficulty` AS `id_difficulty`,
   `recipe`.`id_type` AS `id_type`,
   `recipe`.`numberOfPeople_recipe` AS `numberOfPeople_recipe`,
   `ambiance`.`name_ambiance` AS `name_ambiance`,
   `preparationtime`.`name_preparationTime` AS `name_preparationTime`,
   `difficulty`.`name_difficulty` AS `name_difficulty`,
   `type`.`name_type` AS `name_type`
FROM (((((`recipe` join `user` on((`recipe`.`id_user` = `user`.`id_user`))) join `ambiance` on((`recipe`.`id_ambiance` = `ambiance`.`id_ambiance`))) join `preparationtime` on((`recipe`.`id_preparationTime` = `preparationtime`.`id_preparationTime`))) join `difficulty` on((`recipe`.`id_difficulty` = `difficulty`.`id_difficulty`))) join `type` on((`recipe`.`id_type` = `type`.`id_type`)));


# Replace placeholder table for subscribe with correct view syntax
# ------------------------------------------------------------

DROP TABLE `subscribe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `subscribe`
AS SELECT
   `follow`.`id_follower` AS `id_follower`,
   `u`.`firstname_user` AS `firstname_follower`,
   `u`.`lastname_user` AS `lastname_follower`,
   `u`.`bio_user` AS `bio_follower`,
   `follow`.`id_following` AS `id_following`,
   `uu`.`firstname_user` AS `firstname_following`,
   `uu`.`lastname_user` AS `lastname_following`,
   `uu`.`bio_user` AS `bio_following`
FROM ((`follow` join `user` `u` on((`u`.`id_user` = `follow`.`id_follower`))) join `user` `uu` on((`uu`.`id_user` = `follow`.`id_following`)));


# Replace placeholder table for associate with correct view syntax
# ------------------------------------------------------------

DROP TABLE `associate`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `associate`
AS SELECT
   `ingredient`.`id_ingredient` AS `id_ingredient`,
   `ingredient`.`name_ingredient` AS `name_ingredient`,
   `compose`.`id_recipe` AS `id_recipe`,
   `compose`.`quantity_ingredient` AS `quantity_ingredient`
FROM (`ingredient` join `compose` on((`ingredient`.`id_ingredient` = `compose`.`id_ingredient`)));


# Replace placeholder table for adapt with correct view syntax
# ------------------------------------------------------------

DROP TABLE `adapt`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `adapt`
AS SELECT
   `ambiance`.`id_ambiance` AS `id_ambiance`,
   `ambiance`.`name_ambiance` AS `name_ambiance`,
   `recipe`.`id_recipe` AS `id_recipe`
FROM (`recipe` join `ambiance` on((`recipe`.`id_ambiance` = `ambiance`.`id_ambiance`)));

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
