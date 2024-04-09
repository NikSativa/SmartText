import Foundation

public extension TextFormatter {
    static var email: TextFormatter {
        return [EmailTextFormatter()]
    }
}

private struct EmailTextFormatter: TextFormatable {
    static let kAllowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        + "abcdefghijklmnopqrstuvwxyz"
        + "1234567890"
        + "-_.+"

    public func formatText(_ string: String) -> String {
        var hasDomain = false
        return string.filter {
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
