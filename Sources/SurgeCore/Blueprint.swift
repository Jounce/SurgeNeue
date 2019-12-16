public protocol SurgeBlueprint {}

public protocol SurgeExternalMutatingUnaryBlueprint: SurgeBlueprint {
    typealias Lhs<Scalar> = UnsafeMemory<Scalar>
    typealias Dst<Scalar> = UnsafeMutableMemory<Scalar>
}

public protocol ExternalMutatingUnaryGenericBlueprint: SurgeExternalMutatingUnaryBlueprint {
    associatedtype ExternalMutatingUnaryGenericTest: ExternalMutatingUnaryGenericTestBlueprint

    static func externalMutatingUnaryGeneric<Scalar>(_ lhs: Lhs<Scalar>, into dst: Dst<Scalar>)
    where
        Scalar: SurgeFloatingPoint
}

public protocol ExternalMutatingUnaryGenericTestBlueprint: SurgeExternalMutatingUnaryBlueprint {
    static func externalMutatingUnaryGenericTest<Scalar>(_ lhs: Lhs<Scalar>, into dst: Dst<Scalar>)
    where
        Scalar: SurgeFloatingPoint
}

extension ExternalMutatingUnaryGenericBlueprint
where
    Self: ExternalMutatingUnaryFloatBlueprint,
    Self: ExternalMutatingUnaryDoubleBlueprint
{
    @inlinable @inline(__always)
    public static func externalMutatingUnaryGeneric<Scalar>(_ lhs: Lhs<Scalar>, into dst: Dst<Scalar>)
    where
        Scalar: SurgeFloatingPoint
    {
        switch Scalar.self {
        case is Float.Type:
            let lhs = unsafeBitCast(lhs, to: UnsafeMemory<Float>.self)
            let dst = unsafeBitCast(dst, to: UnsafeMutableMemory<Float>.self)
            return self.externalMutatingUnaryFloat(lhs, into: dst)
        case is Double.Type:
            let lhs = unsafeBitCast(lhs, to: UnsafeMemory<Double>.self)
            let dst = unsafeBitCast(dst, to: UnsafeMutableMemory<Double>.self)
            return self.externalMutatingUnaryDouble(lhs, into: dst)
        case _:
            let typeName = String(describing: Scalar.self)
            fatalError("Expected `Float` or `Double`, found \(typeName)")
        }
    }
}

public protocol ExternalMutatingUnaryBlueprintTest: SurgeExternalMutatingUnaryBlueprint {

}

public protocol ExternalMutatingUnaryFloatBlueprint: SurgeExternalMutatingUnaryBlueprint {
    associatedtype ExternalMutatingUnaryFloatTest: ExternalMutatingUnaryFloatTestBlueprint

    static func externalMutatingUnaryFloat(_ lhs: Lhs<Float>, into dst: Dst<Float>)
}

public protocol ExternalMutatingUnaryFloatTestBlueprint: ExternalMutatingUnaryBlueprintTest {
    associatedtype LhsFloatTest
    associatedtype DstFloatTest

    static func lhsFloat() -> LhsFloatTest
    static func dstFloat() -> DstFloatTest

    static func externalMutatingUnaryFloatTest(_ lhs: Lhs<Float>, into dst: Dst<Float>)
}

public protocol ExternalMutatingUnaryDoubleBlueprint: SurgeExternalMutatingUnaryBlueprint {
    associatedtype ExternalMutatingUnaryDoubleTest: ExternalMutatingUnaryDoubleTestBlueprint

    static func externalMutatingUnaryDouble(_ lhs: Lhs<Double>, into dst: Dst<Double>)
}

public protocol ExternalMutatingUnaryDoubleTestBlueprint: ExternalMutatingUnaryBlueprintTest {
    associatedtype LhsDoubleTest
    associatedtype DstDoubleTest

    static func lhsDouble() -> LhsDoubleTest
    static func dstDouble() -> DstDoubleTest

    static func externalMutatingUnaryDoubleTest(_ lhs: Lhs<Double>, into dst: Dst<Double>)
}
