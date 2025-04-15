package co.catavento.quizzki.repositories;

import co.catavento.quizzki.records.teachers.CreateEvaluationDTO;
import org.springframework.beans.factory.annotation.Autowired;
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

}
