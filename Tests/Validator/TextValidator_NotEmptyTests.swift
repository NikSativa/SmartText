import SmartText
import XCTest

final class TextValidator_NotEmptyTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .notEmpty(errorText: "error")

        XCTAssertEqual(subject.validate(""), [.init(errorText: .plain("error"), isValid: false)])
        XCTAssertEqual(subject.validate("some text"), .valid)
    }
}
