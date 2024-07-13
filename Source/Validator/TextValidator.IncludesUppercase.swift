import Foundation

public extension TextValidator {
    static func includesUppercase(errorText: String? = nil) -> TextValidator {
        return IncludesUppercaseCharactersValidator(errorText: errorText).toValidator()
    }
}

private struct IncludesUppercaseCharactersValidator: TextValidatable {
    let errorText: String?

    func validate(_ value: String) -> TextValidationResult {
        let containsAnUppercase = value.rangeOfCharacter(from: .uppercaseLetters) != nil
        if containsAnUppercase {
            return .valid
        }
        return .invalid(withErrorText: errorText)
    }
}
