-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le :  ven. 24 mai 2019 à 02:17
-- Version du serveur :  10.3.15-MariaDB
-- Version de PHP :  7.2.18

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `template`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresses`
--

DROP TABLE IF EXISTS `adresses`;
CREATE TABLE `adresses` (
  `noAdresse` int(11) UNSIGNED NOT NULL,
  `adresseAdresse` varchar(255) NOT NULL,
  `codePostalAdresse` varchar(255) NOT NULL,
  `villeAdresse` varchar(255) NOT NULL,
  `provinceAdresse` varchar(255) NOT NULL,
  `noPays` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Déchargement des données de la table `adresses`
--

INSERT INTO `adresses` (`noAdresse`, `adresseAdresse`, `codePostalAdresse`, `villeAdresse`, `provinceAdresse`, `noPays`) VALUES
(1, '', '', '', '', 0),
(2, '', '', '', '', 42);

-- --------------------------------------------------------

--
-- Structure de la table `demandesInformations`
--

DROP TABLE IF EXISTS `demandesInformations`;
CREATE TABLE `demandesInformations` (
  `noDemandeInformation` int(10) UNSIGNED NOT NULL,
  `prenomDemandeInformation` varchar(255) NOT NULL,
  `nomDemandeInformation` varchar(255) NOT NULL,
  `courrielDemandeInformation` varchar(255) NOT NULL,
  `telephoneDemandeInformation` varchar(255) NOT NULL,
  `dateDemandeInformation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `fichiers`
--

