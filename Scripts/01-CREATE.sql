drop schema if exists Centro_Medico_CSB2;
create schema if not exists Centro_Medico_CSB2;
use Centro_Medico_CSB2;

-- Esta tabla corresponde a los paises donde seran instalados los centros medicos
drop table if exists Pais;
create table if not exists Pais (
id_pais int not null auto_increment,
nombre 	text (50) not null,
primary key (id_pais)
);

-- Esta tabla va determinar las provincias relacionadas a los paises donde seran instaldos los centros medicos
drop table if exists Provincia;
create table if not exists Provincia (
id_provincia int not null auto_increment,
nombre text (50) not null,
id_pais int not null,
primary key (id_provincia),
constraint Provincia_Pais foreign key (id_pais) references pais (id_pais) on delete cascade
);

-- Esta tabla va determinar el cargo de cada uno de los empleados. Los cargos seran director, medico y administrativos.
drop table if exists Cargo;
create table if not exists Cargo (
id_cargo int not null auto_increment,
nombre text (20) not null,
primary key (id_cargo)
);

-- Esta tabla tengra la informacion general de los centros medicos
-- Primero seran estructurados en Argentina con la idea de exterder sus servicios en Uruguay y Brasil.
drop table if exists Centro;
create table if not exists Centro (
id_centro int not null auto_increment,
nombre text (100) not null,
direccion varchar (200) not null,
email varchar (50) not null,
telefono varchar (30) not null,
url varchar (50) not null,
id_provincia int not null,
primary key (id_centro),
constraint Centro_Provincia foreign key (id_provincia) references Provincia (id_provincia) on delete cascade
);

-- Esta tabla va determinar las tipo de cobertura que tendra cada una de las obras sociales y prepagas.
drop table if exists Tipo_Cobertura;
create table if not exists Tipo_Cobertura (
id_tipo_cob int not null auto_increment,
tipo varchar (50) not null,
primary key (id_tipo_cob)
);

-- Esta tabla va determinar el nombre de cada una de las coberturas de obras sociales prepagas aceptadas en los centros medicos.
drop table if exists Cobertura;
create table if not exists Cobertura (
id_cobertura int not null auto_increment,
nombre text (50) not null,
id_tipo_cob int not null,
primary key (id_cobertura),
constraint Cobertura_TipoCob foreign key (id_tipo_cob) references Tipo_Cobertura (id_tipo_cob) on delete cascade
);

-- Esta tabla va contener todo la informacion de los empleados de los centros asi como su horario de entrada y salida.
drop table if exists Empleado;
create table if not exists Empleado (
id_empleado int not null auto_increment,
nombre text (50) not null,
apellido text (50) not null,
dni int not null,
fecha_nacimiento date not null,
direccion varchar (100) not null,
email varchar (50) not null,
celular varchar (30) not null,
tel_contacto varchar (30) not null,
ingreso time not null,
salida time not null,
id_centro int not null,
id_cargo int not null,
id_provincia int not null,
primary key (id_empleado),
constraint Empleado_Centro foreign key (id_centro) references Centro (id_centro) on delete cascade,
constraint Empleado_Cargo foreign key (id_cargo) references Cargo (id_cargo) on delete cascade,
constraint Empleado_Provincia foreign key (id_provincia) references Provincia (id_provincia) on delete cascade
);

-- Esta sera utilizada para el registro de todos los pacientes que desean ser atendidos en los distintos centros.
drop table if exists Paciente;
create table if not exists Paciente (
id_paciente int not null auto_increment,
nombre text (50) not null,
apellido text (50) not null,
dni int not null,
fecha_nacimiento date not null,
direccion varchar (100) not null,
email varchar (50) not null,
celular varchar (30) not null,
tel_contacto varchar (30) not null,
id_cobertura int not null,
id_provincia int not null,
primary key (id_paciente),
constraint Paciente_Cobertura foreign key (id_cobertura) references Cobertura (id_cobertura) on delete cascade,
constraint Paciente_Provincia foreign key (id_provincia) references Provincia (id_provincia) on delete cascade
);

-- En esta tabla podremos relacionar que socicos fueron atendidos por ciertos medicos y que medicos atendieron a ciertos socios
drop table if exists Empleado_Paciente;
create table if not exists Empleado_Paciente (
id_emp_pac int not null auto_increment,
id_empleado int not null,
id_paciente int not null,
fecha datetime not null,
primary key (id_emp_pac),
constraint Empleado_Paciente foreign key (id_empleado) references Empleado (id_empleado) on delete cascade,
constraint Paciente_Empleado foreign key (id_paciente) references Paciente (id_paciente) on delete cascade
);

-- Esta tabla va contener todas las especialidades que seran atendidas en los diferentes centros y el medico que la llevara a cabo.
drop table if exists Especialidad;
create table if not exists Especialidad (
id_especialidad int not null auto_increment,
tipo varchar(30) not null,
primary key (id_especialidad)
);

-- En esta tabla va quedar registrado los turnos que se asignen a cada uno de los pacientes.
drop table if exists Turno;
create table if not exists Turno (
id_turno int not null auto_increment,
fecha datetime not null,
id_empleado int not null,
id_especialidad int not null,
id_paciente int not null,
primary key (id_turno),
CONSTRAINT Turno_Empleado FOREIGN KEY (id_empleado) REFERENCES Empleado (id_empleado) on delete cascade,
constraint Turno_Especialidad foreign key (id_especialidad) references Especialidad (id_especialidad) on delete cascade,
constraint Turno_Paciente foreign key (id_paciente) references Paciente (id_paciente) on delete cascade
);