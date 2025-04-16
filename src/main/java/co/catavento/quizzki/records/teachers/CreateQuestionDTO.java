package co.catavento.quizzki.records.teachers;

import jakarta.validation.constraints.*;

public record CreateQuestionDTO(
        @NotBlank(message = "Statement cannot be blank")
        @Size(max = 255, message = "Statement cannot exceed 255 characters")
        String statement,

        @NotNull(message = "Public flag cannot be null")
        @Pattern(regexp = "S|N", message = "Public flag must be 'S' or 'N'")
        String isPublic,

        @NotBlank(message = "Question type cannot be blank")
        @Size(max = 50, message = "Question type cannot exceed 50 characters")
        String questionType,

        @Positive(message = "Composed question ID must be positive")
        Long composedQuestionId,

        @NotNull(message = "Topic ID cannot be null")
        @Positive(message = "Topic ID must be positive")
        Long topicId,

        @NotNull(message = "Professor ID cannot be null")
        @Positive(message = "Professor ID must be positive")
        Long professorId
) {
    // Additional validation for consistent question type and public flag
    public CreateQuestionDTO {
        if (questionType != null && !isValidQuestionType(questionType)) {
            throw new IllegalArgumentException("Invalid question type");
        }
    }

    // Method to validate the question type
    private boolean isValidQuestionType(String type) {
        return type.equals("Selección única") || type.equals("Selección múltiple") ||
                type.equals("Verdadero/Falso") || type.equals("Ordenamiento");
    }
}

