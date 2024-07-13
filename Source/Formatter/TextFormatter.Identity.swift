import Foundation

public extension TextFormatter {
    static var identity: TextFormatter {
        return IdentityTextFormatter().toFormatter()
    }
}

private struct IdentityTextFormatter: TextFormatable {
    public func format(_ value: String) -> String {
        return value
    }
}
