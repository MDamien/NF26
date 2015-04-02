DROP TABLE f_bdt_date;

CREATE OR REPLACE TYPE date_typ AS OBJECT (
  ddate char(10),
  MEMBER FUNCTION getDat RETURN date,
  MEMBER FUNCTION getJds RETURN varchar2,
  MEMBER FUNCTION getSem RETURN number,
  MEMBER FUNCTION getMon RETURN number,
  MEMBER FUNCTION getTri RETURN number
);

CREATE OR REPLACE TYPE BODY date_typ IS
  MEMBER FUNCTION getDat RETURN date
  IS
  BEGIN
     if regexp_like(ddate, '[0-9]{4}-[0-9]{2}-[0-9]{2}') then
    return to_date(ddate, 'yyyy-mm-dd');
    else
    return null;
    end if;
  END;
  MEMBER FUNCTION getJds RETURN varchar2
  IS
  BEGIN
    RETURN TO_CHAR(self.getDat(),'day');
  END;
  MEMBER FUNCTION getSem RETURN number
  IS
  BEGIN
    RETURN TO_CHAR(self.getDat(),'ww');
  END;
  MEMBER FUNCTION getMon RETURN number
  IS
  BEGIN
    RETURN TO_CHAR(self.getDat(),'mm');
  END;
  MEMBER FUNCTION getTri RETURN number
  IS
  BEGIN
    RETURN CEIL(TO_CHAR(self.getDat(),'mm') / 3);
  END;
END;

CREATE TABLE f_bdt_date OF date_typ;
CREATE UNIQUE INDEX f_bdt_date_idx ON f_bdt_date(ddate);
ALTER TABLE f_bdt_date
ADD CONSTRAINT f_bdt_date_pk PRIMARY KEY (ddate);

INSERT INTO f_bdt_date
(SELECT DISTINCT tdate
FROM f_bde_ventes
);

select t.getDat() from f_bdt_date t;