DROP TABLE IF EXISTS `fichiers`;
CREATE TABLE `fichiers` (
  `noFichier` int(10) UNSIGNED NOT NULL,
  `nomOriginalFichier` varchar(255) NOT NULL,
  `nomTmpFichier` varchar(255) NOT NULL,
  `pesanteurFichier` varchar(255) NOT NULL,
  `typeFichier` varchar(255) NOT NULL,
  `noUsager` int(10) UNSIGNED NOT NULL,
  `creationFichier` datetime NOT NULL,
  `confirmerFichier` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


-- --------------------------------------------------------

--
-- Structure de la table `fichiersLangues`
--

DROP TABLE IF EXISTS `fichiersLangues`;
CREATE TABLE `fichiersLangues` (
  `noFichier` int(10) UNSIGNED NOT NULL,
  `noLangue` int(10) UNSIGNED NOT NULL,
  `titreFichierLangue` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `fichiersNonAutorises`
--

DROP TABLE IF EXISTS `fichiersNonAutorises`;
CREATE TABLE `fichiersNonAutorises` (
  `noFichierNonAutorise` int(10) UNSIGNED NOT NULL,
  `nomFichierNonAutorise` varchar(255) NOT NULL,
  `typeFichierNonAutorise` varchar(255) NOT NULL,
  `dateFichierNonAutorise` datetime NOT NULL,
  `noUsager` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `groupes`
--

DROP TABLE IF EXISTS `groupes`;
CREATE TABLE `groupes` (
  `noGroupe` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `groupes`
--

INSERT INTO `groupes` (`noGroupe`) VALUES
(1);

-- --------------------------------------------------------

--
-- Structure de la table `groupesAvatar`
--

DROP TABLE IF EXISTS `groupesAvatar`;
CREATE TABLE `groupesAvatar` (
  `noFichier` int(10) UNSIGNED NOT NULL,
  `positionGroupeAvatar` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `groupesAvatarUsager`
--

DROP TABLE IF EXISTS `groupesAvatarUsager`;
CREATE TABLE `groupesAvatarUsager` (
  `noFichier` int(10) UNSIGNED NOT NULL,
  `noUsager` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `groupesLangues`
--

DROP TABLE IF EXISTS `groupesLangues`;
CREATE TABLE `groupesLangues` (
  `noGroupe` int(10) UNSIGNED NOT NULL,
  `noLangue` int(10) UNSIGNED NOT NULL,
  `titreGroupeLangue` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `groupesLangues`
--

INSERT INTO `groupesLangues` (`noGroupe`, `noLangue`, `titreGroupeLangue`) VALUES
(1, 1, 'Générale'),
(1, 2, 'General');

-- --------------------------------------------------------

--
-- Structure de la table `groupesUsagers`
--

DROP TABLE IF EXISTS `groupesUsagers`;
CREATE TABLE `groupesUsagers` (
  `noGroupe` int(10) UNSIGNED NOT NULL,
  `noUsager` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `groupesUsagers`
--

INSERT INTO `groupesUsagers` (`noGroupe`, `noUsager`) VALUES
(1, 1),
(1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `groupesVideos`
--

DROP TABLE IF EXISTS `groupesVideos`;
CREATE TABLE `groupesVideos` (
  `noVideo` int(10) UNSIGNED NOT NULL,
  `noGroupe` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `groupesVideos`
--

INSERT INTO `groupesVideos` (`noVideo`, `noGroupe`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `pages`
--

DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `noPage` int(10) UNSIGNED NOT NULL,
  `modulePage` varchar(255) NOT NULL,
  `actifPage` int(10) UNSIGNED NOT NULL,
  `micrositePage` int(10) UNSIGNED NOT NULL,
  `pageParentPage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Déchargement des données de la table `pages`
--

INSERT INTO `pages` (`noPage`, `modulePage`, `actifPage`, `micrositePage`, `pageParentPage`) VALUES
(1, 'usagers', 1, 2, 0),
(32, 'usagers', 1, 2, 0),
(64, 'accueil', 1, 2, 0),
(65, 'fichiers', 1, 2, 200),
(128, 'accueil', 1, 1, 0),
(200, '', 1, 2, 0),
(255, 'demandesInformations', 1, 2, 200),
(256, '', 1, 2, 0),
(257, 'pages', 1, 2, 256),
(258, 'usagers', 1, 2, 256),
(259, 'videos', 1, 2, 200);

-- --------------------------------------------------------

--
-- Structure de la table `pagesLangues`
--

DROP TABLE IF EXISTS `pagesLangues`;
CREATE TABLE `pagesLangues` (
  `noPage` int(10) UNSIGNED NOT NULL,
  `noLangue` int(10) UNSIGNED NOT NULL,
  `titrePageLangue` varchar(255) NOT NULL,
  `repertoirePageLangue` varchar(255) NOT NULL,
  `descriptionPageLangue` longtext NOT NULL,
  `titreIndexationPageLangue` varchar(255) NOT NULL,
  `descriptionIndexationPageLangue` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `pagesLangues`
--

INSERT INTO `pagesLangues` (`noPage`, `noLangue`, `titrePageLangue`, `repertoirePageLangue`, `descriptionPageLangue`, `titreIndexationPageLangue`, `descriptionIndexationPageLangue`) VALUES
(1, 1, 'Usagers', 'usagers', '', '', ''),
(1, 2, 'Users', 'Users', '', '', ''),
(32, 1, 'Connexion', 'connexion', '', '', ''),
(32, 2, 'Login', 'login', '', '', ''),
(64, 1, 'Accueil', 'accueil', '', '', ''),
(64, 2, 'Home', 'home', '', '', ''),
(65, 1, 'Bibliothèque', 'bibliotheque', '', '', ''),
(65, 2, 'Librairy', 'librairy', '', '', ''),
(128, 1, 'Accueil', 'accueil', '', '', ''),
(128, 2, 'Home', 'home', '', '', ''),
(200, 1, 'Contenu', 'contenu', '', '', ''),
(200, 2, 'Content', 'content', '', '', ''),
(255, 1, 'Demandes d\'information', 'demande-d-information', '', '', ''),
(255, 2, 'Requests', 'requests', '', '', ''),
(256, 1, 'Système', 'systeme', '', '', ''),
(256, 2, 'System', 'system', '', '', ''),
(257, 1, 'Pages', 'pages', '', '', ''),
(257, 2, 'Pages', 'pages', '', '', ''),
(258, 1, 'Usagers', 'usagers', '', '', ''),
(258, 2, 'Users', 'users', '', '', ''),
(259, 1, 'Vidéos', 'videos', '', '', ''),
(259, 2, 'Videos', 'videos', '', '', '');

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE `pays` (
  `noPays` int(10) UNSIGNED NOT NULL,
  `codePays` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`noPays`, `codePays`) VALUES
(9, 'AD'),
(228, 'AE'),
(5, 'AF'),
(13, 'AG'),
(11, 'AI'),
(6, 'AL'),
(15, 'AM'),
(155, 'AN'),
(10, 'AO'),
(12, 'AQ'),
(14, 'AR'),
(8, 'AS'),
(18, 'AT'),
(17, 'AU'),
(16, 'AW'),
(19, 'AZ'),
(31, 'BA'),
(23, 'BB'),
(22, 'BD'),
(25, 'BE'),
(38, 'BF'),
(37, 'BG'),
(21, 'BH'),
(39, 'BI'),
(27, 'BJ'),
(28, 'BM'),
(36, 'BN'),
(30, 'BO'),
(34, 'BR'),
(20, 'BS'),
(29, 'BT'),
(33, 'BV'),
(32, 'BW'),
(24, 'BY'),
(26, 'BZ'),
(42, 'CA'),
(50, 'CC'),
(54, 'CD'),
(45, 'CF'),
(53, 'CG'),
(210, 'CH'),
(57, 'CI'),
(55, 'CK'),
(47, 'CL'),
(41, 'CM'),
(48, 'CN'),
(51, 'CO'),
(56, 'CR'),
(193, 'CS'),
(59, 'CU'),
(43, 'CV'),
(49, 'CX'),
(60, 'CY'),
(61, 'CZ'),
(84, 'DE'),
(63, 'DJ'),
(62, 'DK'),
(64, 'DM'),
(65, 'DO'),
(7, 'DZ'),
(66, 'EC'),
(71, 'EE'),
(67, 'EG'),
(240, 'EH'),
(70, 'ER'),
(203, 'ES'),
(72, 'ET'),
(76, 'FI'),
(75, 'FJ'),
(73, 'FK'),
(143, 'FM'),
(74, 'FO'),
(77, 'FR'),
(81, 'GA'),
(229, 'GB'),
(89, 'GD'),
(83, 'GE'),
(78, 'GF'),
(85, 'GH'),
(86, 'GI'),
(88, 'GL'),
(82, 'GM'),
(93, 'GN'),
(90, 'GP'),
(69, 'GQ'),
(87, 'GR'),
(202, 'GS'),
(92, 'GT'),
(91, 'GU'),
(94, 'GW'),
(95, 'GY'),
(100, 'HK'),
(97, 'HM'),
(99, 'HN'),
(58, 'HR'),
(96, 'HT'),
(101, 'HU'),
(104, 'ID'),
(107, 'IE'),
(108, 'IL'),
(103, 'IN'),
(35, 'IO'),
(106, 'IQ'),
(105, 'IR'),
(102, 'IS'),
(109, 'IT'),
(110, 'JM'),
(112, 'JO'),
(111, 'JP'),
(114, 'KE'),
(119, 'KG'),
(40, 'KH'),
(115, 'KI'),
(52, 'KM'),
(184, 'KN'),
(116, 'KP'),
(117, 'KR'),
(118, 'KW'),
(44, 'KY'),
(113, 'KZ'),
(120, 'LA'),
(122, 'LB'),
(185, 'LC'),
(126, 'LI'),
(204, 'LK'),
(124, 'LR'),
(123, 'LS'),
(127, 'LT'),
(128, 'LU'),
(121, 'LV'),
(125, 'LY'),
(148, 'MA'),
(145, 'MC'),
(144, 'MD'),
(131, 'MG'),
(137, 'MH'),
(130, 'MK'),
(135, 'ML'),
(150, 'MM'),
(146, 'MN'),
(129, 'MO'),
(163, 'MP'),
(138, 'MQ'),
(139, 'MR'),
(147, 'MS'),
(136, 'MT'),
(140, 'MU'),
(134, 'MV'),
(132, 'MW'),
(142, 'MX'),
(133, 'MY'),
(149, 'MZ'),
(151, 'NA'),
(156, 'NC'),
(159, 'NE'),
(162, 'NF'),
(160, 'NG'),
(158, 'NI'),
(154, 'NL'),
(164, 'NO'),
(153, 'NP'),
(152, 'NR'),
(161, 'NU'),
(157, 'NZ'),
(165, 'OM'),
(169, 'PA'),
(172, 'PE'),
(79, 'PF'),
(170, 'PG'),
(173, 'PH'),
(166, 'PK'),
(175, 'PL'),
(186, 'PM'),
(174, 'PN'),
(177, 'PR'),
(168, 'PS'),
(176, 'PT'),
(167, 'PW'),
(171, 'PY'),
(178, 'QA'),
(179, 'RE'),
(180, 'RO'),
(181, 'RU'),
(182, 'RW'),
(191, 'SA'),
(199, 'SB'),
(194, 'SC'),
(205, 'SD'),
(209, 'SE'),
(196, 'SG'),
(183, 'SH'),
(198, 'SI'),
(207, 'SJ'),
(197, 'SK'),
(195, 'SL'),
(189, 'SM'),
(192, 'SN'),
(200, 'SO'),
(206, 'SR'),
(190, 'ST'),
(68, 'SV'),
(211, 'SY'),
(208, 'SZ'),
(224, 'TC'),
(46, 'TD'),
(80, 'TF'),
(217, 'TG'),
(215, 'TH'),
(213, 'TJ'),
(218, 'TK'),
(216, 'TL'),
(223, 'TM'),
(221, 'TN'),
(219, 'TO'),
(222, 'TR'),
(220, 'TT'),
(225, 'TV'),
(212, 'TW'),
(214, 'TZ'),
(227, 'UA'),
(226, 'UG'),
(231, 'UM'),
(230, 'US'),
(232, 'UY'),
(233, 'UZ'),
(98, 'VA'),
(187, 'VC'),
(235, 'VE'),
(237, 'VG'),
(238, 'VI'),
(236, 'VN'),
(234, 'VU'),
(239, 'WF'),
(188, 'WS'),
(241, 'YE'),
(141, 'YT'),
(201, 'ZA'),
(242, 'ZM'),
(243, 'ZW');

-- --------------------------------------------------------

--
-- Structure de la table `paysLangues`
--

DROP TABLE IF EXISTS `paysLangues`;
CREATE TABLE `paysLangues` (
  `noPays` int(11) NOT NULL,
  `noLangue` int(11) NOT NULL,
  `titrePaysLangue` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `paysLangues`
--

INSERT INTO `paysLangues` (`noPays`, `noLangue`, `titrePaysLangue`) VALUES
(5, 1, 'Afghanistan'),
(5, 2, 'Afghanistan'),
(6, 1, 'Albania'),
(6, 2, 'Albania'),
(7, 1, 'Algeria'),
(7, 2, 'Algeria'),
(8, 1, 'American Samoa'),
(8, 2, 'American Samoa'),
(9, 1, 'Andorra'),
(9, 2, 'Andorra'),
(10, 1, 'Angola'),
(10, 2, 'Angola'),
(11, 1, 'Anguilla'),
(11, 2, 'Anguilla'),
(12, 1, 'Antarctica'),
(12, 2, 'Antarctica'),
(13, 1, 'Antigua and Barbuda'),
(13, 2, 'Antigua and Barbuda'),
(14, 1, 'Argentina'),
(14, 2, 'Argentina'),
(15, 1, 'Armenia'),
(15, 2, 'Armenia'),
(16, 1, 'Aruba'),
(16, 2, 'Aruba'),
(17, 1, 'Australia'),
(17, 2, 'Australia'),
(18, 1, 'Austria'),
(18, 2, 'Austria'),
(19, 1, 'Azerbaijan'),
(19, 2, 'Azerbaijan'),
(20, 1, 'Bahamas'),
(20, 2, 'Bahamas'),
(21, 1, 'Bahrain'),
(21, 2, 'Bahrain'),
(22, 1, 'Bangladesh'),
(22, 2, 'Bangladesh'),
(23, 1, 'Barbados'),
(23, 2, 'Barbados'),
(24, 1, 'Belarus'),
(24, 2, 'Belarus'),
(25, 1, 'Belgium'),
(25, 2, 'Belgium'),
(26, 1, 'Belize'),
(26, 2, 'Belize'),
(27, 1, 'Benin'),
(27, 2, 'Benin'),
(28, 1, 'Bermuda'),
(28, 2, 'Bermuda'),
(29, 1, 'Bhutan'),
(29, 2, 'Bhutan'),
(30, 1, 'Bolivia'),
(30, 2, 'Bolivia'),
(31, 1, 'Bosnia and Herzegovina'),
(31, 2, 'Bosnia and Herzegovina'),
(32, 1, 'Botswana'),
(32, 2, 'Botswana'),
(33, 1, 'Bouvet Island'),
(33, 2, 'Bouvet Island'),
(34, 1, 'Brazil'),
(34, 2, 'Brazil'),
(35, 1, 'British Indian Ocean Territory'),
(35, 2, 'British Indian Ocean Territory'),
(36, 1, 'Brunei Darussalam'),
(36, 2, 'Brunei Darussalam'),
(37, 1, 'Bulgaria'),
(37, 2, 'Bulgaria'),
(38, 1, 'Burkina Faso'),
(38, 2, 'Burkina Faso'),
(39, 1, 'Burundi'),
(39, 2, 'Burundi'),
(40, 1, 'Cambodia'),
(40, 2, 'Cambodia'),
(41, 1, 'Cameroon'),
(41, 2, 'Cameroon'),
(42, 1, 'Canada'),
(42, 2, 'Canada'),
(43, 1, 'Cape Verde'),
(43, 2, 'Cape Verde'),
(44, 1, 'Cayman Islands'),
(44, 2, 'Cayman Islands'),
(45, 1, 'Central African Republic'),
(45, 2, 'Central African Republic'),
(46, 1, 'Chad'),
(46, 2, 'Chad'),
(47, 1, 'Chile'),
(47, 2, 'Chile'),
(48, 1, 'China'),
(48, 2, 'China'),
(49, 1, 'Christmas Island'),
(49, 2, 'Christmas Island'),
(50, 1, 'Cocos (Keeling) Islands'),
(50, 2, 'Cocos (Keeling) Islands'),
(51, 1, 'Colombia'),
(51, 2, 'Colombia'),
(52, 1, 'Comoros'),
(52, 2, 'Comoros'),
(53, 1, 'Congo'),
(53, 2, 'Congo'),
(54, 1, 'Congo, the Democratic Republic of the'),
(54, 2, 'Congo, the Democratic Republic of the'),
(55, 1, 'Cook Islands'),
(55, 2, 'Cook Islands'),
(56, 1, 'Costa Rica'),
(56, 2, 'Costa Rica'),
(57, 1, 'Cote D\'Ivoire'),
(57, 2, 'Cote D\'Ivoire'),
(58, 1, 'Croatia'),
(58, 2, 'Croatia'),
(59, 1, 'Cuba'),
(59, 2, 'Cuba'),
(60, 1, 'Cyprus'),
(60, 2, 'Cyprus'),
(61, 1, 'Czech Republic'),
(61, 2, 'Czech Republic'),
(62, 1, 'Denmark'),
(62, 2, 'Denmark'),
(63, 1, 'Djibouti'),
(63, 2, 'Djibouti'),
(64, 1, 'Dominica'),
(64, 2, 'Dominica'),
(65, 1, 'Dominican Republic'),
(65, 2, 'Dominican Republic'),
(66, 1, 'Ecuador'),
(66, 2, 'Ecuador'),
(67, 1, 'Egypt'),
(67, 2, 'Egypt'),
(68, 1, 'El Salvador'),
(68, 2, 'El Salvador'),
(69, 1, 'Equatorial Guinea'),
(69, 2, 'Equatorial Guinea'),
(70, 1, 'Eritrea'),
(70, 2, 'Eritrea'),
(71, 1, 'Estonia'),
(71, 2, 'Estonia'),
(72, 1, 'Ethiopia'),
(72, 2, 'Ethiopia'),
(73, 1, 'Falkland Islands (Malvinas)'),
(73, 2, 'Falkland Islands (Malvinas)'),
(74, 1, 'Faroe Islands'),
(74, 2, 'Faroe Islands'),
(75, 1, 'Fiji'),
(75, 2, 'Fiji'),
(76, 1, 'Finland'),
(76, 2, 'Finland'),
(77, 1, 'France'),
(77, 2, 'France'),
(78, 1, 'French Guiana'),
(78, 2, 'French Guiana'),
(79, 1, 'French Polynesia'),
(79, 2, 'French Polynesia'),
(80, 1, 'French Southern Territories'),
(80, 2, 'French Southern Territories'),
(81, 1, 'Gabon'),
(81, 2, 'Gabon'),
(82, 1, 'Gambia'),
(82, 2, 'Gambia'),
(83, 1, 'Georgia'),
(83, 2, 'Georgia'),
(84, 1, 'Germany'),
(84, 2, 'Germany'),
(85, 1, 'Ghana'),
(85, 2, 'Ghana'),
(86, 1, 'Gibraltar'),
(86, 2, 'Gibraltar'),
(87, 1, 'Greece'),
(87, 2, 'Greece'),
(88, 1, 'Greenland'),
(88, 2, 'Greenland'),
(89, 1, 'Grenada'),
(89, 2, 'Grenada'),
(90, 1, 'Guadeloupe'),
(90, 2, 'Guadeloupe'),
(91, 1, 'Guam'),
(91, 2, 'Guam'),
(92, 1, 'Guatemala'),
(92, 2, 'Guatemala'),
(93, 1, 'Guinea'),
(93, 2, 'Guinea'),
(94, 1, 'Guinea-Bissau'),
(94, 2, 'Guinea-Bissau'),
(95, 1, 'Guyana'),
(95, 2, 'Guyana'),
(96, 1, 'Haiti'),
(96, 2, 'Haiti'),
(97, 1, 'Heard Island and Mcdonald Islands'),
(97, 2, 'Heard Island and Mcdonald Islands'),
(98, 1, 'Holy See (Vatican City State)'),
(98, 2, 'Holy See (Vatican City State)'),
(99, 1, 'Honduras'),
(99, 2, 'Honduras'),
(100, 1, 'Hong Kong'),
(100, 2, 'Hong Kong'),
(101, 1, 'Hungary'),
(101, 2, 'Hungary'),
(102, 1, 'Iceland'),
(102, 2, 'Iceland'),
(103, 1, 'India'),
(103, 2, 'India'),
(104, 1, 'Indonesia'),
(104, 2, 'Indonesia'),
(105, 1, 'Iran, Islamic Republic of'),
(105, 2, 'Iran, Islamic Republic of'),
(106, 1, 'Iraq'),
(106, 2, 'Iraq'),
(107, 1, 'Ireland'),
(107, 2, 'Ireland'),
(108, 1, 'Israel'),
(108, 2, 'Israel'),
(109, 1, 'Italy'),
(109, 2, 'Italy'),
(110, 1, 'Jamaica'),
(110, 2, 'Jamaica'),
(111, 1, 'Japan'),
(111, 2, 'Japan'),
(112, 1, 'Jordan'),
(112, 2, 'Jordan'),
(113, 1, 'Kazakhstan'),
(113, 2, 'Kazakhstan'),
(114, 1, 'Kenya'),
(114, 2, 'Kenya'),
(115, 1, 'Kiribati'),
(115, 2, 'Kiribati'),
(116, 1, 'Korea, Democratic People\'s Republic of'),
(116, 2, 'Korea, Democratic People\'s Republic of'),
(117, 1, 'Korea, Republic of'),
(117, 2, 'Korea, Republic of'),
(118, 1, 'Kuwait'),
(118, 2, 'Kuwait'),
(119, 1, 'Kyrgyzstan'),
(119, 2, 'Kyrgyzstan'),
(120, 1, 'Lao People\'s Democratic Republic'),
(120, 2, 'Lao People\'s Democratic Republic'),
(121, 1, 'Latvia'),
(121, 2, 'Latvia'),
(122, 1, 'Lebanon'),
(122, 2, 'Lebanon'),
(123, 1, 'Lesotho'),
(123, 2, 'Lesotho'),
(124, 1, 'Liberia'),
(124, 2, 'Liberia'),
(125, 1, 'Libyan Arab Jamahiriya'),
(125, 2, 'Libyan Arab Jamahiriya'),
(126, 1, 'Liechtenstein'),
(126, 2, 'Liechtenstein'),
(127, 1, 'Lithuania'),
(127, 2, 'Lithuania'),
(128, 1, 'Luxembourg'),
(128, 2, 'Luxembourg'),
(129, 1, 'Macao'),
(129, 2, 'Macao'),
(130, 1, 'Macedonia, the Former Yugoslav Republic of'),
(130, 2, 'Macedonia, the Former Yugoslav Republic of'),
(131, 1, 'Madagascar'),
(131, 2, 'Madagascar'),
(132, 1, 'Malawi'),
(132, 2, 'Malawi'),
(133, 1, 'Malaysia'),
(133, 2, 'Malaysia'),
(134, 1, 'Maldives'),
(134, 2, 'Maldives'),
(135, 1, 'Mali'),
(135, 2, 'Mali'),
(136, 1, 'Malta'),
(136, 2, 'Malta'),
(137, 1, 'Marshall Islands'),
(137, 2, 'Marshall Islands'),
(138, 1, 'Martinique'),
(138, 2, 'Martinique'),
(139, 1, 'Mauritania'),
(139, 2, 'Mauritania'),
(140, 1, 'Mauritius'),
(140, 2, 'Mauritius'),
(141, 1, 'Mayotte'),
(141, 2, 'Mayotte'),
(142, 1, 'Mexico'),
(142, 2, 'Mexico'),
(143, 1, 'Micronesia, Federated States of'),
(143, 2, 'Micronesia, Federated States of'),
(144, 1, 'Moldova, Republic of'),
(144, 2, 'Moldova, Republic of'),
(145, 1, 'Monaco'),
(145, 2, 'Monaco'),
(146, 1, 'Mongolia'),
(146, 2, 'Mongolia'),
(147, 1, 'Montserrat'),
(147, 2, 'Montserrat'),
(148, 1, 'Morocco'),
(148, 2, 'Morocco'),
(149, 1, 'Mozambique'),
(149, 2, 'Mozambique'),
(150, 1, 'Myanmar'),
(150, 2, 'Myanmar'),
(151, 1, 'Namibia'),
(151, 2, 'Namibia'),
(152, 1, 'Nauru'),
(152, 2, 'Nauru'),
(153, 1, 'Nepal'),
(153, 2, 'Nepal'),
(154, 1, 'Netherlands'),
(154, 2, 'Netherlands'),
(155, 1, 'Netherlands Antilles'),
(155, 2, 'Netherlands Antilles'),
(156, 1, 'New Caledonia'),
(156, 2, 'New Caledonia'),
(157, 1, 'New Zealand'),
(157, 2, 'New Zealand'),
(158, 1, 'Nicaragua'),
(158, 2, 'Nicaragua'),
(159, 1, 'Niger'),
(159, 2, 'Niger'),
(160, 1, 'Nigeria'),
(160, 2, 'Nigeria'),
(161, 1, 'Niue'),
(161, 2, 'Niue'),
(162, 1, 'Norfolk Island'),
(162, 2, 'Norfolk Island'),
(163, 1, 'Northern Mariana Islands'),
(163, 2, 'Northern Mariana Islands'),
(164, 1, 'Norway'),
(164, 2, 'Norway'),
(165, 1, 'Oman'),
(165, 2, 'Oman'),
(166, 1, 'Pakistan'),
(166, 2, 'Pakistan'),
(167, 1, 'Palau'),
(167, 2, 'Palau'),
(168, 1, 'Palestinian Territory, Occupied'),
(168, 2, 'Palestinian Territory, Occupied'),
(169, 1, 'Panama'),
(169, 2, 'Panama'),
(170, 1, 'Papua New Guinea'),
(170, 2, 'Papua New Guinea'),
(171, 1, 'Paraguay'),
(171, 2, 'Paraguay'),
(172, 1, 'Peru'),
(172, 2, 'Peru'),
(173, 1, 'Philippines'),
(173, 2, 'Philippines'),
(174, 1, 'Pitcairn'),
(174, 2, 'Pitcairn'),
(175, 1, 'Poland'),
(175, 2, 'Poland'),
(176, 1, 'Portugal'),
(176, 2, 'Portugal'),
(177, 1, 'Puerto Rico'),
(177, 2, 'Puerto Rico'),
(178, 1, 'Qatar'),
(178, 2, 'Qatar'),
(179, 1, 'Reunion'),
(179, 2, 'Reunion'),
(180, 1, 'Romania'),
(180, 2, 'Romania'),
(181, 1, 'Russian Federation'),
(181, 2, 'Russian Federation'),
(182, 1, 'Rwanda'),
(182, 2, 'Rwanda'),
(183, 1, 'Saint Helena'),
(183, 2, 'Saint Helena'),
(184, 1, 'Saint Kitts and Nevis'),
(184, 2, 'Saint Kitts and Nevis'),
(185, 1, 'Saint Lucia'),
(185, 2, 'Saint Lucia'),
(186, 1, 'Saint Pierre and Miquelon'),
(186, 2, 'Saint Pierre and Miquelon'),
(187, 1, 'Saint Vincent and the Grenadines'),
(187, 2, 'Saint Vincent and the Grenadines'),
(188, 1, 'Samoa'),
(188, 2, 'Samoa'),
(189, 1, 'San Marino'),
(189, 2, 'San Marino'),
(190, 1, 'Sao Tome and Principe'),
(190, 2, 'Sao Tome and Principe'),
(191, 1, 'Saudi Arabia'),
(191, 2, 'Saudi Arabia'),
(192, 1, 'Senegal'),
(192, 2, 'Senegal'),
(193, 1, 'Serbia and Montenegro'),
(193, 2, 'Serbia and Montenegro'),
(194, 1, 'Seychelles'),
(194, 2, 'Seychelles'),
(195, 1, 'Sierra Leone'),
(195, 2, 'Sierra Leone'),
(196, 1, 'Singapore'),
(196, 2, 'Singapore'),
(197, 1, 'Slovakia'),
(197, 2, 'Slovakia'),
(198, 1, 'Slovenia'),
(198, 2, 'Slovenia'),
(199, 1, 'Solomon Islands'),
(199, 2, 'Solomon Islands'),
(200, 1, 'Somalia'),
(200, 2, 'Somalia'),
(201, 1, 'South Africa'),
(201, 2, 'South Africa'),
(202, 1, 'South Georgia and the South Sandwich Islands'),
(202, 2, 'South Georgia and the South Sandwich Islands'),
(203, 1, 'Spain'),
(203, 2, 'Spain'),
(204, 1, 'Sri Lanka'),
(204, 2, 'Sri Lanka'),
(205, 1, 'Sudan'),
(205, 2, 'Sudan'),
(206, 1, 'Suriname'),
(206, 2, 'Suriname'),
(207, 1, 'Svalbard and Jan Mayen'),
(207, 2, 'Svalbard and Jan Mayen'),
(208, 1, 'Swaziland'),
(208, 2, 'Swaziland'),
(209, 1, 'Sweden'),
(209, 2, 'Sweden'),
(210, 1, 'Switzerland'),
(210, 2, 'Switzerland'),
(211, 1, 'Syrian Arab Republic'),
(211, 2, 'Syrian Arab Republic'),
(212, 1, 'Taiwan, Province of China'),
(212, 2, 'Taiwan, Province of China'),
(213, 1, 'Tajikistan'),
(213, 2, 'Tajikistan'),
(214, 1, 'Tanzania, United Republic of'),
(214, 2, 'Tanzania, United Republic of'),
(215, 1, 'Thailand'),
(215, 2, 'Thailand'),
(216, 1, 'Timor-Leste'),
(216, 2, 'Timor-Leste'),
(217, 1, 'Togo'),
(217, 2, 'Togo'),
(218, 1, 'Tokelau'),
(218, 2, 'Tokelau'),
(219, 1, 'Tonga'),
(219, 2, 'Tonga'),
(220, 1, 'Trinidad and Tobago'),
(220, 2, 'Trinidad and Tobago'),
(221, 1, 'Tunisia'),
(221, 2, 'Tunisia'),
(222, 1, 'Turkey'),
(222, 2, 'Turkey'),
(223, 1, 'Turkmenistan'),
(223, 2, 'Turkmenistan'),
(224, 1, 'Turks and Caicos Islands'),
(224, 2, 'Turks and Caicos Islands'),
(225, 1, 'Tuvalu'),
(225, 2, 'Tuvalu'),
(226, 1, 'Uganda'),
(226, 2, 'Uganda'),
(227, 1, 'Ukraine'),
(227, 2, 'Ukraine'),
(228, 1, 'United Arab Emirates'),
(228, 2, 'United Arab Emirates'),
(229, 1, 'United Kingdom'),
(229, 2, 'United Kingdom'),
(230, 1, 'United States'),
(230, 2, 'United States'),
(231, 1, 'United States Minor Outlying Islands'),
(231, 2, 'United States Minor Outlying Islands'),
(232, 1, 'Uruguay'),
(232, 2, 'Uruguay'),
(233, 1, 'Uzbekistan'),
(233, 2, 'Uzbekistan'),
(234, 1, 'Vanuatu'),
(234, 2, 'Vanuatu'),
(235, 1, 'Venezuela'),
(235, 2, 'Venezuela'),
(236, 1, 'Viet Nam'),
(236, 2, 'Viet Nam'),
(237, 1, 'Virgin Islands, British'),
(237, 2, 'Virgin Islands, British'),
(238, 1, 'Virgin Islands, U.s.'),
(238, 2, 'Virgin Islands, U.s.'),
(239, 1, 'Wallis and Futuna'),
(239, 2, 'Wallis and Futuna'),
(240, 1, 'Western Sahara'),
(240, 2, 'Western Sahara'),
(241, 1, 'Yemen'),
(241, 2, 'Yemen'),
(242, 1, 'Zambia'),
(242, 2, 'Zambia'),
(243, 1, 'Zimbabwe'),
(243, 2, 'Zimbabwe');

-- --------------------------------------------------------

--
-- Structure de la table `usagers`
--

DROP TABLE IF EXISTS `usagers`;
CREATE TABLE `usagers` (
  `noUsager` int(10) UNSIGNED NOT NULL,
  `actifUsager` int(10) UNSIGNED NOT NULL,
  `adminUsager` int(10) UNSIGNED DEFAULT NULL,
  `prenomUsager` varchar(255) NOT NULL,
  `nomUsager` varchar(255) NOT NULL,
  `noSexe` int(10) UNSIGNED NOT NULL,
  `noAdresse` int(10) UNSIGNED NOT NULL,
  `dateNaissanceUsager` date NOT NULL,
  `courrielUsager` varchar(255) NOT NULL,
  `telephoneUsager` varchar(255) NOT NULL,
  `cellulaireUsager` varchar(255) NOT NULL,
  `motDePasseUsager` varchar(255) DEFAULT NULL,
  `dateConnexionUsager` datetime DEFAULT NULL,
  `hashUsager` varchar(255) DEFAULT NULL,
  `dateHashUsager` datetime DEFAULT NULL,
  `avatarUsager` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Déchargement des données de la table `usagers`
--

INSERT INTO `usagers` (`noUsager`, `actifUsager`, `adminUsager`, `prenomUsager`, `nomUsager`, `noSexe`, `noAdresse`, `dateNaissanceUsager`, `courrielUsager`, `telephoneUsager`, `cellulaireUsager`, `motDePasseUsager`, `dateConnexionUsager`, `hashUsager`, `dateHashUsager`, `avatarUsager`) VALUES
(1, 1, 1, 'Admin', 'System', 0, 1, '2010-01-01', 'admin@localhost.com', '', '', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', 0),
(2, 1, 1, 'Louis-Vincent', 'Fillion Pratte', 1, 2, '1982-07-01', 'spaceham2002@hotmail.com', '418 335-2302', '418 946-3004', '$2y$10$n2rmozSE4q7DYbvCsdyVdujS1/t2yQiS2dh9WxVwaMmxeks5SAcFq', '2019-05-23 17:40:20', '$2y$10$atNmObYMUjjuMbpWiuHcBOmE1QzBP72FexDe0R2DiSSK7E.DOsmAi', '2019-05-17 13:46:23', 13);

-- --------------------------------------------------------

--
-- Structure de la table `usagersParametres`
--

DROP TABLE IF EXISTS `usagersParametres`;
CREATE TABLE `usagersParametres` (
  `noUsager` int(10) UNSIGNED NOT NULL,
  `videoBienvenueUsagerParametre` int(11) NOT NULL,
  `themeUsagerParametre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `usagersParametres`
--

INSERT INTO `usagersParametres` (`noUsager`, `videoBienvenueUsagerParametre`, `themeUsagerParametre`) VALUES
(1, 1, 'dark'),
(2, 4, 'dark');

-- --------------------------------------------------------

--
-- Structure de la table `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos` (
  `noVideo` int(10) UNSIGNED NOT NULL,
  `actifVideo` int(10) UNSIGNED NOT NULL,
  `positionVideo` int(10) UNSIGNED NOT NULL,
  `noUsager` int(10) UNSIGNED NOT NULL,
  `dateAjoutVideo` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Déchargement des données de la table `videos`
--

INSERT INTO `videos` (`noVideo`, `actifVideo`, `positionVideo`, `noUsager`, `dateAjoutVideo`) VALUES
(1, 1, 0, 2, '2019-05-16 17:34:44'),
(2, 1, 0, 2, '2019-05-16 17:42:49'),
(3, 1, 0, 2, '2019-05-16 20:57:29'),
(4, 1, 0, 2, '2019-05-16 21:00:35'),
(9, 1, 0, 2, '2019-05-17 16:50:21'),
(11, 1, 0, 2, '2019-05-23 17:45:11');

-- --------------------------------------------------------

--
-- Structure de la table `videosLangues`
--

DROP TABLE IF EXISTS `videosLangues`;
CREATE TABLE `videosLangues` (
  `noVideo` int(10) UNSIGNED NOT NULL,
  `noLangue` int(10) UNSIGNED NOT NULL,
  `titreVideoLangue` varchar(255) NOT NULL,
  `repertoireVideoLangue` varchar(255) NOT NULL,
  `descriptionVideoLangue` text NOT NULL,
  `urlVideoLangue` varchar(255) NOT NULL,
  `idVideoLangue` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `videosLangues`
--

INSERT INTO `videosLangues` (`noVideo`, `noLangue`, `titreVideoLangue`, `repertoireVideoLangue`, `descriptionVideoLangue`, `urlVideoLangue`, `idVideoLangue`) VALUES
(1, 1, 'AMAZING UPLIFTING TRANCE 2019 JANUARY', 'amazing-uplifting-trance-2019-january', 'This is catchy melodies and big bangers. Its new incredible, uplifting and energetic trance music. Its Uplifting - Deep - Epic - Energetic & Melodic. Subscribe for future updates. Thanks for listening and have a great time.', 'https://www.youtube.com/watch?time_continue=1015&v=VyoGYPDZBSM', 'VyoGYPDZBSM'),
(1, 2, 'AMAZING UPLIFTING TRANCE 2019 JANUARY', 'amazing-uplifting-trance-2019-january', 'This is catchy melodies and big bangers. Its new incredible, uplifting and energetic trance music. Its Uplifting - Deep - Epic - Energetic & Melodic. Subscribe for future updates. Thanks for listening and have a great time.', 'https://www.youtube.com/watch?time_continue=1015&v=VyoGYPDZBSM', 'VyoGYPDZBSM'),
(2, 1, 'Star Wars: The Rise of Skywalker – Teaser', 'star-wars-the-rise-of-skywalker-teaser', 'Every generation has a legend. Watch the brand-new teaser for Star Wars: The Rise of Skywalker.', 'https://www.youtube.com/watch?v=adzYW5DZoWs', 'adzYW5DZoWs'),
(2, 2, 'Star Wars: The Rise of Skywalker – Teaser', 'star-wars-the-rise-of-skywalker-teaser', 'Every generation has a legend. Watch the brand-new teaser for Star Wars: The Rise of Skywalker.', 'https://www.youtube.com/watch?v=adzYW5DZoWs', 'adzYW5DZoWs'),
(3, 1, 'IT CHAPTER TWO - Official Teaser Trailer [HD]', 'it-chapter-two-official-teaser-trailer-hd', 'IT CHAPTER TWO only in theaters September 6, 2019', 'https://www.youtube.com/watch?v=zqUopiAYdRg', 'zqUopiAYdRg'),
(3, 2, 'IT CHAPTER TWO - Official Teaser Trailer [HD]', 'it-chapter-two-official-teaser-trailer-hd', 'IT CHAPTER TWO only in theaters September 6, 2019', 'https://www.youtube.com/watch?v=zqUopiAYdRg', 'zqUopiAYdRg'),
(4, 1, 'Rammstein - Deutschland (Official Video)', 'rammstein-deutschland-official-video', 'New Single / New Album: https://www.rammstein.com', 'https://www.youtube.com/watch?v=NeQM1c-XCDc', 'NeQM1c-XCDc'),
(4, 2, 'Rammstein - Deutschland (Official Video)', 'rammstein-deutschland-official-video', 'New Single / New Album: https://www.rammstein.com', 'https://www.youtube.com/watch?v=NeQM1c-XCDc', 'NeQM1c-XCDc'),
(9, 1, 'John Wick: Chapter 3 - Parabellum (2019 Movie) New Trailer – Keanu Reeves, Halle Berry', 'john-wick-chapter-3-parabellum-2019-movie-new-trailer-keanu-reeves-halle-berry', 'John Wick: Chapter 3 - Parabellum – In theaters May 17, 2019. Starring Keanu Reeves, Halle Berry, Laurence Fishburne, Mark Dacascos, Asia Kate Dillon, Lance Reddick, Saïd Taghmaoui, Jerome Flynn, Jason Mantzoukas, Tobias Segal, Boban Marjanovic, with Anjelica Huston, and Ian McShane.', 'https://www.youtube.com/watch?v=pU8-7BX9uxs', 'pU8-7BX9uxs'),
(9, 2, 'John Wick: Chapter 3 - Parabellum (2019 Movie) New Trailer – Keanu Reeves, Halle Berry', 'john-wick-chapter-3-parabellum-2019-movie-new-trailer-keanu-reeves-halle-berry', 'John Wick: Chapter 3 - Parabellum – In theaters May 17, 2019. Starring Keanu Reeves, Halle Berry, Laurence Fishburne, Mark Dacascos, Asia Kate Dillon, Lance Reddick, Saïd Taghmaoui, Jerome Flynn, Jason Mantzoukas, Tobias Segal, Boban Marjanovic, with Anjelica Huston, and Ian McShane.', 'https://www.youtube.com/watch?v=pU8-7BX9uxs', 'pU8-7BX9uxs'),
(10, 1, 'les premier pas en temp cocariniste', 'les-premier-pas-en-temp-cocariniste', '', 'https://www.youtube.com/watch?v=pYaY5XZGkng', 'pYaY5XZGkng'),
(10, 2, 'Les première fois avec une ocarina', 'les-premiere-fois-avec-une-ocarina', '', 'https://www.youtube.com/watch?v=pYaY5XZGkng', 'pYaY5XZGkng'),
(11, 1, 'Terminator: Dark Fate Teaser Trailer #1 (2019) | Movieclips Trailers', 'terminator-dark-fate-teaser-trailer-1-2019-movieclips-trailers', 'Check out the official Terminator: Dark Fate teaser trailer starring Arnold Schwarzenegger! Let us know what you think in the comments below.', 'https://www.youtube.com/watch?v=RwEr9tOwAbs', 'RwEr9tOwAbs'),
(11, 2, 'Terminator: Dark Fate Teaser Trailer #1 (2019) | Movieclips Trailers', 'terminator-dark-fate-teaser-trailer-1-2019-movieclips-trailers', 'Check out the official Terminator: Dark Fate teaser trailer starring Arnold Schwarzenegger! Let us know what you think in the comments below.', 'https://www.youtube.com/watch?v=RwEr9tOwAbs', 'RwEr9tOwAbs');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adresses`
--
ALTER TABLE `adresses`
  ADD PRIMARY KEY (`noAdresse`);

--
-- Index pour la table `demandesInformations`
--
ALTER TABLE `demandesInformations`
  ADD PRIMARY KEY (`noDemandeInformation`);

--
-- Index pour la table `fichiers`
--
ALTER TABLE `fichiers`
  ADD PRIMARY KEY (`noFichier`);

--
-- Index pour la table `fichiersLangues`
--
ALTER TABLE `fichiersLangues`
  ADD PRIMARY KEY (`noFichier`,`noLangue`);

--
-- Index pour la table `fichiersNonAutorises`
--
ALTER TABLE `fichiersNonAutorises`
  ADD PRIMARY KEY (`noFichierNonAutorise`);

--
-- Index pour la table `groupes`
--
ALTER TABLE `groupes`
  ADD PRIMARY KEY (`noGroupe`);

--
-- Index pour la table `groupesAvatar`
--
ALTER TABLE `groupesAvatar`
  ADD PRIMARY KEY (`noFichier`,`positionGroupeAvatar`);

--
-- Index pour la table `groupesAvatarUsager`
--
ALTER TABLE `groupesAvatarUsager`
  ADD UNIQUE KEY `noUsager` (`noUsager`);

--
-- Index pour la table `groupesLangues`
--
ALTER TABLE `groupesLangues`
  ADD PRIMARY KEY (`noGroupe`,`noLangue`);

--
-- Index pour la table `groupesVideos`
--
ALTER TABLE `groupesVideos`
  ADD PRIMARY KEY (`noVideo`,`noGroupe`);

--
-- Index pour la table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`noPage`);

--
-- Index pour la table `pagesLangues`
--
ALTER TABLE `pagesLangues`
  ADD PRIMARY KEY (`noPage`,`noLangue`),
  ADD KEY `repertoirePageLangue` (`repertoirePageLangue`);

--
-- Index pour la table `pays`
--
ALTER TABLE `pays`
  ADD PRIMARY KEY (`noPays`),
  ADD KEY `abrPays` (`codePays`);

--
-- Index pour la table `paysLangues`
--
ALTER TABLE `paysLangues`
  ADD PRIMARY KEY (`noPays`,`noLangue`),
  ADD KEY `titrePaysLangue` (`titrePaysLangue`);

--
-- Index pour la table `usagers`
--
ALTER TABLE `usagers`
  ADD PRIMARY KEY (`noUsager`);

--
-- Index pour la table `usagersParametres`
--
ALTER TABLE `usagersParametres`
  ADD PRIMARY KEY (`noUsager`);

--
-- Index pour la table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`noVideo`);

--
-- Index pour la table `videosLangues`
--
ALTER TABLE `videosLangues`
  ADD PRIMARY KEY (`noVideo`,`noLangue`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `adresses`
--
ALTER TABLE `adresses`
  MODIFY `noAdresse` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `demandesInformations`
--
ALTER TABLE `demandesInformations`
  MODIFY `noDemandeInformation` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fichiers`
--
ALTER TABLE `fichiers`
  MODIFY `noFichier` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `fichiersNonAutorises`
--
ALTER TABLE `fichiersNonAutorises`
  MODIFY `noFichierNonAutorise` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `groupes`
--
ALTER TABLE `groupes`
  MODIFY `noGroupe` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `pages`
--
ALTER TABLE `pages`
  MODIFY `noPage` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

--
-- AUTO_INCREMENT pour la table `pays`
--
ALTER TABLE `pays`
  MODIFY `noPays` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=244;

--
-- AUTO_INCREMENT pour la table `usagers`
--
ALTER TABLE `usagers`
  MODIFY `noUsager` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `videos`
--
ALTER TABLE `videos`
  MODIFY `noVideo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
