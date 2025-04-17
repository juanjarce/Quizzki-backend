package co.catavento.quizzki.records.students;

import jakarta.validation.constraints.*;

public record GetAvailableEvaluationsDTO(
        @NotBlank(message = "El id del grupo no puede estar vacío")
        Long idGroup,

        @NotNull(message = "El id del estudiante no puede estar vacío")
        Long idStudent,

        @NotNull(message = "El ID de la pregunta no puede ser nulo")
        String actualDate
) {}
