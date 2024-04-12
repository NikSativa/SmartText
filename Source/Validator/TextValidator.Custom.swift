import Foundation

public extension TextValidator {
    static func custom(errorText: String? = nil,
                       _ validator: @escaping (String) -> Bool) -> TextValidator {
        return CustomValidator(validator: validator, errorText: errorText).toValidator()
    }
}

private struct CustomValidator: TextValidatable {
    let validator: (String) -> Bool
    let errorText: String?

    func isValid(string: String) -> Bool {
        return validator(string)
    }
}
