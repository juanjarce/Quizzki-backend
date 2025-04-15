package co.catavento.quizzki.controllers;

import co.catavento.quizzki.records.teachers.CreateEvaluationDTO;
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

    @PostMapping
    public ResponseEntity<ApiResponse<Long>> crearEvaluacion(@RequestBody CreateEvaluationDTO evaluationDTO) {
        try {
            ApiResponse<Long> response = teacherService.createEvaluation(evaluationDTO);
            return ResponseEntity.ok(response);  // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al crear evaluación: " + e.getMessage(), null));
        }
    }

}
