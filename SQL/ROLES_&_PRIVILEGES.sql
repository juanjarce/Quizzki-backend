-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## ROLE CREATION ##
-- Roles principales del sistema
CREATE ROLE rol_administrador;
CREATE ROLE rol_docente;
CREATE ROLE rol_estudiante;
CREATE ROLE rol_coordinador;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## TABLES - ASSIGMENT OF PRIVILEGES ##
-- Privilegios ADMINISTRADOR
GRANT ALL PRIVILEGES ON estudiante TO rol_administrador;
GRANT ALL PRIVILEGES ON grupo TO rol_administrador;
GRANT ALL PRIVILEGES ON estudiante_grupo TO rol_administrador;
GRANT ALL PRIVILEGES ON bloque_horario TO rol_administrador;
GRANT ALL PRIVILEGES ON materia TO rol_administrador;
GRANT ALL PRIVILEGES ON profesor TO rol_administrador;
GRANT ALL PRIVILEGES ON tema TO rol_administrador;
GRANT ALL PRIVILEGES ON unidad_curso TO rol_administrador;
GRANT ALL PRIVILEGES ON evaluacion TO rol_administrador;
GRANT ALL PRIVILEGES ON pregunta TO rol_administrador;
GRANT ALL PRIVILEGES ON opcion_respuesta TO rol_administrador;
GRANT ALL PRIVILEGES ON pregunta_evaluacion TO rol_administrador;
GRANT ALL PRIVILEGES ON horario_grupo TO rol_administrador;
GRANT ALL PRIVILEGES ON calificacion TO rol_administrador;
GRANT ALL PRIVILEGES ON presentacion_evaluacion TO rol_administrador;
GRANT ALL PRIVILEGES ON respuesta_presentacion TO rol_administrador;


-- Privilegios DOCENTE
-- Creación y gestión de evaluaciones/preguntas
GRANT SELECT, INSERT, UPDATE, DELETE ON tema TO rol_docente;
GRANT SELECT, INSERT, UPDATE, DELETE ON evaluacion TO rol_docente;
GRANT SELECT, INSERT, UPDATE, DELETE ON pregunta TO rol_docente;
GRANT SELECT, INSERT, UPDATE, DELETE ON opcion_respuesta TO rol_docente;
GRANT SELECT, INSERT, UPDATE, DELETE ON pregunta_evaluacion TO rol_docente;
GRANT SELECT, INSERT, UPDATE ON calificacion TO rol_docente;
-- Calificación de estudiantes
GRANT SELECT ON estudiante TO rol_docente;
GRANT SELECT ON materia TO rol_docente;
GRANT SELECT, INSERT, UPDATE ON presentacion_evaluacion TO rol_docente;
GRANT SELECT ON respuesta_presentacion TO rol_docente;


-- Privilegios ESTUDIANTE
-- Presentación de exámenes
GRANT SELECT ON pregunta TO rol_estudiante;
GRANT SELECT ON opcion_respuesta TO rol_estudiante;
GRANT SELECT, INSERT ON presentacion_evaluacion TO rol_estudiante;
GRANT SELECT, INSERT ON respuesta_presentacion TO rol_estudiante;
-- Consulta de calificaciones
GRANT SELECT ON calificacion TO rol_estudiante;
-- Consulta de horarios
GRANT SELECT ON estudiante_grupo TO rol_estudiante;
GRANT SELECT ON horario_grupo TO rol_estudiante;


