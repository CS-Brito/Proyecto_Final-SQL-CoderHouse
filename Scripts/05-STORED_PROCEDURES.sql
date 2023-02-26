-- Este prodedimiento lo que haces es generar un listado de los empleados con su cargo y a que centro medio pertenecen.
-- El mismo se puede ordenarse de manera ascendente o descendente por las columnas nombre_completo, dni, cargo o centro.
drop procedure if exists sp_empleado;
delimiter //
create procedure sp_empleado (in p_columna char(20),
							  in p_asc_desc char(10)	
							  )
begin
	if p_columna <> '' then
		set @ordenar = concat('order by ', p_columna, ' ', p_asc_desc);
	end if;
    set @clausula = concat('select concat_ws(", ", e.apellido, e.nombre) nombre_completo, 
							e.dni,
                            timestampdiff(year,fecha_nacimiento, curdate()) edad,
                            c.nombre cargo,
                            ce.nombre centro
							from empleado as e
                            inner join cargo as c on c.id_cargo = e.id_cargo
                            inner join centro as ce on ce.id_centro = e.id_centro ', 
                            @ordenar);
    prepare runSQL from @clausula;
    execute runSQL;
    deallocate prepare runSQL;
end//
delimiter ;

-- En procedimiento mediante el id del empleado inserta el registro del empleado despedido en la tabla "empleado_despedido" y luego lo elimina de lta tabla empleado

drop table if exists empleado_despedido;
create table empleado_despedido
like empleado;

drop procedure if exists sp_empleado_despedido;
delimiter //
create procedure sp_empleado_despedido (in p_id_empleado int, out p_mensaje varchar(255))
begin
	declare cantidad int;
    set cantidad = (select count(*) from empleado where id_empleado = p_id_empleado);
	if cantidad > 0 then
		set @despedido = concat('insert into empleado_despedido
								select * from empleado where id_empleado = ', p_id_empleado);
		prepare runSQL from @despedido;
		execute runSQL;
		deallocate prepare runSQL;
        select concat_ws(" ", "El empleado con id", p_id_empleado, "fue despedido") into p_mensaje;
        set @eliminar = concat('delete from empleado where id_empleado = ', p_id_empleado);
        prepare runSQL from @eliminar;
		execute runSQL;
		deallocate prepare runSQL;
	else
		select concat_ws(" ", "El empleado con id", p_id_empleado, "no existe") into p_mensaje;
	end if;

end//
delimiter ;
 
