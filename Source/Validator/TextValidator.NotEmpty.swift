import Foundation
import SwiftUI

public extension TextValidator {
    static func notEmpty(errorText: String? = nil) -> TextValidator {
        return NotEmptyValidator(errorText: errorText.map(STString.plain)).toValidator()
    }

    static func notEmpty(errorKey: LocalizedStringKey) -> TextValidator {
        return NotEmptyValidator(errorText: .localized(errorKey)).toValidator()
    }
}

private struct NotEmptyValidator: TextValidatable {
    let errorText: STString?

    func validate(_ value: String) -> TextValidationResult {
        if value.isEmpty == false {
            return .valid
        }

        return .invalid(withErrorText: errorText)
    }
}
