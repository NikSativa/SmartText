import Foundation

public final class TextValidator: Equatable, ExpressibleByArrayLiteral {
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

    public func isTextValid(_ text: String) -> TextValidationResult {
        let result: TextValidationResult = validators
            .first(where: {
                !$0.isValid(string: text)
            })
            .map {
                $0.errorText.map { .invalidWithErrorText($0) } ?? .invalid
            } ?? .valid

        return result
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

    public static func ==(lhs: TextValidator, rhs: TextValidator) -> Bool {
        let lhsIDs = Set(lhs.validators.map(\.uniqueID))
        let rhsIDs = Set(rhs.validators.map(\.uniqueID))
        return lhsIDs == rhsIDs
    }
}
