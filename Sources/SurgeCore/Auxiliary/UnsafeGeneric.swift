public enum UnsafeGeneric {
    public struct ExtractingUnary {
        public typealias FloatImpl = SurgeCore.ExtractingUnary<Float>
        public typealias DoubleImpl = SurgeCore.ExtractingUnary<Double>

        public let float: FloatImpl
        public let double: DoubleImpl

        public init(float: FloatImpl, double: DoubleImpl) {
            self.float = float
            self.double = double
        }
    }

    public struct MutatingUnary {
        public typealias FloatImpl = SurgeCore.MutatingUnary<Float>
        public typealias DoubleImpl = SurgeCore.MutatingUnary<Double>

        public let float: FloatImpl
        public let double: DoubleImpl

        public init(float: FloatImpl, double: DoubleImpl) {
            self.float = float
            self.double = double
        }
    }

    public struct ProducingUnary {
        public typealias FloatImpl = SurgeCore.ExtractingUnary<Float>
        public typealias DoubleImpl = SurgeCore.ExtractingUnary<Double>

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
    _ unsafe: UnsafeGeneric.ExtractingUnary
) -> ExtractingUnary<Scalar>
where
    Scalar: SurgeFloatingPoint
{
    precondition((Scalar.self == Float.self) || (Scalar.self == Double.self))

    return .init { genericLhs, genericDst in
        switch Scalar.self {
        case is Float.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMemory<Float>.self)
            let dst = unsafeBitCast(genericDst, to: UnsafeMutableMemory<Float>.self)
            return unsafe.float.closure(lhs, dst)
        case is Double.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMemory<Double>.self)
            let dst = unsafeBitCast(genericDst, to: UnsafeMutableMemory<Double>.self)
            return unsafe.double.closure(lhs, dst)
        case _:
            let typeName = String(describing: Scalar.self)
            fatalError("Expected `Float` or `Double`, found \(typeName)")
        }
    }
}

@inlinable @inline(__always)
public func unsafeGeneric<Scalar>(
    _ unsafe: UnsafeGeneric.MutatingUnary
) -> MutatingUnary<Scalar>
where
    Scalar: SurgeFloatingPoint
{
    precondition((Scalar.self == Float.self) || (Scalar.self == Double.self))

    return .init { genericLhs in
        switch Scalar.self {
        case is Float.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMutableMemory<Float>.self)
            return unsafe.float.closure(lhs)
        case is Double.Type:
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMutableMemory<Double>.self)
            return unsafe.double.closure(lhs)
        case _:
            let typeName = String(describing: Scalar.self)
            fatalError("Expected `Float` or `Double`, found \(typeName)")
        }
    }
}

@inlinable @inline(__always)
public func unsafeGeneric<Scalar, Out>(
    _ unsafe: UnsafeGeneric.ExtractingUnary
) -> ProducingUnary<Scalar, Out>
where
    Scalar: SurgeFloatingPoint,
    Out: RangeReplaceableCollection & UnsafeMutableMemoryAccessible,
    Out.Element == Scalar
{
    precondition((Scalar.self == Float.self) || (Scalar.self == Double.self))

    return .init { genericLhs in
        switch Scalar.self {
        case is Float.Type:
            var out = Out(genericLhs)
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMemory<Float>.self)
            out.withUnsafeMutableMemory { genericOut in
                let out = unsafeBitCast(genericOut, to: UnsafeMutableMemory<Float>.self)
                unsafe.float.closure(lhs, out)
            }
            return out
        case is Double.Type:
            var out = Out(genericLhs)
            let lhs = unsafeBitCast(genericLhs, to: UnsafeMemory<Double>.self)
            out.withUnsafeMutableMemory { genericOut in
                let out = unsafeBitCast(genericOut, to: UnsafeMutableMemory<Double>.self)
                unsafe.double.closure(lhs, out)
            }
            return out
        case _:
            let typeName = String(describing: Scalar.self)
            fatalError("Expected `Float` or `Double`, found \(typeName)")
        }
    }
}
