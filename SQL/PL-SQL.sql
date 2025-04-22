-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## ASIGNAR_PREGUNTAS_ALEATORIAS ##
create or replace PROCEDURE ASIGNAR_PREGUNTAS_ALEATORIAS (
    p_id_evaluacion IN NUMBER,
    p_estado_out OUT VARCHAR2,
    p_mensaje_out OUT VARCHAR2
) AS
    v_num_aleatorias NUMBER;
    v_total_preguntas NUMBER;
    v_id_tema NUMBER;
    v_total_disponibles NUMBER;
    v_porcentaje_por_pregunta NUMBER;
BEGIN
    -- Verificar que la evaluación exista y obtener los datos necesarios
SELECT NUM_PREGUNTAS_ALEATORIAS, NUMERO_PREGUNTAS, ID_TEMA
INTO v_num_aleatorias, v_total_preguntas, v_id_tema
FROM EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion;

IF v_num_aleatorias IS NULL OR v_num_aleatorias <= 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La evaluación no tiene preguntas aleatorias por asignar';
        RETURN;
END IF;

    IF v_total_preguntas IS NULL OR v_total_preguntas <= 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La evaluación no tiene definido el número total de preguntas';
        RETURN;
END IF;

    -- Verificar si hay suficientes preguntas disponibles
SELECT COUNT(*) INTO v_total_disponibles
FROM PREGUNTA P
WHERE P.ID_TEMA = v_id_tema
  AND P.ESTADO = 'Activa'
  AND P.ES_PUBLICA = 'S'
  AND NOT EXISTS (
    SELECT 1 FROM PREGUNTA_EVALUACION PE
    WHERE PE.ID_EVALUACION = p_id_evaluacion
      AND PE.ID_PREGUNTA = P.ID_PREGUNTA
);

IF v_total_disponibles < v_num_aleatorias THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'No hay suficientes preguntas disponibles para asignar aleatoriamente.';
        RETURN;
END IF;

    -- Calcular el porcentaje por pregunta aleatoria (basado en el total de la evaluación)
    v_porcentaje_por_pregunta := 100 / v_total_preguntas;

    -- Insertar preguntas aleatorias
FOR pregunta_rec IN (
        SELECT ID_PREGUNTA
        FROM (
            SELECT P.ID_PREGUNTA
            FROM PREGUNTA P
            WHERE P.ID_TEMA = v_id_tema
              AND P.ESTADO = 'Activa'
              AND P.ES_PUBLICA = 'S'
              AND NOT EXISTS (
                  SELECT 1 FROM PREGUNTA_EVALUACION PE
                  WHERE PE.ID_EVALUACION = p_id_evaluacion
                    AND PE.ID_PREGUNTA = P.ID_PREGUNTA
              )
            ORDER BY DBMS_RANDOM.VALUE
        )
        WHERE ROWNUM <= v_num_aleatorias
    ) LOOP
        INSERT INTO PREGUNTA_EVALUACION (
            PORCENTAJE_EVALUACION,
            TIEMPO_PREGUNTA,
            TIENE_TIEMPO_MAXIMO,
            ID_PREGUNTA,
            ID_EVALUACION
        ) VALUES (
            v_porcentaje_por_pregunta,
            NULL,
            'N',
            pregunta_rec.ID_PREGUNTA,
            p_id_evaluacion
        );
END LOOP;

    -- Actualizar la evaluación para dejar el campo en 0
UPDATE EVALUACION
SET NUM_PREGUNTAS_ALEATORIAS = 0
WHERE ID_EVALUACION = p_id_evaluacion;

p_estado_out := 'EXITO';
    p_mensaje_out := 'Preguntas aleatorias asignadas correctamente';

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La evaluación con el ID proporcionado no existe';
WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## CREAR_EVALUACION ##
create or replace PROCEDURE CREAR_EVALUACION (
    -- Parámetros de entrada
    p_tiempo_max            IN NUMBER,
    p_numero_preguntas      IN NUMBER,
    p_porcentaje_curso      IN NUMBER,
    p_nombre                IN VARCHAR2,
    p_porcentaje_aprobatorio IN NUMBER,
    p_fecha_hora_inicio     IN TIMESTAMP,
    p_fecha_hora_fin        IN TIMESTAMP,
    p_num_preguntas_aleatorias IN NUMBER,
    p_id_tema               IN NUMBER,
    p_id_profesor           IN NUMBER,
    p_id_grupo              IN NUMBER,

    -- Parámetros de salida
    p_id_evaluacion_out     OUT NUMBER,
    p_resultado_out         OUT VARCHAR2,
    p_mensaje_error_out     OUT VARCHAR2
) AS
    v_existe_profesor NUMBER;
    v_existe_grupo NUMBER;
    v_existe_tema NUMBER;
    v_fecha_valida BOOLEAN := TRUE;
BEGIN
    -- Inicializar parámetros de salida
    p_id_evaluacion_out := NULL;
    p_resultado_out := 'ERROR';
    p_mensaje_error_out := NULL;

    -- Validación 1: Verificar que el profesor existe
SELECT COUNT(*) INTO v_existe_profesor
FROM PROFESOR
WHERE id_profesor = p_id_profesor;

