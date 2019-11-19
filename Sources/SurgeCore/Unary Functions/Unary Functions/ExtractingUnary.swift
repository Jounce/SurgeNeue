public struct ExtractingUnary<Scalar> {
    public typealias LhsMemory = UnsafeMemory<Scalar>
    public typealias DstMemory = UnsafeMutableMemory<Scalar>

    public typealias Closure = (LhsMemory, DstMemory) -> ()

    @usableFromInline
    internal let closure: Closure

    @inlinable @inline(__always)
    public init(
        _ closure: @escaping Closure
    ) {
        self.closure = closure
    }

    @inlinable @inline(__always)
    public func extract(
        _ lhs: LhsMemory,
        into dst: DstMemory
    ) {
        self.closure(lhs, dst)
    }

    @inlinable @inline(__always)
    public func extract<Lhs, Dst>(
        _ lhs: Lhs,
        into dst: inout Dst
    )
    where
        Lhs: UnsafeMemoryAccessible,
        Dst: UnsafeMutableMemoryAccessible,
        Lhs.Element == Scalar,
        Dst.Element == Scalar
    {
        lhs.withUnsafeMemory { lhs in
            dst.withUnsafeMutableMemory { dst in
                self.extract(lhs, into: dst)
            }
        }
    }
}
