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