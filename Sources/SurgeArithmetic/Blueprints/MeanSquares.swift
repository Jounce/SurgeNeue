import Accelerate

import SurgeCore

@usableFromInline
struct MeanSquares {}

extension MeanSquares: SurgeBlueprint {}

extension MeanSquares: SurgeExternalMutatingUnaryBlueprint {}

// sourcery:derive: ExternalMutatingUnary, ExternalUnary
// sourcery:derive: InternalMutatingUnary, InternalUnary
extension MeanSquares: ExternalMutatingUnaryFloatBlueprint {
    @usableFromInline
    typealias ExternalMutatingUnaryFloatTest = MeanSquaresTest

    @usableFromInline
    static func externalMutatingUnaryFloat(_ lhs: Lhs<Float>, into dst: Dst<Float>) {
        assert(
            lhs.stride == 1 && dst.stride == 1,
            "sqrt doesn't support stride values other than 1"
        )

        assert(
            lhs.count >= dst.count,
            "destination doesn't have enough capacity to store the results"
        )

        let stride: vDSP_Stride = numericCast(lhs.stride)
        let count: vDSP_Length = numericCast(dst.count)
        vDSP_measqv(lhs.pointer, stride, dst.pointer, count)
    }
}

extension MeanSquares: ExternalMutatingUnaryDoubleBlueprint {
    @usableFromInline
    typealias ExternalMutatingUnaryDoubleTest = MeanSquaresTest

    @usableFromInline
    static func externalMutatingUnaryDouble(_ lhs: Lhs<Double>, into dst: Dst<Double>) {
        assert(
            lhs.stride == 1 && dst.stride == 1,
            "sqrt doesn't support stride values other than 1"
        )

        assert(
            lhs.count >= dst.count,
            "destination doesn't have enough capacity to store the results"
        )

        let stride: vDSP_Stride = numericCast(lhs.stride)
        let count: vDSP_Length = numericCast(dst.count)
        vDSP_measqvD(lhs.pointer, stride, dst.pointer, count)
    }
}

@usableFromInline
struct MeanSquaresTest {
    static let count: Int = 10

    @usableFromInline
    typealias LhsTest<Scalar> = Array<Scalar>

    @usableFromInline
    typealias DstTest<Scalar> = ContiguousArray<Scalar>

    static func lhs<Scalar>() -> LhsTest<Scalar>
    where
        Scalar: FloatingPoint
    {
        (0..<self.count).map { Scalar($0) }
    }

    static func dst<Scalar>() -> DstTest<Scalar>
    where
        Scalar: ExpressibleByFloatLiteral
    {
        .init(repeating: 0.0, count: self.count)
    }

    @usableFromInline
    static func externalMutatingUnaryTest<Scalar>(_ lhs: Lhs<Scalar>, into dst: Dst<Scalar>)
    where
        Scalar: FloatingPoint & ExpressibleByFloatLiteral
    {
        let weight = 1.0 / Scalar(lhs.count)
        dst.pointer.pointee = lhs.reduce(0.0) { $0 + (($1 * $1) * weight) }
    }
}

extension MeanSquaresTest: ExternalMutatingUnaryFloatTestBlueprint {
    @usableFromInline
    typealias LhsFloatTest = LhsTest<Float>

    @usableFromInline
    typealias DstFloatTest = DstTest<Float>

    @usableFromInline
    static func lhsFloat() -> LhsFloatTest {
        lhs()
    }

    @usableFromInline
    static func dstFloat() -> DstFloatTest {
        dst()
    }

    @usableFromInline
    static func externalMutatingUnaryFloatTest(_ lhs: Lhs<Float>, into dst: Dst<Float>) {
        let weight = 1.0 / Float(lhs.count)
        dst.pointer.pointee = lhs.reduce(0.0) { $0 + (($1 * $1) * weight) }
    }
}

extension MeanSquaresTest: ExternalMutatingUnaryDoubleTestBlueprint {
    @usableFromInline
    typealias LhsDoubleTest = LhsTest<Double>

    @usableFromInline
    typealias DstDoubleTest = DstTest<Double>

    @usableFromInline
    static func lhsDouble() -> LhsDoubleTest {
        lhs()
    }

    @usableFromInline
    static func dstDouble() -> DstDoubleTest {
        dst()
    }

    @usableFromInline
    static func externalMutatingUnaryDoubleTest(_ lhs: Lhs<Double>, into dst: Dst<Double>) {
        let weight = 1.0 / Double(lhs.count)
        dst.pointer.pointee = lhs.reduce(0.0) { $0 + (($1 * $1) * weight) }
    }
}
