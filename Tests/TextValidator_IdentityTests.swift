import Foundation
import SmartText
import XCTest

final class TextValidator_IdentityTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .identity

        XCTAssertEqual(subject, .identity)
        XCTAssertNotEqual(subject, .email())

        XCTAssertEqual(subject.isTextValid(""), .valid)
        XCTAssertEqual(subject.isTextValid("sdfsd 🤓"), .valid)
        XCTAssertEqual(subject.isTextValid(UUID().uuidString), .valid)
    }
}
