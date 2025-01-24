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

-----
-- constraint
-- unique constraint
-- membuat table dengan unique constraint
create table customer(
	id 		serial not null,
	email 		varchar(100) not null,
	first_name	varchar(100) not null,
	last_name	varchar(100),
	primary key (id),
	constraint unique_email unique (email)
);


-- menambah/menghapus unique constraint
alter table customer
drop constraint unique_email;

alter table customer           -- menambah bila terlanjur sudah dibuat table
add constraint unique_email unique (email);


-- check constraint 
-- membuat table dengan check constraint
create table products(
	id			varchar(100) not null,
	name		varchar(100) not null,
	description text,
	price		int not null,
	quantity	int not null,
	created_at	timestamp not null default CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	CONSTRAINT price_check CHECK (price >= 1000)
);

-- menambah/menghapus check constraint
alter table products
drop constraint price_check;

alter table products  -- menambah bila terlanjur sudah dibuat table
add constraint price_check CHECK (price >= 1000);

alter table products -- menambah bila terlanjur sudah dibuat table
add constraint quantity_check CHECK (quantity >= 0);

-- index --
-- membuat table
create table sellers(
	id		serial not null,
	name	varchar(100) not null,
	email	varchar(100) not null,
	PRIMARY KEY (id),
	CONSTRAINT email_unique UNIQUE (email)
);

-- mencari dengan index
select * from sellers where id = 1;
select * from sellers where id = 1 OR name 'Toko Toni';
select * from sellers where email = 'jaja@gmail.com';

-- menambah/menghapus Index
create index sellers_id_and_name_index ON sellers(id, name);
create index sellers_email_and_name_index ON sellers(email, name);

-- full-text search
-- mencari tanpa index
select * from products where to_tsvector(name) @@ to_tsquery('mie');

-- fulll-text search index
-- membuat index full-text search
select cfgname from pg_ts_config;
create index products_name_search ON products USING GIN (to_tsvector('indonesian', name));
create index products_description_search ON products USING GIN (to_tsvector('indonesian', description));

drop index products_name_search;
drop index products_description_search;

-- mencari menggunakan fulll-text search
select * from products 
where name @@ to_tsquery('mie');

select * from products 
where description @@ to_tsquery('mie');

-- query operator
-- mencari dengan operator
select * from products
where name @@ to_tsquery('original | bakso');

select * from products
where name @@ to_tsquery('bakso & tahu');

select * from products
where name @@ to_tsquery('!bakso');

-- tipe data TSVECTOR

-- table relationship --
-- membuat table dengan foreign key
create table wishlist(
	id serial not null,
	id_product varchar(10) not null,
	description text,
	primary key (id),
	constraint fk_wishlist_product FOREIGN KEY (id_product) REFERENCES products (id)
);

-- menambah/menghapus foreign key
alter table wishlist
drop constraint fk_wishlist_product;

alter table wishlist -- jika tablenya sudah dibuat tinggal tambah
add constraint fk_wishlist_product FOREIGN KEY (id_product) REFERENCES products (id);

