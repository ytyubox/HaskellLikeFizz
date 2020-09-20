//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/9/21.
//

import Foundation

public func pair<T>(_ first:T) -> (list<T>?) -> list<T>
{
    {
        [first] in
        list(first, $0)
    }
}

public func range(_ low: Int) -> (Int) -> list<Int>?
{
    {
        [low] (high: Int) in
        low > high
            ? nil
            : pair(low)(range(low+1)(high))
    }
}
public func head<T>(_ list: list<T>) -> T
{
    list.first
}
public func tail<T>(_ list: list<T>?) -> list<T>?
{
    list?.second
}
public func map<T,U>(_ f:@escaping (T)->U) -> ((list<T>?) -> (list<U>?))
{
    {
        [f] (xs:list?) -> list<U>? in
        xs == nil
            ? nil
            : pair(f(head(xs!)))(map(f)(tail(xs)))
    }
}
