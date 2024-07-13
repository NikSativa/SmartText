import Foundation

public extension TextValidator {
    static func minLengthLimited(_ count: Int, errorText: String? = nil) -> TextValidator {
        return MinCharacterLimitValidation(minCharacters: count, errorText: errorText).toValidator()
    }
}

private struct MinCharacterLimitValidation: TextValidatable {
    let minCharacters: Int
    let errorText: String?

    func validate(_ value: String) -> TextValidationResult {
        if value.count >= minCharacters {
            return .valid
        }
        return .invalid(withErrorText: errorText)
    }
}
