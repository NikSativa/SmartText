import Foundation
import SwiftUI

public extension TextValidator {
    static func email(errorText: String? = nil) -> TextValidator {
        return EmailValidation(errorText: errorText.map(STString.plain)).toValidator()
    }

    static func email(errorKey: LocalizedStringKey) -> TextValidator {
        return EmailValidation(errorText: .localized(errorKey)).toValidator()
    }
}

private struct EmailValidation: TextValidatable {
    let errorText: STString?

    #if swift(>=6.0)
    private nonisolated(unsafe) static let emailPredicate: NSPredicate = {
        let emailStartValidCharacters = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+"
        let emailLastGroupValidCharacters = "(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*"
        let emailDomainStartValidCharacter = "[A-Za-z0-9]"
        let emailDomainEndingValidCharacters = "([A-Za-z0-9-]*[A-Za-z0-9])*"
        let emailDomainExtensionValidCharacters = "(\\.[A-Za-z]{2,}){1,}"
        let emailRegEx = [
            emailStartValidCharacters,
            emailLastGroupValidCharacters,
            "@",
            emailDomainStartValidCharacter,
            emailDomainEndingValidCharacters,
            emailDomainExtensionValidCharacters
        ].joined()
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    }()
    #else
    private static let emailPredicate: NSPredicate = {
        let emailStartValidCharacters = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+"
        let emailLastGroupValidCharacters = "(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*"
        let emailDomainStartValidCharacter = "[A-Za-z0-9]"
        let emailDomainEndingValidCharacters = "([A-Za-z0-9-]*[A-Za-z0-9])*"
        let emailDomainExtensionValidCharacters = "(\\.[A-Za-z]{2,}){1,}"
        let emailRegEx = [
            emailStartValidCharacters,
            emailLastGroupValidCharacters,
            "@",
            emailDomainStartValidCharacter,
            emailDomainEndingValidCharacters,
            emailDomainExtensionValidCharacters
        ].joined()
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    }()
    #endif

    private static let aSet = CharacterSet(charactersIn: "@._-")
        .union(.lowercaseLetters)
        .union(.uppercaseLetters)
        .union(.decimalDigits)
        .inverted
        .union(.init(charactersIn: "+!#$%&'*+/=?^_`{|}~\",\\<>;:[]()"))

    func validate(_ value: String) -> TextValidationResult {
        if Self.emailPredicate.evaluate(with: value) {
            return .valid
        }

        let common = value.ranges(of: Self.aSet)
        let at = value.ranges(of: .init(charactersIn: "@")).dropFirst()
        let points = value.ranges(of: ".")
            .combineRanges()
            .filter { range in
                return value[range].count > 1
            }
        let weirdPairs = [
            "-@", "@-",
            "@.", ".@",
            ".-", "-.",
            "@@"
        ]
            .map {
                value.ranges(of: $0)
            }
            .flatMap { $0 }

        let combinations = common + at + points + weirdPairs
        let result = combinations
            .sorted { a, b in
                if a.lowerBound == b.lowerBound {
                    return a.upperBound < b.upperBound
                }
                return a.lowerBound < b.lowerBound
            }
            .combineRanges()
        return .init(invalidRanges: result,
                     errorText: errorText,
                     isValid: false)
    }
}

#if swift(>=6.0)
extension EmailValidation: @unchecked Sendable {}
#endif
