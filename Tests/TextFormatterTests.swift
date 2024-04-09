import SmartText
import SpryKit
import XCTest

final class TextFormatterTests: XCTestCase {
    private enum Constant {
        static let sharedName = "TestFormatter_shared_behavior"
        static let sharedKey = "formatables"
    }

    private struct TestFormatter: TextFormatable {
        let uniqueID: String
        init(uniqueID: String) {
            self.uniqueID = uniqueID
        }

        func formatText(_ string: String) -> String {
            return uniqueID == string ? "uniqueID_" + string : string
        }
    }

    private func applyTest(subject: TextFormatter, _ formatables: [TextFormatable], file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(subject, TextFormatter(formatables), file: file, line: line)
        XCTAssertEqual(subject, TextFormatter(formatables.reversed()), file: file, line: line)

        XCTAssertNotEqual(subject, .numbersOnly, file: file, line: line)
        XCTAssertNotEqual(subject, .numbersOnly + .identity, file: file, line: line)
        XCTAssertNotEqual(subject, .stripLeadingSpaces, file: file, line: line)
        XCTAssertNotEqual(subject, .stripLeadingSpaces + .email, file: file, line: line)

        XCTAssertEqual(subject.formatText("1"), "uniqueID_1", file: file, line: line)
        XCTAssertEqual(subject.formatText("2"), formatables.count >= 2 ? "uniqueID_2" : "2", file: file, line: line)
        XCTAssertEqual(subject.formatText("12"), "12", file: file, line: line)
    }

    func test_spec() {
        let subject: TextFormatter = .stripLeadingSpaces + .numbersOnly

        XCTAssertEqual(subject, .stripLeadingSpaces + .numbersOnly)
        XCTAssertEqual(subject, .numbersOnly + .stripLeadingSpaces)

        XCTAssertNotEqual(subject, .numbersOnly)
        XCTAssertNotEqual(subject, .numbersOnly + .identity)
        XCTAssertNotEqual(subject, .stripLeadingSpaces)
        XCTAssertNotEqual(subject, .stripLeadingSpaces + .email)

        let mock1: TextFormatable = TestFormatter(uniqueID: "1")
        let mock2: TextFormatable = TestFormatter(uniqueID: "2")
        applyTest(subject: .init(arrayLiteral: mock1, mock2), [mock1, mock2])
        applyTest(subject: [mock1, mock2], [mock1, mock2])
        applyTest(subject: .init([mock1, mock2]), [mock1, mock2])
        applyTest(subject: .init(mock1), [mock1])
        applyTest(subject: .init(formatters: [TextFormatter(mock1), TextFormatter(mock2)]), [mock1, mock2])
        applyTest(subject: TextFormatter(mock1) + TextFormatter(mock2), [mock1, mock2])
        applyTest(subject: TextFormatter(mock1) + mock2, [mock1, mock2])
        applyTest(subject: mock1 + TextFormatter(mock2) + mock1, [mock1, mock2])
        applyTest(subject: TextFormatter(mock2) + mock1 + mock2, [mock1, mock2])
        applyTest(subject: mock1 + [mock2, mock1], [mock1, mock2])
        applyTest(subject: TextFormatter(mock2) + [mock1, mock2], [mock1, mock2])
    }
}
