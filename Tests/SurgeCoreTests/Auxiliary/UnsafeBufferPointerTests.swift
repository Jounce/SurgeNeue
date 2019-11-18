import XCTest

@testable import SurgeCore

final class UnsafeBufferPointerTests: XCTestCase {
    func test__withUnsafeMemory() {
        let values: Array<Int> = [0, 1, 2, 3]

        let count: Int = values.count
        let capacity: Int = values.count
        let stride: Int = 1

        values.withUnsafeBufferPointer { bufferPointer in
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

    static var allTests = [
        ("test__withUnsafeMemory", test__withUnsafeMemory),
    ]
}
