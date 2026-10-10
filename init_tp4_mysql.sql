-- =====================================================================
-- TP4 Big Data Engineering - UCAD - Prof. S. Ndiaye
-- SGBD 1/4 : MySQL 8 - base CRM (table clients)
-- A executer en tant que root, par ex. :
--   mysql -u root -p < init_tp4_mysql.sql
-- (ou copier-coller dans MySQL Workbench)
-- =====================================================================
DROP DATABASE IF EXISTS ecommerce_crm;
CREATE DATABASE ecommerce_crm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Compte technique Spark (moindre privilege : lecture seule)
CREATE USER IF NOT EXISTS 'spark_user'@'%' IDENTIFIED BY 'Ucad2026!';
ALTER USER 'spark_user'@'%' IDENTIFIED BY 'Ucad2026!';
GRANT SELECT ON ecommerce_crm.* TO 'spark_user'@'%';
FLUSH PRIVILEGES;

USE ecommerce_crm;
CREATE TABLE clients (
  client_id        VARCHAR(10)  PRIMARY KEY,
  nom              VARCHAR(100) NOT NULL,
  ville            VARCHAR(50)  NOT NULL,
  email            VARCHAR(120),
  telephone        VARCHAR(20),
  date_inscription DATE
);

INSERT INTO clients VALUES
  ('C001', 'Awa Diop', 'Dakar', 'awa.diop@gmail.com', '77 123 45 67', '2025-01-15'),
  ('C002', 'Moussa Ndiaye', 'Thies', 'moussa.ndiaye@yahoo.fr', '78 234 56 78', '2025-02-03'),
  ('C003', 'Fatou Sarr', 'Dakar', NULL, '76 345 67 89', '2025-02-20'),
  ('C004', 'Ibrahima Fall', 'Saint-Louis', 'ibrahima.fall@gmail.com', '70 456 78 90', '2025-03-11'),
  ('C005', 'Aminata Ba', 'Ziguinchor', 'aminata.ba@outlook.com', '75 567 89 01', '2025-04-02'),
  ('C006', 'Ousmane Sow', 'Kaolack', 'ousmane.sow@gmail.com', '77 678 90 12', '2025-04-25'),
  ('C007', 'Mariama Diallo', 'Dakar', 'mariama.diallo@gmail.com', '78 789 01 23', '2025-05-14'),
  ('C008', 'Cheikh Gueye', 'Touba', NULL, '76 890 12 34', '2025-06-08'),
  ('C009', 'Adama Faye', 'Rufisque', 'adama.faye@yahoo.fr', '70 901 23 45', '2025-07-19'),
  ('C010', 'Khady Ndour', 'Mbour', 'khady.ndour@gmail.com', '75 012 34 56', '2025-08-30'),
  ('C011', 'Serigne Mbaye', 'Diourbel', 'serigne.mbaye@gmail.com', '77 135 79 02', '2025-10-12'),
  ('C012', 'Coumba Cisse', 'Dakar', 'coumba.cisse@outlook.com', '78 246 80 13', '2025-11-27');

SELECT COUNT(*) AS nb_clients FROM clients;  -- attendu : 12
