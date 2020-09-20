import XCTest
@testable import HaskellLikeFizz

final class HaskellLikeFizzTests: XCTestCase {
    func testadd() {
        let result = HaskellAdd(1)(2)
        XCTAssertEqual(3, result)
    }
    func testPair() {
        XCTAssertEqual(fst(pair(10)(20)), 10)
        XCTAssertEqual(snd(pair(10)(20)), 20)
        XCTAssertEqual(fst(pair(10)(nil)), 10)
        XCTAssertEqual(snd(pair(10)(nil)), nil)
    }
    
    static var allTests = [
        ("testadd", testadd),
    ]
}

struct HaskellAdd {
    internal init(_ a: Int) {
        self.a = a
    }
    
    private let a:Int
    func callAsFunction(_ b: Int) -> Int {
        a + b
    }
}
func pair(_ first:Int) -> (Int?) -> list {
    return {
        list(first, $0)
    }
}
func fst(_ list: list) -> Int {
    list.first
}
func snd(_ list: list) -> Int? {
    list.second
}
struct list {
    internal init(
        _ first: Int,
        _ second: Int?) {
        self.first = first
        self.second = second
    }
    
    let first:Int
    let second:Int?
}


