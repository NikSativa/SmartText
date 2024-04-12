import Foundation

public extension TextFormatter {
    static var stripLeadingAndTrailingSpaces: TextFormatter {
        return StripLeadingAndTrailingSpaces().toFormatter()
    }
}

private struct StripLeadingAndTrailingSpaces: TextFormatable {
    func formatText(_ string: String) -> String {
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
