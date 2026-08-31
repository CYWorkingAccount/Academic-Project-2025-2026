/*Les filles n’aiment pas les études scientifiques. 

Faut voir les conditions f.n10 LIKE '%Licence - Sciences%' 
    OR f.n10 LIKE '%Licence - Lettres%' 
    OR f.n10 LIKE '%Licence - Arts%'
Elles prennent trop de choses en compte, le reste est good sinon*/

SELECT 
    SUM(r.n47) AS total_admis,
    SUM(r.n48) AS total_filles_admises,
    ROUND(SUM(r.n48) * 100.0 / SUM(r.n47), 2) AS pourcentage_taux_filles_admises,
    SUM(r.n19) AS candidats,
    SUM(r.n20) AS candidates,
    ROUND(SUM(r.n20) * 100.0 / SUM(r.n19), 2) AS pourcentage_taux_filles_candidates
FROM recrutement r
JOIN filiere f ON r.id_filiere = f.id
JOIN etablissement e ON r.id_etablissement = e.id 
JOIN localisation l ON e.id_localisation = l.id
WHERE l.n7 IN ('Pays-de-la-Loire', 'Centre')
AND r.n47 > 0
AND (
    f.n10 LIKE '%Licence - Sciences%' 
    OR f.n10 LIKE '%Licence - Lettres%' 
    OR f.n10 LIKE '%Licence - Arts%'
    OR f.n10 LIKE '%Informatique%'
    OR f.n10 LIKE '%Ingénieur%'
    OR f.n10 LIKE '%BUT%'
    OR f.n10 LIKE '%BTS%Chimie%'
    OR f.n10 LIKE '%BTS%Informatique%'
    OR f.n10 LIKE '%CPGE%scientifique%'
);



/*Les bacs technologiques ont plus de chances que les bacs généraux d'être
acceptés en filières sélectives. */
SELECT 
    r.n17 AS type_formation,
    ROUND(SUM(n57) * 100.0 / SUM(n56), 1) AS part_bac_general,
    ROUND(SUM(n58) * 100.0 / SUM(n56), 1) AS part_bac_techno
FROM import
WHERE n7 IN ('Pays de la Loire', 'Centre-Val de Loire')
  AND n56 > 0
  AND n11 = 'formation sélective'
GROUP BY n17;
/*Les boursiers préfèrent les études courtes. */

SELECT 'Etudes courtes (BUT/BTS)' AS type_etudes, 
       ROUND(AVG(n53 * 100.0 / n47)::numeric, 1) AS taux_boursiers
FROM recrutement r
JOIN filiere f ON r.id_filiere = f.id
JOIN etablissement e ON r.id_etablissement = e.id
JOIN localisation l ON e.id_localisation = l.id
WHERE l.n7 IN ('Pays de la Loire', 'Centre-Val de Loire')
  AND f.n11 IN ('B.U.T.', 'BTS')
  AND n47 > 0

UNION 
SELECT 'Etudes longues (Licence/CPGE)' AS type_etudes, 
       ROUND(AVG(n53 * 100.0 / n47)::numeric, 1) AS taux_boursiers
FROM recrutement r
JOIN filiere f ON r.id_filiere = f.id
JOIN etablissement e ON r.id_etablissement = e.id
JOIN localisation l ON e.id_localisation = l.id
WHERE l.n7 IN ('Pays de la Loire', 'Centre-Val de Loire')
  AND f.n11 IN ('Licence', 'CPGE')
  AND n47 > 0;