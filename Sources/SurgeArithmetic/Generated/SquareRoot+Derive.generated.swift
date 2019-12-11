// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SurgeCore

// MARK: - ExternalMutatingUnary

extension ExternalMutatingUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func squareRoot() -> ExternalMutatingUnary {
        return .init(SquareRoot.externalMutatingUnaryDouble)
    }
}

extension ExternalMutatingUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func squareRoot() -> ExternalMutatingUnary {
        return .init(SquareRoot.externalMutatingUnaryFloat)
    }
}

// MARK: - ExternalUnary

extension ExternalUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func squareRoot() -> ExternalUnary {
        return .init(SquareRoot.externalMutatingUnaryDouble)
    }
}

extension ExternalUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func squareRoot() -> ExternalUnary {
        return .init(SquareRoot.externalMutatingUnaryFloat)
    }
}

// MARK: - InternalMutatingUnary

extension InternalMutatingUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func squareRoot() -> InternalMutatingUnary {
        return .init(SquareRoot.externalMutatingUnaryDouble)
    }
}

extension InternalMutatingUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func squareRoot() -> InternalMutatingUnary {
        return .init(SquareRoot.externalMutatingUnaryFloat)
    }
}

// MARK: - InternalUnary

extension InternalUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func squareRoot() -> InternalUnary {
        return .init(SquareRoot.externalMutatingUnaryDouble)
    }
}

extension InternalUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func squareRoot() -> InternalUnary {
        return .init(SquareRoot.externalMutatingUnaryFloat)
    }
}
