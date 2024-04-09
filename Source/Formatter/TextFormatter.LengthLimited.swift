import Foundation

public extension TextFormatter {
    static func lengthLimited(_ count: Int) -> TextFormatter {
        return TextFormatter(MaxCharsFormatter(maxChars: count))
    }
}

private struct MaxCharsFormatter: TextFormatable {
    let maxChars: Int

    init(maxChars: Int) {
        self.maxChars = maxChars
    }

    public func formatText(_ string: String) -> String {
        return string[maxLength: maxChars]
    }

    var uniqueID: String {
        return makeUniqueID() + " \(maxChars)"
    }
}
