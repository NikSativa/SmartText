import Foundation
import SwiftUI

public struct TextValidationResult: Equatable {
    public let invalidRanges: [Range<String.Index>]
    public let errorText: STString?
    public let isValid: Bool

    public static let valid: Self = .init(invalidRanges: [], errorText: nil, isValid: true)
    public static func invalid(withErrorText: STString? = nil) -> Self {
        return .init(invalidRanges: [], errorText: withErrorText, isValid: false)
    }

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
}

public extension [TextValidationResult] {
    static let invalid: Self = [.invalid]
    static let valid: Self = []
}
