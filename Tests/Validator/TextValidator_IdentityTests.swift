import Foundation
import SmartText
import XCTest

final class TextValidator_IdentityTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .identity

        XCTAssertTrue(subject.validate("").isValid)
        XCTAssertTrue(subject.validate("sdfsd 🤓").isValid)
        XCTAssertTrue(subject.validate(UUID().uuidString).isValid)
    }
}
