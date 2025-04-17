package co.catavento.quizzki.services;

import co.catavento.quizzki.records.students.CreateEvaluationPresentationDTO;
import co.catavento.quizzki.records.students.GetAvailableEvaluationsDTO;
import co.catavento.quizzki.repositories.StudentRepository;
import co.catavento.quizzki.utils.ApiResponse;
import co.catavento.quizzki.utils.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
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

    public ApiResponse<List<Map<String, Object>>> getAvailableEvaluations(GetAvailableEvaluationsDTO dto, String token) {
        // Token validation
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        // Call to the repository to execute the procedure
        Map<String, Object> result = studentRepository.getAvailableEvaluations(dto);

        // Retrieve status and error message
        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_error_out");

        // Check if the execution was successful
        if ("EXITO".equalsIgnoreCase(status)) {
            // Retrieve evaluations from the cursor
            List<Map<String, Object>> evaluaciones = (List<Map<String, Object>>) result.get("p_evaluaciones_cursor");
            return new ApiResponse<>("EXITO", "Evaluaciones disponibles obtenidas correctamente", evaluaciones);
        } else {
            // If an error occurred, we return the error message
            return new ApiResponse<>("ERROR", "Error al obtener las evaluaciones: " + message, null);
        }
    }

    public ApiResponse<Map<String, Object>> createEvaluationPresentation(CreateEvaluationPresentationDTO dto, String token) {
        // Token validation
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        // Call to the repository to execute the procedure
        Map<String, Object> result = studentRepository.createEvaluationPresentation(dto);

        // Retrieve status and error message
        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_out");

        // Check if the execution was successful
        if ("EXITO".equalsIgnoreCase(status)) {
            Map<String, Object> data = new HashMap<>();
            data.put("id_presentacion", result.get("p_id_presentacion_out"));
            return new ApiResponse<>("EXITO", message, data);
        } else {
            return new ApiResponse<>("ERROR", "Error al crear la presentación de evaluación: " + message, null);
        }
    }

    public ApiResponse<Map<String, Object>> getEvaluationQuestions(Long evaluationId, String token) {
        // Token validation
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        // Call to the repository to execute the procedure
        Map<String, Object> result = studentRepository.getEvaluationQuestions(evaluationId);

        // Retrieve status and message
        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_out");

        // Check if the execution was successful
        if ("EXITO".equalsIgnoreCase(status)) {
            Map<String, Object> data = new HashMap<>();
            data.put("preguntas", result.get("p_cursor_out"));
            return new ApiResponse<>("EXITO", message, data);
        } else {
            return new ApiResponse<>("ERROR", "Error al obtener las preguntas de la evaluación: " + message, null);
        }
    }

    public ApiResponse<Map<String, Object>> getQuestionOptions(Long questionId, String token) {
        // Token validation
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        // Call to the repository to execute the procedure
        Map<String, Object> result = studentRepository.getQuestionOptions(questionId);

        // Retrieve status and message
        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_out");

        // Check if the execution was successful
        if ("EXITO".equalsIgnoreCase(status)) {
            Map<String, Object> data = new HashMap<>();
            data.put("opciones", result.get("p_cursor_out"));
            return new ApiResponse<>("EXITO", message, data);
        } else {
            return new ApiResponse<>("ERROR", "Error al obtener las opciones de la pregunta: " + message, null);
        }
    }

}
