import Foundation

public final class TextFormatter: ExpressibleByArrayLiteral, TextFormatable {
    private let formatters: [TextFormatable]

    public required init(_ formatables: [TextFormatable]) {
        self.formatters = formatables
    }

    public convenience init(_ formatter: TextFormatable) {
        self.init([formatter])
    }

    public convenience init(formatters: [TextFormatter]) {
        let formatables = formatters.flatMap(\.formatters)
        self.init(formatables)
    }

    public convenience init(arrayLiteral formatters: TextFormatter...) {
        let formatables = formatters.flatMap(\.formatters)
        self.init(formatables)
    }

    public func format(_ value: String) -> String {
        var formattedText = value
        for formatter in formatters {
            formattedText = formatter.format(formattedText)
        }
        return formattedText
    }

    public static func +(lhs: TextFormatter, rhs: TextFormatable) -> TextFormatter {
        let combinedValidations = lhs.formatters + [rhs]
        return .init(combinedValidations)
    }

    public static func +(lhs: TextFormatable, rhs: TextFormatter) -> TextFormatter {
        let combinedValidations = [lhs] + rhs.formatters
        return .init(combinedValidations)
    }

    public static func +(lhs: TextFormatter, rhs: TextFormatter) -> TextFormatter {
        let combinedValidations = lhs.formatters + rhs.formatters
        return .init(combinedValidations)
    }
}

#if swift(>=6.0)
extension TextFormatter: Sendable {}
#endif
