import Foundation

public extension TextValidator {
    static var identity: TextValidator {
        return TextValidator(IdentityTextValidator())
    }
}

private struct IdentityTextValidator: TextValidatable {
    let errorText: String? = nil

    func isValid(string _: String) -> Bool {
        return true
    }
}
