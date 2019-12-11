public struct InternalUnary<Scalar> {
    public typealias LhsMemory = UnsafeMutableMemory<Scalar>
    public typealias InternalMutating = InternalMutatingUnary<Scalar>

    @usableFromInline
    internal let internalMutating: InternalMutating

    @inlinable @inline(__always)
    public init(
        _ closure: @escaping ExternalMutatingUnary<Scalar>.Closure
    ) {
        self.init(internalMutating: .init(closure))
    }

    @inlinable @inline(__always)
    public init(
        _ closure: @escaping InternalMutatingUnary<Scalar>.Closure
    ) {
        self.init(internalMutating: .init(closure))
    }

    @inlinable @inline(__always)
    public init(internalMutating: InternalMutating) {
        self.internalMutating = internalMutating
    }

    @inlinable @inline(__always)
    public func apply<Lhs>(
        _ lhs: Lhs
    ) -> Lhs
    where
        Lhs: UnsafeMutableMemoryAccessible,
        Lhs.Element == Scalar
    {
        var out = lhs
        self.internalMutating.apply(&out)
        return out
    }
}

extension UnsafeMutableMemoryAccessible {
    @inlinable @inline(__always)
    public func apply(
        _ nonMutating: InternalUnary<Element>
    ) -> Self {
        nonMutating.apply(self)
    }
}
