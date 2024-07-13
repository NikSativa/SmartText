import Foundation

public extension TextFormatter {
    static var numbersOnly: TextFormatter {
        return NumbersOnlyFormatter().toFormatter()
    }
}

private struct NumbersOnlyFormatter: TextFormatable {
    public func format(_ value: String) -> String {
        let kAllowedCharacters = "0123456789"
        let formattedText = value.filter { character in
            return kAllowedCharacters.contains(character)
        }
        return formattedText
    }
}
