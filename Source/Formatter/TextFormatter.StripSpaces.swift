import Foundation

public extension TextFormatter {
    static var stripLeadingAndTrailingSpaces: TextFormatter {
        return StripLeadingAndTrailingSpaces().toFormatter()
    }
}

private struct StripLeadingAndTrailingSpaces: TextFormatable {
    func format(_ value: String) -> String {
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
