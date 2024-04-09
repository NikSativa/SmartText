import SmartText
import SpryKit
import XCTest

final class TextFormatter_StripSpacesTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .stripLeadingAndTrailingSpaces

        XCTAssertEqual(subject, .stripLeadingAndTrailingSpaces)
        XCTAssertNotEqual(subject, .identity)

        XCTAssertEqual(subject.formatText("    absd 456    "), "absd 456")
        XCTAssertEqual(subject.formatText("    absd 456"), "absd 456")
        XCTAssertEqual(subject.formatText("absd 456    "), "absd 456")
    }
}
