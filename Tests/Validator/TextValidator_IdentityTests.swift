import Foundation
import SmartText
import XCTest

final class TextValidator_IdentityTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .identity

        XCTAssertEqual(subject.validate(""), .valid)
        XCTAssertEqual(subject.validate("sdfsd 🤓"), .valid)
        XCTAssertEqual(subject.validate(UUID().uuidString), .valid)
    }
}