IF v_existe_profesor = 0 THEN
        p_mensaje_error_out := 'El profesor con ID ' || p_id_profesor || ' no existe';
        RETURN;
END IF;

    -- Validación 2: Verificar que el grupo existe
SELECT COUNT(*) INTO v_existe_grupo
FROM GRUPO
WHERE id_grupo = p_id_grupo;

IF v_existe_grupo = 0 THEN
        p_mensaje_error_out := 'El grupo con ID ' || p_id_grupo || ' no existe';
        RETURN;
END IF;

    -- Validación 3: Verificar que el tema existe
SELECT COUNT(*) INTO v_existe_tema
FROM TEMA
WHERE id_tema = p_id_tema;

IF v_existe_tema = 0 THEN
        p_mensaje_error_out := 'El tema con ID ' || p_id_tema || ' no existe';
        RETURN;
END IF;

    -- Validación 4: Fechas coherentes
    IF p_fecha_hora_inicio >= p_fecha_hora_fin THEN
        p_mensaje_error_out := 'La fecha de inicio debe ser anterior a la fecha de fin';
        RETURN;
END IF;

    -- Validación 5: Porcentajes válidos
    IF p_porcentaje_curso <= 0 OR p_porcentaje_curso > 100 THEN
        p_mensaje_error_out := 'El porcentaje del curso debe estar entre 1 y 100';
        RETURN;
END IF;

    IF p_porcentaje_aprobatorio <= 0 OR p_porcentaje_aprobatorio > 100 THEN
        p_mensaje_error_out := 'El porcentaje aprobatorio debe estar entre 1 y 100';
        RETURN;
END IF;

    -- Validación 6: Número de preguntas aleatorias
    IF p_num_preguntas_aleatorias IS NOT NULL AND
       p_num_preguntas_aleatorias > p_numero_preguntas THEN
        p_mensaje_error_out := 'El número de preguntas aleatorias no puede ser mayor al total de preguntas';
        RETURN;
END IF;

        -- Validación 7: Verificar que existen suficientes preguntas activas del tema
    DECLARE
v_preguntas_disponibles NUMBER;
BEGIN
SELECT COUNT(*) INTO v_preguntas_disponibles
FROM PREGUNTA
WHERE ID_TEMA = p_id_tema
  AND ESTADO = 'Activa';

IF v_preguntas_disponibles < p_numero_preguntas THEN
            p_mensaje_error_out := 'No hay suficientes preguntas activas para el tema con ID ' || p_id_tema;
            RETURN;
END IF;
END;

    -- Insertar la nueva evaluación
INSERT INTO EVALUACION (
    ID_EVALUACION,
    TIEMPO_MAX,
    NUMERO_PREGUNTAS,
    PORCENTAJE_CURSO,
    NOMBRE,
    PORCENTAJE_APROBATORIO,
    FECHA_HORA_INICIO,
    FECHA_HORA_FIN,
    NUM_PREGUNTAS_ALEATORIAS,
    ID_TEMA,
    ID_PROFESOR,
    ID_GRUPO,
    ESTADO
) VALUES (
             SEQ_EVALUACION.NEXTVAL,  -- Asumiendo que existe una secuencia
             p_tiempo_max,
             p_numero_preguntas,
             p_porcentaje_curso,
             p_nombre,
             p_porcentaje_aprobatorio,
             p_fecha_hora_inicio,
             p_fecha_hora_fin,
             p_num_preguntas_aleatorias,
             p_id_tema,
             p_id_profesor,
             p_id_grupo,
             'Activa'
         )
    RETURNING ID_EVALUACION INTO p_id_evaluacion_out;

-- Confirmar la transacción
COMMIT;

-- Establecer resultado exitoso
p_resultado_out := 'EXITO';
    p_mensaje_error_out := NULL;

EXCEPTION
    WHEN OTHERS THEN
        -- En caso de error, hacer rollback y registrar el error
        ROLLBACK;
        p_resultado_out := 'ERROR';
        p_mensaje_error_out := 'Error al crear evaluación: ' || SQLERRM;
        p_id_evaluacion_out := NULL;
END CREAR_EVALUACION;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## CREAR_OPCION_RESPUESTA ##
create or replace PROCEDURE CREAR_OPCION_RESPUESTA (
    p_descripcion         IN VARCHAR2,
    p_es_correcta         IN CHAR,
    p_id_pregunta         IN NUMBER,
    p_id_respuesta_out    OUT NUMBER,
    p_resultado_out       OUT VARCHAR2,
    p_mensaje_error_out   OUT VARCHAR2
)
AS
    v_pregunta_existente NUMBER := 0;
BEGIN
    -- Verificar que el valor de p_es_correcta sea 'S' o 'N'
    IF p_es_correcta NOT IN ('S', 'N') THEN
        p_resultado_out := 'ERROR';
        p_mensaje_error_out := 'El campo ES_CORRECTA solo puede ser ''S'' o ''N''.';
        RETURN;
END IF;

    -- Verificar que la pregunta exista
SELECT COUNT(*) INTO v_pregunta_existente
FROM PREGUNTA
WHERE ID_PREGUNTA = p_id_pregunta;

IF v_pregunta_existente = 0 THEN
        p_resultado_out := 'ERROR';
        p_mensaje_error_out := 'La pregunta con el ID proporcionado no existe.';
        RETURN;
