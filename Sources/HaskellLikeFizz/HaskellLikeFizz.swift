public func list2array<T>(_ xs:list<T>?) -> [T]
{
    var xs = xs
    var result = [T]()
    while xs != nil {
        result.append(head(xs!))
        xs = tail(xs)
    }
    return result
}

public func array2list<T>(_ list: [T]) -> list<T>?
{
    var result:list<T>? = nil
    for i in list.reversed()
    {
        result = pair(i)(result)
    }
    return result
}

public func fizzbuzz(_ n: Int) -> String?
{
    ifEmpty(
            (n.isMultiple(of: 3) ? "fizz" : "") +
            (n.isMultiple(of: 5) ? "buzz" : "")
    )(n.description)
}

func ifEmpty<T:Collection>(_ c: T) -> (T.Element...) -> [T.Element] {
    { [c] in
        c.isEmpty ? $0 : Array(c)
    }
}

func ifEmpty(_ c: String) -> (String) -> String {
    { [c] in
        c.isEmpty ? $0 : c
        
    }
}
