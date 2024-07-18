import Foundation
import SwiftUI

public enum STString: Equatable {
    case plain(String)
    case localized(LocalizedStringKey)
}

// MARK: - ExpressibleByStringLiteral

extension STString: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .plain(value)
    }
}
