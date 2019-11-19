import XCTest

@testable import SurgeCore

final class ExternalUnaryTests: XCTestCase {
    func test__init() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Out = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }

        let external = ExternalUnary<Scalar, Out> { lhs in
            lhs.map { $0 * 2.0 }
        }

        let actual = external.produce(lhs)

        let expected: Lhs = lhs.map { $0 * 2 }

        XCTAssertEqual(actual, expected)
    }

    func test__init_externalMutating() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Out = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }

        let externalMutating = ExternalMutatingUnary<Scalar> { lhs, dst in
            for index in 0..<lhs.count {
                dst[index] = lhs[index] * 2.0
            }
        }

        let external = ExternalUnary<Scalar, Out>(externalMutating)

        let actual = external.produce(lhs)

        let expected: Lhs = lhs.map { $0 * 2 }

        XCTAssertEqual(actual, expected)
    }

    func test__init_mutating() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Out = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }

        let internalMutating = InternalMutatingUnary<Scalar> { lhs in
            for index in 0..<lhs.count {
                lhs[index] *= 2.0
            }
        }

        let external = ExternalUnary<Scalar, Out>(internalMutating)

        let actual = external.produce(lhs)

        let expected: Lhs = lhs.map { $0 * 2 }

        XCTAssertEqual(actual, expected)
    }

    static var allTests = [
        ("test__init", test__init),
        ("test__init_externalMutating", test__init_externalMutating),
        ("test__init_mutating", test__init_mutating),
    ]
}
