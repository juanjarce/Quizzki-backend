package co.catavento.quizzki.records.students;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record AnswerQuestionDTO (
        @NotBlank(message = "El id de la presentación de la evaluación no puede estar vacío")
        Long idEvaluationPresentation,

        @NotNull(message = "El id la pregunta no puede estar vacío")
        Long idQuestion,

        @NotNull(message = "El id de la respuesta no puede estar vacío")
        Long idAnswer
) {}
