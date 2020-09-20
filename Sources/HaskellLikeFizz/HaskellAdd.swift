import Foundation

public struct HaskellAdd
{
    public init(_ a: Int)
    {
        self.a = a
    }
    
    private let a:Int
    public func callAsFunction(_ b: Int) -> Int
    {
        a + b
    }
}