END IF;

    -- Insertar la opción de respuesta
INSERT INTO OPCION_RESPUESTA (ID_RESPUESTA, DESCRIPCION, ES_CORRECTA, ID_PREGUNTA)
VALUES (SEQ_OPCION_RESPUESTA.NEXTVAL, p_descripcion, p_es_correcta, p_id_pregunta)
    RETURNING ID_RESPUESTA INTO p_id_respuesta_out;

p_resultado_out := 'EXITO';
    p_mensaje_error_out := NULL;

EXCEPTION
    WHEN OTHERS THEN
        p_resultado_out := 'ERROR';
        p_mensaje_error_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## crear_pregunta ##
create or replace PROCEDURE crear_pregunta (
    p_enunciado             IN VARCHAR2,
    p_es_publica            IN CHAR,
    p_tipo_pregunta         IN VARCHAR2,
    p_id_pregunta_compuesta IN NUMBER,
    p_id_tema               IN NUMBER,
    p_id_profesor           IN NUMBER,

    -- Parámetros de salida
    p_id_pregunta_out       OUT NUMBER,
    p_resultado_out         OUT VARCHAR2,
    p_mensaje_error_out     OUT VARCHAR2
) AS
    v_id_pregunta NUMBER;
    v_tipo_valido CONSTANT SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
        'Selección única', 'Selección múltiple', 'Verdadero/Falso', 'Ordenamiento'
    );
    v_tipo_valido_encontrado BOOLEAN := FALSE;
    v_dummy NUMBER;
BEGIN
    -- Inicializar parámetros de salida
    p_id_pregunta_out := NULL;
    p_resultado_out := 'ERROR';
    p_mensaje_error_out := NULL;

    -- Validaciones básicas
    IF p_enunciado IS NULL OR LENGTH(TRIM(p_enunciado)) = 0 THEN
        p_mensaje_error_out := 'El enunciado no puede estar vacío.';
        RETURN;
END IF;

    IF p_es_publica NOT IN ('S', 'N') THEN
        p_mensaje_error_out := 'El valor de "es_publica" debe ser ''S'' o ''N''.';
        RETURN;
END IF;

    -- Validar tipo de pregunta
FOR i IN 1 .. v_tipo_valido.COUNT LOOP
        IF p_tipo_pregunta = v_tipo_valido(i) THEN
            v_tipo_valido_encontrado := TRUE;
            EXIT;
END IF;
END LOOP;

    IF NOT v_tipo_valido_encontrado THEN
        p_mensaje_error_out := 'Tipo de pregunta no válido.';
        RETURN;
END IF;

    -- Validar que el tema exista
SELECT COUNT(*) INTO v_dummy
FROM TEMA
WHERE ID_TEMA = p_id_tema;

IF v_dummy = 0 THEN
        p_mensaje_error_out := 'El ID_TEMA no existe.';
        RETURN;
END IF;

    -- Validar que el profesor exista
SELECT COUNT(*) INTO v_dummy
FROM PROFESOR
WHERE ID_PROFESOR = p_id_profesor;

IF v_dummy = 0 THEN
        p_mensaje_error_out := 'El ID_PROFESOR no existe.';
        RETURN;
END IF;

    -- Obtener siguiente valor de secuencia
SELECT SEQ_PREGUNTA.NEXTVAL INTO v_id_pregunta FROM dual;

-- Insertar pregunta
INSERT INTO PREGUNTA (
    ID_PREGUNTA,
    ENUNCIADO,
    ES_PUBLICA,
    TIPO_PREGUNTA,
    ID_PREGUNTA_COMPUESTA,
    ID_TEMA,
    ID_PROFESOR,
    ESTADO
) VALUES (
             v_id_pregunta,
             p_enunciado,
             p_es_publica,
             p_tipo_pregunta,
             p_id_pregunta_compuesta,
             p_id_tema,
             p_id_profesor,
             'Activa'
         );

-- Retornar el ID generado
p_id_pregunta_out := v_id_pregunta;

    -- Establecer resultado exitoso
    p_resultado_out := 'EXITO';
    p_mensaje_error_out := NULL;

COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- En caso de error, hacer rollback y registrar el error
        ROLLBACK;
        p_resultado_out := 'ERROR';
        p_mensaje_error_out := 'Error al crear pregunta: ' || SQLERRM;
        p_id_pregunta_out := NULL;
END crear_pregunta;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## CREAR_PREGUNTA_EVALUACION ##
create or replace PROCEDURE CREAR_PREGUNTA_EVALUACION(
    p_id_pregunta         IN NUMBER,
    p_id_evaluacion       IN NUMBER,
    p_porcentaje          IN NUMBER,
    p_tiene_tiempo_max    IN CHAR,
    p_tiempo_pregunta     IN NUMBER,
    p_estado_out          OUT VARCHAR2,
    p_mensaje_out         OUT VARCHAR2
) AS
    v_estado_pregunta       VARCHAR2(15);
    v_id_tema_pregunta      NUMBER;
    v_id_tema_evaluacion    NUMBER;
    v_total_porcentaje      NUMBER := 0;
    v_tiempo_eval           NUMBER;
    v_existe                NUMBER := 0;
    v_num_max_preguntas     NUMBER;
    v_num_preguntas_actual  NUMBER;
