use master
go

create database ETIQUETAS
go

Use ETIQUETAS
go

--CREACION DE TABLAS

create table PERSONAS
(
NroDoc int not null,
TipoDoc varchar(20) not null,
Apellido varchar(50) not null,
Nombre varchar(50) not null,
Provincia varchar(30) null,
Localidad varchar(30) null,
Direccion varchar(50) null, 
Telefono int null,
Celular int null, 
Email varchar(50) null,
Sexo char(1) check (Sexo in ('F','M')) null, 
EstadoCivil varchar(20) check (EstadoCivil in ('Soltero','Casado','Divorciado','Viudo')) null, 
Nacionalidad varchar(50) null,
Suspendido bit not null default 0, -- 0 false, 1 true
constraint PK_personas_NroDoc_TipoDoc primary key(NroDoc,TipoDoc)
)
go

create table CARRERAS
(
CodigoCarrera char(3) not null,
Descripcion varchar(50) not null,
Suspendido bit not null default 0,
constraint PK_carreras_CodigoCarrera primary key (CodigoCarrera)
)
go

create table PERMISOS --ESTA NO SE PUEDE ADULTERAR
(
TipoUsuario varchar(20) check (TipoUsuario in ('Lectura','Administrador')) default 'Administrador' not null,
DescripcionPermiso varchar(50) not null,
constraint PK_carreras_TipoUsuario primary key(TipoUsuario)
)
go



create table USSUARIOS
(
Usuario varchar(50) not null,
NroDoc int not null,
TipoDoc varchar(20) not null, 
TipoUsuario varchar(20) not null,
Contrasenia varchar(10) not null, 
FechaAlta date not null, 
FechaBaja date null,
CausaBaja varchar(50) null, 
Suspendido bit not null default 0,
constraint PK_usuarios_Usuario primary key(Usuario),
constraint FK_usuarios_TipoUsuario foreign key (TipoUsuario) references PERMISOS(TipoUsuario), --
constraint FK_usuarios_NroDoc_TipoDoc foreign key (NroDoc,TipoDoc) references PERSONAS(NroDoc,TipoDoc) --
)
go


create table DOCENTES
(IdDocente int identity(1,1),
NroDoc int not null,
TipoDoc varchar(20) not null, 
Legajo int null,
Suspendido bit not null default 0,
constraint PK_docentes_IdDocente primary key (IdDocente),
constraint FK_docentes_NroDoc_TipoDoc foreign key (NroDoc,TipoDoc) references PERSONAS(NroDoc,TipoDoc) --
)
go

create table DEPARTAMENTOS
(
IdDepartamento int identity(1,1),
Descripcion varchar(50) not null,
Suspendido bit not null default 0,
constraint PK_departamentos_IdDepartamento primary key (IdDepartamento)
)
go

create table CURSADAS
(
Cursada char(20) not null,
FechaInicio date not null,
FechaFin date not null,
Observaciones varchar(50) null,
Suspendido bit not null default 0,
constraint PK_cursadas_Cursada primary key (Cursada)
)
go

create table MATERIAS
(
CodigoCarrera char(3) not null,
CodigoMateria char(3) not null,
Descripcion varchar(50) not null,
TipoPlan varchar(50) null,
Cursada char(20) not null,
Suspendido bit not null default 0,
constraint PK_materias_CodigoCarrera_CodigoMateria primary key (CodigoCarrera,CodigoMateria),
constraint FK_materias_CodigoCarrera foreign key (CodigoCarrera) references CARRERAS(CodigoCarrera), --
constraint FK_materias_Cursada foreign key (Cursada) references CURSADAS(Cursada) --
)
go

create table DIAS --ESTA NO SE PUEDE ADULTERAR
(
Dia char(10) not null,
constraint PK_dias_Dia primary key (Dia)
)
go

create table HORAS --ESTA NO SE PUEDE ADULTERAR
(
Hora char(2) not null,
constraint PK_horas_Hora primary key (Hora)
)
go

create table MINUTOS --ESTA NO SE PUEDE ADULTERAR
(
Minuto char(3) not null,
constraint PK_minutos_Minuto primary key (Minuto)
)
go

