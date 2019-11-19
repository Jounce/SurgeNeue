// Copyright © 2014-2019 the Surge contributors
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

/// Protocol for collections that can be accessed via `UnsafeMemory`
public protocol UnsafeMemoryAccessible: Collection {
    @inlinable
    func withUnsafeMemory<Result>(
        _ body: (UnsafeMemory<Element>) throws -> Result
    ) rethrows -> Result
}

/// Memory region.
public struct UnsafeMemory<Element>: Collection {
    public typealias Index = Int

    @inlinable @inline(__always)
    public var startIndex: Int {
        return 0
    }

    @inlinable @inline(__always)
    public var endIndex: Int {
        return self.count
    }

    /// Pointer to the first element
    public var pointer: UnsafePointer<Element>

    /// Pointer stride between elements
    public var stride: Int

    /// Number of elements
    public var count: Int

    /// Max number of elements
    public var capacity: Int

    @inlinable
    public init(
        _ mutable: UnsafeMutableMemory<Element>
    ) {
        self.pointer = UnsafePointer(mutable.pointer)
        self.count = mutable.count
        self.capacity = mutable.capacity
        self.stride = mutable.stride
    }

    @inlinable
    public init(
        pointer: UnsafePointer<Element>,
        count: Int,
        capacity: Int? = nil,
        stride: Int = 1
    ) {
        self.pointer = pointer
        self.count = count
        self.capacity = capacity ?? count
        self.stride = stride
    }

    @inlinable
    public init(
        bufferPointer: UnsafeBufferPointer<Element>,
        count: Int? = nil,
        capacity: Int? = nil,
        stride: Int = 1
    ) {
        self.pointer = bufferPointer.baseAddress!
        self.count = count ?? bufferPointer.count
        self.capacity = capacity ?? bufferPointer.count
        self.stride = stride
    }

    @inlinable @inline(__always)
    public func index(after index: Int) -> Int {
        return index + 1
    }

    @inlinable @inline(__always)
    public subscript(position: Int) -> Element {
        return self.pointer[position]
    }

    @inlinable
    public func withMemoryRebound<T, Result>(
        to type: T.Type,
        _ body: (UnsafeMemory<T>) throws -> Result
    ) rethrows -> Result {
        try self.pointer.withMemoryRebound(to: T.self, capacity: self.capacity) { pointer in
            try body(UnsafeMemory<T>(
                pointer: pointer,
                count: self.count,
                capacity: self.capacity,
                stride: self.stride
            ))
        }
    }
}
