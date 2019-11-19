import XCTest

@testable import SurgeCore
@testable import SurgeArithmetic

final class SquareRootTests: XCTestCase {
    func test__extract__float() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = Array(repeating: 0.0, count: lhs.count)

        lhs.extract(.squareRoot(), into: &actual)

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__extract__double() {
        typealias Scalar = Double
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = Array(repeating: 0.0, count: lhs.count)

        lhs.extract(.squareRoot(), into: &actual)

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__extract__generic() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = Array(repeating: 0.0, count: lhs.count)

        lhs.extract(unsafeGeneric(.squareRoot()), into: &actual)

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__mutate__float() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = lhs

        actual.mutate(.squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__mutate__double() {
        typealias Scalar = Double
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = lhs

        actual.mutate(.squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__mutate__generic() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Dst = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        var actual: Dst = lhs

        actual.mutate(unsafeGeneric(.squareRoot()))

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__produce__float() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Out = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        let actual: Out = lhs.produce(.squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__produce__double() {
        typealias Scalar = Double
        typealias Lhs = [Scalar]
        typealias Out = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        let actual: Out = lhs.produce(.squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    func test__produce__generic() {
        typealias Scalar = Float
        typealias Lhs = [Scalar]
        typealias Out = [Scalar]

        let lhs: Lhs = (0..<10).map { Scalar($0) }
        let actual: Out = lhs.produce(.squareRoot())

        let expected: Lhs = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected)
    }

    static var allTests = [
        ("test__extract__float", test__extract__float),
        ("test__extract__double", test__extract__double),
        ("test__extract__generic", test__extract__generic),

        ("test__mutate__float", test__mutate__float),
        ("test__mutate__double", test__mutate__double),
        ("test__mutate__generic", test__mutate__generic),

        ("test__produce__float", test__produce__float),
        ("test__produce__double", test__produce__double),
        ("test__produce__generic", test__produce__generic),
    ]
}
