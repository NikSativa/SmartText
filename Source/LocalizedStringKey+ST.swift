import Foundation
import SwiftUI

private extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
}

public extension LocalizedStringKey {
    func stringValue() -> String {
        return stringValue(with: [])
    }

    func stringValue(bundle: Bundle = .main, with parameters: any CVarArg...) -> String {
        guard let key = stringKey else {
            assertionFailure("LocalizedStringKey has no key \(String(describing: self))")
            return String(describing: self)
        }

        let formatString = bundle.localizedString(forKey: key, value: key, table: nil)
        return String(format: formatString, arguments: parameters)
    }
}
