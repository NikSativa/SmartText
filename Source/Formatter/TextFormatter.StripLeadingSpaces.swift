import Foundation

public extension TextFormatter {
    static var stripLeadingSpaces: TextFormatter {
        return [StripLeadingSpaces()]
    }
}

private struct StripLeadingSpaces: TextFormatable {
    public func formatText(_ string: String) -> String {
        let formattedString = string.reduce("") { result, nextCharacter -> String in
            if nextCharacter == " ", result.isEmpty {
                return result
            }
            return result + String(nextCharacter)
        }

        return formattedString
    }
}
