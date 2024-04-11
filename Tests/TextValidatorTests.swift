import SmartText
import SpryKit
import XCTest

final class TextValidatorTests: XCTestCase {
    private enum Constant {
        static let sharedName = "TextValidator_shared_behavior"
        static let sharedValidatorsKey = "validatables"
        static let sharedError1Key = "errorText1"
        static let sharedError2Key = "errorText2"
    }

    private struct TestValidator: TextValidatable {
        let uniqueID: String
        let errorText: String? = nil

        init(uniqueID: String) {
            self.uniqueID = uniqueID
        }

        func isValid(string: String) -> Bool {
            return uniqueID != string
        }
    }

    private func applyTest(subject: TextValidator, _ validatables: [TextValidatable], file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(subject, TextValidator(validatables), file: file, line: line)
        XCTAssertEqual(subject, TextValidator(validatables.reversed()), file: file, line: line)

        XCTAssertNotEqual(subject, .identity, file: file, line: line)
        XCTAssertNotEqual(subject, .notEmpty() + .identity, file: file, line: line)
        XCTAssertNotEqual(subject, .identity + .notEmpty(), file: file, line: line)

        XCTAssertEqual(subject.isTextValid("1"), .invalid, file: file, line: line)
        XCTAssertEqual(subject.isTextValid("2"), validatables.count >= 2 ? .invalid : .valid, file: file, line: line)
        XCTAssertEqual(subject.isTextValid("12"), .valid, file: file, line: line)
    }

    func test_spec() {
        let subject: TextValidator = .email() + .includesLowerAndUppercase()
        XCTAssertEqual(subject, .email() + .includesLowerAndUppercase())
        XCTAssertEqual(subject, .includesLowerAndUppercase() + .email())

        XCTAssertNotEqual(subject, .email() + .identity)
        XCTAssertNotEqual(subject, .includesLowerAndUppercase() + .identity)
        XCTAssertNotEqual(subject, .email())
        XCTAssertNotEqual(subject, .identity)

        let mock1 = TestValidator(uniqueID: "1")
        let mock2 = TestValidator(uniqueID: "2")

        let mockV1 = TextValidator(mock1)
        let mockV2 = TextValidator(mock2)

        applyTest(subject: .init(arrayLiteral: mockV1, mockV2), [mock1, mock2])
        applyTest(subject: [mockV1, mockV2], [mock1, mock2])
        applyTest(subject: .init([mock1, mock2]), [mock1, mock2])
        applyTest(subject: .init(mock1), [mock1])
        applyTest(subject: .init(validators: [TextValidator(mock1), TextValidator(mock2)]), [mock1, mock2])
        applyTest(subject: TextValidator(mock1) + TextValidator(mock2), [mock1, mock2])
        applyTest(subject: TextValidator(mock1) + mock2, [mock1, mock2])
        applyTest(subject: mock1 + TextValidator(mock2), [mock1, mock2])
        applyTest(subject: mock1 + TextValidator(mock2) + mock1, [mock1, mock2])
        applyTest(subject: TextValidator(mock2) + mock1 + mock2, [mock1, mock2])
        applyTest(subject: mock1 + [mockV2, mockV1], [mock1, mock2])
        applyTest(subject: TextValidator(mock2) + [mockV1, mockV2], [mock1, mock2])
    }
}
