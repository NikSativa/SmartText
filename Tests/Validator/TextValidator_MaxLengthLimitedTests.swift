import SmartText
import XCTest

final class TextValidator_MaxLengthLimitedTests: XCTestCase {
    let subject: TextValidator = .maxLengthLimited(4)

    func test_spec() throws {
        XCTAssertTrue(subject.validate("").isValid)
        XCTAssertTrue(subject.validate("1").isValid)
        XCTAssertTrue(subject.validate("12").isValid)
        XCTAssertTrue(subject.validate("123").isValid)
        XCTAssertTrue(subject.validate("1234").isValid)

        try run_validation_test(subject, "12345", sub: ["5"])
        try run_validation_test(subject, "123456", sub: ["56"])
    }
}
