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
struct SquareRootTest {}

extension SquareRootTest: ExternalMutatingUnaryFloatTestBlueprint {
    @usableFromInline
    static func externalMutatingUnaryFloatTest(_ lhs: Lhs<Float>, into dst: Dst<Float>) {
        for i in 0..<lhs.count {
            dst[i] = lhs[i].squareRoot()
        }
    }
}

extension SquareRootTest: ExternalMutatingUnaryDoubleTestBlueprint {
    @usableFromInline
    static func externalMutatingUnaryDoubleTest(_ lhs: Lhs<Double>, into dst: Dst<Double>) {
        for i in 0..<lhs.count {
            dst[i] = lhs[i].squareRoot()
        }
    }
}
