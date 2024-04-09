import Foundation
import SmartText
import SpryKit
import XCTest

final class TextFormatter_IdentityTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .identity

        XCTAssertEqual(subject, .identity)
        XCTAssertNotEqual(subject, .email)

        let text = " a 1 b 2 c 3 ! "
        XCTAssertEqual(subject.formatText(text), text)

        let text2 = UUID().uuidString
        XCTAssertEqual(subject.formatText(text2), text2)
    }
}