create table HORARIOS
(
CodHorario int identity(1,1),
HoraInicio char(2) not null,
MinutoInicio char(3) not null, 
HoraFin char(2) not null,
MinutoFin char(3) not null,
Suspendido bit not null default 0,
constraint PK_horario_CodHorario primary key (CodHorario),
constraint FK_horario_HoraInicio foreign key (HoraInicio) references HORAS(Hora), --
constraint FK_horario_MinutoInicio foreign key (MinutoInicio) references MINUTOS(Minuto), --
constraint FK_horario_HoraFin foreign key (HoraFin) references HORAS(Hora), --
constraint FK_horario_MinutoFin foreign key (MinutoFin) references MINUTOS(Minuto) --
)
go

create table DIAS_CURSOS
(
CodigoCarrera char(3) not null,
CodigoMateria char(3) not null,
Anio char(4) not null,
Cursada char(20) not null,
Dia char(10) not null,
CodHorario int not null,
Suspendido bit not null default 0,
constraint PK_diascursos_claveprimaria primary key (CodigoCarrera,CodigoMateria,Anio,Cursada,Dia,CodHorario),
constraint FK_diascursos_CodigoCarrera_CodigoMateria foreign key (CodigoCarrera, CodigoMateria) references MATERIAS(CodigoCarrera,CodigoMateria), --
constraint FK_diascursos_Cursada foreign key (Cursada) references CURSADAS(Cursada), --
constraint FK_diascursos_Dia foreign key (Dia) references DIAS(Dia), --
constraint FK_diascursos_CodHorario foreign key (CodHorario) references HORARIOS(CodHorario)--
)
go

create table TURNOS
(
Turno char(10) not null,
CodHorario int not null,
Suspendido bit not null default 0,
constraint PK_turnos_Turno primary key (Turno),
constraint FK_turnos_CodHorario foreign key (CodHorario) references HORARIOS(CodHorario) --
)
go

create table CURSOS
(
CodigoCarrera char(3) not null,
CodigoMateria char(3) not null,
Anio char(4) not null,
Cursada char(20) not null,
Turno char(10) not null,
IdDocente int not null,
IdDepartamento int not null,
Curso char(4) not null,
Suspendido bit not null default 0,
constraint PK_cursos_claveprimaria primary key (CodigoCarrera,CodigoMateria,Anio,Cursada,Turno,IdDocente),
constraint FK_cursos_CodigoCarrera_CodigoMateria foreign key (CodigoCarrera, CodigoMateria) references MATERIAS(CodigoCarrera,CodigoMateria), --
constraint FK_cursos_Cursada foreign key (Cursada) references CURSADAS(Cursada), --
constraint FK_cursos_Turno foreign key (Turno) references TURNOS(Turno), --
constraint FK_cursos_IdDocente foreign key (IdDocente) references DOCENTES(IdDocente), --
constraint FK_cursos_IdDepartamento foreign key (IdDepartamento) references DEPARTAMENTOS(IdDepartamento) --
)
go

-------------------------------------------------------------------------------------------------------------------------------

--INSERCION DE DATOS

insert into PERMISOS(TipoUsuario,DescripcionPermiso)
select 'Administrador', 'Lectura, Ingreso, Modificacion, Eliminacion' union
select 'Lectura', 'Solo Lectura'
go

insert into PERSONAS
(NroDoc,
TipoDoc,
Apellido,
Nombre)
select 1, 'DNI', 'UTN', 'Programador' union
select 2, 'DNI', 'UTN' , 'Lector'
go


insert into USSUARIOS
(Usuario,
NroDoc,
TipoDoc,
TipoUsuario,
Contrasenia,
FechaAlta
)
select 'Programador', 1, 'DNI', 'Administrador', 'utn', GETDATE() union
select 'Lector' , 2, 'DNI' , 'Lectura' , '123' , GETDATE()
go

insert into DIAS(Dia)
select 'Lunes' union
select 'Martes' union
select 'Miercoles' union
select 'Jueves' union
select 'Viernes' union
select 'Sabado'
go

insert into HORAS(Hora)
select '00' union
select '01' union
select '02' union
select '03' union
select '04' union
select '05' union
select '06' union
select '07' union
select '08' union
select '09' union
select '10' union
select '11' union
select '12' union
select '13' union
select '14' union
select '15' union
select '16' union
select '17' union
select '18' union
select '19' union
select '20' union
select '21' union
select '22' union
select '23'
go

