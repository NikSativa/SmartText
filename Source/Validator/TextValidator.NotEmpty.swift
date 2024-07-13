import Foundation

public extension TextValidator {
    static func notEmpty(errorText: String? = nil) -> TextValidator {
        return NotEmptyValidator(errorText: errorText).toValidator()
    }
}

private struct NotEmptyValidator: TextValidatable {
    let errorText: String?

    func validate(_ value: String) -> TextValidationResult {
        if value.isEmpty == false {
            return .valid
        }

        return .invalid(withErrorText: errorText)
    }
}
