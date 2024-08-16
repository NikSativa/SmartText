import Foundation
import SwiftUI

public struct TextValidationResult: Equatable {
    public let invalidRanges: [Range<String.Index>]
    public let errorText: STString?
    public let isValid: Bool

    public init(invalidRanges: [Range<String.Index>] = [],
                errorText: STString? = nil,
                isValid: Bool) {
        self.invalidRanges = invalidRanges
        self.errorText = errorText
        self.isValid = isValid
    }
}

public extension TextValidationResult {
    static let invalid: Self = .init(isValid: false)
    static let valid: Self = .init(invalidRanges: [], errorText: nil, isValid: true)

    static func invalid(withError error: STString? = nil) -> Self {
        return .init(invalidRanges: [], errorText: error, isValid: false)
    }

    static func invalid(withErrorKey key: LocalizedStringKey? = nil) -> Self {
        return .init(invalidRanges: [], errorText: key.map(STString.localized), isValid: false)
    }

    static func invalid(withErrorText text: String? = nil) -> Self {
        return .init(invalidRanges: [], errorText: text.map(STString.plain), isValid: false)
    }
}

public extension [TextValidationResult] {
    var isValid: Bool {
        return allSatisfy(\.isValid)
    }

    var isInvalid: Bool {
        return contains(where: { $0.isValid == false })
    }
}
