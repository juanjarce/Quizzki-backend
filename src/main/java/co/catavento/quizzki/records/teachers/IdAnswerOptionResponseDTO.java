package co.catavento.quizzki.records.teachers;

import jakarta.validation.constraints.NotBlank;

public record IdAnswerOptionResponseDTO (
        @NotBlank(message = "El id de la opcion de respuesta no puede estar vacío")
        String idAnswerOption
) {}
