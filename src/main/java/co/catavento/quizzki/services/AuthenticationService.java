package co.catavento.quizzki.services;

import co.catavento.quizzki.records.authentication.LoginResponseDTO;
import co.catavento.quizzki.records.authentication.TeacherLoginDTO;
import co.catavento.quizzki.repositories.AuthenticationRepository;
import co.catavento.quizzki.utils.ApiResponse;
import co.catavento.quizzki.utils.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@Transactional
@RequiredArgsConstructor
public class AuthenticationService {

    private final AuthenticationRepository authRepository;
    private final JwtUtil jwtUtil;

    public ApiResponse<LoginResponseDTO> loginProfessor(TeacherLoginDTO loginDTO) {
        try {
            Map<String, Object> result = authRepository.authenticateProfessor(
                    loginDTO.email(),
                    loginDTO.password()
            );

            String status = (String) result.get("p_resultado");
            String message = (String) result.get("p_mensaje");

            if ("EXITO".equals(status)) {
                Long professorId = ((Number) result.get("p_profesor_id")).longValue();
                String name = (String) result.get("p_nombre");

                String jwt = jwtUtil.generateToken(loginDTO.email());
                // We instantiate the response DTO for the service
                LoginResponseDTO responseDTO = new LoginResponseDTO(jwt, String.valueOf(professorId));

                return new ApiResponse<>("EXITO", "Inicio de sesión exitoso", responseDTO);
            } else {
                return new ApiResponse<>("ERROR", "Error iniciando la sesión: " + message, null);
            }
        } catch (Exception e) {
            return new ApiResponse<>("ERROR", "Error iniciando la sesión: " + e.getMessage(), null);
        }
    }
}
