package co.catavento.quizzki.services;

import co.catavento.quizzki.repositories.StudentRepository;
import co.catavento.quizzki.utils.ApiResponse;
import co.catavento.quizzki.utils.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
@RequiredArgsConstructor
public class StudentService {

    private final JwtUtil jwtUtil;

    @Autowired
    private StudentRepository studentRepository;

    public ApiResponse<List<Map<String, Object>>> getStudentGroups(Long idStudent, String token) {
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        Map<String, Object> result = studentRepository.getStudentGroups(idStudent);

        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_error_out");

        if ("EXITO".equalsIgnoreCase(status)) {
            List<Map<String, Object>> grupos = (List<Map<String, Object>>) result.get("p_resultado_cursor");
            return new ApiResponse<>("EXITO", "Grupos del estudiante obtenidos correctamente", grupos);
        } else {
            return new ApiResponse<>("ERROR", "Error al obtener los grupos: " + message, null);
        }
    }

}