insert into MINUTOS(Minuto)
select ':00' union
select ':05' union
select ':10' union
select ':15' union
select ':20' union
select ':25' union
select ':30' union
select ':35' union
select ':40' union
select ':45' union
select ':50' union
select ':55' 
go

insert into HORARIOS(HoraInicio, MinutoInicio, HoraFin, MinutoFin)
select '08', ':00', '12', ':00' union
select '13', ':00', '17', ':00' union
select '18', ':00', '22', ':00'
go

insert into TURNOS(Turno,CodHorario)
select 'Mañana', 1 union
select 'Tarde',  2 union
select 'Noche',  3
go

----------------------------------------------------------------------------------------------------------------------------

--PROCEDIMIENTOS ALMACENADOS

--Procedimientos de Ingreso

use ETIQUETAS
go

create procedure SP_Ingresar_Persona
@NroDoc int,
@TipoDoc varchar(20),
@Apellido varchar(50),
@Nombre varchar(50),
@Provincia varchar(30),
@Localidad varchar(30),
@Direccion varchar (30),
@Telefono int,
@Celular int,
@Email varchar(50),
@Sexo char(1),
@EstadoCivil varchar(20),
@Nacionalidad varchar(50)
as
insert into PERSONAS
(
NroDoc,
TipoDoc,
Apellido,
Nombre,
Provincia,
Localidad,
Direccion,
Telefono,
Celular,
Email,
Sexo,
EstadoCivil,
Nacionalidad
)
values (
@NroDoc,
@TipoDoc,
@Apellido,
@Nombre,
@Provincia,
@Localidad,
@Direccion,
@Telefono,
@Celular,
@Email,
@Sexo,
@EstadoCivil,
@Nacionalidad
)
go


create procedure SP_Ingresar_Carrera
@CodigoCarrera char(3),
@Descripcion varchar(50)
as
insert into CARRERAS
(
CodigoCarrera,
Descripcion
)
values
(
@CodigoCarrera,
@Descripcion
)
go




create procedure SP_Ingresar_Usuario
@Usuario varchar(50),
@NroDoc int,
@TipoDoc varchar(20),
@TipoUsuario varchar(20),
@Contrasenia varchar(10)
as
insert into USSUARIOS
(
Usuario,
NroDoc,
TipoDoc,
TipoUsuario,
Contrasenia, 
FechaAlta
)
values
(
@Usuario,
@NroDoc,
@TipoDoc,
@TipoUsuario,
@Contrasenia,
GETDATE()
)
go

create procedure SP_Ingresar_Docente
@NroDoc int,
@TipoDoc varchar(20),
@Legajo int
as
insert into DOCENTES
(
NroDoc,
TipoDoc,
Legajo
)
values
(
@NroDoc,
@TipoDoc,
@Legajo
)
go


create procedure SP_Ingresar_Departamento
@Descripcion varchar(50)
as
insert into DEPARTAMENTOS
(
Descripcion
)
values
(
@Descripcion
)
go

create procedure SP_Ingresar_Cursada
@Cursada char(20),
@FechaInicio date,
@FechaFin date, 
@Observaciones varchar(50)
as
insert into CURSADAS
(
Cursada,
FechaInicio,
FechaFin,
Observaciones
)
values
(
@Cursada,
@FechaInicio,
@FechaFin,
@Observaciones
)
go

create procedure SP_Ingresar_Materia
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Descripcion varchar(50),
@TipoPlan varchar(50),
@Cursada char(20)
as
insert into MATERIAS
(
CodigoCarrera,
CodigoMateria,
Descripcion,
TipoPlan,
Cursada
)
values
(
@CodigoCarrera,
@CodigoMateria,
@Descripcion,
@TipoPlan,
@Cursada
)
go

create procedure SP_Ingresar_Horario
@HoraInicio char(2),
@MinutoInicio char(3),
@HoraFin char(2),
@MinutoFin char(3)
as
insert into HORARIOS
(
HoraInicio,
MinutoInicio,
HoraFin,
MinutoFin
)
values
(
@HoraInicio,
@MinutoInicio,
@HoraFin,
@MinutoFin
)
go

