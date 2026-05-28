-- ============================================================
--  BANCO DE ALIMENTOS COMUNITARIO
--  06_procedimientos.sql — 9 PROCEDIMIENTOS (3 integrantes x 3)
-- ============================================================

-- ============================================================
-- INTEGRANTE 1 — Procedimientos 1 al 3
-- ============================================================

-- PR1: Registrar una donación completa con sus productos
CREATE OR REPLACE PROCEDURE pr_registrar_donacion (
    p_id_donador IN NUMBER,
    p_productos  IN SYS.ODCINUMBERLIST,
    p_cantidades IN SYS.ODCINUMBERLIST
) AS
    v_id_donacion NUMBER;
BEGIN
    INSERT INTO DONACIONES (id_donador, fecha_donacion)
    VALUES (p_id_donador, SYSDATE)
    RETURNING id_donacion INTO v_id_donacion;

    FOR i IN 1 .. p_productos.COUNT LOOP
        INSERT INTO DETALLE_DONACION (id_donacion, id_producto, cantidad_donada)
        VALUES (v_id_donacion, p_productos(i), p_cantidades(i));
    END LOOP;
    COMMIT;
END;
/

-- PR2: Obtener el total de unidades donadas por un donador
CREATE OR REPLACE PROCEDURE pr_total_donaciones_por_donador (
    p_id_donador IN  NUMBER,
    p_total      OUT NUMBER
) AS
BEGIN
    SELECT NVL(SUM(dd.cantidad_donada), 0) INTO p_total
    FROM DONACIONES d
    JOIN DETALLE_DONACION dd ON d.id_donacion = dd.id_donacion
    WHERE d.id_donador = p_id_donador;
END;
/

-- PR3: Eliminar donador solo si no tiene donaciones registradas
CREATE OR REPLACE PROCEDURE pr_eliminar_donador_seguro (
    p_id_donador IN  NUMBER,
    p_resultado  OUT NUMBER
) AS
    v_count NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM DONACIONES WHERE id_donador = p_id_donador;

    IF v_count = 0 THEN
        DELETE FROM DONADORES WHERE id_donador = p_id_donador;
        p_resultado := 1;
        COMMIT;
    ELSE
        p_resultado := 0;
    END IF;
END;
/

-- ============================================================
-- INTEGRANTE 2 — Procedimientos 4 al 6
-- ============================================================

-- PR4: Registrar una entrega completa con sus productos
CREATE OR REPLACE PROCEDURE pr_registrar_entrega (
    p_id_beneficiario IN NUMBER,
    p_productos        IN SYS.ODCINUMBERLIST,
    p_cantidades       IN SYS.ODCINUMBERLIST
) AS
    v_id_entrega NUMBER;
BEGIN
    INSERT INTO ENTREGAS (id_beneficiario, fecha_entrega)
    VALUES (p_id_beneficiario, SYSDATE)
    RETURNING id_entrega INTO v_id_entrega;

    FOR i IN 1 .. p_productos.COUNT LOOP
        INSERT INTO DETALLE_ENTREGA (id_entrega, id_producto, cantidad_entregada)
        VALUES (v_id_entrega, p_productos(i), p_cantidades(i));
    END LOOP;
    COMMIT;
END;
/

-- PR5: Transferir stock entre dos productos
CREATE OR REPLACE PROCEDURE pr_transferir_stock (
    p_id_origen  IN  NUMBER,
    p_id_destino IN  NUMBER,
    p_cantidad   IN  NUMBER,
    p_resultado  OUT NUMBER
) AS
BEGIN
    UPDATE PRODUCTOS
    SET cantidad_existencia = cantidad_existencia - p_cantidad
    WHERE id_producto = p_id_origen;

    UPDATE PRODUCTOS
    SET cantidad_existencia = cantidad_existencia + p_cantidad
    WHERE id_producto = p_id_destino;

    p_resultado := 1;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        p_resultado := 0;
        ROLLBACK;
END;
/

-- PR6: Ajuste manual de stock de un producto
CREATE OR REPLACE PROCEDURE pr_ajustar_stock_manual (
    p_id_producto IN NUMBER,
    p_delta       IN NUMBER
) AS
BEGIN
    UPDATE PRODUCTOS
    SET cantidad_existencia = NVL(cantidad_existencia, 0) + p_delta
    WHERE id_producto = p_id_producto;
    COMMIT;
END;
/

-- ============================================================
-- INTEGRANTE 3 — Procedimientos 7 al 9
-- ============================================================

-- PR7: Buscar beneficiarios por número mínimo de integrantes
CREATE OR REPLACE PROCEDURE pr_buscar_beneficiarios_por_familia (
    p_minimo    IN  NUMBER,
    p_resultado OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_resultado FOR
        SELECT id_beneficiario, nombre_completo,
               num_integrantes_familia, direccion, telefono
        FROM BENEFICIARIOS
        WHERE num_integrantes_familia >= p_minimo
        ORDER BY num_integrantes_familia DESC;
END;
/

-- PR8: Registrar un nuevo usuario en el sistema
CREATE OR REPLACE PROCEDURE pr_registrar_usuario (
    p_nombre_usuario IN VARCHAR2,
    p_contrasena     IN VARCHAR2,
    p_rol            IN VARCHAR2,
    p_resultado      OUT NUMBER
) AS
BEGIN
    INSERT INTO USUARIOS (nombre_usuario, contrasena, rol_usuario)
    VALUES (p_nombre_usuario, p_contrasena, p_rol);
    COMMIT;
    p_resultado := 1;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        p_resultado := 0;
    WHEN OTHERS THEN
        p_resultado := -1;
        ROLLBACK;
END;
/

-- PR9: Reporte de productos con stock por debajo de un umbral
CREATE OR REPLACE PROCEDURE pr_reporte_stock_bajo (
    p_umbral    IN  NUMBER,
    p_resultado OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_resultado FOR
        SELECT id_producto, nombre_producto, categoria,
               cantidad_existencia, fecha_caducidad
        FROM PRODUCTOS
        WHERE cantidad_existencia <= p_umbral
        ORDER BY cantidad_existencia ASC;
END;
/