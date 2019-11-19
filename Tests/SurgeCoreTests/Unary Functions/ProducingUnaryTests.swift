import XCTest

@testable import SurgeCore

final class ProducingUnaryTests: XCTestCase {
    func test__init() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Out = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }

        let producing = ProducingUnary<Scalar, Out> { lhs in
            lhs.map { $0 * 2.0 }
        }

        let actual = producing.produce(lhs)

        let expected: Lhs = lhs.map { $0 * 2 }

        XCTAssertEqual(actual, expected)
    }

    func test__init_extracting() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Out = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }

        let extracting = ExtractingUnary<Scalar> { lhs, dst in
            for index in 0..<lhs.count {
                dst[index] = lhs[index] * 2.0
            }
        }

        let producing = ProducingUnary<Scalar, Out>(extracting)

        let actual = producing.produce(lhs)

        let expected: Lhs = lhs.map { $0 * 2 }

        XCTAssertEqual(actual, expected)
    }

    func test__init_mutating() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Out = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }

        let mutating = MutatingUnary<Scalar> { lhs in
            for index in 0..<lhs.count {
                lhs[index] *= 2.0
            }
        }

        let producing = ProducingUnary<Scalar, Out>(mutating)

        let actual = producing.produce(lhs)

        let expected: Lhs = lhs.map { $0 * 2 }

        XCTAssertEqual(actual, expected)
    }

    static var allTests = [
        ("test__init", test__init),
        ("test__init_extracting", test__init_extracting),
        ("test__init_mutating", test__init_mutating),
    ]
}
