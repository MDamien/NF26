-- DROP TABLE f_bdt_magasin;
-- DROP TYPE magasin_typ;

CREATE OR REPLACE TYPE magasin_typ AS OBJECT (
  dpt number(2),
  dpt_nom varchar2(50),
  dpt_pop number(10),
  rayonnage char(1),
  bestseller number(1),
  recent number(1),
  mag varchar2(4),
  
  MEMBER FUNCTION getDpt RETURN number,
  MEMBER FUNCTION getDptnom RETURN varchar2,
  MEMBER FUNCTION getDptpopulation RETURN number,
  MEMBER FUNCTION getRayonnage RETURN varchar2,
  MEMBER FUNCTION getMagasin RETURN varchar2,
  MEMBER FUNCTION getRecent RETURN number,
  MEMBER FUNCTION getBestseller RETURN varchar2
);

@bdt_magasin_body.sql;

CREATE TABLE f_bdt_magasin OF magasin_typ;

CREATE UNIQUE INDEX f_bdt_magasin_idx ON f_bdt_magasin(mag);

ALTER TABLE f_bdt_magasin ADD CONSTRAINT f_bdt_magasin_pk PRIMARY KEY (mag);

INSERT INTO f_bdt_magasin
(SELECT dept, nom, pop, rayonnage, bestseller, recent, magasin
FROM f_bde_dept, f_bde_marketing
WHERE dept = dept_no
);
select * from f_bdt_magasin;