import Foundation

public extension TextValidator {
    static func numbersOnly(errorText: String? = nil) -> TextValidator {
        return NumbersOnlyValidator(errorText: errorText).toValidator()
    }
}

private struct NumbersOnlyValidator: TextValidatable {
    let errorText: String?

    func validate(_ value: String) -> TextValidationResult {
        let numberCharacters = CharacterSet.decimalDigits.inverted
        let ranges = value.ranges(of: numberCharacters)
        if ranges.isEmpty {
            return .valid
        }
        return .init(invalidRanges: ranges,
                     errorText: errorText,
                     isValid: false)
    }
}
