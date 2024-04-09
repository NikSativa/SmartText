import SmartText
import XCTest

final class TextValidator_MinLengthLimitedTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .minLengthLimited(4)

        XCTAssertEqual(subject, .minLengthLimited(4))
        XCTAssertNotEqual(subject, .identity)

        XCTAssertEqual(subject.isTextValid(""), .invalid)
        XCTAssertEqual(subject.isTextValid("1"), .invalid)
        XCTAssertEqual(subject.isTextValid("12"), .invalid)
        XCTAssertEqual(subject.isTextValid("123"), .invalid)

        XCTAssertEqual(subject.isTextValid("1234"), .valid)
        XCTAssertEqual(subject.isTextValid("12345"), .valid)
        XCTAssertEqual(subject.isTextValid("123456"), .valid)
    }
}
