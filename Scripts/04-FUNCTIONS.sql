-- Esta funcion nos dara a conocer el nombre completo y la edad cada paciente y cada empleado segun su numero de ID
drop function if exists fn_edad_paciente; 
delimiter //
create function fn_edad_paciente (p_paciente int)
returns varchar(100)
deterministic
begin
declare edad_paciente varchar(100);
set edad_paciente =
		(select concat_ws(" ", p.nombre, p.apellido, timestampdiff(year,fecha_nacimiento, curdate()), 'años')
		 from paciente as p
		 where id_paciente = p_paciente
        );
return edad_paciente;
end//
delimiter ;

drop function if exists fn_edad_empleado; 
delimiter //
create function fn_edad_empleado (p_empleado int)
returns varchar(100)
deterministic
begin
declare edad_empleado varchar(100);
set edad_empleado =
		(select concat_ws(" ", e.nombre, e.apellido, timestampdiff(year,e.fecha_nacimiento, curdate()), 'años')
		 from empleado as e
		 where id_empleado = p_empleado
        );
return edad_empleado;
end//
delimiter ;

-- Esta funcion nos dara a conocer el correo y celular para contactar al paciente y confirmar el turno segun el numero de id del turno. 

drop function if exists fn_turno_confirmacion; 
delimiter //
create function fn_turno_confirmacion (p_turno int)
returns varchar(200)
deterministic
begin
declare Turno varchar(200);
set Turno =
		(select concat_ws(" / ", concat(p.apellido,", ", p.nombre), p.email, p.celular, esp.tipo, t.fecha)
		 from turno as t 
         inner join paciente as p on p.id_paciente = t.id_paciente
		 inner join especialidad as esp on esp.id_especialidad = t.id_especialidad
		 inner join empleado as e on e.id_empleado = t.id_empleado
		 where t.id_turno = p_turno
        );
return Turno;
end//
delimiter ;


