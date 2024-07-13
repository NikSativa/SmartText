import SmartText
import XCTest

final class TextValidator_IncludesLowercaseTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .includesLowercase()

        XCTAssertEqual(subject.validate(""), .invalid)
        XCTAssertEqual(subject.validate("abc"), .valid)
        XCTAssertEqual(subject.validate("ABC"), .invalid)

        XCTAssertEqual(subject.validate("aB"), .valid)
        XCTAssertEqual(subject.validate("aBc"), .valid)
        XCTAssertEqual(subject.validate("AbC"), .valid)
        XCTAssertEqual(subject.validate("A123abc"), .valid)
    }
}
