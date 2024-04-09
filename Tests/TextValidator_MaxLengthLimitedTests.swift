import SmartText
import XCTest

final class TextValidator_MaxLengthLimitedTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .maxLengthLimited(4)

        XCTAssertEqual(subject, .maxLengthLimited(4))
        XCTAssertNotEqual(subject, .identity)

        XCTAssertEqual(subject.isTextValid(""), .valid)
        XCTAssertEqual(subject.isTextValid("1"), .valid)
        XCTAssertEqual(subject.isTextValid("12"), .valid)
        XCTAssertEqual(subject.isTextValid("123"), .valid)
        XCTAssertEqual(subject.isTextValid("1234"), .valid)

        XCTAssertEqual(subject.isTextValid("12345"), .invalid)
        XCTAssertEqual(subject.isTextValid("123456"), .invalid)
    }
}
