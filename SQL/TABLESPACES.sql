-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tablespace para estudiantes
CREATE TABLESPACE estudiante_tbs
DATAFILE 'C:\app\quizzki\estudiante.dat'
SIZE 65536K -- 64 MB
AUTOEXTEND ON
NEXT 8192K -- 8 MB
MAXSIZE 262144K; -- 256 MB

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tablespace para profesores y contenidos
CREATE TABLESPACE profesor_tbs
DATAFILE 'C:\app\quizzki\profesor.dat'
SIZE 32768K -- 32 MB
AUTOEXTEND ON
NEXT 4096K -- 4 MB
MAXSIZE 131072K; -- 128 MB

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tablespace para evaluaciones
CREATE TABLESPACE evaluacion_tbs
DATAFILE 'C:\app\quizzki\evaluacion.dat'
SIZE 102400K -- 100 MB
AUTOEXTEND ON
NEXT 8192K -- 8 MB
MAXSIZE 524288K; -- 512 MB

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tablespace para presentaciones y calificaciones
CREATE TABLESPACE presentacion_tbs
DATAFILE 'C:\app\quizzki\presentacion.dat'
SIZE 81920K -- 80 MB
AUTOEXTEND ON
NEXT 8192K -- 8 MB
MAXSIZE 307200K; -- 300 MB

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tablespace para horarios
CREATE TABLESPACE horario_tbs
DATAFILE 'C:\app\quizzki\horario.dat'
SIZE 20480K -- 20 MB
AUTOEXTEND ON
NEXT 2048K -- 2 MB
MAXSIZE 102400K; -- 100 MB

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tablespace para índices de estudiantes
CREATE TABLESPACE estudiante_idx_tbs
DATAFILE 'C:\app\quizzki\estudiante_idx.dat'
SIZE 40960K -- 40 MB
AUTOEXTEND ON
NEXT 4096K -- 4 MB
MAXSIZE 204800K; -- 200 MB

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tablespace para índices de profesores y evaluaciones
CREATE TABLESPACE prof_eval_idx_tbs
DATAFILE 'C:\app\quizzki\prof_eval_idx.dat'
SIZE 51200K -- 50 MB
AUTOEXTEND ON
NEXT 4096K -- 4 MB
MAXSIZE 256000K; -- 250 MB
