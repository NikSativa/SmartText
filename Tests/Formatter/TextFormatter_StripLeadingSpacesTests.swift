import SmartText
import SpryKit
import XCTest

final class TextFormatter_StripLeadingSpacesTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .stripLeadingSpaces

        XCTAssertEqual(subject.format("    absd 456    "), "absd 456    ")
        XCTAssertEqual(subject.format("   \n absd 456    "), "\n absd 456    ")
        XCTAssertEqual(subject.format("absd 456    "), "absd 456    ")
    }
}
