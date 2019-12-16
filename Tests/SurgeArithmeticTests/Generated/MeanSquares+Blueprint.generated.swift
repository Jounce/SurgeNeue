// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest

@testable import SurgeCore
@testable import SurgeArithmetic

final class MeanSquaresTests: XCTestCase {
    // MARK: - ExternalMutatingUnary

    func testExternalMutatingUnaryDouble() {
        typealias Scalar = Double
        typealias Input = Array<Scalar>
        typealias Output = ContiguousArray<Scalar>

        let function = MeanSquares.externalMutatingUnaryDouble
        let testFunction = MeanSquaresTest.externalMutatingUnaryDoubleTest

        let input: Input = (0..<10).map { Scalar($0) }

        var actual: Output = .init(repeating: 0.0, count: input.count)
        input.apply(into: &actual, mutating: .init(function))

        var expected: Output = .init(repeating: 0.0, count: input.count)
        input.apply(into: &expected, mutating: .init(testFunction))

        XCTAssertEqual(actual, expected)
    }

    func testExternalMutatingUnaryFloat() {
        typealias Scalar = Float
        typealias Input = Array<Scalar>
        typealias Output = ContiguousArray<Scalar>

        let function = MeanSquares.externalMutatingUnaryFloat
        let testFunction = MeanSquaresTest.externalMutatingUnaryFloatTest

        let input: Input = (0..<10).map { Scalar($0) }

        var actual: Output = .init(repeating: 0.0, count: input.count)
        input.apply(into: &actual, mutating: .init(function))

        var expected: Output = .init(repeating: 0.0, count: input.count)
        input.apply(into: &expected, mutating: .init(testFunction))

        XCTAssertEqual(actual, expected)
    }
}
