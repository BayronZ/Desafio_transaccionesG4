-- 1. Cargar el respaldo de la base de datos unidad2.sql. (2 Puntos)
--Se elimino el autocmmit
-- bill_jobs=# \set AUTOCOMMIT OFF
-- bill_jobs=# \echo :AUTOCOMMIT
-- OFF

--Se creó la base de datos
--mrcoco=# CREATE DATABASE bill_jobs;
-- CREATE DATABASE

-- Se cargó el archivo unidad2.sql
--psql -U mrcoco bill_jobs < unidad2.sql
-- SET
-- SET
-- SET
-- SET
-- SET
--  set_config 
-- ------------
-- (1 row)

-- 2. El cliente usuario01 ha realizado la siguiente compra:
-- ● producto: producto9.
-- ● cantidad: 5.
-- ● fecha: fecha del sistema.
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este
-- requerimiento y luego consulta la tabla producto para validar si fue efectivamente
-- descontado en el stock. (3 Puntos)
--Se mostró la tabla producto
SELECT * FROM producto;
bill_jobs=# SELECT * FROM producto;
 id | descripcion | stock | precio 
----+-------------+-------+--------
  3 | producto3   |     9 |   9449
  4 | producto4   |     8 |    194
  5 | producto5   |    10 |   3764
  6 | producto6   |     6 |   8655
  7 | producto7   |     4 |   2875
 10 | producto10  |     1 |   3001
 11 | producto11  |     9 |   7993
 12 | producto12  |     3 |   8504
 13 | producto13  |    10 |   2415
 14 | producto14  |     5 |   3824
 15 | producto15  |    10 |   7358
 16 | producto16  |     7 |   3631
 17 | producto17  |     3 |   4467
 18 | producto18  |     2 |   9383q
 19 | producto19  |     6 |   1140
 20 | producto20  |     4 |    102
  9 | producto9   |     8 |   4219
  1 | producto1   |     6 |   9107
  2 | producto2   |     5 |   1760
  8 | producto8   |     0 |   8923
(20 rows)

-- Se realizó la transaccion
BEGIN; INSERT INTO compra (cliente_id,fecha) 
VALUES(1,CURRENT_DATE); 
INSERT INTO detalle_compra(producto_id, compra_id, cantidad) 
VALUES(9,32,5); 
UPDATE producto SET stock = stock - 5 WHERE id = 9; 
COMMIT;

--Se consultó la tabla producto después de la transaccion


 id | descripcion | stock | precio 
----+-------------+-------+--------
  3 | producto3   |     9 |   9449
  4 | producto4   |     8 |    194
  5 | producto5   |    10 |   3764
  6 | producto6   |     6 |   8655
  7 | producto7   |     4 |   2875
 10 | producto10  |     1 |   3001
 11 | producto11  |     9 |   7993
 12 | producto12  |     3 |   8504
 13 | producto13  |    10 |   2415
 14 | producto14  |     5 |   3824
 15 | producto15  |    10 |   7358
 16 | producto16  |     7 |   3631
 17 | producto17  |     3 |   4467
 18 | producto18  |     2 |   9383
 19 | producto19  |     6 |   1140
 20 | producto20  |     4 |    102
  1 | producto1   |     6 |   9107
  2 | producto2   |     5 |   1760
  8 | producto8   |     0 |   8923
  9 | producto9   |     3 |   4219
(20 rows)

-- 3. El cliente usuario02 ha realizado la siguiente compra:
-- ● producto: producto1, producto 2, producto 8.
-- ● cantidad: 3 de cada producto.
-- ● fecha: fecha del sistema.
-- Mediante el uso de transacciones, realiza las consultas          correspondientes para este
-- requerimiento y luego consulta la tabla producto para validar que si alguno de ellos
-- se queda sin stock, no se realice la compra. (3 Puntos)

--se realizo la transaccion del producto 1
-- además de un savepoint para realizar un rollback en caso de que no haya stock

BEGIN; INSERT INTO compra (cliente_id,fecha) 
VALUES(2,CURRENT_DATE); 
INSERT INTO detalle_compra(producto_id, compra_id, cantidad) 
VALUES(1,33,3); 
UPDATE producto SET stock = stock - 3 WHERE id = 1;
SAVEPOINT checkpoint; 


-- Se trae la tabla productos
bill_jobs=# SELECT * FROM producto;
id | descripcion | stock | precio 
----+-------------+-------+--------
  3 | producto3   |     9 |   9449 
  4 | producto4   |     8 |    194
  5 | producto5   |    10 |   3764
  6 | producto6   |     6 |   8655
  7 | producto7   |     4 |   2875
 10 | producto10  |     1 |   3001
 11 | producto11  |     9 |   7993
 12 | producto12  |     3 |   8504
 13 | producto13  |    10 |   2415
 14 | producto14  |     5 |   3824
 15 | producto15  |    10 |   7358
 16 | producto16  |     7 |   3631
 17 | producto17  |     3 |   4467
 18 | producto18  |     2 |   9383
 19 | producto19  |     6 |   1140
 20 | producto20  |     4 |    102
  2 | producto2   |     5 |   1760
  8 | producto8   |     0 |   8923
  9 | producto9   |     3 |   4219
  1 | producto1   |     3 |   9107
(20 rows)

-- donde se observa que si se descontaron 3 al stock del producto 1

-- se realiza la transaccion al producto 2
 BEGIN; INSERT INTO compra (cliente_id,fecha) 
 VALUES(2,CURRENT_DATE); 
 INSERT INTO detalle_compra(producto_id, compra_id, cantidad)
 VALUES(2,43,3); 
 UPDATE producto SET stock = stock - 3 WHERE id = 2;
--Se trae la tabla producto después de la transacion

 id | descripcion | stock | precio 
----+-------------+-------+--------
  3 | producto3   |     9 |   9449 
  4 | producto4   |     8 |    194 
  5 | producto5   |    10 |   3764 
  6 | producto6   |     6 |   8655 
  7 | producto7   |     4 |   2875 
 10 | producto10  |     1 |   3001 
 11 | producto11  |     9 |   7993 
 12 | producto12  |     3 |   8504 
 13 | producto13  |    10 |   2415 
 14 | producto14  |     5 |   3824 
 15 | producto15  |    10 |   7358 
 16 | producto16  |     7 |   3631
 17 | producto17  |     3 |   4467
 18 | producto18  |     2 |   9383
 19 | producto19  |     6 |   1140
 20 | producto20  |     4 |    102
  8 | producto8   |     0 |   8923
  9 | producto9   |     3 |   4219
  1 | producto1   |     3 |   9107
  2 | producto2   |     2 |   1760
(20 rows)

--Se realiza la transacción para el producto 8
