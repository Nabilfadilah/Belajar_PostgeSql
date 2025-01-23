-- menambah table
create table products(
	id varchar(10) not null,
	name varchar(100) not null,
	description text,
	price int not null,
	quantity int not null default 0,
	created_at timestamp not null default current_timestamp
);

-- menambah kolom baru pada table
ALTER TABLE barang
add column deskripsi text;

-- menghapus kolom pada table
ALTER TABLE barang 
drop column deskripsi;

-- merubah nama kolom pada table
ALTER TABLE barang
rename column name to nama;

-- menghapus semua data pada table
truncate barang;

-- menghapus table
drop table barang;

-- menambah data Sebagian kolom
insert into products(id, name, price, quantity)
values('P0001', 'Mie Ayaram Original', 15000, 100)

-- menambah data semua kolom
insert into products(id, name, description, price, quantity)
values('P0002', 'Mie Ayam Bakso Tahu', 'Mie Ayam Original + Bakse tahu', 20000, 100);

-- menambah data banyak sekaligus
insert into products(id, name, price, quantity)
values('P0003', 'Mie Ayam Ceker', 20000, 100),
      ('P0004', 'Mie Ayam Spesial', 25000, 100),
	  ('P0005', 'Mie Ayam Yamin', 15000, 100);

-- menampilkan semua ata
select * from products;

-- menampilkan data berdasarkan kolom 
select id, name, price, quantity from products;

-- delete data pada table
DELETE FROM products
WHERE id = 'P0002'; -- *where clause

-- menambah id ke table yang sudah ada
alter table products
add primary key (id);

-- mencari data
select id, name, price, quantity
from products
where price = 15000; -- *where clause

-- menambah kolom kategori
create type PRODUCT_CATEGORY as enum ('Makanan', 'Minuman', 'Lain-Lain');

alter table products
add column category PRODUCT_CATEGORY;


-- mengubah satu kolom
update products
set category = 'Makanan'
where id = 'P0001';

-- mengubah beberapa kolom
update products
set category = 'Makanan',
description = 'Mie Ayam + Ceker'
where id = 'P0003';

-- mengubah dengan value di kolom (bisa tambah, kali, kurang / bagi)
update products 
set price = price + 5000
where id = 'P0005'

-- alias untuk kolom
select id as Kode, price as Harga, description as Deskripsi from products;

-- alias untuk table
select p.id as "Kode Barang", 
	p.price as "Harga Barang", 
	p.description as "Deskripsi Barang" 
from products as p;

-- menggunakan where close, yang ada *where

-- mencari data dengan operator perbandingan
select * from products where price > 15000;

-- mencari data dengan operator AND
select * from products where price > 15000 AND category = 'Makanan';

-- mencari data dengan operator OR
select * from products where price > 10000 OR category = 'Minuman';

-- prioritas dengan kurung()
select * from products where (quantity > 100 OR category = 'Makanan') AND price > 10000;
(ambil dulu! data products dimana quantity nya lebih dari 100 atau category nya makanan) tapi kita bandingkan dengan price lebih dari 1000, *tapi dalam kurung harus bernnilai true dulu.

-- mencari menggunakan like operator
select * from products where name ILIKE '%mie%';

-- mencari menggunakan null operator
select * from products where description IS NULL; 

-- mencari menggunakan BETWEEN operator (mencari di antara)
select * from products where price between 10000 and 20000;

-- mencari menggunakan IN operator
select * from products where category IN ('Makanan', 'Minuman');


-- order by clause --
-- mengurutkan data
select * from products ORDER BY price ASC, id DESC; 

-- limit clause -- enak buat paging
-- membatasi hasil query
select * from products where price > 0 ORDER BY price ASC LIMIT 2;

-- skip hasil query
select * from products where price > 0 ORDER BY price ASC LIMIT 2 OFFSET 2;

-- select distinct data
-- menghilangkan data duplikat
select DISTINCT category from products;

-- numeric function
-- menggunakan Arithmetic operator
select 10 + 10 as hasil;
select id, name, price / 1000 as price_in_k from products;

-- mathematical function
select PI();
select POWER(10, 2);
select COS(10), SIN(10), TAN(10);
select id, name, power(quantity, 2) as quantity_power_2 from products;

-- Auto increment
-- membuat table dengan auto increment
create table admin (
	id	SERIAL not null,
	first_name varchar(100) not null,
	last_name varchar(100),
	primary key (id)
);

-- memasukan data tanpa Id
insert into admin(frist_name, last_name)
values('Nabil', 'Fadilah'), ('Arul','Fajri'), ('Buloh','Hapid')

-- melihat Id terakhir
select currval(pg_admin_serial_sequence('admin', 'id'));
select currval('admin_id_seq');

-- sequence
-- membuat sequence
create SEQUENCE contoh_sequence;

-- memanggil sequence, otomatis increment
select NEXTVAL('contoh_sequence');

-- mengambil nilai terakhir sequence
SELECT CURRVAL('contoh_sequence');

-- sequence dari serial
create sequence admin_id_seq;
create table admin (
	id 			INT NOT NULL default nextval('admin_id_seq'),
	first_name	varchar(100),
	last_name	varchar(100),
	PRIMARY KEY (id)
);

-- string function
-- menggunakan string function
select id, LOWER(name), LENGTH(name), LOWER(description) from products;

-- date dan time function
-- menambah kolom timestamp
select id, extract(year from created_at), extract(month from created_at) from products;

-- flow control function
-- menggunakan control flow case
select id, CASE category -- jika category nya
	WHEN 'Makanan' THEN 'Enak' -- adalah makanan maka ubah ke enak
	WHEN 'Minuman' THEN 'Seger'
	ELSE 'Apa itu?' -- jika bukan 
	END as category -- harus ada end dan buat kolom caregory
FROM products;

-- menggunakan operator
select id, price, 
CASE  -- jika category nya id dan price
	WHEN price <= 15000 THEN 'Murah' -- kurang dari 15000 maka murah
	WHEN price <= 20000 THEN 'Mahal' 
	ELSE 'Mahal Banget' -- jika bukan dari ke2 pricenya
	END as murah -- harus ada end dan buat kolom murah
FROM products;

-- menggunakan control flow check Null
select id, name, 
CASE 
	WHEN description IS NULL THEN 'Kosong'
	ELSE description
	END as description
FROM products;

-- aggregate function
-- menggunakan aggregate function 
select COUNT(id) AS "Total Product" FROM products; -- semua total data
select AVG(price) AS "Rata-rata Harga" FROM products; -- rata-rata Harga price
select MAX(price) AS "Harga Termahal" FROM products; -- Harga termahal
select MIN(price) AS "Harga Termurah" FROM products; -- Harga termurah 

 
-- Grupping
-- menggunakan Group By
select category, COUNT(id) as "Total Product"
FROM products GROUP BY category;

select category, 
	avg(price) as "Rata-Rata Harga",
	min(price) as "Harga termurah",
	max(price) as "Harga termahal",
FROM products GROUP BY category;

-- having clause
-- menggunakan having clause
select category, COUNT(id) as total
FROM products
GROUP BY category
HAVING COUNT(id) > 1;
