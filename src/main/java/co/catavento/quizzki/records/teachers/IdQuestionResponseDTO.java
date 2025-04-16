package co.catavento.quizzki.records.teachers;

import jakarta.validation.constraints.NotBlank;

public record IdQuestionResponseDTO (
        @NotBlank(message = "El id de la pregunta no puede estar vacío")
        String idQuestion
) {}
