package co.catavento.quizzki.records.students;

import jakarta.validation.constraints.*;

public record CreateEvaluationPresentationDTO (
        @NotBlank(message = "El id de la evaluación no puede estar vacío")
        Long idEvaluation,

        @NotNull(message = "El id del estudiante no puede estar vacío")
        Long idStudent,

        @NotNull(message = "La ip de presentacion del examen no puede estar vacía")
        String ipSource
) {}
