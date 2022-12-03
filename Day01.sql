Create Table ogrenciler
(
	ogrenci_no char (7),
	isim varchar (20),
	soyisim varchar(25),
	not_ort real, --double number
	kayit_tarih date
);

--var olan tablodan yeni tablo olusturmak
create table ogrenci_notlari
as select isim, soyisim, not_ort from ogrenciler

--DHL Data Manupilation Language

INSERT INTO ogrenciler VALUES (1234567,'Said', 'ILHAN', 85.5, now());
INSERT INTO ogrenciler VALUES (1234567,'Said', 'ILHAN', 85.5, '2020-12-11');

Insert Into ogrenciler(isim, soyisim) Values ('Ilyas', 'Okutan');

--DQL

select * from ogrenciler;
