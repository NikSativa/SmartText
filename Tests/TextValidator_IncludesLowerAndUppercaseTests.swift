import SmartText
import XCTest

final class TextValidator_IncludesLowerAndUppercaseTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .includesLowerAndUppercase()

        XCTAssertEqual(subject, .includesLowerAndUppercase())
        XCTAssertNotEqual(subject, .identity)

        XCTAssertEqual(subject.isTextValid(""), .invalid)
        XCTAssertEqual(subject.isTextValid("abc"), .invalid)
        XCTAssertEqual(subject.isTextValid("ABC"), .invalid)

        XCTAssertEqual(subject.isTextValid("aB"), .valid)
        XCTAssertEqual(subject.isTextValid("aBc"), .valid)
        XCTAssertEqual(subject.isTextValid("AbC"), .valid)
        XCTAssertEqual(subject.isTextValid("A123abc"), .valid)
    }
}
