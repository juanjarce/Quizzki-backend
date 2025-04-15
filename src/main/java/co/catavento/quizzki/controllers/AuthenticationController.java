package co.catavento.quizzki.controllers;

import co.catavento.quizzki.records.authentication.LoginResponseDTO;
import co.catavento.quizzki.records.authentication.StudentLoginDTO;
import co.catavento.quizzki.records.authentication.TeacherLoginDTO;
import co.catavento.quizzki.services.AuthenticationService;
import co.catavento.quizzki.utils.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:5173/")
public class AuthenticationController {

    @Autowired
    private AuthenticationService authService;

    @PostMapping("/login/teacher")
    public ResponseEntity<ApiResponse<LoginResponseDTO>> teacherLogin(
            @RequestBody TeacherLoginDTO loginDTO) {
        try {
            ApiResponse<LoginResponseDTO> response = authService.loginProfessor(loginDTO);
            return ResponseEntity.ok(response);  // Retorna 200 OK en caso de éxito, con el token
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error iniciando la sesión: " + e.getMessage(), null));
        }
    }

    @PostMapping("/login/student")
    public ResponseEntity<ApiResponse<LoginResponseDTO>> login(
            @RequestBody StudentLoginDTO loginDTO) {
        try {
            ApiResponse<LoginResponseDTO> response = authService.loginStudent(loginDTO);
            return ResponseEntity.ok(response);  // Retorna 200 OK en caso de éxito, con el token
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error iniciando la sesión: " + e.getMessage(), null));
        }
    }

}
