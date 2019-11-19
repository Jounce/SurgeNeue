public struct ExternalUnary<Scalar> {
    public typealias LhsMemory = UnsafeMemory<Scalar>
    public typealias Mutating = ExternalMutatingUnary<Scalar>
    public typealias Closure = Mutating.Closure

    @usableFromInline
    internal let mutating: Mutating

    @inlinable @inline(__always)
    public init(mutating: Mutating) {
        self.mutating = mutating
    }

    @inlinable @inline(__always)
    public func apply<Lhs, Out>(
        _ lhs: Lhs,
        as type: Out.Type
    ) -> Out
    where
        Lhs: UnsafeMemoryAccessible,
        Lhs.Element == Scalar,
        Out: RangeReplaceableCollection & UnsafeMutableMemoryAccessible,
        Out.Element == Scalar
    {
        var out = Out(lhs)
        self.mutating.apply(lhs, into: &out)
        return out
    }
}

extension UnsafeMemoryAccessible {
    @inlinable @inline(__always)
    public func apply<Out>(
        as type: Out.Type,
        _ nonMutating: ExternalUnary<Element>
    ) -> Out
    where
        Out: RangeReplaceableCollection & UnsafeMutableMemoryAccessible,
        Out.Element == Element
    {
        nonMutating.apply(self, as: type)
    }
}
