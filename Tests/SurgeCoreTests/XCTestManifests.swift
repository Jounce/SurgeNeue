import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UnsafeMutableMemoryTests.allTests),
        testCase(UnsafeMemoryTests.allTests),
        testCase(UnsafeMutableBufferPointerTests.allTests),
        testCase(ArraySliceTests.allTests),
        testCase(ContiguousArrayTests.allTests),
        testCase(ArrayTests.allTests),
        testCase(UnsafeBufferPointerTests.allTests),
    ]
}
#endif
