-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-05-26 15:15:38 CST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE BENEFICIARIOS 
    ( 
     id_beneficiario         NUMBER GENERATED ALWAYS AS IDENTITY 
        ( START WITH 1 NOCACHE )  NOT NULL , 
     nombre_completo         VARCHAR2 (150)  NOT NULL , 
     num_integrantes_familia NUMBER (3)  NOT NULL , 
     direccion               VARCHAR2 (250) , 
     telefono                VARCHAR2 (15) 
    ) 
    LOGGING 
;

ALTER TABLE BENEFICIARIOS 
    ADD CONSTRAINT chk_integrantes 
    CHECK (num_integrantes_familia > 0) 
;

ALTER TABLE BENEFICIARIOS 
    ADD CONSTRAINT BENEFICIARIOS_PK PRIMARY KEY ( id_beneficiario ) ;

CREATE TABLE DETALLE_DONACION 
    ( 
     id_detalle_donacion NUMBER GENERATED ALWAYS AS IDENTITY 
        ( START WITH 1 NOCACHE )  NOT NULL , 
     id_donacion         NUMBER  NOT NULL , 
     id_producto         NUMBER  NOT NULL , 
     cantidad_donada     NUMBER (10)  NOT NULL 
    ) 
    LOGGING 
;

ALTER TABLE DETALLE_DONACION 
    ADD CONSTRAINT chk_cant_donada 
    CHECK (cantidad_donada > 0) 
;

ALTER TABLE DETALLE_DONACION 
    ADD CONSTRAINT DETALLE_DONACION_PK PRIMARY KEY ( id_detalle_donacion ) ;

ALTER TABLE DETALLE_DONACION 
    ADD CONSTRAINT uq_detdon UNIQUE ( id_donacion , id_producto ) ;

CREATE TABLE DETALLE_ENTREGA 
    ( 
     id_detalle_entrega NUMBER GENERATED ALWAYS AS IDENTITY 
        ( START WITH 1 NOCACHE )  NOT NULL , 
     id_entrega         NUMBER  NOT NULL , 
     id_producto        NUMBER  NOT NULL , 
     cantidad_entregada NUMBER (10)  NOT NULL 
    ) 
    LOGGING 
;

ALTER TABLE DETALLE_ENTREGA 
    ADD CONSTRAINT chk_cant_entregada 
    CHECK (cantidad_entregada > 0) 
;

ALTER TABLE DETALLE_ENTREGA 
    ADD CONSTRAINT DETALLE_ENTREGA_PK PRIMARY KEY ( id_detalle_entrega ) ;

ALTER TABLE DETALLE_ENTREGA 
    ADD CONSTRAINT uq_detent UNIQUE ( id_entrega , id_producto ) ;

CREATE TABLE DONACIONES 
    ( 
     id_donacion    NUMBER GENERATED ALWAYS AS IDENTITY 
        ( START WITH 1 NOCACHE )  NOT NULL , 
     id_donador     NUMBER  NOT NULL , 
     fecha_donacion DATE DEFAULT SYSDATE  NOT NULL 
    ) 
    LOGGING 
;

ALTER TABLE DONACIONES 
    ADD CONSTRAINT DONACIONES_PK PRIMARY KEY ( id_donacion ) ;

CREATE TABLE DONADORES 
    ( 
     id_donador          NUMBER GENERATED ALWAYS AS IDENTITY 
        ( START WITH 1 NOCACHE )  NOT NULL , 
     nombre_razon_social VARCHAR2 (150)  NOT NULL , 
     telefono            VARCHAR2 (15) , 
     correo_electronico  VARCHAR2 (100) , 
     direccion           VARCHAR2 (250) 
    ) 
    LOGGING 
;

ALTER TABLE DONADORES 
    ADD CONSTRAINT DONADORES_PK PRIMARY KEY ( id_donador ) ;

