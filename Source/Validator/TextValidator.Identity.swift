import Foundation

public extension TextValidator {
    static var identity: TextValidator {
        return IdentityTextValidator().toValidator()
    }
}

private struct IdentityTextValidator: TextValidatable {
    func validate(_: String) -> TextValidationResult {
        return .valid
    }
}
