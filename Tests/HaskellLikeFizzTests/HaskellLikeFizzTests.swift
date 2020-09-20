import XCTest
@testable import HaskellLikeFizz

final class HaskellLikeFizzTests: XCTestCase {
    func testadd() {
        let result = HaskellAdd(1)(2)
        XCTAssertEqual(3, result)
    }
    func test_pair_head_tail() {
        XCTAssertEqual(head(pair(10)(20)), 10)
        XCTAssertEqual(tail(pair(10)(20)), pair(20)(nil))
        XCTAssertEqual(head(pair(10)(nil)), 10)
        XCTAssertEqual(tail(pair(10)(nil)), nil)
    }
    func test_list2array() {
        XCTAssertEqual(
            list2array(pair(3)(pair(2)(pair(1)(nil)))),
            [3,2,1]
        )
    }
    func test_array2list() {
        let expect = pair(1)(pair(2)(pair(3)(nil)))
        let result = array2list([1,2,3])
        XCTAssertEqual(expect, result)
    }
    func test_range() {
        let expect = (1...10).map{$0}
        let result = list2array(range(1)(10))
        XCTAssertEqual(expect, result)
    }
    func test_map() {
        XCTAssertEqual(list2array(map({$0 * $0})(range(1)(10))), (1...10).map{$0 * $0})
    }
    static var allTests = [
        ("testadd", testadd),
        ("test_pair_head_tail",test_pair_head_tail),
        ("test_list2array",test_list2array),
        ("test_array2list",test_array2list),
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

func pair(_ first:Int) -> (list?) -> list
{
    {
        list(first,
             $0)
    }
}

func range(_ low: Int) -> (Int) -> list? {
    { (high: Int)  in
        low > high
            ? nil
            : pair(low)(range(low+1)(high))
    }
}
func head(_ list: list) -> Int
{
    list.first
}
func tail(_ list: list?) -> list?
{
    list?.second
}
func map(_ f:@escaping (Int)->Int) -> ((list?) -> (list?))
{
    { (xs:list?) -> list? in
        xs == nil
            ? nil
            : pair(f(head(xs!)))(map(f)(tail(xs)))
    }
}
class list: Equatable, ExpressibleByIntegerLiteral {
    required init(integerLiteral value: Int) {
        self.first = value
        self.second = nil
    }
    
    
    static func == (lhs: list, rhs: list) -> Bool {
        lhs.first == rhs.first && lhs.second == rhs.second
    }
    
    internal init(
        _ first: Int,
        _ second: list?) {
        self.first = first
        self.second = second
    }
    
    let first:Int
    let second:list?
}


func list2array(_ xs:list?) -> [Int] {
    var xs = xs
    var result = [Int]()
    while xs != nil {
        result.append(head(xs!))
        xs = tail(xs)
    }
    return result
}

func array2list(_ list: [Int]) -> list? {
    var result:list? = nil
    for i in list.reversed() {
        result = pair(i)(result)
    }
    return result
}
