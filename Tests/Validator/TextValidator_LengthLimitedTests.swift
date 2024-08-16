import SmartText
import XCTest

final class TextValidator_LengthLimitedTests: XCTestCase {
    func test_spec() throws {
        let subject: TextValidator = .lengthLimited(4, canBeEmpty: false)

        XCTAssertTrue(subject.validate("").isInvalid)
        XCTAssertTrue(subject.validate("1").isInvalid)
        XCTAssertTrue(subject.validate("12").isInvalid)
        XCTAssertTrue(subject.validate("123").isInvalid)
        XCTAssertTrue(subject.validate("1234").isValid)

        try run_validation_test(subject, "12345", sub: ["5"])
        try run_validation_test(subject, "123456", sub: ["56"])
    }

    func test_spec_canBeEmpty() throws {
        let subject: TextValidator = .lengthLimited(4, canBeEmpty: true)

        XCTAssertTrue(subject.validate("").isValid)
        XCTAssertTrue(subject.validate("1").isInvalid)
        XCTAssertTrue(subject.validate("12").isInvalid)
        XCTAssertTrue(subject.validate("123").isInvalid)
        XCTAssertTrue(subject.validate("1234").isValid)

        try run_validation_test(subject, "12345", sub: ["5"])
        try run_validation_test(subject, "123456", sub: ["56"])
    }
}
