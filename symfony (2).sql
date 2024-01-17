-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 27 juil. 2023 à 19:33
-- Version du serveur : 8.0.31
-- Version de PHP : 8.1.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `symfony`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230726091018', '2023-07-26 09:10:37', 125);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `position`
--

DROP TABLE IF EXISTS `position`;
CREATE TABLE IF NOT EXISTS `position` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `position`
--

INSERT INTO `position` (`id`, `label`) VALUES
(1, 'gérant'),
(2, 'commercial'),
(3, 'comptable'),
(4, 'lead dev'),
(5, 'dev'),
(6, 'UI/UX'),
(7, 'Testeur'),
(8, 'Stagiaire');

-- --------------------------------------------------------

--
-- Structure de la table `position_team`
--

DROP TABLE IF EXISTS `position_team`;
CREATE TABLE IF NOT EXISTS `position_team` (
  `position_id` int NOT NULL,
  `team_id` int NOT NULL,
  PRIMARY KEY (`position_id`,`team_id`),
  KEY `IDX_D7788841DD842E46` (`position_id`),
  KEY `IDX_D7788841296CD8AE` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `position_team`
--

INSERT INTO `position_team` (`position_id`, `team_id`) VALUES
(1, 1),
(2, 3),
(3, 4),
(4, 2),
(5, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 8);

-- --------------------------------------------------------

--
-- Structure de la table `team`
--

DROP TABLE IF EXISTS `team`;
CREATE TABLE IF NOT EXISTS `team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cv` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Status` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `team`
--

INSERT INTO `team` (`id`, `firstname`, `lastname`, `photo`, `age`, `adresse`, `tel`, `mail`, `cv`, `parent_id`, `path`, `Status`) VALUES
(1, 'Paul', 'Stone', 'Photo/PStone.jpg', '47', '12 rue de la Paix', '06/09/07/08/20', 'PStone@gmail.com', 'CV_PStone.pdf', NULL, '-1:1', 1),
(2, 'Paul', 'Martin', 'Photo/paul.jpg', '42', '189 rue d\'étratat', '06/08/06/07/19', 'paul@gmail.com', 'CV_Paul.pdf', 1, '-1:1:2', 0),
(3, 'Sylvie', 'Durand', 'Photo/sylvie.jpg', '36', '114 blvd Agute Semba', '06/07/05/06/18', 'sylvie@gmail.com', 'CV_Sylvie.pdf', 1, '-1:1:3', 1),
(4, 'Martine', 'Duck', 'Photo/martine.jpg', '34', '1656 rue de la mort', '06/06/04/05/17', 'martine@gmail.com', 'CV_Martine.pdf', 1, '-1:1:4', 1),
(5, 'Justine', 'Dupont', 'Photo/justine.jpg', '33', '785 rue des herbacés', '06/05/03/04/16', 'justine@gmail.com', 'CV_Justine.pdf', 1, '-1:1:5', 1),
(6, 'Arthur', 'Vincent', 'Photo/arthur.jpg', '35', '5 rue des Lilas', '06/04/02/03/15', 'arthur@gmail.com', 'CV_Arthur.pdf', 1, '-1:1:6', 1),
(7, 'John', 'Deer', 'Photo/john.jpg', '32', '12 av des déportés', '06/03/01/01/12', 'john@gmail.com', 'CV_John.pdf', 1, '-1:1:7', 1),
(8, 'Charly', 'Goose', 'Photo/charly.jpg', '18', '8 avenue du Rhin', '06/02/01/03/10', 'charly@gmail.com', 'CV_Charly.pdf', 5, '-1:1:2:5:8', 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `position_team`
--
ALTER TABLE `position_team`
  ADD CONSTRAINT `FK_D7788841296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D7788841DD842E46` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
