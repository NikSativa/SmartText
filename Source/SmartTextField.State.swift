#if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS) || os(visionOS)
import Foundation
import UIKit

public extension SmartTextField {
    enum State: Equatable {
        case clear
        case text(String)
    }

    #if os(iOS) || targetEnvironment(macCatalyst) || os(visionOS)
    struct DatePicker: Equatable {
        public let calendar: Calendar
        public let dateFormatter: Foundation.DateFormatter
        public let minDate: Date
        public let selecatedDate: Date?
        public let maxDate: Date
        public let mode: UIDatePicker.Mode
        public let eventier: SmartTextField.Eventier?

        public init(calendar: Calendar = .current,
                    dateFormatter: Foundation.DateFormatter,
                    minDate: Date = .init(),
                    selecatedDate: Date?,
                    maxDate: Date,
                    mode: UIDatePicker.Mode = .date,
                    eventier: SmartTextField.Eventier? = nil) {
            self.calendar = calendar
            self.dateFormatter = dateFormatter
            self.minDate = minDate
            self.selecatedDate = selecatedDate
            self.maxDate = maxDate
            self.mode = mode
            self.eventier = eventier
        }
    }
    #endif

    struct Configuration: Equatable {
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

        public init(placeholder: Placeholder? = nil,
                    textFormatter: TextFormatter = .identity,
                    textValidator: TextValidator = .identity,
                    textContentType: UITextContentType? = nil,
                    isSecureTextEntry: Bool = false,
                    keyboardType: UIKeyboardType = .default,
                    returnKeyType: UIReturnKeyType = .default,
                    autocapitalizationType: UITextAutocapitalizationType = .none,
                    autocorrectionType: UITextAutocorrectionType = .no,
                    clearButtonMode: UITextField.ViewMode = .never) {
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
        }
    }
}
#endif
