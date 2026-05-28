-- ============================================================
--  BANCO DE ALIMENTOS COMUNITARIO
--  04_queries.sql — 30 CONSULTAS (3 integrantes x 10)
-- ============================================================

-- ============================================================
-- INTEGRANTE 1 — Queries 1 al 10
-- ============================================================

-- Q1: Listar todos los productos en orden alfabético
SELECT nombre_producto, categoria, cantidad_existencia
FROM PRODUCTOS ORDER BY nombre_producto ASC;

-- Q2: Buscar donadores que tengan dirección en una avenida
SELECT nombre_razon_social, correo_electronico
FROM DONADORES WHERE direccion LIKE '%Av.%';

-- Q3: Contar productos registrados por categoría
SELECT categoria, COUNT(*) AS total_productos
FROM PRODUCTOS GROUP BY categoria;

-- Q4: Beneficiarios con más de 4 integrantes de familia
SELECT nombre_completo, num_integrantes_familia
FROM BENEFICIARIOS WHERE num_integrantes_familia > 4;

-- Q5: Suma total de existencias en inventario
SELECT SUM(cantidad_existencia) AS total_piezas_inventario
FROM PRODUCTOS;

-- Q6: Detalle completo de donaciones con nombres de donadores y productos
SELECT dr.nombre_razon_social, p.nombre_producto, dd.cantidad_donada, d.fecha_donacion
FROM DETALLE_DONACION dd
JOIN DONACIONES d  ON dd.id_donacion = d.id_donacion
JOIN DONADORES  dr ON d.id_donador   = dr.id_donador
JOIN PRODUCTOS  p  ON dd.id_producto = p.id_producto;

-- Q7: Productos recibidos por la Familia Perez Lopez
SELECT b.nombre_completo, p.nombre_producto, de.cantidad_entregada
FROM DETALLE_ENTREGA de
JOIN ENTREGAS      e ON de.id_entrega      = e.id_entrega
JOIN BENEFICIARIOS b ON e.id_beneficiario  = b.id_beneficiario
JOIN PRODUCTOS     p ON de.id_producto     = p.id_producto
WHERE b.nombre_completo = 'Familia Perez Lopez';

-- Q8: Producto con el inventario más alto
SELECT nombre_producto, cantidad_existencia
FROM PRODUCTOS
WHERE cantidad_existencia = (SELECT MAX(cantidad_existencia) FROM PRODUCTOS);

-- Q9: Entregas realizadas en mayo 2026
SELECT id_entrega, fecha_entrega
FROM ENTREGAS
WHERE fecha_entrega BETWEEN TO_DATE('2026-05-01','YYYY-MM-DD')
                        AND TO_DATE('2026-05-31','YYYY-MM-DD');

-- Q10: Usuarios con rol OPERADOR
SELECT nombre_usuario, rol_usuario
FROM USUARIOS WHERE rol_usuario = 'OPERADOR';

-- ============================================================
-- INTEGRANTE 2 — Queries 11 al 20
-- ============================================================

-- Q11: Total de unidades donadas por cada donador
SELECT dr.nombre_razon_social, SUM(dd.cantidad_donada) AS total_donado
FROM DETALLE_DONACION dd
JOIN DONACIONES d  ON dd.id_donacion = d.id_donacion
JOIN DONADORES  dr ON d.id_donador   = dr.id_donador
GROUP BY dr.nombre_razon_social
ORDER BY total_donado DESC;

-- Q12: Donadores que no han registrado ninguna donación
SELECT nombre_razon_social
FROM DONADORES
WHERE id_donador NOT IN (SELECT id_donador FROM DONACIONES);

-- Q13: Existencia total agrupada por categoría
SELECT categoria, SUM(cantidad_existencia) AS total_por_categoria
FROM PRODUCTOS
GROUP BY categoria ORDER BY total_por_categoria DESC;

-- Q14: Cantidad de entregas realizadas por cada beneficiario
SELECT b.nombre_completo, COUNT(e.id_entrega) AS entregas_realizadas
FROM BENEFICIARIOS b
LEFT JOIN ENTREGAS e ON b.id_beneficiario = e.id_beneficiario
GROUP BY b.nombre_completo
ORDER BY entregas_realizadas DESC;

-- Q15: Promedio de integrantes por familia beneficiaria
SELECT ROUND(AVG(num_integrantes_familia), 2) AS promedio_integrantes
FROM BENEFICIARIOS;

-- Q16: Últimas 5 donaciones registradas
SELECT d.id_donacion, dr.nombre_razon_social, d.fecha_donacion
FROM DONACIONES d
JOIN DONADORES dr ON d.id_donador = dr.id_donador
ORDER BY d.fecha_donacion DESC
FETCH FIRST 5 ROWS ONLY;

