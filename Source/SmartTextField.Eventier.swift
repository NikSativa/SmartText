#if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS) || os(visionOS)
import Foundation

// MARK: - SmartTextField.Eventier

public extension SmartTextField {
    final class Eventier {
        var shouldBeginEditing: () -> Bool
        var didBeginEditing: () -> Void

        var textDidChanged: (_ newValue: String) -> Void
        var errorDidChanged: (_ state: TextValidationResult) -> Void

        var didEndEditing: () -> Void
        var didTapReturnButton: () -> Void
        var clearButton: () -> Void

        #if os(iOS) || targetEnvironment(macCatalyst)
        var dateDidChanged: (_ newValue: Date) -> Void
        var didTapToolbarDoneButton: () -> Void

        required init(shouldBeginEditing: @escaping () -> Bool = { true },
                      didBeginEditing: @escaping () -> Void = {},
                      dateDidChanged: @escaping (Date) -> Void = { _ in },
                      textDidChanged: @escaping (String) -> Void = { _ in },
                      errorDidChanged: @escaping (TextValidationResult) -> Void = { _ in },
                      didEndEditing: @escaping () -> Void = {},
                      didTapReturnButton: @escaping () -> Void = {},
                      didTapToolbarDoneButton: @escaping () -> Void = {},
                      clearButton: @escaping () -> Void = {}) {
            self.shouldBeginEditing = shouldBeginEditing
            self.didBeginEditing = didBeginEditing
            self.dateDidChanged = dateDidChanged
            self.textDidChanged = textDidChanged
            self.errorDidChanged = errorDidChanged
            self.didEndEditing = didEndEditing
            self.didTapReturnButton = didTapReturnButton
            self.didTapToolbarDoneButton = didTapToolbarDoneButton
            self.clearButton = clearButton
        }

        #elseif os(visionOS)
        var dateDidChanged: (_ newValue: Date) -> Void
        required init(shouldBeginEditing: @escaping () -> Bool = { true },
                      didBeginEditing: @escaping () -> Void = {},
                      dateDidChanged: @escaping (Date) -> Void = { _ in },
                      textDidChanged: @escaping (String) -> Void = { _ in },
                      errorDidChanged: @escaping (TextValidationResult) -> Void = { _ in },
                      didEndEditing: @escaping () -> Void = {},
                      didTapReturnButton: @escaping () -> Void = {},
                      clearButton: @escaping () -> Void = {}) {
            self.shouldBeginEditing = shouldBeginEditing
            self.didBeginEditing = didBeginEditing
            self.dateDidChanged = dateDidChanged
            self.textDidChanged = textDidChanged
            self.errorDidChanged = errorDidChanged
            self.didEndEditing = didEndEditing
            self.didTapReturnButton = didTapReturnButton
            self.clearButton = clearButton
        }
        #elseif os(tvOS)
        required init(shouldBeginEditing: @escaping () -> Bool = { true },
                      didBeginEditing: @escaping () -> Void = {},
                      textDidChanged: @escaping (String) -> Void = { _ in },
                      errorDidChanged: @escaping (TextValidationResult) -> Void = { _ in },
                      didEndEditing: @escaping () -> Void = {},
                      didTapReturnButton: @escaping () -> Void = {},
                      clearButton: @escaping () -> Void = {}) {
            self.shouldBeginEditing = shouldBeginEditing
            self.didBeginEditing = didBeginEditing
            self.textDidChanged = textDidChanged
            self.errorDidChanged = errorDidChanged
            self.didEndEditing = didEndEditing
            self.didTapReturnButton = didTapReturnButton
            self.clearButton = clearButton
        }
        #endif
    }
}

// MARK: - SmartTextField.Eventier + Equatable

extension SmartTextField.Eventier: Equatable {
    public static func ==(lhs: SmartTextField.Eventier, rhs: SmartTextField.Eventier) -> Bool {
        return lhs === rhs
    }
}
#endif
