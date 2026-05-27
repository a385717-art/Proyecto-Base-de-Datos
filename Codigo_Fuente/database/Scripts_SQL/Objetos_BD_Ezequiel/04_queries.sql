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