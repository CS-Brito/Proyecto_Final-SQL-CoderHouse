-- Informacion de los Centros Medicos
drop view if exists vw_Info_Centros;
create view vw_Info_Centros as
select c.nombre CENTRO, c.direccion DIRECCION, c.email CORREO_ELECTRONICO, c.telefono TELEFONO, p.nombre NOMBRE
from centro as c
inner join provincia as p on p.id_provincia = c.id_provincia;

-- Nombre, apellido y cargo de cada empleado de las SEDE Buenos Aires
drop view if exists vw_Empleados_BuenosAires;
create view vw_Empleados_BuenosAires as
select concat(e.apellido,", ", e.nombre) EMPLEADO, c.nombre CARGO, prov.nombre PROVINCIA
from empleado as e
inner join cargo as c on c.id_cargo = e.id_cargo
inner join provincia as prov on prov.id_provincia = e.id_provincia
where prov.nombre = 'Buenos Aires';

-- Nombre, apellido y cargo de cada empleado de las SEDE Cordoba
drop view if exists vw_Empleados_Cordoba;
create view vw_Empleados_Cordoba as
select concat(e.apellido,", ", e.nombre) EMPLEADO, c.nombre CARGO, prov.nombre PROVINCIA
from empleado as e
inner join cargo as c on c.id_cargo = e.id_cargo
inner join provincia as prov on prov.id_provincia = e.id_provincia
where prov.nombre = 'Cordoba';

-- Nombre, apellido y cargo de cada empleado de las SEDE Santa Fe
drop view if exists vw_Empleados_SantaFe;
create view vw_Empleados_SantaFe as
select concat(e.apellido,", ", e.nombre) EMPLEADO, c.nombre CARGO, prov.nombre PROVINCIA
from empleado as e
inner join cargo as c on c.id_cargo = e.id_cargo
inner join provincia as prov on prov.id_provincia = e.id_provincia
where prov.nombre = 'Santa Fe';

-- Cantidad de pacientes por cobertura.
drop view if exists vw_Cant_Pacientes_por_Cobertura;
create view vw_Cant_Pacientes_por_Cobertura as
select count(p.id_paciente) PACIENTES, cob.nombre COBERTURA
from paciente as p
inner join cobertura as cob on cob.id_cobertura = p.id_cobertura
group by COBERTURA
order by PACIENTES;

-- Detalle de los turnos por fecha detallando paciente, especialidad y medico.
drop view if exists vw_Turnos;
create view vw_Turnos as
select concat(p.apellido,", ", p.nombre) PACIENTE, t.fecha FECHA, esp.tipo ESPECIALIDAD, 
	   concat(e.apellido, ", ", e.nombre) MEDICO
from turno as t
inner join paciente as p on p.id_paciente = t.id_paciente
inner join especialidad as esp on esp.id_especialidad = t.id_especialidad
inner join empleado as e on e.id_empleado = t.id_empleado
order by t.fecha;

-- Detalle de los administrativos que tomaron el turno de los pacientes.
drop view if exists vw_Solicitud_Turnos;
create view vw_Solicitud_Turnos as
select concat(e.apellido,", ", e.nombre) ADMINISTRATIVO, ep.fecha FECHA,
	   concat(p.apellido, ", ", p.nombre) PACIENTE
from empleado_paciente as ep
inner join paciente as p on p.id_paciente = ep.id_paciente
inner join empleado as e on e.id_empleado = ep.id_empleado
order by ep.fecha;

-- Cantidad de turnos solicitados por especialidades en Buenos Aires
drop view if exists vw_Cant_Turno_Buenos_Aires;
create view vw_Cant_Turno_Buenos_Aires as
select count(t.id_paciente) TURNO, esp.tipo ESPECIALIDAD
from turno as t
inner join especialidad as esp on esp.id_especialidad = t.id_especialidad
where t.id_paciente in (select p.id_paciente from paciente as p where p.id_provincia = 1)
group by esp.tipo
;

-- Cantidad de turnos solicitados por especialidades en Cordoba
drop view if exists vw_Cant_Turno_Cordoba;
create view vw_Cant_Turno_Cordoba as
select count(t.id_paciente) TURNO, esp.tipo ESPECIALIDAD
from turno as t
inner join especialidad as esp on esp.id_especialidad = t.id_especialidad
where t.id_paciente in (select p.id_paciente from paciente as p where p.id_provincia = 2)
group by esp.tipo
;

-- Cantidad de turnos solicitados por especialidades en SantaFe
drop view if exists vw_Cant_Turno_SantaFe;
create view vw_Cant_Turno_SantaFe as
select count(t.id_paciente) TURNO, esp.tipo ESPECIALIDAD
from turno as t
inner join especialidad as esp on esp.id_especialidad = t.id_especialidad
where t.id_paciente in (select p.id_paciente from paciente as p where p.id_provincia = 3)
group by esp.tipo
;




