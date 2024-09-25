import Foundation

#if swift(>=6.0)
public protocol TextValidatable: Sendable {
    func validate(_ value: String) -> TextValidationResult
}
#else
public protocol TextValidatable {
    func validate(_ value: String) -> TextValidationResult
}
#endif

public extension TextValidatable {
    func toValidator() -> TextValidator {
        return .init(self)
    }
}