BEGIN
    -- Verificar que la pregunta exista y esté activa
SELECT ESTADO, ID_TEMA INTO v_estado_pregunta, v_id_tema_pregunta
FROM PREGUNTA
WHERE ID_PREGUNTA = p_id_pregunta;

IF UPPER(v_estado_pregunta) != 'ACTIVA' THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La pregunta no está activa.';
        RETURN;
END IF;

    -- Verificar que la evaluación exista y obtener su tema, tiempo y número máximo de preguntas
SELECT ID_TEMA, TIEMPO_MAX, NUMERO_PREGUNTAS
INTO v_id_tema_evaluacion, v_tiempo_eval, v_num_max_preguntas
FROM EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion;

-- Verificar que el tema coincida
IF v_id_tema_pregunta != v_id_tema_evaluacion THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La pregunta y la evaluación no pertenecen al mismo tema.';
        RETURN;
END IF;

    -- Verificar si ya está asignada
SELECT COUNT(*) INTO v_existe
FROM PREGUNTA_EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion
  AND ID_PREGUNTA = p_id_pregunta;

IF v_existe > 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La pregunta ya está asignada a la evaluación.';
        RETURN;
END IF;

    -- Verificar que aún se puedan asignar más preguntas
SELECT COUNT(*) INTO v_num_preguntas_actual
FROM PREGUNTA_EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion;

IF v_num_preguntas_actual >= v_num_max_preguntas THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La evaluación ya tiene asignado el número máximo de preguntas.';
        RETURN;
END IF;

    -- Sumar el porcentaje actual de la evaluación
SELECT NVL(SUM(PORCENTAJE_EVALUACION), 0) INTO v_total_porcentaje
FROM PREGUNTA_EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion;

IF v_total_porcentaje + p_porcentaje > 100 THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La suma de porcentajes excede el 100% en la evaluación.';
        RETURN;
END IF;

    -- Verificar tiempo si aplica
    IF p_tiene_tiempo_max = 'S' THEN
        IF p_tiempo_pregunta IS NULL OR p_tiempo_pregunta > v_tiempo_eval THEN
            p_estado_out := 'ERROR';
            p_mensaje_out := 'El tiempo de la pregunta excede el tiempo máximo de la evaluación.';
            RETURN;
END IF;
END IF;

    -- Insertar en la tabla PREGUNTA_EVALUACION
INSERT INTO PREGUNTA_EVALUACION (
    PORCENTAJE_EVALUACION,
    TIEMPO_PREGUNTA,
    TIENE_TIEMPO_MAXIMO,
    ID_PREGUNTA,
    ID_EVALUACION
) VALUES (
             p_porcentaje,
             CASE WHEN p_tiene_tiempo_max = 'S' THEN p_tiempo_pregunta ELSE NULL END,
             p_tiene_tiempo_max,
             p_id_pregunta,
             p_id_evaluacion
         );

p_estado_out := 'EXITO';
    p_mensaje_out := 'La pregunta fue asignada correctamente a la evaluación.';

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La pregunta o la evaluación no existen.';
WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## CREAR_PRESENTACION_EVALUACION ##
create or replace PROCEDURE CREAR_PRESENTACION_EVALUACION (
    p_id_evaluacion       IN  NUMBER,
    p_id_estudiante       IN  NUMBER,
    p_ip_source           IN  VARCHAR2,
    p_id_presentacion_out OUT NUMBER,
    p_estado_out          OUT VARCHAR2,
    p_mensaje_out         OUT VARCHAR2
) AS
    v_dummy NUMBER;
    v_numero_preguntas NUMBER;
    v_preguntas_asignadas NUMBER;
BEGIN
    -- Verificar si el estudiante existe
SELECT 1 INTO v_dummy
FROM ESTUDIANTE
WHERE ID_ESTUDIANTE = p_id_estudiante;

-- Verificar si la evaluación existe
SELECT 1 INTO v_dummy
FROM EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion;

-- Verificar si la evaluación tiene todas las preguntas asignadas
SELECT NUMERO_PREGUNTAS INTO v_numero_preguntas
FROM EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion;

-- Contar las preguntas asignadas a la evaluación
SELECT COUNT(*) INTO v_preguntas_asignadas
FROM PREGUNTA_EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion;

-- Verificar si el número de preguntas asignadas es igual al número de preguntas requeridas
IF v_preguntas_asignadas != v_numero_preguntas THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La evaluación no tiene todas las preguntas asignadas';
        p_id_presentacion_out := NULL;
        RETURN;
END IF;

    -- Verificar si ya existe una presentación no terminada
BEGIN
SELECT ID_PRESENTACION_EVALUACION INTO p_id_presentacion_out
FROM PRESENTACION_EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion
  AND ID_ESTUDIANTE = p_id_estudiante
  AND TERMINADO = 'N';

-- Ya existe presentación no terminada
p_estado_out := 'EXITO';
        p_mensaje_out := 'Ya existe una presentación no finalizada para esta evaluación';
        RETURN;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- No hay presentación no terminada, verificar si existe una terminada
