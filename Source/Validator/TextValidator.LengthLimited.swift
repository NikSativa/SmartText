import Foundation

public extension TextValidator {
    static func lengthLimited(_ count: Int, canBeEmpty: Bool, errorText: String? = nil) -> TextValidator {
        return LengthLimitedValidation(limitCharacters: count, canBeEmpty: canBeEmpty, errorText: errorText).toValidator()
    }
}

private struct LengthLimitedValidation: TextValidatable {
    let limitCharacters: Int
    let canBeEmpty: Bool
    let errorText: String?

    func validate(_ value: String) -> TextValidationResult {
        if value.count == limitCharacters || (canBeEmpty && value.isEmpty) {
            return .valid
        }

        let ranges: [Range<String.Index>]
        if limitCharacters < value.count {
            ranges = [value.index(value.startIndex, offsetBy: limitCharacters)..<value.endIndex]
        } else {
            ranges = []
        }
        return .init(invalidRanges: ranges,
                     errorText: errorText,
                     isValid: false)
    }
}
