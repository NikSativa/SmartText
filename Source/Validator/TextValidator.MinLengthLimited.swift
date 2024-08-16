import Foundation
import SwiftUI

public extension TextValidator {
    static func minLengthLimited(_ count: Int, errorText: String? = nil) -> TextValidator {
        return MinCharacterLimitValidation(minCharacters: count, errorText: errorText.map(STString.plain)).toValidator()
    }

    static func minLengthLimited(_ count: Int, errorKey: LocalizedStringKey) -> TextValidator {
        return MinCharacterLimitValidation(minCharacters: count, errorText: .localized(errorKey)).toValidator()
    }
}

private struct MinCharacterLimitValidation: TextValidatable {
    let minCharacters: Int
    let errorText: STString?

    func validate(_ value: String) -> TextValidationResult {
        if value.count >= minCharacters {
            return .valid
        }
        return .invalid(withError: errorText)
    }
}
