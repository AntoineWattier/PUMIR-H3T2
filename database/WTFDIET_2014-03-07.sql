# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Hôte: 127.0.0.1 (MySQL 5.6.16)
# Base de données: WTFDIET
# Temps de génération: 2014-03-07 09:54:57 +0000
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
	(1,'repas-leger','Repas léger','Parce que faire attention à sa ligne ne doit pas vous empêcher de vous faire plaisir, savourez nos repas légers.','public/images/assets/repas-leger.png'),
	(2,'repas-rapide','Repas rapide','Des recettes pour vos pauses-déj et  repas sur le pouce. Parce qu’il n’y a pas besoin de faire long pour faire bon !','public/images/assets/repas-rapide.png'),
	(3,'saveurs-d-ailleurs','Saveurs d\'ailleurs','Asiatique, africaine, sud-américaine, alsacienne, découvrez les saveurs du monde entier.','public/images/assets/repas-ailleurs.png'),
	(4,'repas-vegetarien','Repas végétarien','Une sélection de recettes contenant graines, tiges et autres racines qui vous donneront l’eau à la bouche.','public/images/assets/repas-vegetarien.png'),
	(5,'repas-gourmand','Repas gourmand','Ravissez vos papilles et celles de vos proches avec nos entrées, plats et desserts gourmands.','public/images/assets/repas-gourmand.png');

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
	(142,47,15,'Il faut vraiment un moule de 30cm ?','2014-03-07 10:45:00','0000-00-00 00:00:00');

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
	(2069,55,'3 gousses d\'ail',NULL),
	(2069,60,'3 gousses',NULL),
	(2074,57,'',NULL),
	(2102,55,'',NULL),
	(2125,57,'',NULL),
	(2125,61,'3 cuillères à soupe',NULL),
	(2137,53,'24',NULL),
	(2140,62,'1Kg',NULL),
	(2150,60,'1 kg 500',NULL),
	(2159,49,'12,5cl',NULL),
	(2188,53,'30g en poudre',NULL),
	(2189,53,'1/2 L',NULL),
	(2200,57,'',NULL),
	(2200,58,' 1/2 cuillère à caf',NULL),
	(2212,58,'3-4',NULL),
	(2212,59,'5 ou 6',NULL),
	(2214,59,'20 petits',NULL),
	(2241,61,'24',NULL),
	(2268,61,'rouge',NULL),
	(2282,62,'1',NULL),
	(2297,51,'rouge, 3-4 gouttes',NULL),
	(2303,59,'2',NULL),
	(2325,58,'3-4',NULL),
	(2337,43,'1 pot',NULL),
	(2339,62,'5 cuillères à soupe',NULL),
	(2377,44,'bouillante, 40cl',NULL),
	(2377,52,'gazeuse, 20cl',NULL),
	(2406,62,'15',NULL),
	(2409,52,'200g',NULL),
	(2409,57,'',NULL),
	(2460,59,'10 (type fajitas)',NULL),
	(2512,43,'150gr râpé',NULL),
	(2513,62,'',NULL),
	(2529,60,'750 g ',NULL),
	(2537,52,'2 cuillères à soupe',NULL),
	(2537,58,'4 cuillères à soupe',NULL),
	(2562,59,'',NULL),
	(2595,55,'1 barde',NULL),
	(2599,55,'',NULL),
	(2607,52,'1 paquet',NULL),
	(2644,53,'250g',NULL),
	(2672,43,'3 cuillères à soupe',NULL),
	(2675,58,'1kg',NULL),
	(2686,58,'3-4',NULL),
	(2697,45,'1,5 feuilles',NULL),
	(2707,53,'3',NULL),
	(2711,44,'de Printemps, 2',NULL),
	(2711,55,'',NULL),
	(2711,58,'2',NULL),
	(2711,60,'2 gros',NULL),
	(2711,61,'2',NULL),
	(2711,62,'2',NULL),
	(2773,43,'1',NULL),
	(2805,62,'',NULL),
	(2820,58,'1 poignée',NULL),
	(2823,58,'1 pincée',NULL),
	(2823,61,'',NULL),
	(2828,60,'1',NULL),
	(2828,62,'3',NULL),
	(2830,51,'20',NULL),
	(2830,57,'',NULL),
	(2830,61,'3, acide',NULL),
	(2831,55,'1/pers',NULL),
	(2831,58,'3-4',NULL),
	(2852,45,'séchée, 1',NULL),
	(2891,45,'',NULL),
	(2891,49,'',NULL),
	(2917,55,'1/4 livre',NULL),
	(2917,61,'2 cuillères à soupe',NULL),
	(2925,49,'6,5cl',NULL),
	(2926,62,'10 feuilles',NULL),
	(2947,55,'6',NULL),
	(2954,55,'',NULL),
	(2957,45,'1/2 filet',NULL),
	(2967,55,'',NULL),
	(2967,61,'',NULL),
	(2980,44,'1 cuillere à café',NULL),
	(2994,49,'2 cuillères à soupe',NULL),
	(2994,51,'60cl',NULL),
	(2994,61,'3',NULL),
	(2996,52,'50g',NULL),
	(2996,57,'',NULL),
	(2997,53,'100g',NULL),
	(2998,53,'1 sachet',NULL),
	(3019,43,'2 boîtes',NULL),
	(3019,49,'1 pavé',NULL),
	(3022,55,'',NULL),
	(3025,44,'100g',NULL),
	(3027,43,'3',NULL),
	(3027,58,'3-4',NULL),
	(3027,62,'3',NULL),
	(3068,55,'2 verres',NULL),
	(3070,61,'10 cl',NULL),
	(3071,61,'1 filet',NULL),
	(3077,49,'25cl',NULL),
	(3081,49,'',NULL);

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
	(46,45,47,'2014-03-07 10:52:21');

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
	(2060,'yaourts','Yaourts',NULL),
	(2061,'abadeche','Abadèche',NULL),
	(2062,'abondance','Abondance',NULL),
	(2063,'abricot','Abricot',NULL),
	(2064,'agar-agar','Agar-agar',NULL),
	(2065,'agneau','Agneau',NULL),
	(2066,'aiguillette-de-canard','Aiguillette de canard',NULL),
	(2067,'aiguillette-de-poulet','Aiguillette de poulet',NULL),
	(2068,'aiguillettes-de-dinde','Aiguillettes de dinde',NULL),
	(2069,'ail','Ail',NULL),
	(2070,'aile-de-poulet','Aile de poulet',NULL),
	(2071,'airelles','Airelles',NULL),
	(2072,'alevin','Alevin',NULL),
	(2073,'aligot','Aligot',NULL),
	(2074,'amande','Amande',NULL),
	(2075,'amaretto','Amaretto',NULL),
	(2076,'amidon','Amidon',NULL),
	(2077,'ananas','Ananas',NULL),
	(2078,'anchoiade','Anchoïade',NULL),
	(2079,'anchois','Anchois',NULL),
	(2080,'andouille','Andouille',NULL),
	(2081,'andouillette','Andouillette',NULL),
	(2082,'aneth','Aneth',NULL),
	(2083,'anguille','Anguille',NULL),
	(2084,'anis-etoile','Anis étoilé',NULL),
	(2085,'anis-vert','Anis vert',NULL),
	(2086,'appenzeller','Appenzeller',NULL),
	(2087,'arachide','Arachide',NULL),
	(2088,'araignee-de-mer','Araignée de mer',NULL),
	(2089,'arbois','Arbois',NULL),
	(2090,'arbouse','Arbouse',NULL),
	(2091,'armagnac','Armagnac',NULL),
	(2092,'arome','Arôme',NULL),
	(2093,'artichaut','Artichaut',NULL),
	(2094,'asperge','Asperge',NULL),
	(2095,'aubergine','Aubergine',NULL),
	(2096,'autruche','Autruche',NULL),
	(2097,'avocat','Avocat',NULL),
	(2098,'avoine','Avoine',NULL),
	(2099,'bacon','Bacon',NULL),
	(2100,'badiane','Badiane',NULL),
	(2101,'baguette','Baguette',NULL),
	(2102,'baie-de-genevrier','Baie de genévrier',NULL),
	(2103,'baie-rouge','Baie rouge',NULL),
	(2104,'baies-rose','Baies rose',NULL),
	(2105,'bambou','Bambou',NULL),
	(2106,'banane','Banane',NULL),
	(2107,'banane-plantain','Banane plantain',NULL),
	(2108,'banon','Banon',NULL),
	(2109,'bar','Bar',NULL),
	(2110,'barbue','Barbue',NULL),
	(2111,'baron','Baron',NULL),
	(2112,'basilic','Basilic',NULL),
	(2113,'bastogne','Bastogne',NULL),
	(2114,'beaufort','Beaufort',NULL),
	(2115,'beaujolais','Beaujolais',NULL),
	(2116,'becasse','Bécasse',NULL),
	(2117,'bechamel','Béchamel',NULL),
	(2118,'beef-steak','Beef steak',NULL),
	(2119,'belangere','Bélangère',NULL),
	(2120,'bergamote','Bergamote',NULL),
	(2121,'bergerac','Bergerac',NULL),
	(2122,'bernique','Bernique',NULL),
	(2123,'betterave','Betterave',NULL),
	(2124,'bettes-a-cardes','Bettes à cardes',NULL),
	(2125,'beurre','Beurre',NULL),
	(2126,'beurre-allege','Beurre allégé',NULL),
	(2127,'beurre-de-cacahuete','Beurre de cacahuète',NULL),
	(2128,'beurre-doux','Beurre doux',NULL),
	(2129,'beurre-tendre','Beurre tendre',NULL),
	(2130,'bicarbonate','Bicarbonate',NULL),
	(2131,'biere','Bière',NULL),
	(2132,'bigarade','Bigarade',NULL),
	(2133,'bigorneau','Bigorneau',NULL),
	(2134,'biscotte','Biscotte',NULL),
	(2135,'biscuit-cuiller','Biscuit cuiller',NULL),
	(2136,'biscuit-sec','Biscuit sec',NULL),
	(2137,'biscuits-a-la-cuillere','Biscuits à la cuillère',NULL),
	(2138,'bison','Bison',NULL),
	(2139,'blanc-de-dinde','Blanc de dinde',NULL),
	(2140,'blanc-de-poulet','Blanc de poulet',NULL),
	(2141,'blanquette-de-veau','Blanquette de veau',NULL),
	(2142,'ble','Blé',NULL),
	(2143,'blette','Blette',NULL),
	(2144,'bleu','Bleu',NULL),
	(2145,'bleu-de-bresse','Bleu de bresse',NULL),
	(2146,'bleu-de-gex','Bleu de gex',NULL),
	(2147,'bleu-des-causses','Bleu des causses',NULL),
	(2148,'blini','Blini',NULL),
	(2149,'bocconcini','Bocconcini',NULL),
	(2150,'boeuf','Boeuf',NULL),
	(2151,'bok-choy','Bok choy',NULL),
	(2152,'bolet','Bolet',NULL),
	(2153,'bonbon-arlequin','Bonbon arlequin',NULL),
	(2154,'bonnet','Bonnet',NULL),
	(2155,'bordeaux','Bordeaux',NULL),
	(2156,'boudin-blanc','Boudin blanc',NULL),
	(2157,'boudin-noir','Boudin noir',NULL),
	(2158,'boudoir','Boudoir',NULL),
	(2159,'bouillon','Bouillon',NULL),
	(2160,'bouillon-de-boeuf','Bouillon de boeuf',NULL),
	(2161,'bouillon-de-legume','Bouillon de légume',NULL),
	(2162,'bouillon-de-poule','Bouillon de poule',NULL),
	(2163,'bouillon-de-volaille','Bouillon de volaille',NULL),
	(2164,'boulgour','Boulgour',NULL),
	(2165,'bouquet-garni','Bouquet garni',NULL),
	(2166,'bourgeois','Bourgeois',NULL),
	(2167,'bourgogne','Bourgogne',NULL),
	(2168,'bourguignon','Bourguignon',NULL),
	(2169,'bourrache','Bourrache',NULL),
	(2170,'boursault','Boursault',NULL),
	(2171,'boursin','Boursin',NULL),
	(2172,'bresaola','Bresaola',NULL),
	(2173,'brick','Brick',NULL),
	(2174,'brie-de-meaux','Brie de meaux',NULL),
	(2175,'brillat-savarin','Brillat-savarin',NULL),
	(2176,'brioche','Brioche',NULL),
	(2177,'brique','Brique',NULL),
	(2178,'brocciu','Brocciu',NULL),
	(2179,'brochet','Brochet',NULL),
	(2180,'brocoli','Brocoli',NULL),
	(2181,'brousse','Brousse',NULL),
	(2182,'brownie','Brownie',NULL),
	(2183,'brugnon','Brugnon',NULL),
	(2184,'bulot','Bulot',NULL),
	(2185,'butternut','Butternut',NULL),
	(2186,'cabecou','Cabécou',NULL),
	(2187,'cabillaud','Cabillaud',NULL),
	(2188,'cacao','Cacao',NULL),
	(2189,'cafe','Café',NULL),
	(2190,'cafe-soluble','Café soluble',NULL),
	(2191,'caille','Caille',NULL),
	(2192,'caillette','Caillette',NULL),
	(2193,'calamar','Calamar',NULL),
	(2194,'calvados','Calvados',NULL),
	(2195,'camembert','Camembert',NULL),
	(2196,'canard','Canard',NULL),
	(2197,'cancoillotte','Cancoillotte',NULL),
	(2198,'canette','Canette',NULL),
	(2199,'canneberge','Canneberge',NULL),
	(2200,'cannelle','Cannelle',NULL),
	(2201,'canneloni','Canneloni',NULL),
	(2202,'cantal','Cantal',NULL),
	(2203,'capelan','Capelan',NULL),
	(2204,'capres','Câpres',NULL),
	(2205,'caprice-des-dieux','Caprice des dieux',NULL),
	(2206,'capucine','Capucine',NULL),
	(2207,'carambole','Carambole',NULL),
	(2208,'caramel','Caramel',NULL),
	(2209,'caramel-au-beurre-sale','Caramel au beurre salé',NULL),
	(2210,'cardamome','Cardamome',NULL),
	(2211,'cardon','Cardon',NULL),
	(2212,'carotte','Carotte',NULL),
	(2213,'carpe','Carpe',NULL),
	(2214,'carre-frais','Carré frais',NULL),
	(2215,'carrelet','Carrelet',NULL),
	(2216,'cassis','Cassis',NULL),
	(2217,'cassonade','Cassonade',NULL),
	(2218,'caviar','Caviar',NULL),
	(2219,'cedrat','Cédrat',NULL),
	(2220,'celeri','Céleri',NULL),
	(2221,'celeri-rave','Céleri-rave',NULL),
	(2222,'cepe','Cèpe',NULL),
	(2223,'cereale','Céréale',NULL),
	(2224,'cerf','Cerf',NULL),
	(2225,'cerfeuil','Cerfeuil',NULL),
	(2226,'cerise','Cerise',NULL),
	(2227,'cerise-de-terre','Cerise de terre',NULL),
	(2228,'cervelas','Cervelas',NULL),
	(2229,'cervelle','Cervelle',NULL),
	(2230,'chabichou','Chabichou',NULL),
	(2231,'chair-a-saucisse','Chair à saucisse',NULL),
	(2232,'champagne','Champagne',NULL),
	(2233,'champignon','Champignon',NULL),
	(2234,'champignon-frais','Champignon frais',NULL),
	(2235,'champignon-noir','Champignon noir',NULL),
	(2236,'chanterelle','Chanterelle',NULL),
	(2237,'chaource','Chaource',NULL),
	(2238,'chapelure','Chapelure',NULL),
	(2239,'chapon','Chapon',NULL),
	(2240,'charolais','Charolais',NULL),
	(2241,'chataigne','Châtaigne',NULL),
	(2242,'chaume','Chaume',NULL),
	(2243,'chayote','Chayote',NULL),
	(2244,'cheddar','Cheddar',NULL),
	(2245,'chene','Chêne',NULL),
	(2246,'chermoula','Chermoula',NULL),
	(2247,'chevre','Chèvre',NULL),
	(2248,'chevreau','Chevreau',NULL),
	(2249,'chevreuil','Chevreuil',NULL),
	(2250,'chicon','Chicon',NULL),
	(2251,'chicoree','Chicorée',NULL),
	(2252,'chili','Chili',NULL),
	(2253,'chipiron','Chipiron',NULL),
	(2254,'chipolata','Chipolata',NULL),
	(2255,'chips','Chips',NULL),
	(2256,'chocolat','Chocolat',NULL),
	(2257,'chocolat-a-tartiner','Chocolat à tartiner',NULL),
	(2258,'chocolat-amer','Chocolat amer',NULL),
	(2259,'chocolat-au-lait','Chocolat au lait',NULL),
	(2260,'chocolat-au-riz-souffle','Chocolat au riz soufflé',NULL),
	(2261,'chocolat-aux-noisettes','Chocolat aux noisettes',NULL),
	(2262,'chocolat-blanc','Chocolat blanc',NULL),
	(2263,'chocolat-de-couverture','Chocolat de couverture',NULL),
	(2264,'chocolat-en-poudre','Chocolat en poudre',NULL),
	(2265,'chocolat-noir','Chocolat noir',NULL),
	(2266,'chocolat-patissier','Chocolat pâtissier',NULL),
	(2267,'chorizo','Chorizo',NULL),
	(2268,'chou','Chou',NULL),
	(2269,'chou-chinois','Chou chinois',NULL),
	(2270,'chou-de-bruxelles','Chou de bruxelles',NULL),
	(2271,'chou-romanesco','Chou romanesco',NULL),
	(2272,'chouchou','Chouchou',NULL),
	(2273,'chou-fleur','Chou-fleur',NULL),
	(2274,'christophine','Christophine',NULL),
	(2275,'ciboule','Ciboule',NULL),
	(2276,'ciboulette','Ciboulette',NULL),
	(2277,'cidre','Cidre',NULL),
	(2278,'cigale-de-mer','Cigale de mer',NULL),
	(2279,'cigarette-russe','Cigarette russe',NULL),
	(2280,'cinq-parfums','Cinq parfums',NULL),
	(2281,'cinq-epices','Cinq-épices',NULL),
	(2282,'citron','Citron',NULL),
	(2283,'citron-confit','Citron confit',NULL),
	(2284,'citron-vert','Citron vert',NULL),
	(2285,'citronnelle','Citronnelle',NULL),
	(2286,'citrouille','Citrouille',NULL),
	(2287,'clams','Clams',NULL),
	(2288,'clementine','Clémentine',NULL),
	(2289,'clou-de-girofle','Clou de girofle',NULL),
	(2290,'coeur','Coeur',NULL),
	(2291,'coeur-de-palmier','Coeur de palmier',NULL),
	(2292,'cognac','Cognac',NULL),
	(2293,'coing','Coing',NULL),
	(2294,'coleslaw','Coleslaw',NULL),
	(2295,'colin','Colin',NULL),
	(2296,'colorant','Colorant',NULL),
	(2297,'colorant-alimentaire','Colorant alimentaire',NULL),
	(2298,'combava','Combava',NULL),
	(2299,'compote','Compote',NULL),
	(2300,'comte','Comté',NULL),
	(2301,'concentre-de-tomate','Concentré de tomate',NULL),
	(2302,'conchiglione','Conchiglione',NULL),
	(2303,'concombre','Concombre',NULL),
	(2304,'confit-de-canard','Confit de canard',NULL),
	(2305,'confiture','Confiture',NULL),
	(2306,'congre','Congre',NULL),
	(2307,'cookie','Cookie',NULL),
	(2308,'coppa','Coppa',NULL),
	(2309,'coq','Coq',NULL),
	(2310,'coque','Coque',NULL),
	(2311,'coquelet','Coquelet',NULL),
	(2312,'coquille-saint-jacques','Coquille saint-jacques',NULL),
	(2313,'coquillettes','Coquillettes',NULL),
	(2314,'coriandre','Coriandre',NULL),
	(2315,'corn-flakes','Corn flakes',NULL),
	(2316,'cornichons','Cornichons',NULL),
	(2317,'cotes-de-porc','Côtes de porc',NULL),
	(2318,'couche','Couche',NULL),
	(2319,'coude','Coude',NULL),
	(2320,'coulis-de-tomate','Coulis de tomate',NULL),
	(2321,'coulommier','Coulommier',NULL),
	(2322,'courge','Courge',NULL),
	(2323,'courge-musquee','Courge musquée',NULL),
	(2324,'courge-spaghetti','Courge spaghetti',NULL),
	(2325,'courgette','Courgette',NULL),
	(2326,'court-bouillon','Court-bouillon',NULL),
	(2327,'couscous','Couscous',NULL),
	(2328,'couteau','Couteau',NULL),
	(2329,'crabe','Crabe',NULL),
	(2330,'cranberrie','Cranberrie',NULL),
	(2331,'cream-cheese','Cream cheese',NULL),
	(2332,'cremant','Crémant',NULL),
	(2333,'creme','Crème',NULL),
	(2334,'creme-anglaise','Crème anglaise',NULL),
	(2335,'creme-chantilly','Crème chantilly',NULL),
	(2336,'creme-de-soja','Crème de soja',NULL),
	(2337,'creme-epaisse','Crème épaisse',NULL),
	(2338,'creme-fouettee','Crème fouettée',NULL),
	(2339,'creme-fraiche-allegee','Crème fraîche allégée',NULL),
	(2340,'creme-fraiche-epaisse','Crème fraîche épaisse',NULL),
	(2341,'creme-liquide','Crème liquide',NULL),
	(2342,'creme-semi-epaisse','Crème semi-épaisse',NULL),
	(2343,'crepe','Crêpe',NULL),
	(2344,'crepinette','Crépinette',NULL),
	(2345,'cresson','Cresson',NULL),
	(2346,'crevette','Crevette',NULL),
	(2347,'crevette-bouquet','Crevette bouquet',NULL),
	(2348,'crevette-rose','Crevette rose',NULL),
	(2349,'crevette-tigree','Crevette tigrée',NULL),
	(2350,'crevettes-grises','Crevettes grises',NULL),
	(2351,'croissant','Croissant',NULL),
	(2352,'crosne-de-fougere','Crosne de fougère',NULL),
	(2353,'crottins-de-chavignol','Crottins de chavignol',NULL),
	(2354,'croutons','Croûtons',NULL),
	(2355,'crozet','Crozet',NULL),
	(2356,'cuisse-de-canard','Cuisse de canard',NULL),
	(2357,'cuisse-de-dinde','Cuisse de dinde',NULL),
	(2358,'cuisse-de-poulet','Cuisse de poulet',NULL),
	(2359,'cuisses-de-lapin','Cuisses de lapin',NULL),
	(2360,'cumin','Cumin',NULL),
	(2361,'curcuma','Curcuma',NULL),
	(2362,'cure-nantais','Curé nantais',NULL),
	(2363,'curry','Curry',NULL),
	(2364,'dachine','Dachine',NULL),
	(2365,'daikon','Daikon',NULL),
	(2366,'daim','Daim',NULL),
	(2367,'datte','Datte',NULL),
	(2368,'daurade','Daurade',NULL),
	(2369,'decor-en-sucre','Décor en sucre',NULL),
	(2370,'dinde','Dinde',NULL),
	(2371,'dindonneau','Dindonneau',NULL),
	(2372,'diot','Diot',NULL),
	(2373,'dorade','Dorade',NULL),
	(2374,'dore','Doré',NULL),
	(2375,'dragibus','Dragibus',NULL),
	(2376,'earl-grey','Earl grey',NULL),
	(2377,'eau','Eau',NULL),
	(2378,'echine-de-porc','Échine de porc',NULL),
	(2379,'ecrevisse','Écrevisse',NULL),
	(2380,'edam','Edam',NULL),
	(2381,'edelzwicker','Edelzwicker',NULL),
	(2382,'edulcorant','Édulcorant',NULL),
	(2383,'eglefin','Églefin',NULL),
	(2384,'emmental','Emmental',NULL),
	(2385,'encornet','Encornet',NULL),
	(2386,'endive','Endive',NULL),
	(2387,'entrecote','Entrecôte',NULL),
	(2388,'epeautre','Épeautre',NULL),
	(2389,'eperlan','Éperlan',NULL),
	(2390,'epinard','Épinard',NULL),
	(2391,'epoisse','Époisse',NULL),
	(2392,'erable','Érable',NULL),
	(2393,'escalope','Escalope',NULL),
	(2394,'escalope-de-dinde','Escalope de dinde',NULL),
	(2395,'escalope-de-poulet','Escalope de poulet',NULL),
	(2396,'escargot','Escargot',NULL),
	(2397,'espadon','Espadon',NULL),
	(2398,'estomac','Estomac',NULL),
	(2399,'estragon','Estragon',NULL),
	(2400,'esturgeon','Esturgeon',NULL),
	(2401,'etorki','Etorki',NULL),
	(2402,'etrilles','Étrilles',NULL),
	(2403,'extrait-de-vanille-liquide','Extrait de vanille liquide',NULL),
	(2404,'faisan','Faisan',NULL),
	(2405,'faisselle','Faisselle',NULL),
	(2406,'fajitas','Fajitas',NULL),
	(2407,'farce','Farce',NULL),
	(2408,'farfalle','Farfalle',NULL),
	(2409,'farine','Farine',NULL),
	(2410,'farine-de-ble','Farine de blé',NULL),
	(2411,'farine-de-ble-noir','Farine de blé noir',NULL),
	(2412,'farine-de-chataigne','Farine de chataîgne',NULL),
	(2413,'farine-de-mais','Farine de maïs',NULL),
	(2414,'fecule','Fécule',NULL),
	(2415,'fecule-de-mais','Fécule de maïs',NULL),
	(2416,'fecule-de-pomme-de-terre','Fécule de pomme de terre',NULL),
	(2417,'fenouil','Fenouil',NULL),
	(2418,'fenouil-en-grains','Fenouil en grains',NULL),
	(2419,'fenugreek','Fenugreek',NULL),
	(2420,'fera','Féra',NULL),
	(2421,'feta','Feta',NULL),
	(2422,'feuille-de-brick','Feuille de brick',NULL),
	(2423,'feuille-de-menthe','Feuille de menthe',NULL),
	(2424,'feuillet','Feuillet',NULL),
	(2425,'feuillets-a-raviolis','Feuillets à raviolis',NULL),
	(2426,'feve','Fève',NULL),
	(2427,'figue','Figue',NULL),
	(2428,'figue-de-barbarie','Figue de barbarie',NULL),
	(2429,'filet-de-poulet','Filet de poulet',NULL),
	(2430,'filo','Filo',NULL),
	(2431,'fixe-chantilly','Fixe chantilly',NULL),
	(2432,'flageolet','Flageolet',NULL),
	(2433,'fletan','Flétan',NULL),
	(2434,'fleur-de-sel','Fleur de sel',NULL),
	(2435,'foie','Foie',NULL),
	(2436,'foie-gras','Foie gras',NULL),
	(2437,'fond-de-veau','Fond de veau',NULL),
	(2438,'fond-de-volaille','Fond de volaille',NULL),
	(2439,'fonds','Fonds',NULL),
	(2440,'fourme-de-montbrison','Fourme de montbrison',NULL),
	(2441,'fraise','Fraise',NULL),
	(2442,'fraise-des-bois','Fraise des bois',NULL),
	(2443,'fraise-gariguette','Fraise gariguette',NULL),
	(2444,'framboise','Framboise',NULL),
	(2445,'fribourg','Fribourg',NULL),
	(2446,'frisee','Frisée',NULL),
	(2447,'fromage-ail-et-fines-herbes','Fromage ail et fines herbes',NULL),
	(2448,'fromage-blanc','Fromage blanc',NULL),
	(2449,'fromage-blanc-sucre','Fromage blanc sucré',NULL),
	(2450,'fromage-rape','Fromage râpé',NULL),
	(2451,'fromages-italiens','Fromages italiens',NULL),
	(2452,'fromages-suisses','Fromages suisses',NULL),
	(2453,'fructose','Fructose',NULL),
	(2454,'fruit-a-pain','Fruit à pain',NULL),
	(2455,'fruit-confit','Fruit confit',NULL),
	(2456,'fruit-de-la-passion','Fruit de la passion',NULL),
	(2457,'fruit-de-mer','Fruit de mer',NULL),
	(2458,'fruit-rouge','Fruit rouge',NULL),
	(2459,'fusilli','Fusilli',NULL),
	(2460,'galette','Galette',NULL),
	(2461,'galettes-bretonnes','Galettes (bretonnes)',NULL),
	(2462,'galettes-de-riz','Galettes de riz',NULL),
	(2463,'gambas','Gambas',NULL),
	(2464,'gaperon','Gaperon',NULL),
	(2465,'garam-massala','Garam massala',NULL),
	(2466,'gateaux','Gâteaux',NULL),
	(2467,'gaufre','Gaufre',NULL),
	(2468,'gaufrette','Gaufrette',NULL),
	(2469,'gavotte','Gavotte',NULL),
	(2470,'gelatine','Gélatine',NULL),
	(2471,'gelatine-en-poudre','Gélatine en poudre',NULL),
	(2472,'gelee','Gelée',NULL),
	(2473,'gelee-au-madere','Gelée au madère',NULL),
	(2474,'genievre','Genièvre',NULL),
	(2475,'genoise','Génoise',NULL),
	(2476,'germes-de-soja','Germes de soja',NULL),
	(2477,'gesiers','Gésiers',NULL),
	(2478,'gewurztraminer','Gewurztraminer',NULL),
	(2479,'gin','Gin',NULL),
	(2480,'gingembre','Gingembre',NULL),
	(2481,'gingembre-confit','Gingembre confit',NULL),
	(2482,'giraumon','Giraumon',NULL),
	(2483,'girofle','Girofle',NULL),
	(2484,'girolle','Girolle',NULL),
	(2485,'gite','Gîte',NULL),
	(2486,'glace-pilee','Glace pilée',NULL),
	(2487,'glace-vanille','Glace vanille',NULL),
	(2488,'glacon','Glaçon',NULL),
	(2489,'glucose','Glucose',NULL),
	(2490,'gnocchi','Gnocchi',NULL),
	(2491,'golden-sirup','Golden sirup',NULL),
	(2492,'gombo','Gombo',NULL),
	(2493,'gomme-de-xanthane','Gomme de xanthane',NULL),
	(2494,'gorgonzola','Gorgonzola',NULL),
	(2495,'gouda','Gouda',NULL),
	(2496,'goyave','Goyave',NULL),
	(2497,'graine-de-lin','Graine de lin',NULL),
	(2498,'graine-germee','Graine germée',NULL),
	(2499,'graines-de-tournesol','Graines de tournesol',NULL),
	(2500,'grana-padano','Grana padano',NULL),
	(2501,'grand-marnier','Grand-marnier',NULL),
	(2502,'grenade','Grenade',NULL),
	(2503,'grenadier','Grenadier',NULL),
	(2504,'grenadin','Grenadin',NULL),
	(2505,'grenaille','Grenaille',NULL),
	(2506,'gressin','Gressin',NULL),
	(2507,'griotte','Griotte',NULL),
	(2508,'grondin','Grondin',NULL),
	(2509,'gros-sel','Gros sel',NULL),
	(2510,'groseille','Groseille',NULL),
	(2511,'groseille-a-maquereaux','Groseille à maquereaux',NULL),
	(2512,'gruyere','Gruyère',NULL),
	(2513,'guacamole','Guacamole',NULL),
	(2514,'guimauve','Guimauve',NULL),
	(2515,'haddock','Haddock',NULL),
	(2516,'hampe','Hampe',NULL),
	(2517,'hareng','Hareng',NULL),
	(2518,'haricot-beurre','Haricot beurre',NULL),
	(2519,'haricot-blanc','Haricot blanc',NULL),
	(2520,'haricot-coco','Haricot coco',NULL),
	(2521,'haricot-de-lima','Haricot de lima',NULL),
	(2522,'haricot-de-soissons','Haricot de soissons',NULL),
	(2523,'haricot-lingot','Haricot lingot',NULL),
	(2524,'haricot-mange-tout','Haricot mange-tout',NULL),
	(2525,'haricot-mungo','Haricot mungo',NULL),
	(2526,'haricot-noir','Haricot noir',NULL),
	(2527,'haricot-pinto','Haricot pinto',NULL),
	(2528,'haricot-plat','Haricot plat',NULL),
	(2529,'haricot-rouge','Haricot rouge',NULL),
	(2530,'haricot-sec','Haricot sec',NULL),
	(2531,'haricot-tarbais','Haricot tarbais',NULL),
	(2532,'haricot-vert','Haricot vert',NULL),
	(2533,'harissa','Harissa',NULL),
	(2534,'herbes-de-provence','Herbes de provence',NULL),
	(2535,'homard','Homard',NULL),
	(2536,'houblon','Houblon',NULL),
	(2537,'huile','Huile',NULL),
	(2538,'huile-de-colza','Huile de colza',NULL),
	(2539,'huile-de-noisette','Huile de noisette',NULL),
	(2540,'huile-de-palme','Huile de palme',NULL),
	(2541,'huile-de-pepin-de-raisin','Huile de pépin de raisin',NULL),
	(2542,'huile-de-sesame','Huile de sésame',NULL),
	(2543,'huile-de-tournesol','Huile de tournesol',NULL),
	(2544,'huitre','Huître',NULL),
	(2545,'iceberg','Iceberg',NULL),
	(2546,'igname','Igname',NULL),
	(2547,'jambon','Jambon',NULL),
	(2548,'jambon-blanc','Jambon blanc',NULL),
	(2549,'jambon-de-bayonne','Jambon de bayonne',NULL),
	(2550,'jambon-de-parme','Jambon de parme',NULL),
	(2551,'jambon-de-vendee','Jambon de vendée',NULL),
	(2552,'jambon-de-virginie','Jambon de virginie',NULL),
	(2553,'jambon-fume','Jambon fumé',NULL),
	(2554,'jambon-persille','Jambon persillé',NULL),
	(2555,'jambon-sec','Jambon sec',NULL),
	(2556,'jambonneau','Jambonneau',NULL),
	(2557,'jarret-de-veau','Jarret de veau',NULL),
	(2558,'jesus','Jésus',NULL),
	(2559,'joue','Joue',NULL),
	(2560,'joue-de-lotte','Joue de lotte',NULL),
	(2561,'julienne','Julienne',NULL),
	(2562,'jus-de-citron','Jus de citron',NULL),
	(2563,'jus-de-fruit-de-la-passion','Jus de fruit de la passion',NULL),
	(2564,'kaki','Kaki',NULL),
	(2565,'kangourou','Kangourou',NULL),
	(2566,'kefalotiri','Kefalotiri',NULL),
	(2567,'ketchup','Ketchup',NULL),
	(2568,'kirsch','Kirsch',NULL),
	(2569,'kiwi','Kiwi',NULL),
	(2570,'knacki','Knacki',NULL),
	(2571,'kub-or','Kub or',NULL),
	(2572,'kumquat','Kumquat',NULL),
	(2573,'lait','Lait',NULL),
	(2574,'lait-concentre','Lait concentré',NULL),
	(2575,'lait-concentre-non-sucre','Lait concentré non sucré',NULL),
	(2576,'lait-concentre-sucre','Lait concentré sucré',NULL),
	(2577,'lait-de-chevre','Lait de chèvre',NULL),
	(2578,'lait-de-coco','Lait de coco',NULL),
	(2579,'lait-de-soja','Lait de soja',NULL),
	(2580,'lait-ecreme','Lait écrémé',NULL),
	(2581,'lait-en-poudre','Lait en poudre',NULL),
	(2582,'lait-en-poudre-ecreme','Lait en poudre écrémé',NULL),
	(2583,'lait-en-poudre-entier','Lait en poudre entier',NULL),
	(2584,'lait-entier','Lait entier',NULL),
	(2585,'lait-entier-concentre','Lait entier concentré',NULL),
	(2586,'lait-fermente','Lait fermenté',NULL),
	(2587,'laitue','Laitue',NULL),
	(2588,'langouste','Langouste',NULL),
	(2589,'langoustine','Langoustine',NULL),
	(2590,'langres','Langres',NULL),
	(2591,'langue','Langue',NULL),
	(2592,'langue-de-chat','Langue de chat',NULL),
	(2593,'lapin','Lapin',NULL),
	(2594,'lapin-entier','Lapin entier',NULL),
	(2595,'lard','Lard',NULL),
	(2596,'lardons','Lardons',NULL),
	(2597,'lardons-fumes','Lardons fumés',NULL),
	(2598,'lasagnes','Lasagnes',NULL),
	(2599,'laurier','Laurier',NULL),
	(2600,'lavande','Lavande',NULL),
	(2601,'legine-australe','Légine australe',NULL),
	(2602,'lemon-curd','Lemon curd',NULL),
	(2603,'lentille','Lentille',NULL),
	(2604,'lentille-corail','Lentille corail',NULL),
	(2605,'lentille-verte','Lentille verte',NULL),
	(2606,'lentin','Lentin',NULL),
	(2607,'levure','Levure',NULL),
	(2608,'levure-chimique','Levure chimique',NULL),
	(2609,'levure-de-boulanger-fraiche','Levure de boulanger fraîche',NULL),
	(2610,'levure-de-boulanger-seche','Levure de boulanger sèche',NULL),
	(2611,'lieu-jaune','Lieu jaune',NULL),
	(2612,'lieu-noir','Lieu noir',NULL),
	(2613,'limande','Limande',NULL),
	(2614,'lingue','Lingue',NULL),
	(2615,'linguine','Linguine',NULL),
	(2616,'litchi','Litchi',NULL),
	(2617,'livarot','Livarot',NULL),
	(2618,'liveche','Livèche',NULL),
	(2619,'lotte','Lotte',NULL),
	(2620,'lotus','Lotus',NULL),
	(2621,'loup','Loup',NULL),
	(2622,'loup-de-mer','Loup de mer',NULL),
	(2623,'maasdam','Maasdam',NULL),
	(2624,'macaroni','Macaroni',NULL),
	(2625,'mache','Mâche',NULL),
	(2626,'madeleine','Madeleine',NULL),
	(2627,'madere','Madère',NULL),
	(2628,'magret-de-canard','Magret de canard',NULL),
	(2629,'magret-de-canard-fume','Magret de canard fumé',NULL),
	(2630,'mahi-mahi','Mahi mahi',NULL),
	(2631,'mais','Maïs',NULL),
	(2632,'maizena','Maïzena',NULL),
	(2633,'manchego','Manchego',NULL),
	(2634,'mandarine','Mandarine',NULL),
	(2635,'mangue','Mangue',NULL),
	(2636,'manioc','Manioc',NULL),
	(2637,'manouri','Manouri',NULL),
	(2638,'maquereau','Maquereau',NULL),
	(2639,'margarine','Margarine',NULL),
	(2640,'marjolaine','Marjolaine',NULL),
	(2641,'maroilles','Maroilles',NULL),
	(2642,'marrons','Marrons',NULL),
	(2643,'martini-blanc','Martini blanc',NULL),
	(2644,'mascarpone','Mascarpone',NULL),
	(2645,'massala','Massala',NULL),
	(2646,'mayonnaise','Mayonnaise',NULL),
	(2647,'melisse','Mélisse',NULL),
	(2648,'melon','Melon',NULL),
	(2649,'merguez','Merguez',NULL),
	(2650,'meringue','Meringue',NULL),
	(2651,'merlan','Merlan',NULL),
	(2652,'merlu','Merlu',NULL),
	(2653,'mesclun','Mesclun',NULL),
	(2654,'miel','Miel',NULL),
	(2655,'miel-liquide','Miel liquide',NULL),
	(2656,'miette-de-crabe','Miette de crabe',NULL),
	(2657,'millet','Millet',NULL),
	(2658,'mimolette','Mimolette',NULL),
	(2659,'mini-smarties','Mini smarties',NULL),
	(2660,'mirabelle','Mirabelle',NULL),
	(2661,'mirin','Mirin',NULL),
	(2662,'miso','Miso',NULL),
	(2663,'mogette','Mogette',NULL),
	(2664,'montasio','Montasio',NULL),
	(2665,'morbier','Morbier',NULL),
	(2666,'morille','Morille',NULL),
	(2667,'mortadelle','Mortadelle',NULL),
	(2668,'morue','Morue',NULL),
	(2669,'moules','Moules',NULL),
	(2670,'mousse-de-foie','Mousse de foie',NULL),
	(2671,'mousseron','Mousseron',NULL),
	(2672,'moutarde','Moutarde',NULL),
	(2673,'moutarde-de-dijon','Moutarde de dijon',NULL),
	(2674,'moutarde-de-meaux','Moutarde de meaux',NULL),
	(2675,'mouton','Mouton',NULL),
	(2676,'mozzarella','Mozzarella',NULL),
	(2677,'mozzarella-di-buffala','Mozzarella di buffala',NULL),
	(2678,'muesli','Muesli',NULL),
	(2679,'muffin-plat','Muffin plat',NULL),
	(2680,'munster','Munster',NULL),
	(2681,'mure','Mûre',NULL),
	(2682,'muscade','Muscade',NULL),
	(2683,'muscat','Muscat',NULL),
	(2684,'museau','Museau',NULL),
	(2685,'myrtille','Myrtille',NULL),
	(2686,'navet','Navet',NULL),
	(2687,'nectarine','Nectarine',NULL),
	(2688,'nefle','Nèfle',NULL),
	(2689,'niebe','Niébé',NULL),
	(2690,'noilly-prat','Noilly prat',NULL),
	(2691,'noisette','Noisette',NULL),
	(2692,'noix','Noix',NULL),
	(2693,'noix-de-cajou','Noix de cajou',NULL),
	(2694,'noix-de-coco','Noix de coco',NULL),
	(2695,'noix-de-coco-rapee','Noix de coco rapée',NULL),
	(2696,'nopal','Nopal',NULL),
	(2697,'nori','Nori',NULL),
	(2698,'nougat','Nougat',NULL),
	(2699,'nougatine','Nougatine',NULL),
	(2700,'nouilles','Nouilles',NULL),
	(2701,'nouilles-chinoises','Nouilles chinoises',NULL),
	(2702,'nouilles-de-riz','Nouilles de riz',NULL),
	(2703,'nouilles-soba','Nouilles soba',NULL),
	(2704,'nugget','Nugget',NULL),
	(2705,'nuoc-mam','Nuoc mam',NULL),
	(2706,'nutella','Nutella',NULL),
	(2707,'oeuf','Oeuf',NULL),
	(2708,'oeuf-de-caille','Oeuf de caille',NULL),
	(2709,'oeufs-de-saumon','Oeufs de saumon',NULL),
	(2710,'oie','Oie',NULL),
	(2711,'oignon','Oignon',NULL),
	(2712,'oignon-blanc','Oignon blanc',NULL),
	(2713,'oignon-nouveau','Oignon nouveau',NULL),
	(2714,'oignon-rouge','Oignon rouge',NULL),
	(2715,'oka','Oka',NULL),
	(2716,'okra','Okra',NULL),
	(2717,'olives','Olives',NULL),
	(2718,'omble-chevalier','Omble chevalier',NULL),
	(2719,'onglet','Onglet',NULL),
	(2720,'orange','Orange',NULL),
	(2721,'orange-amere','Orange amère',NULL),
	(2722,'orecchiette','Orecchiette',NULL),
	(2723,'oreilles','Oreilles',NULL),
	(2724,'oreo','Oréo',NULL),
	(2725,'orge','Orge',NULL),
	(2726,'origan','Origan',NULL),
	(2727,'ormeau','Ormeau',NULL),
	(2728,'oronge','Oronge',NULL),
	(2729,'oseille','Oseille',NULL),
	(2730,'ossau-iraty','Ossau iraty',NULL),
	(2731,'oursin','Oursin',NULL),
	(2732,'ourson-en-guimauve','Ourson en guimauve',NULL),
	(2733,'pain','Pain',NULL),
	(2734,'pain-au-lait','Pain au lait',NULL),
	(2735,'pain-aux-cereales','Pain aux céréales',NULL),
	(2736,'pain-brioche','Pain brioché',NULL),
	(2737,'pain-complet','Pain complet',NULL),
	(2738,'pain-de-campagne','Pain de campagne',NULL),
	(2739,'pain-de-mie','Pain de mie',NULL),
	(2740,'pain-de-seigle','Pain de seigle',NULL),
	(2741,'pain-indien-naan','Pain indien naan',NULL),
	(2742,'pain-pita','Pain pita',NULL),
	(2743,'pain-pour-hamburger','Pain pour hamburger',NULL),
	(2744,'pain-viennois','Pain viennois',NULL),
	(2745,'palets-bretons','Palets bretons',NULL),
	(2746,'palombe','Palombe',NULL),
	(2747,'palourde','Palourde',NULL),
	(2748,'pamplemousse','Pamplemousse',NULL),
	(2749,'panais','Panais',NULL),
	(2750,'pancetta','Pancetta',NULL),
	(2751,'panga','Panga',NULL),
	(2752,'pangasius','Pangasius',NULL),
	(2753,'panse','Panse',NULL),
	(2754,'pansette','Pansette',NULL),
	(2755,'papaye','Papaye',NULL),
	(2756,'papier-sulfurise','Papier sulfurisé',NULL),
	(2757,'papillons','Papillons',NULL),
	(2758,'pappardelles','Pappardelles',NULL),
	(2759,'paprika','Paprika',NULL),
	(2760,'parmesan','Parmesan',NULL),
	(2761,'pasteque','Pastèque',NULL),
	(2762,'pastis','Pastis',NULL),
	(2763,'patate-douce','Patate douce',NULL),
	(2764,'pate','Pâte',NULL),
	(2765,'pate','Pâté',NULL),
	(2766,'pate-a-pizza','Pâte à pizza',NULL),
	(2767,'pate-a-raviolis','Pâte à raviolis',NULL),
	(2768,'pate-a-tartiner','Pâte à tartiner',NULL),
	(2769,'pate-brisee','Pâte brisée',NULL),
	(2770,'pate-de-campagne','Pâté de campagne',NULL),
	(2771,'pate-de-curry','Pâte de curry',NULL),
	(2772,'pate-de-foie','Pâté de foie',NULL),
	(2773,'pate-feuilletee','Pâte feuilletée',NULL),
	(2774,'pate-sablee','Pâte sablée',NULL),
	(2775,'pates','Pâtes',NULL),
	(2776,'pates-fraiches','Pâtes fraîches',NULL),
	(2777,'patisson','Pâtisson',NULL),
	(2778,'pavot','Pavot',NULL),
	(2779,'peche','Pêche',NULL),
	(2780,'pecorino-pepato','Pecorino pepato',NULL),
	(2781,'pecorino-romano','Pecorino romano',NULL),
	(2782,'pelardon','Pélardon',NULL),
	(2783,'penne','Penne',NULL),
	(2784,'pensee','Pensée',NULL),
	(2785,'perail','Pérail',NULL),
	(2786,'perche','Perche',NULL),
	(2787,'perche-du-nil','Perche du nil',NULL),
	(2788,'persil','Persil',NULL),
	(2789,'pesto','Pesto',NULL),
	(2790,'pesto-rosso','Pesto rosso',NULL),
	(2791,'petit-beurre','Petit beurre',NULL),
	(2792,'petit-pois','Petit pois',NULL),
	(2793,'petit-sale','Petit salé',NULL),
	(2794,'petit-suisse','Petit suisse',NULL),
	(2795,'petoncle','Pétoncle',NULL),
	(2796,'picodon','Picodon',NULL),
	(2797,'pied-de-mouton','Pied-de-mouton',NULL),
	(2798,'pieds','Pieds',NULL),
	(2799,'pieds-de-mouton','Pieds de mouton',NULL),
	(2800,'pieuvre','Pieuvre',NULL),
	(2801,'pigeon','Pigeon',NULL),
	(2802,'pignon','Pignon',NULL),
	(2803,'pilon-de-poulet','Pilon de poulet',NULL),
	(2804,'piment','Piment',NULL),
	(2805,'piment-de-cayenne','Piment de Cayenne',NULL),
	(2806,'piments-mexicains','Piments mexicains',NULL),
	(2807,'pineau-des-charentes','Pineau des charentes',NULL),
	(2808,'pinot-noir','Pinot noir',NULL),
	(2809,'pintade','Pintade',NULL),
	(2810,'piquillo','Piquillo',NULL),
	(2811,'pissenlit','Pissenlit',NULL),
	(2812,'pistache','Pistache',NULL),
	(2813,'pistou','Pistou',NULL),
	(2814,'plantain','Plantain',NULL),
	(2815,'pleurote','Pleurote',NULL),
	(2816,'plie','Plie',NULL),
	(2817,'poire','Poire',NULL),
	(2818,'poireau','Poireau',NULL),
	(2819,'pois-casses','Pois cassés',NULL),
	(2820,'pois-chiche','Pois chiche',NULL),
	(2821,'poitrine-fumee','Poitrine fumée',NULL),
	(2822,'poivrade','Poivrade',NULL),
	(2823,'poivre','Poivre',NULL),
	(2824,'poivre-5-baies','Poivre 5 baies',NULL),
	(2825,'poivre-de-sichuan','Poivre de sichuan',NULL),
	(2826,'poivre-long','Poivre long',NULL),
	(2827,'poivre-vert','Poivre vert',NULL),
	(2828,'poivron','Poivron',NULL),
	(2829,'polenta','Polenta',NULL),
	(2830,'pomme','Pomme',NULL),
	(2831,'pomme-de-terre','Pomme de terre',NULL),
	(2832,'pommeau','Pommeau',NULL),
	(2833,'porc','Porc',NULL),
	(2834,'porto','Porto',NULL),
	(2835,'port-salut','Port-salut',NULL),
	(2836,'potimarron','Potimarron',NULL),
	(2837,'potiron','Potiron',NULL),
	(2838,'poudre-a-lever','Poudre à lever',NULL),
	(2839,'poudre-de-colombo','Poudre de colombo',NULL),
	(2840,'poularde','Poularde',NULL),
	(2841,'poule','Poule',NULL),
	(2842,'poulet','Poulet',NULL),
	(2843,'poulet-entier','Poulet entier',NULL),
	(2844,'poulpe','Poulpe',NULL),
	(2845,'poumons','Poumons',NULL),
	(2846,'pourpier','Pourpier',NULL),
	(2847,'poutargue','Poutargue',NULL),
	(2848,'praire','Praire',NULL),
	(2849,'pralin','Pralin',NULL),
	(2850,'pralinoise','Pralinoise',NULL),
	(2851,'provolone','Provolone',NULL),
	(2852,'prune','Prune',NULL),
	(2853,'pruneaux','Pruneaux',NULL),
	(2854,'pulpe-de-tomate','Pulpe de tomate',NULL),
	(2855,'puree','Purée',NULL),
	(2856,'puree-de-piment','Purée de piment',NULL),
	(2857,'pyrenees','Pyrénées',NULL),
	(2858,'quatre-epices','Quatre-épices',NULL),
	(2859,'quatre-quarts','Quatre-quarts',NULL),
	(2860,'quenelle','Quenelle',NULL),
	(2861,'quetsche','Quetsche',NULL),
	(2862,'queue','Queue',NULL),
	(2863,'quinoa','Quinoa',NULL),
	(2864,'rable-de-lapin','Râble de lapin',NULL),
	(2865,'raclette','Raclette',NULL),
	(2866,'radis','Radis',NULL),
	(2867,'raie','Raie',NULL),
	(2868,'raifort','Raifort',NULL),
	(2869,'raisin','Raisin',NULL),
	(2870,'raisins-secs','Raisins secs',NULL),
	(2871,'ras-el-hanout','Ras el Hanout',NULL),
	(2872,'rascasse','Rascasse',NULL),
	(2873,'ratatouille','Ratatouille',NULL),
	(2874,'rate','Rate',NULL),
	(2875,'ratte','Ratte',NULL),
	(2876,'ravioli','Ravioli',NULL),
	(2877,'reblochon','Reblochon',NULL),
	(2878,'reglisse','Réglisse',NULL),
	(2879,'renne','Renne',NULL),
	(2880,'requin','Requin',NULL),
	(2881,'rhubarbe','Rhubarbe',NULL),
	(2882,'rhum','Rhum',NULL),
	(2883,'ricotta','Ricotta',NULL),
	(2884,'riesling','Riesling',NULL),
	(2885,'rillettes','Rillettes',NULL),
	(2886,'rillons','Rillons',NULL),
	(2887,'ris-de-veau','Ris de veau',NULL),
	(2888,'risotto','Risotto',NULL),
	(2889,'riz','Riz',NULL),
	(2890,'riz-basmati','Riz basmati',NULL),
	(2891,'riz-gluant','Riz gluant',NULL),
	(2892,'riz-long','Riz long',NULL),
	(2893,'riz-rond','Riz rond',NULL),
	(2894,'riz-sauvage','Riz sauvage',NULL),
	(2895,'riz-surinam','Riz surinam',NULL),
	(2896,'riz-thai','Riz thaï',NULL),
	(2897,'rocamadour','Rocamadour',NULL),
	(2898,'rognons','Rognons',NULL),
	(2899,'romaine','Romaine',NULL),
	(2900,'romarin','Romarin',NULL),
	(2901,'roquefort','Roquefort',NULL),
	(2902,'roquette','Roquette',NULL),
	(2903,'rosbif','Rosbif',NULL),
	(2904,'rose','Rose',NULL),
	(2905,'rosette','Rosette',NULL),
	(2906,'roti-de-boeuf','Roti de boeuf',NULL),
	(2907,'roti-de-porc','Roti de porc',NULL),
	(2908,'roti-de-veau','Rôti de veau',NULL),
	(2909,'rougail','Rougail',NULL),
	(2910,'rouget','Rouget',NULL),
	(2911,'rouille','Rouille',NULL),
	(2912,'rumsteck','Rumsteck',NULL),
	(2913,'rutabaga','Rutabaga',NULL),
	(2914,'sables','Sablés',NULL),
	(2915,'sabodet','Sabodet',NULL),
	(2916,'safran','Safran',NULL),
	(2917,'saindoux','Saindoux',NULL),
	(2918,'saint-moret','Saint Morêt',NULL),
	(2919,'sainte-maure-de-touraine','Sainte-maure de Touraine',NULL),
	(2920,'saint-florentin','Saint-florentin',NULL),
	(2921,'saint-marcellin','Saint-marcellin',NULL),
	(2922,'saint-nectaire','Saint-nectaire',NULL),
	(2923,'saint-paulin','Saint-paulin',NULL),
	(2924,'saint-pierre','Saint-pierre',NULL),
	(2925,'sake','Saké',NULL),
	(2926,'salade','Salade',NULL),
	(2927,'salami','Salami',NULL),
	(2928,'salers','Salers',NULL),
	(2929,'salicorne','Salicorne',NULL),
	(2930,'salsifi','Salsifi',NULL),
	(2931,'sancerre','Sancerre',NULL),
	(2932,'sandre','Sandre',NULL),
	(2933,'sanglier','Sanglier',NULL),
	(2934,'sardine','Sardine',NULL),
	(2935,'sarrasin','Sarrasin',NULL),
	(2936,'sarriette','Sarriette',NULL),
	(2937,'sate','Saté',NULL),
	(2938,'sauce-bolognaise','Sauce bolognaise',NULL),
	(2939,'sauce-cocktail','Sauce cocktail',NULL),
	(2940,'sauce-hoisin','Sauce hoisin',NULL),
	(2941,'sauce-nuoc-mam','Sauce nuoc mam',NULL),
	(2942,'sauce-piquante','Sauce piquante',NULL),
	(2943,'sauce-soja','Sauce soja',NULL),
	(2944,'sauce-tartare','Sauce tartare',NULL),
	(2945,'sauce-tomate','Sauce tomate',NULL),
	(2946,'sauce-worcestershire','Sauce worcestershire',NULL),
	(2947,'saucisse-de-francfort','Saucisse de Francfort',NULL),
	(2948,'saucisse-de-montbeliard','Saucisse de Montbéliard',NULL),
	(2949,'saucisse-de-morteau','Saucisse de morteau',NULL),
	(2950,'saucisse-de-strasboug','Saucisse de Strasboug',NULL),
	(2951,'saucisse-de-toulouse','Saucisse de Toulouse',NULL),
	(2952,'saucisse-seche','Saucisse sèche',NULL),
	(2953,'saucisses','Saucisses',NULL),
	(2954,'saucisson','Saucisson',NULL),
	(2955,'saucisson-sec','Saucisson sec',NULL),
	(2956,'sauge','Sauge',NULL),
	(2957,'saumon','Saumon',NULL),
	(2958,'saumon-fume','Saumon fumé',NULL),
	(2959,'saute','Sauté',NULL),
	(2960,'saute-de-porc','Sauté de porc',NULL),
	(2961,'savora','Savora',NULL),
	(2962,'sbrinz','Sbrinz',NULL),
	(2963,'scampi','Scampi',NULL),
	(2964,'scarole','Scarole',NULL),
	(2965,'seiche','Seiche',NULL),
	(2966,'seigle','Seigle',NULL),
	(2967,'sel','Sel',NULL),
	(2968,'sel-de-celeri','Sel de céleri',NULL),
	(2969,'sel-et-poivre','Sel et poivre',NULL),
	(2970,'semoule','Semoule',NULL),
	(2971,'semoule-fine','Semoule fine',NULL),
	(2972,'semoule-moyenne','Semoule moyenne',NULL),
	(2973,'sere','Séré',NULL),
	(2974,'serpolet','Serpolet',NULL),
	(2975,'sesame','Sésame',NULL),
	(2976,'shortbread','Shortbread',NULL),
	(2977,'silure','Silure',NULL),
	(2978,'sirop-de-canne','Sirop de canne',NULL),
	(2979,'sirop-de-liege','Sirop de Liège',NULL),
	(2980,'soja','Soja',NULL),
	(2981,'sole','Sole',NULL),
	(2982,'sorgho','Sorgho',NULL),
	(2983,'soucis','Soucis',NULL),
	(2984,'soumaintrain','Soumaintrain',NULL),
	(2985,'spaghetti','Spaghetti',NULL),
	(2986,'spatzle','Spätzle',NULL),
	(2987,'speculoos','Spéculoos',NULL),
	(2988,'spigol','Spigol',NULL),
	(2989,'sprat','Sprat',NULL),
	(2990,'steak','Steak',NULL),
	(2991,'steak-hache','Steak haché',NULL),
	(2992,'stevia','Stévia',NULL),
	(2993,'stilton','Stilton',NULL),
	(2994,'sucre','Sucre',NULL),
	(2995,'sucre-de-canne','Sucre de canne',NULL),
	(2996,'sucre-en-poudre','Sucre en poudre',NULL),
	(2997,'sucre-roux','Sucre roux',NULL),
	(2998,'sucre-vanille','Sucre vanillé',NULL),
	(2999,'sucre-vanilline','Sucre vanilliné',NULL),
	(3000,'sumac','Sumac',NULL),
	(3001,'surimi','Surimi',NULL),
	(3002,'sylvaner','Sylvaner',NULL),
	(3003,'tabasco','Tabasco',NULL),
	(3004,'tacaud','Tacaud',NULL),
	(3005,'tagliatelle','Tagliatelle',NULL),
	(3006,'tamarin','Tamarin',NULL),
	(3007,'tandoori','Tandoori',NULL),
	(3008,'tapenade','Tapenade',NULL),
	(3009,'tapenade-noire','Tapenade noire',NULL),
	(3010,'tapenade-verte','Tapenade verte',NULL),
	(3011,'tarama','Tarama',NULL),
	(3012,'tellines','Tellines',NULL),
	(3013,'tete-de-moine','Tête de moine',NULL),
	(3014,'tete-de-veau','Tête de veau',NULL),
	(3015,'tetine','Tétine',NULL),
	(3016,'the','Thé',NULL),
	(3017,'the-matcha','Thé matcha',NULL),
	(3018,'the-vert','Thé vert',NULL),
	(3019,'thon','Thon',NULL),
	(3020,'thon-blanc','Thon blanc',NULL),
	(3021,'thon-rouge','Thon rouge',NULL),
	(3022,'thym','Thym',NULL),
	(3023,'tilleul','Tilleul',NULL),
	(3024,'tobiko','Tobiko',NULL),
	(3025,'tofu','Tofu',NULL),
	(3026,'tofu-soyeux','Tofu soyeux',NULL),
	(3027,'tomate','Tomate',NULL),
	(3028,'tomate-cerise','Tomate cerise',NULL),
	(3029,'tomate-pelee','Tomate pelée',NULL),
	(3030,'tome-piemontaise','Tome piemontaise',NULL),
	(3031,'tomme','Tomme',NULL),
	(3032,'tomme-vaudoise','Tomme vaudoise',NULL),
	(3033,'tonka-feve','Tonka (fève)',NULL),
	(3034,'topinambour','Topinambour',NULL),
	(3035,'torsades','Torsades',NULL),
	(3036,'torsette','Torsette',NULL),
	(3037,'tortellini','Tortellini',NULL),
	(3038,'tortilla','Tortilla',NULL),
	(3039,'tortilla-chips','Tortilla chips',NULL),
	(3040,'tournedos','Tournedos',NULL),
	(3041,'tourteau','Tourteau',NULL),
	(3042,'travers-de-porc','Travers de porc',NULL),
	(3043,'trevise','Trévise',NULL),
	(3044,'tripes','Tripes',NULL),
	(3045,'trompette-de-la-mort','Trompette de la mort',NULL),
	(3046,'truffe','Truffe',NULL),
	(3047,'truffe-noire-de-bourgogne','Truffe noire de bourgogne',NULL),
	(3048,'truite','Truite',NULL),
	(3049,'truite-saumonee','Truite saumonée',NULL),
	(3050,'turbot','Turbot',NULL),
	(3051,'tzatziki','Tzatziki',NULL),
	(3052,'vache-qui-rit','Vache qui rit',NULL),
	(3053,'vacherin','Vacherin',NULL),
	(3054,'vanille','Vanille',NULL),
	(3055,'veau','Veau',NULL),
	(3056,'vegetaline','Végétaline',NULL),
	(3057,'vergeoise','Vergeoise',NULL),
	(3058,'vergeoise-blonde','Vergeoise blonde',NULL),
	(3059,'vergeoise-brune','Vergeoise brune',NULL),
	(3060,'vermicelles','Vermicelles',NULL),
	(3061,'vermicelles-de-riz','Vermicelles de riz',NULL),
	(3062,'vermicelles-de-soja','Vermicelles de soja',NULL),
	(3063,'verveine','Verveine',NULL),
	(3064,'viande-de-grison','Viande de grison',NULL),
	(3065,'viandox','Viandox',NULL),
	(3066,'vieux-lille','Vieux lille',NULL),
	(3067,'vieux-pane','Vieux pané',NULL),
	(3068,'vin-blanc','Vin blanc',NULL),
	(3069,'vin-rose','Vin rosé',NULL),
	(3070,'vin-rouge','Vin rouge',NULL),
	(3071,'vinaigre','Vinaigre',NULL),
	(3072,'vinaigre-aromatise','Vinaigre aromatisé',NULL),
	(3073,'vinaigre-balsamique','Vinaigre balsamique',NULL),
	(3074,'vinaigre-de-cidre','Vinaigre de cidre',NULL),
	(3075,'vinaigre-de-datte','Vinaigre de datte',NULL),
	(3076,'vinaigre-de-framboise','Vinaigre de framboise',NULL),
	(3077,'vinaigre-de-riz','Vinaigre de riz',NULL),
	(3078,'vinaigre-de-vin','Vinaigre de vin',NULL),
	(3079,'vinaigre-de-xeres','Vinaigre de xeres',NULL),
	(3080,'vodka','Vodka',NULL),
	(3081,'wasabi','Wasabi',NULL),
	(3082,'whisky','Whisky',NULL),
	(3083,'xeres','Xérès',NULL),
	(3084,'yaourt-a-la-grecque','Yaourt à la grecque',NULL),
	(3085,'yaourt-allege','Yaourt allégé',NULL),
	(3086,'yaourt-aromatise','Yaourt aromatisé',NULL),
	(3087,'yaourt-aux-fruits','Yaourt aux fruits',NULL),
	(3088,'yaourt-brasse','Yaourt brassé',NULL),
	(3089,'yaourt-nature','Yaourt nature',NULL),
	(3090,'yaourts','Yaourts',NULL);

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
  KEY `id_preparationTime` (`id_preparationTime`),
  CONSTRAINT `recipe_ibfk_2` FOREIGN KEY (`id_ambiance`) REFERENCES `AMBIANCE` (`id_ambiance`),
  CONSTRAINT `recipe_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `USER` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `recipe_ibfk_4` FOREIGN KEY (`id_difficulty`) REFERENCES `DIFFICULTY` (`id_difficulty`),
  CONSTRAINT `recipe_ibfk_5` FOREIGN KEY (`Id_type`) REFERENCES `TYPE` (`id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `RECIPE` WRITE;
