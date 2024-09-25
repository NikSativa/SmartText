#if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS) || supportsVisionOS
import Foundation
import UIKit

public extension UISmartTextField {
    #if os(iOS) || targetEnvironment(macCatalyst) || supportsVisionOS
    struct DatePicker {
        public let calendar: Calendar
        public let dateFormatter: Foundation.DateFormatter
        public let minDate: Date
        public let selecatedDate: Date?
        public let maxDate: Date
        public let mode: UIDatePicker.Mode
        public let eventier: UISmartTextField.Eventier?

        public init(calendar: Calendar = .current,
                    dateFormatter: Foundation.DateFormatter,
                    minDate: Date = .init(),
                    selecatedDate: Date?,
                    maxDate: Date,
                    mode: UIDatePicker.Mode = .date,
                    eventier: UISmartTextField.Eventier? = nil) {
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
}
#endif
