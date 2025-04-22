-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ESTUDIANTE
CREATE TABLE estudiante (
                            id_estudiante INTEGER PRIMARY KEY,
                            codigo VARCHAR(20) NOT NULL,
                            nombre VARCHAR(63) NOT NULL,
                            correo VARCHAR(63) NOT NULL,
                            contrasena VARCHAR(63) NOT NULL
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GRUPO
CREATE TABLE grupo (
                       id_grupo INTEGER PRIMARY KEY,
                       nombre VARCHAR(63) NOT NULL,
                       semestre INTEGER NOT NULL,
                       id_materia INTEGER NOT NULL
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ESTUDIANTE_GRUPO
CREATE TABLE estudiante_grupo (
                                  id_estudiante INTEGER NOT NULL,
                                  id_grupo INTEGER NOT NULL,
                                  PRIMARY KEY (id_estudiante, id_grupo),
                                  CONSTRAINT est_grp_est_fk FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante),
                                  CONSTRAINT est_grp_grp_fk FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BLOQUE_HORARIO
CREATE TABLE bloque_horario (
                                id_bloque INTEGER PRIMARY KEY,
                                dia VARCHAR(15) NOT NULL,
                                hora_inicio TIMESTAMP NOT NULL,
                                hora_fin TIMESTAMP NOT NULL
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MATERIA
CREATE TABLE materia (
                         id_materia INTEGER PRIMARY KEY,
                         nombre VARCHAR(63) NOT NULL
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROFESOR
CREATE TABLE profesor (
                          id_profesor INTEGER PRIMARY KEY,
                          nombre VARCHAR(63) NOT NULL,
                          correo VARCHAR(63) NOT NULL,
                          contrasena VARCHAR(63) NOT NULL
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TEMA
CREATE TABLE tema (
                      id_tema INTEGER PRIMARY KEY,
                      nombre VARCHAR(63) NOT NULL,
                      id_unidad INTEGER NOT NULL
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNIDAD_CURSO
CREATE TABLE unidad_curso (
                              id_unidad INTEGER PRIMARY KEY,
                              nombre VARCHAR(63) NOT NULL,
                              id_materia INTEGER NOT NULL,
                              CONSTRAINT unidad_mat_fk FOREIGN KEY (id_materia) REFERENCES materia(id_materia)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVALUACION
CREATE TABLE evaluacion (
                            id_evaluacion INTEGER PRIMARY KEY,
                            tiempo_max INTEGER DEFAULT 120 NOT NULL,
                            numero_preguntas INTEGER NOT NULL,
                            porcentaje_curso INTEGER NOT NULL,
                            nombre VARCHAR(63),
                            porcentaje_aprobatorio INTEGER DEFAULT 60 NOT NULL,
                            fecha_hora_inicio TIMESTAMP NOT NULL,
                            fecha_hora_fin TIMESTAMP NOT NULL,
                            num_preguntas_aleatorias INTEGER,
                            id_tema INTEGER NOT NULL,
                            id_profesor INTEGER NOT NULL,
                            id_grupo INTEGER NOT NULL,
                            estado VARCHAR(15) NOT NULL,
                            CONSTRAINT eval_prof_fk FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor),
                            CONSTRAINT eval_grp_fk FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo),
                            CONSTRAINT eval_tema_fk FOREIGN KEY (id_tema) REFERENCES tema(id_tema)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PREGUNTA
CREATE TABLE pregunta (
                          id_pregunta INTEGER PRIMARY KEY,
                          enunciado VARCHAR(256) NOT NULL,
                          es_publica CHAR(1) NOT NULL,
                          tipo_pregunta VARCHAR(32) NOT NULL,
                          id_pregunta_compuesta INTEGER,
                          id_tema INTEGER NOT NULL,
                          id_profesor INTEGER NOT NULL,
                          estado VARCHAR(15) NOT NULL,
                          CONSTRAINT preg_tema_fk FOREIGN KEY (id_tema) REFERENCES tema(id_tema),
                          CONSTRAINT preg_prof_fk FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OPCION_RESPUESTA
CREATE TABLE opcion_respuesta (
                                  id_respuesta INTEGER PRIMARY KEY,
                                  descripcion VARCHAR(256) NOT NULL,
                                  es_correcta CHAR(1) NOT NULL,
                                  id_pregunta INTEGER NOT NULL,
                                  CONSTRAINT opc_resp_preg_fk FOREIGN KEY (id_pregunta) REFERENCES pregunta(id_pregunta)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PREGUNTA_EVALUACION
CREATE TABLE pregunta_evaluacion (
                                     porcentaje_evaluacion INTEGER,
                                     tiempo_pregunta INTEGER,
                                     tiene_tiempo_maximo CHAR(1) NOT NULL,
                                     id_pregunta INTEGER NOT NULL,
                                     id_evaluacion INTEGER NOT NULL,
                                     PRIMARY KEY (id_pregunta, id_evaluacion),
                                     CONSTRAINT pre_eval_preg_fk FOREIGN KEY (id_pregunta) REFERENCES pregunta(id_pregunta),
                                     CONSTRAINT pre_eval_eval_fk FOREIGN KEY (id_evaluacion) REFERENCES evaluacion(id_evaluacion)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HORARIO_GRUPO
CREATE TABLE horario_grupo (
                               id_horario INTEGER PRIMARY KEY,
                               id_grupo INTEGER NOT NULL,
                               id_bloque INTEGER NOT NULL,
                               CONSTRAINT hor_grp_fk FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo),
                               CONSTRAINT hor_bloq_fk FOREIGN KEY (id_bloque) REFERENCES bloque_horario(id_bloque)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALIFICACION
CREATE TABLE calificacion (
                              id_calificacion INTEGER PRIMARY KEY,
                              nota FLOAT NOT NULL,
                              observaciones VARCHAR(256),
                              id_estudiante INTEGER NOT NULL,
                              id_evaluacion INTEGER NOT NULL,
                              CONSTRAINT cal_est_fk FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante),
                              CONSTRAINT cal_eval_fk FOREIGN KEY (id_evaluacion) REFERENCES evaluacion(id_evaluacion)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PRESENTACION_EVALUACION
CREATE TABLE presentacion_evaluacion (
                                         id_presentacion_evaluacion INTEGER PRIMARY KEY,
                                         tiempo INTEGER,
                                         terminado CHAR(1) NOT NULL,
                                         calificacion FLOAT,
                                         ip_source VARCHAR(15),
                                         fecha_hora_presentacion TIMESTAMP,
                                         id_evaluacion INTEGER NOT NULL,
                                         id_estudiante INTEGER NOT NULL,
                                         CONSTRAINT pres_eval_eval_fk FOREIGN KEY (id_evaluacion) REFERENCES evaluacion(id_evaluacion),
                                         CONSTRAINT pres_eval_est_fk FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RESPUESTA_PRESENTACION
CREATE TABLE respuesta_presentacion (
                                        id_presentacion_pregunta INTEGER PRIMARY KEY,
                                        respuesta_correcta CHAR(1) NOT NULL,
                                        id_pregunta INTEGER NOT NULL,
                                        id_respuesta INTEGER,
                                        id_presentacion_evaluacion INTEGER NOT NULL,
                                        CONSTRAINT resp_pres_preg_fk FOREIGN KEY (id_pregunta) REFERENCES pregunta(id_pregunta),
                                        CONSTRAINT resp_pres_eval_fk FOREIGN KEY (id_presentacion_evaluacion) REFERENCES presentacion_evaluacion(id_presentacion_evaluacion)
);
