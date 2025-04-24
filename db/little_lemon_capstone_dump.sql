-- MySQL dump 10.13  Distrib 9.1.0, for Win64 (x86_64)
--
-- Host: localhost    Database: little_lemon_capstone
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Current Database: `little_lemon_capstone`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `little_lemon_capstone` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `little_lemon_capstone`;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `booking_slot` datetime NOT NULL,
  `table_number` int NOT NULL,
  `customer_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `diners_count` int NOT NULL DEFAULT '1',
  `booking_slot_date` date GENERATED ALWAYS AS (cast(`booking_slot` as date)) STORED,
  PRIMARY KEY (`booking_id`),
  KEY `booked_by` (`customer_id`),
  KEY `assigned_to` (`employee_id`),
  KEY `index_booking_slot_date` (`booking_slot_date`),
  CONSTRAINT `assigned_to` FOREIGN KEY (`employee_id`) REFERENCES `staff` (`employee_id`),
  CONSTRAINT `booked_by` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` (`booking_id`, `booking_slot`, `table_number`, `customer_id`, `employee_id`, `diners_count`) VALUES (1,'2025-05-01 18:00:00',1,1,NULL,2),(2,'2025-05-01 20:00:00',2,1,6,4),(3,'2025-05-02 18:00:00',3,2,NULL,3),(4,'2025-05-02 20:00:00',4,2,1,2),(5,'2025-05-03 18:00:00',5,3,NULL,2),(6,'2025-05-03 20:00:00',6,3,3,4),(7,'2025-05-04 18:00:00',7,4,NULL,1),(8,'2025-05-04 20:00:00',8,4,4,2),(9,'2025-05-05 18:00:00',1,5,NULL,2),(10,'2025-05-05 20:00:00',2,5,5,3),(11,'2025-05-06 18:00:00',3,6,NULL,4),(12,'2025-05-06 20:00:00',4,6,2,2),(13,'2025-05-07 18:00:00',5,7,NULL,2),(14,'2025-05-07 20:00:00',6,7,6,1),(15,'2025-05-08 18:00:00',7,8,NULL,3),(16,'2025-05-08 20:00:00',8,8,1,2),(17,'2025-05-08 20:00:00',5,1,NULL,1);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Alice Wonderland','+49 176 12345678','alice.wonderland@email.com'),(2,'Bob The Builder','+49 152 87654321','bob.thebuilder@email.com'),(3,'Charlie Chaplin','+49 163 11223344','charlie.chaplin@email.com'),(4,'Dorothy Gale','+49 177 99887766','dorothy.gale@email.com'),(5,'Eve Harrington','+49 151 22334455','eve.harrington@email.com'),(6,'Frankenstein Monster','+49 178 33445566','frankenstein@email.com'),(7,'Greta Garbo','+49 162 44556677','greta.garbo@email.com'),(8,'Hans Solo','+49 155 55667788','hans.solo@email.com');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `delivery_id` int NOT NULL AUTO_INCREMENT,
  `delivery_address_id` int NOT NULL,
  `delivery_cost` double NOT NULL,
  PRIMARY KEY (`delivery_id`),
  KEY `deliver_to` (`delivery_address_id`),
  CONSTRAINT `deliver_to` FOREIGN KEY (`delivery_address_id`) REFERENCES `delivery_address` (`delivery_address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (1,1,5.99),(2,3,7.5),(3,5,4.5),(4,7,6.25),(5,9,5.5),(6,11,8),(7,13,4.99),(8,15,7);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_address`
--

DROP TABLE IF EXISTS `delivery_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_address` (
  `delivery_address_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `street` varchar(255) NOT NULL,
  PRIMARY KEY (`delivery_address_id`),
  KEY `delivery_address_belongs_to_customer` (`customer_id`),
  CONSTRAINT `delivery_address_belongs_to_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_address`
--

LOCK TABLES `delivery_address` WRITE;
/*!40000 ALTER TABLE `delivery_address` DISABLE KEYS */;
INSERT INTO `delivery_address` VALUES (1,1,'60311','Main Street 1'),(2,1,'60528','Elm Avenue 22'),(3,2,'60322','Oak Road 15'),(4,2,'60599','Pine Lane 7'),(5,3,'60439','Parkway 3'),(6,3,'60313','River Side 101'),(7,4,'60596','Hill Top 5'),(8,4,'60308','Valley View 8'),(9,5,'60488','Church Street 12'),(10,5,'60529','Market Square 4'),(11,6,'60385','Forest Trail 9'),(12,6,'60594','Lake Drive 16'),(13,7,'60325','Castle Road 2'),(14,7,'60591','Bridge Street 11'),(15,8,'60437','Garden Lane 6'),(16,8,'60598','Field Way 14');
/*!40000 ALTER TABLE `delivery_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `high_demand_menu_items`
--

DROP TABLE IF EXISTS `high_demand_menu_items`;
/*!50001 DROP VIEW IF EXISTS `high_demand_menu_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `high_demand_menu_items` AS SELECT 
 1 AS `menuitem_id`,
 1 AS `item_name`,
 1 AS `item_description`,
 1 AS `price`,
 1 AS `category`,
 1 AS `menu_id`,
 1 AS `cuisine`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `high_sales`
--

DROP TABLE IF EXISTS `high_sales`;
/*!50001 DROP VIEW IF EXISTS `high_sales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `high_sales` AS SELECT 
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `order_id`,
 1 AS `subtotal`,
 1 AS `menuitem_id`,
 1 AS `quantity`,
 1 AS `total_item_price`,
 1 AS `item_name`,
 1 AS `price`,
 1 AS `cuisine`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `cuisine` varchar(50) NOT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Mediterranean'),(2,'Mexican'),(3,'American'),(4,'Japanese');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitem`
--

DROP TABLE IF EXISTS `menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitem` (
  `menuitem_id` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) NOT NULL,
  `item_description` tinytext,
  `price` double DEFAULT NULL,
  `category` enum('Starters','Main Course','Drinks','Desserts') DEFAULT NULL,
  `menu_id` int NOT NULL,
  PRIMARY KEY (`menuitem_id`),
  KEY `belongs_to_cuisine` (`menu_id`),
  CONSTRAINT `belongs_to_cuisine` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitem`
--

LOCK TABLES `menuitem` WRITE;
/*!40000 ALTER TABLE `menuitem` DISABLE KEYS */;
INSERT INTO `menuitem` VALUES (1,'Hummus with Pita Bread','Creamy chickpea dip served with warm pita bread',7.99,'Starters',1),(2,'Falafel','Deep-fried chickpea patties, served with tahini sauce',8.5,'Starters',1),(3,'Greek Salad','Fresh tomatoes, cucumbers, onions, olives, and feta cheese with a vinaigrette',9.5,'Starters',1),(4,'Moussaka','Layered eggplant, minced lamb, and béchamel sauce',16.99,'Main Course',1),(5,'Souvlaki (Chicken)','Grilled chicken skewers marinated in herbs and lemon',15.5,'Main Course',1),(6,'Baklava','Sweet pastry made of layers of filo dough filled with chopped nuts and sweetened with syrup',6.5,'Desserts',1),(7,'Greek Yogurt with Honey and Walnuts','Thick Greek yogurt drizzled with honey and sprinkled with walnuts',5.99,'Desserts',1),(8,'Greek White Wine (Glass)','Dry and refreshing white wine from Greece',6,'Drinks',1),(9,'Ouzo','Traditional anise-flavored aperitif',4.5,'Drinks',1),(10,'Guacamole with Tortilla Chips','Fresh avocado dip with lime, cilantro, and onions, served with crispy tortilla chips',8.99,'Starters',2),(11,'Quesadillas (Cheese)','Folded tortillas filled with melted cheese',7.5,'Starters',2),(12,'Chicken Enchiladas','Rolled tortillas filled with shredded chicken and topped with sauce and cheese',14.99,'Main Course',2),(13,'Beef Tacos (3)','Corn tortillas filled with seasoned ground beef, lettuce, and cheese',12.5,'Main Course',2),(14,'Churros with Chocolate Sauce','Fried dough pastries dusted with cinnamon sugar, served with rich chocolate sauce',6.99,'Desserts',2),(15,'Flan','Creamy custard dessert with a caramel topping',5.5,'Desserts',2),(16,'Mexican Lager','Light and refreshing beer from Mexico',5,'Drinks',2),(17,'Margarita','Classic cocktail with tequila, lime juice, and orange liqueur',8,'Drinks',2),(18,'Classic Caesar Salad','Romaine lettuce, croutons, Parmesan cheese, and Caesar dressing',9.5,'Starters',3),(19,'Buffalo Wings (6)','Crispy chicken wings tossed in spicy Buffalo sauce, served with blue cheese dip',10.99,'Starters',3),(20,'Classic Cheeseburger','Beef patty with melted cheese, lettuce, tomato, onion, and pickles on a bun',13.5,'Main Course',3),(21,'BBQ Ribs (Half Rack)','Slow-cooked pork ribs glazed with smoky BBQ sauce',17.99,'Main Course',3),(22,'Apple Pie','Traditional double-crust apple pie served warm',7.5,'Desserts',3),(23,'Chocolate Brownie Sundae','Warm chocolate brownie topped with vanilla ice cream, chocolate sauce, and whipped cream',8.99,'Desserts',3),(24,'Cola','Classic carbonated soft drink',3.5,'Drinks',3),(25,'Iced Tea','Brewed black tea served chilled',3,'Drinks',3),(26,'Edamame','Steamed soybeans lightly salted',6.5,'Starters',4),(27,'Gyoza (6)','Pan-fried Japanese dumplings filled with pork and vegetables',8,'Starters',4),(28,'Salmon Nigiri (2 pieces)','Sushi rice topped with fresh salmon',7.99,'Main Course',4),(29,'Chicken Teriyaki with Rice','Grilled chicken glazed with teriyaki sauce',15.99,'Main Course',4),(30,'Matcha Ice Cream','Green tea flavored ice cream',6.5,'Desserts',4),(31,'Mochi (2 pieces)','Sweet rice cakes with various fillings',5.99,'Desserts',4),(32,'Green Tea','Traditional Japanese green tea',4,'Drinks',4),(33,'Sake (Small)','Japanese rice wine',7,'Drinks',4);
/*!40000 ALTER TABLE `menuitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `order_id` int NOT NULL,
  `menuitem_id` int NOT NULL,
  `quantity` int NOT NULL,
  `total_item_price` double NOT NULL,
  PRIMARY KEY (`order_id`,`menuitem_id`),
  KEY `specifies_item` (`menuitem_id`),
  CONSTRAINT `belongs_to_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `specifies_item` FOREIGN KEY (`menuitem_id`) REFERENCES `menuitem` (`menuitem_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,2,15.98),(1,4,1,16.99),(2,2,1,8.5),(2,5,2,31),(3,12,1,14.99),(3,15,2,13.98),(4,11,2,15),(4,14,1,12.5),(5,21,1,13.5),(6,24,1,17.99),(7,25,2,15),(8,28,1,3.5),(9,29,2,7),(10,31,1,6.5),(11,32,2,16),(12,33,1,7.99),(13,32,4,16),(14,33,3,21),(15,1,1,7.99),(16,4,1,16.99),(17,2,2,17),(18,7,1,5.99),(19,9,1,4.5),(20,11,1,8.99),(21,14,1,12.5),(22,16,1,5.5),(23,18,2,16),(24,21,1,13.5),(25,24,1,17.99),(26,26,1,8.99),(27,29,1,3),(28,31,2,13),(29,33,2,14),(30,1,1,7.99),(31,5,1,15.5),(32,12,1,14.99),(33,15,2,13.98),(34,17,1,5),(35,21,2,27),(36,24,1,17.99),(37,27,1,8.99),(38,30,1,7),(39,33,2,15.98),(40,1,1,7.99);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `placed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int NOT NULL,
  `delivery_id` int DEFAULT NULL,
  `booking_id` int DEFAULT NULL,
  `subtotal` double NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `placed_by` (`customer_id`),
  KEY `optional_delivery` (`delivery_id`),
  KEY `placed_during_booking` (`booking_id`),
  CONSTRAINT `optional_delivery` FOREIGN KEY (`delivery_id`) REFERENCES `delivery` (`delivery_id`),
  CONSTRAINT `placed_by` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `placed_during_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2025-04-22 19:24:54',1,NULL,1,25),(2,'2025-04-22 19:24:54',1,NULL,1,30),(3,'2025-04-22 19:24:54',1,NULL,2,18),(4,'2025-04-22 19:24:54',1,NULL,2,22),(5,'2025-04-22 19:24:54',1,1,NULL,15),(6,'2025-04-22 19:24:54',2,NULL,3,28),(7,'2025-04-22 19:24:54',2,NULL,3,33),(8,'2025-04-22 19:24:54',2,NULL,4,20),(9,'2025-04-22 19:24:54',2,NULL,4,24),(10,'2025-04-22 19:24:54',2,2,NULL,17),(11,'2025-04-22 19:24:54',3,NULL,5,31),(12,'2025-04-22 19:24:54',3,NULL,5,36),(13,'2025-04-22 19:24:54',3,NULL,6,23),(14,'2025-04-22 19:24:54',3,NULL,6,27),(15,'2025-04-22 19:24:54',3,3,NULL,19),(16,'2025-04-22 19:24:54',4,NULL,7,34),(17,'2025-04-22 19:24:54',4,NULL,7,39),(18,'2025-04-22 19:24:54',4,NULL,8,26),(19,'2025-04-22 19:24:54',4,NULL,8,30),(20,'2025-04-22 19:24:54',4,4,NULL,21),(21,'2025-04-22 19:24:54',5,NULL,9,27),(22,'2025-04-22 19:24:54',5,NULL,9,32),(23,'2025-04-22 19:24:54',5,NULL,10,19),(24,'2025-04-22 19:24:54',5,NULL,10,23),(25,'2025-04-22 19:24:54',5,5,NULL,16),(26,'2025-04-22 19:24:54',6,NULL,11,30),(27,'2025-04-22 19:24:54',6,NULL,11,35),(28,'2025-04-22 19:24:54',6,NULL,12,22),(29,'2025-04-22 19:24:54',6,NULL,12,26),(30,'2025-04-22 19:24:54',6,6,NULL,18),(31,'2025-04-22 19:24:54',7,NULL,13,33),(32,'2025-04-22 19:24:54',7,NULL,13,38),(33,'2025-04-22 19:24:54',7,NULL,14,25),(34,'2025-04-22 19:24:54',7,NULL,14,29),(35,'2025-04-22 19:24:54',7,7,NULL,20),(36,'2025-04-22 19:24:54',8,NULL,15,29),(37,'2025-04-22 19:24:54',8,NULL,15,34),(38,'2025-04-22 19:24:54',8,NULL,16,21),(39,'2025-04-22 19:24:54',8,NULL,16,25),(40,'2025-04-22 19:24:54',8,8,NULL,17);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_delete_order_optional_booking_cleanup` AFTER DELETE ON `orders` FOR EACH ROW begin
    declare order_count int;
    if old.booking_id is not null then
        select count(order_id) into order_count
        from orders
        where booking_id = old.booking_id;
        if order_count = 0 then
            delete from booking where booking_id = old.booking_id;
        end if;
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_delete_order_delivery_cleanup` AFTER DELETE ON `orders` FOR EACH ROW begin
    if old.delivery_id is not null then
        delete from delivery where delivery_id = old.delivery_id;
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `orders_view`
--

DROP TABLE IF EXISTS `orders_view`;
/*!50001 DROP VIEW IF EXISTS `orders_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `orders_view` AS SELECT 
 1 AS `order_id`,
 1 AS `total_order_quantity`,
 1 AS `order_cost`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(255) NOT NULL,
  `employee_role` enum('Manager','Assistant Manager','Chef','Assistant Chef','Head Waiter','Receptionist') DEFAULT NULL,
  `salary` double NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Alfred Manager','Manager',5000,'+49 171 11122233','alfred.manager@email.com'),(2,'Betty Assistant','Assistant Manager',4000,'+49 152 44455566','betty.assistant@email.com'),(3,'Carl Chef','Chef',6000,'+49 163 77788899','carl.chef@email.com'),(4,'Diana Assistant','Assistant Chef',4500,'+49 177 99900011','diana.assistant@email.com'),(5,'Eric Headwaiter','Head Waiter',3500,'+49 151 22233344','eric.headwaiter@email.com'),(6,'Fiona Receptionist','Receptionist',3000,'+49 178 55566677','fiona.receptionist@email.com');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'little_lemon_capstone'
--

--
-- Dumping routines for database 'little_lemon_capstone'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_valid_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_valid_booking`(
    in by_customer_id int,
    in slot datetime,
    in table_no int,
    in number_of_diners int
)
begin
    start transaction;
    call is_table_booked(date(slot), table_no, @is_cooked);
    insert into booking(customer_id, booking_slot, table_number, diners_count)
    values (by_customer_id, slot, table_no, number_of_diners);
    if @is_cooked then
        rollback;
    else
        commit;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cancel_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancel_booking`(in booking_identifier int, out did_cancel bool)
begin
    declare existing_booking_slot datetime;
    select booking_slot
    into existing_booking_slot
    from booking
    where booking_id = booking_identifier;
    if existing_booking_slot is null then -- booking doesn't even exist
        set did_cancel = false;
    elseif now() >= existing_booking_slot then -- too late to cancel
        set did_cancel = false;
    else
        delete
        from booking
        where booking_id = booking_identifier;
        set did_cancel = true;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cancel_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancel_order`(in order_id int)
begin
    delete from orders where orders.order_id = order_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `can_move_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `can_move_booking`(in booking_identifier int, in to_slot datetime, out can_move bool)
begin
    declare old_slot_date date;
    declare table_no int;
    declare new_slot_date date default date(to_slot);
    select booking_slot_date, table_number
    into old_slot_date, table_no
    from booking
    where booking.booking_id = booking_identifier;
    if old_slot_date = new_slot_date then
        set can_move = true;
    else
        call is_table_booked(new_slot_date, table_no, @is_booked);
        set can_move = not @is_booked;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_max_quantity_ordered` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_max_quantity_ordered`()
begin
    select max(quantity) as max_quantity_ordered
    from orders
    natural join order_item;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `is_table_booked` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `is_table_booked`(in on_date date, in table_number int, out is_booked boolean)
begin
    declare int_is_booked int;
    select count(booking_id)
    into int_is_booked
    from booking
    where booking_slot_date = on_date -- index-based filtering first
      and booking.table_number = table_number; -- then check if there's an existing booking with the same table as requested
    if int_is_booked = 0 then
        set is_booked = false;
    else
        set is_booked = true;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_booking_slot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_booking_slot`(in booking_identifier int, in to_slot datetime, out did_update bool)
begin
    call can_move_booking(booking_identifier, to_slot, @can_move);
    if @can_move then
        update booking
        set booking_slot = to_slot
        where booking.booking_id = booking_identifier;
        set did_update = true;
    else
        set did_update = false;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `little_lemon_capstone`
--

USE `little_lemon_capstone`;

--
-- Final view structure for view `high_demand_menu_items`
--

/*!50001 DROP VIEW IF EXISTS `high_demand_menu_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `high_demand_menu_items` AS select `menuitem`.`menuitem_id` AS `menuitem_id`,`menuitem`.`item_name` AS `item_name`,`menuitem`.`item_description` AS `item_description`,`menuitem`.`price` AS `price`,`menuitem`.`category` AS `category`,`menuitem`.`menu_id` AS `menu_id`,`menu`.`cuisine` AS `cuisine` from (`menuitem` join `menu` on((`menuitem`.`menu_id` = `menu`.`menu_id`))) where `menuitem`.`menuitem_id` in (select `order_item`.`menuitem_id` from (`orders` join `order_item` on((`orders`.`order_id` = `order_item`.`order_id`))) group by `order_item`.`menuitem_id` having (count(`order_item`.`menuitem_id`) > 2)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `high_sales`
--

/*!50001 DROP VIEW IF EXISTS `high_sales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `high_sales` AS select `customer`.`customer_id` AS `customer_id`,`customer`.`customer_name` AS `customer_name`,`orders`.`order_id` AS `order_id`,`orders`.`subtotal` AS `subtotal`,`order_item`.`menuitem_id` AS `menuitem_id`,`order_item`.`quantity` AS `quantity`,`order_item`.`total_item_price` AS `total_item_price`,`menuitem`.`item_name` AS `item_name`,`menuitem`.`price` AS `price`,`menu`.`cuisine` AS `cuisine` from ((((`customer` join `orders` on((`customer`.`customer_id` = `orders`.`customer_id`))) join `order_item` on((`orders`.`order_id` = `order_item`.`order_id`))) join `menuitem` on((`order_item`.`menuitem_id` = `menuitem`.`menuitem_id`))) join `menu` on((`menuitem`.`menu_id` = `menu`.`menu_id`))) where (`orders`.`subtotal` > 30) order by `orders`.`subtotal` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `orders_view`
--

/*!50001 DROP VIEW IF EXISTS `orders_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `orders_view` AS select `orders`.`order_id` AS `order_id`,sum(`order_item`.`quantity`) AS `total_order_quantity`,sum(`order_item`.`total_item_price`) AS `order_cost` from (`orders` join `order_item` on((`orders`.`order_id` = `order_item`.`order_id`))) group by `orders`.`order_id` having (`total_order_quantity` > 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-24 18:01:58
