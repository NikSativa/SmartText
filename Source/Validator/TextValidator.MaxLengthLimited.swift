import Foundation

public extension TextValidator {
    static func maxLengthLimited(_ count: Int, errorText: String? = nil) -> TextValidator {
        return MaxCharacterLimitValidation(maxCharacters: count, errorText: errorText).toValidator()
    }
}

private struct MaxCharacterLimitValidation: TextValidatable {
    let maxCharacters: Int
    let errorText: String?

    func validate(_ value: String) -> TextValidationResult {
        if value.count <= maxCharacters {
            return .valid
        }

        return .init(invalidRanges: [value.index(value.startIndex, offsetBy: maxCharacters)..<value.endIndex],
                     errorText: errorText,
                     isValid: false)
    }
}
