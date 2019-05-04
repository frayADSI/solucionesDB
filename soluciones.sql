create database soluciones;
use soluciones;
/*next the creation of tables without FK*/
/*TblCliente creation*/
create table TblCliente(
CliNumeroIdentificacion bigint not null,
CliNombre varchar(20) not null,
CliApellido varchar(30) not null,
CliTelefono int not null,
primary key(CliNumeroIdentificacion) 
);
/*TblLicencia creation*/
create table TblLicencia(
LicCodigo varchar(20) not null,
LicTipo varchar(20) not null,
LicVencimiento date not null
);
alter table TblLicencia modify column
LicCodigo varchar(20) not null primary key;
/*TblElemento creation*/
create table TblElemento(
EleCodigo varchar(20) not null,
EleCantidad int not null,
EleNombre varchar(20) not null,
EleTipo varchar(20) not null,
primary key(EleCodigo)
);