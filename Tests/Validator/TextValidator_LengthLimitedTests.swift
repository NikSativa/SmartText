import SmartText
import XCTest

final class TextValidator_LengthLimitedTests: XCTestCase {
    func test_spec() throws {
        let subject: TextValidator = .lengthLimited(4, canBeEmpty: false)

        XCTAssertEqual(subject.validate(""), .invalid)
        XCTAssertEqual(subject.validate("1"), .invalid)
        XCTAssertEqual(subject.validate("12"), .invalid)
        XCTAssertEqual(subject.validate("123"), .invalid)
        XCTAssertEqual(subject.validate("1234"), .valid)

        try run_validation_test(subject, "12345", sub: ["5"])
        try run_validation_test(subject, "123456", sub: ["56"])
    }

    func test_spec_canBeEmpty() throws {
        let subject: TextValidator = .lengthLimited(4, canBeEmpty: true)

        XCTAssertEqual(subject.validate(""), .valid)
        XCTAssertEqual(subject.validate("1"), .invalid)
        XCTAssertEqual(subject.validate("12"), .invalid)
        XCTAssertEqual(subject.validate("123"), .invalid)
        XCTAssertEqual(subject.validate("1234"), .valid)

        try run_validation_test(subject, "12345", sub: ["5"])
        try run_validation_test(subject, "123456", sub: ["56"])
    }
}
