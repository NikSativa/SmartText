import Foundation

public extension TextFormatter {
    #if swift(>=6.0)
    typealias CustomFormatterClosure = @Sendable (String) -> String
    #else
    typealias CustomFormatterClosure = (String) -> String
    #endif

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
