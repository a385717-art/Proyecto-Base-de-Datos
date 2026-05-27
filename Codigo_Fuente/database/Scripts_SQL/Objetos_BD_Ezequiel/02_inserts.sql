--  BANCO DE ALIMENTOS COMUNITARIO
--  -- INSERTs: 5 registros por tabla
--  Fundamentos de Bases de Datos - Tercer Parcial

-- 1. TABLA: USUARIOS (5 INSERTS)

INSERT INTO USUARIOS (id_usuario, nombre_usuario, contrasena, rol_usuario) VALUES (1, 'admin_banco', 'admin123', 'Administrador');
INSERT INTO USUARIOS (id_usuario, nombre_usuario, contrasena, rol_usuario) VALUES (2, 'juan_empleado', 'juan123', 'Operador');
INSERT INTO USUARIOS (id_usuario, nombre_usuario, contrasena, rol_usuario) VALUES (3, 'ana_coordinadora', 'ana123', 'Coordinador');
INSERT INTO USUARIOS (id_usuario, nombre_usuario, contrasena, rol_usuario) VALUES (4, 'carlos_voluntario', 'carlos123', 'Voluntario');
INSERT INTO USUARIOS (id_usuario, nombre_usuario, contrasena, rol_usuario) VALUES (5, 'sofia_auditora', 'sofia123', 'Auditor');

-- 2. TABLA: DONADORES (5 INSERTS)

INSERT INTO DONADORES (id_donador, nombre_razon_social, telefono, correo_electronico, direccion) VALUES (1, 'Supermercados Alsuper', '6141234567', 'donaciones@alsuper.com', 'Av. Universidad 123');
INSERT INTO DONADORES (id_donador, nombre_razon_social, telefono, correo_electronico, direccion) VALUES (2, 'Maria Gonzalez', '6149876543', 'maria.g@email.com', 'Col. Centro 456');
INSERT INTO DONADORES (id_donador, nombre_razon_social, telefono, correo_electronico, direccion) VALUES (3, 'Panaderia El Sazon', '6143332211', 'contacto@elsazon.com', 'Av. Juárez 990');
INSERT INTO DONADORES (id_donador, nombre_razon_social, telefono, correo_electronico, direccion) VALUES (4, 'Banco Agricola Local', '6147778899', 'donas@agricola.org', 'Carr. Central Km 5');
INSERT INTO DONADORES (id_donador, nombre_razon_social, telefono, correo_electronico, direccion) VALUES (5, 'Distribuidora San Marcos', '6142225566', 'smarcos@dist.com', 'Zona Industrial Lote 12');


-- 3. TABLA: BENEFICIARIOS (5 INSERTS)

INSERT INTO BENEFICIARIOS (id_beneficiario, nombre_completo, num_integrantes_familia, direccion, telefono) VALUES (1, 'Familia Perez Lopez', 5, 'Calle del Arroyo 789', '6145551122');
INSERT INTO BENEFICIARIOS (id_beneficiario, nombre_completo, num_integrantes_familia, direccion, telefono) VALUES (2, 'Jose Ramirez', 1, 'Col. Sur 101', '6145553344');
INSERT INTO BENEFICIARIOS (id_beneficiario, nombre_completo, num_integrantes_familia, direccion, telefono) VALUES (3, 'Comedor Comunitario San Jose', 45, 'Calle Tercera 410', '6148889900');
INSERT INTO BENEFICIARIOS (id_beneficiario, nombre_completo, num_integrantes_familia, direccion, telefono) VALUES (4, 'Familia Mendoza Ruiz', 6, 'Col. Vista Hermosa 23', '6141112233');
INSERT INTO BENEFICIARIOS (id_beneficiario, nombre_completo, num_integrantes_familia, direccion, telefono) VALUES (5, 'Asilo de Ancianos Luz de Luna', 30, 'Av. de los Pinos 1024', '6144447788');

-- 4. TABLA: PRODUCTOS (5 INSERTS)

