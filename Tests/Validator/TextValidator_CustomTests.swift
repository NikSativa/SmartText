import Foundation
import SmartText
import XCTest

final class TextValidator_CustomTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .custom { str, _ in
            if str.isEmpty || str.hasPrefix("123") {
                return .valid
            }
            return .invalid
        }

        XCTAssertTrue(subject.validate("").isValid)
        XCTAssertTrue(subject.validate("123").isValid)
        XCTAssertTrue(subject.validate("123qwwe").isValid)

        XCTAssertTrue(subject.validate("0").isInvalid)
        XCTAssertTrue(subject.validate("sd0fsd 🤓").isInvalid)
        XCTAssertTrue(subject.validate("asd").isInvalid)
        XCTAssertTrue(subject.validate("asd123").isInvalid)
        XCTAssertTrue(subject.validate("1223asd").isInvalid)
    }
}
