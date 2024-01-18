-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 19 jan. 2024 à 00:35
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `GestionProjet`
--

-- --------------------------------------------------------

--
-- Structure de la table `projet`
--

CREATE TABLE `projet` (
  `id_projet` int(11) NOT NULL,
  `libelle` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `idUser` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `projet`
--

INSERT INTO `projet` (`id_projet`, `libelle`, `description`, `idUser`) VALUES
(1, 'azerty', 'aaaaaa', 'adil123'),
(2, 'zzzz', 'eeeee', 'adil123'),
(3, 'aaa', 'aaa', 'adil123'),
(4, 'azery', 'ssissisiis', 'adil123');

-- --------------------------------------------------------

--
-- Structure de la table `tache`
--

CREATE TABLE `tache` (
  `id_tache` int(11) NOT NULL,
  `id_projet` int(11) NOT NULL,
  `description` text NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `etat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `tache`
--

INSERT INTO `tache` (`id_tache`, `id_projet`, `description`, `date_debut`, `date_fin`, `etat`) VALUES
(8, 1, 'azertyuuaoauaaaa', '2024-01-01', '2024-01-01', 'Done'),
(9, 1, 'sisgsig', '2024-01-01', '2024-01-03', 'Doing'),
(11, 2, 'oonononon', '2024-01-10', '2024-01-18', 'Doing');

-- --------------------------------------------------------

--
-- Structure de la table `tacheuser`
--

CREATE TABLE `tacheuser` (
  `id_tache` int(11) NOT NULL,
  `username` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` varchar(30) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`username`, `nom`, `prenom`, `email`, `password`, `role`) VALUES
('adil123', 'Azzaoui', 'Adil', 'adil@adil.com', 'adil123', 'user'),
('amine123', 'Amine', 'El Ouadi', 'amin@amine.com', 'amin123', 'user'),
('fati', 'amezian', 'fati', 'aa@aa.com', 'fati', 'user'),
('samira', 'Azdad', 'samira', 'samira@sa.com', 'samira', 'user');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `projet`
--
ALTER TABLE `projet`
  ADD PRIMARY KEY (`id_projet`),
  ADD KEY `idUser` (`idUser`);

--
-- Index pour la table `tache`
--
ALTER TABLE `tache`
  ADD PRIMARY KEY (`id_tache`),
  ADD KEY `for_key` (`id_projet`);

--
-- Index pour la table `tacheuser`
--
ALTER TABLE `tacheuser`
  ADD KEY `fktache` (`id_tache`),
  ADD KEY `fkuser` (`username`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `projet`
--
ALTER TABLE `projet`
  MODIFY `id_projet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `tache`
--
ALTER TABLE `tache`
  MODIFY `id_tache` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `projet`
--
ALTER TABLE `projet`
  ADD CONSTRAINT `projet_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`username`);

--
-- Contraintes pour la table `tache`
--
ALTER TABLE `tache`
  ADD CONSTRAINT `for_key` FOREIGN KEY (`id_projet`) REFERENCES `projet` (`id_projet`);

--
-- Contraintes pour la table `tacheuser`
--
ALTER TABLE `tacheuser`
  ADD CONSTRAINT `fktache` FOREIGN KEY (`id_tache`) REFERENCES `tache` (`id_tache`),
  ADD CONSTRAINT `fkuser` FOREIGN KEY (`username`) REFERENCES `user` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
