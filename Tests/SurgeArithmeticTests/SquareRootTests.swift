import XCTest

@testable import SurgeCore
@testable import SurgeArithmetic

final class SquareRootTests: XCTestCase {
    // MARK: - External Mutating

    func test__externalMutating__float() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Dst = ContiguousArray<Scalar>

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = .init(repeating: 0.0, count: lhs.count)

        lhs.apply(into: &actual, mutating: .squareRoot())

        let expected: Dst = .init(lhs.map { sqrt($0) })

        XCTAssertEqual(actual, expected)
    }

    func test__externalMutating__double() {
        typealias Scalar = Double
        typealias Lhs = Array<Scalar>
        typealias Dst = ContiguousArray<Scalar>

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = .init(repeating: 0.0, count: lhs.count)

        lhs.apply(into: &actual, mutating: .squareRoot())

        let expected: Dst = .init(lhs.map { sqrt($0) })

        XCTAssertEqual(actual, expected)
    }

    func test__externalMutating__generic() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Dst = ContiguousArray<Scalar>

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = .init(repeating: 0.0, count: lhs.count)

        lhs.apply(into: &actual, mutating: unsafeGeneric(.squareRoot()))

        let expected: Dst = .init(lhs.map { sqrt($0) })

        XCTAssertEqual(actual, expected)
    }

    // MARK: - External

    func test__external__float() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Out = ContiguousArray<Scalar>

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        let actual: Out = lhs.apply(as: Out.self, .squareRoot())

        let expected: Out = .init(lhs.map { sqrt($0) })

        XCTAssertEqual(actual, expected)
    }

    func test__external__double() {
        typealias Scalar = Double
        typealias Lhs = Array<Scalar>
        typealias Out = ContiguousArray<Scalar>

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        let actual: Out = lhs.apply(as: Out.self, .squareRoot())

        let expected: Out = .init(lhs.map { sqrt($0) })

        XCTAssertEqual(actual, expected)
    }

    func test__external__generic() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Out = ContiguousArray<Scalar>

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        let actual: Out = lhs.apply(as: Out.self, .squareRoot())

        let expected: Out = .init(lhs.map { sqrt($0) })

        XCTAssertEqual(actual, expected)
    }

    // MARK: - Internal Mutating

    func test__internalMutating__float() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Dst = Lhs

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual = lhs

        actual.apply(mutating: .squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__internalMutating__double() {
        typealias Scalar = Double
        typealias Lhs = Array<Scalar>
        typealias Dst = Lhs

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual = lhs

        actual.apply(mutating: .squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__internalMutating__generic() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Dst = Lhs

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual = lhs

        actual.apply(mutating: unsafeGeneric(.squareRoot()))

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    // MARK: - Internal

    func test__internal__float() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Out = Lhs

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        let actual: Out = lhs.apply(.squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__internal__double() {
        typealias Scalar = Double
        typealias Lhs = Array<Scalar>
        typealias Out = Lhs

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        let actual: Out = lhs.apply(.squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__internal__generic() {
        typealias Scalar = Float
        typealias Lhs = Array<Scalar>
        typealias Out = Lhs

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        let actual: Out = lhs.apply(.squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    static var allTests = [
        ("test__externalMutating__float", test__externalMutating__float),
        ("test__externalMutating__double", test__externalMutating__double),
        ("test__externalMutating__generic", test__externalMutating__generic),

        ("test__external__float", test__external__float),
        ("test__external__double", test__external__double),
        ("test__external__generic", test__external__generic),

        ("test__internalMutating__float", test__internalMutating__float),
        ("test__internalMutating__double", test__internalMutating__double),
        ("test__internalMutating__generic", test__internalMutating__generic),

        ("test__internal__float", test__internal__float),
        ("test__internal__double", test__internal__double),
        ("test__internal__generic", test__internal__generic),
    ]
}
