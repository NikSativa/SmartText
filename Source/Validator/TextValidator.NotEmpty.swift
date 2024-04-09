import Foundation

public extension TextValidator {
    static func notEmpty(errorText: String? = nil) -> TextValidator {
        return TextValidator(NotEmptyValidator(errorText: errorText))
    }
}

private struct NotEmptyValidator: TextValidatable {
    let errorText: String?

    init(errorText: String?) {
        self.errorText = errorText
    }

    func isValid(string: String) -> Bool {
        return string.isEmpty == false
    }
}
