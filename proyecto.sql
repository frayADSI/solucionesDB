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

/*
CREATE TABLE tblequipo(
	equserial 				VARCHAR(20) NOT NULL,
	equtipo 				VARCHAR(20),
	equcapacidadmemoria 			DOUBLE,
	equmarca 				VARCHAR(15),
	equubicacion 				VARCHAR(40),
	equcondicion 				VARCHAR(40),
	equifechaingreso 			DATE,
	tbllicencia_liccodigo_fk 		VARCHAR(20),
	tblcliente_clinumeroidentificacion_fk BIGINT,
	PRIMARY KEY (equserial),
	CONSTRAINT FK_clienteequipo FOREIGN KEY (tblcliente_clinumeroidentificacion_fk) REFERENCES tblcliente(clinumeroidentificacion),
	CONSTRAINT FK_licenciaeequipo FOREIGN KEY (tbllicencia_liccodigo_fk) REFERENCES tbllicencia(liccodigo)
);



CREATE TABLE tblservicio(
	sernombre 			VARCHAR(30) NOT NULL,
	sertipo 			VARCHAR(20),
	serfechainicio 			DATE,
	serfechafin 			DATE,
	PRIMARY KEY (sernombre)
);



CREATE TABLE tblcliente_has_tblservicio(
	tblcliente_clinumeroidentificacion_fk 	BIGINT,
	tblservicio_sernombre_fk 		BIGINT,
	CONSTRAINT FK_serviciocliente FOREIGN KEY (tblservicio_sernombre_fk) REFERENCES tblcliente(clinumeroidentificacion)
);

*/