BEGIN
SELECT 1 INTO v_dummy
FROM PRESENTACION_EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion
  AND ID_ESTUDIANTE = p_id_estudiante
  AND TERMINADO = 'S';

-- Ya presentó la evaluación completamente
p_estado_out := 'ERROR';
                p_mensaje_out := 'El estudiante ya ha presentado esta evaluación';
                RETURN;

EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    -- No hay presentación previa, se puede crear
                    INSERT INTO PRESENTACION_EVALUACION (
                        ID_PRESENTACION_EVALUACION,
                        TIEMPO,
                        TERMINADO,
                        CALIFICACION,
                        IP_SOURCE,
                        FECHA_HORA_PRESENTACION,
                        ID_EVALUACION,
                        ID_ESTUDIANTE
                    ) VALUES (
                        SEQ_PRESENTACION_EVAL.NEXTVAL,
                        NULL,
                        'N',
                        NULL,
                        p_ip_source,
                        CURRENT_TIMESTAMP,
                        p_id_evaluacion,
                        p_id_estudiante
                    )
                    RETURNING ID_PRESENTACION_EVALUACION INTO p_id_presentacion_out;

                    p_estado_out := 'EXITO';
                    p_mensaje_out := 'Presentación de evaluación creada exitosamente';
END;
END;

EXCEPTION
    WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := SQLERRM;
        p_id_presentacion_out := NULL;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## FINALIZAR_PRESENTACION_EXAMEN ##
create or replace PROCEDURE FINALIZAR_PRESENTACION_EXAMEN (
    p_id_presentacion_eval IN PRESENTACION_EVALUACION.ID_PRESENTACION_EVALUACION%TYPE,
    p_estado_out           OUT VARCHAR2,
    p_mensaje_out          OUT VARCHAR2,
    p_calificacion_out     OUT FLOAT
) AS
    v_id_evaluacion           EVALUACION.ID_EVALUACION%TYPE;
    v_total_preguntas_eval   EVALUACION.NUMERO_PREGUNTAS%TYPE;
    v_total_respuestas        NUMBER;
    v_calificacion_total      FLOAT := 0;
    v_total_correctas         NUMBER := 0;
    v_valor_pregunta          FLOAT;
BEGIN
    -- Obtener ID de evaluación asociado a la presentación
SELECT ID_EVALUACION INTO v_id_evaluacion
FROM PRESENTACION_EVALUACION
WHERE ID_PRESENTACION_EVALUACION = p_id_presentacion_eval;

-- Obtener total de preguntas de la evaluación
SELECT NUMERO_PREGUNTAS INTO v_total_preguntas_eval
FROM EVALUACION
WHERE ID_EVALUACION = v_id_evaluacion;

-- Contar cuántas preguntas ha respondido el estudiante en esta presentación
SELECT COUNT(*) INTO v_total_respuestas
FROM RESPUESTA_PRESENTACION
WHERE ID_PRESENTACION_EVALUACION = p_id_presentacion_eval;

-- Validar si respondió todas
IF v_total_respuestas < v_total_preguntas_eval THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'No se han respondido todas las preguntas.';
        p_calificacion_out := NULL;
        RETURN;
END IF;

    -- Calcular calificación sobre 5
FOR r IN (
        SELECT RP.ID_PREGUNTA, RP.RESPUESTA_CORRECTA
        FROM RESPUESTA_PRESENTACION RP
        WHERE RP.ID_PRESENTACION_EVALUACION = p_id_presentacion_eval
    ) LOOP
        IF r.RESPUESTA_CORRECTA = 'S' THEN
            -- Obtener cuánto vale esa pregunta
SELECT PORCENTAJE_EVALUACION INTO v_valor_pregunta
FROM PREGUNTA_EVALUACION
WHERE ID_PREGUNTA = r.ID_PREGUNTA
  AND ID_EVALUACION = v_id_evaluacion;

-- Sumar proporcional al total sobre 5
v_calificacion_total := v_calificacion_total + (v_valor_pregunta * 5 / 100);
END IF;
END LOOP;

    -- Actualizar tabla PRESENTACION_EVALUACION
UPDATE PRESENTACION_EVALUACION
SET TERMINADO = 'S',
    CALIFICACION = v_calificacion_total
WHERE ID_PRESENTACION_EVALUACION = p_id_presentacion_eval;

COMMIT;

p_estado_out := 'EXITO';
    p_mensaje_out := 'Presentación finalizada con éxito.';
    p_calificacion_out := v_calificacion_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'Datos no encontrados.';
        p_calificacion_out := NULL;
WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'Error inesperado: ' || SQLERRM;
        p_calificacion_out := NULL;
END FINALIZAR_PRESENTACION_EXAMEN;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## INICIO_SESION_ESTUDIANTE ##
create or replace PROCEDURE INICIO_SESION_ESTUDIANTE (
    p_correo IN VARCHAR2,
    p_contrasena IN VARCHAR2,
    p_estudiante_id OUT NUMBER,
    p_codigo OUT VARCHAR2,
    p_nombre OUT VARCHAR2,
    p_resultado OUT VARCHAR2,
    p_mensaje OUT VARCHAR2
) AS
    v_db_password VARCHAR2(63);
