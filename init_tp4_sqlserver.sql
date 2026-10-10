-- =====================================================================
-- TP4 Big Data Engineering - UCAD - Prof. S. Ndiaye
-- SGBD 4/4 : SQL Server 2022 Express - base paiements (table paiements)
-- A executer en tant que sa (authentification SQL activee) :
--   sqlcmd -S localhost -U sa -P VotreMdpSa -i init_tp4_sqlserver.sql
-- (ou copier-coller dans SSMS)
-- PREREQUIS : protocole TCP/IP active (port 1433) + mode mixte
-- =====================================================================
IF DB_ID('ecommerce_paiements') IS NULL
  CREATE DATABASE ecommerce_paiements;
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'spark_user')
  CREATE LOGIN spark_user WITH PASSWORD = 'Ucad2026!', CHECK_POLICY = OFF;
GO
USE ecommerce_paiements;
GO
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'spark_user')
  CREATE USER spark_user FOR LOGIN spark_user;
ALTER ROLE db_datareader ADD MEMBER spark_user;
GO
DROP TABLE IF EXISTS dbo.paiements;
CREATE TABLE dbo.paiements (
  paiement_id     VARCHAR(10) PRIMARY KEY,
  commande_id     VARCHAR(10) NOT NULL,
  moyen_paiement  VARCHAR(30) NOT NULL,
  montant_fcfa    INT         NOT NULL,
  statut_paiement VARCHAR(10) NOT NULL,
  date_paiement   DATE        NOT NULL
);
GO
INSERT INTO dbo.paiements VALUES
  ('PAY01', 'CMD01', 'Orange Money', 85000, 'reussi', '2026-01-06'),
  ('PAY02', 'CMD02', 'Wave', 350000, 'reussi', '2026-01-09'),
  ('PAY03', 'CMD03', 'especes_livraison', 24000, 'reussi', '2026-01-11'),
  ('PAY04', 'CMD04', 'Free Money', 45000, 'reussi', '2026-01-13'),
  ('PAY05', 'CMD05', 'Orange Money', 30000, 'reussi', '2026-01-16'),
  ('PAY06', 'CMD06', 'Wave', 18000, 'reussi', '2026-01-19'),
  ('PAY07', 'CMD08', 'especes_livraison', 16000, 'reussi', '2026-01-23'),
  ('PAY08', 'CMD09', 'Free Money', 28000, 'reussi', '2026-01-26'),
  ('PAY09', 'CMD10', 'Orange Money', 85000, 'reussi', '2026-02-02'),
  ('PAY10', 'CMD11', 'Wave', 22000, 'reussi', '2026-02-04'),
  ('PAY11', 'CMD13', 'carte_bancaire', 350000, 'reussi', '2026-02-09'),
  ('PAY12', 'CMD14', 'especes_livraison', 12000, 'reussi', '2026-02-11'),
  ('PAY13', 'CMD16', 'Orange Money', 15000, 'reussi', '2026-02-15'),
  ('PAY14', 'CMD17', 'Wave', 85000, 'reussi', '2026-02-17'),
  ('PAY15', 'CMD18', 'especes_livraison', 24000, 'reussi', '2026-02-19'),
  ('PAY16', 'CMD19', 'carte_bancaire', 45000, 'reussi', '2026-02-21'),
  ('PAY17', 'CMD20', 'Orange Money', 32000, 'reussi', '2026-02-23'),
  ('PAY18', 'CMD21', 'Wave', 15000, 'reussi', '2026-02-25'),
  ('PAY19', 'CMD22', 'Free Money', 50000, 'reussi', '2026-02-27'),
  ('PAY20', 'CMD23', 'Orange Money', 24000, 'reussi', '2026-03-02'),
  ('PAY21', 'CMD24', 'Wave', 6000, 'reussi', '2026-03-04'),
  ('PAY22', 'CMD25', 'Wave', 56000, 'reussi', '2026-03-06'),
  ('PAY23', 'CMD27', 'Orange Money', 85000, 'reussi', '2026-03-11'),
  ('PAY24', 'CMD29', 'Orange Money', 15000, 'reussi', '2026-03-15'),
  ('PAY25', 'CMD12', 'Orange Money', 12000, 'echec', '2026-02-06'),
  ('PAY26', 'CMD26', 'Wave', 22000, 'echec', '2026-03-09'),
  ('PAY27', 'CMD99', 'Wave', 99000, 'reussi', '2026-03-20');
GO
SELECT COUNT(*) AS nb_paiements FROM dbo.paiements;  -- attendu : 27
GO
