import SmartText
import SpryKit
import XCTest

final class TextFormatter_EmailTests: XCTestCase {
    func test_emails() {
        let subject: TextFormatter = .email

        var expected: [String] = Emails.validEmails.map {
            return subject.format($0)
        }
        XCTAssertEqual(Emails.validEmails, expected)

        expected = Emails.validEmails.map {
            let modifiedEmail = "  \n  " + $0.replacingOccurrences(of: "@", with: "!*@@()") + "  \n  "
            return subject.format(modifiedEmail)
        }
        XCTAssertEqual(Emails.validEmails, expected)

        expected = Emails.validEmails.map {
            let modifiedEmail = $0.uppercased()
            return subject.format(modifiedEmail)
        }

        let actual = Emails.validEmails.map { $0.uppercased() }
        XCTAssertEqual(actual, expected)
    }
}
