import Foundation

public final class TextValidator: ExpressibleByArrayLiteral {
    public typealias Eventier = (TextValidator, TextValidationResult) -> Void

    private let validators: [TextValidatable]

    public required init(_ validatables: [TextValidatable]) {
        self.validators = validatables
    }

    public convenience init(_ validator: TextValidatable) {
        self.init([validator])
    }

    public convenience init(validators: [TextValidator]) {
        let validatables = validators.flatMap(\.validators)
        self.init(validatables)
    }

    public convenience init(arrayLiteral validators: TextValidator...) {
        let validatables = validators.flatMap(\.validators)
        self.init(validatables)
    }

    public func validate(_ value: String) -> [TextValidationResult] {
        return validators.compactMap {
            let result = $0.validate(value)
            return result.isValid ? nil : result
        }
    }

    public static func +(lhs: TextValidator, rhs: TextValidatable) -> TextValidator {
        let combinedValidations = lhs.validators + [rhs]
        return .init(combinedValidations)
    }

    public static func +(lhs: TextValidatable, rhs: TextValidator) -> TextValidator {
        let combinedValidations = [lhs] + rhs.validators
        return .init(combinedValidations)
    }

    public static func +(lhs: TextValidator, rhs: TextValidator) -> TextValidator {
        let validators = lhs.validators + rhs.validators
        return .init(validators)
    }
}
