package co.catavento.quizzki.controllers;

import co.catavento.quizzki.records.students.GetAvailableEvaluationsDTO;
import co.catavento.quizzki.records.teachers.*;
import co.catavento.quizzki.services.TeacherService;
import co.catavento.quizzki.utils.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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

    @GetMapping("/subjects")
    public ResponseEntity<?> getSubjects(
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            // Call the service to obtain available evaluations
            ApiResponse<List<Map<String, Object>>> response = teacherService.getSubjects(token);

            // Return 200 OK if everything is successful
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            // In case of error, return a message with the error
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al obtener las materias: " + e.getMessage(), null));
        }
    }

    @GetMapping("/topics")
    public ResponseEntity<?> getTopics(
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            // Call the service to obtain available evaluations
            ApiResponse<List<Map<String, Object>>> response = teacherService.getTopics(token);

            // Return 200 OK if everything is successful
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            // In case of error, return a message with the error
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al obtener las temas: " + e.getMessage(), null));
        }
    }

    @GetMapping("/subjects/{idSubject}/groups")
    public ResponseEntity<?> getGroupsBySubject(
            @PathVariable Long idSubject,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            ApiResponse<List<Map<String, Object>>> response = teacherService.getGroupsBySubject(idSubject, token);
            return ResponseEntity.ok(response);  // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al obtener los grupos de la materia: " + e.getMessage(), null));
        }
    }

    @GetMapping("/topics/{idTopic}/questions")
    public ResponseEntity<?> getActiveQuestionsByTopic(
            @PathVariable Long idTopic,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            ApiResponse<List<Map<String, Object>>> response = teacherService.getActiveQuestionsByTopic(idTopic, token);
            return ResponseEntity.ok(response);  // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al obtener las preguntas activas del tema: " + e.getMessage(), null));
        }
    }

    @PostMapping("/evaluation/{idEvaluation}/assign-random-questions")
    public ResponseEntity<?> assignRandomQuestions(
            @PathVariable Long idEvaluation,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            ApiResponse<Void> response = teacherService.assignRandomQuestions(idEvaluation, token);
            return ResponseEntity.ok(response); // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al asignar preguntas aleatorias: " + e.getMessage(), null));
        }
    }

    @PostMapping("/evaluation/assign-question")
    public ResponseEntity<?> assignQuestionToEvaluation(
            @RequestBody AssignQuestionToEvaluationDTO dto,
            @RequestHeader("Authorization") String authorizationHeader) {
        try {
            // Extract the token without the "Bearer" prefix
            String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;

            ApiResponse<Void> response = teacherService.assignQuestionToEvaluation(dto, token);
            return ResponseEntity.ok(response); // Return 200 OK
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("ERROR", "Error al asignar la pregunta a la evaluación: " + e.getMessage(), null));
        }
    }

}
