import Foundation
import SwiftUI

public extension TextValidator {
    static func lengthLimited(_ count: Int, canBeEmpty: Bool, errorText: String? = nil) -> TextValidator {
        return LengthLimitedValidation(limitCharacters: count, canBeEmpty: canBeEmpty, errorText: errorText.map(STString.plain)).toValidator()
    }

    static func lengthLimited(_ count: Int, canBeEmpty: Bool, errorKey: LocalizedStringKey) -> TextValidator {
        return LengthLimitedValidation(limitCharacters: count, canBeEmpty: canBeEmpty, errorText: .localized(errorKey)).toValidator()
    }
}

private struct LengthLimitedValidation: TextValidatable {
    let limitCharacters: Int
    let canBeEmpty: Bool
    let errorText: STString?

    func validate(_ value: String) -> TextValidationResult {
        if value.count == limitCharacters || (canBeEmpty && value.isEmpty) {
            return .valid
        }

        let ranges: [Range<String.Index>] =
            if limitCharacters < value.count {
                [value.index(value.startIndex, offsetBy: limitCharacters)..<value.endIndex]
            } else {
                []
            }
        return .init(invalidRanges: ranges,
                     errorText: errorText,
                     isValid: false)
    }
}
