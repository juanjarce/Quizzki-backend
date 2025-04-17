package co.catavento.quizzki.repositories;

import co.catavento.quizzki.records.teachers.CreateAnswerOptionDTO;
import co.catavento.quizzki.records.teachers.CreateEvaluationDTO;
import co.catavento.quizzki.records.teachers.CreateQuestionDTO;
import oracle.jdbc.internal.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.ColumnMapRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

@Repository
public class TeacherRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Map<String, Object> createEvaluation(CreateEvaluationDTO evaluationDTO) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("CREAR_EVALUACION")
                .declareParameters(
                        new SqlParameter("p_tiempo_max", Types.NUMERIC),
                        new SqlParameter("p_numero_preguntas", Types.NUMERIC),
                        new SqlParameter("p_porcentaje_curso", Types.NUMERIC),
                        new SqlParameter("p_nombre", Types.VARCHAR),
                        new SqlParameter("p_porcentaje_aprobatorio", Types.NUMERIC),
                        new SqlParameter("p_fecha_hora_inicio", Types.TIMESTAMP),
                        new SqlParameter("p_fecha_hora_fin", Types.TIMESTAMP),
                        new SqlParameter("p_num_preguntas_aleatorias", Types.NUMERIC),
                        new SqlParameter("p_id_tema", Types.NUMERIC),
                        new SqlParameter("p_id_profesor", Types.NUMERIC),
                        new SqlParameter("p_id_grupo", Types.NUMERIC),
                        new SqlOutParameter("p_id_evaluacion_out", Types.NUMERIC),
                        new SqlOutParameter("p_resultado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_error_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_tiempo_max", evaluationDTO.maxTime());
        params.put("p_numero_preguntas", evaluationDTO.questionCount());
        params.put("p_porcentaje_curso", evaluationDTO.coursePercentage());
        params.put("p_nombre", evaluationDTO.name());
        params.put("p_porcentaje_aprobatorio", evaluationDTO.passingPercentage());
        params.put("p_fecha_hora_inicio", evaluationDTO.startDateTime());
        params.put("p_fecha_hora_fin", evaluationDTO.endDateTime());
        params.put("p_num_preguntas_aleatorias", evaluationDTO.randomQuestionsCount());
        params.put("p_id_tema", evaluationDTO.topicId());
        params.put("p_id_profesor", evaluationDTO.professorId());
        params.put("p_id_grupo", evaluationDTO.groupId());

        return jdbcCall.execute(params);
    }

    public Map<String, Object> createQuestion(CreateQuestionDTO questionDTO) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("CREAR_PREGUNTA")
                .declareParameters(
                        new SqlParameter("p_enunciado", Types.VARCHAR),
                        new SqlParameter("p_es_publica", Types.CHAR),
                        new SqlParameter("p_tipo_pregunta", Types.VARCHAR),
                        new SqlParameter("p_id_pregunta_compuesta", Types.NUMERIC),
                        new SqlParameter("p_id_tema", Types.NUMERIC),
                        new SqlParameter("p_id_profesor", Types.NUMERIC),
                        new SqlOutParameter("p_id_pregunta_out", Types.NUMERIC),
                        new SqlOutParameter("p_resultado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_error_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_enunciado", questionDTO.statement());
        params.put("p_es_publica", questionDTO.isPublic());
        params.put("p_tipo_pregunta", questionDTO.questionType());
        params.put("p_id_pregunta_compuesta", questionDTO.composedQuestionId());
        params.put("p_id_tema", questionDTO.topicId());
        params.put("p_id_profesor", questionDTO.professorId());

        // Ejecutar el procedimiento almacenado y recuperar los valores de salida
        return jdbcCall.execute(params);
    }

    public Map<String, Object> createAnswerOption(CreateAnswerOptionDTO optionDTO) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("CREAR_OPCION_RESPUESTA")
                .declareParameters(
                        new SqlParameter("p_descripcion", Types.VARCHAR),
                        new SqlParameter("p_es_correcta", Types.CHAR),
                        new SqlParameter("p_id_pregunta", Types.NUMERIC),
                        new SqlOutParameter("p_id_respuesta_out", Types.NUMERIC),
                        new SqlOutParameter("p_resultado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_error_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_descripcion", optionDTO.description());
        params.put("p_es_correcta", optionDTO.isCorrect());
        params.put("p_id_pregunta", optionDTO.idQuestion());

        return jdbcCall.execute(params);
    }

    public Map<String, Object> getSubjects() {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("OBTENER_MATERIAS")
                .declareParameters(
                        new SqlOutParameter("p_materias_cursor", OracleTypes.CURSOR, new ColumnMapRowMapper()),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_out", Types.VARCHAR)
                );

        return jdbcCall.execute();
    }

    public Map<String, Object> getTopics() {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("OBTENER_TEMAS")
                .declareParameters(
                        new SqlOutParameter("p_temas_cursor", OracleTypes.CURSOR, new ColumnMapRowMapper()),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_out", Types.VARCHAR)
                );

        return jdbcCall.execute(new HashMap<>());
    }

    public Map<String, Object> getGroupsBySubject(Long idSubject) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("OBTENER_GRUPOS_POR_MATERIA")
                .declareParameters(
                        new SqlParameter("p_id_materia", Types.NUMERIC),
                        new SqlOutParameter("p_grupos_cursor", OracleTypes.CURSOR, new ColumnMapRowMapper()),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_id_materia", idSubject);

        return jdbcCall.execute(params);
    }

    public Map<String, Object> getActiveQuestionsByTopic(Long idTopic) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("OBTENER_PREGUNTAS_TEMA")
                .declareParameters(
                        new SqlParameter("p_id_tema", Types.NUMERIC),
                        new SqlOutParameter("p_preguntas_cursor", OracleTypes.CURSOR, new ColumnMapRowMapper()),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_id_tema", idTopic);

        return jdbcCall.execute(params);
    }

}
