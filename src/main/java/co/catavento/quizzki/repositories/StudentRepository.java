package co.catavento.quizzki.repositories;

import co.catavento.quizzki.records.students.AnswerQuestionDTO;
import co.catavento.quizzki.records.students.CreateEvaluationPresentationDTO;
import co.catavento.quizzki.records.students.GetAvailableEvaluationsDTO;
import oracle.jdbc.internal.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.ColumnMapRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.*;

@Repository
public class StudentRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Map<String, Object> getStudentGroups(Long idStudent) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("OBTENER_GRUPOS_ESTUDIANTE")
                .declareParameters(
                        new SqlParameter("p_id_estudiante", Types.NUMERIC),
                        new SqlOutParameter("p_resultado_cursor", OracleTypes.CURSOR, new ColumnMapRowMapper()),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_error_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_id_estudiante", idStudent);

        return jdbcCall.execute(params);
    }

    public Map<String, Object> getAvailableEvaluations(GetAvailableEvaluationsDTO dto) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("OBTENER_EVALUACIONES_DISP")
                .declareParameters(
                        new SqlParameter("p_id_estudiante", Types.NUMERIC),
                        new SqlParameter("p_id_grupo", Types.NUMERIC),
                        new SqlParameter("p_fecha_actual", Types.VARCHAR),  // Cambiar a VARCHAR
                        new SqlOutParameter("p_evaluaciones_cursor", OracleTypes.CURSOR, new ColumnMapRowMapper()),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_error_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_id_estudiante", dto.idStudent());
        params.put("p_id_grupo", dto.idGroup());
        params.put("p_fecha_actual", dto.actualDate());

        System.out.println("id_estudiante: " + dto.idStudent());
        System.out.println("id_grupo: " + dto.idGroup());
        System.out.println("Fecha actual enviada: " + dto.actualDate());

        return jdbcCall.execute(params);
    }

    public Map<String, Object> createEvaluationPresentation(CreateEvaluationPresentationDTO dto) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("CREAR_PRESENTACION_EVALUACION")
                .declareParameters(
                        new SqlParameter("p_id_evaluacion", Types.NUMERIC),
                        new SqlParameter("p_id_estudiante", Types.NUMERIC),
                        new SqlParameter("p_ip_source", Types.VARCHAR),
                        new SqlOutParameter("p_id_presentacion_out", Types.NUMERIC),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_id_evaluacion", dto.idEvaluation());
        params.put("p_id_estudiante", dto.idStudent());
        params.put("p_ip_source", dto.ipSource());

        System.out.println("ID Evaluación: " + dto.idEvaluation());
        System.out.println("ID Estudiante: " + dto.idStudent());
        System.out.println("IP del estudiante: " + dto.ipSource());

        return jdbcCall.execute(params);
    }

    public Map<String, Object> getEvaluationQuestions(Long evaluationId) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("OBTENER_PREGUNTAS_EVALUACION")
                .declareParameters(
                        new SqlParameter("p_id_evaluacion", Types.NUMERIC),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_out", Types.VARCHAR),
                        new SqlOutParameter("p_cursor_out", OracleTypes.CURSOR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_id_evaluacion", evaluationId);

        return jdbcCall.execute(params);
    }

    public Map<String, Object> getQuestionOptions(Long questionId) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("OBTENER_OPCIONES_PREGUNTA")
                .declareParameters(
                        new SqlParameter("p_id_pregunta", Types.NUMERIC),
                        new SqlOutParameter("p_cursor_out", OracleTypes.CURSOR),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_id_pregunta", questionId);

        return jdbcCall.execute(params);
    }

    public Map<String, Object> registerStudentAnswer(AnswerQuestionDTO dto) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("REGISTRAR_RESPUESTA_ESTUDIANTE")
                .declareParameters(
                        new SqlParameter("p_id_presentacion_eval", Types.NUMERIC),
                        new SqlParameter("p_id_pregunta", Types.NUMERIC),
                        new SqlParameter("p_id_respuesta", Types.NUMERIC),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_out", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_id_presentacion_eval", dto.idEvaluationPresentation()); // <- este era el error
        params.put("p_id_pregunta", dto.idQuestion());
        params.put("p_id_respuesta", dto.idAnswer());

        System.out.println("ID Presentación: " + dto.idEvaluationPresentation());
        System.out.println("ID Pregunta: " + dto.idQuestion());
        System.out.println("ID Respuesta: " + dto.idAnswer());

        return jdbcCall.execute(params);
    }

    public Map<String, Object> finishEvaluation(Long idPresentationEval) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("FINALIZAR_PRESENTACION_EXAMEN")
                .declareParameters(
                        new SqlParameter("p_id_presentacion_eval", Types.NUMERIC),
                        new SqlOutParameter("p_estado_out", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje_out", Types.VARCHAR),
                        new SqlOutParameter("p_calificacion_out", Types.FLOAT)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_id_presentacion_eval", idPresentationEval);

        System.out.println("Finalizando presentación con ID: " + idPresentationEval);

        return jdbcCall.execute(params);
    }

}
