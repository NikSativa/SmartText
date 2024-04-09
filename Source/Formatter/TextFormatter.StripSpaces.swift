import Foundation

public extension TextFormatter {
    static var stripLeadingAndTrailingSpaces: TextFormatter {
        return TextFormatter(StripLeadingAndTrailingSpaces())
    }
}

private struct StripLeadingAndTrailingSpaces: TextFormatable {
    func formatText(_ string: String) -> String {
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
