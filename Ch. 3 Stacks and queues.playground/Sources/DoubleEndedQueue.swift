import Foundation

// Because of different fancy requirements in the problems,
// I had to make access to Node and DoubleEndedQueue pretty wide open.
// If I just used these classes to subclass default implementations
// of a Stack and a Queue, this wouldn't be necessary.

public class Node<T: Comparable> {
    public var value: T
    public var next: Node<T>?
    
    public init(value: T) {
        self.value = value
    }
}

extension Node: Comparable {
    
    public static func ==(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value && lhs.next == rhs.next
    }
    
    public static func <(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value < rhs.value
    }
}

/// A double-ended queue that serves as a parent for Stack and Queue data structures.
/// Items within the queue are organized in a linked list from `head` to `tail`,
/// popping is performed from `head`, new items are pushed to `head` and appended to `tail`.
open class DoubleEndedQueue<T: Comparable> {
    
    // MARK: - State
    
    private(set) public var head: Node<T>?
    private var tail: Node<T>?
    
    // MARK: - Initialization
    
    init(head: T? = nil) {
        if let head = head {
            self.head = Node<T>(value: head)
            self.tail = self.head
        }
    }
    
    // MARK: - Interface
    
    open var isEmpty: Bool {
        return head == nil
    }
    
    open var count: Int {
        var current = head
        var result = 0
        while current != nil {
            result += 1
            current = current?.next
        }
        return result
    }
    
    func pop() -> T? {
        guard let head = head else { return nil }
        self.head = head.next
        if self.head == nil {
            tail = nil
        }
        return head.value
    }
    
    func peek() -> T? {
        return head?.value
    }
    
    func push(_ value: T) {
        let node = Node(value: value)
        node.next = head
        head = node
    }
    
    func append(_ value: T) {
        let node = Node(value: value)
        if head == nil {
            head = node
            tail = node
        } else {
            tail?.next = node
            tail = node
        }
    }
    
    /// Array representation of this queue, with the first element of the array being the head of the queue.
    var asArray: [T] {
        var array = [T]()
        
        var current = head
        
        while current != nil {
            array.append(current!.value)
            current = current?.next
        }
        
        return array
    }
}

extension DoubleEndedQueue: CustomStringConvertible {
    
    public var description: String {
        guard head != nil else { return "empty" }
        var result = ""
        var current = head
        while current != nil {
            let suffix = current?.next != nil ? "," : ""
            result += "\(current!.value)\(suffix)"
            current = current?.next
        }
        return result
    }
}
