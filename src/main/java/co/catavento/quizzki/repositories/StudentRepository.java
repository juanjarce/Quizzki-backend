package co.catavento.quizzki.repositories;

import oracle.jdbc.internal.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.ColumnMapRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import java.sql.Types;
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

}
