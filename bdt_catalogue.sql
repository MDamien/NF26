-- ne pas prendre genre en sortie
-- method getAge()
		
-- DROP TABLE f_bdt_catalogue;
-- DROP TYPE livre_typ;

CREATE OR REPLACE TYPE livre_typ AS OBJECT(
  isbn         VARCHAR(40),
  titre        VARCHAR(255),
  auteur       VARCHAR(255),
  langue       VARCHAR(3),
  publication  VARCHAR(50),
  editeur      VARCHAR(255),
  genre        VARCHAR(255),
  
  MEMBER FUNCTION getIsbn RETURN VARCHAR,
  MEMBER FUNCTION getTitre RETURN VARCHAR, 
  MEMBER FUNCTION getAuteur RETURN VARCHAR,
  MEMBER FUNCTION getLangue RETURN VARCHAR,
  MEMBER FUNCTION getPublication RETURN VARCHAR,
  MEMBER FUNCTION getEditeur RETURN VARCHAR,
  MEMBER FUNCTION getGenre RETURN VARCHAR
);
/

@bdt_catalogue_body.sql;

CREATE TABLE f_bdt_catalogue OF livre_typ (PRIMARY KEY(isbn));

INSERT INTO f_bdt_catalogue (isbn, titre, auteur, langue, publication, editeur, genre)
  SELECT isbn, titre, auteur, langue, publication, editeur, genre
  FROM nf26.catalogue;
  
SELECT count(distinct t.getPublication()) FROM f_bdt_catalogue t;
