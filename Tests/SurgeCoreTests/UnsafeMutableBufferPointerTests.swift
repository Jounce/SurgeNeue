import XCTest

@testable import SurgeCore

final class UnsafeMutableBufferPointerTests: XCTestCase {
    func test__withUnsafeMemory() {
        var values: Array<Int> = [0, 1, 2, 3]

        let count: Int = values.count
        let capacity: Int = values.count
        let stride: Int = 1

        values.withUnsafeMutableBufferPointer { bufferPointer in
            let pointer = bufferPointer.baseAddress!

            bufferPointer.withUnsafeMemory { memory in
                XCTAssertEqual(memory.pointer, pointer)
                XCTAssertEqual(memory.count, count)
                XCTAssertEqual(memory.capacity, capacity)
                XCTAssertEqual(memory.stride, stride)

                for (index, value) in memory.enumerated() {
                    XCTAssertEqual(value, index)
                }
            }
        }
    }

    func test__withUnsafeMutableMemory() {
        var values: Array<Int> = [0, 1, 2, 3]

        let count: Int = values.count
        let capacity: Int = values.count
        let stride: Int = 1

        values.withUnsafeMutableBufferPointer { bufferPointer in
            let pointer = bufferPointer.baseAddress!

            bufferPointer.withUnsafeMutableMemory { memory in
                XCTAssertEqual(memory.pointer, pointer)
                XCTAssertEqual(memory.count, count)
                XCTAssertEqual(memory.capacity, capacity)
                XCTAssertEqual(memory.stride, stride)

                for (index, value) in memory.enumerated() {
                    XCTAssertEqual(value, index)
                }
            }
        }
    }

    static var allTests = [
        ("test__withUnsafeMemory", test__withUnsafeMemory),
        ("test__withUnsafeMutableMemory", test__withUnsafeMutableMemory),
    ]
}
