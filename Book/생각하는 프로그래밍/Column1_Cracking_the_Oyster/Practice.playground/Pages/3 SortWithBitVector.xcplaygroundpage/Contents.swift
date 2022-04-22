//: [Previous](@previous)

class SortWithBitVector {
    
    let n: UInt32 = 10000000
    
    func execute() {
        let bitVector = BitVector(n: n)
        let range: Range<UInt32> = (0..<n)
        
        range.forEach {
            bitVector.clear(i: $0)
        }
        
        InputFile.readLines().compactMap(UInt32.init).forEach {
            bitVector.set(i: $0)
        }
        
        let outputText = range.map { bitVector.test(i: $0) }
            .map(String.init)
            .joined(separator: "\n")
        
        OutputFile.write(text: outputText)
    }
    
}

import XCTest

class SortWithBitVectorTests: XCTestCase {
    
    func testSort() {
        measure {
            SortWithBitVector().execute()
        }
    }
    
}

SortWithBitVectorTests.defaultTestSuite.run()


//: [Next](@next)
