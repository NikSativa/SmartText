import SmartText
import XCTest

final class TextValidator_NotEmptyTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .notEmpty(errorText: "error")

        XCTAssertEqual(subject, .notEmpty(errorText: "error"))
        XCTAssertNotEqual(subject, .identity)

        XCTAssertEqual(subject.isTextValid(""), .invalidWithErrorText("error"))
        XCTAssertEqual(subject.isTextValid("some text"), .valid)
    }
}
