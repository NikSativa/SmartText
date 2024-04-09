import Foundation

public extension TextValidator {
    static func includesLowerAndUppercase(errorText: String? = nil) -> TextValidator {
        return TextValidator(IncludesUpperAndLowercaseCharactersValidator(errorText: errorText))
    }
}

private struct IncludesUpperAndLowercaseCharactersValidator: TextValidatable {
    let errorText: String?

    init(errorText: String?) {
        self.errorText = errorText
    }

    func isValid(string: String) -> Bool {
        let containsAnUppercase = string.rangeOfCharacter(from: .uppercaseLetters) != nil
        let containsALowercase = string.rangeOfCharacter(from: .lowercaseLetters) != nil
        return containsAnUppercase && containsALowercase
    }
}