-- Privilegios COORDINADOR
-- Gestión académica
GRANT SELECT, UPDATE ON grupo TO rol_coordinador;
GRANT SELECT, UPDATE ON bloque_horario TO rol_coordinador;
GRANT SELECT, UPDATE ON materia TO rol_coordinador;
GRANT SELECT, UPDATE ON profesor TO rol_coordinador;
-- Consulta de estudiantes en grupos
GRANT SELECT, UPDATE ON estudiante TO rol_coordinador;
GRANT SELECT, UPDATE ON estudiante_grupo TO rol_coordinador;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## VIEWS - ASSIGMENT OF PRIVILEGES ##
-- Privilegios ADMINISTRADOR
GRANT SELECT ON RendimientoEstudianteTema TO rol_administrador;
GRANT SELECT ON DuracionBloqueHorario TO rol_administrador;
GRANT SELECT ON InformacionBasicaEstudiante TO rol_administrador;
GRANT SELECT ON PreguntasDisponiblesEval TO rol_administrador;
GRANT SELECT ON ExamenesDisponiblesEstudiante TO rol_administrador;
GRANT SELECT ON InfoGeneralAdmin TO rol_administrador;
GRANT SELECT ON EstudiantesPorGrupo TO rol_administrador;
GRANT SELECT ON PreguntasPorTema TO rol_administrador;
GRANT SELECT ON PromedioPorEvaluacion TO rol_administrador;
GRANT SELECT ON PreguntasConMasErrores TO rol_administrador;
GRANT SELECT ON UsoPreguntasEnExamenes TO rol_administrador;
GRANT SELECT ON ResumenActividadProfesor TO rol_administrador;
GRANT SELECT ON TiempoPromedioRespuesta TO rol_administrador;


-- Privilegios DOCENTE
GRANT SELECT ON RendimientoEstudianteTema TO rol_docente;
GRANT SELECT ON PreguntasDisponiblesEval TO rol_docente;
GRANT SELECT ON PreguntasPorTema TO rol_docente;
GRANT SELECT ON PromedioPorEvaluacion TO rol_docente;
GRANT SELECT ON PreguntasConMasErrores TO rol_docente;
GRANT SELECT ON EstudiantesPorGrupo TO rol_docente;


-- Privilegios ESTUDIANTE
GRANT SELECT ON InformacionBasicaEstudiante TO rol_estudiante;
GRANT SELECT ON ExamenesDisponiblesEstudiante TO rol_estudiante;
GRANT SELECT ON DuracionBloqueHorario TO rol_estudiante;


-- Privilegios COORDINADOR
GRANT SELECT ON InfoGeneralAdmin TO rol_coordinador;
GRANT SELECT ON UsoPreguntasEnExamenes TO rol_coordinador;
GRANT SELECT ON ResumenActividadProfesor TO rol_coordinador;
GRANT SELECT ON TiempoPromedioRespuesta TO rol_coordinador;
GRANT SELECT ON EstudiantesPorGrupo TO rol_coordinador;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## SYSTEM - ASSIGMENT OF PRIVILEGES ##
-- Todos los roles necesitan CREATE SESSION para conectarse
GRANT CREATE SESSION TO rol_administrador, rol_docente, rol_estudiante, rol_coordinador;

-- Privilegios adicionales para Administrador (DDL y mantenimiento)
GRANT CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE TO rol_administrador;
GRANT UNLIMITED TABLESPACE TO rol_administrador;

-- Privilegios para Docentes (si necesitan crear objetos temporales)
GRANT CREATE SESSION, CREATE SYNONYM, CREATE VIEW TO rol_docente;

-- Privilegios mínimos para Estudiantes y Coordinadores
GRANT CREATE SESSION TO rol_estudiante, rol_coordinador;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## CREATION OF TEST USERS ##
-- 1. Usuario para Administrador (Acceso completo)
CREATE USER admin_prueba IDENTIFIED BY "admin";
GRANT rol_administrador TO admin_prueba;
ALTER USER admin_prueba DEFAULT ROLE rol_administrador;

-- 2. Usuario para Docente (Gestión académica)
CREATE USER docente_prueba IDENTIFIED BY "docente";
GRANT rol_docente TO docente_prueba;
ALTER USER docente_prueba DEFAULT ROLE rol_docente;

-- 3. Usuario para Estudiante (Acceso limitado)
CREATE USER estudiante_prueba IDENTIFIED BY "estudiante";
GRANT rol_estudiante TO estudiante_prueba;
ALTER USER estudiante_prueba DEFAULT ROLE rol_estudiante;

-- 4. Usuario para Coordinador (Gestión de grupos)
CREATE USER coordinador_prueba IDENTIFIED BY "coordinador";
GRANT rol_coordinador TO coordinador_prueba;
ALTER USER coordinador_prueba DEFAULT ROLE rol_coordinador;