import Foundation

public extension TextValidator {
    static func includesLowercase(errorText: String? = nil) -> TextValidator {
        return IncludesLowercaseCharactersValidator(errorText: errorText).toValidator()
    }
}

private struct IncludesLowercaseCharactersValidator: TextValidatable {
    let errorText: String?

    func validate(_ value: String) -> TextValidationResult {
        let containsALowercase = value.rangeOfCharacter(from: .lowercaseLetters) != nil
        if containsALowercase {
            return .valid
        }
        return .invalid(withErrorText: errorText)
    }
}
