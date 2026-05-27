--  BANCO DE ALIMENTOS COMUNITARIO
--  -- 10 Consultas SQL
--  Fundamentos de Bases de Datos - Tercer Parcial

-- 1. Listar todos los productos en orden alfabético
SELECT nombre_producto, categoria, cantidad_existencia FROM PRODUCTOS ORDER BY nombre_producto ASC;

-- 2. Buscar donadores que pertenezcan a una avenida específica
SELECT nombre_razon_social, correo_electronico FROM DONADORES WHERE direccion LIKE '%Av.%';

-- 3. Contar la cantidad total de productos registrados por categoría
SELECT categoria, COUNT(*) as total_productos FROM PRODUCTOS GROUP BY categoria;

-- 4. Mostrar las familias beneficiarias que tienen más de 4 integrantes
SELECT nombre_completo, num_integrantes_familia FROM BENEFICIARIOS WHERE num_integrantes_familia > 4;

-- 5. Obtener la suma total de productos en existencia en el banco de alimentos
SELECT SUM(cantidad_existencia) as total_piezas_inventario FROM PRODUCTOS;

-- 6. Ver el detalle completo de las donaciones asociando nombres de productos y donadores
SELECT dr.nombre_razon_social, p.nombre_producto, dd.cantidad_donada
FROM DETALLE_DONACION dd
JOIN DONACIONES d ON dd.id_donacion = d.id_donacion
JOIN DONADORES dr ON d.id_donador = dr.id_donador
JOIN PRODUCTOS p ON dd.id_producto = p.id_producto;

-- 7. Mostrar qué productos ha recibido la 'Familia Perez Lopez'
SELECT b.nombre_completo, p.nombre_producto, de.cantidad_entregada
FROM DETALLE_ENTREGA de
JOIN ENTREGAS e ON de.id_entrega = e.id_entrega
JOIN BENEFICIARIOS b ON e.id_beneficiario = b.id_beneficiario
JOIN PRODUCTOS p ON de.id_producto = p.id_producto
WHERE b.nombre_completo = 'Familia Perez Lopez';

-- 8. Obtener el producto con el inventario más alto registrado
SELECT nombre_producto, cantidad_existencia FROM PRODUCTOS WHERE cantidad_existencia = (SELECT MAX(cantidad_existencia) FROM PRODUCTOS);

-- 9. Listar las entregas realizadas durante el mes de mayo de 2026
SELECT id_entrega, fecha_entrega FROM ENTREGAS WHERE fecha_entrega BETWEEN TO_DATE('2026-05-01','YYYY-MM-DD') AND TO_DATE('2026-05-31','YYYY-MM-DD');

-- 10. Listar los usuarios del sistema que tengan el rol de 'OPERADOR'
SELECT nombre_usuario FROM USUARIOS WHERE rol_usuario = 'OPERADOR';

-- ==========================================
-- 11-20: Consultas adicionales
-- ==========================================

-- 11. Total de donaciones (cantidad de piezas) por donador
SELECT dr.nombre_razon_social, SUM(dd.cantidad_donada) total_donado
FROM DETALLE_DONACION dd
JOIN DONACIONES d ON dd.id_donacion = d.id_donacion
JOIN DONADORES dr ON d.id_donador = dr.id_donador
GROUP BY dr.nombre_razon_social
ORDER BY total_donado DESC;

-- 12. Donadores que no han registrado donaciones
SELECT nombre_razon_social FROM DONADORES
WHERE id_donador NOT IN (SELECT id_donador FROM DONACIONES);

-- 13. Productos por categoría con suma de existencia
SELECT categoria, SUM(cantidad_existencia) total_por_categoria
FROM PRODUCTOS
GROUP BY categoria
ORDER BY total_por_categoria DESC;

-- 14. Cantidad de entregas por beneficiario
SELECT b.nombre_completo, COUNT(e.id_entrega) as entregas_realizadas
FROM ENTREGAS e
JOIN BENEFICIARIOS b ON e.id_beneficiario = b.id_beneficiario
GROUP BY b.nombre_completo
ORDER BY entregas_realizadas DESC;

-- 15. Promedio de integrantes por beneficiario (repetida con formato distinto)
SELECT ROUND(AVG(num_integrantes_familia),2) AS promedio_integrantes FROM BENEFICIARIOS;

-- 16. Últimas 5 donaciones registradas
SELECT d.id_donacion, dr.nombre_razon_social, d.fecha_donacion
FROM DONACIONES d
JOIN DONADORES dr ON d.id_donador = dr.id_donador
ORDER BY d.fecha_donacion DESC
FETCH FIRST 5 ROWS ONLY;

-- 17. Productos con stock bajo (menos de 50 unidades)
SELECT id_producto, nombre_producto, cantidad_existencia FROM PRODUCTOS WHERE cantidad_existencia < 50 ORDER BY cantidad_existencia ASC;

-- 18. Total entregado por producto
SELECT p.nombre_producto, SUM(de.cantidad_entregada) total_entregado
FROM DETALLE_ENTREGA de
JOIN PRODUCTOS p ON de.id_producto = p.id_producto
GROUP BY p.nombre_producto
ORDER BY total_entregado DESC;

-- 19. Top 5 productos más donados
SELECT p.nombre_producto, SUM(dd.cantidad_donada) total_donado
FROM DETALLE_DONACION dd
JOIN PRODUCTOS p ON dd.id_producto = p.id_producto
GROUP BY p.nombre_producto
ORDER BY total_donado DESC
FETCH FIRST 5 ROWS ONLY;

-- 20. Contacto rápido de donadores (nombre y correo)
SELECT nombre_razon_social, correo_electronico FROM DONADORES WHERE correo_electronico IS NOT NULL;