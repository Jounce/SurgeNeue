public struct MutatingUnary<Scalar> {
    public typealias LhsMemory = UnsafeMutableMemory<Scalar>

    public typealias Closure = (LhsMemory) -> ()

    @usableFromInline
    internal let closure: Closure

    @inlinable @inline(__always)
    public init(
        _ closure: @escaping Closure
    ) {
        self.closure = closure
    }

    @inlinable @inline(__always)
    public init(_ extracting: ExtractingUnary<Scalar>) {
        self.init { dst in
            let lhs = UnsafeMemory(dst)
            extracting.closure(lhs, dst)
        }
    }

    @inlinable @inline(__always)
    public func mutate(_ lhs: LhsMemory) {
        self.closure(lhs)
    }

    @inlinable @inline(__always)
    public func mutate<Lhs>(
        _ lhs: inout Lhs
    )
    where
        Lhs: UnsafeMutableMemoryAccessible,
        Lhs.Element == Scalar
    {
        lhs.withUnsafeMutableMemory { lhs in
            self.mutate(lhs)
        }
    }
}
