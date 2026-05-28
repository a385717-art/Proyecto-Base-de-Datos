-- ============================================================
--  BANCO DE ALIMENTOS COMUNITARIO
--  07_funciones.sql — 9 FUNCIONES (3 integrantes x 3)
-- ============================================================

-- ============================================================
-- INTEGRANTE 1 — Funciones 1 al 3
-- ============================================================

-- FN1: Obtener stock actual de un producto por su ID
CREATE OR REPLACE FUNCTION fn_obtener_stock (
    p_id_producto IN NUMBER
) RETURN NUMBER AS
    v_stock NUMBER := 0;
BEGIN
    SELECT cantidad_existencia INTO v_stock
    FROM PRODUCTOS WHERE id_producto = p_id_producto;
    RETURN v_stock;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN -1;
END;
/

-- FN2: Calcular promedio de integrantes por familia beneficiaria
CREATE OR REPLACE FUNCTION fn_promedio_integrantes
RETURN NUMBER AS
    v_promedio NUMBER := 0;
BEGIN
    SELECT AVG(num_integrantes_familia) INTO v_promedio
    FROM BENEFICIARIOS;
    RETURN ROUND(v_promedio, 2);
END;
/

-- FN3: Validar credenciales de usuario (1=válido, 0=inválido)
CREATE OR REPLACE FUNCTION fn_validar_usuario (
    p_usuario    IN VARCHAR2,
    p_contrasena IN VARCHAR2
) RETURN NUMBER AS
    v_conteo NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_conteo
    FROM USUARIOS
    WHERE nombre_usuario = p_usuario
      AND contrasena     = p_contrasena;
    RETURN CASE WHEN v_conteo > 0 THEN 1 ELSE 0 END;
END;
/

-- ============================================================
-- INTEGRANTE 2 — Funciones 4 al 6
-- ============================================================

-- FN4: Total de unidades donadas por un donador específico
CREATE OR REPLACE FUNCTION fn_total_donado_por_donador (
    p_id_donador IN NUMBER
) RETURN NUMBER AS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(dd.cantidad_donada), 0) INTO v_total
    FROM DONACIONES d
    JOIN DETALLE_DONACION dd ON d.id_donacion = dd.id_donacion
    WHERE d.id_donador = p_id_donador;
    RETURN v_total;
END;
/

-- FN5: Verificar si un producto tiene stock disponible (1=sí, 0=no)
CREATE OR REPLACE FUNCTION fn_tiene_stock (
    p_id_producto IN NUMBER
) RETURN NUMBER AS
    v_result NUMBER := 0;
BEGIN
    SELECT CASE WHEN NVL(cantidad_existencia, 0) > 0 THEN 1 ELSE 0 END
    INTO v_result
    FROM PRODUCTOS WHERE id_producto = p_id_producto;
    RETURN v_result;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 0;
END;
/

-- FN6: Fecha de la última entrega registrada para un producto
CREATE OR REPLACE FUNCTION fn_ultima_entrega_producto (
    p_id_producto IN NUMBER
) RETURN DATE AS
    v_fecha DATE;
BEGIN
    SELECT MAX(e.fecha_entrega) INTO v_fecha
    FROM DETALLE_ENTREGA de
    JOIN ENTREGAS e ON de.id_entrega = e.id_entrega
    WHERE de.id_producto = p_id_producto;
    RETURN v_fecha;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
END;
/

-- ============================================================
-- INTEGRANTE 3 — Funciones 7 al 9
-- ============================================================

-- FN7: Obtener el rol de un usuario por su nombre de usuario
CREATE OR REPLACE FUNCTION fn_obtener_rol_usuario (
    p_nombre_usuario IN VARCHAR2
) RETURN VARCHAR2 AS
    v_rol VARCHAR2(20);
BEGIN
    SELECT rol_usuario INTO v_rol
    FROM USUARIOS WHERE nombre_usuario = p_nombre_usuario;
    RETURN v_rol;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 'NO_ENCONTRADO';
END;
/

-- FN8: Calcular el total de personas beneficiadas (suma de integrantes)
CREATE OR REPLACE FUNCTION fn_total_personas_beneficiadas
RETURN NUMBER AS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(num_integrantes_familia), 0) INTO v_total
    FROM BENEFICIARIOS;
    RETURN v_total;
END;
/

-- FN9: Verificar si un producto está próximo a caducar (días restantes)
--      Retorna los días restantes; negativo = ya caducó
CREATE OR REPLACE FUNCTION fn_dias_para_caducar (
    p_id_producto IN NUMBER
) RETURN NUMBER AS
    v_fecha DATE;
BEGIN
    SELECT fecha_caducidad INTO v_fecha
    FROM PRODUCTOS WHERE id_producto = p_id_producto;
    RETURN ROUND(v_fecha - SYSDATE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
END;
/