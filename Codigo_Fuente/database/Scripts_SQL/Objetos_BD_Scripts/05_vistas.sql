-- ============================================================
--  BANCO DE ALIMENTOS COMUNITARIO
--  05_vistas.sql — 15 VISTAS (3 integrantes x 5)
-- ============================================================

-- ============================================================
-- INTEGRANTE 1 — Vistas 1 al 5
-- ============================================================

-- V1: Inventario actual completo
CREATE OR REPLACE VIEW v_reporte_inventario AS
SELECT id_producto, nombre_producto, categoria,
       cantidad_existencia, fecha_caducidad
FROM PRODUCTOS;

-- V2: Historial de donaciones con nombres
CREATE OR REPLACE VIEW v_historial_donaciones AS
SELECT d.id_donacion, dr.nombre_razon_social,
       p.nombre_producto, dd.cantidad_donada, d.fecha_donacion
FROM DONACIONES d
JOIN DONADORES        dr ON d.id_donador   = dr.id_donador
JOIN DETALLE_DONACION dd ON d.id_donacion  = dd.id_donacion
JOIN PRODUCTOS         p ON dd.id_producto = p.id_producto;

-- V3: Historial de entregas a beneficiarios
CREATE OR REPLACE VIEW v_historial_entregas AS
SELECT e.id_entrega, b.nombre_completo, b.num_integrantes_familia,
       p.nombre_producto, de.cantidad_entregada, e.fecha_entrega
FROM ENTREGAS e
JOIN BENEFICIARIOS    b  ON e.id_beneficiario = b.id_beneficiario
JOIN DETALLE_ENTREGA  de ON e.id_entrega      = de.id_entrega
JOIN PRODUCTOS         p ON de.id_producto    = p.id_producto;

-- V4: Alertas de productos próximos a caducar
CREATE OR REPLACE VIEW v_alertas_caducidad AS
SELECT nombre_producto, categoria, cantidad_existencia, fecha_caducidad
FROM PRODUCTOS
WHERE fecha_caducidad >= SYSDATE
ORDER BY fecha_caducidad ASC;

-- V5: Usuarios del sistema sin mostrar contraseña
CREATE OR REPLACE VIEW v_usuarios_activos AS
SELECT id_usuario, nombre_usuario, rol_usuario
FROM USUARIOS;

-- ============================================================
-- INTEGRANTE 2 — Vistas 6 al 10
-- ============================================================

-- V6: Donadores sin donaciones registradas
CREATE OR REPLACE VIEW v_donadores_sin_donaciones AS
SELECT d.id_donador, d.nombre_razon_social, d.correo_electronico
FROM DONADORES d
WHERE d.id_donador NOT IN (SELECT id_donador FROM DONACIONES);

-- V7: Existencia total por categoría
CREATE OR REPLACE VIEW v_productos_por_categoria AS
SELECT categoria,
       COUNT(*)                 AS total_tipos,
       SUM(cantidad_existencia) AS total_existencia
FROM PRODUCTOS
GROUP BY categoria;

-- V8: Número de entregas por beneficiario
CREATE OR REPLACE VIEW v_entregas_por_beneficiario AS
SELECT b.id_beneficiario, b.nombre_completo,
       COUNT(e.id_entrega) AS entregas_realizadas
FROM BENEFICIARIOS b
LEFT JOIN ENTREGAS e ON b.id_beneficiario = e.id_beneficiario
GROUP BY b.id_beneficiario, b.nombre_completo;

-- V9: Resumen mensual de donaciones
CREATE OR REPLACE VIEW v_resumen_donaciones_mensual AS
SELECT TO_CHAR(d.fecha_donacion,'YYYY-MM') AS anio_mes,
       COUNT(DISTINCT d.id_donacion)        AS total_donaciones,
       SUM(dd.cantidad_donada)              AS total_unidades
FROM DONACIONES d
JOIN DETALLE_DONACION dd ON d.id_donacion = dd.id_donacion
GROUP BY TO_CHAR(d.fecha_donacion,'YYYY-MM');

-- V10: Productos con caducidad en los próximos 30 días
CREATE OR REPLACE VIEW v_productos_caducidad_30dias AS
SELECT id_producto, nombre_producto, cantidad_existencia, fecha_caducidad
FROM PRODUCTOS
WHERE fecha_caducidad BETWEEN SYSDATE AND SYSDATE + 30
ORDER BY fecha_caducidad ASC;

-- ============================================================
-- INTEGRANTE 3 — Vistas 11 al 15
-- ============================================================

-- V11: Balance de inventario por producto (entradas vs salidas)
CREATE OR REPLACE VIEW v_balance_inventario AS
SELECT p.id_producto,
       p.nombre_producto,
       NVL(SUM(dd.cantidad_donada),   0) AS total_entradas,
       NVL(SUM(de.cantidad_entregada),0) AS total_salidas,
       p.cantidad_existencia             AS stock_actual
FROM PRODUCTOS p
LEFT JOIN DETALLE_DONACION dd ON p.id_producto = dd.id_producto
LEFT JOIN DETALLE_ENTREGA  de ON p.id_producto = de.id_producto
GROUP BY p.id_producto, p.nombre_producto, p.cantidad_existencia;

-- V12: Beneficiarios que nunca han recibido una entrega
CREATE OR REPLACE VIEW v_beneficiarios_sin_entrega AS
SELECT id_beneficiario, nombre_completo,
       num_integrantes_familia, telefono
FROM BENEFICIARIOS
WHERE id_beneficiario NOT IN (SELECT id_beneficiario FROM ENTREGAS);

-- V13: Top donadores por unidades totales donadas
CREATE OR REPLACE VIEW v_top_donadores AS
SELECT dr.id_donador, dr.nombre_razon_social,
       SUM(dd.cantidad_donada) AS total_unidades_donadas
FROM DONADORES dr
JOIN DONACIONES       d  ON dr.id_donador  = d.id_donador
JOIN DETALLE_DONACION dd ON d.id_donacion  = dd.id_donacion
GROUP BY dr.id_donador, dr.nombre_razon_social
ORDER BY total_unidades_donadas DESC;

-- V14: Productos con stock crítico (menos de 20 unidades)
CREATE OR REPLACE VIEW v_stock_critico AS
SELECT id_producto, nombre_producto, categoria,
       cantidad_existencia, fecha_caducidad
FROM PRODUCTOS
WHERE cantidad_existencia < 20
ORDER BY cantidad_existencia ASC;

-- V15: Resumen general del sistema (conteos globales)
CREATE OR REPLACE VIEW v_resumen_general AS
SELECT
    (SELECT COUNT(*) FROM DONADORES)     AS total_donadores,
    (SELECT COUNT(*) FROM BENEFICIARIOS) AS total_beneficiarios,
    (SELECT COUNT(*) FROM PRODUCTOS)     AS total_productos,
    (SELECT COUNT(*) FROM DONACIONES)    AS total_donaciones,
    (SELECT COUNT(*) FROM ENTREGAS)      AS total_entregas,
    (SELECT SUM(cantidad_existencia) FROM PRODUCTOS) AS stock_total
FROM DUAL;