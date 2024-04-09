import Foundation
import UIKit

public extension SmartTextField {
    enum State: Equatable {
        case clear
        case text(String)
    }

    struct DatePicker: Equatable {
        let calendar: Calendar
        let dateFormatter: Foundation.DateFormatter
        let minDate: Date
        let selecatedDate: Date?
        let maxDate: Date
        let mode: UIDatePicker.Mode
        let eventier: SmartTextField.Eventier?

        init(calendar: Calendar = .current,
             dateFormatter: Foundation.DateFormatter,
             minDate: Date,
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

    struct Configuration: Equatable {
        let placeholder: String
        let textFormatter: TextFormatter
        let textValidator: TextValidator

        let textContentType: UITextContentType?
        let isSecureTextEntry: Bool

        let keyboardType: UIKeyboardType
        let returnKeyType: UIReturnKeyType
        let autocapitalizationType: UITextAutocapitalizationType
        let autocorrectionType: UITextAutocorrectionType
        let clearButtonMode: UITextField.ViewMode

        init(placeholder: String,
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
