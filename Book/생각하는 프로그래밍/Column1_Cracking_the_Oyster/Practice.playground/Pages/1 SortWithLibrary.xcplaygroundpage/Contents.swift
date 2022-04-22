import Foundation
import PlaygroundSupport

/*: 연습문제 1. 메모리가 충분하다면 집합(set)의 표현과 정렬을 위한 라이브러리를 이용하여 어떻게 정렬을 구현하겠는가?
*/
class SortWithLibrary {
    
    func solution() {
        let outputText = InputFile.readLines()
            .compactMap(Int.init)
            .sorted()
            .map(String.init)
            .joined(separator: "\n")
        
        OutputFile.write(text: outputText)
    }
        
}

import XCTest

class SortWithLibraryTests: XCTestCase {
    
    //  Test Case '-[__lldb_expr_9.MyTests testSort]' measured [Time, seconds] average: 2.840, relative standard deviation: 1.264%, values: [2.935805, 2.873546, 2.823807, 2.808163, 2.822844, 2.834610, 2.836129, 2.824337, 2.819522, 2.822635]
    func testSort() {
        measure {
            SortWithLibrary().solution()
        }
    }
    
}

SortWithLibraryTests.defaultTestSuite.run()

//: [Next](@next)
