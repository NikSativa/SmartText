import SmartText
import XCTest

final class TextValidator_NumbersOnlyTests: XCTestCase {
    func test_spec() throws {
        let subject: TextValidator = .numbersOnly()

        XCTAssertTrue(subject.validate("").isValid)
        XCTAssertTrue(subject.validate("123").isValid)

        try run_validation_test(subject, "cba123", sub: ["cba"])
        try run_validation_test(subject, "123abcd", sub: ["abcd"])
    }
}