create procedure SP_Ingresar_Dia_Curso
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Anio char(4),
@Cursada char(20),
@Dia char(10),
@CodHorario int
as
insert into DIAS_CURSOS
(
CodigoCarrera,
CodigoMateria,
Anio,
Cursada,
Dia,
CodHorario
)
values
(
@CodigoCarrera,
@CodigoMateria,
@Anio,
@Cursada,
@Dia,
@CodHorario
)
go


create procedure SP_Ingresar_Curso
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Anio char(4),
@Cursada char(20),
@Turno char(10),
@IdDocente int,
@IdDepartamento int,
@Curso char(4)
as
insert into CURSOS
(
CodigoCarrera,
CodigoMateria,
Anio,
Cursada,
Turno,
IdDocente,
IdDepartamento,
Curso
)
values
(
@CodigoCarrera,
@CodigoMateria,
@Anio,
@Cursada,
@Turno,
@IdDocente,
@IdDepartamento,
@Curso
)
go



--Procedimientos de Suspender. 

--Para esta BD, NO SE PUEDEN BORRAR DATOS DE LAS TABLAS. SOLO CAMBIAR SU ESTADO SUSPENDIDO A TRUE

create procedure SP_Suspender_Persona
@NroDoc int,
@TipoDoc varchar(20)
as
update PERSONAS 
set Suspendido = 1
where NroDoc = @NroDoc and TipoDoc = @TipoDoc
go

create procedure SP_Suspender_Carrera
@CodigoCarrera char(3)
as
update CARRERAS
set Suspendido = 1
where CodigoCarrera = @CodigoCarrera
go



create procedure SP_Suspender_Usuario
@Usuario varchar(50),
@CausaBaja varchar(50)
as
update USSUARIOS
set Suspendido = 1, 
FechaBaja = GETDATE(),
CausaBaja = @CausaBaja
where Usuario = @Usuario
go

create procedure SP_Suspender_Docente
@IdDocente int
as
update DOCENTES
set Suspendido = 1
where IdDocente = @IdDocente
go


create procedure SP_Suspender_Departamento
@IdDepartamento int
as
update DEPARTAMENTOS
set Suspendido = 1
where IdDepartamento = @IdDepartamento
go


create procedure SP_Suspender_Cursada
@Cursada char(20)
as
update CURSADAS
set Suspendido = 1
where Cursada = @Cursada
go

create procedure SP_Suspender_Materia
@CodigoCarrera char(3),
@CodigoMateria char(3)
as
update MATERIAS
set Suspendido = 1
where CodigoCarrera = @CodigoCarrera and CodigoMateria = @CodigoMateria
go


create procedure SP_Suspender_Horario
@CodHorario int
as
update HORARIOS
set Suspendido = 1
where CodHorario = @CodHorario
go


create procedure SP_Suspender_Dia_Curso
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Anio char(4),
@Cursada char(20),
@Dia char(10),
@CodHorario int
as
update DIAS_CURSOS
set Suspendido = 1
where CodigoCarrera = @CodigoCarrera and CodigoMateria = @CodigoMateria and Anio = @Anio and Cursada = @Cursada and Dia = @Dia and CodHorario = @CodHorario
go


create procedure SP_Suspender_Turno
@Turno char(10)
as
update TURNOS
set Suspendido = 1
where Turno = @Turno
go


create procedure SP_Suspender_Curso
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Anio char(4),
@Cursada char(20),
@Turno char(10),
@IdDocente int
as
update CURSOS
set Suspendido = 1
where CodigoCarrera = @CodigoCarrera and CodigoMateria = @CodigoMateria and Anio = @Anio and Cursada = @Cursada and Turno = @Turno and IdDocente = @IdDocente
go


--Procedimientos para Actualizar

create procedure SP_Actualizar_Persona
@NroDoc int,
@TipoDoc varchar(20),
@Apellido varchar(50),
@Nombre varchar(50),
@Provincia varchar(30),
@Localidad varchar(30),
@Direccion varchar (30),
@Telefono int,
@Celular int,
@Email varchar(50),
@Sexo char(1),
@EstadoCivil varchar(20),
@Nacionalidad varchar(50)
as
update PERSONAS
set 
Apellido = @Apellido,
Nombre = @Nombre,
Provincia = @Provincia,
Localidad = @Localidad,
Direccion = @Direccion,
Telefono = @Telefono,
Celular = @Celular,
Email = @Email,
Sexo = @Sexo,
EstadoCivil = @EstadoCivil,
Nacionalidad = @Nacionalidad
where NroDoc = @NroDoc and TipoDoc = @TipoDoc
go


