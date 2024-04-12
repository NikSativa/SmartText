import Foundation

public extension TextValidator {
    static func minLengthLimited(_ count: Int, errorText: String? = nil) -> TextValidator {
        return MinCharacterLimitValidation(minCharacters: count, errorText: errorText).toValidator()
    }
}

private struct MinCharacterLimitValidation: TextValidatable {
    let errorText: String?
    private let minCharacters: Int

    init(minCharacters: Int, errorText: String?) {
        self.minCharacters = minCharacters
        self.errorText = errorText
    }

    func isValid(string: String) -> Bool {
        return string.count >= minCharacters
    }

    var uniqueID: String {
        return makeUniqueID() + " \(minCharacters)"
    }
}
