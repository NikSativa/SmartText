import Foundation
import SmartText
import XCTest

extension XCTestCase {
    func run_validation_test(_ subject: TextValidator,
                             _ str: String,
                             sub: [String],
                             file: StaticString = #filePath,
                             line: UInt = #line) throws {
        let resultArr = subject.validate(str)
        XCTAssertEqual(resultArr.count, 1, file: file, line: line)
        XCTAssertEqual(resultArr.map(\.isValid), [false], file: file, line: line)
        XCTAssertEqual(resultArr.flatMap(\.invalidRanges).map { String(str[$0]) }, sub, file: file, line: line)
    }

    func run_formating_test(_ subject: TextFormatter,
                            _ actual: String,
                            expected: String,
                            file: StaticString = #filePath,
                            line: UInt = #line) throws {
        let resultStr = subject.format(actual)
        XCTAssertEqual(resultStr, expected, expected, file: file, line: line)
    }
}
