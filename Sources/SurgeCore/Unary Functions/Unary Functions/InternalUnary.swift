public struct InternalUnary<Scalar> {
    public typealias LhsMemory = UnsafeMutableMemory<Scalar>
    public typealias Mutating = InternalMutatingUnary<Scalar>
    public typealias Closure = Mutating.Closure

    @usableFromInline
    internal let mutating: Mutating

    @inlinable @inline(__always)
    public init(mutating: Mutating) {
        self.mutating = mutating
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
        self.mutating.apply(&out)
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