BEGIN
    -- Inicializar outputs
    p_estudiante_id := NULL;
    p_codigo := NULL;
    p_nombre := NULL;
    p_resultado := 'ERROR';
    p_mensaje := NULL;

    -- Verificar si el estudiante existe y obtener sus credenciales
BEGIN
SELECT ID_ESTUDIANTE, CODIGO, NOMBRE, CONTRASENA
INTO p_estudiante_id, p_codigo, p_nombre, v_db_password
FROM ESTUDIANTE
WHERE CORREO = p_correo;

-- Comparar contraseñas (en producción, utilice un hash de contraseña adecuado))
IF v_db_password = p_contrasena THEN
            p_resultado := 'EXITO';
            p_mensaje := 'Inicio de sesión exitoso';
ELSE
            p_estudiante_id := NULL;
            p_codigo := NULL;
            p_nombre := NULL;
            p_mensaje := 'Credenciales invalidas';
END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_mensaje := 'Estudiante no encontrado con este correo';
WHEN TOO_MANY_ROWS THEN
            p_mensaje := 'Multiples estudiantes con el mismo correo';
END;

EXCEPTION
    WHEN OTHERS THEN
        p_resultado := 'ERROR';
        p_mensaje := 'Error iniciando sesión: ' || SQLERRM;
END INICIO_SESION_ESTUDIANTE;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## INICIO_SESION_PROFESOR ##
create or replace PROCEDURE INICIO_SESION_PROFESOR (
    p_correo IN VARCHAR2,
    p_contrasena IN VARCHAR2,
    p_profesor_id OUT NUMBER,
    p_nombre OUT VARCHAR2,
    p_resultado OUT VARCHAR2,
    p_mensaje OUT VARCHAR2
) AS
    v_hashed_password VARCHAR2(63);
    v_db_password VARCHAR2(63);
BEGIN
    -- Iniclizar los outputs
    p_profesor_id := NULL;
    p_nombre := NULL;
    p_resultado := 'ERROR';
    p_mensaje := NULL;

    -- Verifica si el profesor existe
SELECT COUNT(*) INTO v_hashed_password
FROM PROFESOR
WHERE CORREO = p_correo;

IF v_hashed_password = 0 THEN
        p_mensaje := 'Profesor no encontrado';
        RETURN;
END IF;

    -- Obtener la contraseña almacenada (en una aplicación real, esto compararía hashes)
SELECT ID_PROFESOR, NOMBRE, CONTRASENA
INTO p_profesor_id, p_nombre, v_db_password
FROM PROFESOR
WHERE CORREO = p_correo;

-- Comparar contraseñas (en producción, utilice un hash de contraseña adecuado)
IF v_db_password = p_contrasena THEN
        p_resultado := 'EXITO';
        p_mensaje := 'Inicio de sesión exitoso';
ELSE
        p_profesor_id := NULL;
        p_nombre := NULL;
        p_mensaje := 'Credenciales invalidas';
END IF;

EXCEPTION
    WHEN OTHERS THEN
        p_resultado := 'ERROR';
        p_mensaje := 'Error en el inicio de sesión: ' || SQLERRM;
END INICIO_SESION_PROFESOR;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## OBTENER_EVALUACIONES_DISP ##
create or replace PROCEDURE OBTENER_EVALUACIONES_DISP(
    p_id_estudiante        IN  NUMBER,
    p_id_grupo             IN  NUMBER,
    p_fecha_actual         IN  VARCHAR2,  -- Cambiar a VARCHAR2
    p_evaluaciones_cursor  OUT SYS_REFCURSOR,
    p_estado_out           OUT VARCHAR2,
    p_mensaje_error_out    OUT VARCHAR2
) AS
    v_count_grupo     NUMBER;
    v_count_estudiante NUMBER;
    v_fecha_actual    TIMESTAMP;
BEGIN
    -- Convertir la fecha recibida (p_fecha_actual) a TIMESTAMP
    v_fecha_actual := TO_TIMESTAMP(p_fecha_actual, 'YYYY-MM-DD HH24:MI:SS');

    -- Verificar existencia del grupo
SELECT COUNT(*) INTO v_count_grupo FROM GRUPO WHERE ID_GRUPO = p_id_grupo;
IF v_count_grupo = 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_error_out := 'El grupo no existe.';
        RETURN;
END IF;

    -- Verificar existencia del estudiante
SELECT COUNT(*) INTO v_count_estudiante FROM ESTUDIANTE WHERE ID_ESTUDIANTE = p_id_estudiante;
IF v_count_estudiante = 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_error_out := 'El estudiante no existe.';
        RETURN;
END IF;

    -- Evaluaciones disponibles que el estudiante aún no ha presentado
OPEN p_evaluaciones_cursor FOR
SELECT E.*
FROM EVALUACION E
WHERE E.ID_GRUPO = p_id_grupo
  AND v_fecha_actual BETWEEN E.FECHA_HORA_INICIO AND E.FECHA_HORA_FIN
  AND NOT EXISTS (
    SELECT 1
    FROM PRESENTACION_EVALUACION PE
    WHERE PE.ID_EVALUACION = E.ID_EVALUACION
      AND PE.ID_ESTUDIANTE = p_id_estudiante
)
  AND E.ESTADO = 'Activa';

