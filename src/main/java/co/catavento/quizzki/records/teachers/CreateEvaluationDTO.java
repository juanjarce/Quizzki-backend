package co.catavento.quizzki.records.teachers;

import jakarta.validation.constraints.*;
import java.time.LocalDateTime;

public record CreateEvaluationDTO(
        @NotNull(message = "Maximum time cannot be null")
        @Positive(message = "Maximum time must be positive")
        Integer maxTime,

        @NotNull(message = "Number of questions cannot be null")
        @Positive(message = "Number of questions must be positive")
        Integer questionCount,

        @NotNull(message = "Course percentage cannot be null")
        @Min(value = 1, message = "Course percentage must be at least 1")
        @Max(value = 100, message = "Course percentage must be at most 100")
        Integer coursePercentage,

        @NotBlank(message = "Name cannot be blank")
        @Size(max = 63, message = "Name cannot exceed 63 characters")
        String name,

        @NotNull(message = "Passing percentage cannot be null")
        @Min(value = 1, message = "Passing percentage must be at least 1")
        @Max(value = 100, message = "Passing percentage must be at most 100")
        Integer passingPercentage,

        @NotNull(message = "Start date/time cannot be null")
        LocalDateTime startDateTime,

        @NotNull(message = "End date/time cannot be null")
        LocalDateTime endDateTime,

        @PositiveOrZero(message = "Random questions count must be positive or zero")
        Integer randomQuestionsCount,

        @NotNull(message = "Topic ID cannot be null")
        @Positive(message = "Topic ID must be positive")
        Long topicId,

        @NotNull(message = "Professor ID cannot be null")
        @Positive(message = "Professor ID must be positive")
        Long professorId,

        @NotNull(message = "Group ID cannot be null")
        @Positive(message = "Group ID must be positive")
        Long groupId
) {
    // Additional validation for consistent dates
    public CreateEvaluationDTO {
        if (startDateTime != null && endDateTime != null && startDateTime.isAfter(endDateTime)) {
            throw new IllegalArgumentException("Start date must be before end date");
        }

        if (randomQuestionsCount != null && questionCount != null &&
                randomQuestionsCount > questionCount) {
            throw new IllegalArgumentException(
                    "Random questions count cannot be greater than total questions");
        }
    }
}