import Foundation

public struct TextValidationResult: Equatable {
    public let invalidRanges: [Range<String.Index>]
    public let errorText: String?
    public let isValid: Bool

    public static let valid: Self = .init(invalidRanges: [], errorText: nil, isValid: true)
    public static func invalid(withErrorText: String? = nil) -> Self {
        return .init(invalidRanges: [], errorText: withErrorText, isValid: false)
    }

    public init(invalidRanges: [Range<String.Index>] = [],
                errorText: String? = nil,
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
