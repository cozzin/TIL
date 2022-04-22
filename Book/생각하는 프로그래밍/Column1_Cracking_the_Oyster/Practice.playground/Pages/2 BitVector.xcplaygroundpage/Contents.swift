//: [Previous](@previous)

import Foundation

/*:
 연습문제 2. 비트벡터는 (and, or 또는 shift와 같은) 비트 연산을 이용해 어떻게 구현할 수 있는가?
 
 * 비트벡터: 중복되지 않는 정수 집합을 비트로 나타내는 방식
 
 */
class SwiftBitVector {
    
    let bitPerWord = 32

    let shift = 5

    let mask: UInt32 = 0x1F // 31

    let n = 10000000

    lazy var a: [UInt32] = Array(
        repeating: 0,
        count: 1 + Int(n / bitPerWord)
    )
    
    func set(i: UInt32) {
        print("======= i: \(i) =======")
        
        // 왜 5씩 오른쪽으로 shift 하는가? 2^5로 나누는 효과가 발생함!
        // By shifting i 5 bits to the right, you're simply dividing by 32.
        // https://stackoverflow.com/a/11400297
        //
        // x[0]: | 31 | 30 | . . . | 02 | 01 | 00 |
        // x[1]: | 63 | 62 | . . . | 34 | 33 | 32 |
        //         etc.
        //
        // 1 >> 5 를 하면 0. x[0] 으로 찾아갈 수 있음
        // 32 >> 5 를 하면 1. x[1] 으로 찾아갈 수 있음
        // 33 >> 5 를 하면 1. x[1] 으로 찾아갈 수 있음
        print("i >> shift: \(i >> shift)")
        
        // mask = 0x1F = 31 = 2진법 11111
        // i & mask 해주면
        // i % 32 한것과 같은 효과
        print("i & mask: \(i & mask)")
        
        // i % 32에 해당하는 값을 1로 지정
        print("1 << (i & mask): \(1 << (i & mask))")
        
        a[Int(i >> shift)] |= (1 << (i & mask))
        
        print("a[Int(i >> shift)] |= (1 << (i & mask)): \(String(a[Int(i >> shift)], radix: 2))")
    }
    
    func clear(i: UInt32) {
        // ~(1 << (i & mask)): 00100이 해당 값이라면 NOT을 씌워서 11011로 만들고
        // &로 AND를 해주면 0을 만나는 곳의 값은 반드시 0으로 됨
        a[Int(i >> shift)] &= ~(1 << (i & mask))
    }
    
    func test(i: UInt32) -> UInt32 {
        print("i & mask: \(i & mask)")
        
        return a[Int(i >> shift)] & (1 << (i & mask))
    }
}

let bitVector = SwiftBitVector()
    
bitVector.set(i: 0)
bitVector.set(i: 1)
bitVector.set(i: 2)
bitVector.set(i: 31)
bitVector.set(i: 32)

bitVector.clear(i: 31)

bitVector.test(i: 31)
bitVector.test(i: 32)
bitVector.test(i: 2)



//: [Next](@next)
