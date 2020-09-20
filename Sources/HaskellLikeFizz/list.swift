import Foundation


/// struct like list
/// from class to struct by https://stackoverflow.com/a/40776684/10172299
public struct list<T>
{
   
    internal init(
        _ first: T,
        _ second: list?)
    {
        self.wrapper = Wrapper(first,second: second?.wrapper)
    }
   
    private var wrapper: Wrapper
}
// MARK: - internal
extension list {
    internal var first:T {
        wrapper.first
    }
    internal var second: list<T>? {
        guard let second = self.wrapper.second else {return nil}
        return list(second)
    }
}

// MARK: - extension for Protocol
extension list: ExpressibleByIntegerLiteral where T == Int
{
    public init(integerLiteral value: Int) {
        self.init(value, nil)
    }
}

extension list: Equatable where T: Equatable {
    public static func == (lhs: list, rhs: list) -> Bool
    {
        lhs.first == rhs.first && lhs.second == rhs.second
    }
}

// MARK: - FilePrivate
fileprivate extension list
{
    final class Wrapper
    {
        
        init(_ value: T, second:Wrapper?)
        {
            self.first = value
            self.second = second
        }
        
        let first:T
        let second:Wrapper?
    }
    
    init(_ wrapper: Wrapper)
    {
        self.wrapper = wrapper
    }
}
