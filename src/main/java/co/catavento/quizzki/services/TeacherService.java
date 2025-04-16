package co.catavento.quizzki.services;

import co.catavento.quizzki.records.authentication.LoginResponseDTO;
import co.catavento.quizzki.records.teachers.CreateEvaluationDTO;
import co.catavento.quizzki.records.teachers.IdEvaluationResponseDTO;
import co.catavento.quizzki.repositories.TeacherRepository;
import co.catavento.quizzki.utils.ApiResponse;
import co.catavento.quizzki.utils.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

}
