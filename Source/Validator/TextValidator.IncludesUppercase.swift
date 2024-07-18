import Foundation
import SwiftUI

public extension TextValidator {
    static func includesUppercase(errorText: String? = nil) -> TextValidator {
        return IncludesUppercaseCharactersValidator(errorText: errorText.map(STString.plain)).toValidator()
    }

    static func includesUppercase(errorKey: LocalizedStringKey) -> TextValidator {
        return IncludesUppercaseCharactersValidator(errorText: .localized(errorKey)).toValidator()
    }
}

private struct IncludesUppercaseCharactersValidator: TextValidatable {
    let errorText: STString?

    func validate(_ value: String) -> TextValidationResult {
        let containsAnUppercase = value.rangeOfCharacter(from: .uppercaseLetters) != nil
        if containsAnUppercase {
            return .valid
        }
        return .invalid(withErrorText: errorText)
    }
}