p_estado_out := 'EXITO';
    p_mensaje_error_out := NULL;

EXCEPTION
    WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_error_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## OBTENER_GRUPOS_ESTUDIANTE ##
create or replace PROCEDURE OBTENER_GRUPOS_ESTUDIANTE (
    -- Parámetros de entrada
    p_id_estudiante IN NUMBER,

    -- Parámetros de salida
    p_resultado_cursor OUT SYS_REFCURSOR,
    p_estado_out OUT VARCHAR2,
    p_mensaje_error_out OUT VARCHAR2
) AS
    v_existe_estudiante NUMBER;
BEGIN
    -- Inicializar parámetros de salida
    p_estado_out := 'ERROR';
    p_mensaje_error_out := NULL;

    -- Verificación: que el estudiante exista
SELECT COUNT(*) INTO v_existe_estudiante
FROM ESTUDIANTE
WHERE ID_ESTUDIANTE = p_id_estudiante;

IF v_existe_estudiante = 0 THEN
        p_mensaje_error_out := 'El estudiante con ID ' || p_id_estudiante || ' no existe';
        RETURN;
END IF;

    -- Abrir el cursor con los datos solicitados
OPEN p_resultado_cursor FOR
SELECT
    g.ID_GRUPO,
    g.NOMBRE AS NOMBRE_GRUPO,
    m.NOMBRE AS NOMBRE_MATERIA
FROM GRUPO g
         JOIN MATERIA m ON g.ID_MATERIA = m.ID_MATERIA
         JOIN ESTUDIANTE_GRUPO eg ON eg.ID_GRUPO = g.ID_GRUPO
WHERE eg.ID_ESTUDIANTE = p_id_estudiante;

-- Resultado exitoso
p_estado_out := 'EXITO';
    p_mensaje_error_out := NULL;

EXCEPTION
    WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_error_out := 'Error al obtener grupos del estudiante: ' || SQLERRM;
        IF p_resultado_cursor%ISOPEN THEN
            CLOSE p_resultado_cursor;
END IF;
END OBTENER_GRUPOS_ESTUDIANTE;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## OBTENER_GRUPOS_POR_MATERIA ##
create or replace PROCEDURE OBTENER_GRUPOS_POR_MATERIA(
    p_id_materia     IN  NUMBER,
    p_grupos_cursor  OUT SYS_REFCURSOR,
    p_estado_out     OUT VARCHAR2,
    p_mensaje_out    OUT VARCHAR2
) AS
    v_count NUMBER;
BEGIN
    -- Contamos cuántas materias existen con ese ID
SELECT COUNT(*) INTO v_count FROM MATERIA WHERE ID_MATERIA = p_id_materia;

IF v_count = 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La materia con el ID proporcionado no existe';
        RETURN;
END IF;

OPEN p_grupos_cursor FOR
SELECT ID_GRUPO, NOMBRE, SEMESTRE, ID_MATERIA
FROM GRUPO
WHERE ID_MATERIA = p_id_materia;

p_estado_out := 'EXITO';
    p_mensaje_out := NULL;

EXCEPTION
    WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## OBTENER_MATERIAS ##
create or replace PROCEDURE OBTENER_MATERIAS(
    p_materias_cursor OUT SYS_REFCURSOR,
    p_estado_out      OUT VARCHAR2,
    p_mensaje_out     OUT VARCHAR2
) AS
BEGIN
OPEN p_materias_cursor FOR
SELECT * FROM MATERIA;

p_estado_out := 'EXITO';
    p_mensaje_out := NULL;

EXCEPTION
    WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## OBTENER_OPCIONES_PREGUNTA ##
create or replace PROCEDURE OBTENER_OPCIONES_PREGUNTA (
    p_id_pregunta IN NUMBER,
    p_cursor_out OUT SYS_REFCURSOR,
    p_estado_out OUT VARCHAR2,
    p_mensaje_out OUT VARCHAR2
) AS
    v_count NUMBER;
BEGIN
    -- Verificar que la pregunta exista
SELECT COUNT(*) INTO v_count
FROM PREGUNTA
WHERE ID_PREGUNTA = p_id_pregunta;

IF v_count = 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La pregunta con el ID proporcionado no existe';
        RETURN;
END IF;

    -- Abrir cursor con las opciones de respuesta
OPEN p_cursor_out FOR
SELECT ID_RESPUESTA, DESCRIPCION, ES_CORRECTA, ID_PREGUNTA
FROM OPCION_RESPUESTA
WHERE ID_PREGUNTA = p_id_pregunta;

p_estado_out := 'EXITO';
    p_mensaje_out := 'Opciones de respuesta obtenidas correctamente';

EXCEPTION
    WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## OBTENER_PREGUNTAS_EVALUACION ##
create or replace PROCEDURE OBTENER_PREGUNTAS_EVALUACION (
    p_id_evaluacion IN NUMBER,
    p_estado_out OUT VARCHAR2,
    p_mensaje_out OUT VARCHAR2,
    p_cursor_out OUT SYS_REFCURSOR
) AS
    v_total_preguntas NUMBER;
BEGIN
    -- Verificar que la evaluación exista y obtener los datos necesarios
SELECT COUNT(*)
INTO v_total_preguntas
FROM PREGUNTA_EVALUACION
WHERE ID_EVALUACION = p_id_evaluacion;

