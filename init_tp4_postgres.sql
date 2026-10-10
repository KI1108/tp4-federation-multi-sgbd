-- =====================================================================
-- TP4 Big Data Engineering - UCAD - Prof. S. Ndiaye
-- SGBD 2/4 : PostgreSQL 16 - base catalogue (table produits)
-- A executer en tant que postgres avec psql :
--   psql -U postgres -h localhost -f init_tp4_postgres.sql
-- (les commandes \c sont des meta-commandes psql ;
--  sous pgAdmin, executer les deux blocs separement)
-- =====================================================================
DROP DATABASE IF EXISTS ecommerce_catalogue;
DROP ROLE IF EXISTS spark_user;
CREATE ROLE spark_user LOGIN PASSWORD 'Ucad2026!';
CREATE DATABASE ecommerce_catalogue;

\c ecommerce_catalogue

CREATE TABLE produits (
  produit_id VARCHAR(10)  PRIMARY KEY,
  nom        VARCHAR(100) NOT NULL,
  categorie  VARCHAR(50)  NOT NULL,
  prix_fcfa  INTEGER      NOT NULL,
  stock      INTEGER      NOT NULL
);

INSERT INTO produits VALUES
  ('P001', 'Smartphone Tecno Spark 20', 'Telephonie', 85000, 40),
  ('P002', 'Casque Bluetooth JBL', 'Telephonie', 15000, 120),
  ('P003', 'Ordinateur portable HP 15', 'Informatique', 350000, 15),
  ('P004', 'Cle USB 64 Go', 'Informatique', 8000, 200),
  ('P005', 'Boubou brode', 'Mode', 45000, 30),
  ('P006', 'Paire de sneakers', 'Mode', 28000, 60),
  ('P007', 'Ventilateur sur pied', 'Electromenager', 32000, 25),
  ('P008', 'Mixeur 500 W', 'Electromenager', 22000, 35),
  ('P009', 'Parfum Musc', 'Beaute', 12000, 80),
  ('P010', 'Creme au karite', 'Beaute', 6000, 150);

GRANT CONNECT ON DATABASE ecommerce_catalogue TO spark_user;
GRANT SELECT ON produits TO spark_user;

-- Schema d'ecriture pour la partie E (PostgreSQL = entrepot analytique)
CREATE SCHEMA analytics AUTHORIZATION spark_user;

SELECT COUNT(*) AS nb_produits FROM produits;  -- attendu : 10
