import Foundation

public protocol TextValidatable {
    func validate(_ value: String) -> TextValidationResult
}

public extension TextValidatable {
    func toValidator() -> TextValidator {
        return .init(self)
    }
}
