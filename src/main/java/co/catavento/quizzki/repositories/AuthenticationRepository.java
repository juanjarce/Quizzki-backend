package co.catavento.quizzki.repositories;

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
public class AuthenticationRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Map<String, Object> authenticateProfessor(String email, String password) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("INICIO_SESION_PROFESOR")
                .declareParameters(
                        new SqlParameter("p_correo", Types.VARCHAR),
                        new SqlParameter("p_contrasena", Types.VARCHAR),
                        new SqlOutParameter("p_profesor_id", Types.NUMERIC),
                        new SqlOutParameter("p_nombre", Types.VARCHAR),
                        new SqlOutParameter("p_resultado", Types.VARCHAR),
                        new SqlOutParameter("p_mensaje", Types.VARCHAR)
                );

        Map<String, Object> params = new HashMap<>();
        params.put("p_correo", email);
        params.put("p_contrasena", password);

        return jdbcCall.execute(params);
    }

}
