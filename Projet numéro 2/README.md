---
title: "Sae 2.4"
author:
  - "CY"
lang: fr-FR
---

## Introduction et Problématique

Ce projet s'inscrit dans le cadre de la gestion et de l'ingénierie des bases de données relationnelles. L'objectif principal réside dans le traitement, la structuration et la normalisation d'un jeu de données issu de la plateforme Parcoursup. Le fichier source, caractérisé par un volume conséquent de 14 253 enregistrements répartis sur 118 colonnes, présentait d'importantes contraintes d'exploitabilité. L'absence de structuration relationnelle initiale se traduisait par une redondance massive des informations, la présence de nombreuses valeurs nulles ainsi qu'une nomenclature de champs complexe. La démarche adoptée vise ainsi à transformer ce fichier plat en un système d'information optimisé et cohérent sous PostgreSQL.

## Démarche Méthodologique et Implémentation

La première phase du travail a consisté en une analyse exploratoire de l'information brute au moyen d'outils en ligne de commande Linux. Cette inspection initiale a permis d'établir un dictionnaire de données associant chaque attribut d'origine à un identifiant normalisé. Une table d'accueil temporaire a ensuite été instanciée afin d'y charger l'intégralité du corpus via des requêtes d'importation directes. 

Dans un second temps, afin de pallier les anomalies de redondance et de rationaliser l'occupation mémoire, un Modèle Conceptuel de Données (MCD) a été conçu. La ventilation de la table initiale vers ce schéma cible a permis de répartir l'information au sein de tables entités distinctes, notamment dédiées aux établissements, aux localisations, aux filières et aux modalités de recrutement. 

## Résultats et Analyse des Performances

La restructuration de la base de données a apporté une amélioration substantielle sur le plan des performances informatiques. L'empreinte mémoire totale, initialement évaluée à 16,7 Mo pour la table brute, a été ramenée à 5,8 Mo après ventilation, représentant une réduction du volume de stockage supérieure à 60 %. L'ajout d'index sur les clés d'interrogation stratégiques a en outre permis d'optimiser le temps d'exécution des jointures complexes. 

Enfin, la phase de requêtage SQL a permis de mener des analyses statistiques approfondies, telles que le dénombrement des capacités d'accueil ou l'identification précise de formations spécifiques à l'image du BUT Informatique. Cette étape a soulevé des enjeux techniques liés au calcul d'indicateurs, nécessitant un traitement rigoureux des cas de division par zéro, un transtypage explicite des données numériques et une étude de la gestion des arrondis selon les types de données employés.

## Organisation des Fichiers du Dépôt

L'ensemble des travaux est consigné au sein du présent dépôt. Le fichier `parcoursup.sql` regroupe l'intégralité des instructions DDL et DML relatives à la création et au remplissage du schéma relationnel. Le document `requetes.sql` intègre les requêtes d'analyse et de vérification des indicateurs. Enfin, la documentation est complétée par le dictionnaire de données `dico.txt` ainsi que par la modélisation graphique du système matérialisée dans le fichier `img/MCD.png`.
