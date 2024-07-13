import SmartText
import XCTest

final class String_RangesTests: XCTestCase {
    func test_CharacterSet() {
        run_range_test(of: .decimalDigits, in: "123abs456", sub: ["123", "456"])
        run_range_test(of: .decimalDigits, in: "abc", sub: [])
        run_range_test(of: .decimalDigits, in: "123", sub: ["123"])
        run_range_test(of: .decimalDigits, in: "", sub: [])
        run_range_test(of: .decimalDigits, in: "123456", sub: ["123456"])
        run_range_test(of: .decimalDigits, in: "abc123456", sub: ["123456"])
        run_range_test(of: .decimalDigits, in: "123456abc", sub: ["123456"])
        run_range_test(of: .decimalDigits, in: "abc123456abc", sub: ["123456"])
        run_range_test(of: .decimalDigits, in: "abc123456abc123456", sub: ["123456", "123456"])

        run_range_test(of: .decimalDigits.inverted, in: "123abs456", sub: ["abs"])
        run_range_test(of: .decimalDigits.inverted, in: "abc", sub: ["abc"])
        run_range_test(of: .decimalDigits.inverted, in: "123", sub: [])
        run_range_test(of: .decimalDigits.inverted, in: "", sub: [])
        run_range_test(of: .decimalDigits.inverted, in: "123456", sub: [])
        run_range_test(of: .decimalDigits.inverted, in: "abc123456", sub: ["abc"])
        run_range_test(of: .decimalDigits.inverted, in: "123456abc", sub: ["abc"])
        run_range_test(of: .decimalDigits.inverted, in: "abc123456abc", sub: ["abc", "abc"])
        run_range_test(of: .decimalDigits.inverted, in: "abc123456abc123456", sub: ["abc", "abc"])
    }

    func test_String() {
        run_range_test(of: "123", in: "123abs456", sub: ["123"])
        run_range_test(of: "123", in: "abc", sub: [])
        run_range_test(of: "123", in: "123", sub: ["123"])
        run_range_test(of: "123", in: "", sub: [])
        run_range_test(of: "123", in: "123456", sub: ["123"])
        run_range_test(of: "123", in: "abc123456", sub: ["123"])
        run_range_test(of: "123", in: "123456abc", sub: ["123"])
        run_range_test(of: "123", in: "abc123456abc", sub: ["123"])
        run_range_test(of: "123", in: "abc123456abc123456", sub: ["123", "123"])
        run_range_test(of: "123", in: "abc123123123123456abc123456", sub: ["123", "123", "123", "123", "123"])
    }

    func test_combineRanges() {
        run_range_test(of: [Range<Int>](), sub: [])
        run_range_test(of: [1..<3], sub: [1..<3])
        run_range_test(of: [1..<3, 2..<4], sub: [1..<4])
        run_range_test(of: [1..<3, 3..<5], sub: [1..<5])
        run_range_test(of: [1..<3, 4..<5], sub: [1..<3, 4..<5])
        run_range_test(of: [1..<3, 2..<4, 5..<7], sub: [1..<4, 5..<7])
        run_range_test(of: [1..<3, 2..<4, 5..<7, 6..<8], sub: [1..<4, 5..<8])
        run_range_test(of: [1..<3, 2..<4, 5..<7, 6..<8, 10..<12], sub: [1..<4, 5..<8, 10..<12])
    }
}

private extension XCTestCase {
    func run_range_test(of aSet: CharacterSet,
                        in str: String,
                        sub: [String],
                        file: StaticString = #filePath,
                        line: UInt = #line) {
        let resultArr = str.ranges(of: aSet)
        XCTAssertEqual(resultArr.count, sub.count, file: file, line: line)
        XCTAssertEqual(resultArr.map { String(str[$0]) }, sub, file: file, line: line)
    }

    func run_range_test(of aStr: String,
                        in str: String,
                        sub: [String],
                        file: StaticString = #filePath,
                        line: UInt = #line) {
        let resultArr = str.ranges(of: aStr)
        XCTAssertEqual(resultArr.count, sub.count, file: file, line: line)
        XCTAssertEqual(resultArr.map { String(str[$0]) }, sub, file: file, line: line)
    }

    func run_range_test<T: Comparable>(of ranges: [Range<T>],
                                       sub: [Range<T>],
                                       file: StaticString = #filePath,
                                       line: UInt = #line) {
        let result = ranges.combineRanges()
        XCTAssertEqual(result, sub)
    }
}
