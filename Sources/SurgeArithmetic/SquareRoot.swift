import Accelerate

import SurgeCore

// MARK: - Internal Mutating

extension InternalMutatingUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func squareRoot() -> InternalMutatingUnary {
        .init(externalMutating: .squareRoot())
    }
}

extension InternalMutatingUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func squareRoot() -> InternalMutatingUnary {
        .init(externalMutating: .squareRoot())
    }
}

// MARK: - Internal

extension InternalUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func squareRoot() -> InternalUnary {
        .init(mutating: .squareRoot())
    }
}

extension InternalUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func squareRoot() -> InternalUnary {
        .init(mutating: .squareRoot())
    }
}

// MARK: - External Mutating

extension ExternalMutatingUnary
where
    Scalar == Float
{
    @inlinable
    public static func squareRoot() -> ExternalMutatingUnary {
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

extension ExternalMutatingUnary
where
    Scalar == Double
{
    @inlinable
    public static func squareRoot() -> ExternalMutatingUnary {
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

// MARK: - External

extension ExternalUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func squareRoot() -> ExternalUnary {
        return .init(mutating: .squareRoot())
    }
}

extension ExternalUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func squareRoot() -> ExternalUnary {
        return .init(mutating: .squareRoot())
    }
}

// MARK: - Unsafe Generic

extension UnsafeGeneric.ExternalMutatingUnary {
    @inlinable @inline(__always)
    public static func squareRoot() -> UnsafeGeneric.ExternalMutatingUnary {
        .init(float: .squareRoot(), double: .squareRoot())
    }
}

extension UnsafeGeneric.ExternalUnary {
    @inlinable @inline(__always)
    public static func squareRoot() -> UnsafeGeneric.ExternalUnary {
        .init(float: .squareRoot(), double: .squareRoot())
    }
}

extension UnsafeGeneric.InternalMutatingUnary {
    @inlinable @inline(__always)
    public static func squareRoot() -> UnsafeGeneric.InternalMutatingUnary {
        .init(float: .squareRoot(), double: .squareRoot())
    }
}

extension UnsafeGeneric.InternalUnary {
    @inlinable @inline(__always)
    public static func squareRoot() -> UnsafeGeneric.InternalUnary {
        .init(float: .squareRoot(), double: .squareRoot())
    }
}
