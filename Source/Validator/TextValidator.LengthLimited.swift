import Foundation

public extension TextValidator {
    static func lengthLimited(_ count: Int, canBeEmpty: Bool, errorText: String? = nil) -> TextValidator {
        return TextValidator(LengthLimitedValidation(limitCharacters: count, canBeEmpty: canBeEmpty, errorText: errorText))
    }
}

private struct LengthLimitedValidation: TextValidatable {
    let errorText: String?
    private let limitCharacters: Int
    private let canBeEmpty: Bool

    init(limitCharacters: Int, canBeEmpty: Bool, errorText: String?) {
        self.limitCharacters = limitCharacters
        self.canBeEmpty = canBeEmpty
        self.errorText = errorText
    }

    func isValid(string: String) -> Bool {
        return string.count == limitCharacters || (canBeEmpty && string.isEmpty)
    }

    var uniqueID: String {
        return makeUniqueID() + " \(limitCharacters)"
    }
}
