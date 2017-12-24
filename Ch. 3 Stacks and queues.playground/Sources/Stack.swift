import Foundation

public protocol StackProtocol {

    associatedtype T: Comparable
    
    var isEmpty: Bool { get }
    
    func pop() -> T?
    func peek() -> T?
    func push(_ value: T)
    
    var asArray: [T] { get }
}

open class Stack<T: Comparable>: DoubleEndedQueue<T> {
    
    public override init(head: T? = nil) {
        super.init(head: head)
    }
    
    // MARK: - StackProtocol
    
    open override func pop() -> T? {
        return super.pop()
    }
    
    open override func peek() -> T? {
        return super.peek()
    }
    
    open override func push(_ value: T) {
        super.push(value)
    }
    
    open override var asArray: [T] {
        return super.asArray
    }
    
    // MARK: - Helpers
    
    public static func from(_ array: [T]) -> Stack<T> {
        let stack = Stack<T>()
        for item in array.reversed() {
            stack.push(item)
        }
        return stack
    }
}

extension Stack: Comparable {
    
    public static func ==(lhs: Stack<T>, rhs: Stack<T>) -> Bool {
        var currentA = lhs.head
        var currentB = lhs.head
        
        while currentA != nil || currentB != nil {
            if currentA?.value != currentB?.value { return false }
            currentA = currentA?.next
            currentB = currentB?.next
        }
        
        return true
    }
    
    // If there are stacks A and B with A[i] < B[i], A < B.
    // If A.count < B.count and all elements are equal until A.count, A < B.
    public static func <(lhs: Stack<T>, rhs: Stack<T>) -> Bool {
        var currentA = lhs.head
        var currentB = lhs.head
        
        while currentA != nil || currentB != nil {
            if let a = currentA?.value, let b = currentB?.value {
                if a < b { return true }
                if a > b { return false }
            } else if currentA == nil {
                return true
            } else if currentB == nil {
                return false
            }
            currentA = currentA?.next
            currentB = currentB?.next
        }
        return true
    }
}


