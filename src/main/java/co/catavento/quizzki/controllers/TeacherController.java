package co.catavento.quizzki.controllers;

import co.catavento.quizzki.records.teachers.CreateEvaluationDTO;
import co.catavento.quizzki.records.teachers.IdEvaluationResponseDTO;
import co.catavento.quizzki.services.TeacherService;
import co.catavento.quizzki.utils.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/teacher")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:5173/")
public class TeacherController {

    @Autowired
    private TeacherService teacherService;

    @PostMapping("/evaluation/create")
    public ResponseEntity<ApiResponse<IdEvaluationResponseDTO>> crearEvaluacion(
            @RequestBody CreateEvaluationDTO evaluationDTO,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            ApiResponse<IdEvaluationResponseDTO> response = teacherService.createEvaluation(evaluationDTO, token);
            return ResponseEntity.ok(response);  // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al crear evaluación: " + e.getMessage(), null));
        }
    }

}
