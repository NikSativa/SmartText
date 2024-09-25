#if canImport(SwiftUI) && canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension SmartTextField {
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
        public let clearsOnBeginEditing: Bool
        /// if true, textValidator will be called on every editing change and on end editing. If false, it will be called only on end editing.
        public let checkErrorOnEditing: Bool
        public let checkErrorOnAppear: Bool

        #if supportsVisionOS || os(tvOS)
        /// - **checkErrorOnEditing** if true, textValidator will be called on every editing change and on end editing. If false, it will be called only on end editing.
        public init(placeholder: Placeholder? = nil,
                    textFormatter: TextFormatter = .identity,
                    textValidator: TextValidator = .identity,
                    textContentType: UITextContentType? = nil,
                    isSecureTextEntry: Bool = false,
                    keyboardType: UIKeyboardType = .default,
                    returnKeyType: UIReturnKeyType = .default,
                    autocapitalizationType: UITextAutocapitalizationType = .none,
                    autocorrectionType: UITextAutocorrectionType = .no,
                    clearsOnBeginEditing: Bool = false,
                    checkErrorOnEditing: Bool = true,
                    checkErrorOnAppear: Bool = true) {
            self.placeholder = placeholder
            self.textFormatter = textFormatter
            self.textValidator = textValidator
            self.textContentType = textContentType
            self.isSecureTextEntry = isSecureTextEntry
            self.keyboardType = keyboardType
            self.returnKeyType = returnKeyType
            self.autocapitalizationType = autocapitalizationType
            self.autocorrectionType = autocorrectionType
            self.clearsOnBeginEditing = clearsOnBeginEditing
            self.checkErrorOnEditing = checkErrorOnEditing
            self.checkErrorOnAppear = checkErrorOnAppear
        }
        #else
        public let toolbar: (() -> UIToolbar)?

        /// - **checkErrorOnEditing** if true, textValidator will be called on every editing change and on end editing. If false, it will be called only on end editing.
        public init(placeholder: Placeholder? = nil,
                    textFormatter: TextFormatter = .identity,
                    textValidator: TextValidator = .identity,
                    textContentType: UITextContentType? = nil,
                    isSecureTextEntry: Bool = false,
                    keyboardType: UIKeyboardType = .default,
                    returnKeyType: UIReturnKeyType = .default,
                    autocapitalizationType: UITextAutocapitalizationType = .none,
                    autocorrectionType: UITextAutocorrectionType = .no,
                    clearsOnBeginEditing: Bool = false,
                    checkErrorOnEditing: Bool = true,
                    checkErrorOnAppear: Bool = true,
                    toolbar: (() -> UIToolbar)? = nil) {
            self.placeholder = placeholder
            self.textFormatter = textFormatter
            self.textValidator = textValidator
            self.textContentType = textContentType
            self.isSecureTextEntry = isSecureTextEntry
            self.keyboardType = keyboardType
            self.returnKeyType = returnKeyType
            self.autocapitalizationType = autocapitalizationType
            self.autocorrectionType = autocorrectionType
            self.clearsOnBeginEditing = clearsOnBeginEditing
            self.checkErrorOnEditing = checkErrorOnEditing
            self.toolbar = toolbar
            self.checkErrorOnAppear = checkErrorOnAppear
        }
        #endif
    }
}
#endif
