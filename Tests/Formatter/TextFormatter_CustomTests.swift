import SmartText
import SpryKit
import XCTest

final class TextFormatter_CustomTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .custom {
            return $0 == "0" ? $0 + "_end" : "start_" + $0
        }

        XCTAssertEqual(subject.format("0"), "0_end")
        XCTAssertEqual(subject.format("1"), "start_1")
        XCTAssertEqual(subject.format("1asd"), "start_1asd")
    }
}