/*!40000 ALTER TABLE `RECIPE` DISABLE KEYS */;

INSERT INTO `RECIPE` (`id_recipe`, `slug_recipe`, `name_recipe`, `urlImage_recipe`, `numberOfPeople_recipe`, `id_preparationTime`, `id_difficulty`, `id_type`, `dateAdd_recipe`, `dateUpdate_recipe`, `id_user`, `id_ambiance`, `votes_recipe`)
VALUES
	(43,'tarte-au-thon-et-moutarde','Tarte au thon et moutarde','../../temp/croppedImg_151535622.png',6,3,1,1,'2014-03-07 10:31:54','0000-00-00 00:00:00',45,5,1),
	(44,'soupe-miso','Soupe Miso','../../temp/croppedImg_161240523.jpeg',4,1,1,1,'2014-03-07 10:33:11','0000-00-00 00:00:00',47,3,1),
	(45,'onigiri','Onigiri','../../temp/croppedImg_860702868.jpeg',4,3,1,1,'2014-03-07 10:35:49','0000-00-00 00:00:00',47,1,0),
	(49,'sushis-au-thon','Sushis au thon','../../temp/croppedImg_1298541203.png',4,1,1,1,'2014-03-07 10:37:52','0000-00-00 00:00:00',45,3,0),
	(51,'pommes-d-amour','Pommes d\'amour','../../temp/croppedImg_1163402764.jpeg',20,3,1,1,'2014-03-07 10:39:10','0000-00-00 00:00:00',47,5,0),
	(52,'gaufres-sans-oeufs','Gaufres sans oeufs','../../temp/croppedImg_484032455.jpeg',2,1,1,1,'2014-03-07 10:40:48','0000-00-00 00:00:00',47,4,0),
	(53,'tiramisu','Tiramisu','../../temp/croppedImg_300649918.png',8,1,1,1,'2014-03-07 10:41:35','0000-00-00 00:00:00',45,3,0),
	(55,'choucroute-alsacienne','Choucroute Alsacienne','../../temp/croppedImg_375898853.jpeg',20,3,1,1,'2014-03-07 10:43:31','0000-00-00 00:00:00',48,5,0),
	(57,'crumble-pommes-et-amandes','Crumble pommes et amandes','../../temp/croppedImg_1274137086.jpeg',4,2,1,1,'2014-03-07 10:44:28','0000-00-00 00:00:00',47,5,0),
	(58,'couscous-kabyle','Couscous Kabyle','../../temp/croppedImg_1924280608.jpeg',10,3,1,1,'2014-03-07 10:47:20','0000-00-00 00:00:00',48,3,0),
	(59,'fajitas-vegetariennes-pour-l-ete','Fajitas végétariennes pour l’été','../../temp/croppedImg_1016777243.jpeg',4,1,1,1,'2014-03-07 10:48:06','0000-00-00 00:00:00',45,4,0),
	(60,'chili-con-carne','Chili con carne','../../temp/croppedImg_68627544.jpeg',8,3,1,1,'2014-03-07 10:49:27','0000-00-00 00:00:00',48,3,0),
	(61,'chou-rouge-aux-marrons','Chou rouge aux marrons','../../temp/croppedImg_1230684241.jpeg',4,1,1,1,'2014-03-07 10:50:52','0000-00-00 00:00:00',47,5,0),
	(62,'fajitas-au-poulet','Fajitas au poulet','../../temp/croppedImg_1165867507.jpeg',5,3,1,1,'2014-03-07 10:52:22','0000-00-00 00:00:00',45,3,0);

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
  `countComment_step` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_step`),
  UNIQUE KEY `order_step` (`order_step`,`id_recipe`),
  KEY `id_recipe` (`id_recipe`),
  CONSTRAINT `step_ibfk_2` FOREIGN KEY (`id_recipe`) REFERENCES `RECIPE` (`id_recipe`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `STEP` WRITE;
/*!40000 ALTER TABLE `STEP` DISABLE KEYS */;

INSERT INTO `STEP` (`id_step`, `order_step`, `content_step`, `id_recipe`, `countComment_step`)
VALUES
	(142,1,'Etaler la pâte feuilletée dans un moule de 30 cm.',43,1),
	(143,2,'Etaler une couche de moutarde, puis une couche de thon émietté puis une couche de tomates coupées en rondelles pas trop fines, puis une couche de crème fraîche et enfin une couche de gruyère râpé.',43,0),
	(144,3,'Enfourner pendant 30 mn à thermostat 8 (250°C).',43,0),
	(145,1,'Faire bouillir de l\'eau (pour la quantité, compter un petit bol par personne). ',44,0),
	(146,2,'Couper le tofu en petits carrés d\'un petit centimètre cube. Réserver.',44,0),
	(147,3,'Nettoyer les oignons, les couper en fines tranches, parties blanches et vertes. Réserver. ',44,0),
	(148,4,'Dans un petit bol, mettre une cuillère à café de pâte de Soja ou Miso. Ajouter de l\'eau bouillante et remuer vivement jusqu\'à dissolution de la pâte. Ajouter des cubes de tofu et de l\'oignon selon le goût. ',44,0),
	(149,5,'Répéter l\'opération pour chaque personne. ',44,0),
	(150,6,'Servir immédiatement.',44,0),
	(151,1,'Il faut faire griller le poisson au four ou sur du feu : utilisez une grille pour cette opération.',45,0),
	(152,2,'Préparez tous les ingrédients sur la table : Nori sur une grande assiette qui va accueillir les Onigiri; saumon grillé et émietté; Umeboshi ecrasée; un bol d\'eau ; Gohan(riz) dans un grand saladier;sel.',45,0),
	(153,3,'Mouillez bien vos deux mains et mettez généreusement du sel sur les deux mains',45,0),
	(154,4,'Prenez du riz sur une main (mains bien remplie) et mettez un morceau de saumon au milieu du riz. ',45,0),
	(155,5,'Recouvrez avec du riz d\'une quantité égale et pressez-le avec l\'autre main, de manière à former le sommet d\'un triangle',45,0),
	(156,6,'Retournez l\'ensemble et continuez à faire les 2 autres sommets du triangle.',45,0),
	(157,7,'Aplatissez les 2 faces et mettez la feuille de Nori au centre d\'un coté du triangle afin d\'entourer la boule.',45,0),
	(158,8,'Recommencez avec la prune séchée.',45,0),
	(179,1,'Préparer d\'abord le riz vapeur : laver 3 1/3 tasses de riz à l\'eau froide et laisser égoutter pendant 1 heure.',49,0),
	(180,2,'Mettre le riz dans une casserole, verser 1 litre d\'eau, porter à ébullition sur feu moyen, couvrir et cuire à feu vif pendant 2 mn. Réduire le feu au minimum et continuer la cuisson 20 mn.',49,0),
	(181,3,'Ouvrir, déposer un linge sur le riz, refermer et laisser reposer 15 mn. ',49,0),
	(182,4,'dans une petite casserole, verser 6 cuillères à soupe de vinaigre de riz, 5 cuillères à soupe de sucre et 4 cuillères à café de sel. Faire chauffer quelques secondes pour faire dissoudre le sucre.',49,0),
	(183,5,'Verser doucement le vinaigre de riz dans le riz cuit encore chaud, mélanger et détacher les grains doucement à l\'aide de baguettes. ',49,0),
	(184,6,'Ensuite, au travail ! Le principe de base est de former de petites boules de riz préparé à sushi - chacune équivalent à 50 ml. Appliquer une très légère pointe de wasabi entre le riz et le poisson. Déposer dans la main, mettre le poisson et autres préparations dessus, mouler doucement le poisson sur le riz en aplatissant le tout. Déposer sur un plateau.',49,0),
	(185,7,'Tailler le poisson cru en fines tranches qui épouse la forme de feuille ou de pétale. Déposer sur 4 boules de riz aplaties en longueur en forme de feuille - soit une extrémité ronde et une extrémité pointue.',49,0),
	(186,8,'Présenter dans une assiette 4 sushis - les 4 extrémités rondes doivent se toucher au centre de l\'assiette. Saupoudrer le centre d\'un jaune d\'oeuf cuit dur et émietté pour symboliser le pollen de la fleur.',49,0),
	(187,9,'Servir avec du gingembre mariné, du wasabi et de la sauce soja.',49,0),
	(193,1,'Couper des rondelles de pommes : prendre la pomme entière, non épluchée, la poser sur le côté et couper de sorte à ce que la mouche apparaissent au milieu. Les rondelles doivent être de 2 à 3 mm d’épaisseur.',51,0),
	(194,2,'Disposer les pommes sur la grille du four et faire cuire 1 h à 90° (thermostat 3).',51,0),
	(195,3,'Plus les rondelles sont grosses, plus cela prendra de temps. Il faut que les pommes soit tout à fait sèches, comme des chips. ',51,0),
	(196,4,'Faire chauffer une poêle, à feu très chaud. Une fois que la poêle est bien chaude, ajouter le sucre et par dessus le colorant. Il ne faut pas l\'étaler dans la casserole mais faire une petite montagne.',51,0),
	(197,5,'Ne pas remuer, attendre que le sucre fasse une petite flaque. Puis remuer.',51,0),
	(198,6,'Il faut chauffer jusqu\'à ce qu\'il n\'y ait plus de cristaux. ',51,0),
	(199,7,' Prendre les chips de pommes à l\'aide d\'une fourchette et les tremper une à une dans le sucre.',51,0),
	(200,8,'Déposer au fur et à mesure sur la grille pour sécher.',51,0),
	(201,1,'Pour faire une pâte légère et sans oeufs, l\'eau gazeuse se révèle miraculeuse, en rajouter plus ou moins selon proportion désirée.',52,0),
	(202,2,'élanger l\'ensemble des ingrédients et laisser reposer au moins 1 heure avant de cuire.',52,0),
	(203,1,'Séparer les blancs des jaunes. Mélanger les jaunes + sucre + sucre vanillé. Ajouter le mascarpone au fouet.',53,0),
	(204,2,'Monter les blancs en neige et les incorporer délicatement à la spatule au mélange précédent.',53,0),
	(205,3,'Préparer du café noir.',53,0),
	(206,4,'Mouiller les biscuits dans le café.',53,0),
	(207,5,'Tapisser le fond du moule avec les biscuits. Recouvrir d\'une couche de crème, œuf, sucre, mascarpone. Alterner biscuits et crème.',53,0),
	(208,6,'Terminer par une couche de crème. Saupoudrer de cacao.',53,0),
	(209,7,'Mettre au réfrigérateur 4 heures minimum.',53,0),
	(212,1,'Faire tremper la choucroute toute une nuit, la laver à plusieurs eaux. ',55,0),
	(213,2,'Mettre la barde de lard dans le fond de la marmite avec la moitié de saindoux. Y déposer la moitié de la choucroute égouttée, puis toute la viande à l\'exception des saucisses.',55,0),
	(214,3,'Ajouter le reste de saindoux, l\'ail, l\'oignon, les baies, le vin blanc, l\'eau et le reste de choucroute. Il faut que le liquide affleure la surface. ',55,0),
	(215,4,'Couvrir et laisser cuire à feu modéré. ',55,0),
	(216,5,'Une heure avant la fin ajouter les saucisses et les pommes de terre.',55,0),
	(219,1,'Éplucher les pommes, les épépiner et les découper en tranches. Disposer sur un plat beurré. ',57,0),
	(220,2,'Mélanger le sucre, les amandes, la cannelle et la farine. Incorporer le beurre à la préparation en la malaxant. Étaler le mélange dans le plat et enfourner 30 min à 210°C (thermostat 7).',57,0),
	(221,1,'La veille, mettez les pois chiches dans un bol d’eau.',58,0),
	(222,2,'Le jour même, roulez le couscous . Si vous utilisez du couscous roulé et séché, rincez-le à l\'eau froide, égouttez-le et laissez-le gonfler pendant 30 mn.',58,0),
	(223,3,'Coupez la viande en morceaux. Pelez les oignons et coupez-en 1 en morceaux.',58,0),
	(224,4,'Lavez et passez les tomates à la moulinette. Mettez la viande dans une marmite et ajoutez les morceaux d\'oignon, les tomates ou le concentré de tomate dilué dans 1 verre d\'eau, l\'huile, le poivre, le piment, la cannelle et du sel.',58,0),
	(225,5,'Faites revenir à petit feu pendant quelques minutes. Mouillez avec 3 litres d\'eau, portez à ébullition et jetez les pois chiches dans la sauce.',58,0),
	(226,6,'Mettez le couscous dans le haut du couscoussier et placer ce dernier sur la marmite contenant le bouillon en ébullition. Après échappement de la vapeur à travers les grains, laissez cuire 15 à 20 mn. Retirez le haut du couscoussier (laissez la marmite sur le feu) versez le couscous dans une cuvette.',58,0),
	(227,7,'Séparez les grains avec une cuillère, puis arrosez-les d\'1/3 de litre d\'eau froide en les aérant en même temps. Laissez les s’imbiber.',58,0),
	(228,1,'Pelez les carottes, coupez-les en baguettes plus ou moins épaisses ou longues.',59,0),
	(229,2,'Faites de même avec les concombres.',59,0),
	(230,3,'Mélangez 2 carrés frais et assaisonnez de sel, poivre et un peu de jus de citron.',59,0),
	(231,4,'Etalez les carrés frais assaisonnés sur toute la longueur centrale d\' une fajitas, placez dessus des baguettes de concombres et de carottes.',59,0),
	(232,5,'Refermez la fajitas, placez-là dans un plat et recommencez l\'opération avec les autres.',59,0),
	(233,6,'Couvrez le plat avec du papier sulfurisé et mettez le tout au frigo. (vous pouvez les consommez de suite mais c\'est meilleur quand elle sont bien froides).',59,0),
	(234,1,'Hacher ails et oignons et les faire revenir dans l\'huile d\'olive dans une grande cocotte (prévoir l\'équivalent de la cocotte Seb 4,5 l) pendant 10 mn ensuite ajouter la viande et remuer pendant 5-6 mn.',60,0),
	(235,2,'Ajouter le cumin, l\'origan, les piments et le Tabasco (plus ou moins selon votre goût). Saler, remuer consciencieusement et mettez sur feux doux. Mouiller avec le bouillon, ajouter tomates et poivron coupé en dés et laisser mijoter pendant 1 heure. ',60,0),
	(236,3,'Ajouter les haricots égouttés et laisser cuire encore une heure.',60,0),
	(237,1,'Nettoyer le chou rouge, lui couper le trognon et lui retirer les côtes épaisses avant de l\'émincer. Peler et émincer les oignons.',61,0),
	(238,2,'Dans une cocotte, faire fondre le saindoux, puis ajouter le chou rouge et les oignons. Laisser cuire 15 min sans cesser de remuer puis saler et poivrer.',61,0),
	(239,3,'Dans une cocotte, faire fondre le saindoux, puis ajouter le chou rouge et les oignons. Laisser cuire 15 min sans cesser de remuer puis saler et poivrer.',61,0),
	(240,4,'Pendant ce temps, éplucher les châtaignes et détailler les pommes en dés après les avoir pelées.',61,0),
	(241,5,'Les faire revenir ensemble dans une sauteuse avec le beurre puis laisser cuire 45 min également.',61,0),
	(242,1,'Couper les poivrons en petits morceaux. Les faire frire à feux doux jusqu\'à ce qu\'ils soient presque cuits.',62,0),
	(243,2,'Pendant ce temps, couper également les oignons en petits morceaux. Les faire cuire. ',62,0),
	(244,3,'Une fois qu\'ils seront quasiment cuits, les ajouter aux poivrons puis continuer à faire cuire à toujours à feux doux. ',62,0),
	(245,4,'Assaisonner : mettre sel et poivre, puis piment de cayenne selon vos goûts. ',62,0),
	(246,5,'Couper le poulet en petits morceaux. ',62,0),
	(247,6,'Retirer les poivrons et oignons du feu. ',62,0),
	(248,7,'Faire cuire le poulet. ',62,0),
	(249,8,'Une fois cuit ajouter le jus d\'un citron ainsi que les oignons et les poivrons et laisser à feux doux quelques instants puis éteindre. ',62,0),
	(250,9,'Au moment de servir, faire réchauffer le poulet. ',62,0),
	(251,10,'Couper les tomates en petits dés. ',62,0),
	(252,11,'Mettre de la crème fraîche sur la pâte, du guacamole, quelques dés de tomate ainsi que quelques petits morceaux de salade. Rajouter de la préparation au poulet, rouler, manger ! ',62,0);

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
	(45,'hugo-mingoia',0,'Hugo','Mingoia','hugomingoia@gmail.com',NULL,NULL,'https://graph.facebook.com/1181047747/picture?type=large',NULL,'1181047747',NULL,'2014-03-07 10:25:51','0000-00-00 00:00:00'),
	(47,'laure-boutmy',0,'Laure','Boutmy','laureboutmy@gmail.com','098f6bcd4621d373cade4e832627b4f6','Trop jolie.','public/uploads/user/47/3b3b089f5afa5e437c283407b0d29407-1.jpg',NULL,NULL,NULL,'2014-03-07 10:26:55','0000-00-00 00:00:00'),
	(48,'julien-perriere',0,'Julien','Perrière','perrierejulien@gmail.com',NULL,'','public/uploads/user/48/160141610151834604792142808003840N.jpg',NULL,'668822141',NULL,'2014-03-07 10:31:55','0000-00-00 00:00:00'),
	(49,'john-doe',0,'John','Doe','john@doe.com','098f6bcd4621d373cade4e832627b4f6',NULL,NULL,NULL,NULL,NULL,'2014-03-07 10:41:44','0000-00-00 00:00:00');

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
	(504,47,44,'2014-03-07 10:33:16'),
	(510,47,43,'2014-03-07 10:44:51');

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
