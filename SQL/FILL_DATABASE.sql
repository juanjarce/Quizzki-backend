-- ESTUDIANTE
INSERT INTO estudiante VALUES (1, '202310001', 'Laura Gómez', 'laura.gomez@uq.edu.co', 'pass123');
INSERT INTO estudiante VALUES (2, '202310002', 'Juan Pérez', 'juan.perez@uq.edu.co', 'pass123');
INSERT INTO estudiante VALUES (3, '202310003', 'Ana Ruiz', 'ana.ruiz@uq.edu.co', 'pass123');
INSERT INTO estudiante VALUES (4, '202310004', 'Luis Díaz', 'luis.diaz@uq.edu.co', 'pass123');
INSERT INTO estudiante VALUES (5, '202310005', 'Carlos Ramírez', 'carlos.ramirez@uq.edu.co', 'pass123');
INSERT INTO estudiante VALUES (6, '202310006', 'Diana Torres', 'diana.torres@uq.edu.co', 'pass123');
INSERT INTO estudiante VALUES (7, '202310007', 'María López', 'maria.lopez@uq.edu.co', 'pass123');
INSERT INTO estudiante VALUES (8, '202310008', 'Pedro Morales', 'pedro.morales@uq.edu.co', 'pass123');
INSERT INTO estudiante VALUES (9, '202310009', 'Daniela Ríos', 'daniela.rios@uq.edu.co', 'pass123');
INSERT INTO estudiante VALUES (10, '202310010', 'Miguel Castro', 'miguel.castro@uq.edu.co', 'pass123');

-- MATERIA
INSERT INTO materia VALUES (1, 'Matemáticas');
INSERT INTO materia VALUES (2, 'Programación');
INSERT INTO materia VALUES (3, 'Bases de Datos');
INSERT INTO materia VALUES (4, 'Física');
INSERT INTO materia VALUES (5, 'Estadística');
INSERT INTO materia VALUES (6, 'Estructuras de Datos');
INSERT INTO materia VALUES (7, 'Algoritmos');
INSERT INTO materia VALUES (8, 'Inteligencia Artificial');
INSERT INTO materia VALUES (9, 'Sistemas Operativos');
INSERT INTO materia VALUES (10, 'Redes');

-- PROFESOR
INSERT INTO profesor VALUES (1, 'Prof. Juan Mora', 'juan@uni.edu', 'prof1');
INSERT INTO profesor VALUES (2, 'Prof. Elena Suárez', 'elena@uni.edu', 'prof2');
INSERT INTO profesor VALUES (3, 'Prof. Hugo Ramírez', 'hugo@uni.edu', 'prof3');
INSERT INTO profesor VALUES (4, 'Prof. Rosa Vargas', 'rosa@uni.edu', 'prof4');
INSERT INTO profesor VALUES (5, 'Prof. David Torres', 'david@uni.edu', 'prof5');
INSERT INTO profesor VALUES (6, 'Prof. Mónica Pérez', 'monica@uni.edu', 'prof6');
INSERT INTO profesor VALUES (7, 'Prof. Sergio Díaz', 'sergio@uni.edu', 'prof7');
INSERT INTO profesor VALUES (8, 'Prof. Karla Mejía', 'karla@uni.edu', 'prof8');
INSERT INTO profesor VALUES (9, 'Prof. Pedro Gómez', 'pedro@uni.edu', 'prof9');
INSERT INTO profesor VALUES (10, 'Prof. Andrea Ruiz', 'andrea@uni.edu', 'prof10');

-- GRUPO
INSERT INTO grupo VALUES (1, 'Grupo A', 1, 1);
INSERT INTO grupo VALUES (2, 'Grupo B', 2, 2);
INSERT INTO grupo VALUES (3, 'Grupo C', 3, 3);
INSERT INTO grupo VALUES (4, 'Grupo D', 1, 4);
INSERT INTO grupo VALUES (5, 'Grupo E', 2, 5);
INSERT INTO grupo VALUES (6, 'Grupo F', 3, 6);
INSERT INTO grupo VALUES (7, 'Grupo G', 4, 7);
INSERT INTO grupo VALUES (8, 'Grupo H', 4, 8);
INSERT INTO grupo VALUES (9, 'Grupo I', 5, 9);
INSERT INTO grupo VALUES (10, 'Grupo J', 5, 10);

