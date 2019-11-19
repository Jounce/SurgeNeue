import XCTest

@testable import SurgeCore

final class ExtractingUnaryTests: XCTestCase {
    func test__init() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = Array(repeating: 0.0, count: lhs.count)

        let extracting = ExtractingUnary<Scalar> { lhs, dst in
            for index in 0..<lhs.count {
                dst.pointer[index] = lhs[index] * 2
            }
        }

        extracting.extract(lhs, into: &actual)

        let expected: Lhs = lhs.map { $0 * 2 }

        XCTAssertEqual(actual, expected)
    }

    static var allTests = [
        ("test__init", test__init),
    ]
}
