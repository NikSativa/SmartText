import Foundation

public protocol TextFormatable {
    var uniqueID: String { get }
    func formatText(_ string: String) -> String
}

public extension TextFormatable {
    var uniqueID: String {
        makeUniqueID()
    }

    func makeUniqueID() -> String {
        String(describing: type(of: self))
    }

    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.uniqueID == rhs.uniqueID
    }
}
