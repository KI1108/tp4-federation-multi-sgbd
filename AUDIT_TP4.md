# Audit d'intégrité inter-SGBD — TP4 Fédération de données

  Étudiants :  
   Alioune NDIAYE
   Korotimi Inna DIALLO

Aucune clé étrangère ne traverse les 4 SGBD (MySQL, PostgreSQL, Oracle, SQL Server). L'intégrité référentielle a donc été vérifiée par anti-jointures (`LEFT ANTI JOIN`) dans Spark SQL.

## Les 3 anomalies

| # | Identifiant | Table et SGBD source | Anomalie | Impact métier |
|---|---|---|---|---|
| 1 | CMD21 (client `C999`, 15 000 FCFA, livrée) | `commandes` — Oracle XE (équipe Ventes) | Client absent de `clients` (MySQL, équipe CRM) : « client fantôme » | Une vente livrée et payée (PAY18) ne peut être rattachée à aucun client : CA par ville faussé et relation client impossible. |
| 2 |   CMD22   (produit `P999`, 50 000 FCFA, livrée) | `commandes` — Oracle XE (équipe Ventes) | Produit absent de `produits` (PostgreSQL, équipe Catalogue) : « produit fantôme » | Une vente livrée et payée (PAY19) échappe au CA par catégorie et à la gestion de stock. |
| 3 |   PAY27   (`CMD99`, 99 000 FCFA, Wave, réussi) | `paiements` — SQL Server (équipe Finance) | Paiement orphelin : la commande `CMD99` n'existe pas chez les Ventes (Oracle) | 99 000 FCFA encaissés sans commande : risque de fraude ou d'erreur de saisie, écart de rapprochement comptable à expliquer ou rembourser. |

Les ventes impactées par CMD21 et CMD22 (65 000 FCFA) sont exclues de la vue fédérée (jointures internes), qui sous-estime donc le CA réel de 65 000 FCFA.

## Contrôle complémentaire

Commandes   livrées sans paiement réussi   :   0 ligne  . Toutes les commandes livrées ont un paiement réussi, ce qui prouve la cohérence livraison / encaissement.

## Tableau de relevés

| Mesure | Valeur |
|---|---:|
| nb_clients (MySQL) | 12 |
| nb_produits (PostgreSQL) | 10 |
| nb_commandes (Oracle) | 30 |
| nb_paiements (SQL Server) | 27 |
| jointure commandes-clients | 29 |
| jointure 3 tables | 28 |
| vue fédérée (4 SGBD) | 22 |
| commandes sans client | 1 |
| commandes sans produit | 1 |
| paiements orphelins | 1 |
| livrées sans paiement réussi | 0 |
| CA fédéré total (FCFA) | 1 452 000 |

CA par ville (tête) : Dakar 723 000 — par catégorie : Informatique 740 000 — par moyen de paiement : Wave 537 000.

## Recommandations

1. Contrôles d'intégrité inter-systèmes planifiés (anti-jointures) avec alerte aux propriétaires de données.
2. Référentiels maîtres partagés (clients, produits) et validation des identifiants à la saisie côté Ventes.
3. Rapprochement Finance / Ventes périodique pour détecter les paiements orphelins.
