import Foundation
import SmartText
import SpryKit
import XCTest

final class TextFormatter_IdentityTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .identity

        let text = " a 1 b 2 c 3 ! "
        XCTAssertEqual(subject.format(text), text)

        let text2 = UUID().uuidString
        XCTAssertEqual(subject.format(text2), text2)
    }
}
