package co.catavento.quizzki.records.teachers;

import jakarta.validation.constraints.*;

public record AssignQuestionToEvaluationDTO(

        @NotNull(message = "El ID de la pregunta no puede ser nulo")
        @Positive(message = "El ID de la pregunta debe ser un número positivo")
        Long idQuestion,

        @NotNull(message = "El ID de la evaluación no puede ser nulo")
        @Positive(message = "El ID de la evaluación debe ser un número positivo")
        Long idEvaluation,

        @NotNull(message = "El porcentaje no puede ser nulo")
        @Min(value = 1, message = "Passing percentage must be at least 1")
        @Max(value = 100, message = "Passing percentage must be at most 100")
        Integer percentage,

        @NotNull(message = "Debe especificar si tiene tiempo máximo")
        @Pattern(regexp = "S|N", message = "El campo 'tieneTiempoMaximo' debe ser 'S' o 'N'")
        String hasMaxTime,

        @Positive(message = "El tiempo por pregunta debe ser un número positivo")
        Long questionTime // Este campo puede ser null si tieneTiempoMaximo es 'N'

) {}