-- ESTUDIANTE_GRUPO
INSERT INTO estudiante_grupo VALUES (1, 1);
INSERT INTO estudiante_grupo VALUES (1, 2);
INSERT INTO estudiante_grupo VALUES (2, 2);
INSERT INTO estudiante_grupo VALUES (2, 3);
INSERT INTO estudiante_grupo VALUES (3, 1);
INSERT INTO estudiante_grupo VALUES (3, 3);
INSERT INTO estudiante_grupo VALUES (4, 4);
INSERT INTO estudiante_grupo VALUES (4, 5);
INSERT INTO estudiante_grupo VALUES (5, 5);
INSERT INTO estudiante_grupo VALUES (5, 6);
INSERT INTO estudiante_grupo VALUES (6, 6);
INSERT INTO estudiante_grupo VALUES (6, 7);
INSERT INTO estudiante_grupo VALUES (7, 7);
INSERT INTO estudiante_grupo VALUES (7, 8);
INSERT INTO estudiante_grupo VALUES (8, 8);
INSERT INTO estudiante_grupo VALUES (8, 9);
INSERT INTO estudiante_grupo VALUES (9, 9);
INSERT INTO estudiante_grupo VALUES (9, 10);
INSERT INTO estudiante_grupo VALUES (10, 10);
INSERT INTO estudiante_grupo VALUES (10, 1);

