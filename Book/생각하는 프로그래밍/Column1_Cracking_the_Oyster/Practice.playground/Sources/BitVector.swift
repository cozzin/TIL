import Foundation

public class BitVector {
    
    let bitPerWord: UInt32 = 32

    let shift = 5

    let mask: UInt32 = 0x1F // 31

    let n: UInt32

    lazy var a: [UInt32] = Array(
        repeating: 0,
        count: 1 + Int(n / bitPerWord)
    )
    
    public init(n: UInt32) {
        self.n = n
    }
    
    public func set(i: UInt32) {
        a[Int(i >> shift)] |= (1 << (i & mask))
    }
    
    public func clear(i: UInt32) {
        a[Int(i >> shift)] &= ~(1 << (i & mask))
    }
    
    public func test(i: UInt32) -> UInt32 {
        return a[Int(i >> shift)] & (1 << (i & mask))
    }
    
}
