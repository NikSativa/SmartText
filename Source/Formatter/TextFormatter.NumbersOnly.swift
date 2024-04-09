import Foundation

public extension TextFormatter {
    static var numbersOnly: TextFormatter {
        return [NumbersOnlyFormatter()]
    }
}

private struct NumbersOnlyFormatter: TextFormatable {
    public func formatText(_ string: String) -> String {
        let kAllowedCharacters = "0123456789"
        let formattedText = string.filter { character in
            return kAllowedCharacters.contains(character)
        }
        return formattedText
    }
}
