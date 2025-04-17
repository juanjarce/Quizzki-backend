package co.catavento.quizzki.controllers;

import co.catavento.quizzki.records.students.GetAvailableEvaluationsDTO;
import co.catavento.quizzki.services.StudentService;
import co.catavento.quizzki.utils.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/student")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:5173/")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @GetMapping("/{idStudent}/groups")
    public ResponseEntity<?> getStudentGroups(
            @PathVariable Long idStudent,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            ApiResponse<List<Map<String, Object>>> response = studentService.getStudentGroups(idStudent, token);
            return ResponseEntity.ok(response);  // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al obtener los grupos del estudiante: " + e.getMessage(), null));
        }
    }

    @GetMapping("/{idStudent}/evaluations")
    public ResponseEntity<?> getAvailableEvaluations(
            @RequestBody GetAvailableEvaluationsDTO dto,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            // Call the service to obtain available evaluations
            ApiResponse<List<Map<String, Object>>> response = studentService.getAvailableEvaluations(dto, token);

            // Return 200 OK if everything is successful
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            // In case of error, return a message with the error
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al obtener las evaluaciones del estudiante: " + e.getMessage(), null));
        }
    }

}
