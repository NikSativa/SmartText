import Foundation

public enum TextValidationResult: Equatable {
    case valid
    case invalid
    case invalidWithErrorText(String)

    public var isValid: Bool {
        switch self {
        case .invalid,
             .invalidWithErrorText:
            return false
        case .valid:
            return true
        }
    }

    public var errorText: String? {
        switch self {
        case .invalidWithErrorText(let text):
            return text
        case .invalid,
             .valid:
            return nil
        }
    }
}
