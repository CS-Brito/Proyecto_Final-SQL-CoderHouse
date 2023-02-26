use mysql;

-- Este usuario solo podra leer la infomracion de la base de datos.
drop user if exists 'asisitente_lectura'@'localhost'; 
create user 'asisitente_lectura'@'localhost' identified by 'read1234';

-- Este usuario podra leer, insertar y actualizar informacion de la base de datos.
drop user if exists 'asisitente_actualizacion'@'localhost';
create user 'asisitente_actualizacion'@'localhost' identified by 'update1234';

-- Aqui solo otorgamos poderes de lectura dentro de la base de datos.
grant select on centro_medico_csb2.* to 'asisitente_lectura'@'localhost';

-- Aqui solo otorgamos poderes de lectura, insercion y modificacion dentro de la base de datos.
grant select, insert, update on centro_medico_csb2.* to 'asisitente_actualizacion'@'localhost';