create procedure SP_Actualizar_Carrera
@CodigoCarrera char(3),
@Descripcion varchar(50)
as
update CARRERAS
set Descripcion = @Descripcion
where CodigoCarrera = @CodigoCarrera
go


create procedure SP_Actualizar_Usuario
@Usuario varchar(50),
@NroDoc int,
@TipoDoc varchar(20),
@TipoUsuario varchar(20),
@Contrasenia varchar(10)
as
update USSUARIOS
set NroDoc = @NroDoc,
TipoDoc = @TipoDoc,
TipoUsuario = @TipoUsuario,
Contrasenia = @Contrasenia 
where Usuario = @Usuario
go


create procedure SP_Actualizar_Docente
@IdDocente int,
@NroDoc int,
@TipoDoc varchar(20),
@Legajo int
as
update DOCENTES
set NroDoc = @NroDoc,
TipoDoc = @TipoDoc,
Legajo = @Legajo
where IdDocente = @IdDocente
go


create procedure SP_Actualizar_Departamento
@IdDepartamento int,
@Descripcion varchar(50)
as
update DEPARTAMENTOS
set Descripcion = @Descripcion
where IdDepartamento = @IdDepartamento
go


create procedure SP_Actualizar_Cursada
@Cursada char(20),
@FechaInicio date,
@FechaFin date, 
@Observaciones varchar(50)
as
update CURSADAS
set FechaInicio = @FechaInicio,
FechaFin = @FechaFin,
Observaciones = @Observaciones
where Cursada = @Cursada
go

create procedure SP_Actualizar_Materia
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Descripcion varchar(50),
@TipoPlan varchar(50),
@Cursada char(20)
as
update MATERIAS
set Descripcion = @Descripcion,
TipoPlan = @TipoPlan,
Cursada = @Cursada
where CodigoCarrera = @CodigoCarrera and CodigoMateria = @CodigoMateria
go

--La Tabla Horarios NO conviene actualizarla, solo ingresar o suspender

create procedure SP_Actualizar_Dia_Curso
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Anio char(4),
@Cursada char(20),
@Dia char(10),
@CodHorario int
as
update DIAS_CURSOS
set Dia = @Dia,
CodHorario = @CodHorario
where CodigoCarrera = @CodigoCarrera and CodigoMateria = @CodigoMateria and Anio = @Anio and Cursada = @Cursada 
go

create procedure SP_Actualizar_Curso
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Anio char(4),
@Cursada char(20),
@Turno char(10),
@IdDocente int,
@IdDepartamento int,
@Curso char(4)
as
update CURSOS
set  IdDepartamento = @IdDepartamento,
Curso = @Curso
where CodigoCarrera = @CodigoCarrera and CodigoMateria = @CodigoMateria and Anio = @Anio and Cursada = @Cursada and Turno = @Turno and IdDocente = @IdDocente
go

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--TRIGGERS

CREATE TRIGGER TR_SEGURIDAD_TABLAS
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE
AS 
RAISERROR ('No está permitido borrar ni modificar tablas.' , 16, 1)
ROLLBACK TRANSACTION 
go

create trigger TR_Seguridad_Triggers
on database
for drop_trigger,alter_trigger
AS 
SET NOCOUNT ON;
RAISERROR ('No está permitido borrar ni modificar triggers.' , 16, 1)
ROLLBACK TRANSACTION 
go

create trigger TR_Seguridad_SP
on database
for drop_procedure, alter_procedure
AS 
SET NOCOUNT ON;
RAISERROR ('No está permitido borrar ni modificar procedimientos almacenados.' , 16, 1)
ROLLBACK TRANSACTION 
go


create trigger TR_Borrar_Persona
on PERSONAS
after delete
as
set nocount on;
declare 
@NroDoc int,
@TipoDoc varchar(20),
@Apellido varchar(50),
@Nombre varchar(50),
@Provincia varchar(30),
@Localidad varchar(30),
@Direccion varchar (30),
@Telefono int,
@Celular int,
@Email varchar(50),
@Sexo char(1),
@EstadoCivil varchar(20),
@Nacionalidad varchar(50);

