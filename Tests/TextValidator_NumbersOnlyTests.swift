import SmartText
import XCTest

final class TextValidator_NumbersOnlyTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .numbersOnly()

        XCTAssertEqual(subject, .numbersOnly())
        XCTAssertNotEqual(subject, .identity)

        XCTAssertEqual(subject.isTextValid(""), .valid)
        XCTAssertEqual(subject.isTextValid("123"), .valid)

        XCTAssertEqual(subject.isTextValid("abc123"), .invalid)
        XCTAssertEqual(subject.isTextValid("123abc"), .invalid)
    }
}
