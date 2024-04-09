import SmartText
import XCTest

final class TextValidator_EmailTests: XCTestCase {
    private typealias Constants = TextValidator.Constant

    func test_spec() {
        let subject: TextValidator = .email()

        XCTAssertEqual(subject, .email())
        XCTAssertNotEqual(subject, .identity)

        for email in Constants.invalidEmails {
            XCTAssertEqual(subject.isTextValid(email), .invalid, email)

            let uppercasedEmail = email.uppercased()
            XCTAssertEqual(subject.isTextValid(uppercasedEmail), .invalid, email)

            let lowercasedEmail = email.lowercased()
            XCTAssertEqual(subject.isTextValid(lowercasedEmail), .invalid, email)
        }

        for email in Constants.validEmails {
            XCTAssertEqual(subject.isTextValid(email), .valid, email)

            let uppercasedEmail = email.uppercased()
            XCTAssertEqual(subject.isTextValid(uppercasedEmail), .valid, email)

            let lowercasedEmail = email.lowercased()
            XCTAssertEqual(subject.isTextValid(lowercasedEmail), .valid, email)
        }
    }
}
