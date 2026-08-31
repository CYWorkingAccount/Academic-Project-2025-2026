-- Q1. Ecrire une requête qui, à partir de import affiche le contenu de la colonne n56 et le re-calcul de celle-ci à partir d’autres colonnes de import (2 cols).

SELECT n56, n57 + n58 + n59 AS recalcule
FROM import;

-- Q2. Quelle requête vous permet de savoir que ce re-calcul est parfaitement exact ?

SELECT COUNT(*)
FROM import
WHERE n56 <> n57 + n58 + n59;

-- Q3. Ecrire une requête qui, à partir de import affiche le contenu de la colonne n74 et le re-calcul de celle-ci à partir d’autres colonnes de import (2 cols).

SELECT n74, ROUND(n51::NUMERIC / n47 * 100, 0) AS recalcul
FROM import
WHERE n47 <> 0;

-- Q4. Quelle requête vous permet de savoir que ce re-calcul est parfaitement exact ?

SELECT COUNT(*)
FROM import 
WHERE n47 > 0
AND n74 <> (ROUND(n51::NUMERIC / n47 * 100, 0));

-- Q5. Ecrire une requête qui, à partir de import affiche le contenu de la colonne n76 et le re-calcul de celle-ci à partir d’autres colonnes de import (2 cols). A partir de combien de décimales ces données sont exactes ?

SELECT n76, ROUND(n53::NUMERIC / n47 * 100, 0) AS recalucl
FROM import
WHERE n47 > 0;

-- A partir de  0 décimales 

-- Q6. Fournir la même requête sur vos tables ventilées

SELECT n76, ROUND(n53::NUMERIC / n47 * 100, 0) AS recalcul
FROM recrutement
WHERE n47 > 0;

-- Q7. Ecrire une requête qui, à partir de import affiche la n81 et la manière de la recalculer. A partir de combien de décimales ces données sont exactes ?

SELECT n81, ROUND(n55::NUMERIC / n56 * 100, 0) AS recalcul
FROM import
WHERE n56 > 0;

-- A partir de  0 décimales 

-- Q8. Fournir la même requête sur vos tables ventilée

SELECT n81, ROUND(n55::NUMERIC / n56 * 100, 0) AS recalcul
FROM recrutement
WHERE n56 > 0;