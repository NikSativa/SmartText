import SmartText
import XCTest

final class TextValidator_IncludesUppercaseTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .includesUppercase()

        XCTAssertTrue(subject.validate("").isInvalid)
        XCTAssertTrue(subject.validate("abc").isInvalid)
        XCTAssertTrue(subject.validate("ABC").isValid)

        XCTAssertTrue(subject.validate("aB").isValid)
        XCTAssertTrue(subject.validate("aBc").isValid)
        XCTAssertTrue(subject.validate("AbC").isValid)
        XCTAssertTrue(subject.validate("A123abc").isValid)
    }
}
