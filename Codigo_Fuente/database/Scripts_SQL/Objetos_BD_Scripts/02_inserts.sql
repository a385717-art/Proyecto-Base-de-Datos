--  BANCO DE ALIMENTOS COMUNITARIO
--  02_inserts.sql — 

-- ============================================================
-- 1. USUARIOS — primeros 5 (roles válidos: ADMIN/OPERADOR/CONSULTA)
-- ============================================================
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('admin_banco',        'admin123',   'ADMIN');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('juan_empleado',      'juan123',    'OPERADOR');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('ana_coordinadora',   'ana123',     'OPERADOR');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('carlos_voluntario',  'carlos123',  'CONSULTA');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('sofia_auditora',     'sofia123',   'CONSULTA');

-- 2. DONADORES
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Supermercados Alsuper',    '6141234567', 'donaciones@alsuper.com', 'Av. Universidad 123');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Maria Gonzalez',           '6149876543', 'maria.g@email.com',      'Col. Centro 456');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Panaderia El Sazon',       '6143332211', 'contacto@elsazon.com',   'Av. Juarez 990');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Banco Agricola Local',     '6147778899', 'donas@agricola.org',     'Carr. Central Km 5');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Distribuidora San Marcos', '6142225566', 'smarcos@dist.com',       'Zona Industrial Lote 12');

-- 3. BENEFICIARIOS
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Familia Perez Lopez',          5,  'Calle del Arroyo 789',  '6145551122');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Jose Ramirez',                 1,  'Col. Sur 101',          '6145553344');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Comedor Comunitario San Jose', 45, 'Calle Tercera 410',     '6148889900');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Familia Mendoza Ruiz',         6,  'Col. Vista Hermosa 23', '6141112233');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Asilo de Ancianos Luz de Luna',30, 'Av. de los Pinos 1024', '6144447788');

-- 4. PRODUCTOS (existencia inicial en 0, el trigger la incrementa con donaciones)
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Frijol Pinto 1kg',    'Granos',    0, TO_DATE('2027-01-01','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Arroz Blanco 1kg',    'Granos',    0, TO_DATE('2027-06-15','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Leche Entera 1L',     'Lacteos',   0, TO_DATE('2026-08-20','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Atun en Agua 140g',   'Enlatados', 0, TO_DATE('2028-05-10','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Aceite Vegetal 1L',   'Abarrotes', 0, TO_DATE('2027-09-18','YYYY-MM-DD'));

