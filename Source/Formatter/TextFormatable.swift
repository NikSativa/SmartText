import Foundation

#if swift(>=6.0)
public protocol TextFormatable: Sendable {
    func format(_ value: String) -> String
}
#else
public protocol TextFormatable {
    func format(_ value: String) -> String
}
#endif

public extension TextFormatable {
    func toFormatter() -> TextFormatter {
        return .init(self)
    }
}
