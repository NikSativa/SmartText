import SmartText
import XCTest

final class TextValidator_MinLengthLimitedTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .minLengthLimited(4)

        XCTAssertEqual(subject.validate(""), .invalid)
        XCTAssertEqual(subject.validate("1"), .invalid)
        XCTAssertEqual(subject.validate("12"), .invalid)
        XCTAssertEqual(subject.validate("123"), .invalid)

        XCTAssertEqual(subject.validate("1234"), .valid)
        XCTAssertEqual(subject.validate("12345"), .valid)
        XCTAssertEqual(subject.validate("123456"), .valid)
    }
}
