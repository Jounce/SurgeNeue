public struct ProducingUnary<Scalar, Out>
where
    Out: RangeReplaceableCollection & UnsafeMutableMemoryAccessible,
    Out.Element == Scalar
{
    public typealias LhsMemory = UnsafeMemory<Scalar>

    public typealias Closure = (LhsMemory) -> Out

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
        self.init { lhs in
            var out = Out(lhs)
            out.withUnsafeMutableMemory { out in
                extracting.closure(lhs, out)
            }
            return out
        }
    }

    @inlinable @inline(__always)
    public init(_ mutating: MutatingUnary<Scalar>) {
        self.init { lhs in
            var out = Out(lhs)
            out.withUnsafeMutableMemory { out in
                mutating.closure(out)
            }
            return out
        }
    }

    @inlinable @inline(__always)
    public func produce(_ lhs: LhsMemory) -> Out {
        self.closure(lhs)
    }

    @inlinable @inline(__always)
    public func produce<Lhs>(
        _ lhs: Lhs
    ) -> Out
    where
        Lhs: UnsafeMemoryAccessible,
        Lhs.Element == Scalar
    {
        lhs.withUnsafeMemory { lhs in
            self.produce(lhs)
        }
    }
}

extension UnsafeMemoryAccessible {
    @inlinable @inline(__always)
    public func produce<Out>(
        _ function: ProducingUnary<Element, Out>
    ) -> Out
    where
        Out: RangeReplaceableCollection & UnsafeMutableMemoryAccessible,
        Out.Element == Element
    {
        function.produce(self)
    }
}
