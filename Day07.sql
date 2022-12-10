-- DISTINCT KULLANIMI

CREATE TABLE musteri_urun (
urun_id int,
musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

select * from musteri_urun

--Group By cözümü
select urun_isim from musteri_urun
Group By urun_isim

--distinc cözümü

select Distinct(urun_isim) from musteri_urun;

--Tabloda kac farkli meyve vardir ?

select count(Distinct urun_isim) from musteri_urun;

select urun_isim, count(urun_isim) from musteri_urun
Group By urun_isim

--Fetch next () row only / offset /limit

--müsteri urun tablosoundan ilk 3 kayfi listeleyiniz

select * from musteri_urun order by urun_id
fetch next 3 row only

select * from musteri_urun order by urun_id
limit 3

--musteri urun tablosundan son 3 kaydi listeleyiniz
select * from musteri_urun order by urun_id DESC
limit 3



CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int,
Primary Key (id,musteri_isim)    
);

INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

--en yuksek maas
SELECT * FROM maas order by maas desc

--en yuksek ikinci maas
select * from maas order by maas desc offset 1 limit 1;
--offset satir atlamak icin kullanilir

select * from maas order by maas desc
offset 1 
fetch next 1 row only

--maas tablosundan en düsük 4. maas listeleyiniz

select * from maas order by maas desc offset 3 limit 1;


-- DDL --> ALTER TABLE
drop table personel -- Tabloyu ortadan kaldırmak için kullanılır

CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel
-- 1) ADD default deger ile tabloya bir field ekleme

Alter Table personel
add ulke varchar(30)

Alter Table personel
add adres varchar(50) default 'Ankara'

alter table personel
drop ulke -- drop column ulke olarak da yazilabilir

alter table personel
drop ulke, drop isim;

alter table personel
rename isim to ad

alter table personel
rename column sehir to il

--tablo ismini degistirme
alter table personel
rename to isciler

select * from isciler

--5 type/set(modify) sutunlarin ozelliklerini degistirme

alter table isciler
alter column il type varchar(30),
alter column maas set not null;

-- numeric data türünü string bir data türüne cevirme
alter table isciler
alter column maas
type varchar(30) using(maas::varchar(30));


--string data tipini numeric data tipine cevirme
alter table isciler
alter column maas
type int using(maas::int);

DROP table ogrenciler2

-- TRANSACTION (BEGIN-SAVEPOINT-ROLLBACK-COMMIT)
/*
Transaction başlatmak için BEGIN komutu kullanmamız gerekir ve Transaction'ı sonlardık için
COMMIT komutunu çalıştırmalıyız
*/

CREATE TABLE ogrenciler2
(
id serial, -- Serial data türü otomatik olarak 1 den baslayarak sıralı olarak sayı ataması yapar
            -- INSERT INTO ile tabloya veri eklerken serial data türünü kullandığım veri değeri yerine DEFAULT yazarız
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT;

SELECT * from ogrenciler2
delete from ogrenciler2
drop table ogrenciler2
