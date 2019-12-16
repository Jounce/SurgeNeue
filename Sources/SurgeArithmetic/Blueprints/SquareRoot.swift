import Accelerate

import SurgeCore

@usableFromInline
struct SquareRoot {}

extension SquareRoot: SurgeBlueprint {}

extension SquareRoot: SurgeExternalMutatingUnaryBlueprint {}

// sourcery:derive: ExternalMutatingUnary, ExternalUnary
// sourcery:derive: InternalMutatingUnary, InternalUnary
extension SquareRoot: ExternalMutatingUnaryFloatBlueprint {
    @usableFromInline
    typealias ExternalMutatingUnaryFloatTest = SquareRootTest

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

        var count: Int32 = numericCast(dst.count)
        vvsqrtf(dst.pointer, lhs.pointer, &count)
    }
}

extension SquareRoot: ExternalMutatingUnaryDoubleBlueprint {
    @usableFromInline
    typealias ExternalMutatingUnaryDoubleTest = SquareRootTest

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

        var count: Int32 = numericCast(dst.count)
        vvsqrt(dst.pointer, lhs.pointer, &count)
    }
}

@usableFromInline
struct SquareRootTest {
    static let count: Int = 10

    @usableFromInline
    typealias LhsTest<Scalar> = Array<Scalar>

    @usableFromInline
    typealias DstTest<Scalar> = ContiguousArray<Scalar>

    @usableFromInline
    static func lhs<Scalar>() -> LhsTest<Scalar>
    where
        Scalar: FloatingPoint
    {
        (0..<self.count).map { Scalar($0) }
    }

    @usableFromInline
    static func dst<Scalar>() -> DstTest<Scalar>
    where
        Scalar: ExpressibleByFloatLiteral
    {
        .init(repeating: 0.0, count: self.count)
    }

    @usableFromInline
    static func externalMutatingUnaryTest<Scalar>(_ lhs: Lhs<Scalar>, into dst: Dst<Scalar>)
    where
        Scalar: FloatingPoint
    {
        for i in 0..<lhs.count {
            dst[i] = lhs[i].squareRoot()
        }
    }
}

extension SquareRootTest: ExternalMutatingUnaryFloatTestBlueprint {
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
        externalMutatingUnaryTest(lhs, into: dst)
    }
}

extension SquareRootTest: ExternalMutatingUnaryDoubleTestBlueprint {
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
        externalMutatingUnaryTest(lhs, into: dst)
    }
}
