import Foundation

/**
 Merges two sorted linked lists into a single sorted linked list.

 - Parameters:
   - l1: The first sorted linked list.
   - l2: The second sorted linked list.
 - Returns: A new sorted linked list containing all elements from l1 and l2.
 */
class Merge2Lists: Problem {

    class ListNode<T>: NSObject {
        var val: T
        var next: ListNode?
        init(val: T, next: ListNode? = nil) {
            self.val = val
            self.next = next
        }

        func printList() {
            var current: ListNode? = self
            var output = ""

            while let node = current {
                output += "\(node.val) -> "
                current = node.next
            }

            output += "nil"
            print(output)
        }
    }

    typealias TestCase = (arr1: [Int], arr2: [Int], expected: [Int])

    override func performTests() {
        print("Running tests for: \(Self.self)")

        let tests: [TestCase] = [
            // Basic merge with overlapping values
            ([1, 2, 3], [2, 3, 4], [1, 2, 2, 3, 3, 4]),

            // Both lists are empty
            ([], [], []),

            // One list is empty, the other has values
            ([1, 3, 5], [], [1, 3, 5]),

            // One list is empty, the other has values
            ([], [2, 4, 6], [2, 4, 6]),

            // Perfect interleave of elements
            ([1, 3, 5], [2, 4, 6], [1, 2, 3, 4, 5, 6]),

            // All elements in l1 are smaller than those in l2
            ([1, 2, 3], [4, 5, 6], [1, 2, 3, 4, 5, 6]),

            // All elements in l2 are smaller than those in l1
            ([4, 5, 6], [1, 2, 3], [1, 2, 3, 4, 5, 6]),

            // Lists with duplicate elements
            ([1, 1, 2], [1, 3, 4], [1, 1, 1, 2, 3, 4]),
        ]

        func pad(_ string: String, to length: Int) -> String {
            if string.count >= length { return String(string.prefix(length)) }
            return string + String(repeating: " ", count: length - string.count)
        }

        let columnWidths = (input: 24, expected: 20, actual: 20, pass: 6)

        let header = "| " + pad("Input (arr1, arr2)", to: columnWidths.input)
            + " | " + pad("Expected", to: columnWidths.expected)
            + " | " + pad("Actual", to: columnWidths.actual)
            + " | " + pad("Pass", to: columnWidths.pass) + " |"

        let separator = "|" + String(repeating: "-", count: columnWidths.input + 2)
            + "|" + String(repeating: "-", count: columnWidths.expected + 2)
            + "|" + String(repeating: "-", count: columnWidths.actual + 2)
            + "|" + String(repeating: "-", count: columnWidths.pass + 2) + "|"

        print(header)
        print(separator)

        for (_, test) in tests.enumerated() {
            let result = mergeSortedLists(arrayToLinkedList(test.arr1), arrayToLinkedList(test.arr2))
            let actual = linkedListToArray(result)
            let pass = actual == test.expected ? "✅" : "❌"
            let inputStr = "(\(test.arr1.prefix(3))..., \(test.arr2.prefix(3))...)"
            print("| " + pad(inputStr, to: columnWidths.input)
                + " | " + pad(String(describing: test.expected), to: columnWidths.expected)
                + " | " + pad(String(describing: actual), to: columnWidths.actual)
                + " | " + pad(pass, to: columnWidths.pass) + " |")
        }
    }

    func mergeSortedLists<T: Comparable>(_ l1: ListNode<T>?, _ l2: ListNode<T>?) -> ListNode<T>? {
        let dummy = ListNode<T>(val: (l1?.val ?? l2!.val))
        var tail = dummy
        var a = l1
        var b = l2

        while let nodeA = a, let nodeB = b {
            if nodeA.val < nodeB.val {
                tail.next = nodeA
                a = nodeA.next
            } else {
                tail.next = nodeB
                b = nodeB.next
            }
            tail = tail.next!
        }

        tail.next = a ?? b
        return dummy.next
    }

    func arrayToLinkedList<T>(_ array: [T]) -> ListNode<T>? {
        guard let first = array.first else { return nil }
        let head = ListNode(val: first)
        var current = head

        for value in array.dropFirst() {
            current.next = ListNode(val: value)
            current = current.next!
        }

        return head
    }

    func linkedListToArray<T>(_ head: ListNode<T>?) -> [T] {
        var result: [T] = []
        var current = head
        while let node = current {
            result.append(node.val)
            current = node.next
        }
        return result
    }
}
