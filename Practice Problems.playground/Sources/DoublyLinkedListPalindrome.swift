//
//  DoublyLinkedListPalindrome.swift
//  
//
//  Created by Justin Goulet on 3/24/25.
//


/**
 Using a doubly linked list, determine if a word is a palindrome
 */

/**
final class Node<T>: NSObject {
    
    var data: T
    var nextNode: Node<T>?
    var previousNode: Node<T>?
    
    init(with data: T) {
        self.data = data
    }
    
}

final class DoublyLinkedList<T>: NSObject {
    
    var count: Int = 0
    var head: Node<T>?
    var tail: Node<T>?
    
    init(with node: Node<T>? = nil) {
        head = node
        tail = node
        count = node == nil ? 0 : 1
    }
    
    func push(node: Node<T>) {
        
        //   If the head is empty, the list is empty and both need to be set
        if head == nil && tail == nil {
            head = node
            tail = node
        }
        
        //  Take the current tail, and set the next node to the new node
        //  and then set the updated tail
        tail?.nextNode = node
        node.previousNode = tail
        
        tail = node
        
        count += 1
    }
    
    func printList() {
        var currentNode = head
        
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

func stringToList(_ input: String) -> DoublyLinkedList<String> {
    var currentInput = input
    let list = DoublyLinkedList<String>()
    
    for character in currentInput {
        list.push(node: Node<String>(with: String(character)))
    }
    
    return list
}

func isListPalindrome(list: DoublyLinkedList<String>) -> Bool {
    //  Since each node has a previous, we can just compare both
    //  in-place
    var currentHead = list.head
    var currentTail = list.tail
    
    while currentHead != list.tail {
        if currentHead?.data != currentTail?.data { return false }
        currentHead = currentHead?.nextNode
        currentTail = currentTail?.previousNode
    }
    
    return true
}

func performTests() {
    cases.forEach {
        let list = stringToList($0.word)
        let isPalindrome = isListPalindrome(list: list)
        let word = $0.word
        print("\(word): \tisPalindrome: \(isPalindrome), testPassed: \(isPalindrome == $0.expected)")
    }
}*/
