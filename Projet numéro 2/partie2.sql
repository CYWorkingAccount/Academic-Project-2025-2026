--trouver les but 

SELECT e.n2 AS nom_iut, l.n9 AS ville, e.id AS id_etablissement
FROM etablissement e
JOIN localisation l ON e.id_localisation = l.id
JOIN recrutement r ON r.id_etablissement = e.id
JOIN filiere f ON r.id_filiere = f.id
WHERE l.n7 IN ('Pays de la Loire', 'Centre-Val de Loire')
  AND f.n10 LIKE '%BUT%Informatique%'
GROUP BY e.n2, l.n9, e.id;

--commande a faire avec les but 
SELECT 
    e.n2 AS iut,
    ROUND((r.n51 * 100.0 / r.n47)::numeric, 1) AS pourcentage_filles_candidats,
    ROUND((r.n53 * 100.0 / r.n47)::numeric, 1) AS pourcentage_boursiers_candidats,
    ROUND((r.n57 * 100.0 / r.n56)::numeric, 1) AS part_bac_general_admis,
    ROUND((r.n58 * 100.0 / r.n56)::numeric, 1) AS part_bac_techno_admis,
    ROUND((r.n59 * 100.0 / r.n56)::numeric, 1) AS part_autres_bacs_admis
FROM recrutement r
JOIN etablissement e ON r.id_etablissement = e.id
JOIN localisation l ON e.id_localisation = l.id
JOIN filiere f ON r.id_filiere = f.id
WHERE f.n10 LIKE '%BUT%Informatique%'
  AND l.n9 IN (nom 1,nom2)
  AND r.n47 > 0 AND r.n56 > 0;
  
--calcul pertinent en plus

SELECT 
    e.n2 AS iut,
    -- Nombre de candidats pour 1 place (Attractivité)
    ROUND((r.n47::numeric / r.n18), 1) AS candidats_par_place,
    -- Pourcentage de candidats qui ont reçu une proposition (Sélectivité)
    ROUND((r.n48 * 100.0 / r.n47)::numeric, 1) AS taux_de_selection
FROM recrutement r
JOIN etablissement e ON r.id_etablissement = e.id
JOIN filiere f ON r.id_filiere = f.id
JOIN localisation l ON e.id_localisation = l.id
WHERE f.n10 LIKE '%BUT%Informatique%'
  AND l.n9 IN ('Nantes', 'Orléans');