IF v_total_preguntas <= 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La evaluación no tiene preguntas asociadas';
        RETURN;
END IF;

    -- Abrir un cursor para devolver las preguntas de la evaluación
OPEN p_cursor_out FOR
SELECT
    pe.PORCENTAJE_EVALUACION,
    pe.TIEMPO_PREGUNTA,
    pe.TIENE_TIEMPO_MAXIMO,
    p.ID_PREGUNTA,
    p.ENUNCIADO,
    p.ES_PUBLICA,
    p.TIPO_PREGUNTA,
    p.ID_PREGUNTA_COMPUESTA,
    p.ID_TEMA,
    p.ID_PROFESOR,
    p.ESTADO
FROM
    PREGUNTA_EVALUACION pe
        JOIN
    PREGUNTA p ON pe.ID_PREGUNTA = p.ID_PREGUNTA
WHERE
    pe.ID_EVALUACION = p_id_evaluacion;

p_estado_out := 'EXITO';
    p_mensaje_out := 'Preguntas de la evaluación obtenidas correctamente';

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'No se encontraron preguntas para la evaluación especificada';
WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## OBTENER_PREGUNTAS_TEMA ##
create or replace PROCEDURE OBTENER_PREGUNTAS_TEMA (
    p_id_tema         IN  NUMBER,
    p_preguntas_cursor OUT SYS_REFCURSOR,
    p_estado_out       OUT VARCHAR2,
    p_mensaje_out      OUT VARCHAR2
) AS
    v_count NUMBER;
BEGIN
    -- Verificamos que el tema exista
SELECT COUNT(*) INTO v_count FROM TEMA WHERE ID_TEMA = p_id_tema;

IF v_count = 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'El tema con el ID proporcionado no existe';
        RETURN;
END IF;

    -- Abrimos el cursor con las preguntas activas del tema
OPEN p_preguntas_cursor FOR
SELECT ID_PREGUNTA, ENUNCIADO, ES_PUBLICA, TIPO_PREGUNTA, ID_PREGUNTA_COMPUESTA,
       ID_TEMA, ID_PROFESOR, ESTADO
FROM PREGUNTA
WHERE ID_TEMA = p_id_tema
  AND ESTADO = 'Activa'
  AND ES_PUBLICA = 'S';

p_estado_out := 'EXITO';
    p_mensaje_out := NULL;

EXCEPTION
    WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## OBTENER_TEMAS ##
create or replace PROCEDURE OBTENER_TEMAS(
    p_temas_cursor       OUT SYS_REFCURSOR,
    p_estado_out         OUT VARCHAR2,
    p_mensaje_out        OUT VARCHAR2
) AS
BEGIN
OPEN p_temas_cursor FOR
SELECT ID_TEMA, NOMBRE
FROM TEMA;

p_estado_out := 'EXITO';
    p_mensaje_out := NULL;

EXCEPTION
    WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := SQLERRM;
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## REGISTRAR_RESPUESTA_ESTUDIANTE ##
create or replace PROCEDURE REGISTRAR_RESPUESTA_ESTUDIANTE (
    p_id_presentacion_eval     IN RESPUESTA_PRESENTACION.ID_PRESENTACION_EVALUACION%TYPE,
    p_id_pregunta              IN RESPUESTA_PRESENTACION.ID_PREGUNTA%TYPE,
    p_id_respuesta             IN RESPUESTA_PRESENTACION.ID_RESPUESTA%TYPE,
    p_estado_out               OUT VARCHAR2,
    p_mensaje_out              OUT VARCHAR2
) AS
    v_existente       NUMBER;
    v_correcta        OPCION_RESPUESTA.ES_CORRECTA%TYPE;
BEGIN
    -- Verificar si ya existe una respuesta para esa pregunta en la presentación
SELECT COUNT(*) INTO v_existente
FROM RESPUESTA_PRESENTACION
WHERE ID_PRESENTACION_EVALUACION = p_id_presentacion_eval
  AND ID_PREGUNTA = p_id_pregunta;

IF v_existente > 0 THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'Ya existe una respuesta registrada para esta pregunta.';
        RETURN;
END IF;

    -- Obtener si la respuesta seleccionada es correcta
SELECT ES_CORRECTA INTO v_correcta
FROM OPCION_RESPUESTA
WHERE ID_RESPUESTA = p_id_respuesta;

-- Insertar la nueva respuesta
INSERT INTO RESPUESTA_PRESENTACION (
    ID_PRESENTACION_PREGUNTA,
    RESPUESTA_CORRECTA,
    ID_PREGUNTA,
    ID_RESPUESTA,
    ID_PRESENTACION_EVALUACION
) VALUES (
             RESPUESTA_PRESENTACION_SEQ.NEXTVAL,
             v_correcta,
             p_id_pregunta,
             p_id_respuesta,
             p_id_presentacion_eval
         );

COMMIT;
p_estado_out := 'EXITO';
    p_mensaje_out := 'Respuesta registrada correctamente.';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'La respuesta especificada no existe.';
WHEN OTHERS THEN
        p_estado_out := 'ERROR';
        p_mensaje_out := 'Error inesperado: ' || SQLERRM;
END;