DROP INDEX IF EXISTS index_etablissement_n3;
DROP TABLE IF EXISTS recrutement CASCADE;
DROP TABLE IF EXISTS etablissement CASCADE;
DROP TABLE IF EXISTS localisation CASCADE;
DROP TABLE IF EXISTS filiere CASCADE;
DROP TABLE IF EXISTS import CASCADE;


CREATE TABLE import (
    n1 INT, n2 TEXT, n3 CHAR(8), n4 TEXT, n5 CHAR(3), n6 TEXT, n7 TEXT, n8 TEXT,
    n9 TEXT, n10 TEXT, n11 VARCHAR(50), n12 TEXT, n13 TEXT, n14 TEXT, n15 TEXT,
    n16 TEXT, n17 TEXT, n18 INT, n19 INT, n20 INT, n21 INT, n22 INT, n23 INT, n24 INT, n25 INT, n26 INT, n27 INT,
    n28 INT, n29 INT, n30 INT, n31 INT, n32 INT, n33 INT, n34 INT, n35 INT, n36 INT, n37 INT, n38 INT, n39 INT, n40 INT, n41 INT,
    n42 INT, n43 INT, n44 INT, n45 INT, n46 INT, n47 INT, n48 INT, n49 INT, n50 INT, n51 INT, n52 INT, n53 INT, n54 INT, n55 INT,
    n56 INT, n57 INT, n58 INT, n59 INT, n60 INT, n61 INT, n62 INT, n63 INT, n64 INT, n65 INT, n66 INT, n67 INT, n68 INT, n69 INT,
    n70 INT, n71 INT, n72 INT, n73 INT, n74 FLOAT, n75 FLOAT, n76 FLOAT, n77 FLOAT, n78 FLOAT, n79 FLOAT, n80 FLOAT, n81 FLOAT,
    n82 FLOAT, n83 FLOAT, n84 FLOAT, n85 FLOAT, n86 FLOAT, n87 FLOAT, n88 FLOAT, n89 FLOAT, n90 FLOAT, n91 FLOAT, n92 FLOAT,
    n93 FLOAT, n94 FLOAT, n95 FLOAT, n96 FLOAT, n97 FLOAT, n98 FLOAT, n99 FLOAT, n100 FLOAT, n101 FLOAT, n102 TEXT, n103 INT,
    n104 TEXT, n105 INT, n106 TEXT, n107 INT, n108 TEXT, n109 TEXT, n110 INT,
    n111 TEXT, n112 TEXT, n113 FLOAT, n114 FLOAT, n115 FLOAT, n116 FLOAT, n117 VARCHAR(50), n118 TEXT
);


CREATE TABLE filiere (
    id SERIAL,
    n10 TEXT,
    n11 TEXT,
    n12 TEXT,
    n13 TEXT,
    n14 TEXT,
    n15 TEXT,
    n16 TEXT,
    CONSTRAINT pk_filiere PRIMARY KEY (id)
);

CREATE TABLE localisation (
    id SERIAL,
    n5 CHAR(3),
    n6 TEXT,
    n7 TEXT,
    n8 TEXT,
    n9 TEXT,
    n110 INT,
    CONSTRAINT pk_localisation PRIMARY KEY (id)
);

CREATE TABLE etablissement (
    id SERIAL,
    n3 CHAR(8),
    n2 TEXT,
    n4 TEXT,
    n117 TEXT,
    id_localisation INT,
    CONSTRAINT pk_etablissement PRIMARY KEY (id),
    CONSTRAINT fk_localisation FOREIGN KEY (id_localisation)
        REFERENCES localisation(id)
        ON UPDATE CASCADE
);

CREATE TABLE recrutement (
    id SERIAL,
    n1 INT,
    n18 INT,
    n19 INT,
    n20 INT,
    n21 INT,
    n24 INT,
    n25 INT,
    n29 INT,
    n35 INT,
    n39 INT,
    n41 INT,
    n45 INT,
    n46 INT,
    n47 INT,
    n48 INT,
    n51 INT,
    n53 INT,
    n55 INT,
    n56 INT,
    n57 INT,
    n58 INT,
    n59 INT,
    n65 INT,
    n74 FLOAT,
    n76 FLOAT,
    n81 FLOAT,
    id_etablissement INT,
    id_filiere INT,
    CONSTRAINT pk_recrutement PRIMARY KEY (id),
    CONSTRAINT fk_etablissement FOREIGN KEY (id_etablissement)
        REFERENCES etablissement(id)
        ON UPDATE CASCADE,
    CONSTRAINT fk_filiere FOREIGN KEY (id_filiere)
        REFERENCES filiere(id)
        ON UPDATE CASCADE
);

\copy import FROM fr-esr-parcoursup.csv.csv DELIMITER ';' NULL '';

INSERT INTO filiere (n10, n11, n12, n13, n14, n15, n16)
SELECT DISTINCT n10, n11, n12, n13, n14, n15, n16
FROM import;

INSERT INTO localisation (n5, n6, n7, n8, n9)
SELECT DISTINCT n5, n6, n7, n8, n9
FROM import;

INSERT INTO etablissement (n3, n2, n4, n117, id_localisation)
SELECT DISTINCT i.n3, i.n2, i.n4, i.n117, l.id
FROM import i
JOIN localisation l
    ON  i.n5 = l.n5
    AND i.n6 = l.n6
    AND i.n7 = l.n7
    AND i.n8 = l.n8
    AND i.n9 = l.n9;

CREATE INDEX index_etablissement_n3 ON etablissement (n3);

INSERT INTO recrutement (n1, n18, n19, n20, n21, n24, n25, n29, n35, n39, n41, n45, n46, n47, n48, n51, n53, n55, n56, n57, n58, n59, n65, n74, n76, n81,id_etablissement, id_filiere)
SELECT i.n1, i.n18, i.n19, i.n20, i.n21, i.n24, i.n25, i.n29, i.n35, i.n39, i.n41, i.n45, i.n46, i.n47, i.n48, i.n51, i.n53, i.n55, i.n56, i.n57, i.n58, i.n59, i.n65, i.n74, i.n76, i.n81, e.id, f.id
FROM (import i JOIN etablissement e ON i.n3 = e.n3) JOIN filiere f
    ON  i.n10 = f.n10
    AND i.n11 = f.n11
    AND i.n12 = f.n12
    AND i.n13 = f.n13
    AND i.n14 = f.n14
    AND i.n15 = f.n15
    AND i.n16 = f.n16;
