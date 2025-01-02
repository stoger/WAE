-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: tuv22
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `group99_article`
--

DROP TABLE IF EXISTS `group99_category`;
CREATE TABLE `group99_category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

LOCK TABLES `group99_category` WRITE;
INSERT INTO `group99_category` VALUES
  (3, "News");
UNLOCK TABLES;

DROP TABLE IF EXISTS `group99_user`;
CREATE TABLE `group99_user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL UNIQUE,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

LOCK TABLES `group99_user` WRITE;
INSERT INTO `group99_user` VALUES 
  (1, "test", "test"),
  (2, "todd", "tuv"),
  (3, "schranz", "tuv");
UNLOCK TABLES;

DROP TABLE IF EXISTS `group99_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group99_article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `category_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `excerpt` text,
  `content` text,
  `status` tinyint NOT NULL DEFAULT '1',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `article_category` (`category_id`),
  KEY `article_user` (`user_id`),
  CONSTRAINT `article_category` FOREIGN KEY (`category_id`) REFERENCES `group99_category` (`category_id`),
  CONSTRAINT `article_user` FOREIGN KEY (`user_id`) REFERENCES `group99_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `group99_comment` (
  `comment_id` int unsigned NOT NULL AUTO_INCREMENT, 
  `article_id` int unsigned NOT NULL,
  `comment` varchar(500) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user` int unsigned NOT NULL,
  PRIMARY KEY(`comment_id`),
  CONSTRAINT `article_comment` FOREIGN KEY (`article_id`) REFERENCES `group99_article` (`article_id`),
  CONSTRAINT `comment_user` FOREIGN KEY (`user`) REFERENCES `group99_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group99_article`
--

