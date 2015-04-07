
CREATE OR REPLACE TYPE vente_typ AS OBJECT (
  ticket VARCHAR2(13),
  ddate VARCHAR2(20),
  magasin VARCHAR2(20),
  isbn VARCHAR2(13),
  
  MEMBER FUNCTION getTicket RETURN NUMBER,
  MEMBER FUNCTION getMagasin RETURN VARCHAR2,
  MEMBER FUNCTION getDate RETURN DATE,
  MEMBER FUNCTION getIsbn RETURN VARCHAR2
);
/

@bdt_ventes_body.sql

CREATE TABLE f_bdt_ventes OF vente_typ;

INSERT INTO f_bdt_ventes
(SELECT ticket, tdate, mag, isbn
FROM f_bde_ventes
);

/*
ALTER TABLE f_bdt_ventes
ADD CONSTRAINT f_bdt_ventes_fkdate
FOREIGN KEY (ddate) REFERENCES f_bdt_date(ddate);

ALTER TABLE f_bdt_ventes
ADD CONSTRAINT f_bdt_ventes_fkmagasin
FOREIGN KEY (magasin) REFERENCES f_bdt_magasin(mag);
*/
