import Foundation

public extension TextValidator {
    typealias CustomValidatorClosure = (_ value: String, _ errorText: String?) -> TextValidationResult

    static func custom(errorText: String? = nil,
                       _ validator: @escaping CustomValidatorClosure) -> TextValidator {
        return CustomValidator(errorText: errorText, validator: validator).toValidator()
    }
}

private struct CustomValidator: TextValidatable {
    let errorText: String?
    let validator: TextValidator.CustomValidatorClosure

    func validate(_ value: String) -> TextValidationResult {
        return validator(value, errorText)
    }
}
