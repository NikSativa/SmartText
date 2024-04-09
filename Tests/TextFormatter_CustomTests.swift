import SmartText
import SpryKit
import XCTest

final class TextFormatter_CustomTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .custom {
            return $0 == "0" ? $0 + "_end" : "start_" + $0
        }

        XCTAssertEqual(subject, .custom { $0 })
        XCTAssertNotEqual(subject, .identity)

        XCTAssertEqual(subject.formatText("0"), "0_end")
        XCTAssertEqual(subject.formatText("1"), "start_1")
        XCTAssertEqual(subject.formatText("1asd"), "start_1asd")
    }
}
