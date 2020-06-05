-- MySQL dump 10.13  Distrib 5.7.25, for osx10.9 (x86_64)
--
-- Host: localhost    Database: bowery
-- ------------------------------------------------------
-- Server version	5.7.25

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
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetindexdata`
--

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransformindex`
--

LOCK TABLES `assettransformindex` WRITE;
/*!40000 ALTER TABLE `assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (9,1,NULL,NULL,'2020-01-17 02:24:19','2020-01-17 02:24:19','9ee9f102-cc03-4536-8287-15218aa7beef');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
INSERT INTO `categorygroups` VALUES (1,1,NULL,'Blog Category','blogCategory','2020-01-17 02:12:51','2020-01-17 02:12:51',NULL,'71c8735d-f488-4e81-aa1d-bbcaffc53808');
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
INSERT INTO `categorygroups_sites` VALUES (1,1,1,0,NULL,NULL,'2020-01-17 02:12:51','2020-01-17 02:12:51','f68f2b1c-4359-420a-b063-f160fb6f7db3');
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_shortDescription` text,
  `field_heroTitle` text,
  `field_showInChannel` tinyint(1) DEFAULT NULL,
  `field_pageIndexed` tinyint(1) DEFAULT NULL,
  `field_featuredArticle` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,1,1,NULL,'2020-01-15 22:40:09','2020-01-15 22:40:09','9c8dec07-1fcc-442a-9645-4b18cf807f92',NULL,NULL,NULL,NULL,NULL),(2,2,1,NULL,'2020-01-17 02:21:51','2020-01-17 02:21:57','7ebcd264-26ae-4432-a4e9-727dba2f0496',NULL,NULL,1,1,0),(4,9,1,'Test Category','2020-01-17 02:24:19','2020-01-17 02:24:19','4ed946a0-2b28-4999-951c-1bf1f2c7bb4f',NULL,NULL,NULL,NULL,NULL),(5,12,1,'Test Blog 1','2020-01-17 02:24:27','2020-01-17 02:24:27','d0a58636-dedf-4efb-a963-2af5936e3420','This will be used on the Blog Feed page and as the meta description for the article.','Test Blog Title Override',1,1,0),(6,14,1,'Test Blog 1','2020-01-17 02:24:27','2020-01-17 02:24:27','f3ca7ba2-53a8-4b29-a28b-7e6f006397f7','This will be used on the Blog Feed page and as the meta description for the article.','Test Blog Title Override',1,1,0);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
INSERT INTO `drafts` VALUES (1,NULL,1,'First draft','');
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-01-15 22:40:09','2020-01-15 22:40:09',NULL,'481f9eb4-72b9-46e3-b347-4b1ccbcf4ee5'),(2,1,NULL,9,'craft\\elements\\Entry',1,0,'2020-01-17 02:21:51','2020-01-17 02:21:57',NULL,'6c1ddbed-d9d6-4681-abca-26e50b834ffb'),(3,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-01-17 02:21:57','2020-01-17 02:21:57',NULL,'62cc8775-4d50-46ee-9cd4-68aa0bcb63ad'),(5,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-01-17 02:23:50','2020-01-17 02:23:50','2020-01-17 02:23:53','94e4f55b-c3bd-4736-b879-ea44b54a228d'),(6,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-01-17 02:23:53','2020-01-17 02:23:53','2020-01-17 02:23:57','ef5a3479-3023-409a-97b2-6ca02c4e1d74'),(7,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-01-17 02:23:57','2020-01-17 02:23:57','2020-01-17 02:24:03','266f34ba-34e1-4991-b391-8d9da517e080'),(8,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-01-17 02:24:03','2020-01-17 02:24:03','2020-01-17 02:24:21','ff0f9927-4ee2-453a-9f9f-0a3e491d4d7d'),(9,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2020-01-17 02:24:19','2020-01-17 02:24:19',NULL,'8bfd8cba-5cea-44a1-ac68-1a234d317c52'),(10,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-01-17 02:24:21','2020-01-17 02:24:21','2020-01-17 02:24:27','753ad7ce-7555-4d6f-b93a-71420e2312d6'),(12,NULL,NULL,9,'craft\\elements\\Entry',1,0,'2020-01-17 02:24:27','2020-01-17 02:24:27',NULL,'0303e339-596a-4a81-924a-57503ca9857d'),(13,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-01-17 02:24:27','2020-01-17 02:24:27',NULL,'f87d1051-e0fb-492c-8b80-787b7ca28c45'),(14,NULL,1,9,'craft\\elements\\Entry',1,0,'2020-01-17 02:24:27','2020-01-17 02:24:27',NULL,'e237a796-18de-474c-8b0e-e08fb2ad24c1'),(15,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-01-17 02:24:27','2020-01-17 02:24:27',NULL,'cfde5436-69ed-4ed1-a3ac-04a43fb32acd');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-01-15 22:40:09','2020-01-15 22:40:09','3f23a51f-753d-4696-a8cb-1db08a1b3354'),(2,2,1,'__temp_1c0JwVufrPpO1HQfE29N2ZBGsx2116TL6bIN','blog/__temp_1c0JwVufrPpO1HQfE29N2ZBGsx2116TL6bIN',1,'2020-01-17 02:21:51','2020-01-17 02:21:51','4371fb16-19b9-4701-be9f-9550fa58bad0'),(3,3,1,NULL,NULL,1,'2020-01-17 02:21:57','2020-01-17 02:21:57','f4e745f6-e364-48d5-ae2d-91b18ef42cec'),(5,5,1,NULL,NULL,1,'2020-01-17 02:23:50','2020-01-17 02:23:50','c52306fa-b7c6-4e4b-87ff-a21aba5b7335'),(6,6,1,NULL,NULL,1,'2020-01-17 02:23:53','2020-01-17 02:23:53','cfc57e1c-7df1-4aae-b5c6-695e13ef3c11'),(7,7,1,NULL,NULL,1,'2020-01-17 02:23:57','2020-01-17 02:23:57','fc7207c4-96fb-44aa-b542-e3209abf5018'),(8,8,1,NULL,NULL,1,'2020-01-17 02:24:03','2020-01-17 02:24:03','77197702-fd49-4eec-a11c-412d55b3e429'),(9,9,1,'test-category',NULL,1,'2020-01-17 02:24:19','2020-01-17 02:24:19','f05d18ee-8556-4dfd-8758-a9b763f88387'),(10,10,1,NULL,NULL,1,'2020-01-17 02:24:21','2020-01-17 02:24:21','749cfd9c-a9c3-41c7-a8dc-e9709f8f4762'),(12,12,1,'test-blog-1','blog/test-blog-1',1,'2020-01-17 02:24:27','2020-01-17 02:24:27','49b696da-a3b9-43a7-a670-d4187795e252'),(13,13,1,NULL,NULL,1,'2020-01-17 02:24:27','2020-01-17 02:24:27','de149433-b6cb-4b6c-bfae-c158cddc7a90'),(14,14,1,'test-blog-1','blog/test-blog-1',1,'2020-01-17 02:24:27','2020-01-17 02:24:27','531c8623-edea-4adf-86eb-79a9b3980169'),(15,15,1,NULL,NULL,1,'2020-01-17 02:24:27','2020-01-17 02:24:27','6f341c3e-f3e4-4af0-82b2-b76e97af13fc');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
INSERT INTO `entries` VALUES (2,1,NULL,1,1,'2020-01-17 02:21:00',NULL,NULL,'2020-01-17 02:21:51','2020-01-17 02:21:51','ba21851a-4372-4424-aad1-4799f7aa86c7'),(12,1,NULL,1,1,'2020-01-17 02:23:00',NULL,NULL,'2020-01-17 02:24:27','2020-01-17 02:24:27','c2e83d0c-ef99-4ab8-b9f6-d127a5b5d9a8'),(14,1,NULL,1,1,'2020-01-17 02:23:00',NULL,NULL,'2020-01-17 02:24:27','2020-01-17 02:24:27','202e44f5-2c0f-437c-a0f6-b1f86b2948e2');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
INSERT INTO `entrytypes` VALUES (1,1,9,'Blog','blog',1,'Title','',1,'2020-01-17 02:01:14','2020-01-17 02:19:27',NULL,'76a61681-6ec2-4cf1-9d53-20a913398dc5');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
INSERT INTO `fieldgroups` VALUES (1,'Common','2020-01-15 22:40:08','2020-01-15 22:40:08','6f52bdcb-5ed8-4f65-8c01-52b5e19524fe'),(2,'Entry Fields','2020-01-17 02:01:35','2020-01-17 02:01:35','228e9f6e-20d4-40b9-8408-56cf2566ab12'),(3,'Blog Fields','2020-01-17 02:12:30','2020-01-17 02:12:30','5e153193-302c-482e-8bbc-651881d16cb2');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
INSERT INTO `fieldlayoutfields` VALUES (35,1,19,4,0,1,'2020-01-17 02:17:07','2020-01-17 02:17:07','ee6c1489-f961-4791-b7b1-1ddad1cc5138'),(36,2,20,5,0,2,'2020-01-17 02:17:07','2020-01-17 02:17:07','52f127b3-e318-41b7-924e-835258150ac6'),(37,2,20,6,0,1,'2020-01-17 02:17:07','2020-01-17 02:17:07','1a08f652-ad3c-4e7a-bf61-c4416177c601'),(38,3,21,7,0,1,'2020-01-17 02:17:07','2020-01-17 02:17:07','c7c86969-34a9-4a4f-9ee0-780e4decd924'),(39,3,21,8,0,2,'2020-01-17 02:17:07','2020-01-17 02:17:07','ba8de1f6-6599-4540-8c8d-db3b11d1e9a9'),(40,3,21,9,0,3,'2020-01-17 02:17:07','2020-01-17 02:17:07','7996a62d-5819-4a42-86ed-379206d4adce'),(41,4,22,10,0,1,'2020-01-17 02:17:07','2020-01-17 02:17:07','a5373b4b-5c6d-47ee-8c4d-6453e694b505'),(42,5,23,13,0,3,'2020-01-17 02:17:07','2020-01-17 02:17:07','579676c8-e0c4-4ef8-b41d-a44e3e354bcc'),(43,5,23,11,0,1,'2020-01-17 02:17:07','2020-01-17 02:17:07','6fb58542-6d4d-428d-9a65-9743c96ed09c'),(44,5,23,12,0,2,'2020-01-17 02:17:07','2020-01-17 02:17:07','355cdbdd-2c4d-43e0-9060-13f5baffb25b'),(45,5,23,14,0,4,'2020-01-17 02:17:07','2020-01-17 02:17:07','c248803b-9630-4061-bc03-8ee7872c8fd0'),(46,6,24,19,0,1,'2020-01-17 02:17:07','2020-01-17 02:17:07','e0654df3-abf7-4109-b7a7-0c5bcee9d02e'),(49,9,27,1,0,2,'2020-01-17 02:19:27','2020-01-17 02:19:27','b9984937-4559-4cd0-bca2-969897afc771'),(50,9,27,20,0,3,'2020-01-17 02:19:27','2020-01-17 02:19:27','715e95f3-4cd3-4e37-9104-e658a90ae686'),(51,9,27,3,0,4,'2020-01-17 02:19:27','2020-01-17 02:19:27','6975925d-d3d3-40d4-b49a-3d8cd7b1b9dc'),(52,9,27,2,0,1,'2020-01-17 02:19:27','2020-01-17 02:19:27','41f85555-7db8-459c-a08f-e48baee7e476'),(53,9,28,15,0,1,'2020-01-17 02:19:27','2020-01-17 02:19:27','d2c7a578-8751-4e04-b0b0-4b049e88261d'),(54,9,28,17,0,2,'2020-01-17 02:19:27','2020-01-17 02:19:27','27fdc87e-6d84-44f3-9378-5a31b4637e35'),(55,9,28,18,0,3,'2020-01-17 02:19:27','2020-01-17 02:19:27','7b50bdc2-f3d4-4f05-8e65-ca3ba70db648'),(56,9,28,16,0,4,'2020-01-17 02:19:27','2020-01-17 02:19:27','8d8323ff-9665-49f6-a94b-eebb069b597e'),(63,7,34,21,0,1,'2020-01-17 02:23:33','2020-01-17 02:23:33','df09ed47-4289-454a-8668-66c7ce11e6e0'),(64,7,34,23,0,2,'2020-01-17 02:23:33','2020-01-17 02:23:33','e68aef6a-6055-4f1b-be50-f9c71f7ab4e6');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\MatrixBlock','2020-01-17 02:04:15','2020-01-17 02:04:15',NULL,'d72fff6a-14dd-4482-83e2-2c453d09c692'),(2,'craft\\elements\\MatrixBlock','2020-01-17 02:09:28','2020-01-17 02:09:28',NULL,'8337815e-4eca-49c4-b5cd-52999562083e'),(3,'craft\\elements\\MatrixBlock','2020-01-17 02:09:28','2020-01-17 02:09:28',NULL,'1f994b47-6d90-4ec8-afed-5c0fcf8bcbd7'),(4,'craft\\elements\\MatrixBlock','2020-01-17 02:09:28','2020-01-17 02:09:28',NULL,'c24ef294-7a7d-47ff-8b89-6fb1c91929c5'),(5,'craft\\elements\\MatrixBlock','2020-01-17 02:09:28','2020-01-17 02:09:28',NULL,'bbaf8c50-cd63-40eb-b157-587342526d08'),(6,'craft\\elements\\MatrixBlock','2020-01-17 02:16:49','2020-01-17 02:16:49',NULL,'1fa5bb44-62a9-470b-9360-65250e5814a0'),(7,'craft\\elements\\MatrixBlock','2020-01-17 02:18:38','2020-01-17 02:18:38',NULL,'deebaa6c-d1c0-40c1-8063-66c64bd98f6a'),(8,'craft\\elements\\MatrixBlock','2020-01-17 02:18:38','2020-01-17 02:18:38','2020-01-17 02:23:01','b2051281-4078-416d-91f7-c249f6f7ee54'),(9,'craft\\elements\\Entry','2020-01-17 02:19:27','2020-01-17 02:19:27',NULL,'90dd8fad-652f-4f1c-b9c9-cc2f25210f0f');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
INSERT INTO `fieldlayouttabs` VALUES (19,1,'Content',1,'2020-01-17 02:17:07','2020-01-17 02:17:07','c62ad7d3-0ca3-49a5-a923-2169c55c6ef1'),(20,2,'Content',1,'2020-01-17 02:17:07','2020-01-17 02:17:07','7e51111e-b64b-4dcc-b3de-2bc15cfcde71'),(21,3,'Content',1,'2020-01-17 02:17:07','2020-01-17 02:17:07','935eea1f-4151-41ac-9d78-3f22d48a297c'),(22,4,'Content',1,'2020-01-17 02:17:07','2020-01-17 02:17:07','38bbc847-0720-4917-afdb-d3afffef7aeb'),(23,5,'Content',1,'2020-01-17 02:17:07','2020-01-17 02:17:07','5ea59c2e-3c96-4042-8a36-5de33c3c8696'),(24,6,'Content',1,'2020-01-17 02:17:07','2020-01-17 02:17:07','27d4867e-16d0-429e-a340-8ab3ac7eddce'),(27,9,'Content',1,'2020-01-17 02:19:27','2020-01-17 02:19:27','aeae8bcc-6dd8-4083-9131-6e90dea8aab1'),(28,9,'Categories',2,'2020-01-17 02:19:27','2020-01-17 02:19:27','25066ab5-3573-415e-9630-a81a243d7634'),(32,8,'Content',1,'2020-01-17 02:21:40','2020-01-17 02:21:40','9ce4d4e7-724d-4dd6-90b7-172059d3b9fb'),(34,7,'Content',1,'2020-01-17 02:23:33','2020-01-17 02:23:33','bdc6b33e-3fd9-4201-b022-8b26b8dd2ee1');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (1,2,'Short Description','shortDescription','global','This will be used on the Blog Feed page and as the meta description for the article.',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"240\",\"columnType\":\"text\"}','2020-01-17 02:02:46','2020-01-17 02:02:46','548d97b3-3128-4e16-8569-a3759516b292'),(2,2,'Hero Title','heroTitle','global','This will override the entry\'s Hero title from the Entry title.',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2020-01-17 02:03:33','2020-01-17 02:03:33','dcd98d41-6cc3-4f07-be15-999638e7b579'),(3,2,'Content Builder','contentBuilder','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_contentbuilder}}\",\"propagationMethod\":\"all\"}','2020-01-17 02:04:15','2020-01-17 02:17:07','af72050e-2cad-4337-b443-afb95eaf9a45'),(4,NULL,'General Body','generalBody','matrixBlockType:0eb6c9c5-4532-4fa2-935a-1f045e39d569','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2020-01-17 02:04:15','2020-01-17 02:17:07','932a7ac5-250c-4ce5-80fc-a1dd2bbf4619'),(5,NULL,'Column 2','column2','matrixBlockType:466b8e7f-2f35-4bc7-bc82-2d1bc3c34916','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2020-01-17 02:09:28','2020-01-17 02:17:07','385790f2-b145-4ebe-a835-647b6b02e97f'),(6,NULL,'Column 1','column1','matrixBlockType:466b8e7f-2f35-4bc7-bc82-2d1bc3c34916','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2020-01-17 02:09:28','2020-01-17 02:17:07','c45f7c16-c54f-4e5c-a8cb-af00c56b5d35'),(7,NULL,'Column 1','column1','matrixBlockType:f21a27b8-ab14-43b8-af05-24d4621763f4','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2020-01-17 02:09:28','2020-01-17 02:17:07','451adb67-d262-4fe4-86b9-8d74f0cbb0db'),(8,NULL,'Column 2','column2','matrixBlockType:f21a27b8-ab14-43b8-af05-24d4621763f4','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2020-01-17 02:09:28','2020-01-17 02:17:07','8325cbbf-c123-489b-9400-0726fdc773ad'),(9,NULL,'Column 3','column3','matrixBlockType:f21a27b8-ab14-43b8-af05-24d4621763f4','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2020-01-17 02:09:28','2020-01-17 02:17:07','fad31a8c-274a-400f-bca4-1f73075d9fe2'),(10,NULL,'Youtube Video ID','youtubeVideoId','matrixBlockType:2155962f-040a-49ee-89a7-0ae336e63c66','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"Enter Youtube Video ID here.\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2020-01-17 02:09:28','2020-01-17 02:17:07','86474f93-9da7-4879-8c1e-c3c090d0a132'),(11,NULL,'Image','image','matrixBlockType:f2bb1d94-19a5-4887-9477-af748a8c73b3','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2020-01-17 02:09:28','2020-01-17 02:17:07','63d84452-12da-4238-b00d-85ff784aea72'),(12,NULL,'Image Position','imagePosition','matrixBlockType:f2bb1d94-19a5-4887-9477-af748a8c73b3','',1,'none',NULL,'rias\\positionfieldtype\\fields\\Position','{\"options\":{\"left\":\"1\",\"center\":\"\",\"right\":\"1\",\"full\":\"\",\"drop-left\":\"\",\"drop-right\":\"\"},\"default\":\"left\"}','2020-01-17 02:09:28','2020-01-17 02:17:07','c5a7916c-1df3-4ae2-8ace-282fb45405e2'),(13,NULL,'Image Width','imageWidth','matrixBlockType:f2bb1d94-19a5-4887-9477-af748a8c73b3','',1,'none',NULL,'rias\\widthfieldtype\\fields\\Width','{\"options\":{\"1/6\":\"\",\"1/5\":\"\",\"1/4\":\"1\",\"1/3\":\"\",\"2/5\":\"\",\"1/2\":\"1\",\"3/5\":\"\",\"2/3\":\"\",\"3/4\":\"1\",\"4/5\":\"\",\"5/6\":\"\",\"full\":\"1\"},\"default\":\"\"}','2020-01-17 02:12:20','2020-01-17 02:17:07','0d5e40eb-d28f-4af7-af13-124c554f2fa8'),(14,NULL,'Image Content','imageContent','matrixBlockType:f2bb1d94-19a5-4887-9477-af748a8c73b3','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2020-01-17 02:12:20','2020-01-17 02:17:07','f7f40511-14fa-4f8a-9808-f96a80afa547'),(15,3,'Blog Category','blogCategory','global','',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:71c8735d-f488-4e81-aa1d-bbcaffc53808\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"Select Category\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2020-01-17 02:13:27','2020-01-17 02:13:27','6aa205b6-3efc-4689-9e99-2447d91f3865'),(16,2,'Show In Channel','showInChannel','global','',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"1\"}','2020-01-17 02:13:45','2020-01-17 02:13:45','febb123c-c754-471c-a35a-dc7eae0f2265'),(17,2,'Page Indexed','pageIndexed','global','When disabled this page will not be crawl-able by search engines.',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"1\"}','2020-01-17 02:14:26','2020-01-17 02:14:26','ade9167e-e02b-43a5-b52d-86b4a56860f6'),(18,2,'Featured Article','featuredArticle','global','When enabled the lasted \"Featured Article\" will appear at the top of https://bowerycap.com/blog',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2020-01-17 02:15:15','2020-01-17 02:15:15','f634851a-eb05-4a60-af4d-164e310424ab'),(19,NULL,'Related Entries','relatedEntries','matrixBlockType:7b72b4a5-a7af-46d5-bea7-ff903c778857','If no entries are selected Craft will pull the latest 3 entries of this Category, excluding the current article.',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":[\"section:242f586b-2bf7-4bf3-9b50-dea8f1102019\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"3\",\"selectionLabel\":\"Select Entry\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2020-01-17 02:16:49','2020-01-17 02:17:07','2ecb6aca-aac9-4a0e-9428-51dcd86427af'),(20,2,'Entry Images','entryImages','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"1\",\"maxBlocks\":\"1\",\"contentTable\":\"{{%matrixcontent_entryimages}}\",\"propagationMethod\":\"all\"}','2020-01-17 02:18:38','2020-01-17 02:23:33','a8478317-0a0b-405a-bd4a-b2b1d8c8daff'),(21,NULL,'Hero Image','heroImage','matrixBlockType:9de65e1a-4f85-4327-be76-df7a397ce18a','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\",\"defaultUploadLocationSubpath\":\"hero-images\",\"singleUploadLocationSource\":\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":[\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add Hero Image\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2020-01-17 02:18:38','2020-01-17 02:23:33','36742cbc-9fa1-48b7-a0df-aa93c21366a0'),(23,NULL,'Thumbnail Images','thumbnailImages','matrixBlockType:9de65e1a-4f85-4327-be76-df7a397ce18a','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\",\"defaultUploadLocationSubpath\":\"thumbnail-images\",\"singleUploadLocationSource\":\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Select Thumbnail\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2020-01-17 02:23:01','2020-01-17 02:23:33','d39716e0-2527-42be-8b20-bbd0f65ca691');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `scope` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqlschemas_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
INSERT INTO `info` VALUES (1,'3.3.20.1','3.3.3',0,'{\"fieldGroups\":{\"6f52bdcb-5ed8-4f65-8c01-52b5e19524fe\":{\"name\":\"Common\"},\"228e9f6e-20d4-40b9-8408-56cf2566ab12\":{\"name\":\"Entry Fields\"},\"5e153193-302c-482e-8bbc-651881d16cb2\":{\"name\":\"Blog Fields\"}},\"siteGroups\":{\"aaa3119a-1413-4b14-a339-285667143c13\":{\"name\":\"Bowery Capital\"}},\"sites\":{\"6f9e97f6-4f67-41a1-8239-60a02c64fb29\":{\"baseUrl\":\"$DEFAULT_SITE_URL\",\"handle\":\"default\",\"hasUrls\":true,\"language\":\"en-US\",\"name\":\"Bowery Capital\",\"primary\":true,\"siteGroup\":\"aaa3119a-1413-4b14-a339-285667143c13\",\"sortOrder\":1}},\"email\":{\"fromEmail\":\"nmann4789@gmail.com\",\"fromName\":\"Bowery Capital\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"},\"system\":{\"edition\":\"solo\",\"name\":\"Bowery Capital\",\"live\":true,\"schemaVersion\":\"3.3.3\",\"timeZone\":\"America/Los_Angeles\"},\"users\":{\"requireEmailVerification\":true,\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoVolumeUid\":null,\"photoSubpath\":\"\"},\"dateModified\":1579227813,\"sections\":{\"242f586b-2bf7-4bf3-9b50-dea8f1102019\":{\"name\":\"Blog\",\"handle\":\"blog\",\"type\":\"channel\",\"enableVersioning\":true,\"propagationMethod\":\"all\",\"siteSettings\":{\"6f9e97f6-4f67-41a1-8239-60a02c64fb29\":{\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"blog/{slug}\",\"template\":\"\"}},\"entryTypes\":{\"76a61681-6ec2-4cf1-9d53-20a913398dc5\":{\"name\":\"Blog\",\"handle\":\"blog\",\"hasTitleField\":true,\"titleLabel\":\"Title\",\"titleFormat\":\"\",\"sortOrder\":1,\"fieldLayouts\":{\"90dd8fad-652f-4f1c-b9c9-cc2f25210f0f\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"548d97b3-3128-4e16-8569-a3759516b292\":{\"required\":false,\"sortOrder\":2},\"a8478317-0a0b-405a-bd4a-b2b1d8c8daff\":{\"required\":false,\"sortOrder\":3},\"af72050e-2cad-4337-b443-afb95eaf9a45\":{\"required\":false,\"sortOrder\":4},\"dcd98d41-6cc3-4f07-be15-999638e7b579\":{\"required\":false,\"sortOrder\":1}}},{\"name\":\"Categories\",\"sortOrder\":2,\"fields\":{\"6aa205b6-3efc-4689-9e99-2447d91f3865\":{\"required\":false,\"sortOrder\":1},\"ade9167e-e02b-43a5-b52d-86b4a56860f6\":{\"required\":false,\"sortOrder\":2},\"f634851a-eb05-4a60-af4d-164e310424ab\":{\"required\":false,\"sortOrder\":3},\"febb123c-c754-471c-a35a-dc7eae0f2265\":{\"required\":false,\"sortOrder\":4}}}]}}}}}},\"fields\":{\"548d97b3-3128-4e16-8569-a3759516b292\":{\"name\":\"Short Description\",\"handle\":\"shortDescription\",\"instructions\":\"This will be used on the Blog Feed page and as the meta description for the article.\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"240\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"228e9f6e-20d4-40b9-8408-56cf2566ab12\"},\"dcd98d41-6cc3-4f07-be15-999638e7b579\":{\"name\":\"Hero Title\",\"handle\":\"heroTitle\",\"instructions\":\"This will override the entry\'s Hero title from the Entry title.\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"228e9f6e-20d4-40b9-8408-56cf2566ab12\"},\"af72050e-2cad-4337-b443-afb95eaf9a45\":{\"name\":\"Content Builder\",\"handle\":\"contentBuilder\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Matrix\",\"settings\":{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_contentbuilder}}\",\"propagationMethod\":\"all\"},\"contentColumnType\":\"string\",\"fieldGroup\":\"228e9f6e-20d4-40b9-8408-56cf2566ab12\"},\"6aa205b6-3efc-4689-9e99-2447d91f3865\":{\"name\":\"Blog Category\",\"handle\":\"blogCategory\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Categories\",\"settings\":{\"allowLimit\":false,\"allowMultipleSources\":false,\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:71c8735d-f488-4e81-aa1d-bbcaffc53808\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"Select Category\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":\"5e153193-302c-482e-8bbc-651881d16cb2\"},\"febb123c-c754-471c-a35a-dc7eae0f2265\":{\"name\":\"Show In Channel\",\"handle\":\"showInChannel\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Lightswitch\",\"settings\":{\"default\":\"1\"},\"contentColumnType\":\"boolean\",\"fieldGroup\":\"228e9f6e-20d4-40b9-8408-56cf2566ab12\"},\"ade9167e-e02b-43a5-b52d-86b4a56860f6\":{\"name\":\"Page Indexed\",\"handle\":\"pageIndexed\",\"instructions\":\"When disabled this page will not be crawl-able by search engines.\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Lightswitch\",\"settings\":{\"default\":\"1\"},\"contentColumnType\":\"boolean\",\"fieldGroup\":\"228e9f6e-20d4-40b9-8408-56cf2566ab12\"},\"f634851a-eb05-4a60-af4d-164e310424ab\":{\"name\":\"Featured Article\",\"handle\":\"featuredArticle\",\"instructions\":\"When enabled the lasted \\\"Featured Article\\\" will appear at the top of https://bowerycap.com/blog\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Lightswitch\",\"settings\":{\"default\":\"\"},\"contentColumnType\":\"boolean\",\"fieldGroup\":\"228e9f6e-20d4-40b9-8408-56cf2566ab12\"},\"a8478317-0a0b-405a-bd4a-b2b1d8c8daff\":{\"name\":\"Entry Images\",\"handle\":\"entryImages\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Matrix\",\"settings\":{\"minBlocks\":\"1\",\"maxBlocks\":\"1\",\"contentTable\":\"{{%matrixcontent_entryimages}}\",\"propagationMethod\":\"all\"},\"contentColumnType\":\"string\",\"fieldGroup\":\"228e9f6e-20d4-40b9-8408-56cf2566ab12\"}},\"matrixBlockTypes\":{\"0eb6c9c5-4532-4fa2-935a-1f045e39d569\":{\"field\":\"af72050e-2cad-4337-b443-afb95eaf9a45\",\"name\":\"General Body\",\"handle\":\"generalBody\",\"sortOrder\":1,\"fields\":{\"932a7ac5-250c-4ce5-80fc-a1dd2bbf4619\":{\"name\":\"General Body\",\"handle\":\"generalBody\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\redactor\\\\Field\",\"settings\":{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"},\"contentColumnType\":\"text\",\"fieldGroup\":null}},\"fieldLayouts\":{\"d72fff6a-14dd-4482-83e2-2c453d09c692\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"932a7ac5-250c-4ce5-80fc-a1dd2bbf4619\":{\"required\":false,\"sortOrder\":1}}}]}}},\"466b8e7f-2f35-4bc7-bc82-2d1bc3c34916\":{\"field\":\"af72050e-2cad-4337-b443-afb95eaf9a45\",\"name\":\"Two Column Section\",\"handle\":\"twoColumnSection\",\"sortOrder\":2,\"fields\":{\"385790f2-b145-4ebe-a835-647b6b02e97f\":{\"name\":\"Column 2\",\"handle\":\"column2\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\redactor\\\\Field\",\"settings\":{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"},\"contentColumnType\":\"text\",\"fieldGroup\":null},\"c45f7c16-c54f-4e5c-a8cb-af00c56b5d35\":{\"name\":\"Column 1\",\"handle\":\"column1\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\redactor\\\\Field\",\"settings\":{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"},\"contentColumnType\":\"text\",\"fieldGroup\":null}},\"fieldLayouts\":{\"8337815e-4eca-49c4-b5cd-52999562083e\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"385790f2-b145-4ebe-a835-647b6b02e97f\":{\"required\":false,\"sortOrder\":2},\"c45f7c16-c54f-4e5c-a8cb-af00c56b5d35\":{\"required\":false,\"sortOrder\":1}}}]}}},\"f21a27b8-ab14-43b8-af05-24d4621763f4\":{\"field\":\"af72050e-2cad-4337-b443-afb95eaf9a45\",\"name\":\"Three Column Section\",\"handle\":\"threeColumnSection\",\"sortOrder\":3,\"fields\":{\"451adb67-d262-4fe4-86b9-8d74f0cbb0db\":{\"name\":\"Column 1\",\"handle\":\"column1\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\redactor\\\\Field\",\"settings\":{\"redactorConfig\":\"\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"},\"contentColumnType\":\"text\",\"fieldGroup\":null},\"8325cbbf-c123-489b-9400-0726fdc773ad\":{\"name\":\"Column 2\",\"handle\":\"column2\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\redactor\\\\Field\",\"settings\":{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"},\"contentColumnType\":\"text\",\"fieldGroup\":null},\"fad31a8c-274a-400f-bca4-1f73075d9fe2\":{\"name\":\"Column 3\",\"handle\":\"column3\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\redactor\\\\Field\",\"settings\":{\"redactorConfig\":\"\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"},\"contentColumnType\":\"text\",\"fieldGroup\":null}},\"fieldLayouts\":{\"1f994b47-6d90-4ec8-afed-5c0fcf8bcbd7\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"451adb67-d262-4fe4-86b9-8d74f0cbb0db\":{\"required\":false,\"sortOrder\":1},\"8325cbbf-c123-489b-9400-0726fdc773ad\":{\"required\":false,\"sortOrder\":2},\"fad31a8c-274a-400f-bca4-1f73075d9fe2\":{\"required\":false,\"sortOrder\":3}}}]}}},\"2155962f-040a-49ee-89a7-0ae336e63c66\":{\"field\":\"af72050e-2cad-4337-b443-afb95eaf9a45\",\"name\":\"Youtube Video\",\"handle\":\"youtubeVideo\",\"sortOrder\":4,\"fields\":{\"86474f93-9da7-4879-8c1e-c3c090d0a132\":{\"name\":\"Youtube Video ID\",\"handle\":\"youtubeVideoId\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"Enter Youtube Video ID here.\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":null}},\"fieldLayouts\":{\"c24ef294-7a7d-47ff-8b89-6fb1c91929c5\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"86474f93-9da7-4879-8c1e-c3c090d0a132\":{\"required\":false,\"sortOrder\":1}}}]}}},\"f2bb1d94-19a5-4887-9477-af748a8c73b3\":{\"field\":\"af72050e-2cad-4337-b443-afb95eaf9a45\",\"name\":\"Text Column With Image\",\"handle\":\"textColumnWithImage\",\"sortOrder\":5,\"fields\":{\"0d5e40eb-d28f-4af7-af13-124c554f2fa8\":{\"name\":\"Image Width\",\"handle\":\"imageWidth\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"rias\\\\widthfieldtype\\\\fields\\\\Width\",\"settings\":{\"options\":{\"1/6\":\"\",\"1/5\":\"\",\"1/4\":\"1\",\"1/3\":\"\",\"2/5\":\"\",\"1/2\":\"1\",\"3/5\":\"\",\"2/3\":\"\",\"3/4\":\"1\",\"4/5\":\"\",\"5/6\":\"\",\"full\":\"1\"},\"default\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":null},\"63d84452-12da-4238-b00d-85ff784aea72\":{\"name\":\"Image\",\"handle\":\"image\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Assets\",\"settings\":{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":null},\"c5a7916c-1df3-4ae2-8ace-282fb45405e2\":{\"name\":\"Image Position\",\"handle\":\"imagePosition\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"rias\\\\positionfieldtype\\\\fields\\\\Position\",\"settings\":{\"options\":{\"left\":\"1\",\"center\":\"\",\"right\":\"1\",\"full\":\"\",\"drop-left\":\"\",\"drop-right\":\"\"},\"default\":\"left\"},\"contentColumnType\":\"string\",\"fieldGroup\":null},\"f7f40511-14fa-4f8a-9808-f96a80afa547\":{\"name\":\"Image Content\",\"handle\":\"imageContent\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\redactor\\\\Field\",\"settings\":{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":true,\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\",\"purifyHtml\":\"\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"},\"contentColumnType\":\"text\",\"fieldGroup\":null}},\"fieldLayouts\":{\"bbaf8c50-cd63-40eb-b157-587342526d08\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"0d5e40eb-d28f-4af7-af13-124c554f2fa8\":{\"required\":false,\"sortOrder\":3},\"63d84452-12da-4238-b00d-85ff784aea72\":{\"required\":false,\"sortOrder\":1},\"c5a7916c-1df3-4ae2-8ace-282fb45405e2\":{\"required\":false,\"sortOrder\":2},\"f7f40511-14fa-4f8a-9808-f96a80afa547\":{\"required\":false,\"sortOrder\":4}}}]}}},\"7b72b4a5-a7af-46d5-bea7-ff903c778857\":{\"field\":\"af72050e-2cad-4337-b443-afb95eaf9a45\",\"name\":\"Related Entries\",\"handle\":\"relatedEntries\",\"sortOrder\":6,\"fields\":{\"2ecb6aca-aac9-4a0e-9428-51dcd86427af\":{\"name\":\"Related Entries\",\"handle\":\"relatedEntries\",\"instructions\":\"If no entries are selected Craft will pull the latest 3 entries of this Category, excluding the current article.\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Entries\",\"settings\":{\"sources\":[\"section:242f586b-2bf7-4bf3-9b50-dea8f1102019\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"3\",\"selectionLabel\":\"Select Entry\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":null}},\"fieldLayouts\":{\"1fa5bb44-62a9-470b-9360-65250e5814a0\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"2ecb6aca-aac9-4a0e-9428-51dcd86427af\":{\"required\":false,\"sortOrder\":1}}}]}}},\"9de65e1a-4f85-4327-be76-df7a397ce18a\":{\"field\":\"a8478317-0a0b-405a-bd4a-b2b1d8c8daff\",\"name\":\"Entry Images\",\"handle\":\"entryImages\",\"sortOrder\":1,\"fields\":{\"36742cbc-9fa1-48b7-a0df-aa93c21366a0\":{\"name\":\"Hero Image\",\"handle\":\"heroImage\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Assets\",\"settings\":{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\",\"defaultUploadLocationSubpath\":\"hero-images\",\"singleUploadLocationSource\":\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":[\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add Hero Image\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":null},\"d39716e0-2527-42be-8b20-bbd0f65ca691\":{\"name\":\"Thumbnail Images\",\"handle\":\"thumbnailImages\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Assets\",\"settings\":{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\",\"defaultUploadLocationSubpath\":\"thumbnail-images\",\"singleUploadLocationSource\":\"volume:ec9122e7-d1e3-491c-b413-dec803a1603a\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Select Thumbnail\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":null}},\"fieldLayouts\":{\"deebaa6c-d1c0-40c1-8063-66c64bd98f6a\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"36742cbc-9fa1-48b7-a0df-aa93c21366a0\":{\"required\":false,\"sortOrder\":1},\"d39716e0-2527-42be-8b20-bbd0f65ca691\":{\"required\":false,\"sortOrder\":2}}}]}}}},\"plugins\":{\"redactor\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"2.3.0\"},\"width-fieldtype\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"1.0.0\"},\"position-fieldtype\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"1.0.0\"}},\"categoryGroups\":{\"71c8735d-f488-4e81-aa1d-bbcaffc53808\":{\"name\":\"Blog Category\",\"handle\":\"blogCategory\",\"structure\":{\"uid\":\"7ed3da8d-cee2-4001-8e98-b0f1319a060c\",\"maxLevels\":null},\"siteSettings\":{\"6f9e97f6-4f67-41a1-8239-60a02c64fb29\":{\"hasUrls\":false,\"uriFormat\":null,\"template\":null}}}},\"volumes\":{\"ec9122e7-d1e3-491c-b413-dec803a1603a\":{\"name\":\"Uploaded Images\",\"handle\":\"uploadedImages\",\"type\":\"craft\\\\volumes\\\\Local\",\"hasUrls\":true,\"url\":\"@web\",\"settings\":{\"path\":\"/template-img\"},\"sortOrder\":1}}}','[]','TeWXPtwbRYtv','2020-01-15 22:40:08','2020-01-15 22:40:08','161bc41a-909b-438e-85fe-169ece944daa');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
INSERT INTO `matrixblocks` VALUES (3,2,20,7,1,NULL,'2020-01-17 02:21:57','2020-01-17 02:21:57','3bdfa431-06db-42fb-90ce-428d7f465e21'),(13,12,20,7,1,NULL,'2020-01-17 02:24:27','2020-01-17 02:24:27','4f6d8dd3-6809-4e5e-87d0-c0427aaaf785'),(15,14,20,7,1,NULL,'2020-01-17 02:24:27','2020-01-17 02:24:27','539139f3-eecf-4bd5-9d3c-92f89331e1d7');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
INSERT INTO `matrixblocktypes` VALUES (1,3,1,'General Body','generalBody',1,'2020-01-17 02:04:15','2020-01-17 02:04:15','0eb6c9c5-4532-4fa2-935a-1f045e39d569'),(2,3,2,'Two Column Section','twoColumnSection',2,'2020-01-17 02:09:28','2020-01-17 02:09:28','466b8e7f-2f35-4bc7-bc82-2d1bc3c34916'),(3,3,3,'Three Column Section','threeColumnSection',3,'2020-01-17 02:09:28','2020-01-17 02:09:28','f21a27b8-ab14-43b8-af05-24d4621763f4'),(4,3,4,'Youtube Video','youtubeVideo',4,'2020-01-17 02:09:28','2020-01-17 02:09:28','2155962f-040a-49ee-89a7-0ae336e63c66'),(5,3,5,'Text Column With Image','textColumnWithImage',5,'2020-01-17 02:09:28','2020-01-17 02:09:28','f2bb1d94-19a5-4887-9477-af748a8c73b3'),(6,3,6,'Related Entries','relatedEntries',6,'2020-01-17 02:16:49','2020-01-17 02:17:07','7b72b4a5-a7af-46d5-bea7-ff903c778857'),(7,20,7,'Entry Images','entryImages',1,'2020-01-17 02:18:38','2020-01-17 02:23:01','9de65e1a-4f85-4327-be76-df7a397ce18a');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixcontent_contentbuilder`
--

DROP TABLE IF EXISTS `matrixcontent_contentbuilder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_contentbuilder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_generalBody_generalBody` text,
  `field_twoColumnSection_column2` text,
  `field_twoColumnSection_column1` text,
  `field_threeColumnSection_column1` text,
  `field_threeColumnSection_column2` text,
  `field_threeColumnSection_column3` text,
  `field_youtubeVideo_youtubeVideoId` text,
  `field_textColumnWithImage_imagePosition` varchar(255) DEFAULT NULL,
  `field_textColumnWithImage_imageWidth` varchar(255) DEFAULT NULL,
  `field_textColumnWithImage_imageContent` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_contentbuilder_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_contentbuilder_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_contentbuilder_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_contentbuilder_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixcontent_contentbuilder`
--

LOCK TABLES `matrixcontent_contentbuilder` WRITE;
/*!40000 ALTER TABLE `matrixcontent_contentbuilder` DISABLE KEYS */;
/*!40000 ALTER TABLE `matrixcontent_contentbuilder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixcontent_entryimages`
--

DROP TABLE IF EXISTS `matrixcontent_entryimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_entryimages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_entryimages_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_entryimages_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_entryimages_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_entryimages_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixcontent_entryimages`
--

LOCK TABLES `matrixcontent_entryimages` WRITE;
/*!40000 ALTER TABLE `matrixcontent_entryimages` DISABLE KEYS */;
INSERT INTO `matrixcontent_entryimages` VALUES (1,3,1,'2020-01-17 02:21:57','2020-01-17 02:21:57','3de69877-6509-4aac-8fcc-d1b0e85d883e'),(2,5,1,'2020-01-17 02:23:50','2020-01-17 02:23:50','3c32bfc6-4370-444f-8012-c3f56d98d5d5'),(3,6,1,'2020-01-17 02:23:53','2020-01-17 02:23:53','9cb3ddf5-134e-425c-8d8f-ac056254e62b'),(4,7,1,'2020-01-17 02:23:57','2020-01-17 02:23:57','96e281d1-c9f8-47e5-a620-f7fe1267c1ec'),(5,8,1,'2020-01-17 02:24:03','2020-01-17 02:24:03','00202be4-945a-4706-a6c1-bda0515499e9'),(6,10,1,'2020-01-17 02:24:21','2020-01-17 02:24:21','6ec68436-4a38-45ad-8222-c09302ca9b6f'),(8,13,1,'2020-01-17 02:24:27','2020-01-17 02:24:27','a5ccc6bd-5398-4380-b05d-f8e84bdbc7f7'),(9,15,1,'2020-01-17 02:24:27','2020-01-17 02:24:27','3fd318d9-ccc2-4165-8cfb-695b8e7d35bb');
/*!40000 ALTER TABLE `matrixcontent_entryimages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','a43c5883-3fa7-460c-90c4-158e3a7ba256'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','ac751adf-fe24-477d-9a40-64054f756233'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','272c684c-4333-4424-9a67-7212c0a16c05'),(4,NULL,'app','m150403_184533_field_version','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','f18aaf33-d005-49ff-8fc5-e71e4766f6d4'),(5,NULL,'app','m150403_184729_type_columns','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','729f33fd-e7ce-429d-ba40-b63d68d2b9f7'),(6,NULL,'app','m150403_185142_volumes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','cfa84ccb-d40f-46fc-a2a4-955341160433'),(7,NULL,'app','m150428_231346_userpreferences','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','e8cb3b67-ca92-4e72-97f2-1a2cfd0b5326'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','5868d02d-ae0e-453a-96c6-6619a342fcdc'),(9,NULL,'app','m150617_213829_update_email_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','989627a3-47e4-45c0-ae0a-a837d4c98c4b'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','c106edea-e075-48b7-9b07-57ea04d8d52b'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','1f22b663-4a14-48d4-b2e5-0bae882ea275'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','7111f2dd-f585-4123-a402-76a377e19c5d'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','32411661-5028-4baa-a308-ae147f0d5aea'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','7470080f-b9b6-4708-88d2-4eb20d9a7ec8'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','5dbb8ce9-04a1-41a4-9ab2-bb4f1b174de4'),(16,NULL,'app','m151209_000000_move_logo','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b74e54ef-f143-421f-89b9-8c4139182ea5'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','2ea375da-e4bc-4e0d-8e1c-a797286adc4c'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','4fc8ff42-de52-4e8e-b1d8-2464f17db985'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','9701cc8c-d1e8-40cf-a211-d0d475ebcfe8'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','caf3b01b-9f9a-4046-963b-f47ce16350f7'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','62ff9512-4bc6-4d8e-804a-0105de20394e'),(22,NULL,'app','m160727_194637_column_cleanup','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','297cd5e2-856f-43bd-a27d-30290972fb2b'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','c439168b-a260-4fc9-9e9b-50333c45cc78'),(24,NULL,'app','m160807_144858_sites','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','c0d2f32a-6ab6-4099-8ab1-1e8985315e25'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','50fbb370-0026-4143-a12b-c5d33d127825'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','e77cdc81-df5e-4f5a-8925-5d9e31cefa4f'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b37d6d4a-1a4a-44fc-88f3-605571fa2ade'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','7e4f31ca-3552-4373-ad93-3030d2ae49ce'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','8b99c002-0950-4d55-9c6b-b78d2fb6d7fd'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','81218521-dc52-4ae8-a89e-2cfd7f3c9e4a'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','bbf6fbf9-06b5-4566-acdd-290a87be0b02'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','6b45ba52-2c69-4ad0-a5f7-739ab462dc04'),(33,NULL,'app','m161007_130653_update_email_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','6b426348-e104-4edb-a413-a61b8b4c7998'),(34,NULL,'app','m161013_175052_newParentId','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','18b12be0-2f46-4297-826d-7793e2151668'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','cde9a862-dcaa-431a-9016-a2cbdc579c69'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','e4a62f17-082f-4cdb-87e4-24dde0a49e9a'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','cf56582d-08aa-46a6-8a13-9c92d65031fa'),(38,NULL,'app','m161029_124145_email_message_languages','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','09c71b54-6405-4028-adcd-c6cb22cca14e'),(39,NULL,'app','m161108_000000_new_version_format','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','a16f9fae-f69c-4947-8057-c8e677fc9ca6'),(40,NULL,'app','m161109_000000_index_shuffle','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','7ae473ab-4e06-4dd1-ae13-8c0ef04b9af7'),(41,NULL,'app','m161122_185500_no_craft_app','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','a301c7b3-d572-447f-af51-ba5869c743e2'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','921bb438-72c4-4717-bd9f-9e3798de102b'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','767ea7d0-a8e2-4abc-a7d3-8c85ad336970'),(44,NULL,'app','m170114_161144_udates_permission','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','1b50ea62-0546-439f-935d-0888c2943da1'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','101a2e38-930c-498d-a95d-b62b91e3159b'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','1d9ce258-a272-4552-b9c4-8557d5d84453'),(47,NULL,'app','m170206_142126_system_name','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b4ea8bdd-1b1e-4afd-a08b-1614398e82c7'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','db0e1611-e99c-41a2-9f7f-90bd0c940003'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b1c5ec1c-bb78-4756-8682-9f8e5be78deb'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','e6499f7d-3a4a-4d78-8c94-a4d79b84c36f'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','60daa55d-e539-42a0-bca4-48fb08799e3e'),(52,NULL,'app','m170228_171113_system_messages','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','369557ce-729d-45a5-a7a3-2bfacae4aa31'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','a861bd67-3d82-4e71-9ef1-cf56754288ce'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','bcf59b8f-6728-476e-83ed-c471a02088b2'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','5de26810-3733-40ea-a4f9-f1f48daa9a0d'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','17b57845-3600-4519-857a-56aacd92e540'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b1f997fc-3016-4f2e-93ed-f8f128dfaec2'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','4549f418-c48b-4a07-b5f7-ef845622985d'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b0ec67c0-509e-4805-805e-a441ba26986b'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','243b300f-51aa-42c7-a5c7-ab602ffaacd8'),(61,NULL,'app','m170704_134916_sites_tables','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','f935caf1-72be-432b-aceb-a4bce8c488a1'),(62,NULL,'app','m170706_183216_rename_sequences','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','74c66405-f84c-4cea-99c9-b928f3d08f60'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','ac10e03b-1bf1-48b1-b98d-acf436ecd934'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','9ba541d2-83d8-4820-b98b-caf1ff024963'),(65,NULL,'app','m170810_201318_create_queue_table','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','41b6c75e-26e1-4cc1-af3f-9d1da877c932'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b698d469-7b08-4622-82bc-4c98f40ffea2'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','3e92adcd-b325-4ac2-b7a2-5a0d906c5a1d'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','04304673-ffdc-4bfb-a09f-5b9ab4504cd2'),(69,NULL,'app','m171011_214115_site_groups','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','19463888-9e00-40fb-af3c-fccf6d3a6487'),(70,NULL,'app','m171012_151440_primary_site','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','53cc623f-943a-4767-9485-e6296b47930e'),(71,NULL,'app','m171013_142500_transform_interlace','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b1cdb9d7-a8c9-401f-be57-0e4b44c38d6b'),(72,NULL,'app','m171016_092553_drop_position_select','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','78ee7438-a164-4c38-8c46-cdf3b810f8a2'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','a822553f-9a6d-4529-85f7-0324645b3fef'),(74,NULL,'app','m171107_000000_assign_group_permissions','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','959e1d84-ad89-4cd1-87d9-5c4bbadb55e7'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','3f8749b0-f819-43ab-ae70-8b823819c8ba'),(76,NULL,'app','m171126_105927_disabled_plugins','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','fb00e919-cec6-4b49-9621-c34c1366d6d1'),(77,NULL,'app','m171130_214407_craftidtokens_table','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','27a90b2b-3b6b-451f-94c8-08fe5648523f'),(78,NULL,'app','m171202_004225_update_email_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','2e21a213-8d70-4a54-bb78-8a1d316c37fc'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','ef0fc3bc-dfc7-47d6-9d3d-8087d385751e'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','0848fd96-7184-422b-acd8-2d1cf857cbeb'),(81,NULL,'app','m171218_143135_longtext_query_column','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','28f40834-832d-45a9-be4c-f338293e6758'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','c91b276b-ab51-4a27-b72c-8e46a25442e6'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','347d65b7-02ec-44f1-be54-164c4840e227'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','1f523dbf-247e-4275-a62a-a46729fd388f'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','2239608c-62ce-4ec2-b823-e95d27864d70'),(86,NULL,'app','m180128_235202_set_tag_slugs','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','39f5b1ee-f1f2-4575-97a2-727ebf7177ea'),(87,NULL,'app','m180202_185551_fix_focal_points','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','6336fb6f-ab26-4c6c-b1ee-2c75878a147d'),(88,NULL,'app','m180217_172123_tiny_ints','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','7144dc27-74e2-4d7e-a634-f9529847682f'),(89,NULL,'app','m180321_233505_small_ints','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','2d15e077-2554-4097-b5dd-c4607a875d99'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','1401e22b-c919-4102-9f38-1b21dfd113ce'),(91,NULL,'app','m180404_182320_edition_changes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b374807a-a336-46b8-8908-53800b7c800a'),(92,NULL,'app','m180411_102218_fix_db_routes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','55255212-b7fd-40ce-be38-850e37d5fe6a'),(93,NULL,'app','m180416_205628_resourcepaths_table','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b7d67fb3-b8c6-4616-835c-3a2b5812e11c'),(94,NULL,'app','m180418_205713_widget_cleanup','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','7d5f7686-ca49-4401-9cea-858b7e37d4e6'),(95,NULL,'app','m180425_203349_searchable_fields','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','49511174-da84-4869-b596-515b1f808efe'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','c1f174a5-07cc-44d4-8acf-d4f6e48527e6'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','418a8301-dddd-4db3-91b4-00227f386016'),(98,NULL,'app','m180518_173000_permissions_to_uid','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','dfb6ed0b-0bb9-499b-a75f-77fccebb7879'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','5fc3677d-85b5-474f-a88d-54b7cdf981d4'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','99b7fe7d-6e3b-4fc3-a9a0-8ea0068082d6'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','76cd0db4-2c4f-4f58-b454-6c8244e51f8b'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','c985a301-0785-4837-9b4b-a6874d4e1c52'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','0e380ab8-e590-41ae-8c10-cdedded6e042'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','05742ceb-821b-421b-8d9a-6376ed37b3a3'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','082f5cd6-ff6a-48a0-a8bb-a7014d75a78a'),(106,NULL,'app','m180904_112109_permission_changes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','06034fd0-79a7-4042-9322-a383e4360068'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','08fe0a35-73ab-411e-852f-bf9c3d8cab19'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','62c6a948-edec-4d42-882e-9636ce7ae5e4'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','57b551d4-7441-4682-9c41-77e355598e99'),(110,NULL,'app','m181017_225222_system_config_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','77675353-9fc5-4cb6-9b90-a6fe260d762d'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','f25d8e5c-0d90-4177-a70f-e76d2238cbad'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','d0c77b4b-09bf-4bf5-8847-670a7000ff47'),(113,NULL,'app','m181112_203955_sequences_table','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','9c75fe2c-aa53-43ca-8de7-0aa39093a5c4'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','ad605091-272c-48c0-ab4e-280912b6e64b'),(115,NULL,'app','m181128_193942_fix_project_config','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','54606eae-1153-402f-851e-3ede1dd069ac'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','94d200ef-29a8-438c-b7c3-62397326d837'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','a268f9a4-3ae6-4cde-a662-df25870eb005'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','054e491a-9eb3-4a7d-9c33-36bb709f421d'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','3afca7a3-4608-4b9b-a9b8-3883c0f9ea20'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','603367aa-54fb-4157-92b9-582775f923f9'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','06ee95ac-dfc7-4bfd-bab4-e81ccfd53cfe'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b0a1a082-fab5-4a67-835f-8336bd7e1a06'),(123,NULL,'app','m190109_172845_fix_colspan','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','d4abb9bd-3f59-4f62-af99-dd8b3093a4dc'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','aaa6d90d-b0d0-48ca-bd09-48058121f391'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','00f4c7d0-407a-4191-a8af-a0a0f4c0a2ac'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','10ca499f-88e0-4a5d-bc63-c6bfc541e994'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','186fd5b7-3645-4f33-92ab-419fcce80e47'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','41762b07-a6e0-41fe-9dfe-2172b3b96b9a'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','5cc09c65-e76b-4270-878a-aa5423e9b28d'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','916878ad-2687-44e5-beb7-3cd49cbd5727'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','3e4713ce-bff9-442d-bb45-2c51da9f6961'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b9c5bf8c-99c8-4a48-a4d6-d94be269a06f'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','0bf58ebb-a1bc-4fad-9a86-26b0953e8074'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','51d5efa1-b3fd-4ede-948a-b60bb6c20583'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','9f1b2cd6-d990-449a-9e33-43b4f95cff8f'),(136,NULL,'app','m190312_152740_element_revisions','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','54ec4a7d-56d2-4adb-abcc-8d261320a7b4'),(137,NULL,'app','m190327_235137_propagation_method','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','3ff6be3d-04ff-4ba6-95ee-ab178ffdc1d1'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','ef133ea1-9231-4a29-ab12-037e1c8d9901'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','dc823560-624e-4fbd-9ff1-e2411e56e997'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','51b179ff-cb6b-41cb-a2a5-6fea9c237d68'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','e1be8e47-faba-4146-81e8-dd82f01324a1'),(142,NULL,'app','m190504_150349_preview_targets','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','6dd028f2-a5b9-4b96-8015-7231d05bdf2e'),(143,NULL,'app','m190516_184711_job_progress_label','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','325092e0-9db0-42c8-a981-398abd203bdb'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','05ef0c60-121a-4e5c-b08a-623cf97c3ca4'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','9a0ad696-13ca-4c44-88cf-8f7a91e3ebb0'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','d7d82ab9-ae8b-49eb-945c-1317072392b0'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','b5aa69b6-8d6a-412e-afe8-4a036fffce69'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','143771c4-e3ba-4258-b4cc-b45f231e1007'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','92e576a0-4fa2-4536-b06d-ae00a679edae'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','110282f0-7215-4994-aa40-c414eaf23041'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-15 22:40:10','a9b8d810-fdd5-4ec1-b98a-234511fb15e4'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-01-15 22:40:11','2020-01-15 22:40:11','2020-01-15 22:40:11','67afdc88-7f51-4050-9938-c759bf5e9b8f'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-01-15 22:40:11','2020-01-15 22:40:11','2020-01-15 22:40:11','135460a3-e080-4241-bba7-b0ffb6da8944'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-01-15 22:40:11','2020-01-15 22:40:11','2020-01-15 22:40:11','89d2d6a6-a5df-41dd-b667-e6c46b1bf027'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-01-15 22:40:11','2020-01-15 22:40:11','2020-01-15 22:40:11','ecb3842e-7fdf-4858-8afe-ddc61d3de042'),(156,1,'plugin','m180430_204710_remove_old_plugins','2020-01-17 02:05:49','2020-01-17 02:05:49','2020-01-17 02:05:49','498c3608-c325-4cb8-910b-473bac324aa5'),(157,1,'plugin','Install','2020-01-17 02:05:49','2020-01-17 02:05:49','2020-01-17 02:05:49','1ac7c37b-8639-4936-8d96-e497a9820d9a'),(158,1,'plugin','m190225_003922_split_cleanup_html_settings','2020-01-17 02:05:49','2020-01-17 02:05:49','2020-01-17 02:05:49','1ceaaa49-741e-408b-a5d1-97dfd8cf7ec9');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES (1,'redactor','2.4.0','2.3.0','unknown',NULL,'2020-01-17 02:05:49','2020-01-17 02:05:49','2020-01-17 02:11:01','3fda4d31-ef07-430a-b5d7-f237fb80bb25'),(2,'width-fieldtype','1.0.6','1.0.0','unknown',NULL,'2020-01-17 02:09:59','2020-01-17 02:09:59','2020-01-17 02:11:01','201c9ed4-e030-4e13-b052-84f61966b6eb'),(3,'position-fieldtype','1.0.14','1.0.0','unknown',NULL,'2020-01-17 02:10:42','2020-01-17 02:10:42','2020-01-17 02:11:01','5a3856f8-d1d6-4a39-acd6-37517bee3a36');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
INSERT INTO `relations` VALUES (3,15,12,NULL,9,1,'2020-01-17 02:24:27','2020-01-17 02:24:27','af60e497-1d8f-43dc-a60e-0ffe62d15da9'),(4,15,14,NULL,9,1,'2020-01-17 02:24:27','2020-01-17 02:24:27','d4d0c0ee-06e1-4cb1-ad3b-958fbada38b2');
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
INSERT INTO `resourcepaths` VALUES ('13e200ce','@app/web/assets/updateswidget/dist'),('16f835b','@lib/axios'),('1d616b7f','@rias/widthfieldtype/assetbundles/widthfieldtype/dist'),('1d70ac0f','@app/web/assets/craftsupport/dist'),('2b2d2806','@app/web/assets/pluginstore/dist'),('2c84202e','@lib/vue'),('2d5842a0','@app/web/assets/recententries/dist'),('3015652d','@app/web/assets/cp/dist'),('342b7053','@app/web/assets/login/dist'),('3b752f1','@app/web/assets/updater/dist'),('3c6a051f','@vendor/craftcms/redactor/lib/redactor-plugins/fullscreen'),('451158b7','@lib/velocity'),('490e2e93','@app/web/assets/feed/dist'),('549eafca','@bower/jquery/dist'),('5936f75f','@lib/jquery.payment'),('5b4449e3','@app/web/assets/tablesettings/dist'),('5e044a0','@app/web/assets/installer/dist'),('78c47afc','@app/web/assets/matrixsettings/dist'),('7b0e043f','@lib/element-resize-detector'),('81bab86f','@vendor/craftcms/redactor/lib/redactor'),('831eabfd','@craft/web/assets/pluginstore/dist'),('833e1d91','@rias/positionfieldtype/assetbundles/positionfieldtype/dist'),('8626fa43','@lib/xregexp'),('8a659b80','@craft/web/assets/cp/dist'),('8c4abec9','@lib/selectize'),('a7624620','@craft/web/assets/updater/dist'),('b3ffff9','@vendor/craftcms/redactor/lib/redactor-plugins/video'),('b9d9a236','@lib/timepicker'),('bb8c312','@lib/jquery-ui'),('bbecad4a','@app/web/assets/editsection/dist'),('c0dc92b3','@lib/fileupload'),('d3bee961','@app/web/assets/editentry/dist'),('d65684e0','@rias/widthfieldtype/assetbundles/widthfieldtype/dist/img'),('d691b31c','@lib/d3'),('d834934d','@lib/picturefill'),('dc9ccb55','@app/web/assets/matrix/dist'),('dd16a506','@lib/prismjs'),('df90af8f','@lib/jquery-touch-events'),('e52ca49a','@lib/garnishjs'),('f06a70a4','@lib/fabric'),('f3182b61','@app/web/assets/dashboard/dist'),('f47f052f','@app/web/assets/fields/dist'),('fce025ef','@craft/redactor/assets/field/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` VALUES (1,12,1,1,NULL);
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' nmann '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' nmann4789 gmail com '),(1,'slug',0,1,''),(9,'slug',0,1,' test category '),(9,'title',0,1,' test category '),(12,'slug',0,1,' test blog 1 '),(12,'title',0,1,' test blog 1 '),(12,'field',2,1,' test blog title override '),(12,'field',1,1,' this will be used on the blog feed page and as the meta description for the article '),(12,'field',20,1,''),(12,'field',3,1,''),(12,'field',15,1,' test category '),(12,'field',17,1,' 1 '),(12,'field',18,1,''),(12,'field',16,1,' 1 '),(13,'slug',0,1,''),(13,'field',21,1,''),(13,'field',23,1,'');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,NULL,'Blog','blog','channel',1,'all',NULL,'2020-01-17 02:01:14','2020-01-17 02:19:27',NULL,'242f586b-2bf7-4bf3-9b50-dea8f1102019');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'blog/{slug}','',1,'2020-01-17 02:01:14','2020-01-17 02:19:27','3bb4dc22-b802-4609-965f-a83c5ad729aa');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,1,'YfpyfAuMiPKtOFv9Ts2u79o4fYtZDZJvPZfVE2_q0lXw1vQ97A-57sGrfB1mH_c6a1PK6X9dRA3yfqBw3cNYH7jRc9IWJy8N5twG','2020-01-15 22:40:10','2020-01-15 22:40:17','2bff242d-a001-4265-a219-fff0eca5a512');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
INSERT INTO `sitegroups` VALUES (1,'Bowery Capital','2020-01-15 22:40:09','2020-01-15 22:40:09',NULL,'aaa3119a-1413-4b14-a339-285667143c13');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,1,1,'Bowery Capital','default','en-US',1,'$DEFAULT_SITE_URL',1,'2020-01-15 22:40:09','2020-01-15 22:40:09',NULL,'6f9e97f6-4f67-41a1-8239-60a02c64fb29');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
INSERT INTO `structureelements` VALUES (1,1,NULL,1,1,4,0,'2020-01-17 02:24:19','2020-01-17 02:24:19','b129867f-3d42-465e-8566-3ab3ec6ec4a4'),(2,1,9,1,2,3,1,'2020-01-17 02:24:19','2020-01-17 02:24:19','ea55b1ba-8c75-4cb5-bbf3-ef976f2d7d1f');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
INSERT INTO `structures` VALUES (1,NULL,'2020-01-17 02:12:51','2020-01-17 02:12:51',NULL,'7ed3da8d-cee2-4001-8e98-b0f1319a060c');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecacheelements`
--

LOCK TABLES `templatecacheelements` WRITE;
/*!40000 ALTER TABLE `templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecaches`
--

LOCK TABLES `templatecaches` WRITE;
/*!40000 ALTER TABLE `templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'nmann',NULL,NULL,NULL,'nmann4789@gmail.com','$2y$13$5JunJ0PLHijiCQf4ZlSdnedg69bh1utnBipFLmNBfxvrbdGaAJ.pm',1,0,0,0,'2020-01-17 15:57:03',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-01-15 22:40:10','2020-01-15 22:40:10','2020-01-17 15:57:03','92bfda96-c9d9-4728-896d-9d7f941ff465');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Uploaded Images','','2020-01-17 02:20:19','2020-01-17 02:20:19','65dc4ea9-e6be-4d5a-9046-fb17b35cc28a'),(2,NULL,NULL,'Temporary source',NULL,'2020-01-17 02:21:53','2020-01-17 02:21:53','b5e77ab2-545c-4654-b0ba-3011f1e2ebbe'),(3,2,NULL,'user_1','user_1/','2020-01-17 02:21:53','2020-01-17 02:21:53','5b2edcc0-9201-4935-914f-3f4766c107e8');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
INSERT INTO `volumes` VALUES (1,NULL,'Uploaded Images','uploadedImages','craft\\volumes\\Local',1,'@web','{\"path\":\"/template-img\"}',1,'2020-01-17 02:20:19','2020-01-17 02:20:19',NULL,'ec9122e7-d1e3-491c-b413-dec803a1603a');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-01-15 22:40:12','2020-01-15 22:40:12','abb6beb9-cd47-4977-a97b-5adcbbd6c127'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-01-15 22:40:12','2020-01-15 22:40:12','5dee3dab-0e3d-4704-885d-c47d88e7c0e3'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-01-15 22:40:12','2020-01-15 22:40:12','79dd4e66-d5ad-4f16-a298-2c12036505e0'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-01-15 22:40:12','2020-01-15 22:40:12','6cc5d4cd-37cf-42dd-bf4f-27910374af58');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-21 17:51:57
