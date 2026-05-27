--  BANCO DE ALIMENTOS COMUNITARIO
--  -- 5 Vistas
--  Fundamentos de Bases de Datos - Tercer Parcial


-- 1. VISTA: Reporte General de Inventario Actual
-- Muestra qué productos hay, su categoría y cuánta existencia queda
CREATE OR REPLACE VIEW v_reporte_inventario AS
SELECT
id_producto,
nombre_producto,
categoria,
cantidad_existencia,
fecha_caducidad
FROM PRODUCTOS;

-- 2. VISTA: Historial de Donaciones Recibidas (Con nombres de donadores)
-- Une las tablas Donaciones, Donadores y Detalles para ver quién donó qué cosa
CREATE OR REPLACE VIEW v_historial_donaciones AS
SELECT
d.id_donacion,
dr.nombre_razon_social,
p.nombre_producto,
dd.cantidad_donada,
d.fecha_donacion
FROM DONACIONES d
INNER JOIN DONADORES dr ON d.id_donador = dr.id_donador
INNER JOIN DETALLE_DONACION dd ON d.id_donacion = dd.id_donacion
INNER JOIN PRODUCTOS p ON dd.id_producto = p.id_producto;

-- 3. VISTA: Historial de Entregas a Beneficiarios
-- Une Entregas, Beneficiarios y Detalles para ver a qué familia se le apoyó y qué se llevó
CREATE OR REPLACE VIEW v_historial_entregas AS
SELECT
e.id_entrega,
b.nombre_completo,
b.num_integrantes_familia,
p.nombre_producto,
de.cantidad_entregada,
e.fecha_entrega
FROM ENTREGAS e
INNER JOIN BENEFICIARIOS b ON e.id_beneficiario = b.id_beneficiario
INNER JOIN DETALLE_ENTREGA de ON e.id_entrega = de.id_entrega
INNER JOIN PRODUCTOS p ON de.id_producto = p.id_producto;

-- 4. VISTA: Productos Próximos a Caducar
-- Filtra automáticamente los productos que vencen pronto (ordenados del más urgente al menos urgente)
CREATE OR REPLACE VIEW v_alertas_caducidad AS
SELECT
nombre_producto,
categoria,
cantidad_existencia,
fecha_caducidad
FROM PRODUCTOS
WHERE fecha_caducidad >= SYSDATE
ORDER BY fecha_caducidad ASC;

-- 5. VISTA: Resumen de Usuarios del Sistema
-- Muestra la lista de personal autorizado sin exponer las contraseñas por seguridad
CREATE OR REPLACE VIEW v_usuarios_activos AS
SELECT
id_usuario,
nombre_usuario,
rol_usuario
FROM USUARIOS;
