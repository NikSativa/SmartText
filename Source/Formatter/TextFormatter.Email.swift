import Foundation

public extension TextFormatter {
    static var email: TextFormatter {
        return EmailTextFormatter().toFormatter()
    }
}

private struct EmailTextFormatter: TextFormatable {
    static let specialChars: String = "-.+"
    static let kAllowedCharacters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        + "abcdefghijklmnopqrstuvwxyz"
        + "1234567890"
        + specialChars
        + "_" // can be repeated many times

    public func format(_ value: String) -> String {
        var hasDomain = false
        return value
            .replacingPairs(of: Self.specialChars)
            .replacingOccurrencesRecursively(of: ".@", with: "@")
            .replacingOccurrencesRecursively(of: "@.", with: "@")
            .replacingOccurrencesRecursively(of: "+@", with: "@")
            .replacingOccurrencesRecursively(of: "@+", with: "@")
            .filter {
                if EmailTextFormatter.kAllowedCharacters.contains($0) {
                    return true
                } else if $0 == "@" {
                    if hasDomain {
                        return false
                    } else {
                        hasDomain = true
                        return true
                    }
                }

                return false
            }
    }
}

private extension String {
    func replacingPairs(of src: String) -> String {
        var result = self
        for ch in src {
            result = result.replacingOccurrencesRecursively(of: "\(ch)\(ch)", with: "\(ch)")
        }
        return result
    }

    func replacingOccurrencesRecursively(of target: String, with replacement: String) -> String {
        var modifiedString = self
        while modifiedString.contains(target) {
            modifiedString = modifiedString.replacingOccurrences(of: target, with: replacement)
        }

        return modifiedString
    }
}