LOCK TABLES `group99_article` WRITE;
/*!40000 ALTER TABLE `group99_article` DISABLE KEYS */;
INSERT INTO `group99_article` VALUES (37,'[TEST]Pentagon-Strategiepapier: US-Militär bastelt an denkenden Drohnen',3,2,'Pentagon-Strategiepapier: US-Militär bastelt an denkenden Drohnen Von Markus Becker ... [...] [...] [...] [...]                                                                                       [...]','<p><a href=\"http://www.spiegel.de/fotostrecke/militaertechnologie-drohnen-sollen-kleiner-und-autonom-werden-fotostrecke-105468.html\"><img alt=\"Militärtechnologie: Drohnen sollen kleiner und autonom werden\" class=\"left\" src=\"http://cdn4.spiegel.de/images/image-585147-breitwandaufmacher-ljpt.jpg\" style=\"height:180px; width:430px\" /></a></p>\r\n\r\n<p>Northrop Grumman Corporation</p>\r\n\r\n<p><strong>Das amerikanische Milit&auml;r will die Rolle von Drohnen ausweiten. Einem Pentagon-Strategiepapier zufolge sollen weitere Modelle bewaffnet werden, darunter unbemannte Hubschrauber. In Zukunft sollen die Maschinen sogar selbst entscheiden, ob sie schie&szlig;en.</strong></p>\r\n\r\n<p>Die Drohnen-Offensive der USA hat ihren H&ouml;hepunkt vorerst &uuml;berschritten: Mit dem Abzug der amerikanischen Truppen aus<a href=\"http://www.spiegel.de/thema/afghanistan/\">Afghanistan</a>&nbsp;ist auch die Zahl der Kampfeins&auml;tze unbemannter Flugzeuge deutlich gesunken. Doch ein neues Strategiepapier des&nbsp;<a href=\"http://www.spiegel.de/thema/pentagon/\">Pentagon</a>&nbsp;zeigt, dass die USA den milit&auml;rischen Einsatz von Drohnen zu Lande, zu Wasser und in der Luft deutlich ausweiten wollen.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Die&nbsp;<a href=\"http://www.defense.gov/pubs/DOD-USRM-2013.pdf\" target=\"_blank\">Unmanned Integrated Systems Roadmap</a>&nbsp;f&uuml;r den Zeitraum von 2013 bis 2038 zeigt, dass das US-Verteidigungsministerium unbemannte Systeme in Zukunft in einer zentralen Rolle sieht. Bisher werden Drohnen vor allem als taktische Flugsysteme eingesetzt, die in Kriegsgebieten feindliche Kr&auml;fte &uuml;berwachen und angreifen k&ouml;nnen. In Zukunft aber will das Pentagon unbemannte Systeme &quot;f&uuml;r alle Arten von Eventualit&auml;ten&quot; einsetzen. Aufkl&auml;rung, Terrorbek&auml;mpfung, die Bek&auml;mpfung von Massenvernichtungswaffen und Eins&auml;tze in umstrittenen Gebieten.</p>\r\n\r\n<p>Bemerkenswert ist, mit welchen Mitteln das Pentagon diese Ziele erreichen will. Kurzfristig sollen weitere, bereits vorhandene Drohnenmodelle mit Waffen ausger&uuml;stet werden, etwa unbemannte Hubschrauber. Mittelfristig sollen deshalb kleinere und pr&auml;zisere Waffen speziell f&uuml;r Drohnen entwickelt werden. Langfristig will das US-Milit&auml;r unbemannten Systemen auch Autonomie verleihen - also die F&auml;higkeit, eigenst&auml;ndige Entscheidungen ohne menschliches Zutun zu treffen. Darunter f&auml;llt ausdr&uuml;cklich auch der Einsatz von Waffen.</p>\r\n\r\n<p><strong>Ausgaben f&uuml;r Drohnen steigen</strong></p>\r\n\r\n<p>Obwohl der US-Verteidigungshaushalt in den kommenden zehn Jahren um fast 500 Milliarden Dollar schrumpfen soll, steigen die Ausgaben f&uuml;r unbemannte Systeme. Bis 2018 will das Pentagon 24 Milliarden Dollar investieren, das j&auml;hrliche Volumen steigt von 2014 bis 2018 von 4,1 auf 4,9 Milliarden.</p>\r\n\r\n<p>Schon kurzfristig d&uuml;rften neue Kampfdrohnen am Himmel auftauchen. Bisher verf&uuml;gt das US-Milit&auml;r in dieser Klasse vor allem &uuml;ber die &quot;Predator&quot;- und &quot;Reaper&quot;-Modelle. Die sind allerdings standardm&auml;&szlig;ig mit &quot;Hellfire&quot;-Raketen und Freifallbomben best&uuml;ckt - Waffen, die einst entwickelt wurden, um Panzer, Bunker oder Flugpl&auml;tze zu bek&auml;mpfen. Was passieren kann, wenn Waffen mit derartiger Zerst&ouml;rungskraft im Kampf gegen Aufst&auml;ndische eingesetzt werden, haben die Erfahrungen in Afghanistan gezeigt, wo zahlreiche Zivilisten bei Drohnen-Angriffen umkamen.</p>\r\n\r\n<p>Schon seit einiger Zeit geht der Trend deshalb&nbsp;<a href=\"http://www.spiegel.de/wissenschaft/technik/drohnen-neue-waffen-sollen-bundeswehr-programm-retten-a-902449.html\">zu immer kleineren und pr&auml;ziseren Waffen</a>. Ein Ziel ist, die Zahl der get&ouml;teten Unbeteiligten zu senken - in der Pentagon-Roadmap ist von &quot;akzeptablen Kollateralsch&auml;den&quot; die Rede. Zudem k&ouml;nnen durch kleinere Waffen auch die Drohnen selbst kleiner und unauff&auml;lliger werden. Der 168 Seiten starke Bericht enth&auml;lt daf&uuml;r diverse Beispiele.</p>\r\n\r\n<p><strong>Alte Rakete wird aufgemotzt</strong></p>\r\n\r\n<p>So wird die ungelenkte &quot;Hydra 70&quot;-Rakete, deren Entwicklungsgeschichte bis in den&nbsp;<a href=\"http://www.spiegel.de/thema/zweiter_weltkrieg/\">Zweiten Weltkrieg</a>&nbsp;zur&uuml;ckreicht, wohl eine neue Karriere an Bord von Drohnen machen. Bereits 2005 wurden bei einem Test vier &quot;Hydras&quot; von einer &quot;Vigilante&quot;-Helikopterdrohne abgefeuert. &quot;Das hat das Bewaffnungspotential von Rotor-Drohnen bewiesen&quot;, schw&auml;rmen die Autoren des Berichts. Das Pentagon hat zudem bereits begonnen, unbemannte &quot;Fire Scout&quot;-Hubschrauber mit aufgemotzten &quot;Hydras&quot; zu best&uuml;cken. Dazu werden die rund sechs Kilo schweren Luft-Boden-Raketen mit Lasersuchern und Leitsystemen ausgestattet. Das Ganze hei&szlig;t dann &quot;Advanced Precision Kill Weapon System II&quot;.</p>\r\n\r\n<p>Die unheimliche Entwicklung zum fliegenden Mini-Killer ist damit l&auml;ngst nicht am Ende. Wie es in dem Pentagon-Bericht hei&szlig;t, wurde die nur zweieinhalb Kilo schwere &quot;Spike&quot;-Rakete an der &quot;Sentry HP&quot;-Drohne getestet. Die wirkt mit einer Spannweite von weniger als vier Metern und einem Leergewicht von 82 Kilogramm geradezu winzig im Vergleich zu einer &quot;Predator&quot; oder &quot;Reaper&quot;.</p>\r\n\r\n<p>Noch kleiner werden t&ouml;dliche Drohnen, wenn sie keine Waffen verschie&szlig;en, sondern selbst welche sind. So erw&auml;hnt der Pentagon-Report die &quot;Switchblade&quot;-Minidrohne, die sich&nbsp;<a href=\"http://www.spiegel.de/wissenschaft/technik/drohnenkrieg-fliegende-killer-schrumpfen-auf-kleinformat-a-792714.html\">im Kamikaze-Stil auf den Gegner st&uuml;rzt und ihn in die Luft sprengt</a>. Ein weiteres Ger&auml;t dieser Art, &uuml;ber dessen Beschaffung nachgedacht werde, sei das Low-Cost Autonomous Attack System (Locaas). Dabei, hei&szlig;t es in dem Pentagon-Bericht, handele es sich um kleine, billige Waffen, die sich l&auml;ngere Zeit in einem Gebiet befinden und &quot;als Schwarm von intelligenter Munition autonom mobile Ziele finden und zerst&ouml;ren k&ouml;nnen&quot;.</p>\r\n\r\n<p><strong>Brisante Debatte um Autonomie</strong></p>\r\n\r\n<p>Der Begriff &quot;autonom&quot; ist im Zusammenhang mit Kampfdrohnen brisant: Er weckt oft die Horrorvorstellung von Killermaschinen, die ohne menschliche Kontrolle t&ouml;ten. Das ist offenbar auch den Autoren des Pentagon-Berichts bewusst. Sie betonen, dass &quot;Autonomie&quot; oft mit Automatik verwechselt wird. So k&ouml;nnten die heutigen ferngesteuerten Drohnen in Ausnahmesituationen - etwa wenn die Funkverbindung zur Bodenstation verlorengeht - zwar in den automatischen Betrieb wechseln. Autonomie aber bedeute, dass die Maschine im Rahmen ihrer Programmierung eigene Entscheidungen trifft, ohne dass der Mensch noch eingreifen muss.</p>\r\n\r\n<p>Doch genau das plant das Pentagon f&uuml;r die Zukunft. &quot;Die Autonomie unbemannter Systemen wird in zuk&uuml;nftigen Konflikten, die mit Technologie gek&auml;mpft und gewonnen werden, von entscheidender Bedeutung sein&quot;, hei&szlig;t es in dem Bericht. Autonome Systeme k&ouml;nnten in unberechenbaren Situationen schnell reagieren, indem sie eigene Entscheidungen tr&auml;fen.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Damit meinen die Pentagon-Autoren ausdr&uuml;cklich auch den Einsatz von Waffen. F&uuml;r die entsprechenden Bedingungen verweisen sie auf eine<a href=\"http://www.dtic.mil/whs/directives/corres/pdf/300009p.pdf\" target=\"_blank\">Direktive vom November 2012</a>. Darin hei&szlig;t es, dass &quot;autonome Waffensysteme zur Auswahl und zum Angriff auf Ziele&quot; verwendet werden k&ouml;nnen. Die Ausname: Die Maschinen d&uuml;rften keine Menschen ins Visier nehmen.</p>\r\n\r\n<p>Die Unterscheidung aber k&ouml;nnte im Ernstfall schwerfallen. Woher etwa soll eine Drohne wissen, ob ein Panzer oder ein Geb&auml;ude verlassen sind? Dass selbst Menschen in derartigen Situationen oft &uuml;berfordert sind, belegt die Geschichte tragischer Fehlentscheidungen bei Drohnenangriffen.</p>\r\n\r\n<p>Im Pentagon scheint man trotzdem zu glauben, dass die Einf&uuml;hrung autonomer unbemannter Waffensysteme nur noch eine Frage der Zeit ist. &quot;Generell entwickelt sich die Forschung weg von automatischen Systemen, die menschlicher Kontrolle bed&uuml;rfen, hin zu autonomen Systemen, die ohne menschlichen Einfluss entscheiden und reagieren&quot;, hei&szlig;t es in dem Bericht. Solche Programme gebe es auch in der US-Luftwaffe, der Armee, der Marine und bei der Pentagon-Forschungsabteilung Darpa. Autonome Systeme, schreiben die Autoren des Berichts, werden eines Tages &quot;allgegenw&auml;rtig&quot; sein.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n',1,'2020-01-06 20:45:09'),(46,'Thomas Hitzlsperger Becomes Only Fourth Footballer To Announce He Is Gay',2,1,'Thomas Hitzlsperger, the former Premier League footballer, has announced he is gay. The German international used an interview with Die Zeit magazine to become the latest footballer to reveal his sexuality. [...] [...] [...] [...]                                                                  [...]','<p>&nbsp;</p>\r\n\r\n<p><img alt=\"thomas hitzlsperger\" src=\"http://i.huffpost.com/gen/1550139/thumbs/o-THOMAS-HITZLSPERGER-570.jpg\" style=\"height:auto; margin:0px\" /></p>\r\n\r\n<p><strong>Thomas Hitzlsperger said it was a &#39;good time&#39; to make his announcement</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>The 31-year-old, who previously played for Aston Villa, West Ham and Everton during a successful career in England, is one of only a handful of former footballers to reveal they are gay and follows last year&#39;s announcement from ex-Leeds United and USA winger Robbie Rogers.</p>\r\n\r\n<p>In the interview, Hitzlsperger said it was &quot;a good time&quot; for him to reveal his true sexuality.</p>\r\n\r\n<p>&quot;I&#39;m coming out about my homosexuality because I want to move the discussion about homosexuality among professional sportspeople forwards,&quot; the midfielder said.</p>\r\n\r\n<p>The midfielder, who retired in December because of injuries, said he has only realised &quot;in the past few years&quot; that he would &quot;prefer to live together with another man&quot;, saying the issue is otherwise taboo inside the dressing room.</p>\r\n\r\n<p>&quot;I&#39;ve never been ashamed of the way I am,&quot; he added, although he conceded it has not always been easy to live with some of the comments dished out on the subject.</p>\r\n\r\n<p>&quot;Just picture 20 men sat around a table together drinking - you&#39;ve just got to let the majority be, just as long as the jokes are halfway funny and the talk about homosexuality doesn&#39;t get too insulting,&quot; he said.</p>\r\n\r\n<p>&quot;In England, Germany or Italy, homosexuality is not taken seriously as an issue, at least not in the dressing room.&quot;</p>\r\n',1,'2020-01-09 11:52:49');
/*!40000 ALTER TABLE `group99_article` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-03 11:11:43
