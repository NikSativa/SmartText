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

    func ranges(of substring: String,
                options: CompareOptions = [],
                locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = range(of: substring,
                                options: options,
                                range: (ranges.last?.upperBound ?? startIndex)..<endIndex,
                                locale: locale) {
            ranges.append(range)
        }
        return ranges
    }

    func ranges(of aSet: CharacterSet,
                options: CompareOptions = []) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = rangeOfCharacter(from: aSet,
                                           options: options,
                                           range: (ranges.last?.upperBound ?? startIndex)..<endIndex) {
            ranges.append(range)
        }
        return ranges.combineRanges()
    }
}
