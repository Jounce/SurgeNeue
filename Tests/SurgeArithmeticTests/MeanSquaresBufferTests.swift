import XCTest

import SurgeArithmetic
import SurgeCore

final class MeanSquaresBufferTests: XCTestCase {
    func testFloatDestinationSizes() {
        checkDestinationSizes(ExternalMutatingUnary<Float>.meanSquares())
    }

    func testDoubleDestinationSizes() {
        checkDestinationSizes(ExternalMutatingUnary<Double>.meanSquares())
    }

    private func checkDestinationSizes<Scalar: BinaryFloatingPoint>(
        _ meanSquares: ExternalMutatingUnary<Scalar>
    ) {
        let input: [Scalar] = [-1, 1, -3, 3]
        for count in 0...2 {
            var storage: [Scalar] = [-7, -8]
            input.withUnsafeMemory { lhs in
                storage.withUnsafeMutableBufferPointer { buffer in
                    meanSquares.apply(lhs, into: .init(bufferPointer: buffer, count: count))
                }
            }
            let expected: [Scalar] = [count == 0 ? -7 : 5, -8]
            XCTAssertEqual(storage, expected, "Destination count \(count)")
        }
    }
}