-- BLOQUE_HORARIO
INSERT INTO bloque_horario VALUES (1, 'Lunes', TO_DATE('2025-04-14 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-14 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO bloque_horario VALUES (2, 'Martes', TO_DATE('2025-04-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO bloque_horario VALUES (3, 'Miércoles', TO_DATE('2025-04-16 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-16 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO bloque_horario VALUES (4, 'Jueves', TO_DATE('2025-04-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-17 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO bloque_horario VALUES (5, 'Viernes', TO_DATE('2025-04-18 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO bloque_horario VALUES (6, 'Lunes', TO_DATE('2025-04-21 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-21 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO bloque_horario VALUES (7, 'Martes', TO_DATE('2025-04-22 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-22 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO bloque_horario VALUES (8, 'Miércoles', TO_DATE('2025-04-23 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-23 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO bloque_horario VALUES (9, 'Jueves', TO_DATE('2025-04-24 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-24 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO bloque_horario VALUES (10, 'Viernes', TO_DATE('2025-04-25 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- UNIDAD_CURSO
INSERT INTO unidad_curso VALUES (1, 'Álgebra', 1);
INSERT INTO unidad_curso VALUES (2, 'Ecuaciones', 1);
INSERT INTO unidad_curso VALUES (3, 'POO', 2);
INSERT INTO unidad_curso VALUES (4, 'Base de Datos Relacional', 3);
INSERT INTO unidad_curso VALUES (5, 'Normalización', 3);
INSERT INTO unidad_curso VALUES (6, 'Leyes de Newton', 4);
INSERT INTO unidad_curso VALUES (7, 'Estadística Descriptiva', 5);
INSERT INTO unidad_curso VALUES (8, 'Listas Enlazadas', 6);
INSERT INTO unidad_curso VALUES (9, 'Ordenamiento', 7);
INSERT INTO unidad_curso VALUES (10, 'Aprendizaje Supervisado', 8);

-- TEMA
INSERT INTO tema VALUES (1, 'Fracciones', 1);
INSERT INTO tema VALUES (2, 'Ecuaciones Lineales', 2);
INSERT INTO tema VALUES (3, 'Clases', 3);
INSERT INTO tema VALUES (4, 'SQL Básico', 4);
INSERT INTO tema VALUES (5, 'Formas Normales', 5);
INSERT INTO tema VALUES (6, 'MRU', 6);
INSERT INTO tema VALUES (7, 'Moda y Media', 7);
INSERT INTO tema VALUES (8, 'Listas Dobles', 8);
INSERT INTO tema VALUES (9, 'QuickSort', 9);
INSERT INTO tema VALUES (10, 'Red Neuronal', 10);

-- EVALUACION
-- Insertar nuevas evaluaciones coherentes con los temas seleccionados
INSERT INTO evaluacion VALUES (1, 60, 5, 20, 'Examen Fracciones 1', 60, TO_DATE('2025-04-14 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-14 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 1, 1, 1, 'Activa');
INSERT INTO evaluacion VALUES (2, 45, 4, 15, 'Quiz Fracciones', 60, TO_DATE('2025-04-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-15 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 1, 2, 1, 'Activa');
INSERT INTO evaluacion VALUES (3, 90, 6, 25, 'Parcial SQL 1', 60, TO_DATE('2025-04-16 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-16 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 4, 3, 2, 'Activa');
INSERT INTO evaluacion VALUES (4, 60, 5, 20, 'Examen Fracciones 2', 60, TO_DATE('2025-04-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 1, 4, 1, 'Activa');
INSERT INTO evaluacion VALUES (5, 75, 5, 25, 'Parcial SQL 2', 60, TO_DATE('2025-04-18 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-18 12:15:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 4, 5, 2, 'Activa');
INSERT INTO evaluacion VALUES (6, 60, 4, 15, 'Quiz SQL', 60, TO_DATE('2025-04-19 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 6, 2, 'Activa');
INSERT INTO evaluacion VALUES (7, 90, 6, 30, 'Final Fracciones', 60, TO_DATE('2025-04-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-20 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 1, 7, 1, 'Activa');
INSERT INTO evaluacion VALUES (8, 90, 6, 30, 'Final SQL', 60, TO_DATE('2025-04-21 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-21 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 4, 8, 2, 'Activa');
INSERT INTO evaluacion VALUES (9, 60, 5, 20, 'Recuperación Fracciones', 60, TO_DATE('2025-04-22 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-22 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 1, 9, 1, 'Activa');
INSERT INTO evaluacion VALUES (10, 60, 5, 20, 'Recuperación SQL', 60, TO_DATE('2025-04-23 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-23 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 4, 10, 2, 'Activa');

-- PREGUNTA
-- Preguntas sobre Fracciones (Tema 1)
INSERT INTO pregunta VALUES (1, '¿Cuál es el resultado de 1/2 + 1/4?', 'S', 'Selección única', NULL, 1, 1, 'Activa');
INSERT INTO pregunta VALUES (2, '¿Cuál es la fracción equivalente a 0.75?', 'S', 'Selección única', NULL, 1, 2, 'Activa');
INSERT INTO pregunta VALUES (3, 'Al simplificar 6/8 obtenemos:', 'S', 'Selección única', NULL, 1, 3, 'Activa');
INSERT INTO pregunta VALUES (4, '¿Cuál es el resultado de 3/5 × 2/3?', 'S', 'Selección única', NULL, 1, 4, 'Activa');
INSERT INTO pregunta VALUES (5, '¿Cómo se representa gráficamente 1/4?', 'S', 'Selección múltiple', NULL, 1, 5, 'Activa');
INSERT INTO pregunta VALUES (6, 'Verdadero o Falso: 5/10 es igual a 1/2', 'S', 'Verdadero/Falso', NULL, 1, 6, 'Activa');
INSERT INTO pregunta VALUES (7, 'Ordena de menor a mayor: 1/2, 1/3, 1/4', 'S', 'Ordenamiento', NULL, 1, 7, 'Activa');
INSERT INTO pregunta VALUES (8, '¿Cuál es el resultado de 1/2 ÷ 1/4?', 'S', 'Selección única', NULL, 1, 8, 'Activa');
INSERT INTO pregunta VALUES (9, 'Problema: Si tengo 3/4 de pizza y como 1/2, ¿cuánto me queda?', 'S', 'Selección única', NULL, 1, 9, 'Activa');
INSERT INTO pregunta VALUES (10, '¿Qué fracción representa la parte sombreada? (imagen)', 'S', 'Selección única', NULL, 1, 10, 'Activa');

-- Preguntas sobre SQL (Tema 4)
INSERT INTO pregunta VALUES (11, '¿Qué comando SQL se usa para consultar datos?', 'S', 'Selección única', NULL, 4, 1, 'Activa');
INSERT INTO pregunta VALUES (12, '¿Para qué sirve el comando WHERE?', 'S', 'Selección múltiple', NULL, 4, 2, 'Activa');
INSERT INTO pregunta VALUES (13, 'Verdadero o Falso: ORDER BY ordena resultados', 'S', 'Verdadero/Falso', NULL, 4, 3, 'Activa');
INSERT INTO pregunta VALUES (14, '¿Qué tipo de JOIN devuelve todos los registros de ambas tablas?', 'S', 'Selección única', NULL, 4, 4, 'Activa');
INSERT INTO pregunta VALUES (15, '¿Cuál es la función de GROUP BY?', 'S', 'Selección múltiple', NULL, 4, 5, 'Activa');
INSERT INTO pregunta VALUES (16, 'Ejemplo de filtro con LIKE:', 'S', 'Selección única', NULL, 4, 6, 'Activa');
INSERT INTO pregunta VALUES (17, '¿Qué hace el comando DISTINCT?', 'S', 'Selección única', NULL, 4, 7, 'Activa');
INSERT INTO pregunta VALUES (18, 'Ordena los pasos para una consulta básica:', 'S', 'Ordenamiento', NULL, 4, 8, 'Activa');
INSERT INTO pregunta VALUES (19, '¿Qué comando modifica datos existentes?', 'S', 'Selección única', NULL, 4, 9, 'Activa');
INSERT INTO pregunta VALUES (20, '¿Cuál es la sintaxis correcta para SELECT con JOIN?', 'S', 'Selección múltiple', NULL, 4, 10, 'Activa');

-- OPCION_RESPUESTA
-- Opciones para preguntas de Fracciones
INSERT INTO opcion_respuesta VALUES (1, '3/4', 'S', 1);
INSERT INTO opcion_respuesta VALUES (2, '2/6', 'N', 1);
INSERT INTO opcion_respuesta VALUES (3, '3/4', 'S', 2);
INSERT INTO opcion_respuesta VALUES (4, '1/4', 'N', 2);
INSERT INTO opcion_respuesta VALUES (5, '3/4', 'S', 3);
INSERT INTO opcion_respuesta VALUES (6, '2/3', 'N', 3);
INSERT INTO opcion_respuesta VALUES (7, '2/5', 'S', 4);
INSERT INTO opcion_respuesta VALUES (8, '6/15', 'N', 4);
INSERT INTO opcion_respuesta VALUES (9, 'Un cuarto del círculo sombreado', 'S', 5);
INSERT INTO opcion_respuesta VALUES (10, 'Dos octavos del rectángulo sombreados', 'S', 5);
INSERT INTO opcion_respuesta VALUES (11, 'Verdadero', 'S', 6);
INSERT INTO opcion_respuesta VALUES (12, 'Falso', 'N', 6);
INSERT INTO opcion_respuesta VALUES (13, '1/4, 1/3, 1/2', 'S', 7);
INSERT INTO opcion_respuesta VALUES (14, '1/2, 1/3, 1/4', 'N', 7);
INSERT INTO opcion_respuesta VALUES (15, '2', 'S', 8);
INSERT INTO opcion_respuesta VALUES (16, '1/8', 'N', 8);
INSERT INTO opcion_respuesta VALUES (17, '1/4', 'S', 9);
INSERT INTO opcion_respuesta VALUES (18, '1/2', 'N', 9);
INSERT INTO opcion_respuesta VALUES (19, '3/8', 'S', 10);
INSERT INTO opcion_respuesta VALUES (20, '5/8', 'N', 10);

-- Opciones para preguntas de SQL
INSERT INTO opcion_respuesta VALUES (21, 'SELECT', 'S', 11);
INSERT INTO opcion_respuesta VALUES (22, 'GET', 'N', 11);
INSERT INTO opcion_respuesta VALUES (23, 'Filtrar registros', 'S', 12);
INSERT INTO opcion_respuesta VALUES (24, 'Ordenar resultados', 'N', 12);
INSERT INTO opcion_respuesta VALUES (25, 'Verdadero', 'S', 13);
INSERT INTO opcion_respuesta VALUES (26, 'Falso', 'N', 13);
INSERT INTO opcion_respuesta VALUES (27, 'FULL OUTER JOIN', 'S', 14);
INSERT INTO opcion_respuesta VALUES (28, 'INNER JOIN', 'N', 14);
INSERT INTO opcion_respuesta VALUES (29, 'Agrupar resultados', 'S', 15);
INSERT INTO opcion_respuesta VALUES (30, 'Aplicar funciones de agregación', 'S', 15);
INSERT INTO opcion_respuesta VALUES (31, 'WHERE nombre LIKE "A%"', 'S', 16);
INSERT INTO opcion_respuesta VALUES (32, 'WHERE nombre = "A"', 'N', 16);
INSERT INTO opcion_respuesta VALUES (33, 'Elimina duplicados', 'S', 17);
INSERT INTO opcion_respuesta VALUES (34, 'Ordena los resultados', 'N', 17);
INSERT INTO opcion_respuesta VALUES (35, 'SELECT, FROM, WHERE, ORDER BY', 'S', 18);
INSERT INTO opcion_respuesta VALUES (36, 'FROM, SELECT, WHERE, ORDER BY', 'N', 18);
INSERT INTO opcion_respuesta VALUES (37, 'UPDATE', 'S', 19);
INSERT INTO opcion_respuesta VALUES (38, 'ALTER', 'N', 19);
INSERT INTO opcion_respuesta VALUES (39, 'SELECT a.campo, b.campo FROM tabla1 a JOIN tabla2 b ON a.id = b.id', 'S', 20);
INSERT INTO opcion_respuesta VALUES (40, 'SELECT campo FROM tabla1, tabla2 WHERE tabla1.id = tabla2.id', 'S', 20);

--  PREGUNTA_EVALUACION
-- Asignar preguntas de Fracciones a evaluaciones de Fracciones (1-10)
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 1, 1);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 2, 1);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 3, 1);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 4, 2);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 5, 2);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 6, 4);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 7, 4);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 8, 7);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 9, 7);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 10, 9);

-- Asignar preguntas de SQL a evaluaciones de SQL (11-20)
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 11, 3);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 12, 3);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 13, 3);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 14, 5);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 15, 5);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 16, 6);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 17, 6);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 18, 8);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 19, 8);
INSERT INTO pregunta_evaluacion VALUES (20, 5, 'S', 20, 10);

-- PRESENTACION_EVALUACION
-- Presentaciones para evaluaciones de Fracciones (10 registros)
INSERT INTO presentacion_evaluacion VALUES (1, 55, 'S', 85.0, '192.168.1.1', TO_DATE('2025-04-14 08:05:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1);
INSERT INTO presentacion_evaluacion VALUES (2, 50, 'S', 90.0, '192.168.1.2', TO_DATE('2025-04-15 09:10:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 2);
INSERT INTO presentacion_evaluacion VALUES (3, 58, 'S', 75.5, '192.168.1.3', TO_DATE('2025-04-17 10:05:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 3);
INSERT INTO presentacion_evaluacion VALUES (4, 45, 'S', 82.0, '192.168.1.4', TO_DATE('2025-04-20 10:10:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 4);
INSERT INTO presentacion_evaluacion VALUES (5, 60, 'S', 78.5, '192.168.1.5', TO_DATE('2025-04-22 10:05:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 5);
INSERT INTO presentacion_evaluacion VALUES (6, 52, 'S', 88.0, '192.168.1.6', TO_DATE('2025-04-14 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 6);
INSERT INTO presentacion_evaluacion VALUES (7, 48, 'S', 92.0, '192.168.1.7', TO_DATE('2025-04-15 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 7);
INSERT INTO presentacion_evaluacion VALUES (8, 55, 'S', 80.0, '192.168.1.8', TO_DATE('2025-04-17 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 8);
INSERT INTO presentacion_evaluacion VALUES (9, 50, 'S', 85.5, '192.168.1.9', TO_DATE('2025-04-20 10:20:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 9);
INSERT INTO presentacion_evaluacion VALUES (10, 57, 'S', 90.0, '192.168.1.10', TO_DATE('2025-04-22 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 10);

-- Presentaciones para evaluaciones de SQL (10 registros)
INSERT INTO presentacion_evaluacion VALUES (11, 85, 'S', 92.0, '192.168.2.1', TO_DATE('2025-04-16 14:05:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 1);
INSERT INTO presentacion_evaluacion VALUES (12, 78, 'S', 88.0, '192.168.2.2', TO_DATE('2025-04-18 11:10:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 2);
INSERT INTO presentacion_evaluacion VALUES (13, 82, 'S', 95.0, '192.168.2.3', TO_DATE('2025-04-19 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 3);
INSERT INTO presentacion_evaluacion VALUES (14, 88, 'S', 80.0, '192.168.2.4', TO_DATE('2025-04-21 08:20:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 4);
INSERT INTO presentacion_evaluacion VALUES (15, 75, 'S', 85.5, '192.168.2.5', TO_DATE('2025-04-23 11:25:00', 'YYYY-MM-DD HH24:MI:SS'), 10, 5);
INSERT INTO presentacion_evaluacion VALUES (16, 80, 'S', 90.0, '192.168.2.6', TO_DATE('2025-04-16 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 6);
INSERT INTO presentacion_evaluacion VALUES (17, 77, 'S', 75.0, '192.168.2.7', TO_DATE('2025-04-18 11:20:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 7);
INSERT INTO presentacion_evaluacion VALUES (18, 83, 'S', 82.0, '192.168.2.8', TO_DATE('2025-04-19 13:25:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 8);
INSERT INTO presentacion_evaluacion VALUES (19, 79, 'S', 88.5, '192.168.2.9', TO_DATE('2025-04-21 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 9);
INSERT INTO presentacion_evaluacion VALUES (20, 76, 'S', 91.0, '192.168.2.10', TO_DATE('2025-04-23 11:35:00', 'YYYY-MM-DD HH24:MI:SS'), 10, 10);

-- RESPUESTA_PRESENTACION
-- Respuestas para evaluaciones de Fracciones (10 registros)
INSERT INTO respuesta_presentacion VALUES (1, 'S', 1, 1, 1);
INSERT INTO respuesta_presentacion VALUES (2, 'S', 2, 3, 1);
INSERT INTO respuesta_presentacion VALUES (3, 'S', 3, 5, 2);
INSERT INTO respuesta_presentacion VALUES (4, 'S', 4, 7, 2);
INSERT INTO respuesta_presentacion VALUES (5, 'S', 5, 9, 3);
INSERT INTO respuesta_presentacion VALUES (6, 'S', 6, 11, 4);
INSERT INTO respuesta_presentacion VALUES (7, 'S', 7, 13, 5);
INSERT INTO respuesta_presentacion VALUES (8, 'S', 8, 15, 6);
INSERT INTO respuesta_presentacion VALUES (9, 'S', 9, 17, 7);
INSERT INTO respuesta_presentacion VALUES (10, 'S', 10, 19, 8);

-- Respuestas para evaluaciones de SQL (10 registros)
INSERT INTO respuesta_presentacion VALUES (11, 'S', 11, 21, 11);
INSERT INTO respuesta_presentacion VALUES (12, 'S', 12, 23, 11);
INSERT INTO respuesta_presentacion VALUES (13, 'S', 13, 25, 12);
INSERT INTO respuesta_presentacion VALUES (14, 'S', 14, 27, 13);
INSERT INTO respuesta_presentacion VALUES (15, 'S', 15, 29, 14);
INSERT INTO respuesta_presentacion VALUES (16, 'S', 16, 31, 15);
INSERT INTO respuesta_presentacion VALUES (17, 'S', 17, 33, 16);
INSERT INTO respuesta_presentacion VALUES (18, 'S', 18, 35, 17);
INSERT INTO respuesta_presentacion VALUES (19, 'S', 19, 37, 18);
INSERT INTO respuesta_presentacion VALUES (20, 'S', 20, 39, 19);

-- CALIFICACION
-- Calificaciones para evaluaciones de Fracciones (10 registros)
INSERT INTO calificacion VALUES (1, 85.0, 'Buen desempeño en fracciones', 1, 1);
INSERT INTO calificacion VALUES (2, 90.0, 'Excelente comprensión de conceptos', 2, 2);
INSERT INTO calificacion VALUES (3, 75.5, 'Necesita practicar más', 3, 4);
INSERT INTO calificacion VALUES (4, 82.0, 'Buen trabajo en general', 4, 7);
INSERT INTO calificacion VALUES (5, 78.5, 'Aprobado, puede mejorar', 5, 9);
INSERT INTO calificacion VALUES (6, 88.0, 'Muy buen desempeño', 6, 1);
INSERT INTO calificacion VALUES (7, 92.0, 'Sobresaliente', 7, 2);
INSERT INTO calificacion VALUES (8, 80.0, 'Satisfactorio', 8, 4);
INSERT INTO calificacion VALUES (9, 85.5, 'Buen manejo de conceptos', 9, 7);
INSERT INTO calificacion VALUES (10, 90.0, 'Excelente trabajo', 10, 9);

-- Calificaciones para evaluaciones de SQL (10 registros)
INSERT INTO calificacion VALUES (11, 92.0, 'Dominio avanzado de SQL', 1, 3);
INSERT INTO calificacion VALUES (12, 88.0, 'Buen manejo de consultas', 2, 5);
INSERT INTO calificacion VALUES (13, 95.0, 'Excelente en todos los temas', 3, 6);
INSERT INTO calificacion VALUES (14, 80.0, 'Aprobado, necesita practicar JOINs', 4, 8);
INSERT INTO calificacion VALUES (15, 85.5, 'Buen desempeño general', 5, 10);
INSERT INTO calificacion VALUES (16, 90.0, 'Muy buenos resultados', 6, 3);
INSERT INTO calificacion VALUES (17, 75.0, 'Debe mejorar en consultas complejas', 7, 5);
INSERT INTO calificacion VALUES (18, 82.0, 'Satisfactorio', 8, 6);
INSERT INTO calificacion VALUES (19, 88.5, 'Buen manejo de SQL', 9, 8);
INSERT INTO calificacion VALUES (20, 91.0, 'Excelente comprensión', 10, 10);

-- HORARIO_GRUPO
-- Horarios para los grupos de estudiantes por asignatura(10 registros)
INSERT INTO horario_grupo VALUES (1, 1, 1);  -- Grupo A (Matemáticas) - Lunes 8:00-10:00
INSERT INTO horario_grupo VALUES (2, 1, 6);  -- Grupo A también tiene Lunes 10:00-12:00
INSERT INTO horario_grupo VALUES (3, 2, 2);  -- Grupo B (Programación) - Martes 10:00-12:00
INSERT INTO horario_grupo VALUES (4, 2, 7);  -- Grupo B también tiene Martes 8:00-10:00
INSERT INTO horario_grupo VALUES (5, 3, 3);  -- Grupo C (Bases de Datos) - Miércoles 14:00-16:00
INSERT INTO horario_grupo VALUES (6, 4, 4);  -- Grupo D (Física) - Jueves 16:00-18:00
INSERT INTO horario_grupo VALUES (7, 4, 9);  -- Grupo D también tiene Jueves 10:00-12:00
INSERT INTO horario_grupo VALUES (8, 5, 5);  -- Grupo E (Estadística) - Viernes 8:00-10:00
INSERT INTO horario_grupo VALUES (9, 6, 8);  -- Grupo F (Estructuras de Datos) - Miércoles 12:00-14:00
INSERT INTO horario_grupo VALUES (10, 7, 10); -- Grupo G (Algoritmos) - Viernes 14:00-16:00
INSERT INTO horario_grupo VALUES (11, 8, 1);  -- Grupo H (IA) - Lunes 8:00-10:00 (mismo bloque que Grupo A)
INSERT INTO horario_grupo VALUES (12, 9, 2);  -- Grupo I (Sistemas Operativos) - Martes 10:00-12:00
INSERT INTO horario_grupo VALUES (13, 10, 3); -- Grupo J (Redes) - Miércoles 14:00-16:00 (mismo bloque que Grupo C)
