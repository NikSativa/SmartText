import SmartText
import SpryKit
import XCTest

final class TextFormatter_EmailTests: XCTestCase {
    let subject: TextFormatter = .email

    func test_validEmails() {
        let expected: [String] = Emails.validEmails.map {
            return subject.format($0)
        }
        XCTAssertEqual(Emails.validEmails, expected)
    }

    func test_emails_remove_restricted_symbols() {
        let expected = Emails.validEmails.map {
            let modifiedEmail = "  \n  " + $0.replacingOccurrences(of: "@", with: "!*@@()") + "  \n  "
            return subject.format(modifiedEmail)
        }
        XCTAssertEqual(Emails.validEmails, expected)
    }

    func test_emails_uppercased() {
        let expected = Emails.validEmails.map {
            let modifiedEmail = $0.uppercased()
            return subject.format(modifiedEmail)
        }

        let actual = Emails.validEmails.map { $0.uppercased() }
        XCTAssertEqual(actual, expected)
    }

    func test_emails() throws {
        try run_formating_test(0, sub: "plainaddress")
        try run_formating_test(1, sub: "@.com")
        try run_formating_test(2, sub: "@example.com")
        try run_formating_test(3, sub: "JoeSmithemail@example.com")
        try run_formating_test(4, sub: "email.example.com")
        try run_formating_test(5, sub: "email@exampleexample.com")
        try run_formating_test(6, sub: ".email@example.com")
        try run_formating_test(7, sub: "email@example.com")
        try run_formating_test(8, sub: "email.email@example.com")
        try run_formating_test(9, sub: "@example.com")
        try run_formating_test(10, sub: "email@example.comJoeSmith")
        try run_formating_test(11, sub: "email@example")
        try run_formating_test(12, sub: "email@-example.com")
        try run_formating_test(13, sub: "email@111.222.333.44444")
        try run_formating_test(14, sub: "Abc.b.123@example.com")
        try run_formating_test(15, sub: "email@example.com")
        try run_formating_test(16, sub: "email@example-.com")
        try run_formating_test(17, sub: "email@com")
        try run_formating_test(18, sub: "email@")
        try run_formating_test(19, sub: "email@")
        try run_formating_test(20, sub: "email@")
        try run_formating_test(21, sub: "tomCat@1blabla.com")
        try run_formating_test(22, sub: "tomCat@1blabla.com")
        try run_formating_test(23, sub: "+tomCat@1blabla.com")
        try run_formating_test(24, sub: "t+omCat@1blabla.com")
        try run_formating_test(25, sub: "tomCat@blabla.com")
        try run_formating_test(26, sub: "tomCat@blabla.com")

        XCTAssertEqual(Emails.invalidEmails.count, 27)
    }

    private func run_formating_test(_ idx: Int,
                                    sub expected: String,
                                    file: StaticString = #filePath,
                                    line: UInt = #line) throws {
        try run_formating_test(.email, Emails.invalidEmails[idx], expected: expected, file: file, line: line)
    }
}
