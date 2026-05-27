--  BANCO DE ALIMENTOS COMUNITARIO
--  -- UPDATEs y DELETEs
--  Fundamentos de Bases de Datos - Tercer Parcial

-- REQUISITO: 2 UPDATE Y 2 DELETE

-- 1. PRIMER UPDATE: Cambiar el teléfono de un donador específico
UPDATE DONADORES
SET telefono = '6140001111'
WHERE nombre_razon_social = 'Maria Gonzalez';

-- 2. SEGUNDO UPDATE: Actualizar la contraseña de un usuario por seguridad
UPDATE USUARIOS
SET contrasena = 'nueva_clave_2026'
WHERE nombre_usuario = 'juan_empleado';

-- 3. PRIMER DELETE: Eliminar un usuario de pruebas que ya no se necesite
DELETE FROM USUARIOS
WHERE nombre_usuario = 'sofia_auditora';

-- 4. SEGUNDO DELETE: Eliminar un donador que solicitó ser dado de baja (que no tenga transacciones ligadas)
DELETE FROM DONADORES
WHERE id_donador = 5;
COMMIT;