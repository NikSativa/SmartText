import Foundation
import SwiftUI

private extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
}

public extension LocalizedStringKey {
    /// extension to get the string value of a LocalizedStringKey
    /// **IMAPORTANT**: use this methods on your own risk, because it uses private API
    func stringValue(bundle: Bundle = .main) -> String {
        return getStringValue(bundle: bundle, with: [])
    }

    /// extension to get the string value of a LocalizedStringKey
    /// **IMAPORTANT**: use this methods on your own risk, because it uses private API
    func stringValue(bundle: Bundle = .main, with parameters: any CVarArg...) -> String {
        return getStringValue(bundle: bundle, with: parameters)
    }

    private func getStringValue(bundle: Bundle = .main, with parameters: [any CVarArg]) -> String {
        guard let key = stringKey else {
            assertionFailure("LocalizedStringKey has no key \(String(describing: self))")
            return String(describing: self)
        }

        let formatString = bundle.localizedString(forKey: key, value: key, table: nil)
        return String(format: formatString, arguments: parameters)
    }
}
