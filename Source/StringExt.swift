import Foundation

public extension String {
    subscript(from: Int = 0, maxLength maxLength: Int) -> String {
        if isEmpty {
            return self
        }

        if from >= count {
            return ""
        }

        let start = index(startIndex, offsetBy: from)
        let end = index(startIndex, offsetBy: min(from + maxLength, count))
        return String(self[start..<end])
    }
}
