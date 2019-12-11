import XCTest

@testable import SurgeCore

final class ExternalUnaryTests: XCTestCase {
    func test__init() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Out = ContiguousArray<Scalar>

        let lhs: Lhs = (0..<10).map { Scalar($0) }

        let external = ExternalUnary<Scalar> { lhs, dst in
            for i in 0..<lhs.count {
                dst[i] = lhs[i] * 2.0
            }
        }

        let actual = external.apply(lhs, as: Out.self)

        let expected: Out = .init(lhs.map { $0 * 2.0 })

        XCTAssertEqual(actual, expected)
    }

    func test__init_externalMutating() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Out = ContiguousArray<Scalar>

        let lhs: Lhs = (0..<10).map { Scalar($0) }

        let externalMutating = ExternalMutatingUnary<Scalar> { lhs, dst in
            for i in 0..<lhs.count {
                dst[i] = lhs[i] * 2.0
            }
        }

        let external = ExternalUnary<Scalar>(externalMutating: externalMutating)

        let actual = external.apply(lhs, as: Out.self)

        let expected: Out = .init(lhs.map { $0 * 2.0 })

        XCTAssertEqual(actual, expected)
    }

    static var allTests = [
        ("test__init", test__init),
        ("test__init_externalMutating", test__init_externalMutating),
    ]
}
