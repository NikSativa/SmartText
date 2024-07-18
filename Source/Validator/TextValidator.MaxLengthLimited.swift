import Foundation
import SwiftUI

public extension TextValidator {
    static func maxLengthLimited(_ count: Int, errorText: String? = nil) -> TextValidator {
        return MaxCharacterLimitValidation(maxCharacters: count, errorText: errorText.map(STString.plain)).toValidator()
    }

    static func maxLengthLimited(_ count: Int, errorKey: LocalizedStringKey) -> TextValidator {
        return MaxCharacterLimitValidation(maxCharacters: count, errorText: .localized(errorKey)).toValidator()
    }
}

private struct MaxCharacterLimitValidation: TextValidatable {
    let maxCharacters: Int
    let errorText: STString?

    func validate(_ value: String) -> TextValidationResult {
        if value.count <= maxCharacters {
            return .valid
        }

        return .init(invalidRanges: [value.index(value.startIndex, offsetBy: maxCharacters)..<value.endIndex],
                     errorText: errorText,
                     isValid: false)
    }
}