-- Q17: Productos con stock bajo (menos de 50 unidades)
SELECT nombre_producto, cantidad_existencia
FROM PRODUCTOS WHERE cantidad_existencia < 50
ORDER BY cantidad_existencia ASC;

-- Q18: Total de unidades entregadas por producto
SELECT p.nombre_producto, SUM(de.cantidad_entregada) AS total_entregado
FROM DETALLE_ENTREGA de
JOIN PRODUCTOS p ON de.id_producto = p.id_producto
GROUP BY p.nombre_producto ORDER BY total_entregado DESC;

-- Q19: Top 5 productos más donados
SELECT p.nombre_producto, SUM(dd.cantidad_donada) AS total_donado
FROM DETALLE_DONACION dd
JOIN PRODUCTOS p ON dd.id_producto = p.id_producto
GROUP BY p.nombre_producto
ORDER BY total_donado DESC
FETCH FIRST 5 ROWS ONLY;

-- Q20: Contacto de donadores que tienen correo registrado
SELECT nombre_razon_social, telefono, correo_electronico
FROM DONADORES WHERE correo_electronico IS NOT NULL;

-- ============================================================
-- INTEGRANTE 3 — Queries 21 al 30
-- ============================================================

-- Q21: Beneficiarios que nunca han recibido una entrega
SELECT nombre_completo
FROM BENEFICIARIOS
WHERE id_beneficiario NOT IN (SELECT id_beneficiario FROM ENTREGAS);

-- Q22: Productos próximos a caducar en los próximos 90 días
SELECT nombre_producto, fecha_caducidad,
       ROUND(fecha_caducidad - SYSDATE) AS dias_restantes
FROM PRODUCTOS
WHERE fecha_caducidad BETWEEN SYSDATE AND SYSDATE + 90
ORDER BY fecha_caducidad ASC;

-- Q23: Número total de donadores registrados
SELECT COUNT(*) AS total_donadores FROM DONADORES;

-- Q24: Número total de beneficiarios registrados
SELECT COUNT(*) AS total_beneficiarios FROM BENEFICIARIOS;

-- Q25: Historial de donaciones de un donador específico
SELECT d.id_donacion, p.nombre_producto, dd.cantidad_donada, d.fecha_donacion
FROM DONACIONES d
JOIN DETALLE_DONACION dd ON d.id_donacion = dd.id_donacion
JOIN PRODUCTOS        p  ON dd.id_producto = p.id_producto
WHERE d.id_donador = 1
ORDER BY d.fecha_donacion DESC;

-- Q26: Resumen mensual de donaciones (año-mes, total eventos, total unidades)
SELECT TO_CHAR(d.fecha_donacion, 'YYYY-MM') AS periodo,
       COUNT(DISTINCT d.id_donacion)         AS total_donaciones,
       SUM(dd.cantidad_donada)               AS total_unidades
FROM DONACIONES d
JOIN DETALLE_DONACION dd ON d.id_donacion = dd.id_donacion
GROUP BY TO_CHAR(d.fecha_donacion, 'YYYY-MM')
ORDER BY periodo DESC;

-- Q27: Inventario actual mostrando balance (donado - entregado) por producto
SELECT p.nombre_producto,
       NVL(SUM(dd.cantidad_donada),   0) AS total_donado,
       NVL(SUM(de.cantidad_entregada),0) AS total_entregado,
       p.cantidad_existencia             AS stock_actual
FROM PRODUCTOS p
LEFT JOIN DETALLE_DONACION dd ON p.id_producto = dd.id_producto
LEFT JOIN DETALLE_ENTREGA  de ON p.id_producto = de.id_producto
GROUP BY p.nombre_producto, p.cantidad_existencia
ORDER BY p.nombre_producto;

-- Q28: Usuarios registrados por rol
SELECT rol_usuario, COUNT(*) AS total_usuarios
FROM USUARIOS GROUP BY rol_usuario ORDER BY total_usuarios DESC;

-- Q29: Entregas del mes actual
SELECT e.id_entrega, b.nombre_completo, e.fecha_entrega
FROM ENTREGAS e
JOIN BENEFICIARIOS b ON e.id_beneficiario = b.id_beneficiario
WHERE TO_CHAR(e.fecha_entrega,'YYYY-MM') = TO_CHAR(SYSDATE,'YYYY-MM')
ORDER BY e.fecha_entrega DESC;

-- Q30: Donador con mayor cantidad total donada (histórico)
SELECT dr.nombre_razon_social,
       SUM(dd.cantidad_donada) AS total_unidades_donadas
FROM DONADORES dr
JOIN DONACIONES       d  ON dr.id_donador  = d.id_donador
JOIN DETALLE_DONACION dd ON d.id_donacion  = dd.id_donacion
GROUP BY dr.nombre_razon_social
ORDER BY total_unidades_donadas DESC
FETCH FIRST 1 ROW ONLY;