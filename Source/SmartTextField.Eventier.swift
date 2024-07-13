#if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS) || os(visionOS)
import Foundation

// MARK: - SmartTextField.Eventier

public extension SmartTextField {
    final class Eventier {
        public var shouldBeginEditing: () -> Bool
        public var didBeginEditing: () -> Void

        public var textDidChanged: (_ newValue: String) -> Void
        public var errorDidChanged: (_ state: [TextValidationResult]) -> Void

        public var didEndEditing: () -> Void
        /// Return `true` if you want to resign first responder
        public var didTapReturnButton: () -> Bool
        public var clearButton: () -> Void

        #if os(iOS) || targetEnvironment(macCatalyst)
        public var dateDidChanged: (_ newValue: Date) -> Void
        public var didTapToolbarDoneButton: () -> Void

        /// * `didTapReturnButton`: return `true` if you want to resign first responder
        public required init(shouldBeginEditing: @escaping () -> Bool = { true },
                             didBeginEditing: @escaping () -> Void = {},
                             dateDidChanged: @escaping (Date) -> Void = { _ in },
                             textDidChanged: @escaping (String) -> Void = { _ in },
                             errorDidChanged: @escaping ([TextValidationResult]) -> Void = { _ in },
                             didEndEditing: @escaping () -> Void = {},
                             didTapReturnButton: @escaping () -> Bool = { true },
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
        public var dateDidChanged: (_ newValue: Date) -> Void
        public required init(shouldBeginEditing: @escaping () -> Bool = { true },
                             didBeginEditing: @escaping () -> Void = {},
                             dateDidChanged: @escaping (Date) -> Void = { _ in },
                             textDidChanged: @escaping (String) -> Void = { _ in },
                             errorDidChanged: @escaping ([TextValidationResult]) -> Void = { _ in },
                             didEndEditing: @escaping () -> Void = {},
                             didTapReturnButton: @escaping () -> Bool = { true },
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
        public required init(shouldBeginEditing: @escaping () -> Bool = { true },
                             didBeginEditing: @escaping () -> Void = {},
                             textDidChanged: @escaping (String) -> Void = { _ in },
                             errorDidChanged: @escaping ([TextValidationResult]) -> Void = { _ in },
                             didEndEditing: @escaping () -> Void = {},
                             didTapReturnButton: @escaping () -> Bool = { true },
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
#endif
