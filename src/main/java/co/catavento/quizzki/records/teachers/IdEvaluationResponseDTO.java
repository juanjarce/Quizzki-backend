package co.catavento.quizzki.records.teachers;

import jakarta.validation.constraints.NotBlank;

public record IdEvaluationResponseDTO(
        @NotBlank(message = "El id de la evaluación no puede estar vacío")
        String idEvaluation
) {}
