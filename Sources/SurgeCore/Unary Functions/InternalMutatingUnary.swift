public struct InternalMutatingUnary<Scalar> {
    public typealias LhsMemory = UnsafeMutableMemory<Scalar>

    public typealias Closure = (LhsMemory) -> ()

    @usableFromInline
    internal let closure: Closure

    @inlinable @inline(__always)
    public init(externalMutating: ExternalMutatingUnary<Scalar>) {
        self.init { dst in
            externalMutating.apply(UnsafeMemory(dst), into: dst)
        }
    }

    @inlinable @inline(__always)
    public init(
        _ closure: @escaping ExternalMutatingUnary<Scalar>.Closure
    ) {
        self.init(externalMutating: .init(closure))
    }

    @inlinable @inline(__always)
    public init(
        _ closure: @escaping Closure
    ) {
        self.closure = closure
    }

    @inlinable @inline(__always)
    public func apply(_ lhs: LhsMemory) {
        self.closure(lhs)
    }

    @inlinable @inline(__always)
    public func apply<Lhs>(
        _ lhs: inout Lhs
    )
    where
        Lhs: UnsafeMutableMemoryAccessible,
        Lhs.Element == Scalar
    {
        lhs.withUnsafeMutableMemory { lhs in
            self.apply(lhs)
        }
    }
}

extension UnsafeMutableMemoryAccessible {
    @inlinable @inline(__always)
    public mutating func apply(
        mutating: InternalMutatingUnary<Element>
    ) {
        mutating.apply(&self)
    }
}
