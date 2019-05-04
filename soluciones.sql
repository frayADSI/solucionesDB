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

