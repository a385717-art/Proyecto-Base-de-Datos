-- ============================================================
--  BANCO DE ALIMENTOS COMUNITARIO
--  -- 3 Procedimientos Almacenados
--  Fundamentos de Bases de Datos - Tercer Parcial
-- ============================================================
-- 1. Procedimiento: registrar_donacion
-- Inserta una donación y sus detalles (varios productos) en las tablas
CREATE OR REPLACE PROCEDURE pr_registrar_donacion (
	p_id_donador IN NUMBER,
	p_productos IN SYS.ODCINUMBERLIST, -- lista de id_producto
	p_cantidades IN SYS.ODCINUMBERLIST  -- lista paralela de cantidades
) AS
	v_id_donacion NUMBER;
BEGIN
	INSERT INTO DONACIONES (id_donacion, id_donador, fecha_donacion)
	VALUES (NULL, p_id_donador, SYSDATE)
	RETURNING id_donacion INTO v_id_donacion;

	FOR i IN 1 .. p_productos.COUNT LOOP
		INSERT INTO DETALLE_DONACION (id_detalle_donacion, id_donacion, id_producto, cantidad_donada)
		VALUES (NULL, v_id_donacion, p_productos(i), p_cantidades(i));
	END LOOP;
	COMMIT;
END;
/

-- 2. pr_total_donaciones_por_donador
CREATE OR REPLACE PROCEDURE pr_total_donaciones_por_donador (
	p_id_donador IN NUMBER,
	p_total OUT NUMBER
) AS
BEGIN
	SELECT SUM(dd.cantidad_donada) INTO p_total
	FROM DONACIONES d
	JOIN DETALLE_DONACION dd ON d.id_donacion = dd.id_donacion
	WHERE d.id_donador = p_id_donador;
	IF p_total IS NULL THEN p_total := 0; END IF;
END;
/

-- 3. pr_eliminar_donador_seguro (elimina donador solo si no tiene donaciones)
CREATE OR REPLACE PROCEDURE pr_eliminar_donador_seguro (
	p_id_donador IN NUMBER,
	p_success OUT NUMBER
) AS
	v_count NUMBER := 0;
BEGIN
	SELECT COUNT(*) INTO v_count FROM DONACIONES WHERE id_donador = p_id_donador;
	IF v_count = 0 THEN
		DELETE FROM DONADORES WHERE id_donador = p_id_donador;
		p_success := 1;
		COMMIT;
	ELSE
		p_success := 0;
	END IF;
END;
/

-- 4. pr_transferir_stock (mover cantidad entre dos productos)
CREATE OR REPLACE PROCEDURE pr_transferir_stock (
	p_id_origen IN NUMBER,
	p_id_destino IN NUMBER,
	p_cantidad IN NUMBER,
	p_success OUT NUMBER
) AS
BEGIN
	UPDATE PRODUCTOS SET cantidad_existencia = cantidad_existencia - p_cantidad WHERE id_producto = p_id_origen;
	UPDATE PRODUCTOS SET cantidad_existencia = cantidad_existencia + p_cantidad WHERE id_producto = p_id_destino;
	p_success := 1;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		p_success := 0;
		ROLLBACK;
END;
/

-- 5. Procedimiento: registrar_entrega
-- Inserta una entrega y sus detalles; actualiza inventario (usa triggers ya definidos)
CREATE OR REPLACE PROCEDURE pr_registrar_entrega (
	p_id_beneficiario IN NUMBER,
	p_productos IN SYS.ODCINUMBERLIST,
	p_cantidades IN SYS.ODCINUMBERLIST
) AS
	v_id_entrega NUMBER;
BEGIN
	INSERT INTO ENTREGAS (id_entrega, id_beneficiario, fecha_entrega)
	VALUES (NULL, p_id_beneficiario, SYSDATE)
	RETURNING id_entrega INTO v_id_entrega;

	FOR i IN 1 .. p_productos.COUNT LOOP
		INSERT INTO DETALLE_ENTREGA (id_detalle_entrega, id_entrega, id_producto, cantidad_entregada)
		VALUES (NULL, v_id_entrega, p_productos(i), p_cantidades(i));
	END LOOP;
	COMMIT;
END;
/

-- 6. Procedimiento: pr_actualizar_stock_manual
-- Permite ajustar manualmente el stock de un producto (positivo o negativo)
CREATE OR REPLACE PROCEDURE pr_actualizar_stock_manual (
	p_id_producto IN NUMBER,
	p_delta IN NUMBER
) AS
BEGIN
	UPDATE PRODUCTOS
	SET cantidad_existencia = NVL(cantidad_existencia,0) + p_delta
	WHERE id_producto = p_id_producto;
	COMMIT;
END;
/

