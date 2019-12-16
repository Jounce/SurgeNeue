// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest

@testable import SurgeCore
@testable import SurgeArithmetic

final class MeanSquaresTests: XCTestCase {
    // MARK: - ExternalMutatingUnary

    func testExternalMutatingUnaryDouble() {
        typealias Function = MeanSquares
        typealias Fixture = MeanSquaresTest
        typealias Scalar = Double
        typealias Input = Array<Scalar>
        typealias Output = ContiguousArray<Scalar>

        let function = Function.externalMutatingUnaryDouble
        let testFunction = Fixture.externalMutatingUnaryDoubleTest

        let input: Input = Fixture.lhs()

        var actual: Output = Fixture.dst()
        input.apply(into: &actual, mutating: .init(function))

        var expected: Output = Fixture.dst()
        input.apply(into: &expected, mutating: .init(testFunction))

        XCTAssertEqual(actual, expected)
    }

    func testExternalMutatingUnaryFloat() {
        typealias Function = MeanSquares
        typealias Fixture = MeanSquaresTest
        typealias Scalar = Float
        typealias Input = Array<Scalar>
        typealias Output = ContiguousArray<Scalar>

        let function = Function.externalMutatingUnaryFloat
        let testFunction = Fixture.externalMutatingUnaryFloatTest

        let input: Input = Fixture.lhs()

        var actual: Output = Fixture.dst()
        input.apply(into: &actual, mutating: .init(function))

        var expected: Output = Fixture.dst()
        input.apply(into: &expected, mutating: .init(testFunction))

        XCTAssertEqual(actual, expected)
    }
}
