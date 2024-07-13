import SmartText
import SpryKit
import XCTest

final class TextFormatter_StripSpacesTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .stripLeadingAndTrailingSpaces

        XCTAssertEqual(subject.format("    absd 456    "), "absd 456")
        XCTAssertEqual(subject.format("    absd 456"), "absd 456")
        XCTAssertEqual(subject.format("absd 456    "), "absd 456")
    }
}
