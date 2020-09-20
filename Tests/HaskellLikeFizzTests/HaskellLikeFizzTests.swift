import XCTest
import HaskellLikeFizz

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
