import Foundation

public protocol QueueProtocol {
    
    associatedtype T: Comparable
    
    var isEmpty: Bool { get }
    
    func add(_ value: T)
    func remove() -> T?
    func peek() -> T?
    
    var asArray: [T] { get }
}

public class Queue<T: Comparable>: DoubleEndedQueue<T> {
    
    public override init(head: T? = nil) {
        super.init(head: head)
    }
    
    // MARK: - QueueProtocol
        
    public func add(_ value: T) {
        super.append(value)
    }
    
    public func remove() -> T? {
        return super.pop()
    }
    
    public override func peek() -> T? {
        return super.peek()
    }
    
    public override var asArray: [T] {
        return super.asArray
    }
    
    // MARK: - Helpers
    
    public static func from(_ array: [T]) -> Queue<T> {
        let queue = Queue<T>()
        for item in array {
            queue.add(item)
        }
        return queue
    }
}
