import Foundation

public extension TextFormatter {
    static func custom(_ formatter: @escaping (String) -> String) -> TextFormatter {
        return [CustomFormatter(formatter: formatter)]
    }
}

private struct CustomFormatter: TextFormatable {
    private let formatter: (String) -> String

    init(formatter: @escaping (String) -> String) {
        self.formatter = formatter
    }

    func formatText(_ string: String) -> String {
        return formatter(string)
    }
}
