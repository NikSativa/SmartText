import SmartText
import XCTest

final class TextValidator_MinLengthLimitedTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .minLengthLimited(4)

        XCTAssertTrue(subject.validate("").isInvalid)
        XCTAssertTrue(subject.validate("1").isInvalid)
        XCTAssertTrue(subject.validate("12").isInvalid)
        XCTAssertTrue(subject.validate("123").isInvalid)

        XCTAssertTrue(subject.validate("1234").isValid)
        XCTAssertTrue(subject.validate("12345").isValid)
        XCTAssertTrue(subject.validate("123456").isValid)
    }
}
