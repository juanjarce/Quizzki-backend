-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Indices para estudiante_idx_tbs
-- Índices para RESPUESTA_PRESENTACION
CREATE INDEX idx_resp_pres_eval ON RESPUESTA_PRESENTACION(id_presentacion_evaluacion)
    TABLESPACE estudiante_idx_tbs;

CREATE INDEX idx_resp_pres_preg ON RESPUESTA_PRESENTACION(id_pregunta)
    TABLESPACE estudiante_idx_tbs;

-- Índices para ESTUDIANTE_GRUPO
CREATE INDEX idx_est_gru_est ON ESTUDIANTE_GRUPO(id_estudiante)
    TABLESPACE estudiante_idx_tbs;

CREATE INDEX idx_est_gru_gru ON ESTUDIANTE_GRUPO(id_grupo)
    TABLESPACE estudiante_idx_tbs;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Indices para prof_eval_idx_tbs
-- Índices para UNIDAD_CURSO
CREATE INDEX idx_unidad_mat ON UNIDAD_CURSO(id_materia)
    TABLESPACE prof_eval_idx_tbs;

-- Índices para TEMA (si lo deseas también, ya que se relaciona con unidad)
CREATE INDEX idx_tema_unidad ON TEMA(id_unidad)
    TABLESPACE prof_eval_idx_tbs;

-- Índices para EVALUACION
CREATE INDEX idx_eval_prof ON EVALUACION(id_profesor)
    TABLESPACE prof_eval_idx_tbs;

CREATE INDEX idx_eval_tema ON EVALUACION(id_tema)
    TABLESPACE prof_eval_idx_tbs;

-- Índices para OPCION_RESPUESTA
CREATE INDEX idx_opc_preg ON OPCION_RESPUESTA(id_pregunta)
    TABLESPACE prof_eval_idx_tbs;

-- Índices para PREGUNTA_EVALUACION
CREATE INDEX idx_preg_eval_eval ON PREGUNTA_EVALUACION(id_evaluacion)
    TABLESPACE prof_eval_idx_tbs;

CREATE INDEX idx_preg_eval_preg ON PREGUNTA_EVALUACION(id_pregunta)
    TABLESPACE prof_eval_idx_tbs;
