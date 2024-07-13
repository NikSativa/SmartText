import Foundation

public extension Array {
    func combineRanges<T: Comparable>() -> [Range<T>] where Element == Range<T> {
        var result: [Range<T>] = []
        var lastRange: Range<T>?
        for range in self {
            if let _lastRange = lastRange {
                if range.lowerBound <= _lastRange.upperBound {
                    lastRange = _lastRange.lowerBound..<range.upperBound
                } else {
                    result.append(_lastRange)
                    lastRange = range
                }
            } else {
                lastRange = range
            }
        }
        if let lastRange {
            result.append(lastRange)
        }
        return result
    }
}