select 
@NroDoc = NroDoc,
@TipoDoc = TipoDoc,
@Apellido = Apellido,
@Nombre = Nombre,
@Provincia = Provincia,
@Localidad = Localidad,
@Direccion = Direccion,
@Telefono = Telefono,
@Celular = Celular,
@Email = Email,
@Sexo = Sexo,
@EstadoCivil = EstadoCivil,
@Nacionalidad = Nacionalidad
from Deleted

insert into PERSONAS
(
NroDoc,
TipoDoc,
Apellido,
Nombre,
Provincia,
Localidad,
Direccion,
Telefono,
Celular,
Email,
Sexo,
EstadoCivil,
Nacionalidad,
Suspendido
)
values
(
@NroDoc,
@TipoDoc,
@Apellido,
@Nombre,
@Provincia,
@Localidad,
@Direccion,
@Telefono,
@Celular,
@Email,
@Sexo,
@EstadoCivil,
@Nacionalidad,
1 --true 
)
go

create trigger TR_Borrar_Carrera
on CARRERAS
after delete
as
set nocount on;
declare 
@CodigoCarrera char(3),
@Descripcion varchar(50);

select
@CodigoCarrera = CodigoCarrera,
@Descripcion = Descripcion
from 
Deleted

insert into CARRERAS
(
CodigoCarrera,
Descripcion,
Suspendido
)
values
(
@CodigoCarrera,
@Descripcion,
1
)
go


create trigger TR_Borrar_Permiso
on PERMISOS
instead of delete
as
raiserror ('No está permitido Borrar Permisos',16,1)
rollback
go

create trigger TR_Actualizar_Permiso
on PERMISOS
instead of update
as
raiserror ('No está permitido Actualizar Permisos',16,1)
rollback
go


create trigger TR_Borrar_Usuario
on USSUARIOS
after delete
as
set nocount on;
declare
@Usuario varchar(50),
@NroDoc int,
@TipoDoc varchar(20),
@TipoUsuario varchar(20),
@Contrasenia varchar(10),
@FechaAlta date,
@FechaBaja date,
@CausaBaja varchar(50);

select 
@Usuario = Usuario,
@NroDoc = NroDoc,
@TipoDoc = TipoDoc,
@TipoUsuario = TipoUsuario,
@Contrasenia = Contrasenia,
@FechaAlta = FechaAlta,
@FechaBaja = FechaBaja,
@CausaBaja = CausaBaja
from 
Deleted

insert into USSUARIOS
(
Usuario,
NroDoc,
TipoDoc,
TipoUsuario,
Contrasenia,
FechaAlta,
FechaBaja,
CausaBaja,
Suspendido
)
values
(
@Usuario,
@NroDoc,
@TipoDoc,
@TipoUsuario,
@Contrasenia,
@FechaAlta,
@FechaBaja,
@CausaBaja,
1
)
go



create trigger TR_Borrar_Docente
on DOCENTES
instead of delete
as
raiserror ('No se puede borrar de la tabla Docentes, utilice el procedimiento almacenado SP_Suspender_Docente',16,1)
rollback
go


create trigger TR_Borrar_Departamento
on DEPARTAMENTOS
instead of delete
as
raiserror ('No se puede borrar de la tabla Departamentos, utilice el procedimiento almacenado SP_Suspender_Departamento',16,1)
rollback
go


create trigger TR_Borrar_Cursada
on CURSADAS
after delete
as
set nocount on;
declare
@Cursada char(20),
@FechaInicio date,
@FechaFin date,
@Observaciones varchar(50);

select
@Cursada = Cursada,
@FechaInicio = FechaInicio,
@FechaFin = FechaFin,
@Observaciones = Observaciones
from 
Deleted

insert into CURSADAS
(
Cursada,
FechaInicio,
FechaFin,
Observaciones,
Suspendido
)
values
(
@Cursada,
@FechaInicio,
@FechaFin,
@Observaciones,
1
)
go


create trigger TR_Borrar_Materia
on MATERIAS
after delete
as
set nocount on;
declare
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Descripcion varchar(50),
@TipoPlan varchar(50),
@Cursada char(20);

