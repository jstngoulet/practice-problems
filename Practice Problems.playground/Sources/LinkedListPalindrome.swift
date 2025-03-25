import Foundation
import PlaygroundSupport

/**
 Using a linked list, determine if a word is a palindrome
 */
/**
final class Node<T>: NSObject {
    
    var data: T
    var nextNode: Node<T>?
    
    init(with data: T, next: Node<T>?) {
        self.data = data
        self.nextNode = next
    }
    
}

final class LinkedList<T>: NSObject {
    
    var count: Int = 0
    
    var first: Node<T>?
    
    var last: Node<T>? {
        
        var currentNode = first
        
        while let next = currentNode?.nextNode {
            currentNode = next
        }
        
        return currentNode
    }
    
    func push(node: Node<T>) {
        if first == nil {
            first = node
            count += 1
            return
        }
        
        last?.nextNode = node
        count += 1
    }
    
    func popFirst() -> Node<T>? {
        
        guard let currentFirst = first
        else { return nil }
        
        let newFirst = currentFirst.nextNode
        first = newFirst
        count -= 1
        
        return currentFirst
    }
    
    func popLast() -> Node<T>? {
        guard let first else { return nil } //  Empty
        
        guard first.nextNode != nil else {
            self.first = nil
            count -= 1
            return first    //  Single item
        }
        
        var prev: Node<T>?
        var current: Node<T>? = first
        
        while current?.nextNode != nil {
            prev = current
            current = current?.nextNode
        }
        
        prev?.nextNode = nil
        count -= 1
        
        return current
    }
    
    func printList() {
        var currentNode = first
        
        while let node = currentNode {
            print(node.data)
            currentNode = node.nextNode
        }
    }
}

//  For paindrome, create some test cases
let cases:[ (word: String, expected: Bool)] = [
    ("DAD", true),
    ("MOM", true),
    ("ANNE", false),
    ("CAT", false),
    ("RACECAR", true),
    ("ANNA", true)
]

func stringToList(_ input: String) -> LinkedList<String> {
    var currentInput = input
    let list = LinkedList<String>()
    
    for character in currentInput {
        list.push(node: Node<String>(with: String(character), next: nil))
    }
    
    return list
}

func isListPalindrome(list: LinkedList<String>) -> Bool {
    
    while (list.count != 0) {
        let first = list.popFirst()?.data
        let last = list.popLast()?.data
        if first != last { return last == nil }
    }
    return true
}

func perfromTest() {
    cases.forEach {
        let isPalindrome = isListPalindrome(list: stringToList($0.word))
        let word = $0.word
        print("\(word): \tisPalindrome: \(isPalindrome), testPassed: \(isPalindrome == $0.expected)")
    }
}

*/
