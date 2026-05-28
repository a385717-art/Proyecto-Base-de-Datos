-- ============================================================
--  BANCO DE ALIMENTOS COMUNITARIO
--  03_updates_deletes.sql — 3 INTEGRANTES (6 UPDATE, 6 DELETE)
-- ============================================================

-- ============================================================
-- INTEGRANTE 1 — 2 UPDATE + 2 DELETE
-- ============================================================

-- UPDATE 1: Cambiar teléfono de un donador
UPDATE DONADORES
SET telefono = '6140001111'
WHERE nombre_razon_social = 'Maria Gonzalez';

-- UPDATE 2: Actualizar contraseña de un usuario
UPDATE USUARIOS
SET contrasena = 'nueva_clave_2026'
WHERE nombre_usuario = 'juan_empleado';

-- DELETE 1: Eliminar usuario de prueba
DELETE FROM USUARIOS
WHERE nombre_usuario = 'sofia_auditora';

-- DELETE 2: Eliminar donador sin transacciones ligadas
DELETE FROM DONADORES
WHERE nombre_razon_social = 'Hogar Ayuda'
  AND id_donador NOT IN (SELECT id_donador FROM DONACIONES);

COMMIT;

-- ============================================================
-- INTEGRANTE 2 — 2 UPDATE + 2 DELETE
-- ============================================================

-- UPDATE 3: Actualizar categoría de un producto
UPDATE PRODUCTOS
SET categoria = 'Lacteos'
WHERE nombre_producto = 'Leche en Polvo 500g';

-- UPDATE 4: Actualizar dirección de un beneficiario
UPDATE BENEFICIARIOS
SET direccion = 'Calle Nueva 123, Col. Centro'
WHERE nombre_completo = 'Familia Torres';

-- DELETE 3: Eliminar un detalle de donación específico
DELETE FROM DETALLE_DONACION
WHERE id_donacion = 10 AND id_producto = 10;

-- DELETE 4: Eliminar una entrega de prueba y su detalle
DELETE FROM DETALLE_ENTREGA WHERE id_entrega = 10;
DELETE FROM ENTREGAS WHERE id_entrega = 10;

COMMIT;

-- ============================================================
-- INTEGRANTE 3 — 2 UPDATE + 2 DELETE
-- ============================================================

-- UPDATE 5: Aumentar manualmente el stock de un producto
UPDATE PRODUCTOS
SET cantidad_existencia = cantidad_existencia + 50
WHERE nombre_producto = 'Avena en Hojuelas 500g';

-- UPDATE 6: Cambiar rol de un usuario a CONSULTA
UPDATE USUARIOS
SET rol_usuario = 'CONSULTA'
WHERE nombre_usuario = 'pedro_aux';

-- DELETE 5: Eliminar un beneficiario sin entregas registradas
DELETE FROM BENEFICIARIOS
WHERE nombre_completo = 'Familia Ibarra Cruz'
  AND id_beneficiario NOT IN (SELECT id_beneficiario FROM ENTREGAS);

-- DELETE 6: Eliminar usuario inactivo
DELETE FROM USUARIOS
WHERE nombre_usuario = 'jorge_cons';

COMMIT;