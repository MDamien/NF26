-- REGEXP_REPLACE(ddate, '(([0-9]*-[0-9]*-)([0-9]))', '\20\3') "ndate";

-- annee

CREATE OR REPLACE TYPE BODY date_typ IS
  MEMBER FUNCTION getDat RETURN date
  IS
  BEGIN
     if regexp_like(ddate, '[0-9]{4}-[0-9]{2}-[0-9]{2}') then
      return to_date(ddate, 'yyyy-mm-dd');
    else
     if regexp_like(ddate, '0[0-9]{2}-[0-9]{2}-[0-9]{2}') then
        return to_date(CONCAT('2',ddate), 'yyyy-mm-dd');
      else
        return null;
      end if;
    end if;
  END;
  MEMBER FUNCTION getJds RETURN varchar2
  IS
  BEGIN
    RETURN TO_CHAR(self.getDat(),'fmday');
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
    RETURN TO_CHAR(self.getDat(),'q');
  END;
END;