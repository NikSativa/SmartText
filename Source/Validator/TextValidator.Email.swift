import Foundation

public extension TextValidator {
    static func email(errorText: String? = nil) -> TextValidator {
        return TextValidator(EmailValidation(errorText: errorText))
    }
}

private struct EmailValidation: TextValidatable {
    let errorText: String?

    init(errorText: String?) {
        self.errorText = errorText
    }

    private static let emailPredicate: NSPredicate = {
        let emailStartValidCharacters = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+"
        let emailLastGroupValidCharacters = "(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*"
        let emailDomainStartValidCharacter = "[A-Za-z0-9]"
        let emailDomainEndingValidCharacters = "([A-Za-z0-9-]*[A-Za-z0-9])*"
        let emailDomainExtensionValidCharacters = "(\\.[A-Za-z]{2,}){1,}"
        let emailRegEx = emailStartValidCharacters + emailLastGroupValidCharacters + "@" + emailDomainStartValidCharacter + emailDomainEndingValidCharacters + emailDomainExtensionValidCharacters
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    }()

    func isValid(string: String) -> Bool {
        return EmailValidation.emailPredicate.evaluate(with: string)
    }
}
