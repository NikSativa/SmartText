import Foundation

public extension TextFormatter {
    static var stripLeadingSpaces: TextFormatter {
        return StripLeadingSpaces().toFormatter()
    }
}

private struct StripLeadingSpaces: TextFormatable {
    public func format(_ value: String) -> String {
        let formattedString = value.reduce("") { result, nextCharacter -> String in
            if nextCharacter == " ", result.isEmpty {
                return result
            }
            return result + String(nextCharacter)
        }

        return formattedString
    }
}
