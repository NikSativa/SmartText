import SmartText
import SpryKit
import XCTest

final class TextFormatter_NumbersOnlyTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .numbersOnly

        XCTAssertEqual(subject, .numbersOnly)
        XCTAssertNotEqual(subject, .identity)

        XCTAssertEqual(subject.formatText("123ABV34"), "12334")
        XCTAssertEqual(subject.formatText("vc123ABV34"), "12334")
        XCTAssertEqual(subject.formatText("vc123ABV34\\2"), "123342")
    }
}
