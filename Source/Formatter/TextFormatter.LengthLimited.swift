import Foundation

public extension TextFormatter {
    static func lengthLimited(_ count: Int) -> TextFormatter {
        return MaxCharsFormatter(maxChars: count).toFormatter()
    }
}

private struct MaxCharsFormatter: TextFormatable {
    let maxChars: Int

    init(maxChars: Int) {
        self.maxChars = maxChars
    }

    public func format(_ value: String) -> String {
        return value[maxLength: maxChars]
    }
}
