import SmartText
import XCTest

final class TextValidator_MaxLengthLimitedTests: XCTestCase {
    let subject: TextValidator = .maxLengthLimited(4)

    func test_spec() throws {
        XCTAssertEqual(subject.validate(""), .valid)
        XCTAssertEqual(subject.validate("1"), .valid)
        XCTAssertEqual(subject.validate("12"), .valid)
        XCTAssertEqual(subject.validate("123"), .valid)
        XCTAssertEqual(subject.validate("1234"), .valid)

        try run_validation_test(subject, "12345", sub: ["5"])
        try run_validation_test(subject, "123456", sub: ["56"])
    }
}
