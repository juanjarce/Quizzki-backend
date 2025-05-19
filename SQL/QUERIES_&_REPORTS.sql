-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Consulta & reporte para 'Promedio de calificaciones por materia y grupo'
SELECT
    m.nombre AS materia,
    g.nombre AS grupo,
    ROUND(AVG(c.nota), 2) AS promedio_nota
FROM
    calificacion c
        JOIN evaluacion e ON c.id_evaluacion = e.id_evaluacion
        JOIN grupo g ON e.id_grupo = g.id_grupo
        JOIN materia m ON g.id_materia = m.id_materia
GROUP BY
    m.nombre, g.nombre
ORDER BY
    m.nombre, promedio_nota DESC;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Consulta & reporte para 'Reporte de rendimiento promedio por tema y docente'
SELECT
    t.nombre AS tema,
    p.nombre AS docente,
    ROUND(AVG(CASE WHEN rp.respuesta_correcta = 'S' THEN 1 ELSE 0 END) * 5, 2) AS rendimiento_promedio,
    CASE
        WHEN AVG(CASE WHEN rp.respuesta_correcta = 'S' THEN 1 ELSE 0 END) * 5 BETWEEN 0.0 AND 3.0 THEN 'Bajo'
        WHEN AVG(CASE WHEN rp.respuesta_correcta = 'S' THEN 1 ELSE 0 END) * 5 BETWEEN 3.01 AND 4.0 THEN 'Medio'
        WHEN AVG(CASE WHEN rp.respuesta_correcta = 'S' THEN 1 ELSE 0 END) * 5 BETWEEN 4.01 AND 5.0 THEN 'Alto'
        ELSE 'N/A'
        END AS nivel_rendimiento
FROM
    respuesta_presentacion rp
        JOIN pregunta q ON rp.id_pregunta = q.id_pregunta
        JOIN tema t ON q.id_tema = t.id_tema
        JOIN presentacion_evaluacion pe ON rp.id_presentacion_evaluacion = pe.id_presentacion_evaluacion
        JOIN evaluacion e ON pe.id_evaluacion = e.id_evaluacion
        JOIN profesor p ON e.id_profesor = p.id_profesor
GROUP BY
    ROLLUP (t.nombre, p.nombre);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Consulta & reporte para 'Calificaciones promedio por estudiante y materia (PIVOT)'
SELECT * FROM (
                  SELECT
                      s.nombre AS estudiante,
                      m.nombre AS materia,
                      c.nota
                  FROM
                      calificacion c
                          JOIN estudiante s ON c.id_estudiante = s.id_estudiante
                          JOIN evaluacion e ON c.id_evaluacion = e.id_evaluacion
                          JOIN materia m ON e.id_grupo = (
                          SELECT g.id_grupo
                          FROM grupo g
                          WHERE g.id_grupo = e.id_grupo AND g.id_materia = m.id_materia
                      )
              )
                  PIVOT (
                         AVG(nota)
    FOR materia IN (
        'Matemáticas' AS matematicas,
        'Física' AS fisica,
        'Programación' AS programacion
    )
        )
ORDER BY estudiante;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Consulta & reporte para 'Número de preguntas respondidas correctamente por tema'
SELECT
    t.nombre AS tema,
    COUNT(*) AS total_respondidas,
    SUM(CASE WHEN rp.respuesta_correcta = 'S' THEN 1 ELSE 0 END) AS correctas,
    ROUND(
            100.0 * SUM(CASE WHEN rp.respuesta_correcta = 'S' THEN 1 ELSE 0 END) / COUNT(*),
            2
    ) AS porcentaje_correctas
FROM
    respuesta_presentacion rp
        JOIN pregunta p ON rp.id_pregunta = p.id_pregunta
        JOIN tema t ON p.id_tema = t.id_tema
GROUP BY
    t.nombre
ORDER BY
    porcentaje_correctas ASC;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Consulta & reporte para 'Distribución de estudiantes por grupo y semestre (PIVOT + COUNT)'
SELECT * FROM (
                  SELECT
                      g.nombre AS grupo,
                      g.semestre,
                      eg.id_estudiante
                  FROM
                      estudiante_grupo eg
                          JOIN grupo g ON eg.id_grupo = g.id_grupo
              )
     PIVOT (
    COUNT(id_estudiante)
    FOR semestre IN (
        1 AS sem_1,
        2 AS sem_2,
        3 AS sem_3,
        4 AS sem_4,
        5 AS sem_5
    )
        )
ORDER BY grupo;

