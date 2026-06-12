import Foundation

public extension TextFormatter {
    typealias CustomFormatterClosure = @Sendable (String) -> String

    static func custom(_ formatter: @escaping CustomFormatterClosure) -> TextFormatter {
        return CustomFormatter(formatter: formatter).toFormatter()
    }
}

private struct CustomFormatter: TextFormatable {
    private let formatter: TextFormatter.CustomFormatterClosure

    init(formatter: @escaping TextFormatter.CustomFormatterClosure) {
        self.formatter = formatter
    }

    func format(_ value: String) -> String {
        return formatter(value)
    }
}
