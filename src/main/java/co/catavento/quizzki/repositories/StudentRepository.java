package co.catavento.quizzki.repositories;

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

}
