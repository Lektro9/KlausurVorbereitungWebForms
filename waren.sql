-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Erstellungszeit: 09. Okt 2020 um 09:00
-- Server-Version: 10.1.37-MariaDB
-- PHP-Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `waren`
--
CREATE DATABASE IF NOT EXISTS `waren` DEFAULT CHARACTER SET latin1 COLLATE latin1_german1_ci;
USE `waren`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bestellungen`
--

DROP TABLE IF EXISTS `bestellungen`;
CREATE TABLE IF NOT EXISTS `bestellungen` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Kunde` int(11) NOT NULL,
  `Produkt` int(11) NOT NULL,
  `Menge` int(11) NOT NULL,
  `Datum` text COLLATE latin1_german1_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `kunde` (`Kunde`),
  KEY `produkt` (`Produkt`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

--
-- RELATIONEN DER TABELLE `bestellungen`:
--   `Kunde`
--       `kunden` -> `Kundennummer`
--   `Produkt`
--       `produkte` -> `Artikelnummer`
--

--
-- Daten für Tabelle `bestellungen`
--

INSERT INTO `bestellungen` (`ID`, `Kunde`, `Produkt`, `Menge`, `Datum`) VALUES
(1, 1, 1, 4, '12.10.2020'),
(2, 2, 2, 7, '13.10.2020');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `kunden`
--

DROP TABLE IF EXISTS `kunden`;
CREATE TABLE IF NOT EXISTS `kunden` (
  `Kundennummer` int(11) NOT NULL AUTO_INCREMENT,
  `Name` text COLLATE latin1_german1_ci NOT NULL,
  `Vorname` text COLLATE latin1_german1_ci NOT NULL,
  `Adresse` text COLLATE latin1_german1_ci NOT NULL,
  PRIMARY KEY (`Kundennummer`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

--
-- RELATIONEN DER TABELLE `kunden`:
--

--
-- Daten für Tabelle `kunden`
--

INSERT INTO `kunden` (`Kundennummer`, `Name`, `Vorname`, `Adresse`) VALUES
(1, 'Müller', 'Fritz', 'Holzgasse1, 1234 Musterhausen'),
(2, 'Lehmann', 'Willi', 'Musterweg 12, 23456 Musterdorf');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `produkte`
--

DROP TABLE IF EXISTS `produkte`;
CREATE TABLE IF NOT EXISTS `produkte` (
  `Artikelnummer` int(11) NOT NULL AUTO_INCREMENT,
  `Bezeichnung` text COLLATE latin1_german1_ci NOT NULL,
  `Preis` text COLLATE latin1_german1_ci NOT NULL,
  PRIMARY KEY (`Artikelnummer`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

--
-- RELATIONEN DER TABELLE `produkte`:
--

--
-- Daten für Tabelle `produkte`
--

INSERT INTO `produkte` (`Artikelnummer`, `Bezeichnung`, `Preis`) VALUES
(1, 'Buch', '12,98'),
(2, 'CD', '19,99');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rechnung`
--

DROP TABLE IF EXISTS `rechnung`;
CREATE TABLE IF NOT EXISTS `rechnung` (
  `Rechnungsnummer` int(11) NOT NULL AUTO_INCREMENT,
  `Kunde` int(11) NOT NULL,
  `Rechnungsdatum` text COLLATE latin1_german1_ci NOT NULL,
  `Gesamtpreis` text COLLATE latin1_german1_ci NOT NULL,
  PRIMARY KEY (`Rechnungsnummer`),
  KEY `kundennummer` (`Kunde`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

--
-- RELATIONEN DER TABELLE `rechnung`:
--   `Kunde`
--       `kunden` -> `Kundennummer`
--

--
-- Daten für Tabelle `rechnung`
--

INSERT INTO `rechnung` (`Rechnungsnummer`, `Kunde`, `Rechnungsdatum`, `Gesamtpreis`) VALUES
(1, 1, '1.10.2020', '199,98'),
(2, 2, '1.9.2020', '58,64');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rechnungsposten`
--

DROP TABLE IF EXISTS `rechnungsposten`;
CREATE TABLE IF NOT EXISTS `rechnungsposten` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Rechnungsnr` int(11) NOT NULL,
  `Produkt` int(11) NOT NULL,
  `Menge` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `rpprodukt` (`Produkt`) USING BTREE,
  KEY `rprechnung` (`Rechnungsnr`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

--
-- RELATIONEN DER TABELLE `rechnungsposten`:
--   `Produkt`
--       `produkte` -> `Artikelnummer`
--   `Rechnungsnr`
--       `rechnung` -> `Rechnungsnummer`
--

--
-- Daten für Tabelle `rechnungsposten`
--

INSERT INTO `rechnungsposten` (`ID`, `Rechnungsnr`, `Produkt`, `Menge`) VALUES
(7, 1, 1, 3),
(8, 1, 2, 7),
(9, 2, 1, 5),
(10, 2, 2, 9);

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `bestellungen`
--
ALTER TABLE `bestellungen`
  ADD CONSTRAINT `kunde` FOREIGN KEY (`Kunde`) REFERENCES `kunden` (`Kundennummer`),
  ADD CONSTRAINT `produkt` FOREIGN KEY (`Produkt`) REFERENCES `produkte` (`Artikelnummer`);

--
-- Constraints der Tabelle `rechnung`
--
ALTER TABLE `rechnung`
  ADD CONSTRAINT `kundennummer` FOREIGN KEY (`Kunde`) REFERENCES `kunden` (`Kundennummer`);

--
-- Constraints der Tabelle `rechnungsposten`
--
ALTER TABLE `rechnungsposten`
  ADD CONSTRAINT `rpprodukt` FOREIGN KEY (`Produkt`) REFERENCES `produkte` (`Artikelnummer`),
  ADD CONSTRAINT `rprechnung` FOREIGN KEY (`Rechnungsnr`) REFERENCES `rechnung` (`Rechnungsnummer`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
