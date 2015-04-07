CREATE OR REPLACE TYPE date_typ AS OBJECT (
  ddate char(10),
  MEMBER FUNCTION getDat RETURN date,
  MEMBER FUNCTION getJds RETURN varchar2,
  MEMBER FUNCTION getSem RETURN number,
  MEMBER FUNCTION getMon RETURN number,
  MEMBER FUNCTION getTri RETURN number
);
/

@bdt_date_body.sql

CREATE TABLE f_bdt_date OF date_typ;

CREATE UNIQUE INDEX f_bdt_date_idx ON f_bdt_date(ddate);

ALTER TABLE f_bdt_date
ADD CONSTRAINT f_bdt_date_pk PRIMARY KEY (ddate);

INSERT INTO f_bdt_date
(SELECT DISTINCT tdate
  FROM f_bde_ventes
);

select ddate,t.getDat() from f_bdt_date t;