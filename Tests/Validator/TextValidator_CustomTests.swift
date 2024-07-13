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

        XCTAssertEqual(subject.validate(""), .valid)
        XCTAssertEqual(subject.validate("123"), .valid)
        XCTAssertEqual(subject.validate("123qwwe"), .valid)

        XCTAssertEqual(subject.validate("0"), .invalid)
        XCTAssertEqual(subject.validate("sd0fsd 🤓"), .invalid)
        XCTAssertEqual(subject.validate("asd"), .invalid)
        XCTAssertEqual(subject.validate("asd123"), .invalid)
        XCTAssertEqual(subject.validate("1223asd"), .invalid)
    }
}