-- mengubah behavior menghapus relasi
alter table wishlist
add CONSTRAINT fk_wishlist_product FOREIGN KEY (id_product) REFERENCES products (id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- contoh menambah data pada table product dan wishlist
insert into products(id, name, price, quantity, category)
values ('XXX', 'Xxx', 10000, 100, 'Minuman');

select * from products;
insert into wishlist(id_product, description) values ('XXX', 'Contoh');

select * from wishlist;

delete from products where id = 'XXX';

-- join --
-- melakukan join table
select * from wishlist JOIN products ON wishlist.id_product = products.id;
select * from wishlist JOIN products ON products.id = wishlist.id_product;

select products.id, products.name, wishlist.description
FROM wishlist JOIN products ON products.id = wishlist.id_product;

-- membuat relasi ke table customers
alter table wishlist ADD COLUMN id_customer INT;

alter table wishlist ADD constraint fk_wishlist_customer FOREIGN KEY (id_customer) REFERENCES customer (id);

-- update table untuk rubah id_customer
select * from customer;
update wishlist 
set id_customer = 1
where id in (2,3);

update wishlist 
set id_customer = 4
where id = 3;

-- Melakukan JOIN Multiple Table
select c.email, p.id, p.name, w.description
from wishlist as w
         join products as p on w.id_product = p.id
         join customer as c on c.id = w.id_customer;


-- one to one relationship --
-- membuat table wallet
create table wallet
(
    id          serial not null,
    id_customer int    not null,
    balance     int    not null default 0,
    primary key (id),
    constraint wallet_customer_unique unique (id_customer),
    constraint fk_wallet_customer foreign key (id_customer) references customer (id)
);

-- relasi one to one
select *
from customer
         join wallet on wallet.id_customer = customer.id;

-- on to many relationship --
-- membuat table category
create table categories
(
    id   varchar(10)  not null,
    name varchar(100) not null,
    primary key (id)
);

-- mengubah table product
alter table products
    add column id_category varchar(10);

alter table products
    add constraint fk_product_category foreign key (id_category) references categories (id);

-- update dulu datanya
update products
set id_category = 'C0001'
where category = 'Makanan';

update products
set id_category = 'C0002'
where category = 'Minuman';

-- terus hapus kolom categorynya
alter table products
    drop column category;

-- relasi on to many
select *
from products
         join categories on products.id_category = categories.id;


-- many to many relationship --
-- membuat table order
create table orders
(
    id         serial    not null,
    total      int       not null,
    order_date timestamp not null default current_timestamp,
    primary key (id)
);

-- membuat table order detail (yang di tengahnya menghubungkan table orders dan product)
create table orders_detail
(
    id_product varchar(10) not null,
    id_order   int         not null,
    price      int         not null,
    quantity   int         not null,
    primary key (id_product, id_order)
);

-- membuat foreign key
alter table orders_detail
    add constraint fk_orders_detail_product foreign key (id_product) references products (id);

alter table orders_detail
    add constraint fk_orders_detail_order foreign key (id_order) references orders (id);

-- terus buat relasinya antar table product dan order
insert into orders_detail (id_product, id_order, price, quantity)
values ('P0001', 1, 1000, 2),
       ('P0003', 1, 1000, 2),
       ('P0004', 1, 1000, 2);

insert into orders_detail (id_product, id_order, price, quantity)
values ('P0005', 2, 1000, 2),
       ('P0006', 2, 1000, 2),
       ('P0007', 2, 1000, 2);

insert into orders_detail (id_product, id_order, price, quantity)
values ('P0001', 3, 1000, 2),
       ('P0004', 3, 1000, 2),
       ('P0005', 3, 1000, 2);

-- melihat data order, detail dan product-nya
select *
from orders
         join orders_detail on orders_detail.id_order = orders.id
         join products on orders_detail.id_product = products.id;

-- saya ingin lihat order 3 aja!
select *
from orders
         join orders_detail on orders_detail.id_order = orders.id
         join products on orders_detail.id_product = products.id
where orders.id = 3;

-- jenis-jenis join --
-- melakukan inner join
select *
from categories
         inner join products on products.id_category = categories.id;

-- melakukan left join
select *
from categories
         left join products on products.id_category = categories.id;

-- melakukan right join
select *
from categories
         right join products on products.id_category = categories.id;

-- melakukan full join
select *
from categories
         full join products on products.id_category = categories.id;

-- Subquery --
-- melakukan subquery di where clause
select *
from products
where price > (select avg(price) from products);

-- melihat rata-rata
select avg(price)
from products;

-- subquery di FROM
-- melakukan subquery di form clause
select *
from products
where price > (select avg(price) from products);


-- set operator --
-- membuat table guest book
create table guestbooks
(
    id      serial       not null,
    email   varchar(100) not null,
    title   varchar(100) not null,
    content text,
    primary key (id)
);

-- union 
-- melakukan query UNION
select distinct email
from customer
union
select distinct email
from guestbooks;

-- melakukan query union all
select email
from customer
union all
select email
from guestbooks;

-- ini untuk grup by nya ada berapa email yang munculnya
select email, count(email)
from (select email
      from customer
      union all
      select email
      from guestbooks) as contoh
group by email;

-- Intersect
select email  -- query pertama
from customer 
intersect 
select email  -- query kedua
from guestbooks;


-- Except
select email  -- query pertama
from customer
except
select email  -- query kedua
from guestbooks;

-- Transaction -- (fitur paling aman Ketika menjalan perintah apapun)
start transaction;

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 2');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 3');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 4');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 5');

commit; -- kalau jadi tambah datanya 
rollback; -- kalau tidak jadi tambah datanya

-- Locking -- mengunci data
-- jika kita belum selesai melakukan proses, belum commit maka proses apapun yang terjadi di data yang sama tidak akan dilakukan, jadi harus menunggu dulu data sebelumnya di commit, baru bisa merubah datanya.

-- locking otomatis
start transaction;

update products
set description = 'Mie ayam original enak'
where id = 'P0001';

select * from products
where id = 'P0001';

commit;

-- locking record manual
start transaction;

select * from products
where id = 'P0001' for update; -- tinggal tambahkan for update, hasilnya sama seperti locing otomatis

rollback;

select * from products
where id = 'P0001';


-- Deadlock (terjadi 2 proses bersamaan yang dilakukan dan menunggu satu sama lain)
start transaction;

select * from products
where id = 'P0001' for update;

select * from products
where id = 'P0003' for update;

rollback;

-- Melihat schema saat ini
select current_schema();
SHOW search_path();

-- Membuat dan menghapus Schema 
create schema contoh;

drop schema contoh; -- hati-hati akan menghapus semua table di schema itu

-- pindah schema
SET search_path TO contoh;

select current_schema();


-- membuat table di schema
create table contoh.products
(
    id   serial       not null,
    name varchar(100) not null,
    primary key (id)
);

-- cara atur sql untuk schema lain yang di luar schema saat ini
select * from contoh.products; -- tinggal sebutkan nama schema nya .+ tablenya

SET search_path TO public;

insert into contoh.products(name)
values ('iphone'),
       ('Play Station');

select * from contoh.products;

-- Role --
-- Membuat atau menghapus User
create ROLE fadilah;
create ROLE qiol;

drop ROLE fadilah;
drop ROLE qiol; 

-- menambah option ke user
alter role fadilah login password 'rahasia';

alter role qiol login password 'rahasia';

-- menambah Hak Akses (agar user tidak sembarangan merubah data)
grant insert, update, select on all tables in schema public to fadilah;
grant usage, select, update ON guestbooks_id_seq TO fadilah;
grant insert, update, select on customer to qiol;

-------------------
cara running server with psql di cmd:
psql --host=localhost --port=5432 --dbname=belajar --username=qiol --password
-------------------

cara backup database:
pg_dump --host=localhost --port=5432 --dbname=belajar --username=postgres --format=plain --file=/Users/Asus/backup.sql

cara restore database, tapi harus buat dulu table datanya:
create database belajar_restore;
psql --host=localhost --port=5432 --dbname=belajar_restore --username=postgres --file=/Users/Asus/backup.sql

