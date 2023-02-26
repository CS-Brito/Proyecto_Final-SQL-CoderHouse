-- En es esta tabla se controlaran los turnos cancelados asi como los nuevos turnos tomados. 
drop table if exists movimiento_turno;
create table movimiento_turno (
id_mov_turno int not null auto_increment,
id_turno int,
informacion varchar(255),
accion varchar(10),
tabla varchar(50),
usuario varchar(100),
fecha date,
hora time,
primary key (id_mov_turno)
);

-- Este disparador insertara el nuestra nueva tabla el turno eliminado
drop trigger if exists eliminar_turno;
delimiter //
create trigger eliminar_turno after delete on turno for each row
begin
	insert into movimiento_turno (id_turno, informacion, accion, tabla, usuario, fecha, hora)
    values (old.id_turno, concat_ws(', ', old.fecha, old.id_empleado, old.id_especialidad, old.id_paciente), 'DELETE', 'TURNO', current_user(), current_date(), current_time());
end//
delimiter ;

-- Este disparador insertara el nuestra nueva tabla el turno solicitado
drop trigger if exists insertar_turno;
delimiter //
create trigger insertar_turno before insert on turno for each row
begin
	insert into movimiento_turno (id_turno, informacion, accion, tabla, usuario, fecha, hora)
    values (new.id_turno, concat_ws(', ', new.fecha, new.id_empleado, new.id_especialidad, new.id_paciente), 'INSERT', 'TURNO', current_user(), current_date(), current_time());
end//
delimiter ;

-- En esta tabla se hara control de la actualizacion de los datos de los paciente
drop table if exists registro_paciente;
create table registro_paciente (
id_reg_paciente int not null auto_increment,
id_paciente int,
info_actual varchar(255),
info_nueva varchar(255),
accion varchar(10),
tabla varchar(50),
usuario varchar(100),
fecha date,
hora time,
primary key (id_reg_paciente)
);

-- Este disparador actualizara la infomacion relacionada a direccion, telefono de contacto y cobertura.
drop trigger if exists actualizacion_paciente;
delimiter //
create trigger actualizacion_paciente before update on paciente for each row
begin
	insert into registro_paciente (id_paciente, info_actual, info_nueva, accion, tabla, usuario, fecha, hora)
    values (old.id_paciente, 
			concat_ws(', ', old.nombre, old.apellido, old.direccion, old.email, old.celular, old.tel_contacto, old.id_cobertura, old.id_provincia),
            concat_ws(', ', new.direccion, new.email, new.celular, new.tel_contacto, new.id_cobertura, new.id_provincia),
            'UPDATE', 'PACIENTE', current_user(), current_date(), current_time());
end//
delimiter ;

