import Foundation
import SwiftUI

public extension TextValidator {
    static func includesLowercase(errorText: String? = nil) -> TextValidator {
        return IncludesLowercaseCharactersValidator(errorText: errorText.map(STString.plain)).toValidator()
    }

    static func includesLowercase(errorKey: LocalizedStringKey) -> TextValidator {
        return IncludesLowercaseCharactersValidator(errorText: .localized(errorKey)).toValidator()
    }
}

private struct IncludesLowercaseCharactersValidator: TextValidatable {
    let errorText: STString?

    func validate(_ value: String) -> TextValidationResult {
        let containsALowercase = value.rangeOfCharacter(from: .lowercaseLetters) != nil
        if containsALowercase {
            return .valid
        }
        return .invalid(withError: errorText)
    }
}