INSERT INTO PRODUCTOS (id_producto, nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES (1, 'Frijol Pinto 1kg', 'Granos', 0, TO_DATE('2027-01-01', 'YYYY-MM-DD'));
INSERT INTO PRODUCTOS (id_producto, nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES (2, 'Arroz Blanco 1kg', 'Granos', 0, TO_DATE('2027-06-15', 'YYYY-MM-DD'));
INSERT INTO PRODUCTOS (id_producto, nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES (3, 'Leche Entera 1L', 'Lacteos', 0, TO_DATE('2026-08-20', 'YYYY-MM-DD'));
INSERT INTO PRODUCTOS (id_producto, nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES (4, 'Atun en Agua 140g', 'Enlatados', 0, TO_DATE('2028-05-10', 'YYYY-MM-DD'));
INSERT INTO PRODUCTOS (id_producto, nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES (5, 'Aceite Vegetal 1L', 'Abarrotes', 0, TO_DATE('2027-09-18', 'YYYY-MM-DD'));

-- ==========================================
-- 5. TABLA: DONACIONES (5 INSERTS)
-- ==========================================
INSERT INTO DONACIONES (id_donacion, id_donador, fecha_donacion) VALUES (1, 1, TO_DATE('2026-05-20', 'YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donacion, id_donador, fecha_donacion) VALUES (2, 2, TO_DATE('2026-05-21', 'YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donacion, id_donador, fecha_donacion) VALUES (3, 3, TO_DATE('2026-05-22', 'YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donacion, id_donador, fecha_donacion) VALUES (4, 4, TO_DATE('2026-05-23', 'YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donacion, id_donador, fecha_donacion) VALUES (5, 5, TO_DATE('2026-05-24', 'YYYY-MM-DD'));

-- 6. TABLA: DETALLE_DONACION (5 INSERTS)

INSERT INTO DETALLE_DONACION (id_detalle_donacion, id_donacion, id_producto, cantidad_donada) VALUES (1, 1, 1, 100);
INSERT INTO DETALLE_DONACION (id_detalle_donacion, id_donacion, id_producto, cantidad_donada) VALUES (2, 2, 2, 150);
INSERT INTO DETALLE_DONACION (id_detalle_donacion, id_donacion, id_producto, cantidad_donada) VALUES (3, 3, 3, 80);
INSERT INTO DETALLE_DONACION (id_detalle_donacion, id_donacion, id_producto, cantidad_donada) VALUES (4, 4, 4, 200);
INSERT INTO DETALLE_DONACION (id_detalle_donacion, id_donacion, id_producto, cantidad_donada) VALUES (5, 5, 5, 120);


-- 7. TABLA: ENTREGAS (5 INSERTS)

INSERT INTO ENTREGAS (id_entrega, id_beneficiario, fecha_entrega) VALUES (1, 1, TO_DATE('2026-05-25', 'YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_entrega, id_beneficiario, fecha_entrega) VALUES (2, 2, TO_DATE('2026-05-25', 'YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_entrega, id_beneficiario, fecha_entrega) VALUES (3, 3, TO_DATE('2026-05-26', 'YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_entrega, id_beneficiario, fecha_entrega) VALUES (4, 4, TO_DATE('2026-05-26', 'YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_entrega, id_beneficiario, fecha_entrega) VALUES (5, 5, TO_DATE('2026-05-26', 'YYYY-MM-DD'));

-- 8. TABLA: DETALLE_ENTREGA (5 INSERTS)

INSERT INTO DETALLE_ENTREGA (id_detalle_entrega, id_entrega, id_producto, cantidad_entregada) VALUES (1, 1, 1, 10);
INSERT INTO DETALLE_ENTREGA (id_detalle_entrega, id_entrega, id_producto, cantidad_entregada) VALUES (2, 2, 2, 15);
INSERT INTO DETALLE_ENTREGA (id_detalle_entrega, id_entrega, id_producto, cantidad_entregada) VALUES (3, 3, 3, 20);
INSERT INTO DETALLE_ENTREGA (id_detalle_entrega, id_entrega, id_producto, cantidad_entregada) VALUES (4, 4, 4, 30);
INSERT INTO DETALLE_ENTREGA (id_detalle_entrega, id_entrega, id_producto, cantidad_entregada) VALUES (5, 5, 5, 12);

-- Confirmar permanentemente todos los datos agregados en el servidor
COMMIT;