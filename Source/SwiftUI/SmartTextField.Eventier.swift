#if canImport(SwiftUI) && canImport(UIKit) && !os(watchOS)
import Foundation

// MARK: - SmartTextField.Eventier

internal extension SmartTextField {
    final class Eventier {
        var shouldBeginEditing: () -> Bool
        var didBeginEditing: () -> Void

        var didEndEditing: () -> Void
        /// Return `true` if you want to resign first responder
        var didTapReturnButton: () -> Bool

        required init(shouldBeginEditing: @escaping () -> Bool = { true },
                      didBeginEditing: @escaping () -> Void = {},
                      didEndEditing: @escaping () -> Void = {},
                      didTapReturnButton: @escaping () -> Bool = { true }) {
            self.shouldBeginEditing = shouldBeginEditing
            self.didBeginEditing = didBeginEditing
            self.didEndEditing = didEndEditing
            self.didTapReturnButton = didTapReturnButton
        }
    }
}
#endif
