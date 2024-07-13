import SmartText
import SpryKit
import XCTest

final class TextFormatter_LengthLimitedTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .lengthLimited(4)

        XCTAssertEqual(subject.format(""), "")
        XCTAssertEqual(subject.format("1"), "1")
        XCTAssertEqual(subject.format("12"), "12")
        XCTAssertEqual(subject.format("123"), "123")
        XCTAssertEqual(subject.format("1234"), "1234")
        XCTAssertEqual(subject.format("12345"), "1234")
        XCTAssertEqual(subject.format("123456"), "1234")
        XCTAssertEqual(subject.format("1234567"), "1234")
    }
}
