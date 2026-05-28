--  BANCO DE ALIMENTOS COMUNITARIO
--  -- 2 Triggers
--  Fundamentos de Bases de Datos - Tercer Parcial

CREATE OR REPLACE TRIGGER trg_sumar_inventario
AFTER INSERT ON DETALLE_DONACION
FOR EACH ROW
BEGIN
    UPDATE PRODUCTOS
    SET cantidad_existencia = cantidad_existencia + :NEW.cantidad_donada
    WHERE id_producto = :NEW.id_producto;
END;
/

CREATE OR REPLACE TRIGGER trg_restar_inventario
AFTER INSERT ON DETALLE_ENTREGA
FOR EACH ROW
BEGIN
    UPDATE PRODUCTOS
    SET cantidad_existencia = cantidad_existencia - :NEW.cantidad_entregada
    WHERE id_producto = :NEW.id_producto;
END;
/

-- Trigger adicional 1: evitar stock negativo al actualizar PRODUCTOS
CREATE OR REPLACE TRIGGER trg_evitar_stock_negativo
BEFORE UPDATE OF cantidad_existencia ON PRODUCTOS
FOR EACH ROW
BEGIN
    IF :NEW.cantidad_existencia < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se permite stock negativo para el producto');
    END IF;
END;
/

-- Trigger adicional 2: normalizar nombre de usuario a mayúsculas
CREATE OR REPLACE TRIGGER trg_upper_usuario
BEFORE INSERT OR UPDATE ON USUARIOS
FOR EACH ROW
BEGIN
    :NEW.nombre_usuario := UPPER(:NEW.nombre_usuario);
END;
/
/