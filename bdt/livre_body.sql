create or replace type body livre_typ IS
member function getIsbn return varchar
is
begin
return isbn;
end;
member function getTitre return varchar
is
begin
return titre;
end;
member function getAuteur return varchar
is
begin
return auteur;
end;
member function getEditeur return varchar
is
begin
return editeur;
end;
member function getLangue return VARCHAR
is
begin
return langue;
end;
member function getGenre return VARCHAR
is
begin
return genre;
end;
member function getPublication return VARCHAR
is
begin
  return to_char(
    cast(to_timestamp_tz(publication, 'yyyy-mm-dd"T"hh24:mi:ss tzh:tzm')
    as date), 'YYYY');
end;
end;
