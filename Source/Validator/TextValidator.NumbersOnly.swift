import Foundation

public extension TextValidator {
    static func numbersOnly(errorText: String? = nil) -> TextValidator {
        return TextValidator(NumbersOnlyValidator(errorText: errorText))
    }
}

private struct NumbersOnlyValidator: TextValidatable {
    let errorText: String?

    init(errorText: String?) {
        self.errorText = errorText
    }

    func isValid(string: String) -> Bool {
        let numberCharacters = CharacterSet.decimalDigits.inverted
        return string.rangeOfCharacter(from: numberCharacters) == nil
    }
}
