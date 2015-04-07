
CREATE TABLE f_dw_produit (
isbn char(13),
titre varchar2(255),
auteur varchar2(255),
langue char(3),
publication char(4),
editeur varchar2(255),
genre varchar2(255)
);
CREATE UNIQUE INDEX f_dw_produit_idx ON f_dw_produit(isbn);
ALTER TABLE f_dw_produit
ADD CONSTRAINT f_dw_produit_pk PRIMARY KEY (isbn);


CREATE TABLE f_dw_magasin (
mag char(4),
bs char(1),
ray char(1),
dpt char(2),
dptnom varchar2(50),
dptpop number(7)
);
CREATE UNIQUE INDEX f_dw_magasin_idx ON f_dw_magasin(mag);
ALTER TABLE f_dw_magasin
ADD CONSTRAINT f_dw_magasin_pk PRIMARY KEY (mag);


CREATE TABLE f_dw_date (
dat date,
jds varchar2(10),
sem number(2),
mon number(2),
tri number(1)
);
CREATE UNIQUE INDEX f_dw_date_idx ON f_dw_date(dat);
ALTER TABLE f_dw_date
ADD CONSTRAINT f_dw_date_pk PRIMARY KEY (dat);

CREATE TABLE f_dw_ventes (
ticket varchar2(13),
mag varchar2(20),
dat date,
pro char(13)
);


ALTER TABLE f_dw_ventes
ADD CONSTRAINT f_dw_ventes_fkpro
FOREIGN KEY (pro) REFERENCES f_dw_produit(isbn);
ALTER TABLE f_dw_ventes
ADD CONSTRAINT f_dw_ventes_fkdat
FOREIGN KEY (dat) REFERENCES f_dw_date(dat);
ALTER TABLE f_dw_ventes
ADD CONSTRAINT f_dw_ventes_fkmag
FOREIGN KEY (mag) REFERENCES f_dw_magasin(mag);



-- Désactivation des contraintes et index
ALTER TABLE f_dw_ventes DISABLE CONSTRAINT f_dw_ventes_fkpro;
ALTER TABLE f_dw_ventes DISABLE CONSTRAINT f_dw_ventes_fkdat;
ALTER TABLE f_dw_ventes DISABLE CONSTRAINT f_dw_ventes_fkmag;
ALTER TABLE f_dw_date DISABLE CONSTRAINT f_dw_date_pk;
ALTER TABLE f_dw_magasin DISABLE CONSTRAINT f_dw_magasin_pk;
ALTER TABLE f_dw_produit DISABLE CONSTRAINT f_dw_produit_pk;
DROP INDEX f_dw_date_idx;
DROP INDEX f_dw_magasin_idx;
DROP INDEX f_dw_produit_idx;

-- Insertion
INSERT INTO f_dw_produit(isbn,titre,auteur,langue,publication,editeur)
SELECT t.getIsbn(),t.getTitre(),t.getAuteur(),t.getLangue(),t.getPublication(),t.getEditeur()
FROM f_bdt_catalogue t;
INSERT INTO f_dw_magasin (mag,bs,ray,dpt,dptnom,dptpop)
SELECT m.getMagasin(),m.getBestseller(),m.getRayonnage(),m.getDpt(),m.getDptnom(),m.getDptpopulation()
FROM f_bdt_magasin m;
INSERT INTO f_dw_date (dat, jds, sem, mon, tri)
SELECT t.getDat(), t.getJds(), t.getSem(), t.getMon(), t.getTri()
FROM f_bdt_date t;
INSERT INTO f_dw_ventes (mag,dat,pro)
SELECT t.getMagasin(),t.getDate(),t.getIsbn()
FROM f_bdt_ventes t;


-- Réactivation des index et contraintes
CREATE INDEX f_dw_date_idx ON f_dw_date(dat);
CREATE INDEX f_dw_magasin_idx ON f_dw_magasin(mag);
CREATE INDEX f_dw_produit_idx ON f_dw_produit(isbn);
ALTER TABLE f_dw_date ENABLE CONSTRAINT f_dw_date_pk;
ALTER TABLE f_dw_magasin ENABLE CONSTRAINT f_dw_magasin_pk;
ALTER TABLE f_dw_produit ENABLE CONSTRAINT f_dw_produit_pk;
ALTER TABLE f_dw_ventes ENABLE CONSTRAINT f_dw_ventes_fkpro;
ALTER TABLE f_dw_ventes ENABLE CONSTRAINT f_dw_ventes_fkdat;
ALTER TABLE f_dw_ventes ENABLE CONSTRAINT f_dw_ventes_fkmag;


SELECT count(*) exceptions FROM exceptions;


-- Vérification sommaire du transfert
SELECT * FROM f_dw_ventes WHERE ROWNUM=1;
SELECT count(*) FROM f_bdt_ventes;
SELECT * FROM f_dw_date WHERE ROWNUM=1;
SELECT count(*) FROM f_bdt_date;
SELECT * FROM f_dw_magasin WHERE ROWNUM=1;
SELECT count(*) FROM f_bdt_magasin;
SELECT * FROM f_dw_produit WHERE ROWNUM=1;
SELECT count(*) FROM f_bdt_catalogue;