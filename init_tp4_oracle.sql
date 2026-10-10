-- =====================================================================
-- TP4 Big Data Engineering - UCAD - Prof. S. Ndiaye
-- SGBD 3/4 : Oracle Database 21c XE - schema ventes (table commandes)
-- A executer en tant que SYSTEM sur la base pluggable XEPDB1 :
--   sqlplus system/VotreMdpSystem@//localhost:1521/XEPDB1 @init_tp4_oracle.sql
-- (ou copier-coller dans SQL Developer, connecte a XEPDB1)
-- =====================================================================

-- Suppression du compte s'il existe deja (ignore l'erreur sinon)
BEGIN
  EXECUTE IMMEDIATE 'DROP USER spark_user CASCADE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE USER spark_user IDENTIFIED BY "Ucad2026!"
  DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
GRANT CREATE SESSION, CREATE TABLE TO spark_user;

CREATE TABLE spark_user.commandes (
  commande_id   VARCHAR2(10) PRIMARY KEY,
  client_id     VARCHAR2(10) NOT NULL,
  produit_id    VARCHAR2(10) NOT NULL,
  quantite      NUMBER(5)    NOT NULL,
  montant_fcfa  NUMBER(12)   NOT NULL,
  date_commande DATE         NOT NULL,
  statut        VARCHAR2(20) NOT NULL
);

INSERT INTO spark_user.commandes VALUES ('CMD01', 'C001', 'P001', 1, 85000, TO_DATE('2026-01-05','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD02', 'C002', 'P003', 1, 350000, TO_DATE('2026-01-08','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD03', 'C003', 'P009', 2, 24000, TO_DATE('2026-01-10','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD04', 'C004', 'P005', 1, 45000, TO_DATE('2026-01-12','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD05', 'C001', 'P002', 2, 30000, TO_DATE('2026-01-15','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD06', 'C005', 'P010', 3, 18000, TO_DATE('2026-01-18','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD07', 'C006', 'P007', 1, 32000, TO_DATE('2026-01-20','YYYY-MM-DD'), 'annulee');
INSERT INTO spark_user.commandes VALUES ('CMD08', 'C007', 'P004', 2, 16000, TO_DATE('2026-01-22','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD09', 'C008', 'P006', 1, 28000, TO_DATE('2026-01-25','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD10', 'C009', 'P001', 1, 85000, TO_DATE('2026-02-01','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD11', 'C010', 'P008', 1, 22000, TO_DATE('2026-02-03','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD12', 'C011', 'P009', 1, 12000, TO_DATE('2026-02-05','YYYY-MM-DD'), 'en_cours');
INSERT INTO spark_user.commandes VALUES ('CMD13', 'C012', 'P003', 1, 350000, TO_DATE('2026-02-08','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD14', 'C002', 'P010', 2, 12000, TO_DATE('2026-02-10','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD15', 'C003', 'P006', 1, 28000, TO_DATE('2026-02-12','YYYY-MM-DD'), 'annulee');
INSERT INTO spark_user.commandes VALUES ('CMD16', 'C004', 'P002', 1, 15000, TO_DATE('2026-02-14','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD17', 'C005', 'P001', 1, 85000, TO_DATE('2026-02-16','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD18', 'C006', 'P004', 3, 24000, TO_DATE('2026-02-18','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD19', 'C007', 'P005', 1, 45000, TO_DATE('2026-02-20','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD20', 'C001', 'P007', 1, 32000, TO_DATE('2026-02-22','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD21', 'C999', 'P002', 1, 15000, TO_DATE('2026-02-24','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD22', 'C009', 'P999', 1, 50000, TO_DATE('2026-02-26','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD23', 'C010', 'P009', 2, 24000, TO_DATE('2026-03-01','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD24', 'C011', 'P010', 1, 6000, TO_DATE('2026-03-03','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD25', 'C012', 'P006', 2, 56000, TO_DATE('2026-03-05','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD26', 'C008', 'P008', 1, 22000, TO_DATE('2026-03-08','YYYY-MM-DD'), 'en_cours');
INSERT INTO spark_user.commandes VALUES ('CMD27', 'C003', 'P001', 1, 85000, TO_DATE('2026-03-10','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD28', 'C005', 'P004', 1, 8000, TO_DATE('2026-03-12','YYYY-MM-DD'), 'en_cours');
INSERT INTO spark_user.commandes VALUES ('CMD29', 'C006', 'P002', 1, 15000, TO_DATE('2026-03-14','YYYY-MM-DD'), 'livree');
INSERT INTO spark_user.commandes VALUES ('CMD30', 'C007', 'P010', 4, 24000, TO_DATE('2026-03-16','YYYY-MM-DD'), 'annulee');
COMMIT;

SELECT COUNT(*) AS nb_commandes FROM spark_user.commandes;  -- attendu : 30
EXIT;
