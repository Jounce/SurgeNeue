import XCTest

@testable import SurgeCore

final class MutatingUnaryTests: XCTestCase {
    func test__init() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = lhs

        let internalMutating = InternalMutatingUnary<Scalar> { lhs in
            for index in 0..<lhs.count {
                lhs[index] *= 2.0
            }
        }

        internalMutating.mutate(&actual)

        let expected: Lhs = lhs.map { $0 * 2 }

        XCTAssertEqual(actual, expected)
    }

    func test__init_externalMutating() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = lhs

        let externalMutating = ExternalMutatingUnary<Scalar> { lhs, dst in
            for index in 0..<lhs.count {
                dst[index] = lhs[index] * 2.0
            }
        }

        let internalMutating = InternalMutatingUnary(externalMutating)

        internalMutating.mutate(&actual)

        let expected: Lhs = lhs.map { $0 * 2.0 }

        XCTAssertEqual(actual, expected)
    }

    static var allTests = [
        ("test__init", test__init),
        ("test__init_externalMutating", test__init_externalMutating),
    ]
}