select
@CodigoCarrera = CodigoCarrera,
@CodigoMateria = CodigoMateria,
@Descripcion = Descripcion,
@TipoPlan = TipoPlan,
@Cursada = Cursada
from 
Deleted

insert into MATERIAS
(
CodigoCarrera,
CodigoMateria,
Descripcion,
TipoPlan,
Cursada,
Suspendido
)
values
(
@CodigoCarrera,
@CodigoMateria,
@Descripcion,
@TipoPlan,
@Cursada,
1
)
go


create trigger TR_Borrar_Dia
on DIAS
instead of delete
as
raiserror ('No está permitido borrar días' ,16,1)
rollback
go


create trigger TR_Actualizar_Dia
on DIAS
instead of update
as
raiserror ('No está permitido actualizar días' ,16,1)
rollback
go

create trigger TR_Borrar_Hora
on HORAS
instead of delete
as
raiserror ('No está permitido borrar horas', 16,1)
rollback
go

create trigger TR_Actualizar_Hora
on HORAS
instead of update
as
raiserror ('No está permitido actualizar horas',16,1)
rollback
go

create trigger TR_Borrar_Minuto
on MINUTOS
instead of delete
as
raiserror ('No está permitido borrar minutos', 16,1)
rollback
go

create trigger TR_Actualizar_Minuto
on MINUTOS
instead of update
as
raiserror ('No está permitido actualizar minutos', 16,1)
rollback
go

create trigger TR_Borrar_Horario
on HORARIOS
instead of delete
as
raiserror ('No está permitido borrar Horarios, utilice el procedimiento almacenado SP_Suspender_Horario',16,1)
rollback
go


create trigger TR_Actualizar_Horario
on HORARIOS
instead of update
as
raiserror ('No está permitido actualizar Horarios, utilice los procedimientos almacenados SP_Suspender_Horario y SP_Ingresar_Horario',16,1)
rollback
go


create trigger TR_Borrar_Dia_Curso
on DIAS_CURSOS
after delete
as
set nocount on;
declare
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Anio char(4),
@Cursada char(20),
@Dia char(10),
@CodHorario int;

select
@CodigoCarrera = CodigoCarrera,
@CodigoMateria = CodigoMateria,
@Anio = Anio,
@Cursada = Cursada,
@Dia = Dia,
@CodHorario = CodHorario
from 
Deleted

insert into DIAS_CURSOS
(
CodigoCarrera,
CodigoMateria,
Anio,
Cursada,
Dia,
CodHorario,
Suspendido
)
values
(
@CodigoCarrera,
@CodigoMateria,
@Anio,
@Cursada,
@Dia,
@CodHorario,
1
)
go

create trigger TR_Borrar_Turno
on TURNOS
after delete
as
set nocount on;
declare
@Turno char(10),
@CodHorario int;

select
@Turno = Turno,
@CodHorario = CodHorario
from
Deleted

insert into TURNOS
(
Turno,
CodHorario,
Suspendido
)
values
(
@Turno,
@CodHorario,
1
)
go


create trigger TR_Borrar_Curso
on CURSOS
after delete
as
set nocount on;
declare
@CodigoCarrera char(3),
@CodigoMateria char(3),
@Anio char(4),
@Cursada char(20),
@Turno char(10),
@IdDocente int,
@IdDepartamento int,
@Curso char(4);

select 
@CodigoCarrera = CodigoCarrera,
@CodigoMateria = CodigoMateria,
@Anio = Anio,
@Cursada = Cursada,
@Turno = Turno,
@IdDocente = IdDocente,
@IdDepartamento = IdDepartamento,
@Curso = Curso
from 
Deleted

insert into CURSOS
(
CodigoCarrera,
CodigoMateria,
Anio,
Cursada,
Turno,
IdDocente,
IdDepartamento,
Curso,
Suspendido
)
values
(
@CodigoCarrera,
@CodigoMateria,
@Anio,
@Cursada,
@Turno,
@IdDocente,
@IdDepartamento,
@Curso,
1
)
go

create trigger TR_Cursadas_Validar_Fechas
on CURSADAS
for insert, update
as

if ((select datediff(day, FechaInicio, FechaFin) from Inserted) <= 0)
begin
raiserror ('La Fecha de Inicio de Cursada debe ser anterior a la Fecha de Finalizacion de la misma', 16,1)
rollback
end
go

