import Foundation

public extension TextFormatter {
    static var identity: TextFormatter {
        return [IdentityTextFormatter()]
    }
}

private struct IdentityTextFormatter: TextFormatable {
    public func formatText(_ string: String) -> String {
        return string
    }
}
