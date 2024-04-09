import Foundation

public protocol TextValidatable {
    var uniqueID: String { get }
    var errorText: String? { get }
    func isValid(string: String) -> Bool
}

public extension TextValidatable {
    var uniqueID: String {
        return makeUniqueID()
    }

    func makeUniqueID() -> String {
        return String(describing: type(of: self)) + (errorText.map { " errorText: \($0)" } ?? "")
    }

    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.uniqueID == rhs.uniqueID
    }
}
