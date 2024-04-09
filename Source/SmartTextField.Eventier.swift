import Foundation

// MARK: - SmartTextField.Eventier

public extension SmartTextField {
    final class Eventier {
        var shouldBeginEditing: () -> Bool
        var didBeginEditing: () -> Void

        var dateDidChanged: (_ newValue: Date) -> Void
        var textDidChanged: (_ newValue: String) -> Void
        var errorDidChanged: (_ state: TextValidationResult) -> Void

        var didEndEditing: () -> Void
        var didTapReturnButton: () -> Void
        var didTapToolbarDoneButton: () -> Void
        var clearButton: () -> Void

        required init(shouldBeginEditing: @escaping () -> Bool,
                      didBeginEditing: @escaping () -> Void,
                      dateDidChanged: @escaping (Date) -> Void,
                      textDidChanged: @escaping (String) -> Void,
                      errorDidChanged: @escaping (TextValidationResult) -> Void,
                      didEndEditing: @escaping () -> Void,
                      didTapReturnButton: @escaping () -> Void,
                      didTapToolbarDoneButton: @escaping () -> Void,
                      clearButton: @escaping () -> Void) {
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
    }
}

extension SmartTextField.Eventier {
    convenience init() {
        self.init(shouldBeginEditing: { true },
                  didBeginEditing: {},
                  dateDidChanged: { _ in },
                  textDidChanged: { _ in },
                  errorDidChanged: { _ in },
                  didEndEditing: {},
                  didTapReturnButton: {},
                  didTapToolbarDoneButton: {},
                  clearButton: {})
    }
}

// MARK: - SmartTextField.Eventier + Equatable

extension SmartTextField.Eventier: Equatable {
    public static func ==(lhs: SmartTextField.Eventier, rhs: SmartTextField.Eventier) -> Bool {
        return lhs === rhs
    }
}
