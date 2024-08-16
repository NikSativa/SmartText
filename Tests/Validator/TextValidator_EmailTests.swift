import SmartText
import XCTest

final class TextValidator_EmailTests: XCTestCase {
    func test_spec() {
        let subject: TextValidator = .email()

        for email in Emails.invalidEmails {
            XCTAssertEqual(subject.validate(email).map(\.isValid), [false], email)

            let uppercasedEmail = email.uppercased()
            XCTAssertEqual(subject.validate(uppercasedEmail).map(\.isValid), [false], email)

            let lowercasedEmail = email.lowercased()
            XCTAssertEqual(subject.validate(lowercasedEmail).map(\.isValid), [false], email)
        }

        for email in Emails.validEmails {
            XCTAssertTrue(subject.validate(email).isValid, email)

            let uppercasedEmail = email.uppercased()
            XCTAssertTrue(subject.validate(uppercasedEmail).isValid, email)

            let lowercasedEmail = email.lowercased()
            XCTAssertTrue(subject.validate(lowercasedEmail).isValid, email)
        }
    }

    func test_ranges() throws {
        try run_validation_test(.email(), "", sub: [])

        try run_validation_test(0, sub: [])
        try run_validation_test(1, sub: ["#", "%^%#$@#$@#"])
        try run_validation_test(2, sub: [])
        try run_validation_test(3, sub: [" ", " <", ">"])
        try run_validation_test(4, sub: [])
        try run_validation_test(5, sub: ["@"])
        try run_validation_test(6, sub: [])
        try run_validation_test(7, sub: [".@"])
        try run_validation_test(8, sub: [".."])
        try run_validation_test(9, sub: ["あいうえお"])
        try run_validation_test(10, sub: [" (", " ", ")"])
        try run_validation_test(11, sub: [])
        try run_validation_test(12, sub: ["@-"])
        try run_validation_test(13, sub: [])
        try run_validation_test(14, sub: ["..."])
        try run_validation_test(15, sub: [".."])
        try run_validation_test(16, sub: ["-."])
        try run_validation_test(17, sub: ["@."])
        try run_validation_test(18, sub: [".@."])
        try run_validation_test(19, sub: [".@"])
        try run_validation_test(20, sub: [])
        try run_validation_test(21, sub: ["@@"])
        try run_validation_test(22, sub: ["!", "@@"])
        try run_validation_test(23, sub: ["+", "@@"])
        try run_validation_test(24, sub: ["!+", "@@"])
        try run_validation_test(25, sub: [".."])
        try run_validation_test(26, sub: ["..."])

        XCTAssertEqual(Emails.invalidEmails.count, 27)
    }

    private func run_validation_test(_ idx: Int,
                                     sub: [String],
                                     file: StaticString = #filePath,
                                     line: UInt = #line) throws {
        try run_validation_test(.email(), Emails.invalidEmails[idx], sub: sub, file: file, line: line)
    }
}
