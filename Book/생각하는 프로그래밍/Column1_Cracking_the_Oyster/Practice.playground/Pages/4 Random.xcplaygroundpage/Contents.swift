//: [Previous](@previous)

import Foundation

let totalCount = 10000 // n
let outputCount = 10 // k

// 0 ~ n-1 초기화
var values = Array(stride(from: 0, to: totalCount, by: 1))

func swapValue(_ positionA: Int, _ positionB: Int) {
    let aValue = values[positionA]
    let bValue = values[positionB]

    values[positionA] = bValue
    values[positionB] = aValue
}

(0..<outputCount).forEach {
    swapValue($0, .random(in: $0..<totalCount))
    print(values[$0])
}


//: [Next](@next)
