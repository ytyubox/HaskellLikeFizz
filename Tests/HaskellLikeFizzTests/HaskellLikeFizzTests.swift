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
        XCTAssertEqual(list2array(map({$0.description})(range(1)(10))), (1...10).map{$0.description})
    }
    func test_fizzbuzz() {
        XCTAssertEqual(fizzbuzz(1), "1")
        
        XCTAssertEqual(fizzbuzz(3), "fizz")
        XCTAssertEqual(fizzbuzz(5), "buzz")
        XCTAssertEqual(fizzbuzz(15), "fizzbuzz")
        let result = list2array(map(fizzbuzz(_:))(range(1)(20)))
        let expect = [
            "1", "2", "fizz", "4", "buzz",
            "fizz", "7","8", "fizz","buzz",
            "11", "fizz", "13", "14", "fizzbuzz",
            "16", "17", "fizz", "19", "buzz"
        ]
        XCTAssertEqual(result, expect)
    }
    static var allTests = [
        ("testadd", testadd),
        ("test_pair_head_tail",test_pair_head_tail),
        ("test_list2array",test_list2array),
        ("test_array2list",test_array2list),
    ]
}

struct HaskellAdd
{
    internal init(_ a: Int)
    {
        self.a = a
    }
    
    private let a:Int
    func callAsFunction(_ b: Int) -> Int
    {
        a + b
    }
}

func pair<T>(_ first:T) -> (list<T>?) -> list<T>
{
    { [first] in
        list(first,
             $0)
    }
}

func range(_ low: Int) -> (Int) -> list<Int>?
{
    {
        [low] (high: Int)  in
        low > high
            ? nil
            : pair(low)(range(low+1)(high))
    }
}
func head<T>(_ list: list<T>) -> T
{
    list.first
}
func tail<T>(_ list: list<T>?) -> list<T>?
{
    list?.second
}
func map<T,U>(_ f:@escaping (T)->U) -> ((list<T>?) -> (list<U>?))
{
    {  [f] (xs:list?) -> list<U>? in
        xs == nil
            ? nil
            : pair(f(head(xs!)))(map(f)(tail(xs)))
    }
}

/// struct like list
/// from class to struct by https://stackoverflow.com/a/40776684/10172299
struct list<T:Equatable>: Equatable {
    private final class Wrapper {
        let first:T
        let second:Wrapper?
        
        init(_ value: T, second:Wrapper?) {
            self.first = value
            self.second = second
            
        }
    }
    
    static func == (lhs: list, rhs: list) -> Bool {
        lhs.first == rhs.first && lhs.second == rhs.second
    }
    
    internal init(
        _ first: T,
        _ second: list?) {
        self.wrapper = Wrapper(first,second: second?.wrapper)
    }
    private init(
        _ wrapper: Wrapper) {
        self.wrapper = wrapper
    }
    private var wrapper: Wrapper
    var first:T {
        wrapper.first
    }
    var second: list<T>? {
        guard let second = self.wrapper.second else {return nil}
        return list(second)
    }
}
extension list: ExpressibleByIntegerLiteral where T == Int{
    init(integerLiteral value: Int) {
        self.init(value, nil)
    }
    
}

func list2array<T>(_ xs:list<T>?) -> [T] {
    var xs = xs
    var result = [T]()
    while xs != nil {
        result.append(head(xs!))
        xs = tail(xs)
    }
    return result
}

func array2list<T>(_ list: [T]) -> list<T>? {
    var result:list<T>? = nil
    for i in list.reversed() {
        result = pair(i)(result)
    }
    return result
}

func fizzbuzz(_ n: Int) -> String? {
    ifEmpty((n.isMultiple(of: 3) ? "fizz" : "")
              +
              (n.isMultiple(of: 5) ? "buzz": ""))(
        n.description)
}

func ifEmpty<T:Collection>(_ c: T) -> (T.Element...) -> [T.Element] {
    { [c] in
        c.isEmpty ? Array(c) : $0
    }
}

func ifEmpty(_ c: String) -> (String) -> String {
    { [c] in
        c.isEmpty ? $0 : c
        
    }
}
