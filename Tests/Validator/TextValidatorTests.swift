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

        func validate(_ value: String) -> TextValidationResult {
            return uniqueID != value ? .valid : .invalid
        }
    }

    private func applyTest(subject: TextValidator, isValid: Bool, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(subject.validate("1").isInvalid, file: file, line: line)
        XCTAssertTrue(subject.validate("2").isValid == isValid, file: file, line: line)
        XCTAssertTrue(subject.validate("12").isValid, file: file, line: line)
    }

    func test_spec() {
        let mock1: TextValidatable = TestValidator(uniqueID: "1")
        let mock2: TextValidatable = TestValidator(uniqueID: "2")

        let mockV1: TextValidator = mock1.toValidator()
        let mockV2: TextValidator = mock2.toValidator()

        applyTest(subject: .init(arrayLiteral: mockV1, mockV2), isValid: false)
        applyTest(subject: [mockV1, mockV2], isValid: false)
        applyTest(subject: .init([mock1, mock2]), isValid: false)
        applyTest(subject: .init(mock1), isValid: true)
        applyTest(subject: .init(validators: [TextValidator(mock1), TextValidator(mock2)]), isValid: false)
        applyTest(subject: TextValidator(mock1) + TextValidator(mock2), isValid: false)
        applyTest(subject: TextValidator(mock1) + mock2, isValid: false)
        applyTest(subject: mock1 + TextValidator(mock2), isValid: false)
    }
}
