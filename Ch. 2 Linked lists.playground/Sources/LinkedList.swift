import Foundation

public class SingleLinkedNode<T> {
    public var value: T
    public var next: SingleLinkedNode?
    
    public init(value: T) {
        self.value = value
    }
}

public struct SingleLinkedList<T: Hashable & Comparable> {
    
    public var head: SingleLinkedNode<T>?
    
    public init(head: SingleLinkedNode<T>? = nil) {
        self.head = head
    }
    
    public static func from(_ array: [T]) -> SingleLinkedList<T> {
        var result = SingleLinkedList<T>()
        
        guard !array.isEmpty else { return result }
        
        var current = SingleLinkedNode(value: array[0])
        result.head = current

        guard array.count > 1 else { return result }
        
        for i in (1..<array.count) {
            let node = SingleLinkedNode(value: array[i])
            current.next = node
            current = node
        }
        
        return result
    }
    
    public var asArray: [T] {
        var result = [T]()
        var current = head
        while current != nil {
            result.append(current!.value)
            current = current?.next
        }
        return result
    }
    
    mutating public func append(_ node: SingleLinkedNode<T>) {
        guard let head = head else {
            self.head = node
            return
        }
        
        var tail: SingleLinkedNode? = head
        while tail?.next != nil {
            tail = tail?.next
        }
        tail?.next = node
    }
    
    mutating public func append(_ element: T) {
        let newNode = SingleLinkedNode(value: element)
        append(newNode)
    }
    
    mutating public func delete(_ element: T) -> Bool {
        guard head?.value != element else {
            head = head?.next
            return true
        }
        
        var previous = head
        var current = head?.next
        while current != nil {
            if current?.value == element {
                previous?.next = current?.next
                return true
            }
            previous = current
            current = current?.next
        }
        return false
    }
    
    mutating public func reverse() {
        guard head != nil && head?.next != nil else { return }
        
        var previous = head
        var current = head?.next
        previous?.next = nil
        
        while current != nil {
            let next = current?.next
            current?.next = previous
            previous = current
            current = next
            if current == nil {
                head = previous
            }
        }
    }
}

extension SingleLinkedList: CustomStringConvertible {
    
    public var description: String {
        var result = ""
        var current = head
        while current != nil {
            let suffix = current?.next == nil ? "" : ","
            result += "\(current!.value)\(suffix)"
            current = current?.next
        }
        return result.isEmpty ? "empty list" : result
    }
}





