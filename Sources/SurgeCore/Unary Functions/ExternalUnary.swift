public struct ExternalUnary<Scalar> {
    public typealias LhsMemory = UnsafeMemory<Scalar>
    public typealias ExternalMutating = ExternalMutatingUnary<Scalar>

    @usableFromInline
    internal let externalMutating: ExternalMutating

    @inlinable @inline(__always)
    public init(
        _ closure: @escaping ExternalMutating.Closure
    ) {
        self.init(externalMutating: .init(closure)) 
    }

    @inlinable @inline(__always)
    public init(externalMutating: ExternalMutating) {
        self.externalMutating = externalMutating
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
        self.externalMutating.apply(lhs, into: &out)
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