-- 5. DONACIONES
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (1, TO_DATE('2026-05-20','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (2, TO_DATE('2026-05-21','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (3, TO_DATE('2026-05-22','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (4, TO_DATE('2026-05-23','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (5, TO_DATE('2026-05-24','YYYY-MM-DD'));

-- 6. DETALLE_DONACION (el trigger trg_sumar_inventario actualiza PRODUCTOS automáticamente)
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (1, 1, 100);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (2, 2, 150);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (3, 3, 80);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (4, 4, 200);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (5, 5, 120);

-- 7. ENTREGAS
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (1, TO_DATE('2026-05-25','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (2, TO_DATE('2026-05-25','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (3, TO_DATE('2026-05-26','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (4, TO_DATE('2026-05-26','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (5, TO_DATE('2026-05-26','YYYY-MM-DD'));

-- 8. DETALLE_ENTREGA (el trigger trg_restar_inventario descuenta PRODUCTOS automáticamente)
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (1, 1, 10);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (2, 2, 15);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (3, 3, 20);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (4, 4, 30);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (5, 5, 12);

COMMIT;

-- ============================================================
-- INTEGRANTE 2 — 5 registros adicionales por tabla
-- ============================================================
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('maria_admin',  'maria123',  'ADMIN');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('luis_ops',     'luis123',   'OPERADOR');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('sandra_cons',  'sandra123', 'CONSULTA');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('pedro_aux',    'pedro123',  'OPERADOR');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('laura_sup',    'laura123',  'ADMIN');

INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Tienda La Esquina',   '6141010101', 'esquina@tienda.com',     'Calle 1');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Cafeteria Buena',     '6142020202', 'contacto@cafebuena.com', 'Av. Central 55');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Mercado Local',       '6143030303', 'mercado@local.com',      'Plaza Mayor 2');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Empresa Solidaria',   '6144040404', 'solidaria@empresa.com',  'Poligono 7');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Hogar Ayuda',         '6145050505', 'ayuda@hogar.com',        'Camino Real 10');

INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Familia Torres',             4,  'Calle Verde 12',    '6146667777');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Centro Comunitario Flores',  25, 'Calle Flores 77',   '6148882233');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Familia Ruiz',               3,  'Col. Lomas 9',      '6149991122');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Casa Hogar San Miguel',      18, 'Av. Sur 200',       '6141234433');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Familia Ortega',             2,  'Col. Palma 45',     '6145566778');

INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Harina de Trigo 1kg',  'Granos',    120, TO_DATE('2027-11-01','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Azucar 1kg',           'Abarrotes',  80, TO_DATE('2028-03-15','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Sopa Instantanea 60g', 'Enlatados', 200, TO_DATE('2029-01-10','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Galletas 200g',        'Abarrotes', 150, TO_DATE('2027-07-30','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Leche en Polvo 500g',  'Lacteos',    60, TO_DATE('2027-12-05','YYYY-MM-DD'));

INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (6,  TO_DATE('2026-05-26','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (7,  TO_DATE('2026-05-26','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (8,  TO_DATE('2026-05-26','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (9,  TO_DATE('2026-05-26','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (10, TO_DATE('2026-05-26','YYYY-MM-DD'));

INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (6,  6,  50);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (7,  7,  40);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (8,  8, 100);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (9,  9,  60);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (10, 10, 30);

INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (6,  TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (7,  TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (8,  TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (9,  TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (10, TO_DATE('2026-05-27','YYYY-MM-DD'));

INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (6,  6,  5);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (7,  7,  8);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (8,  8, 12);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (9,  9,  6);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (10, 10,  4);

COMMIT;

-- ============================================================
-- INTEGRANTE 3 — 5 registros adicionales por tabla
-- ============================================================
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('roberto_ops',   'roberto123', 'OPERADOR');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('diana_cons',    'diana123',   'CONSULTA');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('hector_adm',    'hector123',  'ADMIN');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('elena_ops',     'elena123',   'OPERADOR');
INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario) VALUES ('jorge_cons',    'jorge123',   'CONSULTA');

INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Restaurante El Rancho',  '6146060606', 'rancho@rest.com',       'Blvd. Diaz Ordaz 300');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Club Rotario Chihuahua', '6147070707', 'rotario@club.org',      'Av. Colon 88');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Farmacia Santa Cruz',    '6148080808', 'santacruz@farm.com',    'Calle Zarco 12');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Tortilleria La Nueva',   '6149090909', 'nueva@tortilleria.com', 'Col. Obrera 5');
INSERT INTO DONADORES (nombre_razon_social, telefono, correo_electronico, direccion) VALUES ('Fundacion Manos Unidas', '6140001122', 'info@manosunidas.org',  'Av. Independencia 400');

INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Familia Chavez Soto',      7,  'Col. Partido Romero 3',  '6141231234');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Guarderia Sol Naciente',   20, 'Av. Tecnologico 500',    '6142342345');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Familia Valenzuela',        4,  'Calle Nogal 77',         '6143453456');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Albergue Juvenil Esperanza',15, 'Blvd. Lombardo 210',     '6144564567');
INSERT INTO BENEFICIARIOS (nombre_completo, num_integrantes_familia, direccion, telefono) VALUES ('Familia Ibarra Cruz',       3,  'Calle Pino Suarez 99',   '6145675678');

INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Sal de Mesa 1kg',       'Abarrotes',  90, TO_DATE('2029-05-01','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Sardina en Tomate 425g','Enlatados',  75, TO_DATE('2028-11-20','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Pasta Espagueti 500g',  'Granos',    110, TO_DATE('2027-04-15','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Avena en Hojuelas 500g','Granos',     55, TO_DATE('2027-08-30','YYYY-MM-DD'));
INSERT INTO PRODUCTOS (nombre_producto, categoria, cantidad_existencia, fecha_caducidad) VALUES ('Yogurt Natural 1L',     'Lacteos',    40, TO_DATE('2026-07-10','YYYY-MM-DD'));

INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (11, TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (12, TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (13, TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (14, TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO DONACIONES (id_donador, fecha_donacion) VALUES (15, TO_DATE('2026-05-27','YYYY-MM-DD'));

INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (11, 11, 45);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (12, 12, 60);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (13, 13, 90);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (14, 14, 30);
INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada) VALUES (15, 15, 20);

INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (11, TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (12, TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (13, TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (14, TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega) VALUES (15, TO_DATE('2026-05-27','YYYY-MM-DD'));

INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (11, 11,  5);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (12, 12,  7);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (13, 13, 10);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (14, 14,  4);
INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada) VALUES (15, 15,  3);

COMMIT;