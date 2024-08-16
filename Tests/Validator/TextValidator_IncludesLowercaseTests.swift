import SmartText
import XCTest

final class TextValidator_IncludesLowercaseTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .includesLowercase()

        XCTAssertTrue(subject.validate("").isInvalid)
        XCTAssertTrue(subject.validate("abc").isValid)
        XCTAssertTrue(subject.validate("ABC").isInvalid)

        XCTAssertTrue(subject.validate("aB").isValid)
        XCTAssertTrue(subject.validate("aBc").isValid)
        XCTAssertTrue(subject.validate("AbC").isValid)
        XCTAssertTrue(subject.validate("A123abc").isValid)
    }
}
