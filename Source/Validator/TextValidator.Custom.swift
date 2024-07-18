import Foundation
import SwiftUI

public extension TextValidator {
    typealias CustomValidatorClosure = (_ value: String, _ errorText: STString?) -> TextValidationResult

    static func custom(errorText: String? = nil,
                       _ validator: @escaping CustomValidatorClosure) -> TextValidator {
        return CustomValidator(errorText: errorText.map(STString.plain), validator: validator).toValidator()
    }

    static func custom(errorKey: LocalizedStringKey,
                       _ validator: @escaping CustomValidatorClosure) -> TextValidator {
        return CustomValidator(errorText: .localized(errorKey), validator: validator).toValidator()
    }
}

private struct CustomValidator: TextValidatable {
    let errorText: STString?
    let validator: TextValidator.CustomValidatorClosure

    func validate(_ value: String) -> TextValidationResult {
        return validator(value, errorText)
    }
}
