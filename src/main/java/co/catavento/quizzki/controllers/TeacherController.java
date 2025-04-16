package co.catavento.quizzki.controllers;

import co.catavento.quizzki.records.teachers.*;
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
    public ResponseEntity<ApiResponse<IdEvaluationResponseDTO>> createEvaluation(
            @RequestBody CreateEvaluationDTO evaluationDTO,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            ApiResponse<IdEvaluationResponseDTO> response = teacherService.createEvaluation(evaluationDTO, token);
            return ResponseEntity.ok(response);  // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al crear la evaluación: " + e.getMessage(), null));
        }
    }

    @PostMapping("/question/create")
    public ResponseEntity<ApiResponse<IdQuestionResponseDTO>> createQuestion(
            @RequestBody CreateQuestionDTO questionDTO,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            ApiResponse<IdQuestionResponseDTO> response = teacherService.createQuestion(questionDTO, token);
            return ResponseEntity.ok(response);  // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al crear la pregunta: " + e.getMessage(), null));
        }
    }

    @PostMapping("/answerOption/create")
    public ResponseEntity<ApiResponse<IdAnswerOptionResponseDTO>> createAnswerOption(
            @RequestBody CreateAnswerOptionDTO answerOptionDTO,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            ApiResponse<IdAnswerOptionResponseDTO> response = teacherService.createAnswerOption(answerOptionDTO, token);
            return ResponseEntity.ok(response);  // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al crear la opción de respuesta: " + e.getMessage(), null));
        }
    }

}
