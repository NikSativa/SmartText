import SmartText
import SpryKit
import XCTest

final class TextFormatter_NumbersOnlyTests: XCTestCase {
    func test_spec() {
        let subject: TextFormatter = .numbersOnly

        XCTAssertEqual(subject.format("123ABV34"), "12334")
        XCTAssertEqual(subject.format("vc123ABV34"), "12334")
        XCTAssertEqual(subject.format("vc123ABV34\\2"), "123342")
    }
}
