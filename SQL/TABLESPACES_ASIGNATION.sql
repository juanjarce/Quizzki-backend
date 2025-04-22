-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Estudiantes → estudiante_tbs
ALTER TABLE ESTUDIANTE MOVE TABLESPACE estudiante_tbs;
ALTER TABLE ESTUDIANTE_GRUPO MOVE TABLESPACE estudiante_tbs;
ALTER TABLE RESPUESTA_PRESENTACION MOVE TABLESPACE estudiante_tbs;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Profesores y contenidos → profesor_tbs
ALTER TABLE PROFESOR MOVE TABLESPACE profesor_tbs;
ALTER TABLE MATERIA MOVE TABLESPACE profesor_tbs;
ALTER TABLE UNIDAD_CURSO MOVE TABLESPACE profesor_tbs;
ALTER TABLE TEMA MOVE TABLESPACE profesor_tbs;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Evaluaciones → evaluacion_tbs
ALTER TABLE EVALUACION MOVE TABLESPACE evaluacion_tbs;
ALTER TABLE PREGUNTA MOVE TABLESPACE evaluacion_tbs;
ALTER TABLE OPCION_RESPUESTA MOVE TABLESPACE evaluacion_tbs;
ALTER TABLE PREGUNTA_EVALUACION MOVE TABLESPACE evaluacion_tbs;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Presentaciones y calificaciones → presentacion_tbs
ALTER TABLE PRESENTACION_EVALUACION MOVE TABLESPACE presentacion_tbs;
ALTER TABLE RESPUESTA_PRESENTACION MOVE TABLESPACE presentacion_tbs;
ALTER TABLE CALIFICACION MOVE TABLESPACE presentacion_tbs;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Horarios → horario_tbs
ALTER TABLE GRUPO MOVE TABLESPACE horario_tbs;
ALTER TABLE HORARIO_GRUPO MOVE TABLESPACE horario_tbs;
ALTER TABLE BLOQUE_HORARIO MOVE TABLESPACE horario_tbs;
