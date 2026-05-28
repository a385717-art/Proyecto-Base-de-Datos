-- ============================================================
--  BANCO DE ALIMENTOS COMUNITARIO
--  08_triggers.sql — 6 TRIGGERS (3 integrantes x 2)
-- ============================================================

-- ============================================================
-- INTEGRANTE 1 — Triggers 1 y 2 (control de inventario)
-- ============================================================

-- TRG1: Sumar al inventario cuando se registra una donación
CREATE OR REPLACE TRIGGER trg_sumar_inventario
AFTER INSERT ON DETALLE_DONACION
FOR EACH ROW
BEGIN
    UPDATE PRODUCTOS
    SET cantidad_existencia = cantidad_existencia + :NEW.cantidad_donada
    WHERE id_producto = :NEW.id_producto;
END;
/

-- TRG2: Restar del inventario cuando se registra una entrega
CREATE OR REPLACE TRIGGER trg_restar_inventario
AFTER INSERT ON DETALLE_ENTREGA
FOR EACH ROW
BEGIN
    UPDATE PRODUCTOS
    SET cantidad_existencia = cantidad_existencia - :NEW.cantidad_entregada
    WHERE id_producto = :NEW.id_producto;
END;
/

-- ============================================================
-- INTEGRANTE 2 — Triggers 3 y 4 (validaciones)
-- ============================================================

-- TRG3: Evitar que el stock de un producto sea negativo
CREATE OR REPLACE TRIGGER trg_evitar_stock_negativo
BEFORE UPDATE OF cantidad_existencia ON PRODUCTOS
FOR EACH ROW
BEGIN
    IF :NEW.cantidad_existencia < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Error: No se permite stock negativo para el producto ' || :NEW.nombre_producto
        );
    END IF;
END;
/

-- TRG4: Normalizar nombre de usuario a mayúsculas automáticamente
CREATE OR REPLACE TRIGGER trg_upper_nombre_usuario
BEFORE INSERT OR UPDATE ON USUARIOS
FOR EACH ROW
BEGIN
    :NEW.nombre_usuario := UPPER(:NEW.nombre_usuario);
END;
/

-- ============================================================
-- INTEGRANTE 3 — Triggers 5 y 6 (auditoría y validación)
-- ============================================================

-- TRG5: Validar que la cantidad entregada no supere el stock disponible
CREATE OR REPLACE TRIGGER trg_validar_stock_entrega
BEFORE INSERT ON DETALLE_ENTREGA
FOR EACH ROW
DECLARE
    v_stock NUMBER := 0;
BEGIN
    SELECT NVL(cantidad_existencia, 0) INTO v_stock
    FROM PRODUCTOS WHERE id_producto = :NEW.id_producto;

    IF :NEW.cantidad_entregada > v_stock THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Error: Stock insuficiente. Disponible: ' || v_stock ||
            ', Solicitado: ' || :NEW.cantidad_entregada
        );
    END IF;
END;
/

-- TRG6: Validar que la fecha de donación no sea futura
CREATE OR REPLACE TRIGGER trg_validar_fecha_donacion
BEFORE INSERT ON DONACIONES
FOR EACH ROW
BEGIN
    IF :NEW.fecha_donacion > SYSDATE THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Error: La fecha de donación no puede ser una fecha futura.'
        );
    END IF;
END;
/