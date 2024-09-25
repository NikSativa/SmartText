#if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS) || supportsVisionOS
import Foundation
import UIKit

public extension UISmartTextField {
    struct Configuration {
        public enum Placeholder: Equatable, ExpressibleByStringLiteral {
            case text(String)
            case attributed(NSAttributedString)

            public init(stringLiteral value: String) {
                self = .text(value)
            }
        }

        public let placeholder: Placeholder?
        public let textFormatter: TextFormatter
        public let textValidator: TextValidator

        public let textContentType: UITextContentType?
        public let isSecureTextEntry: Bool

        public let keyboardType: UIKeyboardType
        public let returnKeyType: UIReturnKeyType
        public let autocapitalizationType: UITextAutocapitalizationType
        public let autocorrectionType: UITextAutocorrectionType
        public let clearButtonMode: UITextField.ViewMode
        public let clearsOnBeginEditing: Bool

        public init(placeholder: Placeholder? = nil,
                    textFormatter: TextFormatter = .identity,
                    textValidator: TextValidator = .identity,
                    textContentType: UITextContentType? = nil,
                    isSecureTextEntry: Bool = false,
                    keyboardType: UIKeyboardType = .default,
                    returnKeyType: UIReturnKeyType = .default,
                    autocapitalizationType: UITextAutocapitalizationType = .none,
                    autocorrectionType: UITextAutocorrectionType = .no,
                    clearButtonMode: UITextField.ViewMode = .never,
                    clearsOnBeginEditing: Bool = false) {
            self.placeholder = placeholder
            self.textFormatter = textFormatter
            self.textValidator = textValidator
            self.textContentType = textContentType
            self.isSecureTextEntry = isSecureTextEntry
            self.keyboardType = keyboardType
            self.returnKeyType = returnKeyType
            self.autocapitalizationType = autocapitalizationType
            self.autocorrectionType = autocorrectionType
            self.clearButtonMode = clearButtonMode
            self.clearsOnBeginEditing = clearsOnBeginEditing
        }
    }
}
#endif
