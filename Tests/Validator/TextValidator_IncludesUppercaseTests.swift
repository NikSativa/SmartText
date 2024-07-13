import SmartText
import XCTest

final class TextValidator_IncludesUppercaseTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .includesUppercase()

        XCTAssertEqual(subject.validate(""), .invalid)
        XCTAssertEqual(subject.validate("abc"), .invalid)
        XCTAssertEqual(subject.validate("ABC"), .valid)

        XCTAssertEqual(subject.validate("aB"), .valid)
        XCTAssertEqual(subject.validate("aBc"), .valid)
        XCTAssertEqual(subject.validate("AbC"), .valid)
        XCTAssertEqual(subject.validate("A123abc"), .valid)
    }
}
