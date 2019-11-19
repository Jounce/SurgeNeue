public enum UnsafeGeneric {
    public struct ExternalMutatingUnary {
        public typealias FloatImpl = SurgeCore.ExternalMutatingUnary<Float>
        public typealias DoubleImpl = SurgeCore.ExternalMutatingUnary<Double>

        public let float: FloatImpl
        public let double: DoubleImpl

        public init(float: FloatImpl, double: DoubleImpl) {
            self.float = float
            self.double = double
        }
    }

    public struct ExternalUnary {
        public typealias FloatImpl = SurgeCore.ExternalMutatingUnary<Float>
        public typealias DoubleImpl = SurgeCore.ExternalMutatingUnary<Double>

        public let float: FloatImpl
        public let double: DoubleImpl

        public init(float: FloatImpl, double: DoubleImpl) {
            self.float = float
            self.double = double
        }
    }

    public struct InternalMutatingUnary {
        public typealias FloatImpl = SurgeCore.InternalMutatingUnary<Float>
        public typealias DoubleImpl = SurgeCore.InternalMutatingUnary<Double>

        public let float: FloatImpl
        public let double: DoubleImpl

        public init(float: FloatImpl, double: DoubleImpl) {
            self.float = float
            self.double = double
        }
    }

    public struct InternalUnary {
        public typealias FloatImpl = SurgeCore.InternalMutatingUnary<Float>
        public typealias DoubleImpl = SurgeCore.InternalMutatingUnary<Double>

        public let float: FloatImpl
        public let double: DoubleImpl

        public init(float: FloatImpl, double: DoubleImpl) {
            self.float = float
            self.double = double
        }
    }
}

@inlinable @inline(__always)
public func unsafeGeneric<Scalar>(
    _ unsafe: UnsafeGeneric.ExternalMutatingUnary
) -> ExternalMutatingUnary<Scalar>
where
    Scalar: SurgeFloatingPoint
{
    precondition((Scalar.self == Float.self) || (Scalar.self == Double.self))

    return .init { genericLhs, genericDst in
        switch Scalar.self {
        case is Float.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMemory<Float>.self)
            let dst = unsafeBitCast(genericDst, to: UnsafeMutableMemory<Float>.self)
            return unsafe.float.apply(lhs, into: dst)
        case is Double.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMemory<Double>.self)
            let dst = unsafeBitCast(genericDst, to: UnsafeMutableMemory<Double>.self)
            return unsafe.double.apply(lhs, into: dst)
        case _:
            let typeName = String(describing: Scalar.self)
            fatalError("Expected `Float` or `Double`, found \(typeName)")
        }
    }
}

@inlinable @inline(__always)
public func unsafeGeneric<Scalar>(
    _ unsafe: UnsafeGeneric.ExternalUnary
) -> ExternalUnary<Scalar>
where
    Scalar: SurgeFloatingPoint
{
    precondition((Scalar.self == Float.self) || (Scalar.self == Double.self))

    return .init(mutating: .init { genericLhs, genericDst in
        switch Scalar.self {
        case is Float.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMemory<Float>.self)
            let dst = unsafeBitCast(genericDst, to: UnsafeMutableMemory<Float>.self)
            return unsafe.float.apply(lhs, into: dst)
        case is Double.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMemory<Double>.self)
            let dst = unsafeBitCast(genericDst, to: UnsafeMutableMemory<Double>.self)
            return unsafe.double.apply(lhs, into: dst)
        case _:
            let typeName = String(describing: Scalar.self)
            fatalError("Expected `Float` or `Double`, found \(typeName)")
        }
    })
}

@inlinable @inline(__always)
public func unsafeGeneric<Scalar>(
    _ unsafe: UnsafeGeneric.InternalMutatingUnary
) -> InternalMutatingUnary<Scalar>
where
    Scalar: SurgeFloatingPoint
{
    precondition((Scalar.self == Float.self) || (Scalar.self == Double.self))

    return .init { genericLhs in
        switch Scalar.self {
        case is Float.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMutableMemory<Float>.self)
            return unsafe.float.apply(lhs)
        case is Double.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMutableMemory<Double>.self)
            return unsafe.double.apply(lhs)
        case _:
            let typeName = String(describing: Scalar.self)
            fatalError("Expected `Float` or `Double`, found \(typeName)")
        }
    }
}

@inlinable @inline(__always)
public func unsafeGeneric<Scalar>(
    _ unsafe: UnsafeGeneric.InternalUnary
) -> InternalUnary<Scalar>
where
    Scalar: SurgeFloatingPoint
{
    precondition((Scalar.self == Float.self) || (Scalar.self == Double.self))

    return .init(mutating: .init { genericLhs in
        switch Scalar.self {
        case is Float.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMutableMemory<Float>.self)
            return unsafe.float.apply(lhs)
        case is Double.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMutableMemory<Double>.self)
            return unsafe.double.apply(lhs)
        case _:
            let typeName = String(describing: Scalar.self)
            fatalError("Expected `Float` or `Double`, found \(typeName)")
        }
    })
}
