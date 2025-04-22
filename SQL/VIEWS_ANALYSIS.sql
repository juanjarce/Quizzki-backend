-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## RendimientoEstudianteTema ##
CREATE OR REPLACE VIEW RendimientoEstudianteTema AS
SELECT
    c.id_estudiante,
    t.id_tema,
    t.nombre AS tema,
    AVG(c.nota) AS rendimiento
FROM calificacion c
         JOIN evaluacion e ON c.id_evaluacion = e.id_evaluacion
         JOIN tema t ON e.id_tema = t.id_tema
GROUP BY c.id_estudiante, t.id_tema, t.nombre;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## DuracionBloqueHorario ##
CREATE OR REPLACE VIEW DuracionBloqueHorario AS
SELECT
    id_bloque,
    dia,
    hora_inicio,
    hora_fin,
    EXTRACT(HOUR FROM (hora_fin - hora_inicio)) AS duracion_horas
FROM bloque_horario;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## InformacionBasicaEstudiante ##
CREATE OR REPLACE VIEW InformacionBasicaEstudiante AS
SELECT
    e.id_estudiante,
    e.nombre AS estudiante,
    g.nombre AS grupo,
    m.nombre AS materia
FROM estudiante e
         JOIN estudiante_grupo eg ON e.id_estudiante = eg.id_estudiante
         JOIN grupo g ON eg.id_grupo = g.id_grupo
         JOIN materia m ON g.id_materia = m.id_materia;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## PreguntasDisponiblesEval ##
CREATE OR REPLACE VIEW PreguntasDisponiblesEval AS
SELECT
    p.id_pregunta,
    p.enunciado,
    p.tipo_pregunta,
    t.nombre AS tema
FROM pregunta p
         JOIN tema t ON p.id_tema = t.id_tema
WHERE p.es_publica = 'S' AND p.estado = 'Activa';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## ExamenesDisponiblesEstudiante ##
CREATE OR REPLACE VIEW ExamenesDisponiblesEstudiante AS
SELECT
    e.id_evaluacion,
    e.nombre AS examen,
    e.fecha_hora_inicio,
    e.fecha_hora_fin,
    g.nombre AS grupo,
    t.nombre AS tema
FROM evaluacion e
         JOIN grupo g ON e.id_grupo = g.id_grupo
         JOIN tema t ON e.id_tema = t.id_tema
WHERE e.estado = 'Activa'
  AND CURRENT_TIMESTAMP BETWEEN e.fecha_hora_inicio AND e.fecha_hora_fin;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## InfoGeneralAdmin ##
CREATE OR REPLACE VIEW InfoGeneralAdmin AS
SELECT
    (SELECT COUNT(*) FROM estudiante) AS total_estudiantes,
    (SELECT COUNT(*) FROM profesor) AS total_profesores,
    (SELECT COUNT(*) FROM materia) AS total_materias,
    (SELECT COUNT(*) FROM evaluacion) AS total_evaluaciones,
    (SELECT COUNT(*) FROM pregunta) AS total_preguntas
FROM dual;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## EstudiantesPorGrupo ##
CREATE OR REPLACE VIEW EstudiantesPorGrupo AS
SELECT
    g.nombre AS grupo,
    m.nombre AS materia,
    e.nombre AS estudiante,
    e.codigo
FROM estudiante e
         JOIN estudiante_grupo eg ON e.id_estudiante = eg.id_estudiante
         JOIN grupo g ON eg.id_grupo = g.id_grupo
         JOIN materia m ON g.id_materia = m.id_materia
ORDER BY g.nombre, e.nombre;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## PreguntasPorTema ##
CREATE OR REPLACE VIEW PreguntasPorTema AS
SELECT
    t.nombre AS tema,
    COUNT(p.id_pregunta) AS total_preguntas,
    SUM(CASE WHEN p.es_publica = 'S' THEN 1 ELSE 0 END) AS preguntas_publicas
FROM tema t
         LEFT JOIN pregunta p ON t.id_tema = p.id_tema
GROUP BY t.nombre;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## PromedioPorEvaluacion ##
CREATE OR REPLACE VIEW PromedioPorEvaluacion AS
SELECT
    e.nombre AS examen,
    AVG(c.nota) AS promedio_nota,
    COUNT(c.id_calificacion) AS total_estudiantes
FROM calificacion c
         JOIN evaluacion e ON c.id_evaluacion = e.id_evaluacion
GROUP BY e.nombre;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## PreguntasConMasErrores ##
CREATE OR REPLACE VIEW PreguntasConMasErrores AS
SELECT
    p.enunciado,
    t.nombre AS tema,
    COUNT(rp.id_presentacion_pregunta) AS total_respuestas,
    SUM(CASE WHEN rp.respuesta_correcta = 'N' THEN 1 ELSE 0 END) AS errores,
    ROUND(SUM(CASE WHEN rp.respuesta_correcta = 'N' THEN 1 ELSE 0 END) / COUNT(rp.id_presentacion_pregunta) * 100, 2) AS porcentaje_error
FROM respuesta_presentacion rp
         JOIN pregunta p ON rp.id_pregunta = p.id_pregunta
         JOIN tema t ON p.id_tema = t.id_tema
GROUP BY p.enunciado, t.nombre
HAVING COUNT(rp.id_presentacion_pregunta) > 0
ORDER BY porcentaje_error DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## UsoPreguntasEnExamenes ##
CREATE OR REPLACE VIEW UsoPreguntasEnExamenes AS
SELECT
    p.enunciado,
    COUNT(pe.id_evaluacion) AS veces_usada
FROM pregunta p
         LEFT JOIN pregunta_evaluacion pe ON p.id_pregunta = pe.id_pregunta
GROUP BY p.enunciado
ORDER BY veces_usada DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## ResumenActividadProfesor ##
CREATE OR REPLACE VIEW ResumenActividadProfesor AS
SELECT
    pr.nombre AS profesor,
    COUNT(DISTINCT e.id_evaluacion) AS examenes_creados,
    COUNT(DISTINCT p.id_pregunta) AS preguntas_contribuidas
FROM profesor pr
         LEFT JOIN evaluacion e ON pr.id_profesor = e.id_profesor
         LEFT JOIN pregunta p ON pr.id_profesor = p.id_profesor
GROUP BY pr.nombre;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ## TiempoPromedioRespuesta ##
CREATE OR REPLACE VIEW TiempoPromedioRespuesta AS
SELECT
    p.enunciado,
    AVG(pe.tiempo) AS tiempo_promedio_segundos
FROM presentacion_evaluacion pe
         JOIN respuesta_presentacion rp ON pe.id_presentacion_evaluacion = rp.id_presentacion_evaluacion
         JOIN pregunta p ON rp.id_pregunta = p.id_pregunta
GROUP BY p.enunciado;
