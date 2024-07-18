import Foundation
import SwiftUI

public extension TextValidator {
    static func numbersOnly(errorText: String? = nil) -> TextValidator {
        return NumbersOnlyValidator(errorText: errorText.map(STString.plain)).toValidator()
    }

    static func numbersOnly(errorKey: LocalizedStringKey) -> TextValidator {
        return NumbersOnlyValidator(errorText: .localized(errorKey)).toValidator()
    }
}

private struct NumbersOnlyValidator: TextValidatable {
    let errorText: STString?

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
