import Foundation
import SmartText
import XCTest

final class TextValidator_CustomTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .custom { str in
            return str.isEmpty || str.hasPrefix("123")
        }

        XCTAssertEqual(subject, .custom { $0.isEmpty })
        XCTAssertNotEqual(subject, .email())

        XCTAssertEqual(subject.isTextValid(""), .valid)
        XCTAssertEqual(subject.isTextValid("123"), .valid)
        XCTAssertEqual(subject.isTextValid("123qwwe"), .valid)

        XCTAssertEqual(subject.isTextValid("0"), .invalid)
        XCTAssertEqual(subject.isTextValid("sd0fsd 🤓"), .invalid)
        XCTAssertEqual(subject.isTextValid("asd"), .invalid)
        XCTAssertEqual(subject.isTextValid("asd123"), .invalid)
        XCTAssertEqual(subject.isTextValid("1223asd"), .invalid)
    }
}
