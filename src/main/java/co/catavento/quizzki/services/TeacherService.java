package co.catavento.quizzki.services;

import co.catavento.quizzki.records.teachers.*;
import co.catavento.quizzki.repositories.TeacherRepository;
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
public class TeacherService {

    @Autowired
    private TeacherRepository teacherRepository;

    private final JwtUtil jwtUtil;

    public ApiResponse<IdEvaluationResponseDTO> createEvaluation(CreateEvaluationDTO evaluationDTO, String token) {
        // Validate the token before proceeding
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        Map<String, Object> result = teacherRepository.createEvaluation(evaluationDTO);

        String resultMesage = (String) result.get("p_resultado_out");
        String errorMesage = (String) result.get("p_mensaje_error_out");

        if ("EXITO".equals(resultMesage)) {
            Long idEvaluacion = ((Number) result.get("p_id_evaluacion_out")).longValue();

            // We instantiate the response DTO for the service
            IdEvaluationResponseDTO responseDTO = new IdEvaluationResponseDTO(String.valueOf(idEvaluacion));

            return new ApiResponse<>("EXITO", "Evaluación creada", responseDTO);
        } else {
            return new ApiResponse<>("ERROR", "Error al crear evaluación: " + errorMesage, null);
        }
    }

    public ApiResponse<IdQuestionResponseDTO> createQuestion(CreateQuestionDTO questionDTO, String token) {
        // Validate the token before proceeding
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        Map<String, Object> result = teacherRepository.createQuestion(questionDTO);

        String resultMessage = (String) result.get("p_resultado_out");
        String errorMessage = (String) result.get("p_mensaje_error_out");

        if ("EXITO".equals(resultMessage)) {
            Long idPregunta = ((Number) result.get("p_id_pregunta_out")).longValue();

            // We instantiate the response DTO for the service
            IdQuestionResponseDTO responseDTO = new IdQuestionResponseDTO(String.valueOf(idPregunta));

            return new ApiResponse<>("EXITO", "Pregunta creada", responseDTO);
        } else {
            return new ApiResponse<>("ERROR", "Error al crear pregunta: " + errorMessage, null);
        }
    }

    public ApiResponse<IdAnswerOptionResponseDTO> createAnswerOption(CreateAnswerOptionDTO optionDTO, String token) {
        // Validate the token before proceeding
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        Map<String, Object> result = teacherRepository.createAnswerOption(optionDTO);

        String resultMessage = (String) result.get("p_resultado_out");
        String errorMessage = (String) result.get("p_mensaje_error_out");

        if ("EXITO".equals(resultMessage)) {
            Long idAnswerOption = ((Number) result.get("p_id_respuesta_out")).longValue();

            // We instantiate the response DTO for the service
            IdAnswerOptionResponseDTO responseDTO = new IdAnswerOptionResponseDTO(String.valueOf(idAnswerOption));

            return new ApiResponse<>("EXITO", "Opción de respuesta creada correctamente", responseDTO);
        } else {
            return new ApiResponse<>("ERROR", "Error al crear opción de respuesta: " + errorMessage, null);
        }
    }

    public ApiResponse<List<Map<String, Object>>> getSubjects(String token) {
        // Token validation
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        // We call the repository
        Map<String, Object> result = teacherRepository.getSubjects();

        // We get the status and message of the result
        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_out");

        if ("EXITO".equalsIgnoreCase(status)) {
            List<Map<String, Object>> materias = (List<Map<String, Object>>) result.get("p_materias_cursor");
            return new ApiResponse<>("EXITO", "Materias obtenidas correctamente", materias);
        } else {
            return new ApiResponse<>("ERROR", "Error al obtener las materias: " + message, null);
        }
    }

    public ApiResponse<List<Map<String, Object>>> getTopics(String token) {
        // Token validation
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        // We call the repository
        Map<String, Object> result = teacherRepository.getTopics();

        // We get the status and message of the result
        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_out");

        if ("EXITO".equalsIgnoreCase(status)) {
            List<Map<String, Object>> temas = (List<Map<String, Object>>) result.get("p_temas_cursor");
            return new ApiResponse<>("EXITO", "Temas obtenidos correctamente", temas);
        } else {
            return new ApiResponse<>("ERROR", "Error al obtener los temas: " + message, null);
        }
    }

    public ApiResponse<List<Map<String, Object>>> getGroupsBySubject(Long idSubject, String token) {
        // Token validation
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        // We call the repository
        Map<String, Object> result = teacherRepository.getGroupsBySubject(idSubject);

        // We get the status and message of the result
        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_out");

        if ("EXITO".equalsIgnoreCase(status)) {
            List<Map<String, Object>> grupos = (List<Map<String, Object>>) result.get("p_grupos_cursor");
            return new ApiResponse<>("EXITO", "Grupos obtenidos correctamente", grupos);
        } else {
            return new ApiResponse<>("ERROR", "Error al obtener los grupos: " + message, null);
        }
    }

    public ApiResponse<List<Map<String, Object>>> getActiveQuestionsByTopic(Long idTopic, String token) {
        // Validar token
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        // We call the repository
        Map<String, Object> result = teacherRepository.getActiveQuestionsByTopic(idTopic);

        // We get the status and message of the result
        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_out");

        if ("EXITO".equalsIgnoreCase(status)) {
            List<Map<String, Object>> questions = (List<Map<String, Object>>) result.get("p_preguntas_cursor");
            return new ApiResponse<>("EXITO", "Preguntas activas del tema obtenidas correctamente", questions);
        } else {
            return new ApiResponse<>("ERROR", "Error al obtener preguntas del tema: " + message, null);
        }
    }

    public ApiResponse<Void> assignRandomQuestions(Long idEvaluation, String token) {
        // Validar token
        if (!jwtUtil.validateToken(token)) {
            throw new RuntimeException("Token inválido");
        }

        // We call the repository
        Map<String, Object> result = teacherRepository.assignRandomQuestions(idEvaluation);

        // We get the status and message of the result
        String status = (String) result.get("p_estado_out");
        String message = (String) result.get("p_mensaje_out");

        if ("EXITO".equalsIgnoreCase(status)) {
            return new ApiResponse<>("EXITO", "Preguntas asignadas aleatoriamente correctamente", null);
        } else {
            return new ApiResponse<>("ERROR", "Error al asignar preguntas: " + message, null);
        }
    }

}
