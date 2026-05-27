--  BANCO DE ALIMENTOS COMUNITARIO
--  -- 3 Funciones
--  Fundamentos de Bases de Datos - Tercer Parcial

-- REQUISITO: 3 FUNCIONES PL/SQL

-- 1. Obtener la existencia actual de un producto mediante su ID
CREATE OR REPLACE FUNCTION fn_obtener_stock (
p_id_producto IN NUMBER
) RETURN NUMBER AS
v_stock NUMBER := 0;
BEGIN
SELECT cantidad_existencia INTO v_stock FROM PRODUCTOS WHERE id_producto = p_id_producto;
RETURN v_stock;
EXCEPTION
WHEN NO_DATA_FOUND THEN RETURN -1;
END;
/

-- 2. Calcular cuántos integrantes de familia promedio tienen los beneficiarios registrados
CREATE OR REPLACE FUNCTION fn_promedio_integrantes RETURN NUMBER AS
v_promedio NUMBER := 0;
BEGIN
SELECT AVG(num_integrantes_familia) INTO v_promedio FROM BENEFICIARIOS;
RETURN ROUND(v_promedio, 2);
END;
/

-- 3. Validar las credenciales de un usuario del sistema (Retorna 1 si es correcto, 0 si no)
CREATE OR REPLACE FUNCTION fn_validar_usuario (
p_user IN VARCHAR2,
p_pass IN VARCHAR2
) RETURN NUMBER AS
v_conteo NUMBER := 0;
BEGIN
SELECT COUNT(*) INTO v_conteo FROM USUARIOS WHERE nombre_usuario = p_user AND contrasena = p_pass;
IF v_conteo > 0 THEN
RETURN 1;
ELSE
RETURN 0;
END IF;
END;
/

-- 4. Funcion: fn_total_unidades_donadas_por_donador
CREATE OR REPLACE FUNCTION fn_total_unidades_donadas_por_donador (
	p_id_donador IN NUMBER
) RETURN NUMBER AS
	v_total NUMBER := 0;
BEGIN
	SELECT NVL(SUM(dd.cantidad_donada),0) INTO v_total
	FROM DONACIONES d JOIN DETALLE_DONACION dd ON d.id_donacion = dd.id_donacion
	WHERE d.id_donador = p_id_donador;
	RETURN v_total;
END;
/

-- 5. Funcion: fn_esta_en_inventario (retorna 1 si existe stock >0)
CREATE OR REPLACE FUNCTION fn_esta_en_inventario (
	p_id_producto IN NUMBER
) RETURN NUMBER AS
	v_exist NUMBER := 0;
BEGIN
	SELECT CASE WHEN NVL(cantidad_existencia,0) > 0 THEN 1 ELSE 0 END INTO v_exist
	FROM PRODUCTOS WHERE id_producto = p_id_producto;
	RETURN v_exist;
EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
END;
/

-- 6. Funcion: fn_ultima_entrega_producto (ultima fecha de entrega para un producto)
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
EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
END;
/