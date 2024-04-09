import Foundation

infix operator +: AdditionPrecedence
public class TextFormatter: Equatable, ExpressibleByArrayLiteral {
    private let formatters: [TextFormatable]

    public required init(arrayLiteral: TextFormatable...) {
        self.formatters = arrayLiteral
    }

    public required init(_ formatables: [TextFormatable]) {
        self.formatters = formatables
    }

    public convenience init(_ formatter: TextFormatable) {
        self.init([formatter])
    }

    public convenience init(formatters: [TextFormatter]) {
        let formatables = formatters.reduce([]) { $0 + $1.formatters }
        self.init(formatables)
    }

    public func formatText(_ text: String) -> String {
        var formattedText = text
        for formatter in formatters {
            formattedText = formatter.formatText(formattedText)
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

    public static func ==(lhs: TextFormatter, rhs: TextFormatter) -> Bool {
        let lhsIDs = Set(lhs.formatters.map(\.uniqueID))
        let rhsIDs = Set(rhs.formatters.map(\.uniqueID))
        return lhsIDs == rhsIDs
    }
}
