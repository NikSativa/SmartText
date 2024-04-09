import SmartText
import SpryKit
import XCTest

final class TextFormatter_LengthLimitedTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .lengthLimited(4)

        XCTAssertEqual(subject, .lengthLimited(4))
        XCTAssertNotEqual(subject, .identity)
        XCTAssertNotEqual(subject, .lengthLimited(3))
        XCTAssertNotEqual(subject, .lengthLimited(5))

        XCTAssertEqual(subject.formatText(""), "")
        XCTAssertEqual(subject.formatText("1"), "1")
        XCTAssertEqual(subject.formatText("12"), "12")
        XCTAssertEqual(subject.formatText("123"), "123")
        XCTAssertEqual(subject.formatText("1234"), "1234")
        XCTAssertEqual(subject.formatText("12345"), "1234")
        XCTAssertEqual(subject.formatText("123456"), "1234")
        XCTAssertEqual(subject.formatText("1234567"), "1234")
    }
}
