CREATE OR REPLACE TYPE vente_typ AS OBJECT (
  ticket NUMBER(13),
  ddate CHAR(10),
  magasin VARCHAR2(10),
  isbn CHAR(13),
  
  MEMBER FUNCTION getTicket RETURN NUMBER,
  MEMBER FUNCTION getMagasin RETURN VARCHAR2,
  MEMBER FUNCTION getDate RETURN DATE,
  MEMBER FUNCTION getIsbn RETURN VARCHAR2
);

CREATE TABLE f_bdt_ventes OF vente_typ;

ALTER TABLE f_bdt_ventes
ADD CONSTRAINT f_bdt_ventes_fkdate
FOREIGN KEY (ddate) REFERENCES f_bdt_date(ddate);

ALTER TABLE f_bdt_ventes
ADD CONSTRAINT f_bdt_ventes_fkmagasin
FOREIGN KEY (fk_magasin) REFERENCES f_bdt_magasin(mag);