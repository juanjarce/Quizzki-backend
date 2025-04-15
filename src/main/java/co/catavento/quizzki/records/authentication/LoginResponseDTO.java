package co.catavento.quizzki.records.authentication;

import jakarta.validation.constraints.NotBlank;

public record LoginResponseDTO(
        @NotBlank(message = "El token no puede estar vacío")
        String token,

        @NotBlank(message = "La id no puede estar vacía")
        String id
) {}
