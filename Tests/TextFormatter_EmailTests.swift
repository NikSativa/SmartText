import SmartText
import SpryKit
import XCTest

final class TextFormatter_EmailTests: XCTestCase {
    private typealias Constants = TextValidator.Constant

    func test_emails() {
        let subject: TextFormatter = .email

        XCTAssertEqual(subject, .email)
        XCTAssertNotEqual(subject, .identity)

        var expected: [String] = Constants.validEmails.map {
            return subject.formatText($0)
        }
        XCTAssertEqual(Constants.validEmails, expected)

        expected = Constants.validEmails.map {
            let modifiedEmail = "  \n  " + $0.replacingOccurrences(of: "@", with: "!*@@()") + "  \n  "
            return subject.formatText(modifiedEmail)
        }
        XCTAssertEqual(Constants.validEmails, expected)

        expected = Constants.validEmails.map {
            let modifiedEmail = $0.uppercased()
            return subject.formatText(modifiedEmail)
        }

        let actual = Constants.validEmails.map { $0.uppercased() }
        XCTAssertEqual(actual, expected)
    }
}