CREATE TABLE ENTREGAS 
    ( 
     id_entrega      NUMBER GENERATED ALWAYS AS IDENTITY 
        ( START WITH 1 NOCACHE )  NOT NULL , 
     id_beneficiario NUMBER  NOT NULL , 
     fecha_entrega   DATE DEFAULT SYSDATE  NOT NULL 
    ) 
    LOGGING 
;

ALTER TABLE ENTREGAS 
    ADD CONSTRAINT ENTREGAS_PK PRIMARY KEY ( id_entrega ) ;

CREATE TABLE PRODUCTOS 
    ( 
     id_producto         NUMBER GENERATED ALWAYS AS IDENTITY 
        ( START WITH 1 NOCACHE )  NOT NULL , 
     nombre_producto     VARCHAR2 (100)  NOT NULL , 
     categoria           VARCHAR2 (50) , 
     cantidad_existencia NUMBER (10) DEFAULT 0 , 
     fecha_caducidad     DATE 
    ) 
    LOGGING 
;

ALTER TABLE PRODUCTOS 
    ADD CONSTRAINT chk_existencia 
    CHECK (cantidad_existencia >= 0) 
;

ALTER TABLE PRODUCTOS 
    ADD CONSTRAINT PRODUCTOS_PK PRIMARY KEY ( id_producto ) ;

CREATE TABLE USUARIOS 
    ( 
     id_usuario     NUMBER GENERATED ALWAYS AS IDENTITY 
        ( START WITH 1 NOCACHE )  NOT NULL , 
     nombre_usuario VARCHAR2 (50)  NOT NULL , 
     contrasena     VARCHAR2 (255)  NOT NULL , 
     rol_usuario    VARCHAR2 (20)  NOT NULL 
    ) 
    LOGGING 
;

ALTER TABLE USUARIOS 
    ADD CONSTRAINT chk_rol 
    CHECK (rol_usuario IN ('ADMIN', 'CONSULTA', 'OPERADOR')) 
;

ALTER TABLE USUARIOS 
    ADD CONSTRAINT USUARIOS_PK PRIMARY KEY ( id_usuario ) ;

ALTER TABLE USUARIOS 
    ADD CONSTRAINT INDEX_1 UNIQUE ( nombre_usuario ) ;

ALTER TABLE DETALLE_DONACION 
    ADD CONSTRAINT fk_detdon_donacion FOREIGN KEY 
    ( 
     id_donacion
    ) 
    REFERENCES DONACIONES 
    ( 
     id_donacion
    ) 
    NOT DEFERRABLE 
;

ALTER TABLE DETALLE_DONACION 
    ADD CONSTRAINT fk_detdon_producto FOREIGN KEY 
    ( 
     id_producto
    ) 
    REFERENCES PRODUCTOS 
    ( 
     id_producto
    ) 
    NOT DEFERRABLE 
;

ALTER TABLE DETALLE_ENTREGA 
    ADD CONSTRAINT fk_detent_entrega FOREIGN KEY 
    ( 
     id_entrega
    ) 
    REFERENCES ENTREGAS 
    ( 
     id_entrega
    ) 
    NOT DEFERRABLE 
;

ALTER TABLE DETALLE_ENTREGA 
    ADD CONSTRAINT fk_detent_producto FOREIGN KEY 
    ( 
     id_producto
    ) 
    REFERENCES PRODUCTOS 
    ( 
     id_producto
    ) 
    NOT DEFERRABLE 
;

ALTER TABLE DONACIONES 
    ADD CONSTRAINT fk_don_donador FOREIGN KEY 
    ( 
     id_donador
    ) 
    REFERENCES DONADORES 
    ( 
     id_donador
    ) 
    NOT DEFERRABLE 
;

ALTER TABLE ENTREGAS 
    ADD CONSTRAINT fk_ent_beneficiario FOREIGN KEY 
    ( 
     id_beneficiario
    ) 
    REFERENCES BENEFICIARIOS 
    ( 
     id_beneficiario
    ) 
    NOT DEFERRABLE 
;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             22
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
