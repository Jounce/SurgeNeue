import XCTest

@testable import SurgeCore

final class UnsafeMemoryTests: XCTestCase {
    func test__init_pointer_count_capacity_stride() {
        let values: Array<Int> = [0, 1, 2, 3]

        let count: Int = values.count
        let capacity: Int = values.count
        let stride: Int = 1

        values.withUnsafeBufferPointer { bufferPointer in
            let pointer = bufferPointer.baseAddress!

            let memory = UnsafeMemory(
                pointer: pointer,
                count: count,
                capacity: capacity,
                stride: stride
            )

            XCTAssertEqual(memory.pointer, pointer)
            XCTAssertEqual(memory.count, count)
            XCTAssertEqual(memory.capacity, capacity)
            XCTAssertEqual(memory.stride, stride)

            for (index, value) in memory.enumerated() {
                XCTAssertEqual(value, index)
            }
        }
    }

    func test__init_pointer_count() {
        let values: Array<Int> = [0, 1, 2, 3]

        let count: Int = values.count
        let capacity: Int = values.count
        let stride: Int = 1

        values.withUnsafeBufferPointer { bufferPointer in
            let pointer = bufferPointer.baseAddress!

            let memory = UnsafeMemory(
                pointer: pointer,
                count: count
            )

            XCTAssertEqual(memory.pointer, pointer)
            XCTAssertEqual(memory.count, count)
            XCTAssertEqual(memory.capacity, capacity)
            XCTAssertEqual(memory.stride, stride)

            for (index, value) in memory.enumerated() {
                XCTAssertEqual(value, index)
            }
        }
    }

    func test__init_bufferPointer_count_capacity_stride() {
        let values: Array<Int> = [0, 1, 2, 3]

        let count: Int = values.count
        let capacity: Int = values.count
        let stride: Int = 1

        values.withUnsafeBufferPointer { bufferPointer in
            let pointer = bufferPointer.baseAddress!

            let memory = UnsafeMemory(
                bufferPointer: bufferPointer,
                count: count,
                capacity: capacity,
                stride: stride
            )

            XCTAssertEqual(memory.pointer, pointer)
            XCTAssertEqual(memory.count, count)
            XCTAssertEqual(memory.capacity, capacity)
            XCTAssertEqual(memory.stride, stride)

            for (index, value) in memory.enumerated() {
                XCTAssertEqual(value, index)
            }
        }
    }

    func test__init_bufferPointer() {
        let values: Array<Int> = [0, 1, 2, 3]

        let count: Int = values.count
        let capacity: Int = values.count
        let stride: Int = 1

        values.withUnsafeBufferPointer { bufferPointer in
            let pointer = bufferPointer.baseAddress!

            let memory = UnsafeMemory(
                bufferPointer: bufferPointer
            )

            XCTAssertEqual(memory.pointer, pointer)
            XCTAssertEqual(memory.count, count)
            XCTAssertEqual(memory.capacity, capacity)
            XCTAssertEqual(memory.stride, stride)

            for (index, value) in memory.enumerated() {
                XCTAssertEqual(value, index)
            }
        }
    }

    func test__withMemoryRebound() {
        let values: [UInt8] = Array((UInt8.min)..<(UInt8.max))
        let reboundValues: [Int8] = values.map {
            Int8(bitPattern: $0)
        }

        values.withUnsafeBufferPointer { bufferPointer in
            let memory = UnsafeMemory(
                bufferPointer: bufferPointer
            )

            memory.withMemoryRebound(to: Int8.self) { memory in
                for (actual, expected) in zip(memory, reboundValues) {
                    XCTAssertEqual(actual, expected)
                }
            }
        }
    }

    static var allTests = [
        ("test__init_pointer_count_capacity_stride", test__init_pointer_count_capacity_stride),
        ("test__init_pointer_count", test__init_pointer_count),
        ("test__init_bufferPointer_count_capacity_stride", test__init_bufferPointer_count_capacity_stride),
        ("test__init_bufferPointer", test__init_bufferPointer),
        ("test__withMemoryRebound", test__withMemoryRebound),
    ]
}
