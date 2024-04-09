import Foundation

public extension TextValidator {
    static func maxLengthLimited(_ count: Int, errorText: String? = nil) -> TextValidator {
        return TextValidator(MaxCharacterLimitValidation(maxCharacters: count, errorText: errorText))
    }
}

private struct MaxCharacterLimitValidation: TextValidatable {
    let errorText: String?
    private let maxCharacters: Int

    init(maxCharacters: Int, errorText: String?) {
        self.maxCharacters = maxCharacters
        self.errorText = errorText
    }

    func isValid(string: String) -> Bool {
        return string.count <= maxCharacters
    }

    var uniqueID: String {
        return makeUniqueID() + " \(maxCharacters)"
    }
}
