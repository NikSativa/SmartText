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

        func format(_ value: String) -> String {
            return uniqueID == value ? "uniqueID_" + value : value
        }
    }

    private func applyTest(subject: TextFormatter, _ formatables: [TextFormatable], file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(subject.format("1"), "uniqueID_1", file: file, line: line)
        XCTAssertEqual(subject.format("2"), formatables.count >= 2 ? "uniqueID_2" : "2", file: file, line: line)
        XCTAssertEqual(subject.format("12"), "12", file: file, line: line)
    }

    func test_spec() {
        let mock1: TextFormatable = TestFormatter(uniqueID: "1")
        let mock2: TextFormatable = TestFormatter(uniqueID: "2")

        let mockV1: TextFormatter = mock1.toFormatter()
        let mockV2: TextFormatter = mock2.toFormatter()
        applyTest(subject: .init(arrayLiteral: mockV1, mockV2), [mock1, mock2])
        applyTest(subject: [mockV1, mockV2], [mock1, mock2])
        applyTest(subject: .init([mock1, mock2]), [mock1, mock2])
        applyTest(subject: .init(mock1), [mock1])
        applyTest(subject: .init(formatters: [TextFormatter(mock1), TextFormatter(mock2)]), [mock1, mock2])
        applyTest(subject: TextFormatter(mock1) + TextFormatter(mock2), [mock1, mock2])
        applyTest(subject: TextFormatter(mock1) + mock2, [mock1, mock2])
        applyTest(subject: mock1 + TextFormatter(mock2) + mock1, [mock1, mock2])
        applyTest(subject: TextFormatter(mock2) + mock1 + mock2, [mock1, mock2])
        applyTest(subject: mock1 + [mockV2, mockV1], [mock1, mock2])
        applyTest(subject: TextFormatter(mock2) + [mockV1, mockV2], [mock1, mock2])
    }
}
