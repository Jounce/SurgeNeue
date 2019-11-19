import Accelerate

import SurgeCore

// MARK: - Producing

extension ProducingUnary
where
    Scalar == Float,
    Out: RangeReplaceableCollection & UnsafeMutableMemoryAccessible
{
    @inlinable @inline(__always)
    public static func squareRoot() -> ProducingUnary {
        typealias Base = ExtractingUnary<Scalar>
        return .init(Base.squareRoot())
    }
}

extension ProducingUnary
where
    Scalar == Double,
    Out: RangeReplaceableCollection & UnsafeMutableMemoryAccessible
{
    @inlinable @inline(__always)
    public static func squareRoot() -> ProducingUnary {
        typealias Base = ExtractingUnary<Scalar>
        return .init(Base.squareRoot())
    }
}

// MARK: - Mutating

extension MutatingUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func squareRoot() -> MutatingUnary {
        typealias Base = ExtractingUnary<Scalar>
        return .init(Base.squareRoot())
    }
}

extension MutatingUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func squareRoot() -> MutatingUnary {
        typealias Base = ExtractingUnary<Scalar>
        return .init(Base.squareRoot())
    }
}

// MARK: - Extracting

extension ExtractingUnary
where
    Scalar == Float
{
    @inlinable
    public static func squareRoot() -> ExtractingUnary {
        .init { lhs, dst in
            assert(
                lhs.stride == 1 && dst.stride == 1,
                "sqrt doesn't support step values other than 1"
            )

            assert(
                lhs.count >= dst.count,
                "destination doesn't have enough capacity to store the results"
            )

            var count: Int32 = numericCast(dst.count)
            vvsqrtf(dst.pointer, lhs.pointer, &count)
        }
    }
}

extension ExtractingUnary
where
    Scalar == Double
{
    @inlinable
    public static func squareRoot() -> ExtractingUnary {
        .init { lhs, dst in
            assert(
                lhs.stride == 1 && dst.stride == 1,
                "sqrt doesn't support step values other than 1"
            )

            assert(
                lhs.count >= dst.count,
                "destination doesn't have enough capacity to store the results"
            )

            var count: Int32 = numericCast(dst.count)
            vvsqrt(dst.pointer, lhs.pointer, &count)
        }
    }
}

extension UnsafeGeneric.ExtractingUnary {
    @inlinable @inline(__always)
    public static func squareRoot() -> UnsafeGeneric.ExtractingUnary {
        .init(float: .squareRoot(), double: .squareRoot())
    }
}

extension UnsafeGeneric.MutatingUnary {
    @inlinable @inline(__always)
    public static func squareRoot() -> UnsafeGeneric.MutatingUnary {
        .init(float: .squareRoot(), double: .squareRoot())
    }
}

extension UnsafeGeneric.ProducingUnary {
    @inlinable @inline(__always)
    public static func squareRoot() -> UnsafeGeneric.ProducingUnary {
        .init(float: .squareRoot(), double: .squareRoot())
    }
}
