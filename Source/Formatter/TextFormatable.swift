import Foundation

public protocol TextFormatable {
    func format(_ value: String) -> String
}

public extension TextFormatable {
    func toFormatter() -> TextFormatter {
        return .init(self)
    }
}
