CREATE OR REPLACE TYPE BODY vente_typ
IS
MEMBER FUNCTION getMagasin RETURN varchar2
IS
BEGIN
RETURN magasin;
END;
MEMBER FUNCTION getDate RETURN date
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
MEMBER FUNCTION getIsbn RETURN varchar2
IS
BEGIN
RETURN isbn;
END;
MEMBER FUNCTION getTicket RETURN NUMBER
IS
BEGIN
   if regexp_like(ticket, '[0-9]+') then
    return to_number(ticket);
  else
    return null;
  end if;
END;
END;