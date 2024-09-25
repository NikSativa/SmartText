import Foundation
import SwiftUI

public enum STString: Equatable {
    case plain(String)
    case localized(LocalizedStringKey)

    public init(_ value: LocalizedStringKey) {
        self = .localized(value)
    }
}

public extension LocalizedStringKey {
    var st: STString {
        return .localized(self)
    }
}

public extension String {
    var st: STString {
        return .plain(self)
    }
}

#if swift(>=6.0)
extension STString: @unchecked Sendable {}
#endif
