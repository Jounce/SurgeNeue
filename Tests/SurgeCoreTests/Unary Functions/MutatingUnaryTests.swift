import XCTest

@testable import SurgeCore

final class MutatingUnaryTests: XCTestCase {
    func test__init() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = lhs

        let mutating = MutatingUnary<Scalar> { lhs in
            for index in 0..<lhs.count {
                lhs[index] *= 2.0
            }
        }

        mutating.mutate(&actual)

        let expected: Lhs = lhs.map { $0 * 2 }

        XCTAssertEqual(actual, expected)
    }

    func test__init_extracting() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = lhs

        let extracting = ExtractingUnary<Scalar> { lhs, dst in
            for index in 0..<lhs.count {
                dst[index] = lhs[index] * 2.0
            }
        }

        let mutating = MutatingUnary(extracting)

        mutating.mutate(&actual)

        let expected: Lhs = lhs.map { $0 * 2.0 }

        XCTAssertEqual(actual, expected)
    }

    static var allTests = [
        ("test__init", test__init),
        ("test__init_extracting", test__init_extracting),
    ]
}
