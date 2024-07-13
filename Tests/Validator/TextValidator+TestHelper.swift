import Foundation
import SmartText
import SpryKit

// MARK: - TextValidator + SpryFriendlyStringConvertible

extension TextValidator: SpryFriendlyStringConvertible {
    public var friendlyDescription: String {
        let propertyReflector = PropertyReflector.scan(self)
        let formatters: [TextValidatable] = propertyReflector.property(named: "validators") ?? []
        return "TextValidator: " + formatters.compactMap { String(describing: $0) }.joined(separator: ", ")
    }
}
