create database proyecto;

use proyecto;

/*Creation of tables without FK*/

CREATE TABLE tblcliente(
	clinumeroidentificacion BIGINT NOT NULL,
	clinombre 		VARCHAR(20) NOT NULL,
	cliapellido 		VARCHAR(30) NOT NULL,
	clitelefono 		INT,
	PRIMARY KEY (clinumeroidentificacion)
);



CREATE TABLE tbllicencia(
	liccodigo 				VARCHAR(20) NOT NULL,
	lictipo 				VARCHAR(20),
	licvencimiento	 			DATE NOT NULL,
	PRIMARY KEY (liccodigo)
);

CREATE TABLE tblelemento(
	elecodigo 			VARCHAR(20) NOT NULL,
	elecantidad 			INT NOT NULL,
	elenombre 			VARCHAR(20) NOT NULL,
	eletipo 			VARCHAR(20) NOT NULL,
	PRIMARY KEY (elecodigo)	
);


CREATE TABLE tblencargado(
	enccedula 			BIGINT NOT NULL,
	encdireccion 			VARCHAR(40),
	encnombre 			VARCHAR(20),
	encapellido 			VARCHAR(20),
	PRIMARY KEY (enccedula)	
);

/*creation of tables with FK*/

CREATE TABLE tblequipo(
	equserial 				VARCHAR(20) NOT NULL,
	equtipo 				VARCHAR(20) NOT NULL,
	equcapacidadmemoria 			DOUBLE,
	equmarca 				VARCHAR(15),
	equubicacion 				VARCHAR(40) NOT NULL,
	equcondicion 				VARCHAR(40) NOT NULL,
	equifechaingreso 			DATE,
	tbllicencia_liccodigo_fk 		VARCHAR(20),
	tblcliente_clinumeroidentificacion_fk BIGINT not null,
	PRIMARY KEY (equserial),
	CONSTRAINT FK_clienteequipo FOREIGN KEY (tblcliente_clinumeroidentificacion_fk) REFERENCES tblcliente(clinumeroidentificacion),
	CONSTRAINT FK_licenciaeequipo FOREIGN KEY (tbllicencia_liccodigo_fk) REFERENCES tbllicencia(liccodigo)
);



CREATE TABLE tblservicio(
	sernombre 			VARCHAR(30) NOT NULL,
	sertipo 			VARCHAR(20) NOT NULL,
	serfechainicio 			DATE NOT NULL,
	serfechafin 			DATE,
    tblEcargado_EncCedula_fk bigint,
	PRIMARY KEY (sernombre),
    FOREIGN KEY(tblEcargado_EncCedula_fk) REFERENCES tblencargado(enccedula)
);



CREATE TABLE tblcliente_has_tblservicio(
	tblcliente_clinumeroidentificacion_fk 	BIGINT NOT NULL,
	tblservicio_sernombre_fk 		VARCHAR(30) NOT NULL,
    CONSTRAINT FK_serviciocliente FOREIGN KEY (tblservicio_sernombre_fk) REFERENCES tblservicio(sernombre),
    FOREIGN KEY(tblcliente_clinumeroidentificacion_fk) REFERENCES tblcliente(clinumeroidentificacion)
);

CREATE TABLE tblServicio_has_tblElemento(
	TblServicio_SerNombre_fk VARCHAR(30) NOT NULL, 
    tblElemento_Elecodigo_fk VARCHAR(20) NOT NULL,
    FOREIGN KEY(TblServicio_SerNombre_fk) REFERENCES tblservicio(sernombre),
    FOREIGN KEY(tblElemento_Elecodigo_fK) REFERENCES tblelemento(elecodigo)
);

/*next the creation of procedures*/
USE proyecto;
CREATE PROCEDURE ListEquType(tipo VARCHAR(20))
SELECT equserial, equtipo,equmarca,equcondicion FROM tblequipo
WHERE equtipo=tipo;

/*Next the creation of functions */
USE proyecto;

DELIMITER //
CREATE FUNCTION contarClientes() RETURNS INT 
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE cantidad INT;
SELECT count(*) INTO cantidad
FROM tblcliente;
RETURN cantidad;
END
//
DELIMITER ;

/*Creation of triggers on client's table*/
CREATE TABLE Auditoria_Cliente(
id_Audi int not null auto_increment,
CliNumeroIdentificacion_Anterior bigint,
CliNombre_Anterior varchar(20),
CliApellido_Anterior varchar(30),
CliTelefono_Anterior int,
CliNumeroIdentificacion_Nuevo bigint,
CliNombre_Nuevo varchar(20),
CliApellido_Nuevo varchar(30),
CliTelefono_Nuevo int,
Fecha_Audi datetime,
usuario varchar(45),
accion varchar(45) not null,
primary key(id_Audi)
);

/*Trigger for update*/
create trigger auditoria_modificaCliente after update
on tblcliente
for each row
insert  into auditoria_cliente(
CliNumeroIdentificacion_Anterior,CliNombre_Anterior,CliApellido_Anterior,
CliTelefono_Anterior,CliNumeroIdentificacion_Nuevo,CliNombre_Nuevo,CliApellido_Nuevo,
CliTelefono_Nuevo,Fecha_Audi,usuario,accion) values( old.clinumeroidentificacion, old.clinombre, old.cliapellido,
old.clitelefono,new.clinumeroidentificacion, new.clinombre, new.cliapellido,
new.clitelefono, now(), current_user(), 'Actualizacion'); 

/*Trigger for delete*/
create trigger auditoria_eliminaCliente after delete
on tblcliente
for each row
insert  into auditoria_cliente(
CliNumeroIdentificacion_Anterior,CliNombre_Anterior,CliApellido_Anterior,
CliTelefono_Anterior,Fecha_Audi,usuario,accion) values( old.clinumeroidentificacion, old.clinombre, old.cliapellido,
old.clitelefono, now(), current_user(), 'Eliminacion'); 

/*Trigger for insert*/
create trigger auditoria_insertCliente after insert
on tblcliente
for each row
insert  into auditoria_cliente(
CliNumeroIdentificacion_Nuevo,CliNombre_Nuevo,CliApellido_Nuevo,
CliTelefono_Nuevo,Fecha_Audi,usuario,accion) values( new.clinumeroidentificacion, new.clinombre, new.cliapellido,
new.clitelefono, now(), current_user(), 'insertar'); 