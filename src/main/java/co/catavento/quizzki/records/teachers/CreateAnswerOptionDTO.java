package co.catavento.quizzki.records.teachers;

import jakarta.validation.constraints.*;

public record CreateAnswerOptionDTO(
        @NotBlank(message = "La descripción no puede estar vacía")
        @Size(max = 256, message = "La descripción no puede superar los 256 caracteres")
        String description,

        @NotNull(message = "El campo 'esCorrecta' no puede ser nulo")
        @Pattern(regexp = "S|N", message = "El campo 'esCorrecta' debe ser 'S' o 'N'")
        String isCorrect,

        @NotNull(message = "El ID de la pregunta no puede ser nulo")
        @Positive(message = "El ID de la pregunta debe ser un número positivo")
        Long idQuestion
) {}

