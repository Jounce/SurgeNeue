// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SurgeCore

// MARK: - ExternalMutatingUnary

extension ExternalMutatingUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func meanSquares() -> ExternalMutatingUnary {
        return .init(MeanSquares.externalMutatingUnaryDouble)
    }
}

extension ExternalMutatingUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func meanSquares() -> ExternalMutatingUnary {
        return .init(MeanSquares.externalMutatingUnaryFloat)
    }
}

// MARK: - ExternalUnary

extension ExternalUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func meanSquares() -> ExternalUnary {
        return .init(MeanSquares.externalMutatingUnaryDouble)
    }
}

extension ExternalUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func meanSquares() -> ExternalUnary {
        return .init(MeanSquares.externalMutatingUnaryFloat)
    }
}

// MARK: - InternalMutatingUnary

extension InternalMutatingUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func meanSquares() -> InternalMutatingUnary {
        return .init(MeanSquares.externalMutatingUnaryDouble)
    }
}

extension InternalMutatingUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func meanSquares() -> InternalMutatingUnary {
        return .init(MeanSquares.externalMutatingUnaryFloat)
    }
}

// MARK: - InternalUnary

extension InternalUnary
where
    Scalar == Double
{
    @inlinable @inline(__always)
    public static func meanSquares() -> InternalUnary {
        return .init(MeanSquares.externalMutatingUnaryDouble)
    }
}

extension InternalUnary
where
    Scalar == Float
{
    @inlinable @inline(__always)
    public static func meanSquares() -> InternalUnary {
        return .init(MeanSquares.externalMutatingUnaryFloat)
    }
}
